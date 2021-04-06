Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94EBB3552C6
	for <lists+linux-scsi@lfdr.de>; Tue,  6 Apr 2021 13:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343540AbhDFLxB (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 6 Apr 2021 07:53:01 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:16364 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343536AbhDFLw6 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 6 Apr 2021 07:52:58 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FF5SY45BLz94Cq;
        Tue,  6 Apr 2021 19:50:37 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Tue, 6 Apr 2021 19:52:38 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.orgc>,
        <linuxarm@huawei.com>, Jianqin Xie <xiejianqin@hisilicon.com>,
        Luo Jiaxing <luojiaxing@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 4/6] scsi: hisi_sas: Directly snapshot registers when executing a reset
Date:   Tue, 6 Apr 2021 19:48:29 +0800
Message-ID: <1617709711-195853-5-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1617709711-195853-1-git-send-email-john.garry@huawei.com>
References: <1617709711-195853-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Jianqin Xie <xiejianqin@hisilicon.com>

The debugfs snapshot should be executed before the reset occurs to ensure
that the register contents are saved properly.

As such, it is incorrect to queue the debugfs dump when running a reset
as the reset will occur prior to the snapshot work item is handler.

Therefore, directly snapshot registers in the reset work handler.

Signed-off-by: Jianqin Xie <xiejianqin@hisilicon.com>
Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas.h       |  1 +
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 28 ++++++++++++++++++--------
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 27 ++++++++++++++-----------
 3 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas.h b/drivers/scsi/hisi_sas/hisi_sas.h
index 4dd53bc2d946..cf879cc59e4c 100644
--- a/drivers/scsi/hisi_sas/hisi_sas.h
+++ b/drivers/scsi/hisi_sas/hisi_sas.h
@@ -346,6 +346,7 @@ struct hisi_sas_hw {
 				u8 reg_index, u8 reg_count, u8 *write_data);
 	void (*wait_cmds_complete_timeout)(struct hisi_hba *hisi_hba,
 					   int delay_ms, int timeout_ms);
+	void (*debugfs_snapshot_regs)(struct hisi_hba *hisi_hba);
 	int complete_hdr_size;
 	struct scsi_host_template *sht;
 };
diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 971c45a1401c..4c90d91d47f4 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -1568,21 +1568,26 @@ void hisi_sas_controller_reset_done(struct hisi_hba *hisi_hba)
 }
 EXPORT_SYMBOL_GPL(hisi_sas_controller_reset_done);
 
-static int hisi_sas_controller_reset(struct hisi_hba *hisi_hba)
+static int hisi_sas_controller_prereset(struct hisi_hba *hisi_hba)
 {
-	struct device *dev = hisi_hba->dev;
-	struct Scsi_Host *shost = hisi_hba->shost;
-	int rc;
-
-	if (hisi_sas_debugfs_enable && hisi_hba->debugfs_itct[0].itct)
-		queue_work(hisi_hba->wq, &hisi_hba->debugfs_work);
-
 	if (!hisi_hba->hw->soft_reset)
 		return -1;
 
 	if (test_and_set_bit(HISI_SAS_RESET_BIT, &hisi_hba->flags))
 		return -1;
 
+	if (hisi_sas_debugfs_enable && hisi_hba->debugfs_itct[0].itct)
+		hisi_hba->hw->debugfs_snapshot_regs(hisi_hba);
+
+	return 0;
+}
+
+static int hisi_sas_controller_reset(struct hisi_hba *hisi_hba)
+{
+	struct device *dev = hisi_hba->dev;
+	struct Scsi_Host *shost = hisi_hba->shost;
+	int rc;
+
 	dev_info(dev, "controller resetting...\n");
 	hisi_sas_controller_reset_prepare(hisi_hba);
 
@@ -2471,6 +2476,9 @@ void hisi_sas_rst_work_handler(struct work_struct *work)
 	struct hisi_hba *hisi_hba =
 		container_of(work, struct hisi_hba, rst_work);
 
+	if (hisi_sas_controller_prereset(hisi_hba))
+		return;
+
 	hisi_sas_controller_reset(hisi_hba);
 }
 EXPORT_SYMBOL_GPL(hisi_sas_rst_work_handler);
@@ -2480,8 +2488,12 @@ void hisi_sas_sync_rst_work_handler(struct work_struct *work)
 	struct hisi_sas_rst *rst =
 		container_of(work, struct hisi_sas_rst, work);
 
+	if (hisi_sas_controller_prereset(rst->hisi_hba))
+		goto rst_complete;
+
 	if (!hisi_sas_controller_reset(rst->hisi_hba))
 		rst->done = true;
+rst_complete:
 	complete(rst->completion);
 }
 EXPORT_SYMBOL_GPL(hisi_sas_sync_rst_work_handler);
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index d7f8ba0c1680..0927b0b30b29 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -531,6 +531,7 @@ module_param(prot_mask, int, 0);
 MODULE_PARM_DESC(prot_mask, " host protection capabilities mask, def=0x0 ");
 
 static void debugfs_work_handler_v3_hw(struct work_struct *work);
+static void debugfs_snapshot_regs_v3_hw(struct hisi_hba *hisi_hba);
 
 static u32 hisi_sas_read32(struct hisi_hba *hisi_hba, u32 off)
 {
@@ -3182,6 +3183,7 @@ static const struct hisi_sas_hw hisi_sas_v3_hw = {
 	.get_events = phy_get_events_v3_hw,
 	.write_gpio = write_gpio_v3_hw,
 	.wait_cmds_complete_timeout = wait_cmds_complete_timeout_v3_hw,
+	.debugfs_snapshot_regs = debugfs_snapshot_regs_v3_hw,
 };
 
 static struct Scsi_Host *
@@ -3666,6 +3668,19 @@ static void debugfs_create_files_v3_hw(struct hisi_hba *hisi_hba)
 
 static void debugfs_snapshot_regs_v3_hw(struct hisi_hba *hisi_hba)
 {
+	int debugfs_dump_index = hisi_hba->debugfs_dump_index;
+	struct device *dev = hisi_hba->dev;
+	u64 timestamp = local_clock();
+
+	if (debugfs_dump_index >= hisi_sas_debugfs_dump_count) {
+		dev_warn(dev, "dump count exceeded!\n");
+		return;
+	}
+
+	do_div(timestamp, NSEC_PER_MSEC);
+	hisi_hba->debugfs_timestamp[debugfs_dump_index] = timestamp;
+	hisi_hba->debugfs_dump_index++;
+
 	debugfs_snapshot_prepare_v3_hw(hisi_hba);
 
 	debugfs_snapshot_global_reg_v3_hw(hisi_hba);
@@ -4408,20 +4423,8 @@ static void debugfs_work_handler_v3_hw(struct work_struct *work)
 {
 	struct hisi_hba *hisi_hba =
 		container_of(work, struct hisi_hba, debugfs_work);
-	int debugfs_dump_index = hisi_hba->debugfs_dump_index;
-	struct device *dev = hisi_hba->dev;
-	u64 timestamp = local_clock();
-
-	if (debugfs_dump_index >= hisi_sas_debugfs_dump_count) {
-		dev_warn(dev, "dump count exceeded!\n");
-		return;
-	}
-
-	do_div(timestamp, NSEC_PER_MSEC);
-	hisi_hba->debugfs_timestamp[debugfs_dump_index] = timestamp;
 
 	debugfs_snapshot_regs_v3_hw(hisi_hba);
-	hisi_hba->debugfs_dump_index++;
 }
 
 static void debugfs_release_v3_hw(struct hisi_hba *hisi_hba, int dump_index)
-- 
2.26.2

