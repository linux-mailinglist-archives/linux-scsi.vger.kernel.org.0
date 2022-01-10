Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089B2488F77
	for <lists+linux-scsi@lfdr.de>; Mon, 10 Jan 2022 06:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235068AbiAJFDM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 10 Jan 2022 00:03:12 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:55302 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235011AbiAJFC6 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 10 Jan 2022 00:02:58 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 209KQlqf023499
        for <linux-scsi@vger.kernel.org>; Sun, 9 Jan 2022 21:02:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=mHS7ngIF2L4DDvjanc1IJ+UNz1UEe+lbdRTrmGSTVy8=;
 b=EbXC0055q6kWPOXAK/zvjkHZ//cMAwW47cKY6VAU0FyudTAOaDDiDICGf1LK/gpBPPGt
 vS3pgzvzQGDc22HswWAOoOXAWW6AQjHJ7HIw9rnSz4z3z+yEpEXN0hbRAsfAR8TpzK8s
 taYeP5efXc+Bt5fzOYWSSKb+MxqvLAPJjs9HJzjncTeMnX8itWgljfx35Lem68RZwQ9S
 BteYKATMJ5FIQd6uJD9SdiGUfrIwIa/9+832ResHqk2yiVJRQYL+r/uRcZn9SH4WSZp6
 2zQy1FVNxpbYfL9N4WqICO6G4RPQFTS71WY3+IcjRBIOt8scWpMuQwXLwkqL0rRF7TWx LA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3dfy8nhjf0-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Sun, 09 Jan 2022 21:02:57 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 9 Jan
 2022 21:02:54 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 9 Jan 2022 21:02:54 -0800
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id A24803F70A5;
        Sun,  9 Jan 2022 21:02:54 -0800 (PST)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id 20A52suh004009;
        Sun, 9 Jan 2022 21:02:54 -0800
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id 20A52sGQ004008;
        Sun, 9 Jan 2022 21:02:54 -0800
From:   Nilesh Javali <njavali@marvell.com>
To:     <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>
Subject: [PATCH v2 04/17] qla2xxx: Fix warning message due to adisc is being flush
Date:   Sun, 9 Jan 2022 21:02:05 -0800
Message-ID: <20220110050218.3958-5-njavali@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20220110050218.3958-1-njavali@marvell.com>
References: <20220110050218.3958-1-njavali@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: B3ELXv8bxMaLrmJzJ8mSCA_TPXGt3-lI
X-Proofpoint-ORIG-GUID: B3ELXv8bxMaLrmJzJ8mSCA_TPXGt3-lI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-10_01,2022-01-07_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Quinn Tran <qutran@marvell.com>

Fix warning message due to adisc is being flush.
Linux kernel triggered a warning message where a different
error code type is not matching up with the expected type. This
patch adds additional translation of one error code type to another.

WARNING: CPU: 2 PID: 1131623 at drivers/scsi/qla2xxx/qla_init.c:498
qla2x00_async_adisc_sp_done+0x294/0x2b0 [qla2xxx]
CPU: 2 PID: 1131623 Comm: drmgr Not tainted 5.13.0-rc1-autotest #1
..
GPR28: c000000aaa9c8890 c0080000079ab678 c00000140a104800 c00000002bd19000
NIP [c00800000790857c] qla2x00_async_adisc_sp_done+0x294/0x2b0 [qla2xxx]
LR [c008000007908578] qla2x00_async_adisc_sp_done+0x290/0x2b0 [qla2xxx]
Call Trace:
[c00000001cdc3620] [c008000007908578] qla2x00_async_adisc_sp_done+0x290/0x2b0 [qla2xxx] (unreliable)
[c00000001cdc3710] [c0080000078f3080] __qla2x00_abort_all_cmds+0x1b8/0x580 [qla2xxx]
[c00000001cdc3840] [c0080000078f589c] qla2x00_abort_all_cmds+0x34/0xd0 [qla2xxx]
[c00000001cdc3880] [c0080000079153d8] qla2x00_abort_isp_cleanup+0x3f0/0x570 [qla2xxx]
[c00000001cdc3920] [c0080000078fb7e8] qla2x00_remove_one+0x3d0/0x480 [qla2xxx]
[c00000001cdc39b0] [c00000000071c274] pci_device_remove+0x64/0x120
[c00000001cdc39f0] [c0000000007fb818] device_release_driver_internal+0x168/0x2a0
[c00000001cdc3a30] [c00000000070e304] pci_stop_bus_device+0xb4/0x100
[c00000001cdc3a70] [c00000000070e4f0] pci_stop_and_remove_bus_device+0x20/0x40
[c00000001cdc3aa0] [c000000000073940] pci_hp_remove_devices+0x90/0x130
[c00000001cdc3b30] [c0080000070704d0] disable_slot+0x38/0x90 [rpaphp] [
c00000001cdc3b60] [c00000000073eb4c] power_write_file+0xcc/0x180
[c00000001cdc3be0] [c0000000007354bc] pci_slot_attr_store+0x3c/0x60
[c00000001cdc3c00] [c00000000055f820] sysfs_kf_write+0x60/0x80 [c00000001cdc3c20]
[c00000000055df10] kernfs_fop_write_iter+0x1a0/0x290
[c00000001cdc3c70] [c000000000447c4c] new_sync_write+0x14c/0x1d0
[c00000001cdc3d10] [c00000000044b134] vfs_write+0x224/0x330
[c00000001cdc3d60] [c00000000044b3f4] ksys_write+0x74/0x130
[c00000001cdc3db0] [c00000000002df70] system_call_exception+0x150/0x2d0
[c00000001cdc3e10] [c00000000000d45c] system_call_common+0xec/0x278

Reported-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
---
 drivers/scsi/qla2xxx/qla_init.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 0b641a803f7c..e54c31296fab 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -295,6 +295,8 @@ static void qla2x00_async_login_sp_done(srb_t *sp, int res)
 		ea.iop[0] = lio->u.logio.iop[0];
 		ea.iop[1] = lio->u.logio.iop[1];
 		ea.sp = sp;
+		if (res)
+			ea.data[0] = MBS_COMMAND_ERROR;
 		qla24xx_handle_plogi_done_event(vha, &ea);
 	}
 
@@ -557,6 +559,8 @@ static void qla2x00_async_adisc_sp_done(srb_t *sp, int res)
 	ea.iop[1] = lio->u.logio.iop[1];
 	ea.fcport = sp->fcport;
 	ea.sp = sp;
+	if (res)
+		ea.data[0] = MBS_COMMAND_ERROR;
 
 	qla24xx_handle_adisc_event(vha, &ea);
 	/* ref: INIT */
@@ -1237,6 +1241,8 @@ static void qla2x00_async_prli_sp_done(srb_t *sp, int res)
 		ea.sp = sp;
 		if (res == QLA_OS_TIMER_EXPIRED)
 			ea.data[0] = QLA_OS_TIMER_EXPIRED;
+		else if (res)
+			ea.data[0] = MBS_COMMAND_ERROR;
 
 		qla24xx_handle_prli_done_event(vha, &ea);
 	}
-- 
2.23.1

