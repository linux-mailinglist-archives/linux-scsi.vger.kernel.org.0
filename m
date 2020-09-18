Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB6F126F074
	for <lists+linux-scsi@lfdr.de>; Fri, 18 Sep 2020 04:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbgIRCn6 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 17 Sep 2020 22:43:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:35456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728479AbgIRCKk (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 17 Sep 2020 22:10:40 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0933321D92;
        Fri, 18 Sep 2020 02:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600395039;
        bh=EIG617GRYWpHFU1Bw2ur5B/76jOIn2f5DCaQ90ReApo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wsDewwU9ekFxppcGnkPMqUBWh3TTdmpuNtznh/98uCO6sD+3VTpLa+oxY1TJX9qa/
         LwAIv2iOvcWHMSHf/WhPZqSnrSA74u48C8R9zzGvGnK3lO/gc94M+H8boOuQGCkkQL
         R4bAKhUtROQT9i7MWZzkK79As5f6Znpo7l2hqXMw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Don Brace <don.brace@microsemi.com>,
        Scott Teel <scott.teel@microsemi.com>,
        Matt Perricone <matt.perricone@microsemi.com>,
        Scott Benesh <scott.benesh@microsemi.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, iss_storagedev@hp.com,
        storagedev@pmcs.com, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 129/206] scsi: hpsa: correct race condition in offload enabled
Date:   Thu, 17 Sep 2020 22:06:45 -0400
Message-Id: <20200918020802.2065198-129-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918020802.2065198-1-sashal@kernel.org>
References: <20200918020802.2065198-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Don Brace <don.brace@microsemi.com>

[ Upstream commit 3e16e83a62edac7617bfd8dbb4e55d04ff6adbe1 ]

Correct race condition where ioaccel is re-enabled before the raid_map is
updated. For RAID_1, RAID_1ADM, and RAID 5/6 there is a BUG_ON called which
is bad.

 - Change event thread to disable ioaccel only. Send all requests down the
   RAID path instead.

 - Have rescan thread handle offload_enable.

 - Since there is only one rescan allowed at a time, turning
   offload_enabled on/off should not be racy. Each handler queues up a
   rescan if one is already in progress.

  - For timing diagram, offload_enabled is initially off due to a change
    (transformation: splitmirror/remirror), ...

  otbe = offload_to_be_enabled
  oe   = offload_enabled

  Time Event         Rescan              Completion     Request
       Worker        Worker              Thread         Thread
  ---- ------        ------              ----------     -------
   T0   |             |                       + UA      |
   T1   |             + rescan started        | 0x3f    |
   T2   + Event       |                       | 0x0e    |
   T3   + Ack msg     |                       |         |
   T4   |             + if (!dev[i]->oe &&    |         |
   T5   |             |     dev[i]->otbe)     |         |
   T6   |             |      get_raid_map     |         |
   T7   + otbe = 1    |                       |         |
   T8   |             |                       |         |
   T9   |             + oe = otbe             |         |
   T10  |             |                       |         + ioaccel request
   T11                                                  * BUG_ON

  T0 - I/O completion with UA 0x3f 0x0e sets rescan flag.
  T1 - rescan worker thread starts a rescan.
  T2 - event comes in
  T3 - event thread starts and issues "Acknowledge" message
  ...
  T6 - rescan thread has bypassed code to reload new raid map.
  ...
  T7 - event thread runs and sets offload_to_be_enabled
  ...
  T9 - rescan thread turns on offload_enabled.
  T10- request comes in and goes down ioaccel path.
  T11- BUG_ON.

 - After the patch is applied, ioaccel_enabled can only be re-enabled in
   the re-scan thread.

