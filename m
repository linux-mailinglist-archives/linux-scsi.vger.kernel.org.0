Return-Path: <linux-scsi+bounces-23536-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEI0L++e82lJ5QEAu9opvQ
	(envelope-from <linux-scsi+bounces-23536-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Apr 2026 20:26:55 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 612444A6E9C
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Apr 2026 20:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 892E53063A9A
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Apr 2026 18:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6B847CC69;
	Thu, 30 Apr 2026 18:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="kKO2yEKB"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62CB47B425
	for <linux-scsi@vger.kernel.org>; Thu, 30 Apr 2026 18:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777573454; cv=none; b=tNZfn1jdI/jojIcuxH5MHH4+QeXEUc90AGSRL/BuzruT2k8xQ4Ni1QNNRlo10x+G5YahbbpECJe06cD+xfNRF63H22hvQt8hWs4wf0i9piHz3GCuBuwQ8bRa3HiSFj091OCIcPSgVpXpsQWqnfXF5c8cOmttDi75k4ZBGOim7k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777573454; c=relaxed/simple;
	bh=342vbo+jSWIuvus37ymB6JWKPsI1lGe4DPDO3gcGr4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qEm85FQRaX1ygyZXwIqlMC7O0cMu92g+c5byNQZA+WsIU6D5TTFxWJYM+NiFuH9CVkOEotMRk3nX+3U7vawQZM7ULfWNRtJveEGEUj9PZfSRrPMkX3uEke+dH+0aPMJvcQ5T9llutZSBOBQdXgyZqh+caEaXPZc5Dla9ArVLQw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=kKO2yEKB; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4g62cr6ddfzlffts;
	Thu, 30 Apr 2026 18:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1777573448; x=1780165449; bh=03fq5
	As8Qpku8FY12z+wW/QDg5KsqYGNC+LpLlFZhEE=; b=kKO2yEKBNxA44VaF1SYik
	5tcbCOMCZ2HqidHxN7J/KeiL/y3p6Ejjl+Nuvb7BHCVDPkn7WyJkUZ328yjhTIS6
	R8NAVeO66O76RRLiUYkDpew/U8fcLaemWHpnhM+IsEmXVx8kN1F+SBhY0mV+B/bA
	QJChDt7d4W5ez5XWBX9olM1/GHz9H0cgdvnuSnWLDmlhCc6cOwYoGEs9q2qz830a
	MMUkoNhMiffRAZi67z+8jj8HWKEanTDYzEKmz2CUtDB0/j7NdH7am5sNsTOIh9RJ
	2gt31RyUnHCGbxlOMX0ay3OMD9xxfCZNBaSkxZtizGeME2AQGLo8lmcxeZ8m3kp9
	A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Ov-JiAeTdG6i; Thu, 30 Apr 2026 18:24:08 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4g62cg6cX0zlfvpH;
	Thu, 30 Apr 2026 18:24:03 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Jason Yan <yanaijie@huawei.com>,
	John Garry <john.g.garry@oracle.com>,
	Niklas Cassel <cassel@kernel.org>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH v2 36/56] scsi: libsas: Prepare for enabling lock context analysis
Date: Thu, 30 Apr 2026 11:20:06 -0700
Message-ID: <20260430182130.1978347-37-bvanassche@acm.org>
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
X-Rspamd-Queue-Id: 612444A6E9C
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
	TAGGED_FROM(0.00)[bounces-23536-lists,linux-scsi=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[acm.org:+];
	TAGGED_RCPT(0.00)[linux-scsi];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,acm.org:email,acm.org:dkim,acm.org:mid]

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

