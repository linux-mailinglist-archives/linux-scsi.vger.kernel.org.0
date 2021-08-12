Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 990BD3E9FC9
	for <lists+linux-scsi@lfdr.de>; Thu, 12 Aug 2021 09:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234745AbhHLHuj (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 12 Aug 2021 03:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbhHLHui (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 12 Aug 2021 03:50:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C2DC061765;
        Thu, 12 Aug 2021 00:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=VSY5+aubavQCko7U0IzQq6eA1rwvwuw7Ga9+zkk/gDE=; b=MAGur+QNSb3QD96Ne2cCvzwkKX
        Xe33rRpJIRihHJB56E3gDlIEZ7VWrocfC9iWYbBNw5QsT7ji7uyZwwA15HWiNm2US1o5xXERhM+AX
        zI5970qcHSOLUBcdi77C0UNvBSX4PBbcHsgDNTzvk5ikqPnLZ/yRGsab3K8WcKnLxTkM87VXjn68D
        djQcAwZn/gFVCDcP/pzZgPw52nV5a0emb9sJoS5ETbOu5kmCK9/VtRDNAeErj0dZqVbwxzGmQmX/F
        lgA3M8eqHjXEYlMZ+bnM5f0cu0pbvYfEJ8aHL0nTL8SjqSTrLKK4sBeb3Yva44Vsv6Sv6EaMef4Ix
        NHx3AOBQ==;
Received: from [2001:4bb8:184:6215:d7d:1904:40de:694d] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mE5Ro-00EIpR-Fd; Thu, 12 Aug 2021 07:48:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Doug Gilbert <dgilbert@interlog.com>,
        =?UTF-8?q?Kai=20M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 2/8] st: do not allocate a gendisk
Date:   Thu, 12 Aug 2021 09:46:36 +0200
Message-Id: <20210812074642.18592-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210812074642.18592-1-hch@lst.de>
References: <20210812074642.18592-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

st is a character driver and thus does not need to allocate a gendisk,
which is only used for file system-like block layer I/O on block
devices.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/st.c | 49 ++++++++++++-----------------------------------
 drivers/scsi/st.h |  2 +-
 2 files changed, 13 insertions(+), 38 deletions(-)

diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index c6f14540ae03..d1abc020f3c0 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -309,13 +309,8 @@ static char * st_incompatible(struct scsi_device* SDp)
 }
 
 
-static inline char *tape_name(struct scsi_tape *tape)
-{
-	return tape->disk->disk_name;
-}
-
 #define st_printk(prefix, t, fmt, a...) \
