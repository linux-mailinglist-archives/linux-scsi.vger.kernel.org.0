Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0321B2B3BA7
	for <lists+linux-scsi@lfdr.de>; Mon, 16 Nov 2020 04:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgKPDF1 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 15 Nov 2020 22:05:27 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44591 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbgKPDF1 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 15 Nov 2020 22:05:27 -0500
Received: by mail-pl1-f196.google.com with SMTP id b3so7648412pls.11;
        Sun, 15 Nov 2020 19:05:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qRKRjS62RKtDoHWQs4RID8UCcBBixKzfvMA3W55OBZ0=;
        b=PFvukmo0NJn+eVTIbS9NSou4q7HvvA1aNHLi4BXjXqDDYfRwdMfvmSb4A1U9i8rK/N
         xlhtgwWsakV0Z8z2NkpyKmBD1zP3GGjVhUkTfAeZQy96igw6g0OC35tS5F2/H/Fynv9Q
         73yppVEkv7dkqUEzfnRZH76xGhSRB9HRhzYQMctJBfbsPNy1SvzYRFk7XW79QD4ST8Nb
         PTo3apQFA+7uWFz4DxIgFPQB/7/ECbUbi968QLIcmWhxBiP+wIR/4TfBOIqRxH3BWe7K
         fhoWgGqoY166Y6sPchY6bm0uvF2Oh8UHkk69Trd346vyhAX/jDWdRvVuofvJi/rz2Bwn
         0UFg==
X-Gm-Message-State: AOAM532xwNSu6Z2ckGcQnOTmP1/q1rKrczihnNBmJB9r5zwvyarJQWww
        dJM+UuMdhg/5QOEJ7jpyNVs=
X-Google-Smtp-Source: ABdhPJxQOrZRBaKFIsiabwJFhagwWIEM6IkIfozTICIcENxpdTCCM5dKaESke61vHRatnCMNV5iqaA==
X-Received: by 2002:a17:902:aa06:b029:d6:da66:5048 with SMTP id be6-20020a170902aa06b02900d6da665048mr11772296plb.5.1605495926223;
        Sun, 15 Nov 2020 19:05:26 -0800 (PST)
Received: from asus.hsd1.ca.comcast.net (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id r3sm17148131pjl.23.2020.11.15.19.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 19:05:25 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Can Guo <cang@codeaurora.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Ming Lei <ming.lei@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v2 9/9] block: Do not accept any requests while suspended
Date:   Sun, 15 Nov 2020 19:04:59 -0800
Message-Id: <20201116030459.13963-10-bvanassche@acm.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116030459.13963-1-bvanassche@acm.org>
References: <20201116030459.13963-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

blk_queue_enter() accepts BLK_MQ_REQ_PREEMPT independent of the runtime
power management state. Since SCSI domain validation no longer depends on
this behavior, modify the behavior of blk_queue_enter() as follows:
- Do not accept any requests while suspended.
- Only process power management requests while suspending or resuming.

Submitting BLK_MQ_REQ_PREEMPT requests to a device that is runtime-
suspended causes runtime-suspended block devices not to resume as they
should. The request which should cause a runtime resume instead gets
issued directly, without resuming the device first. Of course the device
can't handle it properly, the I/O fails, and the device remains suspended.

The problem is fixed by checking that the queue's runtime-PM status
isn't RPM_SUSPENDED before allowing a request to be issued, and
queuing a runtime-resume request if it is.  In particular, the inline
blk_pm_request_resume() routine is renamed blk_pm_resume_queue() and
the code is unified by merging the surrounding checks into the
routine.  If the queue isn't set up for runtime PM, or there currently
is no restriction on allowed requests, the request is allowed.
Likewise if the BLK_MQ_REQ_PREEMPT flag is set and the status isn't
RPM_SUSPENDED.  Otherwise a runtime resume is queued and the request
is blocked until conditions are more suitable.

Cc: Can Guo <cang@codeaurora.org>
Cc: Stanley Chu <stanley.chu@mediatek.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reported-and-tested-by: Martin Kepplinger <martin.kepplinger@puri.sm>
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
[ bvanassche: modified commit message and removed Cc: stable because without
  the previous patches from this series this patch would break parallel SCSI
  domain validation ]
---
 block/blk-core.c |  6 +++---
 block/blk-pm.h   | 14 +++++++++-----
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index a00bce9f46d8..230880cbf8c8 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -440,7 +440,8 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 			 * responsible for ensuring that that counter is
 			 * globally visible before the queue is unfrozen.
 			 */
-			if (pm || !blk_queue_pm_only(q)) {
+			if ((pm && q->rpm_status != RPM_SUSPENDED) ||
+			    !blk_queue_pm_only(q)) {
 				success = true;
 			} else {
 				percpu_ref_put(&q->q_usage_counter);
@@ -465,8 +466,7 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 
 		wait_event(q->mq_freeze_wq,
 			   (!q->mq_freeze_depth &&
-			    (pm || (blk_pm_request_resume(q),
-				    !blk_queue_pm_only(q)))) ||
+			    blk_pm_resume_queue(pm, q)) ||
 			   blk_queue_dying(q));
 		if (blk_queue_dying(q))
 			return -ENODEV;
diff --git a/block/blk-pm.h b/block/blk-pm.h
index ea5507d23e75..a2283cc9f716 100644
--- a/block/blk-pm.h
+++ b/block/blk-pm.h
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
@@ -44,8 +47,9 @@ static inline void blk_pm_put_request(struct request *rq)
 		--rq->q->nr_pending;
 }
 #else
-static inline void blk_pm_request_resume(struct request_queue *q)
+static inline int blk_pm_resume_queue(const bool pm, struct request_queue *q)
 {
+	return 1;
 }
 
 static inline void blk_pm_mark_last_busy(struct request *rq)
