Return-Path: <linux-scsi+bounces-15353-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5600B0CC81
	for <lists+linux-scsi@lfdr.de>; Mon, 21 Jul 2025 23:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B120B7B2D4D
	for <lists+linux-scsi@lfdr.de>; Mon, 21 Jul 2025 21:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FD223F413;
	Mon, 21 Jul 2025 21:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="xZ9UQ8/u"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A0923E34C
	for <linux-scsi@vger.kernel.org>; Mon, 21 Jul 2025 21:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753132999; cv=none; b=sVYDEouWko5KY5OKoKZL2rG/eFoUjfiwklvPAZsr7Odqwuw6NTofK+XoKXqMl2T8VGquRI3y8cnZT36oA8tub6H5zNjzMIlEYKlAi2bP6Bk2CHpveKOIwQ1KFQ3x8tcndgWX9aI9wtg792wNCGbXfC9/GpsgZipDkkBiayDCO8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753132999; c=relaxed/simple;
	bh=V0+HQypSMNWWlGdLaU3WLdyNxVOnaYxaP68d7ZXNJw0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oSHmwak/ngE0B0psGK2Td6+T2sHDOwY2iQe4HoBExWn+JpCJJBrSBaVsK7vGuy+JcboU8428qEl8+sHPCKmquVZcWGKRedptd4PQwoTk3fhMj+vji4LKQ3kJXKoSbT8EtCSRjPWONIci02WLy+H1VA8bilLUVJMaBdrrlVGeiU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=xZ9UQ8/u; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4bmD043d30zlgqV5;
	Mon, 21 Jul 2025 21:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:mime-version
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1753132993; x=1755724994; bh=6cLAE
	7i5fnR5FW+tZnKaWxMhsSmq+TxNFQXGOHOHwIc=; b=xZ9UQ8/ux5ZvRLozRzI/S
	e4D9i09BCS/twpOJFRH/ORg/2MQjJaCEnHBC+AZSYDEA36bcc7KgNIWKjXr7ZB+p
	JS6M+8JYqdf2IqPkB+EpTCVMlLAMt68k3J+Gj1d/Y7qcTxRKvW/vjadHFywTKV+q
	99HhD2QOGt6P9aFrbccSNI7mPa/bYtxFbGyRStCLAHb+7GLfqjKY6/ETg971C015
	pMfwlQ/fJjnUgwc2unjiV+V24kOowmFWFIRhp6hSNQhHKQUxLqvvxOwt+qHPITTG
	qoKVnCxIKH5C/j+e0nqBzz6mXmpavt6wgfufvxTva4+mu5Y3FlTHSrnJ/JKXHTW4
	Q==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 3YNMgz4H_uHW; Mon, 21 Jul 2025 21:23:13 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4bmCzt325rzlgqVJ;
	Mon, 21 Jul 2025 21:23:05 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Peter Wang <peter.wang@mediatek.com>,
	Avri Altman <avri.altman@sandisk.com>,
	Bean Huo <huobean@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	"Bao D. Nguyen" <quic_nguyenb@quicinc.com>
