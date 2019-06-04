Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE2AB34801
	for <lists+linux-scsi@lfdr.de>; Tue,  4 Jun 2019 15:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbfFDNRy (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 4 Jun 2019 09:17:54 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41514 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727579AbfFDNRw (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 4 Jun 2019 09:17:52 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 60BDFAEDEBC14FE0D052;
        Tue,  4 Jun 2019 21:17:46 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Tue, 4 Jun 2019
 21:17:27 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <martin.petersen@oracle.com>, <jejb@linux.vnet.ibm.com>
CC:     <linux-scsi@vger.kernel.org>, Jason Yan <yanaijie@huawei.com>
Subject: [PATCH v2] scsi: kill useless scsi_use_blk_mq and force_blk_mq
Date:   Tue, 4 Jun 2019 21:35:15 +0800
Message-ID: <20190604133515.40311-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The legacy path is gone and we do not have to choose mq or not. The
module parameter scsi_use_blk_mq and scsi_host_template.force_blk_mq
is useless now.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---

v2: remove force_blk_mq too

 drivers/scsi/scsi.c        | 4 ----
 drivers/scsi/scsi_priv.h   | 1 -
 drivers/scsi/scsi_sysfs.c  | 8 --------
 drivers/scsi/virtio_scsi.c | 1 -
 include/scsi/scsi_host.h   | 3 ---
 5 files changed, 17 deletions(-)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 653d5ea6c5d9..7049aabb86e0 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -765,10 +765,6 @@ MODULE_LICENSE("GPL");
 module_param(scsi_logging_level, int, S_IRUGO|S_IWUSR);
 MODULE_PARM_DESC(scsi_logging_level, "a bit mask of logging levels");
 
-/* This should go away in the future, it doesn't do anything anymore */
-bool scsi_use_blk_mq = true;
-module_param_named(use_blk_mq, scsi_use_blk_mq, bool, S_IWUSR | S_IRUGO);
-
 static int __init init_scsi(void)
 {
 	int error;
diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
index 5f21547b2ad2..a4f0741524d8 100644
--- a/drivers/scsi/scsi_priv.h
+++ b/drivers/scsi/scsi_priv.h
@@ -29,7 +29,6 @@ extern int scsi_init_hosts(void);
 extern void scsi_exit_hosts(void);
 
 /* scsi.c */
-extern bool scsi_use_blk_mq;
 int scsi_init_sense_cache(struct Scsi_Host *shost);
 void scsi_init_command(struct scsi_device *dev, struct scsi_cmnd *cmd);
 #ifdef CONFIG_SCSI_LOGGING
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index dbb206c90ecf..403832ee17e0 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -386,15 +386,7 @@ show_host_busy(struct device *dev, struct device_attribute *attr, char *buf)
 }
 static DEVICE_ATTR(host_busy, S_IRUGO, show_host_busy, NULL);
 
-static ssize_t
-show_use_blk_mq(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	return sprintf(buf, "1\n");
-}
-static DEVICE_ATTR(use_blk_mq, S_IRUGO, show_use_blk_mq, NULL);
-
 static struct attribute *scsi_sysfs_shost_attrs[] = {
-	&dev_attr_use_blk_mq.attr,
 	&dev_attr_unique_id.attr,
 	&dev_attr_host_busy.attr,
 	&dev_attr_cmd_per_lun.attr,
diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 13f1b3b9923a..f4e3c0310c7d 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -687,7 +687,6 @@ static struct scsi_host_template virtscsi_host_template = {
 	.dma_boundary = UINT_MAX,
 	.map_queues = virtscsi_map_queues,
 	.track_queue_depth = 1,
-	.force_blk_mq = 1,
 };
 
 #define virtscsi_config_get(vdev, fld) \
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index a5fcdad4a03e..2bf56cdb6195 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -425,9 +425,6 @@ struct scsi_host_template {
 	/* True if the controller does not support WRITE SAME */
 	unsigned no_write_same:1;
 
-	/* True if the low-level driver supports blk-mq only */
-	unsigned force_blk_mq:1;
-
 	/*
 	 * Countdown for host blocking with no commands outstanding.
 	 */
-- 
2.17.2

