Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0AB326B8C
	for <lists+linux-scsi@lfdr.de>; Wed, 22 May 2019 21:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732351AbfEVT1g (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 22 May 2019 15:27:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:49828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732345AbfEVT1f (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 22 May 2019 15:27:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3100A20675;
        Wed, 22 May 2019 19:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558553254;
        bh=lzQDYxnmPENw2IBbFBXDQ5RLNt5Efiy/LGcOLn6RGmE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zXIHY8cxSc2HWTFlFWrcHACtfRJ0EgKTYEtKklvj9aT7ZtwgSsjE091zUfldFsAX3
         TcaVZ4bijZ6r6HL2lOSwwrdIpSVAFVDwlICBM/LADxOBdM59tA59nrOLkrM37dimEA
         65Ggf5GXZsaD0ck7iBnvUuYWKq5PWmmCfHAlmJCU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 037/244] scsi: qla2xxx: Avoid that lockdep complains about unsafe locking in tcm_qla2xxx_close_session()
Date:   Wed, 22 May 2019 15:23:03 -0400
Message-Id: <20190522192630.24917-37-sashal@kernel.org>
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

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit d4023db71108375e4194e92730ba0d32d7f07813 ]

This patch avoids that lockdep reports the following warning:

=====================================================
WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
5.1.0-rc1-dbg+ #11 Tainted: G        W
-----------------------------------------------------
rmdir/1478 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
00000000e7ac4607 (&(&k->k_lock)->rlock){+.+.}, at: klist_next+0x43/0x1d0

and this task is already holding:
00000000cf0baf5e (&(&ha->tgt.sess_lock)->rlock){-...}, at: tcm_qla2xxx_close_session+0x57/0xb0 [tcm_qla2xxx]
which would create a new lock dependency:
 (&(&ha->tgt.sess_lock)->rlock){-...} -> (&(&k->k_lock)->rlock){+.+.}

but this new dependency connects a HARDIRQ-irq-safe lock:
 (&(&ha->tgt.sess_lock)->rlock){-...}

... which became HARDIRQ-irq-safe at:
  lock_acquire+0xe3/0x200
  _raw_spin_lock_irqsave+0x3d/0x60
  qla2x00_fcport_event_handler+0x1f3d/0x22b0 [qla2xxx]
  qla2x00_async_login_sp_done+0x1dc/0x1f0 [qla2xxx]
  qla24xx_process_response_queue+0xa37/0x10e0 [qla2xxx]
  qla24xx_msix_rsp_q+0x79/0xf0 [qla2xxx]
  __handle_irq_event_percpu+0x79/0x3c0
  handle_irq_event_percpu+0x70/0xf0
  handle_irq_event+0x5a/0x8b
  handle_edge_irq+0x12c/0x310
  handle_irq+0x192/0x20a
  do_IRQ+0x73/0x160
  ret_from_intr+0x0/0x1d
  default_idle+0x23/0x1f0
  arch_cpu_idle+0x15/0x20
  default_idle_call+0x35/0x40
  do_idle+0x2bb/0x2e0
  cpu_startup_entry+0x1d/0x20
  start_secondary+0x24d/0x2d0
  secondary_startup_64+0xa4/0xb0

to a HARDIRQ-irq-unsafe lock:
 (&(&k->k_lock)->rlock){+.+.}

... which became HARDIRQ-irq-unsafe at:
...
  lock_acquire+0xe3/0x200
  _raw_spin_lock+0x32/0x50
  klist_add_tail+0x33/0xb0
  device_add+0x7f4/0xb60
  device_create_groups_vargs+0x11c/0x150
  device_create_with_groups+0x89/0xb0
  vtconsole_class_init+0xb2/0x124
  do_one_initcall+0xc5/0x3ce
  kernel_init_freeable+0x295/0x32e
  kernel_init+0x11/0x11b
  ret_from_fork+0x3a/0x50

other info that might help us debug this:

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&(&k->k_lock)->rlock);
                               local_irq_disable();
                               lock(&(&ha->tgt.sess_lock)->rlock);
                               lock(&(&k->k_lock)->rlock);
  <Interrupt>
    lock(&(&ha->tgt.sess_lock)->rlock);

 *** DEADLOCK ***

4 locks held by rmdir/1478:
 #0: 000000002c7f1ba4 (sb_writers#10){.+.+}, at: mnt_want_write+0x32/0x70
 #1: 00000000c85eb147 (&default_group_class[depth - 1]#2/1){+.+.}, at: do_rmdir+0x217/0x2d0
 #2: 000000002b164d6f (&sb->s_type->i_mutex_key#13){++++}, at: vfs_rmdir+0x7e/0x1d0
 #3: 00000000cf0baf5e (&(&ha->tgt.sess_lock)->rlock){-...}, at: tcm_qla2xxx_close_session+0x57/0xb0 [tcm_qla2xxx]

