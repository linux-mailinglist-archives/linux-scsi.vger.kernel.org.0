Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91AE346744E
	for <lists+linux-scsi@lfdr.de>; Fri,  3 Dec 2021 10:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379483AbhLCJ4f (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 3 Dec 2021 04:56:35 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:35422 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232991AbhLCJ4e (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 3 Dec 2021 04:56:34 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1B38QB5i014928;
        Fri, 3 Dec 2021 01:53:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=tV//p3k1jSZ3YWVe4pHffCHpRJ/iSpCPT/ay/gHxNv4=;
 b=BhUpxQZxe8hEjfoLQC5qmXr8asamkAsL+ZAgSaL+nV/7DlxtTZZX4b6K8FXIZ4jMxGKF
 VMcL+WwoYVIfitPJZPR2jbOz+moeTshC+lfrSHCIdNd0w3rqH3m6nZJ2UJiCPB+0qgfJ
 oGOpfj6sMf4esT3zxyabwKYSCj2SLwZqt9EajatqXV9fyyB55t2SdouKTeEqI9jSYgoh
 psANHOL3m7qUuzuA5KfEpM5tJWUMc5aChYuM8GfSNkglMwepXvz5JwiohWbeGkxF8/rr
 HBK5oPAgBVWmX2CMVfJdQMqWZM7U0vOe1Bx7xtoFynfAYuho6DCn5WOYpKu5Fs0biH4g EA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3cqfqq89ga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 01:53:06 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 3 Dec
 2021 01:53:04 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Fri, 3 Dec 2021 01:53:04 -0800
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id BEC173F705E;
        Fri,  3 Dec 2021 01:53:04 -0800 (PST)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id 1B39qsFa005520;
        Fri, 3 Dec 2021 01:52:54 -0800
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id 1B39qIeD005511;
        Fri, 3 Dec 2021 01:52:18 -0800
From:   Manish Rangankar <mrangankar@marvell.com>
To:     <martin.petersen@oracle.com>, <lduncan@suse.com>,
        <cleech@redhat.com>, <michael.christie@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>
Subject: [PATCH v2 REPOST] qedi: Fix cmd_cleanup_cmpl counter mismatch issue.
Date:   Fri, 3 Dec 2021 01:52:18 -0800
Message-ID: <20211203095218.5477-1-mrangankar@marvell.com>
X-Mailer: git-send-email 2.12.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: U6lErhQGSgEAIQvVJZCqWdI2mcV4E2Jk
X-Proofpoint-ORIG-GUID: U6lErhQGSgEAIQvVJZCqWdI2mcV4E2Jk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-03_05,2021-12-02_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

When issued LUN reset under heavy i/o, we hit the qedi WARN_ON
because of a mismatch in firmware i/o cmd cleanup request count
and i/o cmd cleanup response count received. The mismatch is
because of the race caused by the postfix increment of
cmd_cleanup_cmpl.

[qedi_clearsq:1295]:18: fatal error, need hard reset, cid=0x0
WARNING: CPU: 48 PID: 110963 at drivers/scsi/qedi/qedi_fw.c:1296 qedi_clearsq+0xa5/0xd0 [qedi]
CPU: 48 PID: 110963 Comm: kworker/u130:0 Kdump: loaded Tainted: G        W
Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 04/15/2020
Workqueue: iscsi_conn_cleanup iscsi_cleanup_conn_work_fn [scsi_transport_iscsi]
RIP: 0010:qedi_clearsq+0xa5/0xd0 [qedi]
 RSP: 0018:ffffac2162c7fd98 EFLAGS: 00010246
 RAX: 0000000000000000 RBX: ffff975213c40ab8 RCX: 0000000000000000
 RDX: 0000000000000000 RSI: ffff9761bf816858 RDI: ffff9761bf816858
 RBP: ffff975247018628 R08: 000000000000522c R09: 000000000000005b
 R10: 0000000000000000 R11: ffffac2162c7fbd8 R12: ffff97522e1b2be8
 R13: 0000000000000000 R14: ffff97522e1b2800 R15: 0000000000000001
 FS:  0000000000000000(0000) GS:ffff9761bf800000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007f1a34e3e1a0 CR3: 0000000108bb2000 CR4: 0000000000350ee0
 Call Trace:
  qedi_ep_disconnect+0x533/0x550 [qedi]
  ? iscsi_dbg_trace+0x63/0x80 [scsi_transport_iscsi]
  ? _cond_resched+0x15/0x30
  ? iscsi_suspend_queue+0x19/0x40 [libiscsi]
  iscsi_ep_disconnect+0xb0/0x130 [scsi_transport_iscsi]
  iscsi_cleanup_conn_work_fn+0x82/0x130 [scsi_transport_iscsi]
  process_one_work+0x1a7/0x360
  ? create_worker+0x1a0/0x1a0
  worker_thread+0x30/0x390
  ? create_worker+0x1a0/0x1a0
  kthread+0x116/0x130
  ? kthread_flush_work_fn+0x10/0x10
  ret_from_fork+0x22/0x40
 ---[ end trace 5f1441f59082235c ]---

Signed-off-by: Manish Rangankar <mrangankar@marvell.com>
---
v1 -> v2:
 - Changing cmd_cleanup_cmpl variable to atomic
 - In completion path instead pre-increment use atomic inc.


 drivers/scsi/qedi/qedi_fw.c    | 37 ++++++++++++++--------------------
 drivers/scsi/qedi/qedi_iscsi.c |  2 +-
 drivers/scsi/qedi/qedi_iscsi.h |  2 +-
 3 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/drivers/scsi/qedi/qedi_fw.c b/drivers/scsi/qedi/qedi_fw.c
index 84a4204a2cb4..5916ed7662d5 100644
--- a/drivers/scsi/qedi/qedi_fw.c
+++ b/drivers/scsi/qedi/qedi_fw.c
@@ -732,7 +732,6 @@ static void qedi_process_cmd_cleanup_resp(struct qedi_ctx *qedi,
 {
 	struct qedi_work_map *work, *work_tmp;
 	u32 proto_itt = cqe->itid;
-	itt_t protoitt = 0;
 	int found = 0;
 	struct qedi_cmd *qedi_cmd = NULL;
 	u32 iscsi_cid;
@@ -812,16 +811,12 @@ static void qedi_process_cmd_cleanup_resp(struct qedi_ctx *qedi,
 	return;
 
 check_cleanup_reqs:
-	if (qedi_conn->cmd_cleanup_req > 0) {
-		QEDI_INFO(&qedi->dbg_ctx, QEDI_LOG_TID,
+	if (atomic_inc_return(&qedi_conn->cmd_cleanup_cmpl) ==
+	    qedi_conn->cmd_cleanup_req) {
+		QEDI_INFO(&qedi->dbg_ctx, QEDI_LOG_SCSI_TM,
 			  "Freeing tid=0x%x for cid=0x%x\n",
 			  cqe->itid, qedi_conn->iscsi_conn_id);
-		qedi_conn->cmd_cleanup_cmpl++;
 		wake_up(&qedi_conn->wait_queue);
-	} else {
-		QEDI_ERR(&qedi->dbg_ctx,
-			 "Delayed or untracked cleanup response, itt=0x%x, tid=0x%x, cid=0x%x\n",
-			 protoitt, cqe->itid, qedi_conn->iscsi_conn_id);
 	}
 }
 
@@ -1163,7 +1158,7 @@ int qedi_cleanup_all_io(struct qedi_ctx *qedi, struct qedi_conn *qedi_conn,
 	}
 
 	qedi_conn->cmd_cleanup_req = 0;
-	qedi_conn->cmd_cleanup_cmpl = 0;
+	atomic_set(&qedi_conn->cmd_cleanup_cmpl, 0);
 
 	QEDI_INFO(&qedi->dbg_ctx, QEDI_LOG_SCSI_TM,
 		  "active_cmd_count=%d, cid=0x%x, in_recovery=%d, lun_reset=%d\n",
@@ -1215,16 +1210,15 @@ int qedi_cleanup_all_io(struct qedi_ctx *qedi, struct qedi_conn *qedi_conn,
 		  qedi_conn->iscsi_conn_id);
 
 	rval  = wait_event_interruptible_timeout(qedi_conn->wait_queue,
-						 ((qedi_conn->cmd_cleanup_req ==
-						 qedi_conn->cmd_cleanup_cmpl) ||
-						 test_bit(QEDI_IN_RECOVERY,
-							  &qedi->flags)),
-						 5 * HZ);
+				(qedi_conn->cmd_cleanup_req ==
+				 atomic_read(&qedi_conn->cmd_cleanup_cmpl)) ||
+				test_bit(QEDI_IN_RECOVERY, &qedi->flags),
+				5 * HZ);
 	if (rval) {
 		QEDI_INFO(&qedi->dbg_ctx, QEDI_LOG_SCSI_TM,
 			  "i/o cmd_cleanup_req=%d, equal to cmd_cleanup_cmpl=%d, cid=0x%x\n",
 			  qedi_conn->cmd_cleanup_req,
-			  qedi_conn->cmd_cleanup_cmpl,
+			  atomic_read(&qedi_conn->cmd_cleanup_cmpl),
 			  qedi_conn->iscsi_conn_id);
 
 		return 0;
@@ -1233,7 +1227,7 @@ int qedi_cleanup_all_io(struct qedi_ctx *qedi, struct qedi_conn *qedi_conn,
 	QEDI_INFO(&qedi->dbg_ctx, QEDI_LOG_SCSI_TM,
 		  "i/o cmd_cleanup_req=%d, not equal to cmd_cleanup_cmpl=%d, cid=0x%x\n",
 		  qedi_conn->cmd_cleanup_req,
-		  qedi_conn->cmd_cleanup_cmpl,
+		  atomic_read(&qedi_conn->cmd_cleanup_cmpl),
 		  qedi_conn->iscsi_conn_id);
 
 	iscsi_host_for_each_session(qedi->shost,
@@ -1242,11 +1236,10 @@ int qedi_cleanup_all_io(struct qedi_ctx *qedi, struct qedi_conn *qedi_conn,
 
 	/* Enable IOs for all other sessions except current.*/
 	if (!wait_event_interruptible_timeout(qedi_conn->wait_queue,
-					      (qedi_conn->cmd_cleanup_req ==
-					       qedi_conn->cmd_cleanup_cmpl) ||
-					       test_bit(QEDI_IN_RECOVERY,
-							&qedi->flags),
-					      5 * HZ)) {
+				(qedi_conn->cmd_cleanup_req ==
+				 atomic_read(&qedi_conn->cmd_cleanup_cmpl)) ||
+				test_bit(QEDI_IN_RECOVERY, &qedi->flags),
+				5 * HZ)) {
 		iscsi_host_for_each_session(qedi->shost,
 					    qedi_mark_device_available);
 		return -1;
@@ -1266,7 +1259,7 @@ void qedi_clearsq(struct qedi_ctx *qedi, struct qedi_conn *qedi_conn,
 
 	qedi_ep = qedi_conn->ep;
 	qedi_conn->cmd_cleanup_req = 0;
-	qedi_conn->cmd_cleanup_cmpl = 0;
+	atomic_set(&qedi_conn->cmd_cleanup_cmpl, 0);
 
 	if (!qedi_ep) {
 		QEDI_WARN(&qedi->dbg_ctx,
diff --git a/drivers/scsi/qedi/qedi_iscsi.c b/drivers/scsi/qedi/qedi_iscsi.c
index 88aa7d8b11c9..282ecb4e39bb 100644
--- a/drivers/scsi/qedi/qedi_iscsi.c
+++ b/drivers/scsi/qedi/qedi_iscsi.c
@@ -412,7 +412,7 @@ static int qedi_conn_bind(struct iscsi_cls_session *cls_session,
 	qedi_conn->iscsi_conn_id = qedi_ep->iscsi_cid;
 	qedi_conn->fw_cid = qedi_ep->fw_cid;
 	qedi_conn->cmd_cleanup_req = 0;
-	qedi_conn->cmd_cleanup_cmpl = 0;
+	atomic_set(&qedi_conn->cmd_cleanup_cmpl, 0);
 
 	if (qedi_bind_conn_to_iscsi_cid(qedi, qedi_conn)) {
 		rc = -EINVAL;
diff --git a/drivers/scsi/qedi/qedi_iscsi.h b/drivers/scsi/qedi/qedi_iscsi.h
index a282860da0aa..9b9f2e44fdde 100644
--- a/drivers/scsi/qedi/qedi_iscsi.h
+++ b/drivers/scsi/qedi/qedi_iscsi.h
@@ -155,7 +155,7 @@ struct qedi_conn {
 	spinlock_t list_lock;		/* internal conn lock */
 	u32 active_cmd_count;
 	u32 cmd_cleanup_req;
-	u32 cmd_cleanup_cmpl;
+	atomic_t cmd_cleanup_cmpl;
 
 	u32 iscsi_conn_id;
 	int itt;
-- 
2.18.2

