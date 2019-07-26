Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04389766BC
	for <lists+linux-scsi@lfdr.de>; Fri, 26 Jul 2019 14:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbfGZM6t (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 26 Jul 2019 08:58:49 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41365 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfGZM6t (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 26 Jul 2019 08:58:49 -0400
Received: by mail-pg1-f194.google.com with SMTP id x15so14417261pgg.8
        for <linux-scsi@vger.kernel.org>; Fri, 26 Jul 2019 05:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=fmF7QbbYCsb2bwn9TANPVsHe+Z5e456CNNhtsQHklvw=;
        b=LrOgbWD1uBvI42cadKEY00k8E/hDs7iloWli3I48WCk+iR9zC2+SrJJU1yrJqhfl+y
         8XccT7IUzSFWCiLxJtJZoBx/qMi4wuy4+6S+SPstN9oMRgjE6zKBPWQNejm6cSga4LA/
         kaGvPzfIqWnOmuPXUuNBUxOZNbcUs5itilx8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fmF7QbbYCsb2bwn9TANPVsHe+Z5e456CNNhtsQHklvw=;
        b=kl4chHQ56jdai0ayyNZt6/A7qIl+jT3BjqGs71d+2/HZnRD602XUeX0kD04Jiye8u5
         asr034P5Z0roTohfvLHs81EVhkjqmH5WhL6ge5rwM8zmUY7o+GCsQgLyKW0gv1ZNG0r4
         KAH/PTkyF3bTMGHWEYyBKx3OUHGOigPp5Uvz+kpwVOMvv9r9c36F+QcmuFnSKwv9t/lk
         7psRTuxnKgKd1keNYTP6m1a0WJwHb5F/o1c5t+m6+viSHulB0/XYUneZnsVtnDw7nZLo
         B4naazTxLGVSL1LiIJARFfdF8PP9ultkPs2BFIfsfY9jIXY/Uye/iL8CcgJX2V/JHQDc
         y/3g==
X-Gm-Message-State: APjAAAUgWJgL82FSBnC8PBLgjB35mfXQJwSQL4q56leZ88oKKxNS6p6k
        J5l8vKh9aed4/5bHYKoFu1bW/0vGOXazS7rFepcu61fF007DNJbQmBR6XHy499No9hoXCLA55Dh
        7E6qmCIbY50P0dyAmHx0DrGQRmwzHvKzEEFNh/EQPx+S7AAnlXFOADqY05nvOenHo4nXI5uGcY5
        rt3uqzJDLeuDQbCaWSXg==
X-Google-Smtp-Source: APXvYqyCMJx/CbJSughUK+f5r33kd+q6h9Dd7H7xpVJm0Yw61Jf6SOnV97NWLlbW7vODQh0MNSR1LQ==
X-Received: by 2002:a65:654d:: with SMTP id a13mr75052833pgw.196.1564145928391;
        Fri, 26 Jul 2019 05:58:48 -0700 (PDT)
Received: from dhcp-10-123-20-15.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id b126sm77821386pfa.126.2019.07.26.05.58.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 05:58:47 -0700 (PDT)
From:   Suganath Prabu <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org, stable@vger.kernel.org
Cc:     Sathya.Prakash@broadcom.com, kashyap.desai@broadcom.com,
        sreekanth.reddy@broadcom.com,
        Suganath Prabu <suganath-prabu.subramani@broadcom.com>
Subject: [V1] mpt3sas: Use 63-bit DMA addressing on SAS35 HBA
Date:   Fri, 26 Jul 2019 08:58:38 -0400
Message-Id: <1564145918-45146-1-git-send-email-suganath-prabu.subramani@broadcom.com>
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

Cc: <stable@vger.kernel.org>
Signed-off-by: Suganath Prabu <suganath-prabu.subramani@broadcom.com>
---
V1 Change: Added tag for stable tree
 
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

