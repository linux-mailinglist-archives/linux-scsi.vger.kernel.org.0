Return-Path: <linux-scsi+bounces-25683-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ampRNF/9S2rceAEAu9opvQ
	(envelope-from <linux-scsi+bounces-25683-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 06 Jul 2026 21:09:19 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 308D1714D12
	for <lists+linux-scsi@lfdr.de>; Mon, 06 Jul 2026 21:09:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=meta.com header.s=s2048-2025-q2 header.b="gC6p/kdt";
	dmarc=pass (policy=reject) header.from=meta.com;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25683-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25683-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE70B362D862
	for <lists+linux-scsi@lfdr.de>; Mon,  6 Jul 2026 17:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AE21A316E;
	Mon,  6 Jul 2026 17:35:20 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2593B7B68
	for <linux-scsi@vger.kernel.org>; Mon,  6 Jul 2026 17:35:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783359320; cv=none; b=nrj2SSFPcuh5vOSrH9VUQ/LKg+sd2H5mBIya0AXUrFG0PGHIt7han3hRxXp1tvgO4RYD6FGq8T9FdyY518xmN3YQ4y0FTstatS2urbuBbNnraFSzNj4y1hrals8FaEaCMxMD3kqrbLUb/EmIBxFEUZoHzZbKl1YDZDNYk8lOejU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783359320; c=relaxed/simple;
	bh=K71e339q7TqUJAYyqWN/qTmLFxi/UmIsTHjT1hjaeqU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RC8ZKK91MNWJzmU2q2L2cjDGnYh4Lddd4/USAjeiROhtNqdX17UYhE8/fOfivynKQhy+Jn7FqC9UnWomfY5Mu/xXVQ4WTRZB6ZLQis9vhqkOT3T1CSrTFSX1Dp6bHAg7B2gMcFUYf+I0rTy9WlOEAROpWDSm/SjSPvmeXSWMBCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=gC6p/kdt; arc=none smtp.client-ip=67.231.145.42
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666GjHPe1857558
	for <linux-scsi@vger.kernel.org>; Mon, 6 Jul 2026 10:35:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=7BEFwvLjfQl1CU/gINz2nIT5ihFDOQBXSnV7ryfq5nA=; b=gC6p/kdtv4S3
	5iAnxxTCjI0t29upJ7M1WwxJ+pUDzj5nRcV5bDi9yths7feGAp2bP0Ss36dkg/XS
	AtjSuRlt1K1E3F3GiuVVBuQgT8Om6KRiiJE2rY1BAUp+hyFedIyB/GAEiuF1AKRq
	3qCnwuDCJ1VwmFVwecVzT8JmiscPfKmywlmkaBNhX2M82jlrZEjydLk2lvfTGU2H
	LNwrRZkZ60dWg1RN5Bw8+DPuvK9B0mXihSxi9JXIZSoksGiCnhAusALH3C+QQMYG
	NNbrFqphmh5OHdgP1ohQuXUCNOJIt05L1wdQ6i+yuwUrTDGdCpFaDROwTEjR5OX2
	adZbx+RwYg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4f6wg1m9b4-14
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-scsi@vger.kernel.org>; Mon, 06 Jul 2026 10:35:18 -0700 (PDT)
Received: from twshared98500.16.frc2.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Mon, 6 Jul 2026 17:35:15 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 58E03249DC6D9; Mon,  6 Jul 2026 10:34:55 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>
CC: <linux-scsi@vger.kernel.org>, <axboe@kernel.dk>, <hch@lst.de>,
        <bvanassche@acm.org>, <sumit.saxena@broadcom.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [RFC PATCH 3/6] blk-mq: factor out a per-hctx tag busy iterator
Date: Mon, 6 Jul 2026 10:34:35 -0700
Message-ID: <20260706173438.3537347-4-kbusch@meta.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706173438.3537347-1-kbusch@meta.com>
References: <20260706173438.3537347-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: arWGIM35ajAFhdpDzNvCTQF192Q2TcMR
X-Proofpoint-ORIG-GUID: arWGIM35ajAFhdpDzNvCTQF192Q2TcMR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE3NyBTYWx0ZWRfXwDE8uMW8k+JJ
 zRL25DtwMSewYbHwzgITSrJsM7jTrgTAoD+gK+lx0bMsxlX05H1QhsV5o6ChkZkRtytKb/9FjNL
 ABG0G4WKOmN9aWRqgMyDL3+PZ+kZKA7U0gSgFvNcMwEh389sinRykzbLAE9HgdMcZlrvRNA6zCP
 BwDJ3nebv2nhyMKeqigFD8shnggtY7xEzCcV9IsXWCUSxjU5VTgWhmh4Ns9V7Mn9wLgPHapVqFv
 FQhabL5V0/JjYNDo3UlzCL+8plbVwLlIUeG0YBidTDGd4qFofofRZAcY+mQ5AL6eT+sI/a9e258
 uo4UKQ03hNQ+wFJyuZEzJH3C1jLpmwLO8mKa/BkPdHnWhwomalsXrfNMXdILp6vjd3c7fguwPEd
 NthF2Nu9jIeKfkkg4nF+w2TiriSkX++mRwkM7lbh/m5PhZhAbquJLNpDlA/bcKMii/GEJ5DRoGP
 sZThB1rGF6kb8gC5y0A==
X-Authority-Analysis: v=2.4 cv=EpfiaycA c=1 sm=1 tr=0 ts=6a4be756 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=8elwO82fXORLTBIkMd32:22 a=VwQbUJbxAAAA:8 a=7mcLuo5Pn-Xy9yioAo8A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE3NyBTYWx0ZWRfX7NuN1RGifz7U
 f8nSJIonl1s2QP8MAtntSEziPFTi4GeBBPEaIDNh9AReToOwzOSNPJfkaKSDPpiKqFH/7za9P/5
 do5zPoojfKEvGSfc7b8br3qErHhCG6g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[meta.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25683-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-block@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:axboe@kernel.dk,m:hch@lst.de,m:bvanassche@acm.org,m:sumit.saxena@broadcom.com,m:kbusch@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kbusch@meta.com,linux-scsi@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[meta.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kbusch@meta.com,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:from_mime,meta.com:dkim,meta.com:mid];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 308D1714D12

From: Keith Busch <kbusch@kernel.org>

Make a helper for walking the busy tags of specific hardware queue based
on the per-hctx walk into __blk_mq_hctx_tag_busy_iter() so it can be
reused to iterate a single hardware queue's tags. No functional change.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-mq-tag.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 0dd497225c74a..58cf480df9c69 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -582,6 +582,28 @@ void blk_mq_tagset_wait_completed_request(struct blk=
_mq_tag_set *tagset)
 }
 EXPORT_SYMBOL(blk_mq_tagset_wait_completed_request);
