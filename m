Return-Path: <linux-scsi+bounces-23515-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOvaIPad82lg5QEAu9opvQ
	(envelope-from <linux-scsi+bounces-23515-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Apr 2026 20:22:46 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B8C4A6D5E
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Apr 2026 20:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CEE0B3004627
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Apr 2026 18:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE228478E59;
	Thu, 30 Apr 2026 18:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="kv6Gj9mU"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ABD39D6DE
	for <linux-scsi@vger.kernel.org>; Thu, 30 Apr 2026 18:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777573360; cv=none; b=MGcp8ULD9gtR0NTKKkI8srnRqaTbF6emhpd3VT2z3/miWlRpXSqTRCwbPyLUOxR+Ye5jwzYkkCFkiIcTbLoc2Jd2+P0M2mYNo9oy6Y7Fr68jXsg9z0bGuEJD4Pq7N1j3cI9879wutP2Q80Z1pi9ii6lQJCLhQ9dtfSE2v6GMKEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777573360; c=relaxed/simple;
	bh=YvQPTSLZjjNqI6F27JJxdl2tqRIp855nNJ5VkINyXTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CCNLE673TeNipjQDoJWtvOZvn5OvxKlAE1cSTx5TlRIM2bSx3SXJAZ+5gKK0vIrc3dVgXWcyk2JStuCChXS1XGHwNQPiKg5aM3kUKHTF3YoCXPCvzixJRqZrzcAwuKSA0TC2miFVVjO3W+JpFwQwfnuFL6JvNrnYNUcQR1JfD1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=kv6Gj9mU; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4g62b31PsKzlhpdP;
	Thu, 30 Apr 2026 18:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1777573355; x=1780165356; bh=U7WZA
	po3QESKqo3zxWmTXd1ulz3fP6GnxNJ/T/f3j/U=; b=kv6Gj9mUHPwK1R2RzGnGl
	MqNRAv4F5e9ldJvz6d6ccAdZ6btKb4gDLi471q6L36C8LWzaDVJe5PZBtNvY2rUM
	6oQky8FH2RR3Frel/rSnssaHh8FU3uA7a27UK0Onfs669OiHJm4bIB3AEuQiHVo2
	QEzwZaF3soIW0cCcMbg4NUEmoCAAePPvJAGBB8KIbHOKoWOC9max91sAe+wt7vfx
	CkSosOo2Ta3BX82iO2X+ddH1IanTLaDA086oea7md1AVGGKPrYczXotn2+gUFJUi
	18XPtxs2bdTs1/RXWUKDnn9ofNx5fQNLWXTX94stL7lZiD7/xAj43INHKuUdnuAW
	g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id PG3sMQFfV4ob; Thu, 30 Apr 2026 18:22:35 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4g62Zy2jVBzlkMYB;
	Thu, 30 Apr 2026 18:22:34 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Ketan Mukadam <ketan.mukadam@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Subject: [PATCH v2 15/56] scsi: be2iscsi: Prepare for enabling lock context analysis
Date: Thu, 30 Apr 2026 11:19:45 -0700
Message-ID: <20260430182130.1978347-16-bvanassche@acm.org>
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
X-Rspamd-Queue-Id: B9B8C4A6D5E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-23515-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-scsi];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,acm.org:email,acm.org:dkim,acm.org:mid]

Document locking requirements with __must_hold().

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/be2iscsi/be_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/be2iscsi/be_main.c b/drivers/scsi/be2iscsi/be_m=
ain.c
index fd18d4d3d219..289d9d18482c 100644
--- a/drivers/scsi/be2iscsi/be_main.c
+++ b/drivers/scsi/be2iscsi/be_main.c
@@ -1185,6 +1185,7 @@ static void
 be_complete_logout(struct beiscsi_conn *beiscsi_conn,
 		    struct iscsi_task *task,
 		    struct common_sol_cqe *csol_cqe)
+	__must_hold(&beiscsi_conn->conn->session->back_lock)
 {
 	struct iscsi_logout_rsp *hdr;
 	struct beiscsi_io_task *io_task =3D task->dd_data;
@@ -1212,6 +1213,7 @@ static void
 be_complete_tmf(struct beiscsi_conn *beiscsi_conn,
 		 struct iscsi_task *task,
 		 struct common_sol_cqe *csol_cqe)
+	__must_hold(&beiscsi_conn->conn->session->back_lock)
 {
 	struct iscsi_tm_rsp *hdr;
 	struct iscsi_conn *conn =3D beiscsi_conn->conn;
@@ -1268,6 +1270,7 @@ static void
 be_complete_nopin_resp(struct beiscsi_conn *beiscsi_conn,
 			struct iscsi_task *task,
 			struct common_sol_cqe *csol_cqe)
+	__must_hold(&beiscsi_conn->conn->session->back_lock)
 {
 	struct iscsi_nopin *hdr;
 	struct iscsi_conn *conn =3D beiscsi_conn->conn;
@@ -1423,6 +1426,7 @@ static void hwi_complete_cmd(struct beiscsi_conn *b=
eiscsi_conn,
 static unsigned int
 beiscsi_complete_pdu(struct beiscsi_conn *beiscsi_conn,
 		struct pdu_base *phdr, void *pdata, unsigned int dlen)
+	__must_hold(&beiscsi_conn->conn->session->back_lock)
 {
 	struct beiscsi_hba *phba =3D beiscsi_conn->phba;
 	struct iscsi_conn *conn =3D beiscsi_conn->conn;

