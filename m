Return-Path: <linux-scsi+bounces-23527-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOjjFpCe82lJ5QEAu9opvQ
	(envelope-from <linux-scsi+bounces-23527-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Apr 2026 20:25:20 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE834A6E4B
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Apr 2026 20:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB8D6303309D
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Apr 2026 18:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C13C477E43;
	Thu, 30 Apr 2026 18:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="KJMhcw4U"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F28344D688
	for <linux-scsi@vger.kernel.org>; Thu, 30 Apr 2026 18:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777573418; cv=none; b=iEDLSgiW3sIFyQzsMYoGPujAffuhXy/Lv08UJP3JlqbOT4FWkwHKkGqqGzBqc9P4dstB73s3FJawIW1InK3W9RtvT2LozpYEcyFPHujl94EE4kq/+FN30vl/ea1thyKx4No67b/xn42zkWFsNkTyF0gTLC41neW9CBqzLbWZsJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777573418; c=relaxed/simple;
	bh=Uh2kqNzenSgeuokHHwOo59nRuvU3MlOuJNSDr8grqTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o8AVgEi0etRjMGsMSIHFhVigOgEQeIQ1votjQ+L8TdrbOO0YwmnyscFRN65qpqNAlKeagaBpmZLjQVcYhf7RShS2kZbzqoOR4Xd4EmlJ1K7utuiPHCjoBK3Aa64Jr7T0wNrpzV9BZwe8cfFePIo/bZLpyTDBqcxjtYOs78HPEmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=KJMhcw4U; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4g62c86Zf7zlfdfc;
	Thu, 30 Apr 2026 18:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1777573413; x=1780165414; bh=T8bCX
	+kZFkL4o/NjINdXo14hgrpSu5S5lRQMb0p/oEI=; b=KJMhcw4UOLWQxf+cY1z9m
	eN4vYSDOwAy+02RCfez1I3CVufLSSZptdeCZYwjwpb/eWluY0fK8PQ0ZVmOPj4Gi
	0Qmumxa1uuyLWQDRfFr77wLjEbnMDqFM5v13Bjh+VMfMXVhbU38o/WaKEwFvgLdJ
	ZKn6iUGzpBsQkrrXy6muS4j/EYMzbnqpaQdNSJVSlB7xzCZtpLCjQ22PiARoh1aL
	X04yXGrJ8uzVbFs+1GF0W0zf8wt10s3FpqdKgFHtWMDQwg0m+TstLp3XvJXa44vK
	G+xgQVZvsNthwldQupxeiiBvbolAkSL/mhzS2HUQtDT4u6+p3d1zqA6j5ZtiZ8ah
	Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id g3tSL03hIvQm; Thu, 30 Apr 2026 18:23:33 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4g62c32GnfzlfvpH;
	Thu, 30 Apr 2026 18:23:31 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Don Brace <don.brace@microchip.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 28/56] scsi: hpsa: Prepare for enabling lock context analysis
Date: Thu, 30 Apr 2026 11:19:58 -0700
Message-ID: <20260430182130.1978347-29-bvanassche@acm.org>
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
X-Rspamd-Queue-Id: EEE834A6E4B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23527-lists,linux-scsi=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[acm.org:+];
	TAGGED_RCPT(0.00)[linux-scsi];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[acm.org:email,acm.org:dkim,acm.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

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

