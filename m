Return-Path: <linux-scsi+bounces-17544-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91587B9C26B
	for <lists+linux-scsi@lfdr.de>; Wed, 24 Sep 2025 22:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 914693BA221
	for <lists+linux-scsi@lfdr.de>; Wed, 24 Sep 2025 20:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91FD32B4B5;
	Wed, 24 Sep 2025 20:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="zYP6ts7o"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6506A32BF32
	for <linux-scsi@vger.kernel.org>; Wed, 24 Sep 2025 20:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758746146; cv=none; b=I0yh3Ns09t15kBtM3v4jLxDH/KPBMtR+aTCabe0S5sbkXFtrcrZ3LNv9QJJrjs64zSwAuv0qTA43sRjseRk0wJ5JmXt1BxzjfExm6AvEk/aoLk6ryLiaBZ+tLGnC7C2WXZdZiR4ZQfZ+Ftt0KZx8xqJCup7ScHWiR/0LCOTx704=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758746146; c=relaxed/simple;
	bh=Oan/Zuq4foT5uk5LG9l3EZ+ZVtAdhzCCPwD8jhY5dL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gojZw7TXtoG1JXDmrAURldB13ldx2ukX+BP/I000ZDezFFA8/Dp0h1efB1T8DhA5uak0one2bz98Uh2+OhITvS9TDGier5NZSTZgnWJn2xuFlnLbra0rZSJzeU1O0zpbTiaoNSj20QMBB5nZt+RjVbxwrbPVIPHCOAaJFFhLjvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=zYP6ts7o; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4cX7sC5JRQzlgqVP;
	Wed, 24 Sep 2025 20:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1758746140; x=1761338141; bh=CnvNh
	SOghqq8VLNAk19MuXL1Hm4JNM+km310qYgMiWw=; b=zYP6ts7oJme/LxGL6hcKO
	Dnk2/lNB4INbKd0DVJ0dUM6atcXrRYJDyHocc7JjWMO9DHtOQVkbR6HPwoJpfMPT
	Z997NLanB5AgxWichVm7UV12QIFWd2o0rZHXh7LMBzSYBf6GR/8pbX0U6P8GF5oX
	/PsOGE44GGrTDIjH6dBqMmcnqdvz+7qqdPcKrLWS1R8pwNsMufQX04WwwEu8C9sB
	yJZy25qWszaM1ec1+18eKfdUfehEuvMdG1VtSEf/gKXXi/nO+LbTGd4px1JSl//Y
	9ijQVV6sAEz9A3PZ9d/5XNT4nyutCVo49sY3I5eX53c/aenIwf4V96FhZQ7LYhMr
	A==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 9T7PwlpoMsud; Wed, 24 Sep 2025 20:35:40 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4cX7rx2cplzlgqxl;
	Wed, 24 Sep 2025 20:35:28 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Peter Wang <peter.wang@mediatek.com>,
	"ping.gao" <ping.gao@samsung.com>,
	Chenyuan Yang <chenyuan0y@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Ziqi Chen <quic_ziqichen@quicinc.com>,
	Bean Huo <beanhuo@micron.com>,
	Can Guo <quic_cang@quicinc.com>,
	"Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Avri Altman <avri.altman@wdc.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Nitin Rawat <quic_nitirawa@quicinc.com>,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v5 28/28] ufs: core: Switch to scsi_get_internal_cmd()
Date: Wed, 24 Sep 2025 13:30:47 -0700
Message-ID: <20250924203142.4073403-29-bvanassche@acm.org>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
In-Reply-To: <20250924203142.4073403-1-bvanassche@acm.org>
References: <20250924203142.4073403-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Instead of storing the tag of the reserved command in hba->reserved_slot,
use scsi_get_internal_cmd() and scsi_put_internal_cmd() to allocate the
tag for the reserved command dynamically. Add
ufshcd_queue_reserved_command() for submitting reserved commands. Add
support in ufshcd_abort() for device management commands. Use
blk_execute_rq() for submitting reserved commands. Remove the code and
data structures that became superfluous. This includes
ufshcd_wait_for_dev_cmd(), hba->reserved_slot and ufs_dev_cmd.complete.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/ufs/core/ufs-mcq.c     |  19 ++-
 drivers/ufs/core/ufshcd-priv.h |  25 +---
 drivers/ufs/core/ufshcd.c      | 224 ++++++++++++++++-----------------
 include/ufs/ufshcd.h           |   6 -
 4 files changed, 119 insertions(+), 155 deletions(-)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index c6c6cca400de..9303687e38a8 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -471,9 +471,6 @@ int ufshcd_mcq_init(struct ufs_hba *hba)
 		mutex_init(&hwq->sq_mutex);
 	}
