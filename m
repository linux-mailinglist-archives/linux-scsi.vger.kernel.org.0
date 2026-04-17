Return-Path: <linux-scsi+bounces-23062-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBqbAbqm4mmR8gAAu9opvQ
	(envelope-from <linux-scsi+bounces-23062-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 17 Apr 2026 23:31:38 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CD741EB92
	for <lists+linux-scsi@lfdr.de>; Fri, 17 Apr 2026 23:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 01D89300C7DD
	for <lists+linux-scsi@lfdr.de>; Fri, 17 Apr 2026 21:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA8A37C928;
	Fri, 17 Apr 2026 21:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="cfkDKbpY"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F5B37C90C
	for <linux-scsi@vger.kernel.org>; Fri, 17 Apr 2026 21:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776461455; cv=none; b=McbdH3ZuhvpA/pBULK4IRz83SpNuh/xAVqcY8fj/TvgBZFMM9jiz5EOXEXrh/XV7wI9djNRG65Sq+8O/NAtVa65jk+4PbliWsGr63At1xFAQVOj19lB4MfAFWnCQIvCa981FTWa+EaULxUz/NjAPLC4CfxHMNR/pqDp7EgW8IJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776461455; c=relaxed/simple;
	bh=lgXT9EccAbsxCbwGChifXiWF0heIBB3rXwDefKB+mIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jYLu/ZwbiLytjcvzDZ4MuWzBBjH0k5tedwMziaDFC5gBkqbPrWSCwHQfFKVwcNfKlycJmBM5NKgNgXcmsRsUK0j5PM3SDSWPFMjTbreOUsYPh8tZiMUtToPH7eVOGNSyVGobJvGMcx6NB7dyg1/82tmijs0XgW6XARFDatbShiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=cfkDKbpY; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fy7NG2btLzlfl7l;
	Fri, 17 Apr 2026 21:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1776461449; x=1779053450; bh=qZ/ER
	tEYqUNVUGk2oFnch4CIcwVOoIe/kSJr7pDlubc=; b=cfkDKbpYE3Nhled56wgEN
	nLfaZXEllIzinA6D2jIKHpP9vYd10ozr0F3g1icw2ZeAiPiQHMEyR3US4YGdbieA
	vRoWbbCre02QqOUhILEE1dFt4hX0yvmNiWfZGp47N7r7h7PbqANtMhxcaO0om7Zr
	W+rruk2iZne/Vt+1frH5w8O3Iiz3sYFN/USQKpla6os+uYm5V52v5KYiKxy3al5P
	7Svkc07xKlOkSMIPxqqjTvn87XcUmNLIKIemDsZkwmuqik1MeaYax74X1CYZ+2QI
	Wf3uDFFa0jgmfkxcg3SJuht+n8g264EEeAQu5RW5mC4S17RLK7wGCp2eckrLgapC
	g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 7_rkXm2AhKWf; Fri, 17 Apr 2026 21:30:49 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fy7N72njrzlgtck;
	Fri, 17 Apr 2026 21:30:46 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Peter Wang <peter.wang@mediatek.com>,
	Avri Altman <avri.altman@sandisk.com>,
	Bean Huo <beanhuo@micron.com>,
	Can Guo <can.guo@oss.qualcomm.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 3/3] ufs: core: Optimize ufshcd_add_uic_command_trace()
Date: Fri, 17 Apr 2026 14:30:22 -0700
Message-ID: <20260417213027.3506742-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.rc1.555.g9c883467ad-goog
In-Reply-To: <20260417213027.3506742-1-bvanassche@acm.org>
References: <20260417213027.3506742-1-bvanassche@acm.org>
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
	TAGGED_FROM(0.00)[bounces-23062-lists,linux-scsi=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[acm.org:+];
	TAGGED_RCPT(0.00)[linux-scsi];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,acm.org:email,acm.org:dkim,acm.org:mid]
X-Rspamd-Queue-Id: 03CD741EB92
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use cached values in ufshcd_add_uic_command_trace() instead of calling
readl(). In ufshcd_uic_cmd_compl(), also read the result byte for power
commands since it is also set if a power command completes.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/ufs/core/ufshcd.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 0ff9d7c2a7ac..12445e012cad 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -460,20 +460,11 @@ static void ufshcd_add_uic_command_trace(struct ufs=
_hba *hba,
 					 const struct uic_command *ucmd,
 					 enum ufs_trace_str_t str_t)
 {
-	u32 cmd;
-
 	if (!trace_ufshcd_uic_command_enabled())
 		return;
=20
-	if (str_t =3D=3D UFS_CMD_SEND)
-		cmd =3D ucmd->command;
-	else
-		cmd =3D ufshcd_readl(hba, REG_UIC_COMMAND);
-
-	trace_ufshcd_uic_command(hba, str_t, cmd,
-				 ufshcd_readl(hba, REG_UIC_COMMAND_ARG_1),
-				 ufshcd_readl(hba, REG_UIC_COMMAND_ARG_2),
-				 ufshcd_readl(hba, REG_UIC_COMMAND_ARG_3));
+	trace_ufshcd_uic_command(hba, str_t, ucmd->command, ucmd->argument1,
+				 ucmd->argument2, ucmd->argument3);
 }
=20
 static void ufshcd_add_command_trace(struct ufs_hba *hba, struct scsi_cm=
nd *cmd,
@@ -5689,13 +5680,11 @@ static irqreturn_t ufshcd_uic_cmd_compl(struct uf=
s_hba *hba, u32 intr_status)
 	if (ufshcd_is_auto_hibern8_error(hba, intr_status))
 		hba->errors |=3D (UFSHCD_UIC_HIBERN8_MASK & intr_status);
=20
+	/* Store the UIC command result in the lowest byte of cmd->argument2. *=
/
+	cmd->argument2 |=3D ufshcd_readl(hba, REG_UIC_COMMAND_ARG_2) &
+		MASK_UIC_COMMAND_RESULT;
+
 	if (intr_status & UIC_COMMAND_COMPL) {
-		/*
-		 * Store the UIC command result in the lowest byte of
-		 * cmd->argument2.
-		 */
-		cmd->argument2 |=3D ufshcd_readl(hba, REG_UIC_COMMAND_ARG_2) &
-				  MASK_UIC_COMMAND_RESULT;
 		/* Store the DME attribute value in cmd->argument3. */
 		cmd->argument3 =3D ufshcd_readl(hba, REG_UIC_COMMAND_ARG_3);
 		if (!hba->uic_async_done)

