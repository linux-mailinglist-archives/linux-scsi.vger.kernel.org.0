Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A28754A98A
	for <lists+linux-scsi@lfdr.de>; Tue, 18 Jun 2019 20:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730169AbfFRSMB (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 18 Jun 2019 14:12:01 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:20558 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727616AbfFRSMB (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 18 Jun 2019 14:12:01 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5II4cjk015571;
        Tue, 18 Jun 2019 11:11:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=1Rhg3meYJ3OxnNZ2ZPE32LQrbyAsZ5erPqj9zbBW3d8=;
 b=DCcjLBScT023ZKsXDXvgiWktHyTx4OEQ5+nxg24aN5LzECb9DB3BXrJND+rm7oE6Plah
 cQ22+kwk6WKOvSROpYxiABLFxe+J6l2Kh70P3Jzhmxg+c072UtMpuUBvDitOJXEt/H57
 8NMJ1vCaRxnOBt4L5zoHBHzUkefXgETbtIVKa8OBoSaNb7ORysifwfal79+t4/z0Mvtk
 bkYPtyb2fSFuQoHKg1/DHtyM9DI1IEidOoANB9IBta41nKl5tcJlDU1JQNB3+usANCgE
 mDYxHNWUAdCP79/gOdruOrT2rvJmZscTLn8hYhRtMEtcX/oIHhnYyWnQXUhGfxc0/Mgg ug== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2t73vqgcuy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 18 Jun 2019 11:11:59 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 18 Jun
 2019 11:11:58 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Tue, 18 Jun 2019 11:11:58 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id 1B9563F7041;
        Tue, 18 Jun 2019 11:11:58 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id x5IIBvne016610;
        Tue, 18 Jun 2019 11:11:57 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id x5IIBv78016609;
        Tue, 18 Jun 2019 11:11:57 -0700
From:   Himanshu Madhani <hmadhani@marvell.com>
To:     <James.Bottomley@HansenPartnership.com>,
        <martin.petersen@oracle.com>
CC:     <hmadhani@marvell.com>, <linux-scsi@vger.kernel.org>
Subject: [PATCH v2 3/3] qla2xxx: Fix NVME cmd and LS cmd timeout race condition
Date:   Tue, 18 Jun 2019 11:10:21 -0700
Message-ID: <20190618181021.16547-4-hmadhani@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190618181021.16547-1-hmadhani@marvell.com>
References: <20190618181021.16547-1-hmadhani@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-18_08:,,
 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Quinn Tran <qutran@marvell.com>

This patch uses kref to protect access between fcp_abort
path and nvme command and LS command completion path.
Stack trace below shows the abort path is accessing stale
memory (nvme_private->sp).

When command kref reaches 0, nvme_private & srb resource will
be disconnected from each other.  Any subsequence nvme abort
request will not be able to reference the original srb.

[ 5631.003998] BUG: unable to handle kernel paging request at 00000010000005d8
[ 5631.004016] IP: [<ffffffffc087df92>] qla_nvme_abort_work+0x22/0x100 [qla2xxx]
[ 5631.004086] Workqueue: events qla_nvme_abort_work [qla2xxx]
[ 5631.004097] RIP: 0010:[<ffffffffc087df92>]  [<ffffffffc087df92>] qla_nvme_abort_work+0x22/0x100 [qla2xxx]
[ 5631.004109] Call Trace:
[ 5631.004115]  [<ffffffffaa4b8174>] ? pwq_dec_nr_in_flight+0x64/0xb0
[ 5631.004117]  [<ffffffffaa4b9d4f>] process_one_work+0x17f/0x440
[ 5631.004120]  [<ffffffffaa4bade6>] worker_thread+0x126/0x3c0

Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
---
 drivers/scsi/qla2xxx/qla_def.h  |   2 +
 drivers/scsi/qla2xxx/qla_nvme.c | 164 ++++++++++++++++++++++++++++------------
 drivers/scsi/qla2xxx/qla_nvme.h |   1 +
 3 files changed, 117 insertions(+), 50 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 602ed24bb806..85a27ee5d647 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -532,6 +532,8 @@ typedef struct srb {
 	uint8_t cmd_type;
 	uint8_t pad[3];
 	atomic_t ref_count;
+	struct kref cmd_kref;	/* need to migrate ref_count over to this */
+	void *priv;
 	wait_queue_head_t nvme_ls_waitq;
 	struct fc_port *fcport;
 	struct scsi_qla_host *vha;
diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index 2c64457ce713..78df476e80a1 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -123,53 +123,91 @@ static int qla_nvme_alloc_queue(struct nvme_fc_local_port *lport,
 	return 0;
 }
 
+static void qla_nvme_release_fcp_cmd_kref(struct kref *kref)
+{
+	struct srb *sp = container_of(kref, struct srb, cmd_kref);
+	struct nvme_private *priv = (struct nvme_private *)sp->priv;
+	struct nvmefc_fcp_req *fd;
+	struct srb_iocb *nvme;
+	unsigned long flags;
+
+	if (!priv)
+		goto out;
+
+	nvme = &sp->u.iocb_cmd;
+	fd = nvme->u.nvme.desc;
+
+	spin_lock_irqsave(&priv->cmd_lock, flags);
+	priv->sp = NULL;
+	sp->priv = NULL;
+	if (priv->comp_status == QLA_SUCCESS) {
+		fd->rcv_rsplen = nvme->u.nvme.rsp_pyld_len;
+	} else {
+		fd->rcv_rsplen = 0;
+		fd->transferred_length = 0;
+	}
+	fd->status = 0;
+	spin_unlock_irqrestore(&priv->cmd_lock, flags);
+
+	fd->done(fd);
+out:
+	qla2xxx_rel_qpair_sp(sp->qpair, sp);
+}
+
+static void qla_nvme_release_ls_cmd_kref(struct kref *kref)
+{
+	struct srb *sp = container_of(kref, struct srb, cmd_kref);
+	struct nvme_private *priv = (struct nvme_private *)sp->priv;
+	struct nvmefc_ls_req *fd;
+	unsigned long flags;
+
+	if (!priv)
+		goto out;
+
+	spin_lock_irqsave(&priv->cmd_lock, flags);
+	priv->sp = NULL;
+	sp->priv = NULL;
+	spin_unlock_irqrestore(&priv->cmd_lock, flags);
+
+	fd = priv->fd;
+	fd->done(fd, priv->comp_status);
+out:
+	qla2x00_rel_sp(sp);
+}
+
+static void qla_nvme_ls_complete(struct work_struct *work)
+{
+	struct nvme_private *priv =
+		container_of(work, struct nvme_private, ls_work);
+
+	kref_put(&priv->sp->cmd_kref, qla_nvme_release_ls_cmd_kref);
+}
+
 static void qla_nvme_sp_ls_done(void *ptr, int res)
 {
 	srb_t *sp = ptr;
-	struct srb_iocb *nvme;
-	struct nvmefc_ls_req   *fd;
 	struct nvme_private *priv;
 
-	if (WARN_ON_ONCE(atomic_read(&sp->ref_count) == 0))
+	if (WARN_ON_ONCE(kref_read(&sp->cmd_kref) == 0))
 		return;
 
-	atomic_dec(&sp->ref_count);
-
 	if (res)
 		res = -EINVAL;
 
-	nvme = &sp->u.iocb_cmd;
-	fd = nvme->u.nvme.desc;
-	priv = fd->private;
+	priv = (struct nvme_private *)sp->priv;
 	priv->comp_status = res;
+	INIT_WORK(&priv->ls_work, qla_nvme_ls_complete);
 	schedule_work(&priv->ls_work);
-	/* work schedule doesn't need the sp */
-	qla2x00_rel_sp(sp);
 }
 
+/* it assumed that QPair lock is held. */
 static void qla_nvme_sp_done(void *ptr, int res)
 {
 	srb_t *sp = ptr;
-	struct srb_iocb *nvme;
-	struct nvmefc_fcp_req *fd;
+	struct nvme_private *priv = (struct nvme_private *)sp->priv;
 
-	nvme = &sp->u.iocb_cmd;
-	fd = nvme->u.nvme.desc;
-
-	if (WARN_ON_ONCE(atomic_read(&sp->ref_count) == 0))
-		return;
-
-	atomic_dec(&sp->ref_count);
-
-	if (res == QLA_SUCCESS) {
-		fd->rcv_rsplen = nvme->u.nvme.rsp_pyld_len;
-	} else {
-		fd->rcv_rsplen = 0;
-		fd->transferred_length = 0;
-	}
-	fd->status = 0;
-	fd->done(fd);
-	qla2xxx_rel_qpair_sp(sp->qpair, sp);
+	priv->comp_status = res;
+	kref_put(&sp->cmd_kref, qla_nvme_release_fcp_cmd_kref);
 
 	return;
 }
@@ -188,44 +226,53 @@ static void qla_nvme_abort_work(struct work_struct *work)
 	       __func__, sp, sp->handle, fcport, fcport->deleted);
 
 	if (!ha->flags.fw_started && (fcport && fcport->deleted))
-		return;
+		goto out;
 
 	if (ha->flags.host_shutting_down) {
 		ql_log(ql_log_info, sp->fcport->vha, 0xffff,
 		    "%s Calling done on sp: %p, type: 0x%x, sp->ref_count: 0x%x\n",
 		    __func__, sp, sp->type, atomic_read(&sp->ref_count));
 		sp->done(sp, 0);
-		return;
+		goto out;
 	}
 
-	if (WARN_ON_ONCE(atomic_read(&sp->ref_count) == 0))
-		return;
-
 	rval = ha->isp_ops->abort_command(sp);
 
 	ql_dbg(ql_dbg_io, fcport->vha, 0x212b,
 	    "%s: %s command for sp=%p, handle=%x on fcport=%p rval=%x\n",
 	    __func__, (rval != QLA_SUCCESS) ? "Failed to abort" : "Aborted",
 	    sp, sp->handle, fcport, rval);
+
+out:
+	/* kref_get was done before work was schedule. */
+	if (sp->type == SRB_NVME_CMD)
+		kref_put(&sp->cmd_kref, qla_nvme_release_fcp_cmd_kref);
+	else if (sp->type == SRB_NVME_LS)
+		kref_put(&sp->cmd_kref, qla_nvme_release_ls_cmd_kref);
 }
 
 static void qla_nvme_ls_abort(struct nvme_fc_local_port *lport,
     struct nvme_fc_remote_port *rport, struct nvmefc_ls_req *fd)
 {
 	struct nvme_private *priv = fd->private;
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->cmd_lock, flags);
+	if (!priv->sp) {
+		spin_unlock_irqrestore(&priv->cmd_lock, flags);
+		return;
+	}
+
+	if (!kref_get_unless_zero(&priv->sp->cmd_kref)) {
+		spin_unlock_irqrestore(&priv->cmd_lock, flags);
+		return;
+	}
+	spin_unlock_irqrestore(&priv->cmd_lock, flags);
 
 	INIT_WORK(&priv->abort_work, qla_nvme_abort_work);
 	schedule_work(&priv->abort_work);
 }
 
