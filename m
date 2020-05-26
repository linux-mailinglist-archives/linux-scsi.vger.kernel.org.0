Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE2A41D5038
	for <lists+linux-scsi@lfdr.de>; Fri, 15 May 2020 16:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgEOOR4 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 15 May 2020 10:17:56 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4793 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726248AbgEOORx (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 15 May 2020 10:17:53 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BD873D6B1D4BB6337E45;
        Fri, 15 May 2020 22:17:48 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Fri, 15 May 2020 22:17:37 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, Luo Jiaxing <luojiaxing@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 3/4] scsi: hisi_sas: Add SAS_RAS_INTR0 to debugfs register name list
Date:   Fri, 15 May 2020 22:13:44 +0800
Message-ID: <1589552025-165012-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1589552025-165012-1-git-send-email-john.garry@huawei.com>
References: <1589552025-165012-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Luo Jiaxing <luojiaxing@huawei.com>

Register SAS_RAS_INTR0 can help us to figure out which ECC error was
occurred. This register is helpful to locate RAS issue, so we add it to
the list of debugfs register name list for easier retrieval.

Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 41e07e9f6c8a..df9f06224f8f 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -2901,6 +2901,7 @@ static const struct hisi_sas_debugfs_reg debugfs_axi_reg = {
 };
 
 static const struct hisi_sas_debugfs_reg_lu debugfs_ras_reg_lu[] = {
+	HISI_SAS_DEBUGFS_REG(SAS_RAS_INTR0),
 	HISI_SAS_DEBUGFS_REG(SAS_RAS_INTR1),
 	HISI_SAS_DEBUGFS_REG(SAS_RAS_INTR0_MASK),
 	HISI_SAS_DEBUGFS_REG(SAS_RAS_INTR1_MASK),
-- 
2.16.4

