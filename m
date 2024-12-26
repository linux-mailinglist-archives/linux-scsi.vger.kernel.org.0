Return-Path: <linux-scsi+bounces-11033-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EC59FCADE
	for <lists+linux-scsi@lfdr.de>; Thu, 26 Dec 2024 13:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F336A1623F5
	for <lists+linux-scsi@lfdr.de>; Thu, 26 Dec 2024 12:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208EB1CEEBE;
	Thu, 26 Dec 2024 12:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oBu0UPWA"
X-Original-To: linux-scsi@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E341C1BC063
	for <linux-scsi@vger.kernel.org>; Thu, 26 Dec 2024 12:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735215505; cv=none; b=TZCzdGMVpo1fl4MXnGmR6QA4towvjM33MTLq1aSxbBUxMfIvPThhC+Mm0mxYioUquQZDuUR+qvK6qI/wi4NMDWqfW6Flw2PtdvdyrZeM5U44yG8B37+LksUSbfC+uE4ezfUU2SAUh8f+snu9DkMcuCzWkOBbhYsPLY7af7C1Yk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735215505; c=relaxed/simple;
	bh=hJa2hd44b6M1GfGs10LHczt/KL5ob5i8O1xtjcMVjac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DWpKb4+KRKGrPBZ0+x9KYbQLj77S9LXGIwg5jHV0QKBh3Zcb8PLqZ0uYEHKkmWUO22kTHZ4vyq9kIr5e893gGYqOhqFCjA+UyvnXey72biTrNJSA76dJeN/Z+7xWypAKHlI0cdLd+6ZH7K+Ny8zNVAzqzUUHOp/scS6h+U5LZ2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oBu0UPWA; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1735215494; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=iSlNSGRDa8q1GnXJnSCFSYoBnGSTX1K9HtLc88SOnMQ=;
	b=oBu0UPWAYf8qMGw1sQ+19M7uNN76m40WJPs0SQlOUGoAvqXDKUmKe3SdODa+uikGxWHOSxek+4gGWxuiFFHUonRcBhQLnqELs/ebZrSDl5uDMAPMvhv585uln1Vg8Fn81q/Cz3ZqWnN05k3ZrGBkUcbjm3L1hYZ0xoAoIJbPxHY=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WMIAKiE_1735215488 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 26 Dec 2024 20:18:13 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: mpi3mr-linuxdrv.pdl@broadcom.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH v3] scsi: mpi3mr: fix possible crash when setup bsg fail
Date: Thu, 26 Dec 2024 20:18:08 +0800
Message-ID: <20241226121808.46396-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If bsg_setup_queue() fails, the bsg_queue is assigned a non-NULL value.
Consequently, in mpi3mr_bsg_exit(), the condition
"if(!mrioc->bsg_queue)" will not be satisfied, preventing execution
from entering bsg_remove_queue(), which could lead to the following
crash:

