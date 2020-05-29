Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8161E7F2A
	for <lists+linux-scsi@lfdr.de>; Fri, 29 May 2020 15:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgE2Nrm (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 29 May 2020 09:47:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:35760 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbgE2Nrk (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 29 May 2020 09:47:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 33A5EAF27;
        Fri, 29 May 2020 13:47:37 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Doug Gilbert <dgilbert@interlog.com>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 5/5] scsi_error: use xarray lookup instead of wrappers
Date:   Fri, 29 May 2020 15:47:30 +0200
Message-Id: <20200529134730.146573-6-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200529134730.146573-1-hare@suse.de>
References: <20200529134730.146573-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

For SCSI EH most shost_for_each_sdev() calls are just to filter
out devices for specific targets or channels.
These calls can be made more efficient using direct xarray
lookup and iterators.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/scsi.c       |  2 +-
 drivers/scsi/scsi_error.c | 35 ++++++++++++++++++++++-------------
 drivers/scsi/scsi_priv.h  |  2 ++
 3 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 6a1d8c6bd8f9..296cecd61d3a 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -652,7 +652,7 @@ EXPORT_SYMBOL(__scsi_iterate_devices_unlocked);
  * @id:		ID of the target
  *
  */
-static struct scsi_target *__scsi_target_lookup(struct Scsi_Host *shost,
+struct scsi_target *__scsi_target_lookup(struct Scsi_Host *shost,
 					 u16 channel, u16 id)
 {
 	return xa_load(&shost->__targets, (channel << 16) | id);
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 978be1602f71..f13789e86601 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -643,7 +643,9 @@ EXPORT_SYMBOL_GPL(scsi_check_sense);
 static void scsi_handle_queue_ramp_up(struct scsi_device *sdev)
 {
 	struct scsi_host_template *sht = sdev->host->hostt;
+	struct scsi_target *starget;
 	struct scsi_device *tmp_sdev;
+	unsigned long lun_idx = 0;
 
 	if (!sht->track_queue_depth ||
 	    sdev->queue_depth >= sdev->max_queue_depth)
@@ -661,10 +663,9 @@ static void scsi_handle_queue_ramp_up(struct scsi_device *sdev)
 	 * Walk all devices of a target and do
 	 * ramp up on them.
 	 */
-	shost_for_each_device(tmp_sdev, sdev->host) {
-		if (tmp_sdev->channel != sdev->channel ||
-		    tmp_sdev->id != sdev->id ||
-		    tmp_sdev->queue_depth == sdev->max_queue_depth)
+	starget = __scsi_target_lookup(sdev->host, sdev->channel, sdev->id);
+	xa_for_each(&starget->__devices, lun_idx, tmp_sdev) {
+		if (tmp_sdev->queue_depth == sdev->max_queue_depth)
 			continue;
 
 		scsi_change_queue_depth(tmp_sdev, tmp_sdev->queue_depth + 1);
@@ -675,14 +676,15 @@ static void scsi_handle_queue_ramp_up(struct scsi_device *sdev)
 static void scsi_handle_queue_full(struct scsi_device *sdev)
 {
 	struct scsi_host_template *sht = sdev->host->hostt;
+	struct scsi_target *starget;
 	struct scsi_device *tmp_sdev;
+	unsigned long lun_idx = 0;
 
 	if (!sht->track_queue_depth)
 		return;
 
-	shost_for_each_device(tmp_sdev, sdev->host) {
-		if (tmp_sdev->channel != sdev->channel ||
-		    tmp_sdev->id != sdev->id)
+	xa_for_each(&starget->__devices, lun_idx, tmp_sdev) {
+		if (tmp_sdev->sdev_state == SDEV_DEL)
 			continue;
 		/*
 		 * We do not know the number of commands that were at
@@ -2271,10 +2273,16 @@ int scsi_error_handler(void *data)
  */
 void scsi_report_bus_reset(struct Scsi_Host *shost, int channel)
 {
+	struct scsi_target *starget;
 	struct scsi_device *sdev;
+	unsigned long tid = 0;
 
-	__shost_for_each_device(sdev, shost) {
-		if (channel == sdev_channel(sdev))
+	xa_for_each(&shost->__targets, tid, starget) {
+		unsigned long lun_idx = 0;
+
+		if (starget->channel != channel)
+			continue;
+		xa_for_each(&starget->__devices, lun_idx, sdev)
 			__scsi_report_device_reset(sdev, NULL);
 	}
 }
@@ -2304,13 +2312,14 @@ EXPORT_SYMBOL(scsi_report_bus_reset);
  */
 void scsi_report_device_reset(struct Scsi_Host *shost, int channel, int target)
 {
+	struct scsi_target *starget;
 	struct scsi_device *sdev;
+	unsigned long lun_idx = 0;
 
-	__shost_for_each_device(sdev, shost) {
-		if (channel == sdev_channel(sdev) &&
-		    target == sdev_id(sdev))
+	starget = __scsi_target_lookup(shost, channel, target);
+	if (starget)
+		xa_for_each(&starget->__devices, lun_idx, sdev)
 			__scsi_report_device_reset(sdev, NULL);
-	}
 }
 EXPORT_SYMBOL(scsi_report_device_reset);
 
diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
index 22b6585e28b4..0a87c95359aa 100644
--- a/drivers/scsi/scsi_priv.h
+++ b/drivers/scsi/scsi_priv.h
@@ -49,6 +49,8 @@ enum scsi_devinfo_key {
 	SCSI_DEVINFO_SPI,
 };
 
+extern struct scsi_target *__scsi_target_lookup(struct Scsi_Host *shost,
+						u16 channel, u16 id);
 extern blist_flags_t scsi_get_device_flags(struct scsi_device *sdev,
 					   const unsigned char *vendor,
 					   const unsigned char *model);
-- 
2.16.4

