Return-Path: <linux-scsi+bounces-16602-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12692B38B73
	for <lists+linux-scsi@lfdr.de>; Wed, 27 Aug 2025 23:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80EBD1C22AB3
	for <lists+linux-scsi@lfdr.de>; Wed, 27 Aug 2025 21:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F12F2C15BC;
	Wed, 27 Aug 2025 21:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="ZWmAVzeX"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC40283680;
	Wed, 27 Aug 2025 21:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756330266; cv=none; b=jec0Hzf9hyVmacLB75lgNar3Odn6PT2VmEHxTnYDLVvOMI5F4HMpnRynQdqT732GdLOk1q1Ht84nLa21SrGloXhHTF5MasxXiijTn5YA9egSEeMgJRz1EvP4Gtg5DT3OQRNGuZEIHCc0aSvMRN42fw8cW996iPu+FMuv/EkUSdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756330266; c=relaxed/simple;
	bh=2Y6sx0cQO+xtMSzjLd8MVroH4R3Inu5nEyT/9JfUMFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qew2YmwqdNuD89+/Nybd8V5aPaxjzjI9lm3VvhOZH8sdEMHGbS6PC19Ze/uE3QqL3AgaIPW9SgP8Q+qxr5pQdHes3oc9sYncrBxIsB2T2KNH/wd6wN6zFkZaAcin+9cCgYtQ4C7Gi4JECTMpphQalPG97JUkcEU2J95oBHu/I8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ZWmAVzeX; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4cByPz2Qddzm174B;
	Wed, 27 Aug 2025 21:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1756330262; x=1758922263; bh=uqFA2
	pAxPtXlVcqsBreLSKNckWONALxb7+EXrHBFqEg=; b=ZWmAVzeXWS+Pf46NSN/x+
	QWZrlUfqsG6yT3yvxPMGnXpJZ1lnhbPpwIOZm8SKU5ajUZT4dteBe4l6YsOuj5qN
	AdX0StsWTg6pD6azP1KF8JpwDkFpMYxKNqj78CT02PvQfwbE3/BddWKgD9oZZuPt
	fRExsYL/Hipx+FafBUOYB/7x+c/tLWbFoW1VW3XHHDkoAEWllwrojPvQxQch7s4I
	JdkZGKGFEdeo9dTpObA90jJhGDm+Fa4CAYQn3IaE3yte8xzl77BBcHEN92uNvIxr
	F9U4ISH2bdSgMIluRQjm7cIjIsmyCV2Rj0JMeb/UjWzkITc1LocwsolciSXjhVt2
	Q==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id yv9ZS7-q7uQc; Wed, 27 Aug 2025 21:31:02 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4cByPt2lGzzm0yQ2;
	Wed, 27 Aug 2025 21:30:57 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v24 12/18] blk-zoned: Support pipelining of zoned writes
