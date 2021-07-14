Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 317443C8E6D
	for <lists+linux-scsi@lfdr.de>; Wed, 14 Jul 2021 21:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234765AbhGNTrr (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 14 Jul 2021 15:47:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:38626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237862AbhGNTqm (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 14 Jul 2021 15:46:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D8B23613F2;
        Wed, 14 Jul 2021 19:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626291772;
        bh=oKjWj7Onv+W+k1uW4T3TWlfaX1bu26QRsVcZxGXlQgo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gt2ALsCIsSkpO6JXh8Da7uU30UPIKAsaHj6fJmLkt8JBgXB7+Sg9eTk8ejhb53NV7
         zxHGrG7FUpsZLd8N3Ptd7H9Djj8XOiagBKap32jtcPLvf1hYZr0inL+5DLmGIKtv6d
         it+AUund1+EsSACf1Kb2EKGLoUYq4Y77E+mErh9r/HYyUFGP2h2mADYAsxE/FznPMD
         HA/IMU0YQIRz9e5nEybd9jhBQpEUFQKo9XmSdxFVDqYHimR8TR70Riaz7rTWN/JmyB
         OdYO9smmvo40biMfPF3b7Tw87luEJl7XjpRjcdi4bh83qkY571GdRfwrJXrK1Ko15y
         wN6jn++NkLGUw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Javed Hasan <jhasan@marvell.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.12 096/102] scsi: qedf: Add check to synchronize abort and flush
Date:   Wed, 14 Jul 2021 15:40:29 -0400
Message-Id: <20210714194036.53141-96-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210714194036.53141-1-sashal@kernel.org>
References: <20210714194036.53141-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Javed Hasan <jhasan@marvell.com>

[ Upstream commit df99446d5c2a63dc6e6920c8090da0e9da6539d5 ]

A race condition was observed between qedf_cleanup_fcport() and
qedf_process_error_detect()->qedf_initiate_abts():

 [2069091.203145] BUG: unable to handle kernel NULL pointer dereference at 0000000000000030
 [2069091.213100] IP: [<ffffffffc0666cc6>] qedf_process_error_detect+0x96/0x130 [qedf]
 [2069091.223391] PGD 1943049067 PUD 194304e067 PMD 0
 [2069091.233420] Oops: 0000 [#1] SMP
 [2069091.361820] CPU: 1 PID: 14751 Comm: kworker/1:46 Kdump: loaded Tainted: P           OE  ------------   3.10.0-1160.25.1.el7.x86_64 #1
 [2069091.388474] Hardware name: HPE Synergy 480 Gen10/Synergy 480 Gen10 Compute Module, BIOS I42 04/08/2020
 [2069091.402148] Workqueue: qedf_io_wq qedf_fp_io_handler [qedf]
 [2069091.415780] task: ffff9bb9f5190000 ti: ffff9bacaef9c000 task.ti: ffff9bacaef9c000
 [2069091.429590] RIP: 0010:[<ffffffffc0666cc6>]  [<ffffffffc0666cc6>] qedf_process_error_detect+0x96/0x130 [qedf]
 [2069091.443666] RSP: 0018:ffff9bacaef9fdb8  EFLAGS: 00010246
 [2069091.457692] RAX: 0000000000000000 RBX: ffff9bbbbbfb18a0 RCX: ffffffffc0672310
 [2069091.471997] RDX: 00000000000005de RSI: ffffffffc066e7f0 RDI: ffff9beb3f4538d8
 [2069091.486130] RBP: ffff9bacaef9fdd8 R08: 0000000000006000 R09: 0000000000006000
 [2069091.500321] R10: 0000000000001551 R11: ffffb582996ffff8 R12: ffffb5829b39cc18
 [2069091.514779] R13: ffff9badab380c28 R14: ffffd5827f643900 R15: 0000000000000040
 [2069091.529472] FS:  0000000000000000(0000) GS:ffff9beb3f440000(0000) knlGS:0000000000000000
 [2069091.543926] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 [2069091.558942] CR2: 0000000000000030 CR3: 000000193b9a2000 CR4: 00000000007607e0
 [2069091.573424] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 [2069091.587876] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 [2069091.602007] PKRU: 00000000
 [2069091.616010] Call Trace:
 [2069091.629902]  [<ffffffffc0663969>] qedf_process_cqe+0x109/0x2e0 [qedf]
 [2069091.643941]  [<ffffffffc0663b66>] qedf_fp_io_handler+0x26/0x60 [qedf]
 [2069091.657948]  [<ffffffff85ebddcf>] process_one_work+0x17f/0x440
 [2069091.672111]  [<ffffffff85ebeee6>] worker_thread+0x126/0x3c0
 [2069091.686057]  [<ffffffff85ebedc0>] ? manage_workers.isra.26+0x2a0/0x2a0
 [2069091.700033]  [<ffffffff85ec5da1>] kthread+0xd1/0xe0
 [2069091.713891]  [<ffffffff85ec5cd0>] ? insert_kthread_work+0x40/0x40

Add check in qedf_process_error_detect(). When flush is active, let the
cmds be completed from the cleanup contex.

Link: https://lore.kernel.org/r/20210624171802.598-1-jhasan@marvell.com
Signed-off-by: Javed Hasan <jhasan@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qedf/qedf_io.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/qedf/qedf_io.c b/drivers/scsi/qedf/qedf_io.c
index 4869ef813dc4..63f99f4eeed9 100644
--- a/drivers/scsi/qedf/qedf_io.c
+++ b/drivers/scsi/qedf/qedf_io.c
@@ -1520,9 +1520,19 @@ void qedf_process_error_detect(struct qedf_ctx *qedf, struct fcoe_cqe *cqe,
 {
 	int rval;
 
+	if (io_req == NULL) {
+		QEDF_INFO(NULL, QEDF_LOG_IO, "io_req is NULL.\n");
+		return;
+	}
+
+	if (io_req->fcport == NULL) {
+		QEDF_INFO(NULL, QEDF_LOG_IO, "fcport is NULL.\n");
+		return;
+	}
+
 	if (!cqe) {
 		QEDF_INFO(&qedf->dbg_ctx, QEDF_LOG_IO,
-			  "cqe is NULL for io_req %p\n", io_req);
+			"cqe is NULL for io_req %p\n", io_req);
 		return;
 	}
 
@@ -1538,6 +1548,16 @@ void qedf_process_error_detect(struct qedf_ctx *qedf, struct fcoe_cqe *cqe,
 		  le32_to_cpu(cqe->cqe_info.err_info.rx_buf_off),
 		  le32_to_cpu(cqe->cqe_info.err_info.rx_id));
 
+	/* When flush is active, let the cmds be flushed out from the cleanup context */
+	if (test_bit(QEDF_RPORT_IN_TARGET_RESET, &io_req->fcport->flags) ||
+		(test_bit(QEDF_RPORT_IN_LUN_RESET, &io_req->fcport->flags) &&
+		 io_req->sc_cmd->device->lun == (u64)io_req->fcport->lun_reset_lun)) {
+		QEDF_ERR(&qedf->dbg_ctx,
+			"Dropping EQE for xid=0x%x as fcport is flushing",
+			io_req->xid);
+		return;
+	}
+
 	if (qedf->stop_io_on_error) {
 		qedf_stop_all_io(qedf);
 		return;
-- 
2.30.2

