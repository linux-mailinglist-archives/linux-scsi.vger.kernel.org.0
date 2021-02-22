Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6031E3211A3
	for <lists+linux-scsi@lfdr.de>; Mon, 22 Feb 2021 08:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhBVHxb (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 22 Feb 2021 02:53:31 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:36882 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230170AbhBVHxa (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 22 Feb 2021 02:53:30 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UPD0K-M_1613980366;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UPD0K-M_1613980366)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 22 Feb 2021 15:52:46 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     brking@us.ibm.com
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] scsi: ipr: Switch to using the new API kobj_to_dev()
Date:   Mon, 22 Feb 2021 15:52:45 +0800
Message-Id: <1613980365-34562-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

fixed the following coccicheck:
./drivers/scsi/ipr.c:4209:61-62: WARNING opportunity for kobj_to_dev()
./drivers/scsi/ipr.c:4268:61-62: WARNING opportunity for kobj_to_dev()
./drivers/scsi/ipr.c:4457:61-62: WARNING opportunity for kobj_to_dev()

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/scsi/ipr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index e451102..4d8a975 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
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
1.8.3.1

