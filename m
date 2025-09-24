Return-Path: <linux-scsi+bounces-17536-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5415EB9C1B9
	for <lists+linux-scsi@lfdr.de>; Wed, 24 Sep 2025 22:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C95471BC0CEE
	for <lists+linux-scsi@lfdr.de>; Wed, 24 Sep 2025 20:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549782A1BF;
	Wed, 24 Sep 2025 20:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="S0ryNfeM"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C17A263F2D
	for <linux-scsi@vger.kernel.org>; Wed, 24 Sep 2025 20:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758746097; cv=none; b=gM26mvl6hWSL0uV+eR2mRNH1nexL8YoOhaPY/Y2lpLd3F5RTScEtuJmO2wPofJNRhCHHOn2mo0su0jBa8iPn651hRJaYVlOz9xhhQ0yIhGpuzQX5qI6ExAMxZigHljmZ49H1sIeOeXIyNoZ9rf0UggI4cTV8b15HJZroFYAdimo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758746097; c=relaxed/simple;
	bh=KJcZOREvsffeQzo6/9rgPrtt44FniGlh/5xOj30k/h8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HX1U8DUxgo8A4GskCThWUWpcP1i/1gd+6zlC7JKXIp1lTvfouzFc4v8xNO48VOfJ9wXUmkyJ33HXLttD3JrP4qyupIOOHKnH0q6Q7f070HvE0NGwBKtQ60erTbGv3qnSfKrX9/MY9erUf0c0QK+eTeLiuuA6qy6wlTfjklYlHjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=S0ryNfeM; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4cX7rF4WLDzlgqyp;
	Wed, 24 Sep 2025 20:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1758746089; x=1761338090; bh=i6cKE
	7ObYrF3hvcV2/775rA0+jG03bUUrn4Q8jkofNg=; b=S0ryNfeMjkpu4eRzyD59R
	Tly3xy4OrV8BF1QY77Mjyw0fGuMpBpQEjdJx8yPABdjlsk3ZpZcve4zuYoHvGxiB
	uaEOZo3Lm2eFnQSt00stKVc7cWIilSTi+ac54iM8C40Qwu3zapESPSg0bafmbBMY
	x4YL1fUAC1tfZOeVkNO6BatQ0AStuCKzAmsiG6+Vkq7CuS2gX5twqlmyXsD6AaDE
	a5iiUHqliQe5PTas8S7fPhNc97PrskBWwUXrVwlgUAaiVLWwd6TtRytn6b4ItyDQ
	fz7cd95Eg1YUvuvcK1ALo+FAISvE0gA4DJpV9EsJQ17neh/1Kzvb2tjzl/cejBor
	Q==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id n03u56bd9SS9; Wed, 24 Sep 2025 20:34:49 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4cX7qy21KtzlgqVP;
	Wed, 24 Sep 2025 20:34:37 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Peter Wang <peter.wang@mediatek.com>,
	"ping.gao" <ping.gao@samsung.com>,
	"Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Chenyuan Yang <chenyuan0y@gmail.com>,
	Bean Huo <beanhuo@micron.com>,
	Can Guo <quic_cang@quicinc.com>,
	Ziqi Chen <quic_ziqichen@quicinc.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Avri Altman <avri.altman@wdc.com>,
	Nitin Rawat <quic_nitirawa@quicinc.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v5 23/28] ufs: core: Optimize the hot path
Date: Wed, 24 Sep 2025 13:30:42 -0700
Message-ID: <20250924203142.4073403-24-bvanassche@acm.org>
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

Set .cmd_size in the SCSI host template such that the SCSI core makes
struct scsi_cmnd and struct ufshcd_lrb adjacent. Convert the cmd->lrbp
and lrbp->cmd memory loads into pointer offset calculations. Remove the
data structure members that became superfluous, namely ufshcd_lrb.cmd
and ufs_hba.lrb.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/ufs/core/ufs-mcq.c       |   9 +-
 drivers/ufs/core/ufshcd-crypto.h |  18 ++-
 drivers/ufs/core/ufshcd-priv.h   |  41 +++++-
 drivers/ufs/core/ufshcd.c        | 232 ++++++++++++++++---------------
 include/ufs/ufshcd.h             |   5 -
 5 files changed, 177 insertions(+), 128 deletions(-)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 9b6674d6f21c..c6c6cca400de 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -526,8 +526,8 @@ static int ufshcd_mcq_sq_start(struct ufs_hba *hba, s=
truct ufs_hw_queue *hwq)
  */
 int ufshcd_mcq_sq_cleanup(struct ufs_hba *hba, int task_tag)
 {
-	struct ufshcd_lrb *lrbp =3D &hba->lrb[task_tag];
-	struct scsi_cmnd *cmd =3D lrbp->cmd;
+	struct scsi_cmnd *cmd =3D ufshcd_tag_to_cmd(hba, task_tag);
+	struct ufshcd_lrb *lrbp =3D scsi_cmd_priv(cmd);
 	struct ufs_hw_queue *hwq;
 	void __iomem *reg, *opr_sqd_base;
 	u32 nexus, id, val;
@@ -612,7 +612,8 @@ static void ufshcd_mcq_nullify_sqe(struct utp_transfe=
r_req_desc *utrd)
 static bool ufshcd_mcq_sqe_search(struct ufs_hba *hba,
 				  struct ufs_hw_queue *hwq, int task_tag)
 {
-	struct ufshcd_lrb *lrbp =3D &hba->lrb[task_tag];
+	struct scsi_cmnd *cmd =3D ufshcd_tag_to_cmd(hba, task_tag);
+	struct ufshcd_lrb *lrbp =3D scsi_cmd_priv(cmd);
 	struct utp_transfer_req_desc *utrd;
 	__le64  cmd_desc_base_addr;
 	bool ret =3D false;
@@ -663,7 +664,7 @@ int ufshcd_mcq_abort(struct scsi_cmnd *cmd)
 	struct Scsi_Host *host =3D cmd->device->host;
 	struct ufs_hba *hba =3D shost_priv(host);
 	int tag =3D scsi_cmd_to_rq(cmd)->tag;
-	struct ufshcd_lrb *lrbp =3D &hba->lrb[tag];
+	struct ufshcd_lrb *lrbp =3D scsi_cmd_priv(cmd);
 	struct ufs_hw_queue *hwq;
 	int err;
=20
diff --git a/drivers/ufs/core/ufshcd-crypto.h b/drivers/ufs/core/ufshcd-c=
rypto.h
index 89bb97c14c15..c148a5194378 100644
--- a/drivers/ufs/core/ufshcd-crypto.h
+++ b/drivers/ufs/core/ufshcd-crypto.h
@@ -38,10 +38,10 @@ ufshcd_prepare_req_desc_hdr_crypto(struct ufshcd_lrb =
*lrbp,
 }
=20
 static inline int ufshcd_crypto_fill_prdt(struct ufs_hba *hba,
-					  struct ufshcd_lrb *lrbp)
+					  struct scsi_cmnd *cmd)
 {
-	struct scsi_cmnd *cmd =3D lrbp->cmd;
 	const struct bio_crypt_ctx *crypt_ctx =3D scsi_cmd_to_rq(cmd)->crypt_ct=
x;
+	struct ufshcd_lrb *lrbp =3D scsi_cmd_priv(cmd);
=20
 	if (crypt_ctx && hba->vops && hba->vops->fill_crypto_prdt)
 		return hba->vops->fill_crypto_prdt(hba, crypt_ctx,
@@ -51,17 +51,19 @@ static inline int ufshcd_crypto_fill_prdt(struct ufs_=
hba *hba,
 }
=20
 static inline void ufshcd_crypto_clear_prdt(struct ufs_hba *hba,
-					    struct ufshcd_lrb *lrbp)
+					    struct scsi_cmnd *cmd)
 {
+	struct ufshcd_lrb *lrbp =3D scsi_cmd_priv(cmd);
+
 	if (!(hba->quirks & UFSHCD_QUIRK_KEYS_IN_PRDT))
 		return;
=20
-	if (!(scsi_cmd_to_rq(lrbp->cmd)->crypt_ctx))
+	if (!(scsi_cmd_to_rq(cmd)->crypt_ctx))
 		return;
=20
 	/* Zeroize the PRDT because it can contain cryptographic keys. */
 	memzero_explicit(lrbp->ucd_prdt_ptr,
-			 ufshcd_sg_entry_size(hba) * scsi_sg_count(lrbp->cmd));
+			 ufshcd_sg_entry_size(hba) * scsi_sg_count(cmd));
 }
=20
 bool ufshcd_crypto_enable(struct ufs_hba *hba);
@@ -82,13 +84,15 @@ ufshcd_prepare_req_desc_hdr_crypto(struct ufshcd_lrb =
*lrbp,
 				   struct request_desc_header *h) { }
=20
 static inline int ufshcd_crypto_fill_prdt(struct ufs_hba *hba,
-					  struct ufshcd_lrb *lrbp)
+					  struct scsi_cmnd *cmd)
 {
 	return 0;
 }
