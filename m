Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81DE9129D7F
	for <lists+linux-scsi@lfdr.de>; Tue, 24 Dec 2019 05:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfLXEl1 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 23 Dec 2019 23:41:27 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:31043 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbfLXEl0 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 23 Dec 2019 23:41:26 -0500
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  viswas.g@microsemi.com designates 208.19.100.23 as permitted
  sender) identity=mailfrom; client-ip=208.19.100.23;
  receiver=esa6.microchip.iphmx.com;
  envelope-from="viswas.g@microsemi.com";
  x-sender="viswas.g@microsemi.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:208.19.100.20 ip4:208.19.100.21 ip4:208.19.100.22
  ip4:208.19.100.23 ip4:208.19.99.221 ip4:208.19.99.222
  ip4:208.19.99.223 ip4:208.19.99.225 -all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@smtp.microsemi.com) identity=helo;
  client-ip=208.19.100.23; receiver=esa6.microchip.iphmx.com;
  envelope-from="viswas.g@microsemi.com";
  x-sender="postmaster@smtp.microsemi.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=viswas.g@microsemi.com; spf=None smtp.helo=postmaster@smtp.microsemi.com; dmarc=fail (p=none dis=none) d=microchip.com
IronPort-SDR: Fb6DHEzexgFTpUvXXbs7nOAnZ2kk/m49TDcE6fvRXxnyjOFGBbT99jZjUjXgQkpm8PWCKOVa8h
 9RkXgjBcdpm5gUboYAEEOq9sX1NLehkY9NjEzp70YxKuHwYAocDS+/aqmooR78eYFhSLCi6QgC
 22aaAI7odBUeiXMA7u2lO3kYqf1e5UClTkpI847ZssP/iWBs7XZV05sBP/8YoMNjht2B20X26P
 VreSYf5byqaZIR583V7ysV9KaweyISPzsuuLYiMRnVPgieqT7wBlLu8pFzJG++8vCzbM3HT9yj
 hR4=
X-IronPort-AV: E=Sophos;i="5.69,350,1571727600"; 
   d="scan'208";a="58809228"
