Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B960A23DA77
	for <lists+linux-scsi@lfdr.de>; Thu,  6 Aug 2020 14:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbgHFMw6 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 6 Aug 2020 08:52:58 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:16740 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726150AbgHFLNf (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 6 Aug 2020 07:13:35 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 076BA1Jb020998
        for <linux-scsi@vger.kernel.org>; Thu, 6 Aug 2020 04:13:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=6tH6vLqUhUnBnp73H+Qa/+UpXiH+uaVtJLF1ElYn8js=;
 b=TgyxjMVyqUjrS/MwbdEvt5KrKWrNHG3MUf6f6KdhXcN7Ils7FOxoR6vmT5aViUWWeyHz
 j0vQreq5Mlkh9xfTHfc8yL2t5yVJIrztEIhndRZ/1FmElC8lJfIEqo/0dW2gyPCsy0dH
 r2eyGlWtcrj+9CKmrikPxB6XJyOY+Xt0pPFlHHDluzMajjcYqRSdb2M2Qd4zg1kA8tbB
 s0Htf0hDKlBM0nCPknpDVOtQ0ezkbKvqkmYuxLAMQ0l+EXql/z/F7IlCg7feMBM4DJTZ
 IrKH6AWh6jfRc2De5dSagPxJ2ruxv6jtrhTXPbIo1ZG3IpcF0CyAuCab5qFFAXWfTt3J Mw== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 32n8ff3xbx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Thu, 06 Aug 2020 04:13:30 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 6 Aug
 2020 04:13:28 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 6 Aug
 2020 04:13:27 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 6 Aug 2020 04:13:27 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id 9E1723F7043;
        Thu,  6 Aug 2020 04:13:27 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id 076BDR0V028522;
        Thu, 6 Aug 2020 04:13:27 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id 076BDRi4028513;
        Thu, 6 Aug 2020 04:13:27 -0700
From:   Nilesh Javali <njavali@marvell.com>
To:     <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>
Subject: [PATCH v2 07/11] qla2xxx: Fix WARN_ON in qla_nvme_register_hba
Date:   Thu, 6 Aug 2020 04:10:10 -0700
Message-ID: <20200806111014.28434-8-njavali@marvell.com>
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

From: Arun Easi <aeasi@marvell.com>

qla_nvme_register_hba puts out a warning when there are not enough
queue pairs available for FC-NVME.
Just fail the NVME registration rather than a WARNING + Call Trace.

Signed-off-by: Arun Easi <aeasi@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
---
 drivers/scsi/qla2xxx/qla_def.h  |  1 +
 drivers/scsi/qla2xxx/qla_nvme.c | 10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 8c92af5e4390..1bc090d8a71b 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -3880,6 +3880,7 @@ struct qla_hw_data {
 		uint32_t	scm_supported_f:1;
 				/* Enabled in Driver */
 		uint32_t	scm_enabled:1;
+		uint32_t	max_req_queue_warned:1;
 	} flags;
 
 	uint16_t max_exchg;
diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index d66d47a0f958..be1d49f5c622 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -686,7 +686,15 @@ int qla_nvme_register_hba(struct scsi_qla_host *vha)
 	tmpl = &qla_nvme_fc_transport;
 
 	WARN_ON(vha->nvme_local_port);
-	WARN_ON(ha->max_req_queues < 3);
+
+	if (ha->max_req_queues < 3) {
+		if (!ha->flags.max_req_queue_warned)
+			ql_log(ql_log_info, vha, 0x2120,
+			       "%s: Disabling FC-NVME due to lack of free queue pairs (%d).\n",
+			       __func__, ha->max_req_queues);
+		ha->flags.max_req_queue_warned = 1;
+		return ret;
+	}
 
 	qla_nvme_fc_transport.max_hw_queues =
 	    min((uint8_t)(qla_nvme_fc_transport.max_hw_queues),
-- 
2.19.0.rc0