-	sdev_prefix_printk(prefix, (t)->device, tape_name(t), fmt, ##a)
+	sdev_prefix_printk(prefix, (t)->device, (t)->name, fmt, ##a)
 #ifdef DEBUG
 #define DEBC_printk(t, fmt, a...) \
 	if (debugging) { st_printk(ST_DEB_MSG, t, fmt, ##a ); }
@@ -363,7 +358,7 @@ static int st_chk_result(struct scsi_tape *STp, struct st_request * SRpnt)
 	int result = SRpnt->result;
 	u8 scode;
 	DEB(const char *stp;)
-	char *name = tape_name(STp);
+	char *name = STp->name;
 	struct st_cmdstatus *cmdstatp;
 
 	if (!result)
@@ -3841,8 +3836,9 @@ static long st_ioctl_common(struct file *file, unsigned int cmd_in, void __user
 			    !capable(CAP_SYS_RAWIO))
 				i = -EPERM;
 			else
-				i = scsi_cmd_ioctl(STp->disk->queue, STp->disk,
-						   file->f_mode, cmd_in, p);
+				i = scsi_cmd_ioctl(STp->device->request_queue,
+						   NULL, file->f_mode, cmd_in,
+						   p);
 			if (i != -ENOTTY)
 				return i;
 			break;
@@ -4216,7 +4212,7 @@ static int create_one_cdev(struct scsi_tape *tape, int mode, int rew)
 
 	i = mode << (4 - ST_NBR_MODE_BITS);
 	snprintf(name, 10, "%s%s%s", rew ? "n" : "",
-		 tape->disk->disk_name, st_formats[i]);
+		 tape->name, st_formats[i]);
 
 	dev = device_create(&st_sysfs_class, &tape->device->sdev_gendev,
 			    cdev_devno, &tape->modes[mode], "%s", name);
@@ -4271,7 +4267,6 @@ static void remove_cdevs(struct scsi_tape *tape)
 static int st_probe(struct device *dev)
 {
 	struct scsi_device *SDp = to_scsi_device(dev);
-	struct gendisk *disk = NULL;
 	struct scsi_tape *tpnt = NULL;
 	struct st_modedef *STm;
 	struct st_partstat *STps;
@@ -4301,27 +4296,13 @@ static int st_probe(struct device *dev)
 		goto out;
 	}
 
-	disk = alloc_disk(1);
-	if (!disk) {
-		sdev_printk(KERN_ERR, SDp,
-			    "st: out of memory. Device not attached.\n");
-		goto out_buffer_free;
-	}
-
 	tpnt = kzalloc(sizeof(struct scsi_tape), GFP_KERNEL);
 	if (tpnt == NULL) {
 		sdev_printk(KERN_ERR, SDp,
 			    "st: Can't allocate device descriptor.\n");
-		goto out_put_disk;
+		goto out_buffer_free;
 	}
 	kref_init(&tpnt->kref);
-	tpnt->disk = disk;
-	disk->private_data = &tpnt->driver;
-	/* SCSI tape doesn't register this gendisk via add_disk().  Manually
-	 * take queue reference that release_disk() expects. */
-	if (!blk_get_queue(SDp->request_queue))
-		goto out_put_disk;
-	disk->queue = SDp->request_queue;
 	tpnt->driver = &st_template;
 
 	tpnt->device = SDp;
@@ -4394,10 +4375,10 @@ static int st_probe(struct device *dev)
 	idr_preload_end();
 	if (error < 0) {
 		pr_warn("st: idr allocation failed: %d\n", error);
-		goto out_put_queue;
+		goto out_free_tape;
 	}
 	tpnt->index = error;
-	sprintf(disk->disk_name, "st%d", tpnt->index);
+	sprintf(tpnt->name, "st%d", tpnt->index);
 	tpnt->stats = kzalloc(sizeof(struct scsi_tape_stats), GFP_KERNEL);
 	if (tpnt->stats == NULL) {
 		sdev_printk(KERN_ERR, SDp,
@@ -4414,9 +4395,9 @@ static int st_probe(struct device *dev)
 	scsi_autopm_put_device(SDp);
 
 	sdev_printk(KERN_NOTICE, SDp,
-		    "Attached scsi tape %s\n", tape_name(tpnt));
+		    "Attached scsi tape %s\n", tpnt->name);
 	sdev_printk(KERN_INFO, SDp, "%s: try direct i/o: %s (alignment %d B)\n",
-		    tape_name(tpnt), tpnt->try_dio ? "yes" : "no",
+		    tpnt->name, tpnt->try_dio ? "yes" : "no",
 		    queue_dma_alignment(SDp->request_queue) + 1);
 
 	return 0;
@@ -4428,10 +4409,7 @@ static int st_probe(struct device *dev)
 	spin_lock(&st_index_lock);
 	idr_remove(&st_index_idr, tpnt->index);
 	spin_unlock(&st_index_lock);
-out_put_queue:
-	blk_put_queue(disk->queue);
-out_put_disk:
-	put_disk(disk);
+out_free_tape:
 	kfree(tpnt);
 out_buffer_free:
 	kfree(buffer);
@@ -4470,7 +4448,6 @@ static int st_remove(struct device *dev)
 static void scsi_tape_release(struct kref *kref)
 {
 	struct scsi_tape *tpnt = to_scsi_tape(kref);
-	struct gendisk *disk = tpnt->disk;
 
 	tpnt->device = NULL;
 
@@ -4480,8 +4457,6 @@ static void scsi_tape_release(struct kref *kref)
 		kfree(tpnt->buffer);
 	}
 
-	disk->private_data = NULL;
-	put_disk(disk);
 	kfree(tpnt->stats);
 	kfree(tpnt);
 	return;
diff --git a/drivers/scsi/st.h b/drivers/scsi/st.h
index 9d3c38bb0794..c0ef0d9aaf8a 100644
--- a/drivers/scsi/st.h
+++ b/drivers/scsi/st.h
@@ -187,7 +187,7 @@ struct scsi_tape {
 	unsigned char last_cmnd[6];
 	unsigned char last_sense[16];
 #endif
-	struct gendisk *disk;
+	char name[DISK_NAME_LEN];
 	struct kref     kref;
 	struct scsi_tape_stats *stats;
 };
-- 
2.30.2

