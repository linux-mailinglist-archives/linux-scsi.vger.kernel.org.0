Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF78B2609FB
	for <lists+linux-scsi@lfdr.de>; Tue,  8 Sep 2020 07:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbgIHFZK (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 8 Sep 2020 01:25:10 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:39816 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726387AbgIHFZK (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 8 Sep 2020 01:25:10 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0885P45i023569;
        Mon, 7 Sep 2020 22:25:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=FkhiKUErK7yQSMGTzeorgJ2U9rEJ7JaxU0gwXMkv+Jo=;
 b=FjkOXpFtZ4j1qukrNzfA0mMi1svAMAAoB7sGMjbtfXUH7fD5DoA8qQt/lBQuCEfAQJER
 jQu8pYdkkRd7Q6I5QV8o/vuYXMtoe6oRZDOatseiAzXuLS6cI/QOkLXBaU8+TgTO4Aow
 hou1Rv+Gvswdg2IiWI2MBua3CAAzRwDGSmpHK0w5tjspyljp9XaNOim0iciWMOZviv30
 7388UbHr5wApPBDeXuuCfEW3uo0BYJ3E8ug0LXeaFd5gyzgT0ic1Uh3ZryByYC5+Ckr5
 OuDI8nkkUQ1EN0fhG668JOjGJL6h8ZBpWnUYf54Mua054UebQHMc/5n1oDbvagBHKeFA sw== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 33c81pt69m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 07 Sep 2020 22:25:04 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 7 Sep
 2020 22:25:00 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 7 Sep 2020 22:25:00 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id ABA783F7043;
        Mon,  7 Sep 2020 22:25:00 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id 0885P0T1021965;
        Mon, 7 Sep 2020 22:25:00 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id 0885P07B021956;
        Mon, 7 Sep 2020 22:25:00 -0700
From:   Manish Rangankar <mrangankar@marvell.com>
To:     <martin.petersen@oracle.com>, <lduncan@suse.com>,
        <cleech@redhat.com>
CC:     <linux-scsi@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>
Subject: [PATCH 1/8] qedi: Use qed count from set_fp_int in msix allocation.
Date:   Mon, 7 Sep 2020 22:24:05 -0700
Message-ID: <20200908052412.21917-2-mrangankar@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20200908052412.21917-1-mrangankar@marvell.com>
References: <20200908052412.21917-1-mrangankar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-08_02:2020-09-07,2020-09-08 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

To avoid unnecessary vector allocation when number of fast-path
queues are less then available msix vectors, use return count
from module qed->set_fp_int.

Signed-off-by: Manish Rangankar <mrangankar@marvell.com>
---
 drivers/scsi/qedi/qedi.h      | 1 +
 drivers/scsi/qedi/qedi_main.c | 9 +++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qedi/qedi.h b/drivers/scsi/qedi/qedi.h
index 9498279ae80d..9c19ec9dc682 100644
--- a/drivers/scsi/qedi/qedi.h
+++ b/drivers/scsi/qedi/qedi.h
@@ -305,6 +305,7 @@ struct qedi_ctx {
 	u32 max_sqes;
 	u8 num_queues;
 	u32 max_active_conns;
+	s32 msix_count;
 
 	struct iscsi_cid_queue cid_que;
 	struct qedi_endpoint **ep_tbl;
diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.c
index 6f038ae5efca..e1ec22d7d699 100644
--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -1357,7 +1357,7 @@ static int qedi_request_msix_irq(struct qedi_ctx *qedi)
 	u16 idx;
 
 	cpu = cpumask_first(cpu_online_mask);
-	for (i = 0; i < qedi->int_info.msix_cnt; i++) {
+	for (i = 0; i < qedi->msix_count; i++) {
 		idx = i * qedi->dev_info.common.num_hwfns +
 			  qedi_ops->common->get_affin_hwfn_idx(qedi->cdev);
 
@@ -1387,7 +1387,12 @@ static int qedi_setup_int(struct qedi_ctx *qedi)
 {
 	int rc = 0;
 
-	rc = qedi_ops->common->set_fp_int(qedi->cdev, num_online_cpus());
+	rc = qedi_ops->common->set_fp_int(qedi->cdev, qedi->num_queues);
+	if (rc < 0)
+		goto exit_setup_int;
+
+	qedi->msix_count = rc;
+
 	rc = qedi_ops->common->get_fp_int(qedi->cdev, &qedi->int_info);
 	if (rc)
 		goto exit_setup_int;
-- 
2.25.0

