Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD9D6517C4
	for <lists+linux-scsi@lfdr.de>; Tue, 20 Dec 2022 02:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbiLTBWM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 19 Dec 2022 20:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbiLTBVr (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 19 Dec 2022 20:21:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F7D11469;
        Mon, 19 Dec 2022 17:21:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E38ABB80FA6;
        Tue, 20 Dec 2022 01:21:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5036BC43392;
        Tue, 20 Dec 2022 01:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671499274;
        bh=Y/Vay+/JbI8G6+W5iGyTt9B8uqjSBD3oCJgRX1GagCw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PICMxruB/5OjLMM2lYkvA7Zegwd/af65uAogcUIxihiy8DrILm9v3Pb2NMX5DpQ6n
         wtTrcTTsumyUYNLgrEObKlxCQV6sTDOvOzscSWNVtK1PuJ4rJ4IAjqWu7uvRCLnxVO
         7S+X7SYzSkNPOs/0l1xbwc25CcO+BIxeGE95dXcBF7WIc+YZXJuNYLKmIVJAFDgvDF
         zZLZeOU9xpHHHmjCFgElJXyjVlI2GMvNA+Tk0q/sWcYhSNoIvwwiKA2a6q5uvg+mrI
         8O2GwbVi3m1huMDdvUCpaS/esyEx547lFy7bGdjnsRpOTrGRyndHZmpyvUDxrm6hAT
         tUJO+SuqLIVLQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kumar Meiyappan <Kumar.Meiyappan@microchip.com>,
        Scott Benesh <scott.benesh@microchip.com>,
        Scott Teel <scott.teel@microchip.com>,
        Mike Mcgowan <mike.mcgowan@microchip.com>,
        Kevin Barnett <kevin.barnett@microchip.com>,
        Don Brace <don.brace@microchip.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, jejb@linux.ibm.com,
        storagedev@microchip.com, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 09/16] scsi: smartpqi: Correct device removal for multi-actuator devices
Date:   Mon, 19 Dec 2022 20:20:46 -0500
Message-Id: <20221220012053.1222101-9-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221220012053.1222101-1-sashal@kernel.org>
References: <20221220012053.1222101-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Kumar Meiyappan <Kumar.Meiyappan@microchip.com>

[ Upstream commit cc9befcbbb5ebce77726f938508700d913530035 ]

Correct device count for multi-actuator drives which can cause kernel
panics.

