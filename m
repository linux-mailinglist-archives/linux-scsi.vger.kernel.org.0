Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8A61FC3A6
	for <lists+linux-scsi@lfdr.de>; Thu, 14 Nov 2019 11:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfKNKIh (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 14 Nov 2019 05:08:37 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:31166 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfKNKIh (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 14 Nov 2019 05:08:37 -0500
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  viswas.g@microsemi.com designates 208.19.100.23 as permitted
  sender) identity=mailfrom; client-ip=208.19.100.23;
  receiver=esa3.microchip.iphmx.com;
  envelope-from="viswas.g@microsemi.com";
  x-sender="viswas.g@microsemi.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:208.19.100.20 ip4:208.19.100.21 ip4:208.19.100.22
  ip4:208.19.100.23 ip4:208.19.99.221 ip4:208.19.99.222
  ip4:208.19.99.223 ip4:208.19.99.225 -all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@smtp.microsemi.com) identity=helo;
  client-ip=208.19.100.23; receiver=esa3.microchip.iphmx.com;
  envelope-from="viswas.g@microsemi.com";
  x-sender="postmaster@smtp.microsemi.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=viswas.g@microsemi.com; spf=None smtp.helo=postmaster@smtp.microsemi.com; dmarc=fail (p=none dis=none) d=microchip.com
IronPort-SDR: Db9gmfOwd6RbZrNeCPECsz7T1MTwOteg6406QTU2eHwcWumgyGYOzFk32Od6VEWhj1GLG4vSfw
 qlQvJrTo5427CEGt1IA586wbSsJrIP6+dXU0yiReO20aAnoU56DVIyHMyMQqQ5LR3Ix+sl43nJ
 kxzkEF2LNsNQFU7mZ/1ZVhUfSVqI6Y6yJK/xdIFJlSpQhR1Q39QOgW5Tt/GDJYCupLaKGh/pNL
 8/MKXtx4488fNInH9OsqBN5X2e0xoOU6nEpT8BeIzVjDirStkgxZstxoOyOnaEiw6Lh5nKZexN
 yMU=
X-IronPort-AV: E=Sophos;i="5.68,304,1569308400"; 
   d="scan'208";a="57056450"
Received: from unknown (HELO smtp.microsemi.com) ([208.19.100.23])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Nov 2019 03:08:36 -0700
Received: from AVMBX2.microsemi.net (10.100.34.32) by AVMBX3.microsemi.net
 (10.100.34.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Thu, 14 Nov
 2019 02:08:35 -0800
Received: from localhost (10.41.130.49) by avmbx2.microsemi.net (10.100.34.32)
 with Microsoft SMTP Server id 15.1.1847.3 via Frontend Transport; Thu, 14 Nov
 2019 02:08:34 -0800
From:   Deepak Ukey <deepak.ukey@microchip.com>
To:     <linux-scsi@vger.kernel.org>
CC:     <Vasanthalakshmi.Tharmarajan@microchip.com>,
        <Viswas.G@microchip.com>, <deepak.ukey@microchip.com>,
        <jinpu.wang@profitbricks.com>, <martin.petersen@oracle.com>,
        <dpf@google.com>, <jsperbeck@google.com>, <auradkar@google.com>,
        <ianyar@google.com>
Subject: [PATCH V2 04/13] pm80xx : Convert 'long' mdelay to msleep.
Date:   Thu, 14 Nov 2019 15:39:01 +0530
Message-ID: <20191114100910.6153-5-deepak.ukey@microchip.com>
X-Mailer: git-send-email 2.19.0-rc1
In-Reply-To: <20191114100910.6153-1-deepak.ukey@microchip.com>
References: <20191114100910.6153-1-deepak.ukey@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Vikram Auradkar <auradkar@google.com>

For delays longer than 20ms [um]delay isn't recommended.
pm80xx_chip_soft_rst starts off with a 500ms delay before it even
gets around to checking for the results of the reset. As long as
it's at least 500ms it doesn't matter what the scheduler is doing.
The delay in the pm8001_exec_internal_task_abort does nothing, and
theory is this is a delay to avoid a double-free.

Signed-off-by: Vikram Auradkar <auradkar@google.com>
Signed-off-by: Deepak Ukey <deepak.ukey@microchip.com>
Signed-off-by: Viswas G <Viswas.G@microchip.com>
Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/scsi/pm8001/pm80xx_hwi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index ee9c187d8caa..1a1adda15db8 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -1241,7 +1241,7 @@ pm80xx_chip_soft_rst(struct pm8001_hba_info *pm8001_ha)
 		pm8001_printk("reset register before write : 0x%x\n", regval));
 
 	pm8001_cw32(pm8001_ha, 0, SPC_REG_SOFT_RESET, SPCv_NORMAL_RESET_VALUE);
-	mdelay(500);
+	msleep(500);
 
 	regval = pm8001_cr32(pm8001_ha, 0, SPC_REG_SOFT_RESET);
 	PM8001_INIT_DBG(pm8001_ha,
@@ -2986,7 +2986,7 @@ hw_event_sas_phy_up(struct pm8001_hba_info *pm8001_ha, void *piomb)
 	pm8001_get_attached_sas_addr(phy, phy->sas_phy.attached_sas_addr);
 	spin_unlock_irqrestore(&phy->sas_phy.frame_rcvd_lock, flags);
 	if (pm8001_ha->flags == PM8001F_RUN_TIME)
-		mdelay(200);/*delay a moment to wait disk to spinup*/
+		msleep(200);/*delay a moment to wait disk to spinup*/
 	pm8001_bytes_dmaed(pm8001_ha, phy_id);
 }
 
-- 
2.16.3

