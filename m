Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6F33034D4
	for <lists+linux-scsi@lfdr.de>; Tue, 26 Jan 2021 06:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732916AbhAZF2p (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 26 Jan 2021 00:28:45 -0500
Received: from smtp.infotech.no ([82.134.31.41]:48671 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731586AbhAYTNQ (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 25 Jan 2021 14:13:16 -0500
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 2456D2041CF;
        Mon, 25 Jan 2021 20:11:38 +0100 (CET)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ErB778bI06Bg; Mon, 25 Jan 2021 20:11:36 +0100 (CET)
Received: from xtwo70.bingwo.ca (host-104-157-204-209.dyn.295.ca [104.157.204.209])
        by smtp.infotech.no (Postfix) with ESMTPA id 733BE2041D4;
        Mon, 25 Jan 2021 20:11:34 +0100 (CET)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        kashyap.desai@broadcom.com, Hannes Reinecke <hare@suse.com>
Subject: [PATCH v15 06/45] sg: make open count an atomic
Date:   Mon, 25 Jan 2021 14:10:43 -0500
Message-Id: <20210125191122.345858-7-dgilbert@interlog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210125191122.345858-1-dgilbert@interlog.com>
References: <20210125191122.345858-1-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Convert sg_device::open_cnt into an atomic. Also rename
sg_tablesize into the more descriptive max_sgat_elems.

Reviewed-by: Hannes Reinecke <hare@suse.com>

Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/sg.c | 44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 087e2d7f5474..7f2a2d48d247 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -162,9 +162,9 @@ struct sg_device { /* holds the state of each scsi generic device */
 	struct mutex open_rel_lock;     /* held when in open() or release() */
 	struct list_head sfds;
 	rwlock_t sfd_lock;      /* protect access to sfd list */
-	int sg_tablesize;	/* adapter's max scatter-gather table size */
+	int max_sgat_elems;	/* adapter's max sgat number of elements */
 	u32 index;		/* device index number */
-	int open_cnt;		/* count of opens (perhaps < num(sfds) ) */
+	atomic_t open_cnt;	/* count of opens (perhaps < num(sfds) ) */
 	unsigned long fdev_bm[1];	/* see SG_FDEV_* defines above */
 	struct gendisk *disk;
 	struct cdev *cdev;
@@ -276,11 +276,11 @@ sg_wait_open_event(struct sg_device *sdp, bool o_excl)
 	int retval = 0;
 
 	if (o_excl) {
-		while (sdp->open_cnt > 0) {
+		while (atomic_read(&sdp->open_cnt) > 0) {
 			mutex_unlock(&sdp->open_rel_lock);
 			retval = wait_event_interruptible(sdp->open_wait,
 					(SG_IS_DETACHING(sdp) ||
-					 !sdp->open_cnt));
+					 atomic_read(&sdp->open_cnt) == 0));
 			mutex_lock(&sdp->open_rel_lock);
 
 			if (retval) /* -ERESTARTSYS */
@@ -328,7 +328,7 @@ sg_open(struct inode *inode, struct file *filp)
 	o_excl = !!(op_flags & O_EXCL);
 	if (o_excl && ((op_flags & O_ACCMODE) == O_RDONLY))
 		return -EPERM; /* Can't lock it with read only access */
-	sdp = sg_get_dev(min_dev);
+	sdp = sg_get_dev(min_dev);	/* increments sdp->d_ref */
 	if (IS_ERR(sdp))
 		return PTR_ERR(sdp);
 
@@ -355,7 +355,7 @@ sg_open(struct inode *inode, struct file *filp)
 	mutex_lock(&sdp->open_rel_lock);
 	if (op_flags & O_NONBLOCK) {
 		if (o_excl) {
-			if (sdp->open_cnt > 0) {
+			if (atomic_read(&sdp->open_cnt) > 0) {
 				retval = -EBUSY;
 				goto error_mutex_locked;
 			}
@@ -375,27 +375,29 @@ sg_open(struct inode *inode, struct file *filp)
 	if (o_excl)
 		set_bit(SG_FDEV_EXCLUDE, sdp->fdev_bm);
 
-	if (sdp->open_cnt < 1) {  /* no existing opens */
+	if (atomic_read(&sdp->open_cnt) < 1) {  /* no existing opens */
 		clear_bit(SG_FDEV_LOG_SENSE, sdp->fdev_bm);
 		q = sdp->device->request_queue;
-		sdp->sg_tablesize = queue_max_segments(q);
+		sdp->max_sgat_elems = queue_max_segments(q);
 	}
-	sfp = sg_add_sfp(sdp);
+	sfp = sg_add_sfp(sdp);		/* increments sdp->d_ref */
 	if (IS_ERR(sfp)) {
 		retval = PTR_ERR(sfp);
 		goto out_undo;
 	}
 
 	filp->private_data = sfp;
-	sdp->open_cnt++;
+	atomic_inc(&sdp->open_cnt);
 	mutex_unlock(&sdp->open_rel_lock);
 	SG_LOG(3, sfp, "%s: minor=%d, op_flags=0x%x; %s count prior=%d%s\n",
-	       __func__, min_dev, op_flags, "device open", sdp->open_cnt,
+	       __func__, min_dev, op_flags, "device open",
+	       atomic_read(&sdp->open_cnt),
 	       ((op_flags & O_NONBLOCK) ? " O_NONBLOCK" : ""));
 
 	retval = 0;
 sg_put:
 	kref_put(&sdp->d_ref, sg_device_destroy);
+	/* if success, sdp->d_ref is incremented twice, decremented once */
 	return retval;
 
 out_undo:
@@ -423,20 +425,20 @@ sg_release(struct inode *inode, struct file *filp)
 	sfp = filp->private_data;
 	sdp = sfp->parentdp;
 	SG_LOG(3, sfp, "%s: device open count prior=%d\n", __func__,
-	       sdp->open_cnt);
+	       atomic_read(&sdp->open_cnt));
 	if (!sdp)
 		return -ENXIO;
 
 	mutex_lock(&sdp->open_rel_lock);
 	scsi_autopm_put_device(sdp->device);
 	kref_put(&sfp->f_ref, sg_remove_sfp);
-	sdp->open_cnt--;
+	atomic_dec(&sdp->open_cnt);
 
 	/* possibly many open()s waiting on exclude clearing, start many;
 	 * only open(O_EXCL)s wait on 0==open_cnt so only start one */
 	if (test_and_clear_bit(SG_FDEV_EXCLUDE, sdp->fdev_bm))
 		wake_up_interruptible_all(&sdp->open_wait);
-	else if (sdp->open_cnt == 0)
+	else if (atomic_read(&sdp->open_cnt) == 0)
 		wake_up_interruptible(&sdp->open_wait);
 	mutex_unlock(&sdp->open_rel_lock);
 	return 0;
@@ -1110,7 +1112,7 @@ sg_ioctl_common(struct file *filp, struct sg_device *sdp, struct sg_fd *sfp,
 		read_unlock_irqrestore(&sfp->rq_list_lock, iflags);
 		return put_user(val, ip);
 	case SG_GET_SG_TABLESIZE:
-		return put_user(sdp->sg_tablesize, ip);
+		return put_user(sdp->max_sgat_elems, ip);
 	case SG_SET_RESERVED_SIZE:
 		result = get_user(val, ip);
 		if (result)
@@ -1589,7 +1591,7 @@ sg_alloc(struct gendisk *disk, struct scsi_device *scsidp)
 	init_waitqueue_head(&sdp->open_wait);
 	clear_bit(SG_FDEV_DETACHING, sdp->fdev_bm);
 	rwlock_init(&sdp->sfd_lock);
-	sdp->sg_tablesize = queue_max_segments(q);
+	sdp->max_sgat_elems = queue_max_segments(q);
 	sdp->index = k;
 	kref_init(&sdp->d_ref);
 	error = 0;
@@ -1985,7 +1987,7 @@ sg_build_indirect(struct sg_scatter_hold *schp, struct sg_fd *sfp,
 		  int buff_size)
 {
 	int ret_sz = 0, i, k, rem_sz, num, mx_sc_elems;
-	int sg_tablesize = sfp->parentdp->sg_tablesize;
+	int max_sgat_elems = sfp->parentdp->max_sgat_elems;
 	int blk_size = buff_size, order;
 	gfp_t gfp_mask = GFP_ATOMIC | __GFP_COMP | __GFP_NOWARN | __GFP_ZERO;
 	struct sg_device *sdp = sfp->parentdp;
@@ -2000,7 +2002,7 @@ sg_build_indirect(struct sg_scatter_hold *schp, struct sg_fd *sfp,
 	       blk_size);
 
 	/* N.B. ret_sz carried into this block ... */
-	mx_sc_elems = sg_build_sgat(schp, sfp, sg_tablesize);
+	mx_sc_elems = sg_build_sgat(schp, sfp, max_sgat_elems);
 	if (mx_sc_elems < 0)
 		return mx_sc_elems;	/* most likely -ENOMEM */
 
@@ -2688,9 +2690,9 @@ sg_proc_seq_show_debug(struct seq_file *s, void *v)
 				   scsidp->lun,
 				   scsidp->host->hostt->emulated);
 		}
-		seq_printf(s, " sg_tablesize=%d excl=%d open_cnt=%d\n",
-			   sdp->sg_tablesize, SG_HAVE_EXCLUDE(sdp),
-			   sdp->open_cnt);
+		seq_printf(s, " max_sgat_elems=%d excl=%d open_cnt=%d\n",
+			   sdp->max_sgat_elems, SG_HAVE_EXCLUDE(sdp),
+			   atomic_read(&sdp->open_cnt));
 		sg_proc_debug_helper(s, sdp);
 	}
 	read_unlock(&sdp->sfd_lock);
-- 
2.25.1

