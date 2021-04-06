Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA813552C0
	for <lists+linux-scsi@lfdr.de>; Tue,  6 Apr 2021 13:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343501AbhDFLwx (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 6 Apr 2021 07:52:53 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15136 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbhDFLww (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 6 Apr 2021 07:52:52 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FF5Rp26tmzpVLQ;
        Tue,  6 Apr 2021 19:49:58 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Tue, 6 Apr 2021 19:52:37 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.orgc>,
        <linuxarm@huawei.com>, Luo Jiaxing <luojiaxing@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 1/6] scsi: hisi_sas: Delete some unused callbacks
Date:   Tue, 6 Apr 2021 19:48:26 +0800
Message-ID: <1617709711-195853-2-git-send-email-john.garry@huawei.com>
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

From: Luo Jiaxing <luojiaxing@huawei.com>

The debugfs code has been relocated to v3 hw driver, so delete unused
struct hisi_sas_hw function pointers snapshot_{prepare, restore}.

Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas.h b/drivers/scsi/hisi_sas/hisi_sas.h
index 2401a9575215..4dd53bc2d946 100644
--- a/drivers/scsi/hisi_sas/hisi_sas.h
+++ b/drivers/scsi/hisi_sas/hisi_sas.h
@@ -346,8 +346,6 @@ struct hisi_sas_hw {
 				u8 reg_index, u8 reg_count, u8 *write_data);
 	void (*wait_cmds_complete_timeout)(struct hisi_hba *hisi_hba,
 					   int delay_ms, int timeout_ms);
-	void (*snapshot_prepare)(struct hisi_hba *hisi_hba);
-	void (*snapshot_restore)(struct hisi_hba *hisi_hba);
 	int complete_hdr_size;
 	struct scsi_host_template *sht;
 };
-- 
2.26.2

