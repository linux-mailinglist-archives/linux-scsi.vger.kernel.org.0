Return-Path: <linux-scsi+bounces-17538-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A874B9C1C3
	for <lists+linux-scsi@lfdr.de>; Wed, 24 Sep 2025 22:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 669671BC3701
	for <lists+linux-scsi@lfdr.de>; Wed, 24 Sep 2025 20:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0741F2B88;
	Wed, 24 Sep 2025 20:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="sSU45ybK"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FE4329F3A
	for <linux-scsi@vger.kernel.org>; Wed, 24 Sep 2025 20:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758746113; cv=none; b=HMPORKcDC40iMnb3LuFImRw68827fNaRSFZ+jBsfXeEWMVQ2VvMDyNvH4+tZiEezeb7Z5IEp5nQljdsjJPXqK2xrEoOBN9VcJ05WxBMwi55bHwDwts9lEtUu6qhYK920V/oMvPIQAeafYlRJmjarem3Ip2H01924CJa0UVZvgEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758746113; c=relaxed/simple;
	bh=v20HWfVlX8b9Mn+GW2sgn7DHANQk45M8d57NWGVlVt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fLv+ssc4q8I6BqkmF84uwuFBuv+gC0Yk+/hEy1S5F10NUczSuZEhMM+JmpX8teYB1OLNapgNaboFhRfPJ34OM4NBKUpitbKWXbkpM8niEofQfZ0x4++YbDefPavdVi+uID98v5VQjFLuqGuSnVGzn0uoXLAw5ulHMbUbljUpMXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=sSU45ybK; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4cX7rb3Z0bzlgqVB;
	Wed, 24 Sep 2025 20:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1758746108; x=1761338109; bh=C/JDG
	cI2wEtE9rSWKSFL6dvpKeh06bIeu3XJupHwrV8=; b=sSU45ybK/k4kuhxajhUNw
	2GE15ae0vWye1nezYTppYL1RExpShYfzbV90U5KRDMBIOlouuqdp7jL38phoaC9l
	BkQ+4ZG2hLi7VNqt0Af2W5CYqfn9JqSmCj0uVYvbi50giyzVwNf6v0ZM+LB5kuir
	RwolKLgYLxrEbEFnyUWO02FMHVx11o3wcOXmtxwIUQE3/2TL5gjtB6qf+dIoaXAN
	ux0Qmgcj5dsoKWCKZOgSgiTMmOJtyXtnFu8tUwAPPTE4sJn7K8MUQEvqe8jTAOq4
	CvkoJ1bvAltZ24o/pxwIzWhyKA9qTf9nZh7dn4GXk9i8mvyG7vRLcKd/dvDXg6wr
	Q==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 3vCi-kNUnwFE; Wed, 24 Sep 2025 20:35:08 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4cX7rN5Xx2zlgqTr;
	Wed, 24 Sep 2025 20:35:00 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Peter Wang <peter.wang@mediatek.com>,
	Avri Altman <avri.altman@sandisk.com>,
	Bean Huo <beanhuo@micron.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Can Guo <quic_cang@quicinc.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Nitin Rawat <quic_nitirawa@quicinc.com>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v5 25/28] ufs: core: Remove the ufshcd_lrb task_tag member
Date: Wed, 24 Sep 2025 13:30:44 -0700
Message-ID: <20250924203142.4073403-26-bvanassche@acm.org>
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

