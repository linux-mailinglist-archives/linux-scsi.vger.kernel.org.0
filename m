Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE6850494
	for <lists+linux-scsi@lfdr.de>; Mon, 24 Jun 2019 10:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbfFXIaP (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 24 Jun 2019 04:30:15 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:35544 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726622AbfFXIaP (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 24 Jun 2019 04:30:15 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5O8UBRF025709
        for <linux-scsi@vger.kernel.org>; Mon, 24 Jun 2019 01:30:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=dLvOz6g4McFfaoKj3H4yB8GTJcDg1DYhqTa2QtWyWyY=;
 b=TIPtj7SmZ8CU6tW+W2kPrgf6Nqw21L0LectopHo0OwQgQ1hirIRaqssu/GRPDxdf7rf9
 C2h1cRnkoQapG7tysoTBM0RkBsRROkVmdU24U4zeJ0pI/W+WlL+s0paX8vRB84C5+8D2
 W9Ez5KALvFNQuyjrA3jd1cQkqhAIqt8IDdhj/jRLBtM8F6/EpXm+XaKEg7sYb/mxLc6e
 ljHhH6SkQWra5/gq1r4YYyt9q8Sd380qwi9haIcjIb/79ZVnwKM+LYBPOXwmEo0UrDrN
 uhhTSf2EUqLLzosGiDtNcIbhANqqxxt1KOl5C32dBAFNluVwi8HSusxm7pHvgF7MvBtf tw== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2t9kujdw7h-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Mon, 24 Jun 2019 01:30:13 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 24 Jun
 2019 01:30:11 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Mon, 24 Jun 2019 01:30:11 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id C1E0D3F7044;
        Mon, 24 Jun 2019 01:30:10 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id x5O8UAs6023231;
        Mon, 24 Jun 2019 01:30:10 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id x5O8UAZ1023222;
        Mon, 24 Jun 2019 01:30:10 -0700
From:   Saurav Kashyap <skashyap@marvell.com>
To:     <martin.petersen@oracle.com>
CC:     <gbasrur@marvell.com>, <svernekar@marvell.com>,
        <linux-scsi@vger.kernel.org>
Subject: [PATCH 3/6] bnx2fc: Separate out completion flags and variables for abort and cleanup.
Date:   Mon, 24 Jun 2019 01:29:57 -0700
Message-ID: <20190624083000.23074-4-skashyap@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190624083000.23074-1-skashyap@marvell.com>
References: <20190624083000.23074-1-skashyap@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-24_06:,,
 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

- Separate out abort and cleanup flag and completion, to have better
understaning of what is getting processed.

Signed-off-by: Saurav Kashyap <skashyap@marvell.com>
---
 drivers/scsi/bnx2fc/bnx2fc.h     |  6 ++--
 drivers/scsi/bnx2fc/bnx2fc_io.c  | 59 ++++++++++++++++++++++------------------
 drivers/scsi/bnx2fc/bnx2fc_tgt.c | 10 +++----
 3 files changed, 41 insertions(+), 34 deletions(-)

diff --git a/drivers/scsi/bnx2fc/bnx2fc.h b/drivers/scsi/bnx2fc/bnx2fc.h
index 901a316..5d7e21a 100644
--- a/drivers/scsi/bnx2fc/bnx2fc.h
+++ b/drivers/scsi/bnx2fc/bnx2fc.h
@@ -433,8 +433,10 @@ struct bnx2fc_cmd {
 	void (*cb_func)(struct bnx2fc_els_cb_arg *cb_arg);
 	struct bnx2fc_els_cb_arg *cb_arg;
 	struct delayed_work timeout_work; /* timer for ULP timeouts */
-	struct completion tm_done;
-	int wait_for_comp;
+	struct completion abts_done;
+	struct completion cleanup_done;
+	int wait_for_abts_comp;
+	int wait_for_cleanup_comp;
 	u16 xid;
 	struct fcoe_err_report_entry err_entry;
 	struct fcoe_task_ctx_entry *task;
diff --git a/drivers/scsi/bnx2fc/bnx2fc_io.c b/drivers/scsi/bnx2fc/bnx2fc_io.c
index 578ff53..88c392b 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_io.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_io.c
@@ -70,7 +70,7 @@ static void bnx2fc_cmd_timeout(struct work_struct *work)
 							&io_req->req_flags)) {
 			/* Handle eh_abort timeout */
 			BNX2FC_IO_DBG(io_req, "eh_abort timed out\n");
-			complete(&io_req->tm_done);
+			complete(&io_req->abts_done);
 		} else if (test_bit(BNX2FC_FLAG_ISSUE_ABTS,
 				    &io_req->req_flags)) {
 			/* Handle internally generated ABTS timeout */
@@ -775,31 +775,32 @@ retry_tmf:
 	io_req->on_tmf_queue = 1;
 	list_add_tail(&io_req->link, &tgt->active_tm_queue);
 
-	init_completion(&io_req->tm_done);
-	io_req->wait_for_comp = 1;
+	init_completion(&io_req->abts_done);
+	io_req->wait_for_abts_comp = 1;
 
 	/* Ring doorbell */
 	bnx2fc_ring_doorbell(tgt);
 	spin_unlock_bh(&tgt->tgt_lock);
 
-	rc = wait_for_completion_timeout(&io_req->tm_done,
+	rc = wait_for_completion_timeout(&io_req->abts_done,
 					 interface->tm_timeout * HZ);
 	spin_lock_bh(&tgt->tgt_lock);
 
-	io_req->wait_for_comp = 0;
+	io_req->wait_for_abts_comp = 0;
 	if (!(test_bit(BNX2FC_FLAG_TM_COMPL, &io_req->req_flags))) {
 		set_bit(BNX2FC_FLAG_TM_TIMEOUT, &io_req->req_flags);
 		if (io_req->on_tmf_queue) {
 			list_del_init(&io_req->link);
 			io_req->on_tmf_queue = 0;
 		}
-		io_req->wait_for_comp = 1;
+		io_req->wait_for_cleanup_comp = 1;
+		init_completion(&io_req->cleanup_done);
 		bnx2fc_initiate_cleanup(io_req);
 		spin_unlock_bh(&tgt->tgt_lock);
-		rc = wait_for_completion_timeout(&io_req->tm_done,
+		rc = wait_for_completion_timeout(&io_req->cleanup_done,
 						 BNX2FC_FW_TIMEOUT);
 		spin_lock_bh(&tgt->tgt_lock);
-		io_req->wait_for_comp = 0;
+		io_req->wait_for_cleanup_comp = 0;
 		if (!rc)
 			kref_put(&io_req->refcount, bnx2fc_cmd_release);
 	}
@@ -1085,7 +1086,8 @@ static int bnx2fc_abts_cleanup(struct bnx2fc_cmd *io_req)
 	struct bnx2fc_rport *tgt = io_req->tgt;
 	unsigned int time_left;
 
-	io_req->wait_for_comp = 1;
+	init_completion(&io_req->cleanup_done);
+	io_req->wait_for_cleanup_comp = 1;
 	bnx2fc_initiate_cleanup(io_req);
 
 	spin_unlock_bh(&tgt->tgt_lock);
@@ -1094,9 +1096,8 @@ static int bnx2fc_abts_cleanup(struct bnx2fc_cmd *io_req)
 	 * Can't wait forever on cleanup response lest we let the SCSI error
 	 * handler wait forever
 	 */
-	time_left = wait_for_completion_timeout(&io_req->tm_done,
+	time_left = wait_for_completion_timeout(&io_req->cleanup_done,
 						BNX2FC_FW_TIMEOUT);
-	io_req->wait_for_comp = 0;
 	if (!time_left) {
 		BNX2FC_IO_DBG(io_req, "%s(): Wait for cleanup timed out.\n",
 			      __func__);
@@ -1109,6 +1110,7 @@ static int bnx2fc_abts_cleanup(struct bnx2fc_cmd *io_req)
 	}
 
 	spin_lock_bh(&tgt->tgt_lock);
+	io_req->wait_for_cleanup_comp = 0;
 	return SUCCESS;
 }
 
@@ -1197,7 +1199,8 @@ int bnx2fc_eh_abort(struct scsi_cmnd *sc_cmd)
 	/* Move IO req to retire queue */
 	list_add_tail(&io_req->link, &tgt->io_retire_queue);
 
-	init_completion(&io_req->tm_done);
+	init_completion(&io_req->abts_done);
+	init_completion(&io_req->cleanup_done);
 
 	if (test_and_set_bit(BNX2FC_FLAG_ISSUE_ABTS, &io_req->req_flags)) {
 		printk(KERN_ERR PFX "eh_abort: io_req (xid = 0x%x) "
@@ -1225,26 +1228,28 @@ int bnx2fc_eh_abort(struct scsi_cmnd *sc_cmd)
 		kref_put(&io_req->refcount,
 			 bnx2fc_cmd_release); /* drop timer hold */
 	set_bit(BNX2FC_FLAG_EH_ABORT, &io_req->req_flags);
-	io_req->wait_for_comp = 1;
+	io_req->wait_for_abts_comp = 1;
 	rc = bnx2fc_initiate_abts(io_req);
 	if (rc == FAILED) {
+		io_req->wait_for_cleanup_comp = 1;
 		bnx2fc_initiate_cleanup(io_req);
 		spin_unlock_bh(&tgt->tgt_lock);
-		wait_for_completion(&io_req->tm_done);
+		wait_for_completion(&io_req->cleanup_done);
 		spin_lock_bh(&tgt->tgt_lock);
-		io_req->wait_for_comp = 0;
+		io_req->wait_for_cleanup_comp = 0;
 		goto done;
 	}
 	spin_unlock_bh(&tgt->tgt_lock);
 
 	/* Wait 2 * RA_TOV + 1 to be sure timeout function hasn't fired */
-	time_left = wait_for_completion_timeout(&io_req->tm_done,
-	    (2 * rp->r_a_tov + 1) * HZ);
+	time_left = wait_for_completion_timeout(&io_req->abts_done,
+						(2 * rp->r_a_tov + 1) * HZ);
 	if (time_left)
-		BNX2FC_IO_DBG(io_req, "Timed out in eh_abort waiting for tm_done");
+		BNX2FC_IO_DBG(io_req,
+			      "Timed out in eh_abort waiting for abts_done");
 
 	spin_lock_bh(&tgt->tgt_lock);
-	io_req->wait_for_comp = 0;
+	io_req->wait_for_abts_comp = 0;
 	if (test_bit(BNX2FC_FLAG_IO_COMPL, &io_req->req_flags)) {
 		BNX2FC_IO_DBG(io_req, "IO completed in a different context\n");
 		rc = SUCCESS;
@@ -1321,8 +1326,8 @@ void bnx2fc_process_cleanup_compl(struct bnx2fc_cmd *io_req,
 		   kref_read(&io_req->refcount), io_req->cmd_type);
 	bnx2fc_scsi_done(io_req, DID_ERROR);
 	kref_put(&io_req->refcount, bnx2fc_cmd_release);
-	if (io_req->wait_for_comp)
-		complete(&io_req->tm_done);
+	if (io_req->wait_for_cleanup_comp)
+		complete(&io_req->cleanup_done);
 }
 
 void bnx2fc_process_abts_compl(struct bnx2fc_cmd *io_req,
@@ -1390,10 +1395,10 @@ void bnx2fc_process_abts_compl(struct bnx2fc_cmd *io_req,
 	bnx2fc_cmd_timer_set(io_req, r_a_tov);
 
 io_compl:
-	if (io_req->wait_for_comp) {
+	if (io_req->wait_for_abts_comp) {
 		if (test_and_clear_bit(BNX2FC_FLAG_EH_ABORT,
 				       &io_req->req_flags))
-			complete(&io_req->tm_done);
+			complete(&io_req->abts_done);
 	} else {
 		/*
 		 * We end up here when ABTS is issued as
@@ -1577,9 +1582,9 @@ void bnx2fc_process_tm_compl(struct bnx2fc_cmd *io_req,
 	sc_cmd->scsi_done(sc_cmd);
 
 	kref_put(&io_req->refcount, bnx2fc_cmd_release);
-	if (io_req->wait_for_comp) {
+	if (io_req->wait_for_abts_comp) {
 		BNX2FC_IO_DBG(io_req, "tm_compl - wake up the waiter\n");
-		complete(&io_req->tm_done);
+		complete(&io_req->abts_done);
 	}
 }
 
@@ -1926,10 +1931,10 @@ void bnx2fc_process_scsi_cmd_compl(struct bnx2fc_cmd *io_req,
 		 * between command abort and (late) completion.
 		 */
 		BNX2FC_IO_DBG(io_req, "xid not on active_cmd_queue\n");
-		if (io_req->wait_for_comp)
+		if (io_req->wait_for_abts_comp)
 			if (test_and_clear_bit(BNX2FC_FLAG_EH_ABORT,
 					       &io_req->req_flags))
-				complete(&io_req->tm_done);
+				complete(&io_req->abts_done);
 	}
 
 	bnx2fc_unmap_sg_list(io_req);
diff --git a/drivers/scsi/bnx2fc/bnx2fc_tgt.c b/drivers/scsi/bnx2fc/bnx2fc_tgt.c
index d735e87..50384b4 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_tgt.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_tgt.c
@@ -187,7 +187,7 @@ void bnx2fc_flush_active_ios(struct bnx2fc_rport *tgt)
 				/* Handle eh_abort timeout */
 				BNX2FC_IO_DBG(io_req, "eh_abort for IO "
 					      "cleaned up\n");
-				complete(&io_req->tm_done);
+				complete(&io_req->abts_done);
 			}
 			kref_put(&io_req->refcount,
 				 bnx2fc_cmd_release); /* drop timer hold */
@@ -210,8 +210,8 @@ void bnx2fc_flush_active_ios(struct bnx2fc_rport *tgt)
 		list_del_init(&io_req->link);
 		io_req->on_tmf_queue = 0;
 		BNX2FC_IO_DBG(io_req, "tm_queue cleanup\n");
-		if (io_req->wait_for_comp)
-			complete(&io_req->tm_done);
+		if (io_req->wait_for_abts_comp)
+			complete(&io_req->abts_done);
 	}
 
 	list_for_each_entry_safe(io_req, tmp, &tgt->els_queue, link) {
@@ -251,8 +251,8 @@ void bnx2fc_flush_active_ios(struct bnx2fc_rport *tgt)
 				/* Handle eh_abort timeout */
 				BNX2FC_IO_DBG(io_req, "eh_abort for IO "
 					      "in retire_q\n");
-				if (io_req->wait_for_comp)
-					complete(&io_req->tm_done);
+				if (io_req->wait_for_abts_comp)
+					complete(&io_req->abts_done);
 			}
 			kref_put(&io_req->refcount, bnx2fc_cmd_release);
 		}
-- 
1.8.3.1

