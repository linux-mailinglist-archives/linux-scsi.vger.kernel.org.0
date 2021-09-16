Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C422F40CFA6
	for <lists+linux-scsi@lfdr.de>; Thu, 16 Sep 2021 00:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbhIOWnF (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 15 Sep 2021 18:43:05 -0400
Received: from smtp.infotech.no ([82.134.31.41]:36532 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233086AbhIOWmi (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 15 Sep 2021 18:42:38 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 8B5CF20426C;
        Thu, 16 Sep 2021 00:33:35 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ItI8jbeiH7Da; Thu, 16 Sep 2021 00:33:33 +0200 (CEST)
Received: from xtwo70.bingwo.ca (host-45-78-207-107.dyn.295.ca [45.78.207.107])
        by smtp.infotech.no (Postfix) with ESMTPA id DFAD8204257;
        Thu, 16 Sep 2021 00:33:28 +0200 (CEST)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        Damien.LeMoal@wdc.com
Subject: [PATCH v20 26/46] sg: sense buffer rework
Date:   Wed, 15 Sep 2021 18:32:45 -0400
Message-Id: <20210915223305.256429-27-dgilbert@interlog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210915223305.256429-1-dgilbert@interlog.com>
References: <20210915223305.256429-1-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The biggest single item in the sg_request object is the sense
buffer array which is SCSI_SENSE_BUFFERSIZE bytes long. That
constant started out at 18 bytes 20 years ago and is 96 bytes
now and might grow in the future. On the other hand the sense
buffer is only used by a small number of SCSI commands: those
that fail and those that want to return more information
other than a SCSI status of GOOD.

Set up a small mempool called "sg_sense" that is only used as
required and released back to the mempool as soon as practical.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/sg.c | 118 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 90 insertions(+), 28 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index bb94e4255a7a..c7b73a19b912 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -72,6 +72,10 @@ static char *sg_version_date = "20190606";
  */
 #define SG_MAX_CDB_SIZE 252
 
+static struct kmem_cache *sg_sense_cache;
+#define SG_MEMPOOL_MIN_NR 4
+static mempool_t *sg_sense_pool;
+
 /* Following enum contains the states of sg_request::rq_st */
 enum sg_rq_state {	/* N.B. sg_rq_state_arr assumes SG_RS_AWAIT_RCV==2 */
 	SG_RS_INACTIVE = 0,	/* request not in use (e.g. on fl) */
@@ -173,7 +177,6 @@ struct sg_fd;
 struct sg_request {	/* active SCSI command or inactive request */
 	struct sg_scatter_hold sgat_h;	/* hold buffer, perhaps scatter list */
 	struct sg_slice_hdr3 s_hdr3;  /* subset of sg_io_hdr */
-	u8 sense_b[SCSI_SENSE_BUFFERSIZE];
 	u32 duration;		/* cmd duration in milliseconds */
 	u32 rq_flags;		/* hold user supplied flags */
 	u32 rq_idx;		/* my index within parent's srp_arr */
@@ -186,6 +189,7 @@ struct sg_request {	/* active SCSI command or inactive request */
 	u8 cmd_opcode;		/* first byte of SCSI cdb */
 	u64 start_ns;		/* starting point of command duration calc */
 	unsigned long frq_bm[1];	/* see SG_FRQ_* defines above */
+	u8 *sense_bp;		/* mempool alloc-ed sense buffer, as needed */
 	struct sg_fd *parentfp;	/* pointer to owning fd, even when on fl */
 	struct request *rq;	/* released in sg_rq_end_io(), bio kept */
 	struct bio *bio;	/* kept until this req -->SG_RS_INACTIVE */
@@ -955,21 +959,24 @@ sg_copy_sense(struct sg_request *srp)
 	/* If need be, copy the sense buffer to the user space */
 	scsi_stat = srp->rq_result & 0xff;
 	if ((scsi_stat & SAM_STAT_CHECK_CONDITION) ||
-	    (srp->sense_b[0] & 0x70) == 0x70) {
+	    (srp->sense_bp[0] & 0x70) == 0x70) {
 		int sb_len = min_t(int, SCSI_SENSE_BUFFERSIZE, srp->sense_len);
 		int mx_sb_len = srp->s_hdr3.mx_sb_len;
+		u8 *sbp = srp->sense_bp;
 		void __user *up = srp->s_hdr3.sbp;
 
-		if (up && mx_sb_len > 0) {
+		srp->sense_bp = NULL;
+		if (up && mx_sb_len > 0 && sbp) {
 			sb_len = min_t(int, mx_sb_len, sb_len);
 			/* Additional sense length field */
-			sb_len_ret = 8 + (int)srp->sense_b[7];
+			sb_len_ret = 8 + (int)sbp[7];
 			sb_len_ret = min_t(int, sb_len_ret, sb_len);
-			if (copy_to_user(up, srp->sense_b, sb_len_ret))
+			if (copy_to_user(up, sbp, sb_len_ret))
 				sb_len_ret = -EFAULT;
 		} else {
 			sb_len_ret = 0;
 		}
+		mempool_free(sbp, sg_sense_pool);
 	}
 	return sb_len_ret;
 }
@@ -1059,10 +1066,16 @@ sg_read_v1v2(void __user *buf, int count, struct sg_fd *sfp,
 	h2p->host_status = host_byte(rq_result);
 	h2p->driver_status = driver_byte(rq_result);
 	if ((CHECK_CONDITION & status_byte(rq_result)) ||
-	    (srp->sense_b[0] & 0x70) == 0x70) {
+	    (srp->sense_bp[0] & 0x70) == 0x70) {
 		h2p->driver_status = DRIVER_SENSE;
-		memcpy(h2p->sense_buffer, srp->sense_b,
-		       sizeof(h2p->sense_buffer));
+		if (srp->sense_bp) {
+			u8 *sbp = srp->sense_bp;
+
+			srp->sense_bp = NULL;
+			memcpy(h2p->sense_buffer, sbp,
+			       sizeof(h2p->sense_buffer));
+			mempool_free(sbp, sg_sense_pool);
+		}
 	}
 	switch (host_byte(rq_result)) {
 	/*
@@ -1097,18 +1110,22 @@ sg_read_v1v2(void __user *buf, int count, struct sg_fd *sfp,
 
 	/* Now copy the result back to the user buffer.  */
 	if (count >= SZ_SG_HEADER) {
-		if (copy_to_user(buf, h2p, SZ_SG_HEADER))
-			return -EFAULT;
+		if (copy_to_user(buf, h2p, SZ_SG_HEADER)) {
+			res = -EFAULT;
+			goto fini;
+		}
 		buf += SZ_SG_HEADER;
 		if (count > h2p->reply_len)
 			count = h2p->reply_len;
 		if (count > SZ_SG_HEADER) {
-			if (sg_read_append(srp, buf, count - SZ_SG_HEADER))
-				return -EFAULT;
+			res = sg_read_append(srp, buf, count - SZ_SG_HEADER);
+			if (res)
+				goto fini;
 		}
 	} else {
 		res = (h2p->result == 0) ? 0 : -EIO;
 	}
+fini:
 	atomic_set(&srp->rq_st, SG_RS_RCV_DONE);
 	sg_finish_scsi_blk_rq(srp);
 	sg_deact_request(sfp, srp);
@@ -2016,8 +2033,25 @@ sg_rq_end_io(struct request *rq, blk_status_t status)
 	srp->duration = sg_calc_rq_dur(srp);
 	if (unlikely((srp->rq_result & SG_ML_RESULT_MSK) && slen > 0))
 		sg_check_sense(sdp, srp, slen);
-	if (slen > 0)
-		memcpy(srp->sense_b, scsi_rp->sense, slen);
+	if (slen > 0) {
+		if (scsi_rp->sense) {
+			srp->sense_bp = mempool_alloc(sg_sense_pool,
+						      GFP_ATOMIC);
+			if (srp->sense_bp) {
+				memcpy(srp->sense_bp, scsi_rp->sense, slen);
+				if (slen < SCSI_SENSE_BUFFERSIZE)
+					memset(srp->sense_bp + slen, 0,
+					       SCSI_SENSE_BUFFERSIZE - slen);
+			} else {
+				slen = 0;
+				pr_warn("%s: sense but can't alloc buffer\n",
+					__func__);
+			}
+		} else {
+			slen = 0;
+			pr_warn("%s: sense_len>0 but sense==NULL\n", __func__);
+		}
+	}
 	srp->sense_len = slen;
 	if (unlikely(test_bit(SG_FRQ_IS_ORPHAN, srp->frq_bm))) {
 		if (test_bit(SG_FFD_KEEP_ORPHAN, sfp->ffd_bm)) {
@@ -2293,13 +2327,30 @@ init_sg(void)
 	if (rc)
 		return rc;
 
+	sg_sense_cache = kmem_cache_create_usercopy
+				("sg_sense", SCSI_SENSE_BUFFERSIZE, 0,
+				 SLAB_HWCACHE_ALIGN, 0,
+				 SCSI_SENSE_BUFFERSIZE, NULL);
+	if (!sg_sense_cache) {
+		pr_err("sg: can't init sense cache\n");
+		rc = -ENOMEM;
+		goto err_out_unreg;
+	}
+	sg_sense_pool = mempool_create_slab_pool(SG_MEMPOOL_MIN_NR,
+						 sg_sense_cache);
+	if (!sg_sense_pool) {
+		pr_err("sg: can't init sense pool\n");
+		rc = -ENOMEM;
+		goto err_out_cache;
+	}
+
 	pr_info("Registered %s[char major=0x%x], version: %s, date: %s\n",
 		"sg device ", SCSI_GENERIC_MAJOR, SG_VERSION_STR,
 		sg_version_date);
 	sg_sysfs_class = class_create(THIS_MODULE, "scsi_generic");
 	if (IS_ERR(sg_sysfs_class)) {
 		rc = PTR_ERR(sg_sysfs_class);
-		goto err_out_unreg;
+		goto err_out_pool;
 	}
 	sg_sysfs_valid = true;
 	rc = scsi_register_interface(&sg_interface);
@@ -2309,6 +2360,10 @@ init_sg(void)
 	}
 	class_destroy(sg_sysfs_class);
 
+err_out_pool:
+	mempool_destroy(sg_sense_pool);
+err_out_cache:
+	kmem_cache_destroy(sg_sense_cache);
 err_out_unreg:
 	unregister_chrdev_region(MKDEV(SCSI_GENERIC_MAJOR, 0), SG_MAX_DEVS);
 	return rc;
@@ -2328,6 +2383,8 @@ exit_sg(void)
 	if (IS_ENABLED(CONFIG_SCSI_PROC_FS))
 		remove_proc_subtree("scsi/sg", NULL);
 	scsi_unregister_interface(&sg_interface);
+	mempool_destroy(sg_sense_pool);
+	kmem_cache_destroy(sg_sense_cache);
 	class_destroy(sg_sysfs_class);
 	sg_sysfs_valid = false;
 	unregister_chrdev_region(MKDEV(SCSI_GENERIC_MAJOR, 0),
@@ -2843,6 +2900,7 @@ sg_setup_req(struct sg_fd *sfp, int dxfr_len, struct sg_comm_wr_t *cwrp)
 	int num_inactive = 0;
 	unsigned long idx, last_idx, iflags;
 	struct sg_request *r_srp = NULL;	/* request to return */
+	struct sg_request *last_srp = NULL;
 	struct xarray *xafp = &sfp->srp_arr;
 	__maybe_unused const char *cp;
 
@@ -2859,19 +2917,17 @@ sg_setup_req(struct sg_fd *sfp, int dxfr_len, struct sg_comm_wr_t *cwrp)
 			++num_inactive;
 			if (dxfr_len < SG_DEF_SECTOR_SZ) {
 				last_idx = idx;
+				last_srp = r_srp;
 				continue;
 			}
 		}
 		/* If dxfr_len is small, use last inactive request */
-		if (last_idx != ~0UL) {
-			idx = last_idx;
-			r_srp = xa_load(xafp, idx);
-			if (!r_srp)
-				goto start_again;
+		if (last_idx != ~0UL && last_srp) {
+			r_srp = last_srp;
 			if (sg_rq_state_chg(r_srp, SG_RS_INACTIVE, SG_RS_BUSY,
 					    false, __func__))
 				goto start_again; /* gone to another thread */
-			cp = "toward back of srp_arr";
+			cp = "toward end of srp_arr";
 			found = true;
 		}
 	} else {
@@ -2956,15 +3012,16 @@ sg_setup_req(struct sg_fd *sfp, int dxfr_len, struct sg_comm_wr_t *cwrp)
 static void
 sg_deact_request(struct sg_fd *sfp, struct sg_request *srp)
 {
-	unsigned long iflags;
+	u8 *sbp;
 
 	if (WARN_ON(!sfp || !srp))
 		return;
-	atomic_set(&srp->rq_st, SG_RS_INACTIVE);
-	xa_lock_irqsave(&sfp->srp_arr, iflags);
-	__xa_set_mark(&sfp->srp_arr, srp->rq_idx, SG_XA_RQ_INACTIVE);
-	__xa_clear_mark(&sfp->srp_arr, srp->rq_idx, SG_XA_RQ_AWAIT);
-	xa_unlock_irqrestore(&sfp->srp_arr, iflags);
+	sbp = srp->sense_bp;
+	srp->sense_bp = NULL;
+	sg_rq_state_chg(srp, 0, SG_RS_INACTIVE, true /* force */, __func__);
+	/* maybe orphaned req, thus never read */
+	if (sbp)
+		mempool_free(sbp, sg_sense_pool);
 }
 
 /* Returns pointer to sg_fd object or negated errno twisted by ERR_PTR */
@@ -3113,7 +3170,12 @@ sg_remove_sfp_usercontext(struct work_struct *work)
 			continue;
 		if (!xa_get_mark(xafp, srp->rq_idx, SG_XA_RQ_INACTIVE))
 			sg_finish_scsi_blk_rq(srp);
-		sg_remove_sgat(srp);
+		if (srp->sgat_h.buflen > 0)
+			sg_remove_sgat(srp);
+		if (srp->sense_bp) {
+			mempool_free(srp->sense_bp, sg_sense_pool);
+			srp->sense_bp = NULL;
+		}
 		xa_lock_irqsave(xafp, iflags);
 		e_srp = __xa_erase(xafp, srp->rq_idx);
 		xa_unlock_irqrestore(xafp, iflags);
-- 
2.25.1

