Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59CE3653B5A
	for <lists+linux-scsi@lfdr.de>; Thu, 22 Dec 2022 05:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbiLVEjx (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 21 Dec 2022 23:39:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234981AbiLVEjp (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 21 Dec 2022 23:39:45 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC2119C23
        for <linux-scsi@vger.kernel.org>; Wed, 21 Dec 2022 20:39:43 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BM4OKMk020309
        for <linux-scsi@vger.kernel.org>; Wed, 21 Dec 2022 20:39:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=l/XdOKT/lXcpjQjRZt7qyzEazEOzwQRt9ifVp9zEJew=;
 b=eP9tsfbNemlWmPND4T3ALJEX7PG4Yeh9W5NEALBAd1StJ/F5ahlFAcHD7TL7aNUq9ba9
 FHHOrUDpv9tw1Nx4+7m5tfe2f868J3gqLtTFa8tXU99KFawb8G3fUzd9T82+yS4jqYPP
 RjLEgyeCNwEZ3g1RtC7U4Mqjzpu/4lRmQVEl+Ka5KIxVkMIV3wlB75SNx5coRbmcHqmy
 z4YpafQuDoUdu8Qnp6444a0IE1RGuUobqKdlOB9rpZbH9Ere+W7yEMBOSUGaO/vxbf9n
 1yRLk1n3whantkaOiM6wHgdG8rhbrhC+XLgOVUgwLAeEVr4XejBhaphUFcB19bQpoQx+ rw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3mhe5rsdhc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Wed, 21 Dec 2022 20:39:42 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 21 Dec
 2022 20:39:40 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Wed, 21 Dec 2022 20:39:40 -0800
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id 5ADE03F7068;
        Wed, 21 Dec 2022 20:39:40 -0800 (PST)
From:   Nilesh Javali <njavali@marvell.com>
To:     <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>, <bhazarika@marvell.com>,
        <agurumurthy@marvell.com>, <sdeodhar@marvell.com>
Subject: [PATCH 01/10] qla2xxx: Remove dead code
Date:   Wed, 21 Dec 2022 20:39:24 -0800
Message-ID: <20221222043933.2825-2-njavali@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20221222043933.2825-1-njavali@marvell.com>
References: <20221222043933.2825-1-njavali@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: VZIUUOrIS-WppQhUy77URJWxtKmVlDdC
X-Proofpoint-ORIG-GUID: VZIUUOrIS-WppQhUy77URJWxtKmVlDdC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-22_01,2022-12-21_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Quinn Tran <qutran@marvell.com>

Removing drport field and FCPORT_UPDATE_NEEDED signals.

Cc: stable@vger.kernel.org
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
---
 drivers/scsi/qla2xxx/qla_attr.c |  5 ++--
 drivers/scsi/qla2xxx/qla_def.h  |  3 +--
 drivers/scsi/qla2xxx/qla_init.c | 48 ---------------------------------
 drivers/scsi/qla2xxx/qla_mid.c  |  9 -------
 drivers/scsi/qla2xxx/qla_os.c   | 13 ++-------
 5 files changed, 5 insertions(+), 73 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_attr.c b/drivers/scsi/qla2xxx/qla_attr.c
index fa1fcbfb946f..6a4bc59d6525 100644
--- a/drivers/scsi/qla2xxx/qla_attr.c
+++ b/drivers/scsi/qla2xxx/qla_attr.c
@@ -2732,7 +2732,7 @@ qla2x00_dev_loss_tmo_callbk(struct fc_rport *rport)
 	spin_lock_irqsave(host->host_lock, flags);
 	/* Confirm port has not reappeared before clearing pointers. */
 	if (rport->port_state != FC_PORTSTATE_ONLINE) {
-		fcport->rport = fcport->drport = NULL;
+		fcport->rport = NULL;
 		*((fc_port_t **)rport->dd_data) = NULL;
 	}
 	spin_unlock_irqrestore(host->host_lock, flags);
@@ -3171,8 +3171,7 @@ qla24xx_vport_delete(struct fc_vport *fc_vport)
 
 	set_bit(VPORT_DELETE, &vha->dpc_flags);
 
-	while (test_bit(LOOP_RESYNC_ACTIVE, &vha->dpc_flags) ||
-	    test_bit(FCPORT_UPDATE_NEEDED, &vha->dpc_flags))
+	while (test_bit(LOOP_RESYNC_ACTIVE, &vha->dpc_flags))
 		msleep(1000);
 
 
diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index cd4eb11b0707..0dde3fa9e258 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -2596,7 +2596,7 @@ typedef struct fc_port {
 
 	int login_retry;
 
-	struct fc_rport *rport, *drport;
+	struct fc_rport *rport;
 	u32 supported_classes;
 
 	uint8_t fc4_type;
@@ -4876,7 +4876,6 @@ typedef struct scsi_qla_host {
 #define ISP_ABORT_RETRY		10	/* ISP aborted. */
 #define BEACON_BLINK_NEEDED	11
 #define REGISTER_FDMI_NEEDED	12
-#define FCPORT_UPDATE_NEEDED	13
 #define VP_DPC_NEEDED		14	/* wake up for VP dpc handling */
 #define UNLOADING		15
 #define NPIV_CONFIG_NEEDED	16
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 6968e8d08968..ca216b820b1c 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -5224,27 +5224,6 @@ qla2x00_nvram_config(scsi_qla_host_t *vha)
 	return (rval);
 }
 
-static void
-qla2x00_rport_del(void *data)
-{
-	fc_port_t *fcport = data;
-	struct fc_rport *rport;
-	unsigned long flags;
-
-	spin_lock_irqsave(fcport->vha->host->host_lock, flags);
-	rport = fcport->drport ? fcport->drport : fcport->rport;
-	fcport->drport = NULL;
-	spin_unlock_irqrestore(fcport->vha->host->host_lock, flags);
-	if (rport) {
-		ql_dbg(ql_dbg_disc, fcport->vha, 0x210b,
-		    "%s %8phN. rport %p roles %x\n",
-		    __func__, fcport->port_name, rport,
-		    rport->roles);
-
-		fc_remote_port_delete(rport);
-	}
-}
-
 void qla2x00_set_fcport_state(fc_port_t *fcport, int state)
 {
 	int old_state;
@@ -6761,33 +6740,6 @@ int qla2x00_perform_loop_resync(scsi_qla_host_t *ha)
 	return rval;
 }
 
-void
-qla2x00_update_fcports(scsi_qla_host_t *base_vha)
-{
-	fc_port_t *fcport;
-	struct scsi_qla_host *vha, *tvp;
-	struct qla_hw_data *ha = base_vha->hw;
-	unsigned long flags;
-
-	spin_lock_irqsave(&ha->vport_slock, flags);
-	/* Go with deferred removal of rport references. */
-	list_for_each_entry_safe(vha, tvp, &base_vha->hw->vp_list, list) {
-		atomic_inc(&vha->vref_count);
-		list_for_each_entry(fcport, &vha->vp_fcports, list) {
-			if (fcport->drport &&
-			    atomic_read(&fcport->state) != FCS_UNCONFIGURED) {
-				spin_unlock_irqrestore(&ha->vport_slock, flags);
-				qla2x00_rport_del(fcport);
-
-				spin_lock_irqsave(&ha->vport_slock, flags);
-			}
-		}
-		atomic_dec(&vha->vref_count);
-		wake_up(&vha->vref_waitq);
-	}
-	spin_unlock_irqrestore(&ha->vport_slock, flags);
-}
-
 /* Assumes idc_lock always held on entry */
 void
 qla83xx_reset_ownership(scsi_qla_host_t *vha)
diff --git a/drivers/scsi/qla2xxx/qla_mid.c b/drivers/scsi/qla2xxx/qla_mid.c
index 16a9f22bb860..5fff17da0202 100644
--- a/drivers/scsi/qla2xxx/qla_mid.c
+++ b/drivers/scsi/qla2xxx/qla_mid.c
@@ -384,15 +384,6 @@ qla2x00_do_dpc_vp(scsi_qla_host_t *vha)
 		}
 	}
 
-	if (test_bit(FCPORT_UPDATE_NEEDED, &vha->dpc_flags)) {
-		ql_dbg(ql_dbg_dpc, vha, 0x4016,
-		    "FCPort update scheduled.\n");
-		qla2x00_update_fcports(vha);
-		clear_bit(FCPORT_UPDATE_NEEDED, &vha->dpc_flags);
-		ql_dbg(ql_dbg_dpc, vha, 0x4017,
-		    "FCPort update end.\n");
-	}
-
 	if (test_bit(RELOGIN_NEEDED, &vha->dpc_flags) &&
 	    !test_bit(LOOP_RESYNC_NEEDED, &vha->dpc_flags) &&
 	    atomic_read(&vha->loop_state) != LOOP_DOWN) {
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 2d86f804872b..078b63b89189 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -7025,11 +7025,6 @@ qla2x00_do_dpc(void *data)
 			}
 		}
 