Remove the ufshcd_lrb task_tag member and use scsi_cmd_to_rq(cmd)->tag
instead. Use rq->tag instead of lrbp->task_tag. This patch reduces the
size of struct ufshcd_lrb.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/ufs/core/ufshcd.c | 62 +++++++++++++++++++--------------------
 include/ufs/ufshcd.h      |  1 -
 2 files changed, 30 insertions(+), 33 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 02e3e4c4bf3e..7193505c030d 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -604,7 +604,7 @@ static void ufshcd_print_tr(struct ufs_hba *hba, stru=
ct scsi_cmnd *cmd,
 			    bool pr_prdt)
 {
 	struct ufshcd_lrb *lrbp =3D scsi_cmd_priv(cmd);
-	const int tag =3D lrbp->task_tag;
+	const int tag =3D scsi_cmd_to_rq(cmd)->tag;
 	int prdt_length;
=20
 	if (hba->monitor.enabled) {
@@ -2368,6 +2368,7 @@ static inline void ufshcd_send_command(struct ufs_h=
ba *hba,
 				       struct ufs_hw_queue *hwq)
 {
 	struct ufshcd_lrb *lrbp =3D scsi_cmd_priv(cmd);
+	const int tag =3D scsi_cmd_to_rq(cmd)->tag;
 	unsigned long flags;
=20
 	if (hba->monitor.enabled) {
@@ -2396,11 +2397,10 @@ static inline void ufshcd_send_command(struct ufs=
_hba *hba,
 	} else {
 		spin_lock_irqsave(&hba->outstanding_lock, flags);
 		if (hba->vops && hba->vops->setup_xfer_req)
-			hba->vops->setup_xfer_req(hba, lrbp->task_tag,
+			hba->vops->setup_xfer_req(hba, tag,
 						  ufshcd_is_scsi_cmd(cmd));
-		__set_bit(lrbp->task_tag, &hba->outstanding_reqs);
-		ufshcd_writel(hba, 1 << lrbp->task_tag,
-			      REG_UTP_TRANSFER_REQ_DOOR_BELL);
+		__set_bit(tag, &hba->outstanding_reqs);
+		ufshcd_writel(hba, 1 << tag, REG_UTP_TRANSFER_REQ_DOOR_BELL);
 		spin_unlock_irqrestore(&hba->outstanding_lock, flags);
 	}
 }
@@ -2797,6 +2797,7 @@ static void ufshcd_prepare_utp_scsi_cmd_upiu(struct=
 scsi_cmnd *cmd,
 					     u8 upiu_flags)
 {
 	struct ufshcd_lrb *lrbp =3D scsi_cmd_priv(cmd);
+	const int tag =3D scsi_cmd_to_rq(cmd)->tag;
 	struct utp_upiu_req *ucd_req_ptr =3D lrbp->ucd_req_ptr;
 	unsigned short cdb_len;
=20
@@ -2804,11 +2805,11 @@ static void ufshcd_prepare_utp_scsi_cmd_upiu(stru=
ct scsi_cmnd *cmd,
 		.transaction_code =3D UPIU_TRANSACTION_COMMAND,
 		.flags =3D upiu_flags,
 		.lun =3D lrbp->lun,
-		.task_tag =3D lrbp->task_tag,
+		.task_tag =3D tag,
 		.command_set_type =3D UPIU_COMMAND_SET_TYPE_SCSI,
 	};
=20
-	WARN_ON_ONCE(ucd_req_ptr->header.task_tag !=3D lrbp->task_tag);
+	WARN_ON_ONCE(ucd_req_ptr->header.task_tag !=3D tag);
=20
 	ucd_req_ptr->sc.exp_data_transfer_len =3D cpu_to_be32(cmd->sdb.length);
=20
@@ -2829,6 +2830,7 @@ static void ufshcd_prepare_utp_query_req_upiu(struc=
t ufs_hba *hba,
 {
 	struct ufshcd_lrb *lrbp =3D scsi_cmd_priv(cmd);
 	struct utp_upiu_req *ucd_req_ptr =3D lrbp->ucd_req_ptr;
+	const int tag =3D scsi_cmd_to_rq(cmd)->tag;
 	struct ufs_query *query =3D &hba->dev_cmd.query;
 	u16 len =3D be16_to_cpu(query->request.upiu_req.length);
=20
@@ -2837,7 +2839,7 @@ static void ufshcd_prepare_utp_query_req_upiu(struc=
t ufs_hba *hba,
 		.transaction_code =3D UPIU_TRANSACTION_QUERY_REQ,
 		.flags =3D upiu_flags,
 		.lun =3D lrbp->lun,
-		.task_tag =3D lrbp->task_tag,
+		.task_tag =3D tag,
 		.query_function =3D query->request.query_func,
 		/* Data segment length only need for WRITE_DESC */
 		.data_segment_length =3D
@@ -2860,12 +2862,13 @@ static inline void ufshcd_prepare_utp_nop_upiu(st=
ruct scsi_cmnd *cmd)
 {
 	struct ufshcd_lrb *lrbp =3D scsi_cmd_priv(cmd);
 	struct utp_upiu_req *ucd_req_ptr =3D lrbp->ucd_req_ptr;
+	const int tag =3D scsi_cmd_to_rq(cmd)->tag;
=20
 	memset(ucd_req_ptr, 0, sizeof(struct utp_upiu_req));
=20
 	ucd_req_ptr->header =3D (struct utp_upiu_header){
 		.transaction_code =3D UPIU_TRANSACTION_NOP_OUT,
-		.task_tag =3D lrbp->task_tag,
+		.task_tag =3D tag,
 	};
 }
=20
@@ -2950,7 +2953,6 @@ static void __ufshcd_setup_cmd(struct ufs_hba *hba,=
 struct scsi_cmnd *cmd,
=20
 	memset(lrbp->ucd_req_ptr, 0, sizeof(*lrbp->ucd_req_ptr));
=20
-	lrbp->task_tag =3D tag;
 	lrbp->lun =3D lun;
 	ufshcd_prepare_lrbp_crypto(cmd ? scsi_cmd_to_rq(cmd) : NULL, lrbp);
 }
@@ -3246,6 +3248,8 @@ ufshcd_dev_cmd_completion(struct ufs_hba *hba, stru=
ct ufshcd_lrb *lrbp)
 static int ufshcd_wait_for_dev_cmd(struct ufs_hba *hba,
 		struct ufshcd_lrb *lrbp, int max_timeout)
 {
+	struct scsi_cmnd *cmd =3D (struct scsi_cmnd *)lrbp - 1;
+	const int tag =3D scsi_cmd_to_rq(cmd)->tag;
 	unsigned long time_left =3D msecs_to_jiffies(max_timeout);
 	unsigned long flags;
 	bool pending;
@@ -3262,18 +3266,18 @@ static int ufshcd_wait_for_dev_cmd(struct ufs_hba=
 *hba,
 	} else {
 		err =3D -ETIMEDOUT;
 		dev_dbg(hba->dev, "%s: dev_cmd request timedout, tag %d\n",
-			__func__, lrbp->task_tag);
+			__func__, tag);
=20
 		/* MCQ mode */
 		if (hba->mcq_enabled) {
 			/* successfully cleared the command, retry if needed */
-			if (ufshcd_clear_cmd(hba, lrbp->task_tag) =3D=3D 0)
+			if (ufshcd_clear_cmd(hba, tag) =3D=3D 0)
 				err =3D -EAGAIN;
 			return err;
 		}
=20
 		/* SDB mode */
-		if (ufshcd_clear_cmd(hba, lrbp->task_tag) =3D=3D 0) {
+		if (ufshcd_clear_cmd(hba, tag) =3D=3D 0) {
 			/* successfully cleared the command, retry if needed */
 			err =3D -EAGAIN;
 			/*
@@ -3282,11 +3286,9 @@ static int ufshcd_wait_for_dev_cmd(struct ufs_hba =
*hba,
 			 * variable.
 			 */
 			spin_lock_irqsave(&hba->outstanding_lock, flags);
-			pending =3D test_bit(lrbp->task_tag,
-					   &hba->outstanding_reqs);
+			pending =3D test_bit(tag, &hba->outstanding_reqs);
 			if (pending)
-				__clear_bit(lrbp->task_tag,
-					    &hba->outstanding_reqs);
+				__clear_bit(tag, &hba->outstanding_reqs);
 			spin_unlock_irqrestore(&hba->outstanding_lock, flags);
=20
 			if (!pending) {
@@ -3299,11 +3301,10 @@ static int ufshcd_wait_for_dev_cmd(struct ufs_hba=
 *hba,
 			}
 		} else {
 			dev_err(hba->dev, "%s: failed to clear tag %d\n",
-				__func__, lrbp->task_tag);
+				__func__, tag);
=20
 			spin_lock_irqsave(&hba->outstanding_lock, flags);
-			pending =3D test_bit(lrbp->task_tag,
-					   &hba->outstanding_reqs);
+			pending =3D test_bit(tag, &hba->outstanding_reqs);
 			spin_unlock_irqrestore(&hba->outstanding_lock, flags);
=20
 			if (!pending) {
@@ -5459,6 +5460,7 @@ static inline int ufshcd_transfer_rsp_status(struct=
 ufs_hba *hba,
 					     struct cq_entry *cqe)
 {
 	struct ufshcd_lrb *lrbp =3D scsi_cmd_priv(cmd);
+	const int tag =3D scsi_cmd_to_rq(cmd)->tag;
 	int result =3D 0;
 	int scsi_status;
 	enum utp_ocs ocs;
@@ -5530,10 +5532,8 @@ static inline int ufshcd_transfer_rsp_status(struc=
t ufs_hba *hba,
 	case OCS_ABORTED:
 	case OCS_INVALID_COMMAND_STATUS:
 		result |=3D DID_REQUEUE << 16;
-		dev_warn(hba->dev,
-				"OCS %s from controller for tag %d\n",
-				(ocs =3D=3D OCS_ABORTED ? "aborted" : "invalid"),
-				lrbp->task_tag);
+		dev_warn(hba->dev, "OCS %s from controller for tag %d\n",
+			 ocs =3D=3D OCS_ABORTED ? "aborted" : "invalid", tag);
 		break;
 	case OCS_INVALID_CMD_TABLE_ATTR:
 	case OCS_INVALID_PRDT_ATTR:
@@ -5546,9 +5546,8 @@ static inline int ufshcd_transfer_rsp_status(struct=
 ufs_hba *hba,
 	case OCS_GENERAL_CRYPTO_ERROR:
 	default:
 		result |=3D DID_ERROR << 16;
-		dev_err(hba->dev,
-				"OCS error from controller =3D %x for tag %d\n",
-				ocs, lrbp->task_tag);
+		dev_err(hba->dev, "OCS error from controller =3D %x for tag %d\n",
+			ocs, tag);
 		ufshcd_print_evt_hist(hba);
 		ufshcd_print_host_state(hba);
 		break;
@@ -7663,8 +7662,8 @@ int ufshcd_try_to_abort_task(struct ufs_hba *hba, i=
nt tag)
 	u8 resp =3D 0xF;
=20
 	for (poll_cnt =3D 100; poll_cnt; poll_cnt--) {
-		err =3D ufshcd_issue_tm_cmd(hba, lrbp->lun, lrbp->task_tag,
-				UFS_QUERY_TASK, &resp);
+		err =3D ufshcd_issue_tm_cmd(hba, lrbp->lun, tag, UFS_QUERY_TASK,
+					  &resp);
 		if (!err && resp =3D=3D UPIU_TASK_MANAGEMENT_FUNC_SUCCEEDED) {
 			/* cmd pending in the device */
 			dev_err(hba->dev, "%s: cmd pending in the device. tag =3D %d\n",
@@ -7697,8 +7696,7 @@ int ufshcd_try_to_abort_task(struct ufs_hba *hba, i=
nt tag)
 	if (!poll_cnt)
 		return -EBUSY;
=20
-	err =3D ufshcd_issue_tm_cmd(hba, lrbp->lun, lrbp->task_tag,
-			UFS_ABORT_TASK, &resp);
+	err =3D ufshcd_issue_tm_cmd(hba, lrbp->lun, tag, UFS_ABORT_TASK, &resp)=
;
 	if (err || resp !=3D UPIU_TASK_MANAGEMENT_FUNC_COMPL) {
 		if (!err) {
 			err =3D resp; /* service response error */
@@ -7808,7 +7806,7 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 		goto release;
 	}
=20
-	err =3D ufshcd_try_to_abort_task(hba, lrbp->task_tag);
+	err =3D ufshcd_try_to_abort_task(hba, tag);
 	if (err) {
 		dev_err(hba->dev, "%s: failed with err %d\n", __func__, err);
 		ufshcd_set_req_abort_skip(hba, hba->outstanding_reqs);
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 89dcac34c957..9eb69241e40f 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -188,7 +188,6 @@ struct ufshcd_lrb {
 	int scsi_status;
=20
 	int command_type;
-	int task_tag;
 	u8 lun; /* UPIU LUN id field is only 8-bit wide */
 	bool intr_cmd;
 	bool req_abort_skip;

