Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D968436CE22
	for <lists+linux-scsi@lfdr.de>; Tue, 27 Apr 2021 23:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239363AbhD0V7J (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 27 Apr 2021 17:59:09 -0400
Received: from smtp.infotech.no ([82.134.31.41]:38843 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239377AbhD0V7C (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 27 Apr 2021 17:59:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 05D6520426F;
        Tue, 27 Apr 2021 23:58:16 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GL+SGTVoIpp1; Tue, 27 Apr 2021 23:58:13 +0200 (CEST)
Received: from xtwo70.bingwo.ca (host-45-58-219-4.dyn.295.ca [45.58.219.4])
        by smtp.infotech.no (Postfix) with ESMTPA id 4CA6920424C;
        Tue, 27 Apr 2021 23:58:10 +0200 (CEST)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de
Subject: [PATCH v18 26/83] sg: sense buffer rework
Date:   Tue, 27 Apr 2021 17:56:36 -0400
Message-Id: <20210427215733.417746-28-dgilbert@interlog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210427215733.417746-1-dgilbert@interlog.com>
References: <20210427215733.417746-1-dgilbert@interlog.com>
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
 drivers/scsi/sg.c | 114 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 88 insertions(+), 26 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 6df7aa81349b..2baebe33b05d 100644
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
@@ -957,18 +961,21 @@ sg_copy_sense(struct sg_request *srp)
 	    (driver_byte(srp->rq_result) & DRIVER_SENSE)) {
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
@@ -1059,8 +1066,14 @@ sg_read_v1v2(void __user *buf, int count, struct sg_fd *sfp,
 	h2p->driver_status = driver_byte(rq_result);
 	if ((CHECK_CONDITION & status_byte(rq_result)) ||
 	    (DRIVER_SENSE & driver_byte(rq_result))) {
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
@@ -1095,18 +1108,22 @@ sg_read_v1v2(void __user *buf, int count, struct sg_fd *sfp,
 
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
@@ -2088,8 +2105,25 @@ sg_rq_end_io(struct request *rq, blk_status_t status)
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
@@ -2378,13 +2412,30 @@ init_sg(void)
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
@@ -2394,6 +2445,10 @@ init_sg(void)
 	}
 	class_destroy(sg_sysfs_class);
 
+err_out_pool:
+	mempool_destroy(sg_sense_pool);
+err_out_cache:
+	kmem_cache_destroy(sg_sense_cache);
 err_out_unreg:
 	unregister_chrdev_region(MKDEV(SCSI_GENERIC_MAJOR, 0), SG_MAX_DEVS);
 	return rc;
@@ -2413,6 +2468,8 @@ exit_sg(void)
 	if (IS_ENABLED(CONFIG_SCSI_PROC_FS))
 		remove_proc_subtree("scsi/sg", NULL);
 	scsi_unregister_interface(&sg_interface);
+	mempool_destroy(sg_sense_pool);
+	kmem_cache_destroy(sg_sense_cache);
 	class_destroy(sg_sysfs_class);
 	sg_sysfs_valid = false;
 	unregister_chrdev_region(MKDEV(SCSI_GENERIC_MAJOR, 0),
@@ -2935,6 +2992,7 @@ sg_setup_req(struct sg_fd *sfp, int dxfr_len, struct sg_comm_wr_t *cwrp)
 	int num_inactive = 0;
 	unsigned long idx, last_idx, iflags;
 	struct sg_request *r_srp = NULL;	/* request to return */
+	struct sg_request *last_srp = NULL;
 	struct xarray *xafp = &sfp->srp_arr;
 	__maybe_unused const char *cp;
 
@@ -2951,19 +3009,17 @@ sg_setup_req(struct sg_fd *sfp, int dxfr_len, struct sg_comm_wr_t *cwrp)
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
@@ -3048,15 +3104,16 @@ sg_setup_req(struct sg_fd *sfp, int dxfr_len, struct sg_comm_wr_t *cwrp)
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
@@ -3205,7 +3262,12 @@ sg_remove_sfp_usercontext(struct work_struct *work)
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

