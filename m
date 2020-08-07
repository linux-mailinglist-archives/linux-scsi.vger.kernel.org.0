Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43DA223EBF9
	for <lists+linux-scsi@lfdr.de>; Fri,  7 Aug 2020 13:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbgHGLLF (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 7 Aug 2020 07:11:05 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:13384 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728165AbgHGLKV (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 7 Aug 2020 07:10:21 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 077AoCEH009453
        for <linux-scsi@vger.kernel.org>; Fri, 7 Aug 2020 04:09:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=YJZwpTBfxP2ClPw+2v05lP+q+OwXiWMVmX8XNIhlA6o=;
 b=FCefS3kL3G5KYCCZAx90tU2qVZgjZ3UadsNo/Xe3W4R0WklmEM0T3Y0YH7EmPqw6+2Wh
 nmZHHYoP9Vl4M7akYQLBtGy2NTrAQog+ST9JUDaTPJ+po/K5unppjXW4r2eYJwwMJ81g
 YhmpJTUDzblAwNjCFh7wIYLf0tyxQpRKO4E1xfxj9xk1BvKbiionxEuVPCfgE9cGCkLH
 5J6lV2J3ADJ8reLDOV6a4JxQqA2GeJZJl2TQICkiUsiEbklR69m3ejucdO+5s7X0gYrw
 c7eP8Rt+few9f0Pjl7Zuk+Ve9JtrfqKTofAja3nX3pcMBaHsL6pxIm5Ah7CIscJgVoYT 4g== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 32s3c98geg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Fri, 07 Aug 2020 04:09:47 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 7 Aug
 2020 04:09:45 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 7 Aug 2020 04:09:45 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id 6C27E3F703F;
        Fri,  7 Aug 2020 04:09:45 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id 077B9jrK020049;
        Fri, 7 Aug 2020 04:09:45 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id 077B9jYF020040;
        Fri, 7 Aug 2020 04:09:45 -0700
From:   Javed Hasan <jhasan@marvell.com>
To:     <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>, <jhasan@marvell.com>
Subject: [PATCH 6/7] qedf: Don't process ELS completion if its flushed or cleaned up.
Date:   Fri, 7 Aug 2020 04:06:55 -0700
Message-ID: <20200807110656.19965-7-jhasan@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20200807110656.19965-1-jhasan@marvell.com>
References: <20200807110656.19965-1-jhasan@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-07_06:2020-08-06,2020-08-07 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Saurav Kashyap <skashyap@marvell.com>

  - Don't process ELS completion if its flushed or cleaned up.

Signed-off-by: Saurav Kashyap <skashyap@marvell.com>
Signed-off-by: Javed Hasan <jhasan@marvell.com>
---
 drivers/scsi/qedf/qedf_els.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/scsi/qedf/qedf_els.c b/drivers/scsi/qedf/qedf_els.c
index edd6702..e2e80ea 100644
--- a/drivers/scsi/qedf/qedf_els.c
+++ b/drivers/scsi/qedf/qedf_els.c
@@ -147,6 +147,15 @@ void qedf_process_els_compl(struct qedf_ctx *qedf, struct fcoe_cqe *cqe,
 	QEDF_INFO(&(qedf->dbg_ctx), QEDF_LOG_ELS, "Entered with xid = 0x%x"
 		   " cmd_type = %d.\n", els_req->xid, els_req->cmd_type);
 
+	if ((els_req->event == QEDF_IOREQ_EV_ELS_FLUSH)
+		|| (els_req->event == QEDF_IOREQ_EV_CLEANUP_SUCCESS)
+		|| (els_req->event == QEDF_IOREQ_EV_CLEANUP_FAILED)) {
+		QEDF_INFO(&qedf->dbg_ctx, QEDF_LOG_IO,
+			"ELS completion xid=0x%x after flush event=0x%x",
+			els_req->xid, els_req->event);
+		return;
+	}
+
 	clear_bit(QEDF_CMD_OUTSTANDING, &els_req->flags);
 
 	/* Kill the ELS timer */
-- 
1.8.3.1

