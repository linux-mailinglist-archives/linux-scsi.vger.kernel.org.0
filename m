Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F02A2F96D3
	for <lists+linux-scsi@lfdr.de>; Mon, 18 Jan 2021 01:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbhARAvm (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 17 Jan 2021 19:51:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36493 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730026AbhARAvf (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 17 Jan 2021 19:51:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610931008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WSdRiBknrz8VtD8cS+HWJaCt+0y1IouORAL8c959LYo=;
        b=LArrlv6SLPPvqqgiHNJzK5cV1VH+nMvEJsc5RLTUpQIQlkpujTB/u93ZoK/MlSxhFU8WSY
        Siwn9RS8oUYXACxTtVVvw3vGrhd3njX7h4ozUh3G0xiKMbYuzmprw34w+tUn+Tq5V2Oc5H
        jKfRtWUUhtAk03ER8olpCLAk9AqmmUc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-539-TQjZcKZGOXujWmUfVj7uIA-1; Sun, 17 Jan 2021 19:50:06 -0500
X-MC-Unique: TQjZcKZGOXujWmUfVj7uIA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55CDE59;
        Mon, 18 Jan 2021 00:50:04 +0000 (UTC)
Received: from localhost (ovpn-12-73.pek2.redhat.com [10.72.12.73])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0C40F10023B5;
        Mon, 18 Jan 2021 00:49:59 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@fb.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumanesh Samanta <sumanesh.samanta@broadcom.com>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH V6 06/13] sbitmap: add helper of sbitmap_calculate_shift
Date:   Mon, 18 Jan 2021 08:49:14 +0800
Message-Id: <20210118004921.202545-7-ming.lei@redhat.com>
In-Reply-To: <20210118004921.202545-1-ming.lei@redhat.com>
References: <20210118004921.202545-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
index 3aad25cbd046..e58b8d255943 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -332,6 +332,24 @@ static inline int sbitmap_test_bit(struct sbitmap *sb, unsigned int bitnr)
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
index 73da26ad021e..47b3691058eb 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -87,19 +87,9 @@ int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
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
2.28.0

