Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E75A50470
	for <lists+linux-scsi@lfdr.de>; Mon, 24 Jun 2019 10:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbfFXIWO (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 24 Jun 2019 04:22:14 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:60591 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbfFXIWO (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 24 Jun 2019 04:22:14 -0400
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  viswas.g@microsemi.com designates 208.19.99.222 as permitted
  sender) identity=mailfrom; client-ip=208.19.99.222;
  receiver=esa5.microchip.iphmx.com;
  envelope-from="viswas.g@microsemi.com";
  x-sender="viswas.g@microsemi.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:208.19.100.20 ip4:208.19.100.21 ip4:208.19.100.22
  ip4:208.19.100.23 ip4:208.19.99.221 ip4:208.19.99.222
  ip4:208.19.99.223 ip4:208.19.99.225 -all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@smtp.microsemi.com) identity=helo;
  client-ip=208.19.99.222; receiver=esa5.microchip.iphmx.com;
  envelope-from="viswas.g@microsemi.com";
  x-sender="postmaster@smtp.microsemi.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=viswas.g@microsemi.com; spf=None smtp.helo=postmaster@smtp.microsemi.com; dmarc=fail (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.63,411,1557212400"; 
   d="scan'208";a="37027544"
Received: from unknown (HELO smtp.microsemi.com) ([208.19.99.222])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Jun 2019 01:22:13 -0700
Received: from AUSMBX2.microsemi.net (10.201.34.32) by AUSMBX2.microsemi.net
 (10.201.34.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 24 Jun
 2019 03:22:12 -0500
Received: from localhost (10.41.130.49) by ausmbx2.microsemi.net
 (10.201.34.32) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 24 Jun 2019 03:22:11 -0500
From:   Deepak Ukey <deepak.ukey@microchip.com>
To:     <linux-scsi@vger.kernel.org>
CC:     <Vasanthalakshmi.Tharmarajan@microchip.com>,
        <Viswas.G@microcchip.com>, <deepak.ukey@microchip.com>,
        <jinpu.wang@profitbricks.com>, <martin.petersen@oracle.com>
Subject: [PATCH 1/3] pm80xx : Fixed kernel panic during error recovery for SATA drive.
Date:   Mon, 24 Jun 2019 13:52:26 +0530
Message-ID: <20190624082228.27433-2-deepak.ukey@microchip.com>
X-Mailer: git-send-email 2.19.0-rc1
In-Reply-To: <20190624082228.27433-1-deepak.ukey@microchip.com>
References: <20190624082228.27433-1-deepak.ukey@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Disabling the SATA drive interface cause kernel panic. When the drive
Interface is disabled, device should be deregistered after aborting
all pending IO's.

Signed-off-by: Deepak Ukey <deepak.ukey@microchip.com>
Signed-off-by: Viswas G <Viswas.G@microchip.com>
---
 drivers/scsi/pm8001/pm8001_sas.c | 6 +++++-
 drivers/scsi/pm8001/pm80xx_hwi.c | 2 +-
 drivers/scsi/pm8001/pm80xx_hwi.h | 1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
index 88eef3b..0d680f3 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -889,6 +889,8 @@ static void pm8001_dev_gone_notify(struct domain_device *dev)
 			pm8001_exec_internal_task_abort(pm8001_ha, pm8001_dev ,
 				dev, 1, 0);
 			spin_lock_irqsave(&pm8001_ha->lock, flags);
+			while (pm8001_dev->running_req)
+				msleep(20);
 		}
 		PM8001_CHIP_DISP->dereg_dev_req(pm8001_ha, device_id);
 		pm8001_free_dev(pm8001_dev);
@@ -1256,8 +1258,10 @@ int pm8001_abort_task(struct sas_task *task)
 			PM8001_MSG_DBG(pm8001_ha,
 				pm8001_printk("Waiting for Port reset\n"));
 			wait_for_completion(&completion_reset);
-			if (phy->port_reset_status)
+			if (phy->port_reset_status) {
+				pm8001_dev_gone_notify(dev);
 				goto out;
+			}
 
 			/*
 			 * 4. SATA Abort ALL
diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index 301de40..63e8af7 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -604,7 +604,7 @@ static void update_main_config_table(struct pm8001_hba_info *pm8001_ha)
 		pm8001_ha->main_cfg_tbl.pm80xx_tbl.port_recovery_timer &=
 					0x0000ffff;
 		pm8001_ha->main_cfg_tbl.pm80xx_tbl.port_recovery_timer |=
-					0x140000;
+					CHIP_8006_PORT_RECOVERY_TIMEOUT;
 	}
 	pm8001_mw32(address, MAIN_PORT_RECOVERY_TIMER,
 			pm8001_ha->main_cfg_tbl.pm80xx_tbl.port_recovery_timer);
diff --git a/drivers/scsi/pm8001/pm80xx_hwi.h b/drivers/scsi/pm8001/pm80xx_hwi.h
index 84d7426..a22bb4d 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.h
+++ b/drivers/scsi/pm8001/pm80xx_hwi.h
@@ -230,6 +230,7 @@
 #define SAS_MAX_AIP                     0x200000
 #define IT_NEXUS_TIMEOUT       0x7D0
 #define PORT_RECOVERY_TIMEOUT  ((IT_NEXUS_TIMEOUT/100) + 30)
+#define CHIP_8006_PORT_RECOVERY_TIMEOUT 0x640000
 
 #ifdef __LITTLE_ENDIAN_BITFIELD
 struct sas_identify_frame_local {
-- 
1.8.5.6

