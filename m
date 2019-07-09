Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98AF6633D6
	for <lists+linux-scsi@lfdr.de>; Tue,  9 Jul 2019 12:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfGIKAk (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 9 Jul 2019 06:00:40 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:62740 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfGIKAj (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 9 Jul 2019 06:00:39 -0400
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  viswas.g@microsemi.com designates 208.19.100.22 as permitted
  sender) identity=mailfrom; client-ip=208.19.100.22;
  receiver=esa2.microchip.iphmx.com;
  envelope-from="viswas.g@microsemi.com";
  x-sender="viswas.g@microsemi.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:208.19.100.20 ip4:208.19.100.21 ip4:208.19.100.22
  ip4:208.19.100.23 ip4:208.19.99.221 ip4:208.19.99.222
  ip4:208.19.99.223 ip4:208.19.99.225 -all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@smtp.microsemi.com) identity=helo;
  client-ip=208.19.100.22; receiver=esa2.microchip.iphmx.com;
  envelope-from="viswas.g@microsemi.com";
  x-sender="postmaster@smtp.microsemi.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=viswas.g@microsemi.com; spf=None smtp.helo=postmaster@smtp.microsemi.com; dmarc=fail (p=none dis=none) d=microchip.com
IronPort-SDR: MN9stm0p5E4B/SzLfTzl+BOs8xV+nsVHVXPfiQl514qpE51uPG0MJDbF2QCs6b6V1f5yQbDDpz
 ZkK8UXI09J6uEwIxXYQluUq3Tqq6d3l3U82RYWDTT3oMenVs7b0FsKFCVmtxRCruF4Dlxmz6QO
 6vs6LDDG0BM0pWDUdiN/hGU2W9lo7ct2pwJxFnG0sbyfNGYuvm9AQ1xFvZPLAXOgsmCTVIdHcC
 zyBlfJjDSaDz0kqTwgDrP08lw1splOD4GAc6WjFvNzqitB+Ha1ufwXDMmacwAHTY6Bc6rK28w/
 EJU=
X-IronPort-AV: E=Sophos;i="5.63,470,1557212400"; 
   d="scan'208";a="40489615"
Received: from unknown (HELO smtp.microsemi.com) ([208.19.100.22])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jul 2019 03:00:39 -0700
Received: from AVMBX3.microsemi.net (10.100.34.33) by AVMBX2.microsemi.net
 (10.100.34.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 9 Jul 2019
 03:00:38 -0700
Received: from AVMBX2.microsemi.net (10.100.34.32) by AVMBX3.microsemi.net
 (10.100.34.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 9 Jul 2019
 03:00:37 -0700
Received: from localhost (10.41.130.49) by avmbx2.microsemi.net (10.100.34.32)
 with Microsoft SMTP Server id 15.1.1713.5 via Frontend Transport; Tue, 9 Jul
 2019 03:00:37 -0700
From:   Deepak Ukey <deepak.ukey@microchip.com>
To:     <linux-scsi@vger.kernel.org>
CC:     <Vasanthalakshmi.Tharmarajan@microchip.com>,
        <Viswas.G@microchip.com>, <deepak.ukey@microchip.com>,
        <jinpu.wang@cloud.ionos.com>, <martin.petersen@oracle.com>
Subject: [PATCH V2 3/3] pm80xx : Modified the logic to collect IOP event logs.
Date:   Tue, 9 Jul 2019 15:30:50 +0530
Message-ID: <20190709100050.6947-4-deepak.ukey@microchip.com>
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

Added the logic for collecting IOP log respective to event log size.

Signed-off-by: Deepak Ukey <deepak.ukey@microchip.com>
Signed-off-by: Viswas G <Viswas.G@microchip.com>
Reviewed-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/scsi/pm8001/pm8001_ctl.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_ctl.c b/drivers/scsi/pm8001/pm8001_ctl.c
index c7e0a42c..6b85016 100644
--- a/drivers/scsi/pm8001/pm8001_ctl.c
+++ b/drivers/scsi/pm8001/pm8001_ctl.c
@@ -492,25 +492,26 @@ static ssize_t pm8001_ctl_iop_log_show(struct device *cdev,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct sas_ha_struct *sha = SHOST_TO_SAS_HA(shost);
 	struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
-#define IOP_MEMMAP(r, c) \
-	(*(u32 *)((u8*)pm8001_ha->memoryMap.region[IOP].virt_ptr + (r) * 32 \
-	+ (c)))
-	int i;
 	char *str = buf;
-	int max = 2;
-	for (i = 0; i < max; i++) {
-		str += sprintf(str, "0x%08x 0x%08x 0x%08x 0x%08x 0x%08x 0x%08x"
-			       "0x%08x 0x%08x\n",
-			       IOP_MEMMAP(i, 0),
-			       IOP_MEMMAP(i, 4),
-			       IOP_MEMMAP(i, 8),
-			       IOP_MEMMAP(i, 12),
-			       IOP_MEMMAP(i, 16),
-			       IOP_MEMMAP(i, 20),
-			       IOP_MEMMAP(i, 24),
-			       IOP_MEMMAP(i, 28));
+	u32 read_size =
+		pm8001_ha->main_cfg_tbl.pm80xx_tbl.event_log_size / 1024;
+	static u32 start, end, count;
+	u32 max_read_times = 32;
+	u32 max_count = (read_size * 1024) / (max_read_times * 4);
+	u32 *temp = (u32 *)pm8001_ha->memoryMap.region[IOP].virt_ptr;
+
+	if ((count % max_count) == 0) {
+		start = 0;
+		end = max_read_times;
+		count = 0;
+	} else {
+		start = end;
+		end = end + max_read_times;
 	}
 
+	for (; start < end; start++)
+		str += sprintf(str, "%08x ", *(temp+start));
+	count++;
 	return str - buf;
 }
 static DEVICE_ATTR(iop_log, S_IRUGO, pm8001_ctl_iop_log_show, NULL);
-- 
1.8.5.6

