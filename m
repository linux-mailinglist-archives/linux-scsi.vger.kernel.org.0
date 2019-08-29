Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA4BA0F7F
	for <lists+linux-scsi@lfdr.de>; Thu, 29 Aug 2019 04:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfH2C1S (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 28 Aug 2019 22:27:18 -0400
Received: from smtp.infotech.no ([82.134.31.41]:40050 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727222AbfH2C1S (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 28 Aug 2019 22:27:18 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id CC5712041F1;
        Thu, 29 Aug 2019 04:27:15 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AUQ5sYkNhTV7; Thu, 29 Aug 2019 04:27:13 +0200 (CEST)
Received: from xtwo70.bingwo.ca (host-23-251-188-50.dyn.295.ca [23.251.188.50])
        by smtp.infotech.no (Postfix) with ESMTPA id 32DC6204163;
        Thu, 29 Aug 2019 04:27:11 +0200 (CEST)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        bvanassche@acm.org, hch@infradead.org
Subject: [PATCH v4 05/22] sg: bitops in sg_device
Date:   Wed, 28 Aug 2019 22:26:42 -0400
Message-Id: <20190829022659.23130-6-dgilbert@interlog.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190829022659.23130-1-dgilbert@interlog.com>
References: <20190829022659.23130-1-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Introduce bitops in sg_device to replace an atomic, a bool and a
char. That char (sgdebug) had been reduced to only two states.
Add some associated macros to make the code a little clearer.

Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/sg.c | 104 +++++++++++++++++++++++-----------------------
 1 file changed, 53 insertions(+), 51 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 9aa1b1030033..97ce84f0c51b 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -74,6 +74,11 @@ static char *sg_version_date = "20190606";
 
 #define SG_DEFAULT_TIMEOUT mult_frac(SG_DEFAULT_TIMEOUT_USER, HZ, USER_HZ)
 
+/* Bit positions (flags) for sg_device::fdev_bm bitmask follow */
+#define SG_FDEV_EXCLUDE		0	/* have fd open with O_EXCL */
+#define SG_FDEV_DETACHING	1	/* may be unexpected device removal */
+#define SG_FDEV_LOG_SENSE	2	/* set by ioctl(SG_SET_DEBUG) */
+
 int sg_big_buff = SG_DEF_RESERVED_SIZE;
 /* N.B. This variable is readable and writeable via
    /proc/scsi/sg/def_reserved_size . Each time sg_open() is called a buffer
@@ -155,14 +160,12 @@ struct sg_device { /* holds the state of each scsi generic device */
 	struct scsi_device *device;
 	wait_queue_head_t open_wait;    /* queue open() when O_EXCL present */
 	struct mutex open_rel_lock;     /* held when in open() or release() */
-	int sg_tablesize;	/* adapter's max scatter-gather table size */
-	u32 index;		/* device index number */
 	struct list_head sfds;
 	rwlock_t sfd_lock;      /* protect access to sfd list */
-	atomic_t detaching;     /* 0->device usable, 1->device detaching */
-	bool exclude;		/* 1->open(O_EXCL) succeeded and is active */
+	int sg_tablesize;	/* adapter's max scatter-gather table size */
+	u32 index;		/* device index number */
 	int open_cnt;		/* count of opens (perhaps < num(sfds) ) */
-	char sgdebug;		/* 0->off, 1->sense, 9->dump dev, 10-> all devs */
+	unsigned long fdev_bm[1];	/* see SG_FDEV_* defines above */
 	struct gendisk *disk;
 	struct cdev * cdev;	/* char_dev [sysfs: /sys/cdev/major/sg<n>] */
 	struct kref d_ref;
@@ -200,6 +203,9 @@ static void sg_device_destroy(struct kref *kref);
 #define SZ_SG_IO_HDR ((int)sizeof(struct sg_io_hdr))	/* v3 header */
 #define SZ_SG_REQ_INFO ((int)sizeof(struct sg_req_info))
 
+#define SG_IS_DETACHING(sdp) test_bit(SG_FDEV_DETACHING, (sdp)->fdev_bm)
+#define SG_HAVE_EXCLUDE(sdp) test_bit(SG_FDEV_EXCLUDE, (sdp)->fdev_bm)
+
 /*
  * Kernel needs to be built with CONFIG_SCSI_LOGGING to see log messages.
  * 'depth' is a number between 1 (most severe) and 7 (most noisy, most
@@ -273,26 +279,26 @@ sg_wait_open_event(struct sg_device *sdp, bool o_excl)
 		while (sdp->open_cnt > 0) {
 			mutex_unlock(&sdp->open_rel_lock);
 			retval = wait_event_interruptible(sdp->open_wait,
-					(atomic_read(&sdp->detaching) ||
+					(SG_IS_DETACHING(sdp) ||
 					 !sdp->open_cnt));
 			mutex_lock(&sdp->open_rel_lock);
 
 			if (retval) /* -ERESTARTSYS */
 				return retval;
-			if (atomic_read(&sdp->detaching))
+			if (SG_IS_DETACHING(sdp))
 				return -ENODEV;
 		}
 	} else {
-		while (sdp->exclude) {
+		while (SG_HAVE_EXCLUDE(sdp)) {
 			mutex_unlock(&sdp->open_rel_lock);
 			retval = wait_event_interruptible(sdp->open_wait,
-					(atomic_read(&sdp->detaching) ||
-					 !sdp->exclude));
+					(SG_IS_DETACHING(sdp) ||
+					 !SG_HAVE_EXCLUDE(sdp)));
 			mutex_lock(&sdp->open_rel_lock);
 
 			if (retval) /* -ERESTARTSYS */
 				return retval;
-			if (atomic_read(&sdp->detaching))
+			if (SG_IS_DETACHING(sdp))
 				return -ENODEV;
 		}
 	}
@@ -354,7 +360,7 @@ sg_open(struct inode *inode, struct file *filp)
 				goto error_mutex_locked;
 			}
 		} else {
-			if (sdp->exclude) {
+			if (SG_HAVE_EXCLUDE(sdp)) {
 				retval = -EBUSY;
 				goto error_mutex_locked;
 			}
@@ -367,10 +373,10 @@ sg_open(struct inode *inode, struct file *filp)
 
 	/* N.B. at this point we are holding the open_rel_lock */
 	if (o_excl)
-		sdp->exclude = true;
+		set_bit(SG_FDEV_EXCLUDE, sdp->fdev_bm);
 
 	if (sdp->open_cnt < 1) {  /* no existing opens */
-		sdp->sgdebug = 0;
+		clear_bit(SG_FDEV_LOG_SENSE, sdp->fdev_bm);
 		q = sdp->device->request_queue;
 		sdp->sg_tablesize = queue_max_segments(q);
 	}
@@ -393,8 +399,8 @@ sg_open(struct inode *inode, struct file *filp)
 	return retval;
 
 out_undo:
-	if (o_excl) {
-		sdp->exclude = false;   /* undo if error */
+	if (o_excl) {		/* undo if error */
+		clear_bit(SG_FDEV_EXCLUDE, sdp->fdev_bm);
 		wake_up_interruptible(&sdp->open_wait);
 	}
 error_mutex_locked:
@@ -428,12 +434,10 @@ sg_release(struct inode *inode, struct file *filp)
 
 	/* possibly many open()s waiting on exlude clearing, start many;
 	 * only open(O_EXCL)s wait on 0==open_cnt so only start one */
-	if (sdp->exclude) {
-		sdp->exclude = false;
+	if (test_and_clear_bit(SG_FDEV_EXCLUDE, sdp->fdev_bm))
 		wake_up_interruptible_all(&sdp->open_wait);
-	} else if (0 == sdp->open_cnt) {
+	else if (sdp->open_cnt == 0)
 		wake_up_interruptible(&sdp->open_wait);
-	}
 	mutex_unlock(&sdp->open_rel_lock);
 	return 0;
 }
@@ -467,7 +471,7 @@ sg_write(struct file *filp, const char __user *buf, size_t count, loff_t * ppos)
 	SG_LOG(3, sfp, "%s: write(3rd arg) count=%d\n", __func__, (int)count);
 	if (!sdp)
 		return -ENXIO;
-	if (atomic_read(&sdp->detaching))
+	if (SG_IS_DETACHING(sdp))
 		return -ENODEV;
 	if (!((filp->f_flags & O_NONBLOCK) ||
 	      scsi_block_when_processing_errors(sdp->device)))
@@ -666,7 +670,7 @@ sg_common_write(struct sg_fd *sfp, struct sg_request *srp,
 		sg_remove_request(sfp, srp);
 		return k;	/* probably out of space --> ENOMEM */
 	}
-	if (atomic_read(&sdp->detaching)) {
+	if (SG_IS_DETACHING(sdp)) {
 		if (srp->bio) {
 			scsi_req_free_cmd(scsi_req(srp->rq));
 			blk_put_request(srp->rq);
@@ -831,7 +835,7 @@ sg_read(struct file *filp, char __user *buf, size_t count, loff_t *ppos)
 	}
 	srp = sg_get_rq_mark(sfp, req_pack_id);
 	if (!srp) {		/* now wait on packet to arrive */
-		if (atomic_read(&sdp->detaching)) {
+		if (SG_IS_DETACHING(sdp)) {
 			retval = -ENODEV;
 			goto free_old_hdr;
 		}
@@ -840,9 +844,9 @@ sg_read(struct file *filp, char __user *buf, size_t count, loff_t *ppos)
 			goto free_old_hdr;
 		}
 		retval = wait_event_interruptible(sfp->read_wait,
-			(atomic_read(&sdp->detaching) ||
+			(SG_IS_DETACHING(sdp) ||
 			(srp = sg_get_rq_mark(sfp, req_pack_id))));
-		if (atomic_read(&sdp->detaching)) {
+		if (SG_IS_DETACHING(sdp)) {
 			retval = -ENODEV;
 			goto free_old_hdr;
 		}
@@ -997,7 +1001,7 @@ sg_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
 
 	switch (cmd_in) {
 	case SG_IO:
-		if (atomic_read(&sdp->detaching))
+		if (SG_IS_DETACHING(sdp))
 			return -ENODEV;
 		if (!scsi_block_when_processing_errors(sdp->device))
 			return -ENXIO;
@@ -1008,8 +1012,8 @@ sg_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
 		if (result < 0)
 			return result;
 		result = wait_event_interruptible(sfp->read_wait,
-			(srp_done(sfp, srp) || atomic_read(&sdp->detaching)));
-		if (atomic_read(&sdp->detaching))
+			(srp_done(sfp, srp) || SG_IS_DETACHING(sdp)));
+		if (SG_IS_DETACHING(sdp))
 			return -ENODEV;
 		write_lock_irq(&sfp->rq_list_lock);
 		if (srp->done) {
@@ -1052,7 +1056,7 @@ sg_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
 		else {
 			sg_scsi_id_t __user *sg_idp = p;
 
-			if (atomic_read(&sdp->detaching))
+			if (SG_IS_DETACHING(sdp))
 				return -ENODEV;
 			__put_user((int) sdp->device->host->host_no,
 				   &sg_idp->host_no);
@@ -1176,18 +1180,18 @@ sg_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
 			return result;
 		}
 	case SG_EMULATED_HOST:
-		if (atomic_read(&sdp->detaching))
+		if (SG_IS_DETACHING(sdp))
 			return -ENODEV;
 		return put_user(sdp->device->host->hostt->emulated, ip);
 	case SCSI_IOCTL_SEND_COMMAND:
-		if (atomic_read(&sdp->detaching))
+		if (SG_IS_DETACHING(sdp))
 			return -ENODEV;
 		return sg_scsi_ioctl(sdp->device->request_queue, NULL, filp->f_mode, p);
 	case SG_SET_DEBUG:
 		result = get_user(val, ip);
 		if (result)
 			return result;
-		sdp->sgdebug = (char) val;
+		assign_bit(SG_FDEV_LOG_SENSE, sdp->fdev_bm, val);
 		return 0;
 	case BLKSECTGET:
 		return put_user(max_sectors_bytes(sdp->device->request_queue),
@@ -1208,7 +1212,7 @@ sg_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
 	case SCSI_IOCTL_PROBE_HOST:
 	case SG_GET_TRANSFORM:
 	case SG_SCSI_RESET:
-		if (atomic_read(&sdp->detaching))
+		if (SG_IS_DETACHING(sdp))
 			return -ENODEV;
 		break;
 	default:
@@ -1271,7 +1275,7 @@ sg_poll(struct file *filp, poll_table * wait)
 	}
 	read_unlock_irqrestore(&sfp->rq_list_lock, iflags);
 
-	if (sfp->parentdp && atomic_read(&sfp->parentdp->detaching)) {
+	if (sfp->parentdp && SG_IS_DETACHING(sfp->parentdp)) {
 		p_res |= EPOLLHUP;
 	} else if (!sfp->cmd_q) {
 		if (count == 0)
@@ -1419,7 +1423,7 @@ sg_rq_end_io(struct request *rq, blk_status_t status)
 		return;
 
 	sdp = sfp->parentdp;
-	if (unlikely(atomic_read(&sdp->detaching)))
+	if (unlikely(SG_IS_DETACHING(sdp)))
 		pr_info("%s: device detaching\n", __func__);
 
 	sense = req->sense;
@@ -1440,9 +1444,9 @@ sg_rq_end_io(struct request *rq, blk_status_t status)
 		srp->header.msg_status = msg_byte(result);
 		srp->header.host_status = host_byte(result);
 		srp->header.driver_status = driver_byte(result);
-		if ((sdp->sgdebug > 0) &&
-		    ((CHECK_CONDITION == srp->header.masked_status) ||
-		     (COMMAND_TERMINATED == srp->header.masked_status)))
+		if (test_bit(SG_FDEV_LOG_SENSE, sdp->fdev_bm) &&
+		    (srp->header.masked_status == CHECK_CONDITION ||
+		     srp->header.masked_status == COMMAND_TERMINATED))
 			__scsi_print_sense(sdp->device, __func__, sense,
 					   SCSI_SENSE_BUFFERSIZE);
 
@@ -1557,7 +1561,7 @@ sg_alloc(struct gendisk *disk, struct scsi_device *scsidp)
 	mutex_init(&sdp->open_rel_lock);
 	INIT_LIST_HEAD(&sdp->sfds);
 	init_waitqueue_head(&sdp->open_wait);
-	atomic_set(&sdp->detaching, 0);
+	clear_bit(SG_FDEV_DETACHING, sdp->fdev_bm);
 	rwlock_init(&sdp->sfd_lock);
 	sdp->sg_tablesize = queue_max_segments(q);
 	sdp->index = k;
@@ -1682,13 +1686,11 @@ sg_remove_device(struct device *cl_dev, struct class_interface *cl_intf)
 	struct sg_device *sdp = dev_get_drvdata(cl_dev);
 	unsigned long iflags;
 	struct sg_fd *sfp;
-	int val;
 
 	if (!sdp)
 		return;
-	/* want sdp->detaching non-zero as soon as possible */
-	val = atomic_inc_return(&sdp->detaching);
-	if (val > 1)
+	/* set this flag as soon as possible as it could be a surprise */
+	if (test_and_set_bit(SG_FDEV_DETACHING, sdp->fdev_bm))
 		return; /* only want to do following once per device */
 
 	SCSI_LOG_TIMEOUT(3, sdev_printk(KERN_INFO, sdp->device,
@@ -2218,7 +2220,7 @@ sg_add_sfp(struct sg_device *sdp)
 	sfp->keep_orphan = SG_DEF_KEEP_ORPHAN;
 	sfp->parentdp = sdp;
 	write_lock_irqsave(&sdp->sfd_lock, iflags);
-	if (atomic_read(&sdp->detaching)) {
+	if (SG_IS_DETACHING(sdp)) {
 		write_unlock_irqrestore(&sdp->sfd_lock, iflags);
 		kfree(sfp);
 		return ERR_PTR(-ENODEV);
@@ -2315,8 +2317,8 @@ sg_get_dev(int dev)
 	sdp = sg_lookup_dev(dev);
 	if (!sdp)
 		sdp = ERR_PTR(-ENXIO);
-	else if (atomic_read(&sdp->detaching)) {
-		/* If sdp->detaching, then the refcount may already be 0, in
+	else if (SG_IS_DETACHING(sdp)) {
+		/* If detaching, then the refcount may already be 0, in
 		 * which case it would be a bug to do kref_get().
 		 */
 		sdp = ERR_PTR(-ENODEV);
@@ -2530,8 +2532,7 @@ sg_proc_seq_show_dev(struct seq_file *s, void *v)
 
 	read_lock_irqsave(&sg_index_lock, iflags);
 	sdp = it ? sg_lookup_dev(it->index) : NULL;
-	if ((NULL == sdp) || (NULL == sdp->device) ||
-	    (atomic_read(&sdp->detaching)))
+	if (!sdp || !sdp->device || SG_IS_DETACHING(sdp))
 		seq_puts(s, "-1\t-1\t-1\t-1\t-1\t-1\t-1\t-1\t-1\n");
 	else {
 		scsidp = sdp->device;
@@ -2558,7 +2559,7 @@ sg_proc_seq_show_devstrs(struct seq_file *s, void *v)
 	read_lock_irqsave(&sg_index_lock, iflags);
 	sdp = it ? sg_lookup_dev(it->index) : NULL;
 	scsidp = sdp ? sdp->device : NULL;
-	if (sdp && scsidp && (!atomic_read(&sdp->detaching)))
+	if (sdp && scsidp && !SG_IS_DETACHING(sdp))
 		seq_printf(s, "%8.8s\t%16.16s\t%4.4s\n",
 			   scsidp->vendor, scsidp->model, scsidp->rev);
 	else
@@ -2650,7 +2651,7 @@ sg_proc_seq_show_debug(struct seq_file *s, void *v)
 	read_lock(&sdp->sfd_lock);
 	if (!list_empty(&sdp->sfds)) {
 		seq_printf(s, " >>> device=%s ", sdp->disk->disk_name);
-		if (atomic_read(&sdp->detaching))
+		if (SG_IS_DETACHING(sdp))
 			seq_puts(s, "detaching pending close ");
 		else if (sdp->device) {
 			struct scsi_device *scsidp = sdp->device;
@@ -2662,7 +2663,8 @@ sg_proc_seq_show_debug(struct seq_file *s, void *v)
 				   scsidp->host->hostt->emulated);
 		}
 		seq_printf(s, " sg_tablesize=%d excl=%d open_cnt=%d\n",
-			   sdp->sg_tablesize, sdp->exclude, sdp->open_cnt);
+			   sdp->sg_tablesize, SG_HAVE_EXCLUDE(sdp),
+			   sdp->open_cnt);
 		sg_proc_debug_helper(s, sdp);
 	}
 	read_unlock(&sdp->sfd_lock);
-- 
2.23.0