=20
 static inline void ufshcd_crypto_clear_prdt(struct ufs_hba *hba,
-					    struct ufshcd_lrb *lrbp) { }
+					    struct scsi_cmnd *cmd)
+{
+}
=20
 static inline bool ufshcd_crypto_enable(struct ufs_hba *hba)
 {
diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-pri=
v.h
index ec1bb818bc73..3222c4d3ceb4 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -75,8 +75,7 @@ bool ufshcd_cmd_inflight(struct scsi_cmnd *cmd);
 int ufshcd_mcq_sq_cleanup(struct ufs_hba *hba, int task_tag);
 int ufshcd_mcq_abort(struct scsi_cmnd *cmd);
 int ufshcd_try_to_abort_task(struct ufs_hba *hba, int tag);
-void ufshcd_release_scsi_cmd(struct ufs_hba *hba,
-			     struct ufshcd_lrb *lrbp);
+void ufshcd_release_scsi_cmd(struct ufs_hba *hba, struct scsi_cmnd *cmd)=
;
=20
 #define SD_ASCII_STD true
 #define SD_RAW false
@@ -361,6 +360,44 @@ static inline bool ufs_is_valid_unit_desc_lun(struct=
 ufs_dev_info *dev_info, u8
 	return lun =3D=3D UFS_UPIU_RPMB_WLUN || (lun < dev_info->max_lu_support=
ed);
 }
=20
+/*
+ * Convert a block layer tag into a SCSI command pointer. This function =
is
+ * called once per I/O completion path and is also called from error pat=
hs.
+ */
+static inline struct scsi_cmnd *ufshcd_tag_to_cmd(struct ufs_hba *hba, u=
32 tag)
+{
+	struct blk_mq_tags *tags =3D hba->host->tag_set.shared_tags;
+	struct request *rq;
+
+	/*
+	 * Handle reserved tags differently because the UFS driver does not
+	 * call blk_mq_alloc_request() for allocating reserved requests.
+	 * Allocating reserved tags with blk_mq_alloc_request() would require
+	 * the following:
+	 * - Allocate an additional request queue from &hba->host->tag_set for
+	 *   allocating reserved requests from.
+	 * - For that request queue, allocate a SCSI device.
+	 * - Calling blk_mq_alloc_request(hba->dev_mgmt_queue, REQ_OP_DRV_OUT,
+	 *   BLK_MQ_REQ_RESERVED) for allocating a reserved request and
+	 *   blk_mq_free_request() for freeing reserved requests.
+	 * - Set the .device pointer for these reserved requests.
+	 * - Submit reserved requests with blk_execute_rq().
+	 * - Modify ufshcd_queuecommand() such that it handles reserved request=
s
+	 *   in another way than SCSI requests.
+	 * - Modify ufshcd_compl_one_cqe() such that it calls scsi_done() for
+	 *   device management commands.
+	 * - Modify all callback functions called by blk_mq_tagset_busy_iter()
+	 *   calls in the UFS driver and skip device management commands.
+	 */
+	rq =3D tag < UFSHCD_NUM_RESERVED ? tags->static_rqs[tag] :
+					 blk_mq_tag_to_rq(tags, tag);
+
+	if (WARN_ON_ONCE(!rq))
+		return NULL;
+
+	return blk_mq_rq_to_pdu(rq);
+}
+
 static inline void ufshcd_inc_sq_tail(struct ufs_hw_queue *q)
 	__must_hold(&q->sq_lock)
 {
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index a54359289db5..76375dbcaf5d 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -28,6 +28,7 @@
 #include <scsi/scsi_dbg.h>
 #include <scsi/scsi_driver.h>
 #include <scsi/scsi_eh.h>
+#include <scsi/scsi_tcq.h>
 #include "ufshcd-priv.h"
 #include <ufs/ufs_quirks.h>
 #include <ufs/unipro.h>
@@ -488,7 +489,7 @@ static void ufshcd_add_command_trace(struct ufs_hba *=
hba, struct scsi_cmnd *cmd,
 	u32 hwq_id =3D 0;
 	struct request *rq =3D scsi_cmd_to_rq(cmd);
 	unsigned int tag =3D rq->tag;
-	struct ufshcd_lrb *lrbp =3D &hba->lrb[tag];
+	struct ufshcd_lrb *lrbp =3D scsi_cmd_priv(cmd);
 	int transfer_len =3D -1;
=20
 	/* trace UPIU also */
@@ -599,14 +600,13 @@ static void ufshcd_print_evt_hist(struct ufs_hba *h=
ba)
 	ufshcd_vops_dbg_register_dump(hba);
 }
=20
-static
-void ufshcd_print_tr(struct ufs_hba *hba, int tag, bool pr_prdt)
+static void ufshcd_print_tr(struct ufs_hba *hba, struct scsi_cmnd *cmd,
+			    bool pr_prdt)
 {
-	const struct ufshcd_lrb *lrbp;
+	struct ufshcd_lrb *lrbp =3D scsi_cmd_priv(cmd);
+	const int tag =3D lrbp->task_tag;
 	int prdt_length;
=20
-	lrbp =3D &hba->lrb[tag];
-
 	if (hba->monitor.enabled) {
 		dev_err(hba->dev, "UPIU[%d] - issue time %lld us\n", tag,
 			div_u64(lrbp->issue_time_stamp_local_clock, 1000));
@@ -649,7 +649,7 @@ static bool ufshcd_print_tr_iter(struct request *req,=
 void *priv)
 	struct Scsi_Host *shost =3D sdev->host;
 	struct ufs_hba *hba =3D shost_priv(shost);
=20
-	ufshcd_print_tr(hba, req->tag, *(bool *)priv);
+	ufshcd_print_tr(hba, blk_mq_rq_to_pdu(req), *(bool *)priv);
=20
 	return true;
 }
@@ -2297,8 +2297,7 @@ static inline bool ufshcd_should_inform_monitor(str=
uct ufs_hba *hba,
 						struct scsi_cmnd *cmd)
 {
 	const struct ufs_hba_monitor *m =3D &hba->monitor;
-	struct request *rq =3D scsi_cmd_to_rq(cmd);
-	struct ufshcd_lrb *lrbp =3D &hba->lrb[rq->tag];
+	struct ufshcd_lrb *lrbp =3D scsi_cmd_priv(cmd);
=20
 	return m->enabled &&
 	       (!m->chunk_size || m->chunk_size =3D=3D cmd->sdb.length) &&
@@ -2319,7 +2318,7 @@ static void ufshcd_start_monitor(struct ufs_hba *hb=
a, struct scsi_cmnd *cmd)
 static void ufshcd_update_monitor(struct ufs_hba *hba, struct scsi_cmnd =
*cmd)
 {
 	struct request *req =3D scsi_cmd_to_rq(cmd);
-	struct ufshcd_lrb *lrbp =3D &hba->lrb[req->tag];
+	const struct ufshcd_lrb *lrbp =3D scsi_cmd_priv(cmd);
 	int dir =3D ufshcd_monitor_opcode2dir(cmd->cmnd[0]);
 	unsigned long flags;
=20
@@ -2349,17 +2348,26 @@ static void ufshcd_update_monitor(struct ufs_hba =
*hba, struct scsi_cmnd *cmd)
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
 }
=20
+/*
+ * Returns %true if @cmd represents a SCSI command that is in flight and=
 %false
+ * if it represents a device management command.
+ */
+static bool ufshcd_is_scsi_cmd(struct scsi_cmnd *cmd)
+{
+	return blk_mq_request_started(scsi_cmd_to_rq(cmd));
+}
+
 /**
  * ufshcd_send_command - Send SCSI or device management commands
  * @hba: per adapter instance
- * @lrbp: Local reference block of SCSI command
+ * @cmd: SCSI command or device management command pointer
  * @hwq: pointer to hardware queue instance
  */
 static inline void ufshcd_send_command(struct ufs_hba *hba,
-				       struct ufshcd_lrb *lrbp,
+				       struct scsi_cmnd *cmd,
 				       struct ufs_hw_queue *hwq)
 {
-	struct scsi_cmnd *cmd =3D lrbp->cmd;
+	struct ufshcd_lrb *lrbp =3D scsi_cmd_priv(cmd);
 	unsigned long flags;
=20
 	if (hba->monitor.enabled) {
@@ -2368,7 +2376,7 @@ static inline void ufshcd_send_command(struct ufs_h=
ba *hba,
 		lrbp->compl_time_stamp =3D ktime_set(0, 0);
 		lrbp->compl_time_stamp_local_clock =3D 0;
 	}
-	if (cmd) {
+	if (ufshcd_is_scsi_cmd(cmd)) {
 		ufshcd_add_command_trace(hba, cmd, UFS_CMD_SEND);
 		ufshcd_clk_scaling_start_busy(hba);
 		if (unlikely(ufshcd_should_inform_monitor(hba, cmd)))
@@ -2388,7 +2396,8 @@ static inline void ufshcd_send_command(struct ufs_h=
ba *hba,
 	} else {
 		spin_lock_irqsave(&hba->outstanding_lock, flags);
 		if (hba->vops && hba->vops->setup_xfer_req)
-			hba->vops->setup_xfer_req(hba, lrbp->task_tag, !!cmd);
+			hba->vops->setup_xfer_req(hba, lrbp->task_tag,
+						  ufshcd_is_scsi_cmd(cmd));
 		__set_bit(lrbp->task_tag, &hba->outstanding_reqs);
 		ufshcd_writel(hba, 1 << lrbp->task_tag,
 			      REG_UTP_TRANSFER_REQ_DOOR_BELL);
@@ -2398,11 +2407,12 @@ static inline void ufshcd_send_command(struct ufs=
_hba *hba,
=20
 /**
  * ufshcd_copy_sense_data - Copy sense data in case of check condition
- * @lrbp: pointer to local reference block
+ * @cmd: SCSI command
  */
-static inline void ufshcd_copy_sense_data(struct ufshcd_lrb *lrbp)
+static inline void ufshcd_copy_sense_data(struct scsi_cmnd *cmd)
 {
-	u8 *const sense_buffer =3D lrbp->cmd->sense_buffer;
+	struct ufshcd_lrb *lrbp =3D scsi_cmd_priv(cmd);
+	u8 *const sense_buffer =3D cmd->sense_buffer;
 	u16 resp_len;
 	int len;
=20
@@ -2707,13 +2717,13 @@ static void ufshcd_sgl_to_prdt(struct ufs_hba *hb=
a, struct ufshcd_lrb *lrbp, int
 /**
  * ufshcd_map_sg - Map scatter-gather list to prdt
  * @hba: per adapter instance
- * @lrbp: pointer to local reference block
+ * @cmd: SCSI command
  *
  * Return: 0 in case of success, non-zero value in case of failure.
  */
-static int ufshcd_map_sg(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
+static int ufshcd_map_sg(struct ufs_hba *hba, struct scsi_cmnd *cmd)
 {
-	struct scsi_cmnd *cmd =3D lrbp->cmd;
+	struct ufshcd_lrb *lrbp =3D scsi_cmd_priv(cmd);
 	int sg_segments =3D scsi_dma_map(cmd);
=20
 	if (sg_segments < 0)
@@ -2721,7 +2731,7 @@ static int ufshcd_map_sg(struct ufs_hba *hba, struc=
t ufshcd_lrb *lrbp)
=20
 	ufshcd_sgl_to_prdt(hba, lrbp, sg_segments, scsi_sglist(cmd));
=20
-	return ufshcd_crypto_fill_prdt(hba, lrbp);
+	return ufshcd_crypto_fill_prdt(hba, cmd);
 }
=20
 /**
@@ -2780,13 +2790,13 @@ ufshcd_prepare_req_desc_hdr(struct ufs_hba *hba, =
struct ufshcd_lrb *lrbp,
 /**
  * ufshcd_prepare_utp_scsi_cmd_upiu() - fills the utp_transfer_req_desc,
  * for scsi commands
- * @lrbp: local reference block pointer
+ * @cmd: SCSI command
  * @upiu_flags: flags
  */
-static
-void ufshcd_prepare_utp_scsi_cmd_upiu(struct ufshcd_lrb *lrbp, u8 upiu_f=
lags)
+static void ufshcd_prepare_utp_scsi_cmd_upiu(struct scsi_cmnd *cmd,
+					     u8 upiu_flags)
 {
-	struct scsi_cmnd *cmd =3D lrbp->cmd;
+	struct ufshcd_lrb *lrbp =3D scsi_cmd_priv(cmd);
 	struct utp_upiu_req *ucd_req_ptr =3D lrbp->ucd_req_ptr;
 	unsigned short cdb_len;
=20
@@ -2889,22 +2899,25 @@ static int ufshcd_compose_devman_upiu(struct ufs_=
hba *hba,
  * ufshcd_comp_scsi_upiu - UFS Protocol Information Unit(UPIU)
  *			   for SCSI Purposes
  * @hba: per adapter instance
- * @lrbp: pointer to local reference block
+ * @cmd: SCSI command
  */
-static void ufshcd_comp_scsi_upiu(struct ufs_hba *hba, struct ufshcd_lrb=
 *lrbp)
+static void ufshcd_comp_scsi_upiu(struct ufs_hba *hba, struct scsi_cmnd =
*cmd)
 {
-	struct request *rq =3D scsi_cmd_to_rq(lrbp->cmd);
+	struct ufshcd_lrb *lrbp =3D scsi_cmd_priv(cmd);
+	struct request *rq =3D scsi_cmd_to_rq(cmd);
 	unsigned int ioprio_class =3D IOPRIO_PRIO_CLASS(req_get_ioprio(rq));
 	u8 upiu_flags;
=20
-	ufshcd_prepare_req_desc_hdr(hba, lrbp, &upiu_flags, lrbp->cmd->sc_data_=
direction, 0);
+	ufshcd_prepare_req_desc_hdr(hba, lrbp, &upiu_flags,
+				    cmd->sc_data_direction, 0);
 	if (ioprio_class =3D=3D IOPRIO_CLASS_RT)
 		upiu_flags |=3D UPIU_CMD_FLAGS_CP;
-	ufshcd_prepare_utp_scsi_cmd_upiu(lrbp, upiu_flags);
+	ufshcd_prepare_utp_scsi_cmd_upiu(cmd, upiu_flags);
 }
=20
-static void ufshcd_init_lrb(struct ufs_hba *hba, struct ufshcd_lrb *lrb,=
 int i)
+static void ufshcd_init_lrb(struct ufs_hba *hba, struct scsi_cmnd *cmd)
 {
+	const int i =3D scsi_cmd_to_rq(cmd)->tag;
 	struct utp_transfer_cmd_desc *cmd_descp =3D
 		(void *)hba->ucdl_base_addr + i * ufshcd_get_ucd_size(hba);
 	struct utp_transfer_req_desc *utrdlp =3D hba->utrdl_base_addr;
@@ -2912,6 +2925,7 @@ static void ufshcd_init_lrb(struct ufs_hba *hba, st=
ruct ufshcd_lrb *lrb, int i)
 		hba->ucdl_dma_addr + i * ufshcd_get_ucd_size(hba);
 	u16 response_offset =3D le16_to_cpu(utrdlp[i].response_upiu_offset);
 	u16 prdt_offset =3D le16_to_cpu(utrdlp[i].prd_table_offset);
+	struct ufshcd_lrb *lrb =3D scsi_cmd_priv(cmd);
=20
 	lrb->utr_descriptor_ptr =3D utrdlp + i;
 	lrb->utrd_dma_addr =3D
@@ -2924,27 +2938,30 @@ static void ufshcd_init_lrb(struct ufs_hba *hba, =
struct ufshcd_lrb *lrb, int i)
 	lrb->ucd_prdt_dma_addr =3D cmd_desc_element_addr + prdt_offset;
 }
=20
-static void __ufshcd_setup_cmd(struct ufs_hba *hba, struct ufshcd_lrb *l=
rbp,
-			       struct scsi_cmnd *cmd, u8 lun, int tag)
+static void __ufshcd_setup_cmd(struct ufs_hba *hba, struct scsi_cmnd *cm=
d,
+			       u8 lun, int tag)
 {
-	ufshcd_init_lrb(hba, lrbp, tag);
+	struct ufshcd_lrb *lrbp =3D scsi_cmd_priv(cmd);
+
+	ufshcd_init_lrb(hba, cmd);
=20
 	memset(lrbp->ucd_req_ptr, 0, sizeof(*lrbp->ucd_req_ptr));
=20
-	lrbp->cmd =3D cmd;
 	lrbp->task_tag =3D tag;
 	lrbp->lun =3D lun;
 	ufshcd_prepare_lrbp_crypto(cmd ? scsi_cmd_to_rq(cmd) : NULL, lrbp);
 }
=20
-static void ufshcd_setup_scsi_cmd(struct ufs_hba *hba, struct ufshcd_lrb=
 *lrbp,
-				  struct scsi_cmnd *cmd, u8 lun, int tag)
+static void ufshcd_setup_scsi_cmd(struct ufs_hba *hba, struct scsi_cmnd =
*cmd,
+				  u8 lun, int tag)
 {
-	__ufshcd_setup_cmd(hba, lrbp, cmd, lun, tag);
+	struct ufshcd_lrb *lrbp =3D scsi_cmd_priv(cmd);
+
+	__ufshcd_setup_cmd(hba, cmd, lun, tag);
 	lrbp->intr_cmd =3D !ufshcd_is_intr_aggr_allowed(hba);
 	lrbp->req_abort_skip =3D false;
=20
-	ufshcd_comp_scsi_upiu(hba, lrbp);
+	ufshcd_comp_scsi_upiu(hba, cmd);
 }
=20
 /**
@@ -3015,7 +3032,6 @@ static int ufshcd_queuecommand(struct Scsi_Host *ho=
st, struct scsi_cmnd *cmd)
 {
 	struct ufs_hba *hba =3D shost_priv(host);
 	int tag =3D scsi_cmd_to_rq(cmd)->tag;
-	struct ufshcd_lrb *lrbp;
 	int err =3D 0;
 	struct ufs_hw_queue *hwq =3D NULL;
=20
@@ -3066,11 +3082,10 @@ static int ufshcd_queuecommand(struct Scsi_Host *=
host, struct scsi_cmnd *cmd)
=20
 	ufshcd_hold(hba);
=20
-	lrbp =3D &hba->lrb[tag];
-
-	ufshcd_setup_scsi_cmd(hba, lrbp, cmd, ufshcd_scsi_to_upiu_lun(cmd->devi=
ce->lun), tag);
+	ufshcd_setup_scsi_cmd(hba, cmd,
+			      ufshcd_scsi_to_upiu_lun(cmd->device->lun), tag);
=20
-	err =3D ufshcd_map_sg(hba, lrbp);
+	err =3D ufshcd_map_sg(hba, cmd);
 	if (err) {
 		ufshcd_release(hba);
 		goto out;
@@ -3079,7 +3094,7 @@ static int ufshcd_queuecommand(struct Scsi_Host *ho=
st, struct scsi_cmnd *cmd)
 	if (hba->mcq_enabled)
 		hwq =3D ufshcd_mcq_req_to_hwq(hba, scsi_cmd_to_rq(cmd));
=20
-	ufshcd_send_command(hba, lrbp, hwq);
+	ufshcd_send_command(hba, cmd, hwq);
=20
 out:
 	if (ufs_trigger_eh(hba)) {
@@ -3093,10 +3108,12 @@ static int ufshcd_queuecommand(struct Scsi_Host *=
host, struct scsi_cmnd *cmd)
 	return err;
 }
=20
-static void ufshcd_setup_dev_cmd(struct ufs_hba *hba, struct ufshcd_lrb =
*lrbp,
-			     enum dev_cmd_type cmd_type, u8 lun, int tag)
+static void ufshcd_setup_dev_cmd(struct ufs_hba *hba, struct scsi_cmnd *=
cmd,
+				 enum dev_cmd_type cmd_type, u8 lun, int tag)
 {
-	__ufshcd_setup_cmd(hba, lrbp, NULL, lun, tag);
+	struct ufshcd_lrb *lrbp =3D scsi_cmd_priv(cmd);
+
+	__ufshcd_setup_cmd(hba, cmd, lun, tag);
 	lrbp->intr_cmd =3D true; /* No interrupt aggregation */
 	hba->dev_cmd.type =3D cmd_type;
 }
@@ -3104,10 +3121,12 @@ static void ufshcd_setup_dev_cmd(struct ufs_hba *=
hba, struct ufshcd_lrb *lrbp,
 /*
  * Return: 0 upon success; < 0 upon failure.
  */
-static int ufshcd_compose_dev_cmd(struct ufs_hba *hba,
-		struct ufshcd_lrb *lrbp, enum dev_cmd_type cmd_type, int tag)
+static int ufshcd_compose_dev_cmd(struct ufs_hba *hba, struct scsi_cmnd =
*cmd,
+				  enum dev_cmd_type cmd_type, int tag)
 {
-	ufshcd_setup_dev_cmd(hba, lrbp, cmd_type, 0, tag);
+	struct ufshcd_lrb *lrbp =3D scsi_cmd_priv(cmd);
+
+	ufshcd_setup_dev_cmd(hba, cmd, cmd_type, 0, tag);
=20
 	return ufshcd_compose_devman_upiu(hba, lrbp);
 }
@@ -3318,13 +3337,14 @@ static void ufshcd_dev_man_unlock(struct ufs_hba =
*hba)
 /*
  * Return: 0 upon success; < 0 upon failure.
  */
-static int ufshcd_issue_dev_cmd(struct ufs_hba *hba, struct ufshcd_lrb *=
lrbp,
-			  const u32 tag, int timeout)
+static int ufshcd_issue_dev_cmd(struct ufs_hba *hba, struct scsi_cmnd *c=
md,
+				const u32 tag, int timeout)
 {
+	struct ufshcd_lrb *lrbp =3D scsi_cmd_priv(cmd);
 	int err;
=20
 	ufshcd_add_query_upiu_trace(hba, UFS_QUERY_SEND, lrbp->ucd_req_ptr);
-	ufshcd_send_command(hba, lrbp, hba->dev_cmd_queue);
+	ufshcd_send_command(hba, cmd, hba->dev_cmd_queue);
 	err =3D ufshcd_wait_for_dev_cmd(hba, lrbp, timeout);
=20
 	ufshcd_add_query_upiu_trace(hba, err ? UFS_QUERY_ERR : UFS_QUERY_COMP,
@@ -3348,17 +3368,17 @@ static int ufshcd_exec_dev_cmd(struct ufs_hba *hb=
a,
 		enum dev_cmd_type cmd_type, int timeout)
 {
 	const u32 tag =3D hba->reserved_slot;
-	struct ufshcd_lrb *lrbp =3D &hba->lrb[tag];
+	struct scsi_cmnd *cmd =3D ufshcd_tag_to_cmd(hba, tag);
 	int err;
=20
 	/* Protects use of hba->reserved_slot. */
 	lockdep_assert_held(&hba->dev_cmd.lock);
=20
-	err =3D ufshcd_compose_dev_cmd(hba, lrbp, cmd_type, tag);
+	err =3D ufshcd_compose_dev_cmd(hba, cmd, cmd_type, tag);
 	if (unlikely(err))
 		return err;
=20
-	return ufshcd_issue_dev_cmd(hba, lrbp, tag, timeout);
+	return ufshcd_issue_dev_cmd(hba, cmd, tag, timeout);
 }
=20
 /**
@@ -3985,14 +4005,6 @@ static int ufshcd_memory_alloc(struct ufs_hba *hba=
)
 	}
=20
 skip_utmrdl:
-	/* Allocate memory for local reference block */
-	hba->lrb =3D devm_kcalloc(hba->dev,
-				hba->nutrs, sizeof(struct ufshcd_lrb),
-				GFP_KERNEL);
-	if (!hba->lrb) {
-		dev_err(hba->dev, "LRB Memory allocation failed\n");
-		goto out;
-	}
 	return 0;
 out:
 	return -ENOMEM;
@@ -5403,19 +5415,18 @@ static void ufshcd_sdev_destroy(struct scsi_devic=
e *sdev)
=20
 /**
  * ufshcd_scsi_cmd_status - Update SCSI command result based on SCSI sta=
tus
- * @lrbp: pointer to local reference block of completed command
+ * @cmd: SCSI command
  * @scsi_status: SCSI command status
  *
  * Return: value base on SCSI command status.
  */
-static inline int
-ufshcd_scsi_cmd_status(struct ufshcd_lrb *lrbp, int scsi_status)
+static inline int ufshcd_scsi_cmd_status(struct scsi_cmnd *cmd, int scsi=
_status)
 {
 	int result =3D 0;
=20
 	switch (scsi_status) {
 	case SAM_STAT_CHECK_CONDITION:
-		ufshcd_copy_sense_data(lrbp);
+		ufshcd_copy_sense_data(cmd);
 		fallthrough;
 	case SAM_STAT_GOOD:
 		result |=3D DID_OK << 16 | scsi_status;
@@ -5423,7 +5434,7 @@ ufshcd_scsi_cmd_status(struct ufshcd_lrb *lrbp, int=
 scsi_status)
 	case SAM_STAT_TASK_SET_FULL:
 	case SAM_STAT_BUSY:
 	case SAM_STAT_TASK_ABORTED:
-		ufshcd_copy_sense_data(lrbp);
+		ufshcd_copy_sense_data(cmd);
 		result |=3D scsi_status;
 		break;
 	default:
@@ -5437,15 +5448,16 @@ ufshcd_scsi_cmd_status(struct ufshcd_lrb *lrbp, i=
nt scsi_status)
 /**
  * ufshcd_transfer_rsp_status - Get overall status of the response
  * @hba: per adapter instance
- * @lrbp: pointer to local reference block of completed command
+ * @cmd: SCSI command
  * @cqe: pointer to the completion queue entry
  *
  * Return: result of the command to notify SCSI midlayer.
  */
-static inline int
-ufshcd_transfer_rsp_status(struct ufs_hba *hba, struct ufshcd_lrb *lrbp,
-			   struct cq_entry *cqe)
+static inline int ufshcd_transfer_rsp_status(struct ufs_hba *hba,
+					     struct scsi_cmnd *cmd,
+					     struct cq_entry *cqe)
 {
+	struct ufshcd_lrb *lrbp =3D scsi_cmd_priv(cmd);
 	int result =3D 0;
 	int scsi_status;
 	enum utp_ocs ocs;
@@ -5459,7 +5471,7 @@ ufshcd_transfer_rsp_status(struct ufs_hba *hba, str=
uct ufshcd_lrb *lrbp,
 	 * not set either flag.
 	 */
 	if (resid && !(upiu_flags & UPIU_RSP_FLAG_OVERFLOW))
-		scsi_set_resid(lrbp->cmd, resid);
+		scsi_set_resid(cmd, resid);
=20
 	/* overall command status of utrd */
 	ocs =3D ufshcd_get_tr_ocs(lrbp, cqe);
@@ -5480,7 +5492,7 @@ ufshcd_transfer_rsp_status(struct ufs_hba *hba, str=
uct ufshcd_lrb *lrbp,
 			 * to notify the SCSI midlayer of the command status
 			 */
 			scsi_status =3D lrbp->ucd_rsp_ptr->header.status;
-			result =3D ufshcd_scsi_cmd_status(lrbp, scsi_status);
+			result =3D ufshcd_scsi_cmd_status(cmd, scsi_status);
=20
 			/*
 			 * Currently we are only supporting BKOPs exception
@@ -5543,7 +5555,7 @@ ufshcd_transfer_rsp_status(struct ufs_hba *hba, str=
uct ufshcd_lrb *lrbp,
=20
 	if ((host_byte(result) !=3D DID_OK) &&
 	    (host_byte(result) !=3D DID_REQUEUE) && !hba->silence_err_logs)
-		ufshcd_print_tr(hba, lrbp->task_tag, true);
+		ufshcd_print_tr(hba, cmd, true);
 	return result;
 }
=20
@@ -5612,13 +5624,10 @@ static irqreturn_t ufshcd_uic_cmd_compl(struct uf=
s_hba *hba, u32 intr_status)
 }
=20
 /* Release the resources allocated for processing a SCSI command. */
-void ufshcd_release_scsi_cmd(struct ufs_hba *hba,
-			     struct ufshcd_lrb *lrbp)
+void ufshcd_release_scsi_cmd(struct ufs_hba *hba, struct scsi_cmnd *cmd)
 {
-	struct scsi_cmnd *cmd =3D lrbp->cmd;
-
 	scsi_dma_unmap(cmd);
-	ufshcd_crypto_clear_prdt(hba, lrbp);
+	ufshcd_crypto_clear_prdt(hba, cmd);
 	ufshcd_release(hba);
 	ufshcd_clk_scaling_update_busy(hba);
 }
@@ -5632,20 +5641,20 @@ void ufshcd_release_scsi_cmd(struct ufs_hba *hba,
 void ufshcd_compl_one_cqe(struct ufs_hba *hba, int task_tag,
 			  struct cq_entry *cqe)
 {
-	struct ufshcd_lrb *lrbp =3D &hba->lrb[task_tag];
-	struct scsi_cmnd *cmd =3D lrbp->cmd;
+	struct scsi_cmnd *cmd =3D ufshcd_tag_to_cmd(hba, task_tag);
+	struct ufshcd_lrb *lrbp =3D scsi_cmd_priv(cmd);
 	enum utp_ocs ocs;
=20
 	if (hba->monitor.enabled) {
 		lrbp->compl_time_stamp =3D ktime_get();
 		lrbp->compl_time_stamp_local_clock =3D local_clock();
 	}
-	if (cmd) {
+	if (ufshcd_is_scsi_cmd(cmd)) {
 		if (unlikely(ufshcd_should_inform_monitor(hba, cmd)))
 			ufshcd_update_monitor(hba, cmd);
 		ufshcd_add_command_trace(hba, cmd, UFS_CMD_COMP);
-		cmd->result =3D ufshcd_transfer_rsp_status(hba, lrbp, cqe);
-		ufshcd_release_scsi_cmd(hba, lrbp);
+		cmd->result =3D ufshcd_transfer_rsp_status(hba, cmd, cqe);
+		ufshcd_release_scsi_cmd(hba, cmd);
 		/* Do not touch lrbp after scsi done */
 		scsi_done(cmd);
 	} else {
@@ -5682,7 +5691,7 @@ static void ufshcd_clear_polled(struct ufs_hba *hba=
,
 	int tag;
=20
 	for_each_set_bit(tag, completed_reqs, hba->nutrs) {
-		struct scsi_cmnd *cmd =3D hba->lrb[tag].cmd;
+		struct scsi_cmnd *cmd =3D scsi_host_find_tag(hba->host, tag);
=20
 		if (!cmd)
 			continue;
@@ -5733,7 +5742,6 @@ static bool ufshcd_mcq_force_compl_one(struct reque=
st *rq, void *priv)
 	struct scsi_device *sdev =3D rq->q->queuedata;
 	struct Scsi_Host *shost =3D sdev->host;
 	struct ufs_hba *hba =3D shost_priv(shost);
-	struct ufshcd_lrb *lrbp =3D &hba->lrb[rq->tag];
 	struct ufs_hw_queue *hwq =3D ufshcd_mcq_req_to_hwq(hba, rq);
=20
 	if (!hwq)
@@ -5748,7 +5756,7 @@ static bool ufshcd_mcq_force_compl_one(struct reque=
st *rq, void *priv)
 	scoped_guard(spinlock_irqsave, &hwq->cq_lock) {
 		if (!test_bit(SCMD_STATE_COMPLETE, &cmd->state)) {
 			set_host_byte(cmd, DID_REQUEUE);
-			ufshcd_release_scsi_cmd(hba, lrbp);
+			ufshcd_release_scsi_cmd(hba, cmd);
 			scsi_done(cmd);
 		}
 	}
@@ -6627,7 +6635,7 @@ static bool ufshcd_abort_one(struct request *rq, vo=
id *priv)
=20
 	*ret =3D ufshcd_try_to_abort_task(hba, tag);
 	dev_err(hba->dev, "Aborting tag %d / CDB %#02x %s\n", tag,
-		hba->lrb[tag].cmd ? hba->lrb[tag].cmd->cmnd[0] : -1,
+		ufshcd_is_scsi_cmd(cmd) ? cmd->cmnd[0] : -1,
 		*ret ? "failed" : "succeeded");
=20
 	return *ret =3D=3D 0;
@@ -7344,14 +7352,15 @@ static int ufshcd_issue_devman_upiu_cmd(struct uf=
s_hba *hba,
 					enum query_opcode desc_op)
 {
 	const u32 tag =3D hba->reserved_slot;
-	struct ufshcd_lrb *lrbp =3D &hba->lrb[tag];
+	struct scsi_cmnd *cmd =3D ufshcd_tag_to_cmd(hba, tag);
+	struct ufshcd_lrb *lrbp =3D scsi_cmd_priv(cmd);
 	int err =3D 0;
 	u8 upiu_flags;
=20
 	/* Protects use of hba->reserved_slot. */
 	lockdep_assert_held(&hba->dev_cmd.lock);
=20
-	ufshcd_setup_dev_cmd(hba, lrbp, cmd_type, 0, tag);
+	ufshcd_setup_dev_cmd(hba, cmd, cmd_type, 0, tag);
=20
 	ufshcd_prepare_req_desc_hdr(hba, lrbp, &upiu_flags, DMA_NONE, 0);
=20
@@ -7376,7 +7385,7 @@ static int ufshcd_issue_devman_upiu_cmd(struct ufs_=
hba *hba,
 	 * bound to fail since dev_cmd.query and dev_cmd.type were left empty.
 	 * read the response directly ignoring all errors.
 	 */
-	ufshcd_issue_dev_cmd(hba, lrbp, tag, dev_cmd_timeout);
+	ufshcd_issue_dev_cmd(hba, cmd, tag, dev_cmd_timeout);
=20
 	/* just copy the upiu response as it is */
 	memcpy(rsp_upiu, lrbp->ucd_rsp_ptr, sizeof(*rsp_upiu));
@@ -7490,7 +7499,8 @@ int ufshcd_advanced_rpmb_req_handler(struct ufs_hba=
 *hba, struct utp_upiu_req *r
 			 enum dma_data_direction dir)
 {
 	const u32 tag =3D hba->reserved_slot;
-	struct ufshcd_lrb *lrbp =3D &hba->lrb[tag];
+	struct scsi_cmnd *cmd =3D ufshcd_tag_to_cmd(hba, tag);
+	struct ufshcd_lrb *lrbp =3D scsi_cmd_priv(cmd);
 	int err =3D 0;
 	int result;
 	u8 upiu_flags;
@@ -7501,7 +7511,8 @@ int ufshcd_advanced_rpmb_req_handler(struct ufs_hba=
 *hba, struct utp_upiu_req *r
 	/* Protects use of hba->reserved_slot. */
 	ufshcd_dev_man_lock(hba);
=20
-	ufshcd_setup_dev_cmd(hba, lrbp, DEV_CMD_TYPE_RPMB, UFS_UPIU_RPMB_WLUN, =
tag);
+	ufshcd_setup_dev_cmd(hba, cmd, DEV_CMD_TYPE_RPMB, UFS_UPIU_RPMB_WLUN,
+			     tag);
=20
 	ufshcd_prepare_req_desc_hdr(hba, lrbp, &upiu_flags, DMA_NONE, ehs);
=20
@@ -7518,7 +7529,7 @@ int ufshcd_advanced_rpmb_req_handler(struct ufs_hba=
 *hba, struct utp_upiu_req *r
=20
 	memset(lrbp->ucd_rsp_ptr, 0, sizeof(struct utp_upiu_rsp));
=20
-	err =3D ufshcd_issue_dev_cmd(hba, lrbp, tag, ADVANCED_RPMB_REQ_TIMEOUT)=
;
+	err =3D ufshcd_issue_dev_cmd(hba, cmd, tag, ADVANCED_RPMB_REQ_TIMEOUT);
=20
 	if (!err) {
 		/* Just copy the upiu response as it is */
@@ -7619,11 +7630,12 @@ static int ufshcd_eh_device_reset_handler(struct =
scsi_cmnd *cmd)
=20
 static void ufshcd_set_req_abort_skip(struct ufs_hba *hba, unsigned long=
 bitmap)
 {
-	struct ufshcd_lrb *lrbp;
 	int tag;
=20
 	for_each_set_bit(tag, &bitmap, hba->nutrs) {
-		lrbp =3D &hba->lrb[tag];
+		struct scsi_cmnd *cmd =3D ufshcd_tag_to_cmd(hba, tag);
+		struct ufshcd_lrb *lrbp =3D scsi_cmd_priv(cmd);
+
 		lrbp->req_abort_skip =3D true;
 	}
 }
@@ -7631,7 +7643,7 @@ static void ufshcd_set_req_abort_skip(struct ufs_hb=
a *hba, unsigned long bitmap)
 /**
  * ufshcd_try_to_abort_task - abort a specific task
  * @hba: Pointer to adapter instance
- * @tag: Task tag/index to be aborted
+ * @tag: Tag of the task to be aborted
  *
  * Abort the pending command in device by sending UFS_ABORT_TASK task ma=
nagement
  * command, and in host controller by clearing the door-bell register. T=
here can
@@ -7643,7 +7655,8 @@ static void ufshcd_set_req_abort_skip(struct ufs_hb=
a *hba, unsigned long bitmap)
  */
 int ufshcd_try_to_abort_task(struct ufs_hba *hba, int tag)
 {
-	struct ufshcd_lrb *lrbp =3D &hba->lrb[tag];
+	struct scsi_cmnd *cmd =3D ufshcd_tag_to_cmd(hba, tag);
+	struct ufshcd_lrb *lrbp =3D scsi_cmd_priv(cmd);
 	int err;
 	int poll_cnt;
 	u8 resp =3D 0xF;
@@ -7665,7 +7678,7 @@ int ufshcd_try_to_abort_task(struct ufs_hba *hba, i=
nt tag)
 				hba->dev,
 				"%s: cmd with tag %d not pending in the device.\n",
 				__func__, tag);
-			if (!ufshcd_cmd_inflight(lrbp->cmd)) {
+			if (!ufshcd_cmd_inflight(cmd)) {
 				dev_info(hba->dev,
 					 "%s: cmd with tag=3D%d completed.\n",
 					 __func__, tag);
@@ -7713,7 +7726,7 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 	struct Scsi_Host *host =3D cmd->device->host;
 	struct ufs_hba *hba =3D shost_priv(host);
 	int tag =3D scsi_cmd_to_rq(cmd)->tag;
-	struct ufshcd_lrb *lrbp =3D &hba->lrb[tag];
+	struct ufshcd_lrb *lrbp =3D scsi_cmd_priv(cmd);
 	unsigned long flags;
 	int err =3D FAILED;
 	bool outstanding;
@@ -7748,9 +7761,9 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 		ufshcd_print_evt_hist(hba);
 		ufshcd_print_host_state(hba);
 		ufshcd_print_pwr_info(hba);
-		ufshcd_print_tr(hba, tag, true);
+		ufshcd_print_tr(hba, cmd, true);
 	} else {
-		ufshcd_print_tr(hba, tag, false);
+		ufshcd_print_tr(hba, cmd, false);
 	}
 	hba->req_abort_count++;
=20
@@ -7794,7 +7807,7 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 		goto release;
 	}
=20
-	err =3D ufshcd_try_to_abort_task(hba, tag);
+	err =3D ufshcd_try_to_abort_task(hba, lrbp->task_tag);
 	if (err) {
 		dev_err(hba->dev, "%s: failed with err %d\n", __func__, err);
 		ufshcd_set_req_abort_skip(hba, hba->outstanding_reqs);
@@ -7811,7 +7824,7 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 	spin_unlock_irqrestore(&hba->outstanding_lock, flags);
=20
 	if (outstanding)
-		ufshcd_release_scsi_cmd(hba, lrbp);
+		ufshcd_release_scsi_cmd(hba, cmd);
=20
 	err =3D SUCCESS;
=20
@@ -8889,8 +8902,6 @@ static void ufshcd_release_sdb_queue(struct ufs_hba=
 *hba, int nutrs)
 	utrdl_size =3D sizeof(struct utp_transfer_req_desc) * nutrs;
 	dmam_free_coherent(hba->dev, utrdl_size, hba->utrdl_base_addr,
 			   hba->utrdl_dma_addr);
-
-	devm_kfree(hba->dev, hba->lrb);
 }
=20
 static int ufshcd_alloc_mcq(struct ufs_hba *hba)
@@ -9166,6 +9177,7 @@ static const struct scsi_host_template ufshcd_drive=
r_template =3D {
 	.name			=3D UFSHCD,
 	.proc_name		=3D UFSHCD,
 	.map_queues		=3D ufshcd_map_queues,
+	.cmd_size		=3D sizeof(struct ufshcd_lrb),
 	.init_cmd_priv		=3D ufshcd_init_cmd_priv,
 	.queuecommand		=3D ufshcd_queuecommand,
 	.mq_poll		=3D ufshcd_poll,
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index ea0021f067c9..89dcac34c957 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -161,7 +161,6 @@ struct ufs_pm_lvl_states {
  * @ucd_prdt_dma_addr: PRDT dma address for debug
  * @ucd_rsp_dma_addr: UPIU response dma address for debug
  * @ucd_req_dma_addr: UPIU request dma address for debug
- * @cmd: pointer to SCSI command
  * @scsi_status: SCSI status of the command
  * @command_type: SCSI, UFS, Query.
  * @task_tag: Task tag of the command
@@ -186,7 +185,6 @@ struct ufshcd_lrb {
 	dma_addr_t ucd_rsp_dma_addr;
 	dma_addr_t ucd_prdt_dma_addr;
=20
-	struct scsi_cmnd *cmd;
 	int scsi_status;
=20
 	int command_type;
@@ -833,7 +831,6 @@ enum ufshcd_mcq_opr {
  * @spm_lvl: desired UFS power management level during system PM.
  * @pm_op_in_progress: whether or not a PM operation is in progress.
  * @ahit: value of Auto-Hibernate Idle Timer register.
- * @lrb: local reference block
  * @outstanding_tasks: Bits representing outstanding task requests
  * @outstanding_lock: Protects @outstanding_reqs.
  * @outstanding_reqs: Bits representing outstanding transfer requests
@@ -975,8 +972,6 @@ struct ufs_hba {
 	/* Auto-Hibernate Idle Timer register value */
 	u32 ahit;
=20
-	struct ufshcd_lrb *lrb;
-
 	unsigned long outstanding_tasks;
 	spinlock_t outstanding_lock;
 	unsigned long outstanding_reqs;

