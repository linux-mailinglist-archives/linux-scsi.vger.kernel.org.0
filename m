Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1B1538920
	for <lists+linux-scsi@lfdr.de>; Tue, 31 May 2022 01:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243076AbiE3XPz (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 30 May 2022 19:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233639AbiE3XPo (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 30 May 2022 19:15:44 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC1C71DAB
        for <linux-scsi@vger.kernel.org>; Mon, 30 May 2022 16:15:43 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 073A65A0F1F;
        Mon, 30 May 2022 23:15:43 +0000 (UTC)
Received: from pdx1-sub0-mail-a312.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 4556C5A14FA;
        Mon, 30 May 2022 23:15:42 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1653952542; a=rsa-sha256;
        cv=none;
        b=rIBi/rLonGF3LF6tk6bYXJfq69HMNGVOsxLFHHrQ7Dg0RkD5iQw8MC5NPdRcKZUq499VTn
        F6BGD7xGiidV5Rwd9t1jjeKe9WauSjI43Zzv99IuPWvUbkG7pwS8h3IqSuPB1WMLEDI/oH
        KYVqQ1IQZmU57EZu1XhiA9ksxanb0KV1wlyUG4uyvVCr0HtTiawbUOq117SA1UMbms+Mfe
        sl4m0A6yKhe1zQDyjL7F+kQclJ1sz2f2AS44kjbDBoFnz3xPgnBN+Eh6Iz+C2B7xxhBQaz
        YMCqNro6TKFUbFe374e6BJFXpAK/vYvclMFm1Zk44uRYR9irbvg+1ZBt6eO/dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1653952542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=pKBd6u6q/2SN1T1w2HcEAEHPpfdIA0VzXHcUYKhBS7Q=;
        b=GuyHmQEuEdb5nZhl+mT6ThQ5RkY4ao+6U0mnw7sZETTpjzJDtCnI2QydaRbJOYaujLRbQn
        3/uCr0My3DJS795ZGC//yrQO6xzbqXJ7n6K/DXEe1DzYomMrOtHmZ6r6F5hMod15QsMTEd
        anD+SWPe7mnB9+XTS/5didjVMzJeuTK8sIQcWqpXboBU3aoKsbiuxVKOYd3b84YnH66jAN
        LfhCBJeoijz4VLh6ZIcK3a63brTyhcyes0fa8mrS4gDve4j/MqQOndoBjvrdhqb0Fyp03v
        40Qq0xXDGUwgFszXz8n3nF0jpoaoKjMNSSpfYUTpAPE3Wlxc97tsWTHNkeNwCA==
ARC-Authentication-Results: i=1;
        rspamd-54ff499d4f-2ttcb;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Tank-Name: 7f79b8d90939a8af_1653952542763_3847775782
X-MC-Loop-Signature: 1653952542762:1227645974
X-MC-Ingress-Time: 1653952542762
Received: from pdx1-sub0-mail-a312.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.101.255.183 (trex/6.7.1);
        Mon, 30 May 2022 23:15:42 +0000
Received: from localhost.localdomain (unknown [104.36.31.105])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a312.dreamhost.com (Postfix) with ESMTPSA id 4LBrqd0hJlzlP;
        Mon, 30 May 2022 16:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1653952541;
        bh=pKBd6u6q/2SN1T1w2HcEAEHPpfdIA0VzXHcUYKhBS7Q=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=grqSe0IDLVJTv3Z0LQINO4IL5pPnKs77Bg1TeogCEQG0YVcNqJWgIaxftgo9GU2xp
         YRCJ0DvJzlr4pRWtN4gkzpD/9vGkCO0r2fvnqQ/GIEgi+fqPmru3g+Vp9cC2nU5Gyx
         0gUzRipHYyY4/TOZFbwNCyqlOUlegiK+4kSloxisybTLS69zp9gSTekCg/+lB1lIqd
         ANHW+uh4skBlL2ZZ24IKo17BqsJR2k87LYMWNU+feBKQBP4m8FCWer2Twj87rds4qK
         teKd0zJNz9YSV5BEnZP9CiOa9G2XtgzCy5SZudm6nPy1HdFyF/9oH9gs2HmGcXBMlJ
         3W2lLBH51RaoA==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, ejb@linux.ibm.com,
        bigeasy@linutronix.de, tglx@linutronix.de, dave@stgolabs.net,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 09/10] scsi/ibmvscsi: Replace srp tasklet with work
Date:   Mon, 30 May 2022 16:15:11 -0700
Message-Id: <20220530231512.9729-10-dave@stgolabs.net>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220530231512.9729-1-dave@stgolabs.net>
References: <20220530231512.9729-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Tasklets have long been deprecated as being too heavy on the system
by running in irq context - and this is not a performance critical
path. If a higher priority process wants to run, it must wait for
the tasklet to finish before doing so.

Process srps asynchronously in process context in a dedicated
single threaded workqueue.

Cc: Tyrel Datwyler <tyreld@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/scsi/ibmvscsi/ibmvscsi.c | 38 ++++++++++++++++++++++----------
 drivers/scsi/ibmvscsi/ibmvscsi.h |  3 ++-
 2 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.c b/drivers/scsi/ibmvscsi/ibmvscsi.c
index 63f32f843e75..37cbea8bb0af 100644
--- a/drivers/scsi/ibmvscsi/ibmvscsi.c
+++ b/drivers/scsi/ibmvscsi/ibmvscsi.c
@@ -86,6 +86,8 @@ static DEFINE_SPINLOCK(ibmvscsi_driver_lock);
 
 static struct scsi_transport_template *ibmvscsi_transport_template;
 
+static struct workqueue_struct *ibmvscsi_wq;
+
 #define IBMVSCSI_VERSION "1.5.9"
 
 MODULE_DESCRIPTION("IBM Virtual SCSI");
@@ -117,7 +119,7 @@ static void ibmvscsi_handle_crq(struct viosrp_crq *crq,
  * @irq:	number of irq to handle, not used
  * @dev_instance: ibmvscsi_host_data of host that received interrupt
  *
- * Disables interrupts and schedules srp_task
+ * Disables interrupts and schedules srp_work
  * Always returns IRQ_HANDLED
  */
 static irqreturn_t ibmvscsi_handle_event(int irq, void *dev_instance)
@@ -125,7 +127,7 @@ static irqreturn_t ibmvscsi_handle_event(int irq, void *dev_instance)
 	struct ibmvscsi_host_data *hostdata =
 	    (struct ibmvscsi_host_data *)dev_instance;
 	vio_disable_interrupts(to_vio_dev(hostdata->dev));
-	tasklet_schedule(&hostdata->srp_task);
+	queue_work(ibmvscsi_wq, &hostdata->srp_work);
 	return IRQ_HANDLED;
 }
 
@@ -145,7 +147,7 @@ static void ibmvscsi_release_crq_queue(struct crq_queue *queue,
 	long rc = 0;
 	struct vio_dev *vdev = to_vio_dev(hostdata->dev);
 	free_irq(vdev->irq, (void *)hostdata);
-	tasklet_kill(&hostdata->srp_task);
+	cancel_work_sync(&hostdata->srp_work);
 	do {
 		if (rc)
 			msleep(100);
@@ -206,16 +208,19 @@ static int ibmvscsi_send_crq(struct ibmvscsi_host_data *hostdata,
 }
 
 /**
- * ibmvscsi_task: - Process srps asynchronously
+ * ibmvscsi_workfn: - Process srps asynchronously
  * @data:	ibmvscsi_host_data of host
  */
-static void ibmvscsi_task(void *data)
+static void ibmvscsi_workfn(struct work_struct *work)
 {
-	struct ibmvscsi_host_data *hostdata = (struct ibmvscsi_host_data *)data;
-	struct vio_dev *vdev = to_vio_dev(hostdata->dev);
+	struct ibmvscsi_host_data *hostdata;
+	struct vio_dev *vdev;
 	struct viosrp_crq *crq;
 	int done = 0;
 
+	hostdata = container_of(work, struct ibmvscsi_host_data, srp_work);
+	vdev = to_vio_dev(hostdata->dev);
+
 	while (!done) {
 		/* Pull all the valid messages off the CRQ */
 		while ((crq = crq_queue_next_crq(&hostdata->queue)) != NULL) {
@@ -367,8 +372,7 @@ static int ibmvscsi_init_crq_queue(struct crq_queue *queue,
 	queue->cur = 0;
 	spin_lock_init(&queue->lock);
 
-	tasklet_init(&hostdata->srp_task, (void *)ibmvscsi_task,
-		     (unsigned long)hostdata);
+	INIT_WORK(&hostdata->srp_work, ibmvscsi_workfn);
 
 	if (request_irq(vdev->irq,
 			ibmvscsi_handle_event,
@@ -387,7 +391,7 @@ static int ibmvscsi_init_crq_queue(struct crq_queue *queue,
 	return retrc;
 
       req_irq_failed:
-	tasklet_kill(&hostdata->srp_task);
+	cancel_work_sync(&hostdata->srp_work);
 	rc = 0;
 	do {
 		if (rc)
@@ -2371,7 +2375,7 @@ static int ibmvscsi_resume(struct device *dev)
 {
 	struct ibmvscsi_host_data *hostdata = dev_get_drvdata(dev);
 	vio_disable_interrupts(to_vio_dev(hostdata->dev));
-	tasklet_schedule(&hostdata->srp_task);
+	queue_work(ibmvscsi_wq, &hostdata->srp_work);
 
 	return 0;
 }
@@ -2418,15 +2422,25 @@ static int __init ibmvscsi_module_init(void)
 	if (!ibmvscsi_transport_template)
 		return -ENOMEM;
 
+	ibmvscsi_wq = alloc_ordered_workqueue("ibmvscsi_wq", 0);
+	if (!ibmvscsi_wq) {
+		srp_release_transport(ibmvscsi_transport_template);
+		return -ENOMEM;
+	}
+
 	ret = vio_register_driver(&ibmvscsi_driver);
-	if (ret)
+	if (ret) {
+		destroy_workqueue(ibmvscsi_wq);
 		srp_release_transport(ibmvscsi_transport_template);
+	}
+
 	return ret;
 }
 
 static void __exit ibmvscsi_module_exit(void)
 {
 	vio_unregister_driver(&ibmvscsi_driver);
+	destroy_workqueue(ibmvscsi_wq);
 	srp_release_transport(ibmvscsi_transport_template);
 }
 
diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.h b/drivers/scsi/ibmvscsi/ibmvscsi.h
index e60916ef7a49..f7c52744a206 100644
--- a/drivers/scsi/ibmvscsi/ibmvscsi.h
+++ b/drivers/scsi/ibmvscsi/ibmvscsi.h
@@ -18,6 +18,7 @@
 #include <linux/types.h>
 #include <linux/list.h>
 #include <linux/completion.h>
+#include <linux/workqueue.h>
 #include <linux/interrupt.h>
 #include <scsi/viosrp.h>
 
@@ -90,7 +91,7 @@ struct ibmvscsi_host_data {
 	struct device *dev;
 	struct event_pool pool;
 	struct crq_queue queue;
-	struct tasklet_struct srp_task;
+	struct work_struct srp_work;
 	struct list_head sent;
 	struct Scsi_Host *host;
 	struct task_struct *work_thread;
-- 
2.36.1

