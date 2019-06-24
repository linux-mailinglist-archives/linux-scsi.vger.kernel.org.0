Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D63E50495
	for <lists+linux-scsi@lfdr.de>; Mon, 24 Jun 2019 10:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbfFXIaQ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 24 Jun 2019 04:30:16 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:33436 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726612AbfFXIaQ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 24 Jun 2019 04:30:16 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5O8Tkf6024688
        for <linux-scsi@vger.kernel.org>; Mon, 24 Jun 2019 01:30:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=jKQP7NH0Uu9r0bSPPLG77OhF0Io0cZUL6EdjKYR9cmA=;
 b=J1atqdHZe7RNfKO9dKoV5TfE1gMFStaW9P8VQlmkQm7grRakVf2d1idJQqtVwnIV/TSF
 owavzehOGHeS+YE8c7aaNWtlOPTz+hkt7E56neZ8dj/hrH1hlwAehW3/8tlvaqO7xHAc
 8njzUXmTZYgfEYl7Yra6slbdLeCpbAbm3o6LGo+RdxCrVnISAL0fDwxUB5YjvTWURm84
 aeKyKVtTPQ9qAj1AIy5hW+j5N9GBpii78D9QvQjfdlYjrq9cy6CnJmJ1yo6DtX+/VDVy
 J3TukLZ1sPC99tVY/7Zb4St1mwwatzvJVFCGsRkgYvUMGf8X75At0alyQWbbunqfdhli Mw== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2tarxr8dpg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Mon, 24 Jun 2019 01:30:15 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 24 Jun
 2019 01:30:14 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Mon, 24 Jun 2019 01:30:14 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id EC4463F7041;
        Mon, 24 Jun 2019 01:30:13 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id x5O8UDKD023235;
        Mon, 24 Jun 2019 01:30:13 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id x5O8UDYp023234;
        Mon, 24 Jun 2019 01:30:13 -0700
From:   Saurav Kashyap <skashyap@marvell.com>
To:     <martin.petersen@oracle.com>
CC:     <gbasrur@marvell.com>, <svernekar@marvell.com>,
        <linux-scsi@vger.kernel.org>
Subject: [PATCH 4/6] bnx2fc: Do not allow both a cleanup completion and abort completion for the same request.
Date:   Mon, 24 Jun 2019 01:29:58 -0700
Message-ID: <20190624083000.23074-5-skashyap@marvell.com>
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

- If firmware send any one of cleanup or abort completion, it means
 other won't be send, clean out flags for other as well.

Signed-off-by: Saurav Kashyap <skashyap@marvell.com>
---
 drivers/scsi/bnx2fc/bnx2fc.h    |  1 +
 drivers/scsi/bnx2fc/bnx2fc_io.c | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/scsi/bnx2fc/bnx2fc.h b/drivers/scsi/bnx2fc/bnx2fc.h
index 5d7e21a..14cc692 100644
--- a/drivers/scsi/bnx2fc/bnx2fc.h
+++ b/drivers/scsi/bnx2fc/bnx2fc.h
@@ -457,6 +457,7 @@ struct bnx2fc_cmd {
 #define BNX2FC_FLAG_ELS_TIMEOUT		0xb
 #define BNX2FC_FLAG_CMD_LOST		0xc
 #define BNX2FC_FLAG_SRR_SENT		0xd
+#define BNX2FC_FLAG_ISSUE_CLEANUP_REQ	0xe
 	u8 rec_retry;
 	u8 srr_retry;
 	u32 srr_offset;
diff --git a/drivers/scsi/bnx2fc/bnx2fc_io.c b/drivers/scsi/bnx2fc/bnx2fc_io.c
index 88c392b..d7eb5e1 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_io.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_io.c
@@ -1048,6 +1048,9 @@ int bnx2fc_initiate_cleanup(struct bnx2fc_cmd *io_req)
 	/* Obtain free SQ entry */
 	bnx2fc_add_2_sq(tgt, xid);
 
+	/* Set flag that cleanup request is pending with the firmware */
+	set_bit(BNX2FC_FLAG_ISSUE_CLEANUP_REQ, &io_req->req_flags);
+
 	/* Ring doorbell */
 	bnx2fc_ring_doorbell(tgt);
 
@@ -1324,6 +1327,25 @@ void bnx2fc_process_cleanup_compl(struct bnx2fc_cmd *io_req,
 	BNX2FC_IO_DBG(io_req, "Entered process_cleanup_compl "
 			      "refcnt = %d, cmd_type = %d\n",
 		   kref_read(&io_req->refcount), io_req->cmd_type);
+	/*
+	 * Test whether there is a cleanup request pending. If not just
+	 * exit.
+	 */
+	if (!test_and_clear_bit(BNX2FC_FLAG_ISSUE_CLEANUP_REQ,
+				&io_req->req_flags))
+		return;
+	/*
+	 * If we receive a cleanup completion for this request then the
+	 * firmware will not give us an abort completion for this request
+	 * so clear any ABTS pending flags.
+	 */
+	if (test_bit(BNX2FC_FLAG_ISSUE_ABTS, &io_req->req_flags) &&
+	    !test_bit(BNX2FC_FLAG_ABTS_DONE, &io_req->req_flags)) {
+		set_bit(BNX2FC_FLAG_ABTS_DONE, &io_req->req_flags);
+		if (io_req->wait_for_abts_comp)
+			complete(&io_req->abts_done);
+	}
+
 	bnx2fc_scsi_done(io_req, DID_ERROR);
 	kref_put(&io_req->refcount, bnx2fc_cmd_release);
 	if (io_req->wait_for_cleanup_comp)
@@ -1351,6 +1373,16 @@ void bnx2fc_process_abts_compl(struct bnx2fc_cmd *io_req,
 		return;
 	}
 
+	/*
+	 * If we receive an ABTS completion here then we will not receive
+	 * a cleanup completion so clear any cleanup pending flags.
+	 */
+	if (test_bit(BNX2FC_FLAG_ISSUE_CLEANUP_REQ, &io_req->req_flags)) {
+		clear_bit(BNX2FC_FLAG_ISSUE_CLEANUP_REQ, &io_req->req_flags);
+		if (io_req->wait_for_cleanup_comp)
+			complete(&io_req->cleanup_done);
+	}
+
 	/* Do not issue RRQ as this IO is already cleanedup */
 	if (test_and_set_bit(BNX2FC_FLAG_IO_CLEANUP,
 				&io_req->req_flags))
-- 
1.8.3.1

