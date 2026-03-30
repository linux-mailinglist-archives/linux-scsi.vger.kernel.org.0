Return-Path: <linux-scsi+bounces-22609-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eL84F5jCymmL/wUAu9opvQ
	(envelope-from <linux-scsi+bounces-22609-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 30 Mar 2026 20:36:08 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9CB35FC9F
	for <lists+linux-scsi@lfdr.de>; Mon, 30 Mar 2026 20:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFD7530401A5
	for <lists+linux-scsi@lfdr.de>; Mon, 30 Mar 2026 18:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142EB391E41;
	Mon, 30 Mar 2026 18:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Cm6SZEsi"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BC5382391
	for <linux-scsi@vger.kernel.org>; Mon, 30 Mar 2026 18:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774895626; cv=none; b=Bnwnu5+bjWsXnMRLPRlE92Ai/BWqwLhzGDd+PfK++vFdKeGnZZ9YueuG3au3o4oQdXxFqO6ipLrOZXfSMNIGpnWIq0zn9FOASWRrdCRbRedhzSeaF52kd3gCRoFg1s4Qr7y0hVBal8AciLTw4WsgN0dYseOXx1HvrYxz3Ecal6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774895626; c=relaxed/simple;
	bh=IJ9+T7m61T4PPP58OsbbHk76Gv/tN1vHfyfyrfNs3As=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OqBVtBCUXSbVA5+VPaPNAlFBNXAWiwtMWyFZeXVn1XWYzv7XKdF1ZUqqrwa4KoCWoIyJ+9kc6Bg5jtXpbjCC0ZQJnrcMJyMnW3E40UHb2Pa5v7SkvbgAMV5yAOWkwb6qReiZwsKjmW3NZY5GyuVahOandsGcZwhFWYUK1uCrsi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Cm6SZEsi; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fl0J86FF9zlgy1x;
	Mon, 30 Mar 2026 18:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1774895618; x=1777487619; bh=CHQNU
	dnBlBCPPGlrPUr2Y1HQAxKfITXDWLsJ1kWqZJc=; b=Cm6SZEsiqVPs6x8CTxHto
	G1W2tRrmCGNZh2nizlxN8ZY3EBF8yRegnUEJRVtv9c80WdhIdNjGG73PrKASu86C
	26GcQAdKoinIKJKzPXjhy8NSs46ExU96YrU9tulXE0BJLzoFXd4gFSDTcEcNc6l9
	LLFKsjb1Ez/GhIMCbqj7c5iAf9sffm3TyB+OMPC8kZG3eUC4ucr9Yk0V/nrmzVGU
	+53/Ei+xuHZ8EXfXQcCt05W97XY1DHgy71/Fodui0gyDMq+A0EYH/13dwL0wmvUG
	Y5KeFO2hr0WTgSxxF1JWSMBUmIg0e7eGoH2HOSgi8Bb1uJj+TO8UXZ/kQH862Tf8
	A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 70wJmGGIi26c; Mon, 30 Mar 2026 18:33:38 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fl0Hz2MRTzlfpMC;
	Mon, 30 Mar 2026 18:33:34 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Peter Wang <peter.wang@mediatek.com>,
	vamshi gajjela <vamshigajjela@google.com>,
	Bean Huo <beanhuo@micron.com>,
	"ping.gao" <ping.gao@samsung.com>,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	Chenyuan Yang <chenyuan0y@gmail.com>
Subject: [PATCH 2/3] ufs: core: Introduce ufshcd_mcq_poll_cqe_lock_n()
Date: Mon, 30 Mar 2026 11:33:04 -0700
Message-ID: <20260330183311.1941942-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
In-Reply-To: <20260330183311.1941942-1-bvanassche@acm.org>
References: <20260330183311.1941942-1-bvanassche@acm.org>
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
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,acm.org,HansenPartnership.com,mediatek.com,google.com,micron.com,samsung.com,oracle.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-22609-lists,linux-scsi=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[acm.org:+];
	TAGGED_RCPT(0.00)[linux-scsi];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,acm.org:dkim,acm.org:email,acm.org:mid]
X-Rspamd-Queue-Id: AD9CB35FC9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Introduce a new function for processing completions and that accepts an
upper limit for the number of completions to poll. Tell
ufshcd_mcq_poll_cqe_lock() to poll at most hwq->max_entries. This is
sufficient to poll all pending completions since there are never more
than hwq->max_entries - 1 completions on a completion queue. This patch
prepares for reducing the interrupt latency.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/ufs/core/ufs-mcq.c | 14 +++++++++++---
 include/ufs/ufshcd.h       |  3 +++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 8ccde4571859..afff0784555f 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -322,15 +322,16 @@ static void ufshcd_mcq_process_cqe(struct ufs_hba *=
hba,
 	}
 }
=20
-unsigned long ufshcd_mcq_poll_cqe_lock(struct ufs_hba *hba,
-				       struct ufs_hw_queue *hwq)
+unsigned long ufshcd_mcq_poll_cqe_lock_n(struct ufs_hba *hba,
+					 struct ufs_hw_queue *hwq,
+					 unsigned int max_compl)
 {
 	unsigned long completed_reqs =3D 0;
 	unsigned long flags;
=20
 	spin_lock_irqsave(&hwq->cq_lock, flags);
 	ufshcd_mcq_update_cq_tail_slot(hwq);
-	while (!ufshcd_mcq_is_cq_empty(hwq)) {
+	while (!ufshcd_mcq_is_cq_empty(hwq) && completed_reqs < max_compl) {
 		ufshcd_mcq_process_cqe(hba, hwq);
 		ufshcd_mcq_inc_cq_head_slot(hwq);
 		completed_reqs++;
@@ -342,6 +343,13 @@ unsigned long ufshcd_mcq_poll_cqe_lock(struct ufs_hb=
a *hba,
=20
 	return completed_reqs;
 }
+EXPORT_SYMBOL_GPL(ufshcd_mcq_poll_cqe_lock_n);
+
+unsigned long ufshcd_mcq_poll_cqe_lock(struct ufs_hba *hba,
+				       struct ufs_hw_queue *hwq)
+{
+	return ufshcd_mcq_poll_cqe_lock_n(hba, hwq, hwq->max_entries);
+}
 EXPORT_SYMBOL_GPL(ufshcd_mcq_poll_cqe_lock);
=20
 void ufshcd_mcq_make_queues_operational(struct ufs_hba *hba)
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index cfbc75d8df83..5679d93353ac 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -1475,6 +1475,9 @@ void ufshcd_mcq_config_mac(struct ufs_hba *hba, u32=
 max_active_cmds);
 unsigned int ufshcd_mcq_queue_cfg_addr(struct ufs_hba *hba);
 u32 ufshcd_mcq_read_cqis(struct ufs_hba *hba, int i);
 void ufshcd_mcq_write_cqis(struct ufs_hba *hba, u32 val, int i);
+unsigned long ufshcd_mcq_poll_cqe_lock_n(struct ufs_hba *hba,
+					 struct ufs_hw_queue *hwq,
+					 unsigned int max_compl);
 unsigned long ufshcd_mcq_poll_cqe_lock(struct ufs_hba *hba,
 					 struct ufs_hw_queue *hwq);
 void ufshcd_mcq_make_queues_operational(struct ufs_hba *hba);

