Return-Path: <linux-scsi+bounces-9946-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E939CDED6
	for <lists+linux-scsi@lfdr.de>; Fri, 15 Nov 2024 14:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85AFB283AA2
	for <lists+linux-scsi@lfdr.de>; Fri, 15 Nov 2024 13:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099FB1B85D7;
	Fri, 15 Nov 2024 13:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="dc6qbpLf"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0413B1B6CF9
	for <linux-scsi@vger.kernel.org>; Fri, 15 Nov 2024 13:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731675818; cv=none; b=WzouYrgUwlFZx7tGvshiYiSlc7SGihZxPS+mVVbzQek7wGAn3vVrmZKtULut6slbylrkYudBZKq20IhLrQ7dBDoz1zSuVWehcx2gKus6SL4ubOpWnuGP7nDD/Pk4b86LEREczUm9s+WkeiACa54CgH5qUCSeQn04nQIG9aSEzrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731675818; c=relaxed/simple;
	bh=CQ6iI1aOe6ov0k9N3r4Es1sAJgIOXJDLaGZkvXllXFs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H9nw2d/vPjYmzV5Mma5GDVRlM0SAM+GSjE3TNql42FIcAtVuc0LmNJHFeKIC5XTPN7JzKPMdaHu5Ajznpfj9JhaJEOTzb4fScGRkuRs7xvgPhq9AQeBkO0NpTeFvUenOoslFHEYD1sdu6p+1IfbRL1p7ukqFzeMwVRhU+q3Mwug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=dc6qbpLf; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF7YIB9011764;
	Fri, 15 Nov 2024 05:03:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=U
	5bmrhHH+nZhUP1K6Xi7AhC0QEQUoLXEdw6onNQpwX8=; b=dc6qbpLfg+W0c+yZb
	p8UPxXMKtLycfTgtw4F2VYytdbRXIe4EFQH9eal15FfvKB/vb/kRd20dWM/J58aR
	83iOsLSidE0oocqpz7ugh+0Zz6OuiH/ku/gD+3Xa8xSboWyM+gP3NUgvElYsFIOi
	Th+7h7tRHM4HE0hE8dHrdsdqyb5PJTScou55D/W9VbEArDvhxtQzAkDdRfDi6+j4
	tW1IZ02AqVib81+rRUE8REeIupiSUYEaOZbLQDznxLILPQCEgfMZLClMHpIzoYeO
	GGgqhtSotGlPlOCR3piZf1t+82RfBlHqbPqjn1oAKNHzuoS+Sn/H/+WWPr7/3/E7
	oNyNg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42x2128e70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 05:03:34 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 15 Nov 2024 05:03:32 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 15 Nov 2024 05:03:32 -0800
Received: from stgdev-a5u16.punelab.marvell.com (stgdev-a5u16.punelab.marvell.com [10.31.33.187])
	by maili.marvell.com (Postfix) with ESMTP id 5D6963F7075;
	Fri, 15 Nov 2024 05:03:30 -0800 (PST)
From: Nilesh Javali <njavali@marvell.com>
To: <martin.petersen@oracle.com>
CC: <linux-scsi@vger.kernel.org>, <GR-QLogic-Storage-Upstream@marvell.com>,
        <agurumurthy@marvell.com>, <sdeodhar@marvell.com>, <emilne@redhat.com>,
        <jmeneghi@redhat.com>
Subject: [PATCH 1/7] qla2xxx: fix abort in bsg timeout
Date: Fri, 15 Nov 2024 18:33:07 +0530
Message-ID: <20241115130313.46826-2-njavali@marvell.com>
X-Mailer: git-send-email 2.23.1
In-Reply-To: <20241115130313.46826-1-njavali@marvell.com>
References: <20241115130313.46826-1-njavali@marvell.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: ZrflM6oU7nktbAXUNnqtRQ-VFifDrubh
X-Proofpoint-ORIG-GUID: ZrflM6oU7nktbAXUNnqtRQ-VFifDrubh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

From: Quinn Tran <qutran@marvell.com>

Current abort of bsg on timeout, prematurely clears
the outstanding_cmds[]. Abort does not allow FW to return
the IOCB/SRB. In addition, bsg_job_done is not called to
return the BSG (ie leak).

The change will abort the outstanding bsg/srb, wait
for the completion of the BSG. The completion iocb
will wake up the bsg_timeout thread. If abort is not
successful, then driver will forcibly bsg_job_done and
free the srb.

Err Inject:
 - qaucli -z
 - assign CT Passthru IOCB's NportHandle with another initiator
   nport handle to trigger timeout.  Remote port will drop CT request.
 - bsg_job_done is properly called as part of cleanup

