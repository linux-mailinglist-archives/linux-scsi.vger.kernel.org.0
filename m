Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78138274E85
	for <lists+linux-scsi@lfdr.de>; Wed, 23 Sep 2020 03:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgIWBfG (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 22 Sep 2020 21:35:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42597 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727049AbgIWBfG (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 22 Sep 2020 21:35:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600824903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=roOG+1E/eqc6waohZKCYYe4Di6qKCKi4CaFIdS9glHw=;
        b=hss0eP+a+d8kRzhPx1Dnrps/718QaydzRjmJC9wxfvVRdUfnO1V3LxvT9TK7+4eqyYzw7+
        /ySUOclRSFUby96UYT6y5Yn1GHAVdY8kS9U9E+b+TBb9DGost+ankO0F4X1Fkhal/GYBr8
        FQN3gjidA9KxfB+hJUSkyYHAqU9CF3Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-vplUJUzhOaKu4-1QpoQNVw-1; Tue, 22 Sep 2020 21:35:00 -0400
X-MC-Unique: vplUJUzhOaKu4-1QpoQNVw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1B1A80EF8C;
        Wed, 23 Sep 2020 01:34:58 +0000 (UTC)
Received: from localhost (ovpn-12-168.pek2.redhat.com [10.72.12.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3CEC310023A5;
        Wed, 23 Sep 2020 01:34:54 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@fb.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumanesh Samanta <sumanesh.samanta@broadcom.com>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH V3 for 5.11 12/12] scsi: replace sdev->device_busy with sbitmap
Date:   Wed, 23 Sep 2020 09:33:39 +0800
Message-Id: <20200923013339.1621784-13-ming.lei@redhat.com>
In-Reply-To: <20200923013339.1621784-1-ming.lei@redhat.com>
References: <20200923013339.1621784-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/scsi.c        |  2 ++
 drivers/scsi/scsi_lib.c    | 33 +++++++++++++++------------------
 drivers/scsi/scsi_priv.h   |  1 +
 drivers/scsi/scsi_scan.c   | 22 ++++++++++++++++++++--
 drivers/scsi/scsi_sysfs.c  |  2 ++
 include/scsi/scsi_device.h |  5 +++--
 6 files changed, 43 insertions(+), 22 deletions(-)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index cc6ff1ae8c16..d0d23d295260 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -233,6 +233,8 @@ int scsi_change_queue_depth(struct scsi_device *sdev, int depth)
 	if (sdev->request_queue)
 		blk_set_queue_depth(sdev->request_queue, depth);
 
+	sbitmap_resize(&sdev->budget_map, sdev->queue_depth);
+
 	return sdev->queue_depth;
 }
 EXPORT_SYMBOL(scsi_change_queue_depth);
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index e5b336847852..f16bf3118f9a 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -342,7 +342,7 @@ void scsi_device_unbusy(struct scsi_device *sdev, struct scsi_cmnd *cmd)
 	if (starget->can_queue > 0)
 		atomic_dec(&starget->target_busy);
 
-	atomic_dec(&sdev->device_busy);
+	sbitmap_put(&sdev->budget_map, cmd->budget_token);
 	cmd->budget_token = -1;
 }
 
@@ -1282,19 +1282,17 @@ scsi_prep_state_check(struct scsi_device *sdev, struct request *req)
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
@@ -1306,13 +1304,11 @@ static inline int scsi_dev_queue_ready(struct request_queue *q,
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
@@ -1625,15 +1621,16 @@ static void scsi_mq_put_budget(struct request_queue *q, int budget_token)
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
 
@@ -1742,7 +1739,7 @@ static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
 		break;
 	case BLK_STS_RESOURCE:
 	case BLK_STS_ZONE_RESOURCE:
-		if (atomic_read(&sdev->device_busy) ||
+		if (sbitmap_any_bit_set(&sdev->budget_map) ||
 		    scsi_device_blocked(sdev))
 			ret = BLK_STS_DEV_RESOURCE;
 		break;
diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
index d12ada035961..69145a50a5fa 100644
--- a/drivers/scsi/scsi_priv.h
+++ b/drivers/scsi/scsi_priv.h
@@ -5,6 +5,7 @@
 #include <linux/device.h>
 #include <linux/async.h>
 #include <scsi/scsi_device.h>
+#include <linux/sbitmap.h>
 
 struct request_queue;
 struct request;
diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index f2437a7570ce..f674a6ee0a7d 100644
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
@@ -276,8 +277,24 @@ static struct scsi_device *scsi_alloc_sdev(struct scsi_target *starget,
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
+	if (sbitmap_init_node(&sdev->budget_map, sdev->host->can_queue,
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
 
@@ -979,6 +996,7 @@ static int scsi_add_lun(struct scsi_device *sdev, unsigned char *inq_result,
 		scsi_attach_vpd(sdev);
 
 	sdev->max_queue_depth = sdev->queue_depth;
+	WARN_ON_ONCE(sdev->max_queue_depth > sdev->budget_map.depth);
 	sdev->sdev_bflags = *bflags;
 
 	/*
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 6a51827a4e81..396b0307d979 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -466,6 +466,8 @@ static void scsi_device_dev_release_usercontext(struct work_struct *work)
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
2.25.2

