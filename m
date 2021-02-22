Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 570E7321177
	for <lists+linux-scsi@lfdr.de>; Mon, 22 Feb 2021 08:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhBVHj7 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 22 Feb 2021 02:39:59 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:45673 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230041AbhBVHj7 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 22 Feb 2021 02:39:59 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UPA9y4i_1613979555;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UPA9y4i_1613979555)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 22 Feb 2021 15:39:15 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     james.smart@broadcom.com
Cc:     dick.kennedy@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] scsi: lpfc: Switch to using the new API kobj_to_dev()
Date:   Mon, 22 Feb 2021 15:39:13 +0800
Message-Id: <1613979553-18399-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

fixed the following coccicheck:
./drivers/scsi/lpfc/lpfc_attr.c:4389:6-7: WARNING opportunity for
kobj_to_dev()
./drivers/scsi/lpfc/lpfc_attr.c:6326:60-61: WARNING opportunity for
kobj_to_dev()
./drivers/scsi/lpfc/lpfc_attr.c:6386:60-61: WARNING opportunity for
kobj_to_dev()

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/scsi/lpfc/lpfc_attr.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index 4528166..a3bde0e 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -4385,8 +4385,7 @@ static DEVICE_ATTR(txcmplq_hw, S_IRUGO,
 		struct bin_attribute *bin_attr,
 		char *buf, loff_t off, size_t count)
 {
-	struct device *dev = container_of(kobj, struct device,
-		kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct Scsi_Host  *shost = class_to_shost(dev);
 	struct lpfc_vport *vport = (struct lpfc_vport *) shost->hostdata;
 	struct lpfc_hba   *phba = vport->phba;
@@ -6323,7 +6322,7 @@ struct device_attribute *lpfc_vport_attrs[] = {
 		   char *buf, loff_t off, size_t count)
 {
 	size_t buf_off;
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct Scsi_Host  *shost = class_to_shost(dev);
 	struct lpfc_vport *vport = (struct lpfc_vport *) shost->hostdata;
 	struct lpfc_hba   *phba = vport->phba;
@@ -6383,7 +6382,7 @@ struct device_attribute *lpfc_vport_attrs[] = {
 {
 	size_t buf_off;
 	uint32_t * tmp_ptr;
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct Scsi_Host  *shost = class_to_shost(dev);
 	struct lpfc_vport *vport = (struct lpfc_vport *) shost->hostdata;
 	struct lpfc_hba   *phba = vport->phba;
-- 
1.8.3.1

