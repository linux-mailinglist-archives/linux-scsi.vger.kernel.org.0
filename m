Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C71B9762F3
	for <lists+linux-scsi@lfdr.de>; Fri, 26 Jul 2019 12:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfGZKBc (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 26 Jul 2019 06:01:32 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33266 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfGZKBb (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 26 Jul 2019 06:01:31 -0400
Received: by mail-pl1-f194.google.com with SMTP id c14so24518216plo.0
        for <linux-scsi@vger.kernel.org>; Fri, 26 Jul 2019 03:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=x3+KXCdYMOWuF4h/FqF9a+7bVPJBpkLPyD7+Y3l+WKY=;
        b=M1q+PXQ12LBlRImIcDDqN1f9Lqp4vGfDFEGjuC8xtrTPl17VD8OUA0bEuS7zH4C2m1
         uMlKCKzFTMsjpgNcitIE74cTm5BfNCID+Lp8gbjuAySjgszu1sxK8A0rrHicvG8o0Hh3
         iNZKRlwhOLNHDDNpAkMLdDWFOisL0IshyvoqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=x3+KXCdYMOWuF4h/FqF9a+7bVPJBpkLPyD7+Y3l+WKY=;
        b=uHyI/cl0Jni0EzOwh2LUqJ2YW3VrowkGzXo2u07fnTECYHpypI98rYtBaHPnPJUACD
         2tqf4sceCrSpheS3t4pZpnW9f9KvEe2VuUAjvWqXPMqJp+ZpDvMaIiCyaq+shiheOQ55
         ogeJoJNEHoQxhgOiIWJ0NM3+3F94d4zsmWuFF+sk2mFRJ0+2gsllE8uSMgwcxM1vAIkS
         uwXfFzAjrb5zxkzHvSEN5UbHC60TVUfi6Xf/zPqLEW4TtlGSibyof58zDLdY2u5te+Jf
         TFSyr4eoxdN28/JgYZvybMRQneiEK2eLgkXtDK8fqB6G0voLc8S6gcOYtdU8gqmw8RKt
         3rqQ==
X-Gm-Message-State: APjAAAWK+N9HuBxPkutsNHpbJ+loy5lloUFEGB/qOazgNUCQtPquLLvg
        V8LneZPcXYvjc+n2WQ+SM59hV908rNmcfmifsEGvVL0C3x1j4P9GKzcH6me0HPLieq6wdsruJ46
        uETfB3ux2IiSlcrT1E/HMxi8usywvo+vM0zU+HGzhudVtHzcnAXAk1KkyCXMT/gLvisHm7lPQ7j
        /v5YGvUchJ7fWgKyWGkA==
X-Google-Smtp-Source: APXvYqwQtqb5Aow7Q5E6Cp0uL/YWpS73I7zI993nKApJPRLYb5eqIVLe8FepRN4ryZ020lBnr0IYeQ==
X-Received: by 2002:a17:902:4222:: with SMTP id g31mr20381731pld.41.1564135291007;
        Fri, 26 Jul 2019 03:01:31 -0700 (PDT)
Received: from dhcp-10-123-20-15.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id t11sm59628835pgb.33.2019.07.26.03.01.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 03:01:30 -0700 (PDT)
From:   Suganath Prabu <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org, stable@vger.kernel.org
Cc:     Sathya.Prakash@broadcom.com, kashyap.desai@broadcom.com,
        sreekanth.reddy@broadcom.com,
        Suganath Prabu <suganath-prabu.subramani@broadcom.com>
Subject: [PATCH] mpt3sas: Use 63-bit DMA addressing on SAS35 HBA
Date:   Fri, 26 Jul 2019 06:00:57 -0400
Message-Id: <1564135257-33188-1-git-send-email-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Although SAS3 & SAS3.5 IT HBA controllers support
64-bit DMA addressing, as per hardware design,
DMA address with all 64-bits set (0xFFFFFFFF-FFFFFFFF)
results in a firmware fault.

Fix:
Driver will set 63-bit DMA mask to ensure the above address
will not be used.

Signed-off-by: Suganath Prabu <suganath-prabu.subramani@broadcom.com>
---
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

