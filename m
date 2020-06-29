Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5475020D3D2
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Jun 2020 21:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730501AbgF2TCW (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 29 Jun 2020 15:02:22 -0400
Received: from netrider.rowland.org ([192.131.102.5]:46731 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1730498AbgF2TCT (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 29 Jun 2020 15:02:19 -0400
Received: (qmail 406595 invoked by uid 1000); 29 Jun 2020 12:15:36 -0400
Date:   Mon, 29 Jun 2020 12:15:36 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     Bart Van Assche <bvanassche@acm.org>, jejb@linux.ibm.com,
        Can Guo <cang@codeaurora.org>, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm
Subject: Re: [PATCH] scsi: sd: add runtime pm to open / release
Message-ID: <20200629161536.GA405175@rowland.harvard.edu>
References: <20200623111018.31954-1-martin.kepplinger@puri.sm>
 <ed9ae198-4c68-f82b-04fc-2299ab16df96@acm.org>
 <eccacce9-393c-ca5d-e3b3-09961340e0db@puri.sm>
 <1379e21d-c51a-3710-e185-c2d7a9681fb7@acm.org>
 <20200626154441.GA296771@rowland.harvard.edu>
 <c19f1938-ae47-2357-669d-5b4021aec154@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c19f1938-ae47-2357-669d-5b4021aec154@puri.sm>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, Jun 29, 2020 at 11:42:59AM +0200, Martin Kepplinger wrote:
> 
> 
> On 26.06.20 17:44, Alan Stern wrote:
> > Martin's best approach would be to add some debugging code to find out why 
> > blk_queue_enter() isn't calling bkl_pm_request_resume(), or why that call 
> > doesn't lead to pm_request_resume().
> > 
> > Alan Stern
> > 
> 
> Hi Alan,
> 
> blk_queue_enter() always - especially when sd is runtime suspended and I
> try to mount as above - sets success to be true for me, so never
> continues down to bkl_pm_request_resume(). All I see is "PM: Removing
> info for No Bus:sda1".

Aha.  Looking at this more closely, it's apparent that the code in 
blk-core.c contains a logic bug: It assumes that if the BLK_MQ_REQ_PREEMPT 
flag is set then the request can be issued regardless of the queue's 
runtime status.  That is not correct when the queue is suspended.

Below is my attempt to fix this up.  I'm not sure that the patch is 
entirely correct, but it should fix this logic bug.  I would appreciate a 
critical review.

Martin, does this fix the problem?

Alan Stern



Index: usb-devel/block/blk-core.c
===================================================================
--- usb-devel.orig/block/blk-core.c
+++ usb-devel/block/blk-core.c
@@ -423,7 +423,8 @@ int blk_queue_enter(struct request_queue
 			 * responsible for ensuring that that counter is
 			 * globally visible before the queue is unfrozen.
 			 */
-			if (pm || !blk_queue_pm_only(q)) {
+			if ((pm && q->rpm_status != RPM_SUSPENDED) ||
+			    !blk_queue_pm_only(q)) {
 				success = true;
 			} else {
 				percpu_ref_put(&q->q_usage_counter);
@@ -448,8 +449,7 @@ int blk_queue_enter(struct request_queue
 
 		wait_event(q->mq_freeze_wq,
 			   (!q->mq_freeze_depth &&
-			    (pm || (blk_pm_request_resume(q),
-				    !blk_queue_pm_only(q)))) ||
+			    blk_pm_resume_queue(pm, q)) ||
 			   blk_queue_dying(q));
 		if (blk_queue_dying(q))
 			return -ENODEV;
Index: usb-devel/block/blk-pm.h
===================================================================
--- usb-devel.orig/block/blk-pm.h
+++ usb-devel/block/blk-pm.h
@@ -6,11 +6,14 @@
 #include <linux/pm_runtime.h>
 
 #ifdef CONFIG_PM
-static inline void blk_pm_request_resume(struct request_queue *q)
+static inline int blk_pm_resume_queue(const bool pm, struct request_queue *q)
 {
-	if (q->dev && (q->rpm_status == RPM_SUSPENDED ||
-		       q->rpm_status == RPM_SUSPENDING))
-		pm_request_resume(q->dev);
+	if (!q->dev || !blk_queue_pm_only(q))
+		return 1;	/* Nothing to do */
+	if (pm && q->rpm_status != RPM_SUSPENDED)
+		return 1;	/* Request allowed */
+	pm_request_resume(q->dev);
+	return 0;
 }
 
 static inline void blk_pm_mark_last_busy(struct request *rq)
@@ -44,8 +47,9 @@ static inline void blk_pm_put_request(st
 		--rq->q->nr_pending;
 }
 #else
-static inline void blk_pm_request_resume(struct request_queue *q)
+static inline int blk_pm_resume_queue(const bool pm, struct request_queue *q)
 {
+	return 1;
 }
 
 static inline void blk_pm_mark_last_busy(struct request *rq)
