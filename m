Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0559D30490D
	for <lists+linux-scsi@lfdr.de>; Tue, 26 Jan 2021 20:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733159AbhAZF3U (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 26 Jan 2021 00:29:20 -0500
Received: from smtp.infotech.no ([82.134.31.41]:48747 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731769AbhAYTWr (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 25 Jan 2021 14:22:47 -0500
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id CF1322042B8;
        Mon, 25 Jan 2021 20:12:12 +0100 (CET)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 02K22VC4CsAg; Mon, 25 Jan 2021 20:12:10 +0100 (CET)
Received: from xtwo70.bingwo.ca (host-104-157-204-209.dyn.295.ca [104.157.204.209])
        by smtp.infotech.no (Postfix) with ESMTPA id F1CE82042AA;
        Mon, 25 Jan 2021 20:12:08 +0100 (CET)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        kashyap.desai@broadcom.com
Subject: [PATCH v15 34/45] sg: protect multiple receivers
Date:   Mon, 25 Jan 2021 14:11:11 -0500
Message-Id: <20210125191122.345858-35-dgilbert@interlog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210125191122.345858-1-dgilbert@interlog.com>
References: <20210125191122.345858-1-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

If two threads call ioctl(SG_IORECEIVE) [or read()] on the same
file descriptor there is a potential race on the same request
response. Use atomic bit operations to make sure only one thread
gets each request response. [The other thread will either get
another request response or nothing.]

Also make sfp cleanup a bit more robust and report if the
number of submitted requests (which are decremented when
completed) is other than the expected value of zero.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/sg.c | 54 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 16 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index e049628bd575..d992c71a98ca 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -109,6 +109,7 @@ enum sg_rq_state {	/* N.B. sg_rq_state_arr assumes SG_RS_AWAIT_RCV==2 */
 #define SG_FRQ_SYNC_INVOC	2	/* synchronous (blocking) invocation */
 #define SG_FRQ_NO_US_XFER	3	/* no user space transfer of data */
 #define SG_FRQ_DEACT_ORPHAN	6	/* not keeping orphan so de-activate */
+#define SG_FRQ_RECEIVING	7	/* guard against multiple receivers */
 #define SG_FRQ_BLK_PUT_REQ	8	/* set when blk_put_request() called */
 
 /* Bit positions (flags) for sg_fd::ffd_bm bitmask follow */
@@ -1286,6 +1287,7 @@ sg_ctl_ioreceive(struct file *filp, struct sg_fd *sfp, void __user *p)
 	SG_LOG(3, sfp, "%s: non_block(+IMMED)=%d\n", __func__, non_block);
 	/* read in part of v3 or v4 header for pack_id or tag based find */
 	id = pack_id;
+try_again:
 	srp = sg_find_srp_by_id(sfp, id);
 	if (!srp) {     /* nothing available so wait on packet or */
 		if (unlikely(SG_IS_DETACHING(sdp)))
@@ -1300,6 +1302,10 @@ sg_ctl_ioreceive(struct file *filp, struct sg_fd *sfp, void __user *p)
 		if (res)
 			return res;	/* signal --> -ERESTARTSYS */
 	}	/* now srp should be valid */
+	if (test_and_set_bit(SG_FRQ_RECEIVING, srp->frq_bm)) {
+		cpu_relax();
+		goto try_again;
+	}
 	return sg_receive_v4(sfp, srp, p, h4p);
 }
 
@@ -1336,7 +1342,7 @@ sg_ctl_ioreceive_v3(struct file *filp, struct sg_fd *sfp, void __user *p)
 
 	if (test_bit(SG_FFD_FORCE_PACKID, sfp->ffd_bm))
 		pack_id = h3p->pack_id;
-
+try_again:
 	srp = sg_find_srp_by_id(sfp, pack_id);
 	if (!srp) {     /* nothing available so wait on packet or */
 		if (unlikely(SG_IS_DETACHING(sdp)))
@@ -1351,6 +1357,10 @@ sg_ctl_ioreceive_v3(struct file *filp, struct sg_fd *sfp, void __user *p)
 		if (unlikely(res))
 			return res;	/* signal --> -ERESTARTSYS */
 	}	/* now srp should be valid */
+	if (test_and_set_bit(SG_FRQ_RECEIVING, srp->frq_bm)) {
+		cpu_relax();
+		goto try_again;
+	}
 	return sg_receive_v3(sfp, srp, SZ_SG_IO_HDR, p);
 }
 
@@ -1503,6 +1513,7 @@ sg_read(struct file *filp, char __user *p, size_t count, loff_t *ppos)
 			want_id = h2p->pack_id;
 		}
 	}
