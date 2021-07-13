Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 871063C7871
	for <lists+linux-scsi@lfdr.de>; Tue, 13 Jul 2021 23:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235936AbhGMVFm (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 13 Jul 2021 17:05:42 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:24255 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235536AbhGMVFf (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 13 Jul 2021 17:05:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1626210165; x=1657746165;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A12LawP3oulzMcsMcOVjEE4RtDeE3oxjrT+YdNBnJlM=;
  b=LADUZM0wnjXRMzVwURsfEVbJReyvgmy2leGDl+sLrQfBTa/ltKbP7aJx
   NeUf9js9WeywV6Zk9R6ZIda9noE1/11MOfHKRyvb34xJjXmemTH4l1GEF
   ihvYC+lGT9DDx6SFy1cAeLhwRm9GXnbQ3BhACK07QoRfsaUglSqWcG9Nr
   9dwxl1Mn26Wwcv9zhMwgyW38D4+2I4XqylPPoIczPwE2z076V5aUB0eTL
   nDxNsea3m4s+36EUr6w5Bt2boIK/F8t/NZleCPV2tdAnk3jEKQ487Nt3+
   4wWT7Qilo6ywCNH8e73SqyU+h6eoMk4rXgNlqzmAv6nufVwnnu4ELpACz
   w==;
IronPort-SDR: DcXKj7Lq9JsM241q2cq5ZpnN7AUjfhFioe/gs/OfeUnHM121s/OouebGIG1VXf2AZwIpxE7iTH
 xGYo6COJlupNqTEUUXjzOtKb13cgTHZSK0H/AEw+3ZTjAfrkoPtqsZpg5F1Mb2DVtzculhqXkZ
 zCspJb1qSObGBnkcLQYlTQexjf6sRLwGMZfaqq69rprDL1VX6SwJwyY8mTTxufCdsp+ZBoF8e0
 o2o5vGNpM+ymW0pHTcdXASIipOFUWqfzeZdKUUCIdowylFcYI2Jxsyxqy1cK/gAWc89f6fDR76
 61E=
X-IronPort-AV: E=Sophos;i="5.84,237,1620716400"; 
   d="scan'208";a="124447486"
Received: from f5out.microchip.com (HELO smtp.microsemi.com) ([198.175.253.81])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jul 2021 14:02:45 -0700
Received: from AUSMBX1.microsemi.net (10.10.76.217) by AVMBX1.microsemi.net
 (10.10.46.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 13 Jul
 2021 14:02:43 -0700
Received: from brunhilda.pdev.net (10.238.32.34) by ausmbx1.microsemi.net
 (10.10.76.217) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Tue, 13 Jul 2021 14:02:43 -0700
Received: by brunhilda.pdev.net (Postfix, from userid 1467)
        id 7E37B7034C6; Tue, 13 Jul 2021 16:02:43 -0500 (CDT)
From:   Don Brace <don.brace@microchip.com>
To:     <hch@infradead.org>, <martin.peterson@oracle.com>,
        <jejb@linux.vnet.ibm.com>, <linux-scsi@vger.kernel.org>
CC:     <Kevin.Barnett@microchip.com>, <scott.teel@microchip.com>,
        <Justin.Lindley@microchip.com>, <scott.benesh@microchip.com>,
        <gerry.morong@microchip.com>, <mahesh.rajashekhara@microchip.com>,
        <mike.mcgowen@microchip.com>, <murthy.bhat@microchip.com>,
        <balsundar.p@microchip.com>, <joseph.szczypek@hpe.com>,
        <jeff@canonical.com>, <POSWALD@suse.com>,
        <john.p.donnelly@oracle.com>, <mwilck@suse.com>,
        <pmenzel@molgen.mpg.de>, <linux-kernel@vger.kernel.org>
Subject: [smartpqi updates V2 PATCH 5/9] smartpqi: add SCSI cmd info for resets
Date:   Tue, 13 Jul 2021 16:02:39 -0500
Message-ID: <20210713210243.40594-6-don.brace@microchip.com>
X-Mailer: git-send-email 2.28.0.rc1.9.ge7ae437ac1
In-Reply-To: <20210713210243.40594-1-don.brace@microchip.com>
References: <20210713210243.40594-1-don.brace@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Murthy Bhat <Murthy.Bhat@microchip.com>

Report on SCSI command that has triggered the reset.
 - Also add check for NULL SCSI commands resulting from
   issuing sg_reset when there is no outstanding commands.

   Example:
   sg_reset -d /dev/sgXY
   smartpqi 0000:39:00.0: resetting scsi 4:0:1:0 due to cmd 0x12

Reviewed-by: Kevin Barnett <kevin.barnett@microchip.com>
Reviewed-by: Mike McGowen <mike.mcgowen@microchip.com>
Reviewed-by: Scott Benesh <scott.benesh@microchip.com>
Reviewed-by: Scott Teel <scott.teel@microchip.com>
Signed-off-by: Murthy Bhat <Murthy.Bhat@microchip.com>
Signed-off-by: Don Brace <don.brace@microchip.com>
---
 drivers/scsi/smartpqi/smartpqi_init.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index 29382b290243..ffc7ca221e27 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -6033,8 +6033,10 @@ static int pqi_eh_device_reset_handler(struct scsi_cmnd *scmd)
 	mutex_lock(&ctrl_info->lun_reset_mutex);
 
 	dev_err(&ctrl_info->pci_dev->dev,
-		"resetting scsi %d:%d:%d:%d\n",
-		shost->host_no, device->bus, device->target, device->lun);
+		"resetting scsi %d:%d:%d:%d due to cmd 0x%02x\n",
+		shost->host_no,
+		device->bus, device->target, device->lun,
+		scmd->cmd_len > 0 ? scmd->cmnd[0] : 0xff);
 
 	pqi_check_ctrl_health(ctrl_info);
 	if (pqi_ctrl_offline(ctrl_info))
-- 
2.28.0.rc1.9.ge7ae437ac1

