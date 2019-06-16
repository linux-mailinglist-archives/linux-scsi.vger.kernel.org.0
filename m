Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1EC847560
	for <lists+linux-scsi@lfdr.de>; Sun, 16 Jun 2019 17:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfFPPF6 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 16 Jun 2019 11:05:58 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:42114 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725879AbfFPPF6 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 16 Jun 2019 11:05:58 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5GF03BI020556;
        Sun, 16 Jun 2019 08:05:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0818;
 bh=Hxmb96oWqQOzytTnT20KYoCaNSSwn/mX9KM2yDyiB0k=;
 b=kg3iPaq4/HuNukgi8U5ck+0ETw62Ht/r191T6ILo4j92XlZ5mMAlI0WGp/+w1+dayEO8
 cqHe5gflQ4tEmT/RRewgDHMCvZNipK7BF3+iYt3mwt8CPl+PdpSJJ81CRJGn0zOqrRIj
 m5LxHPh+uiJhHqaH8XknWSebCJ3OBe3aVBJDRCfauLUpY9t+HCVtcfdPSe4XhxN2kE/2
 fwvJsVZstMeO77FCAXH0vbGK8+BH8+IBvRIRuPC3PP0VNk+lms/rBbekggx05YOiZwdZ
 kHyHWOKE0xZEXzP/C8b94SGTIp5mbAwhvkS7ahikQ2Xoj7qGncfknPF9ZU1/1w3rljtN dw== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2t4x1n40p5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 16 Jun 2019 08:05:54 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Sun, 16 Jun
 2019 08:05:53 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Sun, 16 Jun 2019 08:05:53 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id 75EEA3F703F;
        Sun, 16 Jun 2019 08:05:53 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id x5GF5rPs028434;
        Sun, 16 Jun 2019 08:05:53 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id x5GF5r0X028433;
        Sun, 16 Jun 2019 08:05:53 -0700
From:   Himanshu Madhani <hmadhani@marvell.com>
To:     <James.Bottomley@HansenPartnership.com>,
        <martin.petersen@oracle.com>
CC:     <hmadhani@marvell.com>, <linux-scsi@vger.kernel.org>
Subject: [PATCH 1/1] qla2xxx: move IO flush to the front of NVME rport unregistration
Date:   Sun, 16 Jun 2019 08:05:53 -0700
Message-ID: <20190616150553.28399-1-hmadhani@marvell.com>
X-Mailer: git-send-email 2.12.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-16_07:,,
 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Quinn Tran <qutran@marvell.com>

On session deletion, current qla code would unregister an NVMe
session before flushing IOs. This patch would move the unregistration
of NVMe session after IO flush. This way FC-NVMe layer would not
have to wait for stuck IOs. In addition, qla2xxx would stop accepting
new IOs during session deletion.

Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
---
Hi Martin, 

we found one more issue where NVMe IO would be stuck while doing a
port toggle or lip_reset test case. This patch fixes issue by flushing
IO before unregistering NVMe session. 

