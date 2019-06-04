Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47B0534565
	for <lists+linux-scsi@lfdr.de>; Tue,  4 Jun 2019 13:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfFDL0k (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 4 Jun 2019 07:26:40 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18081 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726508AbfFDL0k (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 4 Jun 2019 07:26:40 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CEA3BCFD5F3477FB69CD;
        Tue,  4 Jun 2019 19:26:37 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Tue, 4 Jun 2019
 19:26:31 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <martin.petersen@oracle.com>, <jejb@linux.vnet.ibm.com>
CC:     <linux-scsi@vger.kernel.org>, Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] scsi: kill useless scsi_use_blk_mq
Date:   Tue, 4 Jun 2019 19:44:16 +0800
Message-ID: <20190604114416.26924-1-yanaijie@huawei.com>
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
module parameter scsi_use_blk_mq is useless now.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/scsi/scsi.c       | 4 ----
 drivers/scsi/scsi_priv.h  | 1 -
 drivers/scsi/scsi_sysfs.c | 8 --------
 3 files changed, 13 deletions(-)

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
-- 
2.17.2