=20
+static void __blk_mq_hctx_tag_busy_iter(struct blk_mq_hw_ctx *hctx,
+					busy_tag_iter_fn *fn, void *priv)
+{
+	struct blk_mq_tags *tags =3D hctx->tags;
+
+	/*
+	 * If no software queues are currently mapped to this hardware queue,
+	 * there's nothing to check
+	 */
+	if (!blk_mq_hw_queue_mapped(hctx))
+		return;
+
+	if (tags->nr_reserved_tags)
+		bt_for_each(hctx, hctx->queue, &tags->breserved_tags, fn, priv, true);
+	bt_for_each(hctx, hctx->queue, &tags->bitmap_tags, fn, priv, false);
+}
+
 /**
  * blk_mq_queue_tag_busy_iter - iterate over all requests with a driver =
tag
  * @q:		Request queue to examine.
@@ -621,22 +643,8 @@ void blk_mq_queue_tag_busy_iter(struct request_queue=
 *q, busy_tag_iter_fn *fn,
 		struct blk_mq_hw_ctx *hctx;
 		unsigned long i;
=20
-		queue_for_each_hw_ctx(q, hctx, i) {
-			struct blk_mq_tags *tags =3D hctx->tags;
-			struct sbitmap_queue *bresv =3D &tags->breserved_tags;
-			struct sbitmap_queue *btags =3D &tags->bitmap_tags;
-
-			/*
-			 * If no software queues are currently mapped to this
-			 * hardware queue, there's nothing to check
-			 */
-			if (!blk_mq_hw_queue_mapped(hctx))
-				continue;
-
-			if (tags->nr_reserved_tags)
-				bt_for_each(hctx, q, bresv, fn, priv, true);
-			bt_for_each(hctx, q, btags, fn, priv, false);
-		}
+		queue_for_each_hw_ctx(q, hctx, i)
+			__blk_mq_hctx_tag_busy_iter(hctx, fn, priv);
 	}
 	srcu_read_unlock(&q->tag_set->tags_srcu, srcu_idx);
 	blk_queue_exit(q);
--=20
2.52.0