=20
-	/* The very first HW queue serves device commands */
-	hba->dev_cmd_queue =3D &hba->uhq[0];
-
 	host->host_tagset =3D 1;
 	return 0;
 }
@@ -528,6 +525,7 @@ int ufshcd_mcq_sq_cleanup(struct ufs_hba *hba, int ta=
sk_tag)
 {
 	struct scsi_cmnd *cmd =3D ufshcd_tag_to_cmd(hba, task_tag);
 	struct ufshcd_lrb *lrbp =3D scsi_cmd_priv(cmd);
+	struct request *rq =3D scsi_cmd_to_rq(cmd);
 	struct ufs_hw_queue *hwq;
 	void __iomem *reg, *opr_sqd_base;
 	u32 nexus, id, val;
@@ -536,15 +534,12 @@ int ufshcd_mcq_sq_cleanup(struct ufs_hba *hba, int =
task_tag)
 	if (hba->quirks & UFSHCD_QUIRK_MCQ_BROKEN_RTC)
 		return -ETIMEDOUT;
=20
-	if (task_tag !=3D hba->reserved_slot) {
-		if (!cmd)
-			return -EINVAL;
-		hwq =3D ufshcd_mcq_req_to_hwq(hba, scsi_cmd_to_rq(cmd));
-		if (!hwq)
-			return 0;
-	} else {
-		hwq =3D hba->dev_cmd_queue;
-	}
+	if (!cmd)
+		return -EINVAL;
+
+	hwq =3D ufshcd_mcq_req_to_hwq(hba, rq);
+	if (!hwq)
+		return 0;
=20
 	id =3D hwq->id;
=20
diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-pri=
v.h
index 3222c4d3ceb4..35c3277a4373 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -367,30 +367,7 @@ static inline bool ufs_is_valid_unit_desc_lun(struct=
 ufs_dev_info *dev_info, u8
 static inline struct scsi_cmnd *ufshcd_tag_to_cmd(struct ufs_hba *hba, u=
32 tag)
 {
 	struct blk_mq_tags *tags =3D hba->host->tag_set.shared_tags;
-	struct request *rq;
-
-	/*
-	 * Handle reserved tags differently because the UFS driver does not
-	 * call blk_mq_alloc_request() for allocating reserved requests.
-	 * Allocating reserved tags with blk_mq_alloc_request() would require
-	 * the following:
-	 * - Allocate an additional request queue from &hba->host->tag_set for
-	 *   allocating reserved requests from.
-	 * - For that request queue, allocate a SCSI device.
-	 * - Calling blk_mq_alloc_request(hba->dev_mgmt_queue, REQ_OP_DRV_OUT,
-	 *   BLK_MQ_REQ_RESERVED) for allocating a reserved request and
-	 *   blk_mq_free_request() for freeing reserved requests.
-	 * - Set the .device pointer for these reserved requests.
-	 * - Submit reserved requests with blk_execute_rq().
-	 * - Modify ufshcd_queuecommand() such that it handles reserved request=
s
-	 *   in another way than SCSI requests.
-	 * - Modify ufshcd_compl_one_cqe() such that it calls scsi_done() for
-	 *   device management commands.
-	 * - Modify all callback functions called by blk_mq_tagset_busy_iter()
-	 *   calls in the UFS driver and skip device management commands.
-	 */
-	rq =3D tag < UFSHCD_NUM_RESERVED ? tags->static_rqs[tag] :
-					 blk_mq_tag_to_rq(tags, tag);
+	struct request *rq =3D blk_mq_tag_to_rq(tags, tag);
=20
 	if (WARN_ON_ONCE(!rq))
 		return NULL;
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index b6ee8bfbb718..c7206de67c73 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -2355,7 +2355,7 @@ static void ufshcd_update_monitor(struct ufs_hba *h=
ba, struct scsi_cmnd *cmd)
  */
 static bool ufshcd_is_scsi_cmd(struct scsi_cmnd *cmd)
 {
-	return blk_mq_request_started(scsi_cmd_to_rq(cmd));
+	return !blk_mq_is_reserved_rq(scsi_cmd_to_rq(cmd));
 }
=20
 /**
@@ -2486,7 +2486,6 @@ static inline int ufshcd_hba_capabilities(struct uf=
s_hba *hba)
 	hba->nutrs =3D (hba->capabilities & MASK_TRANSFER_REQUESTS_SLOTS_SDB) +=
 1;
 	hba->nutmrs =3D
 	((hba->capabilities & MASK_TASK_MANAGEMENT_REQUEST_SLOTS) >> 16) + 1;
-	hba->reserved_slot =3D 0;
=20
 	hba->nortt =3D FIELD_GET(MASK_NUMBER_OUTSTANDING_RTT, hba->capabilities=
) + 1;
=20
@@ -3114,6 +3113,20 @@ static int ufshcd_queuecommand(struct Scsi_Host *h=
ost, struct scsi_cmnd *cmd)
 	return err;
 }
=20
+static int ufshcd_queue_reserved_command(struct Scsi_Host *host,
+					 struct scsi_cmnd *cmd)
+{
+	struct ufshcd_lrb *lrbp =3D scsi_cmd_priv(cmd);
+	struct request *rq =3D scsi_cmd_to_rq(cmd);
+	struct ufs_hba *hba =3D shost_priv(host);
+	struct ufs_hw_queue *hwq =3D
+		hba->mcq_enabled ? ufshcd_mcq_req_to_hwq(hba, rq) : NULL;
+
+	ufshcd_add_query_upiu_trace(hba, UFS_QUERY_SEND, lrbp->ucd_req_ptr);
+	ufshcd_send_command(hba, cmd, hwq);
+	return 0;
+}
+
 static void ufshcd_setup_dev_cmd(struct ufs_hba *hba, struct scsi_cmnd *=
cmd,
 				 enum dev_cmd_type cmd_type, u8 lun, int tag)
 {
@@ -3243,84 +3256,6 @@ ufshcd_dev_cmd_completion(struct ufs_hba *hba, str=
uct ufshcd_lrb *lrbp)
 	return err;
 }
=20
-/*
- * Return: 0 upon success; < 0 upon failure.
- */
-static int ufshcd_wait_for_dev_cmd(struct ufs_hba *hba,
-		struct ufshcd_lrb *lrbp, int max_timeout)
-{
-	struct scsi_cmnd *cmd =3D (struct scsi_cmnd *)lrbp - 1;
-	const int tag =3D scsi_cmd_to_rq(cmd)->tag;
-	unsigned long time_left =3D msecs_to_jiffies(max_timeout);
-	unsigned long flags;
-	bool pending;
-	int err;
-
-retry:
-	time_left =3D wait_for_completion_timeout(&hba->dev_cmd.complete,
-						time_left);
-
-	if (likely(time_left)) {
-		err =3D ufshcd_get_tr_ocs(lrbp, NULL);
-	} else {
-		err =3D -ETIMEDOUT;
-		dev_dbg(hba->dev, "%s: dev_cmd request timedout, tag %d\n",
-			__func__, tag);
-
-		/* MCQ mode */
-		if (hba->mcq_enabled) {
-			/* successfully cleared the command, retry if needed */
-			if (ufshcd_clear_cmd(hba, tag) =3D=3D 0)
-				err =3D -EAGAIN;
-			return err;
-		}
-
-		/* SDB mode */
-		if (ufshcd_clear_cmd(hba, tag) =3D=3D 0) {
-			/* successfully cleared the command, retry if needed */
-			err =3D -EAGAIN;
-			/*
-			 * Since clearing the command succeeded we also need to
-			 * clear the task tag bit from the outstanding_reqs
-			 * variable.
-			 */
-			spin_lock_irqsave(&hba->outstanding_lock, flags);
-			pending =3D test_bit(tag, &hba->outstanding_reqs);
-			if (pending)
-				__clear_bit(tag, &hba->outstanding_reqs);
-			spin_unlock_irqrestore(&hba->outstanding_lock, flags);
-
-			if (!pending) {
-				/*
-				 * The completion handler ran while we tried to
-				 * clear the command.
-				 */
-				time_left =3D 1;
-				goto retry;
-			}
-		} else {
-			dev_err(hba->dev, "%s: failed to clear tag %d\n",
-				__func__, tag);
-
-			spin_lock_irqsave(&hba->outstanding_lock, flags);
-			pending =3D test_bit(tag, &hba->outstanding_reqs);
-			spin_unlock_irqrestore(&hba->outstanding_lock, flags);
-
-			if (!pending) {
-				/*
-				 * The completion handler ran while we tried to
-				 * clear the command.
-				 */
-				time_left =3D 1;
-				goto retry;
-			}
-		}
-	}
-
-	WARN_ONCE(err > 0, "Incorrect return value %d > 0\n", err);
-	return err;
-}
-
 static void ufshcd_dev_man_lock(struct ufs_hba *hba)
 {
 	ufshcd_hold(hba);
@@ -3335,23 +3270,45 @@ static void ufshcd_dev_man_unlock(struct ufs_hba =
*hba)
 	ufshcd_release(hba);
 }
=20
+static struct scsi_cmnd *ufshcd_get_dev_mgmt_cmd(struct ufs_hba *hba)
+{
+	/*
+	 * The caller must hold this lock to guarantee that the NOWAIT
+	 * allocation will succeed.
+	 */
+	lockdep_assert_held(&hba->dev_cmd.lock);
+
+	/*
+	 * Allocate from hardware queue 0 instead of the hardware queue
+	 * corresponding to the current CPU because some UFSHCI controllers
+	 * only support hardware queue 0 for device management commands.
+	 */
+	return scsi_get_internal_cmd_hctx(
+		hba->host->pseudo_sdev, DMA_TO_DEVICE,
+		BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT, 0);
+}
+
+static void ufshcd_put_dev_mgmt_cmd(struct scsi_cmnd *cmd)
+{
+	scsi_put_internal_cmd(cmd);
+}
+
 /*
- * Return: 0 upon success; < 0 upon failure.
+ * Return: 0 upon success; < 0 upon timeout; > 0 in case the UFS device
+ * reported an OCS error.
  */
 static int ufshcd_issue_dev_cmd(struct ufs_hba *hba, struct scsi_cmnd *c=
md,
 				const u32 tag, int timeout)
 {
 	struct ufshcd_lrb *lrbp =3D scsi_cmd_priv(cmd);
-	int err;
-
-	ufshcd_add_query_upiu_trace(hba, UFS_QUERY_SEND, lrbp->ucd_req_ptr);
-	ufshcd_send_command(hba, cmd, hba->dev_cmd_queue);
-	err =3D ufshcd_wait_for_dev_cmd(hba, lrbp, timeout);
-
-	ufshcd_add_query_upiu_trace(hba, err ? UFS_QUERY_ERR : UFS_QUERY_COMP,
-				    (struct utp_upiu_req *)lrbp->ucd_rsp_ptr);
+	struct request *rq =3D scsi_cmd_to_rq(cmd);
+	blk_status_t sts;
=20
-	return err;
+	rq->timeout =3D timeout;
+	sts =3D blk_execute_rq(rq, true);
+	if (sts !=3D BLK_STS_OK)
+		return blk_status_to_errno(sts);
+	return lrbp->utr_descriptor_ptr->header.ocs;
 }
=20
 /**
@@ -3360,7 +3317,8 @@ static int ufshcd_issue_dev_cmd(struct ufs_hba *hba=
, struct scsi_cmnd *cmd,
  * @cmd_type: specifies the type (NOP, Query...)
  * @timeout: timeout in milliseconds
  *
- * Return: 0 upon success; < 0 upon failure.
+ * Return: 0 upon success; < 0 upon timeout; > 0 in case the UFS device
+ * reported an OCS error.
  *
  * NOTE: Since there is only one available tag for device management com=
mands,
  * it is expected you hold the hba->dev_cmd.lock mutex.
@@ -3368,23 +3326,31 @@ static int ufshcd_issue_dev_cmd(struct ufs_hba *h=
ba, struct scsi_cmnd *cmd,
 static int ufshcd_exec_dev_cmd(struct ufs_hba *hba,
 		enum dev_cmd_type cmd_type, int timeout)
 {
-	const u32 tag =3D hba->reserved_slot;
-	struct scsi_cmnd *cmd =3D ufshcd_tag_to_cmd(hba, tag);
+	struct scsi_cmnd *cmd =3D ufshcd_get_dev_mgmt_cmd(hba);
 	struct ufshcd_lrb *lrbp =3D scsi_cmd_priv(cmd);
+	u32 tag;
 	int err;
=20
-	/* Protects use of hba->reserved_slot. */
+	/* Protects use of hba->dev_cmd. */
 	lockdep_assert_held(&hba->dev_cmd.lock);
=20
+	if (WARN_ON_ONCE(!cmd))
+		return -ENOMEM;
+
+	tag =3D scsi_cmd_to_rq(cmd)->tag;
+
 	err =3D ufshcd_compose_dev_cmd(hba, cmd, cmd_type, tag);
 	if (unlikely(err))
-		return err;
+		goto out;
=20
 	err =3D ufshcd_issue_dev_cmd(hba, cmd, tag, timeout);
-	if (err)
-		return err;
+	if (err =3D=3D 0)
+		err =3D ufshcd_dev_cmd_completion(hba, lrbp);
+
+out:
+	ufshcd_put_dev_mgmt_cmd(cmd);
=20
-	return ufshcd_dev_cmd_completion(hba, lrbp);
+	return err;
 }
=20
 /**
@@ -5649,6 +5615,10 @@ void ufshcd_compl_one_cqe(struct ufs_hba *hba, int=
 task_tag,
 	struct ufshcd_lrb *lrbp =3D scsi_cmd_priv(cmd);
 	enum utp_ocs ocs;
=20
+	if (WARN_ONCE(!cmd, "cqe->command_desc_base_addr =3D %#llx\n",
+		      le64_to_cpu(cqe->command_desc_base_addr)))
+		return;
+
 	if (hba->monitor.enabled) {
 		lrbp->compl_time_stamp =3D ktime_get();
 		lrbp->compl_time_stamp_local_clock =3D local_clock();
@@ -5659,15 +5629,21 @@ void ufshcd_compl_one_cqe(struct ufs_hba *hba, in=
t task_tag,
 		ufshcd_add_command_trace(hba, cmd, UFS_CMD_COMP);
 		cmd->result =3D ufshcd_transfer_rsp_status(hba, cmd, cqe);
 		ufshcd_release_scsi_cmd(hba, cmd);
-		/* Do not touch lrbp after scsi done */
-		scsi_done(cmd);
 	} else {
 		if (cqe) {
 			ocs =3D le32_to_cpu(cqe->status) & MASK_OCS;
 			lrbp->utr_descriptor_ptr->header.ocs =3D ocs;
+		} else {
+			ocs =3D lrbp->utr_descriptor_ptr->header.ocs;
 		}
-		complete(&hba->dev_cmd.complete);
+		ufshcd_add_query_upiu_trace(
+			hba,
+			ocs =3D=3D OCS_SUCCESS ? UFS_QUERY_COMP : UFS_QUERY_ERR,
+			(struct utp_upiu_req *)lrbp->ucd_rsp_ptr);
+		cmd->result =3D 0;
 	}
+	/* Do not touch lrbp after scsi_done() has been called. */
+	scsi_done(cmd);
 }
