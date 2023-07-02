Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65107450CA
	for <lists+linux-scsi@lfdr.de>; Sun,  2 Jul 2023 21:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjGBTm1 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 2 Jul 2023 15:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjGBTmF (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 2 Jul 2023 15:42:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C2210FD;
        Sun,  2 Jul 2023 12:41:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB4E460CFA;
        Sun,  2 Jul 2023 19:41:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D8B4C433BB;
        Sun,  2 Jul 2023 19:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688326867;
        bh=9WME3iKh6Gwl5xX65XpMf6g6gSE1LTrurp0t6dKLNbI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bm46GYZZmJ9wSY/SIPyqFHrP7DMhj7DGSHS457+X8zChTrImOZ5q0KsLoSG2Jf4aK
         fJiXeUCFlIJPC90+sTTBGBqB2ZsWGAUSMewXXn2tIApjXj1o4Eg2i8dnZgE0KXZN2E
         0WKmJwLU9qQoKRwHwUm+3ToHegkJWzpKVzZ8getqAFOUju6IyrKtN57mGGMZpxZc6a
         JPNVzbkFOxrVJL5x/aRDENOqfeAO4oSRq64EN0VpbszeIdOvcRp9wUN7sm4OADQgGm
         P5Q+lG2Xaq1ZRyZj40l4dt4pF9c5mavrMm1umE11jS6wtHWISJF3J4WowY0YO9M/lF
         n2IKZafkFDfXg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yu Kuai <yukuai3@huawei.com>, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        dgilbert@interlog.com, jejb@linux.ibm.com,
        linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 08/14] scsi: sg: fix blktrace debugfs entries leakage
Date:   Sun,  2 Jul 2023 15:40:47 -0400
Message-Id: <20230702194053.1777356-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702194053.1777356-1-sashal@kernel.org>
References: <20230702194053.1777356-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.3.11
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit db59133e927916d8a25ee1fd8264f2808040909d ]

sg_ioctl() support to enable blktrace, which will create debugfs entries
"/sys/kernel/debug/block/sgx/", however, there is no guarantee that user
will remove these entries through ioctl, and deleting sg device doesn't
cleanup these blktrace entries.

This problem can be fixed by cleanup blktrace while releasing
request_queue, however, it's not a good idea to do this special handling
in common layer just for sg device.

Fix this problem by shutdown bltkrace in sg_device_destroy(), where the
device is deleted and all the users close the device, also grab a
scsi_device reference from sg_add_device() to prevent scsi_device to be
freed before sg_device_destroy();

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Link: https://lore.kernel.org/r/20230610022003.2557284-3-yukuai1@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/sg.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index a91049213203f..7ecce9c771e06 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1496,6 +1496,10 @@ sg_add_device(struct device *cl_dev, struct class_interface *cl_intf)
 	int error;
 	unsigned long iflags;
 
+	error = scsi_device_get(scsidp);
+	if (error)
+		return error;
+
 	error = -ENOMEM;
 	cdev = cdev_alloc();
 	if (!cdev) {
@@ -1553,6 +1557,7 @@ sg_add_device(struct device *cl_dev, struct class_interface *cl_intf)
 out:
 	if (cdev)
 		cdev_del(cdev);
+	scsi_device_put(scsidp);
 	return error;
 }
 
@@ -1560,6 +1565,7 @@ static void
 sg_device_destroy(struct kref *kref)
 {
 	struct sg_device *sdp = container_of(kref, struct sg_device, d_ref);
+	struct request_queue *q = sdp->device->request_queue;
 	unsigned long flags;
 
 	/* CAUTION!  Note that the device can still be found via idr_find()
@@ -1567,6 +1573,9 @@ sg_device_destroy(struct kref *kref)
 	 * any other cleanup.
 	 */
 
+	blk_trace_remove(q);
+	scsi_device_put(sdp->device);
+
 	write_lock_irqsave(&sg_index_lock, flags);
 	idr_remove(&sg_index_idr, sdp->index);
 	write_unlock_irqrestore(&sg_index_lock, flags);
-- 
2.39.2

