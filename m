Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC3172271EB
	for <lists+linux-scsi@lfdr.de>; Mon, 20 Jul 2020 23:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgGTVwx (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 20 Jul 2020 17:52:53 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:52323 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbgGTVwx (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 20 Jul 2020 17:52:53 -0400
IronPort-SDR: 70AXjcBYHQBA3ZMOneKpD5xjkpa2fOyS9iSTsvNvXZwv5b2h25IkkmSwVf/rLdOzFLYtRm4SL/
 m3wZgLO8wACHXbmSFNIVFxbzRQ6ZHA3tbFRC16hEeLyDwFmApJaHM3F9owvhSdm3YQ9l3RIt5+
 oPK2S45Z6XWNJTA+RvF+EHfCLlU1xV77ojo8y7/IZvYr/toe0/Jufl+MhJWvJv/9O5e/ViiJYx
 +ixUlX/PuPyee70L/4QxVeUkD88Cp2pnlM2MaqmfN31WWk0v06+uQnGimi34I0228ZoQGoureK
 rtQ=
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; 
   d="scan'208";a="88394290"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jul 2020 14:52:52 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 20 Jul 2020 14:52:52 -0700
Received: from [127.0.1.1] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Mon, 20 Jul 2020 14:52:12 -0700
Subject: [PATCH 1/4] hpsa: correct rare oob condition
From:   Don Brace <don.brace@microsemi.com>
To:     <Kevin.Barnett@microchip.com>, <scott.teel@microchip.com>,
        <Justin.Lindley@microchip.com>, <scott.benesh@microchip.com>,
        <bader.alisaleh@microchip.com>, <gerry.morong@microchip.com>,
        <mahesh.rajashekhara@microchip.com>, <hch@infradead.org>,
        <jejb@linux.vnet.ibm.com>, <joseph.szczypek@hpe.com>,
        <POSWALD@suse.com>
CC:     <linux-scsi@vger.kernel.org>
Date:   Mon, 20 Jul 2020 16:52:51 -0500
Message-ID: <159528197176.24772.14659026352708896249.stgit@brunhilda>
In-Reply-To: <159528193513.24772.2142294136346611232.stgit@brunhilda>
References: <159528193513.24772.2142294136346611232.stgit@brunhilda>
User-Agent: StGit/0.23-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

There are some rare conditions where a spare
is first in the device list causing an array
out-of-bounds condition.

Reviewed-by: Scott Teel <scott.teel@microsemi.com>
Reviewed-by: Scott Benesh <scott.benesh@microsemi.com>
Reviewed-by: Kevin Barnett <kevin.barnett@microsemi.com>
Signed-off-by: Don Brace <don.brace@microsemi.com>
---
 drivers/scsi/hpsa.c |   20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index 81d0414e2117..9b1edc541ed0 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -3443,9 +3443,14 @@ static void hpsa_get_enclosure_info(struct ctlr_info *h,
 	struct ErrorInfo *ei = NULL;
 	struct bmic_sense_storage_box_params *bssbp = NULL;
 	struct bmic_identify_physical_device *id_phys = NULL;
-	struct ext_report_lun_entry *rle = &rlep->LUN[rle_index];
+	struct ext_report_lun_entry *rle;
 	u16 bmic_device_index = 0;
 
+	if (rle_index < 0 || rle_index >= HPSA_MAX_PHYS_LUN)
+		return;
+
+	rle = &rlep->LUN[rle_index];
+
 	encl_dev->eli =
 		hpsa_get_enclosure_logical_identifier(h, scsi3addr);
 
@@ -4174,6 +4179,9 @@ static void hpsa_get_ioaccel_drive_info(struct ctlr_info *h,
 	int rc;
 	struct ext_report_lun_entry *rle;
 
+	if (rle_index < 0 || rle_index >= HPSA_MAX_PHYS_LUN)
+		return;
+
 	rle = &rlep->LUN[rle_index];
 
 	dev->ioaccel_handle = rle->ioaccel_handle;
@@ -4198,7 +4206,12 @@ static void hpsa_get_path_info(struct hpsa_scsi_dev_t *this_device,
 	struct ReportExtendedLUNdata *rlep, int rle_index,
 	struct bmic_identify_physical_device *id_phys)
 {
-	struct ext_report_lun_entry *rle = &rlep->LUN[rle_index];
+	struct ext_report_lun_entry *rle;
+
+	if (rle_index < 0 || rle_index >= HPSA_MAX_PHYS_LUN)
+		return;
+
+	rle = &rlep->LUN[rle_index];
 
 	if ((rle->device_flags & 0x08) && this_device->ioaccel_handle)
 		this_device->hba_ioaccel_enabled = 1;
@@ -4420,7 +4433,8 @@ static void hpsa_update_scsi_devices(struct ctlr_info *h)
 		/*
 		 * Skip over some devices such as a spare.
 		 */
-		if (!tmpdevice->external && physical_device) {
+		if (phys_dev_index >= 0 && !tmpdevice->external &&
+			physical_device) {
 			skip_device = hpsa_skip_device(h, lunaddrbytes,
 					&physdev_list->LUN[phys_dev_index]);
 			if (skip_device)

