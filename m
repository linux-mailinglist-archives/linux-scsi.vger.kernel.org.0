Return-Path: <linux-scsi+bounces-21968-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNPfBq0ts2ksSwAAu9opvQ
	(envelope-from <linux-scsi+bounces-21968-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 12 Mar 2026 22:18:37 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC5D279E7C
	for <lists+linux-scsi@lfdr.de>; Thu, 12 Mar 2026 22:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73F9730751B6
	for <lists+linux-scsi@lfdr.de>; Thu, 12 Mar 2026 21:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DFA3C6A39;
	Thu, 12 Mar 2026 21:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="UKVzk2zf"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA0B3CA4BE
	for <linux-scsi@vger.kernel.org>; Thu, 12 Mar 2026 21:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773350293; cv=none; b=O/pGwoFeFBjQelSCluB3lyttzh+2o5eP8t9FCBNaHDZIBMjqq/nuSepEZ2NBdudofi0qFgpayeWsuwjZPK5JTyEQdX4SfCstDdlU9zzsUiY9kbHsUdztf4eh6kdSvHhED1AxiSQu7x5BxuwUKLrlfv47UK6zWy9OhTiyDsAUAKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773350293; c=relaxed/simple;
	bh=lUr6Yg+j6QknZUMXj7pZWFPwzdUWLxYR3dAOdAZ47Eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OxNKz8jYx67kpvD5uNoY1/y1p+xJ6ZzJbe+AF0dxLO79lwU1S7drRW0FMWmPUJoy2ac+3e1zWj2WNtEmoD9vBoBLMKd1wuxlJPh/6psP6EfF5fOV38UhzyUrGVzDYl+HGqc/ZjGHUYFUQn627jjtZ6v3S0iIiNjtIbCCf8zpKCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=UKVzk2zf; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fX0pD1fMVzlfl5V;
	Thu, 12 Mar 2026 21:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1773350289; x=1775942290; bh=sl24F
	Sc40CSaoQpszzomHrcUuskgwhuv5OT/UvFfs8s=; b=UKVzk2zfS5q7weBGFKJjM
	Asavt1jLlmSSA2fwo6iEF9Y6LWjEReQXdEK4qI003HsnK+DkQ6wrY0xk3AgpOUUs
	QnTt3ChkMeN9N19NQoEzehWQqtkFVvYDXhEc/kBMnLd1JgYr3GQcPRdLBctm+oD1
	iZSpH5abLbdJ9rEh+8DQoie3oJcGNIQUrepzxb+3CnIufYh+3bAccLS6aYSsdt4b
	CO3OTzVOyqm9MkdL3KqReh5aFvuy9zTL3wgUUxgOlzo8Ot969UpAZ2lGDRVwdnos
	mhmeBc6H79mkYgmRBcTgsfd/DEk6erm/ZLKSkbPMglcdfZ8ZlnXOD1yqVitWTKjO
	g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id TcEfw6QHvfK2; Thu, 12 Mar 2026 21:18:09 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fX0p73q7tzlfl5h;
	Thu, 12 Mar 2026 21:18:07 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Nilesh Javali <njavali@marvell.com>,
	Manish Rangankar <mrangankar@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Subject: [PATCH 28/36] scsi: qedi: Prepare for enabling lock context analysis
Date: Thu, 12 Mar 2026 14:15:39 -0700
Message-ID: <20260312211636.3245119-29-bvanassche@acm.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21968-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 8BC5D279E7C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Annotate qedi_cleanup_all_io() with __no_context_analysis since it
performs conditional locking.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qedi/qedi_fw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/qedi/qedi_fw.c b/drivers/scsi/qedi/qedi_fw.c
index 854efa4f61d8..3223951cab14 100644
--- a/drivers/scsi/qedi/qedi_fw.c
+++ b/drivers/scsi/qedi/qedi_fw.c
@@ -1134,6 +1134,7 @@ int qedi_send_iscsi_logout(struct qedi_conn *qedi_c=
onn,
=20
 int qedi_cleanup_all_io(struct qedi_ctx *qedi, struct qedi_conn *qedi_co=
nn,
 			struct iscsi_task *task, bool in_recovery)
+	__no_context_analysis /* conditional locking */
 {
 	int rval;
 	struct iscsi_task *ctask;

