Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B84F44487
	for <lists+linux-scsi@lfdr.de>; Thu, 13 Jun 2019 18:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730648AbfFMQha (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 13 Jun 2019 12:37:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42992 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730647AbfFMHOR (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 13 Jun 2019 03:14:17 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E9CCB85545;
        Thu, 13 Jun 2019 07:14:16 +0000 (UTC)
Received: from localhost (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 091AB39BF;
        Thu, 13 Jun 2019 07:14:13 +0000 (UTC)
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
Subject: [PATCH V2 04/15] scsi: mvumi: use sg helper to operate sgl
Date:   Thu, 13 Jun 2019 15:13:24 +0800
Message-Id: <20190613071335.5679-5-ming.lei@redhat.com>
In-Reply-To: <20190613071335.5679-1-ming.lei@redhat.com>
References: <20190613071335.5679-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 13 Jun 2019 07:14:17 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The current way isn't safe for chained sgl, so use sgl helper to
operate sgl.

Reviewed-by: Ewan D. Milne <emilne@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/mvumi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/mvumi.c b/drivers/scsi/mvumi.c
index a5410615edac..0022cd31500a 100644
--- a/drivers/scsi/mvumi.c
+++ b/drivers/scsi/mvumi.c
@@ -211,8 +211,7 @@ static int mvumi_make_sgl(struct mvumi_hba *mhba, struct scsi_cmnd *scmd,
 	unsigned int sgnum = scsi_sg_count(scmd);
 	dma_addr_t busaddr;
 
-	sg = scsi_sglist(scmd);
-	*sg_count = dma_map_sg(&mhba->pdev->dev, sg, sgnum,
+	*sg_count = dma_map_sg(&mhba->pdev->dev, scsi_sglist(scmd), sgnum,
 			       scmd->sc_data_direction);
 	if (*sg_count > mhba->max_sge) {
 		dev_err(&mhba->pdev->dev,
@@ -222,12 +221,12 @@ static int mvumi_make_sgl(struct mvumi_hba *mhba, struct scsi_cmnd *scmd,
 			     scmd->sc_data_direction);
 		return -1;
 	}
-	for (i = 0; i < *sg_count; i++) {
-		busaddr = sg_dma_address(&sg[i]);
+	scsi_for_each_sg(scmd, sg, *sg_count, i) {
+		busaddr = sg_dma_address(sg);
 		m_sg->baseaddr_l = cpu_to_le32(lower_32_bits(busaddr));
 		m_sg->baseaddr_h = cpu_to_le32(upper_32_bits(busaddr));
 		m_sg->flags = 0;
-		sgd_setsz(mhba, m_sg, cpu_to_le32(sg_dma_len(&sg[i])));
+		sgd_setsz(mhba, m_sg, cpu_to_le32(sg_dma_len(sg)));
 		if ((i + 1) == *sg_count)
 			m_sg->flags |= 1U << mhba->eot_flag;
 
-- 
2.20.1

