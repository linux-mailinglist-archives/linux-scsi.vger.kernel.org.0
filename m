Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAFFB1455
	for <lists+linux-scsi@lfdr.de>; Thu, 12 Sep 2019 20:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfILSMC (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 12 Sep 2019 14:12:02 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:21448 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726986AbfILSMC (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 12 Sep 2019 14:12:02 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8CI9svC010843;
        Thu, 12 Sep 2019 11:10:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=N9S8cn6GHNB7vbsfSNYcsmXDjr7QwKt4Qw0vVDejZoM=;
 b=mGRFcUNlYqhxUfNbBn8YAn9YSkutqccdhmuqgJvSHkBcMIKqohxqIh0AhdvG751yJDK0
 RHvCc4w5U0oA1xPYrMvr1DCdGBqBzV4GLc8+NyB0xOHnA93Y3Jgn7goeMtgEgvAUbFjB
 UGA9WS0spnCjeYG334SJkNRTclon45anh1TKMOx544j2QdfmDgRXFUCtEtNYUwO4MP4x
 O+ybs04+6cRrSzRrYSgX395aSC3t6NJzh2fXTZ5yTdd9t2oEYCo3RhBKGRIyOOyGsS6G
 BK3yJhJBPkLv9/vPkYbt+ppdl9NX4tcADAwBGHOlX/3M1RidBfXOzgRoWgM02cSNQk22 sg== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2uytdh068j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 12 Sep 2019 11:10:01 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 12 Sep
 2019 11:10:00 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Thu, 12 Sep 2019 11:10:00 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id 7CFC73F7040;
        Thu, 12 Sep 2019 11:10:00 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id x8CIA0Dc006519;
        Thu, 12 Sep 2019 11:10:00 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id x8CIA0AM006518;
        Thu, 12 Sep 2019 11:10:00 -0700
From:   Himanshu Madhani <hmadhani@marvell.com>
To:     <James.Bottomley@HansenPartnership.com>,
        <martin.petersen@oracle.com>
CC:     <hmadhani@marvell.com>, <linux-scsi@vger.kernel.org>
Subject: [PATCH v2 12/14] qla2xxx: Capture FW dump on MPI heartbeat stop event
Date:   Thu, 12 Sep 2019 11:09:16 -0700
Message-ID: <20190912180918.6436-13-hmadhani@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190912180918.6436-1-hmadhani@marvell.com>
References: <20190912180918.6436-1-hmadhani@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-12_09:2019-09-11,2019-09-12 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Quinn Tran <qutran@marvell.com>

For MPI heartbeat stop Async Event, this patch would capture
MPI FW dump and chip reset. FW will tell which function to
capture FW dump for.

Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
---
 drivers/scsi/qla2xxx/qla_attr.c |  4 +++-
 drivers/scsi/qla2xxx/qla_isr.c  | 31 ++++++++++++++++++++++++++-----
 drivers/scsi/qla2xxx/qla_tmpl.c |  4 +++-
 3 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_attr.c b/drivers/scsi/qla2xxx/qla_attr.c
index 8b3015361428..d6b585d303b7 100644
--- a/drivers/scsi/qla2xxx/qla_attr.c
+++ b/drivers/scsi/qla2xxx/qla_attr.c
@@ -102,8 +102,10 @@ qla2x00_sysfs_write_fw_dump(struct file *filp, struct kobject *kobj,
 			qla8044_idc_lock(ha);
 			qla82xx_set_reset_owner(vha);
 			qla8044_idc_unlock(ha);
-		} else
+		} else {
+			ha->fw_dump_mpi = 1;
 			qla2x00_system_error(vha);
+		}
 		break;
 	case 4:
 		if (IS_P3P_TYPE(ha)) {
diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index 4c26630c1c3e..30fd2d355f3a 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -1227,11 +1227,32 @@ qla2x00_async_event(scsi_qla_host_t *vha, struct rsp_que *rsp, uint16_t *mb)
 		break;
 
 	case MBA_IDC_AEN:
-		mb[4] = RD_REG_WORD(&reg24->mailbox4);
-		mb[5] = RD_REG_WORD(&reg24->mailbox5);
-		mb[6] = RD_REG_WORD(&reg24->mailbox6);
-		mb[7] = RD_REG_WORD(&reg24->mailbox7);
-		qla83xx_handle_8200_aen(vha, mb);
+		if (IS_QLA27XX(ha) || IS_QLA28XX(ha)) {
+			ha->flags.fw_init_done = 0;
+			ql_log(ql_log_warn, vha, 0xffff,
+			    "MPI Heartbeat stop. Chip reset needed. MB0[%xh] MB1[%xh] MB2[%xh] MB3[%xh]\n",
+			    mb[0], mb[1], mb[2], mb[3]);
+
+			if ((mb[1] & BIT_8) ||
+			    (mb[2] & BIT_8)) {
+				ql_log(ql_log_warn, vha, 0xd013,
+				    "MPI Heartbeat stop. FW dump needed\n");
+				ha->fw_dump_mpi = 1;
+				ha->isp_ops->fw_dump(vha, 1);
+			}
+			set_bit(ISP_ABORT_NEEDED, &vha->dpc_flags);
+			qla2xxx_wake_dpc(vha);
+		} else if (IS_QLA83XX(ha)) {
+			mb[4] = RD_REG_WORD(&reg24->mailbox4);
+			mb[5] = RD_REG_WORD(&reg24->mailbox5);
+			mb[6] = RD_REG_WORD(&reg24->mailbox6);
+			mb[7] = RD_REG_WORD(&reg24->mailbox7);
+			qla83xx_handle_8200_aen(vha, mb);
+		} else {
+			ql_dbg(ql_dbg_async, vha, 0x5052,
+			    "skip Heartbeat processing mb0-3=[0x%04x] [0x%04x] [0x%04x] [0x%04x]\n",
+			    mb[0], mb[1], mb[2], mb[3]);
+		}
 		break;
 
 	case MBA_DPORT_DIAGNOSTICS:
diff --git a/drivers/scsi/qla2xxx/qla_tmpl.c b/drivers/scsi/qla2xxx/qla_tmpl.c
index b948d94c8b3c..5b0c057def2b 100644
--- a/drivers/scsi/qla2xxx/qla_tmpl.c
+++ b/drivers/scsi/qla2xxx/qla_tmpl.c
@@ -1017,8 +1017,9 @@ qla27xx_fwdump(scsi_qla_host_t *vha, int hardware_locked)
 		uint j;
 		ulong len;
 		void *buf = vha->hw->fw_dump;
+		uint count = vha->hw->fw_dump_mpi ? 2 : 1;
 
-		for (j = 0; j < 2; j++, fwdt++, buf += len) {
+		for (j = 0; j < count; j++, fwdt++, buf += len) {
 			ql_log(ql_log_warn, vha, 0xd011,
 			    "-> fwdt%u running...\n", j);
 			if (!fwdt->template) {
@@ -1046,6 +1047,7 @@ qla27xx_fwdump(scsi_qla_host_t *vha, int hardware_locked)
 	}
 
 bailout:
+	vha->hw->fw_dump_mpi = 0;
 #ifndef __CHECKER__
 	if (!hardware_locked)
 		spin_unlock_irqrestore(&vha->hw->hardware_lock, flags);
-- 
2.12.0

