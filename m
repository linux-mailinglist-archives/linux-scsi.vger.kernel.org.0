Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710E947A899
	for <lists+linux-scsi@lfdr.de>; Mon, 20 Dec 2021 12:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbhLTL0w (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 20 Dec 2021 06:26:52 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:28331 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbhLTL0u (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 20 Dec 2021 06:26:50 -0500
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JHcjb0GSGzbjZk;
        Mon, 20 Dec 2021 19:26:27 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 dggeme756-chm.china.huawei.com (10.3.19.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Mon, 20 Dec 2021 19:26:48 +0800
From:   chenxiang <chenxiang66@hisilicon.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
        <john.garry@huawei.com>, Alan Stern <stern@rowland.harvard.edu>,
        Xiang Chen <chenxiang66@hisilicon.com>
Subject: [PATCH v2 03/15] scsi/block PM: Always set request queue runtime active in blk_post_runtime_resume()
Date:   Mon, 20 Dec 2021 19:21:26 +0800
Message-ID: <1639999298-244569-4-git-send-email-chenxiang66@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1639999298-244569-1-git-send-email-chenxiang66@hisilicon.com>
References: <1639999298-244569-1-git-send-email-chenxiang66@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeme756-chm.china.huawei.com (10.3.19.102)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

John Garry reported a deadlock that occurs when trying to access a
runtime-suspended SATA device.  For obscure reasons, the rescan
procedure causes the link to be hard-reset, which disconnects the
device.

The rescan tries to carry out a runtime resume when accessing the
device.  scsi_rescan_device() holds the SCSI device lock and won't
release it until it can put commands onto the device's block queue.
This can't happen until the queue is successfully runtime-resumed or
the device is unregistered.  But the runtime resume fails because the
device is disconnected, and __scsi_remove_device() can't do the
unregistration because it can't get the device lock.

The best way to resolve this deadlock appears to be to allow the block
queue to start running again even after an unsuccessful runtime
resume.  The idea is that the driver or the SCSI error handler will
need to be able to use the queue to resolve the runtime resume
failure.

This patch removes the err argument to blk_post_runtime_resume() and
makes the routine act as though the resume was successful always.
This fixes the deadlock.

Reported-and-tested-by: John Garry <john.garry@huawei.com>
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Fixes: e27829dc92e5 ("scsi: serialize ->rescan against ->remove")
---
 block/blk-pm.c         | 22 +++++++---------------
 drivers/scsi/scsi_pm.c |  2 +-
 include/linux/blk-pm.h |  2 +-
 3 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/block/blk-pm.c b/block/blk-pm.c
index 17bd020268d4..2dad62cc1572 100644
--- a/block/blk-pm.c
+++ b/block/blk-pm.c
@@ -163,27 +163,19 @@ EXPORT_SYMBOL(blk_pre_runtime_resume);
 /**
  * blk_post_runtime_resume - Post runtime resume processing
  * @q: the queue of the device
- * @err: return value of the device's runtime_resume function
  *
  * Description:
- *    Update the queue's runtime status according to the return value of the
- *    device's runtime_resume function. If the resume was successful, call
- *    blk_set_runtime_active() to do the real work of restarting the queue.
+ *    For historical reasons, this routine merely calls blk_set_runtime_active()
+ *    to do the real work of restarting the queue.  It does this regardless of
+ *    whether the device's runtime-resume succeeded; even if it failed the
+ *    driver or error handler will need to communicate with the device.
  *
  *    This function should be called near the end of the device's
  *    runtime_resume callback.
  */
-void blk_post_runtime_resume(struct request_queue *q, int err)
+void blk_post_runtime_resume(struct request_queue *q)
 {
-	if (!q->dev)
-		return;
-	if (!err) {
-		blk_set_runtime_active(q);
-	} else {
-		spin_lock_irq(&q->queue_lock);
-		q->rpm_status = RPM_SUSPENDED;
-		spin_unlock_irq(&q->queue_lock);
-	}
+	blk_set_runtime_active(q);
 }
 EXPORT_SYMBOL(blk_post_runtime_resume);
 
@@ -201,7 +193,7 @@ EXPORT_SYMBOL(blk_post_runtime_resume);
  * runtime PM status and re-enable peeking requests from the queue. It
  * should be called before first request is added to the queue.
  *
- * This function is also called by blk_post_runtime_resume() for successful
+ * This function is also called by blk_post_runtime_resume() for
  * runtime resumes.  It does everything necessary to restart the queue.
  */
 void blk_set_runtime_active(struct request_queue *q)
diff --git a/drivers/scsi/scsi_pm.c b/drivers/scsi/scsi_pm.c
index 0e841e8761c5..d581613d87c7 100644
--- a/drivers/scsi/scsi_pm.c
+++ b/drivers/scsi/scsi_pm.c
@@ -180,7 +180,7 @@ static int sdev_runtime_resume(struct device *dev)
 	blk_pre_runtime_resume(sdev->request_queue);
 	if (pm && pm->runtime_resume)
 		err = pm->runtime_resume(dev);
-	blk_post_runtime_resume(sdev->request_queue, err);
+	blk_post_runtime_resume(sdev->request_queue);
 
 	return err;
 }
diff --git a/include/linux/blk-pm.h b/include/linux/blk-pm.h
index b80c65aba249..2580e05a8ab6 100644
--- a/include/linux/blk-pm.h
+++ b/include/linux/blk-pm.h
@@ -14,7 +14,7 @@ extern void blk_pm_runtime_init(struct request_queue *q, struct device *dev);
 extern int blk_pre_runtime_suspend(struct request_queue *q);
 extern void blk_post_runtime_suspend(struct request_queue *q, int err);
 extern void blk_pre_runtime_resume(struct request_queue *q);
-extern void blk_post_runtime_resume(struct request_queue *q, int err);
+extern void blk_post_runtime_resume(struct request_queue *q);
 extern void blk_set_runtime_active(struct request_queue *q);
 #else
 static inline void blk_pm_runtime_init(struct request_queue *q,
-- 
2.33.0