Received: from unknown (HELO smtp.microsemi.com) ([208.19.100.23])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Dec 2019 21:41:20 -0700
Received: from AVMBX2.microsemi.net (10.100.34.32) by AVMBX3.microsemi.net
 (10.100.34.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Mon, 23 Dec
 2019 20:41:19 -0800
Received: from localhost (10.41.130.49) by avmbx2.microsemi.net (10.100.34.32)
 with Microsoft SMTP Server id 15.1.1847.3 via Frontend Transport; Mon, 23 Dec
 2019 20:41:18 -0800
From:   Deepak Ukey <deepak.ukey@microchip.com>
To:     <linux-scsi@vger.kernel.org>
CC:     <Vasanthalakshmi.Tharmarajan@microchip.com>,
        <Viswas.G@microchip.com>, <deepak.ukey@microchip.com>,
        <jinpu.wang@profitbricks.com>, <martin.petersen@oracle.com>,
        <dpf@google.com>, <yuuzheng@google.com>, <auradkar@google.com>,
        <vishakhavc@google.com>, <bjashnani@google.com>,
        <radha@google.com>, <akshatzen@google.com>
Subject: [PATCH 11/12] pm80xx : Introduce read and write length for IOCTL payload structure.
Date:   Tue, 24 Dec 2019 10:11:42 +0530
Message-ID: <20191224044143.8178-12-deepak.ukey@microchip.com>
X-Mailer: git-send-email 2.19.0-rc1
In-Reply-To: <20191224044143.8178-1-deepak.ukey@microchip.com>
References: <20191224044143.8178-1-deepak.ukey@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Viswas G <Viswas.G@microchip.com>

Removed the common length and introduce read and write length for
IOCTL payload structure.

Signed-off-by: Deepak Ukey <deepak.ukey@microchip.com>
Signed-off-by: Viswas G <Viswas.G@microchip.com>
Signed-off-by: Vishakha Channapattan <vishakhavc@google.com>
Signed-off-by: Bhavesh Jashnani <bjashnani@google.com>
Signed-off-by: Radha Ramachandran <radha@google.com>
Signed-off-by: Akshat Jain <akshatzen@google.com>
Signed-off-by: Yu Zheng <yuuzheng@google.com>
---
 drivers/scsi/pm8001/pm8001_ctl.c  |  6 +++---
 drivers/scsi/pm8001/pm8001_hwi.c  | 22 +++++++++++-----------
 drivers/scsi/pm8001/pm8001_init.c | 12 ++++++------
 drivers/scsi/pm8001/pm8001_sas.h  |  3 ++-
 4 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_ctl.c b/drivers/scsi/pm8001/pm8001_ctl.c
index 669c60a8d123..63bd2a384d2e 100644
--- a/drivers/scsi/pm8001/pm8001_ctl.c
+++ b/drivers/scsi/pm8001/pm8001_ctl.c
@@ -486,7 +486,7 @@ static ssize_t pm8001_ctl_bios_version_show(struct device *cdev,
 	pm8001_ha->nvmd_completion = &completion;
 	payload.minor_function = 7;
 	payload.offset = 0;
-	payload.length = 4096;
+	payload.rd_length = 4096;
 	payload.func_specific = kzalloc(4096, GFP_KERNEL);
 	if (!payload.func_specific)
 		return -ENOMEM;
@@ -697,7 +697,7 @@ static int pm8001_set_nvmd(struct pm8001_hba_info *pm8001_ha)
 	payload = (struct pm8001_ioctl_payload *)ioctlbuffer;
 	memcpy((u8 *)&payload->func_specific, (u8 *)pm8001_ha->fw_image->data,
 				pm8001_ha->fw_image->size);
-	payload->length = pm8001_ha->fw_image->size;
+	payload->wr_length = pm8001_ha->fw_image->size;
 	payload->id = 0;
 	payload->minor_function = 0x1;
 	pm8001_ha->nvmd_completion = &completion;
@@ -743,7 +743,7 @@ static int pm8001_update_flash(struct pm8001_hba_info *pm8001_ha)
 					IOCTL_BUF_SIZE);
 		for (loopNumber = 0; loopNumber < loopcount; loopNumber++) {
 			payload = (struct pm8001_ioctl_payload *)ioctlbuffer;
-			payload->length = 1024*16;
+			payload->wr_length = 1024*16;
 			payload->id = 0;
 			fwControl =
 			      (struct fw_control_info *)&payload->func_specific;
diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
index f9395d9fd530..16dc7a92ad68 100644
--- a/drivers/scsi/pm8001/pm8001_hwi.c
+++ b/drivers/scsi/pm8001/pm8001_hwi.c
@@ -4841,7 +4841,7 @@ int pm8001_chip_get_nvmd_req(struct pm8001_hba_info *pm8001_ha,
 	if (!fw_control_context)
 		return -ENOMEM;
 	fw_control_context->usrAddr = (u8 *)ioctl_payload->func_specific;
-	fw_control_context->len = ioctl_payload->length;
+	fw_control_context->len = ioctl_payload->rd_length;
 	circularQ = &pm8001_ha->inbnd_q_tbl[0];
 	memset(&nvmd_req, 0, sizeof(nvmd_req));
 	rc = pm8001_tag_alloc(pm8001_ha, &tag);
@@ -4862,7 +4862,7 @@ int pm8001_chip_get_nvmd_req(struct pm8001_hba_info *pm8001_ha,
 
 		nvmd_req.len_ir_vpdd = cpu_to_le32(IPMode | twi_addr << 16 |
 			twi_page_size << 8 | TWI_DEVICE);
-		nvmd_req.resp_len = cpu_to_le32(ioctl_payload->length);
+		nvmd_req.resp_len = cpu_to_le32(ioctl_payload->rd_length);
 		nvmd_req.resp_addr_hi =
 		    cpu_to_le32(pm8001_ha->memoryMap.region[NVMD].phys_addr_hi);
 		nvmd_req.resp_addr_lo =
@@ -4871,7 +4871,7 @@ int pm8001_chip_get_nvmd_req(struct pm8001_hba_info *pm8001_ha,
 	}
 	case C_SEEPROM: {
 		nvmd_req.len_ir_vpdd = cpu_to_le32(IPMode | C_SEEPROM);
-		nvmd_req.resp_len = cpu_to_le32(ioctl_payload->length);
+		nvmd_req.resp_len = cpu_to_le32(ioctl_payload->rd_length);
 		nvmd_req.resp_addr_hi =
 		    cpu_to_le32(pm8001_ha->memoryMap.region[NVMD].phys_addr_hi);
 		nvmd_req.resp_addr_lo =
@@ -4880,7 +4880,7 @@ int pm8001_chip_get_nvmd_req(struct pm8001_hba_info *pm8001_ha,
 	}
 	case VPD_FLASH: {
 		nvmd_req.len_ir_vpdd = cpu_to_le32(IPMode | VPD_FLASH);
-		nvmd_req.resp_len = cpu_to_le32(ioctl_payload->length);
+		nvmd_req.resp_len = cpu_to_le32(ioctl_payload->rd_length);
 		nvmd_req.resp_addr_hi =
 		    cpu_to_le32(pm8001_ha->memoryMap.region[NVMD].phys_addr_hi);
 		nvmd_req.resp_addr_lo =
@@ -4889,7 +4889,7 @@ int pm8001_chip_get_nvmd_req(struct pm8001_hba_info *pm8001_ha,
 	}
 	case EXPAN_ROM: {
 		nvmd_req.len_ir_vpdd = cpu_to_le32(IPMode | EXPAN_ROM);
-		nvmd_req.resp_len = cpu_to_le32(ioctl_payload->length);
+		nvmd_req.resp_len = cpu_to_le32(ioctl_payload->rd_length);
 		nvmd_req.resp_addr_hi =
 		    cpu_to_le32(pm8001_ha->memoryMap.region[NVMD].phys_addr_hi);
 		nvmd_req.resp_addr_lo =
@@ -4898,7 +4898,7 @@ int pm8001_chip_get_nvmd_req(struct pm8001_hba_info *pm8001_ha,
 	}
 	case IOP_RDUMP: {
 		nvmd_req.len_ir_vpdd = cpu_to_le32(IPMode | IOP_RDUMP);
-		nvmd_req.resp_len = cpu_to_le32(ioctl_payload->length);
+		nvmd_req.resp_len = cpu_to_le32(ioctl_payload->rd_length);
 		nvmd_req.vpd_offset = cpu_to_le32(ioctl_payload->offset);
 		nvmd_req.resp_addr_hi =
 		cpu_to_le32(pm8001_ha->memoryMap.region[NVMD].phys_addr_hi);
@@ -4938,7 +4938,7 @@ int pm8001_chip_set_nvmd_req(struct pm8001_hba_info *pm8001_ha,
 	circularQ = &pm8001_ha->inbnd_q_tbl[0];
 	memcpy(pm8001_ha->memoryMap.region[NVMD].virt_ptr,
 		&ioctl_payload->func_specific,
-		ioctl_payload->length);
+		ioctl_payload->wr_length);
 	memset(&nvmd_req, 0, sizeof(nvmd_req));
 	rc = pm8001_tag_alloc(pm8001_ha, &tag);
 	if (rc) {
@@ -4957,7 +4957,7 @@ int pm8001_chip_set_nvmd_req(struct pm8001_hba_info *pm8001_ha,
 		nvmd_req.reserved[0] = cpu_to_le32(0xFEDCBA98);
 		nvmd_req.len_ir_vpdd = cpu_to_le32(IPMode | twi_addr << 16 |
 			twi_page_size << 8 | TWI_DEVICE);
-		nvmd_req.resp_len = cpu_to_le32(ioctl_payload->length);
+		nvmd_req.resp_len = cpu_to_le32(ioctl_payload->wr_length);
 		nvmd_req.resp_addr_hi =
 		    cpu_to_le32(pm8001_ha->memoryMap.region[NVMD].phys_addr_hi);
 		nvmd_req.resp_addr_lo =
@@ -4966,7 +4966,7 @@ int pm8001_chip_set_nvmd_req(struct pm8001_hba_info *pm8001_ha,
 	}
 	case C_SEEPROM:
 		nvmd_req.len_ir_vpdd = cpu_to_le32(IPMode | C_SEEPROM);
-		nvmd_req.resp_len = cpu_to_le32(ioctl_payload->length);
+		nvmd_req.resp_len = cpu_to_le32(ioctl_payload->wr_length);
 		nvmd_req.reserved[0] = cpu_to_le32(0xFEDCBA98);
 		nvmd_req.resp_addr_hi =
 		    cpu_to_le32(pm8001_ha->memoryMap.region[NVMD].phys_addr_hi);
@@ -4975,7 +4975,7 @@ int pm8001_chip_set_nvmd_req(struct pm8001_hba_info *pm8001_ha,
 		break;
 	case VPD_FLASH:
 		nvmd_req.len_ir_vpdd = cpu_to_le32(IPMode | VPD_FLASH);
-		nvmd_req.resp_len = cpu_to_le32(ioctl_payload->length);
+		nvmd_req.resp_len = cpu_to_le32(ioctl_payload->wr_length);
 		nvmd_req.reserved[0] = cpu_to_le32(0xFEDCBA98);
 		nvmd_req.resp_addr_hi =
 		    cpu_to_le32(pm8001_ha->memoryMap.region[NVMD].phys_addr_hi);
@@ -4984,7 +4984,7 @@ int pm8001_chip_set_nvmd_req(struct pm8001_hba_info *pm8001_ha,
 		break;
 	case EXPAN_ROM:
 		nvmd_req.len_ir_vpdd = cpu_to_le32(IPMode | EXPAN_ROM);
-		nvmd_req.resp_len = cpu_to_le32(ioctl_payload->length);
+		nvmd_req.resp_len = cpu_to_le32(ioctl_payload->wr_length);
 		nvmd_req.reserved[0] = cpu_to_le32(0xFEDCBA98);
 		nvmd_req.resp_addr_hi =
 		    cpu_to_le32(pm8001_ha->memoryMap.region[NVMD].phys_addr_hi);
diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index b74282bc1ed0..6e037638656d 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -643,22 +643,22 @@ static void pm8001_init_sas_add(struct pm8001_hba_info *pm8001_ha)
 	if (pm8001_ha->chip_id == chip_8001) {
 		if (deviceid == 0x8081 || deviceid == 0x0042) {
 			payload.minor_function = 4;
-			payload.length = 4096;
+			payload.rd_length = 4096;
 		} else {
 			payload.minor_function = 0;
-			payload.length = 128;
+			payload.rd_length = 128;
 		}
 	} else if ((pm8001_ha->chip_id == chip_8070 ||
 			pm8001_ha->chip_id == chip_8072) &&
 			pm8001_ha->pdev->subsystem_vendor == PCI_VENDOR_ID_ATTO) {
 		payload.minor_function = 4;
-		payload.length = 4096;
+		payload.rd_length = 4096;
 	} else {
 		payload.minor_function = 1;
-		payload.length = 4096;
+		payload.rd_length = 4096;
 	}
 	payload.offset = 0;
-	payload.func_specific = kzalloc(payload.length, GFP_KERNEL);
+	payload.func_specific = kzalloc(payload.rd_length, GFP_KERNEL);
 	if (!payload.func_specific) {
 		PM8001_INIT_DBG(pm8001_ha, pm8001_printk("mem alloc fail\n"));
 		return;
@@ -728,7 +728,7 @@ static int pm8001_get_phy_settings_info(struct pm8001_hba_info *pm8001_ha)
 	/* SAS ADDRESS read from flash / EEPROM */
 	payload.minor_function = 6;
 	payload.offset = 0;
-	payload.length = 4096;
+	payload.rd_length = 4096;
 	payload.func_specific = kzalloc(4096, GFP_KERNEL);
 	if (!payload.func_specific)
 		return -ENOMEM;
diff --git a/drivers/scsi/pm8001/pm8001_sas.h b/drivers/scsi/pm8001/pm8001_sas.h
index 47607a25f819..917a17f4d595 100644
--- a/drivers/scsi/pm8001/pm8001_sas.h
+++ b/drivers/scsi/pm8001/pm8001_sas.h
@@ -164,10 +164,11 @@ struct pm8001_ioctl_payload {
 	u32	signature;
 	u16	major_function;
 	u16	minor_function;
-	u16	length;
 	u16	status;
 	u16	offset;
 	u16	id;
+	u32	wr_length;
+	u32	rd_length;
 	u8	*func_specific;
 };
 
-- 
2.16.3

