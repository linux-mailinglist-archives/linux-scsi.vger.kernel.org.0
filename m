Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB4F50EDE
	for <lists+linux-scsi@lfdr.de>; Mon, 24 Jun 2019 16:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730279AbfFXOnO (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 24 Jun 2019 10:43:14 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42292 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730259AbfFXOnO (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 24 Jun 2019 10:43:14 -0400
Received: by mail-pl1-f194.google.com with SMTP id ay6so6980878plb.9
        for <linux-scsi@vger.kernel.org>; Mon, 24 Jun 2019 07:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7iZ9ehHlIvmBorBohkBuydVhwFmdpy7sDBaqRwPxVwo=;
        b=AO42MT7hPkzLjlOYcOSux7wPabHyIRs+B7SIHpGPBEjLp02XQuBc5/8oRG4G7b0N7t
         yj7SUid5XkRPwEcaERXWELqdqjp3VuC+KerwjpQsN9ZBa5JG5qVaDvZnrNotBA8WVzhk
         G/fHYVkRqPo42K/SBGOUwUkfZmFy84ASf9P7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7iZ9ehHlIvmBorBohkBuydVhwFmdpy7sDBaqRwPxVwo=;
        b=SqGER4QqD6pF+rdMNx//X3pAT022wtaDqMbGD/xyi8Ysz5izl44eYe9ckLwCgKAqT/
         9/Je+4CREyfxSyn2yhB4YLXSNd7PL8T8ya9pemdeahhFiBlI3qXrBaZRat1sxEp/b1kr
         7/enDHSiO6C1j1+Cr7uTrmp/rRAa+saosXsTSQ5zJHc0dDwZX3k9r5t+JWXEChS6Nqjw
         bai3UhLdskeIEHY67RBVLadsr9cRzd3Kpv+6l7O9+JsyOSI7GnLD16Lv8AaBxpFyQyCt
         CsCQ17n3TXOs5oB3GXatlRLVk9fv/tZ813zgCq1vYxROfTuAHZTa602NjRm4dWP4fMRq
         picA==
X-Gm-Message-State: APjAAAWvEprO/C7EjdPv1coOxEJYXV+icJa2eki024QXtnmCZFshWOgd
        dxHgURVvSUmVtwvSQzVm9FebYg==
X-Google-Smtp-Source: APXvYqzAxQsriwWr74oQS1WPtJD7POvTqyNBKz066dgBgXk2z1ISXTFvk1gWYYP67aZfRjOEwYjfRQ==
X-Received: by 2002:a17:902:2862:: with SMTP id e89mr13602561plb.258.1561387393478;
        Mon, 24 Jun 2019 07:43:13 -0700 (PDT)
Received: from dhcp-10-123-20-15.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id k197sm12991799pgc.22.2019.06.24.07.43.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 07:43:12 -0700 (PDT)
From:   Sreekanth Reddy <sreekanth.reddy@broadcom.com>
To:     martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, suganath-prabu.subramani@broadcom.com,
        sathya.prakash@broadcom.com,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Subject: [PATCH 2/4] mpt3sas: Fix look configured PCIe link speed not cap
Date:   Mon, 24 Jun 2019 10:42:54 -0400
Message-Id: <1561387376-28323-3-git-send-email-sreekanth.reddy@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561387376-28323-1-git-send-email-sreekanth.reddy@broadcom.com>
References: <1561387376-28323-1-git-send-email-sreekanth.reddy@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

While enabling high iops queues driver should look for HBA's
configured PCIe link speed instead of looking for HBA's max
capacity link speed.

i.e. Enable high iops queues only if Aero/Sea HBA's configured
PCIe link speed is set to 16GT/s speed.

Signed-off-by: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index d55f134..8a47e02 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -2979,7 +2979,7 @@ static void
 _base_check_and_enable_high_iops_queues(struct MPT3SAS_ADAPTER *ioc,
 		int hba_msix_vector_count)
 {
-	enum pci_bus_speed speed = PCI_SPEED_UNKNOWN;
+	u16 lnksta, speed;
 
 	if (perf_mode == MPT_PERF_MODE_IOPS ||
 	    perf_mode == MPT_PERF_MODE_LATENCY) {
@@ -2989,15 +2989,10 @@ _base_check_and_enable_high_iops_queues(struct MPT3SAS_ADAPTER *ioc,
 
 	if (perf_mode == MPT_PERF_MODE_DEFAULT) {
 
-		speed = pcie_get_speed_cap(ioc->pdev);
-		dev_info(&ioc->pdev->dev, "PCIe device speed is %s\n",
-		     speed == PCIE_SPEED_2_5GT ? "2.5GHz" :
-		     speed == PCIE_SPEED_5_0GT ? "5.0GHz" :
-		     speed == PCIE_SPEED_8_0GT ? "8.0GHz" :
-		     speed == PCIE_SPEED_16_0GT ? "16.0GHz" :
-		     "Unknown");
+		pcie_capability_read_word(ioc->pdev, PCI_EXP_LNKSTA, &lnksta);
+		speed = lnksta & PCI_EXP_LNKSTA_CLS;
 
-		if (speed < PCIE_SPEED_16_0GT) {
+		if (speed < 0x4) {
 			ioc->high_iops_queues = 0;
 			return;
 		}
-- 
1.8.3.1