Link: https://lore.kernel.org/r/158472877894.14200.7077843399036368335.stgit@brunhilda
Reviewed-by: Scott Teel <scott.teel@microsemi.com>
Reviewed-by: Matt Perricone <matt.perricone@microsemi.com>
Reviewed-by: Scott Benesh <scott.benesh@microsemi.com>
Signed-off-by: Don Brace <don.brace@microsemi.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/hpsa.c | 80 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 57 insertions(+), 23 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index f570b8c5d857c..11de2198bb87d 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -507,6 +507,12 @@ static ssize_t host_store_rescan(struct device *dev,
 	return count;
 }
 
+static void hpsa_turn_off_ioaccel_for_device(struct hpsa_scsi_dev_t *device)
+{
+	device->offload_enabled = 0;
+	device->offload_to_be_enabled = 0;
+}
+
 static ssize_t host_show_firmware_revision(struct device *dev,
 	     struct device_attribute *attr, char *buf)
 {
@@ -1743,8 +1749,7 @@ static void hpsa_figure_phys_disk_ptrs(struct ctlr_info *h,
 				__func__,
 				h->scsi_host->host_no, logical_drive->bus,
 				logical_drive->target, logical_drive->lun);
-			logical_drive->offload_enabled = 0;
-			logical_drive->offload_to_be_enabled = 0;
+			hpsa_turn_off_ioaccel_for_device(logical_drive);
 			logical_drive->queue_depth = 8;
 		}
 	}
