Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0E704E883
	for <lists+linux-scsi@lfdr.de>; Fri, 21 Jun 2019 15:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfFUNHi (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 21 Jun 2019 09:07:38 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46062 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbfFUNHg (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 21 Jun 2019 09:07:36 -0400
Received: by mail-lj1-f195.google.com with SMTP id m23so5856374lje.12
        for <linux-scsi@vger.kernel.org>; Fri, 21 Jun 2019 06:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KIxiEPjPFTJ+1vxbl5yjwf7laBnZVBburPM3Qsvxjsc=;
        b=jAkjttrkDBc5StTWyglwMWmrFO5xfZMZEC4/aXMujoVsmJjiVumNp87/zZAkoldEE8
         owN6HkrMnD9li+fb0BQuGz+pdNmonPApcLo2UC5s/As+WvpPXm6Ae4a9KqIRojiU04cX
         KKYXnVSTkkmIUcdOIY1IwzqKt9bIBvIOjMfEsmvnNiPEMhQkCWDAIHC7oGmqIM0MfWSx
         2lMX0vWAOdnCAFaWuQgX4llUeqNe/dWyQT5F9eirTWV3QTSeiK0Lg0x+5IvLmbg9jxqa
         GVVr15lFJs3acP1kyx5aRviZYeEn7le4EWriJvOYYdS3MhRmRuUdX0X5C2NNu1pVZlZ/
         FMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KIxiEPjPFTJ+1vxbl5yjwf7laBnZVBburPM3Qsvxjsc=;
        b=E9+a4lcKF3S9lRQc13yU0MXYOiRjjr+Vjq0VIZ5gopHduJbLzvz2hOgu7o+71/fUGe
         /l6+mhi/p8iWOkcD1/JrbvBdFEZFXB6Tl4isBj1SKlijPEZxQyUta7jE5HDebqEmPZVS
         13JchRgyfLyN5qQhzYLppNwhWe/xPaPRpDCNab/etgv0NmuEvgcmd/uDjHKUac+l6wa0
         u6x02WdvjNgb53bQzf4JvzQUIJPVXRwl6JKUuf5DixXFRy7SJwErgHQrwbGpXqalSqr0
         AKLXYZ6UcLIkD/tnGyURs4JfHpL8N4nwT+YW/MsNpwxeS8JZoLVFy5vxJb/p+XhrMF2P
         OlBg==
X-Gm-Message-State: APjAAAXfbp+dnRHOT29jGMmP7wLmRbrS6hW+3rz7YE3Megq7ryq7d6l6
        Ws7jubPAUaddlgOVLpvXiCMrn+SDvCE=
X-Google-Smtp-Source: APXvYqztGCnsvf/snvO0fvZpXnEV5w6WCjbqDHG4Xxb6KNLNPuizWdxlt0NMN+AmNi/deF5LAXFr2A==
X-Received: by 2002:a2e:8847:: with SMTP id z7mr10590901ljj.51.1561122453679;
        Fri, 21 Jun 2019 06:07:33 -0700 (PDT)
Received: from skyninja.webspeed.dk (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.gmail.com with ESMTPSA id r2sm387100lfi.51.2019.06.21.06.07.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 06:07:33 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com, hch@lst.de, damien.lemoal@wdc.com,
        chaitanya.kulkarni@wdc.com, dmitry.fomichev@wdc.com,
        ajay.joshi@wdc.com, aravind.ramesh@wdc.com,
        martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        agk@redhat.com, snitzer@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH 4/4] dm: add zone open, close and finish support
Date:   Fri, 21 Jun 2019 15:07:11 +0200
Message-Id: <20190621130711.21986-5-mb@lightnvm.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190621130711.21986-1-mb@lightnvm.io>
References: <20190621130711.21986-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Ajay Joshi <ajay.joshi@wdc.com>

Implement REQ_OP_ZONE_OPEN, REQ_OP_ZONE_CLOSE and REQ_OP_ZONE_FINISH
support to allow explicit control of zone states.

Signed-off-by: Ajay Joshi <ajay.joshi@wdc.com>
---
 drivers/md/dm-flakey.c    | 7 +++----
 drivers/md/dm-linear.c    | 2 +-
 drivers/md/dm.c           | 5 +++--
 include/linux/blk_types.h | 8 ++++++++
 4 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/md/dm-flakey.c b/drivers/md/dm-flakey.c
index a9bc518156f2..fff529c0732c 100644
--- a/drivers/md/dm-flakey.c
+++ b/drivers/md/dm-flakey.c
@@ -280,7 +280,7 @@ static void flakey_map_bio(struct dm_target *ti, struct bio *bio)
 	struct flakey_c *fc = ti->private;
 
 	bio_set_dev(bio, fc->dev->bdev);
-	if (bio_sectors(bio) || bio_op(bio) == REQ_OP_ZONE_RESET)
+	if (bio_sectors(bio) || bio_is_zone_mgmt_op(bio))
 		bio->bi_iter.bi_sector =
 			flakey_map_sector(ti, bio->bi_iter.bi_sector);
 }
@@ -322,8 +322,7 @@ static int flakey_map(struct dm_target *ti, struct bio *bio)
 	struct per_bio_data *pb = dm_per_bio_data(bio, sizeof(struct per_bio_data));
 	pb->bio_submitted = false;
 
-	/* Do not fail reset zone */
-	if (bio_op(bio) == REQ_OP_ZONE_RESET)
+	if (bio_is_zone_mgmt_op(bio))
 		goto map_bio;
 
 	/* Are we alive ? */
@@ -384,7 +383,7 @@ static int flakey_end_io(struct dm_target *ti, struct bio *bio,
 	struct flakey_c *fc = ti->private;
 	struct per_bio_data *pb = dm_per_bio_data(bio, sizeof(struct per_bio_data));
 
-	if (bio_op(bio) == REQ_OP_ZONE_RESET)
+	if (bio_is_zone_mgmt_op(bio))
 		return DM_ENDIO_DONE;
 
 	if (!*error && pb->bio_submitted && (bio_data_dir(bio) == READ)) {
diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index ad980a38fb1e..217a1dee8197 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -90,7 +90,7 @@ static void linear_map_bio(struct dm_target *ti, struct bio *bio)
 	struct linear_c *lc = ti->private;
 
 	bio_set_dev(bio, lc->dev->bdev);
-	if (bio_sectors(bio) || bio_op(bio) == REQ_OP_ZONE_RESET)
+	if (bio_sectors(bio) || bio_is_zone_mgmt_op(bio))
 		bio->bi_iter.bi_sector =
 			linear_map_sector(ti, bio->bi_iter.bi_sector);
 }
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 5475081dcbd6..f4507ec20a57 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1176,7 +1176,8 @@ static size_t dm_dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff,
 
 /*
  * A target may call dm_accept_partial_bio only from the map routine.  It is
- * allowed for all bio types except REQ_PREFLUSH and REQ_OP_ZONE_RESET.
+ * allowed for all bio types except REQ_PREFLUSH, REQ_OP_ZONE_RESET,
+ * REQ_OP_ZONE_OPEN, REQ_OP_ZONE_CLOSE and REQ_OP_ZONE_FINISH.
  *
  * dm_accept_partial_bio informs the dm that the target only wants to process
  * additional n_sectors sectors of the bio and the rest of the data should be
@@ -1629,7 +1630,7 @@ static blk_qc_t __split_and_process_bio(struct mapped_device *md,
 		ci.sector_count = 0;
 		error = __send_empty_flush(&ci);
 		/* dec_pending submits any data associated with flush */
-	} else if (bio_op(bio) == REQ_OP_ZONE_RESET) {
+	} else if (bio_is_zone_mgmt_op(bio)) {
 		ci.bio = bio;
 		ci.sector_count = 0;
 		error = __split_and_process_non_flush(&ci);
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 067ef9242275..fd2458cd1a49 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -398,6 +398,14 @@ static inline bool op_is_zone_mgmt_op(enum req_opf op)
 	}
 }
 
+/*
+ * Check if the bio is zoned operation.
+ */
+static inline bool bio_is_zone_mgmt_op(struct bio *bio)
+{
+	return op_is_zone_mgmt_op(bio_op(bio));
+}
+
 static inline bool op_is_write(unsigned int op)
 {
 	return (op & 1);
-- 
2.19.1

