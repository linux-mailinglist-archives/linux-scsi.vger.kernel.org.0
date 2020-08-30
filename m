Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A701256C06
	for <lists+linux-scsi@lfdr.de>; Sun, 30 Aug 2020 08:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgH3GZY (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 30 Aug 2020 02:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgH3GZB (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 30 Aug 2020 02:25:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B1DC061573;
        Sat, 29 Aug 2020 23:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=B9nqgl0BizoCFTSZ0GvnyJ44eULa8ACIMrdc+XZNiS8=; b=Y6jiENa1qL7GdBLAhxjHCGqcmj
        cZbOAR2JMK7wXID16HODGGANEJNUGCvFQ8tjZ/4iB3RJiI9bljbShkJcJkLEOyvtQDzi+e9ocS8u1
        qWu48aidGxhE5C0XpAMgvIburShiGP1q6IQ8j4Se1V+HFQE9vUxbScBD4b5cJHptgQWZPFnO7yMg4
        h9CrqFjSLr2qcxi+xEzVqXeJEzWj3W5b7l2LuPU+dLfZjOnlQv+WdWon04ojCbKczHEA97uSqHf9E
        KnClBv1WQGpowerT8txgVaf66gpxSmlr9AimY6NQDxaGFtsdh6fDw1iNqVF/6W9mVECRtEsvPsOr8
        KbTAWocg==;
Received: from [2001:4bb8:18c:45ba:9892:9e86:5202:32f0] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kCGlq-0002NB-EA; Sun, 30 Aug 2020 06:24:54 +0000
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
Subject: [PATCH 08/19] swim: don't call blk_register_region
Date:   Sun, 30 Aug 2020 08:24:34 +0200
Message-Id: <20200830062445.1199128-9-hch@lst.de>
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

The swim driver (unlike various other floppy drivers) doesn't have
magic device nodes for certain modes, and already registers a gendisk
for each of the floppies supported by a device.  Thus the region
registered is a no-op and can be removed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/swim.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index dd34504382e533..5a8f5932f9bde4 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -763,18 +763,6 @@ static const struct block_device_operations floppy_fops = {
 	.revalidate_disk = floppy_revalidate,
 };
 
-static struct kobject *floppy_find(dev_t dev, int *part, void *data)
-{
-	struct swim_priv *swd = data;
-	int drive = (*part & 3);
-
-	if (drive >= swd->floppy_count)
-		return NULL;
-
-	*part = 0;
-	return get_disk_and_module(swd->unit[drive].disk);
-}
-
 static int swim_add_floppy(struct swim_priv *swd, enum drive_location location)
 {
 	struct floppy_state *fs = &swd->unit[swd->floppy_count];
@@ -864,9 +852,6 @@ static int swim_floppy_init(struct swim_priv *swd)
 		add_disk(swd->unit[drive].disk);
 	}
 
-	blk_register_region(MKDEV(FLOPPY_MAJOR, 0), 256, THIS_MODULE,
-			    floppy_find, NULL, swd);
-
 	return 0;
 
 exit_put_disks:
@@ -950,8 +935,6 @@ static int swim_remove(struct platform_device *dev)
 	int drive;
 	struct resource *res;
 
-	blk_unregister_region(MKDEV(FLOPPY_MAJOR, 0), 256);
-
 	for (drive = 0; drive < swd->floppy_count; drive++) {
 		del_gendisk(swd->unit[drive].disk);
 		blk_cleanup_queue(swd->unit[drive].disk->queue);
-- 
2.28.0

