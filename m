Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2FAA256C4A
	for <lists+linux-scsi@lfdr.de>; Sun, 30 Aug 2020 08:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbgH3G1N (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 30 Aug 2020 02:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbgH3GY6 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 30 Aug 2020 02:24:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F28C061239;
        Sat, 29 Aug 2020 23:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=YM1SPyKS6FTgRnphdLuuProv8AP/xrdO+TruNwolZXE=; b=m0JIRqIxcxnW+xHg05y/iEvibd
        2GVNSm9E9ZqUIAXi2i0hKZfhPyTcwG4oAmYs2TsPiJ6tuDAp4maqAEBCKeksvip3PQY2WkJu61csL
        wo8srVBc47/x+ikRD00yff0tZihKfTubyHzVtSRkhCO7V2+r9Em/pdvlNNTYb0v0RUJHpaM6hKkCo
        ubzo0pdQIhPEesSwUn385IjZLAUVJ7HB20y8S1mEnnQ1pqp3Zqgw+QvoF7FKdvpCGsqGmMDYPoXPr
        kZ/dBzvCFxg30MQUYUw5uWJpmdUWoOok444LP8eCJFEllR9QIJQVRAdYSWJZFAv9EKYSY/HKvgPpj
        S+H4wVqw==;
Received: from [2001:4bb8:18c:45ba:9892:9e86:5202:32f0] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kCGln-0002MZ-7L; Sun, 30 Aug 2020 06:24:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Denis Efremov <efremov@linux.com>,
        "David S. Miller" <davem@davemloft.net>,
        Song Liu <song@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Subject: [PATCH 05/19] block: rework requesting modules for unclaimed devices
Date:   Sun, 30 Aug 2020 08:24:31 +0200
Message-Id: <20200830062445.1199128-6-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200830062445.1199128-1-hch@lst.de>
References: <20200830062445.1199128-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Instead of reusing the ranges in bdev_map, add a new helper that is
called if no ranges was found.  This is a first step to unpeel and
eventually remove the complex ranges structure.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 0ae6210e141ee5..00164304317cfa 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1035,6 +1035,13 @@ static ssize_t disk_badblocks_store(struct device *dev,
 	return badblocks_store(disk->bb, page, len, 0);
 }
 
+static void request_gendisk_module(dev_t devt)
+{
+	if (request_module("block-major-%d-%d", MAJOR(devt), MINOR(devt)) > 0)
+		/* Make old-style 2.4 aliases work */
+		request_module("block-major-%d", MAJOR(devt));
+}
+
 static struct gendisk *lookup_gendisk(dev_t dev, int *partno)
 {
 	struct kobject *kobj;
@@ -1059,6 +1066,14 @@ static struct gendisk *lookup_gendisk(dev_t dev, int *partno)
 		probe = p->probe;
 		best = p->range - 1;
 		*partno = dev - p->dev;
+
+		if (!probe) {
+			mutex_unlock(&bdev_map_lock);
+			module_put(owner);
+			request_gendisk_module(dev);
+			goto retry;
+		}
+
 		if (p->lock && p->lock(dev, data) < 0) {
 			module_put(owner);
 			continue;
@@ -1297,15 +1312,6 @@ static const struct seq_operations partitions_op = {
 };
 #endif
 
-
-static struct kobject *base_probe(dev_t devt, int *partno, void *data)
-{
-	if (request_module("block-major-%d-%d", MAJOR(devt), MINOR(devt)) > 0)
-		/* Make old-style 2.4 aliases work */
-		request_module("block-major-%d", MAJOR(devt));
-	return NULL;
-}
-
 static void bdev_map_init(void)
 {
 	struct bdev_map *base;
@@ -1317,7 +1323,6 @@ static void bdev_map_init(void)
 
 	base->dev = 1;
 	base->range = ~0 ;
-	base->probe = base_probe;
 	for (i = 0; i < 255; i++)
 		bdev_map[i] = base;
 }
-- 
2.28.0