[   85.349992] BUG: kernel NULL pointer dereference, address:
000000000000041c
[   85.349998] #PF: supervisor read access in kernel mode
[   85.350000] #PF: error_code(0x0000) - not-present page
[   85.350002] PGD 0 P4D 0
[   85.350004] Oops: 0000 [#1] PREEMPT SMP NOPTI
[   85.350006] CPU: 2 PID: 4675 Comm: bash Kdump: loaded Tainted: G
E      6.6.63-cbp.git.f6b4ae219.an23.x86_64 #1
[   85.350009] Hardware name: IEIT SYSTEMS
NF5280-M7-A0-R0-00/NF5280-M7-A0-R0-00, BIOS 06.04.01 07/22/2024
[   85.350010] RIP: 0010:bsg_remove_queue+0x10/0x50
[   85.350019] Code: 01 00 00 e9 92 92 fe ff 66 90 90 90 90 90 90 90 90
90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 48 85 ff 74 3a 55
53 <48> 8b af 28 04 00 00 48 89 fb 48 8b bd c8 00 00 00 e8 1a f9 ff ff
[   85.350021] RSP: 0018:ffffc9000f637d40 EFLAGS: 00010282
[   85.350022] RAX: 0000000000000001 RBX: ffff88810a20aa50 RCX:
0000000000000000
[   85.350023] RDX: 0000000000000000 RSI: 0000000000000293 RDI:
fffffffffffffff4
[   85.350024] RBP: ffff88810a20ad58 R08: 0000000000000004 R09:
ffffc9000f637cfc
[   85.350025] R10: 0000000000000037 R11: ffffffffa8d22d60 R12:
ffff88810a20aa50
[   85.350026] R13: ffff888110e52160 R14: ffff888110e57160 R15:
ffff8882123399a0
[   85.350027] FS:  00007f6f2d673740(0000) GS:ffff88903e100000(0000)
knlGS:0000000000000000
[   85.350028] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   85.350029] CR2: 000000000000041c CR3: 000000112dec6003 CR4:
0000000000f70ee0
[   85.350030] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[   85.350031] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7:
0000000000000400
[   85.350032] PKRU: 55555554
[   85.350033] Call Trace:
[   85.350035]  <TASK>
[   85.350037]  ? __die+0x23/0x70
[   85.350043]  ? page_fault_oops+0x75/0x170
[   85.350046]  ? notify_change+0x44e/0x4f0
[   85.350052]  ? exc_page_fault+0x67/0x140
[   85.350059]  ? asm_exc_page_fault+0x26/0x30
[   85.350065]  ? __pfx_pci_conf1_read+0x10/0x10
[   85.350071]  ? bsg_remove_queue+0x10/0x50
[   85.350077]  mpi3mr_bsg_exit+0x1f/0x50 [mpi3mr]
[   85.350090]  mpi3mr_remove+0x6f/0x340 [mpi3mr]
[   85.350097]  pci_device_remove+0x3f/0xb0
[   85.350104]  device_release_driver_internal+0x19d/0x220
[   85.350110]  unbind_store+0xa4/0xb0
[   85.350114]  kernfs_fop_write_iter+0x11f/0x200
[   85.350119]  vfs_write+0x1fc/0x3e0
[   85.350126]  ksys_write+0x67/0xe0
[   85.350128]  do_syscall_64+0x38/0x80
[   85.350133]  entry_SYSCALL_64_after_hwframe+0x78/0xe2
[   85.350136] RIP: 0033:0x7f6f2c32e4e8
[   85.350138] Code: 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 00 00 00
00 f3 0f 1e fa 48 8d 05 75 72 2a 00 8b 00 85 c0 75 17 b8 01 00 00 00 0f
05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 41 54 49 89 d4 55
[   85.350139] RSP: 002b:00007fff133ad218 EFLAGS: 00000246 ORIG_RAX:
0000000000000001
[   85.350140] RAX: ffffffffffffffda RBX: 000000000000000d RCX:
00007f6f2c32e4e8
[   85.350141] RDX: 000000000000000d RSI: 0000557e657fca70 RDI:
0000000000000001
[   85.350142] RBP: 0000557e657fca70 R08: 000000000000000a R09:
00007f6f2c390160
[   85.350142] R10: 000000000000000a R11: 0000000000000246 R12:
00007f6f2c5d16e0
[   85.350143] R13: 000000000000000d R14: 00007f6f2c5cc860 R15:
000000000000000d
[   85.350144]  </TASK>

Fixes: 4268fa751365 ("scsi: mpi3mr: Add bsg device support")
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
Changes from v2 to v3:
- Add the crash stack to commit body.

Changes from v1 to v2:
- Add return statement when setup bsg queue fail, sorry for the v1
trouble.
 drivers/scsi/mpi3mr/mpi3mr_app.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/mpi3mr/mpi3mr_app.c b/drivers/scsi/mpi3mr/mpi3mr_app.c
index 10b8e4dc64f8..7589f48aebc8 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_app.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_app.c
@@ -2951,6 +2951,7 @@ void mpi3mr_bsg_init(struct mpi3mr_ioc *mrioc)
 		.max_hw_sectors		= MPI3MR_MAX_APP_XFER_SECTORS,
 		.max_segments		= MPI3MR_MAX_APP_XFER_SEGMENTS,
 	};
+	struct request_queue *q;
 
 	device_initialize(bsg_dev);
 
@@ -2966,14 +2967,17 @@ void mpi3mr_bsg_init(struct mpi3mr_ioc *mrioc)
 		return;
 	}
 
-	mrioc->bsg_queue = bsg_setup_queue(bsg_dev, dev_name(bsg_dev), &lim,
+	q = bsg_setup_queue(bsg_dev, dev_name(bsg_dev), &lim,
 			mpi3mr_bsg_request, NULL, 0);
-	if (IS_ERR(mrioc->bsg_queue)) {
+	if (IS_ERR(q)) {
 		ioc_err(mrioc, "%s: bsg registration failed\n",
 		    dev_name(bsg_dev));
 		device_del(bsg_dev);
 		put_device(bsg_dev);
+		return;
 	}
+
+	mrioc->bsg_queue = q;
 }
 
 /**
-- 
2.43.0


