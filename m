Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99391478C1
	for <lists+linux-scsi@lfdr.de>; Mon, 17 Jun 2019 05:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbfFQDkB (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 16 Jun 2019 23:40:01 -0400
Received: from smtp.infotech.no ([82.134.31.41]:37801 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727671AbfFQDkB (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 16 Jun 2019 23:40:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id D28F6204187
        for <linux-scsi@vger.kernel.org>; Mon, 17 Jun 2019 05:39:58 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ttfp9A7U4Y+a for <linux-scsi@vger.kernel.org>;
        Mon, 17 Jun 2019 05:39:56 +0200 (CEST)
Received: from xtwo70.bingwo.ca (host-45-58-224-183.dyn.295.ca [45.58.224.183])
        by smtp.infotech.no (Postfix) with ESMTPA id C59A6204271
        for <linux-scsi@vger.kernel.org>; Mon, 17 Jun 2019 05:39:46 +0200 (CEST)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Subject: [PATCH 13/18] sg: add sg v4 interface support
Date:   Sun, 16 Jun 2019 23:39:29 -0400
Message-Id: <20190617033934.5051-14-dgilbert@interlog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190617033934.5051-1-dgilbert@interlog.com>
References: <20190617033934.5051-1-dgilbert@interlog.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Add support for the sg v4 interface based on struct sg_io_v4 found
in include/uapi/linux/bsg.h and only previously supported by the
bsg driver. Add ioctl(SG_IOSUBMIT) and ioctl(SG_IORECEIVE) for
async (non-blocking) usage of the sg v4 interface. Do not accept
the v3 interface with these ioctls. Do not accept the v4
interface with this driver's existing write() and read()
system calls.

For sync (blocking) usage expand the existing ioctl(SG_IO)
to additionally accept the sg v4 interface object.

---

A later patch in this set adds multiple requests in a single
invocation. Multiple requests use sg v4 interface objects
exclusively.

Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/sg.c      | 489 ++++++++++++++++++++++++++++++++---------
 include/uapi/scsi/sg.h |  37 +++-
 2 files changed, 420 insertions(+), 106 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index d194417b2809..4a33d67e85e6 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -7,8 +7,9 @@
  *
  * Original driver (sg.c):
  *        Copyright (C) 1992 Lawrence Foard
- * Version 2 and 3 extensions to driver:
+ * Version 2, 3 and 4 extensions to driver:
  *        Copyright (C) 1998 - 2019 Douglas Gilbert
+ *
  */
 
 static int sg_version_num = 30901;  /* [x]xyyzz where [x] empty when x=0 */
@@ -40,10 +41,12 @@ static char *sg_version_date = "20190606";
 #include <linux/atomic.h>
 #include <linux/ratelimit.h>
 #include <linux/uio.h>
-#include <linux/cred.h> /* for sg_check_file_access() */
+#include <linux/cred.h>			/* for sg_check_file_access() */
+#include <linux/bsg.h>
 #include <linux/proc_fs.h>
 
-#include "scsi.h"
+#include <scsi/scsi.h>
+#include <scsi/scsi_eh.h>
 #include <scsi/scsi_dbg.h>
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_driver.h>
@@ -99,6 +102,7 @@ enum sg_rq_state {
 #define SG_ADD_RQ_MAX_RETRIES 40	/* to stop infinite _trylock(s) */
 
 /* Bit positions (flags) for sg_request::frq_bm bitmask follow */
+#define SG_FRQ_IS_V4I		0	/* true (set) when is v4 interface */
 #define SG_FRQ_IS_ORPHAN	1	/* owner of request gone */
 #define SG_FRQ_SYNC_INVOC	2	/* synchronous (blocking) invocation */
 #define SG_FRQ_DIO_IN_USE	3	/* false->indirect_IO,mmap; 1->dio */
@@ -159,6 +163,15 @@ struct sg_slice_hdr3 {
 	void __user *usr_ptr;
 };
 
+struct sg_slice_hdr4 {	/* parts of sg_io_v4 object needed in async usage */
+	void __user *sbp;	/* derived from sg_io_v4::response */
+	u64 usr_ptr;		/* hold sg_io_v4::usr_ptr as given (u64) */
+	int out_resid;
+	s16 dir;		/* data xfer direction; SG_DXFER_*  */
+	u16 cmd_len;		/* truncated of sg_io_v4::request_len */
+	u16 max_sb_len;		/* truncated of sg_io_v4::max_response_len */
+};
+
 struct sg_scatter_hold {     /* holding area for scsi scatter gather info */
 	struct page **pages;	/* num_sgat element array of struct page* */
 	int buflen;		/* capacity in bytes (dlen<=buflen) */
@@ -175,7 +188,10 @@ struct sg_request {	/* active SCSI command or inactive on free list (fl) */
 	struct list_head fl_entry;	/* member of rq_fl */
 	spinlock_t req_lck;
 	struct sg_scatter_hold sgat_h;	/* hold buffer, perhaps scatter list */
-	struct sg_slice_hdr3 s_hdr3;  /* subset of sg_io_hdr */
+	union {
+		struct sg_slice_hdr3 s_hdr3;  /* subset of sg_io_hdr */
+		struct sg_slice_hdr4 s_hdr4; /* reduced size struct sg_io_v4 */
+	};
 	u32 duration;		/* cmd duration in milliseconds */
 	u32 rq_flags;		/* hold user supplied flags */
 	u32 rq_info;		/* info supplied by v3 and v4 interfaces */
@@ -235,7 +251,10 @@ struct sg_device { /* holds the state of each scsi generic device */
 struct sg_comm_wr_t {	/* arguments to sg_common_write() */
 	int timeout;
 	unsigned long frq_bm[1];	/* see SG_FRQ_* defines above */
-	struct sg_io_hdr *h3p;
+	union {		/* selector is frq_bm.SG_FRQ_IS_V4I */
+		struct sg_io_hdr *h3p;
+		struct sg_io_v4 *h4p;
+	};
 	u8 *cmnd;
 };
 
@@ -244,12 +263,12 @@ static void sg_rq_end_io(struct request *rq, blk_status_t status);
 /* Declarations of other static functions used before they are defined */
 static int sg_proc_init(void);
 static int sg_start_req(struct sg_request *srp, u8 *cmd, int cmd_len,
-			int dxfer_dir);
+			struct sg_io_v4 *h4p, int dxfer_dir);
 static void sg_finish_scsi_blk_rq(struct sg_request *srp);
 static int sg_mk_sgat(struct sg_request *srp, struct sg_fd *sfp, int minlen);
-static int sg_submit(struct file *filp, struct sg_fd *sfp,
-		     struct sg_io_hdr *hp, bool sync,
-		     struct sg_request **o_srp);
+static int sg_v3_submit(struct file *filp, struct sg_fd *sfp,
+			struct sg_io_hdr *hp, bool sync,
+			struct sg_request **o_srp);
 static struct sg_request *sg_common_write(struct sg_fd *sfp,
 					  struct sg_comm_wr_t *cwp);
 static int sg_rd_append(struct sg_request *srp, void __user *outp,
@@ -257,11 +276,11 @@ static int sg_rd_append(struct sg_request *srp, void __user *outp,
 static void sg_remove_sgat(struct sg_request *srp);
 static struct sg_fd *sg_add_sfp(struct sg_device *sdp);
 static void sg_remove_sfp(struct kref *);
-static struct sg_request *sg_find_srp_by_id(struct sg_fd *sfp, int pack_id);
+static struct sg_request *sg_find_srp_by_id(struct sg_fd *sfp, int id);
 static struct sg_request *sg_add_request(struct sg_fd *sfp, int dxfr_len,
 					 struct sg_comm_wr_t *cwrp);
 static void sg_deact_request(struct sg_fd *sfp, struct sg_request *srp);
-static struct sg_device *sg_get_dev(int dev);
+static struct sg_device *sg_get_dev(int min_dev);
 static void sg_device_destroy(struct kref *kref);
 static struct sg_request *sg_mk_srp_sgat(struct sg_fd *sfp, bool first,
 					 int db_len);
@@ -274,8 +293,11 @@ static void sg_rep_rq_state_fail(struct sg_fd *sfp,
 
 #define SZ_SG_HEADER ((int)sizeof(struct sg_header))	/* v1 and v2 header */
 #define SZ_SG_IO_HDR ((int)sizeof(struct sg_io_hdr))	/* v3 header */
+#define SZ_SG_IO_V4 ((int)sizeof(struct sg_io_v4))  /* v4 header (in bsg.h) */
 #define SZ_SG_REQ_INFO ((int)sizeof(struct sg_req_info))
 
+/* There is a assert that SZ_SG_IO_V4 >= SZ_SG_IO_HDR in first function */
+
 #define SG_IS_DETACHING(sdp) test_bit(SG_FDEV_DETACHING, (sdp)->fdev_bm)
 #define SG_HAVE_EXCLUDE(sdp) test_bit(SG_FDEV_EXCLUDE, (sdp)->fdev_bm)
 #define SG_RS_ACTIVE(srp) (atomic_read(&(srp)->rq_st) != SG_RS_INACTIVE)
@@ -295,6 +317,7 @@ static void sg_rep_rq_state_fail(struct sg_fd *sfp,
 
 #if IS_ENABLED(CONFIG_SCSI_LOGGING) && IS_ENABLED(SG_DEBUG)
 #define SG_LOG_BUFF_SZ 48
+#define SG_LOG_ACTIVE 1
 
 #define SG_LOG(depth, sfp, fmt, a...)					\
 	do {								\
@@ -332,6 +355,10 @@ static void sg_rep_rq_state_fail(struct sg_fd *sfp,
 static int
 sg_check_file_access(struct file *filp, const char *caller)
 {
+	/* can't put following in declarations where it belongs */
+	compiletime_assert(SZ_SG_IO_V4 >= SZ_SG_IO_HDR,
+			   "struct sg_io_v4 should be larger than sg_io_hdr");
+
 	if (filp->f_cred != current_real_cred()) {
 		pr_err_once("%s: process %d (%s) changed security contexts after opening file descriptor, this is not allowed.\n",
 			caller, task_tgid_vnr(current), current->comm);
@@ -347,10 +374,11 @@ sg_check_file_access(struct file *filp, const char *caller)
 
 static int
 sg_wait_open_event(struct sg_device *sdp, bool o_excl)
+	__must_hold(&sdp->open_rel_lock)
 {
 	int res = 0;
 
-	if (o_excl) {
+	if (unlikely(o_excl)) {
 		while (atomic_read(&sdp->open_cnt) > 0) {
 			mutex_unlock(&sdp->open_rel_lock);
 			res = wait_event_interruptible
@@ -359,13 +387,13 @@ sg_wait_open_event(struct sg_device *sdp, bool o_excl)
 					  atomic_read(&sdp->open_cnt) == 0));
 			mutex_lock(&sdp->open_rel_lock);
 
-			if (res) /* -ERESTARTSYS */
+			if (unlikely(res)) /* -ERESTARTSYS */
 				return res;
-			if (SG_IS_DETACHING(sdp))
+			if (unlikely(SG_IS_DETACHING(sdp)))
 				return -ENODEV;
 		}
 	} else {
-		while (SG_HAVE_EXCLUDE(sdp)) {
+		while (unlikely(SG_HAVE_EXCLUDE(sdp))) {
 			mutex_unlock(&sdp->open_rel_lock);
 			res = wait_event_interruptible
 					(sdp->open_wait,
@@ -373,13 +401,12 @@ sg_wait_open_event(struct sg_device *sdp, bool o_excl)
 					  !SG_HAVE_EXCLUDE(sdp)));
 			mutex_lock(&sdp->open_rel_lock);
 
-			if (res) /* -ERESTARTSYS */
+			if (unlikely(res)) /* -ERESTARTSYS */
 				return res;
-			if (SG_IS_DETACHING(sdp))
+			if (unlikely(SG_IS_DETACHING(sdp)))
 				return -ENODEV;
 		}
 	}
-
 	return res;
 }
 
@@ -393,9 +420,9 @@ sg_wait_open_event(struct sg_device *sdp, bool o_excl)
 static inline int
 sg_allow_if_err_recovery(struct sg_device *sdp, bool non_block)
 {
-	if (!sdp)
+	if (unlikely(!sdp))
 		return -EPROTO;
-	if (SG_IS_DETACHING(sdp))
+	if (unlikely(SG_IS_DETACHING(sdp)))
 		return -ENODEV;
 	if (non_block)
 		return 0;
@@ -425,21 +452,18 @@ sg_open(struct inode *inode, struct file *filp)
 	o_excl = !!(op_flags & O_EXCL);
 	non_block = !!(op_flags & O_NONBLOCK);
 	if (o_excl && ((op_flags & O_ACCMODE) == O_RDONLY))
-		return -EPERM; /* Can't lock it with read only access */
+		return -EPERM;/* not permitted, need write access for O_EXCL */
 	sdp = sg_get_dev(min_dev);
 	if (IS_ERR(sdp))
 		return PTR_ERR(sdp);
 
-	/* This driver's module count bumped by fops_get in <linux/fs.h> */
 	/* Prevent the device driver from vanishing while we sleep */
 	res = scsi_device_get(sdp->device);
 	if (res)
 		goto sg_put;
-
 	res = scsi_autopm_get_device(sdp->device);
 	if (res)
 		goto sdp_put;
-
 	res = sg_allow_if_err_recovery(sdp, non_block);
 	if (res)
 		goto error_out;
@@ -476,6 +500,7 @@ sg_open(struct inode *inode, struct file *filp)
 	}
 
 	filp->private_data = sfp;
+	sfp->tid = (current ? current->pid : -1);
 	atomic_inc(&sdp->open_cnt);
 	mutex_unlock(&sdp->open_rel_lock);
 	SG_LOG(3, sfp, "%s: minor=%d, op_flags=0x%x; %s count prior=%d%s\n",
@@ -502,8 +527,13 @@ sg_open(struct inode *inode, struct file *filp)
 	goto sg_put;
 }
 
-/* Release resources associated with a successful sg_open()
- * Returns 0 on success, else a negated errno value */
+/*
+ * Release resources associated with a prior, successful sg_open(). It can be
+ * seen as the (final) close() call on a sg device file descriptor in the user
+ * space. The real work releasing all resources associated with this file
+ * descriptor is done by sg_remove_sfp_usercontext() which is scheduled by
+ * sg_remove_sfp().
+ */
 static int
 sg_release(struct inode *inode, struct file *filp)
 {
@@ -583,7 +613,7 @@ sg_write(struct file *filp, const char __user *p, size_t count, loff_t *ppos)
 		if (__copy_from_user(h3u8p + SZ_SG_HEADER, p + SZ_SG_HEADER,
 				     SZ_SG_IO_HDR - SZ_SG_HEADER))
 			return -EFAULT;
-		res = sg_submit(filp, sfp, h3p, false, NULL);
+		res = sg_v3_submit(filp, sfp, h3p, false, NULL);
 		return res < 0 ? res : (int)count;
 	}
 	/* v1 and v2 interfaces processed below this point */
@@ -654,18 +684,6 @@ sg_write(struct file *filp, const char __user *p, size_t count, loff_t *ppos)
 	return (IS_ERR(srp)) ? PTR_ERR(srp) : (int)count;
 }
 
-static inline int
-sg_chk_mmap(struct sg_fd *sfp, int rq_flags, int len)
-{
-	if (!list_empty(&sfp->rq_list))
-		return -EBUSY;  /* already active requests on fd */
-	if (len > sfp->rsv_srp->sgat_h.buflen)
-		return -ENOMEM; /* MMAP_IO size must fit in reserve */
-	if (rq_flags & SG_FLAG_DIRECT_IO)
-		return -EINVAL; /* not both MMAP_IO and DIRECT_IO */
-	return 0;
-}
-
 static int
 sg_fetch_cmnd(struct file *filp, struct sg_fd *sfp, const u8 __user *u_cdbp,
 	      int len, u8 *cdbp)
@@ -688,8 +706,8 @@ sg_fetch_cmnd(struct file *filp, struct sg_fd *sfp, const u8 __user *u_cdbp,
 }
 
 static int
-sg_submit(struct file *filp, struct sg_fd *sfp, struct sg_io_hdr *hp,
-	  bool sync, struct sg_request **o_srp)
+sg_v3_submit(struct file *filp, struct sg_fd *sfp, struct sg_io_hdr *hp,
+	     bool sync, struct sg_request **o_srp)
 {
 	int res, timeout;
 	unsigned long ul_timeout;
@@ -699,9 +717,12 @@ sg_submit(struct file *filp, struct sg_fd *sfp, struct sg_io_hdr *hp,
 
 	/* now doing v3 blocking (sync) or non-blocking submission */
 	if (hp->flags & SG_FLAG_MMAP_IO) {
-		res = sg_chk_mmap(sfp, hp->flags, hp->dxfer_len);
-		if (res)
-			return res;
+		if (!list_empty(&sfp->rq_list))
+			return -EBUSY;  /* already active requests on fd */
+		if (hp->dxfer_len > sfp->rsv_srp->sgat_h.buflen)
+			return -ENOMEM; /* MMAP_IO size must fit in reserve */
+		if (hp->flags & SG_FLAG_DIRECT_IO)
+			return -EINVAL; /* not both MMAP_IO and DIRECT_IO */
 	}
 	/* when v3 seen, allow cmd_q on this fd (def: no cmd_q) */
 	set_bit(SG_FFD_CMD_Q, sfp->ffd_bm);
@@ -723,16 +744,124 @@ sg_submit(struct file *filp, struct sg_fd *sfp, struct sg_io_hdr *hp,
 	return 0;
 }
 
+static int
+sg_v4_submit(struct file *filp, struct sg_fd *sfp, void __user *p,
+	     struct sg_io_v4 *h4p, bool sync, struct sg_request **o_srp)
+{
+	int timeout, res;
+	unsigned long ul_timeout;
+	struct sg_request *srp;
+	struct sg_comm_wr_t cwr;
+	u8 cmnd[SG_MAX_CDB_SIZE];
+
+	if (h4p->flags & SG_FLAG_MMAP_IO) {
+		int len = 0;
+
+		if (h4p->din_xferp)
+			len = h4p->din_xfer_len;
+		else if (h4p->dout_xferp)
+			len = h4p->dout_xfer_len;
+		if (!list_empty(&sfp->rq_list))
+			return -EBUSY;  /* already active requests on fd */
+		if (len > sfp->rsv_srp->sgat_h.buflen)
+			return -ENOMEM; /* MMAP_IO size must fit in reserve */
+		if (h4p->flags & SG_FLAG_DIRECT_IO)
+			return -EINVAL; /* not both MMAP_IO and DIRECT_IO */
+	}
+	/* once v4 (or v3) seen, allow cmd_q on this fd (def: no cmd_q) */
+	set_bit(SG_FFD_CMD_Q, sfp->ffd_bm);
+	ul_timeout = msecs_to_jiffies(h4p->timeout);
+	timeout = min_t(unsigned long, ul_timeout, INT_MAX);
+	res = sg_fetch_cmnd(filp, sfp, cuptr64(h4p->request), h4p->request_len,
+			    cmnd);
+	if (res)
+		return res;
+	cwr.frq_bm[0] = 0;
+	assign_bit(SG_FRQ_SYNC_INVOC, cwr.frq_bm, (int)sync);
+	set_bit(SG_FRQ_IS_V4I, cwr.frq_bm);
+	cwr.h4p = h4p;
+	cwr.timeout = timeout;
+	cwr.cmnd = cmnd;
+	srp = sg_common_write(sfp, &cwr);
+	if (IS_ERR(srp))
+		return PTR_ERR(srp);
+	if (o_srp)
+		*o_srp = srp;
+	return res;
+}
+
+static int
+sg_ctl_iosubmit(struct file *filp, struct sg_fd *sfp, void __user *p)
+{
+	int res;
+	u8 hdr_store[SZ_SG_IO_V4];
+	struct sg_io_v4 *h4p = (struct sg_io_v4 *)hdr_store;
+	struct sg_device *sdp = sfp->parentdp;
+
+	res = sg_allow_if_err_recovery(sdp, (filp->f_flags & O_NONBLOCK));
+	if (res)
+		return res;
+	if (copy_from_user(hdr_store, p, SZ_SG_IO_V4))
+		return -EFAULT;
+	if (h4p->guard == 'Q')
+		return sg_v4_submit(filp, sfp, p, h4p, false, NULL);
+	return -EPERM;
+}
+
+static void
+sg_execute_cmd(struct sg_fd *sfp, struct sg_request *srp)
+{
+	bool at_head, is_v4h, sync;
+	struct sg_device *sdp = sfp->parentdp;
+
+	is_v4h = test_bit(SG_FRQ_IS_V4I, srp->frq_bm);
+	sync = test_bit(SG_FRQ_SYNC_INVOC, srp->frq_bm);
+	SG_LOG(3, sfp, "%s: is_v4h=%d\n", __func__, (int)is_v4h);
+	srp->start_ns = ktime_get_boot_ns();
+	srp->duration = 0;
+
+	if (!is_v4h && srp->s_hdr3.interface_id == '\0')
+		at_head = true;	/* backward compatibility: v1+v2 interfaces */
+	else if (test_bit(SG_FFD_Q_AT_TAIL, sfp->ffd_bm))
+		/* cmd flags can override sfd setting */
+		at_head = !!(srp->rq_flags & SG_FLAG_Q_AT_HEAD);
+	else            /* this sfd is defaulting to head */
+		at_head = !(srp->rq_flags & SG_FLAG_Q_AT_TAIL);
+
+	kref_get(&sfp->f_ref); /* sg_rq_end_io() does kref_put(). */
+
+	/* >>>>>>> send cmd/req off to other levels <<<<<<<< */
+	if (!sync)
+		atomic_inc(&sfp->submitted);
+	blk_execute_rq_nowait(sdp->device->request_queue, sdp->disk,
+			      srp->rq, (int)at_head, sg_rq_end_io);
+}
+
+static inline int
+sg_rstate_chg(struct sg_request *srp, enum sg_rq_state old_st,
+	      enum sg_rq_state new_st)
+{
+	enum sg_rq_state act_old_st = (enum sg_rq_state)
+				atomic_cmpxchg(&srp->rq_st, old_st, new_st);
+
+	if (act_old_st == old_st)
+		return 0;	/* implies new_st --> srp->rq_st */
+	else if (IS_ENABLED(SG_LOG_ACTIVE))
+		sg_rep_rq_state_fail(srp->parentfp, old_st, new_st,
+				     act_old_st);
+	return -EPROTOTYPE;
+}
+
 /*
  * All writes and submits converge on this function to launch the SCSI
  * command/request (via blk_execute_rq_nowait). Returns a pointer to a
  * sg_request object holding the request just issued or a negated errno
  * value twisted by ERR_PTR.
+ * N.B. pack_id placed in sg_io_v4::request_extra field.
  */
 static struct sg_request *
 sg_common_write(struct sg_fd *sfp, struct sg_comm_wr_t *cwrp)
 {
-	bool at_head;
 	int res = 0;
 	int dxfr_len, dir, cmd_len;
 	int pack_id = SG_PACK_ID_WILDCARD;
@@ -740,12 +869,32 @@ sg_common_write(struct sg_fd *sfp, struct sg_comm_wr_t *cwrp)
 	struct sg_device *sdp = sfp->parentdp;
 	struct sg_request *srp;
 	struct sg_io_hdr *hi_p;
-
-	hi_p = cwrp->h3p;
-	dir = hi_p->dxfer_direction;
-	dxfr_len = hi_p->dxfer_len;
-	rq_flags = hi_p->flags;
-	pack_id = hi_p->pack_id;
+	struct sg_io_v4 *h4p;
+
+	if (test_bit(SG_FRQ_IS_V4I, cwrp->frq_bm)) {
+		h4p = cwrp->h4p;
+		hi_p = NULL;
+		dxfr_len = 0;
+		dir = SG_DXFER_NONE;
+		rq_flags = h4p->flags;
+		pack_id = h4p->request_extra;
+		if (h4p->din_xfer_len && h4p->dout_xfer_len) {
+			return ERR_PTR(-EOPNOTSUPP);
+		} else if (h4p->din_xfer_len) {
+			dxfr_len = h4p->din_xfer_len;
+			dir = SG_DXFER_FROM_DEV;
+		} else if (h4p->dout_xfer_len) {
+			dxfr_len = h4p->dout_xfer_len;
+			dir = SG_DXFER_TO_DEV;
+		}
+	} else {                /* sg v3 interface so hi_p valid */
+		h4p = NULL;
+		hi_p = cwrp->h3p;
+		dir = hi_p->dxfer_direction;
+		dxfr_len = hi_p->dxfer_len;
+		rq_flags = hi_p->flags;
+		pack_id = hi_p->pack_id;
+	}
 	if (dxfr_len >= SZ_256M)
 		return ERR_PTR(-EINVAL);
 
@@ -755,13 +904,23 @@ sg_common_write(struct sg_fd *sfp, struct sg_comm_wr_t *cwrp)
 	srp->rq_flags = rq_flags;
 	srp->pack_id = pack_id;
 
-	cmd_len = hi_p->cmd_len;
-	memcpy(&srp->s_hdr3, hi_p, sizeof(srp->s_hdr3));
+	if (h4p) {
+		memset(&srp->s_hdr4, 0, sizeof(srp->s_hdr4));
+		srp->s_hdr4.usr_ptr = h4p->usr_ptr;
+		srp->s_hdr4.sbp = uptr64(h4p->response);
+		srp->s_hdr4.max_sb_len = h4p->max_response_len;
+		srp->s_hdr4.cmd_len = h4p->request_len;
+		srp->s_hdr4.dir = dir;
+		cmd_len = h4p->request_len;
+	} else {	/* v3 interface active */
+		cmd_len = hi_p->cmd_len;
+		memcpy(&srp->s_hdr3, hi_p, sizeof(srp->s_hdr3));
+	}
 	srp->cmd_opcode = cwrp->cmnd[0];/* hold opcode of command for debug */
 	SG_LOG(4, sfp, "%s: opcode=0x%02x, cdb_sz=%d, pack_id=%d\n", __func__,
 	       (int)cwrp->cmnd[0], cmd_len, pack_id);
 
-	res = sg_start_req(srp, cwrp->cmnd, cmd_len, dir);
+	res = sg_start_req(srp, cwrp->cmnd, cmd_len, h4p, dir);
 	if (res < 0)		/* probably out of space --> -ENOMEM */
 		goto err_out;
 	if (unlikely(SG_IS_DETACHING(sdp))) {
@@ -773,21 +932,7 @@ sg_common_write(struct sg_fd *sfp, struct sg_comm_wr_t *cwrp)
 		goto err_out;
 	}
 	srp->rq->timeout = cwrp->timeout;
-	kref_get(&sfp->f_ref); /* sg_rq_end_io() does kref_put(). */
-	srp->start_ns = ktime_get_boot_ns();
-	srp->duration = 0;
-
-	if (srp->s_hdr3.interface_id == '\0')
-		at_head = true; /* backward compatibility: v1+v2 interfaces */
-	else if (test_bit(SG_FFD_Q_AT_TAIL, sfp->ffd_bm))
-	/* cmd flags can override sfd setting */
-		at_head = !!(srp->rq_flags & SG_FLAG_Q_AT_HEAD);
-	else            /* this sfd is defaulting to head */
-		at_head = !(srp->rq_flags & SG_FLAG_Q_AT_TAIL);
-	if (!test_bit(SG_FRQ_SYNC_INVOC, srp->frq_bm))
-		atomic_inc(&sfp->submitted);
-	blk_execute_rq_nowait(sdp->device->request_queue, sdp->disk,
-			      srp->rq, at_head, sg_rq_end_io);
+	sg_execute_cmd(sfp, srp);
 	return srp;
 err_out:
 	sg_finish_scsi_blk_rq(srp);
@@ -795,21 +940,6 @@ sg_common_write(struct sg_fd *sfp, struct sg_comm_wr_t *cwrp)
 	return ERR_PTR(res);
 }
 
-static inline int
-sg_rstate_chg(struct sg_request *srp, enum sg_rq_state old_st,
-	      enum sg_rq_state new_st)
-{
-	enum sg_rq_state act_old_st = (enum sg_rq_state)
-				atomic_cmpxchg(&srp->rq_st, old_st, new_st);
-
-	if (act_old_st == old_st)
-		return 0;       /* implies new_st --> srp->rq_st */
-	else if (IS_ENABLED(CONFIG_SCSI_LOGGING))
-		sg_rep_rq_state_fail(srp->parentfp, old_st, new_st,
-				     act_old_st);
-	return -EPROTOTYPE;
-}
-
 /*
  * This function is called by wait_event_interruptible in sg_read() and
  * sg_ctl_ioreceive(). wait_event_interruptible will return if this one
@@ -834,7 +964,7 @@ sg_get_ready_srp(struct sg_fd *sfp, struct sg_request **srpp, int pack_id)
  * negated errno value.
  */
 static int
-sg_copy_sense(struct sg_request *srp)
+sg_copy_sense(struct sg_request *srp, bool v4_active)
 {
 	int sb_len_wr = 0;
 	int scsi_stat;
@@ -849,8 +979,13 @@ sg_copy_sense(struct sg_request *srp)
 		void __user *up;
 
 		srp->sense_bp = NULL;
-		up = (void __user *)srp->s_hdr3.sbp;
-		mx_sb_len = srp->s_hdr3.mx_sb_len;
+		if (v4_active) {
+			up = uptr64(srp->s_hdr4.sbp);
+			mx_sb_len = srp->s_hdr4.max_sb_len;
+		} else {
+			up = (void __user *)srp->s_hdr3.sbp;
+			mx_sb_len = srp->s_hdr3.mx_sb_len;
+		}
 		if (up && mx_sb_len > 0 && sbp) {
 			sb_len = min_t(int, sb_len, mx_sb_len);
 			/* Additional sense length field */
@@ -891,13 +1026,13 @@ sg_rep_rq_state_fail(struct sg_fd *sfp, enum sg_rq_state exp_old_st,
 #endif
 
 static int
-sg_rec_v3_state(struct sg_fd *sfp, struct sg_request *srp)
+sg_rec_v3v4_state(struct sg_fd *sfp, struct sg_request *srp, bool v4_active)
 {
 	int err = 0;
 	int sb_len_wr;
 	u32 rq_res = srp->rq_result;
 
-	sb_len_wr = sg_copy_sense(srp);
+	sb_len_wr = sg_copy_sense(srp, v4_active);
 	if (sb_len_wr < 0)
 		return sb_len_wr;
 	if (rq_res & SG_ML_RESULT_MSK)
@@ -921,7 +1056,7 @@ sg_v3_receive(struct sg_fd *sfp, struct sg_request *srp, void __user *p)
 	struct sg_io_hdr *hp = &hdr3;
 
 	SG_LOG(3, sfp, "%s: srp=0x%p\n", __func__, srp);
-	err = sg_rec_v3_state(sfp, srp);
+	err = sg_rec_v3v4_state(sfp, srp, false);
 	memset(hp, 0, sizeof(*hp));
 	memcpy(hp, &srp->s_hdr3, sizeof(srp->s_hdr3));
 	hp->sb_len_wr = srp->sense_len;
@@ -944,6 +1079,102 @@ sg_v3_receive(struct sg_fd *sfp, struct sg_request *srp, void __user *p)
 	return err ? err : 0;
 }
 
+static int
+sg_v4_receive(struct sg_fd *sfp, struct sg_request *srp, void __user *p,
+	      struct sg_io_v4 *h4p)
+{
+	int err, err2;
+	u32 rq_result = srp->rq_result;
+
+	SG_LOG(3, sfp, "%s: p=%s, h4p=%s\n", __func__,
+	       (p ? "given" : "NULL"), (h4p ? "given" : "NULL"));
+	err = sg_rec_v3v4_state(sfp, srp, true);
+	h4p->guard = 'Q';
+	h4p->protocol = 0;
+	h4p->subprotocol = 0;
+	h4p->device_status = rq_result & 0xff;
+	h4p->driver_status = driver_byte(rq_result);
+	h4p->transport_status = host_byte(rq_result);
+	h4p->response_len = srp->sense_len;
+	h4p->info = srp->rq_info;
+	h4p->flags = srp->rq_flags;
+	h4p->duration = srp->duration;
+	switch (srp->s_hdr4.dir) {
+	case SG_DXFER_FROM_DEV:
+		h4p->din_xfer_len = srp->sgat_h.dlen;
+		break;
+	case SG_DXFER_TO_DEV:
+		h4p->dout_xfer_len = srp->sgat_h.dlen;
+		break;
+	default:
+		break;
+	}
+	h4p->din_resid = srp->in_resid;
+	h4p->dout_resid = srp->s_hdr4.out_resid;
+	h4p->usr_ptr = srp->s_hdr4.usr_ptr;
+	h4p->response = (u64)srp->s_hdr4.sbp;
+	h4p->request_extra = srp->pack_id;
+	if (p) {
+		if (copy_to_user(p, h4p, SZ_SG_IO_V4))
+			err = err ? err : -EFAULT;
+	}
+	err2 = sg_rstate_chg(srp, atomic_read(&srp->rq_st), SG_RS_DONE_RD);
+	if (err2)
+		err = err ? err : err2;
+	sg_finish_scsi_blk_rq(srp);
+	sg_deact_request(sfp, srp);
+	return err < 0 ? err : 0;
+}
+
+/*
+ * Called when ioctl(SG_IORECEIVE) received. Expects a v4 interface object.
+ * Checks if O_NONBLOCK file flag given, if not checks given 'flags' field
+ * to see if SGV4_FLAG_IMMED is set. Either of these implies non blocking.
+ * When non-blocking and there is no request waiting, yields EAGAIN;
+ * otherwise it waits (i.e. it "blocks").
+ */
+static int
+sg_ctl_ioreceive(struct file *filp, struct sg_fd *sfp, void __user *p)
+{
+	bool non_block = !!(filp->f_flags & O_NONBLOCK);
+	int res, id;
+	int pack_id = SG_PACK_ID_WILDCARD;
+	u8 v4_holder[SZ_SG_IO_V4];
+	struct sg_io_v4 *h4p = (struct sg_io_v4 *)v4_holder;
+	struct sg_device *sdp = sfp->parentdp;
+	struct sg_request *srp;
+
+	res = sg_allow_if_err_recovery(sdp, non_block);
+	if (res)
+		return res;
+	/* Get first three 32 bit integers: guard, proto+subproto */
+	if (copy_from_user(h4p, p, SZ_SG_IO_V4))
+		return -EFAULT;
+	/* for v4: protocol=0 --> SCSI;  subprotocol=0 --> SPC++ */
+	if (h4p->guard != 'Q' || h4p->protocol != 0 || h4p->subprotocol != 0)
+		return -EPERM;
+	if (h4p->flags & SGV4_FLAG_IMMED)
+		non_block = true;	/* set by either this or O_NONBLOCK */
+	SG_LOG(3, sfp, "%s: non_block(+IMMED)=%d\n", __func__, non_block);
+	/* read in part of v3 or v4 header for pack_id or tag based find */
+	id = pack_id;
+	srp = sg_find_srp_by_id(sfp, id);
+	if (!srp) {     /* nothing available so wait on packet or */
+		if (unlikely(SG_IS_DETACHING(sdp)))
+			return -ENODEV;
+		if (non_block)
+			return -EAGAIN;
+		res = wait_event_interruptible(sfp->read_wait,
+					       sg_get_ready_srp(sfp, &srp,
+								id));
+		if (unlikely(SG_IS_DETACHING(sdp)))
+			return -ENODEV;
+		if (res)	/* -ERESTARTSYS as signal hit process */
+			return res;
+	}	/* now srp should be valid */
+	return sg_v4_receive(sfp, srp, p, h4p);
+}
+
 static int
 sg_rd_v1v2(void __user *buf, int count, struct sg_fd *sfp,
 	   struct sg_request *srp)
@@ -1216,6 +1447,8 @@ sg_fill_request_element(struct sg_fd *sfp, struct sg_request *srp,
 	rip->sg_io_owned = test_bit(SG_FRQ_SYNC_INVOC, srp->frq_bm);
 	rip->problem = !!(srp->rq_result & SG_ML_RESULT_MSK);
 	rip->pack_id = srp->pack_id;
+	rip->usr_ptr = test_bit(SG_FRQ_IS_V4I, srp->frq_bm) ?
+			uptr64(srp->s_hdr4.usr_ptr) : srp->s_hdr3.usr_ptr;
 	rip->usr_ptr = srp->s_hdr3.usr_ptr;
 	spin_unlock(&srp->req_lck);
 }
@@ -1233,7 +1466,7 @@ sg_rq_landed(struct sg_device *sdp, struct sg_request *srp)
  */
 static int
 sg_wait_event_srp(struct file *filp, struct sg_fd *sfp, void __user *p,
-		  struct sg_request *srp)
+		  struct sg_io_v4 *h4p, struct sg_request *srp)
 {
 	int res;
 	enum sg_rq_state sr_st;
@@ -1261,7 +1494,10 @@ sg_wait_event_srp(struct file *filp, struct sg_fd *sfp, void __user *p,
 	res = sg_rstate_chg(srp, sr_st, SG_RS_BUSY);
 	if (unlikely(res))
 		return res;
-	res = sg_v3_receive(sfp, srp, p);
+	if (test_bit(SG_FRQ_IS_V4I, srp->frq_bm))
+		res = sg_v4_receive(sfp, srp, p, h4p);
+	else
+		res = sg_v3_receive(sfp, srp, p);
 	return (res < 0) ? res : 0;
 }
 
@@ -1275,8 +1511,9 @@ sg_ctl_sg_io(struct file *filp, struct sg_device *sdp, struct sg_fd *sfp,
 {
 	int res;
 	struct sg_request *srp = NULL;
-	u8 hu8arr[SZ_SG_IO_HDR];
+	u8 hu8arr[SZ_SG_IO_V4];
 	struct sg_io_hdr *h3p = (struct sg_io_hdr *)hu8arr;
+	struct sg_io_v4 *h4p = (struct sg_io_v4 *)hu8arr;
 
 	SG_LOG(3, sfp, "%s:  SG_IO%s\n", __func__,
 	       ((filp->f_flags & O_NONBLOCK) ? " O_NONBLOCK ignored" : ""));
@@ -1285,15 +1522,25 @@ sg_ctl_sg_io(struct file *filp, struct sg_device *sdp, struct sg_fd *sfp,
 		return res;
 	if (copy_from_user(h3p, p, SZ_SG_IO_HDR))
 		return -EFAULT;
-	if (h3p->interface_id == 'S')
-		res = sg_submit(filp, sfp, h3p, true, &srp);
-	else
+	if (h3p->interface_id == 'Q') {
+		/* copy in rest of sg_io_v4 object */
+		if (copy_from_user(hu8arr + SZ_SG_IO_HDR,
+				   ((u8 __user *)p) + SZ_SG_IO_HDR,
+				   SZ_SG_IO_V4 - SZ_SG_IO_HDR))
+			return -EFAULT;
+		res = sg_v4_submit(filp, sfp, p, h4p, true, &srp);
+	} else if (h3p->interface_id == 'S') {
+		res = sg_v3_submit(filp, sfp, h3p, true, &srp);
+	} else {
+		pr_info_once("sg: %s: v3 or v4 interface only here\n",
+			     __func__);
 		return -EPERM;
+	}
 	if (unlikely(res < 0))
 		return res;
 	if (!srp)	/* mrq case: already processed all responses */
 		return res;
-	res = sg_wait_event_srp(filp, sfp, p, srp);
+	res = sg_wait_event_srp(filp, sfp, p, h4p, srp);
 	if (res) {
 		SG_LOG(1, sfp, "%s: %s=0x%p  state: %s\n", __func__,
 		       "unexpected srp", srp,
@@ -1482,6 +1729,12 @@ sg_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
 	switch (cmd_in) {
 	case SG_IO:
 		return sg_ctl_sg_io(filp, sdp, sfp, p);
+	case SG_IOSUBMIT:
+		SG_LOG(3, sfp, "%s:    SG_IOSUBMIT\n", __func__);
+		return sg_ctl_iosubmit(filp, sfp, p);
+	case SG_IORECEIVE:
+		SG_LOG(3, sfp, "%s:    SG_IORECEIVE\n", __func__);
+		return sg_ctl_ioreceive(filp, sfp, p);
 	case SG_GET_SCSI_ID:
 		return sg_ctl_scsi_id(sdev, sfp, p);
 	case SG_SET_FORCE_PACK_ID:
@@ -1977,8 +2230,16 @@ sg_rq_end_io(struct request *rq, blk_status_t status)
 	slen = min_t(int, scsi_rp->sense_len, SCSI_SENSE_BUFFERSIZE);
 	a_resid = scsi_rp->resid_len;
 
-	if (a_resid)
-		srp->in_resid = a_resid;
+	if (a_resid) {
+		if (test_bit(SG_FRQ_IS_V4I, srp->frq_bm)) {
+			if (rq_data_dir(rq) == READ)
+				srp->in_resid = a_resid;
+			else
+				srp->s_hdr4.out_resid = a_resid;
+		} else {
+			srp->in_resid = a_resid;
+		}
+	}
 
 	SG_LOG(6, sfp, "%s: pack_id=%d, res=0x%x\n", __func__, srp->pack_id,
 	       srp->rq_result);
@@ -2353,7 +2614,8 @@ sg_set_map_data(const struct sg_scatter_hold *schp, bool up_valid,
 }
 
 static int
-sg_start_req(struct sg_request *srp, u8 *cmd, int cmd_len, int dxfer_dir)
+sg_start_req(struct sg_request *srp, u8 *cmd, int cmd_len,
+	     struct sg_io_v4 *h4p, int dxfer_dir)
 {
 	bool reserved, us_xfer;
 	int res = 0;
@@ -2370,7 +2632,6 @@ sg_start_req(struct sg_request *srp, u8 *cmd, int cmd_len, int dxfer_dir)
 	struct rq_map_data *md = (void *)srp; /* want any non-NULL value */
 	u8 *long_cmdp = NULL;
 	__maybe_unused const char *cp = "";
-	struct sg_slice_hdr3 *sh3p = &srp->s_hdr3;
 	struct rq_map_data map_data;
 
 	sdp = sfp->parentdp;
@@ -2380,10 +2641,28 @@ sg_start_req(struct sg_request *srp, u8 *cmd, int cmd_len, int dxfer_dir)
 			return -ENOMEM;
 		SG_LOG(5, sfp, "%s: long_cmdp=0x%p ++\n", __func__, long_cmdp);
 	}
-	up = sh3p->dxferp;
-	dxfer_len = (int)sh3p->dxfer_len;
-	iov_count = sh3p->iovec_count;
-	r0w = dxfer_dir == SG_DXFER_TO_DEV ? WRITE : READ;
+	if (h4p) {
+		if (dxfer_dir == SG_DXFER_TO_DEV) {
+			r0w = WRITE;
+			up = uptr64(h4p->dout_xferp);
+			dxfer_len = (int)h4p->dout_xfer_len;
+			iov_count = h4p->dout_iovec_count;
+		} else if (dxfer_dir == SG_DXFER_FROM_DEV) {
+			r0w = READ;
+			up = uptr64(h4p->din_xferp);
+			dxfer_len = (int)h4p->din_xfer_len;
+			iov_count = h4p->din_iovec_count;
+		} else {
+			up = NULL;
+		}
+	} else {
+		struct sg_slice_hdr3 *sh3p = &srp->s_hdr3;
+
+		up = sh3p->dxferp;
+		dxfer_len = (int)sh3p->dxfer_len;
+		iov_count = sh3p->iovec_count;
+		r0w = dxfer_dir == SG_DXFER_TO_DEV ? WRITE : READ;
+	}
 	SG_LOG(4, sfp, "%s: dxfer_len=%d, data-%s\n", __func__, dxfer_len,
 	       (r0w ? "OUT" : "IN"));
 	q = sdp->device->request_queue;
diff --git a/include/uapi/scsi/sg.h b/include/uapi/scsi/sg.h
index bb1be50d7b01..7557c1be01e0 100644
--- a/include/uapi/scsi/sg.h
+++ b/include/uapi/scsi/sg.h
@@ -98,6 +98,18 @@ typedef struct sg_io_hdr {
 #define SG_FLAG_Q_AT_TAIL 0x10
 #define SG_FLAG_Q_AT_HEAD 0x20
 
+/*
+ * Flags used by ioctl(SG_IOSUBMIT) [abbrev: SG_IOS] and ioctl(SG_IORECEIVE)
+ * [abbrev: SG_IOR] OR-ed into sg_io_v4::flags. The sync v4 interface uses
+ * ioctl(SG_IO) and can take these new flags, as can the v3 interface.
+ * These flags apply for SG_IOS unless otherwise noted. May be OR-ed together.
+ */
+#define SGV4_FLAG_DIRECT_IO SG_FLAG_DIRECT_IO
+#define SGV4_FLAG_MMAP_IO SG_FLAG_MMAP_IO
+#define SGV4_FLAG_Q_AT_TAIL SG_FLAG_Q_AT_TAIL
+#define SGV4_FLAG_Q_AT_HEAD SG_FLAG_Q_AT_HEAD
+#define SGV4_FLAG_IMMED 0x400 /* for polling with SG_IOR, ignored in SG_IOS */
+
 /* Output (potentially OR-ed together) in v3::info or v4::info field */
 #define SG_INFO_OK_MASK 0x1
 #define SG_INFO_OK 0x0		/* no sense, host nor driver "noise" */
@@ -133,7 +145,6 @@ typedef struct sg_req_info {	/* used by SG_GET_REQUEST_TABLE ioctl() */
 	/* sg_io_owned set imples synchronous, clear implies asynchronous */
 	char sg_io_owned;/* 0 -> complete with read(), 1 -> owned by SG_IO */
 	char problem;	/* 0 -> no problem detected, 1 -> error to report */
-	/* If SG_CTL_FLAGM_TAG_FOR_PACK_ID set on fd then next field is tag */
 	int pack_id;	/* pack_id, in v4 driver may be tag instead */
 	void __user *usr_ptr;	/* user provided pointer in v3+v4 interface */
 	unsigned int duration;
@@ -162,6 +173,13 @@ typedef struct sg_req_info {	/* used by SG_GET_REQUEST_TABLE ioctl() */
 #define SG_SET_RESERVED_SIZE 0x2275  /* request new reserved buffer size */
 #define SG_GET_RESERVED_SIZE 0x2272  /* actual size of reserved buffer */
 
+/*
+ * Historically the scsi/sg driver has used 0x22 as it ioctl base number.
+ * Add a define for that value and use it for several new ioctls added in
+ * version 4.0.01 sg driver and later.
+ */
+#define SG_IOCTL_MAGIC_NUM 0x22
+
 /* The following ioctl has a 'sg_scsi_id_t *' object as its 3rd argument. */
 #define SG_GET_SCSI_ID 0x2276   /* Yields fd's bus, chan, dev, lun + type */
 /* SCSI id information can also be obtained from SCSI_IOCTL_GET_IDLUN */
@@ -318,6 +336,23 @@ struct sg_header {
  */
 #define SG_NEXT_CMD_LEN 0x2283
 
+/*
+ * New ioctls to replace async (non-blocking) write()/read() interface.
+ * Present in version 4 and later of the sg driver [>20190427]. The
+ * SG_IOSUBMIT and SG_IORECEIVE ioctls accept the sg_v4 interface based on
+ * struct sg_io_v4 found in <include/uapi/linux/bsg.h>. These objects are
+ * passed by a pointer in the third argument of the ioctl.
+ *
+ * Data may be transferred both from the user space to the driver by these
+ * ioctls. Hence the _IOWR macro is used here to generate the ioctl number
+ * rather than _IOW or _IOR.
+ */
+/* Submits a v4 interface object to driver, optionally receive tag back */
+#define SG_IOSUBMIT _IOWR(SG_IOCTL_MAGIC_NUM, 0x41, struct sg_io_v4)
+
+/* Gives some v4 identifying info to driver, receives associated response */
+#define SG_IORECEIVE _IOWR(SG_IOCTL_MAGIC_NUM, 0x42, struct sg_io_v4)
+
 /* command queuing is always on when the v3 or v4 interface is used */
 #define SG_DEF_COMMAND_Q 0
 
-- 
2.17.1

