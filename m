Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4544D37B5F0
	for <lists+linux-scsi@lfdr.de>; Wed, 12 May 2021 08:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhELGUb (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 12 May 2021 02:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbhELGU3 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 12 May 2021 02:20:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82F9C061574;
        Tue, 11 May 2021 23:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=8r4dDrwc1c2KuUUKhe5lmVbinvVLTrnW2K9iGIIw6SE=; b=q3uU3PuaAmZrcZc1JJ0KS1+ImR
        p9eYPMaVMh6YBoSI3/zCFUppgvGmViZgDrOwek722veFP3PMCieto+P4NicgPw8tjev9kC1538AcR
        /EICvsWLJiZFTL3OKJ8RIjmlUPeqn5tn9H9XZJqYVUVGqUWX0bzcgzx7+VqI4gHpTV0BkncsQSf/F
        FxkwXK2oIdY73vh6fl4QqzuNyVw/QgjAg+cMWJjNWK6OkDv3nQw0WdhlxQaDlOGC2KFjekeWHrhS6
        Qk093W9Bwo60re4VIeJ+r93Sfd2g2Zs5HVQbCb+pDyI4cAhc+zXHTVLNsdbV2JQh2o5RVbVkLqt57
        Wv8bSljQ==;
Received: from [2001:4bb8:198:fbc8:1036:7ab9:f97a:adbc] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lgiDF-00A8t5-5t; Wed, 12 May 2021 06:19:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 7/8] block: factor out a part_devt helper
Date:   Wed, 12 May 2021 08:18:55 +0200
Message-Id: <20210512061856.47075-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210512061856.47075-1-hch@lst.de>
References: <20210512061856.47075-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Add a helper to find the dev_t for a disk + partno tuple.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c         | 25 +++++++++++++++++--------
 include/linux/genhd.h |  1 +
 init/do_mounts.c      | 10 ++--------
 3 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 8b88e99f6675..14fd777811fe 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1251,6 +1251,19 @@ static int __init proc_genhd_init(void)
 module_init(proc_genhd_init);
 #endif /* CONFIG_PROC_FS */
 
+dev_t part_devt(struct gendisk *disk, u8 partno)
+{
+	struct block_device *part = bdget_disk(disk, partno);
+	dev_t devt = 0;
+
+	if (part) {
+		devt = part->bd_dev;
+		bdput(part);
+	}
+
+	return devt;
+}
+
 dev_t blk_lookup_devt(const char *name, int partno)
 {
 	dev_t devt = MKDEV(0, 0);
@@ -1260,7 +1273,6 @@ dev_t blk_lookup_devt(const char *name, int partno)
 	class_dev_iter_init(&iter, &block_class, NULL, &disk_type);
 	while ((dev = class_dev_iter_next(&iter))) {
 		struct gendisk *disk = dev_to_disk(dev);
-		struct block_device *part;
 
 		if (strcmp(dev_name(dev), name))
 			continue;
@@ -1271,13 +1283,10 @@ dev_t blk_lookup_devt(const char *name, int partno)
 			 */
 			devt = MKDEV(MAJOR(dev->devt),
 				     MINOR(dev->devt) + partno);
-			break;
-		}
-		part = bdget_disk(disk, partno);
-		if (part) {
-			devt = part->bd_dev;
-			bdput(part);
-			break;
+		} else {
+			devt = part_devt(disk, partno);
+			if (devt)
+				break;
 		}
 	}
 	class_dev_iter_exit(&iter);
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 74fd28ddac70..4c4d903caa09 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -312,6 +312,7 @@ static inline void bd_unlink_disk_holder(struct block_device *bdev,
 
 extern struct rw_semaphore bdev_lookup_sem;
 
+dev_t part_devt(struct gendisk *disk, u8 partno);
 dev_t blk_lookup_devt(const char *name, int partno);
 void blk_request_module(dev_t devt);
 #ifdef CONFIG_BLOCK
diff --git a/init/do_mounts.c b/init/do_mounts.c
index a78e44ee6adb..74aede860de7 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -133,14 +133,8 @@ static dev_t devt_from_partuuid(const char *uuid_str)
 		 * Attempt to find the requested partition by adding an offset
 		 * to the partition number found by UUID.
 		 */
-		struct block_device *part;
-
-		part = bdget_disk(dev_to_disk(dev),
-				  dev_to_bdev(dev)->bd_partno + offset);
-		if (part) {
-			devt = part->bd_dev;
-			bdput(part);
-		}
+		devt = part_devt(dev_to_disk(dev),
+				 dev_to_bdev(dev)->bd_partno + offset);
 	} else {
 		devt = dev->devt;
 	}
-- 
2.30.2

