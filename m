Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07E5217431B
	for <lists+linux-scsi@lfdr.de>; Sat, 29 Feb 2020 00:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgB1XaJ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 28 Feb 2020 18:30:09 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59738 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726765AbgB1XaI (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 28 Feb 2020 18:30:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582932607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dNMWdKtvi6Hy1HcK6nwSHcXHEGZv8eiC4BgPrfgPvCs=;
        b=Ryqr5p9uZoH92hBrbKtW67JcKrAfVp0iNzAz9vBwzM+KO2B5Vs1ySwQJNYmmwEtG0NfPqO
        wBUs6Onh4Hk9rPuLdpWaNnOEtHO83lLTwYwlZImB4yMxKvEsuX7Z0uRY3MmeyONOId6BvG
        LzgsXlXk8PHvHODET3vH1RPVTJYLTFU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-AAw9EoVnPTiiQu9DPPeiHA-1; Fri, 28 Feb 2020 18:30:03 -0500
X-MC-Unique: AAw9EoVnPTiiQu9DPPeiHA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69C5E800D5F;
        Fri, 28 Feb 2020 23:30:01 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8B8CE101D491;
        Fri, 28 Feb 2020 23:30:00 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@fb.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH V2 06/10] sbitmap: add helper of sbitmap_calculate_shift
Date:   Sat, 29 Feb 2020 07:29:16 +0800
Message-Id: <20200228232920.20960-7-ming.lei@redhat.com>
In-Reply-To: <20200228232920.20960-1-ming.lei@redhat.com>
References: <20200228232920.20960-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Move code for calculating default shift into one public helper,
which can be used for SCSI to calculate shift.

Cc: Omar Sandoval <osandov@fb.com>
Cc: Sathya Prakash <sathya.prakash@broadcom.com>
Cc: Chaitra P B <chaitra.basappa@broadcom.com>
Cc: Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Cc: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Sumit Saxena <sumit.saxena@broadcom.com>
Cc: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Cc: Ewan D. Milne <emilne@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/sbitmap.h | 18 ++++++++++++++++++
 lib/sbitmap.c           | 16 +++-------------
 2 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index 34343ce3ef6c..2a40364d6d00 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -337,6 +337,24 @@ static inline int sbitmap_test_bit(struct sbitmap *s=
b, unsigned int bitnr)
 	return test_bit(SB_NR_TO_BIT(sb, bitnr), __sbitmap_word(sb, bitnr));
 }
=20
+static inline int sbitmap_calculate_shift(unsigned int depth)
+{
+	int	shift =3D ilog2(BITS_PER_LONG);
+
+	/*
+	 * If the bitmap is small, shrink the number of bits per word so
+	 * we spread over a few cachelines, at least. If less than 4
+	 * bits, just forget about it, it's not going to work optimally
+	 * anyway.
+	 */
+	if (depth >=3D 4) {
+		while ((4U << shift) > depth)
+			shift--;
+	}
+
+	return shift;
+}
+
 /**
  * sbitmap_show() - Dump &struct sbitmap information to a &struct seq_fi=
le.
  * @sb: Bitmap to show.
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 254475865b3d..bb88a3643d64 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -96,19 +96,9 @@ int sbitmap_init_node(struct sbitmap *sb, unsigned int=
 depth, int shift,
 	unsigned int bits_per_word;
 	unsigned int i;
=20
-	if (shift < 0) {
-		shift =3D ilog2(BITS_PER_LONG);
-		/*
-		 * If the bitmap is small, shrink the number of bits per word so
-		 * we spread over a few cachelines, at least. If less than 4
-		 * bits, just forget about it, it's not going to work optimally
-		 * anyway.
-		 */
-		if (depth >=3D 4) {
-			while ((4U << shift) > depth)
-				shift--;
-		}
-	}
+	if (shift < 0)
+		shift =3D sbitmap_calculate_shift(depth);
+
 	bits_per_word =3D 1U << shift;
 	if (bits_per_word > BITS_PER_LONG)
 		return -EINVAL;
--=20
2.20.1

