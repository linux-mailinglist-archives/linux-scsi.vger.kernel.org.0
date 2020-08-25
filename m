Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48AC325121C
	for <lists+linux-scsi@lfdr.de>; Tue, 25 Aug 2020 08:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbgHYGhU (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 25 Aug 2020 02:37:20 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55298 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726940AbgHYGhT (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 25 Aug 2020 02:37:19 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 574DB6BEFDB23197F942;
        Tue, 25 Aug 2020 14:37:13 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Tue, 25 Aug 2020 14:37:04 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <kashyap.desai@broadcom.com>, <sumit.saxena@broadcom.com>,
        <shivasharan.srikanteshwara@broadcom.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <megaraidlinux.pdl@broadcom.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jingxiangfeng@huawei.com>
Subject: [PATCH] scsi: megaraid: Remove unnecessary assignment to variable ret
Date:   Tue, 25 Aug 2020 14:38:36 +0800
Message-ID: <20200825063836.92239-1-jingxiangfeng@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The variable ret is being initialized with 'FAILED'. So we can remove
this assignement.

Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 drivers/scsi/megaraid/megaraid_sas_fusion.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index 0824410f78f8..96d424645b18 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -4700,7 +4700,6 @@ int megasas_reset_target_fusion(struct scsi_cmnd *scmd)
 	if (atomic_read(&instance->adprecovery) != MEGASAS_HBA_OPERATIONAL) {
 		dev_err(&instance->pdev->dev, "Controller is not OPERATIONAL,"
 		"SCSI host:%d\n", instance->host->host_no);
-		ret = FAILED;
 		return ret;
 	}
 
@@ -4713,7 +4712,6 @@ int megasas_reset_target_fusion(struct scsi_cmnd *scmd)
 	}
 
 	if (!mr_device_priv_data->is_tm_capable) {
-		ret = FAILED;
 		goto out;
 	}
 
-- 
2.17.1

