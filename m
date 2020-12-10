Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB88C2D68D4
	for <lists+linux-scsi@lfdr.de>; Thu, 10 Dec 2020 21:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404613AbgLJUgK (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 10 Dec 2020 15:36:10 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:28345 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393821AbgLJUgD (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 10 Dec 2020 15:36:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1607632564; x=1639168564;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=itenu1lEOIYD0b4kI9bzfnY4aQaBPq6pG2p8fpiaqAs=;
  b=lQ4xDbhdwTp4kEXygC7qEszSMMJjGd/f6p0FrE93UqAF2O7jMC9NE6Fh
   vGI6nkGKV07yycKRHw0v2lL5ab2x76/PcLZxzjEwKGKgdtra4oBRgsQ9L
   dwVKgc1+AhliWzkvgXber7pMfFfFDSsHwvSUtbGHzq5uoz06BRuQd9DpN
   9KyUDk/Aviq4kLqItPy7Zz8Odz2+O1cIrr7rqlJDzIfhmlNhEHUC9yKg1
   VvDVWRprWqWAWlsCIPlGOEAFehiOnjlmjMsihnVErTOi07ecTiysHbRVK
   YrNXQQuPdTgngvtHEIbVqevZc7yaW+iXYz0hgEegdzTL+3e41PCkwEzYe
   g==;
IronPort-SDR: jlY4rKjuwA1+qpdRo0qDqHi1kFJMm06MUBFdjg5DVaTwqVclMbyiJbiLsiSOC0aW+kTX4Q0aI4
 flCfCCo+MTgFIF6T0vobDmkQNoziXNW0WXZcXrfLWABYqiKEGo27Omlb39Y9TMRATv8Uy6J90X
 tlbREfiu9IHBggrDwOWm3uFY/t1HHcOMWWovah3LtRQm3RKpTyfuFgJ0jqc/3FmmUwjkTS1OII
 0PnbFY7ZFXqM0dXFUPqGIhEJoLZnLq2Luudqrxg4x9FxoUhOIDs28MdryZ+Lz2P1j/iVtLZW0l
 9HE=
X-IronPort-AV: E=Sophos;i="5.78,409,1599548400"; 
   d="scan'208";a="101749751"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Dec 2020 13:34:48 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 10 Dec 2020 13:34:44 -0700
Received: from [127.0.1.1] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 10 Dec 2020 13:34:43 -0700
Subject: [PATCH V3 04/25] smartpqi: add support for raid5 and raid6 writes
From:   Don Brace <don.brace@microchip.com>
To:     <Kevin.Barnett@microchip.com>, <scott.teel@microchip.com>,
        <Justin.Lindley@microchip.com>, <scott.benesh@microchip.com>,
        <gerry.morong@microchip.com>, <mahesh.rajashekhara@microchip.com>,
        <hch@infradead.org>, <jejb@linux.vnet.ibm.com>,
        <joseph.szczypek@hpe.com>, <POSWALD@suse.com>
CC:     <linux-scsi@vger.kernel.org>
Date:   Thu, 10 Dec 2020 14:34:43 -0600
Message-ID: <160763248354.26927.303366932249508542.stgit@brunhilda>
In-Reply-To: <160763241302.26927.17487238067261230799.stgit@brunhilda>
References: <160763241302.26927.17487238067261230799.stgit@brunhilda>
User-Agent: StGit/0.23-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

* Add in new IU definition.
* Add in support raid5 and raid6 writes.

Reviewed-by: Scott Benesh <scott.benesh@microchip.com>
Reviewed-by: Scott Teel <scott.teel@microchip.com>
Reviewed-by: Kevin Barnett <kevin.barnett@microchip.com>
Signed-off-by: Don Brace <don.brace@microchip.com>
---
 drivers/scsi/smartpqi/smartpqi.h      |   39 +++++
 drivers/scsi/smartpqi/smartpqi_init.c |  247 ++++++++++++++++++++++++++++++++-
 2 files changed, 278 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/smartpqi/smartpqi.h b/drivers/scsi/smartpqi/smartpqi.h
index d486a2ec3045..e9844210c4a0 100644
--- a/drivers/scsi/smartpqi/smartpqi.h
+++ b/drivers/scsi/smartpqi/smartpqi.h
@@ -257,6 +257,7 @@ struct pqi_device_capability {
 };
 
 #define PQI_MAX_EMBEDDED_SG_DESCRIPTORS		4
+#define PQI_MAX_EMBEDDED_R56_SG_DESCRIPTORS	3
 
 struct pqi_raid_path_request {
 	struct pqi_iu_header header;
@@ -312,6 +313,39 @@ struct pqi_aio_path_request {
 		sg_descriptors[PQI_MAX_EMBEDDED_SG_DESCRIPTORS];
 };
 
+#define PQI_RAID56_XFER_LIMIT_4K	0x1000 /* 4Kib */
+#define PQI_RAID56_XFER_LIMIT_8K	0x2000 /* 8Kib */
+struct pqi_aio_r56_path_request {
+	struct pqi_iu_header header;
+	__le16	request_id;
+	__le16	volume_id;		/* ID of the RAID volume */
+	__le32	data_it_nexus;		/* IT nexus for the data drive */
+	__le32	p_parity_it_nexus;	/* IT nexus for the P parity drive */
+	__le32	q_parity_it_nexus;	/* IT nexus for the Q parity drive */
+	__le32	data_length;		/* total bytes to read/write */
+	u8	data_direction : 2;
+	u8	partial : 1;
+	u8	mem_type : 1;		/* 0b: PCIe, 1b: DDR */
+	u8	fence : 1;
+	u8	encryption_enable : 1;
+	u8	reserved : 2;
+	u8	task_attribute : 3;
+	u8	command_priority : 4;
+	u8	reserved1 : 1;
+	__le16	data_encryption_key_index;
+	u8	cdb[16];
+	__le16	error_index;
+	u8	num_sg_descriptors;
+	u8	cdb_length;
+	u8	xor_multiplier;
+	u8	reserved2[3];
+	__le32	encrypt_tweak_lower;
+	__le32	encrypt_tweak_upper;
+	u8	row;			/* row = logical lba/blocks per row */
+	u8	reserved3[8];
+	struct pqi_sg_descriptor sg_descriptors[PQI_MAX_EMBEDDED_R56_SG_DESCRIPTORS];
+};
+
 struct pqi_io_response {
 	struct pqi_iu_header header;
 	__le16	request_id;
@@ -484,6 +518,8 @@ struct pqi_raid_error_info {
 #define PQI_REQUEST_IU_TASK_MANAGEMENT			0x13
 #define PQI_REQUEST_IU_RAID_PATH_IO			0x14
 #define PQI_REQUEST_IU_AIO_PATH_IO			0x15
+#define PQI_REQUEST_IU_AIO_PATH_RAID5_IO		0x18
+#define PQI_REQUEST_IU_AIO_PATH_RAID6_IO		0x19
 #define PQI_REQUEST_IU_GENERAL_ADMIN			0x60
 #define PQI_REQUEST_IU_REPORT_VENDOR_EVENT_CONFIG	0x72
 #define PQI_REQUEST_IU_SET_VENDOR_EVENT_CONFIG		0x73
@@ -1179,6 +1215,7 @@ struct pqi_ctrl_info {
 	u16		max_inbound_iu_length_per_firmware;
 	u16		max_inbound_iu_length;
 	unsigned int	max_sg_per_iu;
+	unsigned int	max_sg_per_r56_iu;
 	void		*admin_queue_memory_base;
 	u32		admin_queue_memory_length;
 	dma_addr_t	admin_queue_memory_base_dma_handle;
@@ -1210,6 +1247,8 @@ struct pqi_ctrl_info {
 	u8		soft_reset_handshake_supported : 1;
 	u8		raid_iu_timeout_supported: 1;
 	u8		tmf_iu_timeout_supported: 1;
+	u8		enable_r5_writes : 1;
+	u8		enable_r6_writes : 1;
 
 	struct list_head scsi_device_list;
 	spinlock_t	scsi_device_list_lock;
diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index 6bcb037ae9d7..c813cec10003 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -67,6 +67,10 @@ static int pqi_aio_submit_io(struct pqi_ctrl_info *ctrl_info,
 	struct scsi_cmnd *scmd, u32 aio_handle, u8 *cdb,
 	unsigned int cdb_length, struct pqi_queue_group *queue_group,
 	struct pqi_encryption_info *encryption_info, bool raid_bypass);
+static int pqi_aio_submit_r56_write_io(struct pqi_ctrl_info *ctrl_info,
+	struct scsi_cmnd *scmd, struct pqi_queue_group *queue_group,
+	struct pqi_encryption_info *encryption_info, struct pqi_scsi_dev *device,
+	struct pqi_scsi_dev_raid_map_data *rmd);
 static void pqi_ofa_ctrl_quiesce(struct pqi_ctrl_info *ctrl_info);
 static void pqi_ofa_ctrl_unquiesce(struct pqi_ctrl_info *ctrl_info);
 static int pqi_ofa_ctrl_restart(struct pqi_ctrl_info *ctrl_info);
@@ -2237,7 +2241,8 @@ static inline void pqi_set_encryption_info(
  * Attempt to perform RAID bypass mapping for a logical volume I/O.
  */
 
-static bool pqi_aio_raid_level_supported(struct pqi_scsi_dev_raid_map_data *rmd)
+static bool pqi_aio_raid_level_supported(struct pqi_ctrl_info *ctrl_info,
+	struct pqi_scsi_dev_raid_map_data *rmd)
 {
 	bool is_supported = true;
 
@@ -2245,13 +2250,14 @@ static bool pqi_aio_raid_level_supported(struct pqi_scsi_dev_raid_map_data *rmd)
 	case SA_RAID_0:
 		break;
 	case SA_RAID_1:
-		if (rmd->is_write)
-			is_supported = false;
+		is_supported = false;
 		break;
 	case SA_RAID_5:
-		fallthrough;
+		if (rmd->is_write && !ctrl_info->enable_r5_writes)
+			is_supported = false;
+		break;
 	case SA_RAID_6:
-		if (rmd->is_write)
+		if (rmd->is_write && !ctrl_info->enable_r6_writes)
 			is_supported = false;
 		break;
 	case SA_RAID_ADM:
@@ -2526,6 +2532,26 @@ static int pqi_calc_aio_r5_or_r6(struct pqi_scsi_dev_raid_map_data *rmd,
 		rmd->total_disks_per_row)) +
 		(rmd->map_row * rmd->total_disks_per_row) + rmd->first_column;
 
+	if (rmd->is_write) {
+		rmd->p_index = (rmd->map_row * rmd->total_disks_per_row) + rmd->data_disks_per_row;
+		rmd->p_parity_it_nexus = raid_map->disk_data[rmd->p_index].aio_handle;
+		if (rmd->raid_level == SA_RAID_6) {
+			rmd->q_index = (rmd->map_row * rmd->total_disks_per_row) +
+				(rmd->data_disks_per_row + 1);
+			rmd->q_parity_it_nexus = raid_map->disk_data[rmd->q_index].aio_handle;
+			rmd->xor_mult = raid_map->disk_data[rmd->map_index].xor_mult[1];
+		}
+		if (rmd->blocks_per_row == 0)
+			return PQI_RAID_BYPASS_INELIGIBLE;
+#if BITS_PER_LONG == 32
+		tmpdiv = rmd->first_block;
+		do_div(tmpdiv, rmd->blocks_per_row);
+		rmd->row = tmpdiv;
+#else
+		rmd->row = rmd->first_block / rmd->blocks_per_row;
+#endif
+	}
+
 	return 0;
 }
 
@@ -2567,7 +2593,7 @@ static int pqi_raid_bypass_submit_scsi_cmd(struct pqi_ctrl_info *ctrl_info,
 
 	rmd.raid_level = device->raid_level;
 
-	if (!pqi_aio_raid_level_supported(&rmd))
+	if (!pqi_aio_raid_level_supported(ctrl_info, &rmd))
 		return PQI_RAID_BYPASS_INELIGIBLE;
 
 	if (unlikely(rmd.block_cnt == 0))
@@ -2587,7 +2613,8 @@ static int pqi_raid_bypass_submit_scsi_cmd(struct pqi_ctrl_info *ctrl_info,
 	} else if (device->raid_level == SA_RAID_ADM) {
 		rc = pqi_calc_aio_raid_adm(&rmd, device);
 	} else if ((device->raid_level == SA_RAID_5 ||
-		device->raid_level == SA_RAID_6) && rmd.layout_map_count > 1) {
+		device->raid_level == SA_RAID_6) &&
+		(rmd.layout_map_count > 1 || rmd.is_write)) {
 		rc = pqi_calc_aio_r5_or_r6(&rmd, raid_map);
 		if (rc)
 			return PQI_RAID_BYPASS_INELIGIBLE;
@@ -2622,9 +2649,27 @@ static int pqi_raid_bypass_submit_scsi_cmd(struct pqi_ctrl_info *ctrl_info,
 		encryption_info_ptr = NULL;
 	}
 
-	return pqi_aio_submit_io(ctrl_info, scmd, rmd.aio_handle,
+	if (rmd.is_write) {
+		switch (device->raid_level) {
+		case SA_RAID_0:
+			return pqi_aio_submit_io(ctrl_info, scmd, rmd.aio_handle,
 				rmd.cdb, rmd.cdb_length, queue_group,
 				encryption_info_ptr, true);
+		case SA_RAID_5:
+		case SA_RAID_6:
+			return pqi_aio_submit_r56_write_io(ctrl_info, scmd, queue_group,
+					encryption_info_ptr, device, &rmd);
+		default:
+			return pqi_aio_submit_io(ctrl_info, scmd, rmd.aio_handle,
+				rmd.cdb, rmd.cdb_length, queue_group,
+				encryption_info_ptr, true);
+		}
+	} else {
+		return pqi_aio_submit_io(ctrl_info, scmd, rmd.aio_handle,
+			rmd.cdb, rmd.cdb_length, queue_group,
+			encryption_info_ptr, true);
+	}
+
 }
 
 #define PQI_STATUS_IDLE		0x0
@@ -4844,6 +4889,12 @@ static void pqi_calculate_queue_resources(struct pqi_ctrl_info *ctrl_info)
 		PQI_OPERATIONAL_IQ_ELEMENT_LENGTH) /
 		sizeof(struct pqi_sg_descriptor)) +
 		PQI_MAX_EMBEDDED_SG_DESCRIPTORS;
+
+	ctrl_info->max_sg_per_r56_iu =
+		((ctrl_info->max_inbound_iu_length -
+		PQI_OPERATIONAL_IQ_ELEMENT_LENGTH) /
+		sizeof(struct pqi_sg_descriptor)) +
+		PQI_MAX_EMBEDDED_R56_SG_DESCRIPTORS;
 }
 
 static inline void pqi_set_sg_descriptor(
@@ -4931,6 +4982,44 @@ static int pqi_build_raid_sg_list(struct pqi_ctrl_info *ctrl_info,
 	return 0;
 }
 
+static int pqi_build_aio_r56_sg_list(struct pqi_ctrl_info *ctrl_info,
+	struct pqi_aio_r56_path_request *request, struct scsi_cmnd *scmd,
+	struct pqi_io_request *io_request)
+{
+	u16 iu_length;
+	int sg_count;
+	bool chained;
+	unsigned int num_sg_in_iu;
+	struct scatterlist *sg;
+	struct pqi_sg_descriptor *sg_descriptor;
+
+	sg_count = scsi_dma_map(scmd);
+	if (sg_count < 0)
+		return sg_count;
+
+	iu_length = offsetof(struct pqi_aio_r56_path_request, sg_descriptors) -
+		PQI_REQUEST_HEADER_LENGTH;
+	num_sg_in_iu = 0;
+
+	if (sg_count == 0)
+		goto out;
+
+	sg = scsi_sglist(scmd);
+	sg_descriptor = request->sg_descriptors;
+
+	num_sg_in_iu = pqi_build_sg_list(sg_descriptor, sg, sg_count, io_request,
+		ctrl_info->max_sg_per_r56_iu, &chained);
+
+	request->partial = chained;
+	iu_length += num_sg_in_iu * sizeof(*sg_descriptor);
+
+out:
+	put_unaligned_le16(iu_length, &request->header.iu_length);
+	request->num_sg_descriptors = num_sg_in_iu;
+
+	return 0;
+}
+
 static int pqi_build_aio_sg_list(struct pqi_ctrl_info *ctrl_info,
 	struct pqi_aio_path_request *request, struct scsi_cmnd *scmd,
 	struct pqi_io_request *io_request)
@@ -5335,6 +5424,88 @@ static int pqi_aio_submit_io(struct pqi_ctrl_info *ctrl_info,
 	return 0;
 }
 
+static int pqi_aio_submit_r56_write_io(struct pqi_ctrl_info *ctrl_info,
+	struct scsi_cmnd *scmd, struct pqi_queue_group *queue_group,
+	struct pqi_encryption_info *encryption_info, struct pqi_scsi_dev *device,
+	struct pqi_scsi_dev_raid_map_data *rmd)
+{
+	int rc;
+	struct pqi_io_request *io_request;
+	struct pqi_aio_r56_path_request *r56_request;
+
+	io_request = pqi_alloc_io_request(ctrl_info);
+	io_request->io_complete_callback = pqi_aio_io_complete;
+	io_request->scmd = scmd;
+	io_request->raid_bypass = true;
+
+	r56_request = io_request->iu;
+	memset(r56_request, 0, offsetof(struct pqi_aio_r56_path_request, sg_descriptors));
+
+	if (device->raid_level == SA_RAID_5 || device->raid_level == SA_RAID_51)
+		r56_request->header.iu_type = PQI_REQUEST_IU_AIO_PATH_RAID5_IO;
+	else
+		r56_request->header.iu_type = PQI_REQUEST_IU_AIO_PATH_RAID6_IO;
+
+	put_unaligned_le16(*(u16 *)device->scsi3addr & 0x3fff, &r56_request->volume_id);
+	put_unaligned_le32(rmd->aio_handle, &r56_request->data_it_nexus);
+	put_unaligned_le32(rmd->p_parity_it_nexus, &r56_request->p_parity_it_nexus);
+	if (rmd->raid_level == SA_RAID_6) {
+		put_unaligned_le32(rmd->q_parity_it_nexus, &r56_request->q_parity_it_nexus);
+		r56_request->xor_multiplier = rmd->xor_mult;
+	}
+	put_unaligned_le32(scsi_bufflen(scmd), &r56_request->data_length);
+	r56_request->task_attribute = SOP_TASK_ATTRIBUTE_SIMPLE;
+	put_unaligned_le64(rmd->row, &r56_request->row);
+
+	put_unaligned_le16(io_request->index, &r56_request->request_id);
+	r56_request->error_index = r56_request->request_id;
+
+	if (rmd->cdb_length > sizeof(r56_request->cdb))
+		rmd->cdb_length = sizeof(r56_request->cdb);
+	r56_request->cdb_length = rmd->cdb_length;
+	memcpy(r56_request->cdb, rmd->cdb, rmd->cdb_length);
+
+	switch (scmd->sc_data_direction) {
+	case DMA_TO_DEVICE:
+		r56_request->data_direction = SOP_READ_FLAG;
+		break;
+	case DMA_FROM_DEVICE:
+		r56_request->data_direction = SOP_WRITE_FLAG;
+		break;
+	case DMA_NONE:
+		r56_request->data_direction = SOP_NO_DIRECTION_FLAG;
+		break;
+	case DMA_BIDIRECTIONAL:
+		r56_request->data_direction = SOP_BIDIRECTIONAL;
+		break;
+	default:
+		dev_err(&ctrl_info->pci_dev->dev,
+			"unknown data direction: %d\n",
+			scmd->sc_data_direction);
+		break;
+	}
+
+	if (encryption_info) {
+		r56_request->encryption_enable = true;
+		put_unaligned_le16(encryption_info->data_encryption_key_index,
+				&r56_request->data_encryption_key_index);
+		put_unaligned_le32(encryption_info->encrypt_tweak_lower,
+				&r56_request->encrypt_tweak_lower);
+		put_unaligned_le32(encryption_info->encrypt_tweak_upper,
+				&r56_request->encrypt_tweak_upper);
+	}
+
+	rc = pqi_build_aio_r56_sg_list(ctrl_info, r56_request, scmd, io_request);
+	if (rc) {
+		pqi_free_io_request(io_request);
+		return SCSI_MLQUEUE_HOST_BUSY;
+	}
+
+	pqi_start_io(ctrl_info, queue_group, AIO_PATH, io_request);
+
+	return 0;
+}
+
 static inline u16 pqi_get_hw_queue(struct pqi_ctrl_info *ctrl_info,
 	struct scsi_cmnd *scmd)
 {
@@ -6298,6 +6469,60 @@ static ssize_t pqi_lockup_action_store(struct device *dev,
 	return -EINVAL;
 }
 
+static ssize_t pqi_host_enable_r5_writes_show(struct device *dev,
+	struct device_attribute *attr, char *buffer)
+{
+	struct Scsi_Host *shost = class_to_shost(dev);
+	struct pqi_ctrl_info *ctrl_info = shost_to_hba(shost);
+
+	return scnprintf(buffer, 10, "%hhx\n", ctrl_info->enable_r5_writes);
+}
+
+static ssize_t pqi_host_enable_r5_writes_store(struct device *dev,
+	struct device_attribute *attr, const char *buffer, size_t count)
+{
+	struct Scsi_Host *shost = class_to_shost(dev);
+	struct pqi_ctrl_info *ctrl_info = shost_to_hba(shost);
+	u8 set_r5_writes = 0;
+
+	if (kstrtou8(buffer, 0, &set_r5_writes))
+		return -EINVAL;
+
+	if (set_r5_writes > 0)
+		set_r5_writes = 1;
+
+	ctrl_info->enable_r5_writes = set_r5_writes;
+
+	return count;
+}
+
+static ssize_t pqi_host_enable_r6_writes_show(struct device *dev,
+	struct device_attribute *attr, char *buffer)
+{
+	struct Scsi_Host *shost = class_to_shost(dev);
+	struct pqi_ctrl_info *ctrl_info = shost_to_hba(shost);
+
+	return scnprintf(buffer, 10, "%hhx\n", ctrl_info->enable_r6_writes);
+}
+
+static ssize_t pqi_host_enable_r6_writes_store(struct device *dev,
+	struct device_attribute *attr, const char *buffer, size_t count)
+{
+	struct Scsi_Host *shost = class_to_shost(dev);
+	struct pqi_ctrl_info *ctrl_info = shost_to_hba(shost);
+	u8 set_r6_writes = 0;
+
+	if (kstrtou8(buffer, 0, &set_r6_writes))
+		return -EINVAL;
+
+	if (set_r6_writes > 0)
+		set_r6_writes = 1;
+
+	ctrl_info->enable_r6_writes = set_r6_writes;
+
+	return count;
+}
+
 static DEVICE_ATTR(driver_version, 0444, pqi_driver_version_show, NULL);
 static DEVICE_ATTR(firmware_version, 0444, pqi_firmware_version_show, NULL);
 static DEVICE_ATTR(model, 0444, pqi_model_show, NULL);
@@ -6306,6 +6531,10 @@ static DEVICE_ATTR(vendor, 0444, pqi_vendor_show, NULL);
 static DEVICE_ATTR(rescan, 0200, NULL, pqi_host_rescan_store);
 static DEVICE_ATTR(lockup_action, 0644, pqi_lockup_action_show,
 	pqi_lockup_action_store);
+static DEVICE_ATTR(enable_r5_writes, 0644,
+	pqi_host_enable_r5_writes_show, pqi_host_enable_r5_writes_store);
+static DEVICE_ATTR(enable_r6_writes, 0644,
+	pqi_host_enable_r6_writes_show, pqi_host_enable_r6_writes_store);
 
 static struct device_attribute *pqi_shost_attrs[] = {
 	&dev_attr_driver_version,
@@ -6315,6 +6544,8 @@ static struct device_attribute *pqi_shost_attrs[] = {
 	&dev_attr_vendor,
 	&dev_attr_rescan,
 	&dev_attr_lockup_action,
+	&dev_attr_enable_r5_writes,
+	&dev_attr_enable_r6_writes,
 	NULL
 };
 

