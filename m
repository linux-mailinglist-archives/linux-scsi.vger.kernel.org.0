Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEEA315EC2F
	for <lists+linux-scsi@lfdr.de>; Fri, 14 Feb 2020 18:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391550AbgBNRZ0 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 14 Feb 2020 12:25:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:32942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390887AbgBNQIx (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 14 Feb 2020 11:08:53 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74BC324681;
        Fri, 14 Feb 2020 16:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696532;
        bh=k4kF6btikDn9yDWwmYaWL/D+zmwQ0Z+8XzJtVpzynrc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RAv1JA1/VN0Mlw5IZ4j0z1wuLAI33Xcobf+1HgTX2V8GdmJKzj78hvm3Z7S5Z7BB8
         xvLJqLrvXTn7vGevlsE1rCz47v6jOxHkxIr9VDIlWNBQcQjls2vzHqIPTOlhCtEZuT
         fDjVMbj4jCg5r4mteJi6aBJfS5jQi4Nj6X5IkP9g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nick Black <nlb@google.com>, Salman Qazi <sqazi@google.com>,
        Junho Ryu <jayr@google.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Lee Duncan <lduncan@suse.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, open-iscsi@googlegroups.com,
        linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 329/459] scsi: iscsi: Don't destroy session if there are outstanding connections
Date:   Fri, 14 Feb 2020 10:59:39 -0500
Message-Id: <20200214160149.11681-329-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Nick Black <nlb@google.com>

[ Upstream commit 54155ed4199c7aa3fd20866648024ab63c96d579 ]

A faulty userspace that calls destroy_session() before destroying the
connections can trigger the failure.  This patch prevents the issue by
refusing to destroy the session if there are outstanding connections.

------------[ cut here ]------------
kernel BUG at mm/slub.c:306!
invalid opcode: 0000 [#1] SMP PTI
CPU: 1 PID: 1224 Comm: iscsid Not tainted 5.4.0-rc2.iscsi+ #7
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
RIP: 0010:__slab_free+0x181/0x350
[...]
[ 1209.686056] RSP: 0018:ffffa93d4074fae0 EFLAGS: 00010246
[ 1209.686694] RAX: ffff934efa5ad800 RBX: 000000008010000a RCX: ffff934efa5ad800
[ 1209.687651] RDX: ffff934efa5ad800 RSI: ffffeb4041e96b00 RDI: ffff934efd402c40
[ 1209.688582] RBP: ffffa93d4074fb80 R08: 0000000000000001 R09: ffffffffbb5dfa26
[ 1209.689425] R10: ffff934efa5ad800 R11: 0000000000000001 R12: ffffeb4041e96b00
[ 1209.690285] R13: ffff934efa5ad800 R14: ffff934efd402c40 R15: 0000000000000000
[ 1209.691213] FS:  00007f7945dfb540(0000) GS:ffff934efda80000(0000) knlGS:0000000000000000
[ 1209.692316] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1209.693013] CR2: 000055877fd3da80 CR3: 0000000077384000 CR4: 00000000000006e0
[ 1209.693897] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1209.694773] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1209.695631] Call Trace:
[ 1209.695957]  ? __wake_up_common_lock+0x8a/0xc0
[ 1209.696712]  iscsi_pool_free+0x26/0x40
[ 1209.697263]  iscsi_session_teardown+0x2f/0xf0
[ 1209.698117]  iscsi_sw_tcp_session_destroy+0x45/0x60
[ 1209.698831]  iscsi_if_rx+0xd88/0x14e0
[ 1209.699370]  netlink_unicast+0x16f/0x200
[ 1209.699932]  netlink_sendmsg+0x21a/0x3e0
[ 1209.700446]  sock_sendmsg+0x4f/0x60
[ 1209.700902]  ___sys_sendmsg+0x2ae/0x320
[ 1209.701451]  ? cp_new_stat+0x150/0x180
[ 1209.701922]  __sys_sendmsg+0x59/0xa0
[ 1209.702357]  do_syscall_64+0x52/0x160
[ 1209.702812]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 1209.703419] RIP: 0033:0x7f7946433914
[...]
[ 1209.706084] RSP: 002b:00007fffb99f2378 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
[ 1209.706994] RAX: ffffffffffffffda RBX: 000055bc869eac20 RCX: 00007f7946433914
[ 1209.708082] RDX: 0000000000000000 RSI: 00007fffb99f2390 RDI: 0000000000000005
[ 1209.709120] RBP: 00007fffb99f2390 R08: 000055bc84fe9320 R09: 00007fffb99f1f07
[ 1209.710110] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000038
[ 1209.711085] R13: 000055bc8502306e R14: 0000000000000000 R15: 0000000000000000
 Modules linked in:
 ---[ end trace a2d933ede7f730d8 ]---

