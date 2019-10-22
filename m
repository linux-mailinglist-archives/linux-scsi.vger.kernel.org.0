Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D21BE0C50
	for <lists+linux-scsi@lfdr.de>; Tue, 22 Oct 2019 21:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732975AbfJVTM3 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 22 Oct 2019 15:12:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:43484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732960AbfJVTM1 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 22 Oct 2019 15:12:27 -0400
Received: from localhost.localdomain (rrcs-50-75-166-42.nys.biz.rr.com [50.75.166.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23DD121872;
        Tue, 22 Oct 2019 19:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571771546;
        bh=NK1shrnB6RXACQmIToR2eAdSTsYyqi7EfbzoHBlz3kE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SUpRZkNozB0RJAm3MGvuAjFVVOn+KxxVuGRNznokxXvR/WahJ0ftDqSYZ5/+OmMUH
         rFJJ7DJuALzjWIluBdaA1zThESMt85t6Sy0V4EYQ05JCfbK0BKRphZ9IVUxtL1X3ac
         ROdbp79PVROJlZhyi5NKFY65XDBkshw2H+8+Z5Xc=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH tip/core/rcu 04/10] drivers/scsi: Replace rcu_swap_protected() with rcu_replace()
Date:   Tue, 22 Oct 2019 12:12:09 -0700
Message-Id: <20191022191215.25781-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191022191136.GA25627@paulmck-ThinkPad-P72>
References: <20191022191136.GA25627@paulmck-ThinkPad-P72>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit replaces the use of rcu_swap_protected() with the more
intuitively appealing rcu_replace() as a step towards removing
rcu_swap_protected().

Link: https://lore.kernel.org/lkml/CAHk-=wiAsJLw1egFEE=Z7-GGtM6wcvtyytXZA1+BHqta4gg6Hw@mail.gmail.com/
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
[ paulmck: From rcu_replace() to rcu_replace_pointer() per Ingo Molnar. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Acked-by: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: <linux-scsi@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
---
 drivers/scsi/scsi.c       | 4 ++--
 drivers/scsi/scsi_sysfs.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 1f5b5c8..7a1b6c7 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -434,8 +434,8 @@ static void scsi_update_vpd_page(struct scsi_device *sdev, u8 page,
 		return;
 
 	mutex_lock(&sdev->inquiry_mutex);
-	rcu_swap_protected(*sdev_vpd_buf, vpd_buf,
-			   lockdep_is_held(&sdev->inquiry_mutex));
+	vpd_buf = rcu_replace_pointer(*sdev_vpd_buf, vpd_buf,
+				      lockdep_is_held(&sdev->inquiry_mutex));
 	mutex_unlock(&sdev->inquiry_mutex);
 
 	if (vpd_buf)
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 64c96c7..5adfcab 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -466,10 +466,10 @@ static void scsi_device_dev_release_usercontext(struct work_struct *work)
 	sdev->request_queue = NULL;
 
 	mutex_lock(&sdev->inquiry_mutex);
-	rcu_swap_protected(sdev->vpd_pg80, vpd_pg80,
-			   lockdep_is_held(&sdev->inquiry_mutex));
-	rcu_swap_protected(sdev->vpd_pg83, vpd_pg83,
-			   lockdep_is_held(&sdev->inquiry_mutex));
+	vpd_pg80 = rcu_replace_pointer(sdev->vpd_pg80, vpd_pg80,
+				       lockdep_is_held(&sdev->inquiry_mutex));
+	vpd_pg83 = rcu_replace_pointer(sdev->vpd_pg83, vpd_pg83,
+				       lockdep_is_held(&sdev->inquiry_mutex));
 	mutex_unlock(&sdev->inquiry_mutex);
 
 	if (vpd_pg83)
-- 
2.9.5

