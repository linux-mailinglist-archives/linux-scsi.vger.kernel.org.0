Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B88D142C067
	for <lists+linux-scsi@lfdr.de>; Wed, 13 Oct 2021 14:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbhJMMrJ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 13 Oct 2021 08:47:09 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:41036 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232145AbhJMMrJ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 13 Oct 2021 08:47:09 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19D6aNfc031524
        for <linux-scsi@vger.kernel.org>; Wed, 13 Oct 2021 05:45:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=ogJqMCinwWPdFWAUZDuQN8zJHhKehDMD8ET1/7DnoSI=;
 b=RExgLMxiWxGJcDBJu9oJpRvomFdlTfdShZ6vnu6AGm9+sDEhZvEIrByCxYNu0L1N0AV0
 YWgAOFfvJC9Vr+JwYhiwYBhfxpI06sAENdx8ROZhmoVMaieqhbnONJB8dLdoPto/k0AR
 x1L8NpXUs6nStZg4zSgtMwWxEoawr4+VN4/TfyBSjAg1zGX7o97hcvTqRpHnR44ssw2/
 1+FOHHPOB6Gly8Cl+46AKCZuvwuh/zX22Mc7XehhJTUR0jihhG3DQTmXYgAVa8WwTCkR
 3Lry1Fbn5TfP51TKJoYhYr7A+5uuxjYfoXtDLVO6FMe6zpVFzlKZ2dZbvg1B1nj3n/2s /w== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 3bnkcck5df-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Wed, 13 Oct 2021 05:45:05 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 13 Oct
 2021 05:45:03 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 13 Oct 2021 05:45:03 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id C46C83F7062;
        Wed, 13 Oct 2021 05:45:02 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id 19DCiveR017194;
        Wed, 13 Oct 2021 05:44:57 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id 19DCiqDV017193;
        Wed, 13 Oct 2021 05:44:52 -0700
From:   Nilesh Javali <njavali@marvell.com>
To:     <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>
Subject: [PATCH 02/13] qla2xxx: fix gnl list corruption
Date:   Wed, 13 Oct 2021 05:44:11 -0700
Message-ID: <20211013124422.17151-3-njavali@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20211013124422.17151-1-njavali@marvell.com>
References: <20211013124422.17151-1-njavali@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: sM3QOA1wcJj1rPr5lCjTz_fNI1VZV2bQ
X-Proofpoint-GUID: sM3QOA1wcJj1rPr5lCjTz_fNI1VZV2bQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-13_05,2021-10-13_02,2020-04-07_01
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Quinn Tran <qutran@marvell.com>

Current code does list element deletion and addition
in and out of lock protection. This patch move lock
deletion behind lock.

list_add double add: new=ffff9130b5eb89f8, prev=ffff9130b5eb89f8,
    next=ffff9130c6a715f0.
 ------------[ cut here ]------------
 kernel BUG at lib/list_debug.c:31!
 invalid opcode: 0000 [#1] SMP PTI
 CPU: 1 PID: 182395 Comm: kworker/1:37 Kdump: loaded Tainted: G W  OE
 --------- -  - 4.18.0-193.el8.x86_64 #1
 Hardware name: HP ProLiant DL160 Gen8, BIOS J03 02/10/2014
 Workqueue: qla2xxx_wq qla2x00_iocb_work_fn [qla2xxx]
 RIP: 0010:__list_add_valid+0x41/0x50
 Code: 85 94 00 00 00 48 39 c7 74 0b 48 39 d7 74 06 b8 01 00 00 00 c3 48 89 f2
 4c 89 c1 48 89 fe 48 c7 c7 60 83 ad 97 e8 4d bd ce ff <0f> 0b 0f 1f 00 66 2e
 0f 1f 84 00 00 00 00 00 48 8b 07 48 8b 57 08
 RSP: 0018:ffffaba306f47d68 EFLAGS: 00010046
 RAX: 0000000000000058 RBX: ffff9130b5eb8800 RCX: 0000000000000006
 RDX: 0000000000000000 RSI: 0000000000000096 RDI: ffff9130b7456a00
 RBP: ffff9130c6a70a58 R08: 000000000008d7be R09: 0000000000000001
 R10: 0000000000000000 R11: 0000000000000001 R12: ffff9130c6a715f0
 R13: ffff9130b5eb8824 R14: ffff9130b5eb89f8 R15: ffff9130b5eb89f8
 FS:  0000000000000000(0000) GS:ffff9130b7440000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007efcaaef11a0 CR3: 000000005200a002 CR4: 00000000000606e0
 Call Trace:
  qla24xx_async_gnl+0x113/0x3c0 [qla2xxx]
  ? qla2x00_iocb_work_fn+0x53/0x80 [qla2xxx]
  ? process_one_work+0x1a7/0x3b0
  ? worker_thread+0x30/0x390
  ? create_worker+0x1a0/0x1a0
  ? kthread+0x112/0x130

Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
---
 drivers/scsi/qla2xxx/qla_init.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 339aa3b2737a..2ccdc76cf0d9 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -987,8 +987,6 @@ static void qla24xx_async_gnl_sp_done(srb_t *sp, int res)
 	    sp->name, res, sp->u.iocb_cmd.u.mbx.in_mb[1],
 	    sp->u.iocb_cmd.u.mbx.in_mb[2]);
 
-	if (res == QLA_FUNCTION_TIMEOUT)
-		return;
 
 	sp->fcport->flags &= ~(FCF_ASYNC_SENT|FCF_ASYNC_ACTIVE);
 	memset(&ea, 0, sizeof(ea));
@@ -1026,8 +1024,8 @@ static void qla24xx_async_gnl_sp_done(srb_t *sp, int res)
 	spin_unlock_irqrestore(&vha->hw->tgt.sess_lock, flags);
 
 	list_for_each_entry_safe(fcport, tf, &h, gnl_entry) {
-		list_del_init(&fcport->gnl_entry);
 		spin_lock_irqsave(&vha->hw->tgt.sess_lock, flags);
+		list_del_init(&fcport->gnl_entry);
 		fcport->flags &= ~(FCF_ASYNC_SENT | FCF_ASYNC_ACTIVE);
 		spin_unlock_irqrestore(&vha->hw->tgt.sess_lock, flags);
 		ea.fcport = fcport;
-- 
2.19.0.rc0

