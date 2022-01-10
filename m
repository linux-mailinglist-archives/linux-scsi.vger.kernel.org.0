Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED6EA488F78
	for <lists+linux-scsi@lfdr.de>; Mon, 10 Jan 2022 06:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238591AbiAJFDM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 10 Jan 2022 00:03:12 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:25024 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235044AbiAJFC6 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 10 Jan 2022 00:02:58 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 209KQlqg023499
        for <linux-scsi@vger.kernel.org>; Sun, 9 Jan 2022 21:02:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=jEnnvCb1/CfpBcKcCeHbrBfU0NczkboYKqSvB4y6WSI=;
 b=ecgiJibVzrB9c1VNCl+O5QyTj0UD/RGKG/m+UiegSQ8+lLrjKdDN07MPBxkeAN4/1Jyy
 iLR5lJnUrbkPSeWb2Vu8BrvLJK3FEtKQX3tELDieN8wvgeAnAlwW4adraNxw8FT0kry4
 RmPy57tF9f+mVAdfdWbn6XKQ3sh4JXK3DYtsJlcJRYNXf2g7AE+pyOtrgtr9zR4sUtaE
 OU7xE22CMzIVvCOvVMFh4oqfpv2Nw+wHaM/UT9pODi81r6dbhCSz/AQW1cHbmpOwod+u
 KVHDFj46gUsdi/lFvm3I8O3WXauMUR1g2tOMppX9Ti3gRLnWh6TjWyS76/PDoGtGukeV YQ== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3dfy8nhjf0-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Sun, 09 Jan 2022 21:02:58 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 9 Jan
 2022 21:02:54 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Sun, 9 Jan 2022 21:02:54 -0800
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id BA9033F70A6;
        Sun,  9 Jan 2022 21:02:54 -0800 (PST)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id 20A52sSW004013;
        Sun, 9 Jan 2022 21:02:54 -0800
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id 20A52sTG004012;
        Sun, 9 Jan 2022 21:02:54 -0800
From:   Nilesh Javali <njavali@marvell.com>
To:     <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>
Subject: [PATCH v2 05/17] qla2xxx: Fix premature hw access after pci error
Date:   Sun, 9 Jan 2022 21:02:06 -0800
Message-ID: <20220110050218.3958-6-njavali@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20220110050218.3958-1-njavali@marvell.com>
References: <20220110050218.3958-1-njavali@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: HDAlKU9qas8YSentBwX7mJ4B2ODAZxCq
X-Proofpoint-ORIG-GUID: HDAlKU9qas8YSentBwX7mJ4B2ODAZxCq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-10_01,2022-01-07_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Quinn Tran <qutran@marvell.com>

Fix premature hw access after pci error.
After a recoverable PCI error has been detected and recovered, qla driver
needs to check to see if the error condition still persist and/or wait until
the OS to give the resume signal.

Sep  8 22:26:03 localhost kernel: WARNING: CPU: 9 PID: 124606 at qla_tmpl.c:440
qla27xx_fwdt_entry_t266+0x55/0x60 [qla2xxx]
Sep  8 22:26:03 localhost kernel: RIP: 0010:qla27xx_fwdt_entry_t266+0x55/0x60
[qla2xxx]
Sep  8 22:26:03 localhost kernel: Call Trace:
Sep  8 22:26:03 localhost kernel: ? qla27xx_walk_template+0xb1/0x1b0 [qla2xxx]
Sep  8 22:26:03 localhost kernel: ? qla27xx_execute_fwdt_template+0x12a/0x160
[qla2xxx]
Sep  8 22:26:03 localhost kernel: ? qla27xx_fwdump+0xa0/0x1c0 [qla2xxx]
Sep  8 22:26:03 localhost kernel: ? qla2xxx_pci_mmio_enabled+0xfb/0x120
[qla2xxx]
Sep  8 22:26:03 localhost kernel: ? report_mmio_enabled+0x44/0x80
Sep  8 22:26:03 localhost kernel: ? report_slot_reset+0x80/0x80
Sep  8 22:26:03 localhost kernel: ? pci_walk_bus+0x70/0x90
Sep  8 22:26:03 localhost kernel: ? aer_dev_correctable_show+0xc0/0xc0
Sep  8 22:26:03 localhost kernel: ? pcie_do_recovery+0x1bb/0x240
Sep  8 22:26:03 localhost kernel: ? aer_recover_work_func+0xaa/0xd0
Sep  8 22:26:03 localhost kernel: ? process_one_work+0x1a7/0x360
..
Sep  8 22:26:03 localhost kernel: qla2xxx [0000:42:00.2]-8041:22: detected PCI
disconnect.
Sep  8 22:26:03 localhost kernel: qla2xxx [0000:42:00.2]-107ff:22:
qla27xx_fwdt_entry_t262: dump ram MB failed. Area 5h start 198013h end 198013h
Sep  8 22:26:03 localhost kernel: qla2xxx [0000:42:00.2]-107ff:22: Unable to
capture FW dump
Sep  8 22:26:03 localhost kernel: qla2xxx [0000:42:00.2]-1015:22: cmd=0x0,
waited 5221 msecs
Sep  8 22:26:03 localhost kernel: qla2xxx [0000:42:00.2]-680d:22: mmio
enabled returning.
Sep  8 22:26:03 localhost kernel: qla2xxx [0000:42:00.2]-d04c:22: MBX
Command timeout for cmd 0, iocontrol=ffffffff jiffies=10140f2e5
mb[0-3]=[0xffff 0xffff 0xffff 0xffff]

