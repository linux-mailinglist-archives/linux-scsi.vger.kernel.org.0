Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB95334881
	for <lists+linux-scsi@lfdr.de>; Wed, 10 Mar 2021 21:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbhCJUBy (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 10 Mar 2021 15:01:54 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:25911 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbhCJUBd (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 10 Mar 2021 15:01:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1615406493; x=1646942493;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=076c7JYcf53rdzBiz9MHCIa5WNfq9ALI7Wz1cU4939E=;
  b=Dhd8Elk+8uuqi6wh+vgqZ0992eYzPCNscFQzohQBfMB+3m6zaAzeR4ek
   JIx+0H1ko7ssiQFJ2aLwHq8FoOlZFgNDCAd9XHvggtW9ZFIPw/tyGPDIi
   +Z0msz0CmqFRNuJ+ffy0o8PTOSnWy/s4xoHCO3o2Po1V/VVc8P9TZp2mW
   bg7u+S9wccE2A/22Dza4E1QDkN/0J46/pl9lZAAI/V+OMu3n0oM0BqFvy
   pfwCnVQF0ltyE7G6nFyDlUMSqXKsHZH6BsdqOpLPcv2yyJhbPSWpaK7EQ
   uDitWrQVwBm31DyBNC6vyd320FyX5L5X7rW8d4SOibXoZ5JlcRvmYcco7
   A==;
IronPort-SDR: 1tKTWDjdGlsr3TJWSDvQRuY8Ox9uW4Y9MWRzNt3u0lFOMud+69ViVK45DIEoAYNj78BegqBERb
 kS2U31kzRupN04JmtRDQEUuHXhHmLnd/302D2ceuvk+e4TcBBGdW5B2PfWSEXapI0xnSTT1GnT
 AhK2/xnDcOYbVwKo+expw/jFbjmOxIWcckvgge6xWUOfvH3nyS8vl7ydmeoPKdm3a4/Pef3QJ3
 bl3gcOU+aBYEWTaq83szItWo72hoPO3Xabx81XuImbtZbHi7ESeptG2NNrA6MmJNAl68+CRyzw
 +pY=
X-IronPort-AV: E=Sophos;i="5.81,238,1610434800"; 
   d="scan'208";a="112731685"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Mar 2021 13:01:32 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 10 Mar 2021 13:01:32 -0700
Received: from [127.0.1.1] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Wed, 10 Mar 2021 13:01:31 -0700
Subject: [PATCH V4 08/31] smartpqi: add support for BMIC sense feature cmd
 and feature bits
From:   Don Brace <don.brace@microchip.com>
To:     <Kevin.Barnett@microchip.com>, <scott.teel@microchip.com>,
        <Justin.Lindley@microchip.com>, <scott.benesh@microchip.com>,
        <gerry.morong@microchip.com>, <mahesh.rajashekhara@microchip.com>,
        <mike.mcgowen@microchip.com>, <hch@infradead.org>,
        <jejb@linux.vnet.ibm.com>, <joseph.szczypek@hpe.com>,
        <POSWALD@suse.com>
CC:     <linux-scsi@vger.kernel.org>
Date:   Wed, 10 Mar 2021 14:01:31 -0600
Message-ID: <161540649171.19430.2996639772830078771.stgit@brunhilda>
In-Reply-To: <161540568064.19430.11157730901022265360.stgit@brunhilda>
References: <161540568064.19430.11157730901022265360.stgit@brunhilda>
User-Agent: StGit/0.23-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Kevin Barnett <kevin.barnett@microchip.com>

* Determine support for supported features from
  BMIC sense feature command instead of config table.
  * Enable features such as: RAID 1/5/6 write support,
    SATA wwid, and encryption.

Reviewed-by: Scott Teel <scott.teel@microchip.com>
Reviewed-by: Mike McGowen <mike.mcgowen@microchip.com>
Reviewed-by: Scott Benesh <scott.benesh@microchip.com>
Signed-off-by: Kevin Barnett <kevin.barnett@microchip.com>
Signed-off-by: Don Brace <don.brace@microchip.com>
---
 drivers/scsi/smartpqi/smartpqi.h      |   70 +++++++
 drivers/scsi/smartpqi/smartpqi_init.c |  337 +++++++++++++++++++++++++++++++--
 2 files changed, 388 insertions(+), 19 deletions(-)

diff --git a/drivers/scsi/smartpqi/smartpqi.h b/drivers/scsi/smartpqi/smartpqi.h
index bed80c4c4598..35e892579773 100644
--- a/drivers/scsi/smartpqi/smartpqi.h
+++ b/drivers/scsi/smartpqi/smartpqi.h
@@ -343,6 +343,10 @@ struct pqi_aio_r1_path_request {
 	struct pqi_sg_descriptor sg_descriptors[PQI_MAX_EMBEDDED_SG_DESCRIPTORS];
 };
 
+#define PQI_DEFAULT_MAX_WRITE_RAID_5_6			(8 * 1024U)
+#define PQI_DEFAULT_MAX_TRANSFER_ENCRYPTED_SAS_SATA	(~0U)
+#define PQI_DEFAULT_MAX_TRANSFER_ENCRYPTED_NVME		(32 * 1024U)
+
 struct pqi_aio_r56_path_request {
 	struct pqi_iu_header header;
 	__le16	request_id;
@@ -826,13 +830,28 @@ struct pqi_config_table_firmware_features {
 	u8	features_supported[];
 /*	u8	features_requested_by_host[]; */
 /*	u8	features_enabled[]; */
+/* The 2 fields below are only valid if the MAX_KNOWN_FEATURE bit is set. */
+/*	__le16	firmware_max_known_feature; */
+/*	__le16	host_max_known_feature; */
 };
 
 #define PQI_FIRMWARE_FEATURE_OFA			0
 #define PQI_FIRMWARE_FEATURE_SMP			1
+#define PQI_FIRMWARE_FEATURE_MAX_KNOWN_FEATURE		2
+#define PQI_FIRMWARE_FEATURE_RAID_0_READ_BYPASS		3
+#define PQI_FIRMWARE_FEATURE_RAID_1_READ_BYPASS		4
+#define PQI_FIRMWARE_FEATURE_RAID_5_READ_BYPASS		5
+#define PQI_FIRMWARE_FEATURE_RAID_6_READ_BYPASS		6
+#define PQI_FIRMWARE_FEATURE_RAID_0_WRITE_BYPASS	7
+#define PQI_FIRMWARE_FEATURE_RAID_1_WRITE_BYPASS	8
+#define PQI_FIRMWARE_FEATURE_RAID_5_WRITE_BYPASS	9
+#define PQI_FIRMWARE_FEATURE_RAID_6_WRITE_BYPASS	10
 #define PQI_FIRMWARE_FEATURE_SOFT_RESET_HANDSHAKE	11
+#define PQI_FIRMWARE_FEATURE_UNIQUE_SATA_WWN		12
 #define PQI_FIRMWARE_FEATURE_RAID_IU_TIMEOUT		13
 #define PQI_FIRMWARE_FEATURE_TMF_IU_TIMEOUT		14
+#define PQI_FIRMWARE_FEATURE_RAID_BYPASS_ON_ENCRYPTED_NVME	15
+#define PQI_FIRMWARE_FEATURE_MAXIMUM				15
 
 struct pqi_config_table_debug {
 	struct pqi_config_table_section_header header;
@@ -1069,6 +1088,7 @@ struct pqi_scsi_dev {
 	bool	raid_bypass_enabled;	/* RAID bypass enabled */
 	u32	next_bypass_group;
 	struct raid_map *raid_map;	/* RAID bypass map */
+	u32	max_transfer_encrypted;
 
 	struct pqi_sas_port *sas_port;
 	struct scsi_device *sdev;
@@ -1276,6 +1296,14 @@ struct pqi_ctrl_info {
 	u8		enable_r1_writes : 1;
 	u8		enable_r5_writes : 1;
 	u8		enable_r6_writes : 1;
+	u8		lv_drive_type_mix_valid : 1;
+
+	u8		ciss_report_log_flags;
+	u32		max_transfer_encrypted_sas_sata;
+	u32		max_transfer_encrypted_nvme;
+	u32		max_write_raid_5_6;
+	u32		max_write_raid_1_10_2drive;
+	u32		max_write_raid_1_10_3drive;
 
 	struct list_head scsi_device_list;
 	spinlock_t	scsi_device_list_lock;
@@ -1336,6 +1364,7 @@ enum pqi_ctrl_mode {
 #define BMIC_IDENTIFY_PHYSICAL_DEVICE		0x15
 #define BMIC_READ				0x26
 #define BMIC_WRITE				0x27
+#define BMIC_SENSE_FEATURE			0x61
 #define BMIC_SENSE_CONTROLLER_PARAMETERS	0x64
 #define BMIC_SENSE_SUBSYSTEM_INFORMATION	0x66
 #define BMIC_CSMI_PASSTHRU			0x68
@@ -1355,6 +1384,19 @@ enum pqi_ctrl_mode {
 	(((CISS_GET_LEVEL_2_BUS((lunid)) - 1) << 8) + \
 	CISS_GET_LEVEL_2_TARGET((lunid)))
 
+#define LV_GET_DRIVE_TYPE_MIX(lunid)		((lunid)[6])
+
+#define LV_DRIVE_TYPE_MIX_UNKNOWN		0
+#define LV_DRIVE_TYPE_MIX_NO_RESTRICTION	1
+#define LV_DRIVE_TYPE_MIX_SAS_HDD_ONLY		2
+#define LV_DRIVE_TYPE_MIX_SATA_HDD_ONLY		3
+#define LV_DRIVE_TYPE_MIX_SAS_OR_SATA_SSD_ONLY	4
+#define LV_DRIVE_TYPE_MIX_SAS_SSD_ONLY		5
+#define LV_DRIVE_TYPE_MIX_SATA_SSD_ONLY		6
+#define LV_DRIVE_TYPE_MIX_SAS_ONLY		7
+#define LV_DRIVE_TYPE_MIX_SATA_ONLY		8
+#define LV_DRIVE_TYPE_MIX_NVME_ONLY		9
+
 #define NO_TIMEOUT		((unsigned long) -1)
 
 #pragma pack(1)
@@ -1468,6 +1510,34 @@ struct bmic_identify_physical_device {
 	u8	padding_to_multiple_of_512[9];
 };
 
+#define BMIC_SENSE_FEATURE_IO_PAGE		0x8
+#define BMIC_SENSE_FEATURE_IO_PAGE_AIO_SUBPAGE	0x2
+
+struct bmic_sense_feature_buffer_header {
+	u8	page_code;
+	u8	subpage_code;
+	__le16	buffer_length;
+};
+
+struct bmic_sense_feature_page_header {
+	u8	page_code;
+	u8	subpage_code;
+	__le16	page_length;
+};
+
+struct bmic_sense_feature_io_page_aio_subpage {
+	struct bmic_sense_feature_page_header header;
+	u8	firmware_read_support;
+	u8	driver_read_support;
+	u8	firmware_write_support;
+	u8	driver_write_support;
+	__le16	max_transfer_encrypted_sas_sata;
+	__le16	max_transfer_encrypted_nvme;
+	__le16	max_write_raid_5_6;
+	__le16	max_write_raid_1_10_2drive;
+	__le16	max_write_raid_1_10_3drive;
+};
+
 struct bmic_smp_request {
 	u8	frame_type;
 	u8	function;
diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index 7eec445fc9d0..5aae36e4cdf3 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -506,7 +506,7 @@ static int pqi_build_raid_path_request(struct pqi_ctrl_info *ctrl_info,
 		if (cmd == CISS_REPORT_PHYS)
 			cdb[1] = CISS_REPORT_PHYS_FLAG_OTHER;
 		else
-			cdb[1] = CISS_REPORT_LOG_FLAG_UNIQUE_LUN_ID;
+			cdb[1] = ctrl_info->ciss_report_log_flags;
 		put_unaligned_be32(cdb_length, &cdb[6]);
 		break;
 	case CISS_GET_RAID_MAP:
@@ -527,6 +527,7 @@ static int pqi_build_raid_path_request(struct pqi_ctrl_info *ctrl_info,
 	case BMIC_IDENTIFY_CONTROLLER:
 	case BMIC_IDENTIFY_PHYSICAL_DEVICE:
 	case BMIC_SENSE_SUBSYSTEM_INFORMATION:
+	case BMIC_SENSE_FEATURE:
 		request->data_direction = SOP_READ_FLAG;
 		cdb[0] = BMIC_READ;
 		cdb[6] = cmd;
@@ -695,6 +696,105 @@ static int pqi_identify_physical_device(struct pqi_ctrl_info *ctrl_info,
 	return rc;
 }
 
+static inline u32 pqi_aio_limit_to_bytes(__le16 *limit)
+{
+	u32 bytes;
+
+	bytes = get_unaligned_le16(limit);
+	if (bytes == 0)
+		bytes = ~0;
+	else
+		bytes *= 1024;
+
+	return bytes;
+}
+
+#pragma pack(1)
+
+struct bmic_sense_feature_buffer {
+	struct bmic_sense_feature_buffer_header header;
+	struct bmic_sense_feature_io_page_aio_subpage aio_subpage;
+};
+
+#pragma pack()
+
+#define MINIMUM_AIO_SUBPAGE_BUFFER_LENGTH	\
+	offsetofend(struct bmic_sense_feature_buffer, \
+		aio_subpage.max_write_raid_1_10_3drive)
+
+#define MINIMUM_AIO_SUBPAGE_LENGTH	\
+	(offsetofend(struct bmic_sense_feature_io_page_aio_subpage, \
+		max_write_raid_1_10_3drive) - \
+		sizeof_field(struct bmic_sense_feature_io_page_aio_subpage, header))
+
+static int pqi_get_advanced_raid_bypass_config(struct pqi_ctrl_info *ctrl_info)
+{
+	int rc;
+	enum dma_data_direction dir;
+	struct pqi_raid_path_request request;
+	struct bmic_sense_feature_buffer *buffer;
+
+	buffer = kmalloc(sizeof(*buffer), GFP_KERNEL);
+	if (!buffer)
+		return -ENOMEM;
+
+	rc = pqi_build_raid_path_request(ctrl_info, &request,
+		BMIC_SENSE_FEATURE, RAID_CTLR_LUNID, buffer,
+		sizeof(*buffer), 0, &dir);
+	if (rc)
+		goto error;
+
+	request.cdb[2] = BMIC_SENSE_FEATURE_IO_PAGE;
+	request.cdb[3] = BMIC_SENSE_FEATURE_IO_PAGE_AIO_SUBPAGE;
+
+	rc = pqi_submit_raid_request_synchronous(ctrl_info, &request.header,
+		0, NULL, NO_TIMEOUT);
+
+	pqi_pci_unmap(ctrl_info->pci_dev, request.sg_descriptors, 1, dir);
+
+	if (rc)
+		goto error;
+
+	if (buffer->header.page_code != BMIC_SENSE_FEATURE_IO_PAGE ||
+		buffer->header.subpage_code !=
+			BMIC_SENSE_FEATURE_IO_PAGE_AIO_SUBPAGE ||
+		get_unaligned_le16(&buffer->header.buffer_length) <
+			MINIMUM_AIO_SUBPAGE_BUFFER_LENGTH ||
+		buffer->aio_subpage.header.page_code !=
+			BMIC_SENSE_FEATURE_IO_PAGE ||
+		buffer->aio_subpage.header.subpage_code !=
+			BMIC_SENSE_FEATURE_IO_PAGE_AIO_SUBPAGE ||
+		get_unaligned_le16(&buffer->aio_subpage.header.page_length) <
+			MINIMUM_AIO_SUBPAGE_LENGTH) {
+		goto error;
+	}
+
+	ctrl_info->max_transfer_encrypted_sas_sata =
+		pqi_aio_limit_to_bytes(
+			&buffer->aio_subpage.max_transfer_encrypted_sas_sata);
+
+	ctrl_info->max_transfer_encrypted_nvme =
+		pqi_aio_limit_to_bytes(
+			&buffer->aio_subpage.max_transfer_encrypted_nvme);
+
+	ctrl_info->max_write_raid_5_6 =
+		pqi_aio_limit_to_bytes(
+			&buffer->aio_subpage.max_write_raid_5_6);
+
+	ctrl_info->max_write_raid_1_10_2drive =
+		pqi_aio_limit_to_bytes(
+			&buffer->aio_subpage.max_write_raid_1_10_2drive);
+
+	ctrl_info->max_write_raid_1_10_3drive =
+		pqi_aio_limit_to_bytes(
+			&buffer->aio_subpage.max_write_raid_1_10_3drive);
+
+error:
+	kfree(buffer);
+
+	return rc;
+}
+
 static int pqi_flush_cache(struct pqi_ctrl_info *ctrl_info,
 	enum bmic_flush_cache_shutdown_event shutdown_event)
 {
@@ -1232,6 +1332,39 @@ static int pqi_get_raid_map(struct pqi_ctrl_info *ctrl_info,
 	return rc;
 }
 
+static void pqi_set_max_transfer_encrypted(struct pqi_ctrl_info *ctrl_info,
+	struct pqi_scsi_dev *device)
+{
+	if (!ctrl_info->lv_drive_type_mix_valid) {
+		device->max_transfer_encrypted = ~0;
+		return;
+	}
+
+	switch (LV_GET_DRIVE_TYPE_MIX(device->scsi3addr)) {
+	case LV_DRIVE_TYPE_MIX_SAS_HDD_ONLY:
+	case LV_DRIVE_TYPE_MIX_SATA_HDD_ONLY:
+	case LV_DRIVE_TYPE_MIX_SAS_OR_SATA_SSD_ONLY:
+	case LV_DRIVE_TYPE_MIX_SAS_SSD_ONLY:
+	case LV_DRIVE_TYPE_MIX_SATA_SSD_ONLY:
+	case LV_DRIVE_TYPE_MIX_SAS_ONLY:
+	case LV_DRIVE_TYPE_MIX_SATA_ONLY:
+		device->max_transfer_encrypted =
+			ctrl_info->max_transfer_encrypted_sas_sata;
+		break;
+	case LV_DRIVE_TYPE_MIX_NVME_ONLY:
+		device->max_transfer_encrypted =
+			ctrl_info->max_transfer_encrypted_nvme;
+		break;
+	case LV_DRIVE_TYPE_MIX_UNKNOWN:
+	case LV_DRIVE_TYPE_MIX_NO_RESTRICTION:
+	default:
+		device->max_transfer_encrypted =
+			min(ctrl_info->max_transfer_encrypted_sas_sata,
+				ctrl_info->max_transfer_encrypted_nvme);
+		break;
+	}
+}
+
 static void pqi_get_raid_bypass_status(struct pqi_ctrl_info *ctrl_info,
 	struct pqi_scsi_dev *device)
 {
@@ -1257,8 +1390,12 @@ static void pqi_get_raid_bypass_status(struct pqi_ctrl_info *ctrl_info,
 		(bypass_status & RAID_BYPASS_CONFIGURED) != 0;
 	if (device->raid_bypass_configured &&
 		(bypass_status & RAID_BYPASS_ENABLED) &&
-		pqi_get_raid_map(ctrl_info, device) == 0)
+		pqi_get_raid_map(ctrl_info, device) == 0) {
 		device->raid_bypass_enabled = true;
+		if (get_unaligned_le16(&device->raid_map->flags) &
+			RAID_MAP_ENCRYPTION_ENABLED)
+			pqi_set_max_transfer_encrypted(ctrl_info, device);
+	}
 
 out:
 	kfree(buffer);
@@ -2028,6 +2165,10 @@ static int pqi_update_scsi_devices(struct pqi_ctrl_info *ctrl_info)
 		}
 	}
 
+	if (num_logicals &&
+		(logdev_list->header.flags & CISS_REPORT_LOG_FLAG_DRIVE_TYPE_MIX))
+		ctrl_info->lv_drive_type_mix_valid = true;
+
 	num_new_devices = num_physicals + num_logicals;
 
 	new_device_list = kmalloc_array(num_new_devices,
@@ -2254,20 +2395,28 @@ static bool pqi_aio_raid_level_supported(struct pqi_ctrl_info *ctrl_info,
 	case SA_RAID_0:
 		break;
 	case SA_RAID_1:
+		if (rmd->is_write && (!ctrl_info->enable_r1_writes ||
+			rmd->data_length > ctrl_info->max_write_raid_1_10_2drive))
+			is_supported = false;
+		break;
 	case SA_RAID_TRIPLE:
-		if (rmd->is_write && !ctrl_info->enable_r1_writes)
+		if (rmd->is_write && (!ctrl_info->enable_r1_writes ||
+			rmd->data_length > ctrl_info->max_write_raid_1_10_3drive))
 			is_supported = false;
 		break;
 	case SA_RAID_5:
-		if (rmd->is_write && !ctrl_info->enable_r5_writes)
+		if (rmd->is_write && (!ctrl_info->enable_r5_writes ||
+			rmd->data_length > ctrl_info->max_write_raid_5_6))
 			is_supported = false;
 		break;
 	case SA_RAID_6:
-		if (rmd->is_write && !ctrl_info->enable_r6_writes)
+		if (rmd->is_write && (!ctrl_info->enable_r6_writes ||
+			rmd->data_length > ctrl_info->max_write_raid_5_6))
 			is_supported = false;
 		break;
 	default:
 		is_supported = false;
+		break;
 	}
 
 	return is_supported;
@@ -2624,7 +2773,9 @@ static int pqi_raid_bypass_submit_scsi_cmd(struct pqi_ctrl_info *ctrl_info,
 	pqi_set_aio_cdb(&rmd);
 
 	if (get_unaligned_le16(&raid_map->flags) &
-		RAID_MAP_ENCRYPTION_ENABLED) {
+			RAID_MAP_ENCRYPTION_ENABLED) {
+		if (rmd.data_length > device->max_transfer_encrypted)
+			return PQI_RAID_BYPASS_INELIGIBLE;
 		pqi_set_encryption_info(&encryption_info, raid_map,
 			rmd.first_block);
 		encryption_info_ptr = &encryption_info;
@@ -2634,10 +2785,6 @@ static int pqi_raid_bypass_submit_scsi_cmd(struct pqi_ctrl_info *ctrl_info,
 
 	if (rmd.is_write) {
 		switch (device->raid_level) {
-		case SA_RAID_0:
-			return pqi_aio_submit_io(ctrl_info, scmd, rmd.aio_handle,
-				rmd.cdb, rmd.cdb_length, queue_group,
-				encryption_info_ptr, true);
 		case SA_RAID_1:
 		case SA_RAID_TRIPLE:
 			return pqi_aio_submit_r1_write_io(ctrl_info, scmd, queue_group,
@@ -2646,17 +2793,12 @@ static int pqi_raid_bypass_submit_scsi_cmd(struct pqi_ctrl_info *ctrl_info,
 		case SA_RAID_6:
 			return pqi_aio_submit_r56_write_io(ctrl_info, scmd, queue_group,
 					encryption_info_ptr, device, &rmd);
-		default:
-			return pqi_aio_submit_io(ctrl_info, scmd, rmd.aio_handle,
-				rmd.cdb, rmd.cdb_length, queue_group,
-				encryption_info_ptr, true);
 		}
-	} else {
-		return pqi_aio_submit_io(ctrl_info, scmd, rmd.aio_handle,
-			rmd.cdb, rmd.cdb_length, queue_group,
-			encryption_info_ptr, true);
 	}
 
+	return pqi_aio_submit_io(ctrl_info, scmd, rmd.aio_handle,
+		rmd.cdb, rmd.cdb_length, queue_group,
+		encryption_info_ptr, true);
 }
 
 #define PQI_STATUS_IDLE		0x0
@@ -7189,6 +7331,7 @@ static int pqi_enable_firmware_features(struct pqi_ctrl_info *ctrl_info,
 {
 	void *features_requested;
 	void __iomem *features_requested_iomem_addr;
+	void __iomem *host_max_known_feature_iomem_addr;
 
 	features_requested = firmware_features->features_supported +
 		le16_to_cpu(firmware_features->num_elements);
@@ -7199,6 +7342,16 @@ static int pqi_enable_firmware_features(struct pqi_ctrl_info *ctrl_info,
 	memcpy_toio(features_requested_iomem_addr, features_requested,
 		le16_to_cpu(firmware_features->num_elements));
 
+	if (pqi_is_firmware_feature_supported(firmware_features,
+		PQI_FIRMWARE_FEATURE_MAX_KNOWN_FEATURE)) {
+		host_max_known_feature_iomem_addr =
+			features_requested_iomem_addr +
+			(le16_to_cpu(firmware_features->num_elements) * 2) +
+			sizeof(__le16);
+		writew(PQI_FIRMWARE_FEATURE_MAXIMUM,
+			host_max_known_feature_iomem_addr);
+	}
+
 	return pqi_config_table_update(ctrl_info,
 		PQI_CONFIG_TABLE_SECTION_FIRMWARE_FEATURES,
 		PQI_CONFIG_TABLE_SECTION_FIRMWARE_FEATURES);
@@ -7236,6 +7389,15 @@ static void pqi_ctrl_update_feature_flags(struct pqi_ctrl_info *ctrl_info,
 	struct pqi_firmware_feature *firmware_feature)
 {
 	switch (firmware_feature->feature_bit) {
+	case PQI_FIRMWARE_FEATURE_RAID_1_WRITE_BYPASS:
+		ctrl_info->enable_r1_writes = firmware_feature->enabled;
+		break;
+	case PQI_FIRMWARE_FEATURE_RAID_5_WRITE_BYPASS:
+		ctrl_info->enable_r5_writes = firmware_feature->enabled;
+		break;
+	case PQI_FIRMWARE_FEATURE_RAID_6_WRITE_BYPASS:
+		ctrl_info->enable_r6_writes = firmware_feature->enabled;
+		break;
 	case PQI_FIRMWARE_FEATURE_SOFT_RESET_HANDSHAKE:
 		ctrl_info->soft_reset_handshake_supported =
 			firmware_feature->enabled;
@@ -7273,6 +7435,51 @@ static struct pqi_firmware_feature pqi_firmware_features[] = {
 		.feature_bit = PQI_FIRMWARE_FEATURE_SMP,
 		.feature_status = pqi_firmware_feature_status,
 	},
+	{
+		.feature_name = "Maximum Known Feature",
+		.feature_bit = PQI_FIRMWARE_FEATURE_MAX_KNOWN_FEATURE,
+		.feature_status = pqi_firmware_feature_status,
+	},
+	{
+		.feature_name = "RAID 0 Read Bypass",
+		.feature_bit = PQI_FIRMWARE_FEATURE_RAID_0_READ_BYPASS,
+		.feature_status = pqi_firmware_feature_status,
+	},
+	{
+		.feature_name = "RAID 1 Read Bypass",
+		.feature_bit = PQI_FIRMWARE_FEATURE_RAID_1_READ_BYPASS,
+		.feature_status = pqi_firmware_feature_status,
+	},
+	{
+		.feature_name = "RAID 5 Read Bypass",
+		.feature_bit = PQI_FIRMWARE_FEATURE_RAID_5_READ_BYPASS,
+		.feature_status = pqi_firmware_feature_status,
+	},
+	{
+		.feature_name = "RAID 6 Read Bypass",
+		.feature_bit = PQI_FIRMWARE_FEATURE_RAID_6_READ_BYPASS,
+		.feature_status = pqi_firmware_feature_status,
+	},
+	{
+		.feature_name = "RAID 0 Write Bypass",
+		.feature_bit = PQI_FIRMWARE_FEATURE_RAID_0_WRITE_BYPASS,
+		.feature_status = pqi_firmware_feature_status,
+	},
+	{
+		.feature_name = "RAID 1 Write Bypass",
+		.feature_bit = PQI_FIRMWARE_FEATURE_RAID_1_WRITE_BYPASS,
+		.feature_status = pqi_ctrl_update_feature_flags,
+	},
+	{
+		.feature_name = "RAID 5 Write Bypass",
+		.feature_bit = PQI_FIRMWARE_FEATURE_RAID_5_WRITE_BYPASS,
+		.feature_status = pqi_ctrl_update_feature_flags,
+	},
+	{
+		.feature_name = "RAID 6 Write Bypass",
+		.feature_bit = PQI_FIRMWARE_FEATURE_RAID_6_WRITE_BYPASS,
+		.feature_status = pqi_ctrl_update_feature_flags,
+	},
 	{
 		.feature_name = "New Soft Reset Handshake",
 		.feature_bit = PQI_FIRMWARE_FEATURE_SOFT_RESET_HANDSHAKE,
@@ -7288,6 +7495,11 @@ static struct pqi_firmware_feature pqi_firmware_features[] = {
 		.feature_bit = PQI_FIRMWARE_FEATURE_TMF_IU_TIMEOUT,
 		.feature_status = pqi_ctrl_update_feature_flags,
 	},
+	{
+		.feature_name = "RAID Bypass on encrypted logical volumes on NVMe",
+		.feature_bit = PQI_FIRMWARE_FEATURE_RAID_BYPASS_ON_ENCRYPTED_NVME,
+		.feature_status = pqi_firmware_feature_status,
+	},
 };
 
 static void pqi_process_firmware_features(
@@ -7372,14 +7584,21 @@ static void pqi_process_firmware_features_section(
 	mutex_unlock(&pqi_firmware_features_mutex);
 }
 
+/*
+ * Reset all controller settings that can be initialized during the processing
+ * of the PQI Configuration Table.
+ */
+
 static int pqi_process_config_table(struct pqi_ctrl_info *ctrl_info)
 {
 	u32 table_length;
 	u32 section_offset;
+	bool firmware_feature_section_present;
 	void __iomem *table_iomem_addr;
 	struct pqi_config_table *config_table;
 	struct pqi_config_table_section_header *section;
 	struct pqi_config_table_section_info section_info;
+	struct pqi_config_table_section_info feature_section_info;
 
 	table_length = ctrl_info->config_table_length;
 	if (table_length == 0)
@@ -7400,6 +7619,7 @@ static int pqi_process_config_table(struct pqi_ctrl_info *ctrl_info)
 		ctrl_info->config_table_offset;
 	memcpy_fromio(config_table, table_iomem_addr, table_length);
 
+	firmware_feature_section_present = false;
 	section_info.ctrl_info = ctrl_info;
 	section_offset =
 		get_unaligned_le32(&config_table->first_section_offset);
@@ -7414,7 +7634,8 @@ static int pqi_process_config_table(struct pqi_ctrl_info *ctrl_info)
 
 		switch (get_unaligned_le16(&section->section_id)) {
 		case PQI_CONFIG_TABLE_SECTION_FIRMWARE_FEATURES:
-			pqi_process_firmware_features_section(&section_info);
+			firmware_feature_section_present = true;
+			feature_section_info = section_info;
 			break;
 		case PQI_CONFIG_TABLE_SECTION_HEARTBEAT:
 			if (pqi_disable_heartbeat)
@@ -7441,6 +7662,14 @@ static int pqi_process_config_table(struct pqi_ctrl_info *ctrl_info)
 			get_unaligned_le16(&section->next_section_offset);
 	}
 
+	/*
+	 * We process the firmware feature section after all other sections
+	 * have been processed so that the feature bit callbacks can take
+	 * into account the settings configured by other sections.
+	 */
+	if (firmware_feature_section_present)
+		pqi_process_firmware_features_section(&feature_section_info);
+
 	kfree(config_table);
 
 	return 0;
@@ -7647,6 +7876,17 @@ static int pqi_ctrl_init(struct pqi_ctrl_info *ctrl_info)
 
 	pqi_start_heartbeat_timer(ctrl_info);
 
+	if (ctrl_info->enable_r5_writes || ctrl_info->enable_r6_writes) {
+		rc = pqi_get_advanced_raid_bypass_config(ctrl_info);
+		if (rc) { /* Supported features not returned correctly. */
+			dev_err(&ctrl_info->pci_dev->dev,
+				"error obtaining advanced RAID bypass configuration\n");
+			return rc;
+		}
+		ctrl_info->ciss_report_log_flags |=
+			CISS_REPORT_LOG_FLAG_DRIVE_TYPE_MIX;
+	}
+
 	rc = pqi_enable_events(ctrl_info);
 	if (rc) {
 		dev_err(&ctrl_info->pci_dev->dev,
@@ -7802,6 +8042,17 @@ static int pqi_ctrl_init_resume(struct pqi_ctrl_info *ctrl_info)
 
 	pqi_start_heartbeat_timer(ctrl_info);
 
+	if (ctrl_info->enable_r5_writes || ctrl_info->enable_r6_writes) {
+		rc = pqi_get_advanced_raid_bypass_config(ctrl_info);
+		if (rc) {
+			dev_err(&ctrl_info->pci_dev->dev,
+				"error obtaining advanced RAID bypass configuration\n");
+			return rc;
+		}
+		ctrl_info->ciss_report_log_flags |=
+			CISS_REPORT_LOG_FLAG_DRIVE_TYPE_MIX;
+	}
+
 	rc = pqi_enable_events(ctrl_info);
 	if (rc) {
 		dev_err(&ctrl_info->pci_dev->dev,
@@ -7965,6 +8216,15 @@ static struct pqi_ctrl_info *pqi_alloc_ctrl_info(int numa_node)
 	ctrl_info->irq_mode = IRQ_MODE_NONE;
 	ctrl_info->max_msix_vectors = PQI_MAX_MSIX_VECTORS;
 
+	ctrl_info->ciss_report_log_flags = CISS_REPORT_LOG_FLAG_UNIQUE_LUN_ID;
+	ctrl_info->max_transfer_encrypted_sas_sata =
+		PQI_DEFAULT_MAX_TRANSFER_ENCRYPTED_SAS_SATA;
+	ctrl_info->max_transfer_encrypted_nvme =
+		PQI_DEFAULT_MAX_TRANSFER_ENCRYPTED_NVME;
+	ctrl_info->max_write_raid_5_6 = PQI_DEFAULT_MAX_WRITE_RAID_5_6;
+	ctrl_info->max_write_raid_1_10_2drive = ~0;
+	ctrl_info->max_write_raid_1_10_3drive = ~0;
+
 	return ctrl_info;
 }
 
@@ -9376,6 +9636,45 @@ static void __attribute__((unused)) verify_structures(void)
 		current_queue_depth_limit) != 1796);
 	BUILD_BUG_ON(sizeof(struct bmic_identify_physical_device) != 2560);
 
+	BUILD_BUG_ON(sizeof(struct bmic_sense_feature_buffer_header) != 4);
+	BUILD_BUG_ON(offsetof(struct bmic_sense_feature_buffer_header,
+		page_code) != 0);
+	BUILD_BUG_ON(offsetof(struct bmic_sense_feature_buffer_header,
+		subpage_code) != 1);
+	BUILD_BUG_ON(offsetof(struct bmic_sense_feature_buffer_header,
+		buffer_length) != 2);
+
+	BUILD_BUG_ON(sizeof(struct bmic_sense_feature_page_header) != 4);
+	BUILD_BUG_ON(offsetof(struct bmic_sense_feature_page_header,
+		page_code) != 0);
+	BUILD_BUG_ON(offsetof(struct bmic_sense_feature_page_header,
+		subpage_code) != 1);
+	BUILD_BUG_ON(offsetof(struct bmic_sense_feature_page_header,
+		page_length) != 2);
+
+	BUILD_BUG_ON(sizeof(struct bmic_sense_feature_io_page_aio_subpage)
+		!= 18);
+	BUILD_BUG_ON(offsetof(struct bmic_sense_feature_io_page_aio_subpage,
+		header) != 0);
+	BUILD_BUG_ON(offsetof(struct bmic_sense_feature_io_page_aio_subpage,
+		firmware_read_support) != 4);
+	BUILD_BUG_ON(offsetof(struct bmic_sense_feature_io_page_aio_subpage,
+		driver_read_support) != 5);
+	BUILD_BUG_ON(offsetof(struct bmic_sense_feature_io_page_aio_subpage,
+		firmware_write_support) != 6);
+	BUILD_BUG_ON(offsetof(struct bmic_sense_feature_io_page_aio_subpage,
+		driver_write_support) != 7);
+	BUILD_BUG_ON(offsetof(struct bmic_sense_feature_io_page_aio_subpage,
+		max_transfer_encrypted_sas_sata) != 8);
+	BUILD_BUG_ON(offsetof(struct bmic_sense_feature_io_page_aio_subpage,
+		max_transfer_encrypted_nvme) != 10);
+	BUILD_BUG_ON(offsetof(struct bmic_sense_feature_io_page_aio_subpage,
+		max_write_raid_5_6) != 12);
+	BUILD_BUG_ON(offsetof(struct bmic_sense_feature_io_page_aio_subpage,
+		max_write_raid_1_10_2drive) != 14);
+	BUILD_BUG_ON(offsetof(struct bmic_sense_feature_io_page_aio_subpage,
+		max_write_raid_1_10_3drive) != 16);
+
 	BUILD_BUG_ON(PQI_ADMIN_IQ_NUM_ELEMENTS > 255);
 	BUILD_BUG_ON(PQI_ADMIN_OQ_NUM_ELEMENTS > 255);
 	BUILD_BUG_ON(PQI_ADMIN_IQ_ELEMENT_LENGTH %

