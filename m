Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 010062C9977
	for <lists+linux-scsi@lfdr.de>; Tue,  1 Dec 2020 09:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgLAIaP (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 1 Dec 2020 03:30:15 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:60994 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726415AbgLAIaP (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 1 Dec 2020 03:30:15 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B18LctX009899
        for <linux-scsi@vger.kernel.org>; Tue, 1 Dec 2020 00:29:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=CxDJuc+w1TNKnGZKEa9UjipFEM2yz02nGvXU4LAHtX4=;
 b=kfVCWbyPQnYkaciKpI+czl6FQ6EvQdSMMTSHKbUqIFQaVDDU0xKXDh7ml0zAvR4RFys7
 KDV8NHGsXMUDHutajs3UfLEP69djtBejzjMMSxfIqMB+RWYRud0+lrN7rnG+d0/dgXlT
 0oZvux+JoN0oFrb7/BLgnS+f3C946cgF6NvEPylb5872bv7zqejNBbYG+Bn612PsEWKX
 vqXPP4BX+wa1zWfuhX2AUnSh0ZcChXn6BFceQCrPgaxHw0Wbtpglpno8h7fJ+wUfr7Ph
 IZN1jy/KwrETtHoFyM1ifzleIIQdtd0EQuTo4DaAS8MwCwp/MCCkKsw4VRLM4/NknhcO wg== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 353pxsf717-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Tue, 01 Dec 2020 00:29:33 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 1 Dec
 2020 00:29:31 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 1 Dec 2020 00:29:31 -0800
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id 9DCA43F703F;
        Tue,  1 Dec 2020 00:29:31 -0800 (PST)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id 0B18TVKT024225;
        Tue, 1 Dec 2020 00:29:31 -0800
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id 0B18TVZb024224;
        Tue, 1 Dec 2020 00:29:31 -0800
From:   Nilesh Javali <njavali@marvell.com>
To:     <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>
Subject: [PATCH 04/15] qla2xxx: tear down session if FW say its down
Date:   Tue, 1 Dec 2020 00:27:19 -0800
Message-ID: <20201201082730.24158-5-njavali@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20201201082730.24158-1-njavali@marvell.com>
References: <20201201082730.24158-1-njavali@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-01_01:2020-11-30,2020-12-01 signatures=0
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Quinn Tran <qutran@marvell.com>

The completion status 0x28 (ppc = be = 0x2800) below indicate session
is not there, trigger session deletion.

qla2xxx [000b:04:00.1]-8009:8: DEVICE RESET ISSUED nexus=8:1:51 cmd=c000001432d0f600.
qla2xxx [000b:04:00.1]-5039:8: Async-tmf error - hdl=67b completion status(2800).
qla2xxx [000b:04:00.1]-8030:8: TM IOCB failed (102).
qla2xxx [000b:04:00.1]-800c:8: do_reset failed for cmd=c000001432d0f600.
qla2xxx [000b:04:00.1]-800f:8: DEVICE RESET FAILED: Task management failed nexus=8:1:51 cmd=c000001432d0f600.
qla2xxx [000b:04:00.1]-8009:8: DEVICE RESET ISSUED nexus=8:1:52 cmd=c000001432d0c200.
qla2xxx [000b:04:00.1]-5039:8: Async-tmf error - hdl=67c completion status(2800).
qla2xxx [000b:04:00.1]-8030:8: TM IOCB failed (102).

Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
---
 drivers/scsi/qla2xxx/qla_isr.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index 77dd7630c3f8..f9142dbec112 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -2226,11 +2226,13 @@ qla24xx_tm_iocb_entry(scsi_qla_host_t *vha, struct req_que *req, void *tsk)
 	srb_t *sp;
 	struct srb_iocb *iocb;
 	struct sts_entry_24xx *sts = (struct sts_entry_24xx *)tsk;
+	u16 comp_status;
 
 	sp = qla2x00_get_sp_from_handle(vha, func, req, tsk);
 	if (!sp)
 		return;
 
+	comp_status = le16_to_cpu(sts->comp_status);
 	iocb = &sp->u.iocb_cmd;
 	type = sp->name;
 	fcport = sp->fcport;
@@ -2244,7 +2246,7 @@ qla24xx_tm_iocb_entry(scsi_qla_host_t *vha, struct req_que *req, void *tsk)
 	} else if (sts->comp_status != cpu_to_le16(CS_COMPLETE)) {
 		ql_log(ql_log_warn, fcport->vha, 0x5039,
 		    "Async-%s error - hdl=%x completion status(%x).\n",
-		    type, sp->handle, sts->comp_status);
+		    type, sp->handle, comp_status);
 		iocb->u.tmf.data = QLA_FUNCTION_FAILED;
 	} else if ((le16_to_cpu(sts->scsi_status) &
 	    SS_RESPONSE_INFO_LEN_VALID)) {
@@ -2260,6 +2262,30 @@ qla24xx_tm_iocb_entry(scsi_qla_host_t *vha, struct req_que *req, void *tsk)
 		}
 	}
 
+	switch (comp_status) {
+	case CS_PORT_LOGGED_OUT:
+	case CS_PORT_CONFIG_CHG:
+	case CS_PORT_BUSY:
+	case CS_INCOMPLETE:
+	case CS_PORT_UNAVAILABLE:
+	case CS_TIMEOUT:
+	case CS_RESET:
+		if (atomic_read(&fcport->state) == FCS_ONLINE) {
+			ql_dbg(ql_dbg_disc, fcport->vha, 0x3021,
+			       "-Port to be marked lost on fcport=%02x%02x%02x, current port state= %s comp_status %x.\n",
+			       fcport->d_id.b.domain, fcport->d_id.b.area,
+			       fcport->d_id.b.al_pa,
+			       port_state_str[FCS_ONLINE],
+			       comp_status);
+
+			qlt_schedule_sess_for_deletion(fcport);
+		}
+		break;
+
+	default:
+		break;
+	}
+
 	if (iocb->u.tmf.data != QLA_SUCCESS)
 		ql_dump_buffer(ql_dbg_async + ql_dbg_buffer, sp->vha, 0x5055,
 		    sts, sizeof(*sts));
-- 
2.19.0.rc0

