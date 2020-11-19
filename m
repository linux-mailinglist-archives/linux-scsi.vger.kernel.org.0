Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602912B8F46
	for <lists+linux-scsi@lfdr.de>; Thu, 19 Nov 2020 10:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgKSJrg (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 19 Nov 2020 04:47:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25056 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726358AbgKSJrf (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 19 Nov 2020 04:47:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605779254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1FlWyHO+16o2KDl8pHqyk3MKvV5WZqHycr/u/6i+gg8=;
        b=OxcHDbwj/ITUczzrr60kUU8oUxicTUAO+16R8kXSnFDNldOluLgazA1fvwUBestg3YsODr
        BD2U32ZI6UFg+TbMPxMZpyZE+c6BuqxGNFijTELSJhKoAtaUGraUGbQ1f9VPi7riGjMoXC
        QzoomEKI1E1iRkTNVzEGqkiUjDm0Q+k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-WEEgg_BLPQySXkNzN_-yHQ-1; Thu, 19 Nov 2020 04:47:32 -0500
X-MC-Unique: WEEgg_BLPQySXkNzN_-yHQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D409380ED8A;
        Thu, 19 Nov 2020 09:47:30 +0000 (UTC)
Received: from localhost (ovpn-13-167.pek2.redhat.com [10.72.13.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D3F9E19C45;
        Thu, 19 Nov 2020 09:47:26 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@fb.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumanesh Samanta <sumanesh.samanta@broadcom.com>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH V5 03/13] sbitmap: add helpers for updating allocation hint
Date:   Thu, 19 Nov 2020 17:46:55 +0800
Message-Id: <20201119094705.280390-4-ming.lei@redhat.com>
In-Reply-To: <20201119094705.280390-1-ming.lei@redhat.com>
References: <20201119094705.280390-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Add helpers for updating allocation hint, so that we can
avoid to duplicate code.

Prepare for moving allocation hint into sbitmap.

Cc: Omar Sandoval <osandov@fb.com>
Cc: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Sumanesh Samanta <sumanesh.samanta@broadcom.com>
Cc: Ewan D. Milne <emilne@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Tested-by: Sumanesh Samanta <sumanesh.samanta@broadcom.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 lib/sbitmap.c | 93 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 54 insertions(+), 39 deletions(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 8d920d66d42a..4e4423414f4d 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -9,6 +9,55 @@
 #include <linux/sbitmap.h>
 #include <linux/seq_file.h>
 
+static int init_alloc_hint(struct sbitmap_queue *sbq, gfp_t flags)
+{
+	unsigned depth = sbq->sb.depth;
+
+	sbq->alloc_hint = alloc_percpu_gfp(unsigned int, flags);
+	if (!sbq->alloc_hint)
+		return -ENOMEM;
+
+	if (depth && !sbq->sb.round_robin) {
+		int i;
+
+		for_each_possible_cpu(i)
+			*per_cpu_ptr(sbq->alloc_hint, i) = prandom_u32() % depth;
+	}
+
+	return 0;
+}
+
+static inline unsigned update_alloc_hint_before_get(struct sbitmap_queue *sbq,
+						    unsigned int depth)
+{
+	unsigned hint;
+
+	hint = this_cpu_read(*sbq->alloc_hint);
+	if (unlikely(hint >= depth)) {
+		hint = depth ? prandom_u32() % depth : 0;
+		this_cpu_write(*sbq->alloc_hint, hint);
+	}
+
+	return hint;
+}
+
+static inline void update_alloc_hint_after_get(struct sbitmap_queue *sbq,
+					       unsigned int depth,
+					       unsigned int hint,
+					       unsigned int nr)
+{
+	if (nr == -1) {
+		/* If the map is full, a hint won't do us much good. */
+		this_cpu_write(*sbq->alloc_hint, 0);
+	} else if (nr == hint || unlikely(sbq->sb.round_robin)) {
+		/* Only update the hint if we used it. */
+		hint = nr + 1;
+		if (hint >= depth - 1)
+			hint = 0;
+		this_cpu_write(*sbq->alloc_hint, hint);
+	}
+}
+
 /*
  * See if we have deferred clears that we can batch move
  */
@@ -363,17 +412,11 @@ int sbitmap_queue_init_node(struct sbitmap_queue *sbq, unsigned int depth,
 	if (ret)
 		return ret;
 
-	sbq->alloc_hint = alloc_percpu_gfp(unsigned int, flags);
-	if (!sbq->alloc_hint) {
+	if (init_alloc_hint(sbq, flags) != 0) {
 		sbitmap_free(&sbq->sb);
 		return -ENOMEM;
 	}
 
-	if (depth && !round_robin) {
-		for_each_possible_cpu(i)
-			*per_cpu_ptr(sbq->alloc_hint, i) = prandom_u32() % depth;
-	}
-
 	sbq->min_shallow_depth = UINT_MAX;
 	sbq->wake_batch = sbq_calc_wake_batch(sbq, depth);
 	atomic_set(&sbq->wake_index, 0);
@@ -426,24 +469,10 @@ int __sbitmap_queue_get(struct sbitmap_queue *sbq)
 	unsigned int hint, depth;
 	int nr;
 
-	hint = this_cpu_read(*sbq->alloc_hint);
 	depth = READ_ONCE(sbq->sb.depth);
-	if (unlikely(hint >= depth)) {
-		hint = depth ? prandom_u32() % depth : 0;
-		this_cpu_write(*sbq->alloc_hint, hint);
-	}
+	hint = update_alloc_hint_before_get(sbq, depth);
 	nr = sbitmap_get(&sbq->sb, hint);
-
-	if (nr == -1) {
-		/* If the map is full, a hint won't do us much good. */
-		this_cpu_write(*sbq->alloc_hint, 0);
-	} else if (nr == hint || unlikely(sbq->sb.round_robin)) {
-		/* Only update the hint if we used it. */
-		hint = nr + 1;
-		if (hint >= depth - 1)
-			hint = 0;
-		this_cpu_write(*sbq->alloc_hint, hint);
-	}
+	update_alloc_hint_after_get(sbq, depth, hint, nr);
 
 	return nr;
 }
@@ -457,24 +486,10 @@ int __sbitmap_queue_get_shallow(struct sbitmap_queue *sbq,
 
 	WARN_ON_ONCE(shallow_depth < sbq->min_shallow_depth);
 
-	hint = this_cpu_read(*sbq->alloc_hint);
 	depth = READ_ONCE(sbq->sb.depth);
-	if (unlikely(hint >= depth)) {
-		hint = depth ? prandom_u32() % depth : 0;
-		this_cpu_write(*sbq->alloc_hint, hint);
-	}
+	hint = update_alloc_hint_before_get(sbq, depth);
 	nr = sbitmap_get_shallow(&sbq->sb, hint, shallow_depth);
-
-	if (nr == -1) {
-		/* If the map is full, a hint won't do us much good. */
-		this_cpu_write(*sbq->alloc_hint, 0);
-	} else if (nr == hint || unlikely(sbq->sb.round_robin)) {
-		/* Only update the hint if we used it. */
-		hint = nr + 1;
-		if (hint >= depth - 1)
-			hint = 0;
-		this_cpu_write(*sbq->alloc_hint, hint);
-	}
+	update_alloc_hint_after_get(sbq, depth, hint, nr);
 
 	return nr;
 }
-- 
2.25.4