Date: Wed, 27 Aug 2025 14:29:31 -0700
Message-ID: <20250827212937.2759348-13-bvanassche@acm.org>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
In-Reply-To: <20250827212937.2759348-1-bvanassche@acm.org>
References: <20250827212937.2759348-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Support pipelining of zoned writes if the write order is preserved per
hardware queue. Track per zone to which software queue writes have been
queued. If zoned writes are pipelined, submit new writes to the same
software queue as the writes that are already in progress. This prevents
reordering by submitting requests for the same zone to different
software or hardware queues. In disk_zone_wplug_schedule_bio_work(),
only increment the zwplug reference count if queuing zwplug->bio_work
succeeded since with this patch applied the bio_work may already be
queued if disk_zone_wplug_schedule_bio_work() is called.

Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c    |  4 +--
 block/blk-zoned.c | 89 +++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 77 insertions(+), 16 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 31c0db1fc217..6f3069a50f63 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3174,8 +3174,8 @@ void blk_mq_submit_bio(struct bio *bio)
 	/*
 	 * A BIO that was released from a zone write plug has already been
 	 * through the preparation in this function, already holds a reference
-	 * on the queue usage counter, and is the only write BIO in-flight for
-	 * the target zone. Go straight to preparing a request for it.
+	 * on the queue usage counter. Go straight to preparing a request for
+	 * it.
 	 */
 	if (bio_zone_write_plugging(bio)) {
 		nr_segs =3D bio->__bi_nr_segments;
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 627a952477d1..bb3cb1e3eff5 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -8,6 +8,7 @@
  * Copyright (c) 2016, Damien Le Moal
  * Copyright (c) 2016, Western Digital
  * Copyright (c) 2024, Western Digital Corporation or its affiliates.
+ * Copyright 2025 Google LLC
  */
=20
 #include <linux/kernel.h>
@@ -54,6 +55,8 @@ static const char *const zone_cond_name[] =3D {
  * @zone_no: The number of the zone the plug is managing.
  * @wp_offset: The zone write pointer location relative to the start of =
the zone
  *             as a number of 512B sectors.
+ * @from_cpu: Software queue to submit writes from for drivers that pres=
erve
+ *	the write order.
  * @bio_list: The list of BIOs that are currently plugged.
  * @bio_work: Work struct to handle issuing of plugged BIOs
  * @rcu_head: RCU head to free zone write plugs with an RCU grace period=
.
@@ -66,6 +69,7 @@ struct blk_zone_wplug {
 	unsigned int		flags;
 	unsigned int		zone_no;
 	unsigned int		wp_offset;
+	int			from_cpu;
 	struct bio_list		bio_list;
 	struct work_struct	bio_work;
 	struct rcu_head		rcu_head;
@@ -75,8 +79,7 @@ struct blk_zone_wplug {
 /*
  * Zone write plug flags bits:
  *  - BLK_ZONE_WPLUG_PLUGGED: Indicates that the zone write plug is plug=
ged,
- *    that is, that write BIOs are being throttled due to a write BIO al=
ready
- *    being executed or the zone write plug bio list is not empty.
+ *    that is, that write BIOs are being throttled.
  *  - BLK_ZONE_WPLUG_NEED_WP_UPDATE: Indicates that we lost track of a z=
one
  *    write pointer offset and need to update it.
  *  - BLK_ZONE_WPLUG_UNHASHED: Indicates that the zone write plug was re=
moved
@@ -589,6 +592,7 @@ static struct blk_zone_wplug *disk_get_and_lock_zone_=
wplug(struct gendisk *disk,
 	zwplug->flags =3D 0;
 	zwplug->zone_no =3D zno;
 	zwplug->wp_offset =3D bdev_offset_from_zone_start(disk->part0, sector);
+	zwplug->from_cpu =3D -1;
 	bio_list_init(&zwplug->bio_list);
 	INIT_WORK(&zwplug->bio_work, blk_zone_wplug_bio_work);
 	zwplug->disk =3D disk;
@@ -785,16 +789,25 @@ static bool blk_zone_wplug_handle_reset_all(struct =
bio *bio)
 static void disk_zone_wplug_schedule_bio_work(struct gendisk *disk,
 					      struct blk_zone_wplug *zwplug)
 {
+	int cpu;
+
 	lockdep_assert_held(&zwplug->lock);
=20
 	/*
-	 * Take a reference on the zone write plug and schedule the submission
-	 * of the next plugged BIO. blk_zone_wplug_bio_work() will release the
-	 * reference we take here.
+	 * Schedule a blk_zone_wplug_bio_work() call and increase the zone writ=
e
+	 * plug reference count. blk_zone_wplug_bio_work() will release the
+	 * reference we take here. Increasing the zone write plug reference
+	 * count after the queue_work_on() call is safe because all callers hol=
d
+	 * the zone write plug lock and blk_zone_wplug_bio_work() obtains the
+	 * same lock before decrementing the reference count.
 	 */
 	WARN_ON_ONCE(!(zwplug->flags & BLK_ZONE_WPLUG_PLUGGED));
-	refcount_inc(&zwplug->ref);
-	queue_work(disk->zone_wplugs_wq, &zwplug->bio_work);
+	if (zwplug->from_cpu >=3D 0)
+		cpu =3D zwplug->from_cpu;
+	else
+		cpu =3D WORK_CPU_UNBOUND;
+	if (queue_work_on(cpu, disk->zone_wplugs_wq, &zwplug->bio_work))
+		refcount_inc(&zwplug->ref);
 }
=20
 static inline void disk_zone_wplug_add_bio(struct gendisk *disk,
@@ -991,14 +1004,18 @@ static bool blk_zone_wplug_prepare_bio(struct blk_=
zone_wplug *zwplug,
 	return true;
 }
=20
-static bool blk_zone_wplug_handle_write(struct bio *bio, unsigned int nr=
_segs)
+static bool blk_zone_wplug_handle_write(struct bio *bio, unsigned int nr=
_segs,
+					int rq_cpu)
 {
 	struct gendisk *disk =3D bio->bi_bdev->bd_disk;
+	const bool pipeline_zwr =3D bio_op(bio) !=3D REQ_OP_ZONE_APPEND &&
+				 blk_pipeline_zwr(disk->queue);
 	sector_t sector =3D bio->bi_iter.bi_sector;
 	bool schedule_bio_work =3D false;
 	struct blk_zone_wplug *zwplug;
 	gfp_t gfp_mask =3D GFP_NOIO;
 	unsigned long flags;
+	int from_cpu =3D -1;
=20
 	/*
 	 * BIOs must be fully contained within a zone so that we use the correc=
t
@@ -1051,14 +1068,44 @@ static bool blk_zone_wplug_handle_write(struct bi=
o *bio, unsigned int nr_segs)
 	if (zwplug->flags & BLK_ZONE_WPLUG_PLUGGED)
 		goto add_to_bio_list;
=20
+	/*
+	 * The code below has been organized such that zwplug->from_cpu and
+	 * zwplug->flags are only modified after it is clear that a request wil=
l
+	 * be added to the bio list or that it will be submitted by the
+	 * caller. This prevents that any changes to these member variables hav=
e
+	 * to be reverted if the blk_zone_wplug_prepare_bio() call fails.
+	 */
+
+	if (pipeline_zwr) {
+		if (zwplug->from_cpu >=3D 0)
+			from_cpu =3D zwplug->from_cpu;
+		else
+			from_cpu =3D smp_processor_id();
+		if (from_cpu !=3D rq_cpu) {
+			zwplug->from_cpu =3D from_cpu;
+			goto add_to_bio_list;
+		}
+	}
+
 	if (!blk_zone_wplug_prepare_bio(zwplug, bio)) {
 		spin_unlock_irqrestore(&zwplug->lock, flags);
 		bio_io_error(bio);
 		return true;
 	}
=20
-	/* Otherwise, plug and submit the BIO. */
-	zwplug->flags |=3D BLK_ZONE_WPLUG_PLUGGED;
+	if (pipeline_zwr) {
+		/*
+		 * The block driver preserves the write order. Submit future
+		 * writes from the same CPU core as ongoing writes.
+		 */
+		zwplug->from_cpu =3D from_cpu;
+	} else {
+		/*
+		 * The block driver does not preserve the write order. Plug and
+		 * let the caller submit the BIO.
+		 */
+		zwplug->flags |=3D BLK_ZONE_WPLUG_PLUGGED;
+	}
=20
 	spin_unlock_irqrestore(&zwplug->lock, flags);
=20
@@ -1166,7 +1213,7 @@ bool blk_zone_plug_bio(struct bio *bio, unsigned in=
t nr_segs, int rq_cpu)
 		fallthrough;
 	case REQ_OP_WRITE:
 	case REQ_OP_WRITE_ZEROES:
-		return blk_zone_wplug_handle_write(bio, nr_segs);
+		return blk_zone_wplug_handle_write(bio, nr_segs, rq_cpu);
 	case REQ_OP_ZONE_RESET:
 		return blk_zone_wplug_handle_reset_or_finish(bio, 0);
 	case REQ_OP_ZONE_FINISH:
@@ -1198,6 +1245,16 @@ static void disk_zone_wplug_unplug_bio(struct gend=
isk *disk,
=20
 	zwplug->flags &=3D ~BLK_ZONE_WPLUG_PLUGGED;
=20
+	/*
+	 * zwplug->from_cpu must not change while one or more writes are pendin=
g
+	 * for the zone associated with zwplug. zwplug->ref is 2 when the plug
+	 * is unused (one reference taken when the plug was allocated and
+	 * another reference taken by the caller context). Reset
+	 * zwplug->from_cpu if no more writes are pending.
+	 */
+	if (refcount_read(&zwplug->ref) =3D=3D 2)
+		zwplug->from_cpu =3D -1;
+
 	/*
 	 * If the zone is full (it was fully written or finished, or empty
 	 * (it was reset), remove its zone write plug from the hash table.
@@ -1298,6 +1355,7 @@ static void blk_zone_wplug_bio_work(struct work_str=
uct *work)
 {
 	struct blk_zone_wplug *zwplug =3D
 		container_of(work, struct blk_zone_wplug, bio_work);
+	bool pipeline_zwr =3D blk_pipeline_zwr(zwplug->disk->queue);
 	struct block_device *bdev;
 	unsigned long flags;
 	struct bio *bio;
@@ -1344,7 +1402,7 @@ static void blk_zone_wplug_bio_work(struct work_str=
uct *work)
 		} else {
 			blk_mq_submit_bio(bio);
 		}
-	} while (0);
+	} while (pipeline_zwr);
=20
 put_zwplug:
 	/* Drop the reference we took in disk_zone_wplug_schedule_bio_work(). *=
/
@@ -1871,6 +1929,7 @@ static void queue_zone_wplug_show(struct blk_zone_w=
plug *zwplug,
 	unsigned int zwp_zone_no, zwp_ref;
 	unsigned int zwp_bio_list_size;
 	unsigned long flags;
+	int from_cpu;
=20
 	spin_lock_irqsave(&zwplug->lock, flags);
 	zwp_zone_no =3D zwplug->zone_no;
@@ -1878,10 +1937,12 @@ static void queue_zone_wplug_show(struct blk_zone=
_wplug *zwplug,
 	zwp_ref =3D refcount_read(&zwplug->ref);
 	zwp_wp_offset =3D zwplug->wp_offset;
 	zwp_bio_list_size =3D bio_list_size(&zwplug->bio_list);
+	from_cpu =3D zwplug->from_cpu;
 	spin_unlock_irqrestore(&zwplug->lock, flags);
=20
-	seq_printf(m, "%u 0x%x %u %u %u\n", zwp_zone_no, zwp_flags, zwp_ref,
-		   zwp_wp_offset, zwp_bio_list_size);
+	seq_printf(m, "zone_no %u flags 0x%x ref %u wp_offset %u bio_list_size =
%u from_cpu %d\n",
+		   zwp_zone_no, zwp_flags, zwp_ref, zwp_wp_offset,
+		   zwp_bio_list_size, from_cpu);
 }
=20
 int queue_zone_wplugs_show(void *data, struct seq_file *m)

