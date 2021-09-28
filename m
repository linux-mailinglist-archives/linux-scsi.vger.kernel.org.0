Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01BB841BB30
	for <lists+linux-scsi@lfdr.de>; Wed, 29 Sep 2021 01:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243466AbhI1X4v (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 28 Sep 2021 19:56:51 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:25123 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243336AbhI1X4Z (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 28 Sep 2021 19:56:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632873284; x=1664409284;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LlIDL8+TbItJoCk6AYTnwCdDFxUelMH7Zfv/EJCbCPQ=;
  b=xwWiaQNVKxOGdJ80jz7dbNcm/AAvi81t6U5C1OOOD8D3K188FTSck3lt
   o2a6GFcuUYSC2f5NKioyDaRfukn839FyBK/No+Zm0k1uUbnjP4sJWtR8L
   v6/JUcwGMrePguL43P1NJdCtUWZTSuRm6ZSHsnTs7fU/eLLeV5qVmGBEM
   lgRBdOQZCWwc2TNFpOaFkPwNJ2LObGBmndTGFV7fv75+afGHJHKSaLlXd
   RHVQobUojCKV2N2iw7dhuWENYNA8BDV0BUWlRM6m6fXvg/kQ2G3eWaQ3H
   nvm71GzQESYpqzLl6OYmzIFrsRkWKW140y+EDjRIuR48o7xEiGRtPcJCr
   A==;
IronPort-SDR: A/knRl6W+TkTuktefkBa+QbMNW5/F9JMr9J1GZNDrO5JHzBGTQCTlKxLBt3o9vzZOhg/lS1n37
 L8MWobd+kjT60AQpVRJq3xp8mBVGTB0iIqbMnGGBip4hM+BGKKzyBUxHJfqRwm2c6CFqxlpkJ/
 XkXz4b5m0uJaNRnvcOaspQG+9fFtGfQVWvwx3lAnb7FEHfIUYXzmjrn+KorrlzlyCFClhDOZRv
 +yjkVzPyPl5r+kFK5ZeTexQOPUn9pJHQ4OLkU6IANvlJ+oTdEEfb9cBh881/iCLqTQCkgqlqAP
 SE3RPrxWYF+EJgiDjBTaUvMB
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; 
   d="scan'208";a="131019748"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Sep 2021 16:54:44 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 28 Sep 2021 16:54:42 -0700
Received: from brunhilda.pdev.net (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Tue, 28 Sep 2021 16:54:42 -0700
Received: by brunhilda.pdev.net (Postfix, from userid 1467)
        id 84B827028AC; Tue, 28 Sep 2021 18:54:42 -0500 (CDT)
From:   Don Brace <don.brace@microchip.com>
To:     <hch@infradead.org>, <martin.petersen@oracle.com>,
        <jejb@linux.vnet.ibm.com>, <linux-scsi@vger.kernel.org>
CC:     <Kevin.Barnett@microchip.com>, <scott.teel@microchip.com>,
        <Justin.Lindley@microchip.com>, <scott.benesh@microchip.com>,
        <gerry.morong@microchip.com>, <mahesh.rajashekhara@microchip.com>,
        <mike.mcgowen@microchip.com>, <murthy.bhat@microchip.com>,
        <balsundar.p@microchip.com>, <joseph.szczypek@hpe.com>,
        <jeff@canonical.com>, <POSWALD@suse.com>,
        <john.p.donnelly@oracle.com>, <mwilck@suse.com>,
        <pmenzel@molgen.mpg.de>, <linux-kernel@vger.kernel.org>
Subject: [smartpqi updates PATCH V2 07/11] smartpqi: add extended report physical luns
Date:   Tue, 28 Sep 2021 18:54:38 -0500
Message-ID: <20210928235442.201875-8-don.brace@microchip.com>
X-Mailer: git-send-email 2.28.0.rc1.9.ge7ae437ac1
In-Reply-To: <20210928235442.201875-1-don.brace@microchip.com>
References: <20210928235442.201875-1-don.brace@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Mike McGowen <Mike.McGowen@microchip.com>

Add support for the new extended formats in
the data returned from the Report Physical LUNs
command for controllers that enable this feature.

The new formats allow the reporting of 16-byte WWIDs.

Reviewed-by: Scott Benesh <scott.benesh@microchip.com>
Reviewed-by: Scott Teel <scott.teel@microchip.com>
Signed-off-by: Mike McGowen <Mike.McGowen@microchip.com>
Signed-off-by: Don Brace <don.brace@microchip.com>
---
 drivers/scsi/smartpqi/smartpqi.h              |  37 +++-
 drivers/scsi/smartpqi/smartpqi_init.c         | 163 +++++++++++++-----
 .../scsi/smartpqi/smartpqi_sas_transport.c    |   6 +-
 3 files changed, 147 insertions(+), 59 deletions(-)

diff --git a/drivers/scsi/smartpqi/smartpqi.h b/drivers/scsi/smartpqi/smartpqi.h
index d66863f8d1cf..c439583a4ca5 100644
--- a/drivers/scsi/smartpqi/smartpqi.h
+++ b/drivers/scsi/smartpqi/smartpqi.h
@@ -868,7 +868,8 @@ struct pqi_config_table_firmware_features {
 #define PQI_FIRMWARE_FEATURE_RAID_BYPASS_ON_ENCRYPTED_NVME	15
 #define PQI_FIRMWARE_FEATURE_UNIQUE_WWID_IN_REPORT_PHYS_LUN	16
 #define PQI_FIRMWARE_FEATURE_FW_TRIAGE				17
-#define PQI_FIRMWARE_FEATURE_MAXIMUM				17
+#define PQI_FIRMWARE_FEATURE_RPL_EXTENDED_FORMAT_4_5		18
+#define PQI_FIRMWARE_FEATURE_MAXIMUM				18
 
 struct pqi_config_table_debug {
 	struct pqi_config_table_section_header header;
@@ -943,19 +944,21 @@ struct report_lun_header {
 #define CISS_REPORT_LOG_FLAG_QUEUE_DEPTH	(1 << 5)
 #define CISS_REPORT_LOG_FLAG_DRIVE_TYPE_MIX	(1 << 6)
 
-#define CISS_REPORT_PHYS_FLAG_OTHER		(1 << 1)
+#define CISS_REPORT_PHYS_FLAG_EXTENDED_FORMAT_2		0x2
+#define CISS_REPORT_PHYS_FLAG_EXTENDED_FORMAT_4		0x4
+#define CISS_REPORT_PHYS_FLAG_EXTENDED_FORMAT_MASK	0xf
 
-struct report_log_lun_extended_entry {
+struct report_log_lun {
 	u8	lunid[8];
 	u8	volume_id[16];
 };
 
-struct report_log_lun_extended {
+struct report_log_lun_list {
 	struct report_lun_header header;
-	struct report_log_lun_extended_entry lun_entries[1];
+	struct report_log_lun lun_entries[1];
 };
 
-struct report_phys_lun_extended_entry {
+struct report_phys_lun_8byte_wwid {
 	u8	lunid[8];
 	__be64	wwid;
 	u8	device_type;
@@ -965,12 +968,27 @@ struct report_phys_lun_extended_entry {
 	u32	aio_handle;
 };
 
+struct report_phys_lun_16byte_wwid {
+	u8	lunid[8];
+	u8	wwid[16];
+	u8	device_type;
+	u8	device_flags;
+	u8	lun_count;	/* number of LUNs in a multi-LUN device */
+	u8	redundant_paths;
+	u32	aio_handle;
+};
+
 /* for device_flags field of struct report_phys_lun_extended_entry */
 #define CISS_REPORT_PHYS_DEV_FLAG_AIO_ENABLED	0x8
 
-struct report_phys_lun_extended {
+struct report_phys_lun_8byte_wwid_list {
+	struct report_lun_header header;
+	struct report_phys_lun_8byte_wwid lun_entries[1];
+};
+
+struct report_phys_lun_16byte_wwid_list {
 	struct report_lun_header header;
-	struct report_phys_lun_extended_entry lun_entries[1];
+	struct report_phys_lun_16byte_wwid lun_entries[1];
 };
 
 struct raid_map_disk_data {
@@ -1077,7 +1095,7 @@ struct pqi_scsi_dev {
 	int	target;
 	int	lun;
 	u8	scsi3addr[8];
-	__be64	wwid;
+	u8	wwid[16];
 	u8	volume_id[16];
 	u8	is_physical_device : 1;
 	u8	is_external_raid_device : 1;
@@ -1316,6 +1334,7 @@ struct pqi_ctrl_info {
 	u8		tmf_iu_timeout_supported : 1;
 	u8		unique_wwid_in_report_phys_lun_supported : 1;
 	u8		firmware_triage_supported : 1;
+	u8		rpl_extended_format_4_5_supported : 1;
 	u8		enable_r1_writes : 1;
 	u8		enable_r5_writes : 1;
 	u8		enable_r6_writes : 1;
diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index c9f2a3d54663..1e27e6ba0159 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -572,10 +572,14 @@ static int pqi_build_raid_path_request(struct pqi_ctrl_info *ctrl_info,
 	case CISS_REPORT_PHYS:
 		request->data_direction = SOP_READ_FLAG;
 		cdb[0] = cmd;
-		if (cmd == CISS_REPORT_PHYS)
-			cdb[1] = CISS_REPORT_PHYS_FLAG_OTHER;
-		else
+		if (cmd == CISS_REPORT_PHYS) {
+			if (ctrl_info->rpl_extended_format_4_5_supported)
+				cdb[1] = CISS_REPORT_PHYS_FLAG_EXTENDED_FORMAT_4;
+			else
+				cdb[1] = CISS_REPORT_PHYS_FLAG_EXTENDED_FORMAT_2;
+		} else {
 			cdb[1] = ctrl_info->ciss_report_log_flags;
+		}
 		put_unaligned_be32(cdb_length, &cdb[6]);
 		break;
 	case CISS_GET_RAID_MAP:
@@ -1132,7 +1136,64 @@ static int pqi_report_phys_logical_luns(struct pqi_ctrl_info *ctrl_info, u8 cmd,
 
 static inline int pqi_report_phys_luns(struct pqi_ctrl_info *ctrl_info, void **buffer)
 {
-	return pqi_report_phys_logical_luns(ctrl_info, CISS_REPORT_PHYS, buffer);
+	int rc;
+	unsigned int i;
+	u8 rpl_response_format;
+	u32 num_physicals;
+	size_t rpl_16byte_wwid_list_length;
+	void *rpl_list;
+	struct report_lun_header *rpl_header;
+	struct report_phys_lun_8byte_wwid_list *rpl_8byte_wwid_list;
+	struct report_phys_lun_16byte_wwid_list *rpl_16byte_wwid_list;
+
+	rc = pqi_report_phys_logical_luns(ctrl_info, CISS_REPORT_PHYS, &rpl_list);
+	if (rc)
+		return rc;
+
+	if (ctrl_info->rpl_extended_format_4_5_supported) {
+		rpl_header = rpl_list;
+		rpl_response_format = rpl_header->flags & CISS_REPORT_PHYS_FLAG_EXTENDED_FORMAT_MASK;
+		if (rpl_response_format == CISS_REPORT_PHYS_FLAG_EXTENDED_FORMAT_4) {
+			*buffer = rpl_list;
+			return 0;
+		} else if (rpl_response_format != CISS_REPORT_PHYS_FLAG_EXTENDED_FORMAT_2) {
+			dev_err(&ctrl_info->pci_dev->dev,
+				"RPL returned unsupported data format %u\n",
+				rpl_response_format);
+			return -EINVAL;
+		} else {
+			dev_warn(&ctrl_info->pci_dev->dev,
+				"RPL returned extended format 2 instead of 4\n");
+		}
+	}
+
+	rpl_8byte_wwid_list = rpl_list;
+	num_physicals = get_unaligned_be32(&rpl_8byte_wwid_list->header.list_length) / sizeof(rpl_8byte_wwid_list->lun_entries[0]);
+	rpl_16byte_wwid_list_length = sizeof(struct report_lun_header) + (num_physicals * sizeof(struct report_phys_lun_16byte_wwid));
+
+	rpl_16byte_wwid_list = kmalloc(rpl_16byte_wwid_list_length, GFP_KERNEL);
+	if (!rpl_16byte_wwid_list)
+		return -ENOMEM;
+
+	put_unaligned_be32(num_physicals * sizeof(struct report_phys_lun_16byte_wwid),
+		&rpl_16byte_wwid_list->header.list_length);
+	rpl_16byte_wwid_list->header.flags = rpl_8byte_wwid_list->header.flags;
+
+	for (i = 0; i < num_physicals; i++) {
+		memcpy(&rpl_16byte_wwid_list->lun_entries[i].lunid, &rpl_8byte_wwid_list->lun_entries[i].lunid, sizeof(rpl_8byte_wwid_list->lun_entries[i].lunid));
+		memset(&rpl_16byte_wwid_list->lun_entries[i].wwid, 0, 8);
+		memcpy(&rpl_16byte_wwid_list->lun_entries[i].wwid[8], &rpl_8byte_wwid_list->lun_entries[i].wwid, sizeof(rpl_8byte_wwid_list->lun_entries[i].wwid));
+		rpl_16byte_wwid_list->lun_entries[i].device_type = rpl_8byte_wwid_list->lun_entries[i].device_type;
+		rpl_16byte_wwid_list->lun_entries[i].device_flags = rpl_8byte_wwid_list->lun_entries[i].device_flags;
+		rpl_16byte_wwid_list->lun_entries[i].lun_count = rpl_8byte_wwid_list->lun_entries[i].lun_count;
+		rpl_16byte_wwid_list->lun_entries[i].redundant_paths = rpl_8byte_wwid_list->lun_entries[i].redundant_paths;
+		rpl_16byte_wwid_list->lun_entries[i].aio_handle = rpl_8byte_wwid_list->lun_entries[i].aio_handle;
+	}
+
+	kfree(rpl_8byte_wwid_list);
+	*buffer = rpl_16byte_wwid_list;
+
+	return 0;
 }
 
 static inline int pqi_report_logical_luns(struct pqi_ctrl_info *ctrl_info, void **buffer)
@@ -1141,14 +1202,14 @@ static inline int pqi_report_logical_luns(struct pqi_ctrl_info *ctrl_info, void
 }
 
 static int pqi_get_device_lists(struct pqi_ctrl_info *ctrl_info,
-	struct report_phys_lun_extended **physdev_list,
-	struct report_log_lun_extended **logdev_list)
+	struct report_phys_lun_16byte_wwid_list **physdev_list,
+	struct report_log_lun_list **logdev_list)
 {
 	int rc;
 	size_t logdev_list_length;
 	size_t logdev_data_length;
-	struct report_log_lun_extended *internal_logdev_list;
-	struct report_log_lun_extended *logdev_data;
+	struct report_log_lun_list *internal_logdev_list;
+	struct report_log_lun_list *logdev_data;
 	struct report_lun_header report_lun_header;
 
 	rc = pqi_report_phys_luns(ctrl_info, (void **)physdev_list);
@@ -1173,7 +1234,7 @@ static int pqi_get_device_lists(struct pqi_ctrl_info *ctrl_info,
 	} else {
 		memset(&report_lun_header, 0, sizeof(report_lun_header));
 		logdev_data =
-			(struct report_log_lun_extended *)&report_lun_header;
+			(struct report_log_lun_list *)&report_lun_header;
 		logdev_list_length = 0;
 	}
 
@@ -1181,7 +1242,7 @@ static int pqi_get_device_lists(struct pqi_ctrl_info *ctrl_info,
 		logdev_list_length;
 
 	internal_logdev_list = kmalloc(logdev_data_length +
-		sizeof(struct report_log_lun_extended), GFP_KERNEL);
+		sizeof(struct report_log_lun), GFP_KERNEL);
 	if (!internal_logdev_list) {
 		kfree(*logdev_list);
 		*logdev_list = NULL;
@@ -1190,9 +1251,9 @@ static int pqi_get_device_lists(struct pqi_ctrl_info *ctrl_info,
 
 	memcpy(internal_logdev_list, logdev_data, logdev_data_length);
 	memset((u8 *)internal_logdev_list + logdev_data_length, 0,
-		sizeof(struct report_log_lun_extended_entry));
+		sizeof(struct report_log_lun));
 	put_unaligned_be32(logdev_list_length +
-		sizeof(struct report_log_lun_extended_entry),
+		sizeof(struct report_log_lun),
 		&internal_logdev_list->header.list_length);
 
 	kfree(*logdev_list);
@@ -1845,7 +1906,7 @@ static inline bool pqi_device_equal(struct pqi_scsi_dev *dev1, struct pqi_scsi_d
 		return false;
 
 	if (dev1->is_physical_device)
-		return dev1->wwid == dev2->wwid;
+		return memcmp(dev1->wwid, dev2->wwid, sizeof(dev1->wwid)) == 0;
 
 	return memcmp(dev1->volume_id, dev2->volume_id, sizeof(dev1->volume_id)) == 0;
 }
@@ -1915,7 +1976,9 @@ static void pqi_dev_info(struct pqi_ctrl_info *ctrl_info,
 	else
 		count += scnprintf(buffer + count,
 			PQI_DEV_INFO_BUFFER_LENGTH - count,
-			" %016llx", device->sas_address);
+			" %016llx%016llx",
+			get_unaligned_be64(&device->wwid[0]),
+			get_unaligned_be64(&device->wwid[8]));
 
 	count += scnprintf(buffer + count, PQI_DEV_INFO_BUFFER_LENGTH - count,
 		" %s %.8s %.16s ",
@@ -2229,13 +2292,14 @@ static inline bool pqi_expose_device(struct pqi_scsi_dev *device)
 }
 
 static inline void pqi_set_physical_device_wwid(struct pqi_ctrl_info *ctrl_info,
-	struct pqi_scsi_dev *device, struct report_phys_lun_extended_entry *phys_lun_ext_entry)
+	struct pqi_scsi_dev *device, struct report_phys_lun_16byte_wwid *phys_lun)
 {
 	if (ctrl_info->unique_wwid_in_report_phys_lun_supported ||
+		ctrl_info->rpl_extended_format_4_5_supported ||
 		pqi_is_device_with_sas_address(device))
-		device->wwid = phys_lun_ext_entry->wwid;
+		memcpy(device->wwid, phys_lun->wwid, sizeof(device->wwid));
 	else
-		device->wwid = cpu_to_be64(get_unaligned_be64(&device->page_83_identifier));
+		memcpy(&device->wwid[8], device->page_83_identifier, 8);
 }
 
 static int pqi_update_scsi_devices(struct pqi_ctrl_info *ctrl_info)
@@ -2243,10 +2307,10 @@ static int pqi_update_scsi_devices(struct pqi_ctrl_info *ctrl_info)
 	int i;
 	int rc;
 	LIST_HEAD(new_device_list_head);
-	struct report_phys_lun_extended *physdev_list = NULL;
-	struct report_log_lun_extended *logdev_list = NULL;
-	struct report_phys_lun_extended_entry *phys_lun_ext_entry;
-	struct report_log_lun_extended_entry *log_lun_ext_entry;
+	struct report_phys_lun_16byte_wwid_list *physdev_list = NULL;
+	struct report_log_lun_list *logdev_list = NULL;
+	struct report_phys_lun_16byte_wwid *phys_lun;
+	struct report_log_lun *log_lun;
 	struct bmic_identify_physical_device *id_phys = NULL;
 	u32 num_physicals;
 	u32 num_logicals;
@@ -2297,10 +2361,9 @@ static int pqi_update_scsi_devices(struct pqi_ctrl_info *ctrl_info)
 
 		if (pqi_hide_vsep) {
 			for (i = num_physicals - 1; i >= 0; i--) {
-				phys_lun_ext_entry =
-						&physdev_list->lun_entries[i];
-				if (CISS_GET_DRIVE_NUMBER(phys_lun_ext_entry->lunid) == PQI_VSEP_CISS_BTL) {
-					pqi_mask_device(phys_lun_ext_entry->lunid);
+				phys_lun = &physdev_list->lun_entries[i];
+				if (CISS_GET_DRIVE_NUMBER(phys_lun->lunid) == PQI_VSEP_CISS_BTL) {
+					pqi_mask_device(phys_lun->lunid);
 					break;
 				}
 			}
@@ -2344,16 +2407,14 @@ static int pqi_update_scsi_devices(struct pqi_ctrl_info *ctrl_info)
 		if ((!pqi_expose_ld_first && i < num_physicals) ||
 			(pqi_expose_ld_first && i >= num_logicals)) {
 			is_physical_device = true;
-			phys_lun_ext_entry =
-				&physdev_list->lun_entries[physical_index++];
-			log_lun_ext_entry = NULL;
-			scsi3addr = phys_lun_ext_entry->lunid;
+			phys_lun = &physdev_list->lun_entries[physical_index++];
+			log_lun = NULL;
+			scsi3addr = phys_lun->lunid;
 		} else {
 			is_physical_device = false;
-			phys_lun_ext_entry = NULL;
-			log_lun_ext_entry =
-				&logdev_list->lun_entries[logical_index++];
-			scsi3addr = log_lun_ext_entry->lunid;
+			phys_lun = NULL;
+			log_lun = &logdev_list->lun_entries[logical_index++];
+			scsi3addr = log_lun->lunid;
 		}
 
 		if (is_physical_device && pqi_skip_device(scsi3addr))
@@ -2368,7 +2429,7 @@ static int pqi_update_scsi_devices(struct pqi_ctrl_info *ctrl_info)
 		memcpy(device->scsi3addr, scsi3addr, sizeof(device->scsi3addr));
 		device->is_physical_device = is_physical_device;
 		if (is_physical_device) {
-			device->device_type = phys_lun_ext_entry->device_type;
+			device->device_type = phys_lun->device_type;
 			if (device->device_type == SA_DEVICE_TYPE_EXPANDER_SMP)
 				device->is_expander_smp_device = true;
 		} else {
@@ -2393,8 +2454,9 @@ static int pqi_update_scsi_devices(struct pqi_ctrl_info *ctrl_info)
 		if (rc) {
 			if (device->is_physical_device)
 				dev_warn(&ctrl_info->pci_dev->dev,
-					"obtaining device info failed, skipping physical device %016llx\n",
-					get_unaligned_be64(&phys_lun_ext_entry->wwid));
+					"obtaining device info failed, skipping physical device %016llx%016llx\n",
+					get_unaligned_be64(&phys_lun->wwid[0]),
+					get_unaligned_be64(&phys_lun->wwid[8]));
 			else
 				dev_warn(&ctrl_info->pci_dev->dev,
 					"obtaining device info failed, skipping logical device %08x%08x\n",
@@ -2407,21 +2469,21 @@ static int pqi_update_scsi_devices(struct pqi_ctrl_info *ctrl_info)
 		pqi_assign_bus_target_lun(device);
 
 		if (device->is_physical_device) {
-			pqi_set_physical_device_wwid(ctrl_info, device, phys_lun_ext_entry);
-			if ((phys_lun_ext_entry->device_flags &
+			pqi_set_physical_device_wwid(ctrl_info, device, phys_lun);
+			if ((phys_lun->device_flags &
 				CISS_REPORT_PHYS_DEV_FLAG_AIO_ENABLED) &&
-				phys_lun_ext_entry->aio_handle) {
+				phys_lun->aio_handle) {
 					device->aio_enabled = true;
 					device->aio_handle =
-						phys_lun_ext_entry->aio_handle;
+						phys_lun->aio_handle;
 			}
 		} else {
-			memcpy(device->volume_id, log_lun_ext_entry->volume_id,
+			memcpy(device->volume_id, log_lun->volume_id,
 				sizeof(device->volume_id));
 		}
 
 		if (pqi_is_device_with_sas_address(device))
-			device->sas_address = get_unaligned_be64(&device->wwid);
+			device->sas_address = get_unaligned_be64(&device->wwid[8]);
 
 		new_device_list[num_valid_devices++] = device;
 	}
@@ -6804,12 +6866,10 @@ static ssize_t pqi_unique_id_show(struct device *dev,
 		return -ENODEV;
 	}
 
-	if (device->is_physical_device) {
-		memset(unique_id, 0, 8);
-		memcpy(unique_id + 8, &device->wwid, sizeof(device->wwid));
-	} else {
+	if (device->is_physical_device)
+		memcpy(unique_id, device->wwid, sizeof(device->wwid));
+	else
 		memcpy(unique_id, device->volume_id, sizeof(device->volume_id));
-	}
 
 	spin_unlock_irqrestore(&ctrl_info->scsi_device_list_lock, flags);
 
@@ -7443,6 +7503,9 @@ static void pqi_ctrl_update_feature_flags(struct pqi_ctrl_info *ctrl_info,
 		ctrl_info->firmware_triage_supported = firmware_feature->enabled;
 		pqi_save_fw_triage_setting(ctrl_info, firmware_feature->enabled);
 		break;
+	case PQI_FIRMWARE_FEATURE_RPL_EXTENDED_FORMAT_4_5:
+		ctrl_info->rpl_extended_format_4_5_supported = firmware_feature->enabled;
+		break;
 	}
 
 	pqi_firmware_feature_status(ctrl_info, firmware_feature);
@@ -7543,6 +7606,11 @@ static struct pqi_firmware_feature pqi_firmware_features[] = {
 		.feature_bit = PQI_FIRMWARE_FEATURE_FW_TRIAGE,
 		.feature_status = pqi_ctrl_update_feature_flags,
 	},
+	{
+		.feature_name = "RPL Extended Formats 4 and 5",
+		.feature_bit = PQI_FIRMWARE_FEATURE_RPL_EXTENDED_FORMAT_4_5,
+		.feature_status = pqi_ctrl_update_feature_flags,
+	},
 };
 
 static void pqi_process_firmware_features(
@@ -7644,6 +7712,7 @@ static void pqi_ctrl_reset_config(struct pqi_ctrl_info *ctrl_info)
 	ctrl_info->tmf_iu_timeout_supported = false;
 	ctrl_info->unique_wwid_in_report_phys_lun_supported = false;
 	ctrl_info->firmware_triage_supported = false;
+	ctrl_info->rpl_extended_format_4_5_supported = false;
 }
 
 static int pqi_process_config_table(struct pqi_ctrl_info *ctrl_info)
diff --git a/drivers/scsi/smartpqi/smartpqi_sas_transport.c b/drivers/scsi/smartpqi/smartpqi_sas_transport.c
index afd9bafebd1d..dea4ebaf1677 100644
--- a/drivers/scsi/smartpqi/smartpqi_sas_transport.c
+++ b/drivers/scsi/smartpqi/smartpqi_sas_transport.c
@@ -343,7 +343,7 @@ static int pqi_sas_get_enclosure_identifier(struct sas_rphy *rphy,
 	}
 
 	if (found_device->devtype == TYPE_ENCLOSURE) {
-		*identifier = get_unaligned_be64(&found_device->wwid);
+		*identifier = get_unaligned_be64(&found_device->wwid[8]);
 		rc = 0;
 		goto out;
 	}
@@ -364,7 +364,7 @@ static int pqi_sas_get_enclosure_identifier(struct sas_rphy *rphy,
 			memcmp(device->phys_connector,
 				found_device->phys_connector, 2) == 0) {
 			*identifier =
-				get_unaligned_be64(&device->wwid);
+				get_unaligned_be64(&device->wwid[8]);
 			rc = 0;
 			goto out;
 		}
@@ -380,7 +380,7 @@ static int pqi_sas_get_enclosure_identifier(struct sas_rphy *rphy,
 		if (device->devtype == TYPE_ENCLOSURE &&
 			CISS_GET_DRIVE_NUMBER(device->scsi3addr) ==
 				PQI_VSEP_CISS_BTL) {
-			*identifier = get_unaligned_be64(&device->wwid);
+			*identifier = get_unaligned_be64(&device->wwid[8]);
 			rc = 0;
 			goto out;
 		}
-- 
2.28.0.rc1.9.ge7ae437ac1

