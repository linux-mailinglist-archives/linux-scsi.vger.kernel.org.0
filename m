Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59194FB1B7
	for <lists+linux-scsi@lfdr.de>; Mon, 11 Apr 2022 04:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243666AbiDKCbV (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 10 Apr 2022 22:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244036AbiDKCbM (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 10 Apr 2022 22:31:12 -0400
Received: from smtp.infotech.no (smtp.infotech.no [82.134.31.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B2FDC387A8
        for <linux-scsi@vger.kernel.org>; Sun, 10 Apr 2022 19:28:54 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 4399D2041CE;
        Mon, 11 Apr 2022 04:28:54 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XUDrmuO906QB; Mon, 11 Apr 2022 04:28:52 +0200 (CEST)
Received: from xtwo70.bingwo.ca (host-45-78-195-155.dyn.295.ca [45.78.195.155])
        by smtp.infotech.no (Postfix) with ESMTPA id BC44D2041E3;
        Mon, 11 Apr 2022 04:28:49 +0200 (CEST)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        bvanassche@acm.org, Hannes Reinecke <hare@suse.com>
Subject: [PATCH v24 08/46] sg: speed sg_poll and sg_get_num_waiting
Date:   Sun, 10 Apr 2022 22:27:58 -0400
Message-Id: <20220411022836.11871-9-dgilbert@interlog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220411022836.11871-1-dgilbert@interlog.com>
References: <20220411022836.11871-1-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Track the number of submitted and waiting (for read/receive)
requests on each file descriptor with two atomic integers.
This speeds sg_poll() and ioctl(SG_GET_NUM_WAITING) which
are oft used with the asynchronous (non-blocking) interfaces.

Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/sg.c | 54 +++++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 83646e290bf4..c5c82559d065 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -147,6 +147,8 @@ struct sg_fd {		/* holds the state of a file descriptor */
 	struct mutex f_mutex;	/* protect against changes in this fd */
 	int timeout;		/* defaults to SG_DEFAULT_TIMEOUT      */
 	int timeout_user;	/* defaults to SG_DEFAULT_TIMEOUT_USER */
+	atomic_t submitted;	/* number inflight or awaiting read */
+	atomic_t waiting;	/* number of requests awaiting read */
 	struct sg_scatter_hold reserve;	/* buffer for this file descriptor */
 	struct list_head rq_list; /* head of request list */
 	struct fasync_struct *async_qp;	/* used by asynchronous notification */
@@ -684,6 +686,8 @@ sg_common_write(struct sg_fd *sfp, struct sg_request *srp,
 	else
 		at_head = 1;
 
+	if (!blocking)
+		atomic_inc(&sfp->submitted);
 	srp->rq->timeout = timeout;
 	kref_get(&sfp->f_ref); /* sg_rq_end_io() does kref_put(). */
 	blk_execute_rq_nowait(srp->rq, at_head, sg_rq_end_io);
@@ -1106,14 +1110,7 @@ sg_ioctl_common(struct file *filp, struct sg_device *sdp, struct sg_fd *sfp,
 		read_unlock_irqrestore(&sfp->rq_list_lock, iflags);
 		return put_user(-1, ip);
 	case SG_GET_NUM_WAITING:
-		read_lock_irqsave(&sfp->rq_list_lock, iflags);
-		val = 0;
-		list_for_each_entry(srp, &sfp->rq_list, entry) {
-			if ((1 == srp->done) && (!srp->sg_io_owned))
-				++val;
-		}
-		read_unlock_irqrestore(&sfp->rq_list_lock, iflags);
-		return put_user(val, ip);
+		return put_user(atomic_read(&sfp->waiting), ip);
 	case SG_GET_SG_TABLESIZE:
 		return put_user(sdp->max_sgat_elems, ip);
 	case SG_SET_RESERVED_SIZE:
@@ -1261,35 +1258,26 @@ sg_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
 	return scsi_ioctl(sdp->device, filp->f_mode, cmd_in, p);
 }
 
+/*
+ * Implements the poll(2) system call for this driver. Returns various EPOLL*
+ * flags OR-ed together.
+ */
 static __poll_t
 sg_poll(struct file *filp, poll_table * wait)
 {
 	__poll_t p_res = 0;
 	struct sg_fd *sfp = filp->private_data;
-	struct sg_request *srp;
-	int count = 0;
-	unsigned long iflags;
 
-	if (!sfp)
-		return EPOLLERR;
 	poll_wait(filp, &sfp->read_wait, wait);
-	read_lock_irqsave(&sfp->rq_list_lock, iflags);
-	list_for_each_entry(srp, &sfp->rq_list, entry) {
-		/* if any read waiting, flag it */
-		if (p_res == 0 && srp->done == 1 && !srp->sg_io_owned)
-			p_res = EPOLLIN | EPOLLRDNORM;
-		++count;
-	}
-	read_unlock_irqrestore(&sfp->rq_list_lock, iflags);
+	if (atomic_read(&sfp->waiting) > 0)
+		p_res = EPOLLIN | EPOLLRDNORM;
 
-	if (sfp->parentdp && SG_IS_DETACHING(sfp->parentdp)) {
+	if (unlikely(SG_IS_DETACHING(sfp->parentdp)))
 		p_res |= EPOLLHUP;
-	} else if (!sfp->cmd_q) {
-		if (count == 0)
-			p_res |= EPOLLOUT | EPOLLWRNORM;
-	} else if (count < SG_MAX_QUEUE) {
+	else if (likely(sfp->cmd_q))
+		p_res |= EPOLLOUT | EPOLLWRNORM;
+	else if (atomic_read(&sfp->submitted) == 0)
 		p_res |= EPOLLOUT | EPOLLWRNORM;
-	}
 	SG_LOG(3, sfp, "%s: p_res=0x%x\n", __func__, (__force u32)p_res);
 	return p_res;
 }
@@ -1474,6 +1462,8 @@ sg_rq_end_io(struct request *rq, blk_status_t status)
 
 	/* Rely on write phase to clean out srp status values, so no "else" */
 
+	if (!srp->sg_io_owned)
+		atomic_inc(&sfp->waiting);
 	/*
 	 * Free the request as soon as it is complete so that its resources
 	 * can be reused without waiting for userspace to read() the
@@ -1942,6 +1932,10 @@ sg_finish_rem_req(struct sg_request *srp)
 
 	SG_LOG(4, sfp, "%s: srp=0x%p%s\n", __func__, srp,
 	       (srp->res_used) ? " rsv" : "");
+	if (!srp->sg_io_owned) {
+		atomic_dec(&sfp->submitted);
+		atomic_dec(&sfp->waiting);
+	}
 	if (srp->bio)
 		ret = blk_rq_unmap_user(srp->bio);
 
@@ -2233,6 +2227,9 @@ sg_add_sfp(struct sg_device *sdp)
 	sfp->cmd_q = SG_DEF_COMMAND_Q;
 	sfp->keep_orphan = SG_DEF_KEEP_ORPHAN;
 	sfp->parentdp = sdp;
+	atomic_set(&sfp->submitted, 0);
+	atomic_set(&sfp->waiting, 0);
+
 	write_lock_irqsave(&sdp->sfd_lock, iflags);
 	if (SG_IS_DETACHING(sdp)) {
 		write_unlock_irqrestore(&sdp->sfd_lock, iflags);
@@ -2603,6 +2600,9 @@ sg_proc_debug_helper(struct seq_file *s, struct sg_device *sdp)
 		seq_printf(s, "   cmd_q=%d f_packid=%d k_orphan=%d closed=0\n",
 			   (int) fp->cmd_q, (int) fp->force_packid,
 			   (int) fp->keep_orphan);
+		seq_printf(s, "   submitted=%d waiting=%d\n",
+			   atomic_read(&fp->submitted),
+			   atomic_read(&fp->waiting));
 		list_for_each_entry(srp, &fp->rq_list, entry) {
 			hp = &srp->header;
 			new_interface = (hp->interface_id == '\0') ? 0 : 1;
-- 
2.25.1

