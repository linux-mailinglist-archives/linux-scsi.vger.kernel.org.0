Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7DCD40CFAE
	for <lists+linux-scsi@lfdr.de>; Thu, 16 Sep 2021 00:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbhIOWn1 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 15 Sep 2021 18:43:27 -0400
Received: from smtp.infotech.no ([82.134.31.41]:36527 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233213AbhIOWmt (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 15 Sep 2021 18:42:49 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id E092F20423B;
        Thu, 16 Sep 2021 00:33:17 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Z4sUn7f3vJYu; Thu, 16 Sep 2021 00:33:15 +0200 (CEST)
Received: from xtwo70.bingwo.ca (host-45-78-207-107.dyn.295.ca [45.78.207.107])
        by smtp.infotech.no (Postfix) with ESMTPA id 4118A2041BB;
        Thu, 16 Sep 2021 00:33:11 +0200 (CEST)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        Damien.LeMoal@wdc.com
Subject: [PATCH v20 11/46] sg: change rwlock to spinlock
Date:   Wed, 15 Sep 2021 18:32:30 -0400
Message-Id: <20210915223305.256429-12-dgilbert@interlog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210915223305.256429-1-dgilbert@interlog.com>
References: <20210915223305.256429-1-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

A reviewer suggested that the extra overhead associated with a
rw lock compared to a spinlock was not worth it for short,
oft-used critcal sections.

So the rwlock on the request list/array is changed to a spinlock.
The head of that list is in the owning sf file descriptor object.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/sg.c | 58 +++++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 46d77cde2143..3619d6bf970f 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -139,7 +139,7 @@ struct sg_fd {		/* holds the state of a file descriptor */
 	struct list_head sfd_entry;	/* member sg_device::sfds list */
 	struct sg_device *parentdp;	/* owning device */
 	wait_queue_head_t read_wait;	/* queue read until command done */
-	rwlock_t rq_list_lock;	/* protect access to list in req_arr */
+	spinlock_t rq_list_lock;	/* protect access to list in req_arr */
 	struct mutex f_mutex;	/* protect against changes in this fd */
 	int timeout;		/* defaults to SG_DEFAULT_TIMEOUT      */
 	int timeout_user;	/* defaults to SG_DEFAULT_TIMEOUT_USER */
@@ -741,17 +741,17 @@ sg_get_rq_mark(struct sg_fd *sfp, int pack_id)
 	struct sg_request *resp;
 	unsigned long iflags;
 
-	write_lock_irqsave(&sfp->rq_list_lock, iflags);
+	spin_lock_irqsave(&sfp->rq_list_lock, iflags);
 	list_for_each_entry(resp, &sfp->rq_list, entry) {
 		/* look for requests that are ready + not SG_IO owned */
 		if (resp->done == 1 && !resp->sg_io_owned &&
 		    (-1 == pack_id || resp->header.pack_id == pack_id)) {
 			resp->done = 2;	/* guard against other readers */
-			write_unlock_irqrestore(&sfp->rq_list_lock, iflags);
+			spin_unlock_irqrestore(&sfp->rq_list_lock, iflags);
 			return resp;
 		}
 	}
-	write_unlock_irqrestore(&sfp->rq_list_lock, iflags);
+	spin_unlock_irqrestore(&sfp->rq_list_lock, iflags);
 	return NULL;
 }
 
@@ -806,9 +806,9 @@ srp_done(struct sg_fd *sfp, struct sg_request *srp)
 	unsigned long flags;
 	int ret;
 
-	read_lock_irqsave(&sfp->rq_list_lock, flags);
+	spin_lock_irqsave(&sfp->rq_list_lock, flags);
 	ret = srp->done;
-	read_unlock_irqrestore(&sfp->rq_list_lock, flags);
+	spin_unlock_irqrestore(&sfp->rq_list_lock, flags);
 	return ret;
 }
 
@@ -1074,15 +1074,15 @@ sg_ioctl_common(struct file *filp, struct sg_device *sdp, struct sg_fd *sfp,
 			(srp_done(sfp, srp) || SG_IS_DETACHING(sdp)));
 		if (SG_IS_DETACHING(sdp))
 			return -ENODEV;
-		write_lock_irq(&sfp->rq_list_lock);
+		spin_lock_irq(&sfp->rq_list_lock);
 		if (srp->done) {
 			srp->done = 2;
-			write_unlock_irq(&sfp->rq_list_lock);
+			spin_unlock_irq(&sfp->rq_list_lock);
 			result = sg_new_read(sfp, p, SZ_SG_IO_HDR, srp);
 			return (result < 0) ? result : 0;
 		}
 		srp->orphan = 1;
-		write_unlock_irq(&sfp->rq_list_lock);
+		spin_unlock_irq(&sfp->rq_list_lock);
 		return result;	/* -ERESTARTSYS because signal hit process */
 	case SG_SET_TIMEOUT:
 		result = get_user(val, ip);
@@ -1134,15 +1134,15 @@ sg_ioctl_common(struct file *filp, struct sg_device *sdp, struct sg_fd *sfp,
 		sfp->force_packid = val ? 1 : 0;
 		return 0;
 	case SG_GET_PACK_ID:
-		read_lock_irqsave(&sfp->rq_list_lock, iflags);
+		spin_lock_irqsave(&sfp->rq_list_lock, iflags);
 		list_for_each_entry(srp, &sfp->rq_list, entry) {
 			if ((1 == srp->done) && (!srp->sg_io_owned)) {
-				read_unlock_irqrestore(&sfp->rq_list_lock,
+				spin_unlock_irqrestore(&sfp->rq_list_lock,
 						       iflags);
 				return put_user(srp->header.pack_id, ip);
 			}
 		}
-		read_unlock_irqrestore(&sfp->rq_list_lock, iflags);
+		spin_unlock_irqrestore(&sfp->rq_list_lock, iflags);
 		return put_user(-1, ip);
 	case SG_GET_NUM_WAITING:
 		return put_user(atomic_read(&sfp->waiting), ip);
@@ -1211,9 +1211,9 @@ sg_ioctl_common(struct file *filp, struct sg_device *sdp, struct sg_fd *sfp,
 					GFP_KERNEL);
 			if (!rinfo)
 				return -ENOMEM;
-			read_lock_irqsave(&sfp->rq_list_lock, iflags);
+			spin_lock_irqsave(&sfp->rq_list_lock, iflags);
 			sg_fill_request_table(sfp, rinfo);
-			read_unlock_irqrestore(&sfp->rq_list_lock, iflags);
+			spin_unlock_irqrestore(&sfp->rq_list_lock, iflags);
 	#ifdef CONFIG_COMPAT
 			if (in_compat_syscall())
 				result = put_compat_request_table(p, rinfo);
@@ -1509,7 +1509,7 @@ sg_rq_end_io(struct request *rq, blk_status_t status)
 	scsi_req_free_cmd(scsi_req(rq));
 	blk_put_request(rq);
 
-	write_lock_irqsave(&sfp->rq_list_lock, iflags);
+	spin_lock_irqsave(&sfp->rq_list_lock, iflags);
 	if (unlikely(srp->orphan)) {
 		if (sfp->keep_orphan)
 			srp->sg_io_owned = 0;
@@ -1517,7 +1517,7 @@ sg_rq_end_io(struct request *rq, blk_status_t status)
 			done = 0;
 	}
 	srp->done = done;
-	write_unlock_irqrestore(&sfp->rq_list_lock, iflags);
+	spin_unlock_irqrestore(&sfp->rq_list_lock, iflags);
 
 	if (likely(done)) {
 		/* Now wake up any sg_read() that is waiting for this
@@ -2173,7 +2173,7 @@ sg_setup_req(struct sg_fd *sfp)
 	unsigned long iflags;
 	struct sg_request *rp = sfp->req_arr;
 
-	write_lock_irqsave(&sfp->rq_list_lock, iflags);
+	spin_lock_irqsave(&sfp->rq_list_lock, iflags);
 	if (!list_empty(&sfp->rq_list)) {
 		if (!sfp->cmd_q)
 			goto out_unlock;
@@ -2189,10 +2189,10 @@ sg_setup_req(struct sg_fd *sfp)
 	rp->parentfp = sfp;
 	rp->header.duration = jiffies_to_msecs(jiffies);
 	list_add_tail(&rp->entry, &sfp->rq_list);
-	write_unlock_irqrestore(&sfp->rq_list_lock, iflags);
+	spin_unlock_irqrestore(&sfp->rq_list_lock, iflags);
 	return rp;
 out_unlock:
-	write_unlock_irqrestore(&sfp->rq_list_lock, iflags);
+	spin_unlock_irqrestore(&sfp->rq_list_lock, iflags);
 	return NULL;
 }
 
@@ -2205,13 +2205,13 @@ sg_remove_request(struct sg_fd *sfp, struct sg_request *srp)
 
 	if (!sfp || !srp || list_empty(&sfp->rq_list))
 		return res;
-	write_lock_irqsave(&sfp->rq_list_lock, iflags);
+	spin_lock_irqsave(&sfp->rq_list_lock, iflags);
 	if (!list_empty(&srp->entry)) {
 		list_del(&srp->entry);
 		srp->parentfp = NULL;
 		res = 1;
 	}
-	write_unlock_irqrestore(&sfp->rq_list_lock, iflags);
+	spin_unlock_irqrestore(&sfp->rq_list_lock, iflags);
 	return res;
 }
 
@@ -2227,7 +2227,7 @@ sg_add_sfp(struct sg_device *sdp)
 		return ERR_PTR(-ENOMEM);
 
 	init_waitqueue_head(&sfp->read_wait);
-	rwlock_init(&sfp->rq_list_lock);
+	spin_lock_init(&sfp->rq_list_lock);
 	INIT_LIST_HEAD(&sfp->rq_list);
 	kref_init(&sfp->f_ref);
 	mutex_init(&sfp->f_mutex);
@@ -2272,14 +2272,14 @@ sg_remove_sfp_usercontext(struct work_struct *work)
 	unsigned long iflags;
 
 	/* Cleanup any responses which were never read(). */
-	write_lock_irqsave(&sfp->rq_list_lock, iflags);
+	spin_lock_irqsave(&sfp->rq_list_lock, iflags);
 	while (!list_empty(&sfp->rq_list)) {
 		srp = list_first_entry(&sfp->rq_list, struct sg_request, entry);
 		sg_finish_scsi_blk_rq(srp);
 		list_del(&srp->entry);
 		srp->parentfp = NULL;
 	}
-	write_unlock_irqrestore(&sfp->rq_list_lock, iflags);
+	spin_unlock_irqrestore(&sfp->rq_list_lock, iflags);
 
 	if (sfp->reserve.buflen > 0) {
 		SG_LOG(6, sfp, "%s:    buflen=%d, num_sgat=%d\n", __func__,
@@ -2559,9 +2559,9 @@ sg_proc_seq_show_dev(struct seq_file *s, void *v)
 			      scsidp->host->host_no, scsidp->channel,
 			      scsidp->id, scsidp->lun, (int) scsidp->type,
 			      1,
-			      (int) scsidp->queue_depth,
-			      (int) scsi_device_busy(scsidp),
-			      (int) scsi_device_online(scsidp));
+			      (int)scsidp->queue_depth,
+			      (int)scsi_device_busy(scsidp),
+			      (int)scsi_device_online(scsidp));
 	}
 	read_unlock_irqrestore(&sg_index_lock, iflags);
 	return 0;
@@ -2601,7 +2601,7 @@ sg_proc_debug_helper(struct seq_file *s, struct sg_device *sdp)
 	k = 0;
 	list_for_each_entry(fp, &sdp->sfds, sfd_entry) {
 		k++;
-		read_lock(&fp->rq_list_lock); /* irqs already disabled */
+		spin_lock(&fp->rq_list_lock); /* irqs already disabled */
 		seq_printf(s, "   FD(%d): timeout=%dms buflen=%d "
 			   "(res)sgat=%d\n", k,
 			   jiffies_to_msecs(fp->timeout),
@@ -2650,7 +2650,7 @@ sg_proc_debug_helper(struct seq_file *s, struct sg_device *sdp)
 		}
 		if (list_empty(&fp->rq_list))
 			seq_puts(s, "     No requests active\n");
-		read_unlock(&fp->rq_list_lock);
+		spin_unlock(&fp->rq_list_lock);
 	}
 }
 
-- 
2.25.1

