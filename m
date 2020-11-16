Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF18E2B3F8A
	for <lists+linux-scsi@lfdr.de>; Mon, 16 Nov 2020 10:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbgKPJJI (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 16 Nov 2020 04:09:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52966 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728529AbgKPJJH (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 16 Nov 2020 04:09:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605517745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ab5DBe1y7ZWbLGHoAKBfk0vA0UPCC0llONW4dnHQ7Xw=;
        b=cFy7AHqYApftvTOEz19x2Apj7O/uMVH/OaZrc73tWKbrK6YLC8slwGw+ItcOX0EMzNhXB3
        zxNtDdPhQ9vkfiomPMmLsrgiRIJGKLD8PAG/eyrEz0WExNsOPdchUlyUG7zkrrqBXKHREF
        8RPiW6Z15Xt0Ht6L+BQr7kVMPNwFTDU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-SJMneMTOPVGeNdwDvsQa8Q-1; Mon, 16 Nov 2020 04:09:03 -0500
X-MC-Unique: SJMneMTOPVGeNdwDvsQa8Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 904C41007B02;
        Mon, 16 Nov 2020 09:09:01 +0000 (UTC)
Received: from localhost (ovpn-13-166.pek2.redhat.com [10.72.13.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8FCA45B4BF;
        Mon, 16 Nov 2020 09:08:57 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@fb.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumanesh Samanta <sumanesh.samanta@broadcom.com>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH V4 12/12] scsi: replace sdev->device_busy with sbitmap
Date:   Mon, 16 Nov 2020 17:07:37 +0800
Message-Id: <20201116090737.50989-13-ming.lei@redhat.com>
In-Reply-To: <20201116090737.50989-1-ming.lei@redhat.com>
References: <20201116090737.50989-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

scsi requires one global atomic variable to track queue depth for each LUN/
request queue, meantime blk-mq tracks queue depth for each hctx. This SCSI's
requirement can't be implemented in blk-mq easily, cause it is a bigger &
harder problem to spread the device or request queue's depth among all hw
queues.

The current approach by using atomic variable can't scale well when there
is lots of CPU cores and the disk is very fast and IO are submitted to this
device concurrently. It has been observed that IOPS is affected a lot by
tracking queue depth via sdev->device_busy in IO path.

So replace the atomic variable sdev->device_busy with sbitmap for
tracking scsi device queue depth.

It is observed that IOPS is improved ~30% by this patchset in the
following test:

1) test machine(32 logical CPU cores)
	Thread(s) per core:  2
	Core(s) per socket:  8
	Socket(s):           2
	NUMA node(s):        2
	Model name:          Intel(R) Xeon(R) Silver 4110 CPU @ 2.10GHz

2) setup scsi_debug:
modprobe scsi_debug virtual_gb=128 max_luns=1 submit_queues=32 delay=0 max_queue=256

3) fio script:
fio --rw=randread --size=128G --direct=1 --ioengine=libaio --iodepth=2048 \
	--numjobs=32 --bs=4k --group_reporting=1 --group_reporting=1 --runtime=60 \
	--loops=10000 --name=job1 --filename=/dev/sdN

[1] https://lore.kernel.org/linux-block/20200119071432.18558-6-ming.lei@redhat.com/

Cc: Omar Sandoval <osandov@fb.com>
Cc: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Sumanesh Samanta <sumanesh.samanta@broadcom.com>
Cc: Ewan D. Milne <emilne@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>
Tested-by: Sumanesh Samanta <sumanesh.samanta@broadcom.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/scsi.c        |  4 +++-
 drivers/scsi/scsi_lib.c    | 33 +++++++++++++++------------------
 drivers/scsi/scsi_priv.h   |  3 +++
 drivers/scsi/scsi_scan.c   | 23 +++++++++++++++++++++--
 drivers/scsi/scsi_sysfs.c  |  2 ++
 include/scsi/scsi_device.h |  5 +++--
 6 files changed, 47 insertions(+), 23 deletions(-)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index a28d48c850cf..e9e2f0e15ac8 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -218,7 +218,7 @@ void scsi_finish_command(struct scsi_cmnd *cmd)
 /*
  * 1024 is big enough for saturating the fast scsi LUN now
  */
