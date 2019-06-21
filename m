Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8D94ED6E
	for <lists+linux-scsi@lfdr.de>; Fri, 21 Jun 2019 18:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbfFUQun (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 21 Jun 2019 12:50:43 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:51452 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726203AbfFUQun (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 21 Jun 2019 12:50:43 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5LGf4F6004801;
        Fri, 21 Jun 2019 09:50:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=pHFz50stXxGndvfGTMGo5WYdaMEciMBZLOe+8+O1cjI=;
 b=MtalnFsC40cjEZmGx7YUfkW9SXXrH014MQFrRDqd6TmxqGzTqpAbOjFRQi2ekz2xu86h
 9dyQ2M7sZ4G0ILA6HwUAJ7/zSMMekZJEZqh+H8A0Q8TwXzoQD37Ioeneg6psW/pG4KeP
 V23/7qfKZQKz8eRqkZIulQFE+UWG1Oxb2GiDEeb2bUHSrPJGpSNiTzYbYTAKhWLKTq5m
 lv+ngRwCjUS9bDIX88s9I6rbmH9Qn8dei0cQsjvATHsFS8gxHub6tOYjgYpi1oBME9D1
 3+8k00vVfJgknTMvRiRfS/ATA6CejMXi2E5ZAxxnIANU/8R0zQrJCloH+1LG2ABEy7H2 yA== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2t8yp20tss-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 21 Jun 2019 09:50:37 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 21 Jun
 2019 09:50:34 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Fri, 21 Jun 2019 09:50:34 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id 14AAA3F703F;
        Fri, 21 Jun 2019 09:50:34 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id x5LGoXX0023921;
        Fri, 21 Jun 2019 09:50:33 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id x5LGoXWj023920;
        Fri, 21 Jun 2019 09:50:33 -0700
From:   Himanshu Madhani <hmadhani@marvell.com>
To:     <James.Bottomley@HansenPartnership.com>,
        <martin.petersen@oracle.com>
CC:     <hmadhani@marvell.com>, <linux-scsi@vger.kernel.org>
Subject: [PATCH v3 3/3] qla2xxx: Fix NVME cmd and LS cmd timeout race condition
Date:   Fri, 21 Jun 2019 09:50:24 -0700
Message-ID: <20190621165024.23874-4-hmadhani@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190621165024.23874-1-hmadhani@marvell.com>
References: <20190621165024.23874-1-hmadhani@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-21_11:,,
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
 drivers/scsi/qla2xxx/qla_def.h  |   3 +
 drivers/scsi/qla2xxx/qla_nvme.c | 163 ++++++++++++++++++++++++++++------------
 drivers/scsi/qla2xxx/qla_nvme.h |   1 +
 3 files changed, 117 insertions(+), 50 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 602ed24bb806..c0d1b0715541 100644
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
@@ -554,6 +556,7 @@ typedef struct srb {
 	} u;
 	void (*done)(void *, int);
 	void (*free)(void *);
+	void (*put_fn)(struct kref *kref);
 } srb_t;
 
 #define GET_CMD_SP(sp) (sp->u.scmd.cmd)
diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index 8b3cb0fd307e..316aea085e6e 100644
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
@@ -188,44 +226,50 @@ static void qla_nvme_abort_work(struct work_struct *work)
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
+	kref_put(&sp->cmd_kref, sp->put_fn);
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
@@ -257,11 +301,13 @@ static int qla_nvme_ls_req(struct nvme_fc_local_port *lport,
 	sp->type = SRB_NVME_LS;
 	sp->name = "nvme_ls";
 	sp->done = qla_nvme_sp_ls_done;
-	atomic_set(&sp->ref_count, 1);
-	nvme = &sp->u.iocb_cmd;
+	sp->put_fn = qla_nvme_release_ls_cmd_kref;
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
@@ -278,9 +324,10 @@ static int qla_nvme_ls_req(struct nvme_fc_local_port *lport,
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
 
@@ -292,6 +339,18 @@ static void qla_nvme_fcp_abort(struct nvme_fc_local_port *lport,
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
@@ -515,12 +574,15 @@ static int qla_nvme_post_cmd(struct nvme_fc_local_port *lport,
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
 	sp->done = qla_nvme_sp_done;
+	sp->put_fn = qla_nvme_release_fcp_cmd_kref;
 	sp->qpair = qpair;
 	sp->vha = vha;
 	nvme = &sp->u.iocb_cmd;
@@ -530,9 +592,10 @@ static int qla_nvme_post_cmd(struct nvme_fc_local_port *lport,
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

