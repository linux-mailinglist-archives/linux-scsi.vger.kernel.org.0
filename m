Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E54DA3D6C73
	for <lists+linux-scsi@lfdr.de>; Tue, 27 Jul 2021 05:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234718AbhG0Cia (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 26 Jul 2021 22:38:30 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:12309 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234513AbhG0Ci3 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 26 Jul 2021 22:38:29 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GYhj138VWz7yCY;
        Tue, 27 Jul 2021 11:14:13 +0800 (CST)
Received: from dggema773-chm.china.huawei.com (10.1.198.217) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 11:18:55 +0800
Received: from localhost.huawei.com (10.175.124.27) by
 dggema773-chm.china.huawei.com (10.1.198.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 27 Jul 2021 11:18:54 +0800
From:   <lijinlin3@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <john.garry@huawei.com>, <bvanassche@acm.org>,
        <yanaijie@huawei.com>, <linfeilong@huawei.com>,
        <wubo40@huawei.com>, <lijinlin3@huawei.com>
Subject: [PATCH v2] scsi: Fix the issue that the disk capacity set to zero
Date:   Tue, 27 Jul 2021 11:44:55 +0800
Message-ID: <20210727034455.1494960-1-lijinlin3@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema773-chm.china.huawei.com (10.1.198.217)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: lijinlin <lijinlin3@huawei.com>

After add physical volumes to a volume group through vgextend, kernel
will rescan partitions, which will read the capacity of the device.
If the device status is set to offline through sysfs at this time,
read capacity command will return a result which the host byte is
DID_NO_CONNECT, the capacity of the device will be set to zero in
read_capacity_error(). However, the capacity of the device can't be
reread after reset the device status to running, is still zero.

Fix this issue by rescan device when the device state changes to
SDEV_RUNNING.

Signed-off-by: lijinlin <lijinlin3@huawei.com>
Signed-off-by: Wu Bo <wubo40@huawei.com>
---
 drivers/scsi/scsi_sysfs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 32489d25158f..ae9bfc658203 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -807,11 +807,14 @@ store_state_field(struct device *dev, struct device_attribute *attr,
 	mutex_lock(&sdev->state_mutex);
 	ret = scsi_device_set_state(sdev, state);
 	/*
-	 * If the device state changes to SDEV_RUNNING, we need to run
-	 * the queue to avoid I/O hang.
+	 * If the device state changes to SDEV_RUNNING, we need to
+	 * rescan the device to revalidate it, and run the queue to
+	 * avoid I/O hang.
 	 */
-	if (ret == 0 && state == SDEV_RUNNING)
+	if (ret == 0 && state == SDEV_RUNNING) {
+		scsi_rescan_device(dev);
 		blk_mq_run_hw_queues(sdev->request_queue, true);
+	}
 	mutex_unlock(&sdev->state_mutex);
 
 	return ret == 0 ? count : -EINVAL;
-- 
2.27.0

