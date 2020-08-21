Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4C324D8F3
	for <lists+linux-scsi@lfdr.de>; Fri, 21 Aug 2020 17:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgHUPmx (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 21 Aug 2020 11:42:53 -0400
Received: from smtp.infotech.no ([82.134.31.41]:48334 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728008AbgHUPmX (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 21 Aug 2020 11:42:23 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id CD249204248;
        Fri, 21 Aug 2020 17:42:15 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id F5TEOiLB0ChM; Fri, 21 Aug 2020 17:42:14 +0200 (CEST)
Received: from xtwo70.bingwo.ca (host-45-78-251-166.dyn.295.ca [45.78.251.166])
        by smtp.infotech.no (Postfix) with ESMTPA id 68A9A204155;
        Fri, 21 Aug 2020 17:42:13 +0200 (CEST)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        john.garry@huawei.com
Subject: [PATCH v6 06/10] scsi: avoid pointless memory allocation in scsi_alloc_target()
Date:   Fri, 21 Aug 2020 11:42:00 -0400
Message-Id: <20200821154204.9298-7-dgilbert@interlog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821154204.9298-1-dgilbert@interlog.com>
References: <20200821154204.9298-1-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Hannes Reinecke <hare@suse.de>

As we already know the index of the requested target in
scsi_alloc_target() we can try to fetch it first before trying
to allocate a new one. This will save us a pointless memory
allocation in case the target is already present and uncontended.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/scsi_scan.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index 8afb71c036d5..41818111808e 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -387,7 +387,7 @@ static void scsi_target_reap_ref_put(struct scsi_target *starget)
  * is responsible for both reaping and doing a last put
  */
 static struct scsi_target *scsi_alloc_target(struct device *parent,
-					     int channel, uint id)
+					     u16 channel, u16 id)
 {
 	struct Scsi_Host *shost = dev_to_shost(parent);
 	struct device *dev = NULL;
@@ -397,7 +397,23 @@ static struct scsi_target *scsi_alloc_target(struct device *parent,
 	struct scsi_target *starget;
 	struct scsi_target *found_target;
 	int error, ref_got;
-	unsigned long tid;
+	unsigned long tid = (channel << 16) | id;
+
+	/*
+	 * Try if the target is already present, and save us
+	 * a pointless memory allocation if so.
+	 */
+	spin_lock_irqsave(shost->host_lock, flags);
+	found_target = xa_load(&shost->__targets, tid);
+	if (found_target) {
+		get_device(&found_target->dev);
+		if (kref_get_unless_zero(&found_target->reap_ref)) {
+			spin_unlock_irqrestore(shost->host_lock, flags);
+			return found_target;
+		}
+		put_device(&found_target->dev);
+	}
+	spin_unlock_irqrestore(shost->host_lock, flags);
 
 	starget = kzalloc(size, GFP_KERNEL);
 	if (!starget) {
@@ -418,7 +434,6 @@ static struct scsi_target *scsi_alloc_target(struct device *parent,
 	starget->state = STARGET_CREATED;
 	starget->scsi_level = SCSI_2;
 	starget->max_target_blocked = SCSI_DEFAULT_TARGET_BLOCKED;
-	tid = scsi_target_index(starget);
  retry:
 	spin_lock_irqsave(shost->host_lock, flags);
 	found_target = xa_load(&shost->__targets, tid);
-- 
2.25.1

