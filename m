Return-Path: <linux-scsi+bounces-24335-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MS/NK3pHWp0fwkAu9opvQ
	(envelope-from <linux-scsi+bounces-24335-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 01 Jun 2026 22:21:01 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD3162502C
	for <lists+linux-scsi@lfdr.de>; Mon, 01 Jun 2026 22:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 625CC3043EF5
	for <lists+linux-scsi@lfdr.de>; Mon,  1 Jun 2026 20:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FED37754B;
	Mon,  1 Jun 2026 20:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=theesfeld.net header.i=@theesfeld.net header.b="gZI3uUwg"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch [109.224.244.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8BE38399A
	for <linux-scsi@vger.kernel.org>; Mon,  1 Jun 2026 20:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780345217; cv=none; b=PcB6kp9rdwpmk4jv8a7vZ6+W7FvWjQl7NKZJqMWotMe/JbQybeDV9cYj+R8fVZ73kSBZrtxCrSuv3VqlEyUcIEL47gHa7hvyQurc8VV+4MFAE4X4FPIUMnDMa9du1bjCzS6BCWvvANKQ3u4O16M0U7eCWDACY2b4aKIv5pgVKko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780345217; c=relaxed/simple;
	bh=Qv9s2qNDGnJLbDcBOEmyjgdJDS0m4KUfuBRITqJ5lQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hOaiF0qrka7k6NuqkXnZw3id7rYLxENh6UnRs9EgyvjZktv4NpSDqxBk4IVbUvDpNRqWA9qzw147hy2M2aqRkiP7afV5Je8RhjtmMdcmzsvjMnn/5svGvujrqPpAPvjnty+bS6vmyMmxfIz5j4oXjFzJJNFdo91vL2J5OtK0XyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theesfeld.net; spf=pass smtp.mailfrom=theesfeld.net; dkim=pass (2048-bit key) header.d=theesfeld.net header.i=@theesfeld.net header.b=gZI3uUwg; arc=none smtp.client-ip=109.224.244.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theesfeld.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theesfeld.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theesfeld.net;
	s=protonmail2; t=1780345206; x=1780604406;
	bh=KPfVAe+EKCmxEJ9+FKpLXsTX13R2V9swnJwsiXMLk7A=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=gZI3uUwgCwqyAIwZhEHR8qwwKp9alaISstIciQNijBLj50yzVd6+fO0kjit0C1Ict
	 JclcfYc0YNIgvMcalb7cjEWhg+b6Gs77qokdNC51AkU0nagWi0n1jA3YgRLEF0AWey
	 o52JA5lEsXnwPvk3wWmh/bD09kHuUhPDprKTmwkdUccV17mnlBsrPlfng00wkGN+Kr
	 n9JOWA4/FlwKvKMGiXJG1qslwwiwvIPPkjOCsTHWuhI0rufl1rYuO6yOLLrpE+V8wD
	 P6uuVfcwWN9D90t0nLwibts919mDW26m8ASbyLu73MusjqaHAIoQXcIZvt0ZtRQ5ha
	 4rHnHiPFoufcQ==
X-Pm-Submission-Id: 4gTlgk6JJPz1DFFr
From: William Theesfeld <william@theesfeld.net>
To: Justin Tee <justin.tee@broadcom.com>
Cc: Paul Ely <paul.ely@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: lpfc: fix spelling mistake in comment
Date: Mon,  1 Jun 2026 16:20:01 -0400
Message-ID: <20260601202001.651088-1-william@theesfeld.net>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[theesfeld.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[theesfeld.net:s=protonmail2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-24335-lists,linux-scsi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[william@theesfeld.net,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[theesfeld.net:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[theesfeld.net:email,theesfeld.net:mid,theesfeld.net:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6FD3162502C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Comment-only change. No functional impact.

Signed-off-by: William Theesfeld <william@theesfeld.net>
---
 drivers/scsi/lpfc/lpfc_bsg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_bsg.c b/drivers/scsi/lpfc/lpfc_bsg.c
index 7406dfa60..2b87dbe3f 100644
--- a/drivers/scsi/lpfc/lpfc_bsg.c
+++ b/drivers/scsi/lpfc/lpfc_bsg.c
@@ -5003,7 +5003,7 @@ lpfc_bsg_issue_mbox(struct lpfc_hba *phba, struct bsg_job *job,
 	} else if (phba->sli_rev == LPFC_SLI_REV4) {
 		/* Let type 4 (well known data) through because the data is
 		 * returned in varwords[4-8]
-		 * otherwise check the recieve length and fetch the buffer addr
+		 * otherwise check the receive length and fetch the buffer addr
 		 */
 		if ((pmb->mbxCommand == MBX_DUMP_MEMORY) &&
 			(pmb->un.varDmp.type != DMP_WELL_KNOWN)) {
-- 
2.54.0


