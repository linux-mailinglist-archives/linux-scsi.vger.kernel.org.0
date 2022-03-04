Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B56B4CD883
	for <lists+linux-scsi@lfdr.de>; Fri,  4 Mar 2022 17:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240586AbiCDQEy (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 4 Mar 2022 11:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240568AbiCDQEv (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 4 Mar 2022 11:04:51 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACA91B0BE1;
        Fri,  4 Mar 2022 08:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=N5nyxqtZny0MLHb0C3uISnAw/DsiiweV2l+XWUt7yp8=; b=avL1L8asOBDc+JjcUiPKpLlhvL
        Sz27KPbuz71XfRNy8hjlUAKjHOY52XME4/pBKGxhX8a7dCNNdQ+uYRiai6qF7GE9ojreGTAftHZ5o
        lqGhpHV7vWsQAskjzQU3Ad/7KJUPcVUZJffBflC68gKQ3OBvcj5aeBB6LXaRlwdZX2oMWdtzT6xoh
        +/2dGGvkExEmFhJrqfGUJcySo6Gk5NGDSIXDgRkCRe5A+Q9BwolkqDRZ9iVI30CusTxHGJPTudyrf
        6zeRo5knW2nPmknNk7nXKrj0UWgBgmIxuPacVIfjzD9eQRUpDcPk+qlZBAxMUHJzLdoldW3C0GZU6
        ZC8qlvYw==;
Received: from [2001:4bb8:180:5296:7360:567:acd5:aaa2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nQAPP-00Au48-Dp; Fri, 04 Mar 2022 16:04:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 08/14] sr: implement ->free_disk
Date:   Fri,  4 Mar 2022 17:03:25 +0100
Message-Id: <20220304160331.399757-9-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220304160331.399757-1-hch@lst.de>
References: <20220304160331.399757-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Simplify the refcounting and remove the need to clear disk->private_data
by implementing the ->free_disk method.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/sr.c | 124 ++++++++++------------------------------------
 drivers/scsi/sr.h |   4 --
 2 files changed, 26 insertions(+), 102 deletions(-)

diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index 569bda76a5175..11fbdc75bb711 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -109,11 +109,6 @@ static DEFINE_SPINLOCK(sr_index_lock);
 
 static struct lock_class_key sr_bio_compl_lkclass;
 
-/* This semaphore is used to mediate the 0->1 reference get in the
- * face of object destruction (i.e. we can't allow a get on an
- * object after last put) */
-static DEFINE_MUTEX(sr_ref_mutex);
-
 static int sr_open(struct cdrom_device_info *, int);
 static void sr_release(struct cdrom_device_info *);
 
@@ -143,8 +138,6 @@ static const struct cdrom_device_ops sr_dops = {
 	.capability		= SR_CAPABILITIES,
 };
 
-static void sr_kref_release(struct kref *kref);
-
 static inline struct scsi_cd *scsi_cd(struct gendisk *disk)
 {
 	return disk->private_data;
@@ -163,38 +156,6 @@ static int sr_runtime_suspend(struct device *dev)
 		return 0;
 }
 
-/*
- * The get and put routines for the struct scsi_cd.  Note this entity
- * has a scsi_device pointer and owns a reference to this.
- */
-static inline struct scsi_cd *scsi_cd_get(struct gendisk *disk)
-{
-	struct scsi_cd *cd = NULL;
-
-	mutex_lock(&sr_ref_mutex);
-	if (disk->private_data == NULL)
-		goto out;
-	cd = scsi_cd(disk);
-	kref_get(&cd->kref);
-	if (scsi_device_get(cd->device)) {
-		kref_put(&cd->kref, sr_kref_release);
-		cd = NULL;
-	}
- out:
-	mutex_unlock(&sr_ref_mutex);
-	return cd;
-}
-
-static void scsi_cd_put(struct scsi_cd *cd)
-{
-	struct scsi_device *sdev = cd->device;
-
-	mutex_lock(&sr_ref_mutex);
-	kref_put(&cd->kref, sr_kref_release);
-	scsi_device_put(sdev);
-	mutex_unlock(&sr_ref_mutex);
-}
-
 static unsigned int sr_get_events(struct scsi_device *sdev)
 {
 	u8 buf[8];
@@ -522,15 +483,13 @@ static void sr_revalidate_disk(struct scsi_cd *cd)
 
 static int sr_block_open(struct block_device *bdev, fmode_t mode)
 {
-	struct scsi_cd *cd;
-	struct scsi_device *sdev;
+	struct scsi_cd *cd = cd = scsi_cd(bdev->bd_disk);
+	struct scsi_device *sdev = cd->device;
 	int ret = -ENXIO;
 
-	cd = scsi_cd_get(bdev->bd_disk);
-	if (!cd)
-		goto out;
+	if (scsi_device_get(cd->device))
+		return -ENXIO;
 
-	sdev = cd->device;
 	scsi_autopm_get_device(sdev);
 	if (bdev_check_media_change(bdev))
 		sr_revalidate_disk(cd);
@@ -541,9 +500,7 @@ static int sr_block_open(struct block_device *bdev, fmode_t mode)
 
 	scsi_autopm_put_device(sdev);
 	if (ret)
-		scsi_cd_put(cd);
-
-out:
+		scsi_device_put(cd->device);
 	return ret;
 }
 
@@ -555,7 +512,7 @@ static void sr_block_release(struct gendisk *disk, fmode_t mode)
 	cdrom_release(&cd->cdi, mode);
 	mutex_unlock(&cd->lock);
 
-	scsi_cd_put(cd);
+	scsi_device_put(cd->device);
 }
 
 static int sr_block_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
@@ -595,18 +552,24 @@ static int sr_block_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
 static unsigned int sr_block_check_events(struct gendisk *disk,
 					  unsigned int clearing)
 {
-	unsigned int ret = 0;
-	struct scsi_cd *cd;
+	struct scsi_cd *cd = disk->private_data;
 
-	cd = scsi_cd_get(disk);
-	if (!cd)
+	if (atomic_read(&cd->device->disk_events_disable_depth))
 		return 0;
+	return cdrom_check_events(&cd->cdi, clearing);
+}
 
-	if (!atomic_read(&cd->device->disk_events_disable_depth))
-		ret = cdrom_check_events(&cd->cdi, clearing);
+static void sr_free_disk(struct gendisk *disk)
+{
+	struct scsi_cd *cd = disk->private_data;
 
-	scsi_cd_put(cd);
-	return ret;
+	spin_lock(&sr_index_lock);
+	clear_bit(MINOR(disk_devt(disk)), sr_index_bits);
+	spin_unlock(&sr_index_lock);
+
+	unregister_cdrom(&cd->cdi);
+	mutex_destroy(&cd->lock);
+	kfree(cd);
 }
 
 static const struct block_device_operations sr_bdops =
@@ -617,6 +580,7 @@ static const struct block_device_operations sr_bdops =
 	.ioctl		= sr_block_ioctl,
 	.compat_ioctl	= blkdev_compat_ptr_ioctl,
 	.check_events	= sr_block_check_events,
+	.free_disk	= sr_free_disk,
 };
 
 static int sr_open(struct cdrom_device_info *cdi, int purpose)
@@ -660,8 +624,6 @@ static int sr_probe(struct device *dev)
 	if (!cd)
 		goto fail;
 
-	kref_init(&cd->kref);
-
 	disk = __alloc_disk_node(sdev->request_queue, NUMA_NO_NODE,
 				 &sr_bio_compl_lkclass);
 	if (!disk)
@@ -727,10 +689,8 @@ static int sr_probe(struct device *dev)
 	sr_revalidate_disk(cd);
 
 	error = device_add_disk(&sdev->sdev_gendev, disk, NULL);
-	if (error) {
-		kref_put(&cd->kref, sr_kref_release);
-		goto fail;
-	}
+	if (error)
+		goto unregister_cdrom;
 
 	sdev_printk(KERN_DEBUG, sdev,
 		    "Attached scsi CD-ROM %s\n", cd->cdi.name);
@@ -738,6 +698,8 @@ static int sr_probe(struct device *dev)
 
 	return 0;
 
+unregister_cdrom:
+	unregister_cdrom(&cd->cdi);
 fail_minor:
 	spin_lock(&sr_index_lock);
 	clear_bit(minor, sr_index_bits);
@@ -1009,36 +971,6 @@ static int sr_read_cdda_bpc(struct cdrom_device_info *cdi, void __user *ubuf,
 	return ret;
 }
 
-
-/**
- *	sr_kref_release - Called to free the scsi_cd structure
- *	@kref: pointer to embedded kref
- *
- *	sr_ref_mutex must be held entering this routine.  Because it is
- *	called on last put, you should always use the scsi_cd_get()
- *	scsi_cd_put() helpers which manipulate the semaphore directly
- *	and never do a direct kref_put().
- **/
-static void sr_kref_release(struct kref *kref)
-{
-	struct scsi_cd *cd = container_of(kref, struct scsi_cd, kref);
-	struct gendisk *disk = cd->disk;
-
-	spin_lock(&sr_index_lock);
-	clear_bit(MINOR(disk_devt(disk)), sr_index_bits);
-	spin_unlock(&sr_index_lock);
-
-	unregister_cdrom(&cd->cdi);
-
-	disk->private_data = NULL;
-
-	put_disk(disk);
-
-	mutex_destroy(&cd->lock);
-
-	kfree(cd);
-}
-
 static int sr_remove(struct device *dev)
 {
 	struct scsi_cd *cd = dev_get_drvdata(dev);
@@ -1046,11 +978,7 @@ static int sr_remove(struct device *dev)
 	scsi_autopm_get_device(cd->device);
 
 	del_gendisk(cd->disk);
-	dev_set_drvdata(dev, NULL);
-
-	mutex_lock(&sr_ref_mutex);
-	kref_put(&cd->kref, sr_kref_release);
-	mutex_unlock(&sr_ref_mutex);
+	put_disk(cd->disk);
 
 	return 0;
 }
diff --git a/drivers/scsi/sr.h b/drivers/scsi/sr.h
index d80af3fcb6f97..1175f2e213b56 100644
--- a/drivers/scsi/sr.h
+++ b/drivers/scsi/sr.h
@@ -18,7 +18,6 @@
 #ifndef _SR_H
 #define _SR_H
 
-#include <linux/kref.h>
 #include <linux/mutex.h>
 
 #define MAX_RETRIES	3
@@ -51,9 +50,6 @@ typedef struct scsi_cd {
 
 	struct cdrom_device_info cdi;
 	struct mutex lock;
-	/* We hold gendisk and scsi_device references on probe and use
-	 * the refs on this kref to decide when to release them */
-	struct kref kref;
 	struct gendisk *disk;
 } Scsi_CD;
 
-- 
2.30.2