the dependencies between HARDIRQ-irq-safe lock and the holding lock:
-> (&(&ha->tgt.sess_lock)->rlock){-...} ops: 127 {
   IN-HARDIRQ-W at:
                    lock_acquire+0xe3/0x200
                    _raw_spin_lock_irqsave+0x3d/0x60
                    qla2x00_fcport_event_handler+0x1f3d/0x22b0 [qla2xxx]
                    qla2x00_async_login_sp_done+0x1dc/0x1f0 [qla2xxx]
                    qla24xx_process_response_queue+0xa37/0x10e0 [qla2xxx]
                    qla24xx_msix_rsp_q+0x79/0xf0 [qla2xxx]
                    __handle_irq_event_percpu+0x79/0x3c0
                    handle_irq_event_percpu+0x70/0xf0
                    handle_irq_event+0x5a/0x8b
                    handle_edge_irq+0x12c/0x310
                    handle_irq+0x192/0x20a
                    do_IRQ+0x73/0x160
                    ret_from_intr+0x0/0x1d
                    default_idle+0x23/0x1f0
                    arch_cpu_idle+0x15/0x20
                    default_idle_call+0x35/0x40
                    do_idle+0x2bb/0x2e0
                    cpu_startup_entry+0x1d/0x20
                    start_secondary+0x24d/0x2d0
                    secondary_startup_64+0xa4/0xb0
   INITIAL USE at:
                   lock_acquire+0xe3/0x200
                   _raw_spin_lock_irqsave+0x3d/0x60
                   qla2x00_loop_resync+0xb3d/0x2690 [qla2xxx]
                   qla2x00_do_dpc+0xcee/0xf30 [qla2xxx]
                   kthread+0x1d2/0x1f0
                   ret_from_fork+0x3a/0x50
 }
 ... key      at: [<ffffffffa125f700>] __key.62804+0x0/0xfffffffffff7e900 [qla2xxx]
 ... acquired at:
   __lock_acquire+0x11ed/0x1b60
   lock_acquire+0xe3/0x200
   _raw_spin_lock_irqsave+0x3d/0x60
   klist_next+0x43/0x1d0
   device_for_each_child+0x96/0x110
   scsi_target_block+0x3c/0x40 [scsi_mod]
   fc_remote_port_delete+0xe7/0x1c0 [scsi_transport_fc]
   qla2x00_mark_device_lost+0x4d3/0x500 [qla2xxx]
   qlt_unreg_sess+0x104/0x2c0 [qla2xxx]
   tcm_qla2xxx_close_session+0xa2/0xb0 [tcm_qla2xxx]
   target_shutdown_sessions+0x17b/0x190 [target_core_mod]
   core_tpg_del_initiator_node_acl+0xf3/0x1f0 [target_core_mod]
   target_fabric_nacl_base_release+0x25/0x30 [target_core_mod]
   config_item_release+0x9f/0x120 [configfs]
   config_item_put+0x29/0x2b [configfs]
   configfs_rmdir+0x3d2/0x520 [configfs]
   vfs_rmdir+0xb3/0x1d0
   do_rmdir+0x25c/0x2d0
   __x64_sys_rmdir+0x24/0x30
   do_syscall_64+0x77/0x220
   entry_SYSCALL_64_after_hwframe+0x49/0xbe

the dependencies between the lock to be acquired
 and HARDIRQ-irq-unsafe lock:
