Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D76611B1D0A
	for <lists+linux-scsi@lfdr.de>; Tue, 21 Apr 2020 05:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbgDUDlu (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 20 Apr 2020 23:41:50 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57284 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728083AbgDUDlu (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 20 Apr 2020 23:41:50 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DBD42B06E42AC79A7AF9;
        Tue, 21 Apr 2020 11:41:47 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Tue, 21 Apr 2020
 11:41:41 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <kashyap.desai@broadcom.com>, <sumit.saxena@broadcom.com>,
        <shivasharan.srikanteshwara@broadcom.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <megaraidlinux.pdl@broadcom.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] scsi: megaraid: use true,false for bool variables
Date:   Tue, 21 Apr 2020 11:41:11 +0800
Message-ID: <20200421034111.28353-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fix the following coccicheck warning:

drivers/scsi/megaraid/megaraid_sas_fusion.c:4242:6-16: WARNING:
Assignment of 0/1 to bool variable
drivers/scsi/megaraid/megaraid_sas_fusion.c:4786:1-29: WARNING:
Assignment of 0/1 to bool variable
drivers/scsi/megaraid/megaraid_sas_fusion.c:4791:1-29: WARNING:
Assignment of 0/1 to bool variable
drivers/scsi/megaraid/megaraid_sas_fusion.c:4716:1-29: WARNING:
Assignment of 0/1 to bool variable
drivers/scsi/megaraid/megaraid_sas_fusion.c:4721:1-29: WARNING:
Assignment of 0/1 to bool variable

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/scsi/megaraid/megaraid_sas_fusion.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index bec3d4cca74f..e0f923b8cc50 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -4239,7 +4239,7 @@ static void megasas_refire_mgmt_cmd(struct megasas_instance *instance,
 	struct megasas_cmd *cmd_mfi;
 	union MEGASAS_REQUEST_DESCRIPTOR_UNION *req_desc;
 	u16 smid;
-	bool refire_cmd = 0;
+	bool refire_cmd = false;
 	u8 result;
 	u32 opcode = 0;
 
@@ -4713,12 +4713,12 @@ int megasas_task_abort_fusion(struct scsi_cmnd *scmd)
 		"attempting task abort! scmd(0x%p) tm_dev_handle 0x%x\n",
 		scmd, devhandle);
 
-	mr_device_priv_data->tm_busy = 1;
+	mr_device_priv_data->tm_busy = true;
 	ret = megasas_issue_tm(instance, devhandle,
 			scmd->device->channel, scmd->device->id, smid,
 			MPI2_SCSITASKMGMT_TASKTYPE_ABORT_TASK,
 			mr_device_priv_data);
-	mr_device_priv_data->tm_busy = 0;
+	mr_device_priv_data->tm_busy = false;
 
 	mutex_unlock(&instance->reset_mutex);
 	scmd_printk(KERN_INFO, scmd, "task abort %s!! scmd(0x%p)\n",
@@ -4783,12 +4783,12 @@ int megasas_reset_target_fusion(struct scsi_cmnd *scmd)
 	sdev_printk(KERN_INFO, scmd->device,
 		"attempting target reset! scmd(0x%p) tm_dev_handle: 0x%x\n",
 		scmd, devhandle);
-	mr_device_priv_data->tm_busy = 1;
+	mr_device_priv_data->tm_busy = true;
 	ret = megasas_issue_tm(instance, devhandle,
 			scmd->device->channel, scmd->device->id, 0,
 			MPI2_SCSITASKMGMT_TASKTYPE_TARGET_RESET,
 			mr_device_priv_data);
-	mr_device_priv_data->tm_busy = 0;
+	mr_device_priv_data->tm_busy = false;
 	mutex_unlock(&instance->reset_mutex);
 	scmd_printk(KERN_NOTICE, scmd, "target reset %s!!\n",
 		(ret == SUCCESS) ? "SUCCESS" : "FAILED");
-- 
2.21.1