+try_again:
 	srp = sg_find_srp_by_id(sfp, want_id);
 	if (!srp) {	/* nothing available so wait on packet to arrive or */
 		if (unlikely(SG_IS_DETACHING(sdp)))
@@ -1518,6 +1529,10 @@ sg_read(struct file *filp, char __user *p, size_t count, loff_t *ppos)
 			return ret;
 		/* otherwise srp should be valid */
 	}
+	if (test_and_set_bit(SG_FRQ_RECEIVING, srp->frq_bm)) {
+		cpu_relax();
+		goto try_again;
+	}
 	if (srp->s_hdr3.interface_id == '\0')
 		ret = sg_read_v1v2(p, (int)count, sfp, srp);
 	else
@@ -3044,32 +3059,33 @@ sg_finish_scsi_blk_rq(struct sg_request *srp)
 		atomic_dec(&sfp->submitted);
 		atomic_dec(&sfp->waiting);
 	}
-	if (srp->bio) {
-		bool us_xfer = !test_bit(SG_FRQ_NO_US_XFER, srp->frq_bm);
-
-		if (us_xfer) {
-			ret = blk_rq_unmap_user(srp->bio);
-			if (ret) {	/* -EINTR (-4) can be ignored */
-				SG_LOG(6, sfp,
-				       "%s: blk_rq_unmap_user() --> %d\n",
-				       __func__, ret);
-			}
-		}
-		srp->bio = NULL;
-	}
-	/* In worst case READ data returned to user space by this point */
 
 	/* Expect blk_put_request(rq) already called in sg_rq_end_io() */
 	if (unlikely(!test_and_set_bit(SG_FRQ_BLK_PUT_REQ, srp->frq_bm))) {
 		struct request *rq = srp->rq;
 
+		srp->rq = NULL;
 		if (rq) {       /* blk_get_request() may have failed */
 			if (scsi_req(rq))
 				scsi_req_free_cmd(scsi_req(rq));
-			srp->rq = NULL;
 			blk_put_request(rq);
 		}
 	}
+	if (srp->bio) {
+		bool us_xfer = !test_bit(SG_FRQ_NO_US_XFER, srp->frq_bm);
+		struct bio *bio = srp->bio;
+
+		srp->bio = NULL;
+		if (us_xfer && bio) {
+			ret = blk_rq_unmap_user(bio);
+			if (ret) {	/* -EINTR (-4) can be ignored */
+				SG_LOG(6, sfp,
+				       "%s: blk_rq_unmap_user() --> %d\n",
+				       __func__, ret);
+			}
+		}
+	}
+	/* In worst case, READ data returned to user space by this point */
 }
 
 static int
@@ -3499,6 +3515,7 @@ sg_deact_request(struct sg_fd *sfp, struct sg_request *srp)
 		return;
 	sbp = srp->sense_bp;
 	srp->sense_bp = NULL;
+	srp->frq_bm[0] = 0;
 	sg_rq_state_chg(srp, 0, SG_RS_INACTIVE, true /* force */, __func__);
 	/* maybe orphaned req, thus never read */
 	if (sbp)
@@ -3631,6 +3648,7 @@ static void
 sg_remove_sfp_usercontext(struct work_struct *work)
 {
 	__maybe_unused int o_count;
+	int subm;
 	unsigned long idx, iflags;
 	struct sg_device *sdp;
 	struct sg_fd *sfp = container_of(work, struct sg_fd, ew_fd.work);
@@ -3668,6 +3686,10 @@ sg_remove_sfp_usercontext(struct work_struct *work)
 		SG_LOG(6, sfp, "%s: kfree: srp=%pK --\n", __func__, srp);
 		kfree(srp);
 	}
+	subm = atomic_read(&sfp->submitted);
+	if (subm != 0)
+		SG_LOG(1, sfp, "%s: expected submitted=0 got %d\n",
+		       __func__, subm);
 	xa_destroy(xafp);
 	xa_lock_irqsave(xadp, iflags);
 	e_sfp = __xa_erase(xadp, sfp->idx);
-- 
2.25.1

