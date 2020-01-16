Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D74D13F89C
	for <lists+linux-scsi@lfdr.de>; Thu, 16 Jan 2020 20:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731556AbgAPQyJ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 16 Jan 2020 11:54:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:38484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731515AbgAPQyI (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 16 Jan 2020 11:54:08 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17F7822522;
        Thu, 16 Jan 2020 16:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193647;
        bh=BrLs7BvJ+lpkPyofEsvryvAamJQw9HhTY9L33aTBCdM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=05scrx0O9lRkbNgGW3wr1PAjzYVGj8U83ogxVXteFTqU4iWd4ED+u/Yh6GCAnhZjJ
         C5LkaNKF5XcDT+OTTtG/XeOmNfuPlS8C7luGhiaexXT92b15SavZzSC8h9CTuhzG6C
         HwP2ecUU9HyiW1ZjzUu7yIbIbEh0o8Kq3wcPSgw4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Huacai Chen <chenhc@lemote.com>,
        Michael Hernandez <michael.hernandez@cavium.com>,
        Himanshu Madhani <hmadhani@marvell.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 178/205] scsi: qla2xxx: Fix qla2x00_request_irqs() for MSI
Date:   Thu, 16 Jan 2020 11:42:33 -0500
Message-Id: <20200116164300.6705-178-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116164300.6705-1-sashal@kernel.org>
References: <20200116164300.6705-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Huacai Chen <chenhc@lemote.com>

[ Upstream commit 45dc8f2d9c94ed74a5e31e63e9136a19a7e16081 ]

Commit 4fa183455988 ("scsi: qla2xxx: Utilize pci_alloc_irq_vectors/
pci_free_irq_vectors calls.") use pci_alloc_irq_vectors() to replace
pci_enable_msi() but it didn't handle the return value correctly. This bug
make qla2x00 always fail to setup MSI if MSI-X fail, so fix it.

BTW, improve the log message of return value in qla2x00_request_irqs() to
avoid confusion.

Fixes: 4fa183455988 ("scsi: qla2xxx: Utilize pci_alloc_irq_vectors/pci_free_irq_vectors calls.")
Cc: Michael Hernandez <michael.hernandez@cavium.com>
Link: https://lore.kernel.org/r/1574314847-14280-1-git-send-email-chenhc@lemote.com
Signed-off-by: Huacai Chen <chenhc@lemote.com>
Acked-by: Himanshu Madhani <hmadhani@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_isr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index b3766b1879e3..7c5f2736ebee 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -3625,7 +3625,7 @@ qla2x00_request_irqs(struct qla_hw_data *ha, struct rsp_que *rsp)
 skip_msix:
 
 	ql_log(ql_log_info, vha, 0x0037,
-	    "Falling back-to MSI mode -%d.\n", ret);
+	    "Falling back-to MSI mode -- ret=%d.\n", ret);
 
 	if (!IS_QLA24XX(ha) && !IS_QLA2532(ha) && !IS_QLA8432(ha) &&
 	    !IS_QLA8001(ha) && !IS_P3P_TYPE(ha) && !IS_QLAFX00(ha) &&
@@ -3633,13 +3633,13 @@ qla2x00_request_irqs(struct qla_hw_data *ha, struct rsp_que *rsp)
 		goto skip_msi;
 
 	ret = pci_alloc_irq_vectors(ha->pdev, 1, 1, PCI_IRQ_MSI);
-	if (!ret) {
+	if (ret > 0) {
 		ql_dbg(ql_dbg_init, vha, 0x0038,
 		    "MSI: Enabled.\n");
 		ha->flags.msi_enabled = 1;
 	} else
 		ql_log(ql_log_warn, vha, 0x0039,
-		    "Falling back-to INTa mode -- %d.\n", ret);
+		    "Falling back-to INTa mode -- ret=%d.\n", ret);
 skip_msi:
 
 	/* Skip INTx on ISP82xx. */
-- 
2.20.1

