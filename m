Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECCE99B1A4
	for <lists+linux-scsi@lfdr.de>; Fri, 23 Aug 2019 16:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390528AbfHWOJI (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 23 Aug 2019 10:09:08 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5648 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389857AbfHWOJI (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 23 Aug 2019 10:09:08 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id F1E3C241F8B4E6294802;
        Fri, 23 Aug 2019 22:09:02 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Fri, 23 Aug 2019
 22:08:55 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <agross@kernel.org>, <avri.altman@wdc.com>,
        <pedrom.sousa@synopsys.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <zhengbin13@huawei.com>
Subject: [PATCH] scsi: ufs: remove set but not used variable 'val'
Date:   Fri, 23 Aug 2019 22:15:26 +0800
Message-ID: <1566569726-75596-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/scsi/ufs/ufs-qcom.c: In function ufs_qcom_pwr_change_notify:
drivers/scsi/ufs/ufs-qcom.c:808:6: warning: variable val set but not used [-Wunused-but-set-variable]

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 drivers/scsi/ufs/ufs-qcom.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
index 4473f33..02cdcef 100644
--- a/drivers/scsi/ufs/ufs-qcom.c
+++ b/drivers/scsi/ufs/ufs-qcom.c
@@ -800,7 +800,6 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
 				struct ufs_pa_layer_attr *dev_max_params,
 				struct ufs_pa_layer_attr *dev_req_params)
 {
-	u32 val;
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
 	struct ufs_dev_params ufs_qcom_cap;
 	int ret = 0;
@@ -869,8 +868,6 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
 			ret = -EINVAL;
 		}

-		val = ~(MAX_U32 << dev_req_params->lane_tx);
-
 		/* cache the power mode parameters to use internally */
 		memcpy(&host->dev_req_params,
 				dev_req_params, sizeof(*dev_req_params));
--
2.7.4

