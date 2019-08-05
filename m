Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 958C681DE7
	for <lists+linux-scsi@lfdr.de>; Mon,  5 Aug 2019 15:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbfHENu3 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 5 Aug 2019 09:50:29 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44560 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729866AbfHENu2 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 5 Aug 2019 09:50:28 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 29691A460A766AD89F5A;
        Mon,  5 Aug 2019 21:50:24 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Mon, 5 Aug 2019 21:50:13 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>,
        Xiang Chen <chenxiang66@hisilicon.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH 07/15] scsi: hisi_sas: Don't bother clearing status buffer IU in task prep
Date:   Mon, 5 Aug 2019 21:48:04 +0800
Message-ID: <1565012892-75940-8-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1565012892-75940-1-git-send-email-john.garry@huawei.com>
References: <1565012892-75940-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Xiang Chen <chenxiang66@hisilicon.com>

For struct hisi_sas_status_buffer, it contains struct hisi_sas_err_record
and iu[1024]. The struct iu[1024] will be filled fully by the response of
disks, so it is not need to initialize them to 0, but for the struct
hisi_sas_err_record, SAS controller only fill some fields of
hisi_sas_err_record according to hw designer, so it should be initialised
to 0.
After the change, cpu utilization percentage of memset() is changed
from 1.7% to 0.12%.

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 02ad91c01a44..7efa8dfa0cc1 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -545,7 +545,8 @@ static int hisi_sas_task_prep(struct sas_task *task,
 
 	memset(slot->cmd_hdr, 0, sizeof(struct hisi_sas_cmd_hdr));
 	memset(hisi_sas_cmd_hdr_addr_mem(slot), 0, HISI_SAS_COMMAND_TABLE_SZ);
-	memset(hisi_sas_status_buf_addr_mem(slot), 0, HISI_SAS_STATUS_BUF_SZ);
+	memset(hisi_sas_status_buf_addr_mem(slot), 0,
+	       sizeof(struct hisi_sas_err_record));
 
 	switch (task->task_proto) {
 	case SAS_PROTOCOL_SMP:
@@ -2005,7 +2006,8 @@ hisi_sas_internal_abort_task_exec(struct hisi_hba *hisi_hba, int device_id,
 
 	memset(slot->cmd_hdr, 0, sizeof(struct hisi_sas_cmd_hdr));
 	memset(hisi_sas_cmd_hdr_addr_mem(slot), 0, HISI_SAS_COMMAND_TABLE_SZ);
-	memset(hisi_sas_status_buf_addr_mem(slot), 0, HISI_SAS_STATUS_BUF_SZ);
+	memset(hisi_sas_status_buf_addr_mem(slot), 0,
+	       sizeof(struct hisi_sas_err_record));
 
 	hisi_sas_task_prep_abort(hisi_hba, slot, device_id,
 				      abort_flag, task_tag);
-- 
2.17.1

