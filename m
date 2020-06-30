Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B8D20F816
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Jun 2020 17:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389333AbgF3PRg (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 30 Jun 2020 11:17:36 -0400
Received: from netrider.rowland.org ([192.131.102.5]:41917 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1729995AbgF3PRf (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 30 Jun 2020 11:17:35 -0400
Received: (qmail 452401 invoked by uid 1000); 30 Jun 2020 11:17:34 -0400
Date:   Tue, 30 Jun 2020 11:17:34 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Bart Van Assche <bvanassche@acm.org>, martin.petersen@oracle.com
Cc:     Can Guo <cang@codeaurora.org>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH] SCSI and block: Simplify resume handling
Message-ID: <20200630151734.GA451991@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Commit 05d18ae1cc8a ("scsi: pm: Balance pm_only counter of request
queue during system resume") fixed a problem in the block layer's
runtime-PM code: blk_set_runtime_active() failed to call
blk_clear_pm_only().  However, the commit's implementation was
awkward; it forced the SCSI system-resume handler to choose whether to
call blk_post_runtime_resume() or blk_set_runtime_active(), depending
on whether or not the SCSI device had previously been runtime
suspended.

This patch simplifies the situation considerably by adding the missing
function call directly into blk_set_runtime_active().  This allows the
SCSI routine to revert back to its original form.  Furthermore, making
this change reveals that blk_post_runtime_resume() (in its success
pathway) does exactly the same thing as blk_set_runtime_active().  The
duplicate code is easily removed by making one routine call the other.

No functional changes are intended.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
CC: Can Guo <cang@codeaurora.org>
CC: Bart Van Assche <bvanassche@acm.org>

---

Martin:

Since you merged the oritinal 05d18ae1cc8a commit, I'm submitting this to 
you as an update.  If you would prefer to have it go by way of the 
block-layer tree, let me know and I'll resend it.


[as1939]


 block/blk-pm.c         |   25 ++++++++++---------------
 drivers/scsi/scsi_pm.c |   10 ++--------
 2 files changed, 12 insertions(+), 23 deletions(-)

Index: usb-devel/block/blk-pm.c
===================================================================
--- usb-devel.orig/block/blk-pm.c
+++ usb-devel/block/blk-pm.c
@@ -164,30 +164,21 @@ EXPORT_SYMBOL(blk_pre_runtime_resume);
  *
  * Description:
  *    Update the queue's runtime status according to the return value of the
- *    device's runtime_resume function. If it is successfully resumed, process
- *    the requests that are queued into the device's queue when it is resuming
- *    and then mark last busy and initiate autosuspend for it.
+ *    device's runtime_resume function. If the resume was successful, call
+ *    blk_set_runtime_active() to do the real work of restarting the queue.
  *
  *    This function should be called near the end of the device's
  *    runtime_resume callback.
  */
 void blk_post_runtime_resume(struct request_queue *q, int err)
 {
-	if (!q->dev)
-		return;
-
-	spin_lock_irq(&q->queue_lock);
 	if (!err) {
-		q->rpm_status = RPM_ACTIVE;
-		pm_runtime_mark_last_busy(q->dev);
-		pm_request_autosuspend(q->dev);
-	} else {
+		blk_set_runtime_active(q);
+	} else if (q->dev) {
+		spin_lock_irq(&q->queue_lock);
 		q->rpm_status = RPM_SUSPENDED;
+		spin_unlock_irq(&q->queue_lock);
 	}
-	spin_unlock_irq(&q->queue_lock);
-
-	if (!err)
-		blk_clear_pm_only(q);
 }
 EXPORT_SYMBOL(blk_post_runtime_resume);
 
@@ -204,6 +195,9 @@ EXPORT_SYMBOL(blk_post_runtime_resume);
  * This function can be used in driver's resume hook to correct queue
  * runtime PM status and re-enable peeking requests from the queue. It
  * should be called before first request is added to the queue.
+ *
+ * This function is also called by blk_post_runtime_resume() for successful
+ * runtime resumes.  It does everything necessary to restart the queue.
  */
 void blk_set_runtime_active(struct request_queue *q)
 {
@@ -213,6 +207,7 @@ void blk_set_runtime_active(struct reque
 		pm_runtime_mark_last_busy(q->dev);
 		pm_request_autosuspend(q->dev);
 		spin_unlock_irq(&q->queue_lock);
+		blk_clear_pm_only(q);
 	}
 }
 EXPORT_SYMBOL(blk_set_runtime_active);
Index: usb-devel/drivers/scsi/scsi_pm.c
===================================================================
--- usb-devel.orig/drivers/scsi/scsi_pm.c
+++ usb-devel/drivers/scsi/scsi_pm.c
@@ -80,10 +80,6 @@ static int scsi_dev_type_resume(struct d
 	dev_dbg(dev, "scsi resume: %d\n", err);
 
 	if (err == 0) {
-		bool was_runtime_suspended;
-
-		was_runtime_suspended = pm_runtime_suspended(dev);
-
 		pm_runtime_disable(dev);
 		err = pm_runtime_set_active(dev);
 		pm_runtime_enable(dev);
@@ -97,10 +93,8 @@ static int scsi_dev_type_resume(struct d
 		 */
 		if (!err && scsi_is_sdev_device(dev)) {
 			struct scsi_device *sdev = to_scsi_device(dev);
-			if (was_runtime_suspended)
-				blk_post_runtime_resume(sdev->request_queue, 0);
-			else
-				blk_set_runtime_active(sdev->request_queue);
+
+			blk_set_runtime_active(sdev->request_queue);
 		}
 	}
 

