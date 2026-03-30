Return-Path: <linux-scsi+bounces-22610-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aC6YA6HCymmL/wUAu9opvQ
	(envelope-from <linux-scsi+bounces-22610-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 30 Mar 2026 20:36:17 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E8235FCA6
	for <lists+linux-scsi@lfdr.de>; Mon, 30 Mar 2026 20:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B07AE30428A2
	for <lists+linux-scsi@lfdr.de>; Mon, 30 Mar 2026 18:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D71B382391;
	Mon, 30 Mar 2026 18:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="W5L6zC/f"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FD32C11EE
	for <linux-scsi@vger.kernel.org>; Mon, 30 Mar 2026 18:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774895630; cv=none; b=LVUBic1ygdYin/MLa3piy7e11iRnKoni8vCAgUcvQXlWRKX48/KPHBGuiRbFJpS/EjDI8IIqf5vhFXllMN3+DIilMlilIjfGBmxj1B+HdfNC4yKG1jKQalDsK+hTqlmd3hechV2gH4xiDp3y8nyVhWW4wdVnQ7TasY+JFxi4BVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774895630; c=relaxed/simple;
	bh=uA+YhbdfVKxExIEP9bmP95mU3j65+gPABbY3xKuRtjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V04F3a9MCeyHK2m5QfkfDAvD7LuuBLr2Ul5dU7/gTM5PkuHnB26/61jNRk1TQzl4wLhpcIsBEoPUmHWQCaL2cADeOecxIiLfegRwcVkXOh6mpNhl9qY+jvgASUdrDoNIbcsKH1A+A5kgq7J11BZ7zfkB45dZweXckbVrcUlVyYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=W5L6zC/f; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fl0JF0Dy7zlfpMB;
	Mon, 30 Mar 2026 18:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1774895624; x=1777487625; bh=HZOj+
	DpfMXPZNu5sMOtfQTqoI429OgIDozKZzPC0sbg=; b=W5L6zC/f0LwYQ0oraxvz+
	pec5aPhvT0FOkXcRPuJffKTEy5c/JYOfPt1yjCV1njv5yTOjZuChWhKryYKJHogZ
	yKLXlZ0Fd8dPmomfiY15rgBIW2PFnJUscx05mB60Qlgp5eTBLGI7d+ACiSrKPkib
	t7hZBPyOu+FFWOIS2HNnyXgJC38IWyO9IdAsvBa/RouajaG4J3eEvhx0r1sKsprV
	oBPFHv7XGF/G89SLJbKt0n7iCBqqg1Px1RO61L8rqylhbz/fxhINoqggUkcnk5TV
	2o3A3eQJCfXJqoWFBTUZLEzYGjanQFkT2cUL8gKGdVmYmdHrn290tbLm1rnqSyaN
	A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id RCM25HpbZSwb; Mon, 30 Mar 2026 18:33:44 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fl0J30XH3zlfvq4;
	Mon, 30 Mar 2026 18:33:38 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Subject: [PATCH 3/3] ufs: qcom: Reduce interrupt latency
Date: Mon, 30 Mar 2026 11:33:05 -0700
Message-ID: <20260330183311.1941942-4-bvanassche@acm.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-22610-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-scsi];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[acm.org:dkim,acm.org:email,acm.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A0E8235FCA6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Defer completion processing to thread context on slower CPU cores to
prevent interrupt latency spikes. On the fastest CPU cores, keep
processing all completions in interrupt context.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/ufs/host/ufs-qcom.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 5a58ffef3d27..7cacc0ec0624 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -2370,6 +2370,16 @@ struct ufs_qcom_irq {
 	struct ufs_hba		*hba;
 };
=20
+static irqreturn_t ufs_qcom_mcq_threaded_esi_handler(int irq, void *data=
)
+{
+	struct ufs_qcom_irq *qi =3D data;
+	struct ufs_hba *hba =3D qi->hba;
+
+	ufshcd_mcq_poll_cqe_lock(hba, &hba->uhq[qi->idx]);
+
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t ufs_qcom_mcq_esi_handler(int irq, void *data)
 {
 	struct ufs_qcom_irq *qi =3D data;
@@ -2377,9 +2387,22 @@ static irqreturn_t ufs_qcom_mcq_esi_handler(int ir=
q, void *data)
 	struct ufs_hw_queue *hwq =3D &hba->uhq[qi->idx];
=20
 	ufshcd_mcq_write_cqis(hba, 0x1, qi->idx);
-	ufshcd_mcq_poll_cqe_lock(hba, hwq);
=20
-	return IRQ_HANDLED;
+	if (arch_scale_cpu_capacity(raw_smp_processor_id()) =3D=3D
+	    SCHED_CAPACITY_SCALE) {
+		ufshcd_mcq_poll_cqe_lock(hba, hwq);
+		return IRQ_HANDLED;
+	}
+
+	if (ufshcd_mcq_poll_cqe_lock_n(hba, hwq, 4) < 4)
+		return IRQ_HANDLED;
+
+	/*
+	 * Defer further completion processing to thread context because
+	 * processing a large number of completions in interrupt context on
+	 * slower CPU cores can result in unacceptably high interrupt latencies=
.
+	 */
+	return IRQ_WAKE_THREAD;
 }
=20
 static int ufs_qcom_config_esi(struct ufs_hba *hba)
@@ -2415,8 +2438,10 @@ static int ufs_qcom_config_esi(struct ufs_hba *hba=
)
 		qi[idx].idx =3D idx;
 		qi[idx].hba =3D hba;
=20
-		ret =3D devm_request_irq(hba->dev, qi[idx].irq, ufs_qcom_mcq_esi_handl=
er,
-				       IRQF_SHARED, "qcom-mcq-esi", qi + idx);
+		ret =3D devm_request_threaded_irq(hba->dev, qi[idx].irq,
+			ufs_qcom_mcq_esi_handler,
+			ufs_qcom_mcq_threaded_esi_handler,
+			IRQF_SHARED | IRQF_ONESHOT, "qcom-mcq-esi", qi + idx);
 		if (ret) {
 			dev_err(hba->dev, "%s: Failed to request IRQ for %d, err =3D %d\n",
 				__func__, qi[idx].irq, ret);

