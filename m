Return-Path: <linux-scsi+bounces-21963-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ORgCY8ts2ksSwAAu9opvQ
	(envelope-from <linux-scsi+bounces-21963-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 12 Mar 2026 22:18:07 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5564279E2C
	for <lists+linux-scsi@lfdr.de>; Thu, 12 Mar 2026 22:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2739C3039DC6
	for <lists+linux-scsi@lfdr.de>; Thu, 12 Mar 2026 21:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F6C3B7B63;
	Thu, 12 Mar 2026 21:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="FKg9czjF"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A78926B2DA
	for <linux-scsi@vger.kernel.org>; Thu, 12 Mar 2026 21:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773350282; cv=none; b=fGxslTgZFioWomPbKjXy86ADK9ZyBV6SHsUlfQ3kIVncY2drXb1IpKMpHC+00yUB7E2Pet+XE/ZDLseDEwgDUVWY1xaba5AMtgHZulH8tOL28O9H6Man9+YaQcO+ABb/Jf85Tr8CVJeID9XC092FMbIhKiybd6Rd2FyrmMu9ivo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773350282; c=relaxed/simple;
	bh=342vbo+jSWIuvus37ymB6JWKPsI1lGe4DPDO3gcGr4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JjnU3jnw9E5f29zhToFVJAOT3IFBTMj0J8qmr3bCWmgb7qdxxguvsbiOdk2QGAWandA9Qe6+XbmOmbF9ypgTGhTAgLnYlkMBvc3JPp3yP4aUg8qKLeBv63s48ivjBLb8QCygmGK7B1aBKrAUruHVIWKJxSFYgf/9N6EYR9BKcf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=FKg9czjF; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fX0p100qDzlfl5V;
	Thu, 12 Mar 2026 21:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1773350277; x=1775942278; bh=03fq5
	As8Qpku8FY12z+wW/QDg5KsqYGNC+LpLlFZhEE=; b=FKg9czjFp4c++4fWAA+DH
	aB7S2mih/mvujaXGbWX4ILFy7f5wUC4/wdCgwIddln3Jo7HrAfouQLcqxxjwrN+X
	WAWJVYCcJMmvopjlvUIG/kwavwgXLWddmO9wPP0CINTOycxp28eU/I85NgYrOWCJ
	ydIA4kSDU1Yx+UtZojxS+joAUFZr1sxejuYIrgSQ/D0pmOqHHxghlcOWq/+1nbVH
	WdUR/hn+qsa1Fbo4ggfTVVvHvLWwxnjsSopCQUaIMpP1+RpgEeKXyBis1L8DjjSd
	zAWgiiLxVd2il8/C0JsqdA1ojEZ0MxZ+QKkqleDcnfE8VyE5Cg5WByNehbt2B0Zr
	g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id oz1jsuSqanuk; Thu, 12 Mar 2026 21:17:57 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fX0nv0z3Qzlfl5W;
	Thu, 12 Mar 2026 21:17:54 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Jason Yan <yanaijie@huawei.com>,
	Niklas Cassel <cassel@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH 23/36] scsi: libsas: Prepare for enabling lock context analysis
Date: Thu, 12 Mar 2026 14:15:34 -0700
Message-ID: <20260312211636.3245119-24-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
In-Reply-To: <20260312211636.3245119-1-bvanassche@acm.org>
References: <20260312211636.3245119-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21963-lists,linux-scsi=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[acm.org:+];
	TAGGED_RCPT(0.00)[linux-scsi];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B5564279E2C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Since Clang requires that lock context annotations only refer to
variables that are visible, modify a __must_hold() annotation.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/libsas/sas_ata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.=
c
index 61368e55bf86..2340790c9f6b 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -153,7 +153,7 @@ static void sas_ata_task_done(struct sas_task *task)
 }
=20
 static unsigned int sas_ata_qc_issue(struct ata_queued_cmd *qc)
-	__must_hold(ap->lock)
+	__must_hold(qc->ap->lock)
 {
 	struct sas_task *task;
 	struct scatterlist *sg;

