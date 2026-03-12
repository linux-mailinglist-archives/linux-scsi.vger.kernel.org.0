Return-Path: <linux-scsi+bounces-21956-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJttLYcts2ksSwAAu9opvQ
	(envelope-from <linux-scsi+bounces-21956-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 12 Mar 2026 22:17:59 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B93C3279E1D
	for <lists+linux-scsi@lfdr.de>; Thu, 12 Mar 2026 22:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C31C1301731A
	for <lists+linux-scsi@lfdr.de>; Thu, 12 Mar 2026 21:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F523C554A;
	Thu, 12 Mar 2026 21:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="YJd/y5ul"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAF426B2DA
	for <linux-scsi@vger.kernel.org>; Thu, 12 Mar 2026 21:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773350274; cv=none; b=cxDGvwCFDNj8VI7KBP6T51mT8nnjB6f1OyvpmHOGFN1KUJ7+q8dt/tpv0MH0EgNGnZDvJXjcLK9tqrlDS57LcC3J3JTqLRrmv7JQAOzRwzS7/kbAwmZCOrMkU+27kCz05PfSyj/r5WQuQHnKnAMcSP7qwgwbHmeEzutX3qD7wB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773350274; c=relaxed/simple;
	bh=Uh2kqNzenSgeuokHHwOo59nRuvU3MlOuJNSDr8grqTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WrPX5RqIVhNhd124IHxZHW7sQnXjAESNmqp1FdwmuWY4kAuJqJCg/gNDp1Rtp/rB5e+btLOcYdFV6zH3yAfTt7XPdimywsnw71kLCXem32A5CVb2LOgxducZmZba9ws0IEGe8JeDByAr9T/gIaDu1DrpBGQBhjKeJm1eYPjTW9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=YJd/y5ul; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fX0nr4j1SzlfjRJ;
	Thu, 12 Mar 2026 21:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1773350269; x=1775942270; bh=T8bCX
	+kZFkL4o/NjINdXo14hgrpSu5S5lRQMb0p/oEI=; b=YJd/y5ulO3J5rkuTSdBDo
	b2mK6Ar+1T3nsMtIFxKX0ISUyFPrN6gPLeOBvX5HLVCBEitLiegkwf0ZF2ODfZ9W
	+SBM2JyPuNqxRKTXGcVnhtqd7zWurfdUrNbDBqHXUPx0OpMfIWFEtGQ+2akhDd36
	KIIO/2ziiMfnd8SXloaZth+IvF5iVkFmYfssfWNL6HjPbaCNMmyUz01pie3Oo4ZN
	cdxxDsum30h3Gmsa8AX4f62EVfxWIsiC7bpKgyVIo6jWSXtTs9Wn0bvbtpEu+TOF
	ubB0qWDM5myfjYyJGkXtOkG4yrfux+66ucvc0WaR7V4v7XVFsMWVPmb3M287aXH2
	w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Y7raQuOV1xvm; Thu, 12 Mar 2026 21:17:49 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fX0ng6Cp6zlfl5V;
	Thu, 12 Mar 2026 21:17:43 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Don Brace <don.brace@microchip.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 17/36] scsi: hpsa: Prepare for enabling lock context analysis
Date: Thu, 12 Mar 2026 14:15:28 -0700
Message-ID: <20260312211636.3245119-18-bvanassche@acm.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21956-lists,linux-scsi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[acm.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B93C3279E1D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

mutex_lock_interruptible() returns a negative value upon failure or zero
upon success. Since the Clang thread-safety analyzer only supports =3D=3D=
 0
and !=3D 0 tests for functions that perform conditional locking, change
the =3D=3D -EINTR test into !=3D 0. This change does not modify the behav=
ior
of hpsa_do_reset().

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/hpsa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index a1b116cd4723..1b3595c6e036 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -3163,7 +3163,7 @@ static int hpsa_do_reset(struct ctlr_info *h, struc=
t hpsa_scsi_dev_t *dev,
 	int rc =3D 0;
=20
 	/* We can really only handle one reset at a time */
-	if (mutex_lock_interruptible(&h->reset_mutex) =3D=3D -EINTR) {
+	if (mutex_lock_interruptible(&h->reset_mutex)) {
 		dev_warn(&h->pdev->dev, "concurrent reset wait interrupted.\n");
 		return -EINTR;
 	}

