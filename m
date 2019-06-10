Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEAA3B7F5
	for <lists+linux-scsi@lfdr.de>; Mon, 10 Jun 2019 17:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389693AbfFJPDz (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 10 Jun 2019 11:03:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41124 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389345AbfFJPDz (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 10 Jun 2019 11:03:55 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 248CC2F8BE8;
        Mon, 10 Jun 2019 15:03:55 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6896519C59;
        Mon, 10 Jun 2019 15:03:53 +0000 (UTC)
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
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 3/5] scsi: ipr: use sg helper to operate sgl
Date:   Mon, 10 Jun 2019 23:03:15 +0800
Message-Id: <20190610150317.29546-4-ming.lei@redhat.com>
In-Reply-To: <20190610150317.29546-1-ming.lei@redhat.com>
References: <20190610150317.29546-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 10 Jun 2019 15:03:55 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The current way isn't safe for chained sgl, so use sg helper to
operate sgl.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/ipr.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index d06bc1a817a1..028db6bd0280 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -3952,6 +3952,7 @@ static void ipr_build_ucode_ioadl64(struct ipr_cmnd *ipr_cmd,
 	struct ipr_ioarcb *ioarcb = &ipr_cmd->ioarcb;
 	struct ipr_ioadl64_desc *ioadl64 = ipr_cmd->i.ioadl64;
 	struct scatterlist *scatterlist = sglist->scatterlist;
+	struct scatterlist *sg;
 	int i;
 
 	ipr_cmd->dma_use_sg = sglist->num_dma_sg;
@@ -3960,10 +3961,10 @@ static void ipr_build_ucode_ioadl64(struct ipr_cmnd *ipr_cmd,
 
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
-- 
2.20.1

