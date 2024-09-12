Return-Path: <linux-scsi+bounces-8244-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD2B977455
	for <lists+linux-scsi@lfdr.de>; Fri, 13 Sep 2024 00:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8F92B22576
	for <lists+linux-scsi@lfdr.de>; Thu, 12 Sep 2024 22:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DD01C2337;
	Thu, 12 Sep 2024 22:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="496bLgMp"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B152E2C80
	for <linux-scsi@vger.kernel.org>; Thu, 12 Sep 2024 22:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726180244; cv=none; b=enfavaHAMRt4G8gMJOqgE4BSeFciygsNRrBCyAdcvHpg5WUfvX0yV04mNOR8g1HS+h1gl/iqudL3ExMPy2KrKaOKfeniQcvQivR+q4k2liPugE2FBJamoyQb3WsG4qZj0MVR+AA+yrCPmdoDH0bEQjb5SYfGVgikBrJSYd03dsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726180244; c=relaxed/simple;
	bh=zKJfrLeoBPPI3uHpNP+FXEv5R0/yEhtRTKeW7bWtfzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jxVu+9mBzgh2niO0n9gChRVmEmJ/evUmW0DYKk2Ne3HCO9yrZefzcB6eM013tIUodSoM9JuVc7hPxCldB3LYWVReFWgS8HOSVTOjuyDFm3xp32dkDi5Ed1lARqhKI2od8hFISg0CZACYWuZ5dMwR+yxXgCNf1eMdCG0o6ILRgkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=496bLgMp; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4X4XFs6dcJz6ClY9f;
	Thu, 12 Sep 2024 22:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1726180237; x=1728772238; bh=M602l
	HejhFAGmvvzqGitnCXvr6yptgiUPr9f9z3DINk=; b=496bLgMp/WEmHjqwvrXZU
	iAMgBHgjsaaJuzdnO1dDoLbVRkHtXWOW7L9uLoOjEN1BiNoUM1SUxT9BzkCy9DFy
	V+F+F92xKqDo2VTLAVuOo1dpwFmh3pz1r2Uq5gy2DBXswjJJRFGhHbUc5AJ/95Do
	w24tC8/UBo3Ana0wEbcnR9DxwiGLpPFghBFgrMg729LVxoF/fueOu0r36k/Uegf+
	+oOKHqn60iOEIdp76kz/itSF+delyC+MlOMpiVEhTaLFhnqoWh20vkUaB+5YvTCs
	r4U66d1QG2J83vU2cPhVIl7hUglCwe0HV0cklXkoFKihFtbGBMFJbDR4KV6R/dBX
	g==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id o0yCQtKUrh00; Thu, 12 Sep 2024 22:30:37 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4X4XFm0S0Bz6ClY9R;
	Thu, 12 Sep 2024 22:30:35 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Peter Wang <peter.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Eric Biggers <ebiggers@google.com>,
	Avri Altman <avri.altman@wdc.com>,
	Minwoo Im <minwoo.im@samsung.com>,
	Maramaina Naresh <quic_mnaresh@quicinc.com>
Subject: [PATCH v4 1/4] scsi: ufs: core: Improve the struct ufs_hba documentation
Date: Thu, 12 Sep 2024 15:30:02 -0700
Message-ID: <20240912223019.3510966-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
In-Reply-To: <20240912223019.3510966-1-bvanassche@acm.org>
References: <20240912223019.3510966-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Make the role of the structure members related to UIC command processing
more clear.

Reviewed-by: Peter Wang <peter.wang@mediatek.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/ufs/ufshcd.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index a43b14276bc3..85933775c9f3 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -868,9 +868,10 @@ enum ufshcd_mcq_opr {
  * @tmf_tag_set: TMF tag set.
  * @tmf_queue: Used to allocate TMF tags.
  * @tmf_rqs: array with pointers to TMF requests while these are in prog=
ress.
- * @active_uic_cmd: handle of active UIC command
- * @uic_cmd_mutex: mutex for UIC command
- * @uic_async_done: completion used during UIC processing
+ * @active_uic_cmd: pointer to active UIC command.
+ * @uic_cmd_mutex: mutex used for serializing UIC command processing.
+ * @uic_async_done: completion used to wait for power mode or hibernatio=
n state
+ *	changes.
  * @ufshcd_state: UFSHCD state
  * @eh_flags: Error handling flags
  * @intr_mask: Interrupt Mask Bits

