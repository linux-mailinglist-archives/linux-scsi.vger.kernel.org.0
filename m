Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22E539ABFE
	for <lists+linux-scsi@lfdr.de>; Fri, 23 Aug 2019 11:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389862AbfHWJxN (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 23 Aug 2019 05:53:13 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:24246 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389467AbfHWJxM (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 23 Aug 2019 05:53:12 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7N9nhVv002712
        for <linux-scsi@vger.kernel.org>; Fri, 23 Aug 2019 02:53:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=oWYIAKeVNhhmkaSXNjdcpDAd7fHdR+WyPivQHjK1ku8=;
 b=M/RBO0QZ4AYo53FtzpkZLC6ZSDTIu8GrfDRiTlyNLcBp5ZN5Z5RBiwAqKDG3W697omjW
 LHxhSNvj7UYe2FdJDmmtZmGt/TkMO3eVo6JH/yOlw0sy+w22Do3KdU+4LYaemoGuofkX
 pn72jKSftmiPGkzedOyF8xGUez8FgaWQWQW54o3eNl6j4jhTCNB+yHrlAjGbdrCE3nFB
 etm+jNksgAzLa2DpYZGSM7mBEsQ5x3m+fgS2FlvVOBpqHoC76ndQpBeM/hecVwghFiAI
 btZTIa0MkbvyPXW0gfRBc7kTqcppqZp6eUYmfrnaeSKKATQzNqJ6JEwo1UBogfr3uYUc Xg== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2uhad4074h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Fri, 23 Aug 2019 02:53:11 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 23 Aug
 2019 02:53:10 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Fri, 23 Aug 2019 02:53:10 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id 0B4613F7040;
        Fri, 23 Aug 2019 02:53:10 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id x7N9r9YZ007897;
        Fri, 23 Aug 2019 02:53:09 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id x7N9r9mP007896;
        Fri, 23 Aug 2019 02:53:09 -0700
From:   Saurav Kashyap <skashyap@marvell.com>
To:     <martin.petersen@oracle.com>
CC:     <gbasrur@marvell.com>, <svernekar@marvell.com>,
        <linux-scsi@vger.kernel.org>
Subject: [PATCH 08/14] qedf: Add debug information for unsolicited processing.
Date:   Fri, 23 Aug 2019 02:52:38 -0700
Message-ID: <20190823095244.7830-9-skashyap@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190823095244.7830-1-skashyap@marvell.com>
References: <20190823095244.7830-1-skashyap@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-23_03:2019-08-21,2019-08-23 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

- log s_id, d_id, type and command to the log message.

Signed-off-by: Saurav Kashyap <skashyap@marvell.com>
---
 drivers/scsi/qedf/qedf_io.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/qedf/qedf_io.c b/drivers/scsi/qedf/qedf_io.c
index 7377a53..27989b3 100644
--- a/drivers/scsi/qedf/qedf_io.c
+++ b/drivers/scsi/qedf/qedf_io.c
@@ -2550,6 +2550,10 @@ void qedf_process_unsol_compl(struct qedf_ctx *qedf, uint16_t que_idx,
 		QEDF_ERR(&(qedf->dbg_ctx), "Could not allocate fp.\n");
 		goto increment_prod;
 	}
+	QEDF_WARN(&qedf->dbg_ctx,
+		  "Processing Unsolicated frame, src=%06x dest=%06x r_ctl=0x%x type=0x%x cmd=%02x\n",
+		  ntoh24(fh->fh_s_id), ntoh24(fh->fh_d_id), fh->fh_r_ctl,
+		  fh->fh_type, fc_frame_payload_op(fp));
 
 	/* Copy data from BDQ buffer into fc_frame struct */
 	fh = (struct fc_frame_header *)fc_frame_header_get(fp);
-- 
1.8.3.1

