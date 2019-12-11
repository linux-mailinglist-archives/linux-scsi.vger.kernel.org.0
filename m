Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E17C711B18B
	for <lists+linux-scsi@lfdr.de>; Wed, 11 Dec 2019 16:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387793AbfLKPbU (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 11 Dec 2019 10:31:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:36022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733272AbfLKP3T (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 11 Dec 2019 10:29:19 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F917222C4;
        Wed, 11 Dec 2019 15:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576078158;
        bh=Lkrzwv+VZslM1yWUjMBa5AXa8JAkyt/5dNNht3t48e8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1NRSmZq3J6YFXc7OW+TeBvMjv4HpdoKCAjrmevA9WsENqI4ryMaSqiEgcN+PXj1L4
         4SiKBEZwa/zP0tehG87ZV0M58p9+/0vodlXfrTtuXkdqeh55s9ezuU9uxxCDzDEmgT
         S6IWOAm9XjDh9D7c1dP7oGUx10sGFQtaGwblBzaQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Anatol Pomazau <anatol@google.com>,
        Frank Mayhar <fmayhar@google.com>,
        Bharath Ravi <rbharath@google.com>,
        Khazhimsel Kumykov <khazhy@google.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Lee Duncan <lduncan@suse.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, open-iscsi@googlegroups.com,
        linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 43/58] scsi: iscsi: Don't send data to unbound connection
Date:   Wed, 11 Dec 2019 10:28:16 -0500
Message-Id: <20191211152831.23507-43-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211152831.23507-1-sashal@kernel.org>
References: <20191211152831.23507-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Anatol Pomazau <anatol@google.com>

[ Upstream commit 238191d65d7217982d69e21c1d623616da34b281 ]

If a faulty initiator fails to bind the socket to the iSCSI connection
before emitting a command, for instance, a subsequent send_pdu, it will
crash the kernel due to a null pointer dereference in sock_sendmsg(), as
shown in the log below.  This patch makes sure the bind succeeded before
trying to use the socket.

BUG: kernel NULL pointer dereference, address: 0000000000000018
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: 0000 [#1] SMP PTI
CPU: 3 PID: 7 Comm: kworker/u8:0 Not tainted 5.4.0-rc2.iscsi+ #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   24.158246] Workqueue: iscsi_q_0 iscsi_xmitworker
[   24.158883] RIP: 0010:apparmor_socket_sendmsg+0x5/0x20
[...]
[   24.161739] RSP: 0018:ffffab6440043ca0 EFLAGS: 00010282
[   24.162400] RAX: ffffffff891c1c00 RBX: ffffffff89d53968 RCX: 0000000000000001
[   24.163253] RDX: 0000000000000030 RSI: ffffab6440043d00 RDI: 0000000000000000
[   24.164104] RBP: 0000000000000030 R08: 0000000000000030 R09: 0000000000000030
[   24.165166] R10: ffffffff893e66a0 R11: 0000000000000018 R12: ffffab6440043d00
[   24.166038] R13: 0000000000000000 R14: 0000000000000000 R15: ffff9d5575a62e90
[   24.166919] FS:  0000000000000000(0000) GS:ffff9d557db80000(0000) knlGS:0000000000000000
[   24.167890] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   24.168587] CR2: 0000000000000018 CR3: 000000007a838000 CR4: 00000000000006e0
[   24.169451] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   24.170320] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   24.171214] Call Trace:
[   24.171537]  security_socket_sendmsg+0x3a/0x50
[   24.172079]  sock_sendmsg+0x16/0x60
[   24.172506]  iscsi_sw_tcp_xmit_segment+0x77/0x120
[   24.173076]  iscsi_sw_tcp_pdu_xmit+0x58/0x170
[   24.173604]  ? iscsi_dbg_trace+0x63/0x80
[   24.174087]  iscsi_tcp_task_xmit+0x101/0x280
[   24.174666]  iscsi_xmit_task+0x83/0x110
[   24.175206]  iscsi_xmitworker+0x57/0x380
[   24.175757]  ? __schedule+0x2a2/0x700
[   24.176273]  process_one_work+0x1b5/0x360
[   24.176837]  worker_thread+0x50/0x3c0
[   24.177353]  kthread+0xf9/0x130
[   24.177799]  ? process_one_work+0x360/0x360
[   24.178401]  ? kthread_park+0x90/0x90
[   24.178915]  ret_from_fork+0x35/0x40
[   24.179421] Modules linked in:
[   24.179856] CR2: 0000000000000018
[   24.180327] ---[ end trace b4b7674b6df5f480 ]---

Signed-off-by: Anatol Pomazau <anatol@google.com>
Co-developed-by: Frank Mayhar <fmayhar@google.com>
Signed-off-by: Frank Mayhar <fmayhar@google.com>
Co-developed-by: Bharath Ravi <rbharath@google.com>
Signed-off-by: Bharath Ravi <rbharath@google.com>
Co-developed-by: Khazhimsel Kumykov <khazhy@google.com>
Signed-off-by: Khazhimsel Kumykov <khazhy@google.com>
Co-developed-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Reviewed-by: Lee Duncan <lduncan@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/iscsi_tcp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/scsi/iscsi_tcp.c b/drivers/scsi/iscsi_tcp.c
index 045207b5560eb..7e3a77d3c6f01 100644
--- a/drivers/scsi/iscsi_tcp.c
+++ b/drivers/scsi/iscsi_tcp.c
@@ -372,8 +372,16 @@ static int iscsi_sw_tcp_pdu_xmit(struct iscsi_task *task)
 {
 	struct iscsi_conn *conn = task->conn;
 	unsigned int noreclaim_flag;
+	struct iscsi_tcp_conn *tcp_conn = conn->dd_data;
+	struct iscsi_sw_tcp_conn *tcp_sw_conn = tcp_conn->dd_data;
 	int rc = 0;
 
+	if (!tcp_sw_conn->sock) {
+		iscsi_conn_printk(KERN_ERR, conn,
+				  "Transport not bound to socket!\n");
+		return -EINVAL;
+	}
+
 	noreclaim_flag = memalloc_noreclaim_save();
 
 	while (iscsi_sw_tcp_xmit_qlen(conn)) {
-- 
2.20.1

