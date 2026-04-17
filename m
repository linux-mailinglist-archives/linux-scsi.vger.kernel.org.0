Return-Path: <linux-scsi+bounces-23061-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WODIMKum4mmR8gAAu9opvQ
	(envelope-from <linux-scsi+bounces-23061-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 17 Apr 2026 23:31:23 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB85641EB81
	for <lists+linux-scsi@lfdr.de>; Fri, 17 Apr 2026 23:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 26392301B853
	for <lists+linux-scsi@lfdr.de>; Fri, 17 Apr 2026 21:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D59937BE64;
	Fri, 17 Apr 2026 21:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="1iHymlR+"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE7837AA82
	for <linux-scsi@vger.kernel.org>; Fri, 17 Apr 2026 21:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776461451; cv=none; b=fwS4yk8Je2kpFWW4ETfNn4M3RmwADEsZSOhHcfmZjAupMDeyJmRMdRwxR8gmqGEeVO+N0t+BEanTucfWkn5bQPdbBIHCPs7IGwREfwTYJ7RHWnKec2Ia+cCQmb5EDYVOy4eI1csk/TKiG9iY9zAxAxSWIdrC+Gy+73NSuly0CHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776461451; c=relaxed/simple;
	bh=hPHMevWX/fueoQ84EkCmqp+yoN3KbRQeZaOzlZnQYN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NesPo+R20b0Td6vb5UFKBMC25jSA/K3JkGlHUHb1UVq7IbZaILixHF9myCKVR3E6yoofCC899ETRCWemkWGlptsCQYVvo2+GVH2YKa10ayO0Tql9NRF5kKb1c7Rg3E9ByxCyZO6T39G4RfhJEr87JdqQCk081xZQtUUgAwyo/pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=1iHymlR+; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fy7N955tTzlfl7l;
	Fri, 17 Apr 2026 21:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1776461445; x=1779053446; bh=TYlCA
	drRI03ErJsRMxsQRG1LVs0fBLR+Qa4E919Y2P4=; b=1iHymlR+4Z5tWiWpmgcyJ
	lPpS+KBKBhbJsvRYQ96HwictS8o8uo+iAn6CCb1bzuWgxwsyyyRQM9KgmRWpC4Lw
	opg1zRTYqnCShkp+SIX8j4FXghJ9X1t2gAxte8+pXLl8yVNpA2wI4E7as7KScGlO
	jXkFEDVx9Miq8y3uP/CerRaeozTwHfXhwTtPHpleJIpvF+dqsJA94X9krAGSstzz
	PMrWBAHxkFZ6tXU1L43BP13TUva2xJqD58c4ncdKGAaEdkJZ5hWHnhuBIED9umnU
	XQK7otUdULTFKHXFKfKLwMP4dNxVyHvfiiNNGJoO6oUb8hERtJUtsYDaboazKk/O
	w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id B3ZC3-B37bi6; Fri, 17 Apr 2026 21:30:45 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fy7N26s2yzlgtd3;
	Fri, 17 Apr 2026 21:30:42 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Peter Wang <peter.wang@mediatek.com>,
	Avri Altman <avri.altman@sandisk.com>,
	Bean Huo <beanhuo@micron.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Can Guo <can.guo@oss.qualcomm.com>
Subject: [PATCH 2/3] ufs: core: Complain if UIC argument 2 is invalid
Date: Fri, 17 Apr 2026 14:30:21 -0700
Message-ID: <20260417213027.3506742-3-bvanassche@acm.org>
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
	TAGGED_FROM(0.00)[bounces-23061-lists,linux-scsi=lfdr.de];
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
X-Rspamd-Queue-Id: BB85641EB81
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

According to the UFSHCI standard, the lowest byte of UIC argument 2 is
an output value. Additionally, ufshcd_uic_cmd_compl() is based on the
assumption that the lowest byte of UIC argument 2 is zero. Hence, complai=
n
if the result byte is set when a UIC command is submitted.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/ufs/core/ufshcd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 7fb3921bceb2..0ff9d7c2a7ac 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -2571,6 +2571,7 @@ ufshcd_dispatch_uic_cmd(struct ufs_hba *hba, struct=
 uic_command *uic_cmd)
 	lockdep_assert_held(&hba->uic_cmd_mutex);
=20
 	WARN_ON(hba->active_uic_cmd);
+	WARN_ON_ONCE(uic_cmd->argument2 & MASK_UIC_COMMAND_RESULT);
=20
 	hba->active_uic_cmd =3D uic_cmd;
=20