=20
 /**
@@ -7358,15 +7334,20 @@ static int ufshcd_issue_devman_upiu_cmd(struct uf=
s_hba *hba,
 					enum dev_cmd_type cmd_type,
 					enum query_opcode desc_op)
 {
-	const u32 tag =3D hba->reserved_slot;
-	struct scsi_cmnd *cmd =3D ufshcd_tag_to_cmd(hba, tag);
+	struct scsi_cmnd *cmd =3D ufshcd_get_dev_mgmt_cmd(hba);
 	struct ufshcd_lrb *lrbp =3D scsi_cmd_priv(cmd);
+	u32 tag;
 	int err =3D 0;
 	u8 upiu_flags;
=20
-	/* Protects use of hba->reserved_slot. */
+	/* Protects use of hba->dev_cmd. */
 	lockdep_assert_held(&hba->dev_cmd.lock);
=20
+	if (WARN_ON_ONCE(!cmd))
+		return -ENOMEM;
+
+	tag =3D scsi_cmd_to_rq(cmd)->tag;
+
 	ufshcd_setup_dev_cmd(hba, cmd, cmd_type, 0, tag);
=20
 	ufshcd_prepare_req_desc_hdr(hba, lrbp, &upiu_flags, DMA_NONE, 0);
@@ -7410,6 +7391,8 @@ static int ufshcd_issue_devman_upiu_cmd(struct ufs_=
hba *hba,
 		}
 	}
