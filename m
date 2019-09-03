Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84EB0A7046
	for <lists+linux-scsi@lfdr.de>; Tue,  3 Sep 2019 18:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730810AbfICQhq (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 3 Sep 2019 12:37:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:47400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730644AbfICQ03 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 3 Sep 2019 12:26:29 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A01F238F9;
        Tue,  3 Sep 2019 16:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567527988;
        bh=9wU8fXpgELV4lRyl9uKSQLh+1yfeZyVEdf8xbVpJvhs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EAp4OQFH80g0hnUAjQTi2iHmkdbTV+GqN3ek9yW+EmyqQ0nsfpSvaPS/WRVFI5uZQ
         h1hNw2k0vBwgcatOYgKA1TMB4q+w/OS7cA9cJVex+g6Lef/nyneJEerzoiN0MHyZkK
         P+e6LjirsA4wTdi3PXg1j/G2c0LLNULosOi53XBI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 042/167] scsi: megaraid_sas: Use 63-bit DMA addressing
Date:   Tue,  3 Sep 2019 12:23:14 -0400
Message-Id: <20190903162519.7136-42-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903162519.7136-1-sashal@kernel.org>
References: <20190903162519.7136-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>

[ Upstream commit 894169db12463cea08d0e2a9e35f42b291340e5a ]

Although MegaRAID controllers support 64-bit DMA addressing, as per
hardware design, DMA address with all 64-bits set
(0xFFFFFFFF-FFFFFFFF) results in a firmware fault.

Driver will set 63-bit DMA mask to ensure the above address will not be
used.

Cc: stable@vger.kernel.org
Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 749f10146f630..bc37666f998e6 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -6056,13 +6056,13 @@ static int megasas_io_attach(struct megasas_instance *instance)
  * @instance:		Adapter soft state
  * Description:
  *
- * For Ventura, driver/FW will operate in 64bit DMA addresses.
+ * For Ventura, driver/FW will operate in 63bit DMA addresses.
  *
  * For invader-
  *	By default, driver/FW will operate in 32bit DMA addresses
  *	for consistent DMA mapping but if 32 bit consistent
- *	DMA mask fails, driver will try with 64 bit consistent
- *	mask provided FW is true 64bit DMA capable
+ *	DMA mask fails, driver will try with 63 bit consistent
+ *	mask provided FW is true 63bit DMA capable
  *
  * For older controllers(Thunderbolt and MFI based adapters)-
  *	driver/FW will operate in 32 bit consistent DMA addresses.
@@ -6075,15 +6075,15 @@ megasas_set_dma_mask(struct megasas_instance *instance)
 	u32 scratch_pad_2;
 
 	pdev = instance->pdev;
-	consistent_mask = (instance->adapter_type == VENTURA_SERIES) ?
-				DMA_BIT_MASK(64) : DMA_BIT_MASK(32);
+	consistent_mask = (instance->adapter_type >= VENTURA_SERIES) ?
+				DMA_BIT_MASK(63) : DMA_BIT_MASK(32);
 
 	if (IS_DMA64) {
-		if (dma_set_mask(&pdev->dev, DMA_BIT_MASK(64)) &&
+		if (dma_set_mask(&pdev->dev, DMA_BIT_MASK(63)) &&
 		    dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32)))
 			goto fail_set_dma_mask;
 
-		if ((*pdev->dev.dma_mask == DMA_BIT_MASK(64)) &&
+		if ((*pdev->dev.dma_mask == DMA_BIT_MASK(63)) &&
 		    (dma_set_coherent_mask(&pdev->dev, consistent_mask) &&
 		     dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32)))) {
 			/*
@@ -6096,7 +6096,7 @@ megasas_set_dma_mask(struct megasas_instance *instance)
 			if (!(scratch_pad_2 & MR_CAN_HANDLE_64_BIT_DMA_OFFSET))
 				goto fail_set_dma_mask;
 			else if (dma_set_mask_and_coherent(&pdev->dev,
-							   DMA_BIT_MASK(64)))
+							   DMA_BIT_MASK(63)))
 				goto fail_set_dma_mask;
 		}
 	} else if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32)))
@@ -6108,8 +6108,8 @@ megasas_set_dma_mask(struct megasas_instance *instance)
 		instance->consistent_mask_64bit = true;
 
 	dev_info(&pdev->dev, "%s bit DMA mask and %s bit consistent mask\n",
-		 ((*pdev->dev.dma_mask == DMA_BIT_MASK(64)) ? "64" : "32"),
-		 (instance->consistent_mask_64bit ? "64" : "32"));
+		 ((*pdev->dev.dma_mask == DMA_BIT_MASK(64)) ? "63" : "32"),
+		 (instance->consistent_mask_64bit ? "63" : "32"));
 
 	return 0;
 
-- 
2.20.1