Subject: [PATCH] ufs: core: Fix IRQ lock inversion
Date: Mon, 21 Jul 2025 14:22:28 -0700
Message-ID: <20250721212236.2852001-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Commit 3c7ac40d7322 ("scsi: ufs: core: Delegate the interrupt service
routine to a threaded IRQ handler") introduced IRQ lock inversion. Fix
this lock inversion by changing the spin_lock_irq() calls into
spin_lock_irqsave() calls in code that can be called either from
interrupt context or from thread context.

WARNING: possible irq lock inversion dependency detected
6.12.30-android16-5-maybe-dirty-4k #1 Tainted: G        W  OE
--------------------------------------------------------
kworker/u28:0/12 just changed the state of lock:
ffffff881e29dd60 (&hba->clk_gating.lock){-...}-{2:2}, at: ufshcd_release_=
scsi_cmd+0x60/0x110
but this lock took another, HARDIRQ-unsafe lock in the past:
 (shost->host_lock){+.+.}-{2:2}

and interrupts could create inverse lock ordering between them.

other info that might help us debug this:
 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(shost->host_lock);
                               local_irq_disable();
                               lock(&hba->clk_gating.lock);
                               lock(shost->host_lock);
  <Interrupt>
    lock(&hba->clk_gating.lock);

 *** DEADLOCK ***

4 locks held by kworker/u28:0/12:
 #0: ffffff8800ac6158 ((wq_completion)async){+.+.}-{0:0}, at: process_one=
_work+0x1bc/0x65c
 #1: ffffffc085c93d70 ((work_completion)(&entry->work)){+.+.}-{0:0}, at: =
process_one_work+0x1e4/0x65c
 #2: ffffff881e29c0e0 (&shost->scan_mutex){+.+.}-{3:3}, at: __scsi_add_de=
vice+0x74/0x120
 #3: ffffff881960ea00 (&hwq->cq_lock){-...}-{2:2}, at: ufshcd_mcq_poll_cq=
e_lock+0x28/0x104

the shortest dependencies between 2nd lock and 1st lock:
 -> (shost->host_lock){+.+.}-{2:2} {
    HARDIRQ-ON-W at:
                      lock_acquire+0x134/0x2b4
                      _raw_spin_lock+0x48/0x64
                      ufshcd_sl_intr+0x4c/0xa08
                      ufshcd_threaded_intr+0x70/0x12c
                      irq_thread_fn+0x48/0xa8
                      irq_thread+0x130/0x1ec
                      kthread+0x110/0x134
                      ret_from_fork+0x10/0x20
    SOFTIRQ-ON-W at:
                      lock_acquire+0x134/0x2b4
                      _raw_spin_lock+0x48/0x64
                      ufshcd_sl_intr+0x4c/0xa08
                      ufshcd_threaded_intr+0x70/0x12c
                      irq_thread_fn+0x48/0xa8
                      irq_thread+0x130/0x1ec
                      kthread+0x110/0x134
                      ret_from_fork+0x10/0x20
    INITIAL USE at:
                     lock_acquire+0x134/0x2b4
                     _raw_spin_lock+0x48/0x64
                     ufshcd_sl_intr+0x4c/0xa08
                     ufshcd_threaded_intr+0x70/0x12c
                     irq_thread_fn+0x48/0xa8
                     irq_thread+0x130/0x1ec
                     kthread+0x110/0x134
                     ret_from_fork+0x10/0x20
  }
  ... key      at: [<ffffffc085ba1a98>] scsi_host_alloc.__key+0x0/0x10
  ... acquired at:
   _raw_spin_lock_irqsave+0x5c/0x80
   __ufshcd_release+0x78/0x118
   ufshcd_send_uic_cmd+0xe4/0x118
   ufshcd_dme_set_attr+0x88/0x1c8
   ufs_google_phy_initialization+0x68/0x418 [ufs]
   ufs_google_link_startup_notify+0x78/0x27c [ufs]
   ufshcd_link_startup+0x84/0x720
   ufshcd_init+0xf3c/0x1330
   ufshcd_pltfrm_init+0x728/0x7d8
   ufs_google_probe+0x30/0x84 [ufs]
   platform_probe+0xa0/0xe0
   really_probe+0x114/0x454
   __driver_probe_device+0xa4/0x160
   driver_probe_device+0x44/0x23c
   __driver_attach_async_helper+0x60/0xd4
   async_run_entry_fn+0x4c/0x17c
   process_one_work+0x26c/0x65c
   worker_thread+0x33c/0x498
   kthread+0x110/0x134
   ret_from_fork+0x10/0x20

-> (&hba->clk_gating.lock){-...}-{2:2} {
   IN-HARDIRQ-W at:
                    lock_acquire+0x134/0x2b4
                    _raw_spin_lock_irqsave+0x5c/0x80
                    ufshcd_release_scsi_cmd+0x60/0x110
                    ufshcd_compl_one_cqe+0x2c0/0x3f4
                    ufshcd_mcq_poll_cqe_lock+0xb0/0x104
                    ufs_google_mcq_intr+0x80/0xa0 [ufs]
                    __handle_irq_event_percpu+0x104/0x32c
                    handle_irq_event+0x40/0x9c
                    handle_fasteoi_irq+0x170/0x2e8
                    generic_handle_domain_irq+0x58/0x80
                    gic_handle_irq+0x48/0x104
                    call_on_irq_stack+0x3c/0x50
                    do_interrupt_handler+0x7c/0xd8
                    el1_interrupt+0x34/0x58
                    el1h_64_irq_handler+0x18/0x24
                    el1h_64_irq+0x68/0x6c
                    _raw_spin_unlock_irqrestore+0x3c/0x6c
                    debug_object_assert_init+0x16c/0x21c
                    __mod_timer+0x4c/0x48c
                    schedule_timeout+0xd4/0x16c
                    io_schedule_timeout+0x48/0x70
                    do_wait_for_common+0x100/0x194
                    wait_for_completion_io_timeout+0x48/0x6c
                    blk_execute_rq+0x124/0x17c
                    scsi_execute_cmd+0x18c/0x3f8
                    scsi_probe_and_add_lun+0x204/0xd74
                    __scsi_add_device+0xbc/0x120
                    ufshcd_async_scan+0x80/0x3c0
                    async_run_entry_fn+0x4c/0x17c
                    process_one_work+0x26c/0x65c
                    worker_thread+0x33c/0x498
                    kthread+0x110/0x134
                    ret_from_fork+0x10/0x20
   INITIAL USE at:
                   lock_acquire+0x134/0x2b4
                   _raw_spin_lock_irqsave+0x5c/0x80
                   ufshcd_hold+0x34/0x14c
                   ufshcd_send_uic_cmd+0x28/0x118
                   ufshcd_dme_set_attr+0x88/0x1c8
                   ufs_google_phy_initialization+0x68/0x418 [ufs]
                   ufs_google_link_startup_notify+0x78/0x27c [ufs]
                   ufshcd_link_startup+0x84/0x720
                   ufshcd_init+0xf3c/0x1330
                   ufshcd_pltfrm_init+0x728/0x7d8
                   ufs_google_probe+0x30/0x84 [ufs]
                   platform_probe+0xa0/0xe0
                   really_probe+0x114/0x454
                   __driver_probe_device+0xa4/0x160
                   driver_probe_device+0x44/0x23c
                   __driver_attach_async_helper+0x60/0xd4
                   async_run_entry_fn+0x4c/0x17c
                   process_one_work+0x26c/0x65c
                   worker_thread+0x33c/0x498
                   kthread+0x110/0x134
                   ret_from_fork+0x10/0x20
 }
 ... key      at: [<ffffffc085ba6fe8>] ufshcd_init.__key+0x0/0x10
 ... acquired at:
   mark_lock+0x1c4/0x224
   __lock_acquire+0x438/0x2e1c
   lock_acquire+0x134/0x2b4
   _raw_spin_lock_irqsave+0x5c/0x80
   ufshcd_release_scsi_cmd+0x60/0x110
   ufshcd_compl_one_cqe+0x2c0/0x3f4
   ufshcd_mcq_poll_cqe_lock+0xb0/0x104
   ufs_google_mcq_intr+0x80/0xa0 [ufs]
   __handle_irq_event_percpu+0x104/0x32c
   handle_irq_event+0x40/0x9c
   handle_fasteoi_irq+0x170/0x2e8
   generic_handle_domain_irq+0x58/0x80
   gic_handle_irq+0x48/0x104
   call_on_irq_stack+0x3c/0x50
   do_interrupt_handler+0x7c/0xd8
   el1_interrupt+0x34/0x58
   el1h_64_irq_handler+0x18/0x24
   el1h_64_irq+0x68/0x6c
   _raw_spin_unlock_irqrestore+0x3c/0x6c
   debug_object_assert_init+0x16c/0x21c
   __mod_timer+0x4c/0x48c
   schedule_timeout+0xd4/0x16c
   io_schedule_timeout+0x48/0x70
   do_wait_for_common+0x100/0x194
   wait_for_completion_io_timeout+0x48/0x6c
   blk_execute_rq+0x124/0x17c
   scsi_execute_cmd+0x18c/0x3f8
   scsi_probe_and_add_lun+0x204/0xd74
   __scsi_add_device+0xbc/0x120
   ufshcd_async_scan+0x80/0x3c0
   async_run_entry_fn+0x4c/0x17c
   process_one_work+0x26c/0x65c
   worker_thread+0x33c/0x498
   kthread+0x110/0x134
   ret_from_fork+0x10/0x20

stack backtrace:
CPU: 6 UID: 0 PID: 12 Comm: kworker/u28:0 Tainted: G        W  OE      6.=
12.30-android16-5-maybe-dirty-4k #1 ccd4020fe444bdf629efc3b86df6be920b8df=
7d0
Tainted: [W]=3DWARN, [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
Hardware name: Spacecraft board based on MALIBU (DT)
Workqueue: async async_run_entry_fn
Call trace:
 dump_backtrace+0xfc/0x17c
 show_stack+0x18/0x28
 dump_stack_lvl+0x40/0xa0
 dump_stack+0x18/0x24
 print_irq_inversion_bug+0x2fc/0x304
 mark_lock_irq+0x388/0x4fc
 mark_lock+0x1c4/0x224
 __lock_acquire+0x438/0x2e1c
 lock_acquire+0x134/0x2b4
 _raw_spin_lock_irqsave+0x5c/0x80
 ufshcd_release_scsi_cmd+0x60/0x110
 ufshcd_compl_one_cqe+0x2c0/0x3f4
 ufshcd_mcq_poll_cqe_lock+0xb0/0x104
 ufs_google_mcq_intr+0x80/0xa0 [ufs dd6f385554e109da094ab91d5f7be18625a22=
22a]
 __handle_irq_event_percpu+0x104/0x32c
 handle_irq_event+0x40/0x9c
 handle_fasteoi_irq+0x170/0x2e8
 generic_handle_domain_irq+0x58/0x80
 gic_handle_irq+0x48/0x104
 call_on_irq_stack+0x3c/0x50
 do_interrupt_handler+0x7c/0xd8
 el1_interrupt+0x34/0x58
 el1h_64_irq_handler+0x18/0x24
 el1h_64_irq+0x68/0x6c
 _raw_spin_unlock_irqrestore+0x3c/0x6c
 debug_object_assert_init+0x16c/0x21c
 __mod_timer+0x4c/0x48c
 schedule_timeout+0xd4/0x16c
 io_schedule_timeout+0x48/0x70
 do_wait_for_common+0x100/0x194
 wait_for_completion_io_timeout+0x48/0x6c
 blk_execute_rq+0x124/0x17c
 scsi_execute_cmd+0x18c/0x3f8
 scsi_probe_and_add_lun+0x204/0xd74
 __scsi_add_device+0xbc/0x120
 ufshcd_async_scan+0x80/0x3c0
 async_run_entry_fn+0x4c/0x17c
 process_one_work+0x26c/0x65c
 worker_thread+0x33c/0x498
 kthread+0x110/0x134
 ret_from_fork+0x10/0x20

Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
Fixes: 3c7ac40d7322 ("scsi: ufs: core: Delegate the interrupt service rou=
tine to a threaded IRQ handler")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/ufs/core/ufshcd.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index acfc1b4691fa..564143d751d1 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -5566,7 +5566,7 @@ static irqreturn_t ufshcd_uic_cmd_compl(struct ufs_=
hba *hba, u32 intr_status)
 	irqreturn_t retval =3D IRQ_NONE;
 	struct uic_command *cmd;
=20
-	spin_lock(hba->host->host_lock);
+	guard(spinlock_irqsave, hba->host->host_lock);
 	cmd =3D hba->active_uic_cmd;
 	if (WARN_ON_ONCE(!cmd))
 		goto unlock;
@@ -5593,8 +5593,6 @@ static irqreturn_t ufshcd_uic_cmd_compl(struct ufs_=
hba *hba, u32 intr_status)
 		ufshcd_add_uic_command_trace(hba, cmd, UFS_CMD_COMP);
=20
 unlock:
-	spin_unlock(hba->host->host_lock);
-
 	return retval;
 }
=20
@@ -6455,10 +6453,9 @@ void ufshcd_schedule_eh_work(struct ufs_hba *hba)
=20
 static void ufshcd_force_error_recovery(struct ufs_hba *hba)
 {
-	spin_lock_irq(hba->host->host_lock);
+	guard(spinlock_irqsave)(hba->host->host_lock);
 	hba->force_reset =3D true;
 	ufshcd_schedule_eh_work(hba);
-	spin_unlock_irq(hba->host->host_lock);
 }
=20
 static void ufshcd_clk_scaling_allow(struct ufs_hba *hba, bool allow)
@@ -6922,7 +6919,7 @@ static irqreturn_t ufshcd_check_errors(struct ufs_h=
ba *hba, u32 intr_status)
 	bool queue_eh_work =3D false;
 	irqreturn_t retval =3D IRQ_NONE;
=20
-	spin_lock(hba->host->host_lock);
+	guard(spinlock_irqsave)(hba->host->host_lock);
 	hba->errors |=3D UFSHCD_ERROR_MASK & intr_status;
=20
 	if (hba->errors & INT_FATAL_ERRORS) {
@@ -6981,7 +6978,7 @@ static irqreturn_t ufshcd_check_errors(struct ufs_h=
ba *hba, u32 intr_status)
 	 */
 	hba->errors =3D 0;
 	hba->uic_error =3D 0;
-	spin_unlock(hba->host->host_lock);
+
 	return retval;
 }
=20

