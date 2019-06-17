Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 161664785B
	for <lists+linux-scsi@lfdr.de>; Mon, 17 Jun 2019 05:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfFQDFT (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 16 Jun 2019 23:05:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46880 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727464AbfFQDFT (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 16 Jun 2019 23:05:19 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C93AC302454F;
        Mon, 17 Jun 2019 03:05:18 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7214C1001B2E;
        Mon, 17 Jun 2019 03:05:11 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>, Jim Gill <jgill@vmware.com>,
        Cathy Avery <cavery@redhat.com>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Brian King <brking@us.ibm.com>,
        James Smart <james.smart@broadcom.com>,
        "Juergen E . Fischer" <fischer@norbit.de>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-usb@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 05/16] scsi: ipr: use sg helper to operate scatterlist
Date:   Mon, 17 Jun 2019 11:03:38 +0800
Message-Id: <20190617030349.26415-6-ming.lei@redhat.com>
In-Reply-To: <20190617030349.26415-1-ming.lei@redhat.com>
References: <20190617030349.26415-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 17 Jun 2019 03:05:19 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Use the scatterlist iterators and remove direct indexing of the
scatterlist array.

This way allows us to pre-allocate one small scatterlist, which can be
chained with one runtime allocated scatterlist if the pre-allocated one
isn't enough for the whole request.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/ipr.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index 6d053e220153..383603973937 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -3915,22 +3915,22 @@ static int ipr_copy_ucode_buffer(struct ipr_sglist *sglist,
 				 u8 *buffer, u32 len)
 {
 	int bsize_elem, i, result = 0;
-	struct scatterlist *scatterlist;
+	struct scatterlist *sg;
 	void *kaddr;
 
 	/* Determine the actual number of bytes per element */
 	bsize_elem = PAGE_SIZE * (1 << sglist->order);
 
-	scatterlist = sglist->scatterlist;
+	sg = sglist->scatterlist;
 
-	for (i = 0; i < (len / bsize_elem); i++, buffer += bsize_elem) {
-		struct page *page = sg_page(&scatterlist[i]);
+	for (i = 0; i < (len / bsize_elem); i++, sg = sg_next(sg), buffer += bsize_elem) {
+		struct page *page = sg_page(sg);
 
 		kaddr = kmap(page);
 		memcpy(kaddr, buffer, bsize_elem);
 		kunmap(page);
 
-		scatterlist[i].length = bsize_elem;
+		sg->length = bsize_elem;
 
 		if (result != 0) {
 			ipr_trace;
@@ -3939,13 +3939,13 @@ static int ipr_copy_ucode_buffer(struct ipr_sglist *sglist,
 	}
 
 	if (len % bsize_elem) {
-		struct page *page = sg_page(&scatterlist[i]);
+		struct page *page = sg_page(sg);
 
 		kaddr = kmap(page);
 		memcpy(kaddr, buffer, len % bsize_elem);
 		kunmap(page);
 
-		scatterlist[i].length = len % bsize_elem;
+		sg->length = len % bsize_elem;
 	}
 
 	sglist->buffer_len = len;
@@ -3966,6 +3966,7 @@ static void ipr_build_ucode_ioadl64(struct ipr_cmnd *ipr_cmd,
 	struct ipr_ioarcb *ioarcb = &ipr_cmd->ioarcb;
 	struct ipr_ioadl64_desc *ioadl64 = ipr_cmd->i.ioadl64;
 	struct scatterlist *scatterlist = sglist->scatterlist;
+	struct scatterlist *sg;
 	int i;
 
 	ipr_cmd->dma_use_sg = sglist->num_dma_sg;
@@ -3974,10 +3975,10 @@ static void ipr_build_ucode_ioadl64(struct ipr_cmnd *ipr_cmd,
 
 	ioarcb->ioadl_len =
 		cpu_to_be32(sizeof(struct ipr_ioadl64_desc) * ipr_cmd->dma_use_sg);
-	for (i = 0; i < ipr_cmd->dma_use_sg; i++) {
+	for_each_sg(scatterlist, sg, ipr_cmd->dma_use_sg, i) {
 		ioadl64[i].flags = cpu_to_be32(IPR_IOADL_FLAGS_WRITE);
-		ioadl64[i].data_len = cpu_to_be32(sg_dma_len(&scatterlist[i]));
-		ioadl64[i].address = cpu_to_be64(sg_dma_address(&scatterlist[i]));
+		ioadl64[i].data_len = cpu_to_be32(sg_dma_len(sg));
+		ioadl64[i].address = cpu_to_be64(sg_dma_address(sg));
 	}
 
 	ioadl64[i-1].flags |= cpu_to_be32(IPR_IOADL_FLAGS_LAST);
@@ -3997,6 +3998,7 @@ static void ipr_build_ucode_ioadl(struct ipr_cmnd *ipr_cmd,
 	struct ipr_ioarcb *ioarcb = &ipr_cmd->ioarcb;
 	struct ipr_ioadl_desc *ioadl = ipr_cmd->i.ioadl;
 	struct scatterlist *scatterlist = sglist->scatterlist;
+	struct scatterlist *sg;
 	int i;
 
 	ipr_cmd->dma_use_sg = sglist->num_dma_sg;
@@ -4006,11 +4008,11 @@ static void ipr_build_ucode_ioadl(struct ipr_cmnd *ipr_cmd,
 	ioarcb->ioadl_len =
 		cpu_to_be32(sizeof(struct ipr_ioadl_desc) * ipr_cmd->dma_use_sg);
 
-	for (i = 0; i < ipr_cmd->dma_use_sg; i++) {
+	for_each_sg(scatterlist, sg, ipr_cmd->dma_use_sg, i) {
 		ioadl[i].flags_and_data_len =
-			cpu_to_be32(IPR_IOADL_FLAGS_WRITE | sg_dma_len(&scatterlist[i]));
+			cpu_to_be32(IPR_IOADL_FLAGS_WRITE | sg_dma_len(sg));
 		ioadl[i].address =
-			cpu_to_be32(sg_dma_address(&scatterlist[i]));
+			cpu_to_be32(sg_dma_address(sg));
 	}
 
 	ioadl[i-1].flags_and_data_len |=
-- 
2.20.1

