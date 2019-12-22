Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7DFF128C84
	for <lists+linux-scsi@lfdr.de>; Sun, 22 Dec 2019 05:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfLVEAC (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 21 Dec 2019 23:00:02 -0500
Received: from smtp.infotech.no ([82.134.31.41]:39898 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726709AbfLVEAB (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 21 Dec 2019 23:00:01 -0500
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 805F9204192;
        Sun, 22 Dec 2019 04:59:59 +0100 (CET)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HcClWlkHLT6K; Sun, 22 Dec 2019 04:59:57 +0100 (CET)
Received: from xtwo70.bingwo.ca (host-23-251-188-50.dyn.295.ca [23.251.188.50])
        by smtp.infotech.no (Postfix) with ESMTPA id 9915F204195;
        Sun, 22 Dec 2019 04:59:56 +0100 (CET)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de
Subject: [RFC 5/6] scsi_debug: improve command duration calculation
Date:   Sat, 21 Dec 2019 22:59:47 -0500
Message-Id: <20191222035948.30447-6-dgilbert@interlog.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191222035948.30447-1-dgilbert@interlog.com>
References: <20191222035948.30447-1-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Previously the code did the work implied by the given SCSI
command and after that it waited for a timer based on the user
specified command duration to be exhausted before informing
the mid-level that the command was complete. For short command
durations the time to complete the work implied by the SCSI
command could be significant compared to the user specified
command duration.

For example a WRITE of 128 blocks (say 512 bytes each) on a
machine that can copy from main memory to main memory at a rate
of 10 GB/sec will take around 6.4 microseconds to do that copy.
If the user specified a command duration of 5 microseconds
(ndelay=5000) should the driver do a further delay of 5
microseconds after the copy or return immediately because
6.4 > 5 ?

The action prior to this patch was to always do the timer based
delay. After this patch, for ndelay values less than 1
millisecond, this driver will complete the command immediately.
And in the case where the user specified delay was 7
microseconds, a timer delay of 600 nanoseconds will be set
((7 - 6.4) * 1000).

Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/scsi_debug.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index a3cb0bc29f81..f60decb06f59 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -4370,6 +4370,8 @@ static void setup_inject(struct sdebug_queue *sqp,
 	sqcp->inj_cmd_abort = !!(SDEBUG_OPT_CMD_ABORT & sdebug_opts);
 }
 
+#define INCLUSIVE_TIMING_MAX_NS 1000000		/* 1 millisecond */
+
 /* Complete the processing of the thread that queued a SCSI command to this
  * driver. It either completes the command by calling cmnd_done() or
  * schedules a hr timer or work queue then returns 0. Returns
@@ -4381,8 +4383,10 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 				    struct sdebug_dev_info *),
 			 int delta_jiff, int ndelay)
 {
-	unsigned long iflags;
+	bool new_sd_dp;
 	int k, num_in_q, qdepth, inject;
+	unsigned long iflags;
+	u64 ns_from_boot = 0;
 	struct sdebug_queue *sqp;
 	struct sdebug_queued_cmd *sqcp;
 	struct scsi_device *sdp;
@@ -4398,7 +4402,6 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 	if (delta_jiff == 0)
 		goto respond_in_thread;
 
-	/* schedule the response at a later time if resources permit */
 	sqp = get_queue(cmnd);
 	spin_lock_irqsave(&sqp->qc_lock, iflags);
 	if (unlikely(atomic_read(&sqp->blocked))) {
@@ -4457,8 +4460,15 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 		sd_dp = kzalloc(sizeof(*sd_dp), GFP_ATOMIC);
 		if (sd_dp == NULL)
 			return SCSI_MLQUEUE_HOST_BUSY;
+		new_sd_dp = true;
+	} else {
+		new_sd_dp = false;
 	}
 
+	if (ndelay > 0 && ndelay < INCLUSIVE_TIMING_MAX_NS)
+		ns_from_boot = ktime_get_boottime_ns();
+
+	/* one of the resp_*() response functions is called here */
 	cmnd->result = pfp != NULL ? pfp(cmnd, devip) : 0;
 	if (cmnd->result & SDEG_RES_IMMED_MASK) {
 		cmnd->result &= ~SDEG_RES_IMMED_MASK;
@@ -4489,6 +4499,22 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 		} else {	/* ndelay has a 4.2 second max */
 			kt = sdebug_random ? prandom_u32_max((u32)ndelay) :
 					     (u32)ndelay;
+			if (ndelay < INCLUSIVE_TIMING_MAX_NS) {
+				u64 d = ktime_get_boottime_ns() - ns_from_boot;
+
+				if (kt <= d) {	/* elapsed duration >= kt */
+					sqcp->a_cmnd = NULL;
+					atomic_dec(&devip->num_in_q);
+					clear_bit(k, sqp->in_use_bm);
+					if (new_sd_dp)
+						kfree(sd_dp);
+					/* call scsi_done() from this thread */
+					cmnd->scsi_done(cmnd);
+					return 0;
+				}
+				/* otherwise reduce kt by elapsed time */
+				kt -= d;
+			}
 		}
 		if (!sd_dp->init_hrt) {
 			sd_dp->init_hrt = true;
@@ -4502,6 +4528,7 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 		if (sdebug_statistics)
 			sd_dp->issuing_cpu = raw_smp_processor_id();
 		sd_dp->defer_t = SDEB_DEFER_HRT;
+		/* schedule the invocation of scsi_done() for a later time */
 		hrtimer_start(&sd_dp->hrt, kt, HRTIMER_MODE_REL_PINNED);
 	} else {	/* jdelay < 0, use work queue */
 		if (!sd_dp->init_wq) {
-- 
2.24.1

