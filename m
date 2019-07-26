Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC2C76E91
	for <lists+linux-scsi@lfdr.de>; Fri, 26 Jul 2019 18:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfGZQIA (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 26 Jul 2019 12:08:00 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:32660 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726141AbfGZQIA (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 26 Jul 2019 12:08:00 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x6QG52Ue017073;
        Fri, 26 Jul 2019 09:07:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=QapU7paGchECvcaTV0dbtZBGKGh/ZQwYG0YnT13+ARA=;
 b=hNye7D7koIOI1fMv/tpRVnK7+BrQrBF+GYHSKD4ojpXpIcTPBpvzSJjSuu7nijwutKJx
 VexAzbuBFime9ph5YFw46X3tvoEb42DfzP82dmhVabQug0A4zjJ4BOSsfYbaxYiDMDsE
 EQgLxnmd/l3S1YtcYwUuKZ8IbtMXx3whultcqsX3i+IAY+JbSPERpO5MVrxi3glpRNMQ
 ruc6WovtWboBWcjI2JnPOlG5KJajNrB8dXFH6qmz6BjLThEf6oGjL8l7VN9hDfrDyPvi
 tMOxPXEgrrwcX/ifkDOB0Szla6LmUqdP4qm84+Zp0OM8YrSlcSNIsGEs4JrTSI7rd2kM bA== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2tx61rqjwu-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 26 Jul 2019 09:07:58 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 26 Jul
 2019 09:07:57 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Fri, 26 Jul 2019 09:07:56 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id AEB383F703F;
        Fri, 26 Jul 2019 09:07:56 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id x6QG7uvJ025750;
        Fri, 26 Jul 2019 09:07:56 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id x6QG7u27025749;
        Fri, 26 Jul 2019 09:07:56 -0700
From:   Himanshu Madhani <hmadhani@marvell.com>
To:     <James.Bottomley@HansenPartnership.com>,
        <martin.petersen@oracle.com>
CC:     <hmadhani@marvell.com>, <linux-scsi@vger.kernel.org>
Subject: [PATCH 05/15] qla2xxx: Skip FW dump on LOOP initialization error
Date:   Fri, 26 Jul 2019 09:07:30 -0700
Message-ID: <20190726160740.25687-6-hmadhani@marvell.com>
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

Firmware dump captured during LOOP Init error does not yield
any significant information.  This patch removes call to
trigger firmware dump collection during Loop Initialization.

Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
---
 drivers/scsi/qla2xxx/qla_isr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index 78aec50abe0f..e8ce57cb897e 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -776,7 +776,6 @@ qla2x00_async_event(scsi_qla_host_t *vha, struct rsp_que *rsp, uint16_t *mb)
 	case MBA_LOOP_INIT_ERR:
 		ql_log(ql_log_warn, vha, 0x5090,
 		    "LOOP INIT ERROR (%x).\n", mb[1]);
-		ha->isp_ops->fw_dump(vha, 1);
 		set_bit(ISP_ABORT_NEEDED, &vha->dpc_flags);
 		break;
 
-- 
2.12.0

