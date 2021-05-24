Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0FE338E9C2
	for <lists+linux-scsi@lfdr.de>; Mon, 24 May 2021 16:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbhEXOul (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 24 May 2021 10:50:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:54516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233576AbhEXOtD (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 24 May 2021 10:49:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC5FD613E4;
        Mon, 24 May 2021 14:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621867643;
        bh=YZdjdvbmdTz5Fwy5bEjqDiN+V6oQ4S0iDBQsYYdQba0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KkWV0AGhWkt2kIw+O+gZY++j6oNjnpy/6bfJOU3sTQW5WkjErvez+ATKvyb5qj3oD
         9fApiDV6/RaWE+rcmqwufwWUH7dUkZ88IWbsyspwzdwsuKDwTxEVkjIjK/KBC3C4V1
         JAIgf1HZ/QYfrIEHQ2xm8VHobUQgfO3WqS/kYeFfr1d0v11u2zNJhXUsvMsKFjYs7E
         +7rT2V7WAgqyU+HOnumXADa/LZXvbQ+QDYy/DCKlVpK1/0j5mA+GV7sUicQskST1jE
         rcwGJiIAO8if5izFwyTq0yn9l+TElo1MQMqN2MB6QH/1tyapvWI/hcc/L8gyhLio6C
         3FND0jkFLMxuQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ajish Koshy <ajish.koshy@microchip.com>,
        Viswas G <viswas.g@microchip.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.12 48/63] scsi: pm80xx: Fix drives missing during rmmod/insmod loop
Date:   Mon, 24 May 2021 10:46:05 -0400
Message-Id: <20210524144620.2497249-48-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210524144620.2497249-1-sashal@kernel.org>
References: <20210524144620.2497249-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Ajish Koshy <ajish.koshy@microchip.com>

[ Upstream commit d1acd81bd6eb685aa9fef25624fb36d297f6404e ]

When driver is loaded after rmmod some drives are not showing up during
discovery.

SATA drives are directly attached to the controller connected phys.  During
device discovery, the IDENTIFY command (qc timeout (cmd 0xec)) is timing out
during revalidation. This will trigger abort from host side and controller
successfully aborts the command and returns success. Post this successful
abort response ATA library decides to mark the disk as NODEV.

To overcome this, inside pm8001_scan_start() after phy_start() call, add get
start response and wait for few milliseconds to trigger next phy start.
This millisecond delay will give sufficient time for the controller state
machine to accept next phy start.

Link: https://lore.kernel.org/r/20210505120103.24497-1-ajish.koshy@microchip.com
Signed-off-by: Ajish Koshy <ajish.koshy@microchip.com>
Signed-off-by: Viswas G <viswas.g@microchip.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/pm8001/pm8001_hwi.c  | 10 ++++++----
 drivers/scsi/pm8001/pm8001_init.c |  2 +-
 drivers/scsi/pm8001/pm8001_sas.c  |  7 ++++++-
 drivers/scsi/pm8001/pm80xx_hwi.c  | 12 ++++++------
 4 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
index 1b1a57f46989..c2a38a172904 100644
--- a/drivers/scsi/pm8001/pm8001_hwi.c
+++ b/drivers/scsi/pm8001/pm8001_hwi.c
@@ -3709,11 +3709,13 @@ static int mpi_hw_event(struct pm8001_hba_info *pm8001_ha, void* piomb)
 	case HW_EVENT_PHY_START_STATUS:
 		pm8001_dbg(pm8001_ha, MSG, "HW_EVENT_PHY_START_STATUS status = %x\n",
 			   status);
-		if (status == 0) {
+		if (status == 0)
 			phy->phy_state = 1;
-			if (pm8001_ha->flags == PM8001F_RUN_TIME &&
-					phy->enable_completion != NULL)
-				complete(phy->enable_completion);
+
+		if (pm8001_ha->flags == PM8001F_RUN_TIME &&
+				phy->enable_completion != NULL) {
+			complete(phy->enable_completion);
+			phy->enable_completion = NULL;
 		}
 		break;
 	case HW_EVENT_SAS_PHY_UP:
diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index bd626ef876da..4f3ec2bba8c9 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -1144,8 +1144,8 @@ static int pm8001_pci_probe(struct pci_dev *pdev,
 		goto err_out_shost;
 	}
 	list_add_tail(&pm8001_ha->list, &hba_list);
-	scsi_scan_host(pm8001_ha->shost);
 	pm8001_ha->flags = PM8001F_RUN_TIME;
+	scsi_scan_host(pm8001_ha->shost);
 	return 0;
 
 err_out_shost:
diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
index a98d4496ff8b..0a637609504e 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -264,12 +264,17 @@ void pm8001_scan_start(struct Scsi_Host *shost)
 	int i;
 	struct pm8001_hba_info *pm8001_ha;
 	struct sas_ha_struct *sha = SHOST_TO_SAS_HA(shost);
+	DECLARE_COMPLETION_ONSTACK(completion);
 	pm8001_ha = sha->lldd_ha;
 	/* SAS_RE_INITIALIZATION not available in SPCv/ve */
 	if (pm8001_ha->chip_id == chip_8001)
 		PM8001_CHIP_DISP->sas_re_init_req(pm8001_ha);
-	for (i = 0; i < pm8001_ha->chip->n_phy; ++i)
+	for (i = 0; i < pm8001_ha->chip->n_phy; ++i) {
+		pm8001_ha->phy[i].enable_completion = &completion;
 		PM8001_CHIP_DISP->phy_start_req(pm8001_ha, i);
+		wait_for_completion(&completion);
+		msleep(300);
+	}
 }
 
 int pm8001_scan_finished(struct Scsi_Host *shost, unsigned long time)
diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index c6b0834e3806..5de7adfabd57 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -3485,13 +3485,13 @@ static int mpi_phy_start_resp(struct pm8001_hba_info *pm8001_ha, void *piomb)
 	pm8001_dbg(pm8001_ha, INIT,
 		   "phy start resp status:0x%x, phyid:0x%x\n",
 		   status, phy_id);
-	if (status == 0) {
+	if (status == 0)
 		phy->phy_state = PHY_LINK_DOWN;
-		if (pm8001_ha->flags == PM8001F_RUN_TIME &&
-				phy->enable_completion != NULL) {
-			complete(phy->enable_completion);
-			phy->enable_completion = NULL;
-		}
+
+	if (pm8001_ha->flags == PM8001F_RUN_TIME &&
+			phy->enable_completion != NULL) {
+		complete(phy->enable_completion);
+		phy->enable_completion = NULL;
 	}
 	return 0;
 
-- 
2.30.2

