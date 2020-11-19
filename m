Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E322B8F09
	for <lists+linux-scsi@lfdr.de>; Thu, 19 Nov 2020 10:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgKSJe6 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 19 Nov 2020 04:34:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20813 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726358AbgKSJe5 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 19 Nov 2020 04:34:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605778496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ny3Aw/ziwKoa38/xY1iai/R3EsDNWVT2JPkt/hHmx50=;
        b=CG58psJd48qyF9HrHjTHVHrMjf4fMLx3z/b8ykMGMdAwTNDfoyeUZO2m/8S16ALybcNHAw
        RZJwLfMf1xVsxaEgfht4RDJug/5JXkZV7QOKBZPU6CZJbLhNr4AEqt/UJ4KLhQM7O5b85d
        fyaClkPQoqBYZkivTLjXoblJK4XDu5M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-dwc64IhXNFKSsoLbSJQccQ-1; Thu, 19 Nov 2020 04:34:52 -0500
X-MC-Unique: dwc64IhXNFKSsoLbSJQccQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5596818B6126;
        Thu, 19 Nov 2020 09:34:50 +0000 (UTC)
Received: from localhost (ovpn-13-167.pek2.redhat.com [10.72.13.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 518BA60636;
        Thu, 19 Nov 2020 09:34:45 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@fb.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumanesh Samanta <sumanesh.samanta@broadcom.com>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH V5 06/13] sbitmap: add helper of sbitmap_calculate_shift
Date:   Thu, 19 Nov 2020 17:33:55 +0800
Message-Id: <20201119093402.279318-7-ming.lei@redhat.com>
In-Reply-To: <20201119093402.279318-1-ming.lei@redhat.com>
References: <20201119093402.279318-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Move code for calculating default shift into one public helper,
which can be used for SCSI to calculate shift.

Cc: Omar Sandoval <osandov@fb.com>
Cc: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Sumanesh Samanta <sumanesh.samanta@broadcom.com>
Cc: Ewan D. Milne <emilne@redhat.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Tested-by: Sumanesh Samanta <sumanesh.samanta@broadcom.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/sbitmap.h | 18 ++++++++++++++++++
 lib/sbitmap.c           | 16 +++-------------
 2 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index c1706cfd1ab3..77760279e82c 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -337,6 +337,24 @@ static inline int sbitmap_test_bit(struct sbitmap *sb, unsigned int bitnr)
 	return test_bit(SB_NR_TO_BIT(sb, bitnr), __sbitmap_word(sb, bitnr));
 }
 
+static inline int sbitmap_calculate_shift(unsigned int depth)
+{
+	int	shift = ilog2(BITS_PER_LONG);
+
+	/*
+	 * If the bitmap is small, shrink the number of bits per word so
+	 * we spread over a few cachelines, at least. If less than 4
+	 * bits, just forget about it, it's not going to work optimally
+	 * anyway.
+	 */
+	if (depth >= 4) {
+		while ((4U << shift) > depth)
+			shift--;
+	}
+
+	return shift;
+}
+
 /**
  * sbitmap_show() - Dump &struct sbitmap information to a &struct seq_file.
  * @sb: Bitmap to show.
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index fb1d3c2f70a2..c5a58cf7731b 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -96,19 +96,9 @@ int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
 	unsigned int bits_per_word;
 	unsigned int i;
 
-	if (shift < 0) {
-		shift = ilog2(BITS_PER_LONG);
-		/*
-		 * If the bitmap is small, shrink the number of bits per word so
-		 * we spread over a few cachelines, at least. If less than 4
-		 * bits, just forget about it, it's not going to work optimally
-		 * anyway.
-		 */
-		if (depth >= 4) {
-			while ((4U << shift) > depth)
-				shift--;
-		}
-	}
+	if (shift < 0)
+		shift = sbitmap_calculate_shift(depth);
+
 	bits_per_word = 1U << shift;
 	if (bits_per_word > BITS_PER_LONG)
 		return -EINVAL;
-- 
2.25.4

