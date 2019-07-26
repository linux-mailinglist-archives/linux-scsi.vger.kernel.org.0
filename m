Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1574476E93
	for <lists+linux-scsi@lfdr.de>; Fri, 26 Jul 2019 18:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbfGZQIG (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 26 Jul 2019 12:08:06 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:6008 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726141AbfGZQIG (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 26 Jul 2019 12:08:06 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x6QG525c017074;
        Fri, 26 Jul 2019 09:08:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=eCfovYWeFUKcQpz83RXDhPn2H0hHrIWqo9aaENfH4iA=;
 b=CK7BDp4vuZx7tm9gnPqirD9Q3swwFRh/avsRSusVFUPiEFd99r8Oxg6R3xY2wXGZlHX7
 S82fLz2/2jCt7SiTv7v+v74t3Zhx0xCoy7kcfDAZkPMhi5j+zuqncs62nWOa6tvPsyP7
 P1jdHy3IbcG8j5cdCJ7v0Ndp5PQN+/a7BeXs4q2P5xW9xiNcadWwvPmLylq0nJNCndot
 uk+kQi84ki/JAS62phK9mFnLQ7ApemZH+cFPpa+ospJYZmaHyUykrMdEcYvxV2MY7inC
 2cboilI6SYiZbYJJBUqg9WqngFDnZax4UZ7VA7WqzFF6SeI3LXeZkgHxAU7UlDcj7tjE qw== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2tx61rqjxg-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 26 Jul 2019 09:08:04 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 26 Jul
 2019 09:08:03 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Fri, 26 Jul 2019 09:08:03 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id 126D93F7041;
        Fri, 26 Jul 2019 09:08:03 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id x6QG82nn025758;
        Fri, 26 Jul 2019 09:08:02 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id x6QG82pV025757;
        Fri, 26 Jul 2019 09:08:02 -0700
From:   Himanshu Madhani <hmadhani@marvell.com>
To:     <James.Bottomley@HansenPartnership.com>,
        <martin.petersen@oracle.com>
CC:     <hmadhani@marvell.com>, <linux-scsi@vger.kernel.org>
Subject: [PATCH 07/15] qla2xxx: Fix Relogin to prevent modifying scan_state flag
Date:   Fri, 26 Jul 2019 09:07:32 -0700
Message-ID: <20190726160740.25687-8-hmadhani@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190726160740.25687-1-hmadhani@marvell.com>
References: <20190726160740.25687-1-hmadhani@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-07-26_12:2019-07-26,2019-07-26 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Quinn Tran <qutran@marvell.com>

Relogin fail to move forward due scan_state flag indicate
device is not there. Before relogin process, Session delete
process accidently modified the scan_state flag.

Fixes: 79140e2f4fa7 ("scsi: qla2xxx: Fix login state machine freeze")
Cc: stable@vger.kernel.org
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
---
 drivers/scsi/qla2xxx/qla_init.c   | 25 ++++++++++++++++++++-----
 drivers/scsi/qla2xxx/qla_os.c     |  1 +
 drivers/scsi/qla2xxx/qla_target.c |  1 -
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 68d7496a8aff..02bbc5bdaa43 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -303,8 +303,13 @@ qla2x00_async_login(struct scsi_qla_host *vha, fc_port_t *fcport,
 	struct srb_iocb *lio;
 	int rval = QLA_FUNCTION_FAILED;
 
-	if (!vha->flags.online)
-		goto done;
+	if (!vha->flags.online || (fcport->flags & FCF_ASYNC_SENT) ||
+	    fcport->loop_id == FC_NO_LOOP_ID) {
+		ql_log(ql_log_warn, vha, 0xffff,
+		    "%s: %8phC - not sending command.\n",
+		    __func__, fcport->port_name);
+		return rval;
+	}
 
 	sp = qla2x00_get_sp(vha, fcport, GFP_KERNEL);
 	if (!sp)
@@ -1276,8 +1281,13 @@ int qla24xx_async_gpdb(struct scsi_qla_host *vha, fc_port_t *fcport, u8 opt)
 	struct port_database_24xx *pd;
 	struct qla_hw_data *ha = vha->hw;
 
-	if (!vha->flags.online || (fcport->flags & FCF_ASYNC_SENT))
+	if (!vha->flags.online || (fcport->flags & FCF_ASYNC_SENT) ||
+	    fcport->loop_id == FC_NO_LOOP_ID) {
+		ql_log(ql_log_warn, vha, 0xffff,
+		    "%s: %8phC - not sending command.\n",
+		    __func__, fcport->port_name);
 		return rval;
+	}
 
 	fcport->disc_state = DSC_GPDB;
 
@@ -1967,8 +1977,11 @@ qla24xx_handle_plogi_done_event(struct scsi_qla_host *vha, struct event_arg *ea)
 		return;
 	}
 
-	if (fcport->disc_state == DSC_DELETE_PEND)
+	if ((fcport->disc_state == DSC_DELETE_PEND) ||
+	    (fcport->disc_state == DSC_DELETED)) {
+		set_bit(RELOGIN_NEEDED, &vha->dpc_flags);
 		return;
+	}
 
 	if (ea->sp->gen2 != fcport->login_gen) {
 		/* target side must have changed it. */
@@ -6712,8 +6725,10 @@ qla2x00_abort_isp_cleanup(scsi_qla_host_t *vha)
 	}
 
 	/* Clear all async request states across all VPs. */
-	list_for_each_entry(fcport, &vha->vp_fcports, list)
+	list_for_each_entry(fcport, &vha->vp_fcports, list) {
 		fcport->flags &= ~(FCF_LOGIN_NEEDED | FCF_ASYNC_SENT);
+		fcport->scan_state = 0;
+	}
 	spin_lock_irqsave(&ha->vport_slock, flags);
 	list_for_each_entry(vp, &ha->vp_list, list) {
 		atomic_inc(&vp->vref_count);
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index d416ac5d1e4c..d34f6ba36a03 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -5086,6 +5086,7 @@ void qla24xx_create_new_sess(struct scsi_qla_host *vha, struct qla_work_evt *e)
 	if (fcport) {
 		fcport->id_changed = 1;
 		fcport->scan_state = QLA_FCPORT_FOUND;
+		fcport->chip_reset = vha->hw->base_qpair->chip_reset;
 		memcpy(fcport->node_name, e->u.new_sess.node_name, WWN_SIZE);
 
 		if (pla) {
diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index d733e405c625..d0061ae1488e 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -1209,7 +1209,6 @@ static void qla24xx_chk_fcp_state(struct fc_port *sess)
 		sess->logout_on_delete = 0;
 		sess->logo_ack_needed = 0;
 		sess->fw_login_state = DSC_LS_PORT_UNAVAIL;
-		sess->scan_state = 0;
 	}
 }
 
-- 
2.12.0

