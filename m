Return-Path: <linux-scsi+bounces-23505-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aN+hB9Wd82lJ5QEAu9opvQ
	(envelope-from <linux-scsi+bounces-23505-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Apr 2026 20:22:13 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1EC4A6D1C
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Apr 2026 20:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3609B3003BD2
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Apr 2026 18:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229EC44D688;
	Thu, 30 Apr 2026 18:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="vkj6/Cgl"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B895339D6DE
	for <linux-scsi@vger.kernel.org>; Thu, 30 Apr 2026 18:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777573326; cv=none; b=cbZZhJV1LE49nTHkCyFSjFBIZFgvsewNaXRVwFqWtommBmJXXosDX2p3wSMq6vqwxtHzVD1WEHBZj+1KegVbhrflqff0HMJB1Nx92gM6JLlh8L+Aef/kBT3Vwzzshl0vOg81C4jstgVs4FY4+gZ0WKdoS6/7YOfTmfdD+CirL+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777573326; c=relaxed/simple;
	bh=1ENnRbW+KwQhnmzgpw6VNl0JjGhszm4LBCOTPFBiS80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iwNOibw6/oazpp/HV9AHIMJX5YDIhRU0yaHHwe0RbEYNVXrCov7OxZrqWcnVBUzniQlH3TXlE8Bf6xGzFUeKCD89tO6x8gTuwkBAbPaoQNXGDbnjTW6LpnC9mVnzu/L78aixB06rIQu7gD4CKFs2KxfG9Q8QxWkZJtc6t7e6z90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=vkj6/Cgl; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4g62ZP3kJNzm1W15;
	Thu, 30 Apr 2026 18:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1777573322; x=1780165323; bh=936lz
	P54ESjJgj55qwK5i6f24mKocosE/EXtnEOqjp4=; b=vkj6/CglrmDjkEIKTSq4r
	W9PcBRl73KviguEGpwglJ7CT8nhloCns72cM8EvHXZyA+Vvc/BIOK6RAefdoEUGV
	OMAZJiCPWGv8tqLcblcFJnVHJfDQRCgKFoYuXQsMerDTR8iV0sPDE3ewpRui76PU
	hb4/iuB3Jd5koUoduxO/bDSz6j8qY2XWD/UCOLqffq2RfzMyvf7SWvQhuA/oU27D
	J9cPUZyKlX/xmr69DU30JsnuX+sNnq5pjAS08sI4nH4elvATpcWyk7uDR3HJ17z+
	dBqqD6xuiGCuXQiKU9agg1m0mz5SunM+m5GaO6Bp0G7N2RxT/zvMbyAp4KCnpfZj
	A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 8MaNOG6XA4Iw; Thu, 30 Apr 2026 18:22:02 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4g62ZJ13s0zlfftm;
	Thu, 30 Apr 2026 18:21:59 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Khalid Aziz <khalid@gonehiking.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Subject: [PATCH v2 05/56] scsi: BusLogic: Introduce a local variable
Date: Thu, 30 Apr 2026 11:19:35 -0700
Message-ID: <20260430182130.1978347-6-bvanassche@acm.org>
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
X-Rspamd-Queue-Id: 1C1EC4A6D1C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-23505-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-scsi];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Introduce a new local variable to prepare for enabling thread-safety
analysis. No functionality has been changed.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/BusLogic.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/BusLogic.c b/drivers/scsi/BusLogic.c
index 5304d2febd63..e3790ff24e56 100644
--- a/drivers/scsi/BusLogic.c
+++ b/drivers/scsi/BusLogic.c
@@ -2886,6 +2886,7 @@ static enum scsi_qc_status blogic_qcmd_lck(struct s=
csi_cmnd *command)
 	struct blogic_tgt_flags *tgt_flags =3D
 		&adapter->tgt_flags[command->device->id];
 	struct blogic_tgt_stats *tgt_stats =3D adapter->tgt_stats;
+	struct Scsi_Host *const shost =3D command->device->host;
 	unsigned char *cdb =3D command->cmnd;
 	int cdblen =3D command->cmd_len;
 	int tgt_id =3D command->device->id;
@@ -2915,9 +2916,9 @@ static enum scsi_qc_status blogic_qcmd_lck(struct s=
csi_cmnd *command)
 	 */
 	ccb =3D blogic_alloc_ccb(adapter);
 	if (ccb =3D=3D NULL) {
-		spin_unlock_irq(adapter->scsi_host->host_lock);
+		spin_unlock_irq(shost->host_lock);
 		blogic_delay(1);
-		spin_lock_irq(adapter->scsi_host->host_lock);
+		spin_lock_irq(shost->host_lock);
 		ccb =3D blogic_alloc_ccb(adapter);
 		if (ccb =3D=3D NULL) {
 			command->result =3D DID_ERROR << 16;
@@ -3062,10 +3063,10 @@ static enum scsi_qc_status blogic_qcmd_lck(struct=
 scsi_cmnd *command)
 		   be initiated soon.
 		 */
 		if (!blogic_write_outbox(adapter, BLOGIC_MBOX_START, ccb)) {
-			spin_unlock_irq(adapter->scsi_host->host_lock);
+			spin_unlock_irq(shost->host_lock);
 			blogic_warn("Unable to write Outgoing Mailbox - Pausing for 1 second\=
n", adapter);
 			blogic_delay(1);
-			spin_lock_irq(adapter->scsi_host->host_lock);
+			spin_lock_irq(shost->host_lock);
 			if (!blogic_write_outbox(adapter, BLOGIC_MBOX_START,
 						ccb)) {
 				blogic_warn("Still unable to write Outgoing Mailbox - Host Adapter D=
ead?\n", adapter);