Cc: stable@vger.kernel.org
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
---
 drivers/scsi/qla2xxx/qla_os.c   | 10 +++++++++-
 drivers/scsi/qla2xxx/qla_tmpl.c |  9 +++++++--
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 0a7b00d165c7..c4b4b4496399 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -7639,7 +7639,7 @@ qla2xxx_pci_error_detected(struct pci_dev *pdev, pci_channel_state_t state)
 
 	switch (state) {
 	case pci_channel_io_normal:
-		ha->flags.eeh_busy = 0;
+		qla_pci_set_eeh_busy(vha);
 		if (ql2xmqsupport || ql2xnvmeenable) {
 			set_bit(QPAIR_ONLINE_CHECK_NEEDED, &vha->dpc_flags);
 			qla2xxx_wake_dpc(vha);
@@ -7680,9 +7680,16 @@ qla2xxx_pci_mmio_enabled(struct pci_dev *pdev)
 	       "mmio enabled\n");
 
 	ha->pci_error_state = QLA_PCI_MMIO_ENABLED;
+
 	if (IS_QLA82XX(ha))
 		return PCI_ERS_RESULT_RECOVERED;
 
+	if (qla2x00_isp_reg_stat(ha)) {
+		ql_log(ql_log_info, base_vha, 0x803f,
+		    "During mmio enabled, PCI/Register disconnect still detected.\n");
+		goto out;
+	}
+
 	spin_lock_irqsave(&ha->hardware_lock, flags);
 	if (IS_QLA2100(ha) || IS_QLA2200(ha)){
 		stat = rd_reg_word(&reg->hccr);
@@ -7704,6 +7711,7 @@ qla2xxx_pci_mmio_enabled(struct pci_dev *pdev)
 		    "RISC paused -- mmio_enabled, Dumping firmware.\n");
 		qla2xxx_dump_fw(base_vha);
 	}
+out:
 	/* set PCI_ERS_RESULT_NEED_RESET to trigger call to qla2xxx_pci_slot_reset */
 	ql_dbg(ql_dbg_aer, base_vha, 0x600d,
 	       "mmio enabled returning.\n");
diff --git a/drivers/scsi/qla2xxx/qla_tmpl.c b/drivers/scsi/qla2xxx/qla_tmpl.c
index 26c13a953b97..b0a74b036cf4 100644
--- a/drivers/scsi/qla2xxx/qla_tmpl.c
+++ b/drivers/scsi/qla2xxx/qla_tmpl.c
@@ -435,8 +435,13 @@ qla27xx_fwdt_entry_t266(struct scsi_qla_host *vha,
 {
 	ql_dbg(ql_dbg_misc, vha, 0xd20a,
 	    "%s: reset risc [%lx]\n", __func__, *len);
-	if (buf)
-		WARN_ON_ONCE(qla24xx_soft_reset(vha->hw) != QLA_SUCCESS);
+	if (buf) {
+		if (qla24xx_soft_reset(vha->hw) != QLA_SUCCESS) {
+			ql_dbg(ql_dbg_async, vha, 0x5001,
+			    "%s: unable to soft reset\n", __func__);
+			return INVALID_ENTRY;
+		}
+	}
 
 	return qla27xx_next_entry(ent);
 }
-- 
2.23.1

