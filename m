Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD6361FE2A1
	for <lists+linux-scsi@lfdr.de>; Thu, 18 Jun 2020 04:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731010AbgFRBXf (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 17 Jun 2020 21:23:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:57284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731000AbgFRBXc (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 17 Jun 2020 21:23:32 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 722AF20776;
        Thu, 18 Jun 2020 01:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443412;
        bh=rHpEMiJremWJ4AVvb1ZVRHW/VbO17NmDkwPdsOZEEZ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jaxEW8rLt7q7kmvH82Rf3ZILKAKTkzj2YB5YAzfnB86xUdhtLybhEGa/8BNvsb2HN
         Dt8bGBWysJx/G25LtmpMvd7pggIoWvNSsrEosa4h/3CM650Rbg9ffv3CL2pBz+JAbc
         viKAv6U9u8nXsvZPEefB/OtK+eEd8WFgKksI1BCs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nilesh Javali <njavali@marvell.com>, Lee Duncan <lduncan@suse.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 055/172] scsi: qedi: Do not flush offload work if ARP not resolved
Date:   Wed, 17 Jun 2020 21:20:21 -0400
Message-Id: <20200618012218.607130-55-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618012218.607130-1-sashal@kernel.org>
References: <20200618012218.607130-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Nilesh Javali <njavali@marvell.com>

[ Upstream commit 927527aea0e2a9c1d336c7d33f77f1911481d008 ]

For an unreachable target, offload_work is not initialized and the endpoint
state is set to OFLDCONN_NONE. This results in a WARN_ON due to the check
of the work function field being set to zero.

------------[ cut here ]------------
WARNING: CPU: 24 PID: 18587 at ../kernel/workqueue.c:3037 __flush_work+0x1c1/0x1d0
:
Hardware name: HPE ProLiant DL380 Gen10/ProLiant DL380 Gen10, BIOS U30 02/01/2020
RIP: 0010:__flush_work+0x1c1/0x1d0
Code: ba 6d 00 03 80 c9 f0 eb b6 48 c7 c7 20 ee 6c a4 e8 52 d3 04 00 0f 0b 31 c0 e9 d1 fe ff
ff 48 c7 c7 20 ee 6c a4 e8 3d d3 04 00 <0f> 0b 31 c0 e9 bc fe ff ff e8 11 f3 f
 00 31 f6
RSP: 0018:ffffac5a8cd47a80 EFLAGS: 00010282
RAX: 0000000000000024 RBX: ffff98d68c1fcaf0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff98ce9fd99898 RDI: ffff98ce9fd99898
RBP: ffff98d68c1fcbc0 R08: 00000000000006fa R09: 0000000000000001
R10: ffffac5a8cd47b50 R11: 0000000000000001 R12: 0000000000000000
R13: 000000000000489b R14: ffff98d68c1fc800 R15: ffff98d692132c00
FS:  00007f65f7f62280(0000) GS:ffff98ce9fd80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd2435e880 CR3: 0000000809334003 CR4: 00000000007606e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 ? class_create_release+0x40/0x40
 ? klist_put+0x2c/0x80
 qedi_ep_disconnect+0xdd/0x400 [qedi]
 iscsi_if_ep_disconnect.isra.20+0x59/0x70 [scsi_transport_iscsi]
 iscsi_if_rx+0x129b/0x1670 [scsi_transport_iscsi]
 ? __netlink_lookup+0xe7/0x160
 netlink_unicast+0x21d/0x300
 netlink_sendmsg+0x30f/0x430
 sock_sendmsg+0x5b/0x60
 ____sys_sendmsg+0x1e2/0x240
 ? copy_msghdr_from_user+0xd9/0x160
 ___sys_sendmsg+0x88/0xd0
 ? ___sys_recvmsg+0xa2/0xe0
 ? hrtimer_try_to_cancel+0x25/0x100
 ? do_nanosleep+0x9c/0x170
 ? __sys_sendmsg+0x5e/0xa0
 __sys_sendmsg+0x5e/0xa0
 do_syscall_64+0x60/0x1f0
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f65f6f16107
Code: 64 89 02 48 c7 c0 ff ff ff ff eb b9 0f 1f 80 00 00 00 00 8b 05 aa d2 2b 00 48 63 d2 48
63 ff 85 c0 75 18 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 59 f3 c3 0f 1f 8
    0 00 00 00 00 53 48 89 f3 48
 RSP: 002b:00007ffd24367ca8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
 RAX: ffffffffffffffda RBX: 000055a7aeaaf110 RCX: 00007f65f6f16107
 RDX: 0000000000000000 RSI: 00007ffd24367cc0 RDI: 0000000000000003
 RBP: 0000000000000070 R08: 0000000000000000 R09: 0000000000000000
 R10: 000000000000075c R11: 0000000000000246 R12: 00007ffd24367cc0
 R13: 000055a7ae560008 R14: 00007ffd24367db0 R15: 0000000000000000
 ---[ end trace 54f499c05d41f8bb ]---

Only flush if the connection endpoint state if different from
OFLDCONN_NONE.

[mkp: clarified commit desc]

Link: https://lore.kernel.org/r/20200408064332.19377-5-mrangankar@marvell.com
Reviewed-by: Lee Duncan <lduncan@suse.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Signed-off-by: Manish Rangankar <mrangankar@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qedi/qedi_iscsi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/qedi/qedi_iscsi.c b/drivers/scsi/qedi/qedi_iscsi.c
index d59473d1679f..751941a3ed30 100644
--- a/drivers/scsi/qedi/qedi_iscsi.c
+++ b/drivers/scsi/qedi/qedi_iscsi.c
@@ -1000,7 +1000,8 @@ static void qedi_ep_disconnect(struct iscsi_endpoint *ep)
 	if (qedi_ep->state == EP_STATE_OFLDCONN_START)
 		goto ep_exit_recover;
 
-	flush_work(&qedi_ep->offload_work);
+	if (qedi_ep->state != EP_STATE_OFLDCONN_NONE)
+		flush_work(&qedi_ep->offload_work);
 
 	if (qedi_ep->conn) {
 		qedi_conn = qedi_ep->conn;
-- 
2.25.1