-> (&(&k->k_lock)->rlock){+.+.} ops: 14568 {
   HARDIRQ-ON-W at:
                    lock_acquire+0xe3/0x200
                    _raw_spin_lock+0x32/0x50
                    klist_add_tail+0x33/0xb0
                    device_add+0x7f4/0xb60
                    device_create_groups_vargs+0x11c/0x150
                    device_create_with_groups+0x89/0xb0
                    vtconsole_class_init+0xb2/0x124
                    do_one_initcall+0xc5/0x3ce
                    kernel_init_freeable+0x295/0x32e
                    kernel_init+0x11/0x11b
                    ret_from_fork+0x3a/0x50
   SOFTIRQ-ON-W at:
                    lock_acquire+0xe3/0x200
                    _raw_spin_lock+0x32/0x50
                    klist_add_tail+0x33/0xb0
                    device_add+0x7f4/0xb60
                    device_create_groups_vargs+0x11c/0x150
                    device_create_with_groups+0x89/0xb0
                    vtconsole_class_init+0xb2/0x124
                    do_one_initcall+0xc5/0x3ce
                    kernel_init_freeable+0x295/0x32e
                    kernel_init+0x11/0x11b
                    ret_from_fork+0x3a/0x50
   INITIAL USE at:
                   lock_acquire+0xe3/0x200
                   _raw_spin_lock+0x32/0x50
                   klist_add_tail+0x33/0xb0
                   device_add+0x7f4/0xb60
                   device_create_groups_vargs+0x11c/0x150
                   device_create_with_groups+0x89/0xb0
                   vtconsole_class_init+0xb2/0x124
                   do_one_initcall+0xc5/0x3ce
                   kernel_init_freeable+0x295/0x32e
                   kernel_init+0x11/0x11b
                   ret_from_fork+0x3a/0x50
 }
 ... key      at: [<ffffffff83f3d900>] __key.15805+0x0/0x40
 ... acquired at:
   __lock_acquire+0x11ed/0x1b60
   lock_acquire+0xe3/0x200
   _raw_spin_lock_irqsave+0x3d/0x60
   klist_next+0x43/0x1d0
   device_for_each_child+0x96/0x110
   scsi_target_block+0x3c/0x40 [scsi_mod]
   fc_remote_port_delete+0xe7/0x1c0 [scsi_transport_fc]
   qla2x00_mark_device_lost+0x4d3/0x500 [qla2xxx]
   qlt_unreg_sess+0x104/0x2c0 [qla2xxx]
   tcm_qla2xxx_close_session+0xa2/0xb0 [tcm_qla2xxx]
   target_shutdown_sessions+0x17b/0x190 [target_core_mod]
   core_tpg_del_initiator_node_acl+0xf3/0x1f0 [target_core_mod]
   target_fabric_nacl_base_release+0x25/0x30 [target_core_mod]
   config_item_release+0x9f/0x120 [configfs]
   config_item_put+0x29/0x2b [configfs]
   configfs_rmdir+0x3d2/0x520 [configfs]
   vfs_rmdir+0xb3/0x1d0
   do_rmdir+0x25c/0x2d0
   __x64_sys_rmdir+0x24/0x30
   do_syscall_64+0x77/0x220
   entry_SYSCALL_64_after_hwframe+0x49/0xbe

stack backtrace:
CPU: 7 PID: 1478 Comm: rmdir Tainted: G        W         5.1.0-rc1-dbg+ #11
Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
Call Trace:
 dump_stack+0x86/0xca
 check_usage.cold.59+0x473/0x563
 check_prev_add.constprop.43+0x1f1/0x1170
 __lock_acquire+0x11ed/0x1b60
 lock_acquire+0xe3/0x200
 _raw_spin_lock_irqsave+0x3d/0x60
 klist_next+0x43/0x1d0
 device_for_each_child+0x96/0x110
 scsi_target_block+0x3c/0x40 [scsi_mod]
 fc_remote_port_delete+0xe7/0x1c0 [scsi_transport_fc]
 qla2x00_mark_device_lost+0x4d3/0x500 [qla2xxx]
 qlt_unreg_sess+0x104/0x2c0 [qla2xxx]
 tcm_qla2xxx_close_session+0xa2/0xb0 [tcm_qla2xxx]
 target_shutdown_sessions+0x17b/0x190 [target_core_mod]
 core_tpg_del_initiator_node_acl+0xf3/0x1f0 [target_core_mod]
 target_fabric_nacl_base_release+0x25/0x30 [target_core_mod]
 config_item_release+0x9f/0x120 [configfs]
 config_item_put+0x29/0x2b [configfs]
 configfs_rmdir+0x3d2/0x520 [configfs]
 vfs_rmdir+0xb3/0x1d0
 do_rmdir+0x25c/0x2d0
 __x64_sys_rmdir+0x24/0x30
 do_syscall_64+0x77/0x220
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Acked-by: Himanshu Madhani <hmadhani@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/tcm_qla2xxx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/tcm_qla2xxx.c b/drivers/scsi/qla2xxx/tcm_qla2xxx.c
index 7ef549903124d..f425a9e5056bf 100644
--- a/drivers/scsi/qla2xxx/tcm_qla2xxx.c
+++ b/drivers/scsi/qla2xxx/tcm_qla2xxx.c
@@ -365,8 +365,9 @@ static void tcm_qla2xxx_close_session(struct se_session *se_sess)
 
 	spin_lock_irqsave(&vha->hw->tgt.sess_lock, flags);
 	target_sess_cmd_list_set_waiting(se_sess);
-	tcm_qla2xxx_put_sess(sess);
 	spin_unlock_irqrestore(&vha->hw->tgt.sess_lock, flags);
+
+	tcm_qla2xxx_put_sess(sess);
 }
 
 static u32 tcm_qla2xxx_sess_get_index(struct se_session *se_sess)
-- 
2.20.1

