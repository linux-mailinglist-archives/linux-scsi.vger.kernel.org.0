Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A9254D9B6
	for <lists+linux-scsi@lfdr.de>; Thu, 16 Jun 2022 07:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358633AbiFPFfW (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 16 Jun 2022 01:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358593AbiFPFfQ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 16 Jun 2022 01:35:16 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABAF5AEEA
        for <linux-scsi@vger.kernel.org>; Wed, 15 Jun 2022 22:35:14 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25FN9uIH014684
        for <linux-scsi@vger.kernel.org>; Wed, 15 Jun 2022 22:35:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=JfuBy3nkcESKZ8aFY7UKvIcW0lfRn3rMlyVLWB52Yow=;
 b=F+5w9V+sBcN+1t075WlfcC8hRQDDYT8f3FYnuyYOZs9VjybNj6g5D+U7AwT+EpRbOcQL
 iHaR4rKDZNtLU+C3UJD+Z4P0n/p6k620qNNOmKh9kSdUQKyFDbh8YwDECnSjN14dMoOc
 7R1XzhR9itwj5g4OW09slFNxMlSilXkvqEpbU1o9cqZ0+oO5f5DZrE5nXT4Q8/H52jxp
 Tz1/rSWe4jR769ooYsnoLOqwFsHRIfPZRnR7cHXieWhcS25iKrxgGrnqXMuWuuckA6Md
 GMxPG6MQEPsAvE53lMirXPMJLK5J1h7mkEdszrt4MiMpr/tmubPXi+plIYM5h7qoogAP gg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3gqruu977u-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Wed, 15 Jun 2022 22:35:13 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 15 Jun
 2022 22:35:11 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 15 Jun 2022 22:35:11 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id C2F013F70AF;
        Wed, 15 Jun 2022 22:35:11 -0700 (PDT)
From:   Nilesh Javali <njavali@marvell.com>
To:     <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>
Subject: [PATCH v2 03/11] qla2xxx: Wind down adapter after pcie error
Date:   Wed, 15 Jun 2022 22:35:00 -0700
Message-ID: <20220616053508.27186-4-njavali@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20220616053508.27186-1-njavali@marvell.com>
References: <20220616053508.27186-1-njavali@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 3SK_DPQH5FGdIP0yXDaFthycf9-Whv2Q
X-Proofpoint-GUID: 3SK_DPQH5FGdIP0yXDaFthycf9-Whv2Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-16_02,2022-06-15_01,2022-02-23_01
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Quinn Tran <qutran@marvell.com>

Put adapter into a wind down state if OS does not
make any attempt to recover the adapter after
PCIE error.

Cc: stable@vger.kernel.org
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
---
 drivers/scsi/qla2xxx/qla_bsg.c  | 10 ++++++-
 drivers/scsi/qla2xxx/qla_def.h  |  4 +++
 drivers/scsi/qla2xxx/qla_init.c | 20 ++++++++++++++
 drivers/scsi/qla2xxx/qla_os.c   | 48 +++++++++++++++++++++++++++++++++
 4 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_bsg.c b/drivers/scsi/qla2xxx/qla_bsg.c
index 606474ae4419..299c5cba92f4 100644
--- a/drivers/scsi/qla2xxx/qla_bsg.c
+++ b/drivers/scsi/qla2xxx/qla_bsg.c
@@ -3061,6 +3061,13 @@ qla24xx_bsg_timeout(struct bsg_job *bsg_job)
 
 	ql_log(ql_log_info, vha, 0x708b, "%s CMD timeout. bsg ptr %p.\n",
 	    __func__, bsg_job);
+
+	if (qla2x00_isp_reg_stat(ha)) {
+		ql_log(ql_log_info, vha, 0x9007,
+		    "PCI/Register disconnect.\n");
+		qla_pci_set_eeh_busy(vha);
+	}
+
 	/* find the bsg job from the active list of commands */
 	spin_lock_irqsave(&ha->hardware_lock, flags);
 	for (que = 0; que < ha->max_req_queues; que++) {
@@ -3078,7 +3085,8 @@ qla24xx_bsg_timeout(struct bsg_job *bsg_job)
 			    sp->u.bsg_job == bsg_job) {
 				req->outstanding_cmds[cnt] = NULL;
 				spin_unlock_irqrestore(&ha->hardware_lock, flags);
-				if (ha->isp_ops->abort_command(sp)) {
+
+				if (!ha->flags.eeh_busy && ha->isp_ops->abort_command(sp)) {
 					ql_log(ql_log_warn, vha, 0x7089,
 					    "mbx abort_command failed.\n");
 					bsg_reply->result = -EIO;
diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 5888362cf8d1..74d4234e5a31 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -4053,6 +4053,9 @@ struct qla_hw_data {
 		uint32_t	n2n_fw_acc_sec:1;
 		uint32_t	plogi_template_valid:1;
 		uint32_t	port_isolated:1;
+		uint32_t	eeh_flush:2;
+#define EEH_FLUSH_RDY  1
+#define EEH_FLUSH_DONE 2
 	} flags;
 
 	uint16_t max_exchg;
@@ -4087,6 +4090,7 @@ struct qla_hw_data {
 	uint32_t		rsp_que_len;
 	uint32_t		req_que_off;
 	uint32_t		rsp_que_off;
+	unsigned long		eeh_jif;
 
 	/* Multi queue data structs */
 	device_reg_t *mqiobase;
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index e4db1c1f3f6b..7860cf4319ef 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -47,6 +47,7 @@ qla2x00_sp_timeout(struct timer_list *t)
 {
 	srb_t *sp = from_timer(sp, t, u.iocb_cmd.timer);
 	struct srb_iocb *iocb;
+	scsi_qla_host_t *vha = sp->vha;
 
 	WARN_ON(irqs_disabled());
 	iocb = &sp->u.iocb_cmd;
@@ -54,6 +55,12 @@ qla2x00_sp_timeout(struct timer_list *t)
 
 	/* ref: TMR */
 	kref_put(&sp->cmd_kref, qla2x00_sp_release);
+
+	if (vha && qla2x00_isp_reg_stat(vha->hw)) {
+		ql_log(ql_log_info, vha, 0x9008,
+		    "PCI/Register disconnect.\n");
+		qla_pci_set_eeh_busy(vha);
+	}
 }
 
 void qla2x00_sp_free(srb_t *sp)
@@ -9671,6 +9678,12 @@ int qla2xxx_disable_port(struct Scsi_Host *host)
 
 	vha->hw->flags.port_isolated = 1;
 
+	if (qla2x00_isp_reg_stat(vha->hw)) {
+		ql_log(ql_log_info, vha, 0x9006,
+		    "PCI/Register disconnect, exiting.\n");
+		qla_pci_set_eeh_busy(vha);
+		return FAILED;
+	}
 	if (qla2x00_chip_is_down(vha))
 		return 0;
 
@@ -9686,6 +9699,13 @@ int qla2xxx_enable_port(struct Scsi_Host *host)
 {
 	scsi_qla_host_t *vha = shost_priv(host);
 
+	if (qla2x00_isp_reg_stat(vha->hw)) {
+		ql_log(ql_log_info, vha, 0x9001,
+		    "PCI/Register disconnect, exiting.\n");
+		qla_pci_set_eeh_busy(vha);
+		return FAILED;
+	}
+
 	vha->hw->flags.port_isolated = 0;
 	/* Set the flag to 1, so that isp_abort can proceed */
 	vha->flags.online = 1;
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 4f3125b826c4..210fb5c52421 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -333,6 +333,11 @@ MODULE_PARM_DESC(ql2xabts_wait_nvme,
 		 "To wait for ABTS response on I/O timeouts for NVMe. (default: 1)");
 
 
+u32 ql2xdelay_before_pci_error_handling = 5;
+module_param(ql2xdelay_before_pci_error_handling, uint, 0644);
+MODULE_PARM_DESC(ql2xdelay_before_pci_error_handling,
+	"Number of seconds delayed before qla begin PCI error self-handling (default: 5).\n");
+
 static void qla2x00_clear_drv_active(struct qla_hw_data *);
 static void qla2x00_free_device(scsi_qla_host_t *);
 static int qla2xxx_map_queues(struct Scsi_Host *shost);
@@ -7238,6 +7243,44 @@ static void qla_heart_beat(struct scsi_qla_host *vha, u16 dpc_started)
 	}
 }
 
+static void qla_wind_down_chip(scsi_qla_host_t *vha)
+{
+	struct qla_hw_data *ha = vha->hw;
+
+	if (!ha->flags.eeh_busy)
+		return;
+	if (ha->pci_error_state)
+		/* system is trying to recover */
+		return;
+
+	/*
+	 * Current system is not handling PCIE error.  At this point, this is
+	 * best effort to wind down the adapter.
+	 */
+	if (time_after_eq(jiffies, ha->eeh_jif + ql2xdelay_before_pci_error_handling * HZ) &&
+	    !ha->flags.eeh_flush) {
+		ql_log(ql_log_info, vha, 0x9009,
+		    "PCI Error detected, attempting to reset hardware.\n");
+
+		ha->isp_ops->reset_chip(vha);
+		ha->isp_ops->disable_intrs(ha);
+
+		ha->flags.eeh_flush = EEH_FLUSH_RDY;
+		ha->eeh_jif = jiffies;
+
+	} else if (ha->flags.eeh_flush == EEH_FLUSH_RDY &&
+	    time_after_eq(jiffies, ha->eeh_jif +  5 * HZ)) {
+		pci_clear_master(ha->pdev);
+
+		/* flush all command */
+		qla2x00_abort_isp_cleanup(vha);
+		ha->flags.eeh_flush = EEH_FLUSH_DONE;
+
+		ql_log(ql_log_info, vha, 0x900a,
+		    "PCI Error handling complete, all IOs aborted.\n");
+	}
+}
+
 /**************************************************************************
 *   qla2x00_timer
 *
@@ -7261,6 +7304,8 @@ qla2x00_timer(struct timer_list *t)
 	fc_port_t *fcport = NULL;
 
 	if (ha->flags.eeh_busy) {
+		qla_wind_down_chip(vha);
+
 		ql_dbg(ql_dbg_timer, vha, 0x6000,
 		    "EEH = %d, restarting timer.\n",
 		    ha->flags.eeh_busy);
@@ -7841,6 +7886,9 @@ void qla_pci_set_eeh_busy(struct scsi_qla_host *vha)
 
 	spin_lock_irqsave(&base_vha->work_lock, flags);
 	if (!ha->flags.eeh_busy) {
+		ha->eeh_jif = jiffies;
+		ha->flags.eeh_flush = 0;
+
 		ha->flags.eeh_busy = 1;
 		do_cleanup = true;
 	}
-- 
2.19.0.rc0

