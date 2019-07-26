Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABE1576E92
	for <lists+linux-scsi@lfdr.de>; Fri, 26 Jul 2019 18:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbfGZQIE (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 26 Jul 2019 12:08:04 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:54262 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726141AbfGZQIE (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 26 Jul 2019 12:08:04 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x6QG6tZI025887;
        Fri, 26 Jul 2019 09:08:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=VCnie7PANjD9Drs59McGJAw+5DfbfPcDpYYPne9QE9k=;
 b=r1BDe9lTuYHcKjSepSghZF8R4WoLqnptbxNQZAU16t+7c8iO2eqBLR8NshIYzYUkyFEv
 rV0qIlHIDStg/kVmDXgg4T7a5SqRCDKNDrJnw/Rm47vLCfaYmq6CBYA6p9AHQ14pqgh3
 bshccndFOPUtC8upPZnUr0nD6mOcb0cIWV80kG7e9V4xBblyI1oPEovFNeobdgY89vd6
 CgEPiuAkXiKmarOTKTXBqRCyBtiRW5o+hc1ieGR87/4w40z9yG9doNejpqnOZCi8sFPi
 sRElTYyxTI8n63AXC+8dsbS5Hm7XfpZmzJcCMRva5b/3schyFtFnWZecfJJWNLXnJ2Uh TA== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2tx6256xb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 26 Jul 2019 09:08:01 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 26 Jul
 2019 09:08:00 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Fri, 26 Jul 2019 09:07:59 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id D71E23F703F;
        Fri, 26 Jul 2019 09:07:59 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id x6QG7xIq025754;
        Fri, 26 Jul 2019 09:07:59 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id x6QG7xNb025753;
        Fri, 26 Jul 2019 09:07:59 -0700
From:   Himanshu Madhani <hmadhani@marvell.com>
To:     <James.Bottomley@HansenPartnership.com>,
        <martin.petersen@oracle.com>
CC:     <hmadhani@marvell.com>, <linux-scsi@vger.kernel.org>
Subject: [PATCH 06/15] qla2xxx: Reject EH_{abort|device_reset|target_request}
Date:   Fri, 26 Jul 2019 09:07:31 -0700
Message-ID: <20190726160740.25687-7-hmadhani@marvell.com>
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

Reject eh_{abort|device_reset|target_reset}, when rport is
being torn down or chip is down.

Signed-off-by: Quinn Tran <quinn.tran@cavium.com>
Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
---
 drivers/scsi/qla2xxx/qla_os.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 2e58cff9d200..d416ac5d1e4c 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -1296,6 +1296,9 @@ qla2xxx_eh_abort(struct scsi_cmnd *cmd)
 	if (!qpair)
 		return SUCCESS;
 
+	if (sp->fcport && sp->fcport->deleted)
+		return SUCCESS;
+
 	spin_lock_irqsave(qpair->qp_lock_ptr, flags);
 	if (sp->type != SRB_SCSI_CMD || GET_CMD_SP(sp) != cmd) {
 		/* there's a chance an interrupt could clear
@@ -1420,6 +1423,9 @@ __qla2xxx_eh_generic_reset(char *name, enum nexus_wait_type type,
 	if (err != 0)
 		return err;
 
+	if (fcport->deleted)
+		return SUCCESS;
+
 	ql_log(ql_log_info, vha, 0x8009,
 	    "%s RESET ISSUED nexus=%ld:%d:%llu cmd=%p.\n", name, vha->host_no,
 	    cmd->device->id, cmd->device->lun, cmd);
@@ -1534,6 +1540,9 @@ qla2xxx_eh_bus_reset(struct scsi_cmnd *cmd)
 		return ret;
 	ret = FAILED;
 
+	if (qla2x00_chip_is_down(vha))
+		return ret;
+
 	ql_log(ql_log_info, vha, 0x8012,
 	    "BUS RESET ISSUED nexus=%ld:%d:%llu.\n", vha->host_no, id, lun);
 
-- 
2.12.0

