Return-Path: <linux-scsi+bounces-23060-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFm4B5Cm4mmR8gAAu9opvQ
	(envelope-from <linux-scsi+bounces-23060-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 17 Apr 2026 23:30:56 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AC04741EB79
	for <lists+linux-scsi@lfdr.de>; Fri, 17 Apr 2026 23:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85A343035A72
	for <lists+linux-scsi@lfdr.de>; Fri, 17 Apr 2026 21:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2528C379EF0;
	Fri, 17 Apr 2026 21:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="z8RHyiQZ"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA76379980
	for <linux-scsi@vger.kernel.org>; Fri, 17 Apr 2026 21:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776461447; cv=none; b=KjUOSs1FxRFwH2joYg7jCIKgL6aTGEEoocXxJlSbInXzkhDkntRIQJhPGL5nSiVV1BH2yvQaORx+CKBVs3fpNvKe6QSCbTj5UX48gkytqE81SIcHb9TI+QJi+u3g2IRITJJaURjz8mFAN2eDKKZCl6IPnBijuPFXct75XSNmapc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776461447; c=relaxed/simple;
	bh=mnnSJ0lmIw3ICzjHKPup/xl0ZFP7zRVY97c7YMvVdow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UP425cp0yTZzuMW0MaEQlOlntL0jiSlTirFzqxYiD04OMb3egBXCOizv7FdT0rHe/6TOtxOIqKo38q2aj1yZ00AeOgpfQMUFUDzu6dhyNfzYHAY9jceORKwIdytAYPTAeLo5JFPfwzWg0ycFb0fidJW0LrfQON1S5VfuzxqXlJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=z8RHyiQZ; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fy7N611Mmzlfl6P;
	Fri, 17 Apr 2026 21:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1776461440; x=1779053441; bh=7e41m
	1gvFFhzoc7dhO5zfIPUl0S/PtcEn1NWvU3fn8w=; b=z8RHyiQZRm4Va85/kI+1w
	Rr75j+TKIyDfWCjkfTKcInjE9SA/eQfZB50li+4AGx1nnvF77Y1slt0bjYWh9EI2
	pOvhagG9awdcvMbWAVLcx70B5qbQB14JkhkVXqiYtyUMnvbRuKLmsba5QHGmpKtE
	vNg9ST5c4si7KB2rLoq1YtjEyXaIs2wgDl8AGTvfaIxisEWpjhd+wzd/J5FhrzH6
	yXeKH1oz9sx/i52haNUrKah+wABLyLycYanyeave2HolEzCYlKIcKLh+yT50gyEh
	BKZgBP2G9kDx1L+t/MIJg8SujOecXPMZkVviUjmMlRXFUsJMsM3zNRTzNIU5kPws
	A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 8IahUHgmJ99Z; Fri, 17 Apr 2026 21:30:40 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fy7My5BxMzlfl7l;
	Fri, 17 Apr 2026 21:30:38 +0000 (UTC)
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
Subject: [PATCH 1/3] ufs: core: Inline two functions related to UIC commands
Date: Fri, 17 Apr 2026 14:30:20 -0700
Message-ID: <20260417213027.3506742-2-bvanassche@acm.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23060-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,acm.org:email,acm.org:dkim,acm.org:mid]
X-Rspamd-Queue-Id: AC04741EB79
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The implementation of the two functions ufshcd_get_uic_cmd_result() and
ufshcd_get_dme_attr_val() is very short. Additionally, both functions
only have one caller. Hence, inline both functions.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/ufs/core/ufshcd.c | 37 ++++++++-----------------------------
 1 file changed, 8 insertions(+), 29 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 4805e40ed4d7..7fb3921bceb2 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -912,33 +912,6 @@ static inline int ufshcd_get_lists_status(u32 reg)
 	return !((reg & UFSHCD_STATUS_READY) =3D=3D UFSHCD_STATUS_READY);
 }
=20
-/**
- * ufshcd_get_uic_cmd_result - Get the UIC command result
- * @hba: Pointer to adapter instance
- *
- * This function gets the result of UIC command completion
- *
- * Return: 0 on success; non-zero value on error.
- */
-static inline int ufshcd_get_uic_cmd_result(struct ufs_hba *hba)
-{
-	return ufshcd_readl(hba, REG_UIC_COMMAND_ARG_2) &
-	       MASK_UIC_COMMAND_RESULT;
-}
-
-/**
- * ufshcd_get_dme_attr_val - Get the value of attribute returned by UIC =
command
- * @hba: Pointer to adapter instance
- *
- * This function gets UIC command argument3
- *
- * Return: 0 on success; non-zero value on error.
- */
-static inline u32 ufshcd_get_dme_attr_val(struct ufs_hba *hba)
-{
-	return ufshcd_readl(hba, REG_UIC_COMMAND_ARG_3);
-}
-
 /**
  * ufshcd_get_req_rsp - returns the TR response transaction type
  * @ucd_rsp_ptr: pointer to response UPIU
@@ -5716,8 +5689,14 @@ static irqreturn_t ufshcd_uic_cmd_compl(struct ufs=
_hba *hba, u32 intr_status)
 		hba->errors |=3D (UFSHCD_UIC_HIBERN8_MASK & intr_status);
=20
 	if (intr_status & UIC_COMMAND_COMPL) {
-		cmd->argument2 |=3D ufshcd_get_uic_cmd_result(hba);
-		cmd->argument3 =3D ufshcd_get_dme_attr_val(hba);
+		/*
+		 * Store the UIC command result in the lowest byte of
+		 * cmd->argument2.
+		 */
+		cmd->argument2 |=3D ufshcd_readl(hba, REG_UIC_COMMAND_ARG_2) &
+				  MASK_UIC_COMMAND_RESULT;
+		/* Store the DME attribute value in cmd->argument3. */
+		cmd->argument3 =3D ufshcd_readl(hba, REG_UIC_COMMAND_ARG_3);
 		if (!hba->uic_async_done)
 			cmd->cmd_active =3D false;
 		complete(&cmd->done);

