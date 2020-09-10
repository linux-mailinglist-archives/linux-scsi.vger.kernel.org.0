Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D828D263DFA
	for <lists+linux-scsi@lfdr.de>; Thu, 10 Sep 2020 09:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730374AbgIJHEp (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 10 Sep 2020 03:04:45 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11763 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730317AbgIJHCf (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 10 Sep 2020 03:02:35 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 70660A542A472955DDD9;
        Thu, 10 Sep 2020 15:02:23 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Thu, 10 Sep 2020 15:02:16 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <brking@us.ibm.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH] scsi: ipr: Switch to using the new API kobj_to_dev()
Date:   Thu, 10 Sep 2020 14:59:57 +0800
Message-ID: <1599721197-50686-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Switch to using the new API kobj_to_dev().

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/scsi/ipr.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index b0aa58d1..2ed3dd5 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -3456,7 +3456,7 @@ static ssize_t ipr_read_trace(struct file *filp, struct kobject *kobj,
 			      struct bin_attribute *bin_attr,
 			      char *buf, loff_t off, size_t count)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct ipr_ioa_cfg *ioa_cfg = (struct ipr_ioa_cfg *)shost->hostdata;
 	unsigned long lock_flags = 0;
@@ -4182,7 +4182,7 @@ static ssize_t ipr_read_async_err_log(struct file *filep, struct kobject *kobj,
 				struct bin_attribute *bin_attr, char *buf,
 				loff_t off, size_t count)
 {
-	struct device *cdev = container_of(kobj, struct device, kobj);
+	struct device *cdev = kobj_to_dev(kobj);
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct ipr_ioa_cfg *ioa_cfg = (struct ipr_ioa_cfg *)shost->hostdata;
 	struct ipr_hostrcb *hostrcb;
@@ -4206,7 +4206,7 @@ static ssize_t ipr_next_async_err_log(struct file *filep, struct kobject *kobj,
 				struct bin_attribute *bin_attr, char *buf,
 				loff_t off, size_t count)
 {
-	struct device *cdev = container_of(kobj, struct device, kobj);
+	struct device *cdev = kobj_to_dev(kobj);
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct ipr_ioa_cfg *ioa_cfg = (struct ipr_ioa_cfg *)shost->hostdata;
 	struct ipr_hostrcb *hostrcb;
@@ -4265,7 +4265,7 @@ static ssize_t ipr_read_dump(struct file *filp, struct kobject *kobj,
 			     struct bin_attribute *bin_attr,
 			     char *buf, loff_t off, size_t count)
 {
-	struct device *cdev = container_of(kobj, struct device, kobj);
+	struct device *cdev = kobj_to_dev(kobj);
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct ipr_ioa_cfg *ioa_cfg = (struct ipr_ioa_cfg *)shost->hostdata;
 	struct ipr_dump *dump;
@@ -4454,7 +4454,7 @@ static ssize_t ipr_write_dump(struct file *filp, struct kobject *kobj,
 			      struct bin_attribute *bin_attr,
 			      char *buf, loff_t off, size_t count)
 {
-	struct device *cdev = container_of(kobj, struct device, kobj);
+	struct device *cdev = kobj_to_dev(kobj);
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct ipr_ioa_cfg *ioa_cfg = (struct ipr_ioa_cfg *)shost->hostdata;
 	int rc;
-- 
2.7.4

