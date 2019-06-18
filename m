Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1DDD4A988
	for <lists+linux-scsi@lfdr.de>; Tue, 18 Jun 2019 20:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729898AbfFRSLo (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 18 Jun 2019 14:11:44 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:8132 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727616AbfFRSLo (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 18 Jun 2019 14:11:44 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5II4cOq015568;
        Tue, 18 Jun 2019 11:11:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=NHRx3xOMR22e4vz2pkoNFJNlxcqARZlkcWVkTlcDHGk=;
 b=eZ88DeBX1F4JNJ1nKfuDLe1ukgRrugPy2B5yqKvmK9bMzRFrGjqoN7r633XiqrqeVgdl
 2ibtF44lF2jt6vpfT+6u57y0a+onnbNhqRIJ36wQbNK1onIB++F3clSH+/ITlUDIhdQ6
 TOHsiBzlNIj9Ch3LRVnd+MuNjwkfOBaMozXk/0FVjPtqa0wBN6Wvmg2D8q4XIQUCQ4JP
 ABpoN74ht7qex3ejEl35SZEqFepgqNqhhvoDtiKZVtOg0sGD4M09rjrzpDLg4yxrj+H7
 /LTyWH1092NWNLCOrZ3jJOFUYS1zspt7UYHxK9S2l1sdRNhiu2LBbASwOl/1V/jljjWG Lg== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2t73vqgcrh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 18 Jun 2019 11:11:34 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 18 Jun
 2019 11:11:34 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Tue, 18 Jun 2019 11:11:34 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id E2D873F703F;
        Tue, 18 Jun 2019 11:11:33 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id x5IIBXRX016606;
        Tue, 18 Jun 2019 11:11:33 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id x5IIBXP6016597;
        Tue, 18 Jun 2019 11:11:33 -0700
From:   Himanshu Madhani <hmadhani@marvell.com>
To:     <James.Bottomley@HansenPartnership.com>,
        <martin.petersen@oracle.com>
CC:     <hmadhani@marvell.com>, <linux-scsi@vger.kernel.org>
Subject: [PATCH v2 2/3] qla2xxx: on session delete return nvme cmd
Date:   Tue, 18 Jun 2019 11:10:20 -0700
Message-ID: <20190618181021.16547-3-hmadhani@marvell.com>
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

- on session delete or chip reset, reject all NVME commands.
- on NVME command submission error, free srb resource.

Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
---
 drivers/scsi/qla2xxx/qla_nvme.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index b43c62758cec..2c64457ce713 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -241,6 +241,10 @@ static int qla_nvme_ls_req(struct nvme_fc_local_port *lport,
 
 	vha = fcport->vha;
 	ha = vha->hw;
+
+	if (!ha->flags.fw_started || (fcport && fcport->deleted))
+		return rval;
+
 	/* Alloc SRB structure */
 	sp = qla2x00_get_sp(vha, fcport, GFP_ATOMIC);
 	if (!sp)
@@ -272,6 +276,7 @@ static int qla_nvme_ls_req(struct nvme_fc_local_port *lport,
 		    "qla2x00_start_sp failed = %d\n", rval);
 		atomic_dec(&sp->ref_count);
 		wake_up(&sp->nvme_ls_waitq);
+		sp->free(sp);
 		return rval;
 	}
 
@@ -488,7 +493,7 @@ static int qla_nvme_post_cmd(struct nvme_fc_local_port *lport,
 
 	vha = fcport->vha;
 
-	if (test_bit(ABORT_ISP_ACTIVE, &vha->dpc_flags))
+	if ((qpair && !qpair->fw_started) || (fcport && fcport->deleted))
 		return rval;
 
 	/*
@@ -523,6 +528,7 @@ static int qla_nvme_post_cmd(struct nvme_fc_local_port *lport,
 		    "qla2x00_start_nvme_mq failed = %d\n", rval);
 		atomic_dec(&sp->ref_count);
 		wake_up(&sp->nvme_ls_waitq);
+		sp->free(sp);
 	}
 
 	return rval;
@@ -549,14 +555,13 @@ static void qla_nvme_remoteport_delete(struct nvme_fc_remote_port *rport)
 
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
@@ -588,7 +593,8 @@ static void qla_nvme_unregister_remote_port(struct work_struct *work)
 		return;
 
 	ql_log(ql_log_warn, NULL, 0x2112,
-	    "%s: unregister remoteport on %p\n",__func__, fcport);
+	    "%s: unregister remoteport on %p %8phN\n",
+	    __func__, fcport, fcport->port_name);
 
 	nvme_fc_set_remoteport_devloss(fcport->nvme_remote_port, 0);
 	init_completion(&fcport->nvme_del_done);
-- 
2.12.0

