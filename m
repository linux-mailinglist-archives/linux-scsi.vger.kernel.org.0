Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5E929E64
	for <lists+linux-scsi@lfdr.de>; Fri, 24 May 2019 20:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391625AbfEXSsl (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 24 May 2019 14:48:41 -0400
Received: from smtp.infotech.no ([82.134.31.41]:56423 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391503AbfEXSsl (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 24 May 2019 14:48:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 3892420417E;
        Fri, 24 May 2019 20:48:39 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Zyyx34FQS97d; Fri, 24 May 2019 20:48:36 +0200 (CEST)
Received: from xtwo70.bingwo.ca (host-45-58-224-183.dyn.295.ca [45.58.224.183])
        by smtp.infotech.no (Postfix) with ESMTPA id 2F3F2204162;
        Fri, 24 May 2019 20:48:29 +0200 (CEST)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        bart.vanassche@wdc.com
Subject: [PATCH 15/19] sg: add fd sharing , change, unshare
Date:   Fri, 24 May 2019 14:48:05 -0400
Message-Id: <20190524184809.25121-16-dgilbert@interlog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190524184809.25121-1-dgilbert@interlog.com>
References: <20190524184809.25121-1-dgilbert@interlog.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Add the ability establish a share between any two open file
descriptors in the sg driver. Neither file descriptor can
already be part of a share. This fd share is used for two
features added and described in later patches: request
sharing and the "do_on_other" flag used when multiple
requests are issued (with a single invocation from the
user space). See the webpage at:
http://sg.danny.cz/sg/sg_v40.html
in the section titled: "5 Sharing file descriptors".

Usually two file descriptors are enough. To support the
ability to READ once and then WRITE to two or more
file descriptors (hence potentially to write the same
data to different disks) the ability to drop the
share partner file descriptor and replace it with a
new fd is also available.

Finally a share can explicitly be undone, or unshared,
by either side. In practice, close()ing either side of
a fd share has the same effect (i.e. to unshare) so
this route is the more common.

File shares maybe within a single-threaded process,
between threads in the same process, or even between
processes (on the same machine) by passing an open
file descriptor via Unix sockets to the other process.

Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/sg.c      | 491 +++++++++++++++++++++++++++++++++--------
 include/uapi/scsi/sg.h |   3 +
 2 files changed, 404 insertions(+), 90 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 6a26aa483d8e..44f09c65e0b9 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -33,6 +33,7 @@ static char *sg_version_date = "20190520";
 #include <linux/moduleparam.h>
 #include <linux/cdev.h>
 #include <linux/idr.h>
+#include <linux/file.h>		/* for fget() and fput() */
 #include <linux/seq_file.h>
 #include <linux/blkdev.h>
 #include <linux/delay.h>
@@ -43,6 +44,7 @@ static char *sg_version_date = "20190520";
 #include <linux/uio.h>
 #include <linux/cred.h>		/* for sg_check_file_access() */
 #include <linux/bsg.h>
+#include <linux/timekeeping.h>
 #include <linux/proc_fs.h>	/* used if CONFIG_SCSI_PROC_FS */
 #include <linux/rculist.h>
 
@@ -129,6 +131,7 @@ enum sg_rq_state {
 #define SG_FFD_TIME_IN_NS	4	/* set: time in nanoseconds, else ms */
 #define SG_FFD_Q_AT_TAIL	5	/* set: queue reqs at tail of blk q */
 #define SG_FFD_PREFER_TAG	7	/* prefer tag over pack_id (def) */
+#define SG_FFD_RELEASE		8	/* release (close) underway */
 #define SG_FFD_NO_DURATION	9	/* don't do command duration calc */
 #define SG_FFD_MORE_ASYNC	10	/* yield EBUSY more often */
 
@@ -234,13 +237,16 @@ struct sg_fd {		/* holds the state of a file descriptor */
 	int timeout_user;	/* defaults to SG_DEFAULT_TIMEOUT_USER */
 	int tot_fd_thresh;	/* E2BIG if sum_of(dlen) > this, 0: ignore */
 	int sgat_elem_sz;	/* initialized to scatter_elem_sz */
+	int shr_fd;		/* init: SG_SHARE_FD_UNUSED; master: -2 */
 	atomic_t sum_fd_dlens;	/* when tot_fd_thresh>0 this is sum_of(dlen) */
 	atomic_t submitted;	/* number inflight or awaiting read */
 	atomic_t waiting;	/* number of requests awaiting read */
 	unsigned long ffd_bm[1];	/* see SG_FFD_* defines above */
 	pid_t tid;		/* thread id when opened */
 	u8 next_cmd_len;	/* 0: automatic, >0: use on next write() */
+	struct file *filp;	/* my identity when sharing */
 	struct sg_request *rsv_srp;/* one reserve request per fd */
+	struct sg_fd *share_sfp;/* master+slave shares set this, else NULL */
 	struct fasync_struct *async_qp; /* used by asynchronous notification */
 	struct kref f_ref;
 	struct execute_work ew_fd;  /* harvest all fd resources and lists */
@@ -273,7 +279,6 @@ struct sg_comm_wr_t {	/* arguments to sg_common_write() */
 		struct sg_io_v4 *h4p;
 	};
 	struct sg_fd *sfp;
-	struct file *filp;
 	const u8 __user *u_cmdp;
 	const u8 *cmdp;
 };
@@ -286,14 +291,15 @@ static int sg_start_req(struct sg_request *srp, struct sg_comm_wr_t *cwrp,
 			int dxfer_dir);
 static void sg_finish_scsi_blk_rq(struct sg_request *srp);
 static int sg_mk_sgat(struct sg_request *srp, struct sg_fd *sfp, int minlen);
-static int sg_v3_submit(struct file *filp, struct sg_fd *sfp,
-			struct sg_io_hdr *hp, bool sync,
+static int sg_v3_receive(struct sg_fd *sfp, struct sg_request *srp,
+			 void __user *p);
+static int sg_v3_submit(struct sg_fd *sfp, struct sg_io_hdr *hp, bool sync,
 			struct sg_request **o_srp);
 static struct sg_request *sg_common_write(struct sg_comm_wr_t *cwrp);
 static int sg_rd_append(struct sg_request *srp, void __user *outp,
 			int num_xfer);
 static void sg_remove_sgat(struct sg_request *srp);
-static struct sg_fd *sg_add_sfp(struct sg_device *sdp);
+static struct sg_fd *sg_add_sfp(struct sg_device *sdp, struct file *filp);
 static void sg_remove_sfp(struct kref *);
 static struct sg_request *sg_find_srp_by_id(struct sg_fd *sfp, int id,
 					    bool is_tag);
@@ -514,7 +520,7 @@ sg_open(struct inode *inode, struct file *filp)
 		/* Next done in sg_alloc(), repeat here to pick up change? */
 		sg_calc_sgat_param(sdp);
 	}
-	sfp = sg_add_sfp(sdp);
+	sfp = sg_add_sfp(sdp, filp);
 	if (IS_ERR(sfp)) {
 		res = PTR_ERR(sfp);
 		goto out_undo;
@@ -563,6 +569,7 @@ sg_release(struct inode *inode, struct file *filp)
 	       atomic_read(&sdp->open_cnt));
 	if (unlikely(!sdp))
 		return -ENXIO;
+	set_bit(SG_FFD_RELEASE, sfp->ffd_bm);
 
 	mutex_lock(&sdp->open_rel_lock);
 	scsi_autopm_put_device(sdp->device);
@@ -634,7 +641,7 @@ sg_write(struct file *filp, const char __user *p, size_t count, loff_t *ppos)
 		if (__copy_from_user(h3u8p + SZ_SG_HEADER, p + SZ_SG_HEADER,
 				     SZ_SG_IO_HDR - SZ_SG_HEADER))
 			return -EFAULT;
-		res = sg_v3_submit(filp, sfp, h3p, false, NULL);
+		res = sg_v3_submit(sfp, h3p, false, NULL);
 		return res < 0 ? res : (int)count;
 	}
 	/* v1 and v2 interfaces processed below this point */
@@ -698,7 +705,6 @@ sg_write(struct file *filp, const char __user *p, size_t count, loff_t *ppos)
 	cwr.h3p = h3p;
 	cwr.timeout = sfp->timeout;
 	cwr.cmd_len = cmd_size;
-	cwr.filp = filp;
 	cwr.sfp = sfp;
 	cwr.u_cmdp = p;
 	cwr.cmdp = NULL;
@@ -707,19 +713,18 @@ sg_write(struct file *filp, const char __user *p, size_t count, loff_t *ppos)
 }
 
 static int
-sg_fetch_cmnd(struct file *filp, struct sg_fd *sfp, const u8 __user *u_cdbp,
-	      int len, u8 *cdbp)
+sg_fetch_cmnd(struct sg_fd *sfp, const u8 __user *u_cdbp, int len, u8 *cdbp)
 {
 	if (!u_cdbp || len < 6 || len > SG_MAX_CDB_SIZE)
 		return -EMSGSIZE;
 	if (copy_from_user(cdbp, u_cdbp, len))
 		return -EFAULT;
-	if (O_RDWR != (filp->f_flags & O_ACCMODE)) {	/* read-only */
+	if (O_RDWR != (sfp->filp->f_flags & O_ACCMODE)) { /* read-only */
 		switch (sfp->parentdp->device->type) {
 		case TYPE_DISK:
 		case TYPE_RBC:
 		case TYPE_ZBC:
-			return blk_verify_command(cdbp, filp->f_mode);
+			return blk_verify_command(cdbp, sfp->filp->f_mode);
 		default:	/* SSC, SES, etc cbd_s may differ from SBC */
 			break;
 		}
@@ -728,8 +733,8 @@ sg_fetch_cmnd(struct file *filp, struct sg_fd *sfp, const u8 __user *u_cdbp,
 }
 
 static int
-sg_v3_submit(struct file *filp, struct sg_fd *sfp, struct sg_io_hdr *hp,
-	     bool sync, struct sg_request **o_srp)
+sg_v3_submit(struct sg_fd *sfp, struct sg_io_hdr *hp, bool sync,
+	     struct sg_request **o_srp)
 {
 	unsigned long ul_timeout;
 	struct sg_request *srp;
@@ -752,7 +757,6 @@ sg_v3_submit(struct file *filp, struct sg_fd *sfp, struct sg_io_hdr *hp,
 	cwr.h3p = hp;
 	cwr.timeout = min_t(unsigned long, ul_timeout, INT_MAX);
 	cwr.cmd_len = hp->cmd_len;
-	cwr.filp = filp;
 	cwr.sfp = sfp;
 	cwr.u_cmdp = hp->cmdp;
 	cwr.cmdp = NULL;
@@ -765,8 +769,8 @@ sg_v3_submit(struct file *filp, struct sg_fd *sfp, struct sg_io_hdr *hp,
 }
 
 static int
-sg_v4_submit(struct file *filp, struct sg_fd *sfp, void __user *p,
-	     struct sg_io_v4 *h4p, bool sync, struct sg_request **o_srp)
+sg_v4_submit(struct sg_fd *sfp, void __user *p, struct sg_io_v4 *h4p,
+	     bool sync, struct sg_request **o_srp)
 {
 	int res = 0;
 	unsigned long ul_timeout;
@@ -774,7 +778,6 @@ sg_v4_submit(struct file *filp, struct sg_fd *sfp, void __user *p,
 	struct sg_comm_wr_t cwr;
 
 	memset(&cwr, 0, sizeof(cwr));
-	cwr.filp = filp;
 	cwr.sfp = sfp;
 	cwr.h4p = h4p;
 	if (h4p->flags & SG_FLAG_MMAP_IO) {
@@ -816,38 +819,38 @@ sg_v4_submit(struct file *filp, struct sg_fd *sfp, void __user *p,
 }
 
 static int
-sg_ctl_iosubmit(struct file *filp, struct sg_fd *sfp, void __user *p)
+sg_ctl_iosubmit(struct sg_fd *sfp, void __user *p)
 {
 	int res;
 	u8 hdr_store[SZ_SG_IO_V4];
 	struct sg_io_v4 *h4p = (struct sg_io_v4 *)hdr_store;
 	struct sg_device *sdp = sfp->parentdp;
 
-	res = sg_allow_if_err_recovery(sdp, (filp->f_flags & O_NONBLOCK));
+	res = sg_allow_if_err_recovery(sdp, (sfp->filp->f_flags & O_NONBLOCK));
 	if (unlikely(res))
 		return res;
 	if (copy_from_user(hdr_store, p, SZ_SG_IO_V4))
 		return -EFAULT;
 	if (h4p->guard == 'Q')
-		return sg_v4_submit(filp, sfp, p, h4p, false, NULL);
+		return sg_v4_submit(sfp, p, h4p, false, NULL);
 	return -EPERM;
 }
 
 static int
-sg_ctl_iosubmit_v3(struct file *filp, struct sg_fd *sfp, void __user *p)
+sg_ctl_iosubmit_v3(struct sg_fd *sfp, void __user *p)
 {
 	int res;
 	u8 hdr_store[SZ_SG_IO_V4];	/* max(v3interface, v4interface) */
 	struct sg_io_hdr *h3p = (struct sg_io_hdr *)hdr_store;
 	struct sg_device *sdp = sfp->parentdp;
 
-	res = sg_allow_if_err_recovery(sdp, (filp->f_flags & O_NONBLOCK));
+	res = sg_allow_if_err_recovery(sdp, (sfp->filp->f_flags & O_NONBLOCK));
 	if (unlikely(res))
 		return res;
 	if (copy_from_user(h3p, p, SZ_SG_IO_HDR))
 		return -EFAULT;
 	if (h3p->interface_id == 'S')
-		return sg_v3_submit(filp, sfp, h3p, false, NULL);
+		return sg_v3_submit(sfp, h3p, false, NULL);
 	return -EPERM;
 }
 
@@ -1107,43 +1110,6 @@ sg_rec_v3v4_state(struct sg_fd *sfp, struct sg_request *srp, bool v4_active)
 	return err;
 }
 
-/*
- * Completes a v3 request/command. Called from sg_read {v2 or v3},
- * ioctl(SG_IO) {for v3}, or from ioctl(SG_IORECEIVE) when its
- * completing a v3 request/command.
- */
-static int
-sg_v3_receive(struct sg_fd *sfp, struct sg_request *srp, void __user *p)
-{
-	int err, err2;
-	int rq_result = srp->rq_result;
-	struct sg_io_hdr hdr3;
-	struct sg_io_hdr *hp = &hdr3;
-
-	SG_LOG(3, sfp->parentdp, "%s: srp=0x%p\n", __func__, srp);
-	err = sg_rec_v3v4_state(sfp, srp, false);
-	memset(hp, 0, sizeof(*hp));
-	memcpy(hp, &srp->s_hdr3, sizeof(srp->s_hdr3));
-	hp->sb_len_wr = srp->sense_len;
-	hp->info = srp->rq_info;
-	hp->resid = srp->in_resid;
-	hp->duration = srp->duration;
-	hp->status = rq_result & 0xff;
-	hp->masked_status = status_byte(rq_result);
-	hp->msg_status = msg_byte(rq_result);
-	hp->host_status = host_byte(rq_result);
-	hp->driver_status = driver_byte(rq_result);
-	/* copy_*_user() [without leading underscores] checks access */
-	if (copy_to_user(p, hp, SZ_SG_IO_HDR))
-		err = err ? err : -EFAULT;
-	err2 = sg_rstate_chg(srp, atomic_read(&srp->rq_st), SG_RS_DONE_RD);
-	if (err2)
-		err = err ? err : err2;
-	sg_finish_scsi_blk_rq(srp);
-	sg_deact_request(sfp, srp);
-	return err ? err : 0;
-}
-
 static int
 sg_v4_receive(struct sg_fd *sfp, struct sg_request *srp, void __user *p,
 	      struct sg_io_v4 *h4p)
@@ -1199,9 +1165,9 @@ sg_v4_receive(struct sg_fd *sfp, struct sg_request *srp, void __user *p,
  * otherwise it waits (i.e. it "blocks").
  */
 static int
-sg_ctl_ioreceive(struct file *filp, struct sg_fd *sfp, void __user *p)
+sg_ctl_ioreceive(struct sg_fd *sfp, void __user *p)
 {
-	bool non_block = !!(filp->f_flags & O_NONBLOCK);
+	bool non_block = !!(sfp->filp->f_flags & O_NONBLOCK);
 	bool use_tag = false;
 	int res, id;
 	int pack_id = SG_PACK_ID_WILDCARD;
@@ -1252,9 +1218,9 @@ sg_ctl_ioreceive(struct file *filp, struct sg_fd *sfp, void __user *p)
  * otherwise it waits.
  */
 static int
-sg_ctl_ioreceive_v3(struct file *filp, struct sg_fd *sfp, void __user *p)
+sg_ctl_ioreceive_v3(struct sg_fd *sfp, void __user *p)
 {
-	bool non_block = !!(filp->f_flags & O_NONBLOCK);
+	bool non_block = !!(sfp->filp->f_flags & O_NONBLOCK);
 	int res;
 	int pack_id = SG_PACK_ID_WILDCARD;
 	u8 v3_holder[SZ_SG_IO_HDR];
@@ -1469,6 +1435,43 @@ sg_read(struct file *filp, char __user *p, size_t count, loff_t *ppos)
 	return ret < 0 ? ret : (int)count;
 }
 
+/*
+ * Completes a v3 request/command. Called from sg_read {v2 or v3},
+ * ioctl(SG_IO) {for v3}, or from ioctl(SG_IORECEIVE) when its
+ * completing a v3 request/command.
+ */
+static int
+sg_v3_receive(struct sg_fd *sfp, struct sg_request *srp, void __user *p)
+{
+	int err, err2;
+	int rq_result = srp->rq_result;
+	struct sg_io_hdr hdr3;
+	struct sg_io_hdr *hp = &hdr3;
+
+	SG_LOG(3, sfp->parentdp, "%s: srp=0x%p\n", __func__, srp);
+	err = sg_rec_v3v4_state(sfp, srp, false);
+	memset(hp, 0, sizeof(*hp));
+	memcpy(hp, &srp->s_hdr3, sizeof(srp->s_hdr3));
+	hp->sb_len_wr = srp->sense_len;
+	hp->info = srp->rq_info;
+	hp->resid = srp->in_resid;
+	hp->duration = srp->duration;
+	hp->status = rq_result & 0xff;
+	hp->masked_status = status_byte(rq_result);
+	hp->msg_status = msg_byte(rq_result);
+	hp->host_status = host_byte(rq_result);
+	hp->driver_status = driver_byte(rq_result);
+	/* copy_*_user() [without leading underscores] checks access */
+	if (copy_to_user(p, hp, SZ_SG_IO_HDR))
+		err = err ? err : -EFAULT;
+	err2 = sg_rstate_chg(srp, atomic_read(&srp->rq_st), SG_RS_DONE_RD);
+	if (err2)
+		err = err ? err : err2;
+	sg_finish_scsi_blk_rq(srp);
+	sg_deact_request(sfp, srp);
+	return err ? err : 0;
+}
+
 static int
 max_sectors_bytes(struct request_queue *q)
 {
@@ -1511,6 +1514,78 @@ sg_calc_sgat_param(struct sg_device *sdp)
 	sdp->max_sgat_sz = sz;
 }
 
+static void
+sg_unshare_fds(struct sg_fd *ma_sfp, struct sg_fd *sl_sfp)
+{
+	if (ma_sfp) {
+		ma_sfp->share_sfp = NULL;
+		ma_sfp->shr_fd = SG_SHARE_FD_UNUSED;
+	}
+	if (sl_sfp) {
+		sl_sfp->share_sfp = NULL;
+		sl_sfp->shr_fd = SG_SHARE_FD_UNUSED;
+	}
+}
+
+/*
+ * Active when writing 1 to ioctl(SG_SET_GET_EXTENDED(CTL_FLAGS(UNSHARE))),
+ * writing 0 has no effect. Undoes the configuration that has done by
+ * ioctl(SG_SET_GET_EXTENDED(SHARE_FD)).
+ */
+static void
+sg_chk_unshare(struct sg_fd *sfp, bool unshare_val)
+{
+	bool retry;
+	int retry_count = 0;
+	unsigned long iflags;
+	struct sg_fd *ma_sfp;
+	struct sg_fd *sl_sfp;
+	struct sg_fd *o_sfp = sfp->share_sfp;/* other side of existing share */
+
+	if (sfp->shr_fd == SG_SHARE_FD_UNUSED || !o_sfp)
+		return;	/* no share to undo */
+	if (!unshare_val)
+		return;
+again:
+	retry = false;
+	spin_lock_irqsave(&sfp->rq_list_lock, iflags);
+	if (sfp->shr_fd == SG_SHARE_FD_MASTER) {  /* called on master fd */
+		ma_sfp = sfp;
+		sl_sfp = o_sfp;
+		if (!spin_trylock(&sl_sfp->rq_list_lock)) {
+			if (++retry_count > SG_ADD_RQ_MAX_RETRIES)
+				SG_LOG(1, sfp->parentdp,
+				       "%s: cannot get slave lock\n",
+				       __func__);
+			else
+				retry = true;
+			goto fini;
+		}
+		sg_unshare_fds(ma_sfp, sl_sfp);
+		spin_unlock(&sl_sfp->rq_list_lock);
+	} else {			/* called on slave fd */
+		ma_sfp = o_sfp;
+		sl_sfp = sfp;
+		if (!spin_trylock(&ma_sfp->rq_list_lock)) {
+			if (++retry_count > SG_ADD_RQ_MAX_RETRIES)
+				SG_LOG(1, sfp->parentdp,
+				       "%s: cannot get master lock\n",
+				       __func__);
+			else
+				retry = true;
+			goto fini;
+		}
+		sg_unshare_fds(ma_sfp, sl_sfp);
+		spin_unlock(&ma_sfp->rq_list_lock);
+	}
+fini:
+	spin_unlock_irqrestore(&sfp->rq_list_lock, iflags);
+	if (retry) {
+		cpu_relax();
+		goto again;
+	}
+}
+
 /*
  * Returns duration since srp->start_ns (using boot time as an epoch). Unit
  * is nanoseconds when time_in_ns==true; else it is in milliseconds.
@@ -1602,8 +1677,8 @@ sg_rq_landed(struct sg_device *sdp, struct sg_request *srp)
  * the blocking multiple request case
  */
 static int
-sg_wait_event_srp(struct file *filp, struct sg_fd *sfp, void __user *p,
-		  struct sg_io_v4 *h4p, struct sg_request *srp)
+sg_wait_event_srp(struct sg_fd *sfp, void __user *p, struct sg_io_v4 *h4p,
+		  struct sg_request *srp)
 {
 	int res;
 	enum sg_rq_state sr_st;
@@ -1643,7 +1718,7 @@ sg_wait_event_srp(struct file *filp, struct sg_fd *sfp, void __user *p,
  * Returns 0 on success else a negated errno.
  */
 static int
-sg_ctl_sg_io(struct file *filp, struct sg_device *sdp, struct sg_fd *sfp,
+sg_ctl_sg_io(struct sg_device *sdp, struct sg_fd *sfp,
 	     void __user *p)
 {
 	int res;
@@ -1653,7 +1728,8 @@ sg_ctl_sg_io(struct file *filp, struct sg_device *sdp, struct sg_fd *sfp,
 	struct sg_io_v4 *h4p = (struct sg_io_v4 *)hu8arr;
 
 	SG_LOG(3, sdp, "%s:  SG_IO%s\n", __func__,
-	       ((filp->f_flags & O_NONBLOCK) ? " O_NONBLOCK ignored" : ""));
+	       ((sfp->filp->f_flags & O_NONBLOCK) ?
+				 " O_NONBLOCK ignored" : ""));
 	res = sg_allow_if_err_recovery(sdp, false);
 	if (unlikely(res))
 		return res;
@@ -1667,9 +1743,9 @@ sg_ctl_sg_io(struct file *filp, struct sg_device *sdp, struct sg_fd *sfp,
 				   ((u8 __user *)p) + SZ_SG_IO_HDR,
 				   SZ_SG_IO_V4 - SZ_SG_IO_HDR))
 			return -EFAULT;
-		res = sg_v4_submit(filp, sfp, p, h4p, true, &srp);
+		res = sg_v4_submit(sfp, p, h4p, true, &srp);
 	} else if (h3p->interface_id == 'S') {
-		res = sg_v3_submit(filp, sfp, h3p, true, &srp);
+		res = sg_v3_submit(sfp, h3p, true, &srp);
 	} else {
 		pr_info_once("sg: %s: v3 or v4 interface only here\n",
 			     __func__);
@@ -1679,7 +1755,7 @@ sg_ctl_sg_io(struct file *filp, struct sg_device *sdp, struct sg_fd *sfp,
 		return res;
 	if (!srp)	/* mrq case: already processed all responses */
 		return res;
-	res = sg_wait_event_srp(filp, sfp, p, h4p, srp);
+	res = sg_wait_event_srp(sfp, p, h4p, srp);
 	if (unlikely(res)) {
 		SG_LOG(1, sdp, "%s: %s=0x%p  state: %s\n", __func__,
 		       "unexpected srp", srp,
@@ -1792,6 +1868,215 @@ sg_ctl_abort(struct sg_device *sdp, struct sg_fd *sfp, void __user *p)
 	return res;
 }
 
+static int
+sg_idr_max_id(int id, void *p, void *data)
+{
+	int *k = data;
+
+	if (*k < id)
+		*k = id;
+
+	return 0;
+}
+
+/*
+ * Scans sg driver object tree looking for search_for. Returns valid pointer
+ * if found; returns negated errno twisted by ERR_PTR(); or return NULL if
+ * not found (and no error).
+ */
+static struct sg_fd *
+sg_find_sfp_by_fd(const struct file *search_for, int search_fd,
+		  struct sg_fd *from_sfp, bool from_is_master)
+{
+	bool found = false;
+	int k, num_d;
+	int res = 0;
+	unsigned long iflags;
+	struct sg_fd *sfp;
+	struct sg_device *sdp;
+
+	num_d = -1;
+	read_lock_irqsave(&sg_index_lock, iflags);
+	idr_for_each(&sg_index_idr, sg_idr_max_id, &num_d);
+	++num_d;
+	for (k = 0; k < num_d; ++k) {
+		sdp = idr_find(&sg_index_idr, k);
+		if (!sdp || unlikely(atomic_read(&sdp->detaching)))
+			continue;
+		read_lock(&sdp->sfd_llock);
+		list_for_each_entry(sfp, &sdp->sfds, sfd_entry) {
+			if (test_bit(SG_FFD_RELEASE, sfp->ffd_bm))
+				continue;
+			spin_lock(&sfp->rq_list_lock);
+			if (search_for != sfp->filp) {
+				spin_unlock(&sfp->rq_list_lock);
+				continue;       /* not this one */
+			}
+			if (sfp->shr_fd != SG_SHARE_FD_UNUSED) {
+				res = -EADDRNOTAVAIL;/* already sharing */
+			} else if (SG_RS_ACTIVE(sfp->rsv_srp)) {
+				res = -EBUSY;/* master reserve rq busy */
+			} else if (sdp->exclude) {/* O_EXCL used on this dev */
+				res = -EPERM;
+			} else {
+				res = 0;
+				found = true;
+				if (spin_trylock(&from_sfp->rq_list_lock)) {
+					from_sfp->share_sfp = sfp;
+					from_sfp->shr_fd = from_is_master ?
+						SG_SHARE_FD_MASTER : search_fd;
+					spin_unlock(&from_sfp->rq_list_lock);
+					sfp->share_sfp = from_sfp;
+					sfp->shr_fd = from_is_master ?
+						search_fd : SG_SHARE_FD_MASTER;
+				} else { /* ?? borrow EPROBE_DEFER + encore */
+					res = -EPROBE_DEFER;
+				}
+			}
+			spin_unlock(&sfp->rq_list_lock);
+			if (res || found)
+				break;
+		}       /* end of loop of all fd_s in current device */
+		read_unlock(&sdp->sfd_llock);
+		if (res || found)
+			break;
+	}       /* end of loop of all sg devices */
+	read_unlock_irqrestore(&sg_index_lock, iflags);
+	if (unlikely(res < 0))
+		return ERR_PTR(res);
+	return found ? sfp : NULL;
+}
+
+/*
+ * After checking the proposed master-slave relationship is unique and valid,
+ * sets up pointers between master and slave sg_fd objects. Returns 0 on
+ * success or negated errno value. From ioctl(EXTENDED(SG_SEIM_SHARE_FD)).
+ */
+static int
+sg_fd_share(struct sg_fd *sl_sfp, int m_fd)
+{
+	bool found = false;
+	int res = 0;
+	int retry_count = 0;
+	struct file *fp;
+	struct sg_fd *ma_sfp;
+
+	SG_LOG(3, sl_sfp->parentdp, "%s:  SHARE: master_fd: %d\n", __func__,
+	       m_fd);
+	if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
+		return -EACCES;
+	if (m_fd < 0)
+		return -EBADF;
+	if (sl_sfp->shr_fd != SG_SHARE_FD_UNUSED)
+		return -EADDRINUSE;  /* don't allow chain of shares */
+	/* Alternate approach: fcheck_files(current->files, m_fd) */
+	fp = fget(m_fd);
+	if (!fp)
+		return -ENOENT;
+	if (sl_sfp->filp == fp) {/* share with self confusing */
+		res = -ELOOP;
+		goto fini;
+	}
+	SG_LOG(6, sl_sfp->parentdp, "%s: master fd okay, scan for filp=0x%p\n",
+	       __func__, fp);
+again:
+	ma_sfp = sg_find_sfp_by_fd(fp, m_fd, sl_sfp, false);
+	if (IS_ERR(ma_sfp)) {
+		res = PTR_ERR(ma_sfp);
+		if (res == -EPROBE_DEFER) {
+			if (++retry_count > SG_ADD_RQ_MAX_RETRIES) {
+				res = -EBUSY;
+			} else {
+				res = 0;
+				cpu_relax();
+				goto again;
+			}
+		}
+	} else {
+		found = !!ma_sfp;
+	}
+fini:
+	/* paired with fp=fget(m_fd) above */
+	fput(fp);
+	if (unlikely(res))
+		return res;
+	return found ? 0 : -ENOTSOCK; /* ENOTSOCK for fd exists but not sg */
+}
+
+/*
+ * After checking the proposed master-slave relationship is unique and
+ * valid, sets up pointers between master and slave sg_fd objects. Return
+ * 0 on success or negated errno value.
+ */
+static int
+sg_fd_reshare(struct sg_fd *ma_sfp, int new_sl_fd)
+{
+	bool found = false;
+	int res = 0;
+	int retry_count = 0;
+	unsigned long iflags;
+	struct file *fp;
+	struct sg_fd *sl_sfp = ma_sfp->share_sfp;
+	enum sg_rq_state rq_st;
+
+	SG_LOG(3, sl_sfp->parentdp, "%s:  new_slave_fd: %d\n", __func__,
+	       new_sl_fd);
+	if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
+		return -EACCES;
+	if (new_sl_fd < 0)
+		return -EBADF;
+	if (ma_sfp->shr_fd != SG_SHARE_FD_MASTER || !sl_sfp)
+		return -EINVAL;
+	if (!ma_sfp->rsv_srp)
+		res = -EPROTO;	/* Internal error */
+	rcu_read_lock();
+	rq_st = atomic_read(&ma_sfp->rsv_srp->rq_st);
+	if (rq_st != SG_RS_INACTIVE)
+		res = -EBUSY;
+	rcu_read_unlock();
+	if (unlikely(res))
+		return res;
+
+	/* Alternate approach: fcheck_files(current->files, m_fd) */
+	fp = fget(new_sl_fd);
+	if (!fp)
+		return -ENOENT;
+	if (ma_sfp->filp == fp) {/* share with self confusing */
+		res = -ELOOP;
+		goto fini;
+	}
+	SG_LOG(6, sl_sfp->parentdp, "%s: slave fd ok, scan for filp=0x%p\n",
+	       __func__, fp);
+	/* cleanup up old slave side */
+	spin_lock_irqsave(&sl_sfp->rq_list_lock, iflags);
+	sl_sfp->share_sfp = NULL;
+	sl_sfp->shr_fd = SG_SHARE_FD_UNUSED;
+	spin_unlock_irqrestore(&sl_sfp->rq_list_lock, iflags);
+
+again:
+	sl_sfp = sg_find_sfp_by_fd(fp, new_sl_fd, ma_sfp, true);
+	if (IS_ERR(sl_sfp)) {
+		res = PTR_ERR(sl_sfp);
+		if (res == -EPROBE_DEFER) {
+			if (++retry_count > SG_ADD_RQ_MAX_RETRIES) {
+				res = -EBUSY;
+			} else {
+				res = 0;
+				cpu_relax();
+				goto again;
+			}
+		}
+	} else {
+		found = !!sl_sfp;
+	}
+fini:
+	/* paired with fp=fget(new_sl_fd) above */
+	fput(fp);
+	if (unlikely(res))
+		return res;
+	return found ? 0 : -ENOTSOCK; /* ENOTSOCK for fd exists but not sg */
+}
+
 /*
  * First normalize want_rsv_sz to be >= sfp->sgat_elem_sz and
  * <= max_segment_size. Exit if that is the same as old size; otherwise
@@ -1918,6 +2203,16 @@ sg_extended_bool_flags(struct sg_fd *sfp, struct sg_extended_info *seip)
 		else
 			*c_flgsp &= ~SG_CTL_FLAGM_Q_TAIL;
 	}
+	/*
+	 * UNSHARE boolean: when reading yields zero. When writing true,
+	 * unshares this fd from a previously established fd share. If
+	 * a shared commands is inflight, waits a little while for it
+	 * to finish.
+	 */
+	if (c_flgs_wm & SG_CTL_FLAGM_UNSHARE)
+		sg_chk_unshare(sfp, !!(*c_flgsp & SG_CTL_FLAGM_UNSHARE));
+	if (c_flgs_rm & SG_CTL_FLAGM_UNSHARE)
+		*c_flgsp &= ~SG_CTL_FLAGM_UNSHARE;      /* clear bit */
 	/* NO_DURATION boolean, [rbw] */
 	if (c_flgs_rm & SG_CTL_FLAGM_NO_DURATION)
 		flg = test_bit(SG_FFD_NO_DURATION, sfp->ffd_bm);
@@ -2051,6 +2346,32 @@ sg_ctl_extended(struct sg_fd *sfp, void __user *p)
 	}
 	if ((s_rd_mask & SG_SEIM_READ_VAL) && (s_wr_mask & SG_SEIM_READ_VAL))
 		sg_extended_read_value(sfp, seip);
+	/* slave side gives fd of master to share with [rbw] */
+	if (or_masks & SG_SEIM_SHARE_FD) {
+		mutex_lock(&sfp->f_mutex);
+		n = sfp->shr_fd;        /* hold prior shr_fd for later read */
+		if (s_wr_mask & SG_SEIM_SHARE_FD) {
+			result = sg_fd_share(sfp, (int)seip->share_fd);
+			if (ret == 0 && result)
+				ret = result;
+		}
+		if (s_rd_mask & SG_SEIM_SHARE_FD)
+			seip->share_fd = (unsigned int)n;
+		mutex_unlock(&sfp->f_mutex);
+	}
+	/* master side is given shr_fd of new slave [rbw] */
+	if (or_masks & SG_SEIM_CHG_SHARE_FD) {
+		mutex_lock(&sfp->f_mutex);
+		n = sfp->shr_fd;        /* hold prior sl_fd for later read */
+		if (s_wr_mask & SG_SEIM_CHG_SHARE_FD) {
+			result = sg_fd_reshare(sfp, (int)seip->share_fd);
+			if (ret == 0 && result)
+				ret = result;
+		}
+		if (s_rd_mask & SG_SEIM_CHG_SHARE_FD)
+			seip->share_fd = (unsigned int)n;
+		mutex_unlock(&sfp->f_mutex);
+	}
 	/* override scatter gather element size [rbw] (def: SG_SCATTER_SZ) */
 	if (or_masks & SG_SEIM_SGAT_ELEM_SZ) {
 		n = sfp->sgat_elem_sz;
@@ -2193,19 +2514,19 @@ sg_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
 
 	switch (cmd_in) {
 	case SG_IO:
-		return sg_ctl_sg_io(filp, sdp, sfp, p);
+		return sg_ctl_sg_io(sdp, sfp, p);
 	case SG_IOSUBMIT:
 		SG_LOG(3, sdp, "%s:    SG_IOSUBMIT\n", __func__);
-		return sg_ctl_iosubmit(filp, sfp, p);
+		return sg_ctl_iosubmit(sfp, p);
 	case SG_IOSUBMIT_V3:
 		SG_LOG(3, sdp, "%s:    SG_IOSUBMIT_V3\n", __func__);
-		return sg_ctl_iosubmit_v3(filp, sfp, p);
+		return sg_ctl_iosubmit_v3(sfp, p);
 	case SG_IORECEIVE:
 		SG_LOG(3, sdp, "%s:    SG_IORECEIVE\n", __func__);
-		return sg_ctl_ioreceive(filp, sfp, p);
+		return sg_ctl_ioreceive(sfp, p);
 	case SG_IORECEIVE_V3:
 		SG_LOG(3, sdp, "%s:    SG_IORECEIVE_V3\n", __func__);
-		return sg_ctl_ioreceive_v3(filp, sfp, p);
+		return sg_ctl_ioreceive_v3(sfp, p);
 	case SG_IOABORT:
 		SG_LOG(3, sdp, "%s:    SG_IOABORT\n", __func__);
 		if (read_only)
@@ -3205,8 +3526,8 @@ sg_start_req(struct sg_request *srp, struct sg_comm_wr_t *cwrp, int dxfer_dir)
 	if (cwrp->cmd_len > BLK_MAX_CDB)
 		scsi_rp->cmd = long_cmdp;
 	if (cwrp->u_cmdp)
-		res = sg_fetch_cmnd(cwrp->filp, sfp, cwrp->u_cmdp,
-				    cwrp->cmd_len, scsi_rp->cmd);
+		res = sg_fetch_cmnd(sfp, cwrp->u_cmdp, cwrp->cmd_len,
+				    scsi_rp->cmd);
 	else if (cwrp->cmdp)
 		memcpy(scsi_rp->cmd, cwrp->cmdp, cwrp->cmd_len);
 	else
@@ -3850,7 +4171,7 @@ sg_deact_request(struct sg_fd *sfp, struct sg_request *srp)
 
 /* Returns pointer to sg_fd object or negated errno twisted by ERR_PTR */
 static struct sg_fd *
-sg_add_sfp(struct sg_device *sdp)
+sg_add_sfp(struct sg_device *sdp, struct file *filp)
 {
 	bool reduced = false;
 	int rbuf_len;
@@ -3872,6 +4193,7 @@ sg_add_sfp(struct sg_device *sdp)
 	mutex_init(&sfp->f_mutex);
 	sfp->timeout = SG_DEFAULT_TIMEOUT;
 	sfp->timeout_user = SG_DEFAULT_TIMEOUT_USER;
+	sfp->filp = filp;
 	/* other bits in sfp->ffd_bm[1] cleared by kzalloc() above */
 	assign_bit(SG_FFD_FORCE_PACKID, sfp->ffd_bm, SG_DEF_FORCE_PACK_ID);
 	assign_bit(SG_FFD_CMD_Q, sfp->ffd_bm, SG_DEF_COMMAND_Q);
@@ -4005,17 +4327,6 @@ sg_remove_sfp(struct kref *kref)
 	schedule_work(&sfp->ew_fd.work);
 }
 
-static int
-sg_idr_max_id(int id, void *p, void *data)
-{
-	int *k = data;
-
-	if (*k < id)
-		*k = id;
-
-	return 0;
-}
-
 /* must be called with sg_index_lock held */
 static struct sg_device *
 sg_lookup_dev(int dev)
diff --git a/include/uapi/scsi/sg.h b/include/uapi/scsi/sg.h
index 5223ba33fb8d..a3fa26644496 100644
--- a/include/uapi/scsi/sg.h
+++ b/include/uapi/scsi/sg.h
@@ -170,6 +170,8 @@ typedef struct sg_req_info {	/* used by SG_GET_REQUEST_TABLE ioctl() */
 #define SG_SEIM_RESERVED_SIZE	0x4	/* reserved_sz of reserve request */
 #define SG_SEIM_TOT_FD_THRESH	0x8	/* tot_fd_thresh of data buffers */
 #define SG_SEIM_MINOR_INDEX	0x10	/* sg device minor index number */
+#define SG_SEIM_SHARE_FD	0x20	/* slave gives fd of master: sharing */
+#define SG_SEIM_CHG_SHARE_FD	0x40	/* master gives fd of new slave */
 #define SG_SEIM_SGAT_ELEM_SZ	0x80	/* sgat element size (>= PAGE_SIZE) */
 #define SG_SEIM_ALL_BITS	0xff	/* should be OR of previous items */
 
@@ -179,6 +181,7 @@ typedef struct sg_req_info {	/* used by SG_GET_REQUEST_TABLE ioctl() */
 #define SG_CTL_FLAGM_OTHER_OPENS 0x4	/* rd: other sg fd_s on this dev */
 #define SG_CTL_FLAGM_ORPHANS	0x8	/* rd: orphaned requests on this fd */
 #define SG_CTL_FLAGM_Q_TAIL	0x10	/* used for future cmds on this fd */
+#define SG_CTL_FLAGM_UNSHARE	0x80	/* undo share after inflight cmd */
 #define SG_CTL_FLAGM_NO_DURATION 0x400	/* don't calc command duration */
 #define SG_CTL_FLAGM_MORE_ASYNC	0x800	/* yield EAGAIN in more cases */
 #define SG_CTL_FLAGM_ALL_BITS	0xfff	/* should be OR of previous items */
-- 
2.17.1

