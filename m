Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30CDBA0F86
	for <lists+linux-scsi@lfdr.de>; Thu, 29 Aug 2019 04:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfH2C10 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 28 Aug 2019 22:27:26 -0400
Received: from smtp.infotech.no ([82.134.31.41]:40094 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727216AbfH2C10 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 28 Aug 2019 22:27:26 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id C5C2E20426D;
        Thu, 29 Aug 2019 04:27:24 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QHpkBbm4fcf1; Thu, 29 Aug 2019 04:27:22 +0200 (CEST)
Received: from xtwo70.bingwo.ca (host-23-251-188-50.dyn.295.ca [23.251.188.50])
        by smtp.infotech.no (Postfix) with ESMTPA id C055E204248;
        Thu, 29 Aug 2019 04:27:21 +0200 (CEST)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        bvanassche@acm.org, hch@infradead.org
Subject: [PATCH v4 12/22] sg: sense buffer rework
Date:   Wed, 28 Aug 2019 22:26:49 -0400
Message-Id: <20190829022659.23130-13-dgilbert@interlog.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190829022659.23130-1-dgilbert@interlog.com>
References: <20190829022659.23130-1-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
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

Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/sg.c | 86 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 73 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 2e476e74130b..ebb9d4f53177 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -72,6 +72,10 @@ static char *sg_version_date = "20190606";
  */
 #define SG_MAX_CDB_SIZE 252
 
+static struct kmem_cache *sg_sense_cache;
+#define SG_MEMPOOL_MIN_NR 4
+static mempool_t *sg_sense_pool;
+
 #define uptr64(val) ((void __user *)(uintptr_t)(val))
 #define cuptr64(val) ((const void __user *)(uintptr_t)(val))
 
@@ -176,7 +180,6 @@ struct sg_request {	/* active SCSI command or inactive on free list (fl) */
 	spinlock_t req_lck;
 	struct sg_scatter_hold sgat_h;	/* hold buffer, perhaps scatter list */
 	struct sg_slice_hdr3 s_hdr3;  /* subset of sg_io_hdr */
-	u8 sense_b[SCSI_SENSE_BUFFERSIZE];
 	u32 duration;		/* cmd duration in milliseconds */
 	u32 rq_flags;		/* hold user supplied flags */
 	u32 rq_info;		/* info supplied by v3 and v4 interfaces */
@@ -188,6 +191,7 @@ struct sg_request {	/* active SCSI command or inactive on free list (fl) */
 	u8 cmd_opcode;		/* first byte of SCSI cdb */
 	u64 start_ns;		/* starting point of command duration calc */
 	unsigned long frq_bm[1];	/* see SG_FRQ_* defines above */
+	u8 *sense_bp;		/* mempool alloc-ed sense buffer, as needed */
 	struct sg_fd *parentfp;	/* pointer to owning fd, even when on fl */
 	struct request *rq;	/* released in sg_rq_end_io(), bio kept */
 	struct bio *bio;	/* kept until this req -->SG_RS_INACTIVE */
@@ -845,18 +849,21 @@ sg_copy_sense(struct sg_request *srp)
 	    (driver_byte(srp->rq_result) & DRIVER_SENSE)) {
 		int sb_len = min_t(int, SCSI_SENSE_BUFFERSIZE, srp->sense_len);
 		int mx_sb_len;
+		u8 *sbp = srp->sense_bp;
 		void __user *up;
 
+		srp->sense_bp = NULL;
 		up = (void __user *)srp->s_hdr3.sbp;
 		mx_sb_len = srp->s_hdr3.mx_sb_len;
-		if (up && mx_sb_len > 0) {
+		if (up && mx_sb_len > 0 && sbp) {
 			sb_len = min_t(int, sb_len, mx_sb_len);
 			/* Additional sense length field */
-			sb_len_wr = 8 + (int)srp->sense_b[7];
+			sb_len_wr = 8 + (int)sbp[7];
 			sb_len_wr = min_t(int, sb_len, sb_len_wr);
-			if (copy_to_user(up, srp->sense_b, sb_len_wr))
+			if (copy_to_user(up, sbp, sb_len_wr))
 				sb_len_wr = -EFAULT;
 		}
+		mempool_free(sbp, sg_sense_pool);
 	}
 	return sb_len_wr;
 }
@@ -963,8 +970,14 @@ sg_rd_v1v2(void __user *buf, int count, struct sg_fd *sfp,
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
@@ -999,17 +1012,21 @@ sg_rd_v1v2(void __user *buf, int count, struct sg_fd *sfp,
 
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
-			if (sg_rd_append(srp, buf, count - SZ_SG_HEADER))
-				return -EFAULT;
+			res = sg_rd_append(srp, buf, count - SZ_SG_HEADER);
+			if (res)
+				goto fini;
 		}
 	} else
 		res = (h2p->result == 0) ? 0 : -EIO;
+fini:
 	atomic_set(&srp->rq_st, SG_RS_DONE_RD);
 	sg_finish_scsi_blk_rq(srp);
 	sg_deact_request(sfp, srp);
@@ -1971,8 +1988,17 @@ sg_rq_end_io(struct request *rq, blk_status_t status)
 	srp->duration = sg_calc_rq_dur(srp);
 	if (unlikely((srp->rq_result & SG_ML_RESULT_MSK) && slen > 0))
 		sg_check_sense(sdp, srp, slen);
-	if (slen > 0)
-		memcpy(srp->sense_b, scsi_rp->sense, slen);
+	if (slen > 0) {
+		if (scsi_rp->sense) {
+			srp->sense_bp = mempool_alloc(sg_sense_pool,
+						      GFP_ATOMIC);
+			if (srp->sense_bp)
+				memcpy(srp->sense_bp, scsi_rp->sense, slen);
+		} else {
+			pr_warn("%s: scsi_request::sense==NULL\n", __func__);
+			slen = 0;
+		}
+	}
 	srp->sense_len = slen;
 	if (unlikely(test_bit(SG_FRQ_IS_ORPHAN, srp->frq_bm))) {
 		spin_lock(&srp->req_lck);
@@ -2262,13 +2288,28 @@ init_sg(void)
 	if (rc)
 		return rc;
 
+	sg_sense_cache = kmem_cache_create("sg_sense", SCSI_SENSE_BUFFERSIZE,
+					   0, 0, NULL);
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
@@ -2278,6 +2319,10 @@ init_sg(void)
 	}
 	class_destroy(sg_sysfs_class);
 
+err_out_pool:
+	mempool_destroy(sg_sense_pool);
+err_out_cache:
+	kmem_cache_destroy(sg_sense_cache);
 err_out_unreg:
 	unregister_chrdev_region(MKDEV(SCSI_GENERIC_MAJOR, 0), SG_MAX_DEVS);
 	return rc;
@@ -2297,6 +2342,8 @@ exit_sg(void)
 	if (IS_ENABLED(CONFIG_SCSI_PROC_FS))
 		remove_proc_subtree("scsi/sg", NULL);
 	scsi_unregister_interface(&sg_interface);
+	mempool_destroy(sg_sense_pool);
+	kmem_cache_destroy(sg_sense_cache);
 	class_destroy(sg_sysfs_class);
 	sg_sysfs_valid = 0;
 	unregister_chrdev_region(MKDEV(SCSI_GENERIC_MAJOR, 0),
@@ -2934,6 +2981,7 @@ sg_deact_request(struct sg_fd *sfp, struct sg_request *srp)
 	bool on_fl = false;
 	int dlen, buflen;
 	unsigned long iflags;
+	u8 *sbp;
 	struct sg_request *t_srp;
 	struct sg_scatter_hold *schp;
 	const char *cp = "head";
@@ -2942,8 +2990,12 @@ sg_deact_request(struct sg_fd *sfp, struct sg_request *srp)
 		return;
 	schp = &srp->sgat_h;	/* make sure it is own data buffer */
 	spin_lock_irqsave(&sfp->rq_list_lock, iflags);
+	sbp = srp->sense_bp;
+	srp->sense_bp = NULL;
 	atomic_set(&srp->rq_st, SG_RS_BUSY);
 	list_del_rcu(&srp->rq_entry);
+	/* maybe orphaned req, thus never read */
+	mempool_free(sbp, sg_sense_pool);
 	/*
 	 * N.B. sg_request object is not de-allocated (freed). The contents
 	 * of the rq_list and rq_fl lists are de-allocated (freed) when
@@ -3086,6 +3138,10 @@ sg_remove_sfp_usercontext(struct work_struct *work)
 		list_del(&srp->rq_entry);
 		if (srp->sgat_h.buflen > 0)
 			sg_remove_sgat(srp);
+		if (srp->sense_bp) {
+			mempool_free(srp->sense_bp, sg_sense_pool);
+			srp->sense_bp = NULL;
+		}
 		SG_LOG(6, sfp, "%s:%s%p --\n", __func__, cp, srp);
 		kfree(srp);
 	}
@@ -3097,6 +3153,10 @@ sg_remove_sfp_usercontext(struct work_struct *work)
 		list_del(&srp->fl_entry);
 		if (srp->sgat_h.buflen > 0)
 			sg_remove_sgat(srp);
+		if (srp->sense_bp) {
+			mempool_free(srp->sense_bp, sg_sense_pool);
+			srp->sense_bp = NULL;
+		}
 		SG_LOG(6, sfp, "%s: fl%s%p --\n", __func__, cp, srp);
 		kfree(srp);
 	}
-- 
2.23.0

