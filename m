Return-Path: <linux-scsi+bounces-23511-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yP9AAfmd82lJ5QEAu9opvQ
	(envelope-from <linux-scsi+bounces-23511-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Apr 2026 20:22:49 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 649A94A6D65
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Apr 2026 20:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38367303CD36
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Apr 2026 18:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD99247B432;
	Thu, 30 Apr 2026 18:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="FFGm+Hn+"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8642339D6DE
	for <linux-scsi@vger.kernel.org>; Thu, 30 Apr 2026 18:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777573345; cv=none; b=Qt8IYp055Ki2FdnLa/b6LIn/Jx4SFeRaQNjsM9sYY50YpEC4YOu7UophqGoka+D4tLXgKglouPxZUDffJr2hOweJPy9K/C3yzY9S7961Ur8ZPCF04Ege+BubnycX64wgu9R6syp6seNZHSpgXuRqyBlHAsXQBnlJU6VJaAQyd2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777573345; c=relaxed/simple;
	bh=N+gr+hqGOB5Q54sI/oUwLcBcZAewEvXR2LeWogI9g3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N7JHGoeWmJeXSA2TVBWuEFhPpf8VBJ4A6GQR0Qs8nIMxMuSbHbHckEdChOXdR47eHPirL99ftnuonDiaMs70en157WvT6hknqcJsxhEl+OGDC0Ndi4FeMR6MfHXkr8Y/Ltm5qBtgMv6C3xPb7dQLWTygO9E5Uv+g8EbT7VoHFOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=FFGm+Hn+; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4g62Zm0js8zlkQLv;
	Thu, 30 Apr 2026 18:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1777573340; x=1780165341; bh=o1Tld
	l7ZiAgdLI3MPfWFzUQAcKs61rgRkDsylVWtMtU=; b=FFGm+Hn+XsuPTJs1+/fkM
	HUAo1AihPTe2+VvrclnwRXWb2Eu9QjiSOuooAO3g2iGIb8puw+gx0IrW10cTJM+1
	pWOC3vO/xzZcD8yJubbynMzH6iOc9PQOQNnlMcFmWPXCpdFp0WwePM4KTUx3EA49
	C//6sxss5zvkAe91BXvjbv6JR32vb1sLnUbpa91EuaoVcwwkJHp5vLjEnFQVhI+o
	863bbP3OIdh2ue64R+2sx8l2g0zec8Ueoce1pM1X5IEakBjWqJiolcY8ru2Eu78U
	0IqYPNFUmqfLbC3U4c6rvIIH7hcapdbAfShgV8fSW30XdJf/k8g7IZF+2zKXUeUy
	Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id s1J6ggZEI1Kj; Thu, 30 Apr 2026 18:22:20 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4g62Zg0Rq1zm1W0y;
	Thu, 30 Apr 2026 18:22:18 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Hannes Reinecke <hare@suse.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Subject: [PATCH v2 11/56] scsi: aic7xxx: Prepare for enabling lock context analysis
Date: Thu, 30 Apr 2026 11:19:41 -0700
Message-ID: <20260430182130.1978347-12-bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260430182130.1978347-1-bvanassche@acm.org>
References: <20260430182130.1978347-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 649A94A6D65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-23511-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-scsi];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[acm.org:email,acm.org:dkim,acm.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Document locking requirements with __acquires() and __releases().

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/aic7xxx/aic79xx_osm.h | 2 ++
 drivers/scsi/aic7xxx/aic7xxx_osm.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/scsi/aic7xxx/aic79xx_osm.h b/drivers/scsi/aic7xxx/ai=
c79xx_osm.h
index 793fe19993a9..c6eb2b97e929 100644
--- a/drivers/scsi/aic7xxx/aic79xx_osm.h
+++ b/drivers/scsi/aic7xxx/aic79xx_osm.h
@@ -376,12 +376,14 @@ ahd_lockinit(struct ahd_softc *ahd)
=20
 static inline void
 ahd_lock(struct ahd_softc *ahd, unsigned long *flags)
+	__acquires(&ahd->platform_data->spin_lock)
 {
 	spin_lock_irqsave(&ahd->platform_data->spin_lock, *flags);
 }
=20
 static inline void
 ahd_unlock(struct ahd_softc *ahd, unsigned long *flags)
+	__releases(&ahd->platform_data->spin_lock)
 {
 	spin_unlock_irqrestore(&ahd->platform_data->spin_lock, *flags);
 }
diff --git a/drivers/scsi/aic7xxx/aic7xxx_osm.h b/drivers/scsi/aic7xxx/ai=
c7xxx_osm.h
index 51d9f4de0734..5e78fe7d3f32 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_osm.h
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm.h
@@ -389,12 +389,14 @@ ahc_lockinit(struct ahc_softc *ahc)
=20
 static inline void
 ahc_lock(struct ahc_softc *ahc, unsigned long *flags)
+	__acquires(&ahc->platform_data->spin_lock)
 {
 	spin_lock_irqsave(&ahc->platform_data->spin_lock, *flags);
 }
=20
 static inline void
 ahc_unlock(struct ahc_softc *ahc, unsigned long *flags)
+	__releases(&ahc->platform_data->spin_lock)
 {
 	spin_unlock_irqrestore(&ahc->platform_data->spin_lock, *flags);
 }

