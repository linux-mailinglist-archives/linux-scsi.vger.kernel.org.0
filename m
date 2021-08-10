Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D103E5255
	for <lists+linux-scsi@lfdr.de>; Tue, 10 Aug 2021 06:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237180AbhHJEjj (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 10 Aug 2021 00:39:39 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:43508 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235069AbhHJEji (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 10 Aug 2021 00:39:38 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17A4axM9008747
        for <linux-scsi@vger.kernel.org>; Mon, 9 Aug 2021 21:39:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=tdmBNUdtjMotP/kEPmVoNQDp+agZzW8CTWck6yo5ACs=;
 b=WiiJeqQIIL9cE5zpTxN8K8X0VmDoWCfZdusc+OyTxiZ1RFBY/BGI843CO6TwmDJdmXDZ
 Wmzs1RpElm06CXejOhpGt7FNlMXiIoHp5nc8pAPo7jQ6yHcKFWfhRe8Z0YUZCmLwCzVU
 LKA5Rr04r5jsxpyVSQ41RmjVqPdnGTLGbt2aNQ8mGi09w8G4Bkyw8b3hd1209tPz8iz7
 ReV8ddztA9l6LELsbhhhLlmC3mE2sCH9VzVGjBLa7JmZEWqwclqq0ptmYC/8GIzqsvDM
 p0GKld4wfv7BQ0l3n35m9Rgjk0DD2hYW2cyODkvcmR7mj7jQocIQdiK6hluSGkm05kyy kw== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 3abfu2gf87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Mon, 09 Aug 2021 21:39:17 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 9 Aug
 2021 21:39:15 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 9 Aug 2021 21:39:15 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id 886273F7044;
        Mon,  9 Aug 2021 21:39:15 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id 17A4dFcw001221;
        Mon, 9 Aug 2021 21:39:15 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id 17A4dFn9001220;
        Mon, 9 Aug 2021 21:39:15 -0700
From:   Nilesh Javali <njavali@marvell.com>
To:     <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>
Subject: [PATCH v2 08/14] qla2xxx: fix unsafe removal from link list
Date:   Mon, 9 Aug 2021 21:37:14 -0700
Message-ID: <20210810043720.1137-9-njavali@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20210810043720.1137-1-njavali@marvell.com>
References: <20210810043720.1137-1-njavali@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: TqlT8YvK3sx4cv6032hTKzC3c1ZVD2hd
X-Proofpoint-GUID: TqlT8YvK3sx4cv6032hTKzC3c1ZVD2hd
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-10_01:2021-08-06,2021-08-10 signatures=0
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Quinn Tran <qutran@marvell.com>

On NPIV delete, the VPort is taken off a link list in an unsafe manner.
The check for VPort refcount should be done behind lock before taking
off the element.

[ 2733.016907] general protection fault: 0000 [#1] SMP NOPTI
[ 2733.016908] qla2xxx [0000:22:00.1]-7088:27: VP[4] deleted.
[ 2733.016912] CPU: 22 PID: 23481 Comm: qla2xxx_15_dpc Kdump: loaded Tainted:
G           OE KX    5.3.18-47-default #1 SLE15-SP3
[ 2733.016914] Hardware name: Dell Inc. PowerEdge R7525/0PYVT1, BIOS 2.1.4 02/17/2021
[ 2733.016929] RIP: 0010:qla2x00_abort_isp+0x90/0x850 [qla2xxx]
[ 2733.016933] RSP: 0018:ffffb9cfc91efe98 EFLAGS: 00010087
[ 2733.016935] RAX: 0000000000000292 RBX: dead000000000100 RCX: 0000000000000000
[ 2733.016936] RDX: 0000000000000001 RSI: ffff944bfeb99558 RDI: ffff944bfc4b4488
[ 2733.016937] RBP: ffff944bfc4b2868 R08: 00000000000187a2 R09: 0000000000000001
[ 2733.016937] R10: ffffb9cfc91efcc8 R11: 0000000000000001 R12: ffff944bfc4b4000
[ 2733.016938] R13: ffff944bfc4b4870 R14: ffff944bfc4b4488 R15: ffff944bda895c80
[ 2733.016939] FS:  0000000000000000(0000) GS:ffff944bfeb80000(0000) knlGS:0000000000000000
[ 2733.016940] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2733.016940] CR2: 00007fc173e74458 CR3: 0000001ff57de000 CR4: 0000000000350ee0
[ 2733.016941] Call Trace:
[ 2733.016951]   qla2xxx_pci_error_detected+0x190/0x190 [qla2xxx]
[ 2733.016957]   qla2x00_do_dpc+0x560/0xa10 [qla2xxx]
[ 2733.016962]   kthread+0x10d/0x130
[ 2733.016963]   kthread_park+0xa0/0xa0
[ 2733.016966]   ret_from_fork+0x22/0x40

Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
---
 drivers/scsi/qla2xxx/qla_init.c | 33 +++++++++++++++++---------
 drivers/scsi/qla2xxx/qla_mid.c  | 42 ++++++++++++++++++++-------------
 drivers/scsi/qla2xxx/qla_os.c   |  6 ++---
 3 files changed, 50 insertions(+), 31 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 8fa0cc3fcca0..2810274a262b 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -6573,13 +6573,13 @@ void
 qla2x00_update_fcports(scsi_qla_host_t *base_vha)
 {
 	fc_port_t *fcport;
-	struct scsi_qla_host *vha;
+	struct scsi_qla_host *vha, *tvp;
 	struct qla_hw_data *ha = base_vha->hw;
 	unsigned long flags;
 
 	spin_lock_irqsave(&ha->vport_slock, flags);
 	/* Go with deferred removal of rport references. */
-	list_for_each_entry(vha, &base_vha->hw->vp_list, list) {
+	list_for_each_entry_safe(vha, tvp, &base_vha->hw->vp_list, list) {
 		atomic_inc(&vha->vref_count);
 		list_for_each_entry(fcport, &vha->vp_fcports, list) {
 			if (fcport->drport &&
@@ -6924,7 +6924,8 @@ void
 qla2x00_quiesce_io(scsi_qla_host_t *vha)
 {
 	struct qla_hw_data *ha = vha->hw;
-	struct scsi_qla_host *vp;
+	struct scsi_qla_host *vp, *tvp;
+	unsigned long flags;
 
 	ql_dbg(ql_dbg_dpc, vha, 0x401d,
 	    "Quiescing I/O - ha=%px.\n", ha);
@@ -6933,8 +6934,18 @@ qla2x00_quiesce_io(scsi_qla_host_t *vha)
 	if (atomic_read(&vha->loop_state) != LOOP_DOWN) {
 		atomic_set(&vha->loop_state, LOOP_DOWN);
 		qla2x00_mark_all_devices_lost(vha);
-		list_for_each_entry(vp, &ha->vp_list, list)
+
+		spin_lock_irqsave(&ha->vport_slock, flags);
+		list_for_each_entry_safe(vp, tvp, &ha->vp_list, list) {
+			atomic_inc(&vp->vref_count);
+			spin_unlock_irqrestore(&ha->vport_slock, flags);
+
 			qla2x00_mark_all_devices_lost(vp);
+
+			spin_lock_irqsave(&ha->vport_slock, flags);
+			atomic_dec(&vp->vref_count);
+		}
+		spin_unlock_irqrestore(&ha->vport_slock, flags);
 	} else {
 		if (!atomic_read(&vha->loop_down_timer))
 			atomic_set(&vha->loop_down_timer,
@@ -6949,7 +6960,7 @@ void
 qla2x00_abort_isp_cleanup(scsi_qla_host_t *vha)
 {
 	struct qla_hw_data *ha = vha->hw;
-	struct scsi_qla_host *vp;
+	struct scsi_qla_host *vp, *tvp;
 	unsigned long flags;
 	fc_port_t *fcport;
 	u16 i;
@@ -7017,7 +7028,7 @@ qla2x00_abort_isp_cleanup(scsi_qla_host_t *vha)
 		qla2x00_mark_all_devices_lost(vha);
 
 		spin_lock_irqsave(&ha->vport_slock, flags);
-		list_for_each_entry(vp, &ha->vp_list, list) {
+		list_for_each_entry_safe(vp, tvp, &ha->vp_list, list) {
 			atomic_inc(&vp->vref_count);
 			spin_unlock_irqrestore(&ha->vport_slock, flags);
 
@@ -7039,7 +7050,7 @@ qla2x00_abort_isp_cleanup(scsi_qla_host_t *vha)
 		fcport->scan_state = 0;
 	}
 	spin_lock_irqsave(&ha->vport_slock, flags);
-	list_for_each_entry(vp, &ha->vp_list, list) {
+	list_for_each_entry_safe(vp, tvp, &ha->vp_list, list) {
 		atomic_inc(&vp->vref_count);
 		spin_unlock_irqrestore(&ha->vport_slock, flags);
 
@@ -7083,7 +7094,7 @@ qla2x00_abort_isp(scsi_qla_host_t *vha)
 	int rval;
 	uint8_t        status = 0;
 	struct qla_hw_data *ha = vha->hw;
-	struct scsi_qla_host *vp;
+	struct scsi_qla_host *vp, *tvp;
 	struct req_que *req = ha->req_q_map[0];
 	unsigned long flags;
 
@@ -7239,7 +7250,7 @@ qla2x00_abort_isp(scsi_qla_host_t *vha)
 		ql_dbg(ql_dbg_taskm, vha, 0x8022, "%s succeeded.\n", __func__);
 		qla2x00_configure_hba(vha);
 		spin_lock_irqsave(&ha->vport_slock, flags);
-		list_for_each_entry(vp, &ha->vp_list, list) {
+		list_for_each_entry_safe(vp, tvp, &ha->vp_list, list) {
 			if (vp->vp_idx) {
 				atomic_inc(&vp->vref_count);
 				spin_unlock_irqrestore(&ha->vport_slock, flags);
@@ -8924,7 +8935,7 @@ qla82xx_restart_isp(scsi_qla_host_t *vha)
 {
 	int status, rval;
 	struct qla_hw_data *ha = vha->hw;
-	struct scsi_qla_host *vp;
+	struct scsi_qla_host *vp, *tvp;
 	unsigned long flags;
 
 	status = qla2x00_init_rings(vha);
@@ -8996,7 +9007,7 @@ qla82xx_restart_isp(scsi_qla_host_t *vha)
 		    "qla82xx_restart_isp succeeded.\n");
 
 		spin_lock_irqsave(&ha->vport_slock, flags);
-		list_for_each_entry(vp, &ha->vp_list, list) {
+		list_for_each_entry_safe(vp, tvp, &ha->vp_list, list) {
 			if (vp->vp_idx) {
 				atomic_inc(&vp->vref_count);
 				spin_unlock_irqrestore(&ha->vport_slock, flags);
diff --git a/drivers/scsi/qla2xxx/qla_mid.c b/drivers/scsi/qla2xxx/qla_mid.c
index 98333f5b0807..3fa70750ce25 100644
--- a/drivers/scsi/qla2xxx/qla_mid.c
+++ b/drivers/scsi/qla2xxx/qla_mid.c
@@ -65,7 +65,7 @@ qla24xx_deallocate_vp_id(scsi_qla_host_t *vha)
 	uint16_t vp_id;
 	struct qla_hw_data *ha = vha->hw;
 	unsigned long flags = 0;
-	u8 i;
+	u32 i, bailout;
 
 	mutex_lock(&ha->vport_lock);
 	/*
@@ -75,21 +75,29 @@ qla24xx_deallocate_vp_id(scsi_qla_host_t *vha)
 	 * ensures no active vp_list traversal while the vport is removed
 	 * from the queue)
 	 */
-	for (i = 0; i < 10; i++) {
-		if (wait_event_timeout(vha->vref_waitq,
-		    !atomic_read(&vha->vref_count), HZ) > 0)
+	bailout = 0;
+	for (i = 0; i < 500; i++) {
+		spin_lock_irqsave(&ha->vport_slock, flags);
+		if (atomic_read(&vha->vref_count) == 0) {
+			list_del(&vha->list);
+			qlt_update_vp_map(vha, RESET_VP_IDX);
+			bailout = 1;
+		}
+		spin_unlock_irqrestore(&ha->vport_slock, flags);
+
+		if (bailout)
 			break;
+		else
+			msleep(20);
 	}
-
-	spin_lock_irqsave(&ha->vport_slock, flags);
-	if (atomic_read(&vha->vref_count)) {
-		ql_dbg(ql_dbg_vport, vha, 0xfffa,
-		    "vha->vref_count=%u timeout\n", vha->vref_count.counter);
-		vha->vref_count = (atomic_t)ATOMIC_INIT(0);
+	if (!bailout) {
+		ql_log(ql_log_info, vha, 0xfffa,
+			"vha->vref_count=%u timeout\n", vha->vref_count.counter);
+		spin_lock_irqsave(&ha->vport_slock, flags);
+		list_del(&vha->list);
+		qlt_update_vp_map(vha, RESET_VP_IDX);
+		spin_unlock_irqrestore(&ha->vport_slock, flags);
 	}
-	list_del(&vha->list);
-	qlt_update_vp_map(vha, RESET_VP_IDX);
-	spin_unlock_irqrestore(&ha->vport_slock, flags);
 
 	vp_id = vha->vp_idx;
 	ha->num_vhosts--;
@@ -262,13 +270,13 @@ qla24xx_configure_vp(scsi_qla_host_t *vha)
 void
 qla2x00_alert_all_vps(struct rsp_que *rsp, uint16_t *mb)
 {
-	scsi_qla_host_t *vha;
+	scsi_qla_host_t *vha, *tvp;
 	struct qla_hw_data *ha = rsp->hw;
 	int i = 0;
 	unsigned long flags;
 
 	spin_lock_irqsave(&ha->vport_slock, flags);
-	list_for_each_entry(vha, &ha->vp_list, list) {
+	list_for_each_entry_safe(vha, tvp, &ha->vp_list, list) {
 		if (vha->vp_idx) {
 			if (test_bit(VPORT_DELETE, &vha->dpc_flags))
 				continue;
@@ -421,7 +429,7 @@ void
 qla2x00_do_dpc_all_vps(scsi_qla_host_t *vha)
 {
 	struct qla_hw_data *ha = vha->hw;
-	scsi_qla_host_t *vp;
+	scsi_qla_host_t *vp, *tvp;
 	unsigned long flags = 0;
 
 	if (vha->vp_idx)
@@ -435,7 +443,7 @@ qla2x00_do_dpc_all_vps(scsi_qla_host_t *vha)
 		return;
 
 	spin_lock_irqsave(&ha->vport_slock, flags);
-	list_for_each_entry(vp, &ha->vp_list, list) {
+	list_for_each_entry_safe(vp, tvp, &ha->vp_list, list) {
 		if (vp->vp_idx) {
 			atomic_inc(&vp->vref_count);
 			spin_unlock_irqrestore(&ha->vport_slock, flags);
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 995ab58d3288..b3e1d1c587ba 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -7533,7 +7533,7 @@ static void qla_pci_error_cleanup(scsi_qla_host_t *vha)
 	struct qla_hw_data *ha = vha->hw;
 	scsi_qla_host_t *base_vha = pci_get_drvdata(ha->pdev);
 	struct qla_qpair *qpair = NULL;
-	struct scsi_qla_host *vp;
+	struct scsi_qla_host *vp, *tvp;
 	fc_port_t *fcport;
 	int i;
 	unsigned long flags;
@@ -7564,7 +7564,7 @@ static void qla_pci_error_cleanup(scsi_qla_host_t *vha)
 	qla2x00_mark_all_devices_lost(vha);
 
 	spin_lock_irqsave(&ha->vport_slock, flags);
-	list_for_each_entry(vp, &ha->vp_list, list) {
+	list_for_each_entry_safe(vp, tvp, &ha->vp_list, list) {
 		atomic_inc(&vp->vref_count);
 		spin_unlock_irqrestore(&ha->vport_slock, flags);
 		qla2x00_mark_all_devices_lost(vp);
@@ -7578,7 +7578,7 @@ static void qla_pci_error_cleanup(scsi_qla_host_t *vha)
 		fcport->flags &= ~(FCF_LOGIN_NEEDED | FCF_ASYNC_SENT);
 
 	spin_lock_irqsave(&ha->vport_slock, flags);
-	list_for_each_entry(vp, &ha->vp_list, list) {
+	list_for_each_entry_safe(vp, tvp, &ha->vp_list, list) {
 		atomic_inc(&vp->vref_count);
 		spin_unlock_irqrestore(&ha->vport_slock, flags);
 		list_for_each_entry(fcport, &vp->vp_fcports, list)
-- 
2.19.0.rc0

