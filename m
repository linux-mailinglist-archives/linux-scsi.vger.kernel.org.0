Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 575012D33E4
	for <lists+linux-scsi@lfdr.de>; Tue,  8 Dec 2020 21:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731163AbgLHUQF (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 8 Dec 2020 15:16:05 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:21474 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731155AbgLHUP2 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 8 Dec 2020 15:15:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1607458527; x=1638994527;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IKBKQQP90EW8AQFornZGaSlULl2sX9pD1xrjWlgPEvo=;
  b=rHPBzqPJbxT9tft8G16itrwP1Kowt90X0V0Rvebo04UGGcUSAYGVbuWj
   SlTN1KKZ1AK5N/J+AicipRTE8phh6RSRpkcMOeZcblEOoKde1hxSd6n1S
   yJxSeeW5H9J0D/rYturfEEKaXf7TZBp55lcA1dw9F2wTt65XxcMKOHwr5
   /1c8UkLALN9DN0hWrcmsZFd7fY7LeIJytlfePVlSrFNPU0BfB9+Ro0iUD
   prESdUVoaOibPqAtqtIMCACcE/WQz0nUCutW7ZDTWgsV/9dOyYFp/3iwc
   jtYXeNyds3E+u/GJxr31Gzu2wJiK/iqk9pvVjDgMmf5kIuIH9D73NOunA
   A==;
IronPort-SDR: 21ospDqXvvzkwBFHDuOGAOzKcNJKjY+WQhIpdadPN8moGV+m5YP70EJsfcmOZEMmmBeY61DfCc
 0A5YMNVFAIws4Ow1F0jWFGK48RzA+f0l4SB6HLQ90/DtaC/JOGTv/CJGMuUZic/WkrG5JHuYfr
 pp1QRR/TFsqASMsOBjfw1+fvxU/5nrL0Qpk95NekG+zpWhXlPvK0pHiS781KOq8QuLlxE+tRxA
 bd1fwgXSADlGtSgJ0jLt5HsSO931YSrMRyGVr9k0yb3Bvs1GbP7/mEWuzoiF1mGVu7ynr4SIo6
 fdU=
X-IronPort-AV: E=Sophos;i="5.78,403,1599548400"; 
   d="scan'208";a="106782227"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Dec 2020 12:37:10 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 8 Dec 2020 12:37:10 -0700
Received: from [127.0.1.1] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Tue, 8 Dec 2020 12:37:10 -0700
Subject: [PATCH V2 06/25] smartpqi: add support for BMIC sense feature cmd
 and feature bits
From:   Don Brace <don.brace@microchip.com>
To:     <Kevin.Barnett@microchip.com>, <scott.teel@microchip.com>,
        <Justin.Lindley@microchip.com>, <scott.benesh@microchip.com>,
        <gerry.morong@microchip.com>, <mahesh.rajashekhara@microchip.com>,
        <hch@infradead.org>, <jejb@linux.vnet.ibm.com>,
        <joseph.szczypek@hpe.com>, <POSWALD@suse.com>
CC:     <linux-scsi@vger.kernel.org>
Date:   Tue, 8 Dec 2020 13:37:09 -0600
Message-ID: <160745622993.13450.10623765011955455273.stgit@brunhilda>
In-Reply-To: <160745609917.13450.11882890596851148601.stgit@brunhilda>
References: <160745609917.13450.11882890596851148601.stgit@brunhilda>
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

Reviewed-by: Scott Teel <scott.teel@microchip.com>
Reviewed-by: Scott Benesh <scott.benesh@microchip.com>
Signed-off-by: Kevin Barnett <kevin.barnett@microchip.com>
Signed-off-by: Don Brace <don.brace@microchip.com>
---
 drivers/scsi/smartpqi/smartpqi.h      |   77 +++++++-
 drivers/scsi/smartpqi/smartpqi_init.c |  328 +++++++++++++++++++++++++++++----
 2 files changed, 363 insertions(+), 42 deletions(-)

diff --git a/drivers/scsi/smartpqi/smartpqi.h b/drivers/scsi/smartpqi/smartpqi.h
index 225ec6843c68..31281cddadfe 100644
--- a/drivers/scsi/smartpqi/smartpqi.h
+++ b/drivers/scsi/smartpqi/smartpqi.h
@@ -314,6 +314,7 @@ struct pqi_aio_path_request {
 };
 
 #define PQI_RAID1_NVME_XFER_LIMIT	(32 * 1024)	/* 32 KiB */
+
 struct pqi_aio_r1_path_request {
 	struct pqi_iu_header header;
 	__le16	request_id;
@@ -343,8 +344,10 @@ struct pqi_aio_r1_path_request {
 	struct pqi_sg_descriptor sg_descriptors[PQI_MAX_EMBEDDED_SG_DESCRIPTORS];
 };
 
-#define PQI_RAID56_XFER_LIMIT_4K	0x1000 /* 4Kib */
-#define PQI_RAID56_XFER_LIMIT_8K	0x2000 /* 8Kib */
+#define PQI_DEFAULT_MAX_WRITE_RAID_5_6			(8 * 1024U)
+#define PQI_DEFAULT_MAX_TRANSFER_ENCRYPTED_SAS_SATA	(~0U)
+#define PQI_DEFAULT_MAX_TRANSFER_ENCRYPTED_NVME		(32 * 1024U)
+
 struct pqi_aio_r56_path_request {
 	struct pqi_iu_header header;
 	__le16	request_id;
@@ -355,7 +358,7 @@ struct pqi_aio_r56_path_request {
 	__le32	data_length;		/* total bytes to read/write */
 	u8	data_direction : 2;
 	u8	partial : 1;
-	u8	mem_type : 1;		/* 0b: PCIe, 1b: DDR */
+	u8	mem_type : 1;		/* 0 = PCIe, 1 = DDR */
 	u8	fence : 1;
 	u8	encryption_enable : 1;
 	u8	reserved : 2;
@@ -371,7 +374,7 @@ struct pqi_aio_r56_path_request {
 	u8	reserved2[3];
 	__le32	encrypt_tweak_lower;
 	__le32	encrypt_tweak_upper;
-	u8	row;			/* row = logical lba/blocks per row */
+	__le64	row;			/* row = logical LBA/blocks per row */
 	u8	reserved3[8];
 	struct pqi_sg_descriptor sg_descriptors[PQI_MAX_EMBEDDED_R56_SG_DESCRIPTORS];
 };
@@ -828,13 +831,27 @@ struct pqi_config_table_firmware_features {
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
+#define PQI_FIRMWARE_FEATURE_MAXIMUM			14
 
 struct pqi_config_table_debug {
 	struct pqi_config_table_section_header header;
@@ -1010,12 +1027,12 @@ struct pqi_scsi_dev_raid_map_data {
 	u8	cdb[16];
 	u8	cdb_length;
 
-	/* RAID1 specific */
+	/* RAID 1 specific */
 #define NUM_RAID1_MAP_ENTRIES 3
 	u32	num_it_nexus_entries;
 	u32	it_nexus[NUM_RAID1_MAP_ENTRIES];
 
-	/* RAID5 RAID6 specific */
+	/* RAID 5 / RAID 6 specific */
 	u32	p_parity_it_nexus; /* aio_handle */
 	u32	q_parity_it_nexus; /* aio_handle */
 	u8	xor_mult;
@@ -1071,6 +1088,7 @@ struct pqi_scsi_dev {
 	bool	raid_bypass_enabled;	/* RAID bypass enabled */
 	u32	next_bypass_group;
 	struct raid_map *raid_map;	/* RAID bypass map */
+	u32	max_transfer_encrypted;
 
 	struct pqi_sas_port *sas_port;
 	struct scsi_device *sdev;
@@ -1278,6 +1296,13 @@ struct pqi_ctrl_info {
 	u8		enable_r1_writes : 1;
 	u8		enable_r5_writes : 1;
 	u8		enable_r6_writes : 1;
+	u8		lv_drive_type_mix_valid : 1;
+
+	u8		ciss_report_log_flags;
+	u32		max_transfer_encrypted_sas_sata;
+	u32		max_transfer_encrypted_nvme;
+	u32		max_write_raid_5_6;
+
 
 	struct list_head scsi_device_list;
 	spinlock_t	scsi_device_list_lock;
@@ -1338,6 +1363,7 @@ enum pqi_ctrl_mode {
 #define BMIC_IDENTIFY_PHYSICAL_DEVICE		0x15
 #define BMIC_READ				0x26
 #define BMIC_WRITE				0x27
+#define BMIC_SENSE_FEATURE			0x61
 #define BMIC_SENSE_CONTROLLER_PARAMETERS	0x64
 #define BMIC_SENSE_SUBSYSTEM_INFORMATION	0x66
 #define BMIC_CSMI_PASSTHRU			0x68
@@ -1357,6 +1383,19 @@ enum pqi_ctrl_mode {
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
@@ -1470,6 +1509,32 @@ struct bmic_identify_physical_device {
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
+};
+
 struct bmic_smp_request {
 	u8	frame_type;
 	u8	function;
diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index e8e905336c86..b00ccc02154c 100644
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
@@ -695,6 +696,97 @@ static int pqi_identify_physical_device(struct pqi_ctrl_info *ctrl_info,
 	return rc;
 }
 
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
+		aio_subpage.max_write_raid_5_6)
+
+#define MINIMUM_AIO_SUBPAGE_LENGTH	\
+	(offsetofend(struct bmic_sense_feature_io_page_aio_subpage, \
+		max_write_raid_5_6) - \
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
+		rc = -EINVAL;
+		goto error;
+	}
+
+	ctrl_info->max_transfer_encrypted_sas_sata =
+		get_unaligned_le16(
+			&buffer->aio_subpage.max_transfer_encrypted_sas_sata);
+	if (ctrl_info->max_transfer_encrypted_sas_sata)
+		ctrl_info->max_transfer_encrypted_sas_sata *= 1024;
+	else
+		ctrl_info->max_transfer_encrypted_sas_sata = ~0;
+
+	ctrl_info->max_transfer_encrypted_nvme =
+		get_unaligned_le16(
+			&buffer->aio_subpage.max_transfer_encrypted_nvme);
+	if (ctrl_info->max_transfer_encrypted_nvme)
+		ctrl_info->max_transfer_encrypted_nvme *= 1024;
+	else
+		ctrl_info->max_transfer_encrypted_nvme = ~0;
+
+	ctrl_info->max_write_raid_5_6 =
+		get_unaligned_le16(
+			&buffer->aio_subpage.max_write_raid_5_6);
+	if (ctrl_info->max_write_raid_5_6)
+		ctrl_info->max_write_raid_5_6 *= 1024;
+	else
+		ctrl_info->max_write_raid_5_6 = ~0;
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
@@ -1232,6 +1324,39 @@ static int pqi_get_raid_map(struct pqi_ctrl_info *ctrl_info,
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
@@ -1257,8 +1382,12 @@ static void pqi_get_raid_bypass_status(struct pqi_ctrl_info *ctrl_info,
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
@@ -2028,6 +2157,10 @@ static int pqi_update_scsi_devices(struct pqi_ctrl_info *ctrl_info)
 		}
 	}
 
+	if (num_logicals &&
+		(logdev_list->header.flags & CISS_REPORT_LOG_FLAG_DRIVE_TYPE_MIX))
+		ctrl_info->lv_drive_type_mix_valid = true;
+
 	num_new_devices = num_physicals + num_logicals;
 
 	new_device_list = kmalloc_array(num_new_devices,
@@ -2260,15 +2393,18 @@ static bool pqi_aio_raid_level_supported(struct pqi_ctrl_info *ctrl_info,
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
@@ -2277,7 +2413,7 @@ static bool pqi_aio_raid_level_supported(struct pqi_ctrl_info *ctrl_info,
 #define PQI_RAID_BYPASS_INELIGIBLE	1
 
 static int pqi_get_aio_lba_and_block_count(struct scsi_cmnd *scmd,
-			struct pqi_scsi_dev_raid_map_data *rmd)
+	struct pqi_scsi_dev_raid_map_data *rmd)
 {
 	/* Check for valid opcode, get LBA and block count. */
 	switch (scmd->cmnd[0]) {
@@ -2323,8 +2459,7 @@ static int pqi_get_aio_lba_and_block_count(struct scsi_cmnd *scmd,
 }
 
 static int pci_get_aio_common_raid_map_values(struct pqi_ctrl_info *ctrl_info,
-					struct pqi_scsi_dev_raid_map_data *rmd,
-					struct raid_map *raid_map)
+	struct pqi_scsi_dev_raid_map_data *rmd, struct raid_map *raid_map)
 {
 #if BITS_PER_LONG == 32
 	u64 tmpdiv;
@@ -2339,7 +2474,7 @@ static int pci_get_aio_common_raid_map_values(struct pqi_ctrl_info *ctrl_info,
 		return PQI_RAID_BYPASS_INELIGIBLE;
 
 	rmd->data_disks_per_row =
-			get_unaligned_le16(&raid_map->data_disks_per_row);
+		get_unaligned_le16(&raid_map->data_disks_per_row);
 	rmd->strip_size = get_unaligned_le16(&raid_map->strip_size);
 	rmd->layout_map_count = get_unaligned_le16(&raid_map->layout_map_count);
 
@@ -2364,16 +2499,16 @@ static int pci_get_aio_common_raid_map_values(struct pqi_ctrl_info *ctrl_info,
 	rmd->first_row = rmd->first_block / rmd->blocks_per_row;
 	rmd->last_row = rmd->last_block / rmd->blocks_per_row;
 	rmd->first_row_offset = (u32)(rmd->first_block -
-				(rmd->first_row * rmd->blocks_per_row));
+		(rmd->first_row * rmd->blocks_per_row));
 	rmd->last_row_offset = (u32)(rmd->last_block - (rmd->last_row *
-				rmd->blocks_per_row));
+		rmd->blocks_per_row));
 	rmd->first_column = rmd->first_row_offset / rmd->strip_size;
 	rmd->last_column = rmd->last_row_offset / rmd->strip_size;
 #endif
 
 	/* If this isn't a single row/column then give to the controller. */
 	if (rmd->first_row != rmd->last_row ||
-			rmd->first_column != rmd->last_column)
+		rmd->first_column != rmd->last_column)
 		return PQI_RAID_BYPASS_INELIGIBLE;
 
 	/* Proceeding with driver mapping. */
@@ -2383,19 +2518,19 @@ static int pci_get_aio_common_raid_map_values(struct pqi_ctrl_info *ctrl_info,
 		raid_map->parity_rotation_shift)) %
 		get_unaligned_le16(&raid_map->row_cnt);
 	rmd->map_index = (rmd->map_row * rmd->total_disks_per_row) +
-			rmd->first_column;
+		rmd->first_column;
 
 	return 0;
 }
 
 static int pqi_calc_aio_r5_or_r6(struct pqi_scsi_dev_raid_map_data *rmd,
-				struct raid_map *raid_map)
+	struct raid_map *raid_map)
 {
 #if BITS_PER_LONG == 32
 	u64 tmpdiv;
 #endif
 	/* RAID 50/60 */
-	/* Verify first and last block are in same RAID group */
+	/* Verify first and last block are in same RAID group. */
 	rmd->stripesize = rmd->blocks_per_row * rmd->layout_map_count;
 #if BITS_PER_LONG == 32
 	tmpdiv = rmd->first_block;
@@ -2415,7 +2550,7 @@ static int pqi_calc_aio_r5_or_r6(struct pqi_scsi_dev_raid_map_data *rmd,
 	if (rmd->first_group != rmd->last_group)
 		return PQI_RAID_BYPASS_INELIGIBLE;
 
-	/* Verify request is in a single row of RAID 5/6 */
+	/* Verify request is in a single row of RAID 5/6. */
 #if BITS_PER_LONG == 32
 	tmpdiv = rmd->first_block;
 	do_div(tmpdiv, rmd->stripesize);
@@ -2432,7 +2567,7 @@ static int pqi_calc_aio_r5_or_r6(struct pqi_scsi_dev_raid_map_data *rmd,
 	if (rmd->r5or6_first_row != rmd->r5or6_last_row)
 		return PQI_RAID_BYPASS_INELIGIBLE;
 
-	/* Verify request is in a single column */
+	/* Verify request is in a single column. */
 #if BITS_PER_LONG == 32
 	tmpdiv = rmd->first_block;
 	rmd->first_row_offset = do_div(tmpdiv, rmd->stripesize);
@@ -2451,23 +2586,22 @@ static int pqi_calc_aio_r5_or_r6(struct pqi_scsi_dev_raid_map_data *rmd,
 	rmd->r5or6_last_column = tmpdiv;
 #else
 	rmd->first_row_offset = rmd->r5or6_first_row_offset =
-		(u32)((rmd->first_block %
-				rmd->stripesize) %
-				rmd->blocks_per_row);
+		(u32)((rmd->first_block % rmd->stripesize) %
+		rmd->blocks_per_row);
 
 	rmd->r5or6_last_row_offset =
 		(u32)((rmd->last_block % rmd->stripesize) %
 		rmd->blocks_per_row);
 
 	rmd->first_column =
-			rmd->r5or6_first_row_offset / rmd->strip_size;
+		rmd->r5or6_first_row_offset / rmd->strip_size;
 	rmd->r5or6_first_column = rmd->first_column;
 	rmd->r5or6_last_column = rmd->r5or6_last_row_offset / rmd->strip_size;
 #endif
 	if (rmd->r5or6_first_column != rmd->r5or6_last_column)
 		return PQI_RAID_BYPASS_INELIGIBLE;
 
-	/* Request is eligible */
+	/* Request is eligible. */
 	rmd->map_row =
 		((u32)(rmd->first_row >> raid_map->parity_rotation_shift)) %
 		get_unaligned_le16(&raid_map->row_cnt);
@@ -2517,7 +2651,7 @@ static void pqi_set_aio_cdb(struct pqi_scsi_dev_raid_map_data *rmd)
 }
 
 static void pqi_calc_aio_r1_nexus(struct raid_map *raid_map,
-				struct pqi_scsi_dev_raid_map_data *rmd)
+	struct pqi_scsi_dev_raid_map_data *rmd)
 {
 	u32 index;
 	u32 group;
@@ -2546,7 +2680,7 @@ static int pqi_raid_bypass_submit_scsi_cmd(struct pqi_ctrl_info *ctrl_info,
 	u32 next_bypass_group;
 	struct pqi_encryption_info *encryption_info_ptr;
 	struct pqi_encryption_info encryption_info;
-	struct pqi_scsi_dev_raid_map_data rmd = {0};
+	struct pqi_scsi_dev_raid_map_data rmd = { 0 };
 
 	rc = pqi_get_aio_lba_and_block_count(scmd, &rmd);
 	if (rc)
@@ -2607,7 +2741,9 @@ static int pqi_raid_bypass_submit_scsi_cmd(struct pqi_ctrl_info *ctrl_info,
 	pqi_set_aio_cdb(&rmd);
 
 	if (get_unaligned_le16(&raid_map->flags) &
-		RAID_MAP_ENCRYPTION_ENABLED) {
+			RAID_MAP_ENCRYPTION_ENABLED) {
+		if (rmd.data_length > device->max_transfer_encrypted)
+			return PQI_RAID_BYPASS_INELIGIBLE;
 		pqi_set_encryption_info(&encryption_info, raid_map,
 			rmd.first_block);
 		encryption_info_ptr = &encryption_info;
@@ -2617,10 +2753,6 @@ static int pqi_raid_bypass_submit_scsi_cmd(struct pqi_ctrl_info *ctrl_info,
 
 	if (rmd.is_write) {
 		switch (device->raid_level) {
-		case SA_RAID_0:
-			return pqi_aio_submit_io(ctrl_info, scmd, rmd.aio_handle,
-				rmd.cdb, rmd.cdb_length, queue_group,
-				encryption_info_ptr, true);
 		case SA_RAID_1:
 		case SA_RAID_ADM:
 			return pqi_aio_submit_r1_write_io(ctrl_info, scmd, queue_group,
@@ -2629,17 +2761,12 @@ static int pqi_raid_bypass_submit_scsi_cmd(struct pqi_ctrl_info *ctrl_info,
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
@@ -7203,6 +7330,7 @@ static int pqi_enable_firmware_features(struct pqi_ctrl_info *ctrl_info,
 {
 	void *features_requested;
 	void __iomem *features_requested_iomem_addr;
+	void __iomem *host_max_known_feature_iomem_addr;
 
 	features_requested = firmware_features->features_supported +
 		le16_to_cpu(firmware_features->num_elements);
@@ -7213,6 +7341,16 @@ static int pqi_enable_firmware_features(struct pqi_ctrl_info *ctrl_info,
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
@@ -7250,6 +7388,15 @@ static void pqi_ctrl_update_feature_flags(struct pqi_ctrl_info *ctrl_info,
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
@@ -7287,6 +7434,51 @@ static struct pqi_firmware_feature pqi_firmware_features[] = {
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
@@ -7661,6 +7853,17 @@ static int pqi_ctrl_init(struct pqi_ctrl_info *ctrl_info)
 
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
@@ -7816,6 +8019,17 @@ static int pqi_ctrl_init_resume(struct pqi_ctrl_info *ctrl_info)
 
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
@@ -7979,6 +8193,13 @@ static struct pqi_ctrl_info *pqi_alloc_ctrl_info(int numa_node)
 	ctrl_info->irq_mode = IRQ_MODE_NONE;
 	ctrl_info->max_msix_vectors = PQI_MAX_MSIX_VECTORS;
 
+	ctrl_info->ciss_report_log_flags = CISS_REPORT_LOG_FLAG_UNIQUE_LUN_ID;
+	ctrl_info->max_transfer_encrypted_sas_sata =
+		PQI_DEFAULT_MAX_TRANSFER_ENCRYPTED_SAS_SATA;
+	ctrl_info->max_transfer_encrypted_nvme =
+		PQI_DEFAULT_MAX_TRANSFER_ENCRYPTED_NVME;
+	ctrl_info->max_write_raid_5_6 = PQI_DEFAULT_MAX_WRITE_RAID_5_6;
+
 	return ctrl_info;
 }
 
@@ -9390,6 +9611,41 @@ static void __attribute__((unused)) verify_structures(void)
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
+		!= 14);
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
+
 	BUILD_BUG_ON(PQI_ADMIN_IQ_NUM_ELEMENTS > 255);
 	BUILD_BUG_ON(PQI_ADMIN_OQ_NUM_ELEMENTS > 255);
 	BUILD_BUG_ON(PQI_ADMIN_IQ_ELEMENT_LENGTH %

