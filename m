Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15CCC76EA4
	for <lists+linux-scsi@lfdr.de>; Fri, 26 Jul 2019 18:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfGZQKV (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 26 Jul 2019 12:10:21 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:21460 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726871AbfGZQKV (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 26 Jul 2019 12:10:21 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x6QG525f017074;
        Fri, 26 Jul 2019 09:08:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=BlGMKHvSPwSQ8crERtj3j7VFAWxm7aM1uxhrbG6XHzM=;
 b=fIoqxeSWwFyAy26CG1z6Ua6fgJBRTIVFkQxUxH+15iRv3FZ98G9vcowAPe5o9r64mXKH
 +sd6rXR0eRsDpA7aCKfmzYG95QbBXOSis+0KpnYeR0gRAbEiRgpjtwyCevg0FoGdsqd+
 u1Ool6owRsfdZt0GSJRueL48Ej9x7LgvPal4IFh5irteiDu1YgIIxPY21BnLIMRiffFY
 vNUF0MRoF1GTgj2L+Tw50gn6bF7Yzc0YM2ck3mp/2GlZKVRHQT7O7MmdIPKT1BOkxhoP
 NVzkkImW4axFYXrMwdP0p6pwMK8eDrxbXKdcDOD5qFpWotbkBB8a1tZYFyMTP1KNK7y5 Kg== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2tx61rqk0d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 26 Jul 2019 09:08:20 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 26 Jul
 2019 09:08:19 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Fri, 26 Jul 2019 09:08:19 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id 2E4313F703F;
        Fri, 26 Jul 2019 09:08:19 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id x6QG8Jem025782;
        Fri, 26 Jul 2019 09:08:19 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id x6QG8JCH025781;
        Fri, 26 Jul 2019 09:08:19 -0700
From:   Himanshu Madhani <hmadhani@marvell.com>
To:     <James.Bottomley@HansenPartnership.com>,
        <martin.petersen@oracle.com>
CC:     <hmadhani@marvell.com>, <linux-scsi@vger.kernel.org>
Subject: [PATCH 13/15] qla2xxx: Fix hang in fcport delete path
Date:   Fri, 26 Jul 2019 09:07:38 -0700
Message-ID: <20190726160740.25687-14-hmadhani@marvell.com>
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

A hange was observed in the fcport delete path when the
device was responding slow and a issue-lip path (results
in session termination) was taken.

Fix this by issuing logo requests unconditionally.

PID: 19491  TASK: ffff8e23e67bb150  CPU: 0   COMMAND: "kworker/0:0"
 #0 [ffff8e2370297bf8] __schedule at ffffffffb4f7dbb0
 #1 [ffff8e2370297c88] schedule at ffffffffb4f7e199
 #2 [ffff8e2370297c98] schedule_timeout at ffffffffb4f7ba68
 #3 [ffff8e2370297d40] msleep at ffffffffb48ad9ff
 #4 [ffff8e2370297d58] qlt_free_session_done at ffffffffc0c32052 [qla2xxx]
 #5 [ffff8e2370297e20] process_one_work at ffffffffb48bcfdf
 #6 [ffff8e2370297e68] worker_thread at ffffffffb48bdca6
 #7 [ffff8e2370297ec8] kthread at ffffffffb48c4f81

Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
---
 drivers/scsi/qla2xxx/qla_init.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 194a15b2f5f7..d82d1a2b3543 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -378,9 +378,6 @@ qla2x00_async_logout(struct scsi_qla_host *vha, fc_port_t *fcport)
 	struct srb_iocb *lio;
 	int rval = QLA_FUNCTION_FAILED;
 
-	if (!vha->flags.online || (fcport->flags & FCF_ASYNC_SENT))
-		return rval;
-
 	fcport->flags |= FCF_ASYNC_SENT;
 	sp = qla2x00_get_sp(vha, fcport, GFP_KERNEL);
 	if (!sp)
-- 
2.12.0

