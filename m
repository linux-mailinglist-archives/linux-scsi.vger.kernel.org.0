Return-Path: <linux-scsi+bounces-3892-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5DC895352
	for <lists+linux-scsi@lfdr.de>; Tue,  2 Apr 2024 14:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BD56286B6D
	for <lists+linux-scsi@lfdr.de>; Tue,  2 Apr 2024 12:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C147A705;
	Tue,  2 Apr 2024 12:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYflCbU7"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A17C7A151;
	Tue,  2 Apr 2024 12:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712061552; cv=none; b=Axs17XaoD3ubygzAzVLVKlRd744nutpPUWahbOCFMVKMMCn7SyrJET+VYpMpq81wo9XOxyJA+EYz2n1nsXqGPQsDjpJ19MkkCcWRFI2uFy9HqzKJ3GY4bmRqVsShFkkX/2x9zZdbIG3U9hA2+vY1Xk9dQbOuBr3E8JdnTQPXFlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712061552; c=relaxed/simple;
	bh=0yqNrZFOQaepbT+fRTCJM2qoLk9O4d9p9W1UQpJmlfM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iWf4DIqscL7ZUSxOAMl5p+STL+tWiCkPD0ZMrQSwmhRkPLaT/rE4KJsoK+7TmGNr6gLfGr44eg/zaGNf/+yqbVUY00dWLAEYJAEbiu67UoIdS2O4//A9jvHovdsowzA+UuKOScddClrLiFZ+K0d9iyGEf+c+pSCZoOei9MFdYns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYflCbU7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B4DC433F1;
	Tue,  2 Apr 2024 12:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712061551;
	bh=0yqNrZFOQaepbT+fRTCJM2qoLk9O4d9p9W1UQpJmlfM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=pYflCbU7s91bIX9gd5wfltBtprE4s5pY8I1I8ooTg7/K0ZE8cjAnWGh7F8wvV9RyY
	 uFoShUPljab33xe5DnwSNM8tg7lSeIE/IFNDXO20n7XVRN3VZLC0UxfNy2LuLzYTL9
	 bnGWfdOJhmTUTC03OiE0UX4SEtMpzEzuEXFqUP9CHKhmmmaibNCm8nbWtQjO+4BV0Q
	 Bi/cH1OSOng5a91zYoiyyuAXw2k86/atrL64jxf4svv8IDvhsvBdWRejd8lRgEj2D9
	 H1LCy16h8dyUsktalrbjjULDKzNXHnqtNAObPDOZrYk4OXcVPiyFCabCIwZgrr7wdP
	 ehThBurLKTAnA==
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
Subject: [PATCH v4 01/28] block: Restore sector of flush requests
Date: Tue,  2 Apr 2024 21:38:40 +0900
Message-ID: <20240402123907.512027-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402123907.512027-1-dlemoal@kernel.org>
References: <20240402123907.512027-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On completion of a flush sequence, blk_flush_restore_request() restores
the bio of a request to the original submitted BIO. However, the last
use of the request in the flush sequence may have been for a POSTFLUSH
which does not have a sector. So make sure to restore the request sector
using the iter sector of the original BIO. This BIO has not changed yet
since the completions of the flush sequence intermediate steps use
requeueing of the request until all steps are completed.

Restoring the request sector ensures that blk_mq_end_request() will see
a valid sector as originally set when the flush BIO was submitted.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-flush.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index b0f314f4bc14..2f58ae018464 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -130,6 +130,7 @@ static void blk_flush_restore_request(struct request *rq)
 	 * original @rq->bio.  Restore it.
 	 */
 	rq->bio = rq->biotail;
+	rq->__sector = rq->bio->bi_iter.bi_sector;
 
 	/* make @rq a normal request */
 	rq->rq_flags &= ~RQF_FLUSH_SEQ;
-- 
2.44.0


