Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1700776E8E
	for <lists+linux-scsi@lfdr.de>; Fri, 26 Jul 2019 18:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfGZQHy (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 26 Jul 2019 12:07:54 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:21360 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726909AbfGZQHy (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 26 Jul 2019 12:07:54 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x6QG5fBS017783;
        Fri, 26 Jul 2019 09:07:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=4+rL/+6O80ozgphDj3wKi5ub7WIqLDuTXc8hgNaYK0M=;
 b=lUCWpxtDRoOn/m8jzqOQKW9UEIba3WgDvKUttKnhLDyuKiaqzYseYGBJCJuYtqYd/2A1
 ZRaoUn3K3Bw2wB7aNRngRBvbvwmwlahHrobdDLKL+2y/hMIZPR8StiWgiTq6Q8e/pcIB
 zZwIJrfdur5bWldqsMSXxyyp9cFHUSBhPcDoxkLt69riZiOY3//94GXtYc+USUY6SZfF
 UstCaP7OpNxAPw81VXogNdC5Lh5ALR9u+YkRwscL7M/4XfAkOykPegNvJ+TdRFLRvAQ4
 Xr7ipqULxrwvHylA1nUedVtLwu1p9I13yPCFZLlAbQSwHmd+ZsH9rzhaSO54HhbFtnaP lw== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2tx61rqjwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 26 Jul 2019 09:07:51 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 26 Jul
 2019 09:07:50 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Fri, 26 Jul 2019 09:07:50 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id 59CAC3F703F;
        Fri, 26 Jul 2019 09:07:50 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id x6QG7oqx025742;
        Fri, 26 Jul 2019 09:07:50 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id x6QG7o2h025733;
        Fri, 26 Jul 2019 09:07:50 -0700
From:   Himanshu Madhani <hmadhani@marvell.com>
To:     <James.Bottomley@HansenPartnership.com>,
        <martin.petersen@oracle.com>
CC:     <hmadhani@marvell.com>, <linux-scsi@vger.kernel.org>
Subject: [PATCH 03/15] qla2xxx: Fix abort timeout race condition.
Date:   Fri, 26 Jul 2019 09:07:28 -0700
Message-ID: <20190726160740.25687-4-hmadhani@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190726160740.25687-1-hmadhani@marvell.com>
References: <20190726160740.25687-1-hmadhani@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-07-26_12:2019-07-26,2019-07-26 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Quinn Tran <qutran@marvell.com>

If an abort times out, the Abort IOCB completion and Abort
timer can race against each other. This patch provides
unique error code for timer path to allow proper cleanup

Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
---
 drivers/scsi/qla2xxx/qla_def.h  |  1 +
 drivers/scsi/qla2xxx/qla_init.c | 18 ++++++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index bad2b12604f1..d3d624d43ec3 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -4628,6 +4628,7 @@ struct secure_flash_update_block_pk {
 #define QLA_SUSPENDED			0x106
 #define QLA_BUSY			0x107
 #define QLA_ALREADY_REGISTERED		0x109
+#define QLA_OS_TIMER_EXPIRED		0x10a
 
 #define NVRAM_DELAY()		udelay(10)
 
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 4059655639d9..68d7496a8aff 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -99,9 +99,22 @@ static void qla24xx_abort_iocb_timeout(void *data)
 {
 	srb_t *sp = data;
 	struct srb_iocb *abt = &sp->u.iocb_cmd;
+	struct qla_qpair *qpair = sp->qpair;
+	u32 handle;
+	unsigned long flags;
+
+	spin_lock_irqsave(qpair->qp_lock_ptr, flags);
+	for (handle = 1; handle < qpair->req->num_outstanding_cmds; handle++) {
+		/* removing the abort */
+		if (qpair->req->outstanding_cmds[handle] == sp) {
+			qpair->req->outstanding_cmds[handle] = NULL;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(qpair->qp_lock_ptr, flags);
 
 	abt->u.abt.comp_status = CS_TIMEOUT;
-	sp->done(sp, QLA_FUNCTION_TIMEOUT);
+	sp->done(sp, QLA_OS_TIMER_EXPIRED);
 }
 
 static void qla24xx_abort_sp_done(void *ptr, int res)
@@ -109,7 +122,8 @@ static void qla24xx_abort_sp_done(void *ptr, int res)
 	srb_t *sp = ptr;
 	struct srb_iocb *abt = &sp->u.iocb_cmd;
 
-	if (del_timer(&sp->u.iocb_cmd.timer)) {
+	if ((res == QLA_OS_TIMER_EXPIRED) ||
+	    del_timer(&sp->u.iocb_cmd.timer)) {
 		if (sp->flags & SRB_WAKEUP_ON_COMP)
 			complete(&abt->u.abt.comp);
 		else
-- 
2.12.0

