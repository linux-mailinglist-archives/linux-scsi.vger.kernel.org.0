Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 305AD2526E8
	for <lists+linux-scsi@lfdr.de>; Wed, 26 Aug 2020 08:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgHZGdi (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 26 Aug 2020 02:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgHZGdi (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 26 Aug 2020 02:33:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E6CC061574;
        Tue, 25 Aug 2020 23:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=BQ4CpzfWadwZaE1eVDKbctMggquiS6KqfZ6j9IqjVrY=; b=hJ7usYVtBMK1Utl0NhqloD27al
        wRs+XR6pFpF4xRObEsxz4gmW1UWfEXF9PcUEsOS3KUumK17uZnxY/xwdTkSG3k+37tH1LQgHgbGgU
        y3NENpeUmn587R/DgaqpHlHQBnK2AC800feAkM4YbK2TpzeyFKfFbXT5IluFMTQ5Hi9p2O9u4m1Eh
        AD5PrxrECjMWSyId6MkqZ7TFwv6XNUjghCEf7LgcoHnlLC83QK+N/TwX7aF3DPkHQYwkNh3Egt5pP
        xIlpeQyhiE1ii18RhhFXfSVz6klFMLL5M9phXtn986IMaBslzyeaMHPAyTn5w7JRcmXLOJavGtzDV
        VfxR7esw==;
Received: from 213-225-6-196.nat.highway.a1.net ([213.225.6.196] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kAozy-0001AA-Vy; Wed, 26 Aug 2020 06:33:31 +0000
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
Subject: [PATCH 03/19] block: cleanup del_gendisk a bit
Date:   Wed, 26 Aug 2020 08:24:30 +0200
Message-Id: <20200826062446.31860-4-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200826062446.31860-1-hch@lst.de>
References: <20200826062446.31860-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Merge three hidden gendisk checks into one.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index cb9a51be35b053..df6485223a2c3d 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -973,22 +973,22 @@ void del_gendisk(struct gendisk *disk)
 	disk->flags &= ~GENHD_FL_UP;
 	up_write(&disk->lookup_sem);
 
-	if (!(disk->flags & GENHD_FL_HIDDEN))
+	WARN_ON(!disk->queue);
+
+	if (!(disk->flags & GENHD_FL_HIDDEN)) {
 		sysfs_remove_link(&disk_to_dev(disk)->kobj, "bdi");
-	if (disk->queue) {
+
 		/*
 		 * Unregister bdi before releasing device numbers (as they can
 		 * get reused and we'd get clashes in sysfs).
 		 */
-		if (!(disk->flags & GENHD_FL_HIDDEN))
-			bdi_unregister(disk->queue->backing_dev_info);
+		bdi_unregister(disk->queue->backing_dev_info);
 		blk_unregister_queue(disk);
+		blk_unregister_region(disk_devt(disk), disk->minors);
 	} else {
-		WARN_ON(1);
+		blk_unregister_queue(disk);
 	}
 
-	if (!(disk->flags & GENHD_FL_HIDDEN))
-		blk_unregister_region(disk_devt(disk), disk->minors);
 	/*
 	 * Remove gendisk pointer from idr so that it cannot be looked up
 	 * while RCU period before freeing gendisk is running to prevent
-- 
2.28.0