This patch depends on series sent on June 14.
(https://marc.info/?l=linux-scsi&m=156055022726719&w=2)
 
Please apply this patch to 5.3/scsi-queue branch at your earliest
convenience.

Thanks,
Himanshu
---
 drivers/scsi/qla2xxx/qla_def.h    |  1 -
 drivers/scsi/qla2xxx/qla_gbl.h    |  2 ++
 drivers/scsi/qla2xxx/qla_nvme.c   | 14 ++------------
 drivers/scsi/qla2xxx/qla_target.c | 16 ++++++++--------
 4 files changed, 12 insertions(+), 21 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 85a27ee5d647..aad2a84eac29 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -2338,7 +2338,6 @@ typedef struct fc_port {
 	unsigned int id_changed:1;
 	unsigned int scan_needed:1;
 
-	struct work_struct nvme_del_work;
 	struct completion nvme_del_done;
 	uint32_t nvme_prli_service_param;
 #define NVME_PRLI_SP_CONF       BIT_7
diff --git a/drivers/scsi/qla2xxx/qla_gbl.h b/drivers/scsi/qla2xxx/qla_gbl.h
index bbe69ab5cf3f..f9669fdf7798 100644
--- a/drivers/scsi/qla2xxx/qla_gbl.h
+++ b/drivers/scsi/qla2xxx/qla_gbl.h
@@ -908,4 +908,6 @@ void qlt_clr_qp_table(struct scsi_qla_host *vha);
 void qlt_set_mode(struct scsi_qla_host *);
 int qla2x00_set_data_rate(scsi_qla_host_t *vha, uint16_t mode);
 
+/* nvme.c */
+void qla_nvme_unregister_remote_port(struct fc_port *fcport);
 #endif /* _QLA_GBL_H */
diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index b56dcab9d265..baea57424691 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -12,8 +12,6 @@
 
 static struct nvme_fc_port_template qla_nvme_fc_transport;
 
-static void qla_nvme_unregister_remote_port(struct work_struct *);
-
 static inline
 int qla_is_active_nvme_fcport(struct fc_port *fcport)
 {
@@ -50,7 +48,6 @@ int qla_nvme_register_remote(struct scsi_qla_host *vha, struct fc_port *fcport)
 		(fcport->nvme_flag & NVME_FLAG_REGISTERED))
 		return 0;
 
-	INIT_WORK(&fcport->nvme_del_work, qla_nvme_unregister_remote_port);
 	fcport->nvme_flag &= ~NVME_FLAG_RESETTING;
 
 	memset(&req, 0, sizeof(struct nvme_fc_port_info));
@@ -628,16 +625,11 @@ static void qla_nvme_remoteport_delete(struct nvme_fc_remote_port *rport)
 	fcport = qla_rport->fcport;
 	fcport->nvme_remote_port = NULL;
 	fcport->nvme_flag &= ~NVME_FLAG_REGISTERED;
-
-	complete(&fcport->nvme_del_done);
-
-	INIT_WORK(&fcport->free_work, qlt_free_session_done);
-	schedule_work(&fcport->free_work);
-
 	fcport->nvme_flag &= ~NVME_FLAG_DELETING;
 	ql_log(ql_log_info, fcport->vha, 0x2110,
 	    "remoteport_delete of %p %8phN completed.\n",
 	    fcport, fcport->port_name);
+	complete(&fcport->nvme_del_done);
 }
 
 static struct nvme_fc_port_template qla_nvme_fc_transport = {
@@ -659,10 +651,8 @@ static struct nvme_fc_port_template qla_nvme_fc_transport = {
 	.fcprqst_priv_sz = sizeof(struct nvme_private),
 };
 
-static void qla_nvme_unregister_remote_port(struct work_struct *work)
+void qla_nvme_unregister_remote_port(struct fc_port *fcport)
 {
-	struct fc_port *fcport = container_of(work, struct fc_port,
-	    nvme_del_work);
 	int ret;
 
 	if (!IS_ENABLED(CONFIG_NVME_FC))
diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index 3eeae72793bc..b9ee0fa37c27 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -1013,6 +1013,12 @@ void qlt_free_session_done(struct work_struct *work)
 				else
 					logout_started = true;
 			}
+		} /* if sess->logout_on_delete */
+
+		if (sess->nvme_flag & NVME_FLAG_REGISTERED &&
+		    !(sess->nvme_flag & NVME_FLAG_DELETING)) {
+			sess->nvme_flag |= NVME_FLAG_DELETING;
+			qla_nvme_unregister_remote_port(sess);
 		}
 	}
 
@@ -1164,14 +1170,8 @@ void qlt_unreg_sess(struct fc_port *sess)
 	sess->last_rscn_gen = sess->rscn_gen;
 	sess->last_login_gen = sess->login_gen;
 
-	if (sess->nvme_flag & NVME_FLAG_REGISTERED &&
-	    !(sess->nvme_flag & NVME_FLAG_DELETING)) {
-		sess->nvme_flag |= NVME_FLAG_DELETING;
-		schedule_work(&sess->nvme_del_work);
-	} else {
-		INIT_WORK(&sess->free_work, qlt_free_session_done);
-		schedule_work(&sess->free_work);
-	}
+	INIT_WORK(&sess->free_work, qlt_free_session_done);
+	schedule_work(&sess->free_work);
 }
 EXPORT_SYMBOL(qlt_unreg_sess);
 
-- 
2.12.0

