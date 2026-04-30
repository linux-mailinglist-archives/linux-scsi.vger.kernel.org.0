Return-Path: <linux-scsi+bounces-23514-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFuCACqe82lg5QEAu9opvQ
	(envelope-from <linux-scsi+bounces-23514-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Apr 2026 20:23:38 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BCA4A6D8C
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Apr 2026 20:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3923F303456A
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Apr 2026 18:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C160444D688;
	Thu, 30 Apr 2026 18:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="SrhsLQun"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748D839D6DE
	for <linux-scsi@vger.kernel.org>; Thu, 30 Apr 2026 18:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777573357; cv=none; b=F4QuRhKoxnNv5PcRwv6Wa9I8Y/4a6y3fxObdVNs5uLqtRruxgTVA+VyuJGqcpEy0+H3plgIgt8qHPd2xSwVfpgle+CFhxwOn3WKvFbgxqLXKOciLJXuLCz5kQK61crOM1WxxDhyapvYwCtOpTsUhbe8pz5zBjm4oVH6m+KLe6rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777573357; c=relaxed/simple;
	bh=rA9dcjB/53gL6plQiDABo3vtxCT7CnlACpzZLBieCY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m0l2QVhs5GHk1Jna9uzGXo+RbIcZGbcwroHvahwbmK0n65evupQY+0/IZRsHBcx7M41Cz/s9mI4uIeKfm19cIaOEJF5QKEKWIKWdQDgVY7VBbwO/s+cbApPpn36eRbuARRazcDT9nohYzrUQBuZ1XJaNanBTEX4Dlu4nErbZzOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=SrhsLQun; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4g62b00g2tzlfftl;
	Thu, 30 Apr 2026 18:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1777573353; x=1780165354; bh=3mD38
	fc+TmPeJmfhZePNhtdCoHpJbmZh+Kw2gU6HX2s=; b=SrhsLQundOen9dhh47wk2
	PE38HjeRhcmENUyurkSnpevmc8/4CPI46Xx1bkzuy+M/yBr+LI45PsawyCLLzp8L
	7qRJinb/Pt5aF0/ZVGLxCMJ/OzZff23yYcD5b1ri7KLxGoy8n52n65o2suu4Gifr
	Fw+Y7SeJgsQti8Rf/6u78lkxRZeAEU8QLlycLQDByS9FphbvzZesuxLEaeG4JbZv
	Ce5v1Rj5UFkjqD/1n5ijOqbp3aUWZYpWLrn0zSZE87S3yK0Bfh1aRPLv+nY+ocE8
	d6tW36jslws+pzZe7DAlb6e5Dyy7vjG+qZ4d/Tpkswxslm6Hq11S3ZtrxNHKqyN4
	g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 3UPfx9dQISBY; Thu, 30 Apr 2026 18:22:33 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4g62Zw0LQRzlffts;
	Thu, 30 Apr 2026 18:22:31 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Russell King <linux@armlinux.org.uk>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Subject: [PATCH v2 14/56] scsi: arm: Enable lock context analysis
Date: Thu, 30 Apr 2026 11:19:44 -0700
Message-ID: <20260430182130.1978347-15-bvanassche@acm.org>
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
X-Rspamd-Queue-Id: 97BCA4A6D8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-23514-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/arm/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/arm/Makefile b/drivers/scsi/arm/Makefile
index b576d9276f71..417d47644a8d 100644
--- a/drivers/scsi/arm/Makefile
+++ b/drivers/scsi/arm/Makefile
@@ -3,6 +3,8 @@
 # Makefile for drivers/scsi/arm
 #
=20
+CONTEXT_ANALYSIS :=3D y
+
 acornscsi_mod-objs	:=3D acornscsi.o acornscsi-io.o
=20
 obj-$(CONFIG_SCSI_ACORNSCSI_3)	+=3D acornscsi_mod.o queue.o msgqueue.o

