Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA1DA337EE0
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Mar 2021 21:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhCKUQ4 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 11 Mar 2021 15:16:56 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:58856 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbhCKUQb (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 11 Mar 2021 15:16:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1615493792; x=1647029792;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iN2JLxiSJ9QwbHQEEzn0S9i7yDb1W5fZAT3W4+ERgFo=;
  b=iwdclfQpSrXXU1Yy3WPpNi0DtQ3LEv/JGifkEBCRWQC/6W/+xYjMiIYq
   4tkutyDMFx5fcTSnDtpA5t7pknWpmkpzEUdU2uCTjHDrVv8vF0z6NUl7O
   jhu4+B+ft88BIQJ5wsEhknzHz+MeDy2oLVI8GSx1ZzPiXyhJB2KoeS8lX
   DgbXwJmAET9RQcRJ04vDRe26cGLGdU6jkTRCugortnZxIXn1sER09+zeB
   m0D9vAKSj1LyuX2BMEsnsrs3X+xTDMNDiwBXzT2tgLdru+vfrkuSUmc6k
   46ZqIxF5rlLAz0jAFsv9IN5vWvDDHDLRX6yCwjtkSe3M2Xt2gdw1PcSa2
   Q==;
IronPort-SDR: +zOv9Db5NAvZJVXO56hXroQHer65OPTLkbrDjPb12KFuSp+KD9OaULhTE87h7fp3QDYzlUcZWb
 3y5LU8BfMAL0lBXhGbfIqawu6So8LjtmAOuZegs+VvyRzX8q5lmTGui+Z/8L2amz5o/kbCYiHO
 pyKCpQajKyFFrl0OGTZeB7LOEY6bQ9j1Wgh/QuUJKegkvecR6A/2LS+XlAPX+oBIylUQ8cjGC+
 YSgmPq6Sgonw04lKBql4KWUUvX8zfSn1RqoCFnSMPdw3bVbkFU+4B7DjNgPx+N+UngbuS/fO9h
 +I0=
X-IronPort-AV: E=Sophos;i="5.81,241,1610434800"; 
   d="scan'208";a="109660110"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Mar 2021 13:16:30 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 11 Mar 2021 13:16:21 -0700
Received: from [127.0.1.1] (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Thu, 11 Mar 2021 13:16:20 -0700
Subject: [PATCH V5 15/31] smartpqi: add support for wwid
From:   Don Brace <don.brace@microchip.com>
To:     <Kevin.Barnett@microchip.com>, <scott.teel@microchip.com>,
        <Justin.Lindley@microchip.com>, <scott.benesh@microchip.com>,
        <gerry.morong@microchip.com>, <mahesh.rajashekhara@microchip.com>,
        <mike.mcgowen@microchip.com>, <murthy.bhat@microchip.com>,
        <hch@infradead.org>, <jejb@linux.vnet.ibm.com>,
        <joseph.szczypek@hpe.com>, <POSWALD@suse.com>
CC:     <linux-scsi@vger.kernel.org>
Date:   Thu, 11 Mar 2021 14:16:20 -0600
Message-ID: <161549378041.25025.3869709982357729841.stgit@brunhilda>
In-Reply-To: <161549045434.25025.17473629602756431540.stgit@brunhilda>
References: <161549045434.25025.17473629602756431540.stgit@brunhilda>
User-Agent: StGit/0.23-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Kevin Barnett <kevin.barnett@microchip.com>

Wwid has been added to Report Physical LUNs in
newer controller firmware. The presence of this field
is detected by a feature bit. Add in detection of this
new feature and store the wwid when set.

Reviewed-by: Scott Benesh <scott.benesh@microchip.com>
Reviewed-by: Mike McGowen <mike.mcgowen@microchip.com>
Reviewed-by: Scott Teel <scott.teel@microchip.com>
Signed-off-by: Kevin Barnett <kevin.barnett@microchip.com>
Signed-off-by: Don Brace <don.brace@microchip.com>
---
 drivers/scsi/smartpqi/smartpqi.h      |    5 ++++-
 drivers/scsi/smartpqi/smartpqi_init.c |   24 +++++++++++++++++++++++-
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/smartpqi/smartpqi.h b/drivers/scsi/smartpqi/smartpqi.h
index 8e5e2543c7cf..a579d772dce0 100644
--- a/drivers/scsi/smartpqi/smartpqi.h
+++ b/drivers/scsi/smartpqi/smartpqi.h
@@ -853,7 +853,8 @@ struct pqi_config_table_firmware_features {
 #define PQI_FIRMWARE_FEATURE_RAID_IU_TIMEOUT			13
 #define PQI_FIRMWARE_FEATURE_TMF_IU_TIMEOUT			14
 #define PQI_FIRMWARE_FEATURE_RAID_BYPASS_ON_ENCRYPTED_NVME	15
-#define PQI_FIRMWARE_FEATURE_MAXIMUM				15
+#define PQI_FIRMWARE_FEATURE_UNIQUE_WWID_IN_REPORT_PHYS_LUN	16
+#define PQI_FIRMWARE_FEATURE_MAXIMUM				16
 
 struct pqi_config_table_debug {
 	struct pqi_config_table_section_header header;
@@ -1110,6 +1111,7 @@ struct pqi_scsi_dev {
 	struct pqi_stream_data stream_data[NUM_STREAMS_PER_LUN];
 	atomic_t scsi_cmds_outstanding;
 	atomic_t raid_bypass_cnt;
+	u8	page_83_identifier[16];
 };
 
 /* VPD inquiry pages */
@@ -1303,6 +1305,7 @@ struct pqi_ctrl_info {
 	u8		soft_reset_handshake_supported : 1;
 	u8		raid_iu_timeout_supported : 1;
 	u8		tmf_iu_timeout_supported : 1;
+	u8		unique_wwid_in_report_phys_lun_supported : 1;
 	u8		enable_r1_writes : 1;
 	u8		enable_r5_writes : 1;
 	u8		enable_r6_writes : 1;
diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index d442aabf8fe8..a226b7e32e3d 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -1441,6 +1441,9 @@ static int pqi_get_physical_device_info(struct pqi_ctrl_info *ctrl_info,
 		sizeof(device->phys_connector));
 	device->bay = id_phys->phys_bay_in_box;
 
+	memcpy(&device->page_83_identifier, &id_phys->page_83_identifier,
+		sizeof(device->page_83_identifier));
+
 	return 0;
 }
 
@@ -2045,6 +2048,16 @@ static inline bool pqi_expose_device(struct pqi_scsi_dev *device)
 	return !device->is_physical_device || !pqi_skip_device(device->scsi3addr);
 }
 
+static inline void pqi_set_physical_device_wwid(struct pqi_ctrl_info *ctrl_info,
+	struct pqi_scsi_dev *device, struct report_phys_lun_extended_entry *phys_lun_ext_entry)
+{
+	if (ctrl_info->unique_wwid_in_report_phys_lun_supported ||
+		pqi_is_device_with_sas_address(device))
+		device->wwid = phys_lun_ext_entry->wwid;
+	else
+		device->wwid = cpu_to_be64(get_unaligned_be64(&device->page_83_identifier));
+}
+
 static int pqi_update_scsi_devices(struct pqi_ctrl_info *ctrl_info)
 {
 	int i;
@@ -2210,7 +2223,7 @@ static int pqi_update_scsi_devices(struct pqi_ctrl_info *ctrl_info)
 		pqi_assign_bus_target_lun(device);
 
 		if (device->is_physical_device) {
-			device->wwid = phys_lun_ext_entry->wwid;
+			pqi_set_physical_device_wwid(ctrl_info, device, phys_lun_ext_entry);
 			if ((phys_lun_ext_entry->device_flags &
 				CISS_REPORT_PHYS_DEV_FLAG_AIO_ENABLED) &&
 				phys_lun_ext_entry->aio_handle) {
@@ -7407,6 +7420,10 @@ static void pqi_ctrl_update_feature_flags(struct pqi_ctrl_info *ctrl_info,
 	case PQI_FIRMWARE_FEATURE_TMF_IU_TIMEOUT:
 		ctrl_info->tmf_iu_timeout_supported = firmware_feature->enabled;
 		break;
+	case PQI_FIRMWARE_FEATURE_UNIQUE_WWID_IN_REPORT_PHYS_LUN:
+		ctrl_info->unique_wwid_in_report_phys_lun_supported =
+			firmware_feature->enabled;
+		break;
 	}
 
 	pqi_firmware_feature_status(ctrl_info, firmware_feature);
@@ -7497,6 +7514,11 @@ static struct pqi_firmware_feature pqi_firmware_features[] = {
 		.feature_bit = PQI_FIRMWARE_FEATURE_RAID_BYPASS_ON_ENCRYPTED_NVME,
 		.feature_status = pqi_firmware_feature_status,
 	},
+	{
+		.feature_name = "Unique WWID in Report Physical LUN",
+		.feature_bit = PQI_FIRMWARE_FEATURE_UNIQUE_WWID_IN_REPORT_PHYS_LUN,
+		.feature_status = pqi_ctrl_update_feature_flags,
+	},
 };
 
 static void pqi_process_firmware_features(

