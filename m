Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 822D02EA52C
	for <lists+linux-scsi@lfdr.de>; Tue,  5 Jan 2021 07:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbhAEGFz (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 5 Jan 2021 01:05:55 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:46180 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727234AbhAEGFz (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 5 Jan 2021 01:05:55 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10560L2t025117
        for <linux-scsi@vger.kernel.org>; Mon, 4 Jan 2021 22:05:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=tCeNIiPa1j54b4+yy7wTy3DCkJd1UOkLSVQXvVb+IKg=;
 b=MfvieItjIeJK/pnQnG4/UhE5duvR0zvYYAYWbDfwmV3bbg9HOfnoSf6GX11vUoRR3L07
 yzT+4LBaz0V6lrYeu65nuPtqusfD0BsJceNhpRlRd8xIgt8bGiubpuBS7UgnUs5PFGsa
 PPmXwVBDPjQ+2FXp6OuvHG22CmSoz8mc7QFw69Q0v4BcttRvYVt2Lt+nwIzQ7dy44LPj
 V2IhTuGgYJjrMYIUqPQjaVtlLhJybPWy76tSQZ1/8fJchAVksAjL6pLzc2Z6Tm9ahxP5
 ia6q9E7Rj9xYSSzEKoyjeEfJ2v7xYon7rMzZayV1opBJCF/ga+ydE7TQJ5NvDSn2P10L 7w== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 35tq2udnqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Mon, 04 Jan 2021 22:05:14 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 4 Jan
 2021 22:05:12 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 4 Jan
 2021 22:05:12 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 4 Jan 2021 22:05:12 -0800
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id 3892A3F703F;
        Mon,  4 Jan 2021 22:05:12 -0800 (PST)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id 10565CD6020323;
        Mon, 4 Jan 2021 22:05:12 -0800
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id 10565CN0020322;
        Mon, 4 Jan 2021 22:05:12 -0800
From:   Nilesh Javali <njavali@marvell.com>
To:     <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>
Subject: [PATCH v2 3/7] qla2xxx: Move some messages from debug to normal log level
Date:   Mon, 4 Jan 2021 22:03:31 -0800
Message-ID: <20210105060335.20267-4-njavali@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20210105060335.20267-1-njavali@marvell.com>
References: <20210105060335.20267-1-njavali@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-05_01:2021-01-04,2021-01-05 signatures=0
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Saurav Kashyap <skashyap@marvell.com>

This change will aid in debugging issues where debug level is not set.

Signed-off-by: Saurav Kashyap <skashyap@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
---
 drivers/scsi/qla2xxx/qla_init.c | 10 +++----
 drivers/scsi/qla2xxx/qla_isr.c  | 52 ++++++++++++++++-----------------
 2 files changed, 30 insertions(+), 32 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 410ff5534a59..221369cdf71f 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -347,11 +347,11 @@ qla2x00_async_login(struct scsi_qla_host *vha, fc_port_t *fcport,
 	if (NVME_TARGET(vha->hw, fcport))
 		lio->u.logio.flags |= SRB_LOGIN_SKIP_PRLI;
 
-	ql_dbg(ql_dbg_disc, vha, 0x2072,
-	    "Async-login - %8phC hdl=%x, loopid=%x portid=%02x%02x%02x "
-		"retries=%d.\n", fcport->port_name, sp->handle, fcport->loop_id,
-	    fcport->d_id.b.domain, fcport->d_id.b.area, fcport->d_id.b.al_pa,
-	    fcport->login_retry);
+	ql_log(ql_log_warn, vha, 0x2072,
+	       "Async-login - %8phC hdl=%x, loopid=%x portid=%02x%02x%02x retries=%d.\n",
+	       fcport->port_name, sp->handle, fcport->loop_id,
+	       fcport->d_id.b.domain, fcport->d_id.b.area, fcport->d_id.b.al_pa,
+	       fcport->login_retry);
 
 	rval = qla2x00_start_sp(sp);
 	if (rval != QLA_SUCCESS) {
diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index 9cf8326ab9fc..bfc8bbaeea46 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -1455,9 +1455,9 @@ qla2x00_async_event(scsi_qla_host_t *vha, struct rsp_que *rsp, uint16_t *mb)
 		if (ha->flags.npiv_supported && vha->vp_idx != (mb[3] & 0xff))
 			break;
 
-		ql_dbg(ql_dbg_async, vha, 0x5013,
-		    "RSCN database changed -- %04x %04x %04x.\n",
-		    mb[1], mb[2], mb[3]);
+		ql_log(ql_log_warn, vha, 0x5013,
+		       "RSCN database changed -- %04x %04x %04x.\n",
+		       mb[1], mb[2], mb[3]);
 
 		rscn_entry = ((mb[1] & 0xff) << 16) | mb[2];
 		host_pid = (vha->d_id.b.domain << 16) | (vha->d_id.b.area << 8)
@@ -2221,12 +2221,12 @@ qla24xx_logio_entry(scsi_qla_host_t *vha, struct req_que *req,
 		break;
 	}
 
-	ql_dbg(ql_dbg_async, sp->vha, 0x5037,
-	    "Async-%s failed: handle=%x pid=%06x wwpn=%8phC comp_status=%x iop0=%x iop1=%x\n",
-	    type, sp->handle, fcport->d_id.b24, fcport->port_name,
-	    le16_to_cpu(logio->comp_status),
-	    le32_to_cpu(logio->io_parameter[0]),
-	    le32_to_cpu(logio->io_parameter[1]));
+	ql_log(ql_log_warn, sp->vha, 0x5037,
+	       "Async-%s failed: handle=%x pid=%06x wwpn=%8phC comp_status=%x iop0=%x iop1=%x\n",
+	       type, sp->handle, fcport->d_id.b24, fcport->port_name,
+	       le16_to_cpu(logio->comp_status),
+	       le32_to_cpu(logio->io_parameter[0]),
+	       le32_to_cpu(logio->io_parameter[1]));
 
 logio_done:
 	sp->done(sp, 0);
@@ -2389,9 +2389,9 @@ static void qla24xx_nvme_iocb_entry(scsi_qla_host_t *vha, struct req_que *req,
 
 		tgt_xfer_len = be32_to_cpu(rsp_iu->xfrd_len);
 		if (fd->transferred_length != tgt_xfer_len) {
-			ql_dbg(ql_dbg_io, fcport->vha, 0x3079,
-				"Dropped frame(s) detected (sent/rcvd=%u/%u).\n",
-				tgt_xfer_len, fd->transferred_length);
+			ql_log(ql_log_warn, fcport->vha, 0x3079,
+			       "Dropped frame(s) detected (sent/rcvd=%u/%u).\n",
+			       tgt_xfer_len, fd->transferred_length);
 			logit = 1;
 		} else if (le16_to_cpu(comp_status) == CS_DATA_UNDERRUN) {
 			/*
@@ -3112,9 +3112,9 @@ qla2x00_status_entry(scsi_qla_host_t *vha, struct rsp_que *rsp, void *pkt)
 		scsi_set_resid(cp, resid);
 		if (scsi_status & SS_RESIDUAL_UNDER) {
 			if (IS_FWI2_CAPABLE(ha) && fw_resid_len != resid_len) {
-				ql_dbg(ql_dbg_io, fcport->vha, 0x301d,
-				    "Dropped frame(s) detected (0x%x of 0x%x bytes).\n",
-				    resid, scsi_bufflen(cp));
+				ql_log(ql_log_warn, fcport->vha, 0x301d,
+				       "Dropped frame(s) detected (0x%x of 0x%x bytes).\n",
+				       resid, scsi_bufflen(cp));
 
 				vha->interface_err_cnt++;
 
@@ -3139,9 +3139,9 @@ qla2x00_status_entry(scsi_qla_host_t *vha, struct rsp_que *rsp, void *pkt)
 			 * task not completed.
 			 */
 
-			ql_dbg(ql_dbg_io, fcport->vha, 0x301f,
-			    "Dropped frame(s) detected (0x%x of 0x%x bytes).\n",
-			    resid, scsi_bufflen(cp));
+			ql_log(ql_log_warn, fcport->vha, 0x301f,
+			       "Dropped frame(s) detected (0x%x of 0x%x bytes).\n",
+			       resid, scsi_bufflen(cp));
 
 			vha->interface_err_cnt++;
 
@@ -3257,15 +3257,13 @@ qla2x00_status_entry(scsi_qla_host_t *vha, struct rsp_que *rsp, void *pkt)
 
 out:
 	if (logit)
-		ql_dbg(ql_dbg_io, fcport->vha, 0x3022,
-		    "FCP command status: 0x%x-0x%x (0x%x) nexus=%ld:%d:%llu "
-		    "portid=%02x%02x%02x oxid=0x%x cdb=%10phN len=0x%x "
-		    "rsp_info=0x%x resid=0x%x fw_resid=0x%x sp=%p cp=%p.\n",
-		    comp_status, scsi_status, res, vha->host_no,
-		    cp->device->id, cp->device->lun, fcport->d_id.b.domain,
-		    fcport->d_id.b.area, fcport->d_id.b.al_pa, ox_id,
-		    cp->cmnd, scsi_bufflen(cp), rsp_info_len,
-		    resid_len, fw_resid_len, sp, cp);
+		ql_log(ql_log_warn, fcport->vha, 0x3022,
+		       "FCP command status: 0x%x-0x%x (0x%x) nexus=%ld:%d:%llu portid=%02x%02x%02x oxid=0x%x cdb=%10phN len=0x%x rsp_info=0x%x resid=0x%x fw_resid=0x%x sp=%p cp=%p.\n",
+		       comp_status, scsi_status, res, vha->host_no,
+		       cp->device->id, cp->device->lun, fcport->d_id.b.domain,
+		       fcport->d_id.b.area, fcport->d_id.b.al_pa, ox_id,
+		       cp->cmnd, scsi_bufflen(cp), rsp_info_len,
+		       resid_len, fw_resid_len, sp, cp);
 
 	if (rsp->status_srb == NULL)
 		sp->done(sp, res);
-- 
2.19.0.rc0

