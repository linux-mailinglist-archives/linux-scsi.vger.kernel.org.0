Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4CA826E05
	for <lists+linux-scsi@lfdr.de>; Wed, 22 May 2019 21:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387524AbfEVTqD (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 22 May 2019 15:46:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:50242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729711AbfEVT1v (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 22 May 2019 15:27:51 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93AF820675;
        Wed, 22 May 2019 19:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558553270;
        bh=yQvt4+uccVxdTjTgy1w2X3qN7O6gBh/UFLTPVcaVHXc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pxs+3MIYytKEsC2XUl23TyLpe2LBNQwsXFNhG9nr8p18Kvj3AAZmg0AWRxrVfgvpG
         RukqhIe3XgDxSTtT9QXd2SJzxuUBd1aCWm03hcQ/47n4dWsYi/z+AJmdYWD/XNHir8
         2+30ze86ECXvldRogE1YdXUvspB5/F3s9UBx2Ncg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Manish Rangankar <mrangankar@marvell.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 046/244] scsi: qedi: Abort ep termination if offload not scheduled
Date:   Wed, 22 May 2019 15:23:12 -0400
Message-Id: <20190522192630.24917-46-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522192630.24917-1-sashal@kernel.org>
References: <20190522192630.24917-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Manish Rangankar <mrangankar@marvell.com>

[ Upstream commit f848bfd8e167210a29374e8a678892bed591684f ]

Sometimes during connection recovery when there is a failure to resolve
ARP, and offload connection was not issued, driver tries to flush pending
offload connection work which was not queued up.

kernel: WARNING: CPU: 19 PID: 10110 at kernel/workqueue.c:3030 __flush_work.isra.34+0x19c/0x1b0
kernel: CPU: 19 PID: 10110 Comm: iscsid Tainted: G W 5.1.0-rc4 #11
kernel: Hardware name: Dell Inc. PowerEdge R730/0599V5, BIOS 2.9.1 12/04/2018
kernel: RIP: 0010:__flush_work.isra.34+0x19c/0x1b0
kernel: Code: 8b fb 66 0f 1f 44 00 00 31 c0 eb ab 48 89 ef c6 07 00 0f 1f 40 00 fb 66 0f 1f 44 00 00 31 c0 eb 96 e8 08 16 fe ff 0f 0b eb 8d <0f> 0b 31 c0 eb 87 0f 1f 40 00 66 2e 0f 1
f 84 00 00 00 00 00 0f 1f
kernel: RSP: 0018:ffffa6b4054dba68 EFLAGS: 00010246
kernel: RAX: 0000000000000000 RBX: ffff91df21c36fc0 RCX: 0000000000000000
kernel: RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff91df21c36fc0
kernel: RBP: ffff91df21c36ef0 R08: 0000000000000000 R09: 0000000000000000
kernel: R10: 0000000000000038 R11: ffffa6b4054dbd60 R12: ffffffffc05e72c0
kernel: R13: ffff91db10280820 R14: 0000000000000048 R15: 0000000000000000
kernel: FS:  00007f5d83cc1740(0000) GS:ffff91df2f840000(0000) knlGS:0000000000000000
kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kernel: CR2: 0000000001cc5000 CR3: 0000000465450002 CR4: 00000000001606e0
kernel: Call Trace:
kernel: ? try_to_del_timer_sync+0x4d/0x80
kernel: qedi_ep_disconnect+0x3b/0x410 [qedi]
kernel: ? 0xffffffffc083c000
kernel: ? klist_iter_exit+0x14/0x20
kernel: ? class_find_device+0x93/0xf0
kernel: iscsi_if_ep_disconnect.isra.18+0x58/0x70 [scsi_transport_iscsi]
kernel: iscsi_if_recv_msg+0x10e2/0x1510 [scsi_transport_iscsi]
kernel: ? copyout+0x22/0x30
kernel: ? _copy_to_iter+0xa0/0x430
kernel: ? _cond_resched+0x15/0x30
kernel: ? __kmalloc_node_track_caller+0x1f9/0x270
kernel: iscsi_if_rx+0xa5/0x1e0 [scsi_transport_iscsi]
kernel: netlink_unicast+0x17f/0x230
kernel: netlink_sendmsg+0x2d2/0x3d0
kernel: sock_sendmsg+0x36/0x50
kernel: ___sys_sendmsg+0x280/0x2a0
kernel: ? timerqueue_add+0x54/0x80
kernel: ? enqueue_hrtimer+0x38/0x90
kernel: ? hrtimer_start_range_ns+0x19f/0x2c0
kernel: __sys_sendmsg+0x58/0xa0
kernel: do_syscall_64+0x5b/0x180
kernel: entry_SYSCALL_64_after_hwframe+0x44/0xa9

Signed-off-by: Manish Rangankar <mrangankar@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qedi/qedi_iscsi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/qedi/qedi_iscsi.c b/drivers/scsi/qedi/qedi_iscsi.c
index d4821b9dea45d..4130b9117055f 100644
--- a/drivers/scsi/qedi/qedi_iscsi.c
+++ b/drivers/scsi/qedi/qedi_iscsi.c
@@ -1001,6 +1001,9 @@ static void qedi_ep_disconnect(struct iscsi_endpoint *ep)
 	qedi_ep = ep->dd_data;
 	qedi = qedi_ep->qedi;
 
+	if (qedi_ep->state == EP_STATE_OFLDCONN_START)
+		goto ep_exit_recover;
+
 	flush_work(&qedi_ep->offload_work);
 
 	if (qedi_ep->conn) {
-- 
2.20.1