-static int scsi_device_max_queue_depth(struct scsi_device *sdev)
+int scsi_device_max_queue_depth(struct scsi_device *sdev)
 {
 	return max_t(int, sdev->host->can_queue, 1024);
 }
@@ -242,6 +242,8 @@ int scsi_change_queue_depth(struct scsi_device *sdev, int depth)
 	if (sdev->request_queue)
 		blk_set_queue_depth(sdev->request_queue, depth);
 
+	sbitmap_resize(&sdev->budget_map, sdev->queue_depth);
+
 	return sdev->queue_depth;
 }
 EXPORT_SYMBOL(scsi_change_queue_depth);
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 4709418c47e0..f5b675d02929 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -327,7 +327,7 @@ void scsi_device_unbusy(struct scsi_device *sdev, struct scsi_cmnd *cmd)
 	if (starget->can_queue > 0)
 		atomic_dec(&starget->target_busy);
 
-	atomic_dec(&sdev->device_busy);
+	sbitmap_put(&sdev->budget_map, cmd->budget_token);
 	cmd->budget_token = -1;
 }
 
@@ -1250,19 +1250,17 @@ scsi_device_state_check(struct scsi_device *sdev, struct request *req)
 }
 
 /*
- * scsi_dev_queue_ready: if we can send requests to sdev, return 1 else
- * return 0.
- *
- * Called with the queue_lock held.
+ * scsi_dev_queue_ready: if we can send requests to sdev, assign one token
+ * and return the token else return -1.
  */
 static inline int scsi_dev_queue_ready(struct request_queue *q,
 				  struct scsi_device *sdev)
 {
-	unsigned int busy;
+	int token;
 
-	busy = atomic_inc_return(&sdev->device_busy) - 1;
+	token = sbitmap_get(&sdev->budget_map);
 	if (atomic_read(&sdev->device_blocked)) {
-		if (busy)
+		if (token >= 0)
 			goto out_dec;
 
 		/*
@@ -1274,13 +1272,11 @@ static inline int scsi_dev_queue_ready(struct request_queue *q,
 				   "unblocking device at zero depth\n"));
 	}
 
-	if (busy >= sdev->queue_depth)
-		goto out_dec;
-
-	return 1;
+	return token;
 out_dec:
-	atomic_dec(&sdev->device_busy);
-	return 0;
+	if (token >= 0)
+		sbitmap_put(&sdev->budget_map, token);
+	return -1;
 }
 
 /*
@@ -1605,15 +1601,16 @@ static void scsi_mq_put_budget(struct request_queue *q, int budget_token)
 {
 	struct scsi_device *sdev = q->queuedata;
 
-	atomic_dec(&sdev->device_busy);
+	sbitmap_put(&sdev->budget_map, budget_token);
 }
 
 static int scsi_mq_get_budget(struct request_queue *q)
 {
 	struct scsi_device *sdev = q->queuedata;
+	int token = scsi_dev_queue_ready(q, sdev);
 
-	if (scsi_dev_queue_ready(q, sdev))
-		return 0;
+	if (token >= 0)
+		return token;
 
 	atomic_inc(&sdev->restarts);
 
@@ -1723,7 +1720,7 @@ static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
 		break;
 	case BLK_STS_RESOURCE:
 	case BLK_STS_ZONE_RESOURCE:
-		if (atomic_read(&sdev->device_busy) ||
+		if (sbitmap_any_bit_set(&sdev->budget_map) ||
 		    scsi_device_blocked(sdev))
 			ret = BLK_STS_DEV_RESOURCE;
 		break;
diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
index 180636d54982..30b35002d2f8 100644
--- a/drivers/scsi/scsi_priv.h
+++ b/drivers/scsi/scsi_priv.h
@@ -5,6 +5,7 @@
 #include <linux/device.h>
 #include <linux/async.h>
 #include <scsi/scsi_device.h>
+#include <linux/sbitmap.h>
 
 struct request_queue;
 struct request;
@@ -182,6 +183,8 @@ static inline void scsi_dh_add_device(struct scsi_device *sdev) { }
 static inline void scsi_dh_release_device(struct scsi_device *sdev) { }
 #endif
 
+extern int scsi_device_max_queue_depth(struct scsi_device *sdev);
+
 /* 
  * internal scsi timeout functions: for use by mid-layer and transport
  * classes.
diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index 9af50e6f94c4..9f1b7f3c650a 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -215,6 +215,7 @@ static void scsi_unlock_floptical(struct scsi_device *sdev,
 static struct scsi_device *scsi_alloc_sdev(struct scsi_target *starget,
 					   u64 lun, void *hostdata)
 {
+	unsigned int depth;
 	struct scsi_device *sdev;
 	int display_failure_msg = 1, ret;
 	struct Scsi_Host *shost = dev_to_shost(starget->dev.parent);
@@ -276,8 +277,25 @@ static struct scsi_device *scsi_alloc_sdev(struct scsi_target *starget,
 	WARN_ON_ONCE(!blk_get_queue(sdev->request_queue));
 	sdev->request_queue->queuedata = sdev;
 
-	scsi_change_queue_depth(sdev, sdev->host->cmd_per_lun ?
-					sdev->host->cmd_per_lun : 1);
+	depth = sdev->host->cmd_per_lun ?: 1;
+
+	/*
+	 * Use .can_queue as budget map's depth because we have to
+	 * support adjusting queue depth from sysfs. Meantime use
+	 * default device queue depth to figure out sbitmap shift
+	 * since we use this queue depth most of times.
+	 */
+	if (sbitmap_init_node(&sdev->budget_map,
+				scsi_device_max_queue_depth(sdev),
+				sbitmap_calculate_shift(depth),
+				GFP_KERNEL, sdev->request_queue->node,
+				false, true)) {
+		put_device(&starget->dev);
+		kfree(sdev);
+		goto out;
+	}
+
+	scsi_change_queue_depth(sdev, depth);
 
 	scsi_sysfs_device_initialize(sdev);
 
@@ -979,6 +997,7 @@ static int scsi_add_lun(struct scsi_device *sdev, unsigned char *inq_result,
 		scsi_attach_vpd(sdev);
 
 	sdev->max_queue_depth = sdev->queue_depth;
+	WARN_ON_ONCE(sdev->max_queue_depth > sdev->budget_map.depth);
 	sdev->sdev_bflags = *bflags;
 
 	/*
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index ef5c79037bde..79c36cfdb84b 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -477,6 +477,8 @@ static void scsi_device_dev_release_usercontext(struct work_struct *work)
 	/* NULL queue means the device can't be used */
 	sdev->request_queue = NULL;
 
+	sbitmap_free(&sdev->budget_map);
+
 	mutex_lock(&sdev->inquiry_mutex);
 	vpd_pg0 = rcu_replace_pointer(sdev->vpd_pg0, vpd_pg0,
 				       lockdep_is_held(&sdev->inquiry_mutex));
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index dd0b9f690a26..05c7c320ef32 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -8,6 +8,7 @@
 #include <linux/blkdev.h>
 #include <scsi/scsi.h>
 #include <linux/atomic.h>
+#include <linux/sbitmap.h>
 
 struct device;
 struct request_queue;
@@ -106,7 +107,7 @@ struct scsi_device {
 	struct list_head    siblings;   /* list of all devices on this host */
 	struct list_head    same_target_siblings; /* just the devices sharing same target id */
 
-	atomic_t device_busy;		/* commands actually active on LLDD */
+	struct sbitmap budget_map;
 	atomic_t device_blocked;	/* Device returned QUEUE_FULL. */
 
 	atomic_t restarts;
@@ -592,7 +593,7 @@ static inline int scsi_device_supports_vpd(struct scsi_device *sdev)
 
 static inline int scsi_device_busy(struct scsi_device *sdev)
 {
-	return atomic_read(&sdev->device_busy);
+	return sbitmap_weight(&sdev->budget_map);
 }
 
 #define MODULE_ALIAS_SCSI_DEVICE(type) \
-- 
2.25.4

