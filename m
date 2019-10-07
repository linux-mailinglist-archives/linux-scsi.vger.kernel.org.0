Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD8FCEF19
	for <lists+linux-scsi@lfdr.de>; Tue,  8 Oct 2019 00:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729528AbfJGWcM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 7 Oct 2019 18:32:12 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:17338 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729413AbfJGWcM (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 7 Oct 2019 18:32:12 -0400
Authentication-Results: esa6.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=don.brace@microsemi.com; spf=None smtp.helo=postmaster@email.microchip.com
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  don.brace@microsemi.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="don.brace@microsemi.com";
  x-sender="don.brace@microsemi.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:68.232.147.0/24 ip4:68.232.148.0/22 ip4:68.232.152.0/23
  ip4:68.232.154.0/24 ip4:216.71.150.0/24 ip4:216.71.151.0/24
  ip4:216.71.152.0/23 ip4:216.71.154.0/24 ip4:198.175.253.41
  ip4:198.175.253.82 include:servers.mcsv.net -all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="don.brace@microsemi.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
X-Ironport-Dmarc-Check-Result: validskip
IronPort-SDR: XCNOsxPc6/C710D1PQZwt0EhQOjyx9MfqJEDdlY7JszmHzH/cxviOzIoA70DZLICvhICz3K181
 05UIyJI5bTGDn2NrC5v520d/TN+2InyjV5UOPd3X/jiEfLJp5DEoKd0eb3tCFAQWV7x+U6OVJA
 keU+aijS2S8hC6wNt6B6VRkpls4NzJLjXt8vWiJXJ/CKKXtIs3N629jBuAv9/6JBpg3BOW2gM+
 EQENH62OxNVjbG9tUgietjtmo5oOWDpehAZSStaC7MGU+rH8xaWcUxkqn8h8Hcrd6+aEROqE9d
 vPs=
X-IronPort-AV: E=Sophos;i="5.67,269,1566889200"; 
   d="scan'208";a="49125785"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Oct 2019 15:32:11 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 7 Oct 2019 15:32:10 -0700
Received: from [127.0.1.1] (10.10.85.251) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 7 Oct 2019 15:32:10 -0700
Subject: [PATCH 09/10] smartpqi-align-driver-syntax-with-oob
From:   Don Brace <don.brace@microsemi.com>
To:     <Kevin.Barnett@microchip.com>, <scott.teel@microchip.com>,
        <Justin.Lindley@microchip.com>, <scott.benesh@microchip.com>,
        <bader.alisaleh@microchip.com>, <gerry.morong@microchip.com>,
        <mahesh.rajashekhara@microchip.com>, <hch@infradead.org>,
        <jejb@linux.vnet.ibm.com>, <joseph.szczypek@hpe.com>,
        <POSWALD@suse.com>, <shunyong.yang@hxt-semitech.com>
CC:     <linux-scsi@vger.kernel.org>
Date:   Mon, 7 Oct 2019 17:32:10 -0500
Message-ID: <157048753005.11757.2228541207280057256.stgit@brunhilda>
In-Reply-To: <157048745695.11757.6602264644727193780.stgit@brunhilda>
References: <157048745695.11757.6602264644727193780.stgit@brunhilda>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Kevin Barnett <kevin.barnett@microsemi.com>

- a lot of formatting changes
- no functional changes.

Reviewed-by: Scott Benesh <scott.benesh@microsemi.com>
Reviewed-by: Scott Teel <scott.teel@microsemi.com>
Signed-off-by: Kevin Barnett <kevin.barnett@microsemi.com>
Signed-off-by: Don Brace <don.brace@microsemi.com>
---
 drivers/scsi/smartpqi/smartpqi.h               |   60 ++++-----
 drivers/scsi/smartpqi/smartpqi_init.c          |  157 +++++++++++++-----------
 drivers/scsi/smartpqi/smartpqi_sas_transport.c |   20 ---
 3 files changed, 114 insertions(+), 123 deletions(-)

diff --git a/drivers/scsi/smartpqi/smartpqi.h b/drivers/scsi/smartpqi/smartpqi.h
index c42bf033109e..1129fe7a27ed 100644
--- a/drivers/scsi/smartpqi/smartpqi.h
+++ b/drivers/scsi/smartpqi/smartpqi.h
@@ -448,7 +448,7 @@ struct pqi_vendor_general_response {
 
 struct pqi_ofa_memory {
 	__le64	signature;	/* "OFA_QRM" */
-	__le16	version;	/* version of this struct(1 = 1st version) */
+	__le16	version;	/* version of this struct (1 = 1st version) */
 	u8	reserved[62];
 	__le32	bytes_allocated;	/* total allocated memory in bytes */
 	__le16	num_memory_descriptors;
@@ -831,10 +831,17 @@ union pqi_reset_register {
 
 struct report_lun_header {
 	__be32	list_length;
-	u8	extended_response;
+	u8	flags;
 	u8	reserved[3];
 };
 
+/* for flags field of struct report_lun_header */
+#define CISS_REPORT_LOG_FLAG_UNIQUE_LUN_ID	(1 << 0)
+#define CISS_REPORT_LOG_FLAG_QUEUE_DEPTH	(1 << 5)
+#define CISS_REPORT_LOG_FLAG_DRIVE_TYPE_MIX	(1 << 6)
+
+#define CISS_REPORT_PHYS_FLAG_OTHER		(1 << 1)
+
 struct report_log_lun_extended_entry {
 	u8	lunid[8];
 	u8	volume_id[16];
@@ -856,7 +863,7 @@ struct report_phys_lun_extended_entry {
 };
 
 /* for device_flags field of struct report_phys_lun_extended_entry */
-#define REPORT_PHYS_LUN_DEV_FLAG_AIO_ENABLED	0x8
+#define CISS_REPORT_PHYS_DEV_FLAG_AIO_ENABLED	0x8
 
 struct report_phys_lun_extended {
 	struct report_lun_header header;
@@ -869,7 +876,7 @@ struct raid_map_disk_data {
 	u8	reserved[2];
 };
 
-/* constants for flags field of RAID map */
+/* for flags field of RAID map */
 #define RAID_MAP_ENCRYPTION_ENABLED	0x1
 
 struct raid_map {
@@ -1173,9 +1180,9 @@ struct pqi_ctrl_info {
 	spinlock_t	raid_bypass_retry_list_lock;
 	struct work_struct raid_bypass_retry_work;
 
-	struct          pqi_ofa_memory *pqi_ofa_mem_virt_addr;
-	dma_addr_t      pqi_ofa_mem_dma_handle;
-	void            **pqi_ofa_chunk_virt_addr;
+	struct pqi_ofa_memory *pqi_ofa_mem_virt_addr;
+	dma_addr_t	pqi_ofa_mem_dma_handle;
+	void		**pqi_ofa_chunk_virt_addr;
 	atomic_t	sync_cmds_outstanding;
 };
 
@@ -1195,10 +1202,6 @@ enum pqi_ctrl_mode {
 #define CISS_REPORT_PHYS	0xc3	/* Report Physical LUNs */
 #define CISS_GET_RAID_MAP	0xc8
 
-/* constants for CISS_REPORT_LOG/CISS_REPORT_PHYS commands */
-#define CISS_REPORT_LOG_EXTENDED		0x1
-#define CISS_REPORT_PHYS_EXTENDED		0x2
-
 /* BMIC commands */
 #define BMIC_IDENTIFY_CONTROLLER		0x11
 #define BMIC_IDENTIFY_PHYSICAL_DEVICE		0x15
@@ -1212,7 +1215,7 @@ enum pqi_ctrl_mode {
 #define BMIC_SET_DIAG_OPTIONS			0xf4
 #define BMIC_SENSE_DIAG_OPTIONS			0xf5
 
-#define CSMI_CC_SAS_SMP_PASSTHRU		0X17
+#define CSMI_CC_SAS_SMP_PASSTHRU		0x17
 
 #define SA_FLUSH_CACHE				0x1
 
@@ -1248,10 +1251,12 @@ struct bmic_sense_subsystem_info {
 	u8	ctrl_serial_number[16];
 };
 
-#define SA_EXPANDER_SMP_DEVICE		0x05
-#define SA_CONTROLLER_DEVICE		0x07
-/*SCSI Invalid Device Type for SAS devices*/
-#define PQI_SAS_SCSI_INVALID_DEVTYPE	0xff
+/* constants for device_type field */
+#define SA_DEVICE_TYPE_SATA		0x1
+#define SA_DEVICE_TYPE_SAS		0x2
+#define SA_DEVICE_TYPE_EXPANDER_SMP	0x5
+#define SA_DEVICE_TYPE_CONTROLLER	0x7
+#define SA_DEVICE_TYPE_NVME		0x9
 
 struct bmic_identify_physical_device {
 	u8	scsi_bus;		/* SCSI Bus number on controller */
@@ -1277,7 +1282,7 @@ struct bmic_identify_physical_device {
 	__le32	rpm;			/* drive rotational speed in RPM */
 	u8	device_type;		/* type of drive */
 	u8	sata_version;		/* only valid when device_type = */
-					/* BMIC_DEVICE_TYPE_SATA */
+					/* SA_DEVICE_TYPE_SATA */
 	__le64	big_total_block_count;
 	__le64	ris_starting_lba;
 	__le32	ris_size;
@@ -1400,18 +1405,6 @@ struct bmic_diag_options {
 
 #pragma pack()
 
-static inline struct pqi_ctrl_info *shost_to_hba(struct Scsi_Host *shost)
-{
-	void *hostdata = shost_priv(shost);
-
-	return *((struct pqi_ctrl_info **)hostdata);
-}
-
-static inline bool pqi_ctrl_offline(struct pqi_ctrl_info *ctrl_info)
-{
-	return !ctrl_info->controller_online;
-}
-
 static inline void pqi_ctrl_busy(struct pqi_ctrl_info *ctrl_info)
 {
 	atomic_inc(&ctrl_info->num_busy_threads);
@@ -1422,14 +1415,11 @@ static inline void pqi_ctrl_unbusy(struct pqi_ctrl_info *ctrl_info)
 	atomic_dec(&ctrl_info->num_busy_threads);
 }
 
-static inline bool pqi_ctrl_blocked(struct pqi_ctrl_info *ctrl_info)
+static inline struct pqi_ctrl_info *shost_to_hba(struct Scsi_Host *shost)
 {
-	return ctrl_info->block_requests;
-}
+	void *hostdata = shost_priv(shost);
 
-static inline bool pqi_device_reset_blocked(struct pqi_ctrl_info *ctrl_info)
-{
-	return ctrl_info->block_device_reset;
+	return *((struct pqi_ctrl_info **)hostdata);
 }
 
 void pqi_sas_smp_handler(struct bsg_job *job, struct Scsi_Host *shost,
diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index e443b682a89c..f179a745946d 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -211,6 +211,11 @@ static inline bool pqi_is_external_raid_addr(u8 *scsi3addr)
 	return scsi3addr[2] != 0;
 }
 
+static inline bool pqi_ctrl_offline(struct pqi_ctrl_info *ctrl_info)
+{
+	return !ctrl_info->controller_online;
+}
+
 static inline void pqi_check_ctrl_health(struct pqi_ctrl_info *ctrl_info)
 {
 	if (ctrl_info->controller_online)
@@ -235,6 +240,21 @@ static inline void pqi_save_ctrl_mode(struct pqi_ctrl_info *ctrl_info,
 	sis_write_driver_scratch(ctrl_info, mode);
 }
 
+static inline void pqi_ctrl_block_device_reset(struct pqi_ctrl_info *ctrl_info)
+{
+	ctrl_info->block_device_reset = true;
+}
+
+static inline bool pqi_device_reset_blocked(struct pqi_ctrl_info *ctrl_info)
+{
+	return ctrl_info->block_device_reset;
+}
+
+static inline bool pqi_ctrl_blocked(struct pqi_ctrl_info *ctrl_info)
+{
+	return ctrl_info->block_requests;
+}
+
 static inline void pqi_ctrl_block_requests(struct pqi_ctrl_info *ctrl_info)
 {
 	ctrl_info->block_requests = true;
@@ -249,11 +269,6 @@ static inline void pqi_ctrl_unblock_requests(struct pqi_ctrl_info *ctrl_info)
 	scsi_unblock_requests(ctrl_info->scsi_host);
 }
 
-static inline void pqi_ctrl_block_device_reset(struct pqi_ctrl_info *ctrl_info)
-{
-	ctrl_info->block_device_reset = true;
-}
-
 static unsigned long pqi_wait_if_ctrl_blocked(struct pqi_ctrl_info *ctrl_info,
 	unsigned long timeout_msecs)
 {
@@ -397,7 +412,7 @@ static inline u8 pqi_read_soft_reset_status(struct pqi_ctrl_info *ctrl_info)
 }
 
 static inline void pqi_clear_soft_reset_status(struct pqi_ctrl_info *ctrl_info,
-						u8 clear)
+	u8 clear)
 {
 	u8 status;
 
@@ -482,9 +497,9 @@ static int pqi_build_raid_path_request(struct pqi_ctrl_info *ctrl_info,
 		request->data_direction = SOP_READ_FLAG;
 		cdb[0] = cmd;
 		if (cmd == CISS_REPORT_PHYS)
-			cdb[1] = CISS_REPORT_PHYS_EXTENDED;
+			cdb[1] = CISS_REPORT_PHYS_FLAG_OTHER;
 		else
-			cdb[1] = CISS_REPORT_LOG_EXTENDED;
+			cdb[1] = CISS_REPORT_LOG_FLAG_UNIQUE_LUN_ID;
 		put_unaligned_be32(cdb_length, &cdb[6]);
 		break;
 	case CISS_GET_RAID_MAP:
@@ -587,13 +602,12 @@ static void pqi_free_io_request(struct pqi_io_request *io_request)
 }
 
 static int pqi_send_scsi_raid_request(struct pqi_ctrl_info *ctrl_info, u8 cmd,
-		u8 *scsi3addr, void *buffer, size_t buffer_length, u16 vpd_page,
-		struct pqi_raid_error_info *error_info,
-		unsigned long timeout_msecs)
+	u8 *scsi3addr, void *buffer, size_t buffer_length, u16 vpd_page,
+	struct pqi_raid_error_info *error_info,	unsigned long timeout_msecs)
 {
 	int rc;
-	enum dma_data_direction dir;
 	struct pqi_raid_path_request request;
+	enum dma_data_direction dir;
 
 	rc = pqi_build_raid_path_request(ctrl_info, &request,
 		cmd, scsi3addr, buffer,
@@ -601,44 +615,44 @@ static int pqi_send_scsi_raid_request(struct pqi_ctrl_info *ctrl_info, u8 cmd,
 	if (rc)
 		return rc;
 
-	rc = pqi_submit_raid_request_synchronous(ctrl_info, &request.header,
-		 0, error_info, timeout_msecs);
+	rc = pqi_submit_raid_request_synchronous(ctrl_info, &request.header, 0,
+		error_info, timeout_msecs);
 
 	pqi_pci_unmap(ctrl_info->pci_dev, request.sg_descriptors, 1, dir);
+
 	return rc;
 }
 
-/* Helper functions for pqi_send_scsi_raid_request */
+/* helper functions for pqi_send_scsi_raid_request */
 
 static inline int pqi_send_ctrl_raid_request(struct pqi_ctrl_info *ctrl_info,
-		u8 cmd, void *buffer, size_t buffer_length)
+	u8 cmd, void *buffer, size_t buffer_length)
 {
 	return pqi_send_scsi_raid_request(ctrl_info, cmd, RAID_CTLR_LUNID,
-			buffer, buffer_length, 0, NULL, NO_TIMEOUT);
+		buffer, buffer_length, 0, NULL, NO_TIMEOUT);
 }
 
 static inline int pqi_send_ctrl_raid_with_error(struct pqi_ctrl_info *ctrl_info,
-		u8 cmd, void *buffer, size_t buffer_length,
-		struct pqi_raid_error_info *error_info)
+	u8 cmd, void *buffer, size_t buffer_length,
+	struct pqi_raid_error_info *error_info)
 {
 	return pqi_send_scsi_raid_request(ctrl_info, cmd, RAID_CTLR_LUNID,
-			buffer, buffer_length, 0, error_info, NO_TIMEOUT);
+		buffer, buffer_length, 0, error_info, NO_TIMEOUT);
 }
 
-
 static inline int pqi_identify_controller(struct pqi_ctrl_info *ctrl_info,
-		struct bmic_identify_controller *buffer)
+	struct bmic_identify_controller *buffer)
 {
 	return pqi_send_ctrl_raid_request(ctrl_info, BMIC_IDENTIFY_CONTROLLER,
-			buffer, sizeof(*buffer));
+		buffer, sizeof(*buffer));
 }
 
 static inline int pqi_sense_subsystem_info(struct  pqi_ctrl_info *ctrl_info,
-		struct bmic_sense_subsystem_info *sense_info)
+	struct bmic_sense_subsystem_info *sense_info)
 {
 	return pqi_send_ctrl_raid_request(ctrl_info,
-			BMIC_SENSE_SUBSYSTEM_INFORMATION,
-			sense_info, sizeof(*sense_info));
+		BMIC_SENSE_SUBSYSTEM_INFORMATION, sense_info,
+		sizeof(*sense_info));
 }
 
 static inline int pqi_scsi_inquiry(struct pqi_ctrl_info *ctrl_info,
@@ -650,8 +664,7 @@ static inline int pqi_scsi_inquiry(struct pqi_ctrl_info *ctrl_info,
 
 static int pqi_identify_physical_device(struct pqi_ctrl_info *ctrl_info,
 	struct pqi_scsi_dev *device,
-	struct bmic_identify_physical_device *buffer,
-	size_t buffer_length)
+	struct bmic_identify_physical_device *buffer, size_t buffer_length)
 {
 	int rc;
 	enum dma_data_direction dir;
@@ -672,6 +685,7 @@ static int pqi_identify_physical_device(struct pqi_ctrl_info *ctrl_info,
 		0, NULL, NO_TIMEOUT);
 
 	pqi_pci_unmap(ctrl_info->pci_dev, request.sg_descriptors, 1, dir);
+
 	return rc;
 }
 
@@ -710,7 +724,7 @@ int pqi_csmi_smp_passthru(struct pqi_ctrl_info *ctrl_info,
 		buffer, buffer_length, error_info);
 }
 
-#define PQI_FETCH_PTRAID_DATA (1UL<<31)
+#define PQI_FETCH_PTRAID_DATA		(1 << 31)
 
 static int pqi_set_diag_rescan(struct pqi_ctrl_info *ctrl_info)
 {
@@ -722,14 +736,15 @@ static int pqi_set_diag_rescan(struct pqi_ctrl_info *ctrl_info)
 		return -ENOMEM;
 
 	rc = pqi_send_ctrl_raid_request(ctrl_info, BMIC_SENSE_DIAG_OPTIONS,
-					diag, sizeof(*diag));
+		diag, sizeof(*diag));
 	if (rc)
 		goto out;
 
 	diag->options |= cpu_to_le32(PQI_FETCH_PTRAID_DATA);
 
-	rc = pqi_send_ctrl_raid_request(ctrl_info, BMIC_SET_DIAG_OPTIONS,
-					diag, sizeof(*diag));
+	rc = pqi_send_ctrl_raid_request(ctrl_info, BMIC_SET_DIAG_OPTIONS, diag,
+		sizeof(*diag));
+
 out:
 	kfree(diag);
 
@@ -740,7 +755,7 @@ static inline int pqi_write_host_wellness(struct pqi_ctrl_info *ctrl_info,
 	void *buffer, size_t buffer_length)
 {
 	return pqi_send_ctrl_raid_request(ctrl_info, BMIC_WRITE_HOST_WELLNESS,
-					buffer, buffer_length);
+		buffer, buffer_length);
 }
 
 #pragma pack(1)
@@ -893,7 +908,7 @@ static inline int pqi_report_luns(struct pqi_ctrl_info *ctrl_info, u8 cmd,
 	void *buffer, size_t buffer_length)
 {
 	return pqi_send_ctrl_raid_request(ctrl_info, cmd, buffer,
-					buffer_length);
+		buffer_length);
 }
 
 static int pqi_report_phys_logical_luns(struct pqi_ctrl_info *ctrl_info, u8 cmd,
@@ -1227,9 +1242,9 @@ static void pqi_get_raid_bypass_status(struct pqi_ctrl_info *ctrl_info,
 	if (rc)
 		goto out;
 
-#define RAID_BYPASS_STATUS	4
-#define RAID_BYPASS_CONFIGURED	0x1
-#define RAID_BYPASS_ENABLED	0x2
+#define RAID_BYPASS_STATUS		4
+#define RAID_BYPASS_CONFIGURED		0x1
+#define RAID_BYPASS_ENABLED		0x2
 
 	bypass_status = buffer[RAID_BYPASS_STATUS];
 	device->raid_bypass_configured =
@@ -1352,6 +1367,7 @@ static void pqi_get_physical_disk_info(struct pqi_ctrl_info *ctrl_info,
 		device->queue_depth = PQI_PHYSICAL_DISK_DEFAULT_MAX_QUEUE_DEPTH;
 		return;
 	}
+
 	device->box_index = id_phys->box_index;
 	device->phys_box_on_bus = id_phys->phys_box_on_bus;
 	device->phy_connected_dev_type = id_phys->phy_connected_dev_type[0];
@@ -1767,7 +1783,7 @@ static void pqi_update_device_list(struct pqi_ctrl_info *ctrl_info,
 		device = new_device_list[i];
 
 		find_result = pqi_scsi_find_entry(ctrl_info, device,
-						&matching_device);
+			&matching_device);
 
 		switch (find_result) {
 		case DEVICE_SAME:
@@ -1996,9 +2012,8 @@ static int pqi_update_scsi_devices(struct pqi_ctrl_info *ctrl_info)
 			rc = -ENOMEM;
 			goto out;
 		}
-		if (pqi_hide_vsep) {
-			int i;
 
+		if (pqi_hide_vsep) {
 			for (i = num_physicals - 1; i >= 0; i--) {
 				phys_lun_ext_entry =
 						&physdev_list->lun_entries[i];
@@ -2071,7 +2086,7 @@ static int pqi_update_scsi_devices(struct pqi_ctrl_info *ctrl_info)
 		device->is_physical_device = is_physical_device;
 		if (is_physical_device) {
 			if (phys_lun_ext_entry->device_type ==
-				SA_EXPANDER_SMP_DEVICE)
+				SA_DEVICE_TYPE_EXPANDER_SMP)
 				device->is_expander_smp_device = true;
 		} else {
 			device->is_external_raid_device =
@@ -2108,16 +2123,13 @@ static int pqi_update_scsi_devices(struct pqi_ctrl_info *ctrl_info)
 		if (device->is_physical_device) {
 			device->wwid = phys_lun_ext_entry->wwid;
 			if ((phys_lun_ext_entry->device_flags &
-				REPORT_PHYS_LUN_DEV_FLAG_AIO_ENABLED) &&
+				CISS_REPORT_PHYS_DEV_FLAG_AIO_ENABLED) &&
 				phys_lun_ext_entry->aio_handle) {
 				device->aio_enabled = true;
-					device->aio_handle =
+				device->aio_handle =
 						phys_lun_ext_entry->aio_handle;
 			}
-
-				pqi_get_physical_disk_info(ctrl_info,
-					device, id_phys);
-
+			pqi_get_physical_disk_info(ctrl_info, device, id_phys);
 		} else {
 			memcpy(device->volume_id, log_lun_ext_entry->volume_id,
 				sizeof(device->volume_id));
@@ -3097,7 +3109,7 @@ static enum pqi_soft_reset_status pqi_poll_for_soft_reset_status(
 }
 
 static void pqi_process_soft_reset(struct pqi_ctrl_info *ctrl_info,
-		enum pqi_soft_reset_status reset_status)
+	enum pqi_soft_reset_status reset_status)
 {
 	int rc;
 
@@ -3141,8 +3153,8 @@ static void pqi_ofa_process_event(struct pqi_ctrl_info *ctrl_info,
 
 	if (event_id == PQI_EVENT_OFA_QUIESCE) {
 		dev_info(&ctrl_info->pci_dev->dev,
-			 "Received Online Firmware Activation quiesce event for controller %u\n",
-			 ctrl_info->ctrl_id);
+			"Received Online Firmware Activation quiesce event for controller %u\n",
+			ctrl_info->ctrl_id);
 		pqi_ofa_ctrl_quiesce(ctrl_info);
 		pqi_acknowledge_event(ctrl_info, event);
 		if (ctrl_info->soft_reset_handshake_supported) {
@@ -3162,8 +3174,8 @@ static void pqi_ofa_process_event(struct pqi_ctrl_info *ctrl_info,
 		pqi_ofa_free_host_buffer(ctrl_info);
 		pqi_acknowledge_event(ctrl_info, event);
 		dev_info(&ctrl_info->pci_dev->dev,
-			 "Online Firmware Activation(%u) cancel reason : %u\n",
-			 ctrl_info->ctrl_id, event->ofa_cancel_reason);
+			"Online Firmware Activation(%u) cancel reason : %u\n",
+			ctrl_info->ctrl_id, event->ofa_cancel_reason);
 	}
 
 	mutex_unlock(&ctrl_info->ofa_mutex);
@@ -3342,7 +3354,7 @@ static unsigned int pqi_process_event_intr(struct pqi_ctrl_info *ctrl_info)
 #define PQI_LEGACY_INTX_MASK	0x1
 
 static inline void pqi_configure_legacy_intx(struct pqi_ctrl_info *ctrl_info,
-						bool enable_intx)
+	bool enable_intx)
 {
 	u32 intx_mask;
 	struct pqi_device_registers __iomem *pqi_registers;
@@ -3987,8 +3999,8 @@ static void pqi_raid_synchronous_complete(struct pqi_io_request *io_request,
 	complete(waiting);
 }
 
-static int pqi_process_raid_io_error_synchronous(struct pqi_raid_error_info
-						*error_info)
+static int pqi_process_raid_io_error_synchronous(
+	struct pqi_raid_error_info *error_info)
 {
 	int rc = -EIO;
 
@@ -4607,11 +4619,11 @@ static void pqi_free_all_io_requests(struct pqi_ctrl_info *ctrl_info)
 
 static inline int pqi_alloc_error_buffer(struct pqi_ctrl_info *ctrl_info)
 {
-	ctrl_info->error_buffer = dma_alloc_coherent(&ctrl_info->pci_dev->dev,
-						     ctrl_info->error_buffer_length,
-						     &ctrl_info->error_buffer_dma_handle,
-						     GFP_KERNEL);
 
+	ctrl_info->error_buffer = dma_alloc_coherent(&ctrl_info->pci_dev->dev,
+				     ctrl_info->error_buffer_length,
+				     &ctrl_info->error_buffer_dma_handle,
+				     GFP_KERNEL);
 	if (!ctrl_info->error_buffer)
 		return -ENOMEM;
 
@@ -5361,7 +5373,7 @@ static int pqi_scsi_queue_command(struct Scsi_Host *shost,
 	if (pqi_is_logical_device(device)) {
 		raid_bypassed = false;
 		if (device->raid_bypass_enabled &&
-				!blk_rq_is_passthrough(scmd->request)) {
+			!blk_rq_is_passthrough(scmd->request)) {
 			rc = pqi_raid_bypass_submit_scsi_cmd(ctrl_info, device,
 				scmd, queue_group);
 			if (rc == 0 || rc == SCSI_MLQUEUE_HOST_BUSY)
@@ -6080,8 +6092,7 @@ static int pqi_ioctl(struct scsi_device *sdev, unsigned int cmd,
 
 	ctrl_info = shost_to_hba(sdev->host);
 
-	if (pqi_ctrl_in_ofa(ctrl_info) ||
-		pqi_ctrl_in_shutdown(ctrl_info))
+	if (pqi_ctrl_in_ofa(ctrl_info) || pqi_ctrl_in_shutdown(ctrl_info))
 		return -EBUSY;
 
 	switch (cmd) {
@@ -6128,8 +6139,8 @@ static ssize_t pqi_driver_version_show(struct device *dev,
 	shost = class_to_shost(dev);
 	ctrl_info = shost_to_hba(shost);
 
-	return snprintf(buffer, PAGE_SIZE,
-		"%s\n", DRIVER_VERSION BUILD_TIMESTAMP);
+	return snprintf(buffer, PAGE_SIZE, "%s\n",
+		DRIVER_VERSION BUILD_TIMESTAMP);
 }
 
 static ssize_t pqi_serial_number_show(struct device *dev,
@@ -6296,6 +6307,7 @@ static ssize_t pqi_lunid_show(struct device *dev,
 			flags);
 		return -ENODEV;
 	}
+
 	memcpy(lunid, device->scsi3addr, sizeof(lunid));
 
 	spin_unlock_irqrestore(&ctrl_info->scsi_device_list_lock, flags);
@@ -6303,7 +6315,8 @@ static ssize_t pqi_lunid_show(struct device *dev,
 	return snprintf(buffer, PAGE_SIZE, "0x%8phN\n", lunid);
 }
 
-#define MAX_PATHS 8
+#define MAX_PATHS	8
+
 static ssize_t pqi_path_info_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
@@ -6315,9 +6328,9 @@ static ssize_t pqi_path_info_show(struct device *dev,
 	int output_len = 0;
 	u8 box;
 	u8 bay;
-	u8 path_map_index = 0;
+	u8 path_map_index;
 	char *active;
-	unsigned char phys_connector[2];
+	u8 phys_connector[2];
 
 	sdev = to_scsi_device(dev);
 	ctrl_info = shost_to_hba(sdev->host);
@@ -6333,7 +6346,7 @@ static ssize_t pqi_path_info_show(struct device *dev,
 
 	bay = device->bay;
 	for (i = 0; i < MAX_PATHS; i++) {
-		path_map_index = 1<<i;
+		path_map_index = 1 << i;
 		if (i == device->active_path_index)
 			active = "Active";
 		else if (device->path_map & path_map_index)
@@ -6384,10 +6397,10 @@ static ssize_t pqi_path_info_show(struct device *dev,
 	}
 
 	spin_unlock_irqrestore(&ctrl_info->scsi_device_list_lock, flags);
+
 	return output_len;
 }
 
-
 static ssize_t pqi_sas_address_show(struct device *dev,
 	struct device_attribute *attr, char *buffer)
 {
@@ -6408,6 +6421,7 @@ static ssize_t pqi_sas_address_show(struct device *dev,
 			flags);
 		return -ENODEV;
 	}
+
 	sas_address = device->sas_address;
 
 	spin_unlock_irqrestore(&ctrl_info->scsi_device_list_lock, flags);
@@ -7387,7 +7401,7 @@ static int pqi_ctrl_init_resume(struct pqi_ctrl_info *ctrl_info)
 	rc = pqi_get_ctrl_product_details(ctrl_info);
 	if (rc) {
 		dev_err(&ctrl_info->pci_dev->dev,
-			"error obtaining product detail\n");
+			"error obtaining product details\n");
 		return rc;
 	}
 
@@ -7723,6 +7737,8 @@ static void pqi_ofa_setup_host_buffer(struct pqi_ctrl_info *ctrl_info,
 		dev_err(dev, "Failed to allocate host buffer of size = %u",
 			bytes_requested);
 	}
+
+	return;
 }
 
 static void pqi_ofa_free_host_buffer(struct pqi_ctrl_info *ctrl_info)
@@ -8023,7 +8039,6 @@ static void pqi_shutdown(struct pci_dev *pci_dev)
 
 	pqi_crash_if_pending_command(ctrl_info);
 	pqi_reset(ctrl_info);
-
 }
 
 static void pqi_process_lockup_action_param(void)
diff --git a/drivers/scsi/smartpqi/smartpqi_sas_transport.c b/drivers/scsi/smartpqi/smartpqi_sas_transport.c
index b7e28b9f8589..b7289112455c 100644
--- a/drivers/scsi/smartpqi/smartpqi_sas_transport.c
+++ b/drivers/scsi/smartpqi/smartpqi_sas_transport.c
@@ -312,7 +312,6 @@ static int pqi_sas_get_linkerrors(struct sas_phy *phy)
 static int pqi_sas_get_enclosure_identifier(struct sas_rphy *rphy,
 	u64 *identifier)
 {
-
 	int rc;
 	unsigned long flags;
 	struct Scsi_Host *shost;
@@ -361,7 +360,7 @@ static int pqi_sas_get_enclosure_identifier(struct sas_rphy *rphy,
 		}
 	}
 
-	if (found_device->phy_connected_dev_type != SA_CONTROLLER_DEVICE) {
+	if (found_device->phy_connected_dev_type != SA_DEVICE_TYPE_CONTROLLER) {
 		rc = -EINVAL;
 		goto out;
 	}
@@ -382,12 +381,10 @@ static int pqi_sas_get_enclosure_identifier(struct sas_rphy *rphy,
 	spin_unlock_irqrestore(&ctrl_info->scsi_device_list_lock, flags);
 
 	return rc;
-
 }
 
 static int pqi_sas_get_bay_identifier(struct sas_rphy *rphy)
 {
-
 	int rc;
 	unsigned long flags;
 	struct pqi_ctrl_info *ctrl_info;
@@ -482,7 +479,6 @@ pqi_build_csmi_smp_passthru_buffer(struct sas_rphy *rphy,
 		req_size -= SMP_CRC_FIELD_LENGTH;
 
 	put_unaligned_le32(req_size, &parameters->request_length);
-
 	put_unaligned_le32(resp_size, &parameters->response_length);
 
 	sg_copy_to_buffer(job->request_payload.sg_list,
@@ -512,12 +508,12 @@ void pqi_sas_smp_handler(struct bsg_job *job, struct Scsi_Host *shost,
 	struct sas_rphy *rphy)
 {
 	int rc;
-	struct pqi_ctrl_info *ctrl_info = shost_to_hba(shost);
+	struct pqi_ctrl_info *ctrl_info;
 	struct bmic_csmi_smp_passthru_buffer *smp_buf;
 	struct pqi_raid_error_info error_info;
 	unsigned int reslen = 0;
 
-	pqi_ctrl_busy(ctrl_info);
+	ctrl_info = shost_to_hba(shost);
 
 	if (job->reply_payload.payload_len == 0) {
 		rc = -ENOMEM;
@@ -539,16 +535,6 @@ void pqi_sas_smp_handler(struct bsg_job *job, struct Scsi_Host *shost,
 		goto out;
 	}
 
-	if (pqi_ctrl_offline(ctrl_info)) {
-		rc = -ENXIO;
-		goto out;
-	}
-
-	if (pqi_ctrl_blocked(ctrl_info)) {
-		rc = -EBUSY;
-		goto out;
-	}
-
 	smp_buf = pqi_build_csmi_smp_passthru_buffer(rphy, job);
 	if (!smp_buf) {
 		rc = -ENOMEM;

