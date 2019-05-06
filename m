Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFA3415519
	for <lists+linux-scsi@lfdr.de>; Mon,  6 May 2019 22:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfEFUxh (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 6 May 2019 16:53:37 -0400
Received: from mail-eopbgr820045.outbound.protection.outlook.com ([40.107.82.45]:19273
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726369AbfEFUxg (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 6 May 2019 16:53:36 -0400
Received: from DM6PR07CA0012.namprd07.prod.outlook.com (2603:10b6:5:94::25) by
 DM6PR07MB6107.namprd07.prod.outlook.com (2603:10b6:5:18a::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Mon, 6 May 2019 20:53:33 +0000
Received: from DM3NAM05FT018.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::209) by DM6PR07CA0012.outlook.office365.com
 (2603:10b6:5:94::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1856.10 via Frontend
 Transport; Mon, 6 May 2019 20:53:33 +0000
Authentication-Results: spf=fail (sender IP is 199.233.58.38)
 smtp.mailfrom=marvell.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=marvell.com;
Received-SPF: Fail (protection.outlook.com: domain of marvell.com does not
 designate 199.233.58.38 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.233.58.38; helo=CAEXCH02.caveonetworks.com;
Received: from CAEXCH02.caveonetworks.com (199.233.58.38) by
 DM3NAM05FT018.mail.protection.outlook.com (10.152.98.127) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id
 15.20.1856.4 via Frontend Transport; Mon, 6 May 2019 20:53:32 +0000
Received: from dut1171.mv.qlogic.com (10.112.88.18) by
 CAEXCH02.caveonetworks.com (10.67.98.110) with Microsoft SMTP Server (TLS) id
 14.2.347.0; Mon, 6 May 2019 13:52:27 -0700
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])    by
 dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id x46KqQ2q007885;    Mon, 6
 May 2019 13:52:26 -0700
Received: (from root@localhost) by dut1171.mv.qlogic.com
 (8.14.7/8.14.7/Submit) id x46KqQBn007884;      Mon, 6 May 2019 13:52:26 -0700
From:   Himanshu Madhani <hmadhani@marvell.com>
To:     <James.Bottomley@HansenPartnership.com>,
        <martin.petersen@oracle.com>
CC:     <hmadhani@marvell.com>, <linux-scsi@vger.kernel.org>
Subject: [PATCH 2/2] qla2xxx: Add cleanup for PCI EEH recovery
Date:   Mon, 6 May 2019 13:52:19 -0700
Message-ID: <20190506205219.7842-3-hmadhani@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190506205219.7842-1-hmadhani@marvell.com>
References: <20190506205219.7842-1-hmadhani@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-Matching-Connectors: 132016496130921269;(abac79dc-c90b-41ba-8033-08d666125e47);(abac79dc-c90b-41ba-8033-08d666125e47)
X-Forefront-Antispam-Report: CIP:199.233.58.38;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39850400004)(136003)(346002)(376002)(396003)(2980300002)(1110001)(339900001)(189003)(199004)(498600001)(87636003)(53936002)(5660300002)(68736007)(80596001)(36756003)(69596002)(26826003)(85426001)(356004)(1076003)(14444005)(4326008)(6666004)(50226002)(81156014)(2616005)(126002)(70206006)(70586007)(76130400001)(486006)(336012)(26005)(446003)(476003)(54906003)(42186006)(2906002)(51416003)(305945005)(36906005)(110136005)(316002)(16586007)(11346002)(8676002)(47776003)(81166006)(8936002)(48376002)(105606002)(86362001)(76176011)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB6107;H:CAEXCH02.caveonetworks.com;FPR:;SPF:Fail;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 689f13f2-a6d6-4de0-66c7-08d6d264e6ca
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(5600141)(711020)(4605104)(2017052603328);SRVR:DM6PR07MB6107;
X-MS-TrafficTypeDiagnostic: DM6PR07MB6107:
X-Microsoft-Antispam-PRVS: <DM6PR07MB61076414844EE558B1325CFCD6300@DM6PR07MB6107.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0029F17A3F
X-Microsoft-Antispam-Message-Info: o9pveK6yBW9EnJplDjq7um8bXtWczc0y/EJx7eOwJH58FvFTwR3QpCIXvZOwo5XBYoDdTtvphIHqn9SNFXj2bwNxU9OdxAOwApB5xpTY4A0BTx2Dp1JDNoOih06pKooB84QAnk4dyNwTAMgWmwUtc/yoTgSlZkgn7SUIWMoh/zOttW38SIHsBGtmV/I9wXdRbnvUjOyFlEkFqQK16/PrKuiNJK6Zrl/2weAOq4482DhoEKvt0Vp9W96dXqUdinI626geO3oaiz1khAKHxR3CwVnIVmRxQZQrJTKKxkelB3kKslmto3i72rbKJLSgnZaMehBmYpbqay9XgWMFreVEaOUwT9qlV7WCJtQdrxWI39uRrftgxQV4rZLWA2dMDtqF7Z/ZwU08j/9daysPJsfoqpyxv7Xd0+rYxsn3FBsY60A=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2019 20:53:32.5917
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 689f13f2-a6d6-4de0-66c7-08d6d264e6ca
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[199.233.58.38];Helo=[CAEXCH02.caveonetworks.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB6107
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Quinn Tran <qutran@marvell.com>

During EEH error recovery testing, it  was discovered that
driver's reset() callback partially frees resources used by driver,
leaving some stale memory.  After reset() is done and when  resume()
callback in driver uses old data which results into error leaving
adapter disabled due to PCIe error.

This patch does cleanup for EEH recovery code path and prevents
adapter from getting disabled.

Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
---
 drivers/scsi/qla2xxx/qla_os.c | 221 ++++++++++++++++--------------------------
 1 file changed, 82 insertions(+), 139 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index e1c82a0a9745..172ef21827dd 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -6826,6 +6826,78 @@ qla2x00_release_firmware(void)
 	mutex_unlock(&qla_fw_lock);
 }
 
+static void qla_pci_error_cleanup(scsi_qla_host_t *vha)
+{
+	struct qla_hw_data *ha = vha->hw;
+	scsi_qla_host_t *base_vha = pci_get_drvdata(ha->pdev);
+	struct qla_qpair *qpair = NULL;
+	struct scsi_qla_host *vp;
+	fc_port_t *fcport;
+	int i;
+	unsigned long flags;
+
+	ha->chip_reset++;
+
+	ha->base_qpair->chip_reset = ha->chip_reset;
+	for (i = 0; i < ha->max_qpairs; i++) {
+		if (ha->queue_pair_map[i])
+			ha->queue_pair_map[i]->chip_reset =
+			    ha->base_qpair->chip_reset;
+	}
+
+	/* purge MBox commands */
+	if (atomic_read(&ha->num_pend_mbx_stage3)) {
+		clear_bit(MBX_INTR_WAIT, &ha->mbx_cmd_flags);
+		complete(&ha->mbx_intr_comp);
+	}
+
+	i = 0;
+
+	while (atomic_read(&ha->num_pend_mbx_stage3) ||
+	    atomic_read(&ha->num_pend_mbx_stage2) ||
+	    atomic_read(&ha->num_pend_mbx_stage1)) {
+		msleep(20);
+		i++;
+		if (i > 50)
+			break;
+	}
+
+	ha->flags.purge_mbox = 0;
+
+	mutex_lock(&ha->mq_lock);
+	list_for_each_entry(qpair, &base_vha->qp_list, qp_list_elem)
+		qpair->online = 0;
+	mutex_unlock(&ha->mq_lock);
+
+	qla2x00_mark_all_devices_lost(vha, 0);
+
+	spin_lock_irqsave(&ha->vport_slock, flags);
+	list_for_each_entry(vp, &ha->vp_list, list) {
+		atomic_inc(&vp->vref_count);
+		spin_unlock_irqrestore(&ha->vport_slock, flags);
+		qla2x00_mark_all_devices_lost(vp, 0);
+		spin_lock_irqsave(&ha->vport_slock, flags);
+		atomic_dec(&vp->vref_count);
+	}
+	spin_unlock_irqrestore(&ha->vport_slock, flags);
+
+	/* Clear all async request states across all VPs. */
+	list_for_each_entry(fcport, &vha->vp_fcports, list)
+		fcport->flags &= ~(FCF_LOGIN_NEEDED | FCF_ASYNC_SENT);
+
+	spin_lock_irqsave(&ha->vport_slock, flags);
+	list_for_each_entry(vp, &ha->vp_list, list) {
+		atomic_inc(&vp->vref_count);
+		spin_unlock_irqrestore(&ha->vport_slock, flags);
+		list_for_each_entry(fcport, &vp->vp_fcports, list)
+			fcport->flags &= ~(FCF_LOGIN_NEEDED | FCF_ASYNC_SENT);
+		spin_lock_irqsave(&ha->vport_slock, flags);
+		atomic_dec(&vp->vref_count);
+	}
+	spin_unlock_irqrestore(&ha->vport_slock, flags);
+}
+
+
 static pci_ers_result_t
 qla2xxx_pci_error_detected(struct pci_dev *pdev, pci_channel_state_t state)
 {
@@ -6851,20 +6923,7 @@ qla2xxx_pci_error_detected(struct pci_dev *pdev, pci_channel_state_t state)
 		return PCI_ERS_RESULT_CAN_RECOVER;
 	case pci_channel_io_frozen:
 		ha->flags.eeh_busy = 1;
-		/* For ISP82XX complete any pending mailbox cmd */
-		if (IS_QLA82XX(ha)) {
-			ha->flags.isp82xx_fw_hung = 1;
-			ql_dbg(ql_dbg_aer, vha, 0x9001, "Pci channel io frozen\n");
-			qla82xx_clear_pending_mbx(vha);
-		}
-		qla2x00_free_irqs(vha);
-		pci_disable_device(pdev);
-		/* Return back all IOs */
-		qla2x00_abort_all_cmds(vha, DID_RESET << 16);
-		if (ql2xmqsupport || ql2xnvmeenable) {
-			set_bit(QPAIR_ONLINE_CHECK_NEEDED, &vha->dpc_flags);
-			qla2xxx_wake_dpc(vha);
-		}
+		qla_pci_error_cleanup(vha);
 		return PCI_ERS_RESULT_NEED_RESET;
 	case pci_channel_io_perm_failure:
 		ha->flags.pci_channel_io_perm_failure = 1;
@@ -6918,122 +6977,14 @@ qla2xxx_pci_mmio_enabled(struct pci_dev *pdev)
 		return PCI_ERS_RESULT_RECOVERED;
 }
 
-static uint32_t
-qla82xx_error_recovery(scsi_qla_host_t *base_vha)
-{
-	uint32_t rval = QLA_FUNCTION_FAILED;
-	uint32_t drv_active = 0;
-	struct qla_hw_data *ha = base_vha->hw;
-	int fn;
-	struct pci_dev *other_pdev = NULL;
-
-	ql_dbg(ql_dbg_aer, base_vha, 0x9006,
-	    "Entered %s.\n", __func__);
-
-	set_bit(ABORT_ISP_ACTIVE, &base_vha->dpc_flags);
-
-	if (base_vha->flags.online) {
-		/* Abort all outstanding commands,
-		 * so as to be requeued later */
-		qla2x00_abort_isp_cleanup(base_vha);
-	}
-
-
-	fn = PCI_FUNC(ha->pdev->devfn);
-	while (fn > 0) {
-		fn--;
-		ql_dbg(ql_dbg_aer, base_vha, 0x9007,
-		    "Finding pci device at function = 0x%x.\n", fn);
-		other_pdev =
-		    pci_get_domain_bus_and_slot(pci_domain_nr(ha->pdev->bus),
-		    ha->pdev->bus->number, PCI_DEVFN(PCI_SLOT(ha->pdev->devfn),
-		    fn));
-
-		if (!other_pdev)
-			continue;
-		if (atomic_read(&other_pdev->enable_cnt)) {
-			ql_dbg(ql_dbg_aer, base_vha, 0x9008,
-			    "Found PCI func available and enable at 0x%x.\n",
-			    fn);
-			pci_dev_put(other_pdev);
-			break;
-		}
-		pci_dev_put(other_pdev);
-	}
-
-	if (!fn) {
-		/* Reset owner */
-		ql_dbg(ql_dbg_aer, base_vha, 0x9009,
-		    "This devfn is reset owner = 0x%x.\n",
-		    ha->pdev->devfn);
-		qla82xx_idc_lock(ha);
-
-		qla82xx_wr_32(ha, QLA82XX_CRB_DEV_STATE,
-		    QLA8XXX_DEV_INITIALIZING);
-
-		qla82xx_wr_32(ha, QLA82XX_CRB_DRV_IDC_VERSION,
-		    QLA82XX_IDC_VERSION);
-
-		drv_active = qla82xx_rd_32(ha, QLA82XX_CRB_DRV_ACTIVE);
-		ql_dbg(ql_dbg_aer, base_vha, 0x900a,
-		    "drv_active = 0x%x.\n", drv_active);
-
-		qla82xx_idc_unlock(ha);
-		/* Reset if device is not already reset
-		 * drv_active would be 0 if a reset has already been done
-		 */
-		if (drv_active)
-			rval = qla82xx_start_firmware(base_vha);
-		else
-			rval = QLA_SUCCESS;
-		qla82xx_idc_lock(ha);
-
-		if (rval != QLA_SUCCESS) {
-			ql_log(ql_log_info, base_vha, 0x900b,
-			    "HW State: FAILED.\n");
-			qla82xx_clear_drv_active(ha);
-			qla82xx_wr_32(ha, QLA82XX_CRB_DEV_STATE,
-			    QLA8XXX_DEV_FAILED);
-		} else {
-			ql_log(ql_log_info, base_vha, 0x900c,
-			    "HW State: READY.\n");
-			qla82xx_wr_32(ha, QLA82XX_CRB_DEV_STATE,
-			    QLA8XXX_DEV_READY);
-			qla82xx_idc_unlock(ha);
-			ha->flags.isp82xx_fw_hung = 0;
-			rval = qla82xx_restart_isp(base_vha);
-			qla82xx_idc_lock(ha);
-			/* Clear driver state register */
-			qla82xx_wr_32(ha, QLA82XX_CRB_DRV_STATE, 0);
-			qla82xx_set_drv_active(base_vha);
-		}
-		qla82xx_idc_unlock(ha);
-	} else {
-		ql_dbg(ql_dbg_aer, base_vha, 0x900d,
-		    "This devfn is not reset owner = 0x%x.\n",
-		    ha->pdev->devfn);
-		if ((qla82xx_rd_32(ha, QLA82XX_CRB_DEV_STATE) ==
-		    QLA8XXX_DEV_READY)) {
-			ha->flags.isp82xx_fw_hung = 0;
-			rval = qla82xx_restart_isp(base_vha);
-			qla82xx_idc_lock(ha);
-			qla82xx_set_drv_active(base_vha);
-			qla82xx_idc_unlock(ha);
-		}
-	}
-	clear_bit(ABORT_ISP_ACTIVE, &base_vha->dpc_flags);
-
-	return rval;
-}
-
 static pci_ers_result_t
 qla2xxx_pci_slot_reset(struct pci_dev *pdev)
 {
 	pci_ers_result_t ret = PCI_ERS_RESULT_DISCONNECT;
 	scsi_qla_host_t *base_vha = pci_get_drvdata(pdev);
 	struct qla_hw_data *ha = base_vha->hw;
-	struct rsp_que *rsp;
-	int rc, retries = 10;
+	int rc;
+	struct qla_qpair *qpair = NULL;
 
 	ql_dbg(ql_dbg_aer, base_vha, 0x9004,
 	    "Slot Reset.\n");
@@ -7062,24 +7013,16 @@ qla2xxx_pci_slot_reset(struct pci_dev *pdev)
 		goto exit_slot_reset;
 	}
 
-	rsp = ha->rsp_q_map[0];
-	if (qla2x00_request_irqs(ha, rsp))
-		goto exit_slot_reset;
 
 	if (ha->isp_ops->pci_config(base_vha))
 		goto exit_slot_reset;
 
-	if (IS_QLA82XX(ha)) {
-		if (qla82xx_error_recovery(base_vha) == QLA_SUCCESS) {
-			ret = PCI_ERS_RESULT_RECOVERED;
-			goto exit_slot_reset;
-		} else
-			goto exit_slot_reset;
-	}
-
-	while (ha->flags.mbox_busy && retries--)
-		msleep(1000);
+	mutex_lock(&ha->mq_lock);
+	list_for_each_entry(qpair, &base_vha->qp_list, qp_list_elem)
+		qpair->online = 1;
+	mutex_unlock(&ha->mq_lock);
 
+	base_vha->flags.online = 1;
 	set_bit(ABORT_ISP_ACTIVE, &base_vha->dpc_flags);
 	if (ha->isp_ops->abort_isp(base_vha) == QLA_SUCCESS)
 		ret =  PCI_ERS_RESULT_RECOVERED;
@@ -7103,13 +7046,13 @@ qla2xxx_pci_resume(struct pci_dev *pdev)
 	ql_dbg(ql_dbg_aer, base_vha, 0x900f,
 	    "pci_resume.\n");
 
+	ha->flags.eeh_busy = 0;
+
 	ret = qla2x00_wait_for_hba_online(base_vha);
 	if (ret != QLA_SUCCESS) {
 		ql_log(ql_log_fatal, base_vha, 0x9002,
 		    "The device failed to resume I/O from slot/link_reset.\n");
 	}
-
-	ha->flags.eeh_busy = 0;
 }
 
 static void
-- 
2.12.0

