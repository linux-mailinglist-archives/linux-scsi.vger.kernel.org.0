Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB0EFE594C
	for <lists+linux-scsi@lfdr.de>; Sat, 26 Oct 2019 10:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbfJZI4A convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-scsi@lfdr.de>); Sat, 26 Oct 2019 04:56:00 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2441 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726010AbfJZI4A (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 26 Oct 2019 04:56:00 -0400
Received: from DGGEML404-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id 9E6AC9D3645079E50F1F;
        Sat, 26 Oct 2019 16:55:57 +0800 (CST)
Received: from DGGEML424-HUB.china.huawei.com (10.1.199.41) by
 DGGEML404-HUB.china.huawei.com (10.3.17.39) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 26 Oct 2019 16:55:56 +0800
Received: from DGGEML525-MBS.china.huawei.com ([169.254.4.36]) by
 dggeml424-hub.china.huawei.com ([10.1.199.41]) with mapi id 14.03.0439.000;
 Sat, 26 Oct 2019 16:55:50 +0800
From:   "wubo (T)" <wubo40@huawei.com>
To:     "lduncan@suse.com" <lduncan@suse.com>,
        "cleech@redhat.com" <cleech@redhat.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "open-iscsi@googlegroups.com" <open-iscsi@googlegroups.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mingfangsen <mingfangsen@huawei.com>,
        "liuzhiqiang (I)" <liuzhiqiang26@huawei.com>
Subject: [PATCH] scsi: avoid potential deadloop in iscsi_if_rx func
Thread-Topic: [PATCH] scsi: avoid potential deadloop in iscsi_if_rx func
Thread-Index: AdWL2reJ1uh470cQT+idNsWy+95OAQ==
Date:   Sat, 26 Oct 2019 08:55:49 +0000
Message-ID: <EDBAAA0BBBA2AC4E9C8B6B81DEEE1D6915DE9E71@DGGEML525-MBS.china.huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.173.221.252]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Bo Wu <wubo40@huawei.com>

In iscsi_if_rx func, after receiving one request through iscsi_if_recv_msg
func,iscsi_if_send_reply will be called to try to reply the request in 
do-loop. If the return of iscsi_if_send_reply func fails all the time, one
deadloop will occur.
 
For example, a client only send msg without calling recvmsg func, then it
will result in the watchdog soft lockup. The details are given as follows,

Details of the special case which can cause deadloop:
sock_fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_ISCSI); 
... 
retval = bind(sock_fd, (struct sock addr*) & src_addr, sizeof (src_addr); 
... 
while (1) { 
	state_smg = sendmsg(sock_fd, &msg, 0); 
} 
// Note: recvmsg (sock_fd, & msg, 0) is not processed here. 
close(sock_fd); 

watchdog: BUG: soft lockup - CPU#7 stuck for 22s! [netlink_test:253305]
Sample time: 4000897528 ns(HZ: 250)
Sample stat: 
curr: user: 675503481560, nice: 321724050, sys: 448689506750, idle: 4654054240530, iowait: 40885550700, irq: 14161174020, softirq: 8104324140, st: 0
deta: user: 0, nice: 0, sys: 3998210100, idle: 0, iowait: 0, irq: 1547170, softirq: 242870, st: 0
Sample softirq:
	TIMER:        992
	SCHED:          8
Sample irqstat:
 irq    2: delta       1003, curr:    3103802, arch_timer
CPU: 7 PID: 253305 Comm: netlink_test Kdump: loaded Tainted: G           OE     
Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
pstate: 40400005 (nZcv daif +PAN -UAO)
pc : __alloc_skb+0x104/0x1b0
lr : __alloc_skb+0x9c/0x1b0
sp : ffff000033603a30
x29: ffff000033603a30 x28: 00000000000002dd 
x27: ffff800b34ced810 x26: ffff800ba7569f00 
x25: 00000000ffffffff x24: 0000000000000000 
x23: ffff800f7c43f600 x22: 0000000000480020 
x21: ffff0000091d9000 x20: ffff800b34eff200 
x19: ffff800ba7569f00 x18: 0000000000000000 
x17: 0000000000000000 x16: 0000000000000000 
x15: 0000000000000000 x14: 0001000101000100 
x13: 0000000101010000 x12: 0101000001010100 
x11: 0001010101010001 x10: 00000000000002dd 
x9 : ffff000033603d58 x8 : ffff800b34eff400 
x7 : ffff800ba7569200 x6 : ffff800b34eff400 
x5 : 0000000000000000 x4 : 00000000ffffffff 
x3 : 0000000000000000 x2 : 0000000000000001 
x1 : ffff800b34eff2c0 x0 : 0000000000000300 
Call trace:
__alloc_skb+0x104/0x1b0
iscsi_if_rx+0x144/0x12bc [scsi_transport_iscsi]
netlink_unicast+0x1e0/0x258
netlink_sendmsg+0x310/0x378
sock_sendmsg+0x4c/0x70
sock_write_iter+0x90/0xf0
__vfs_write+0x11c/0x190
vfs_write+0xac/0x1c0
ksys_write+0x6c/0xd8
__arm64_sys_write+0x24/0x30
el0_svc_common+0x78/0x130
el0_svc_handler+0x38/0x78
el0_svc+0x8/0xc

Here, we add one limit of retry times in do-loop to avoid the deadloop.

Signed-off-by: Bo Wu <wubo40@huawei.com>
Reviewed-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
---
 drivers/scsi/scsi_transport_iscsi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index 417b868d8735..f377bfed6b0c 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -24,6 +24,8 @@
 
 #define ISCSI_TRANSPORT_VERSION "2.0-870"
 
+#define ISCSI_SEND_MAX_ALLOWED     10
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/iscsi.h>
 
@@ -3682,6 +3684,7 @@ iscsi_if_rx(struct sk_buff *skb)
 		struct nlmsghdr	*nlh;
 		struct iscsi_uevent *ev;
 		uint32_t group;
+		int retries = ISCSI_SEND_MAX_ALLOWED;
 
 		nlh = nlmsg_hdr(skb);
 		if (nlh->nlmsg_len < sizeof(*nlh) + sizeof(*ev) ||
@@ -3710,8 +3713,11 @@ iscsi_if_rx(struct sk_buff *skb)
 				break;
 			if (ev->type == ISCSI_UEVENT_GET_CHAP && !err)
 				break;
+			if (retries <= 0)
+				break;
 			err = iscsi_if_send_reply(portid, nlh->nlmsg_type,
 						  ev, sizeof(*ev));
+			retries--;
 		} while (err < 0 && err != -ECONNREFUSED && err != -ESRCH);
 		skb_pull(skb, rlen);
 	}
-- 
1.8.3.1

