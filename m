Return-Path: <linux-scsi+bounces-15939-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9E7B2136E
	for <lists+linux-scsi@lfdr.de>; Mon, 11 Aug 2025 19:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FC9C3E4215
	for <lists+linux-scsi@lfdr.de>; Mon, 11 Aug 2025 17:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4C82D47E2;
	Mon, 11 Aug 2025 17:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="IDVBJImT"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB7F311C16
	for <linux-scsi@vger.kernel.org>; Mon, 11 Aug 2025 17:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754933961; cv=none; b=fIdhDn4UaHgExGAGxIKtGlFifC+Lf1AzC/2uyTxmQ8AQb+j781QWLO5cgNUtdvSRcVfUIIvxi69IsuQ+QxSZ1myQg/Fv7Ras5KonBHITEGNCXVjV7BoQMLjxKertfbS/jYi5igwe2fSpdgP+g9KaqmtsJPX6Om4QqCpLVPQzRjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754933961; c=relaxed/simple;
	bh=6D+QisIr+e7iX8BxRfzoriCSH6rhR4grfioodzTEySA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DaKkMN35XALYhTizSj5Vv2H0ULyWXb7VSjrm3CTumHfzUXQJOZhohIOSV7hLGMpwYBj1qTYoRgU7Ne+TFkeRBWzZ8VBHuPYE3g5UqUaTCVH8TPFRPMI8iLBDLvsKO1M987Y11BSB3FkmAZpQpBwmNDv7twI5o8rvJeuS4TLlUSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=IDVBJImT; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4c121y509BzlgqV3;
	Mon, 11 Aug 2025 17:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1754933957; x=1757525958; bh=8lhqb
	vl7deHygO7Y2uqlXJ3OxOFwX+1CDd7mCrShOgM=; b=IDVBJImT9u14H9dv6SdPZ
	oaWL9/qnmrQbKh8yMiDfVmZr9kxH+CDFJeuo/XLVhWvBeE2/oLAiZzxrIUKR+AQt
	KddXeZA9VVxIlMvAAUe1pcEzFRLSO0xm/KrPbuN4qvRrx8sVqJL1kXZiMIYpF2gn
	+b2e5r0v3m4fdqUKBUn6EinC1Qh7T0Y21Gm/wW7COyncUnLi1QOu0sPQjvhpK4eS
	b5d/I+fF7wU/ogvzDm9ok4/0qCGR09BdNqpvR0dtF1aa8pQbU2RwxDta6zxWlC9t
	vzC9MJhHFFuDzCDtzpGvZi0BtLkjl5AuOzKN/eIqcbiS5mslQSkVFgax28jaUUV4
	A==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 0COsPBxLpq6x; Mon, 11 Aug 2025 17:39:17 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4c121r61D6zlgqTq;
	Mon, 11 Aug 2025 17:39:12 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Peter Wang <peter.wang@mediatek.com>,
	Avri Altman <avri.altman@sandisk.com>,
	Bean Huo <beanhuo@micron.com>
Subject: [PATCH v2 14/30] ufs: core: Rework ufshcd_mcq_compl_pending_transfer()
Date: Mon, 11 Aug 2025 10:34:26 -0700
Message-ID: <20250811173634.514041-15-bvanassche@acm.org>
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
In-Reply-To: <20250811173634.514041-1-bvanassche@acm.org>
References: <20250811173634.514041-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Replace a tag loop with blk_mq_tagset_busy_iter(). This patch prepares
for removing the hba->lrb[] array.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/ufs/core/ufshcd.c | 80 ++++++++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 34 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 923a19ff668a..e506843d4f33 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -5711,6 +5711,48 @@ static int ufshcd_poll(struct Scsi_Host *shost, un=
signed int queue_num)
 	return completed_reqs !=3D 0;
 }
=20
+static bool ufshcd_mcq_force_compl_one(struct request *rq, void *priv)
+{
+	struct scsi_cmnd *cmd =3D blk_mq_rq_to_pdu(rq);
+	struct scsi_device *sdev =3D rq->q->queuedata;
+	struct Scsi_Host *shost =3D sdev->host;
+	struct ufs_hba *hba =3D shost_priv(shost);
+	struct ufshcd_lrb *lrbp =3D &hba->lrb[rq->tag];
+	struct ufs_hw_queue *hwq =3D ufshcd_mcq_req_to_hwq(hba, rq);
+
+	if (!hwq)
+		return true;
+
+	ufshcd_mcq_compl_all_cqes_lock(hba, hwq);
+
+	/*
+	 * For those cmds of which the cqes are not present in the cq, complete
+	 * them explicitly.
+	 */
+	scoped_guard(spinlock_irqsave, &hwq->cq_lock) {
+		if (cmd && !test_bit(SCMD_STATE_COMPLETE, &cmd->state)) {
+			set_host_byte(cmd, DID_REQUEUE);
+			ufshcd_release_scsi_cmd(hba, lrbp);
+			scsi_done(cmd);
+		}
+	}
+
+	return true;
+}
+
+static bool ufshcd_mcq_compl_one(struct request *rq, void *priv)
+{
+	struct scsi_device *sdev =3D rq->q->queuedata;
+	struct Scsi_Host *shost =3D sdev->host;
+	struct ufs_hba *hba =3D shost_priv(shost);
+	struct ufs_hw_queue *hwq =3D ufshcd_mcq_req_to_hwq(hba, rq);
+
+	if (hwq)
+		ufshcd_mcq_poll_cqe_lock(hba, hwq);
+
+	return true;
+}
+
 /**
  * ufshcd_mcq_compl_pending_transfer - MCQ mode function. It is
  * invoked from the error handler context or ufshcd_host_reset_and_resto=
re()
@@ -5725,40 +5767,10 @@ static int ufshcd_poll(struct Scsi_Host *shost, u=
nsigned int queue_num)
 static void ufshcd_mcq_compl_pending_transfer(struct ufs_hba *hba,
 					      bool force_compl)
 {
-	struct ufs_hw_queue *hwq;
-	struct ufshcd_lrb *lrbp;
-	struct scsi_cmnd *cmd;
-	unsigned long flags;
-	int tag;
-
-	for (tag =3D 0; tag < hba->nutrs; tag++) {
-		lrbp =3D &hba->lrb[tag];
-		cmd =3D lrbp->cmd;
-		if (!ufshcd_cmd_inflight(cmd) ||
-		    test_bit(SCMD_STATE_COMPLETE, &cmd->state))
-			continue;
-
-		hwq =3D ufshcd_mcq_req_to_hwq(hba, scsi_cmd_to_rq(cmd));
-		if (!hwq)
-			continue;
-
-		if (force_compl) {
-			ufshcd_mcq_compl_all_cqes_lock(hba, hwq);
-			/*
-			 * For those cmds of which the cqes are not present
-			 * in the cq, complete them explicitly.
-			 */
-			spin_lock_irqsave(&hwq->cq_lock, flags);
-			if (cmd && !test_bit(SCMD_STATE_COMPLETE, &cmd->state)) {
-				set_host_byte(cmd, DID_REQUEUE);
-				ufshcd_release_scsi_cmd(hba, lrbp);
-				scsi_done(cmd);
-			}
-			spin_unlock_irqrestore(&hwq->cq_lock, flags);
-		} else {
-			ufshcd_mcq_poll_cqe_lock(hba, hwq);
-		}
-	}
+	blk_mq_tagset_busy_iter(&hba->host->tag_set,
+				force_compl ? ufshcd_mcq_force_compl_one :
+					      ufshcd_mcq_compl_one,
+				NULL);
 }
=20
 /**