Reviewed-by: Scott Benesh <scott.benesh@microchip.com>
Reviewed-by: Scott Teel <scott.teel@microchip.com>
Reviewed-by: Mike Mcgowan <mike.mcgowan@microchip.com>
Reviewed-by: Kevin Barnett <kevin.barnett@microchip.com>
Signed-off-by: Kumar Meiyappan <Kumar.Meiyappan@microchip.com>
Signed-off-by: Don Brace <don.brace@microchip.com>
Link: https://lore.kernel.org/r/166793531872.322537.9003385780343419275.stgit@brunhilda
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/smartpqi/smartpqi.h      |  2 +-
 drivers/scsi/smartpqi/smartpqi_init.c | 33 +++++++++++++++++++--------
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/smartpqi/smartpqi.h b/drivers/scsi/smartpqi/smartpqi.h
index e550b12e525a..c8235f15728b 100644
--- a/drivers/scsi/smartpqi/smartpqi.h
+++ b/drivers/scsi/smartpqi/smartpqi.h
@@ -1130,7 +1130,7 @@ struct pqi_scsi_dev {
 	u8	phy_id;
 	u8	ncq_prio_enable;
 	u8	ncq_prio_support;
-	u8	multi_lun_device_lun_count;
+	u8	lun_count;
 	bool	raid_bypass_configured;	/* RAID bypass configured */
 	bool	raid_bypass_enabled;	/* RAID bypass enabled */
 	u32	next_bypass_group[RAID_MAP_MAX_DATA_DISKS_PER_ROW];
diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index 78fc743f46e4..9f0f69c1ed66 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -1610,9 +1610,7 @@ static int pqi_get_physical_device_info(struct pqi_ctrl_info *ctrl_info,
 		&id_phys->alternate_paths_phys_connector,
 		sizeof(device->phys_connector));
 	device->bay = id_phys->phys_bay_in_box;
-	device->multi_lun_device_lun_count = id_phys->multi_lun_device_lun_count;
-	if (!device->multi_lun_device_lun_count)
-		device->multi_lun_device_lun_count = 1;
+	device->lun_count = id_phys->multi_lun_device_lun_count;
 	if ((id_phys->even_more_flags & PQI_DEVICE_PHY_MAP_SUPPORTED) &&
 		id_phys->phy_count)
 		device->phy_id =
@@ -1746,7 +1744,7 @@ static bool pqi_keep_device_offline(struct pqi_ctrl_info *ctrl_info,
 	return offline;
 }
 
-static int pqi_get_device_info(struct pqi_ctrl_info *ctrl_info,
+static int pqi_get_device_info_phys_logical(struct pqi_ctrl_info *ctrl_info,
 	struct pqi_scsi_dev *device,
 	struct bmic_identify_physical_device *id_phys)
 {
@@ -1763,6 +1761,20 @@ static int pqi_get_device_info(struct pqi_ctrl_info *ctrl_info,
 	return rc;
 }
 
+static int pqi_get_device_info(struct pqi_ctrl_info *ctrl_info,
+	struct pqi_scsi_dev *device,
+	struct bmic_identify_physical_device *id_phys)
+{
+	int rc;
+
+	rc = pqi_get_device_info_phys_logical(ctrl_info, device, id_phys);
+
+	if (rc == 0 && device->lun_count == 0)
+		device->lun_count = 1;
+
+	return rc;
+}
+
 static void pqi_show_volume_status(struct pqi_ctrl_info *ctrl_info,
 	struct pqi_scsi_dev *device)
 {
@@ -1897,7 +1909,7 @@ static inline void pqi_remove_device(struct pqi_ctrl_info *ctrl_info, struct pqi
 	int rc;
 	int lun;
 
-	for (lun = 0; lun < device->multi_lun_device_lun_count; lun++) {
+	for (lun = 0; lun < device->lun_count; lun++) {
 		rc = pqi_device_wait_for_pending_io(ctrl_info, device, lun,
 			PQI_REMOVE_DEVICE_PENDING_IO_TIMEOUT_MSECS);
 		if (rc)
@@ -2076,6 +2088,7 @@ static void pqi_scsi_update_device(struct pqi_ctrl_info *ctrl_info,
 	existing_device->sas_address = new_device->sas_address;
 	existing_device->queue_depth = new_device->queue_depth;
 	existing_device->device_offline = false;
+	existing_device->lun_count = new_device->lun_count;
 
 	if (pqi_is_logical_device(existing_device)) {
 		existing_device->is_external_raid_device = new_device->is_external_raid_device;
@@ -2108,10 +2121,6 @@ static void pqi_scsi_update_device(struct pqi_ctrl_info *ctrl_info,
 		existing_device->phy_connected_dev_type = new_device->phy_connected_dev_type;
 		memcpy(existing_device->box, new_device->box, sizeof(existing_device->box));
 		memcpy(existing_device->phys_connector, new_device->phys_connector, sizeof(existing_device->phys_connector));
-
-		existing_device->multi_lun_device_lun_count = new_device->multi_lun_device_lun_count;
-		if (existing_device->multi_lun_device_lun_count == 0)
-			existing_device->multi_lun_device_lun_count = 1;
 	}
 }
 
@@ -6484,6 +6493,12 @@ static void pqi_slave_destroy(struct scsi_device *sdev)
 		return;
 	}
 
+	device->lun_count--;
+	if (device->lun_count > 0) {
+		mutex_unlock(&ctrl_info->scan_mutex);
+		return;
+	}
+
 	spin_lock_irqsave(&ctrl_info->scsi_device_list_lock, flags);
 	list_del(&device->scsi_device_list_entry);
 	spin_unlock_irqrestore(&ctrl_info->scsi_device_list_lock, flags);
-- 
2.35.1

