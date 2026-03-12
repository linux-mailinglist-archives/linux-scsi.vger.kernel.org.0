Return-Path: <linux-scsi+bounces-21947-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJ78FN4ts2ksSwAAu9opvQ
	(envelope-from <linux-scsi+bounces-21947-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 12 Mar 2026 22:19:26 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C009A279EE2
	for <lists+linux-scsi@lfdr.de>; Thu, 12 Mar 2026 22:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D415317F9DE
	for <lists+linux-scsi@lfdr.de>; Thu, 12 Mar 2026 21:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED33A38B122;
	Thu, 12 Mar 2026 21:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="S1zcs8p6"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9AB3CA4A4
	for <linux-scsi@vger.kernel.org>; Thu, 12 Mar 2026 21:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773350243; cv=none; b=bvtidRLtCc6aIyrJ0oy9xNP9T6JyApQ8anz++mspSiuHJbOG1Sdc/DzB8Z53IstkeiwaUjGc86UwT9qvKVDx3Q9VjeDOHaGqBOPDoj8Df5/wAhjYFClNhoh1EZPN6XAJiaN/nQktbp7+SH71WWMBe7hcQdJbsOXfNKPwjnqWY6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773350243; c=relaxed/simple;
	bh=iM8n37gaChXnY6R0qz9AmdgjOGV29aL6mcWE/W4R030=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JJRg6vqQKWlEWAdH0bfgRct1Bb4oh/EeWbugrE5r3JnAuDG8nCVOjBMlb2L61h8i3g7CZuWA/44TBpymGmLzkn6vRNyFtjUqgvvjYy9efSMnRH93XHIHWFDOUnWZ5uOtxTPfImm2CQgKn6b9Bvr+ox0/RIJZDhJOZnUrOtqUKuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=S1zcs8p6; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fX0nG30JMzlfl5W;
	Thu, 12 Mar 2026 21:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1773350239; x=1775942240; bh=IbAMm
	sJV7UqSrgZRuvJcn4RACkeBQPhXm7nCv/4QU1U=; b=S1zcs8p6epW6JVUUjNPMa
	iS4AWcNt3PVPa4q4jTuBB5CByqYAUFVoDrw87ALP/9C+BJ7Jr/Ifsn1amSoNEn3E
	FKyL2jJp+mFgUa/lh2O31ZRjrU6TCGVTo/gm3irjkmfBu+EWsOErLV0eCJkEUOQX
	ugcbbtp7aolxoDBaeHv9kjIETzAsM3w/w8FR1nHdZxoNuAGWUuGv//328MsvSqQZ
	kR+PE2mjswxHSLkoysYDbb9Y6HrI3ZucR6TOR0foJPd/PcJyQI/rc1ZssFs8zeWW
	r5g9IskPxjWHGrNMX1aZ95ChGL+76n2YirmC17UfblqUPZEx9vv7CEYZSXajGfJB
	g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id acmYOLuQLWZl; Thu, 12 Mar 2026 21:17:19 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fX0nB1fjlzlfl7l;
	Thu, 12 Mar 2026 21:17:17 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Finn Thain <fthain@linux-m68k.org>,
	Michael Schmitz <schmitzmic@gmail.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Subject: [PATCH 07/36] scsi: NCR5380: Prepare for enabling lock context analysis
Date: Thu, 12 Mar 2026 14:15:18 -0700
Message-ID: <20260312211636.3245119-8-bvanassche@acm.org>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,acm.org,linux-m68k.org,gmail.com,HansenPartnership.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21947-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[acm.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C009A279EE2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Expand 'hostdata' in the lock context annotations because 'hostdata' is
not a function argument.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/NCR5380.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/NCR5380.c b/drivers/scsi/NCR5380.c
index 006dcf981218..029fe6362629 100644
--- a/drivers/scsi/NCR5380.c
+++ b/drivers/scsi/NCR5380.c
@@ -961,7 +961,7 @@ static irqreturn_t __maybe_unused NCR5380_intr(int ir=
q, void *dev_id)
  */
=20
 static bool NCR5380_select(struct Scsi_Host *instance, struct scsi_cmnd =
*cmd)
-	__releases(&hostdata->lock) __acquires(&hostdata->lock)
+	__must_hold(&((struct NCR5380_hostdata *)shost_priv(instance))->lock)
 {
 	struct NCR5380_hostdata *hostdata =3D shost_priv(instance);
 	unsigned char tmp[3], phase;
@@ -1657,7 +1657,7 @@ static int NCR5380_transfer_dma(struct Scsi_Host *i=
nstance,
  */
=20
 static void NCR5380_information_transfer(struct Scsi_Host *instance)
-	__releases(&hostdata->lock) __acquires(&hostdata->lock)
+	__must_hold(&((struct NCR5380_hostdata *)shost_priv(instance))->lock)
 {
 	struct NCR5380_hostdata *hostdata =3D shost_priv(instance);
 	unsigned char msgout =3D NOP;

