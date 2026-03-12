Return-Path: <linux-scsi+bounces-21972-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NnYAqwts2ksSwAAu9opvQ
	(envelope-from <linux-scsi+bounces-21972-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 12 Mar 2026 22:18:36 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FD6279E75
	for <lists+linux-scsi@lfdr.de>; Thu, 12 Mar 2026 22:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E2D7F30200C2
	for <lists+linux-scsi@lfdr.de>; Thu, 12 Mar 2026 21:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524E83C13EA;
	Thu, 12 Mar 2026 21:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="AAmLIxFb"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244B33C3450
	for <linux-scsi@vger.kernel.org>; Thu, 12 Mar 2026 21:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773350306; cv=none; b=kqnXQkfFEALQ0+CgiPu1sx+lLV7oq8N5BnW6hSC07mAegso4F88NjGIPy1idFC6j/zLvHbK9USVF0H2zrzqRIOCdb5TQ7bW4A4Fr0BKuYGs3DILDOyZ8zLXri5bmFHfCzd30ZYtbhR5zIalSjIYB8/4z4B7QbvxgXZhoTpxsyrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773350306; c=relaxed/simple;
	bh=PbKAdykBusbAmqhisVoEFEOvGFgol6CBScF3ZCAWZIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kUS63Mjid8mF3GwOeqpgVMWNmVXLGGg4HF1iWOy88GKfy0A0g39q6AbZc33SXk0NSlrxZ4OR9NB32ZR3wHh/WW1+74Tdd3ODeu8KLaeLz/CO/ArkiGmfTXjpY7R2h/3MXF9Il7fomAxJt429WBDygQ4Ehn6lrmSkyPJ4t6IBpNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=AAmLIxFb; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fX0pS5dGnzlfl5h;
	Thu, 12 Mar 2026 21:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1773350301; x=1775942302; bh=l4dDJ
	5l1JXJSaLrAzg09t6YwGlXJtlQj9cBMKdC8DI0=; b=AAmLIxFb9YisKQE9OE9vU
	TknRRuUc30G/asDZQSUJRB+uJyE6gMOCjGaM70wcY2W1OLCwYnf9Jr7TH9IWaO6U
	WEMTl83Qye3osEkY41qMpxBRPU/vukvEUJttaIWb8RIP+bM+hWOEiPo4hPCcpLsR
	oiDI8q5zqtHraclwDYrbcvUq2TCikGtntEXb4EXddRJzeLLoXpyjIHy70gOJfCct
	QiREvz2ByWXoxE7jet3a1ZLIVJc7SLaLkJc4oB4ACMtRkIo608b/w1sx+aGemIYA
	5Z6RMbyfYtNV8xD6RinnQa0BfRwmz58ZYHPjE7Oz0KTFSUodYWKbSar0HF0gERvX
	g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id SuTvGA1YYUbq; Thu, 12 Mar 2026 21:18:21 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fX0pN1qyzzlfl8L;
	Thu, 12 Mar 2026 21:18:20 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Lee Duncan <lduncan@suse.com>,
	Chris Leech <cleech@redhat.com>,
	Mike Christie <michael.christie@oracle.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Subject: [PATCH 33/36] scsi: iSCSI transport: Prepare for enabling lock context analysis
Date: Thu, 12 Mar 2026 14:15:44 -0700
Message-ID: <20260312211636.3245119-34-bvanassche@acm.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21972-lists,linux-scsi=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[acm.org:+];
	TAGGED_RCPT(0.00)[linux-scsi];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 31FD6279E75
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Document locking requirements with __must_hold().

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_transport_iscsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_tran=
sport_iscsi.c
index 8aa76f813bcd..129f12bb7271 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -2243,6 +2243,7 @@ static void iscsi_ep_disconnect(struct iscsi_cls_co=
nn *conn, bool is_active)
 static void iscsi_if_disconnect_bound_ep(struct iscsi_cls_conn *conn,
 					 struct iscsi_endpoint *ep,
 					 bool is_active)
+	__must_hold(conn->ep_mutex)
 {
 	/* Check if this was a conn error and the kernel took ownership */
 	spin_lock_irq(&conn->lock);

