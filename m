Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9E338DEA3
	for <lists+linux-scsi@lfdr.de>; Mon, 24 May 2021 03:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbhEXBDr (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 23 May 2021 21:03:47 -0400
Received: from smtp.infotech.no ([82.134.31.41]:33143 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232159AbhEXBDn (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 23 May 2021 21:03:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 33EB5204279;
        Mon, 24 May 2021 03:02:15 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id STFD4pFQCg57; Mon, 24 May 2021 03:02:13 +0200 (CEST)
Received: from xtwo70.bingwo.ca (host-45-58-219-4.dyn.295.ca [45.58.219.4])
        by smtp.infotech.no (Postfix) with ESMTPA id 3CC3120426F;
        Mon, 24 May 2021 03:02:09 +0200 (CEST)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de
Subject: [PATCH v19 16/45] sg: rework sg_mmap
Date:   Sun, 23 May 2021 21:01:18 -0400
Message-Id: <20210524010147.94845-17-dgilbert@interlog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210524010147.94845-1-dgilbert@interlog.com>
References: <20210524010147.94845-1-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Simple rework of the sg_mmap() function.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/sg.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index aa3202cbf3a1..4d13cd28a60c 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1488,14 +1488,15 @@ static const struct vm_operations_struct sg_mmap_vm_ops = {
 	.fault = sg_vma_fault,
 };
 
+/* Entry point for mmap(2) system call */
 static int
 sg_mmap(struct file *filp, struct vm_area_struct *vma)
 {
-	struct sg_fd *sfp;
-	unsigned long req_sz, len, sa;
-	struct sg_scatter_hold *rsv_schp;
 	int k, length;
 	int ret = 0;
+	unsigned long req_sz, len, sa;
+	struct sg_scatter_hold *rsv_schp;
+	struct sg_fd *sfp;
 
 	if (!filp || !vma)
 		return -ENXIO;
@@ -1508,19 +1509,23 @@ sg_mmap(struct file *filp, struct vm_area_struct *vma)
 	SG_LOG(3, sfp, "%s: vm_start=%p, len=%d\n", __func__,
 	       (void *)vma->vm_start, (int)req_sz);
 	if (vma->vm_pgoff)
-		return -EINVAL;	/* want no offset */
-	rsv_schp = &sfp->reserve;
+		return -EINVAL; /* only an offset of 0 accepted */
+	/* Check reserve request is inactive and has large enough buffer */
 	mutex_lock(&sfp->f_mutex);
-	if (req_sz > rsv_schp->buflen) {
-		ret = -ENOMEM;	/* cannot map more than reserved buffer */
+	if (sfp->res_in_use) {
+		ret = -EBUSY;
+		goto out;
+	}
+	rsv_schp = &sfp->reserve;
+	if (req_sz > (unsigned long)rsv_schp->buflen) {
+		ret = -ENOMEM;
 		goto out;
 	}
-
 	sa = vma->vm_start;
 	length = 1 << (PAGE_SHIFT + rsv_schp->page_order);
-	for (k = 0; k < rsv_schp->num_sgat && sa < vma->vm_end; k++) {
+	for (k = 0; k < rsv_schp->num_sgat && sa < vma->vm_end; ++k) {
 		len = vma->vm_end - sa;
-		len = (len < length) ? len : length;
+		len = min_t(unsigned long, len, (unsigned long)length);
 		sa += len;
 	}
 
-- 
2.25.1

