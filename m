Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943B328EAE8
	for <lists+linux-scsi@lfdr.de>; Thu, 15 Oct 2020 04:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389514AbgJOCH4 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 14 Oct 2020 22:07:56 -0400
Received: from smtp.infotech.no ([82.134.31.41]:40278 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732555AbgJOCHp (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 14 Oct 2020 22:07:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 2DDF720423F;
        Thu, 15 Oct 2020 04:07:41 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Sr-h4XW6eyJk; Thu, 15 Oct 2020 04:07:39 +0200 (CEST)
Received: from xtwo70.bingwo.ca (host-104-157-204-209.dyn.295.ca [104.157.204.209])
        by smtp.infotech.no (Postfix) with ESMTPA id 3E81B204248;
        Thu, 15 Oct 2020 04:07:33 +0200 (CEST)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de
Subject: [PATCH v11 43/44] sg: no_dxfer: move to/from kernel buffers
Date:   Wed, 14 Oct 2020 22:06:42 -0400
Message-Id: <20201015020643.432908-44-dgilbert@interlog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201015020643.432908-1-dgilbert@interlog.com>
References: <20201015020643.432908-1-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

When the NO_DXFER flag is use on a command/request, the data-in
and data-out buffers (if present) should not be ignored. Add
sg_rq_map_kern() function to handle this. Uses a single bio with
multiple bvec_s usually each holding multiple pages, if necessary.
The driver default element size is 32 KiB so if PAGE_SIZE is 4096
then get_order()==3 .

Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/sg.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 75c29d0bceef..770e8c1ef53e 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -2865,6 +2865,63 @@ exit_sg(void)
 	idr_destroy(&sg_index_idr);
 }
 
+static struct bio *
+sg_mk_kern_bio(int bvec_cnt)
+{
+	struct bio *biop;
+
+	if (bvec_cnt > BIO_MAX_PAGES)
+		return NULL;
+	biop = bio_alloc(GFP_ATOMIC, bvec_cnt);
+	if (!biop)
+		return NULL;
+	biop->bi_end_io = bio_put;
+	return biop;
+}
+
+/*
+ * Setup to move data between kernel buffers managed by this driver and a SCSI device. Note that
+ * there is no corresponding 'unmap' call as is required by blk_rq_map_user() . Uses a single
+ * bio with an expanded appended bvec if necessary.
+ */
+static int
+sg_rq_map_kern(struct sg_request *srp, struct request_queue *q, struct request *rqq, int rw_ind)
+{
+	struct sg_scatter_hold *schp = &srp->sgat_h;
+	struct bio *bio;
+	int k, ln;
+	int op_flags = 0;
+	int num_sgat = schp->num_sgat;
+	int dlen = schp->dlen;
+	int pg_sz = 1 << (PAGE_SHIFT + schp->page_order);
+	int num_segs = (1 << schp->page_order) * num_sgat;
+	int res = 0;
+
+	SG_LOG(4, srp->parentfp, "%s: dlen=%d, pg_sz=%d\n", __func__, dlen, pg_sz);
+	if (num_sgat <= 0)
+		return 0;
+	if (rw_ind == WRITE)
+		op_flags = REQ_SYNC | REQ_IDLE;
+	bio = sg_mk_kern_bio(num_sgat - k);
+	if (!bio)
+		return -ENOMEM;
+	bio->bi_opf = req_op(rqq) | op_flags;
+
+	for (k = 0; k < num_sgat && dlen > 0; ++k, dlen -= ln) {
+		ln = min_t(int, dlen, pg_sz);
+		if (bio_add_pc_page(q, bio, schp->pages[k], ln, 0) < ln) {
+			bio_put(bio);
+			return -EINVAL;
+		}
+	}
+	res = blk_rq_append_bio(rqq, &bio);
+	if (unlikely(res))
+		bio_put(bio);
+	else
+		rqq->nr_phys_segments = num_segs;
+	return res;
+}
+
 static inline void
 sg_set_map_data(const struct sg_scatter_hold *schp, bool up_valid,
 		struct rq_map_data *mdp)
@@ -3036,6 +3093,8 @@ sg_start_req(struct sg_request *srp, struct sg_comm_wr_t *cwrp, int dxfer_dir)
 		if (IS_ENABLED(CONFIG_SCSI_PROC_FS) && res)
 			SG_LOG(1, sfp, "%s: blk_rq_map_user() res=%d\n",
 			       __func__, res);
+	} else {	/* transfer data to/from kernel buffers */
+		res = sg_rq_map_kern(srp, q, rq, r0w);
 	}
 fini:
 	if (unlikely(res)) {		/* failure, free up resources */
-- 
2.25.1

