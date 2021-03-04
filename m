Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA2732CA1E
	for <lists+linux-scsi@lfdr.de>; Thu,  4 Mar 2021 02:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbhCDBmX (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 3 Mar 2021 20:42:23 -0500
Received: from smtp.infotech.no ([82.134.31.41]:34000 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232812AbhCDBmB (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 3 Mar 2021 20:42:01 -0500
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 6CD4A20419D;
        Thu,  4 Mar 2021 02:41:18 +0100 (CET)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gN7ILcwFLdon; Thu,  4 Mar 2021 02:41:10 +0100 (CET)
Received: from xtwo70.bingwo.ca (host-45-58-219-4.dyn.295.ca [45.58.219.4])
        by smtp.infotech.no (Postfix) with ESMTPA id E89B520418C;
        Thu,  4 Mar 2021 02:41:09 +0100 (CET)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        kashyap.desai@broadcom.com
Subject: [PATCH] scsi_debug: iopoll: fix cmd duration calc
Date:   Wed,  3 Mar 2021 20:41:07 -0500
Message-Id: <20210304014107.307625-1-dgilbert@interlog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

In some cases, sdebug_defer::cmpl_ts (completion timestamp) wasn't
being properly set when REQ_HIPRI was given. Fix that and improve
code to only call ktime_get_boottime_ns() for commands with
REQ_HIPRI set as cmpl_ts is only used in that case.

Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---

This patch is a correction on top off this patchset:
   [PATCH v4 0/5] io_uring iopoll in scsi layer
by Kashyap Desai sent to the linux-scsi list on 20210215

 drivers/scsi/scsi_debug.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index c50de49a2c2f..0eb2dd445d5c 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -5367,6 +5367,7 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 {
 	bool new_sd_dp;
 	bool inject = false;
+	bool hipri = (cmnd->request->cmd_flags & REQ_HIPRI);
 	int k, num_in_q, qdepth;
 	unsigned long iflags;
 	u64 ns_from_boot = 0;
@@ -5453,7 +5454,7 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 	if (sdebug_host_max_queue)
 		sd_dp->hc_idx = get_tag(cmnd);
 
-	if (ndelay > 0 && ndelay < INCLUSIVE_TIMING_MAX_NS)
+	if (hipri)
 		ns_from_boot = ktime_get_boottime_ns();
 
 	/* one of the resp_*() response functions is called here */
@@ -5513,8 +5514,8 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 				kt -= d;
 			}
 		}
-		sd_dp->cmpl_ts = ktime_add(ns_to_ktime(ns_from_boot), kt);
-		if (cmnd->request->cmd_flags & REQ_HIPRI) {
+		if (hipri) {
+			sd_dp->cmpl_ts = ktime_add(ns_to_ktime(ns_from_boot), kt);
 			spin_lock_irqsave(&sqp->qc_lock, iflags);
 			if (!sd_dp->init_poll) {
 				sd_dp->init_poll = true;
@@ -5544,8 +5545,8 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 		if (unlikely((sdebug_opts & SDEBUG_OPT_CMD_ABORT) &&
 			     atomic_read(&sdeb_inject_pending)))
 			sd_dp->aborted = true;
-		sd_dp->cmpl_ts = ns_to_ktime(ns_from_boot);
-		if (cmnd->request->cmd_flags & REQ_HIPRI) {
+		if (hipri) {
+			sd_dp->cmpl_ts = ns_to_ktime(ns_from_boot);
 			spin_lock_irqsave(&sqp->qc_lock, iflags);
 			if (!sd_dp->init_poll) {
 				sd_dp->init_poll = true;
-- 
2.25.1