-		if (test_and_clear_bit(FCPORT_UPDATE_NEEDED,
-		    &base_vha->dpc_flags)) {
-			qla2x00_update_fcports(base_vha);
-		}
-
 		if (IS_QLAFX00(ha))
 			goto loop_resync_check;
 
@@ -7525,7 +7520,6 @@ qla2x00_timer(struct timer_list *t)
 	/* Schedule the DPC routine if needed */
 	if ((test_bit(ISP_ABORT_NEEDED, &vha->dpc_flags) ||
 	    test_bit(LOOP_RESYNC_NEEDED, &vha->dpc_flags) ||
-	    test_bit(FCPORT_UPDATE_NEEDED, &vha->dpc_flags) ||
 	    start_dpc ||
 	    test_bit(RESET_MARKER_NEEDED, &vha->dpc_flags) ||
 	    test_bit(BEACON_BLINK_NEEDED, &vha->dpc_flags) ||
@@ -7536,13 +7530,10 @@ qla2x00_timer(struct timer_list *t)
 	    test_bit(PROCESS_PUREX_IOCB, &vha->dpc_flags))) {
 		ql_dbg(ql_dbg_timer, vha, 0x600b,
 		    "isp_abort_needed=%d loop_resync_needed=%d "
-		    "fcport_update_needed=%d start_dpc=%d "
-		    "reset_marker_needed=%d",
+		    "start_dpc=%d reset_marker_needed=%d",
 		    test_bit(ISP_ABORT_NEEDED, &vha->dpc_flags),
 		    test_bit(LOOP_RESYNC_NEEDED, &vha->dpc_flags),
-		    test_bit(FCPORT_UPDATE_NEEDED, &vha->dpc_flags),
-		    start_dpc,
-		    test_bit(RESET_MARKER_NEEDED, &vha->dpc_flags));
+		    start_dpc, test_bit(RESET_MARKER_NEEDED, &vha->dpc_flags));
 		ql_dbg(ql_dbg_timer, vha, 0x600c,
 		    "beacon_blink_needed=%d isp_unrecoverable=%d "
 		    "fcoe_ctx_reset_needed=%d vp_dpc_needed=%d "
-- 
2.19.0.rc0