@@ -2496,8 +2501,7 @@ static void process_ioaccel2_completion(struct ctlr_info *h,
 			IOACCEL2_SERV_RESPONSE_FAILURE) {
 		if (c2->error_data.status ==
 			IOACCEL2_STATUS_SR_IOACCEL_DISABLED) {
-			dev->offload_enabled = 0;
-			dev->offload_to_be_enabled = 0;
+			hpsa_turn_off_ioaccel_for_device(dev);
 		}
 
 		return hpsa_retry_cmd(h, c);
@@ -3676,10 +3680,17 @@ static void hpsa_get_ioaccel_status(struct ctlr_info *h,
 	this_device->offload_config =
 		!!(ioaccel_status & OFFLOAD_CONFIGURED_BIT);
 	if (this_device->offload_config) {
-		this_device->offload_to_be_enabled =
+		bool offload_enabled =
 			!!(ioaccel_status & OFFLOAD_ENABLED_BIT);
-		if (hpsa_get_raid_map(h, scsi3addr, this_device))
-			this_device->offload_to_be_enabled = 0;
+		/*
+		 * Check to see if offload can be enabled.
+		 */
+		if (offload_enabled) {
+			rc = hpsa_get_raid_map(h, scsi3addr, this_device);
+			if (rc) /* could not load raid_map */
+				goto out;
+			this_device->offload_to_be_enabled = 1;
+		}
 	}
 
 out:
@@ -3998,8 +4009,7 @@ static int hpsa_update_device_info(struct ctlr_info *h,
 	} else {
 		this_device->raid_level = RAID_UNKNOWN;
 		this_device->offload_config = 0;
-		this_device->offload_enabled = 0;
-		this_device->offload_to_be_enabled = 0;
+		hpsa_turn_off_ioaccel_for_device(this_device);
 		this_device->hba_ioaccel_enabled = 0;
 		this_device->volume_offline = 0;
 		this_device->queue_depth = h->nr_cmds;
@@ -5213,8 +5223,12 @@ static int hpsa_scsi_ioaccel_raid_map(struct ctlr_info *h,
 		/* Handles load balance across RAID 1 members.
 		 * (2-drive R1 and R10 with even # of drives.)
 		 * Appropriate for SSDs, not optimal for HDDs
+		 * Ensure we have the correct raid_map.
 		 */
-		BUG_ON(le16_to_cpu(map->layout_map_count) != 2);
+		if (le16_to_cpu(map->layout_map_count) != 2) {
+			hpsa_turn_off_ioaccel_for_device(dev);
+			return IO_ACCEL_INELIGIBLE;
+		}
 		if (dev->offload_to_mirror)
 			map_index += le16_to_cpu(map->data_disks_per_row);
 		dev->offload_to_mirror = !dev->offload_to_mirror;
@@ -5222,8 +5236,12 @@ static int hpsa_scsi_ioaccel_raid_map(struct ctlr_info *h,
 	case HPSA_RAID_ADM:
 		/* Handles N-way mirrors  (R1-ADM)
 		 * and R10 with # of drives divisible by 3.)
+		 * Ensure we have the correct raid_map.
 		 */
-		BUG_ON(le16_to_cpu(map->layout_map_count) != 3);
+		if (le16_to_cpu(map->layout_map_count) != 3) {
+			hpsa_turn_off_ioaccel_for_device(dev);
+			return IO_ACCEL_INELIGIBLE;
+		}
 
 		offload_to_mirror = dev->offload_to_mirror;
 		raid_map_helper(map, offload_to_mirror,
@@ -5248,7 +5266,10 @@ static int hpsa_scsi_ioaccel_raid_map(struct ctlr_info *h,
 		r5or6_blocks_per_row =
 			le16_to_cpu(map->strip_size) *
 			le16_to_cpu(map->data_disks_per_row);
-		BUG_ON(r5or6_blocks_per_row == 0);
+		if (r5or6_blocks_per_row == 0) {
+			hpsa_turn_off_ioaccel_for_device(dev);
+			return IO_ACCEL_INELIGIBLE;
+		}
 		stripesize = r5or6_blocks_per_row *
 			le16_to_cpu(map->layout_map_count);
 #if BITS_PER_LONG == 32
@@ -8218,7 +8239,7 @@ static int detect_controller_lockup(struct ctlr_info *h)
  *
  * Called from monitor controller worker (hpsa_event_monitor_worker)
  *
- * A Volume (or Volumes that comprise an Array set may be undergoing a
+ * A Volume (or Volumes that comprise an Array set) may be undergoing a
  * transformation, so we will be turning off ioaccel for all volumes that
  * make up the Array.
  */
@@ -8241,6 +8262,9 @@ static void hpsa_set_ioaccel_status(struct ctlr_info *h)
 	 * Run through current device list used during I/O requests.
 	 */
 	for (i = 0; i < h->ndevices; i++) {
+		int offload_to_be_enabled = 0;
+		int offload_config = 0;
+
 		device = h->dev[i];
 
 		if (!device)
@@ -8258,25 +8282,35 @@ static void hpsa_set_ioaccel_status(struct ctlr_info *h)
 			continue;
 
 		ioaccel_status = buf[IOACCEL_STATUS_BYTE];
-		device->offload_config =
+
+		/*
+		 * Check if offload is still configured on
+		 */
+		offload_config =
 				!!(ioaccel_status & OFFLOAD_CONFIGURED_BIT);
-		if (device->offload_config)
-			device->offload_to_be_enabled =
+		/*
+		 * If offload is configured on, check to see if ioaccel
+		 * needs to be enabled.
+		 */
+		if (offload_config)
+			offload_to_be_enabled =
 				!!(ioaccel_status & OFFLOAD_ENABLED_BIT);
 
+		/*
+		 * If ioaccel is to be re-enabled, re-enable later during the
+		 * scan operation so the driver can get a fresh raidmap
+		 * before turning ioaccel back on.
+		 */
+		if (offload_to_be_enabled)
+			continue;
+
 		/*
 		 * Immediately turn off ioaccel for any volume the
 		 * controller tells us to. Some of the reasons could be:
 		 *    transformation - change to the LVs of an Array.
 		 *    degraded volume - component failure
-		 *
-		 * If ioaccel is to be re-enabled, re-enable later during the
-		 * scan operation so the driver can get a fresh raidmap
-		 * before turning ioaccel back on.
-		 *
 		 */
-		if (!device->offload_to_be_enabled)
-			device->offload_enabled = 0;
+		hpsa_turn_off_ioaccel_for_device(device);
 	}
 
 	kfree(buf);
-- 
2.25.1