=20
+	ufshcd_put_dev_mgmt_cmd(cmd);
+
 	return err;
 }
=20
@@ -7502,9 +7485,9 @@ int ufshcd_advanced_rpmb_req_handler(struct ufs_hba=
 *hba, struct utp_upiu_req *r
 			 struct ufs_ehs *rsp_ehs, int sg_cnt, struct scatterlist *sg_list,
 			 enum dma_data_direction dir)
 {
-	const u32 tag =3D hba->reserved_slot;
-	struct scsi_cmnd *cmd =3D ufshcd_tag_to_cmd(hba, tag);
-	struct ufshcd_lrb *lrbp =3D scsi_cmd_priv(cmd);
+	struct scsi_cmnd *cmd;
+	struct ufshcd_lrb *lrbp;
+	u32 tag;
 	int err =3D 0;
 	int result;
 	u8 upiu_flags;
@@ -7512,9 +7495,18 @@ int ufshcd_advanced_rpmb_req_handler(struct ufs_hb=
a *hba, struct utp_upiu_req *r
 	u16 ehs_len;
 	int ehs =3D (hba->capabilities & MASK_EHSLUTRD_SUPPORTED) ? 2 : 0;
=20
-	/* Protects use of hba->reserved_slot. */
 	ufshcd_dev_man_lock(hba);
=20
+	cmd =3D ufshcd_get_dev_mgmt_cmd(hba);
+
+	if (WARN_ON_ONCE(!cmd)) {
+		ufshcd_dev_man_unlock(hba);
+		return -ENOMEM;
+	}
+
+	lrbp =3D scsi_cmd_priv(cmd);
+	tag =3D scsi_cmd_to_rq(cmd)->tag;
+
 	ufshcd_setup_dev_cmd(hba, cmd, DEV_CMD_TYPE_RPMB, UFS_UPIU_RPMB_WLUN,
 			     tag);
=20
@@ -7561,6 +7553,8 @@ int ufshcd_advanced_rpmb_req_handler(struct ufs_hba=
 *hba, struct utp_upiu_req *r
 		}
 	}
=20
+	ufshcd_put_dev_mgmt_cmd(cmd);
+
 	ufshcd_dev_man_unlock(hba);
=20
 	return err ? : result;
@@ -7731,7 +7725,8 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 {
 	struct Scsi_Host *host =3D cmd->device->host;
 	struct ufs_hba *hba =3D shost_priv(host);
-	int tag =3D scsi_cmd_to_rq(cmd)->tag;
+	struct request *rq =3D scsi_cmd_to_rq(cmd);
+	int tag =3D rq->tag;
 	struct ufshcd_lrb *lrbp =3D scsi_cmd_priv(cmd);
 	unsigned long flags;
 	int err =3D FAILED;
@@ -7761,7 +7756,8 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 	 * to reduce repeated printouts. For other aborted requests only print
 	 * basic details.
 	 */
-	scsi_print_command(cmd);
+	if (ufshcd_is_scsi_cmd(cmd))
+		scsi_print_command(cmd);
 	if (!hba->req_abort_count) {
 		ufshcd_update_evt_hist(hba, UFS_EVT_ABORT, tag);
 		ufshcd_print_evt_hist(hba);
@@ -7813,7 +7809,10 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 		goto release;
 	}
=20
-	err =3D ufshcd_try_to_abort_task(hba, tag);
+	if (blk_mq_is_reserved_rq(rq))
+		err =3D ufshcd_clear_cmd(hba, tag);
+	else
+		err =3D ufshcd_try_to_abort_task(hba, tag);
 	if (err) {
 		dev_err(hba->dev, "%s: failed with err %d\n", __func__, err);
 		ufshcd_set_req_abort_skip(hba, hba->outstanding_reqs);
@@ -9186,6 +9185,7 @@ static const struct scsi_host_template ufshcd_drive=
r_template =3D {
 	.cmd_size		=3D sizeof(struct ufshcd_lrb),
 	.init_cmd_priv		=3D ufshcd_init_cmd_priv,
 	.queuecommand		=3D ufshcd_queuecommand,
+	.queue_reserved_command	=3D ufshcd_queue_reserved_command,
 	.mq_poll		=3D ufshcd_poll,
 	.sdev_init		=3D ufshcd_sdev_init,
 	.sdev_configure		=3D ufshcd_sdev_configure,
@@ -10728,8 +10728,6 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem=
 *mmio_base, unsigned int irq)
 						UFS_SLEEP_PWR_MODE,
 						UIC_LINK_HIBERN8_STATE);
=20
-	init_completion(&hba->dev_cmd.complete);
-
 	err =3D ufshcd_hba_init(hba);
 	if (err)
 		goto out_error;
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 9eb69241e40f..e07834509182 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -236,13 +236,11 @@ struct ufs_query {
  * struct ufs_dev_cmd - all assosiated fields with device management com=
mands
  * @type: device management command type - Query, NOP OUT
  * @lock: lock to allow one command at a time
- * @complete: internal commands completion
  * @query: Device management query information
  */
 struct ufs_dev_cmd {
 	enum dev_cmd_type type;
 	struct mutex lock;
-	struct completion complete;
 	struct ufs_query query;
 };
=20
@@ -838,7 +836,6 @@ enum ufshcd_mcq_opr {
  * @nutrs: Transfer Request Queue depth supported by controller
  * @nortt - Max outstanding RTTs supported by controller
  * @nutmrs: Task Management Queue depth supported by controller
- * @reserved_slot: Used to submit device commands. Protected by @dev_cmd=
.lock.
  * @ufs_version: UFS Version to which controller complies
  * @vops: pointer to variant specific operations
  * @vps: pointer to variant specific parameters
@@ -929,7 +926,6 @@ enum ufshcd_mcq_opr {
  * @res: array of resource info of MCQ registers
  * @mcq_base: Multi circular queue registers base address
  * @uhq: array of supported hardware queues
- * @dev_cmd_queue: Queue for issuing device management commands
  * @mcq_opr: MCQ operation and runtime registers
  * @ufs_rtc_update_work: A work for UFS RTC periodic update
  * @pm_qos_req: PM QoS request handle
@@ -980,7 +976,6 @@ struct ufs_hba {
 	int nortt;
 	u32 mcq_capabilities;
 	int nutmrs;
-	u32 reserved_slot;
 	u32 ufs_version;
 	const struct ufs_hba_variant_ops *vops;
 	struct ufs_hba_variant_params *vps;
@@ -1098,7 +1093,6 @@ struct ufs_hba {
 	bool mcq_esi_enabled;
 	void __iomem *mcq_base;
 	struct ufs_hw_queue *uhq;
-	struct ufs_hw_queue *dev_cmd_queue;
 	struct ufshcd_mcq_opr_info_t mcq_opr[OPR_MAX];
=20
 	struct delayed_work ufs_rtc_update_work;

