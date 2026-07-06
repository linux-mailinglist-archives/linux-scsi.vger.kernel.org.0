Return-Path: <linux-scsi+bounces-25624-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id llnaL2FZS2pYPwEAu9opvQ
	(envelope-from <linux-scsi+bounces-25624-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 06 Jul 2026 09:29:37 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9EA70D8BC
	for <lists+linux-scsi@lfdr.de>; Mon, 06 Jul 2026 09:29:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=U+frHbPP;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25624-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25624-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 47B40327A718
	for <lists+linux-scsi@lfdr.de>; Mon,  6 Jul 2026 07:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A8D3EAC72;
	Mon,  6 Jul 2026 06:56:34 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38D83D88F5;
	Mon,  6 Jul 2026 06:56:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783320992; cv=none; b=RAWN+axCQgmAqMBJO7gVIOBs/FfcuSbOAfl4mmPDh7bA/JoPsOoKczE3ELn0O1XfpbGxactPC/9JZ4WtUEzmfBE1GpBQMypnPOnY1zkeA6n1hMi2yN/6z4gPP0CAp6oTVQsDtLrzeSgKEFuHGuoiF89uh668jAGWFI/L8n88MnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783320992; c=relaxed/simple;
	bh=OE5djxARK5fUCsZfS5lPRA9rBRbzoI/2aHXyjZTrsnQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sXE1Zf02eWK/yjwd3buuKL4RcdXQvvscS1H4HL48xsnSJDZccQn6MG750Xk+u3uO28MOxAdFLftkKxSfA7Dx0xqMum9AIIlL1QGUI70ZaPqD/jQCHxMWag6geL7ePmyE/gKE9lRCctY0gp6KnbZQjC6YR9pQI+9v1xNQ63IVT2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+frHbPP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 569A21F00ACF;
	Mon,  6 Jul 2026 06:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783320984;
	bh=TB62Cizf1uWpK38GyEp3i+NW3cSCIe1tOjiy77Lmfnc=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=U+frHbPPXhKLhFFQTJRZIzEo9TAeVVAS238IMeUALixghKYRIvCcn32g6zn2KiODG
	 wsfdY3bktbDasek1Xzj5iC0cCQbJ/Z9APYTK+k/PxNcMNPHs/FmGetKtClIHgCMDg7
	 PstW0BN5lptsVMoDLDNHRovzVMzApythhWmwfsTIdmVUCx/CKRVatw4DQEaJnY/rV1
	 1VtLByJ03JfNMxvoLieUBKmrdcOXn/i9s4TBHzDuERIMmZbyOoKkXpTb93tEvns+/k
	 AiOOI4S4zvK1W0j+VQOcrRwmq3hh9S3woIcy6sWKTXZRZmbjfL22lam58H5bU5O3L+
	 sJiAnuDwN7PwA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH v1 4/9] ata: libata-scsi: improve ata_get_xlat_func
Date: Mon,  6 Jul 2026 15:56:05 +0900
Message-ID: <20260706065610.3559692-5-dlemoal@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706065610.3559692-1-dlemoal@kernel.org>
References: <20260706065610.3559692-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:linux-ide@vger.kernel.org,m:cassel@kernel.org,m:linux-scsi@vger.kernel.org,m:martin.petersen@oracle.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-25624-lists,linux-scsi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[dlemoal@kernel.org,linux-scsi@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlemoal@kernel.org,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8C9EA70D8BC

ata_get_xlat_func() is given only the opcode of a SCSI command to
determine the ATA command to translate to. This makes it impossible to
translate SCSI commands such as SERVICE ACTION IN which need a service
action field to fully specify the command.

In preparation for supporting the translation of the SERVICE ACTION IN
command with service actions different from the SAI_READ_CAPACITY_16 (READ
CAPACITY 16), change ata_get_xlat_func() to take a pointer to a SCSI
command CDB so that all fields of the SCSI command to translate can be
easily inspected.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-scsi.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 5cddb63a6bc6..f5c838ca0ce9 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4606,7 +4606,7 @@ static unsigned int ata_scsi_var_len_cdb_xlat(struct ata_queued_cmd *qc)
 /**
  *	ata_get_xlat_func - check if SCSI to ATA translation is possible
  *	@dev: ATA device
- *	@cmd: SCSI command opcode to consider
+ *	@cdb: CDB of the SCSI command to consider
  *
  *	Look up the SCSI command given, and determine whether the
  *	SCSI command is to be translated or simulated.
@@ -4615,9 +4615,10 @@ static unsigned int ata_scsi_var_len_cdb_xlat(struct ata_queued_cmd *qc)
  *	Pointer to translation function if possible, %NULL if not.
  */
 
-static inline ata_xlat_func_t ata_get_xlat_func(struct ata_device *dev, u8 cmd)
+static inline ata_xlat_func_t ata_get_xlat_func(struct ata_device *dev,
+						u8 *cdb)
 {
-	switch (cmd) {
+	switch (cdb[0]) {
 	case READ_6:
 	case READ_10:
 	case READ_16:
@@ -4748,7 +4749,8 @@ enum scsi_qc_status __ata_scsi_queuecmd(struct scsi_cmnd *scmd,
 					struct ata_port *ap)
 	__must_hold(ap->lock)
 {
-	u8 scsi_op = scmd->cmnd[0];
+	u8 *cdb = scmd->cmnd;
+	u8 scsi_op = cdb[0];
 	ata_xlat_func_t xlat_func;
 
 	/*
@@ -4768,7 +4770,7 @@ enum scsi_qc_status __ata_scsi_queuecmd(struct scsi_cmnd *scmd,
 		if (unlikely(scmd->cmd_len > dev->cdb_len))
 			goto bad_cdb_len;
 
-		xlat_func = ata_get_xlat_func(dev, scsi_op);
+		xlat_func = ata_get_xlat_func(dev, cdb);
 	} else if (likely((scsi_op != ATA_16) || !atapi_passthru16)) {
 		/* relay SCSI command to ATAPI device */
 		int len = COMMAND_SIZE(scsi_op);
@@ -4784,7 +4786,7 @@ enum scsi_qc_status __ata_scsi_queuecmd(struct scsi_cmnd *scmd,
 		if (unlikely(scmd->cmd_len > 16))
 			goto bad_cdb_len;
 
-		xlat_func = ata_get_xlat_func(dev, scsi_op);
+		xlat_func = ata_get_xlat_func(dev, cdb);
 	}
 
 	if (xlat_func)
-- 
2.54.0


