Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C789240CF92
	for <lists+linux-scsi@lfdr.de>; Thu, 16 Sep 2021 00:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbhIOWmh (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 15 Sep 2021 18:42:37 -0400
Received: from smtp.infotech.no ([82.134.31.41]:36529 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232477AbhIOWmb (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 15 Sep 2021 18:42:31 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 4961720423A;
        Thu, 16 Sep 2021 00:33:49 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id r6oJ+9ySfpR5; Thu, 16 Sep 2021 00:33:47 +0200 (CEST)
Received: from xtwo70.bingwo.ca (host-45-78-207-107.dyn.295.ca [45.78.207.107])
        by smtp.infotech.no (Postfix) with ESMTPA id 711DB204274;
        Thu, 16 Sep 2021 00:33:41 +0200 (CEST)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        Damien.LeMoal@wdc.com
Subject: [PATCH v20 37/46] sg: defang allow_dio
Date:   Wed, 15 Sep 2021 18:32:56 -0400
Message-Id: <20210915223305.256429-38-dgilbert@interlog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210915223305.256429-1-dgilbert@interlog.com>
References: <20210915223305.256429-1-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Before direct IO was permitted by this driver, the user either had
to give 'allow_dio=1' as a module parameter or write to procfs
with 'echo 1 > /proc/scsi/sg/allow_dio'. The user also needs
to set the SG_FLAG_DIRECT_IO flag in the flags field of either
the sg v3 or v3 interface. The reason this "belts and braces"
approach was taken is lost in the mists of time (done over 20
years ago). So this patch keeps the allow_dio attribute for
backward compatibility but ignores it, relying on the
SG_FLAG_DIRECT_IO flag alone. This brings the use of the
SG_FLAG_DIRECT_IO flag into line with the SG_FLAG_MMAP_IO
flag; the two mechanisms are no more, or less, safe than one
another in recent Linux kernels.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/sg.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index c1a8305b56b7..806bb950cc8a 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -141,7 +141,7 @@ int sg_big_buff = SG_DEF_RESERVED_SIZE;
  * not enough memory) will be reserved for use by this file descriptor.
  */
 static int def_reserved_size = -1;	/* picks up init parameter */
-static int sg_allow_dio = SG_ALLOW_DIO_DEF;
+static int sg_allow_dio = SG_ALLOW_DIO_DEF;	/* ignored by code */
 
 static int scatter_elem_sz = SG_SCATTER_SZ;
 
@@ -2761,17 +2761,6 @@ exit_sg(void)
 	idr_destroy(&sg_index_idr);
 }
 
-static inline bool
-sg_chk_dio_allowed(struct sg_device *sdp, struct sg_request *srp,
-		   int iov_count, int dir)
-{
-	if (sg_allow_dio && (srp->rq_flags & SG_FLAG_DIRECT_IO)) {
-		if (dir != SG_DXFER_UNKNOWN && !iov_count)
-			return true;
-	}
-	return false;
-}
-
 static inline void
 sg_set_map_data(const struct sg_scatter_hold *schp, bool up_valid,
 		struct rq_map_data *mdp)
@@ -2790,6 +2779,7 @@ sg_start_req(struct sg_request *srp, struct sg_comm_wr_t *cwrp, int dxfer_dir)
 	int res = 0;
 	int dxfer_len = 0;
 	int r0w = READ;
+	u32 rq_flags = srp->rq_flags;
 	unsigned int iov_count = 0;
 	void __user *up;
 	struct request *rq;
@@ -2868,7 +2858,7 @@ sg_start_req(struct sg_request *srp, struct sg_comm_wr_t *cwrp, int dxfer_dir)
 		goto fini;
 	scsi_rp->cmd_len = cwrp->cmd_len;
 	srp->cmd_opcode = scsi_rp->cmd[0];
-	us_xfer = !(srp->rq_flags & (SG_FLAG_NO_DXFER | SG_FLAG_MMAP_IO));
+	us_xfer = !(rq_flags & (SG_FLAG_NO_DXFER | SG_FLAG_MMAP_IO));
 	assign_bit(SG_FRQ_NO_US_XFER, srp->frq_bm, !us_xfer);
 	reserved = (sfp->rsv_srp == srp);
 	rq->end_io_data = srp;
@@ -2879,7 +2869,7 @@ sg_start_req(struct sg_request *srp, struct sg_comm_wr_t *cwrp, int dxfer_dir)
 		SG_LOG(4, sfp, "%s: no data xfer [0x%pK]\n", __func__, srp);
 		set_bit(SG_FRQ_NO_US_XFER, srp->frq_bm);
 		goto fini;	/* path of reqs with no din nor dout */
-	} else if (sg_chk_dio_allowed(sdp, srp, iov_count, dxfer_dir) &&
+	} else if ((rq_flags & SG_FLAG_DIRECT_IO) && iov_count == 0 &&
 		   blk_rq_aligned(q, (unsigned long)up, dxfer_len)) {
 		srp->rq_info |= SG_INFO_DIRECT_IO;
 		md = NULL;
@@ -2890,7 +2880,7 @@ sg_start_req(struct sg_request *srp, struct sg_comm_wr_t *cwrp, int dxfer_dir)
 	}
 
 	if (likely(md)) {	/* normal, "indirect" IO */
-		if (unlikely(srp->rq_flags & SG_FLAG_MMAP_IO)) {
+		if (unlikely(rq_flags & SG_FLAG_MMAP_IO)) {
 			/* mmap IO must use and fit in reserve request */
 			if (!reserved || dxfer_len > req_schp->buflen)
 				res = reserved ? -ENOMEM : -EBUSY;
@@ -3770,6 +3760,7 @@ sg_proc_single_open_adio(struct inode *inode, struct file *filp)
 	return single_open(filp, sg_proc_seq_show_int, &sg_allow_dio);
 }
 
+/* Kept for backward compatibility. sg_allow_dio is now ignored. */
 static ssize_t
 sg_proc_write_adio(struct file *filp, const char __user *buffer,
 		   size_t count, loff_t *off)
@@ -4390,6 +4381,6 @@ MODULE_ALIAS_CHARDEV_MAJOR(SCSI_GENERIC_MAJOR);
 
 MODULE_PARM_DESC(scatter_elem_sz, "scatter gather element size (default: max(SG_SCATTER_SZ, PAGE_SIZE))");
 MODULE_PARM_DESC(def_reserved_size, "size of buffer reserved for each fd");
-MODULE_PARM_DESC(allow_dio, "allow direct I/O (default: 0 (disallow))");
+MODULE_PARM_DESC(allow_dio, "allow direct I/O (default: 0 (disallow)); now ignored");
 module_init(init_sg);
 module_exit(exit_sg);
-- 
2.25.1

