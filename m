Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5EEF3C90F4
	for <lists+linux-scsi@lfdr.de>; Wed, 14 Jul 2021 22:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240487AbhGNT5V (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 14 Jul 2021 15:57:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:45690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240882AbhGNTuL (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 14 Jul 2021 15:50:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 75F6F61441;
        Wed, 14 Jul 2021 19:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626291976;
        bh=SIGAi7LUvIswe2NP7JhmVuzcx5KrTadMPoIMpafihMg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZgmWdR3BXD38OkVinFBxsxS4wU0RjbiW7QixqL4W2eCx9v239tCGBpYrWjWFMjh2T
         SeyxkaCsJ7SR8sF2U/tMQo9Bj5K1vOHfMVQScxCAGqQVQHUZShziER4Gp6R8rrM1E2
         daQhg2XB1hlyviqIuHpQJU2nXSZBORPzQ9KW6ZraSIv6yvEVGsEbC9Ak5akW0rGT4i
         G+GRIAecgsjXZNBfor7nL8PPaT7MziCEQsH3ZIzodMfVelF5iWxwhP41NHiQ5fzMQG
         JwwvSGssEt7dcWneC/44zhQLu+estqTlZWhRBULZ7GusA6Un6DS/Xb3u4h9O1R9W4d
         yPLcQSpNz4Qow==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yufen Yu <yuyufen@huawei.com>, Wu Bo <wubo40@huawei.com>,
        John Garry <john.garry@huawei.com>,
        Jason Yan <yanaijie@huawei.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 45/51] scsi: libsas: Add LUN number check in .slave_alloc callback
Date:   Wed, 14 Jul 2021 15:45:07 -0400
Message-Id: <20210714194513.54827-45-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210714194513.54827-1-sashal@kernel.org>
References: <20210714194513.54827-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Yufen Yu <yuyufen@huawei.com>

[ Upstream commit 49da96d77938db21864dae6b7736b71e96c1d203 ]

Offlining a SATA device connected to a hisi SAS controller and then
scanning the host will result in detecting 255 non-existent devices:

  # lsscsi
  [2:0:0:0]    disk    ATA      Samsung SSD 860  2B6Q  /dev/sda
  [2:0:1:0]    disk    ATA      WDC WD2003FYYS-3 1D01  /dev/sdb
  [2:0:2:0]    disk    SEAGATE  ST600MM0006      B001  /dev/sdc
  # echo "offline" > /sys/block/sdb/device/state
  # echo "- - -" > /sys/class/scsi_host/host2/scan
  # lsscsi
  [2:0:0:0]    disk    ATA      Samsung SSD 860  2B6Q  /dev/sda
  [2:0:1:0]    disk    ATA      WDC WD2003FYYS-3 1D01  /dev/sdb
  [2:0:1:1]    disk    ATA      WDC WD2003FYYS-3 1D01  /dev/sdh
  ...
  [2:0:1:255]  disk    ATA      WDC WD2003FYYS-3 1D01  /dev/sdjb

After a REPORT LUN command issued to the offline device fails, the SCSI
midlayer tries to do a sequential scan of all devices whose LUN number is
not 0. However, SATA does not support LUN numbers at all.

Introduce a generic sas_slave_alloc() handler which will return -ENXIO for
SATA devices if the requested LUN number is larger than 0 and make libsas
drivers use this function as their .slave_alloc callback.

Link: https://lore.kernel.org/r/20210622034037.1467088-1-yuyufen@huawei.com
Reported-by: Wu Bo <wubo40@huawei.com>
Suggested-by: John Garry <john.garry@huawei.com>
Reviewed-by: John Garry <john.garry@huawei.com>
Reviewed-by: Jason Yan <yanaijie@huawei.com>
Signed-off-by: Yufen Yu <yuyufen@huawei.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/aic94xx/aic94xx_init.c    | 1 +
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c | 1 +
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 1 +
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 1 +
 drivers/scsi/isci/init.c               | 1 +
 drivers/scsi/libsas/sas_scsi_host.c    | 9 +++++++++
 drivers/scsi/mvsas/mv_init.c           | 1 +
 drivers/scsi/pm8001/pm8001_init.c      | 1 +
 8 files changed, 16 insertions(+)

diff --git a/drivers/scsi/aic94xx/aic94xx_init.c b/drivers/scsi/aic94xx/aic94xx_init.c
index f5781e31f57c..b68dfeb952ee 100644
--- a/drivers/scsi/aic94xx/aic94xx_init.c
+++ b/drivers/scsi/aic94xx/aic94xx_init.c
@@ -52,6 +52,7 @@ static struct scsi_host_template aic94xx_sht = {
 	.max_sectors		= SCSI_DEFAULT_MAX_SECTORS,
 	.eh_device_reset_handler	= sas_eh_device_reset_handler,
 	.eh_target_reset_handler	= sas_eh_target_reset_handler,
+	.slave_alloc		= sas_slave_alloc,
 	.target_destroy		= sas_target_destroy,
 	.ioctl			= sas_ioctl,
 	.track_queue_depth	= 1,
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
index 3364ae0b9bfe..08fed7c416ac 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
@@ -1768,6 +1768,7 @@ static struct scsi_host_template sht_v1_hw = {
 	.max_sectors		= SCSI_DEFAULT_MAX_SECTORS,
 	.eh_device_reset_handler = sas_eh_device_reset_handler,
 	.eh_target_reset_handler = sas_eh_target_reset_handler,
+	.slave_alloc		= sas_slave_alloc,
 	.target_destroy		= sas_target_destroy,
 	.ioctl			= sas_ioctl,
 	.shost_attrs		= host_attrs_v1_hw,
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index 8e96a257e439..11c75881bd89 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -3542,6 +3542,7 @@ static struct scsi_host_template sht_v2_hw = {
 	.max_sectors		= SCSI_DEFAULT_MAX_SECTORS,
 	.eh_device_reset_handler = sas_eh_device_reset_handler,
 	.eh_target_reset_handler = sas_eh_target_reset_handler,
+	.slave_alloc		= sas_slave_alloc,
 	.target_destroy		= sas_target_destroy,
 	.ioctl			= sas_ioctl,
 	.shost_attrs		= host_attrs_v2_hw,
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 916447f3c607..13f314fa757e 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -3064,6 +3064,7 @@ static struct scsi_host_template sht_v3_hw = {
 	.max_sectors		= SCSI_DEFAULT_MAX_SECTORS,
 	.eh_device_reset_handler = sas_eh_device_reset_handler,
 	.eh_target_reset_handler = sas_eh_target_reset_handler,
+	.slave_alloc		= sas_slave_alloc,
 	.target_destroy		= sas_target_destroy,
 	.ioctl			= sas_ioctl,
 	.shost_attrs		= host_attrs_v3_hw,
diff --git a/drivers/scsi/isci/init.c b/drivers/scsi/isci/init.c
index 1727d0c71b12..c33bcf85fb21 100644
--- a/drivers/scsi/isci/init.c
+++ b/drivers/scsi/isci/init.c
@@ -166,6 +166,7 @@ static struct scsi_host_template isci_sht = {
 	.eh_abort_handler		= sas_eh_abort_handler,
 	.eh_device_reset_handler        = sas_eh_device_reset_handler,
 	.eh_target_reset_handler        = sas_eh_target_reset_handler,
+	.slave_alloc			= sas_slave_alloc,
 	.target_destroy			= sas_target_destroy,
 	.ioctl				= sas_ioctl,
 	.shost_attrs			= isci_host_attrs,
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index bec83eb8ab87..081f3145fe14 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -911,6 +911,14 @@ void sas_task_abort(struct sas_task *task)
 		blk_abort_request(sc->request);
 }
 
+int sas_slave_alloc(struct scsi_device *sdev)
+{
+	if (dev_is_sata(sdev_to_domain_dev(sdev)) && sdev->lun)
+		return -ENXIO;
+
+	return 0;
+}
+
 void sas_target_destroy(struct scsi_target *starget)
 {
 	struct domain_device *found_dev = starget->hostdata;
@@ -957,5 +965,6 @@ EXPORT_SYMBOL_GPL(sas_task_abort);
 EXPORT_SYMBOL_GPL(sas_phy_reset);
 EXPORT_SYMBOL_GPL(sas_eh_device_reset_handler);
 EXPORT_SYMBOL_GPL(sas_eh_target_reset_handler);
+EXPORT_SYMBOL_GPL(sas_slave_alloc);
 EXPORT_SYMBOL_GPL(sas_target_destroy);
 EXPORT_SYMBOL_GPL(sas_ioctl);
diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
index da719b0694dc..52405ce58ade 100644
--- a/drivers/scsi/mvsas/mv_init.c
+++ b/drivers/scsi/mvsas/mv_init.c
@@ -45,6 +45,7 @@ static struct scsi_host_template mvs_sht = {
 	.max_sectors		= SCSI_DEFAULT_MAX_SECTORS,
 	.eh_device_reset_handler = sas_eh_device_reset_handler,
 	.eh_target_reset_handler = sas_eh_target_reset_handler,
+	.slave_alloc		= sas_slave_alloc,
 	.target_destroy		= sas_target_destroy,
 	.ioctl			= sas_ioctl,
 	.shost_attrs		= mvst_host_attrs,
diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index 8882ba33ca87..1f41537d52a5 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -86,6 +86,7 @@ static struct scsi_host_template pm8001_sht = {
 	.max_sectors		= SCSI_DEFAULT_MAX_SECTORS,
 	.eh_device_reset_handler = sas_eh_device_reset_handler,
 	.eh_target_reset_handler = sas_eh_target_reset_handler,
+	.slave_alloc		= sas_slave_alloc,
 	.target_destroy		= sas_target_destroy,
 	.ioctl			= sas_ioctl,
 	.shost_attrs		= pm8001_host_attrs,
-- 
2.30.2

