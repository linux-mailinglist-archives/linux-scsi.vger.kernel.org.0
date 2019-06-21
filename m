Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1F34ED6C
	for <lists+linux-scsi@lfdr.de>; Fri, 21 Jun 2019 18:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbfFUQuh (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 21 Jun 2019 12:50:37 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:50552 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726194AbfFUQug (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 21 Jun 2019 12:50:36 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5LGnLOF007652;
        Fri, 21 Jun 2019 09:50:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=0pjYj5AMIqSTKHSgnex+H5/d27t+2SYjdfcWAeDJxI0=;
 b=VrFNIfSCCmCwJT9DdZoLtAOgiXygtCZ9bnbnNEmr6iXySif4FeitpryCIHR+5FECMJ6k
 PYbsQlAX0MqUioCu35L4WLpmux2ercizfzxZ4wwyC1EY/lFvBLnmXxcvFSQXHmhco3BS
 81iUT64Swpfok9EK6ornKzBcN+pYvLdF9l40w/CcZEr2Q9/UC5BD69azAdhoOpboU9me
 yPKFSD1sCP7CmQCyQXYhDq24cU3dpkNZXCj6I8AkOy9NLVcSwZFpPlDydvPA0HXUGZz7
 r5B+UImo8Ke8OTv4rshMrsQ01AI5Ps6j+6PCOK2GVMvTC2Ls4iVA8Xw4rU9SxYHORMWU uQ== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2t8vu2hgwv-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 21 Jun 2019 09:50:34 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 21 Jun
 2019 09:50:31 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Fri, 21 Jun 2019 09:50:31 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id D15983F7040;
        Fri, 21 Jun 2019 09:50:30 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id x5LGoULN023917;
        Fri, 21 Jun 2019 09:50:30 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id x5LGoUd8023916;
        Fri, 21 Jun 2019 09:50:30 -0700
From:   Himanshu Madhani <hmadhani@marvell.com>
To:     <James.Bottomley@HansenPartnership.com>,
        <martin.petersen@oracle.com>
CC:     <hmadhani@marvell.com>, <linux-scsi@vger.kernel.org>
Subject: [PATCH v3 2/3] qla2xxx: on session delete return nvme cmd
Date:   Fri, 21 Jun 2019 09:50:23 -0700
Message-ID: <20190621165024.23874-3-hmadhani@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190621165024.23874-1-hmadhani@marvell.com>
References: <20190621165024.23874-1-hmadhani@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-21_12:,,
 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Quinn Tran <qutran@marvell.com>

- on session delete or chip reset, reject all NVME commands.
- on NVME command submission error, free srb resource.

Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
---
 drivers/scsi/qla2xxx/qla_nvme.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index b43c62758cec..8b3cb0fd307e 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -239,8 +239,16 @@ static int qla_nvme_ls_req(struct nvme_fc_local_port *lport,
 	struct qla_hw_data *ha;
 	srb_t           *sp;
 
+
+	if (!fcport || (fcport && fcport->deleted))
+		return rval;
+
 	vha = fcport->vha;
 	ha = vha->hw;
+
+	if (!ha->flags.fw_started)
+		return rval;
+
 	/* Alloc SRB structure */
 	sp = qla2x00_get_sp(vha, fcport, GFP_ATOMIC);
 	if (!sp)
@@ -272,6 +280,7 @@ static int qla_nvme_ls_req(struct nvme_fc_local_port *lport,
 		    "qla2x00_start_sp failed = %d\n", rval);
 		atomic_dec(&sp->ref_count);
 		wake_up(&sp->nvme_ls_waitq);
+		sp->free(sp);
 		return rval;
 	}
 
@@ -486,11 +495,11 @@ static int qla_nvme_post_cmd(struct nvme_fc_local_port *lport,
 
 	fcport = qla_rport->fcport;
 
-	vha = fcport->vha;
-
-	if (test_bit(ABORT_ISP_ACTIVE, &vha->dpc_flags))
+	if (!qpair || !fcport || (qpair && !qpair->fw_started) ||
+	    (fcport && fcport->deleted))
 		return rval;
 
+	vha = fcport->vha;
 	/*
 	 * If we know the dev is going away while the transport is still sending
 	 * IO's return busy back to stall the IO Q.  This happens when the
@@ -523,6 +532,7 @@ static int qla_nvme_post_cmd(struct nvme_fc_local_port *lport,
 		    "qla2x00_start_nvme_mq failed = %d\n", rval);
 		atomic_dec(&sp->ref_count);
 		wake_up(&sp->nvme_ls_waitq);
+		sp->free(sp);
 	}
 
 	return rval;
@@ -549,14 +559,13 @@ static void qla_nvme_remoteport_delete(struct nvme_fc_remote_port *rport)
 
 	complete(&fcport->nvme_del_done);
 
-	if (!test_bit(UNLOADING, &fcport->vha->dpc_flags)) {
-		INIT_WORK(&fcport->free_work, qlt_free_session_done);
-		schedule_work(&fcport->free_work);
-	}
+	INIT_WORK(&fcport->free_work, qlt_free_session_done);
+	schedule_work(&fcport->free_work);
 
 	fcport->nvme_flag &= ~NVME_FLAG_DELETING;
 	ql_log(ql_log_info, fcport->vha, 0x2110,
-	    "remoteport_delete of %p completed.\n", fcport);
+	    "remoteport_delete of %p %8phN completed.\n",
+	    fcport, fcport->port_name);
 }
 
 static struct nvme_fc_port_template qla_nvme_fc_transport = {
@@ -588,7 +597,8 @@ static void qla_nvme_unregister_remote_port(struct work_struct *work)
 		return;
 
 	ql_log(ql_log_warn, NULL, 0x2112,
-	    "%s: unregister remoteport on %p\n",__func__, fcport);
+	    "%s: unregister remoteport on %p %8phN\n",
+	    __func__, fcport, fcport->port_name);
 
 	nvme_fc_set_remoteport_devloss(fcport->nvme_remote_port, 0);
 	init_completion(&fcport->nvme_del_done);
-- 
2.12.0

