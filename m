Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487B63C43AA
	for <lists+linux-scsi@lfdr.de>; Mon, 12 Jul 2021 07:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbhGLF4T (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 12 Jul 2021 01:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbhGLF4S (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 12 Jul 2021 01:56:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4804BC0613EE;
        Sun, 11 Jul 2021 22:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=URsesX8zonU5gWjyp5hT3HozQQfJ7DJJZDLdYe0CHHA=; b=HJYQZoEq89aPpOxKo8o+5srqwE
        XqGx9RbFeeyza+aDgDpobbL5AixSecv3zR6kkJXHMnS/7TLO7+4F/Mt3Vw/RQj8xgShEUIGgRancH
        GErJsilntQ+EtILj0OsJc8bpg8H47KPviE4zkQnWzFOQi3U30inmnoh00TDgTPU/InoNBhWR290s8
        lzgusQEGVhaEdzKnp14RcNzHkeeyScH9kIsGCyNdhwPlt7qSqUKlYruMLHgTCQK67EFYE5r2Mo5Pn
        s9jBu7XOJSHJvKduvL69bdl3QHNLUjm1ccmMDrIsx50FR6hLp2UFACx23dmRHqCM55+vHvOnBZ4/n
        iWG7PcLA==;
Received: from [2001:4bb8:184:8b7c:bd9:61b8:39ba:d78a] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2orx-00GvFp-4Q; Mon, 12 Jul 2021 05:52:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc:     Doug Gilbert <dgilbert@interlog.com>,
        =?UTF-8?q?Kai=20M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 10/24] scsi_ioctl: remove scsi_verify_blk_ioctl
Date:   Mon, 12 Jul 2021 07:48:02 +0200
Message-Id: <20210712054816.4147559-11-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210712054816.4147559-1-hch@lst.de>
References: <20210712054816.4147559-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Just verify that the device is no a partition or the caller has admin
privіleges at the beginning of the sr ioctl method manually and open
code the trivial check for sd as well.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/scsi_ioctl.c     | 12 ------------
 drivers/scsi/sd.c      |  8 ++------
 drivers/scsi/sr.c      |  6 +++---
 include/linux/blkdev.h |  1 -
 4 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index f8138438c56f..ca7b84452d9d 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -842,18 +842,6 @@ int scsi_cmd_ioctl(struct request_queue *q, struct gendisk *bd_disk, fmode_t mod
 }
 EXPORT_SYMBOL(scsi_cmd_ioctl);
 
-int scsi_verify_blk_ioctl(struct block_device *bd, unsigned int cmd)
-{
-	if (bd && !bdev_is_partition(bd))
-		return 0;
-
-	if (capable(CAP_SYS_RAWIO))
-		return 0;
-
-	return -ENOIOCTLCMD;
-}
-EXPORT_SYMBOL(scsi_verify_blk_ioctl);
-
 /**
  * scsi_req_init - initialize certain fields of a scsi_request structure
  * @req: Pointer to a scsi_request structure.
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index ca918b0047fa..7c0b15cd8a0f 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1558,9 +1558,8 @@ static int sd_ioctl(struct block_device *bdev, fmode_t mode,
 	SCSI_LOG_IOCTL(1, sd_printk(KERN_INFO, sdkp, "sd_ioctl: disk=%s, "
 				    "cmd=0x%x\n", disk->disk_name, cmd));
 
-	error = scsi_verify_blk_ioctl(bdev, cmd);
-	if (error < 0)
-		return error;
+	if (bdev_is_partition(bdev) && !capable(CAP_SYS_RAWIO))
+		return -ENOIOCTLCMD;
 
 	/*
 	 * If we are in the middle of error recovery, don't let anyone
@@ -1586,9 +1585,6 @@ static int sd_ioctl(struct block_device *bdev, fmode_t mode,
 	case SCSI_IOCTL_GET_BUS_NUMBER:
 		break;
 	default:
-		error = scsi_verify_blk_ioctl(bdev, cmd);
-		if (error < 0)
-			return error;
 		error = scsi_cmd_ioctl(disk->queue, disk, mode, cmd, p);
 		if (error != -ENOTTY)
 			return error;
diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index b903e54c57fd..e6eadba4d638 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -562,6 +562,9 @@ static int sr_block_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
 	void __user *argp = (void __user *)arg;
 	int ret;
 
+	if (bdev_is_partition(bdev) && !capable(CAP_SYS_RAWIO))
+		return -ENOIOCTLCMD;
+
 	mutex_lock(&cd->lock);
 
 	ret = scsi_ioctl_block_when_processing_errors(sdev, cmd,
@@ -580,9 +583,6 @@ static int sr_block_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
 	case SCSI_IOCTL_GET_BUS_NUMBER:
 		break;
 	default:
-		ret = scsi_verify_blk_ioctl(bdev, cmd);
-		if (ret < 0)
-			goto put;
 		ret = scsi_cmd_ioctl(disk->queue, disk, mode, cmd, argp);
 		if (ret != -ENOTTY)
 			goto put;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 19aa3d5429c0..e2b972a85012 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -888,7 +888,6 @@ extern blk_status_t blk_insert_cloned_request(struct request_queue *q,
 				     struct request *rq);
 int blk_rq_append_bio(struct request *rq, struct bio *bio);
 extern void blk_queue_split(struct bio **);
-extern int scsi_verify_blk_ioctl(struct block_device *, unsigned int);
 extern int scsi_cmd_ioctl(struct request_queue *, struct gendisk *, fmode_t,
 			  unsigned int, void __user *);
 extern int sg_scsi_ioctl(struct request_queue *, struct gendisk *, fmode_t,
-- 
2.30.2

