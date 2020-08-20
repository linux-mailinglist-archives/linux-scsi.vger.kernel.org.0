Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85FF024AA6E
	for <lists+linux-scsi@lfdr.de>; Thu, 20 Aug 2020 02:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgHTABY (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 19 Aug 2020 20:01:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:57386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbgHTABV (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 19 Aug 2020 20:01:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1955207FB;
        Thu, 20 Aug 2020 00:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597881680;
        bh=EwEXR9T8PYmb61a07qPZ7z2yHCtb/PyyLHa5lWg3rCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nuQv6eSxOZ5Mp5bo0Qda26yYnSlJXYGKQpQFNI1rIVGu+XfOjQJ5NVK/gNgXLLzPM
         gHNAAyZKtf2RO1tc7ivBgDGAbShmm34/aYEo0SkKxPQ2J2OnO4As5ccQKvMVP/oKT7
         49pkFeqOemkMgSahmY0t0EJwwRlftGGYLrUCDDLw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bodo Stroesser <bstroesser@ts.fujitsu.com>,
        JiangYu <lnsyyj@hotmail.com>,
        Daniel Meyerholt <dxm523@gmail.com>,
        Mike Christie <michael.christie@oracle.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.8 02/27] scsi: target: tcmu: Fix crash in tcmu_flush_dcache_range on ARM
Date:   Wed, 19 Aug 2020 20:00:51 -0400
Message-Id: <20200820000116.214821-2-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200820000116.214821-1-sashal@kernel.org>
References: <20200820000116.214821-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Bodo Stroesser <bstroesser@ts.fujitsu.com>

[ Upstream commit 3145550a7f8b08356c8ff29feaa6c56aca12901d ]

This patch fixes the following crash (see
https://bugzilla.kernel.org/show_bug.cgi?id=208045)

 Process iscsi_trx (pid: 7496, stack limit = 0x0000000010dd111a)
 CPU: 0 PID: 7496 Comm: iscsi_trx Not tainted 4.19.118-0419118-generic
        #202004230533
 Hardware name: Greatwall QingTian DF720/F601, BIOS 601FBE20 Sep 26 2019
 pstate: 80400005 (Nzcv daif +PAN -UAO)
 pc : flush_dcache_page+0x18/0x40
 lr : is_ring_space_avail+0x68/0x2f8 [target_core_user]
 sp : ffff000015123a80
 x29: ffff000015123a80 x28: 0000000000000000
 x27: 0000000000001000 x26: ffff000023ea5000
 x25: ffffcfa25bbe08b8 x24: 0000000000000078
 x23: ffff7e0000000000 x22: ffff000023ea5001
 x21: ffffcfa24b79c000 x20: 0000000000000fff
 x19: ffff7e00008fa940 x18: 0000000000000000
 x17: 0000000000000000 x16: ffff2d047e709138
 x15: 0000000000000000 x14: 0000000000000000
 x13: 0000000000000000 x12: ffff2d047fbd0a40
 x11: 0000000000000000 x10: 0000000000000030
 x9 : 0000000000000000 x8 : ffffc9a254820a00
 x7 : 00000000000013b0 x6 : 000000000000003f
 x5 : 0000000000000040 x4 : ffffcfa25bbe08e8
 x3 : 0000000000001000 x2 : 0000000000000078
 x1 : ffffcfa25bbe08b8 x0 : ffff2d040bc88a18
 Call trace:
  flush_dcache_page+0x18/0x40
  is_ring_space_avail+0x68/0x2f8 [target_core_user]
  queue_cmd_ring+0x1f8/0x680 [target_core_user]
  tcmu_queue_cmd+0xe4/0x158 [target_core_user]
  __target_execute_cmd+0x30/0xf0 [target_core_mod]
  target_execute_cmd+0x294/0x390 [target_core_mod]
  transport_generic_new_cmd+0x1e8/0x358 [target_core_mod]
  transport_handle_cdb_direct+0x50/0xb0 [target_core_mod]
  iscsit_execute_cmd+0x2b4/0x350 [iscsi_target_mod]
  iscsit_sequence_cmd+0xd8/0x1d8 [iscsi_target_mod]
  iscsit_process_scsi_cmd+0xac/0xf8 [iscsi_target_mod]
  iscsit_get_rx_pdu+0x404/0xd00 [iscsi_target_mod]
  iscsi_target_rx_thread+0xb8/0x130 [iscsi_target_mod]
  kthread+0x130/0x138
  ret_from_fork+0x10/0x18
 Code: f9000bf3 aa0003f3 aa1e03e0 d503201f (f9400260)
 ---[ end trace 1e451c73f4266776 ]---

The solution is based on patch:

  "scsi: target: tcmu: Optimize use of flush_dcache_page"

which restricts the use of tcmu_flush_dcache_range() to addresses from
vmalloc'ed areas only.

This patch now replaces the virt_to_page() call in
tcmu_flush_dcache_range() - which is wrong for vmalloced addrs - by
vmalloc_to_page().

The patch was tested on ARM with kernel 4.19.118 and 5.7.2

Link: https://lore.kernel.org/r/20200618131632.32748-3-bstroesser@ts.fujitsu.com
Tested-by: JiangYu <lnsyyj@hotmail.com>
Tested-by: Daniel Meyerholt <dxm523@gmail.com>
Acked-by: Mike Christie <michael.christie@oracle.com>
Signed-off-by: Bodo Stroesser <bstroesser@ts.fujitsu.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/target/target_core_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/target/target_core_user.c b/drivers/target/target_core_user.c
index 560bfec933bc3..63cca0e1e9123 100644
--- a/drivers/target/target_core_user.c
+++ b/drivers/target/target_core_user.c
@@ -601,7 +601,7 @@ static inline void tcmu_flush_dcache_range(void *vaddr, size_t size)
 	size = round_up(size+offset, PAGE_SIZE);
 
 	while (size) {
-		flush_dcache_page(virt_to_page(start));
+		flush_dcache_page(vmalloc_to_page(start));
 		start += PAGE_SIZE;
 		size -= PAGE_SIZE;
 	}
-- 
2.25.1

