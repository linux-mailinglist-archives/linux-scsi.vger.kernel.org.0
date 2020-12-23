Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 413892E170C
	for <lists+linux-scsi@lfdr.de>; Wed, 23 Dec 2020 04:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbgLWDFR (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 22 Dec 2020 22:05:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:45452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728521AbgLWCTL (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 22 Dec 2020 21:19:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E1E823333;
        Wed, 23 Dec 2020 02:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608689910;
        bh=8S4+xlE7pBFJj77/azyqVKfA3Qa2ZAaGnJZsbWx11gc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nqB4lNLZQrC+vPfzwNwa9cSDJqzVKDsiqRdX5WyxuyL8GirH9/esf3gKfsCx3yHNM
         4zMRn4LJ4CktkaHBXeVyNqC9Vru/zZ+tNBMF8wCCDK7bQPJdXcqnPxaWqNx/9s96ab
         XhofkmfOfjNnfILl2orPLjjTpe89ElzAjqKj/k/s2J1uZQR1xShHUZ/8anR2QWMj4P
         YXZZRMNyAaNfDYP4dL5XaOgt5M5ABFJF1hFlJIOm2nwa/MKs4V6ABZ3jWOdnAbgtOt
         DPmilJeClvA6CgMpb/Ucbv+I0SXbQuMamiUtFWYrffvgg3UrLu6ZtaKG1wFQQN0AuV
         q+rLIW7cSGpPQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     akshatzen <akshatzen@google.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Viswas G <Viswas.G@microchip.com>,
        Ruksar Devadi <Ruksar.devadi@microchip.com>,
        Radha Ramachandran <radha@google.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 012/130] scsi: pm80xx: Avoid busywait in FW ready check
Date:   Tue, 22 Dec 2020 21:16:15 -0500
Message-Id: <20201223021813.2791612-12-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201223021813.2791612-1-sashal@kernel.org>
References: <20201223021813.2791612-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: akshatzen <akshatzen@google.com>

[ Upstream commit 48cd6b38eb4f2874f091c4776ea1c26e7e4f967e ]

In function check_fw_ready() we busy wait using udelay. The CPU is not
released and we see need_resched failures.

Busy waiting is not necessary since we are in process context and we can
sleep instead. Replace udelay with msleep of 20 ms intervals while waiting
for firmware to become ready.

It has been verified that check_fw_ready is not being used in interrupt
context anywhere, hence it is safe to make this change.

Link: https://lore.kernel.org/r/20201102165528.26510-4-Viswas.G@microchip.com.com
Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Signed-off-by: akshatzen <akshatzen@google.com>
Signed-off-by: Viswas G <Viswas.G@microchip.com>
Signed-off-by: Ruksar Devadi <Ruksar.devadi@microchip.com>
Signed-off-by: Radha Ramachandran <radha@google.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/pm8001/pm80xx_hwi.c | 21 +++++++++++----------
 drivers/scsi/pm8001/pm80xx_hwi.h |  6 ++++++
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index 8756bbf2c3896..a3c58cf2d68c9 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -703,6 +703,7 @@ static int mpi_init_check(struct pm8001_hba_info *pm8001_ha)
 
 /**
  * check_fw_ready - The LLDD check if the FW is ready, if not, return error.
+ * This function sleeps hence it must not be used in atomic context.
  * @pm8001_ha: our hba card information
  */
 static int check_fw_ready(struct pm8001_hba_info *pm8001_ha)
@@ -713,16 +714,16 @@ static int check_fw_ready(struct pm8001_hba_info *pm8001_ha)
 	int ret = 0;
 
 	/* reset / PCIe ready */
-	max_wait_time = max_wait_count = 100 * 1000;	/* 100 milli sec */
+	max_wait_time = max_wait_count = 5;	/* 100 milli sec */
 	do {
-		udelay(1);
+		msleep(FW_READY_INTERVAL);
 		value = pm8001_cr32(pm8001_ha, 0, MSGU_SCRATCH_PAD_1);
 	} while ((value == 0xFFFFFFFF) && (--max_wait_count));
 
 	/* check ila status */
-	max_wait_time = max_wait_count = 1000 * 1000;	/* 1000 milli sec */
+	max_wait_time = max_wait_count = 50;	/* 1000 milli sec */
 	do {
-		udelay(1);
+		msleep(FW_READY_INTERVAL);
 		value = pm8001_cr32(pm8001_ha, 0, MSGU_SCRATCH_PAD_1);
 	} while (((value & SCRATCH_PAD_ILA_READY) !=
 			SCRATCH_PAD_ILA_READY) && (--max_wait_count));
@@ -735,9 +736,9 @@ static int check_fw_ready(struct pm8001_hba_info *pm8001_ha)
 	}
 
 	/* check RAAE status */
-	max_wait_time = max_wait_count = 1800 * 1000;	/* 1800 milli sec */
+	max_wait_time = max_wait_count = 90;	/* 1800 milli sec */
 	do {
-		udelay(1);
+		msleep(FW_READY_INTERVAL);
 		value = pm8001_cr32(pm8001_ha, 0, MSGU_SCRATCH_PAD_1);
 	} while (((value & SCRATCH_PAD_RAAE_READY) !=
 				SCRATCH_PAD_RAAE_READY) && (--max_wait_count));
@@ -750,9 +751,9 @@ static int check_fw_ready(struct pm8001_hba_info *pm8001_ha)
 	}
 
 	/* check iop0 status */
-	max_wait_time = max_wait_count = 600 * 1000;	/* 600 milli sec */
+	max_wait_time = max_wait_count = 30;	/* 600 milli sec */
 	do {
-		udelay(1);
+		msleep(FW_READY_INTERVAL);
 		value = pm8001_cr32(pm8001_ha, 0, MSGU_SCRATCH_PAD_1);
 	} while (((value & SCRATCH_PAD_IOP0_READY) != SCRATCH_PAD_IOP0_READY) &&
 			(--max_wait_count));
@@ -768,9 +769,9 @@ static int check_fw_ready(struct pm8001_hba_info *pm8001_ha)
 	if ((pm8001_ha->chip_id != chip_8008) &&
 			(pm8001_ha->chip_id != chip_8009)) {
 		/* 200 milli sec */
-		max_wait_time = max_wait_count = 200 * 1000;
+		max_wait_time = max_wait_count = 10;
 		do {
-			udelay(1);
+			msleep(FW_READY_INTERVAL);
 			value = pm8001_cr32(pm8001_ha, 0, MSGU_SCRATCH_PAD_1);
 		} while (((value & SCRATCH_PAD_IOP1_READY) !=
 				SCRATCH_PAD_IOP1_READY) && (--max_wait_count));
diff --git a/drivers/scsi/pm8001/pm80xx_hwi.h b/drivers/scsi/pm8001/pm80xx_hwi.h
index dc9ab7689060b..806cf07eefff4 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.h
+++ b/drivers/scsi/pm8001/pm80xx_hwi.h
@@ -1636,3 +1636,9 @@ typedef struct SASProtocolTimerConfig SASProtocolTimerConfig_t;
 
 #define MEMBASE_II_SHIFT_REGISTER       0x1010
 #endif
+
+/**
+ * As we know sleep (1~20) ms may result in sleep longer than ~20 ms, hence we
+ * choose 20 ms interval.
+ */
+#define FW_READY_INTERVAL	20
-- 
2.27.0

