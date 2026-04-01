Return-Path: <linux-scsi+bounces-22679-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HUlF3R/zWnqeAYAu9opvQ
	(envelope-from <linux-scsi+bounces-22679-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 01 Apr 2026 22:26:28 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 17477380260
	for <lists+linux-scsi@lfdr.de>; Wed, 01 Apr 2026 22:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2DB2930215E0
	for <lists+linux-scsi@lfdr.de>; Wed,  1 Apr 2026 20:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD7B3630AD;
	Wed,  1 Apr 2026 20:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="5MAA+Aqq"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68EB331213
	for <linux-scsi@vger.kernel.org>; Wed,  1 Apr 2026 20:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775075126; cv=none; b=Nt2c9UPXBHaG7NvfTQnykUBRSvSUVNdaXAOrxtnnZMR44Aog/RLfG05XORJ7uehoBpw76bAbjmpCRase0o6zMGtDg4Y7CYMAvGaDfX3wMkczjj6SA4pgFyIWcE+qSMHM4mMnh15pxKanRFavoc+V5W7cqaKXOycudjZlF0SiZnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775075126; c=relaxed/simple;
	bh=VqVwA5GcRRrDxTqssQDBCEhGy+aJhXAKhYI0QBjrvcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ourmlTOcP4uWlk+Zv/7cYLMnBLdrmvC0r5C96iPHGU0ADSsFJRe7oOEMrlSiZwtkSi9STNa25QmNRJQO2VcSyb8VEL5e1JScfP9/XyjbzmYJFmyGoK7JoQ8j+UJz1+UJNJd8Ux2qy5JvvGfr+DxainJSYQ3ldA2fDVoNbDEbsnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=5MAA+Aqq; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fmGh52TRdz1XM6JJ;
	Wed,  1 Apr 2026 20:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1775075121; x=1777667122; bh=JgT0X
	z5gtlYiFeDPTDmDmo1wtr89UVnlw2FR6YmOUkg=; b=5MAA+AqqlvzgBI5Z2zlAw
	8NYWKznntsOiRoFy9b+N7FPJJSMdcxDf5mfDS5aVSEaTpsucwcvs3hI4Q2PNQ9cz
	CliSv0XV6ozvo7IefzFyjrl4M3Htvu5r+joe9J7l0rrz1zYy8AKSEqyn5R0K5sVM
	fqHgGy9cKVPgq3KkvyJeJuVq2fP4zPaZ0WiNjlYs0Uusnu2vewqS+PCtg9sJYes7
	YeYvdsRgTjU5GOo5vIuxQ+ZxPat8FVJafk0agg3cY+rVA9PDnFvbKZZPOIadkjtZ
	4CqFw5iHENNgdVJtWtEP/AiacYhi2X1Bj0c/qvZJx42sTro6KFNjR+dyt7lCAcZ2
	g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id qHHc7b0cUG2v; Wed,  1 Apr 2026 20:25:21 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fmGgz2HjRz1XM6JH;
	Wed,  1 Apr 2026 20:25:19 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Peter Wang <peter.wang@mediatek.com>,
	vamshi gajjela <vamshigajjela@google.com>,
	"ping.gao" <ping.gao@samsung.com>,
	Chenyuan Yang <chenyuan0y@gmail.com>
Subject: [PATCH 1/3] ufs: core: Add a comment block above ufshcd_mcq_compl_all_cqes_lock()
Date: Wed,  1 Apr 2026 13:24:59 -0700
Message-ID: <20260401202506.1445324-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.1185.g05d4b7b318-goog
In-Reply-To: <20260401202506.1445324-1-bvanassche@acm.org>
References: <20260401202506.1445324-1-bvanassche@acm.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,acm.org,HansenPartnership.com,mediatek.com,google.com,samsung.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-22679-lists,linux-scsi=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[acm.org:+];
	TAGGED_RCPT(0.00)[linux-scsi];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,acm.org:dkim,acm.org:email,acm.org:mid]
X-Rspamd-Queue-Id: 17477380260
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Document the aspects of ufshcd_mcq_compl_all_cqes_lock() that are
nontrivial in a comment block above this function.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/ufs/core/ufs-mcq.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 1b3062577945..c1b1d67a1ddc 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -322,6 +322,14 @@ static void ufshcd_mcq_process_cqe(struct ufs_hba *h=
ba,
 	}
 }
=20
+/*
+ * This function is called from the UFS error handler with the UFS host
+ * controller disabled (HCE =3D 0). Reading host controller registers, e=
.g. the
+ * CQ tail pointer (CQTPy), may not be safe with the host controller dis=
abled.
+ * Hence, iterate over all completion queue entries. This won't result i=
n
+ * double completions because ufshcd_mcq_process_cqe() clears a CQE afte=
r it
+ * has been processed.
+ */
 void ufshcd_mcq_compl_all_cqes_lock(struct ufs_hba *hba,
 				    struct ufs_hw_queue *hwq)
 {

