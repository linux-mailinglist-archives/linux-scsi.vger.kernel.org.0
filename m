Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB282A3031
	for <lists+linux-scsi@lfdr.de>; Mon,  2 Nov 2020 17:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbgKBQpj (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 2 Nov 2020 11:45:39 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:57098 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgKBQpj (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 2 Nov 2020 11:45:39 -0500
IronPort-SDR: uoQpe4d9pSS6UwlZeVfnhCK+iCUJcZZrCodUNn2XtBZSZahEmR6oyC9zHa2w3RTgMoXNcdy6vw
 Ux0zqfpRvH3C4JzievADrGP+rZBNS1t72292UwHBmbZ7N/BuL+8c/Z+ZCN54XKhiFG4pIVCywT
 k+kUp1PshI/GDi3AbqABDAn+I+XKB4EGPjBsszyS4xqARVtUILb+0iJGxIGW7HNklINQ6zvBkD
 /VUEbHKxWzq6u4V5RzhP5fUuQH+UevPhRzzTV1KtJBlpghHyZ0YGYBNETZbiQIpXzI/abbkYYr
 xuQ=
X-IronPort-AV: E=Sophos;i="5.77,445,1596524400"; 
   d="scan'208";a="97450070"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Nov 2020 09:45:37 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 2 Nov 2020 09:45:38 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Mon, 2 Nov 2020 09:45:37 -0700
From:   Viswas G <Viswas.G@microchip.com.com>
To:     <linux-scsi@vger.kernel.org>
CC:     <Vasanthalakshmi.Tharmarajan@microchip.com>,
        <Viswas.G@microchip.com>, <Ruksar.devadi@microchip.com>,
        <martin.petersen@oracle.com>, <yuuzheng@google.com>,
        <vishakhavc@google.com>, <radha@google.com>,
        <akshatzen@google.com>, <jinpu.wang@cloud.ionos.com>
Subject: [PATCH V3 3/4] pm80xx: Avoid busywait in FW ready check.
Date:   Mon, 2 Nov 2020 22:25:27 +0530
Message-ID: <20201102165528.26510-4-Viswas.G@microchip.com.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20201102165528.26510-1-Viswas.G@microchip.com.com>
References: <20201102165528.26510-1-Viswas.G@microchip.com.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: akshatzen <akshatzen@google.com>

Today in function check_fw_ready we do busy wait using udelay. Due to
which CPU is not released and we see CPU need_resched failures.

Here busy waiting is not necessary since we are in process context and
we should sleep instead. So to avoid busy waiting we are replacing
udelay with msleep of 20 ms intervals to check for FW to become ready.

It's verified that check_fw_ready today is not being used in interrupt
context anywhere, hence it is safe to make this change.

Tested:
Installed the kernel and looked at dmesg for failures pertaining to
need_resched and did not find them.

Signed-off-by: akshatzen <akshatzen@google.com>
Signed-off-by: Viswas G <Viswas.G@microchip.com>
Signed-off-by: Ruksar Devadi <Ruksar.devadi@microchip.com>
Signed-off-by: Radha Ramachandran <radha@google.com>
Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/scsi/pm8001/pm80xx_hwi.c | 21 +++++++++++----------
 drivers/scsi/pm8001/pm80xx_hwi.h |  6 ++++++
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index 1ba93fb76093..24a4f6b9e79d 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -1042,6 +1042,7 @@ static int mpi_init_check(struct pm8001_hba_info *pm8001_ha)
 
 /**
  * check_fw_ready - The LLDD check if the FW is ready, if not, return error.
+ * This function sleeps hence it must not be used in atomic context.
  * @pm8001_ha: our hba card information
  */
 static int check_fw_ready(struct pm8001_hba_info *pm8001_ha)
@@ -1052,16 +1053,16 @@ static int check_fw_ready(struct pm8001_hba_info *pm8001_ha)
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
@@ -1074,9 +1075,9 @@ static int check_fw_ready(struct pm8001_hba_info *pm8001_ha)
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
@@ -1089,9 +1090,9 @@ static int check_fw_ready(struct pm8001_hba_info *pm8001_ha)
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
@@ -1107,9 +1108,9 @@ static int check_fw_ready(struct pm8001_hba_info *pm8001_ha)
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
index 701951a0f715..ec48bc276de6 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.h
+++ b/drivers/scsi/pm8001/pm80xx_hwi.h
@@ -1639,3 +1639,9 @@ typedef struct SASProtocolTimerConfig SASProtocolTimerConfig_t;
 
 #define MEMBASE_II_SHIFT_REGISTER       0x1010
 #endif
+
+/**
+ * As we know sleep (1~20) ms may result in sleep longer than ~20 ms, hence we
+ * choose 20 ms interval.
+ */
+#define FW_READY_INTERVAL	20
-- 
2.16.3

