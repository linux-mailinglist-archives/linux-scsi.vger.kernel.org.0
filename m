Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA42E460F1
	for <lists+linux-scsi@lfdr.de>; Fri, 14 Jun 2019 16:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbfFNOgf (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 14 Jun 2019 10:36:35 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:51586 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728201AbfFNOge (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 14 Jun 2019 10:36:34 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5EEKEOY025647;
        Fri, 14 Jun 2019 07:36:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0818;
 bh=S9FA1uJ09pKOzT1uWxGtIMO7azuJQOnuu2jScLoqKcY=;
 b=vmLUnxzX+uLU1zAV84MRz840QnXPcYFmUT8FNpu7uFkk13r89+4kBRNkK/5wFoyT0p5f
 xph2DU8l0NG6YWP3xJXgJasklPohBBfMlPJynDjQYcmb0/m+gUZ146tjRFEEC8oG8IBe
 8KHAKSyKr4xzs74AqpZGAdceWXEo6vKJafKCqfqdLqfDinKyqY58PbEU0naZC51dO589
 lxR3MDiT3chHEEPSQPpoPtY1FOKO9qtU9qjxuHuTGTlXf/0l4MfP2R/UJqWpSe18sC7B
 j9l2dZFffMK1PdAfNffzMj+m0z6qd/UBafTeSEdGHy/KdjYhbqNtZarvuh+rVr3ZcqmC 4A== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2t3hvpxf4g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 14 Jun 2019 07:36:29 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 14 Jun
 2019 07:36:27 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Fri, 14 Jun 2019 07:36:27 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id ACE423F703F;
        Fri, 14 Jun 2019 07:36:27 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id x5EEaRp7010803;
        Fri, 14 Jun 2019 07:36:27 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id x5EEaRtL010802;
        Fri, 14 Jun 2019 07:36:27 -0700
From:   Himanshu Madhani <hmadhani@marvell.com>
To:     <James.Bottomley@HansenPartnership.com>,
        <martin.petersen@oracle.com>
CC:     <hmadhani@marvell.com>, <linux-scsi@vger.kernel.org>
Subject: [PATCH] qla2xxx: Fix hardlockup in abort command during driver remove.
Date:   Fri, 14 Jun 2019 07:36:27 -0700
Message-ID: <20190614143627.10768-1-hmadhani@marvell.com>
X-Mailer: git-send-email 2.12.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-14_06:,,
 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Arun Easi <aeasi@marvell.com>

[436194.555537] NMI watchdog: Watchdog detected hard LOCKUP on cpu 5
[436194.555558] RIP: 0010:native_queued_spin_lock_slowpath+0x63/0x1e0

[436194.555563] Call Trace:
[436194.555564]  _raw_spin_lock_irqsave+0x30/0x40
[436194.555564]  qla24xx_async_abort_command+0x29/0xd0 [qla2xxx]
[436194.555565]  qla24xx_abort_command+0x208/0x2d0 [qla2xxx]
[436194.555565]  __qla2x00_abort_all_cmds+0x16b/0x290 [qla2xxx]
[436194.555565]  qla2x00_abort_all_cmds+0x42/0x60 [qla2xxx]
[436194.555566]  qla2x00_abort_isp_cleanup+0x2bd/0x3a0 [qla2xxx]
[436194.555566]  qla2x00_remove_one+0x1ad/0x360 [qla2xxx]
[436194.555566]  pci_device_remove+0x3b/0xb0

Fixes: 219d27d7147e (scsi: qla2xxx: Fix race conditions in the code for aborting SCSI commands)
Cc: stable@vger.kernel.org # 5.2
Signed-off-by: Arun Easi <aeasi@marvell.com>
Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
---
Hi Martin,

This patch fixes issue we found during our driver reset recovery testing with 5.2.0 kernel.

Please apply this patch to 5.2/scsi-fixes branch at your earliest convenience.

Thanks,
Himanshu 
---
 drivers/scsi/qla2xxx/qla_os.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 172ef21827dd..d056f5e7cf93 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -1731,8 +1731,8 @@ static void qla2x00_abort_srb(struct qla_qpair *qp, srb_t *sp, const int res,
 	     !test_bit(ABORT_ISP_ACTIVE, &vha->dpc_flags) &&
 	     !qla2x00_isp_reg_stat(ha))) {
 		sp->comp = &comp;
-		rval = ha->isp_ops->abort_command(sp);
 		spin_unlock_irqrestore(qp->qp_lock_ptr, *flags);
+		rval = ha->isp_ops->abort_command(sp);
 
 		switch (rval) {
 		case QLA_SUCCESS:
-- 
2.19.0.rc0

