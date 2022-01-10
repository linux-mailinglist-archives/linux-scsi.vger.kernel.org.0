Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718C4488F70
	for <lists+linux-scsi@lfdr.de>; Mon, 10 Jan 2022 06:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238514AbiAJFDD (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 10 Jan 2022 00:03:03 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:10344 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234110AbiAJFC5 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 10 Jan 2022 00:02:57 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 209MWKE0024446
        for <linux-scsi@vger.kernel.org>; Sun, 9 Jan 2022 21:02:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=AIGLUDd/muSRgL7TiV8pZ04txrh0hF78fkcpKLQGSfk=;
 b=OPERJjKpNOqKkzwiAl4BwSTmFdCu7HtdROhn0UsNxFOzBKYZAwAw8JWOQo1ZmfEkRw5n
 OBEmjV8kGy44CZRpkdduii1HQf6PGB27tAMr/i/ZONv8uBhsiLhANzKLzdwuWOXEBAfM
 HMRwZTiK9HFUq7mdbieurmuZ88lsgXIklhkZXKAMIzWzZU1zstfYm2E6NmYUfkI2CNuu
 9NrIcE+8424H2fprdwsSCnRXsR6X4LKIFSAaS9A6vDCjj3I/R5dHQREoQrJ85ajZU//N
 vLMjKmPMnm+KYKDrYlA4hEaDugFbzXU8kGmX8Y77hX/wpY7q2TA+Ovkg7bg35P1nBxhi fQ== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3dg7nks0qj-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Sun, 09 Jan 2022 21:02:57 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Sun, 9 Jan
 2022 21:02:55 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Sun, 9 Jan 2022 21:02:55 -0800
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id 63AE53F705C;
        Sun,  9 Jan 2022 21:02:55 -0800 (PST)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id 20A52tPj004041;
        Sun, 9 Jan 2022 21:02:55 -0800
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id 20A52tno004040;
        Sun, 9 Jan 2022 21:02:55 -0800
From:   Nilesh Javali <njavali@marvell.com>
To:     <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>
Subject: [PATCH v2 12/17] qla2xxx: edif: Fix clang warning
Date:   Sun, 9 Jan 2022 21:02:13 -0800
Message-ID: <20220110050218.3958-13-njavali@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20220110050218.3958-1-njavali@marvell.com>
References: <20220110050218.3958-1-njavali@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: wqdKo48hCPlqdfFsqHpqCaK0zJMGtMDb
X-Proofpoint-ORIG-GUID: wqdKo48hCPlqdfFsqHpqCaK0zJMGtMDb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-10_01,2022-01-07_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Quinn Tran <qutran@marvell.com>

Silent compile warning due to unaligned memory access.

qla_edif.c:713:45: warning: taking address of packed member 'u' of class or
   structure 'auth_complete_cmd' may result in an unaligned pointer value
   [-Waddress-of-packed-member]
    fcport = qla2x00_find_fcport_by_pid(vha, &appplogiok.u.d_id);

Cc: stable@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
---
 drivers/scsi/qla2xxx/qla_edif.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_edif.c b/drivers/scsi/qla2xxx/qla_edif.c
index c04957c363d8..0628633c7c7e 100644
--- a/drivers/scsi/qla2xxx/qla_edif.c
+++ b/drivers/scsi/qla2xxx/qla_edif.c
@@ -668,6 +668,11 @@ qla_edif_app_authok(scsi_qla_host_t *vha, struct bsg_job *bsg_job)
 	    bsg_job->request_payload.sg_cnt, &appplogiok,
 	    sizeof(struct auth_complete_cmd));
 
+	/* silent unaligned access warning */
+	portid.b.domain = appplogiok.u.d_id.b.domain;
+	portid.b.area   = appplogiok.u.d_id.b.area;
+	portid.b.al_pa  = appplogiok.u.d_id.b.al_pa;
+
 	switch (appplogiok.type) {
 	case PL_TYPE_WWPN:
 		fcport = qla2x00_find_fcport_by_wwpn(vha,
@@ -678,7 +683,7 @@ qla_edif_app_authok(scsi_qla_host_t *vha, struct bsg_job *bsg_job)
 			    __func__, appplogiok.u.wwpn);
 		break;
 	case PL_TYPE_DID:
-		fcport = qla2x00_find_fcport_by_pid(vha, &appplogiok.u.d_id);
+		fcport = qla2x00_find_fcport_by_pid(vha, &portid);
 		if (!fcport)
 			ql_dbg(ql_dbg_edif, vha, 0x911d,
 			    "%s d_id lookup failed: %x\n", __func__,
@@ -777,6 +782,11 @@ qla_edif_app_authfail(scsi_qla_host_t *vha, struct bsg_job *bsg_job)
 	    bsg_job->request_payload.sg_cnt, &appplogifail,
 	    sizeof(struct auth_complete_cmd));
 
+	/* silent unaligned access warning */
+	portid.b.domain = appplogifail.u.d_id.b.domain;
+	portid.b.area   = appplogifail.u.d_id.b.area;
+	portid.b.al_pa  = appplogifail.u.d_id.b.al_pa;
+
 	/*
 	 * TODO: edif: app has failed this plogi. Inform driver to
 	 * take any action (if any).
@@ -788,7 +798,7 @@ qla_edif_app_authfail(scsi_qla_host_t *vha, struct bsg_job *bsg_job)
 		SET_DID_STATUS(bsg_reply->result, DID_OK);
 		break;
 	case PL_TYPE_DID:
-		fcport = qla2x00_find_fcport_by_pid(vha, &appplogifail.u.d_id);
+		fcport = qla2x00_find_fcport_by_pid(vha, &portid);
 		if (!fcport)
 			ql_dbg(ql_dbg_edif, vha, 0x911d,
 			    "%s d_id lookup failed: %x\n", __func__,
@@ -1253,6 +1263,7 @@ qla24xx_sadb_update(struct bsg_job *bsg_job)
 	int result = 0;
 	struct qla_sa_update_frame sa_frame;
 	struct srb_iocb *iocb_cmd;
+	port_id_t portid;
 
 	ql_dbg(ql_dbg_edif + ql_dbg_verbose, vha, 0x911d,
 	    "%s entered, vha: 0x%p\n", __func__, vha);
@@ -1276,7 +1287,12 @@ qla24xx_sadb_update(struct bsg_job *bsg_job)
 		goto done;
 	}
 
-	fcport = qla2x00_find_fcport_by_pid(vha, &sa_frame.port_id);
+	/* silent unaligned access warning */
+	portid.b.domain = sa_frame.port_id.b.domain;
+	portid.b.area   = sa_frame.port_id.b.area;
+	portid.b.al_pa  = sa_frame.port_id.b.al_pa;
+
+	fcport = qla2x00_find_fcport_by_pid(vha, &portid);
 	if (fcport) {
 		found = 1;
 		if (sa_frame.flags == QLA_SA_UPDATE_FLAGS_TX_KEY)
-- 
2.23.1

