Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B09B74E46F
	for <lists+linux-scsi@lfdr.de>; Tue, 11 Jul 2023 04:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjGKCol (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 10 Jul 2023 22:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjGKCoi (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 10 Jul 2023 22:44:38 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6472C188
        for <linux-scsi@vger.kernel.org>; Mon, 10 Jul 2023 19:44:37 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R0Q9W0KYKzMqW1;
        Tue, 11 Jul 2023 10:41:19 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 kwepemi500016.china.huawei.com (7.221.188.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 11 Jul 2023 10:44:34 +0800
From:   chenxiang <chenxiang66@hisilicon.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-scsi@vger.kernel.org>,
        Xingui Yang <yangxingui@huawei.com>,
        Xiang Chen <chenxiang66@hisilicon.com>
Subject: [PATCH 1/3] scsi: hisi_sas: Fix normally completed I/O analysed as failed
Date:   Tue, 11 Jul 2023 11:14:58 +0800
Message-ID: <1689045300-44318-2-git-send-email-chenxiang66@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1689045300-44318-1-git-send-email-chenxiang66@hisilicon.com>
References: <1689045300-44318-1-git-send-email-chenxiang66@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Xingui Yang <yangxingui@huawei.com>

Pio read command has no response frame and the struct iu[1024] won't be
filled, and it's found that I/Os which are normally completed will be
analysed as failed in sas_ata_task_done() when iu contain abnormal dirty
data. So ending_fis should not be filled by iu when the response frame
hasn't been written to the memory.

Fixes: d380f55503ed ("scsi: hisi_sas: Don't bother clearing status buffer IU in task prep")
Signed-off-by: Xingui Yang <yangxingui@huawei.com>
Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
---
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 11 +++++++++--
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  6 ++++--
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index 87d8e40..404aa7e 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -2026,6 +2026,11 @@ static void slot_err_v2_hw(struct hisi_hba *hisi_hba,
 	u16 dma_tx_err_type = le16_to_cpu(err_record->dma_tx_err_type);
 	u16 sipc_rx_err_type = le16_to_cpu(err_record->sipc_rx_err_type);
 	u32 dma_rx_err_type = le32_to_cpu(err_record->dma_rx_err_type);
+	struct hisi_sas_complete_v2_hdr *complete_queue =
+			hisi_hba->complete_hdr[slot->cmplt_queue];
+	struct hisi_sas_complete_v2_hdr *complete_hdr =
+			&complete_queue[slot->cmplt_queue_slot];
+	u32 dw0 = le32_to_cpu(complete_hdr->dw0);
 	int error = -1;
 
 	if (err_phase == 1) {
@@ -2310,7 +2315,8 @@ static void slot_err_v2_hw(struct hisi_hba *hisi_hba,
 			break;
 		}
 		}
-		hisi_sas_sata_done(task, slot);
+		if (dw0 & CMPLT_HDR_RSPNS_XFRD_MSK)
+			hisi_sas_sata_done(task, slot);
 	}
 		break;
 	default:
@@ -2443,7 +2449,8 @@ static void slot_complete_v2_hw(struct hisi_hba *hisi_hba,
 	case SAS_PROTOCOL_SATA | SAS_PROTOCOL_STP:
 	{
 		ts->stat = SAS_SAM_STAT_GOOD;
-		hisi_sas_sata_done(task, slot);
+		if (dw0 & CMPLT_HDR_RSPNS_XFRD_MSK)
+			hisi_sas_sata_done(task, slot);
 		break;
 	}
 	default:
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 20e1607..2f33e6b 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -2257,7 +2257,8 @@ slot_err_v3_hw(struct hisi_hba *hisi_hba, struct sas_task *task,
 			ts->stat = SAS_OPEN_REJECT;
 			ts->open_rej_reason = SAS_OREJ_RSVD_RETRY;
 		}
-		hisi_sas_sata_done(task, slot);
+		if (dw0 & CMPLT_HDR_RSPNS_XFRD_MSK)
+			hisi_sas_sata_done(task, slot);
 		break;
 	case SAS_PROTOCOL_SMP:
 		ts->stat = SAS_SAM_STAT_CHECK_CONDITION;
@@ -2384,7 +2385,8 @@ static void slot_complete_v3_hw(struct hisi_hba *hisi_hba,
 	case SAS_PROTOCOL_STP:
 	case SAS_PROTOCOL_SATA | SAS_PROTOCOL_STP:
 		ts->stat = SAS_SAM_STAT_GOOD;
-		hisi_sas_sata_done(task, slot);
+		if (dw0 & CMPLT_HDR_RSPNS_XFRD_MSK)
+			hisi_sas_sata_done(task, slot);
 		break;
 	default:
 		ts->stat = SAS_SAM_STAT_CHECK_CONDITION;
-- 
2.8.1

