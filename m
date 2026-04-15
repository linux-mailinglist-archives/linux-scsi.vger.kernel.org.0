Return-Path: <linux-scsi+bounces-22949-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLKsGF0r32nOPgAAu9opvQ
	(envelope-from <linux-scsi+bounces-22949-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 15 Apr 2026 08:08:29 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD98400BAE
	for <lists+linux-scsi@lfdr.de>; Wed, 15 Apr 2026 08:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE6F23023E1F
	for <lists+linux-scsi@lfdr.de>; Wed, 15 Apr 2026 06:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94F737F8A9;
	Wed, 15 Apr 2026 06:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vp09enV8"
X-Original-To: linux-scsi@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E42B1D6195;
	Wed, 15 Apr 2026 06:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776233303; cv=none; b=gAqCoHbSAElGolpVThstH8vbXwz/bcs+XquNBXQhML/jojP5sVbL4BH8Oe/BpqZsH5dJryjgYzihQcrwnDBeMfnag6874iZgF8/o9K2csceGkQSgybg0B93qF3v8nDhhTyycNZ15lu1q1ubk90Qtfds9JujzhLKtZVqtj4i5UZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776233303; c=relaxed/simple;
	bh=8jBq4cyz2BUIwnVTUA9cDrMyNHGSBbQxzd3aa2SS1fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sr2OgjIMGxSSQkrCPI5XdutxF4QJB7GqP4jL/uOocnT3EKsTn2xf8NMORAArh2V41XC4z1f9d6q9TrAqwJu2E6Bxart1jO+SekR4R6TcxXW43IiqX6deT8D68FLt7O8Z4U8Pjmax6HP/wC5Fgis+97oEAX20Kd8NHSabNi/edg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vp09enV8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=1Z2UqEtEP4yNvRM+XPzG4KQRTaiD6rIubYf/Vva2dZI=; b=vp09enV845O0/XFERCp7NJjOwk
	gErGoeXKwrJdZtwPvITEytgO2VdVUBWXomuzpxVixE00BAyZfLm/SiFj3FDK1KvJutWgcOZXpYD/O
	/lPREtDFwnld/wKvp3YwwmTE4CNaiNyp5fUw4vllNmajxC6A/GAg52Sgv8IkfX6Dtt/HIcyKjqcjh
	vBHz0k7OYuUo1ihdDBNxSMFILprSIQ4Ran9UDnkIlNxWXr7QXGKtrHdknopFohlaCAGly0taPxVhI
	iyn9WhvdAHmTwG3JAMha/GqVCqJU9bsWV6HXHfU3GYnbRAU2yVmNYlwTjV44iQfq3DsYiKuB73Hm+
	1S0PwoBA==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCtQD-00000000d3U-0nY5;
	Wed, 15 Apr 2026 06:08:21 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Doug Gilbert <dgilbert@interlog.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org
Subject: [PATCH 1/2] sg: don't use GFP_ATOMIC in sg_start_req
Date: Wed, 15 Apr 2026 08:08:06 +0200
Message-ID: <20260415060813.807659-2-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415060813.807659-1-hch@lst.de>
References: <20260415060813.807659-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-22949-lists,linux-scsi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,lst.de:mid,lst.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,wdc.com:email]
X-Rspamd-Queue-Id: BDD98400BAE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

sg_start_req is called from normal user context and can sleep when
waiting for memory.  Switch it to use GFP_KERNEL, which fixes allocation
failures seend with the bio_alloc rework.

Fixes: b520c4eef83d ("block: split bio_alloc_bioset more clearly into a fast and slowpath")
Reported-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 drivers/scsi/sg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 37bac49f30f0..43265f012ce9 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1811,7 +1811,7 @@ sg_start_req(Sg_request *srp, unsigned char *cmd)
 	}
 
 	res = blk_rq_map_user_io(rq, md, hp->dxferp, hp->dxfer_len,
-			GFP_ATOMIC, iov_count, iov_count, 1, rw);
+			GFP_KERNEL, iov_count, iov_count, 1, rw);
 	if (!res) {
 		srp->bio = rq->bio;
 
-- 
2.53.0


