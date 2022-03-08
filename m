Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F64E4D0F8D
	for <lists+linux-scsi@lfdr.de>; Tue,  8 Mar 2022 06:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344378AbiCHFxg (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 8 Mar 2022 00:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343782AbiCHFxe (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 8 Mar 2022 00:53:34 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BDBD7F;
        Mon,  7 Mar 2022 21:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=gE6pOLmsfSp3ZRv8RixKxwhCbuvenlNJg6rpkeQQsVM=; b=AFnRXTQzI0EfNaZw9q4XGbehjE
        UIzSMH5XdPW3yd1SMGXizYWEU3ywhiEEvIbUva2LOZAy0pfH5GUIjWj7PKxxWxGh/5Y4JWy7Myf1l
        eJA8ld+cUyw9z+oMuuvRGUgJzdqNU1hr9gwR8egZmbrkEGFr+iQ8nYqB62i2bRlc/z6LkGNqohLt9
        NXd3E4afOZ/l/SOvOrpGhj+EOUyiPSBBJKfGIhuMlF4FZfF1LrprlLB7OmxV3H6H2LvDr5Ob37UAo
        OeT5MNWyMzNt4aecieTq+MGRx5B1nGPM5VWCD1WUJ8JYB9X2RTSkySDdp5ZcxzxUjxeC7DeKaB9Gx
        iWiPrAjw==;
Received: from [2001:4bb8:184:7746:6f50:7a98:3141:c37b] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nRSlf-002ioY-Px; Tue, 08 Mar 2022 05:52:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 07/14] sd: implement ->free_disk to simplify refcounting
Date:   Tue,  8 Mar 2022 06:51:53 +0100
Message-Id: <20220308055200.735835-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220308055200.735835-1-hch@lst.de>
References: <20220308055200.735835-1-hch@lst.de>
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

Implement the ->free_disk method to to put struct scsi_disk when the last
gendisk reference count goes away.  This removes the need to clear
->private_data and thus freeze the queue on unbind.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 drivers/scsi/sd.c | 90 +++++++++--------------------------------------
 1 file changed, 16 insertions(+), 74 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 346b8d62de7d1..73e6f5f0f37c2 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -121,11 +121,6 @@ static void scsi_disk_release(struct device *cdev);
 
 static DEFINE_IDA(sd_index_ida);
 
-/* This semaphore is used to mediate the 0->1 reference get in the
- * face of object destruction (i.e. we can't allow a get on an
- * object after last put) */
-static DEFINE_MUTEX(sd_ref_mutex);
-
 static struct kmem_cache *sd_cdb_cache;
 static mempool_t *sd_cdb_pool;
 static mempool_t *sd_page_pool;
@@ -663,33 +658,6 @@ static int sd_major(int major_idx)
 	}
 }
 
-static struct scsi_disk *scsi_disk_get(struct gendisk *disk)
-{
-	struct scsi_disk *sdkp = NULL;
-
-	mutex_lock(&sd_ref_mutex);
-
-	if (disk->private_data) {
-		sdkp = scsi_disk(disk);
-		if (scsi_device_get(sdkp->device) == 0)
-			get_device(&sdkp->disk_dev);
-		else
-			sdkp = NULL;
-	}
-	mutex_unlock(&sd_ref_mutex);
-	return sdkp;
-}
-
-static void scsi_disk_put(struct scsi_disk *sdkp)
-{
-	struct scsi_device *sdev = sdkp->device;
-
-	mutex_lock(&sd_ref_mutex);
-	put_device(&sdkp->disk_dev);
-	scsi_device_put(sdev);
-	mutex_unlock(&sd_ref_mutex);
-}
-
 #ifdef CONFIG_BLK_SED_OPAL
 static int sd_sec_submit(void *data, u16 spsp, u8 secp, void *buffer,
 		size_t len, bool send)