kernel: qla2xxx [0000:21:00.1]-7012:7: qla2x00_process_ct : 286 : Error Inject.
kernel: qla2xxx [0000:21:00.1]-7016:7: bsg rqst type: FC_BSG_HST_CT else type: 101 - loop-id=1 portid=fffffa.
kernel: qla2xxx [0000:21:00.1]-70bb:7: qla24xx_bsg_timeout CMD timeout. bsg ptr ffff9971a42f0838 msgcode 80000004 vendor cmd fa010000
kernel: qla2xxx [0000:21:00.1]-507c:7: Abort command issued - hdl=4b, type=5
kernel: qla2xxx [0000:21:00.1]-5040:7: ELS-CT pass-through-ct pass-through error hdl=4b comp_status-status=0x5 error subcode 1=0x0 error subcode 2=0xaf882e80.
kernel: qla2xxx [0000:21:00.1]-7009:7: qla2x00_bsg_job_done: sp hdl 4b, result=70000 bsg ptr ffff9971a42f0838
kernel: qla2xxx [0000:21:00.1]-802c:7: Aborting bsg ffff9971a42f0838 sp=ffff99760b87ba80 handle=4b rval=0
kernel: qla2xxx [0000:21:00.1]-708a:7: bsg abort success. bsg ffff9971a42f0838 sp=ffff99760b87ba80 handle=0x4b

--

kernel: qla2xxx [0000:21:00.1]-7012:7: qla2x00_process_ct : 286 : Error Inject.
kernel: qla2xxx [0000:21:00.1]-7016:7: bsg rqst type: FC_BSG_HST_CT else type: 101 - loop-id=1 portid=fffffa.
kernel: qla2xxx [0000:21:00.1]-70bb:7: qla24xx_bsg_timeout CMD timeout. bsg ptr ffff9971a42f43b8 msgcode 80000004 vendor cmd fa010000
kernel: qla2xxx [0000:21:00.1]-7012:7: qla_bsg_found : 2206 : Error Inject 2.
kernel: qla2xxx [0000:21:00.1]-802c:7: Aborting bsg ffff9971a42f43b8 sp=ffff99762c304440 handle=5e rval=5
kernel: qla2xxx [0000:21:00.1]-704f:7: bsg abort fail.  bsg=ffff9971a42f43b8 sp=ffff99762c304440 rval=5.
kernel: qla2xxx [0000:21:00.1]-7051:7: qla_bsg_found bsg_job_done : bsg ffff9971a42f43b8 result 0xfffffffa sp ffff99762c304440.

Cc: stable@vger.kernel.org
Fixes: c449b4198701 ("scsi: qla2xxx: Use QP lock to search for bsg")
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
---
 drivers/scsi/qla2xxx/qla_bsg.c | 114 ++++++++++++++++++++++++++-------
 1 file changed, 92 insertions(+), 22 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_bsg.c b/drivers/scsi/qla2xxx/qla_bsg.c
index 52dc9604f567..981ac1986cbe 100644
--- a/drivers/scsi/qla2xxx/qla_bsg.c
+++ b/drivers/scsi/qla2xxx/qla_bsg.c
@@ -24,6 +24,7 @@ void qla2x00_bsg_job_done(srb_t *sp, int res)
 {
 	struct bsg_job *bsg_job = sp->u.bsg_job;
 	struct fc_bsg_reply *bsg_reply = bsg_job->reply;
+	struct completion *comp = sp->comp;
 
 	ql_dbg(ql_dbg_user, sp->vha, 0x7009,
 	    "%s: sp hdl %x, result=%x bsg ptr %p\n",
@@ -35,6 +36,9 @@ void qla2x00_bsg_job_done(srb_t *sp, int res)
 	bsg_reply->result = res;
 	bsg_job_done(bsg_job, bsg_reply->result,
 		       bsg_reply->reply_payload_rcv_len);
+
+	if (comp)
+		complete(comp);
 }
 
 void qla2x00_bsg_sp_free(srb_t *sp)
@@ -3061,7 +3065,7 @@ qla24xx_bsg_request(struct bsg_job *bsg_job)
 
 static bool qla_bsg_found(struct qla_qpair *qpair, struct bsg_job *bsg_job)
 {
-	bool found = false;
+	bool found, do_bsg_done;
 	struct fc_bsg_reply *bsg_reply = bsg_job->reply;
 	scsi_qla_host_t *vha = shost_priv(fc_bsg_to_shost(bsg_job));
 	struct qla_hw_data *ha = vha->hw;
@@ -3069,6 +3073,11 @@ static bool qla_bsg_found(struct qla_qpair *qpair, struct bsg_job *bsg_job)
 	int cnt;
 	unsigned long flags;
 	struct req_que *req;
+	int rval;
+	DECLARE_COMPLETION_ONSTACK(comp);
+	uint32_t ratov_j;
+
+	found = do_bsg_done = false;
 
 	spin_lock_irqsave(qpair->qp_lock_ptr, flags);
 	req = qpair->req;
@@ -3080,42 +3089,104 @@ static bool qla_bsg_found(struct qla_qpair *qpair, struct bsg_job *bsg_job)
 		     sp->type == SRB_ELS_CMD_HST ||
 		     sp->type == SRB_ELS_CMD_HST_NOLOGIN) &&
 		    sp->u.bsg_job == bsg_job) {
-			req->outstanding_cmds[cnt] = NULL;
-			spin_unlock_irqrestore(qpair->qp_lock_ptr, flags);
-
-			if (!ha->flags.eeh_busy && ha->isp_ops->abort_command(sp)) {
-				ql_log(ql_log_warn, vha, 0x7089,
-						"mbx abort_command failed.\n");
-				bsg_reply->result = -EIO;
-			} else {
-				ql_dbg(ql_dbg_user, vha, 0x708a,
-						"mbx abort_command success.\n");
-				bsg_reply->result = 0;
-			}
-			/* ref: INIT */
-			kref_put(&sp->cmd_kref, qla2x00_sp_release);
 
 			found = true;
-			goto done;
+			sp->comp = &comp;
+			break;
 		}
 	}
 	spin_unlock_irqrestore(qpair->qp_lock_ptr, flags);
 
