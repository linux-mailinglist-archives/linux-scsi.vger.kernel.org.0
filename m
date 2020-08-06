Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C32E23DA70
	for <lists+linux-scsi@lfdr.de>; Thu,  6 Aug 2020 14:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbgHFMtn (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 6 Aug 2020 08:49:43 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:2808 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726799AbgHFLOT (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 6 Aug 2020 07:14:19 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 076BA1Jg020998
        for <linux-scsi@vger.kernel.org>; Thu, 6 Aug 2020 04:14:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=1YWcJq7RVq5b10lCa1znTek+sSvOxoP5P3pHcgoT40A=;
 b=D/fv0/Zap+g4epsj+3azgskwNUfz/tUXJkqYc3cCkKT3cHy2k2CVCmTfwx6myQBCapMS
 j+hs6i1A3c1Ju8T51rRfL5QY0j4UGE6iMo9YlFC3kmnZzQNdmBu1Wr6bGvM3oWZZrxR4
 aqtayPbRRYF7JzOwvdoCue+KaBRka7lIu9ZqfylRxYn9QlAWS5479wJOMm5AHNGvHklM
 py9hmE3F3JwKbYvUuyPaIsB42fsUOGeZJZaNXICblkJCIHDPVAmOyVOfu+EGDx5ZF9Nl
 1OhTiNYy55iDm3JiCn+z3bD0k6wwz+kYeJhRco5oBSWftSTb06BXfacWumcecrNOSLQm tg== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 32n8ff3xet-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Thu, 06 Aug 2020 04:14:18 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 6 Aug
 2020 04:14:17 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 6 Aug
 2020 04:14:16 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 6 Aug 2020 04:14:16 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id DD4073F7043;
        Thu,  6 Aug 2020 04:14:15 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id 076BEF31028538;
        Thu, 6 Aug 2020 04:14:15 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id 076BEFCI028529;
        Thu, 6 Aug 2020 04:14:15 -0700
From:   Nilesh Javali <njavali@marvell.com>
To:     <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>
Subject: [PATCH v2 09/11] qla2xxx: fix null pointer access while connections disconnect from subsystem
Date:   Thu, 6 Aug 2020 04:10:12 -0700
Message-ID: <20200806111014.28434-10-njavali@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20200806111014.28434-1-njavali@marvell.com>
References: <20200806111014.28434-1-njavali@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-06_06:2020-08-06,2020-08-06 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Quinn Tran <qutran@marvell.com>

NVMEAsync command is being submitted to QLA, while the same nvme controller
is in the middle of reset. The reset path has deleted the association and
freed aen_op->fcp_req.private. Add a check for this private pointer
before issuing the command.

...
 6 [ffffb656ca11fce0] page_fault at ffffffff8c00114e
    [exception RIP: qla_nvme_post_cmd+394]
    RIP: ffffffffc0d012ba  RSP: ffffb656ca11fd98  RFLAGS: 00010206
    RAX: ffff8fb039eda228  RBX: ffff8fb039eda200  RCX: 00000000000da161
    RDX: ffffffffc0d4d0f0  RSI: ffffffffc0d26c9b  RDI: ffff8fb039eda220
    RBP: 0000000000000013   R8: ffff8fb47ff6aa80   R9: 0000000000000002
    R10: 0000000000000000  R11: ffffb656ca11fdc8  R12: ffff8fb27d04a3b0
    R13: ffff8fc46dd98a58  R14: 0000000000000000  R15: ffff8fc4540f0000
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 7 [ffffb656ca11fe08] nvme_fc_start_fcp_op at ffffffffc0241568 [nvme_fc]
 8 [ffffb656ca11fe50] nvme_fc_submit_async_event at ffffffffc0241901 [nvme_fc]
 9 [ffffb656ca11fe68] nvme_async_event_work at ffffffffc014543d [nvme_core]
10 [ffffb656ca11fe98] process_one_work at ffffffff8b6cd437
11 [ffffb656ca11fed8] worker_thread at ffffffff8b6cdcef
12 [ffffb656ca11ff10] kthread at ffffffff8b6d3402
13 [ffffb656ca11ff50] ret_from_fork at ffffffff8c000255

--
PID: 37824  TASK: ffff8fb033063d80  CPU: 20  COMMAND: "kworker/u97:451"
 0 [ffffb656ce1abc28] __schedule at ffffffff8be629e3
 1 [ffffb656ce1abcc8] schedule at ffffffff8be62fe8
 2 [ffffb656ce1abcd0] schedule_timeout at ffffffff8be671ed
 3 [ffffb656ce1abd70] wait_for_completion at ffffffff8be639cf
 4 [ffffb656ce1abdd0] flush_work at ffffffff8b6ce2d5
 5 [ffffb656ce1abe70] nvme_stop_ctrl at ffffffffc0144900 [nvme_core]
 6 [ffffb656ce1abe80] nvme_fc_reset_ctrl_work at ffffffffc0243445 [nvme_fc]
 7 [ffffb656ce1abe98] process_one_work at ffffffff8b6cd437
 8 [ffffb656ce1abed8] worker_thread at ffffffff8b6cdb50
 9 [ffffb656ce1abf10] kthread at ffffffff8b6d3402
10 [ffffb656ce1abf50] ret_from_fork at ffffffff8c000255

Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
---
 drivers/scsi/qla2xxx/qla_nvme.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index be1d49f5c622..f451683db75c 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -535,6 +535,11 @@ static int qla_nvme_post_cmd(struct nvme_fc_local_port *lport,
 	struct nvme_private *priv = fd->private;
 	struct qla_nvme_rport *qla_rport = rport->private;
 
+	if (!priv) {
+		/* nvme association has been torn down */
+		return rval;
+	}
+
 	fcport = qla_rport->fcport;
 
 	if (!qpair || !fcport || (qpair && !qpair->fw_started) ||
-- 
2.19.0.rc0