Link: https://lore.kernel.org/r/20191226203148.2172200-1-krisman@collabora.com
Signed-off-by: Nick Black <nlb@google.com>
Co-developed-by: Salman Qazi <sqazi@google.com>
Signed-off-by: Salman Qazi <sqazi@google.com>
Co-developed-by: Junho Ryu <jayr@google.com>
Signed-off-by: Junho Ryu <jayr@google.com>
Co-developed-by: Khazhismel Kumykov <khazhy@google.com>
Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
Co-developed-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Reviewed-by: Lee Duncan <lduncan@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/iscsi_tcp.c            |  4 ++++
 drivers/scsi/scsi_transport_iscsi.c | 26 +++++++++++++++++++++++---
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/iscsi_tcp.c b/drivers/scsi/iscsi_tcp.c
index 0bc63a7ab41c8..b5dd1caae5e92 100644
--- a/drivers/scsi/iscsi_tcp.c
+++ b/drivers/scsi/iscsi_tcp.c
@@ -887,6 +887,10 @@ iscsi_sw_tcp_session_create(struct iscsi_endpoint *ep, uint16_t cmds_max,
 static void iscsi_sw_tcp_session_destroy(struct iscsi_cls_session *cls_session)
 {
 	struct Scsi_Host *shost = iscsi_session_to_shost(cls_session);
+	struct iscsi_session *session = cls_session->dd_data;
+
+	if (WARN_ON_ONCE(session->leadconn))
+		return;
 
 	iscsi_tcp_r2tpool_free(cls_session->dd_data);
 	iscsi_session_teardown(cls_session);
diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index ed8d9709b9b96..271afea654e2b 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -2947,6 +2947,24 @@ iscsi_set_path(struct iscsi_transport *transport, struct iscsi_uevent *ev)
 	return err;
 }
 
+static int iscsi_session_has_conns(int sid)
+{
+	struct iscsi_cls_conn *conn;
+	unsigned long flags;
+	int found = 0;
+
+	spin_lock_irqsave(&connlock, flags);
+	list_for_each_entry(conn, &connlist, conn_list) {
+		if (iscsi_conn_get_sid(conn) == sid) {
+			found = 1;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&connlock, flags);
+
+	return found;
+}
+
 static int
 iscsi_set_iface_params(struct iscsi_transport *transport,
 		       struct iscsi_uevent *ev, uint32_t len)
@@ -3524,10 +3542,12 @@ iscsi_if_recv_msg(struct sk_buff *skb, struct nlmsghdr *nlh, uint32_t *group)
 		break;
 	case ISCSI_UEVENT_DESTROY_SESSION:
 		session = iscsi_session_lookup(ev->u.d_session.sid);
-		if (session)
-			transport->destroy_session(session);
-		else
+		if (!session)
 			err = -EINVAL;
+		else if (iscsi_session_has_conns(ev->u.d_session.sid))
+			err = -EBUSY;
+		else
+			transport->destroy_session(session);
 		break;
 	case ISCSI_UEVENT_UNBIND_SESSION:
 		session = iscsi_session_lookup(ev->u.d_session.sid);
-- 
2.20.1

