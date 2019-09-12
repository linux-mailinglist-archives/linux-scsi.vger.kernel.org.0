Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD5C6B1208
	for <lists+linux-scsi@lfdr.de>; Thu, 12 Sep 2019 17:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733025AbfILPUf (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 12 Sep 2019 11:20:35 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:4366 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732699AbfILPUf (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 12 Sep 2019 11:20:35 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8CFHFNO011817;
        Thu, 12 Sep 2019 08:20:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=aupOPGka87cVTYrGTwS3iBzuuBBXAQ5LeiZbr1ZL2CY=;
 b=Kv4dH2sqSSCcw4GArvUEYbc0hqwAssaiQzE0uGFqSNz+L+S7DRBNb92TIDaqWPJ6bmoC
 HpI9QaNvHYUlMIa4IzPfexvqZYp98AKehcLYaSc9/GyQjbJ+mXKP5cV3HBM6HEBMqlM/
 siCjAYXaUEAem7THzvU+CYVm8qG26LDQ+wiJS8fPbAxYK5FjS2uvhpVDxFk7JKopqo9h
 8xX5reQiLweGU/3DXWP2yln2KS1dEdodpPkiH6n//CG96/53pb25XTBc5RfK81Bv4eEN
 67cSFx0GsSiKOaCiad3vvezEJBPlMVieLeLMToTKcqyLidSFKnZdI8RElA+OanqofBOL BA== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2uvc2jy5rx-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 12 Sep 2019 08:20:31 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 12 Sep
 2019 08:20:29 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Thu, 12 Sep 2019 08:20:29 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id 91D213F703F;
        Thu, 12 Sep 2019 08:20:29 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id x8CFKT3Q002662;
        Thu, 12 Sep 2019 08:20:29 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id x8CFKTXu002661;
        Thu, 12 Sep 2019 08:20:29 -0700
From:   Himanshu Madhani <hmadhani@marvell.com>
To:     <James.Bottomley@HansenPartnership.com>,
        <martin.petersen@oracle.com>
CC:     <hmadhani@marvell.com>, <linux-scsi@vger.kernel.org>
Subject: [PATCH 13/14] qla2xxx: Improve logging for scan thread
Date:   Thu, 12 Sep 2019 08:19:48 -0700
Message-ID: <20190912151949.2348-14-hmadhani@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190912151949.2348-1-hmadhani@marvell.com>
References: <20190912151949.2348-1-hmadhani@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-12_08:2019-09-11,2019-09-12 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

move messages to verbose logging for scan thread

Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
---
 drivers/scsi/qla2xxx/qla_gs.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_gs.c b/drivers/scsi/qla2xxx/qla_gs.c
index ad7f02a8f6d7..570d7473654a 100644
--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -3617,7 +3617,7 @@ void qla24xx_async_gnnft_done(scsi_qla_host_t *vha, srb_t *sp)
 	u8 recheck = 0;
 	u16 dup = 0, dup_cnt = 0;
 
-	ql_dbg(ql_dbg_disc, vha, 0xffff,
+	ql_dbg(ql_dbg_disc + ql_dbg_verbose, vha, 0xffff,
 	    "%s enter\n", __func__);
 
 	if (sp->gen1 != vha->hw->base_qpair->chip_reset) {
@@ -3634,8 +3634,9 @@ void qla24xx_async_gnnft_done(scsi_qla_host_t *vha, srb_t *sp)
 			set_bit(LOCAL_LOOP_UPDATE, &vha->dpc_flags);
 			set_bit(LOOP_RESYNC_NEEDED, &vha->dpc_flags);
 		} else {
-			ql_dbg(ql_dbg_disc, vha, 0xffff,
-			    "Fabric scan failed on all retries.\n");
+			ql_dbg(ql_dbg_disc + ql_dbg_verbose, vha, 0xffff,
+			    "%s: Fabric scan failed for %d retries.\n",
+			    __func__, vha->scan.scan_retry);
 		}
 		goto out;
 	}
@@ -4102,7 +4103,7 @@ static int qla24xx_async_gnnft(scsi_qla_host_t *vha, struct srb *sp,
 
 void qla24xx_async_gpnft_done(scsi_qla_host_t *vha, srb_t *sp)
 {
-	ql_dbg(ql_dbg_disc, vha, 0xffff,
+	ql_dbg(ql_dbg_disc + ql_dbg_verbose, vha, 0xffff,
 	    "%s enter\n", __func__);
 	qla24xx_async_gnnft(vha, sp, sp->gen2);
 }
@@ -4116,7 +4117,7 @@ int qla24xx_async_gpnft(scsi_qla_host_t *vha, u8 fc4_type, srb_t *sp)
 	u32 rspsz;
 	unsigned long flags;
 
-	ql_dbg(ql_dbg_disc, vha, 0xffff,
+	ql_dbg(ql_dbg_disc + ql_dbg_verbose, vha, 0xffff,
 	    "%s enter\n", __func__);
 
 	if (!vha->flags.online)
@@ -4125,14 +4126,15 @@ int qla24xx_async_gpnft(scsi_qla_host_t *vha, u8 fc4_type, srb_t *sp)
 	spin_lock_irqsave(&vha->work_lock, flags);
 	if (vha->scan.scan_flags & SF_SCANNING) {
 		spin_unlock_irqrestore(&vha->work_lock, flags);
-		ql_dbg(ql_dbg_disc, vha, 0xffff, "scan active\n");
+		ql_dbg(ql_dbg_disc + ql_dbg_verbose, vha, 0xffff,
+		    "%s: scan active\n", __func__);
 		return rval;
 	}
 	vha->scan.scan_flags |= SF_SCANNING;
 	spin_unlock_irqrestore(&vha->work_lock, flags);
 
 	if (fc4_type == FC4_TYPE_FCP_SCSI) {
-		ql_dbg(ql_dbg_disc, vha, 0xffff,
+		ql_dbg(ql_dbg_disc + ql_dbg_verbose, vha, 0xffff,
 		    "%s: Performing FCP Scan\n", __func__);
 
 		if (sp)
@@ -4187,7 +4189,7 @@ int qla24xx_async_gpnft(scsi_qla_host_t *vha, u8 fc4_type, srb_t *sp)
 		}
 		sp->u.iocb_cmd.u.ctarg.rsp_size = rspsz;
 
-		ql_dbg(ql_dbg_disc, vha, 0xffff,
+		ql_dbg(ql_dbg_disc + ql_dbg_verbose, vha, 0xffff,
 		    "%s scan list size %d\n", __func__, vha->scan.size);
 
 		memset(vha->scan.l, 0, vha->scan.size);
@@ -4252,8 +4254,8 @@ int qla24xx_async_gpnft(scsi_qla_host_t *vha, u8 fc4_type, srb_t *sp)
 	spin_lock_irqsave(&vha->work_lock, flags);
 	vha->scan.scan_flags &= ~SF_SCANNING;
 	if (vha->scan.scan_flags == 0) {
-		ql_dbg(ql_dbg_disc, vha, 0xffff,
-		    "%s: schedule\n", __func__);
+		ql_dbg(ql_dbg_disc + ql_dbg_verbose, vha, 0xffff,
+		    "%s: Scan scheduled.\n", __func__);
 		vha->scan.scan_flags |= SF_QUEUED;
 		schedule_delayed_work(&vha->scan.scan_work, 5);
 	}
-- 
2.12.0

