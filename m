Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E87D7A277
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Jul 2019 09:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbfG3HoK (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 30 Jul 2019 03:44:10 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39145 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729460AbfG3HoK (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 30 Jul 2019 03:44:10 -0400
Received: by mail-pf1-f193.google.com with SMTP id f17so25397417pfn.6
        for <linux-scsi@vger.kernel.org>; Tue, 30 Jul 2019 00:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=2dWWxTxJd1pii9dj8g3hNQ+SfQSV9WfBBB3Us7PIsTg=;
        b=Gj1spyNdOEX4wIgjQsV3tGjIwHgaeP0XhSIrvNBSBO4eoUUvl+rJKYxLMoc20vNLs0
         7wANx9S4BA5mHhzI2QgjuZuPuOxvYfXFcDaIPpgf9dEempWjionBTk3wyfDKPWmc3I20
         iPDfLRZHN6vdSHQzYcRxzxxkSn/YMRGNZaebI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2dWWxTxJd1pii9dj8g3hNQ+SfQSV9WfBBB3Us7PIsTg=;
        b=YR106P3HI1YFsq3/94HX8hM4DDmmIwhkZLOkImUvenHZCt0mIU7KdOQAqMxQUtxBMd
         aFIlItN7JPgA17xC6nHFJOlNZ6Ch3PC+qe8nfmhb5FReqeEoDv+5/Ik9bnPswiRONLTW
         vDrsfcsaycvNiuu25eHsrSX5O6+2q6c06amuyEVbWtCgFEZ/g9WundH/HY+Nn17a0udQ
         N/1jgc8QRCQDmvZCs1z+tUgNBGkQauEuk31yRd8/KxOM6y704z7yr2onyvaPNaLUQKEy
         zdm4dc1k41bxcWJ5V9Wq5gsnGj8EdbhMZaCtvezXwjWxlpn5rOxqZvcPXez4dL3vmoTx
         IHOg==
X-Gm-Message-State: APjAAAW3SOQUCQxZIp4IeOAleQcg9ifjqebEbcCuujUzx2+yztjxr/1M
        u/2LL4WwnDeWFlOGmUJN23+DEnoIYg1MfN1VfQ+RgGZRk5000Jy0XOwAokd0ic4AFNqxqefGCNt
        fS59wziz0q/Ep7wTSkFTFj13z+rCfpjTFMXF4sND45zn4FoM4ygMkQo2n6BWKCrliKNspkc5+in
        bX93ej+OsqSaNR0dk/BQ==
X-Google-Smtp-Source: APXvYqxi5mii3lQbqkH6nGaxPGueZvYZ+yXendYx7MJ+6Cv46Dpuq9cbms0INdMWupLnaUk4dEtS9w==
X-Received: by 2002:a63:7245:: with SMTP id c5mr94475280pgn.11.1564472649319;
        Tue, 30 Jul 2019 00:44:09 -0700 (PDT)
Received: from dhcp-10-123-20-15.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id b30sm92259975pfr.117.2019.07.30.00.44.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 00:44:08 -0700 (PDT)
From:   Suganath Prabu <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org, stable@vger.kernel.org
Cc:     Sathya.Prakash@broadcom.com, kashyap.desai@broadcom.com,
        sreekanth.reddy@broadcom.com,
        Suganath Prabu <suganath-prabu.subramani@broadcom.com>
Subject: [PATCH v2] mpt3sas: Use 63-bit DMA addressing on SAS35 HBA
Date:   Tue, 30 Jul 2019 03:43:57 -0400
Message-Id: <1564472637-8062-1-git-send-email-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Although SAS3 & SAS3.5 IT HBA controllers support
64-bit DMA addressing, as per hardware design,
if DMA able range contains all 64-bits set (0xFFFFFFFF-FFFFFFFF) then
it results in a firmware fault.

e.g. SGE's start address is 0xFFFFFFFF-FFFF000 and
data length is 0x1000 bytes. when HBA tries to DMA the data
at 0xFFFFFFFF-FFFFFFFF location then HBA will
fault the firmware.

Fix:
Driver will set 63-bit DMA mask to ensure the above address
will not be used.

Cc: <stable@vger.kernel.org> # 5.1.20+
Signed-off-by: Suganath Prabu <suganath-prabu.subramani@broadcom.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
V1 Change: Added tag for stable tree
V2 Change: Updated patch description.
 
 drivers/scsi/mpt3sas/mpt3sas_base.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 6846628..050c0f0 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -2703,6 +2703,8 @@ _base_config_dma_addressing(struct MPT3SAS_ADAPTER *ioc, struct pci_dev *pdev)
 {
 	u64 required_mask, coherent_mask;
 	struct sysinfo s;
+	/* Set 63 bit DMA mask for all SAS3 and SAS35 controllers */
+	int dma_mask = (ioc->hba_mpi_version_belonged > MPI2_VERSION) ? 63 : 64;
 
 	if (ioc->is_mcpu_endpoint)
 		goto try_32bit;
@@ -2712,17 +2714,17 @@ _base_config_dma_addressing(struct MPT3SAS_ADAPTER *ioc, struct pci_dev *pdev)
 		goto try_32bit;
 
 	if (ioc->dma_mask)
-		coherent_mask = DMA_BIT_MASK(64);
+		coherent_mask = DMA_BIT_MASK(dma_mask);
 	else
 		coherent_mask = DMA_BIT_MASK(32);
 
-	if (dma_set_mask(&pdev->dev, DMA_BIT_MASK(64)) ||
+	if (dma_set_mask(&pdev->dev, DMA_BIT_MASK(dma_mask)) ||
 	    dma_set_coherent_mask(&pdev->dev, coherent_mask))
 		goto try_32bit;
 
 	ioc->base_add_sg_single = &_base_add_sg_single_64;
 	ioc->sge_size = sizeof(Mpi2SGESimple64_t);
-	ioc->dma_mask = 64;
+	ioc->dma_mask = dma_mask;
 	goto out;
 
  try_32bit:
@@ -2744,7 +2746,7 @@ static int
 _base_change_consistent_dma_mask(struct MPT3SAS_ADAPTER *ioc,
 				      struct pci_dev *pdev)
 {
-	if (pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64))) {
+	if (pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(ioc->dma_mask))) {
 		if (pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32)))
 			return -ENODEV;
 	}
@@ -4989,7 +4991,7 @@ _base_allocate_memory_pools(struct MPT3SAS_ADAPTER *ioc)
 		total_sz += sz;
 	} while (ioc->rdpq_array_enable && (++i < ioc->reply_queue_count));
 
-	if (ioc->dma_mask == 64) {
+	if (ioc->dma_mask > 32) {
 		if (_base_change_consistent_dma_mask(ioc, ioc->pdev) != 0) {
 			ioc_warn(ioc, "no suitable consistent DMA mask for %s\n",
 				 pci_name(ioc->pdev));
-- 
1.8.3.1

