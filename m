Return-Path: <linux-scsi+bounces-8924-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E0B9A14A0
	for <lists+linux-scsi@lfdr.de>; Wed, 16 Oct 2024 23:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49DCC1F235C5
	for <lists+linux-scsi@lfdr.de>; Wed, 16 Oct 2024 21:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2FD1D1738;
	Wed, 16 Oct 2024 21:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="xZGPtu8Z"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A581CBA16
	for <linux-scsi@vger.kernel.org>; Wed, 16 Oct 2024 21:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729113160; cv=none; b=ru5TV3opmXBnU1Xiq5FJ1Zyi8dz1lAjhbhf7zdNmabeDRrRcjz1XE6+sVjjHyWcOkG2B/ArX8kXDERByV4QHitBr/00l5lPI8PrXZWp/FWNirfvo5CWbHZ9XbfQWlj6F9lsItKKzyhVX2r/TXZx97xWYwqyPwnBiBsov2QqyelI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729113160; c=relaxed/simple;
	bh=cW6XNMBTBAgxOtzK7ioYdChwOMIEooir0VfeYR/t2OY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lpci6TgIpti+TcM6swKCv9x2znPqoqPPlSAYDZh0ZBVSQQ9PYQdmWJTxp2iq9tIQRFN3IFJc9Ai6NW7et2OIZMbGrfaxyEDsNAZszAFND9jICJebq6r/vaU7/smRmZEdxJLayfFxtQeDUGdv+IIudMZNrdVrFaGO7KlLyw+OOcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=xZGPtu8Z; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XTNw65f7NzlgTWP;
	Wed, 16 Oct 2024 21:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1729113154; x=1731705155; bh=WOHiv
	8CEU+KJI+dGQQYZcdgaaJBmMdv0xMhdmT/xVYU=; b=xZGPtu8ZR0xSABT7POXr3
	CpQtefUhLmG/xkl2sOwOrtA8q8aNIvDNJ3RVPBCfnuEzMFwj+Chk3k5OInX4We3U
	Gn+MCVLpUtotVZe5+/ZSc1rCK2AUFsFUWBkvjyxcIux2VxpiALjrETx8mm3tnWg2
	g1z3PNsP6cbDPJDiYdIiuT6qd2A0T3QdyT6mV9XAPLQpjFF+qdAbhNyzNJ8I0exb
	WZAtyksAGgfEPuZbdLO8mD7gi+aCirmiZhaalGcQOcJlaJRGZj/N7IDeQ9lO62O/
	219YnzqdXjSC0d4CN8yCEEwI/d6esvshfEi91N3mph27FTRU8z+wlvbcrajouLwi
	A==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id gQuCACCqWAhN; Wed, 16 Oct 2024 21:12:34 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XTNvz5N8CzlgMVr;
	Wed, 16 Oct 2024 21:12:31 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Peter Wang <peter.wang@mediatek.com>,
	Avri Altman <avri.altman@wdc.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Bean Huo <beanhuo@micron.com>,
	Maramaina Naresh <quic_mnaresh@quicinc.com>,
	Maya Erez <quic_merez@quicinc.com>,
	Asutosh Das <quic_asutoshd@quicinc.com>,
	Can Guo <quic_cang@quicinc.com>
Subject: [PATCH 4/7] scsi: ufs: core: Fix ufshcd_exception_event_handler()
Date: Wed, 16 Oct 2024 14:11:15 -0700
Message-ID: <20241016211154.2425403-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
In-Reply-To: <20241016211154.2425403-1-bvanassche@acm.org>
References: <20241016211154.2425403-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use blk_mq_quiesce_tagset() / blk_mq_unquiesce_tagset() instead of
scsi_block_requests() / scsi_unblock_requests() because the former wait
for ongoing SCSI command dispatching to finish while the latter do not.

Fixes: 2e3611e9546c ("scsi: ufs: fix exception event handling")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/ufs/core/ufshcd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 76884df580c3..ff1b0af74041 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -6195,7 +6195,7 @@ static void ufshcd_exception_event_handler(struct w=
ork_struct *work)
 	u32 status =3D 0;
 	hba =3D container_of(work, struct ufs_hba, eeh_work);
=20
-	ufshcd_scsi_block_requests(hba);
+	blk_mq_quiesce_tagset(&hba->host->tag_set);
 	err =3D ufshcd_get_ee_status(hba, &status);
 	if (err) {
 		dev_err(hba->dev, "%s: failed to get exception status %d\n",
@@ -6213,7 +6213,7 @@ static void ufshcd_exception_event_handler(struct w=
ork_struct *work)
=20
 	ufs_debugfs_exception_event(hba, status);
 out:
-	ufshcd_scsi_unblock_requests(hba);
+	blk_mq_unquiesce_tagset(&hba->host->tag_set);
 }
=20
 /* Complete requests that have door-bell cleared */

