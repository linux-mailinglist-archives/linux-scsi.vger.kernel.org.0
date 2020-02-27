Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC2B17243E
	for <lists+linux-scsi@lfdr.de>; Thu, 27 Feb 2020 17:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbgB0Q7p (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 27 Feb 2020 11:59:45 -0500
Received: from smtp.infotech.no ([82.134.31.41]:47209 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729581AbgB0Q7o (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 27 Feb 2020 11:59:44 -0500
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 5A60A204197;
        Thu, 27 Feb 2020 17:59:42 +0100 (CET)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id crwg2rTz5vzS; Thu, 27 Feb 2020 17:59:39 +0100 (CET)
Received: from xtwo70.bingwo.ca (host-23-251-188-50.dyn.295.ca [23.251.188.50])
        by smtp.infotech.no (Postfix) with ESMTPA id 3303120418D;
        Thu, 27 Feb 2020 17:59:34 +0100 (CET)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de
Subject: [PATCH v7 21/38] sg: sg_fill_request_element
Date:   Thu, 27 Feb 2020 11:58:45 -0500
Message-Id: <20200227165902.11861-22-dgilbert@interlog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227165902.11861-1-dgilbert@interlog.com>
References: <20200227165902.11861-1-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Replace sg_fill_request_table() with sg_fill_request_element().
Reduce the size of the sg_rq_end_io() function by breaking out
some sense buffer checks into sg_check_sense(). Reduce the
size of the sg_start_req() function with sg_set_map_data()
helper. All code refactoring, no logical change.

*** Reviewed-by: Hannes Reinecke <hare@suse.com>

Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/sg.c | 215 ++++++++++++++++++++++++++--------------------
 1 file changed, 120 insertions(+), 95 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index fb24cbbecda0..0376a65eb7b6 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -161,6 +161,7 @@ struct sg_request {	/* SG_MAX_QUEUE requests outstanding per file */
 	u32 duration;		/* cmd duration in milliseconds */
 	char res_used;		/* 1 -> using reserve buffer, 0 -> not ... */
 	char orphan;		/* 1 -> drop on sight, 0 -> normal */
+	u32 rq_result;		/* packed scsi request result from LLD */
 	char sg_io_owned;	/* 1 -> packet belongs to SG_IO */
 	/* done protected by rq_list_lock */
 	char done;		/* 0->before bh, 1->before read, 2->read */
@@ -636,6 +637,18 @@ sg_write(struct file *filp, const char __user *p, size_t count, loff_t *ppos)
 	return (res < 0) ? res : count;
 }
 
+static inline int
+sg_chk_mmap(struct sg_fd *sfp, int rq_flags, int len)
+{
+	if (len > sfp->reserve.buflen)
+		return -ENOMEM;	/* MMAP_IO size must fit in reserve buffer */
+	if (rq_flags & SG_FLAG_DIRECT_IO)
+		return -EINVAL;	/* either MMAP_IO or DIRECT_IO (not both) */
+	if (sfp->res_in_use)
+		return -EBUSY;	/* reserve buffer already being used */
+	return 0;
+}
+
 static int
 sg_fetch_cmnd(struct file *filp, struct sg_fd *sfp, const u8 __user *u_cdbp,
 	      int len, u8 *cdbp)
@@ -657,18 +670,6 @@ sg_fetch_cmnd(struct file *filp, struct sg_fd *sfp, const u8 __user *u_cdbp,
 	return 0;
 }
 
-static inline int
-sg_chk_mmap(struct sg_fd *sfp, int rq_flags, int len)
-{
-	if (len > sfp->reserve.buflen)
-		return -ENOMEM;	/* MMAP_IO size must fit in reserve buffer */
-	if (rq_flags & SG_FLAG_DIRECT_IO)
-		return -EINVAL;	/* either MMAP_IO or DIRECT_IO (not both) */
-	if (sfp->res_in_use)
-		return -EBUSY;	/* reserve buffer already being used */
-	return 0;
-}
-
 static ssize_t
 sg_submit(struct sg_fd *sfp, struct file *filp, const char __user *buf,
 	  size_t count, bool blocking, bool read_only, bool sg_io_owned,
@@ -918,6 +919,11 @@ sg_receive_v3(struct sg_fd *sfp, struct sg_request *srp, size_t count,
 	return err;
 }
 
+/*
+ * Completes a v3 request/command. Called from sg_read {v2 or v3},
+ * ioctl(SG_IO) {for v3}, or from ioctl(SG_IORECEIVE) when its
+ * completing a v3 request/command.
+ */
 static int
 sg_read_v1v2(void __user *buf, int count, struct sg_fd *sfp,
 	     struct sg_request *srp)
@@ -1169,37 +1175,28 @@ sg_get_dur(struct sg_request *srp, const enum sg_rq_state *sr_stp,
 }
 
 static void
-sg_fill_request_table(struct sg_fd *sfp, struct sg_req_info *rinfo)
+sg_fill_request_element(struct sg_fd *sfp, struct sg_request *srp,
+			struct sg_req_info *rip)
 {
-	struct sg_request *srp;
-	int val;
 	unsigned int ms;
 
-	val = 0;
-	list_for_each_entry(srp, &sfp->rq_list, entry) {
-		if (val >= SG_MAX_QUEUE)
-			break;
-		rinfo[val].req_state = srp->done + 1;
-		rinfo[val].problem =
-			srp->header.masked_status &
-			srp->header.host_status &
-			srp->header.driver_status;
-		rinfo[val].duration = sg_get_dur(srp, NULL, NULL); /* dummy */
-		if (srp->done)
-			rinfo[val].duration =
-				srp->header.duration;
-		else {
-			ms = jiffies_to_msecs(jiffies);
-			rinfo[val].duration =
-				(ms > srp->header.duration) ?
+	rip->req_state = srp->done + 1;
+	rip->problem = srp->header.masked_status &
+		       srp->header.host_status &
+		       srp->header.driver_status;
+	rip->duration = sg_get_dur(srp, NULL, NULL); /* dummy */
+	if (srp->done) {
+		rip->duration = srp->header.duration;
+	} else {
+		ms = jiffies_to_msecs(jiffies);
+		rip->duration = (ms > srp->header.duration) ?
 				(ms - srp->header.duration) : 0;
-		}
-		rinfo[val].orphan = srp->orphan;
-		rinfo[val].sg_io_owned = srp->sg_io_owned;
-		rinfo[val].pack_id = srp->header.pack_id;
-		rinfo[val].usr_ptr = srp->header.usr_ptr;
-		val++;
 	}
+	rip->orphan = srp->orphan;
+	rip->sg_io_owned = srp->sg_io_owned;
+	rip->pack_id = srp->header.pack_id;
+	rip->usr_ptr = srp->header.usr_ptr;
+
 }
 
 static int
@@ -1293,28 +1290,35 @@ static int put_compat_request_table(struct compat_sg_req_info __user *o,
 static int
 sg_ctl_req_tbl(struct sg_fd *sfp, void __user *p)
 {
-	int result;
+	int result, val;
 	unsigned long iflags;
-	sg_req_info_t *rinfo;
+	struct sg_request *srp;
+	sg_req_info_t *rinfop;
 
-	rinfo = kcalloc(SG_MAX_QUEUE, SZ_SG_REQ_INFO,
-			GFP_KERNEL);
-	if (!rinfo)
+	rinfop = kcalloc(SG_MAX_QUEUE, SZ_SG_REQ_INFO,
+			 GFP_KERNEL);
+	if (!rinfop)
 		return -ENOMEM;
 	spin_lock_irqsave(&sfp->rq_list_lock, iflags);
-	sg_fill_request_table(sfp, rinfo);
+	val = 0;
+	list_for_each_entry(srp, &sfp->rq_list, entry) {
+		if (val >= SG_MAX_QUEUE)
+			break;
+		sg_fill_request_element(sfp, srp, rinfop + val);
+		val++;
+	}
 	spin_unlock_irqrestore(&sfp->rq_list_lock, iflags);
 #ifdef CONFIG_COMPAT
 	if (in_compat_syscall())
-		result = put_compat_request_table(p, rinfo);
+		result = put_compat_request_table(p, rinfop);
 	else
-		result = copy_to_user(p, rinfo,
+		result = copy_to_user(p, rinfop,
 				      SZ_SG_REQ_INFO * SG_MAX_QUEUE);
 #else
-	result = copy_to_user(p, rinfo,
+	result = copy_to_user(p, rinfop,
 			      SZ_SG_REQ_INFO * SG_MAX_QUEUE);
 #endif
-	kfree(rinfo);
+	kfree(rinfop);
 	return result;
 }
 
@@ -1369,7 +1373,7 @@ sg_ioctl_common(struct file *filp, struct sg_device *sdp, struct sg_fd *sfp,
 			return result;
 		sfp->force_packid = val ? 1 : 0;
 		return 0;
-	case SG_GET_PACK_ID:
+	case SG_GET_PACK_ID:    /* or tag of oldest "read"-able, -1 if none */
 		val = -1;
 		spin_lock_irqsave(&sfp->rq_list_lock, iflags);
 		list_for_each_entry(srp, &sfp->rq_list, entry) {
@@ -1745,6 +1749,39 @@ sg_rq_end_io_usercontext(struct work_struct *work)
 	kref_put(&sfp->f_ref, sg_remove_sfp);
 }
 
+static void
+sg_check_sense(struct sg_device *sdp, struct sg_request *srp, int sense_len)
+{
+	int driver_stat;
+	u32 rq_res = srp->rq_result;
+	struct scsi_request *scsi_rp = scsi_req(srp->rq);
+	u8 *sbp = scsi_rp ? scsi_rp->sense : NULL;
+
+	if (!sbp)
+		return;
+	driver_stat = driver_byte(rq_res);
+	if (driver_stat & DRIVER_SENSE) {
+		struct scsi_sense_hdr ssh;
+
+		if (scsi_normalize_sense(sbp, sense_len, &ssh)) {
+			if (!scsi_sense_is_deferred(&ssh)) {
+				if (ssh.sense_key == UNIT_ATTENTION) {
+					if (sdp->device->removable)
+						sdp->device->changed = 1;
+				}
+			}
+		}
+	}
+	if (test_bit(SG_FDEV_LOG_SENSE, sdp->fdev_bm) > 0) {
+		int scsi_stat = rq_res & 0xff;
+
+		if (scsi_stat == SAM_STAT_CHECK_CONDITION ||
+		    scsi_stat == SAM_STAT_COMMAND_TERMINATED)
+			__scsi_print_sense(sdp->device, __func__, sbp,
+					   sense_len);
+	}
+}
+
 /*
  * This function is a "bottom half" handler that is called by the mid
  * level when a command is completed (or has failed).
@@ -1753,13 +1790,13 @@ static void
 sg_rq_end_io(struct request *rq, blk_status_t status)
 {
 	struct sg_request *srp = rq->end_io_data;
-	struct scsi_request *req = scsi_req(rq);
+	struct scsi_request *scsi_rp = scsi_req(rq);
 	struct sg_device *sdp;
 	struct sg_fd *sfp;
 	unsigned long iflags;
 	unsigned int ms;
-	char *sense;
-	int result, resid, done = 1;
+	int resid, slen;
+	int done = 1;
 
 	if (WARN_ON(srp->done != 0))
 		return;
@@ -1772,44 +1809,22 @@ sg_rq_end_io(struct request *rq, blk_status_t status)
 	if (unlikely(SG_IS_DETACHING(sdp)))
 		pr_info("%s: device detaching\n", __func__);
 
-	sense = req->sense;
-	result = req->result;
-	resid = req->resid_len;
+	srp->rq_result = scsi_rp->result;
+	resid = scsi_rp->resid_len;
 
 	srp->header.resid = resid;
+
+	slen = min_t(int, scsi_rp->sense_len, SCSI_SENSE_BUFFERSIZE);
+
 	SG_LOG(6, sfp, "%s: pack_id=%d, res=0x%x\n", __func__,
-	       srp->header.pack_id, result);
+	       srp->header.pack_id, srp->rq_result);
 	ms = jiffies_to_msecs(jiffies);
 	srp->header.duration = (ms > srp->header.duration) ?
 				(ms - srp->header.duration) : 0;
-	if (0 != result) {
-		struct scsi_sense_hdr sshdr;
-
-		srp->header.status = 0xff & result;
-		srp->header.masked_status = status_byte(result);
-		srp->header.msg_status = msg_byte(result);
-		srp->header.host_status = host_byte(result);
-		srp->header.driver_status = driver_byte(result);
-		if (test_bit(SG_FDEV_LOG_SENSE, sdp->fdev_bm) &&
-		    (srp->header.masked_status == CHECK_CONDITION ||
-		     srp->header.masked_status == COMMAND_TERMINATED))
-			__scsi_print_sense(sdp->device, __func__, sense,
-					   SCSI_SENSE_BUFFERSIZE);
-
-		/* Following if statement is a patch supplied by Eric Youngdale */
-		if (driver_byte(result) != 0
-		    && scsi_normalize_sense(sense, SCSI_SENSE_BUFFERSIZE, &sshdr)
-		    && !scsi_sense_is_deferred(&sshdr)
-		    && sshdr.sense_key == UNIT_ATTENTION
-		    && sdp->device->removable) {
-			/* Detected possible disc change. Set the bit - this */
-			/* may be used if there are filesystems using this device */
-			sdp->device->changed = 1;
-		}
-	}
-
-	if (req->sense_len)
-		memcpy(srp->sense_b, req->sense, SCSI_SENSE_BUFFERSIZE);
+	if (srp->rq_result != 0 && slen > 0)
+		sg_check_sense(sdp, srp, slen);
+	if (slen > 0)
+		memcpy(srp->sense_b, scsi_rp->sense, slen);
 
 	/* Rely on write phase to clean out srp status values, so no "else" */
 
@@ -1868,6 +1883,7 @@ static struct class *sg_sysfs_class;
 
 static bool sg_sysfs_valid;
 
+/* Returns valid pointer to sg_device or negated errno twisted by ERR_PTR */
 static struct sg_device *
 sg_add_device_helper(struct gendisk *disk, struct scsi_device *scsidp)
 {
@@ -2079,6 +2095,7 @@ init_sg(void)
 {
 	int rc;
 
+	/* check scatter_elem_sz module parameter, change if inappropriate */
 	if (scatter_elem_sz < (int)PAGE_SIZE)
 		scatter_elem_sz = PAGE_SIZE;
 	else if (scatter_elem_sz != (1 << ilog2(scatter_elem_sz)))
@@ -2093,8 +2110,11 @@ init_sg(void)
 				    SG_MAX_DEVS, "sg");
 	if (rc)
 		return rc;
-        sg_sysfs_class = class_create(THIS_MODULE, "scsi_generic");
-        if ( IS_ERR(sg_sysfs_class) ) {
+	pr_info("Registered %s[char major=0x%x], version: %s, date: %s\n",
+		"sg device ", SCSI_GENERIC_MAJOR, SG_VERSION_STR,
+		sg_version_date);
+	sg_sysfs_class = class_create(THIS_MODULE, "scsi_generic");
+	if (IS_ERR(sg_sysfs_class)) {
 		rc = PTR_ERR(sg_sysfs_class);
 		goto err_out_unreg;
 	}
@@ -2131,6 +2151,18 @@ exit_sg(void)
 	idr_destroy(&sg_index_idr);
 }
 
+static void
+sg_set_map_data(const struct sg_scatter_hold *schp, bool up_valid,
+		struct rq_map_data *mdp)
+{
+	memset(mdp, 0, sizeof(*mdp));
+	mdp->pages = schp->pages;
+	mdp->page_order = schp->page_order;
+	mdp->nr_entries = schp->num_sgat;
+	mdp->offset = 0;
+	mdp->null_mapped = !up_valid;
+}
+
 static int
 sg_start_req(struct sg_request *srp, u8 *cmd)
 {
@@ -2218,15 +2250,8 @@ sg_start_req(struct sg_request *srp, u8 *cmd)
 		}
 		mutex_unlock(&sfp->f_mutex);
 
-		md->pages = req_schp->pages;
-		md->page_order = req_schp->page_order;
-		md->nr_entries = req_schp->num_sgat;
-		md->offset = 0;
-		md->null_mapped = hp->dxferp ? 0 : 1;
-		if (dxfer_dir == SG_DXFER_TO_FROM_DEV)
-			md->from_user = 1;
-		else
-			md->from_user = 0;
+		sg_set_map_data(req_schp, !!hp->dxferp, md);
+		md->from_user = (dxfer_dir == SG_DXFER_TO_FROM_DEV);
 	}
 
 	if (iov_count) {
-- 
2.25.1