-done:
-	return found;
+	if (!found)
+		return false;
+
+	if (ha->flags.eeh_busy) {
+		/* skip over abort.  EEH handling will return the bsg. Wait for it */
+		rval = QLA_SUCCESS;
+		ql_dbg(ql_dbg_user, vha, 0x802c,
+			"eeh encounter. bsg %p sp=%p handle=%x \n",
+			bsg_job, sp, sp->handle);
+	} else {
+		rval = ha->isp_ops->abort_command(sp);
+		ql_dbg(ql_dbg_user, vha, 0x802c,
+			"Aborting bsg %p sp=%p handle=%x rval=%x\n",
+			bsg_job, sp, sp->handle, rval);
+	}
+
+	switch (rval) {
+	case QLA_SUCCESS:
+		/* Wait for the command completion. */
+		ratov_j = ha->r_a_tov / 10 * 4 * 1000;
+		ratov_j = msecs_to_jiffies(ratov_j);
+
+		if (!wait_for_completion_timeout(&comp, ratov_j)) {
+			ql_log(ql_log_info, vha, 0x7089,
+				"bsg abort timeout.  bsg=%p sp=%p handle %#x .\n",
+				bsg_job, sp, sp->handle);
+
+			do_bsg_done = true;
+		} else {
+			/* fw had returned the bsg */
+			ql_dbg(ql_dbg_user, vha, 0x708a,
+				"bsg abort success. bsg %p sp=%p handle=%#x\n",
+				bsg_job, sp, sp->handle);
+			do_bsg_done = false;
+		}
+		break;
+	default:
+		ql_log(ql_log_info, vha, 0x704f,
+			"bsg abort fail.  bsg=%p sp=%p rval=%x.\n",
+			bsg_job, sp, rval);
+
+		do_bsg_done = true;
+		break;
+	}
+
+	if (!do_bsg_done)
+		return true;
+
+	spin_lock_irqsave(qpair->qp_lock_ptr, flags);
+	/*
+	 * recheck to make sure it's still the same bsg_job due to
+	 * qp_lock_ptr was released earlier.
+	 */
+	if (req->outstanding_cmds[cnt] &&
+	    req->outstanding_cmds[cnt]->u.bsg_job != bsg_job) {
+		/* fw had returned the bsg */
+		spin_unlock_irqrestore(qpair->qp_lock_ptr, flags);
+		return true;
+	}
+	req->outstanding_cmds[cnt] = NULL;
+	spin_unlock_irqrestore(qpair->qp_lock_ptr, flags);
+
+	/* ref: INIT */
+	sp->comp = NULL;
+	kref_put(&sp->cmd_kref, qla2x00_sp_release);
+	bsg_reply->result = -ENXIO;
+	bsg_reply->reply_payload_rcv_len = 0;
+
+	ql_dbg(ql_dbg_user, vha, 0x7051,
+	       "%s bsg_job_done : bsg %p result %#x sp %p.\n",
+	       __func__, bsg_job, bsg_reply->result, sp);
+
+	bsg_job_done(bsg_job, bsg_reply->result, bsg_reply->reply_payload_rcv_len);
+
+	return true;
 }
 
 int
 qla24xx_bsg_timeout(struct bsg_job *bsg_job)
 {
-	struct fc_bsg_reply *bsg_reply = bsg_job->reply;
+	struct fc_bsg_request *bsg_request = bsg_job->request;
 	scsi_qla_host_t *vha = shost_priv(fc_bsg_to_shost(bsg_job));
 	struct qla_hw_data *ha = vha->hw;
 	int i;
 	struct qla_qpair *qpair;
 
-	ql_log(ql_log_info, vha, 0x708b, "%s CMD timeout. bsg ptr %p.\n",
-	    __func__, bsg_job);
+	ql_log(ql_log_info, vha, 0x708b,
+	       "%s CMD timeout. bsg ptr %p msgcode %x vendor cmd %x\n",
+	       __func__, bsg_job, bsg_request->msgcode,
+	       bsg_request->rqst_data.h_vendor.vendor_cmd[0]);
 
 	if (qla2x00_isp_reg_stat(ha)) {
 		ql_log(ql_log_info, vha, 0x9007,
@@ -3136,7 +3207,6 @@ qla24xx_bsg_timeout(struct bsg_job *bsg_job)
 	}
 
 	ql_log(ql_log_info, vha, 0x708b, "SRB not found to abort.\n");
-	bsg_reply->result = -ENXIO;
 
 done:
 	return 0;
-- 
2.23.1


