Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D944F00C7
	for <lists+linux-scsi@lfdr.de>; Tue,  5 Nov 2019 16:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389015AbfKEPHT (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 5 Nov 2019 10:07:19 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:25568 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730939AbfKEPHT (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 5 Nov 2019 10:07:19 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA5F0ZcX015958;
        Tue, 5 Nov 2019 07:07:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=sY89l5LfAiK3p90v0f1VTQgFnJqOvbZnVZRd3jFRpEE=;
 b=IX7iwBImtgQDDCXIJRfYzGud9aoZQ1LuYpPTo63w+YiZWtUV8wofg2B+v8uHmXQQG59R
 mircPI0pIS4XebdXpLf9k5MFyATZFkxjn4vRUWznTAmpbxsaJRuVxYYlcO8MlZp8S1Q3
 dP1oAlqc0nOWELVRDakHJYYldh1B4P1mEQblbMyz+fSbK0hwbSja+sfXoZx9BNa+ZFfG
 8GEf21kkATJA8YxOfqSGllVFvnZhc4t0jYYNrj8NZCc1e28GhKMzX6STHSdaHRJWvcrW
 pdc6cQnW05y0mRFcyHxDPwDGZz53SBPvlEalVkWuZSEk4fz7wYMkC3p8agPEuQUyt/VP RA== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2w19amtrke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 05 Nov 2019 07:07:15 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 5 Nov
 2019 07:07:13 -0800
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Tue, 5 Nov 2019 07:07:13 -0800
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id 4E76F3F703F;
        Tue,  5 Nov 2019 07:07:13 -0800 (PST)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id xA5F7DL0008155;
        Tue, 5 Nov 2019 07:07:13 -0800
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id xA5F7Dpi008154;
        Tue, 5 Nov 2019 07:07:13 -0800
From:   Himanshu Madhani <hmadhani@marvell.com>
To:     <James.Bottomley@HansenPartnership.com>,
        <martin.petersen@oracle.com>
CC:     <hmadhani@marvell.com>, <linux-scsi@vger.kernel.org>
Subject: [PATCH 5/8] qla2xxx: Fix double scsi_done for abort path
Date:   Tue, 5 Nov 2019 07:06:54 -0800
Message-ID: <20191105150657.8092-6-hmadhani@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20191105150657.8092-1-hmadhani@marvell.com>
References: <20191105150657.8092-1-hmadhani@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-05_05:2019-11-05,2019-11-05 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Quinn Tran <qutran@marvell.com>

Current code assume abort will remove the original command from the
active list where scsi_done will not be call. Instead, the eh_abort
thread will do the scsi_done. That is not the case.  Instead, we
have a double scsi_done calls triggering use after free.

Abort will tell FW to release the command from FW possesion. The
original command will return to ULP with error in its normal fashion via
scsi_done.  eh_abort path would wait for the original command
completion before returning.  eh_abort path will not perform the
scsi_done call.

Fixes: 219d27d7147e0 ("scsi: qla2xxx: Fix race conditions in the code for aborting SCSI commands")
Cc: stable@vger.kernel.org # 5.2
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Arun Easi <aeasi@marvell.com>
Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
---
 drivers/scsi/qla2xxx/qla_def.h  |   5 +-
 drivers/scsi/qla2xxx/qla_isr.c  |   5 ++
 drivers/scsi/qla2xxx/qla_nvme.c |   4 +-
 drivers/scsi/qla2xxx/qla_os.c   | 117 +++++++++++++++++++++-------------------
 4 files changed, 72 insertions(+), 59 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index ef9bb3c7ad6f..2a9e6a9a8c9d 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -591,13 +591,16 @@ typedef struct srb {
 	 */
 	uint8_t cmd_type;
 	uint8_t pad[3];
-	atomic_t ref_count;
 	struct kref cmd_kref;	/* need to migrate ref_count over to this */
 	void *priv;
 	wait_queue_head_t nvme_ls_waitq;
 	struct fc_port *fcport;
 	struct scsi_qla_host *vha;
 	unsigned int start_timer:1;
+	unsigned int abort:1;
+	unsigned int aborted:1;
+	unsigned int completed:1;
+
 	uint32_t handle;
 	uint16_t flags;
 	uint16_t type;
diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index acef3d73983c..1b8f297449cf 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -2487,6 +2487,11 @@ qla2x00_status_entry(scsi_qla_host_t *vha, struct rsp_que *rsp, void *pkt)
 		return;
 	}
 
+	if (sp->abort)
+		sp->aborted = 1;
+	else
+		sp->completed = 1;
+
 	if (sp->cmd_type != TYPE_SRB) {
 		req->outstanding_cmds[handle] = NULL;
 		ql_dbg(ql_dbg_io, vha, 0x3015,
diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index 6cc19e060afc..941aa53363f5 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -224,8 +224,8 @@ static void qla_nvme_abort_work(struct work_struct *work)
 
 	if (ha->flags.host_shutting_down) {
 		ql_log(ql_log_info, sp->fcport->vha, 0xffff,
-		    "%s Calling done on sp: %p, type: 0x%x, sp->ref_count: 0x%x\n",
-		    __func__, sp, sp->type, atomic_read(&sp->ref_count));
+		    "%s Calling done on sp: %p, type: 0x%x\n",
+		    __func__, sp, sp->type);
 		sp->done(sp, 0);
 		goto out;
 	}
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 2e7a4a2d6c5a..b59d579834ea 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -698,11 +698,6 @@ void qla2x00_sp_compl(srb_t *sp, int res)
 	struct scsi_cmnd *cmd = GET_CMD_SP(sp);
 	struct completion *comp = sp->comp;
 
-	if (WARN_ON_ONCE(atomic_read(&sp->ref_count) == 0))
-		return;
-
-	atomic_dec(&sp->ref_count);
-
 	sp->free(sp);
 	cmd->result = res;
 	CMD_SP(cmd) = NULL;
@@ -794,11 +789,6 @@ void qla2xxx_qpair_sp_compl(srb_t *sp, int res)
 	struct scsi_cmnd *cmd = GET_CMD_SP(sp);
 	struct completion *comp = sp->comp;
 
-	if (WARN_ON_ONCE(atomic_read(&sp->ref_count) == 0))
-		return;
-
-	atomic_dec(&sp->ref_count);
-
 	sp->free(sp);
 	cmd->result = res;
 	CMD_SP(cmd) = NULL;
@@ -903,7 +893,7 @@ qla2xxx_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
 
 	sp->u.scmd.cmd = cmd;
 	sp->type = SRB_SCSI_CMD;
-	atomic_set(&sp->ref_count, 1);
+
 	CMD_SP(cmd) = (void *)sp;
 	sp->free = qla2x00_sp_free_dma;
 	sp->done = qla2x00_sp_compl;
@@ -985,11 +975,9 @@ qla2xxx_mqueuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd,
 
 	sp->u.scmd.cmd = cmd;
 	sp->type = SRB_SCSI_CMD;
-	atomic_set(&sp->ref_count, 1);
 	CMD_SP(cmd) = (void *)sp;
 	sp->free = qla2xxx_qpair_sp_free_dma;
 	sp->done = qla2xxx_qpair_sp_compl;
-	sp->qpair = qpair;
 
 	rval = ha->isp_ops->start_scsi_mq(sp);
 	if (rval != QLA_SUCCESS) {
@@ -1187,16 +1175,6 @@ qla2x00_wait_for_chip_reset(scsi_qla_host_t *vha)
 	return return_status;
 }
 
-static int
-sp_get(struct srb *sp)
-{
-	if (!refcount_inc_not_zero((refcount_t *)&sp->ref_count))
-		/* kref get fail */
-		return ENXIO;
-	else
-		return 0;
-}
-
 #define ISP_REG_DISCONNECT 0xffffffffU
 /**************************************************************************
 * qla2x00_isp_reg_stat
@@ -1252,6 +1230,9 @@ qla2xxx_eh_abort(struct scsi_cmnd *cmd)
 	uint64_t lun;
 	int rval;
 	struct qla_hw_data *ha = vha->hw;
+	uint32_t ratov_j;
+	struct qla_qpair *qpair;
+	unsigned long flags;
 
 	if (qla2x00_isp_reg_stat(ha)) {
 		ql_log(ql_log_info, vha, 0x8042,
@@ -1264,13 +1245,26 @@ qla2xxx_eh_abort(struct scsi_cmnd *cmd)
 		return ret;
 
 	sp = scsi_cmd_priv(cmd);
+	qpair = sp->qpair;
 
-	if (sp->fcport && sp->fcport->deleted)
+	if ((sp->fcport && sp->fcport->deleted) || !qpair)
 		return SUCCESS;
 
-	/* Return if the command has already finished. */
-	if (sp_get(sp))
+	spin_lock_irqsave(qpair->qp_lock_ptr, flags);
+	if (sp->completed) {
+		spin_unlock_irqrestore(qpair->qp_lock_ptr, flags);
 		return SUCCESS;
+	}
+
+	if (sp->abort || sp->aborted) {
+		spin_unlock_irqrestore(qpair->qp_lock_ptr, flags);
+		return FAILED;
+	}
+
+	sp->abort = 1;
+	sp->comp = &comp;
+	spin_unlock_irqrestore(qpair->qp_lock_ptr, flags);
+
 
 	id = cmd->device->id;
 	lun = cmd->device->lun;
@@ -1279,47 +1273,37 @@ qla2xxx_eh_abort(struct scsi_cmnd *cmd)
 	    "Aborting from RISC nexus=%ld:%d:%llu sp=%p cmd=%p handle=%x\n",
 	    vha->host_no, id, lun, sp, cmd, sp->handle);
 
+	/*
+	 * Abort will release the original Command/sp from FW. Let the
+	 * original command call scsi_done. In return, he will wakeup
+	 * this sleeping thread.
+	 */
 	rval = ha->isp_ops->abort_command(sp);
+
 	ql_dbg(ql_dbg_taskm, vha, 0x8003,
 	       "Abort command mbx cmd=%p, rval=%x.\n", cmd, rval);
 
+	/* Wait for the command completion. */
+	ratov_j = ha->r_a_tov/10 * 4 * 1000;
+	ratov_j = msecs_to_jiffies(ratov_j);
 	switch (rval) {
 	case QLA_SUCCESS:
-		/*
-		 * The command has been aborted. That means that the firmware
-		 * won't report a completion.
-		 */
-		sp->done(sp, DID_ABORT << 16);
-		ret = SUCCESS;
-		break;
-	case QLA_FUNCTION_PARAMETER_ERROR: {
-		/* Wait for the command completion. */
-		uint32_t ratov = ha->r_a_tov/10;
-		uint32_t ratov_j = msecs_to_jiffies(4 * ratov * 1000);
-
-		WARN_ON_ONCE(sp->comp);
-		sp->comp = &comp;
 		if (!wait_for_completion_timeout(&comp, ratov_j)) {
 			ql_dbg(ql_dbg_taskm, vha, 0xffff,
 			    "%s: Abort wait timer (4 * R_A_TOV[%d]) expired\n",
-			    __func__, ha->r_a_tov);
+			    __func__, ha->r_a_tov/10);
 			ret = FAILED;
 		} else {
 			ret = SUCCESS;
 		}
 		break;
-	}
 	default:
-		/*
-		 * Either abort failed or abort and completion raced. Let
-		 * the SCSI core retry the abort in the former case.
-		 */
 		ret = FAILED;
 		break;
 	}
 
 	sp->comp = NULL;
-	atomic_dec(&sp->ref_count);
+
 	ql_log(ql_log_info, vha, 0x801c,
 	    "Abort command issued nexus=%ld:%d:%llu -- %x.\n",
 	    vha->host_no, id, lun, ret);
@@ -1711,32 +1695,53 @@ static void qla2x00_abort_srb(struct qla_qpair *qp, srb_t *sp, const int res,
 	scsi_qla_host_t *vha = qp->vha;
 	struct qla_hw_data *ha = vha->hw;
 	int rval;
+	bool ret_cmd;
+	uint32_t ratov_j;
 
-	if (sp_get(sp))
+	if (qla2x00_chip_is_down(vha)) {
+		sp->done(sp, res);
 		return;
+	}
 
 	if (sp->type == SRB_NVME_CMD || sp->type == SRB_NVME_LS ||
 	    (sp->type == SRB_SCSI_CMD && !ha->flags.eeh_busy &&
 	     !test_bit(ABORT_ISP_ACTIVE, &vha->dpc_flags) &&
 	     !qla2x00_isp_reg_stat(ha))) {
+		if (sp->comp) {
+			sp->done(sp, res);
+			return;
+		}
+
 		sp->comp = &comp;
+		sp->abort =  1;
 		spin_unlock_irqrestore(qp->qp_lock_ptr, *flags);
-		rval = ha->isp_ops->abort_command(sp);
 
+		rval = ha->isp_ops->abort_command(sp);
+		/* Wait for command completion. */
+		ret_cmd = false;
+		ratov_j = ha->r_a_tov/10 * 4 * 1000;
+		ratov_j = msecs_to_jiffies(ratov_j);
 		switch (rval) {
 		case QLA_SUCCESS:
-			sp->done(sp, res);
+			if (wait_for_completion_timeout(&comp, ratov_j)) {
+				ql_dbg(ql_dbg_taskm, vha, 0xffff,
+				    "%s: Abort wait timer (4 * R_A_TOV[%d]) expired\n",
+				    __func__, ha->r_a_tov/10);
+				ret_cmd = true;
+			}
+			/* else FW return SP to driver */
 			break;
-		case QLA_FUNCTION_PARAMETER_ERROR:
-			wait_for_completion(&comp);
+		default:
+			ret_cmd = true;
 			break;
 		}
 
 		spin_lock_irqsave(qp->qp_lock_ptr, *flags);
-		sp->comp = NULL;
+		if (ret_cmd && (!sp->completed || !sp->aborted))
+			sp->done(sp, res);
+	} else {
+		sp->done(sp, res);
 	}
-
-	atomic_dec(&sp->ref_count);
 }
 
 static void
@@ -1758,7 +1763,6 @@ __qla2x00_abort_all_cmds(struct qla_qpair *qp, int res)
 	for (cnt = 1; cnt < req->num_outstanding_cmds; cnt++) {
 		sp = req->outstanding_cmds[cnt];
 		if (sp) {
-			req->outstanding_cmds[cnt] = NULL;
 			switch (sp->cmd_type) {
 			case TYPE_SRB:
 				qla2x00_abort_srb(qp, sp, res, &flags);
@@ -1780,6 +1784,7 @@ __qla2x00_abort_all_cmds(struct qla_qpair *qp, int res)
 			default:
 				break;
 			}
+			req->outstanding_cmds[cnt] = NULL;
 		}
 	}
 	spin_unlock_irqrestore(qp->qp_lock_ptr, flags);
-- 
2.12.0

