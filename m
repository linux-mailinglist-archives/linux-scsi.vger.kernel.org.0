Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C48F976E97
	for <lists+linux-scsi@lfdr.de>; Fri, 26 Jul 2019 18:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbfGZQIP (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 26 Jul 2019 12:08:15 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:18790 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726141AbfGZQIO (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 26 Jul 2019 12:08:14 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x6QG6wSC025944;
        Fri, 26 Jul 2019 09:08:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=W3ME/4dLHJnmQTCoUNuSNZISHp9LheEPhF1si0C8w5U=;
 b=s/AVe8pW2EA3alUPxo5TY33sidtVjgd6FjkCMGpp+fjotYGmelvMbhZbOcMTEB5jmdA/
 o8r4JKWZUTAUX5Fh8LyZWRTdqUlhkLQHku/mUMEpm1OuxaCTOuPUT3lQ45JcF6NOIr9G
 u9n5n/brUykBNdmVVAjNd1JvmuxqSL8gjHEKStFFGD/2nArhkeVLpHeod+cWSr1P6Vo8
 1xNXsmAlwTRxU28Gkp13g7ijo126Pq10lLAAGXUl986Rj7lf+f9HhTXSL3aaqyAR1kl2
 pRDBwCRkbewKmgyL5KDjf5wvD00UtanF5RpEYaIaToauUmWqCbi/cJkJ/eQ1zyGOdZX8 hQ== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2tx6256xby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 26 Jul 2019 09:08:11 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 26 Jul
 2019 09:08:09 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Fri, 26 Jul 2019 09:08:09 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id 6FA593F703F;
        Fri, 26 Jul 2019 09:08:09 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id x6QG89mU025766;
        Fri, 26 Jul 2019 09:08:09 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id x6QG89Xu025765;
        Fri, 26 Jul 2019 09:08:09 -0700
From:   Himanshu Madhani <hmadhani@marvell.com>
To:     <James.Bottomley@HansenPartnership.com>,
        <martin.petersen@oracle.com>
CC:     <hmadhani@marvell.com>, <linux-scsi@vger.kernel.org>
Subject: [PATCH 09/15] qla2xxx: Retry fabric Scan on IOCB queue full
Date:   Fri, 26 Jul 2019 09:07:34 -0700
Message-ID: <20190726160740.25687-10-hmadhani@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190726160740.25687-1-hmadhani@marvell.com>
References: <20190726160740.25687-1-hmadhani@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-07-26_11:2019-07-26,2019-07-26 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Quinn Tran <qutran@marvell.com>

when fabric scan thread encounters IOCB Q Full, schedule
a delayed work to retry fabric scan.

Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
---
 drivers/scsi/qla2xxx/qla_gs.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_gs.c b/drivers/scsi/qla2xxx/qla_gs.c
index ebf223cfebbc..749109c8f20b 100644
--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -4053,9 +4053,6 @@ static int qla24xx_async_gnnft(scsi_qla_host_t *vha, struct srb *sp,
 
 	rval = qla2x00_start_sp(sp);
 	if (rval != QLA_SUCCESS) {
-		spin_lock_irqsave(&vha->work_lock, flags);
-		vha->scan.scan_flags &= ~SF_SCANNING;
-		spin_unlock_irqrestore(&vha->work_lock, flags);
 		goto done_free_sp;
 	}
 
@@ -4079,6 +4076,17 @@ static int qla24xx_async_gnnft(scsi_qla_host_t *vha, struct srb *sp,
 
 	sp->free(sp);
 
+	spin_lock_irqsave(&vha->work_lock, flags);
+	vha->scan.scan_flags &= ~SF_SCANNING;
+	if (vha->scan.scan_flags == 0) {
+		ql_dbg(ql_dbg_disc, vha, 0xffff,
+		    "%s: schedule\n", __func__);
+		vha->scan.scan_flags |= SF_QUEUED;
+		schedule_delayed_work(&vha->scan.scan_work, 5);
+	}
+	spin_unlock_irqrestore(&vha->work_lock, flags);
+
+
 	return rval;
 } /* GNNFT */
 
@@ -4208,9 +4216,6 @@ int qla24xx_async_gpnft(scsi_qla_host_t *vha, u8 fc4_type, srb_t *sp)
 
 	rval = qla2x00_start_sp(sp);
 	if (rval != QLA_SUCCESS) {
-		spin_lock_irqsave(&vha->work_lock, flags);
-		vha->scan.scan_flags &= ~SF_SCANNING;
-		spin_unlock_irqrestore(&vha->work_lock, flags);
 		goto done_free_sp;
 	}
 
@@ -4234,6 +4239,17 @@ int qla24xx_async_gpnft(scsi_qla_host_t *vha, u8 fc4_type, srb_t *sp)
 
 	sp->free(sp);
 
+	spin_lock_irqsave(&vha->work_lock, flags);
+	vha->scan.scan_flags &= ~SF_SCANNING;
+	if (vha->scan.scan_flags == 0) {
+		ql_dbg(ql_dbg_disc, vha, 0xffff,
+		    "%s: schedule\n", __func__);
+		vha->scan.scan_flags |= SF_QUEUED;
+		schedule_delayed_work(&vha->scan.scan_work, 5);
+	}
+	spin_unlock_irqrestore(&vha->work_lock, flags);
+
+
 	return rval;
 }
 
-- 
2.12.0

