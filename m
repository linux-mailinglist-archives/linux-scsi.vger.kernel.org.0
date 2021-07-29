Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3200B3D9DE3
	for <lists+linux-scsi@lfdr.de>; Thu, 29 Jul 2021 08:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbhG2Gwd (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 29 Jul 2021 02:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234420AbhG2Gwd (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 29 Jul 2021 02:52:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5FEC061757;
        Wed, 28 Jul 2021 23:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=hXXuLh6xFTxvgFd7UlenUMAI0oNjwTAqpTwtSpTjOiM=; b=U2rrCcuforsOyp8r5KjM22d/Gr
        o4xwsAKntCakLtc//IleO6ds/LgUsDmmzFeW42rwxi/TOUcYELmSqoH4VcBb5X/H+VKfWOpXmrh5L
        1Jy8zTBAbHPKvKygKhvhnSnxjQS7zWJFi4xy6M1F10wvgyi29jJ7VRPQ5oMyaK1V02LgnD//r477G
        M6aMya7eCMvzPF8oew1crjzMo8djQDZMqSWHEvDjg66F+86s729Soxc0syK/sldm7MC3RrNEdSFfx
        3hwbfcaXdos1KUElcHzkJvTC72Jb3cVdUCKnr3GsevXo4rBiFQKRO97VfIl8eXTiDIv7qoGuRVxeh
        ChPkDzfw==;
Received: from [2001:4bb8:184:87c5:8c88:c313:79e2:b780] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8zt8-00GnlU-6t; Thu, 29 Jul 2021 06:51:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 4/4] bsg: move the whole request execution into the scsi/transport handlers
Date:   Thu, 29 Jul 2021 08:48:45 +0200
Message-Id: <20210729064845.1044147-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210729064845.1044147-1-hch@lst.de>
References: <20210729064845.1044147-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Remove the amount of indirect calls by making the handler responsible
for the entire execution of the request.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bsg-lib.c         | 80 ++++++++++++++++++++---------------------
 block/bsg.c             | 66 ++++++++--------------------------
 drivers/scsi/scsi_bsg.c | 69 +++++++++++++++++++----------------
 include/linux/bsg.h     | 12 ++-----
 4 files changed, 96 insertions(+), 131 deletions(-)

diff --git a/block/bsg-lib.c b/block/bsg-lib.c
index fe43f5fda6e5..239ebf747141 100644
--- a/block/bsg-lib.c
+++ b/block/bsg-lib.c
@@ -25,32 +25,39 @@ struct bsg_set {
 	bsg_timeout_fn		*timeout_fn;
 };
 
-static int bsg_transport_check_proto(struct sg_io_v4 *hdr)
+static int bsg_transport_sg_io_fn(struct request_queue *q, struct sg_io_v4 *hdr,
+		fmode_t mode, unsigned int timeout)
 {
+	struct bsg_job *job;
+	struct request *rq;
+	struct bio *bio;
+	int ret;
+
 	if (hdr->protocol != BSG_PROTOCOL_SCSI  ||
 	    hdr->subprotocol != BSG_SUB_PROTOCOL_SCSI_TRANSPORT)
 		return -EINVAL;
 	if (!capable(CAP_SYS_RAWIO))
 		return -EPERM;
-	return 0;
-}
 
-static int bsg_transport_fill_hdr(struct request *rq, struct sg_io_v4 *hdr,
-		fmode_t mode)
-{
-	struct bsg_job *job = blk_mq_rq_to_pdu(rq);
-	int ret;
+	rq = blk_get_request(q, hdr->dout_xfer_len ?
+			     REQ_OP_DRV_OUT : REQ_OP_DRV_IN, 0);
+	if (IS_ERR(rq))
+		return PTR_ERR(rq);
+	rq->timeout = timeout;
 
+	job = blk_mq_rq_to_pdu(rq);
 	job->request_len = hdr->request_len;
 	job->request = memdup_user(uptr64(hdr->request), hdr->request_len);
-	if (IS_ERR(job->request))
-		return PTR_ERR(job->request);
+	if (IS_ERR(job->request)) {
+		ret = PTR_ERR(job->request);
+		goto out_put_request;
+	}
 
 	if (hdr->dout_xfer_len && hdr->din_xfer_len) {
 		job->bidi_rq = blk_get_request(rq->q, REQ_OP_DRV_IN, 0);
 		if (IS_ERR(job->bidi_rq)) {
 			ret = PTR_ERR(job->bidi_rq);
-			goto out;
+			goto out_free_job_request;
 		}
 
 		ret = blk_rq_map_user(rq->q, job->bidi_rq, NULL,
@@ -65,20 +72,19 @@ static int bsg_transport_fill_hdr(struct request *rq, struct sg_io_v4 *hdr,
 		job->bidi_bio = NULL;
 	}
 
-	return 0;
+	if (hdr->dout_xfer_len) {
+		ret = blk_rq_map_user(rq->q, rq, NULL, uptr64(hdr->dout_xferp),
+				hdr->dout_xfer_len, GFP_KERNEL);
+	} else if (hdr->din_xfer_len) {
+		ret = blk_rq_map_user(rq->q, rq, NULL, uptr64(hdr->din_xferp),
+				hdr->din_xfer_len, GFP_KERNEL);
+	}
 
-out_free_bidi_rq:
-	if (job->bidi_rq)
-		blk_put_request(job->bidi_rq);
-out:
-	kfree(job->request);
-	return ret;
-}
+	if (ret)
+		goto out_unmap_bidi_rq;
 
-static int bsg_transport_complete_rq(struct request *rq, struct sg_io_v4 *hdr)
-{
-	struct bsg_job *job = blk_mq_rq_to_pdu(rq);
-	int ret = 0;
+	bio = rq->bio;
+	blk_execute_rq(NULL, rq, !(hdr->flags & BSG_FLAG_Q_AT_TAIL));
 
 	/*
 	 * The assignments below don't make much sense, but are kept for
@@ -121,28 +127,20 @@ static int bsg_transport_complete_rq(struct request *rq, struct sg_io_v4 *hdr)
 		hdr->din_resid = 0;
 	}
 
-	return ret;
-}
-
-static void bsg_transport_free_rq(struct request *rq)
-{
-	struct bsg_job *job = blk_mq_rq_to_pdu(rq);
-
-	if (job->bidi_rq) {
+	blk_rq_unmap_user(bio);
+out_unmap_bidi_rq:
+	if (job->bidi_rq)
 		blk_rq_unmap_user(job->bidi_bio);
+out_free_bidi_rq:
+	if (job->bidi_rq)
 		blk_put_request(job->bidi_rq);
-	}
-
+out_free_job_request:
 	kfree(job->request);
+out_put_request:
+	blk_put_request(rq);
+	return ret;
 }
 
-static const struct bsg_ops bsg_transport_ops = {
-	.check_proto		= bsg_transport_check_proto,
-	.fill_hdr		= bsg_transport_fill_hdr,
-	.complete_rq		= bsg_transport_complete_rq,
-	.free_rq		= bsg_transport_free_rq,
-};
-
 /**
  * bsg_teardown_job - routine to teardown a bsg job
  * @kref: kref inside bsg_job that is to be torn down
@@ -398,7 +396,7 @@ struct request_queue *bsg_setup_queue(struct device *dev, const char *name,
 	q->queuedata = dev;
 	blk_queue_rq_timeout(q, BLK_DEFAULT_SG_TIMEOUT);
 
-	bset->bd = bsg_register_queue(q, dev, name, &bsg_transport_ops);
+	bset->bd = bsg_register_queue(q, dev, name, bsg_transport_sg_io_fn);
 	if (IS_ERR(bset->bd)) {
 		ret = PTR_ERR(bset->bd);
 		goto out_cleanup_queue;
diff --git a/block/bsg.c b/block/bsg.c
index 3ba74eec4ba2..351095193788 100644
--- a/block/bsg.c
+++ b/block/bsg.c
@@ -22,12 +22,12 @@
 
 struct bsg_device {
 	struct request_queue *queue;
-	const struct bsg_ops *ops;
 	struct device device;
 	struct cdev cdev;
 	int max_queue;
 	unsigned int timeout;
 	unsigned int reserved_size;
+	bsg_sg_io_fn *sg_io_fn;
 };
 
 static inline struct bsg_device *to_bsg_device(struct inode *inode)
@@ -42,63 +42,28 @@ static DEFINE_IDA(bsg_minor_ida);
 static struct class *bsg_class;
 static int bsg_major;
 
-#define uptr64(val) ((void __user *)(uintptr_t)(val))
+static unsigned int bsg_timeout(struct bsg_device *bd, struct sg_io_v4 *hdr)
+{
+	unsigned int timeout = BLK_DEFAULT_SG_TIMEOUT;
+
+	if (hdr->timeout)
+		timeout = msecs_to_jiffies(hdr->timeout);
+	else if (bd->timeout)
+		timeout = bd->timeout;
+
+	return max_t(unsigned int, timeout, BLK_MIN_SG_TIMEOUT);
+}
 
 static int bsg_sg_io(struct bsg_device *bd, fmode_t mode, void __user *uarg)
 {
-	struct request *rq;
-	struct bio *bio;
 	struct sg_io_v4 hdr;
 	int ret;
 
 	if (copy_from_user(&hdr, uarg, sizeof(hdr)))
 		return -EFAULT;
-
 	if (hdr.guard != 'Q')
 		return -EINVAL;
-	ret = bd->ops->check_proto(&hdr);
-	if (ret)
-		return ret;
-
-	rq = blk_get_request(bd->queue, hdr.dout_xfer_len ?
-			REQ_OP_DRV_OUT : REQ_OP_DRV_IN, 0);
-	if (IS_ERR(rq))
-		return PTR_ERR(rq);
-
-	ret = bd->ops->fill_hdr(rq, &hdr, mode);
-	if (ret) {
-		blk_put_request(rq);
-		return ret;
-	}
-
-	rq->timeout = msecs_to_jiffies(hdr.timeout);
-	if (!rq->timeout)
-		rq->timeout = bd->timeout;
-	if (!rq->timeout)
-		rq->timeout = BLK_DEFAULT_SG_TIMEOUT;
-	if (rq->timeout < BLK_MIN_SG_TIMEOUT)
-		rq->timeout = BLK_MIN_SG_TIMEOUT;
-
-	if (hdr.dout_xfer_len) {
-		ret = blk_rq_map_user(rq->q, rq, NULL, uptr64(hdr.dout_xferp),
-				hdr.dout_xfer_len, GFP_KERNEL);
-	} else if (hdr.din_xfer_len) {
-		ret = blk_rq_map_user(rq->q, rq, NULL, uptr64(hdr.din_xferp),
-				hdr.din_xfer_len, GFP_KERNEL);
-	}
-
-	if (ret)
-		goto out_free_rq;
-
-	bio = rq->bio;
-
-	blk_execute_rq(NULL, rq, !(hdr.flags & BSG_FLAG_Q_AT_TAIL));
-	ret = bd->ops->complete_rq(rq, &hdr);
-	blk_rq_unmap_user(bio);
-
-out_free_rq:
-	bd->ops->free_rq(rq);
-	blk_put_request(rq);
+	ret = bd->sg_io_fn(bd->queue, &hdr, mode, bsg_timeout(bd, &hdr));
 	if (!ret && copy_to_user(uarg, &hdr, sizeof(hdr)))
 		return -EFAULT;
 	return ret;
@@ -211,8 +176,7 @@ void bsg_unregister_queue(struct bsg_device *bd)
 EXPORT_SYMBOL_GPL(bsg_unregister_queue);
 
 struct bsg_device *bsg_register_queue(struct request_queue *q,
-		struct device *parent, const char *name,
-		const struct bsg_ops *ops)
+		struct device *parent, const char *name, bsg_sg_io_fn *sg_io_fn)
 {
 	struct bsg_device *bd;
 	int ret;
@@ -223,7 +187,7 @@ struct bsg_device *bsg_register_queue(struct request_queue *q,
 	bd->max_queue = BSG_DEFAULT_CMDS;
 	bd->reserved_size = INT_MAX;
 	bd->queue = q;
-	bd->ops = ops;
+	bd->sg_io_fn = sg_io_fn;
 
 	ret = ida_simple_get(&bsg_minor_ida, 0, BSG_MAX_DEVS, GFP_KERNEL);
 	if (ret < 0) {
diff --git a/drivers/scsi/scsi_bsg.c b/drivers/scsi/scsi_bsg.c
index c0d41c45c2be..d13a67b82429 100644
--- a/drivers/scsi/scsi_bsg.c
+++ b/drivers/scsi/scsi_bsg.c
@@ -9,42 +9,57 @@
 
 #define uptr64(val) ((void __user *)(uintptr_t)(val))
 
-static int scsi_bsg_check_proto(struct sg_io_v4 *hdr)
+static int scsi_bsg_sg_io_fn(struct request_queue *q, struct sg_io_v4 *hdr,
+		fmode_t mode, unsigned int timeout)
 {
+	struct scsi_request *sreq;
+	struct request *rq;
+	struct bio *bio;
+	int ret;
+
 	if (hdr->protocol != BSG_PROTOCOL_SCSI  ||
 	    hdr->subprotocol != BSG_SUB_PROTOCOL_SCSI_CMD)
 		return -EINVAL;
-	return 0;
-}
-
-static int scsi_bsg_fill_hdr(struct request *rq, struct sg_io_v4 *hdr,
-		fmode_t mode)
-{
-	struct scsi_request *sreq = scsi_req(rq);
-
 	if (hdr->dout_xfer_len && hdr->din_xfer_len) {
 		pr_warn_once("BIDI support in bsg has been removed.\n");
 		return -EOPNOTSUPP;
 	}
 
+	rq = blk_get_request(q, hdr->dout_xfer_len ?
+			     REQ_OP_DRV_OUT : REQ_OP_DRV_IN, 0);
+	if (IS_ERR(rq))
+		return PTR_ERR(rq);
+	rq->timeout = timeout;
+
+	ret = -ENOMEM;
+	sreq = scsi_req(rq);
 	sreq->cmd_len = hdr->request_len;
 	if (sreq->cmd_len > BLK_MAX_CDB) {
 		sreq->cmd = kzalloc(sreq->cmd_len, GFP_KERNEL);
 		if (!sreq->cmd)
-			return -ENOMEM;
+			goto out_put_request;
 	}
 
+	ret = -EFAULT;
 	if (copy_from_user(sreq->cmd, uptr64(hdr->request), sreq->cmd_len))
-		return -EFAULT;
+		goto out_free_cmd;
+	ret = -EPERM;
 	if (!scsi_cmd_allowed(sreq->cmd, mode))
-		return -EPERM;
-	return 0;
-}
+		goto out_free_cmd;
 
-static int scsi_bsg_complete_rq(struct request *rq, struct sg_io_v4 *hdr)
-{
-	struct scsi_request *sreq = scsi_req(rq);
-	int ret = 0;
+	if (hdr->dout_xfer_len) {
+		ret = blk_rq_map_user(rq->q, rq, NULL, uptr64(hdr->dout_xferp),
+				hdr->dout_xfer_len, GFP_KERNEL);
+	} else if (hdr->din_xfer_len) {
+		ret = blk_rq_map_user(rq->q, rq, NULL, uptr64(hdr->din_xferp),
+				hdr->din_xfer_len, GFP_KERNEL);
+	}
+
+	if (ret)
+		goto out_free_cmd;
+
+	bio = rq->bio;
+	blk_execute_rq(NULL, rq, !(hdr->flags & BSG_FLAG_Q_AT_TAIL));
 
 	/*
 	 * fill in all the output members
@@ -74,23 +89,17 @@ static int scsi_bsg_complete_rq(struct request *rq, struct sg_io_v4 *hdr)
 	else
 		hdr->dout_resid = sreq->resid_len;
 
-	return ret;
-}
+	blk_rq_unmap_user(bio);
 
-static void scsi_bsg_free_rq(struct request *rq)
-{
+out_free_cmd:
 	scsi_req_free_cmd(scsi_req(rq));
+out_put_request:
+	blk_put_request(rq);
+	return ret;
 }
 
-static const struct bsg_ops scsi_bsg_ops = {
-	.check_proto		= scsi_bsg_check_proto,
-	.fill_hdr		= scsi_bsg_fill_hdr,
-	.complete_rq		= scsi_bsg_complete_rq,
-	.free_rq		= scsi_bsg_free_rq,
-};
-
 struct bsg_device *scsi_bsg_register_queue(struct scsi_device *sdev)
 {
 	return bsg_register_queue(sdev->request_queue, &sdev->sdev_gendev,
-				  dev_name(&sdev->sdev_gendev), &scsi_bsg_ops);
+			dev_name(&sdev->sdev_gendev), scsi_bsg_sg_io_fn);
 }
diff --git a/include/linux/bsg.h b/include/linux/bsg.h
index fa21f79beda2..1ac81c809da9 100644
--- a/include/linux/bsg.h
+++ b/include/linux/bsg.h
@@ -6,20 +6,14 @@
 
 struct bsg_device;
 struct device;
-struct request;
 struct request_queue;
 
-struct bsg_ops {
-	int	(*check_proto)(struct sg_io_v4 *hdr);
-	int	(*fill_hdr)(struct request *rq, struct sg_io_v4 *hdr,
-				fmode_t mode);
-	int	(*complete_rq)(struct request *rq, struct sg_io_v4 *hdr);
-	void	(*free_rq)(struct request *rq);
-};
+typedef int (bsg_sg_io_fn)(struct request_queue *, struct sg_io_v4 *hdr,
+		fmode_t mode, unsigned int timeout);
 
 struct bsg_device *bsg_register_queue(struct request_queue *q,
 		struct device *parent, const char *name,
-		const struct bsg_ops *ops);
+		bsg_sg_io_fn *sg_io_fn);
 void bsg_unregister_queue(struct bsg_device *bcd);
 
 #endif /* _LINUX_BSG_H */
-- 
2.30.2

