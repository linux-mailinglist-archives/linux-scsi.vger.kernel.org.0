Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 548224447C
	for <lists+linux-scsi@lfdr.de>; Thu, 13 Jun 2019 18:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730719AbfFMQh1 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 13 Jun 2019 12:37:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47724 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730648AbfFMHOW (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 13 Jun 2019 03:14:22 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6C4772E95AF;
        Thu, 13 Jun 2019 07:14:22 +0000 (UTC)
Received: from localhost (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4D8F11001B3C;
        Thu, 13 Jun 2019 07:14:18 +0000 (UTC)
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
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 05/15] scsi: ipr: use sg helper to operate sgl
Date:   Thu, 13 Jun 2019 15:13:25 +0800
Message-Id: <20190613071335.5679-6-ming.lei@redhat.com>
In-Reply-To: <20190613071335.5679-1-ming.lei@redhat.com>
References: <20190613071335.5679-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 13 Jun 2019 07:14:22 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The current way isn't safe for chained sgl, so use sg helper to
operate sgl.

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

