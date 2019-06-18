Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93AF64A986
	for <lists+linux-scsi@lfdr.de>; Tue, 18 Jun 2019 20:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729947AbfFRSLO (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 18 Jun 2019 14:11:14 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:18214 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727616AbfFRSLO (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 18 Jun 2019 14:11:14 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5II5DIO006579;
        Tue, 18 Jun 2019 11:11:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=VzIHvVHplbtxWvCXNv67xB2KpLL3aCCRBBaCHDxU3+U=;
 b=cteiL3X4bDN0Ti6DHqvmY7VdFmAEaOilyTNf6+2KJPc4B2uLaevjzlFDR4F6+5wSOP6b
 S1+XQrjW2OePKod9G/BjemyQKbyIT1e5RozHgmdilLGjo42qyMX+snQ2mUMzjQ4y07Lm
 ICjlU/ailchdpiWYutNhdacOG/egDguqhh6HEZRd5jwAJIjBKvcEQeinE4qYeMOnrCxF
 Z++Ddr8o9U3G3nvS0LDFh49nBcZ+Ns3osDZzjOqeCqXS/DlkWTUyrc2GtH+NIrM3Fjjh
 g1EVB0jz0AdEvnJS1Ul+IAcy+mpdM6vdEBH/xWchnUbYjEOBX8UlQWEaDZ9uWGz0z8Xm 8w== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2t6xkh1ppx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 18 Jun 2019 11:11:11 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 18 Jun
 2019 11:11:10 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Tue, 18 Jun 2019 11:11:10 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id C2E353F703F;
        Tue, 18 Jun 2019 11:11:09 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id x5IIB98i016594;
        Tue, 18 Jun 2019 11:11:09 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id x5IIB9a7016593;
        Tue, 18 Jun 2019 11:11:09 -0700
From:   Himanshu Madhani <hmadhani@marvell.com>
To:     <James.Bottomley@HansenPartnership.com>,
        <martin.petersen@oracle.com>
CC:     <hmadhani@marvell.com>, <linux-scsi@vger.kernel.org>
Subject: [PATCH v2 1/3] qla2xxx: Fix kernel crash after disconnecting NVMe devices
Date:   Tue, 18 Jun 2019 11:10:19 -0700
Message-ID: <20190618181021.16547-2-hmadhani@marvell.com>
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

From: Arun Easi <aeasi@marvell.com>

BUG: unable to handle kernel NULL pointer dereference at           (null)
IP: [<ffffffffc050d10c>] qla_nvme_unregister_remote_port+0x6c/0xf0 [qla2xxx]
PGD 800000084cf41067 PUD 84d288067 PMD 0
Oops: 0000 [#1] SMP
Call Trace:
 [<ffffffff98abcfdf>] process_one_work+0x17f/0x440
 [<ffffffff98abdca6>] worker_thread+0x126/0x3c0
 [<ffffffff98abdb80>] ? manage_workers.isra.26+0x2a0/0x2a0
 [<ffffffff98ac4f81>] kthread+0xd1/0xe0
 [<ffffffff98ac4eb0>] ? insert_kthread_work+0x40/0x40
 [<ffffffff9918ad37>] ret_from_fork_nospec_begin+0x21/0x21
 [<ffffffff98ac4eb0>] ? insert_kthread_work+0x40/0x40
RIP  [<ffffffffc050d10c>] qla_nvme_unregister_remote_port+0x6c/0xf0 [qla2xxx]

The crash is due to a bad entry in the nvme_rport_list. This list is not
protected, and when a remoteport_delete callback is called, driver
traverses the list and crashes.

Actually, the list could be removed and driver could traverse the main
fcport list instead. Fix does exactly that.

Signed-off-by: Arun Easi <aeasi@marvell.com>
Signed-off-by: Himanshu Madhani <hmadhani@redhat.com>
---
 drivers/scsi/qla2xxx/qla_def.h  |  1 -
 drivers/scsi/qla2xxx/qla_nvme.c | 37 ++++++++++---------------------------
 drivers/scsi/qla2xxx/qla_nvme.h |  1 -
 drivers/scsi/qla2xxx/qla_os.c   |  1 -
 4 files changed, 10 insertions(+), 30 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 1a4095c56eee..602ed24bb806 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -4376,7 +4376,6 @@ typedef struct scsi_qla_host {
 
 	struct		nvme_fc_local_port *nvme_local_port;
 	struct completion nvme_del_done;
-	struct list_head nvme_rport_list;
 
 	uint16_t	fcoe_vlan_id;
 	uint16_t	fcoe_fcf_idx;
diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index 22e3fba28e51..b43c62758cec 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -74,7 +74,6 @@ int qla_nvme_register_remote(struct scsi_qla_host *vha, struct fc_port *fcport)
 
 	rport = fcport->nvme_remote_port->private;
 	rport->fcport = fcport;
-	list_add_tail(&rport->list, &vha->nvme_rport_list);
 
 	fcport->nvme_flag |= NVME_FLAG_REGISTERED;
 	return 0;
@@ -542,19 +541,12 @@ static void qla_nvme_localport_delete(struct nvme_fc_local_port *lport)
 static void qla_nvme_remoteport_delete(struct nvme_fc_remote_port *rport)
 {
 	fc_port_t *fcport;
-	struct qla_nvme_rport *qla_rport = rport->private, *trport;
+	struct qla_nvme_rport *qla_rport = rport->private;
 
 	fcport = qla_rport->fcport;
 	fcport->nvme_remote_port = NULL;
 	fcport->nvme_flag &= ~NVME_FLAG_REGISTERED;
 
-	list_for_each_entry_safe(qla_rport, trport,
-	    &fcport->vha->nvme_rport_list, list) {
-		if (qla_rport->fcport == fcport) {
-			list_del(&qla_rport->list);
-			break;
-		}
-	}
 	complete(&fcport->nvme_del_done);
 
 	if (!test_bit(UNLOADING, &fcport->vha->dpc_flags)) {
@@ -590,7 +582,7 @@ static void qla_nvme_unregister_remote_port(struct work_struct *work)
 {
 	struct fc_port *fcport = container_of(work, struct fc_port,
 	    nvme_del_work);
-	struct qla_nvme_rport *qla_rport, *trport;
+	int ret;
 
 	if (!IS_ENABLED(CONFIG_NVME_FC))
 		return;
@@ -598,23 +590,14 @@ static void qla_nvme_unregister_remote_port(struct work_struct *work)
 	ql_log(ql_log_warn, NULL, 0x2112,
 	    "%s: unregister remoteport on %p\n",__func__, fcport);
 
-	list_for_each_entry_safe(qla_rport, trport,
-	    &fcport->vha->nvme_rport_list, list) {
-		if (qla_rport->fcport == fcport) {
-			ql_log(ql_log_info, fcport->vha, 0x2113,
-			    "%s: fcport=%p\n", __func__, fcport);
-			nvme_fc_set_remoteport_devloss
-				(fcport->nvme_remote_port, 0);
-			init_completion(&fcport->nvme_del_done);
-			if (nvme_fc_unregister_remoteport
-			    (fcport->nvme_remote_port))
-				ql_log(ql_log_info, fcport->vha, 0x2114,
-				    "%s: Failed to unregister nvme_remote_port\n",
-				    __func__);
-			wait_for_completion(&fcport->nvme_del_done);
-			break;
-		}
-	}
+	nvme_fc_set_remoteport_devloss(fcport->nvme_remote_port, 0);
+	init_completion(&fcport->nvme_del_done);
+	ret = nvme_fc_unregister_remoteport(fcport->nvme_remote_port);
+	if (ret)
+		ql_log(ql_log_info, fcport->vha, 0x2114,
+			"%s: Failed to unregister nvme_remote_port (%d)\n",
+			    __func__, ret);
+	wait_for_completion(&fcport->nvme_del_done);
 }
 
 void qla_nvme_delete(struct scsi_qla_host *vha)
diff --git a/drivers/scsi/qla2xxx/qla_nvme.h b/drivers/scsi/qla2xxx/qla_nvme.h
index d3b8a6440113..2d088add7011 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.h
+++ b/drivers/scsi/qla2xxx/qla_nvme.h
@@ -37,7 +37,6 @@ struct nvme_private {
 };
 
 struct qla_nvme_rport {
-	struct list_head list;
 	struct fc_port *fcport;
 };
 
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 00fee5bf4de1..ae93ae2b6090 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -4789,7 +4789,6 @@ struct scsi_qla_host *qla2x00_create_host(struct scsi_host_template *sht,
 	INIT_LIST_HEAD(&vha->plogi_ack_list);
 	INIT_LIST_HEAD(&vha->qp_list);
 	INIT_LIST_HEAD(&vha->gnl.fcports);
-	INIT_LIST_HEAD(&vha->nvme_rport_list);
 	INIT_LIST_HEAD(&vha->gpnid_list);
 	INIT_WORK(&vha->iocb_work, qla2x00_iocb_work_fn);
 
-- 
2.12.0

