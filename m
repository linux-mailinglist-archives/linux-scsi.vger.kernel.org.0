Return-Path: <linux-scsi+bounces-4027-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 257AF89694D
	for <lists+linux-scsi@lfdr.de>; Wed,  3 Apr 2024 10:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEF161F2BCE5
	for <lists+linux-scsi@lfdr.de>; Wed,  3 Apr 2024 08:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DE983CC9;
	Wed,  3 Apr 2024 08:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+XG5dQP"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82946D1AF;
	Wed,  3 Apr 2024 08:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712133806; cv=none; b=dnbRDZBrXkJfUopo2Y/gKuOVSVrvDEzCJMJrN2opiqEm6j9zyWEWk2CzvKJIRKK6KGhXfmRiP3bC0qwKl4AQ9Dt8ZcXTRw6KxDa4tr/kNBRcrnmTOLubgPuSLIldNa67ErE8oZzwtoDnpJLqELKlRlVBV3I/6zqZefEmo709EqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712133806; c=relaxed/simple;
	bh=swSQmLVcxXZAAaPOdJC4n8okb3JMRstty8OESc7Mb0Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TvFWX/EDnU+7zbQreo/gEEgW50Cuyi9+QEHdTDLV+tQL7GP9xUrVkN+PnrJw2RBF8xmE7FsVWNiXgYdJ1e5XzjKP82V4W4cwl02VGiM3vwYLITT9G4MFARKf0Dd5QZ/mtMQF3w8LWwqbEMoJmQMwKyqIu45Z2HlWEOA3udHWjy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+XG5dQP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9F7C43390;
	Wed,  3 Apr 2024 08:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712133806;
	bh=swSQmLVcxXZAAaPOdJC4n8okb3JMRstty8OESc7Mb0Q=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=L+XG5dQPK3OEoJhS7JDkk6+6SRWeWPCto2t+qQTOPYiilPaF6tB0rsQqp02pMdpR5
	 3+DXqOWHXKJgXfvq8NWeezxHm/uik08lEWoY5LqDueKtDoE56/gr5nPyIdvnKo+hf3
	 SBQJIf6S3r/8FPopNvxdg4H/NyCaLW7ixbIta+XWAFexRPU1ii/bFQom3owjA9PjoV
	 m/gN+upjTp90M7Wn5Gmvw9XmxVtgH1q3ZnR59wNroWYCX4S1ydwrpdgJd7o72iiPsv
	 s0N9Gwo5hg0fFWxliqfQNtNxCUU5FZ2QXDDLgZ7xuTMOIF11epxSJW27ecAwlEdxt0
	 fUj/29tkqiNVw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@redhat.com>,
	linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 23/28] block: Do not check zone type in blk_check_zone_append()
Date: Wed,  3 Apr 2024 17:42:42 +0900
Message-ID: <20240403084247.856481-24-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403084247.856481-1-dlemoal@kernel.org>
References: <20240403084247.856481-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Zone append operations are only allowed to target sequential write
required zones. blk_check_zone_append() uses bio_zone_is_seq() to check
this. However, this check is not necessary because:
1) For NVMe ZNS namespace devices, only sequential write required zones
   exist, making the zone type check useless.
2) For null_blk, the driver will fail the request anyway, thus notifying
   the user that a conventional zone was targeted.
3) For all other zoned devices, zone append is now emulated using zone
   write plugging, which checks that a zone append operation does not
   target a conventional zone.

In preparation for the removal of zone write locking and its
conventional zone bitmap (used by bio_zone_is_seq()), remove the
bio_zone_is_seq() call from blk_check_zone_append().

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 3bf28149e104..e1a5344c2257 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -589,8 +589,7 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
 		return BLK_STS_NOTSUPP;
 
 	/* The bio sector must point to the start of a sequential zone */
-	if (!bdev_is_zone_start(bio->bi_bdev, bio->bi_iter.bi_sector) ||
-	    !bio_zone_is_seq(bio))
+	if (!bdev_is_zone_start(bio->bi_bdev, bio->bi_iter.bi_sector))
 		return BLK_STS_IOERR;
 
 	/*
-- 
2.44.0


