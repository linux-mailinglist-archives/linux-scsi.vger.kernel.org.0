Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F23638D48A
	for <lists+linux-scsi@lfdr.de>; Sat, 22 May 2021 10:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhEVIma (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 22 May 2021 04:42:30 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5731 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbhEVImJ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 22 May 2021 04:42:09 -0400
Received: from dggems705-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FnH045hjqzqVJW;
        Sat, 22 May 2021 16:37:08 +0800 (CST)
Received: from dggemi760-chm.china.huawei.com (10.1.198.146) by
 dggems705-chm.china.huawei.com (10.3.19.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 22 May 2021 16:40:41 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggemi760-chm.china.huawei.com (10.1.198.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Sat, 22 May 2021 16:40:40 +0800
From:   Hui Tang <tanghui20@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tanghui20@huawei.com>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>
Subject: [PATCH 22/24] scsi: dpt_i2o: remove leading spaces before tabs
Date:   Sat, 22 May 2021 16:37:26 +0800
Message-ID: <1621672648-39955-23-git-send-email-tanghui20@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1621672648-39955-1-git-send-email-tanghui20@huawei.com>
References: <1621672648-39955-1-git-send-email-tanghui20@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggemi760-chm.china.huawei.com (10.1.198.146)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

There are a few leading spaces before tabs and remove it by running
the following commard:

    $ find . -name '*.[ch]' | xargs sed -r -i 's/^[ ]+\t/\t/'

Cc: Adaptec OEM Raid Solutions <aacraid@microsemi.com>
Signed-off-by: Hui Tang <tanghui20@huawei.com>
---
 drivers/scsi/dpt_i2o.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/dpt_i2o.c b/drivers/scsi/dpt_i2o.c
index a18a4a0..6861fe3 100644
--- a/drivers/scsi/dpt_i2o.c
+++ b/drivers/scsi/dpt_i2o.c
@@ -3348,7 +3348,7 @@ static int adpt_i2o_issue_params(int cmd, adpt_hba* pHba, int tid,
 
 	if ((wait_status = adpt_i2o_post_wait(pHba, msg, sizeof(msg), 20))) {
 		printk("adpt_i2o_issue_params: post_wait failed (%p)\n", resblk_va);
-   		return wait_status; 	/* -DetailedStatus */
+		return wait_status; 	/* -DetailedStatus */
 	}
 
 	if (res[1]&0x00FF0000) { 	/* BlockStatus != SUCCESS */
@@ -3375,7 +3375,7 @@ static s32 adpt_i2o_quiesce_hba(adpt_hba* pHba)
 	/* SysQuiesce discarded if IOP not in READY or OPERATIONAL state */
 
 	if((pHba->status_block->iop_state != ADAPTER_STATE_READY) &&
-   	   (pHba->status_block->iop_state != ADAPTER_STATE_OPERATIONAL)){
+	   (pHba->status_block->iop_state != ADAPTER_STATE_OPERATIONAL)){
 		return 0;
 	}
 
-- 
2.8.1