@@ -1418,17 +1386,15 @@ static bool sd_need_revalidate(struct block_device *bdev,
  **/
 static int sd_open(struct block_device *bdev, fmode_t mode)
 {
-	struct scsi_disk *sdkp = scsi_disk_get(bdev->bd_disk);
-	struct scsi_device *sdev;
+	struct scsi_disk *sdkp = scsi_disk(bdev->bd_disk);
+	struct scsi_device *sdev = sdkp->device;
 	int retval;
 
-	if (!sdkp)
+	if (scsi_device_get(sdev))
 		return -ENXIO;
 
 	SCSI_LOG_HLQUEUE(3, sd_printk(KERN_INFO, sdkp, "sd_open\n"));
 
-	sdev = sdkp->device;
-
 	/*
 	 * If the device is in error recovery, wait until it is done.
 	 * If the device is offline, then disallow any access to it.
@@ -1473,7 +1439,7 @@ static int sd_open(struct block_device *bdev, fmode_t mode)
 	return 0;
 
 error_out:
-	scsi_disk_put(sdkp);
+	scsi_device_put(sdev);
 	return retval;	
 }
 
@@ -1502,7 +1468,7 @@ static void sd_release(struct gendisk *disk, fmode_t mode)
 			scsi_set_medium_removal(sdev, SCSI_REMOVAL_ALLOW);
 	}
 
-	scsi_disk_put(sdkp);
+	scsi_device_put(sdev);
 }
 
 static int sd_getgeo(struct block_device *bdev, struct hd_geometry *geo)
@@ -1616,7 +1582,7 @@ static int media_not_present(struct scsi_disk *sdkp,
  **/
 static unsigned int sd_check_events(struct gendisk *disk, unsigned int clearing)
 {
-	struct scsi_disk *sdkp = scsi_disk_get(disk);
+	struct scsi_disk *sdkp = disk->private_data;
 	struct scsi_device *sdp;
 	int retval;
 	bool disk_changed;
@@ -1679,7 +1645,6 @@ static unsigned int sd_check_events(struct gendisk *disk, unsigned int clearing)
 	 */
 	disk_changed = sdp->changed;
 	sdp->changed = 0;
-	scsi_disk_put(sdkp);
 	return disk_changed ? DISK_EVENT_MEDIA_CHANGE : 0;
 }
 
@@ -1887,6 +1852,13 @@ static const struct pr_ops sd_pr_ops = {
 	.pr_clear	= sd_pr_clear,
 };
 
+static void scsi_disk_free_disk(struct gendisk *disk)
+{
+	struct scsi_disk *sdkp = scsi_disk(disk);
+
+	put_device(&sdkp->disk_dev);
+}
+
 static const struct block_device_operations sd_fops = {
 	.owner			= THIS_MODULE,
 	.open			= sd_open,
@@ -1898,6 +1870,7 @@ static const struct block_device_operations sd_fops = {
 	.unlock_native_capacity	= sd_unlock_native_capacity,
 	.report_zones		= sd_zbc_report_zones,
 	.get_unique_id		= sd_get_unique_id,
+	.free_disk		= scsi_disk_free_disk,
 	.pr_ops			= &sd_pr_ops,
 };
 
@@ -3623,54 +3596,23 @@ static int sd_probe(struct device *dev)
  **/
 static int sd_remove(struct device *dev)
 {
-	struct scsi_disk *sdkp;
+	struct scsi_disk *sdkp = dev_get_drvdata(dev);
 
-	sdkp = dev_get_drvdata(dev);
 	scsi_autopm_get_device(sdkp->device);
 
 	device_del(&sdkp->disk_dev);
 	del_gendisk(sdkp->disk);
 	sd_shutdown(dev);
 
-	mutex_lock(&sd_ref_mutex);
-	dev_set_drvdata(dev, NULL);
-	put_device(&sdkp->disk_dev);
-	mutex_unlock(&sd_ref_mutex);
-
+	put_disk(sdkp->disk);
 	return 0;
 }
 
-/**
- *	scsi_disk_release - Called to free the scsi_disk structure
- *	@dev: pointer to embedded class device
- *
- *	sd_ref_mutex must be held entering this routine.  Because it is
- *	called on last put, you should always use the scsi_disk_get()
- *	scsi_disk_put() helpers which manipulate the semaphore directly
- *	and never do a direct put_device.
- **/
 static void scsi_disk_release(struct device *dev)
 {
 	struct scsi_disk *sdkp = to_scsi_disk(dev);
-	struct gendisk *disk = sdkp->disk;
-	struct request_queue *q = disk->queue;
 
 	ida_free(&sd_index_ida, sdkp->index);
-
-	/*
-	 * Wait until all requests that are in progress have completed.
-	 * This is necessary to avoid that e.g. scsi_end_request() crashes
-	 * due to clearing the disk->private_data pointer. Wait from inside
-	 * scsi_disk_release() instead of from sd_release() to avoid that
-	 * freezing and unfreezing the request queue affects user space I/O
-	 * in case multiple processes open a /dev/sd... node concurrently.
-	 */
-	blk_mq_freeze_queue(q);
-	blk_mq_unfreeze_queue(q);
-
-	disk->private_data = NULL;
-	put_disk(disk);
-
 	sd_zbc_release_disk(sdkp);
 	put_device(&sdkp->device->sdev_gendev);
 	free_opal_dev(sdkp->opal_dev);
-- 
2.30.2

