Return-Path: <linux-scsi+bounces-23503-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BUeFNWd82lJ5QEAu9opvQ
	(envelope-from <linux-scsi+bounces-23503-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Apr 2026 20:22:13 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3644A6D1D
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Apr 2026 20:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0E1A3031AEB
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Apr 2026 18:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DC647CC6A;
	Thu, 30 Apr 2026 18:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="YleGXCGe"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A2047B435
	for <linux-scsi@vger.kernel.org>; Thu, 30 Apr 2026 18:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777573321; cv=none; b=nRyYKFnrskOubWzcwgfun4Mca+VoBfU32RkxktJWc0LBli6eZ0lFe8tigBaTQ1JOyv7iPaqpqb3thsgoEZK75OG9H41+kHrU/OuKMthXATuHvwrMs1OxgzsOpUejvelVkk6PeGOJU+s83GxMzXlYhX7N4/RG+L024Nf+0KVqxNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777573321; c=relaxed/simple;
	bh=jgHtAUetBAMqIth81WubE/GeJHc2FgmTvEBZmcQhU9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=umF44fw3nRLszY9ff2CraEse4+LCMepBZBT6XV1I4aL3AKaqprPbsUDYNCCQxIDASn7RNs0hrlETsVgQuZmn4BMtZwzDHZvLPgGJqJdr2tQsLyeihCImuPTIVAti+ZnOa884grNFr0n9HerqKhAgZG3VxHiEBXWk8+rfkI0+jak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=YleGXCGe; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4g62ZH5ghLzlkMYB;
	Thu, 30 Apr 2026 18:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1777573316; x=1780165317; bh=XafUO
	nQWsOIb4/g19CDM1nA0LzU9mACC/txY6BlS2xo=; b=YleGXCGeDlHPJwUanHOei
	VCMlT8cW8YaxiwmStGlt6FR2A396xmlty+k4PeTtaOFKvBBg7FyimUKkFM1ycj50
	PlW9oJHrSvGTVOogtfBHPqC/f6bT747hIKC0uzlJpTdIaifA2GqUb0Fy+I++ugCg
	K/s7wAAMHnCo8EhhmFal96RnzDJeoLLQfevAEKKNJknKXqMkKrK2qk07t08dXdF1
	KFgyWD3Kq3nGD7QaimbqpZwupSe9wRR/HNvGqlY4VXHQR0y7LfvOpW72dxLqsmaH
	R5C0BsA869xgL/WV3LZCwFGRn9P9FlXRvCcPX3wkV955Ek9DpFTUcGqEKPaWWU8K
	g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id OkKxUoyLgShO; Thu, 30 Apr 2026 18:21:56 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4g62ZB3xMyzlfftm;
	Thu, 30 Apr 2026 18:21:54 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Doug Gilbert <dgilbert@interlog.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Subject: [PATCH v2 03/56] scsi: sg: Prepare for enabling lock context analysis
Date: Thu, 30 Apr 2026 11:19:33 -0700
Message-ID: <20260430182130.1978347-4-bvanassche@acm.org>
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
X-Rspamd-Queue-Id: 9F3644A6D1D
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
	TAGGED_FROM(0.00)[bounces-23503-lists,linux-scsi=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Annotate open_wait() with __must_hold() since it unlocks and locks a
mutex.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/sg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 2b4b2a1a8e44..ec405cb56a40 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -245,6 +245,7 @@ static int sg_allow_access(struct file *filp, unsigne=
d char *cmd)
=20
 static int
 open_wait(Sg_device *sdp, int flags)
+	__must_hold(sdp->open_rel_lock)
 {
 	int retval =3D 0;
=20

