Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92A7E633D4
	for <lists+linux-scsi@lfdr.de>; Tue,  9 Jul 2019 12:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfGIKAf (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 9 Jul 2019 06:00:35 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:57568 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfGIKAf (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 9 Jul 2019 06:00:35 -0400
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  viswas.g@microsemi.com designates 208.19.99.222 as permitted
  sender) identity=mailfrom; client-ip=208.19.99.222;
  receiver=esa1.microchip.iphmx.com;
  envelope-from="viswas.g@microsemi.com";
  x-sender="viswas.g@microsemi.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:208.19.100.20 ip4:208.19.100.21 ip4:208.19.100.22
  ip4:208.19.100.23 ip4:208.19.99.221 ip4:208.19.99.222
  ip4:208.19.99.223 ip4:208.19.99.225 -all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@smtp.microsemi.com) identity=helo;
  client-ip=208.19.99.222; receiver=esa1.microchip.iphmx.com;
  envelope-from="viswas.g@microsemi.com";
  x-sender="postmaster@smtp.microsemi.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=viswas.g@microsemi.com; spf=None smtp.helo=postmaster@smtp.microsemi.com; dmarc=fail (p=none dis=none) d=microchip.com
IronPort-SDR: TP8ic6JzLuKgNEVhecbxAO9L9tQIgn+P6Lt1EYvDXFhJj72jcg4qQR1McgQ5R7qUwc40yCIMIe
 1HNX1eMIr10fhy38RRZJ1zi12geMldQ3Nk8DqN1DRFfJ7ZgmPGF8rne2ydShzIACjw5eLaBdFf
 TUWHi5GOlppWxQ9eISe00Z+NYwPpM23QgtisbAHmuPjvCpzL41yAOnhVwojbAhyGsCVj6L7+Fj
 gJRuyFNIy4yEPkNuDAeshIAzVwJNoGecaabgErzjIPDm6W2PmChbr/kWTSYaIKhiKaj7w35WTy
 x4o=
X-IronPort-AV: E=Sophos;i="5.63,470,1557212400"; 
   d="scan'208";a="41966420"
Received: from unknown (HELO smtp.microsemi.com) ([208.19.99.222])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jul 2019 03:00:34 -0700
Received: from AUSMBX3.microsemi.net (10.201.34.33) by AUSMBX2.microsemi.net
 (10.201.34.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 9 Jul 2019
 05:00:33 -0500
Received: from AUSMBX1.microsemi.net (10.201.34.31) by AUSMBX3.microsemi.net
 (10.201.34.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 9 Jul 2019
 05:00:32 -0500
Received: from localhost (10.41.130.49) by ausmbx1.microsemi.net
 (10.201.34.31) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 9 Jul 2019 05:00:31 -0500
From:   Deepak Ukey <deepak.ukey@microchip.com>
To:     <linux-scsi@vger.kernel.org>
CC:     <Vasanthalakshmi.Tharmarajan@microchip.com>,
        <Viswas.G@microchip.com>, <deepak.ukey@microchip.com>,
        <jinpu.wang@cloud.ionos.com>, <martin.petersen@oracle.com>
Subject: [PATCH V2 1/3] pm80xx : Fixed kernel panic during error recovery for SATA drive.
Date:   Tue, 9 Jul 2019 15:30:48 +0530
Message-ID: <20190709100050.6947-2-deepak.ukey@microchip.com>
X-Mailer: git-send-email 2.19.0-rc1
In-Reply-To: <20190709100050.6947-1-deepak.ukey@microchip.com>
References: <20190709100050.6947-1-deepak.ukey@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Disabling the SATA drive interface cause kernel panic. When the drive
Interface is disabled, device should be deregistered after aborting
all pending IO's. Also changed the port recovery timeout to 10000 ms
for PM8006 controller.

	V2:
		-Acquired spin lock after aborting all requests.

Signed-off-by: Deepak Ukey <deepak.ukey@microchip.com>
Signed-off-by: Viswas G <Viswas.G@microchip.com>
---
 drivers/scsi/pm8001/pm8001_sas.c | 6 +++++-
 drivers/scsi/pm8001/pm80xx_hwi.c | 2 +-
 drivers/scsi/pm8001/pm80xx_hwi.h | 2 ++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
index 88eef3b..0c2f13d 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -888,6 +888,8 @@ static void pm8001_dev_gone_notify(struct domain_device *dev)
 			spin_unlock_irqrestore(&pm8001_ha->lock, flags);
 			pm8001_exec_internal_task_abort(pm8001_ha, pm8001_dev ,
 				dev, 1, 0);
+			while (pm8001_dev->running_req)
+				msleep(20);
 			spin_lock_irqsave(&pm8001_ha->lock, flags);
 		}
 		PM8001_CHIP_DISP->dereg_dev_req(pm8001_ha, device_id);
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
index 84d7426..dc9ab76 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.h
+++ b/drivers/scsi/pm8001/pm80xx_hwi.h
@@ -230,6 +230,8 @@
 #define SAS_MAX_AIP                     0x200000
 #define IT_NEXUS_TIMEOUT       0x7D0
 #define PORT_RECOVERY_TIMEOUT  ((IT_NEXUS_TIMEOUT/100) + 30)
+/* Port recovery timeout, 10000 ms for PM8006 controller */
+#define CHIP_8006_PORT_RECOVERY_TIMEOUT 0x640000
 
 #ifdef __LITTLE_ENDIAN_BITFIELD
 struct sas_identify_frame_local {
-- 
1.8.5.6

