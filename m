Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7285C143772
	for <lists+linux-scsi@lfdr.de>; Tue, 21 Jan 2020 08:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgAUHQT (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 21 Jan 2020 02:16:19 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:45502 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725789AbgAUHQT (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 21 Jan 2020 02:16:19 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A83432AFE458E64B75AC;
        Tue, 21 Jan 2020 15:16:16 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Tue, 21 Jan 2020
 15:16:10 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, Ye Bin <yebin10@huawei.com>
Subject: [PATCH] scsi: Remove redundant assignment about request_queue->queuedata
Date:   Tue, 21 Jan 2020 15:15:21 +0800
Message-ID: <20200121071521.26959-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

We already set request_queue->queuedata value in function scsi_mq_alloc_queue.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 drivers/scsi/scsi_scan.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index 058079f915f1..57d2a00f3b28 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -275,7 +275,6 @@ static struct scsi_device *scsi_alloc_sdev(struct scsi_target *starget,
 		goto out;
 	}
 	WARN_ON_ONCE(!blk_get_queue(sdev->request_queue));
-	sdev->request_queue->queuedata = sdev;
 
 	scsi_change_queue_depth(sdev, sdev->host->cmd_per_lun ?
 					sdev->host->cmd_per_lun : 1);
-- 
2.17.2

