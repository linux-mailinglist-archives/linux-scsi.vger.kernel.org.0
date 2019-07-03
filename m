Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 354005D015
	for <lists+linux-scsi@lfdr.de>; Tue,  2 Jul 2019 15:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfGBNE4 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 2 Jul 2019 09:04:56 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8682 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726623AbfGBNEz (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 2 Jul 2019 09:04:55 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4C35869C953EE121C7D9;
        Tue,  2 Jul 2019 21:01:45 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Tue, 2 Jul 2019
 21:01:38 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <kashyap.desai@broadcom.com>, <sumit.saxena@broadcom.com>,
        <shivasharan.srikanteshwara@broadcom.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <megaraidlinux.pdl@broadcom.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] scsi: megaraid_sas: Make some symbols static
Date:   Tue, 2 Jul 2019 21:01:14 +0800
Message-ID: <20190702130114.29356-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fix sparse warnings:

drivers/scsi/megaraid/megaraid_sas_base.c:271:1: warning: symbol 'megasas_issue_dcmd' was not declared. Should it be static?
drivers/scsi/megaraid/megaraid_sas_base.c:2227:6: warning: symbol 'megasas_do_ocr' was not declared. Should it be static?
drivers/scsi/megaraid/megaraid_sas_base.c:3194:25: warning: symbol 'megaraid_host_attrs' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 80ab970..49e0f3d 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -280,7 +280,7 @@ void megasas_set_dma_settings(struct megasas_instance *instance,
 	}
 }
 
-void
+static void
 megasas_issue_dcmd(struct megasas_instance *instance, struct megasas_cmd *cmd)
 {
 	instance->instancet->fire_cmd(instance,
@@ -2237,7 +2237,7 @@ megasas_internal_reset_defer_cmds(struct megasas_instance *instance);
 static void
 process_fw_state_change_wq(struct work_struct *work);
 
-void megasas_do_ocr(struct megasas_instance *instance)
+static void megasas_do_ocr(struct megasas_instance *instance)
 {
 	if ((instance->pdev->device == PCI_DEVICE_ID_LSI_SAS1064R) ||
 	(instance->pdev->device == PCI_DEVICE_ID_DELL_PERC5) ||
@@ -3303,7 +3303,7 @@ static DEVICE_ATTR_RO(fw_cmds_outstanding);
 static DEVICE_ATTR_RO(dump_system_regs);
 static DEVICE_ATTR_RO(raid_map_id);
 
-struct device_attribute *megaraid_host_attrs[] = {
+static struct device_attribute *megaraid_host_attrs[] = {
 	&dev_attr_fw_crash_buffer_size,
 	&dev_attr_fw_crash_buffer,
 	&dev_attr_fw_crash_state,
-- 
2.7.4


