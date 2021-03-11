Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8388337ED8
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Mar 2021 21:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbhCKUPz (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 11 Mar 2021 15:15:55 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:58776 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhCKUPq (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 11 Mar 2021 15:15:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1615493747; x=1647029747;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2YdUHJANKnqs+zx5TpPN/TZu9Q+41ZM9AOWF8ReHyPg=;
  b=P0My5DsS6vs5bRjnItc7ehwqvJv7ZzRnkPFyPCYux6n5dH7oXg3R72bU
   OWE2CeG8TB2rYCh+S6Nuw5Y7RQwyI18c4D7iMdEl9u+72kAUgkzRlpj0Z
   rlks9MZaiISAyyv6ZuvENFGmVyYEtUzMZ/mIspnwMBPbWwfknxLGQmGcg
   qF5YueaCQrULPdffDdVZqIOa1Q8CAyMwZ79X2G7dQBBipnJFOFUkN2c/s
   Yy3G9dbtqF1OgmryDX3+s2HvRzdBSvKqTe4+K/VoenmA4HInCQrNb4jzl
   AaGL43nc/j3dDk59B3JpQirnkGYkTubGmMAHe0QK8RSeB9VE4ne5nUnMT
   g==;
IronPort-SDR: RRm9ZXkvF9Z33gk9nv6MiNROjzP/kQ9i8uvJix0OmH0qfkmYY0+9WXykXSyZOCKTR1fIfycmx6
 49J9CCy2Ty8a+euNDj5WEgn7GHJIDMXzb28Lq11k/b+yAPliynY+mmyxr2kp1ZTBrI6hqQd7b7
 aeIjw5zPqGJtitTWoyaZj/dFKu0gFKhzhW4IoTStoSZUgVpQOqmgB480OwbzwjkJW3qEHVZftc
 4JchVVCzzGN6TKuUYyZus1OPytwfWbS+rpX9EGtTG7EU9o9fDMd3UiO1q/jrTRQhkTz5xBrpJR
 Zco=
X-IronPort-AV: E=Sophos;i="5.81,241,1610434800"; 
   d="scan'208";a="109660001"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Mar 2021 13:15:46 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 11 Mar 2021 13:15:33 -0700
Received: from [127.0.1.1] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Thu, 11 Mar 2021 13:15:33 -0700
Subject: [PATCH V5 07/31] smartpqi: add support for raid1 writes
From:   Don Brace <don.brace@microchip.com>
To:     <Kevin.Barnett@microchip.com>, <scott.teel@microchip.com>,
        <Justin.Lindley@microchip.com>, <scott.benesh@microchip.com>,
        <gerry.morong@microchip.com>, <mahesh.rajashekhara@microchip.com>,
        <mike.mcgowen@microchip.com>, <murthy.bhat@microchip.com>,
        <hch@infradead.org>, <jejb@linux.vnet.ibm.com>,
        <joseph.szczypek@hpe.com>, <POSWALD@suse.com>
CC:     <linux-scsi@vger.kernel.org>
Date:   Thu, 11 Mar 2021 14:15:33 -0600
Message-ID: <161549373324.25025.2441592111049564780.stgit@brunhilda>
In-Reply-To: <161549045434.25025.17473629602756431540.stgit@brunhilda>
References: <161549045434.25025.17473629602756431540.stgit@brunhilda>
User-Agent: StGit/0.23-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

* Add raid1 write IU.
* Add in raid1 write support.
* Change brand names ADM/ADG to TRIPLE/RAID-6

Reviewed-by: Scott Benesh <scott.benesh@microchip.com>
Reviewed-by: Scott Teel <scott.teel@microchip.com>
Reviewed-by: Kevin Barnett <kevin.barnett@microchip.com>
Signed-off-by: Don Brace <don.brace@microchip.com>
---
 drivers/scsi/smartpqi/smartpqi.h      |   37 +++++
 drivers/scsi/smartpqi/smartpqi_init.c |  228 ++++++++++++++++++++++-----------
 2 files changed, 183 insertions(+), 82 deletions(-)

diff --git a/drivers/scsi/smartpqi/smartpqi.h b/drivers/scsi/smartpqi/smartpqi.h
index a2fd246c8ae8..bed80c4c4598 100644
--- a/drivers/scsi/smartpqi/smartpqi.h
+++ b/drivers/scsi/smartpqi/smartpqi.h
@@ -313,6 +313,36 @@ struct pqi_aio_path_request {
 		sg_descriptors[PQI_MAX_EMBEDDED_SG_DESCRIPTORS];
 };
 
+#define PQI_RAID1_NVME_XFER_LIMIT	(32 * 1024)	/* 32 KiB */
+struct pqi_aio_r1_path_request {
+	struct pqi_iu_header header;
+	__le16	request_id;
+	__le16	volume_id;	/* ID of the RAID volume */
+	__le32	it_nexus_1;	/* IT nexus of the 1st drive in the RAID volume */
+	__le32	it_nexus_2;	/* IT nexus of the 2nd drive in the RAID volume */
+	__le32	it_nexus_3;	/* IT nexus of the 3rd drive in the RAID volume */
+	__le32	data_length;	/* total bytes to read/write */
+	u8	data_direction : 2;
+	u8	partial : 1;
+	u8	memory_type : 1;
+	u8	fence : 1;
+	u8	encryption_enable : 1;
+	u8	reserved : 2;
+	u8	task_attribute : 3;
+	u8	command_priority : 4;
+	u8	reserved2 : 1;
+	__le16	data_encryption_key_index;
+	u8	cdb[16];
+	__le16	error_index;
+	u8	num_sg_descriptors;
+	u8	cdb_length;
+	u8	num_drives;	/* number of drives in the RAID volume (2 or 3) */
+	u8	reserved3[3];
+	__le32	encrypt_tweak_lower;
+	__le32	encrypt_tweak_upper;
+	struct pqi_sg_descriptor sg_descriptors[PQI_MAX_EMBEDDED_SG_DESCRIPTORS];
+};
+
 struct pqi_aio_r56_path_request {
 	struct pqi_iu_header header;
 	__le16	request_id;
@@ -518,6 +548,7 @@ struct pqi_raid_error_info {
 #define PQI_REQUEST_IU_AIO_PATH_IO			0x15
 #define PQI_REQUEST_IU_AIO_PATH_RAID5_IO		0x18
 #define PQI_REQUEST_IU_AIO_PATH_RAID6_IO		0x19
+#define PQI_REQUEST_IU_AIO_PATH_RAID1_IO		0x1A
 #define PQI_REQUEST_IU_GENERAL_ADMIN			0x60
 #define PQI_REQUEST_IU_REPORT_VENDOR_EVENT_CONFIG	0x72
 #define PQI_REQUEST_IU_SET_VENDOR_EVENT_CONFIG		0x73
@@ -970,14 +1001,12 @@ struct pqi_scsi_dev_raid_map_data {
 	u16	strip_size;
 	u32	first_group;
 	u32	last_group;
-	u32	current_group;
 	u32	map_row;
 	u32	aio_handle;
 	u64	disk_block;
 	u32	disk_block_cnt;
 	u8	cdb[16];
 	u8	cdb_length;
-	int	offload_to_mirror;
 
 	/* RAID1 specific */
 #define NUM_RAID1_MAP_ENTRIES	3
@@ -1038,8 +1067,7 @@ struct pqi_scsi_dev {
 	u16	phys_connector[8];
 	bool	raid_bypass_configured;	/* RAID bypass configured */
 	bool	raid_bypass_enabled;	/* RAID bypass enabled */
-	int	offload_to_mirror;	/* Send next RAID bypass request */
-					/* to mirror drive. */
+	u32	next_bypass_group;
 	struct raid_map *raid_map;	/* RAID bypass map */
 
 	struct pqi_sas_port *sas_port;
@@ -1245,6 +1273,7 @@ struct pqi_ctrl_info {
 	u8		soft_reset_handshake_supported : 1;
 	u8		raid_iu_timeout_supported: 1;
 	u8		tmf_iu_timeout_supported: 1;
+	u8		enable_r1_writes : 1;
 	u8		enable_r5_writes : 1;
 	u8		enable_r6_writes : 1;
 
diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index 17b697022473..a36861184fc0 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -67,6 +67,10 @@ static int pqi_aio_submit_io(struct pqi_ctrl_info *ctrl_info,
 	struct scsi_cmnd *scmd, u32 aio_handle, u8 *cdb,
 	unsigned int cdb_length, struct pqi_queue_group *queue_group,
 	struct pqi_encryption_info *encryption_info, bool raid_bypass);
+static  int pqi_aio_submit_r1_write_io(struct pqi_ctrl_info *ctrl_info,
+	struct scsi_cmnd *scmd, struct pqi_queue_group *queue_group,
+	struct pqi_encryption_info *encryption_info, struct pqi_scsi_dev *device,
+	struct pqi_scsi_dev_raid_map_data *rmd);
 static int pqi_aio_submit_r56_write_io(struct pqi_ctrl_info *ctrl_info,
 	struct scsi_cmnd *scmd, struct pqi_queue_group *queue_group,
 	struct pqi_encryption_info *encryption_info, struct pqi_scsi_dev *device,
@@ -167,8 +171,8 @@ static char *raid_levels[] = {
 	"RAID-1(1+0)",
 	"RAID-5",
 	"RAID-5+1",
-	"RAID-ADG",
-	"RAID-1(ADM)",
+	"RAID-6",
+	"RAID-1(Triple)",
 };
 
 static char *pqi_raid_level_to_string(u8 raid_level)
@@ -185,8 +189,8 @@ static char *pqi_raid_level_to_string(u8 raid_level)
 #define SA_RAID_5		3	/* also used for RAID 50 */
 #define SA_RAID_51		4
 #define SA_RAID_6		5	/* also used for RAID 60 */
-#define SA_RAID_ADM		6	/* also used for RAID 1+0 ADM */
-#define SA_RAID_MAX		SA_RAID_ADM
+#define SA_RAID_TRIPLE		6	/* also used for RAID 1+0 Triple */
+#define SA_RAID_MAX		SA_RAID_TRIPLE
 #define SA_RAID_UNKNOWN		0xff
 
 static inline void pqi_scsi_done(struct scsi_cmnd *scmd)
@@ -1141,9 +1145,9 @@ static int pqi_validate_raid_map(struct pqi_ctrl_info *ctrl_info,
 			err_msg = "invalid RAID-1 map";
 			goto bad_raid_map;
 		}
-	} else if (device->raid_level == SA_RAID_ADM) {
+	} else if (device->raid_level == SA_RAID_TRIPLE) {
 		if (get_unaligned_le16(&raid_map->layout_map_count) != 3) {
-			err_msg = "invalid RAID-1(ADM) map";
+			err_msg = "invalid RAID-1(Triple) map";
 			goto bad_raid_map;
 		}
 	} else if ((device->raid_level == SA_RAID_5 ||
@@ -1717,7 +1721,7 @@ static void pqi_scsi_update_device(struct pqi_scsi_dev *existing_device,
 		sizeof(existing_device->box));
 	memcpy(existing_device->phys_connector, new_device->phys_connector,
 		sizeof(existing_device->phys_connector));
-	existing_device->offload_to_mirror = 0;
+	existing_device->next_bypass_group = 0;
 	kfree(existing_device->raid_map);
 	existing_device->raid_map = new_device->raid_map;
 	existing_device->raid_bypass_configured =
@@ -2250,7 +2254,8 @@ static bool pqi_aio_raid_level_supported(struct pqi_ctrl_info *ctrl_info,
 	case SA_RAID_0:
 		break;
 	case SA_RAID_1:
-		if (rmd->is_write)
+	case SA_RAID_TRIPLE:
+		if (rmd->is_write && !ctrl_info->enable_r1_writes)
 			is_supported = false;
 		break;
 	case SA_RAID_5:
@@ -2261,10 +2266,6 @@ static bool pqi_aio_raid_level_supported(struct pqi_ctrl_info *ctrl_info,
 		if (rmd->is_write && !ctrl_info->enable_r6_writes)
 			is_supported = false;
 		break;
-	case SA_RAID_ADM:
-		if (rmd->is_write)
-			is_supported = false;
-		break;
 	default:
 		is_supported = false;
 	}
@@ -2386,64 +2387,6 @@ static int pci_get_aio_common_raid_map_values(struct pqi_ctrl_info *ctrl_info,
 	return 0;
 }
 
-static int pqi_calc_aio_raid_adm(struct pqi_scsi_dev_raid_map_data *rmd,
-				struct pqi_scsi_dev *device)
-{
-	/* RAID ADM */
-	/*
-	 * Handles N-way mirrors  (R1-ADM) and R10 with # of drives
-	 * divisible by 3.
-	 */
-	rmd->offload_to_mirror = device->offload_to_mirror;
-
-	if (rmd->offload_to_mirror == 0)  {
-		/* use physical disk in the first mirrored group. */
-		rmd->map_index %= rmd->data_disks_per_row;
-	} else {
-		do {
-			/*
-			 * Determine mirror group that map_index
-			 * indicates.
-			 */
-			rmd->current_group =
-				rmd->map_index / rmd->data_disks_per_row;
-
-			if (rmd->offload_to_mirror !=
-					rmd->current_group) {
-				if (rmd->current_group <
-					rmd->layout_map_count - 1) {
-					/*
-					 * Select raid index from
-					 * next group.
-					 */
-					rmd->map_index += rmd->data_disks_per_row;
-					rmd->current_group++;
-				} else {
-					/*
-					 * Select raid index from first
-					 * group.
-					 */
-					rmd->map_index %= rmd->data_disks_per_row;
-					rmd->current_group = 0;
-				}
-			}
-		} while (rmd->offload_to_mirror != rmd->current_group);
-	}
-
-	/* Set mirror group to use next time. */
-	rmd->offload_to_mirror =
-		(rmd->offload_to_mirror >= rmd->layout_map_count - 1) ?
-			0 : rmd->offload_to_mirror + 1;
-	device->offload_to_mirror = rmd->offload_to_mirror;
-	/*
-	 * Avoid direct use of device->offload_to_mirror within this
-	 * function since multiple threads might simultaneously
-	 * increment it beyond the range of device->layout_map_count -1.
-	 */
-
-	return 0;
-}
-
 static int pqi_calc_aio_r5_or_r6(struct pqi_scsi_dev_raid_map_data *rmd,
 				struct raid_map *raid_map)
 {
@@ -2590,12 +2533,34 @@ static void pqi_set_aio_cdb(struct pqi_scsi_dev_raid_map_data *rmd)
 	}
 }
 
+static void pqi_calc_aio_r1_nexus(struct raid_map *raid_map,
+				struct pqi_scsi_dev_raid_map_data *rmd)
+{
+	u32 index;
+	u32 group;
+
+	group = rmd->map_index / rmd->data_disks_per_row;
+
+	index = rmd->map_index - (group * rmd->data_disks_per_row);
+	rmd->it_nexus[0] = raid_map->disk_data[index].aio_handle;
+	index += rmd->data_disks_per_row;
+	rmd->it_nexus[1] = raid_map->disk_data[index].aio_handle;
+	if (rmd->layout_map_count > 2) {
+		index += rmd->data_disks_per_row;
+		rmd->it_nexus[2] = raid_map->disk_data[index].aio_handle;
+	}
+
+	rmd->num_it_nexus_entries = rmd->layout_map_count;
+}
+
 static int pqi_raid_bypass_submit_scsi_cmd(struct pqi_ctrl_info *ctrl_info,
 	struct pqi_scsi_dev *device, struct scsi_cmnd *scmd,
 	struct pqi_queue_group *queue_group)
 {
-	struct raid_map *raid_map;
 	int rc;
+	struct raid_map *raid_map;
+	u32 group;
+	u32 next_bypass_group;
 	struct pqi_encryption_info *encryption_info_ptr;
 	struct pqi_encryption_info encryption_info;
 	struct pqi_scsi_dev_raid_map_data rmd = {0};
@@ -2618,13 +2583,18 @@ static int pqi_raid_bypass_submit_scsi_cmd(struct pqi_ctrl_info *ctrl_info,
 	if (rc)
 		return PQI_RAID_BYPASS_INELIGIBLE;
 
-	/* RAID 1 */
-	if (device->raid_level == SA_RAID_1) {
-		if (device->offload_to_mirror)
-			rmd.map_index += rmd.data_disks_per_row;
-		device->offload_to_mirror = !device->offload_to_mirror;
-	} else if (device->raid_level == SA_RAID_ADM) {
-		rc = pqi_calc_aio_raid_adm(&rmd, device);
+	if (device->raid_level == SA_RAID_1 ||
+		device->raid_level == SA_RAID_TRIPLE) {
+		if (rmd.is_write) {
+			pqi_calc_aio_r1_nexus(raid_map, &rmd);
+		} else {
+			group = device->next_bypass_group;
+			next_bypass_group = group + 1;
+			if (next_bypass_group >= rmd.layout_map_count)
+				next_bypass_group = 0;
+			device->next_bypass_group = next_bypass_group;
+			rmd.map_index += group * rmd.data_disks_per_row;
+		}
 	} else if ((device->raid_level == SA_RAID_5 ||
 		device->raid_level == SA_RAID_6) &&
 		(rmd.layout_map_count > 1 || rmd.is_write)) {
@@ -2668,6 +2638,10 @@ static int pqi_raid_bypass_submit_scsi_cmd(struct pqi_ctrl_info *ctrl_info,
 			return pqi_aio_submit_io(ctrl_info, scmd, rmd.aio_handle,
 				rmd.cdb, rmd.cdb_length, queue_group,
 				encryption_info_ptr, true);
+		case SA_RAID_1:
+		case SA_RAID_TRIPLE:
+			return pqi_aio_submit_r1_write_io(ctrl_info, scmd, queue_group,
+				encryption_info_ptr, device, &rmd);
 		case SA_RAID_5:
 		case SA_RAID_6:
 			return pqi_aio_submit_r56_write_io(ctrl_info, scmd, queue_group,
@@ -4995,6 +4969,44 @@ static int pqi_build_raid_sg_list(struct pqi_ctrl_info *ctrl_info,
 	return 0;
 }
 
+static int pqi_build_aio_r1_sg_list(struct pqi_ctrl_info *ctrl_info,
+	struct pqi_aio_r1_path_request *request, struct scsi_cmnd *scmd,
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
+	iu_length = offsetof(struct pqi_aio_r1_path_request, sg_descriptors) -
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
+		ctrl_info->max_sg_per_iu, &chained);
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
 static int pqi_build_aio_r56_sg_list(struct pqi_ctrl_info *ctrl_info,
 	struct pqi_aio_r56_path_request *request, struct scsi_cmnd *scmd,
 	struct pqi_io_request *io_request)
@@ -5435,6 +5447,66 @@ static int pqi_aio_submit_io(struct pqi_ctrl_info *ctrl_info,
 	return 0;
 }
 
+static  int pqi_aio_submit_r1_write_io(struct pqi_ctrl_info *ctrl_info,
+	struct scsi_cmnd *scmd, struct pqi_queue_group *queue_group,
+	struct pqi_encryption_info *encryption_info, struct pqi_scsi_dev *device,
+	struct pqi_scsi_dev_raid_map_data *rmd)
+
+{
+	int rc;
+	struct pqi_io_request *io_request;
+	struct pqi_aio_r1_path_request *r1_request;
+
+	io_request = pqi_alloc_io_request(ctrl_info);
+	io_request->io_complete_callback = pqi_aio_io_complete;
+	io_request->scmd = scmd;
+	io_request->raid_bypass = true;
+
+	r1_request = io_request->iu;
+	memset(r1_request, 0, offsetof(struct pqi_aio_r1_path_request, sg_descriptors));
+
+	r1_request->header.iu_type = PQI_REQUEST_IU_AIO_PATH_RAID1_IO;
+
+	put_unaligned_le16(*(u16 *)device->scsi3addr & 0x3fff, &r1_request->volume_id);
+	r1_request->num_drives = rmd->num_it_nexus_entries;
+	put_unaligned_le32(rmd->it_nexus[0], &r1_request->it_nexus_1);
+	put_unaligned_le32(rmd->it_nexus[1], &r1_request->it_nexus_2);
+	if (rmd->num_it_nexus_entries == 3)
+		put_unaligned_le32(rmd->it_nexus[2], &r1_request->it_nexus_3);
+
+	put_unaligned_le32(scsi_bufflen(scmd), &r1_request->data_length);
+	r1_request->task_attribute = SOP_TASK_ATTRIBUTE_SIMPLE;
+	put_unaligned_le16(io_request->index, &r1_request->request_id);
+	r1_request->error_index = r1_request->request_id;
+	if (rmd->cdb_length > sizeof(r1_request->cdb))
+		rmd->cdb_length = sizeof(r1_request->cdb);
+	r1_request->cdb_length = rmd->cdb_length;
+	memcpy(r1_request->cdb, rmd->cdb, rmd->cdb_length);
+
+	/* The direction is always write. */
+	r1_request->data_direction = SOP_READ_FLAG;
+
+	if (encryption_info) {
+		r1_request->encryption_enable = true;
+		put_unaligned_le16(encryption_info->data_encryption_key_index,
+				&r1_request->data_encryption_key_index);
+		put_unaligned_le32(encryption_info->encrypt_tweak_lower,
+				&r1_request->encrypt_tweak_lower);
+		put_unaligned_le32(encryption_info->encrypt_tweak_upper,
+				&r1_request->encrypt_tweak_upper);
+	}
+
+	rc = pqi_build_aio_r1_sg_list(ctrl_info, r1_request, scmd, io_request);
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
 static int pqi_aio_submit_r56_write_io(struct pqi_ctrl_info *ctrl_info,
 	struct scsi_cmnd *scmd, struct pqi_queue_group *queue_group,
 	struct pqi_encryption_info *encryption_info, struct pqi_scsi_dev *device,