-static void qla_nvme_ls_complete(struct work_struct *work)
-{
-	struct nvme_private *priv =
-	    container_of(work, struct nvme_private, ls_work);
-	struct nvmefc_ls_req *fd = priv->fd;
-
-	fd->done(fd, priv->comp_status);
-}
 
 static int qla_nvme_ls_req(struct nvme_fc_local_port *lport,
     struct nvme_fc_remote_port *rport, struct nvmefc_ls_req *fd)
@@ -253,11 +300,12 @@ static int qla_nvme_ls_req(struct nvme_fc_local_port *lport,
 	sp->type = SRB_NVME_LS;
 	sp->name = "nvme_ls";
 	sp->done = qla_nvme_sp_ls_done;
-	atomic_set(&sp->ref_count, 1);
-	nvme = &sp->u.iocb_cmd;
+	sp->priv = (void *)priv;
 	priv->sp = sp;
+	kref_init(&sp->cmd_kref);
+	spin_lock_init(&priv->cmd_lock);
+	nvme = &sp->u.iocb_cmd;
 	priv->fd = fd;
-	INIT_WORK(&priv->ls_work, qla_nvme_ls_complete);
 	nvme->u.nvme.desc = fd;
 	nvme->u.nvme.dir = 0;
 	nvme->u.nvme.dl = 0;
@@ -274,9 +322,10 @@ static int qla_nvme_ls_req(struct nvme_fc_local_port *lport,
 	if (rval != QLA_SUCCESS) {
 		ql_log(ql_log_warn, vha, 0x700e,
 		    "qla2x00_start_sp failed = %d\n", rval);
-		atomic_dec(&sp->ref_count);
 		wake_up(&sp->nvme_ls_waitq);
-		sp->free(sp);
+		sp->priv = NULL;
+		priv->sp = NULL;
+		qla2x00_rel_sp(sp);
 		return rval;
 	}
 
@@ -288,6 +337,18 @@ static void qla_nvme_fcp_abort(struct nvme_fc_local_port *lport,
     struct nvmefc_fcp_req *fd)
 {
 	struct nvme_private *priv = fd->private;
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->cmd_lock, flags);
+	if (!priv->sp) {
+		spin_unlock_irqrestore(&priv->cmd_lock, flags);
+		return;
+	}
+	if (!kref_get_unless_zero(&priv->sp->cmd_kref)) {
+		spin_unlock_irqrestore(&priv->cmd_lock, flags);
+		return;
+	}
+	spin_unlock_irqrestore(&priv->cmd_lock, flags);
 
 	INIT_WORK(&priv->abort_work, qla_nvme_abort_work);
 	schedule_work(&priv->abort_work);
@@ -511,8 +572,10 @@ static int qla_nvme_post_cmd(struct nvme_fc_local_port *lport,
 	if (!sp)
 		return -EBUSY;
 
-	atomic_set(&sp->ref_count, 1);
 	init_waitqueue_head(&sp->nvme_ls_waitq);
+	kref_init(&sp->cmd_kref);
+	spin_lock_init(&priv->cmd_lock);
+	sp->priv = (void *)priv;
 	priv->sp = sp;
 	sp->type = SRB_NVME_CMD;
 	sp->name = "nvme_cmd";
@@ -526,9 +589,10 @@ static int qla_nvme_post_cmd(struct nvme_fc_local_port *lport,
 	if (rval != QLA_SUCCESS) {
 		ql_log(ql_log_warn, vha, 0x212d,
 		    "qla2x00_start_nvme_mq failed = %d\n", rval);
-		atomic_dec(&sp->ref_count);
 		wake_up(&sp->nvme_ls_waitq);
-		sp->free(sp);
+		sp->priv = NULL;
+		priv->sp = NULL;
+		qla2xxx_rel_qpair_sp(sp->qpair, sp);
 	}
 
 	return rval;
diff --git a/drivers/scsi/qla2xxx/qla_nvme.h b/drivers/scsi/qla2xxx/qla_nvme.h
index 2d088add7011..67bb4a2a3742 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.h
+++ b/drivers/scsi/qla2xxx/qla_nvme.h
@@ -34,6 +34,7 @@ struct nvme_private {
 	struct work_struct ls_work;
 	struct work_struct abort_work;
 	int comp_status;
+	spinlock_t cmd_lock;
 };
 
 struct qla_nvme_rport {
-- 
2.12.0

