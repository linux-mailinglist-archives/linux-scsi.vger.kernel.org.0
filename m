Return-Path: <linux-scsi+bounces-23850-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOc7GKOHB2r57AIAu9opvQ
	(envelope-from <linux-scsi+bounces-23850-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 15 May 2026 22:52:51 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 43721557928
	for <lists+linux-scsi@lfdr.de>; Fri, 15 May 2026 22:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7BB6F300C02C
	for <lists+linux-scsi@lfdr.de>; Fri, 15 May 2026 20:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135D43E835F;
	Fri, 15 May 2026 20:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="kdAIqPez"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05CB3E9C02
	for <linux-scsi@vger.kernel.org>; Fri, 15 May 2026 20:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778878363; cv=none; b=t2X0GLVNZxrATCZfjFxcaeEdc38nC6SNtxo0oc251Oe00vXPgozct7QMyiQT9NqmUWRpjiSwjMnn68M8VZghOUcIzqznFWjuhrgKAhOu0xJ1exbcXDec1vO7i98ueyUC17NoRbULVfNATMerX8rmjoF1T1edbTpIt7vFf/VVAUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778878363; c=relaxed/simple;
	bh=1YDV/uNtvE/9jXzAg/y0xGlpQ5vPYc+HsJMVMhJCC6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m0bmWAA5WZjBbQUdBSlroruOQyvJpv2hUlvwN4DN78cBUEsiWrSgXrqobjyoUVKWnNACT5UGDqbmSjB77KGaiOq+nyszt1ckGcUQ0KOO1reMY303Jo9Dh1myh1xd341HZClaV/9rSwA4LxIWjaH59s4fGZZvxuByI3rzu39jv0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=kdAIqPez; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gHKCG1Rhfzlh1VC;
	Fri, 15 May 2026 20:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1778878358; x=1781470359; bh=K8nrh
	1FQVh/fBk7ETuJT7tpKKTZkJp1Rary+iNcdRjg=; b=kdAIqPezDTMcSppc8JZ8s
	hnXF2XlIFxsMzVcvOOFSZTLYOoAchRhYXyOT9DalCRkHRHXe8xq+VO1RsY8062a1
	s+Roz5n5kAUxJ1Z+09LIOqkGZX9kQZ5sVedY7FsoHtavvuLJb17p/0DRAu3+JCNg
	4ISOEHb14NnkL7ZFfJmlBg9YjPS2/bzH04Hx/sBeaxWPmAxMIBNj9CKGerXh/SeO
	nhs9OnquoUwVauRUCPQ9oWiy6vh/g/8qiS6L4u+EFnlxmlJeud6IhlqbKomK6km1
	mT7LgNts4HoqSgq1JzLJ8a1DpQes4X1vdb1BwJAUUMUxcqp3UakIT3BxyhCR+A96
	A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id VRIgzuK3rFg4; Fri, 15 May 2026 20:52:38 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gHKC83Vj3zlgwNJ;
	Fri, 15 May 2026 20:52:36 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	Brian Bunker <brian@purestorage.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Bart Van Assche <bvanassche@acm.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Subject: [PATCH v2 2/3] scsi: core: Use the INQUIRY-related constants
Date: Fri, 15 May 2026 13:52:20 -0700
Message-ID: <20260515205222.1754621-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
In-Reply-To: <20260515205222.1754621-1-bvanassche@acm.org>
References: <20260515205222.1754621-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 43721557928
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23850-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[acm.org:email,acm.org:mid,acm.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Use symbolic names instead of numeric constants to access the vendor and
model information.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_scan.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index a35a5f777d16..b0473f4595c1 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -728,9 +728,13 @@ static int scsi_probe_lun(struct scsi_device *sdev, =
unsigned char *inq_result,
 	}
=20
 	if (result =3D=3D 0) {
-		scsi_sanitize_inquiry_string(&inq_result[8], 8);
-		scsi_sanitize_inquiry_string(&inq_result[16], 16);
-		scsi_sanitize_inquiry_string(&inq_result[32], 4);
+		scsi_sanitize_inquiry_string(&inq_result[INQUIRY_VENDOR_OFFSET],
+					     INQUIRY_VENDOR_LEN);
+		scsi_sanitize_inquiry_string(&inq_result[INQUIRY_MODEL_OFFSET],
+					     INQUIRY_MODEL_LEN);
+		scsi_sanitize_inquiry_string(
+			&inq_result[INQUIRY_REVISION_OFFSET],
+			INQUIRY_REVISION_LEN);
=20
 		response_len =3D inq_result[4] + 5;
 		if (response_len > 255)
@@ -743,8 +747,9 @@ static int scsi_probe_lun(struct scsi_device *sdev, u=
nsigned char *inq_result,
 		 * corresponding bit fields in scsi_device, so bflags
 		 * need not be passed as an argument.
 		 */
-		*bflags =3D scsi_get_device_flags(sdev, &inq_result[8],
-				&inq_result[16]);
+		*bflags =3D scsi_get_device_flags(sdev,
+				&inq_result[INQUIRY_VENDOR_OFFSET],
+				&inq_result[INQUIRY_MODEL_OFFSET]);
=20
 		/* When the first pass succeeds we gain information about
 		 * what larger transfer lengths might work. */

