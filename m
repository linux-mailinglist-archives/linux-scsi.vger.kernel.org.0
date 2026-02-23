Return-Path: <linux-scsi+bounces-20988-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8A2UExl2nGmwHwQAu9opvQ
	(envelope-from <linux-scsi+bounces-20988-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 23 Feb 2026 16:45:29 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A60C178F79
	for <lists+linux-scsi@lfdr.de>; Mon, 23 Feb 2026 16:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3095F3029672
	for <lists+linux-scsi@lfdr.de>; Mon, 23 Feb 2026 15:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CACA2FF17A;
	Mon, 23 Feb 2026 15:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q33Cd8Cl"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01331FBCA7;
	Mon, 23 Feb 2026 15:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771861522; cv=none; b=GnWfFpK1xPpShR4D98FtRFOJ0jz56ih14BkYbyl/8rFC6LePLQ1K0LLDlE5x9Qu161O1RGq62VdtDIQ3PzLCgJQTcsmvZrzvwyQYN8GSej3Ew+GetAghMVZEF9cIjbAArQL9D721L33B8Ci+QGZZKRK/WfVWtrSOAAuoAupzOjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771861522; c=relaxed/simple;
	bh=uI2CTnMZZo8iPqYpwm0xtZd6/FFIAG4bUniP6Ll6Ts8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ef5W20iaDwzTwAKIvmEeLmgyqxeeKAB5qSbMbk6xVEUg2iKCOA58CNFWmbalyakhKn+wBNDQJJFgOtr99bKlb1zOEPxlUqb2yyxoBpfmP3N1EHPB5S1ZbGZfNaCFPvnHLgZkEjNglAH3VJr4U2rw/2jyk7/E6qADXwkPL3nkwQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q33Cd8Cl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A11BDC116C6;
	Mon, 23 Feb 2026 15:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771861521;
	bh=uI2CTnMZZo8iPqYpwm0xtZd6/FFIAG4bUniP6Ll6Ts8=;
	h=From:To:Cc:Subject:Date:From;
	b=q33Cd8Cl2SYM5KlzfAb/xFHR4WHivHVw0eru2+E0awP9IVPiERW6Z+ep959rKmqG8
	 +n0ESof9gl4vgXKbLZKK+kcAR3XT9BgFidR1b1WG4rhpRZvnYwhf7qECGcQVPcJ+uM
	 h09hZBr1QmnQaAOvQ4y94Pg8C5MEheF4XLK+p6pE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	stable <stable@kernel.org>
Subject: [PATCH] scsi: ses: Handle positive SCSI error from ses_recv_diag()
Date: Mon, 23 Feb 2026 16:44:59 +0100
Message-ID: <2026022301-bony-overstock-a07f@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 27
X-Developer-Signature: v=1; a=openpgp-sha256; l=1051; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=uI2CTnMZZo8iPqYpwm0xtZd6/FFIAG4bUniP6Ll6Ts8=; b=owGbwMvMwCRo6H6F97bub03G02pJDJlzSv+qMPh9jmmf/aVCzy7ZUt+iYNkyeYcbW+7uc/N9P dm2Oq+mI5aFQZCJQVZMkeXLNp6j+ysOKXoZ2p6GmcPKBDKEgYtTACaydCfD/Fz2ZQfUD+15am+Z uL1o8eykc1MeMTEs2DqnX/1edsOOdayH99y5et7jRaHNfwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20988-lists,linux-scsi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7A60C178F79
X-Rspamd-Action: no action

ses_recv_diag() can return a positive value, which also means that an
error happened, so do not only test for negative values.

Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: stable <stable@kernel.org>
Assisted-by: gkh_clanker_2000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/ses.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ses.c b/drivers/scsi/ses.c
index 35101e9b7ba7..128042c734cc 100644
--- a/drivers/scsi/ses.c
+++ b/drivers/scsi/ses.c
@@ -215,7 +215,7 @@ static unsigned char *ses_get_page2_descriptor(struct enclosure_device *edev,
 	unsigned char *type_ptr = ses_dev->page1_types;
 	unsigned char *desc_ptr = ses_dev->page2 + 8;
 
-	if (ses_recv_diag(sdev, 2, ses_dev->page2, ses_dev->page2_len) < 0)
+	if (ses_recv_diag(sdev, 2, ses_dev->page2, ses_dev->page2_len))
 		return NULL;
 
 	for (i = 0; i < ses_dev->page1_num_types; i++, type_ptr += 4) {
-- 
2.53.0


