Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC122406164
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Sep 2021 02:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240513AbhIJAmr (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 9 Sep 2021 20:42:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:45080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231924AbhIJASz (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 9 Sep 2021 20:18:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D90761179;
        Fri, 10 Sep 2021 00:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631233050;
        bh=fGJNsXZJEfWuQsC/YWaZfeTvppf9d7dio6s4UPGm+bM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jODxxqNtKVLe1OynylIDXI8c/ge9qfiWnSeVIYwCUuTveBjakoTyhqiC/XgNgdTeS
         VkDtInqlGJlPIyqVd0tH9woEI6ncm+UbYmGveLV3pIu4B+xzG2gzc+jK5TiZBREB4e
         ICXdlRf+aYhn+CLnnpQaeEGgssfdq2U4kh8u+kaAOZYiLM8l/GeOkxSd+XWp78bKQU
         JbIA4ZLlJ5Zq+a+3voyC8IwN6dUEVcnXrNdgWJJg0u6VQ/10fgKZJVoJBPRA0wwL5j
         fnX1QyRrwRjb4aeTitcQpp4D9ixXY5FmM+HLCB+JgM8FvzP/f3Zqv396EiQJR+kssQ
         zh1j47mXe/yIQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kashyap Desai <kashyap.desai@broadcom.com>,
        sathya.prakash@broadcom.com, thenzl@redhat.com,
        Marco Patalano <mpatalan@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>,
        mpi3mr-linuxdrv.pdl@broadcom.com, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.14 66/99] scsi: mpi3mr: Set up IRQs in resume path
Date:   Thu,  9 Sep 2021 20:15:25 -0400
Message-Id: <20210910001558.173296-66-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210910001558.173296-1-sashal@kernel.org>
References: <20210910001558.173296-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Kashyap Desai <kashyap.desai@broadcom.com>

[ Upstream commit 0da66348c26ffde19d69ed7770514d202afde222 ]

Driver is not setting up IRQs in the resume path. As a result, hibernation
path is broken and controller will not be operational after system is
resumed.

Set up IRQs to handle the hibernation case.

Link: https://lore.kernel.org/r/20210818081755.1274470-1-kashyap.desai@broadcom.com
Cc: sathya.prakash@broadcom.com
Cc: thenzl@redhat.com
Reported-by: Marco Patalano <mpatalan@redhat.com>
Tested-by: Marco Patalano <mpatalan@redhat.com>
Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/mpi3mr/mpi3mr.h    | 19 +++++++++++++++--
 drivers/scsi/mpi3mr/mpi3mr_fw.c | 37 ++++++++++++++++++---------------
 drivers/scsi/mpi3mr/mpi3mr_os.c | 13 ++++++------
 3 files changed, 44 insertions(+), 25 deletions(-)

diff --git a/drivers/scsi/mpi3mr/mpi3mr.h b/drivers/scsi/mpi3mr/mpi3mr.h
index 6f5dc9e78553..9787b53a2b59 100644
--- a/drivers/scsi/mpi3mr/mpi3mr.h
+++ b/drivers/scsi/mpi3mr/mpi3mr.h
@@ -183,6 +183,20 @@ enum mpi3mr_iocstate {
 	MRIOC_STATE_UNRECOVERABLE,
 };
 
+/* Init type definitions */
+enum mpi3mr_init_type {
+	MPI3MR_IT_INIT = 0,
+	MPI3MR_IT_RESET,
+	MPI3MR_IT_RESUME,
+};
+
+/* Cleanup reason definitions */
+enum mpi3mr_cleanup_reason {
+	MPI3MR_COMPLETE_CLEANUP = 0,
+	MPI3MR_REINIT_FAILURE,
+	MPI3MR_SUSPEND,
+};
+
 /* Reset reason code definitions*/
 enum mpi3mr_reset_reason {
 	MPI3MR_RESET_FROM_BRINGUP = 1,
@@ -855,8 +869,8 @@ struct delayed_dev_rmhs_node {
 
 int mpi3mr_setup_resources(struct mpi3mr_ioc *mrioc);
 void mpi3mr_cleanup_resources(struct mpi3mr_ioc *mrioc);
-int mpi3mr_init_ioc(struct mpi3mr_ioc *mrioc, u8 re_init);
-void mpi3mr_cleanup_ioc(struct mpi3mr_ioc *mrioc, u8 re_init);
+int mpi3mr_init_ioc(struct mpi3mr_ioc *mrioc, u8 init_type);
+void mpi3mr_cleanup_ioc(struct mpi3mr_ioc *mrioc, u8 reason);
 int mpi3mr_issue_port_enable(struct mpi3mr_ioc *mrioc, u8 async);
 int mpi3mr_admin_request_post(struct mpi3mr_ioc *mrioc, void *admin_req,
 u16 admin_req_sz, u8 ignore_reset);
@@ -872,6 +886,7 @@ void *mpi3mr_get_reply_virt_addr(struct mpi3mr_ioc *mrioc,
 void mpi3mr_repost_sense_buf(struct mpi3mr_ioc *mrioc,
 				     u64 sense_buf_dma);
 
+void mpi3mr_memset_buffers(struct mpi3mr_ioc *mrioc);
 void mpi3mr_os_handle_events(struct mpi3mr_ioc *mrioc,
 			     struct mpi3_event_notification_reply *event_reply);
 void mpi3mr_process_op_reply_desc(struct mpi3mr_ioc *mrioc,
diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
index 2dba2b0af166..4a8316c6bd41 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@ -3205,7 +3205,7 @@ int mpi3mr_setup_resources(struct mpi3mr_ioc *mrioc)
 /**
  * mpi3mr_init_ioc - Initialize the controller
  * @mrioc: Adapter instance reference
- * @re_init: Flag to indicate is this fresh init or re-init
+ * @init_type: Flag to indicate is the init_type
  *
  * This the controller initialization routine, executed either
  * after soft reset or from pci probe callback.
@@ -3218,7 +3218,7 @@ int mpi3mr_setup_resources(struct mpi3mr_ioc *mrioc)
  *
  * Return: 0 on success and non-zero on failure.
  */
-int mpi3mr_init_ioc(struct mpi3mr_ioc *mrioc, u8 re_init)
+int mpi3mr_init_ioc(struct mpi3mr_ioc *mrioc, u8 init_type)
 {
 	int retval = 0;
 	enum mpi3mr_iocstate ioc_state;
@@ -3229,7 +3229,7 @@ int mpi3mr_init_ioc(struct mpi3mr_ioc *mrioc, u8 re_init)
 
 	mrioc->irqpoll_sleep = MPI3MR_IRQ_POLL_SLEEP;
 	mrioc->change_count = 0;
-	if (!re_init) {
+	if (init_type == MPI3MR_IT_INIT) {
 		mrioc->cpu_count = num_online_cpus();
 		retval = mpi3mr_setup_resources(mrioc);
 		if (retval) {
@@ -3314,7 +3314,7 @@ int mpi3mr_init_ioc(struct mpi3mr_ioc *mrioc, u8 re_init)
 		goto out_failed;
 	}
 
-	if (!re_init) {
+	if (init_type != MPI3MR_IT_RESET) {
 		retval = mpi3mr_setup_isr(mrioc, 1);
 		if (retval) {
 			ioc_err(mrioc, "Failed to setup ISR error %d\n",
@@ -3332,7 +3332,7 @@ int mpi3mr_init_ioc(struct mpi3mr_ioc *mrioc, u8 re_init)
 	}
 
 	mpi3mr_process_factsdata(mrioc, &facts_data);
-	if (!re_init) {
+	if (init_type == MPI3MR_IT_INIT) {
 		retval = mpi3mr_check_reset_dma_mask(mrioc);
 		if (retval) {
 			ioc_err(mrioc, "Resetting dma mask failed %d\n",
@@ -3351,7 +3351,7 @@ int mpi3mr_init_ioc(struct mpi3mr_ioc *mrioc, u8 re_init)
 		goto out_failed;
 	}
 
-	if (!re_init) {
+	if (init_type == MPI3MR_IT_INIT) {
 		retval = mpi3mr_alloc_chain_bufs(mrioc);
 		if (retval) {
 			ioc_err(mrioc, "Failed to allocated chain buffers %d\n",
@@ -3374,7 +3374,7 @@ int mpi3mr_init_ioc(struct mpi3mr_ioc *mrioc, u8 re_init)
 	writel(mrioc->sbq_host_index,
 	    &mrioc->sysif_regs->sense_buffer_free_host_index);
 
-	if (!re_init)  {
+	if (init_type != MPI3MR_IT_RESET) {
 		retval = mpi3mr_setup_isr(mrioc, 0);
 		if (retval) {
 			ioc_err(mrioc, "Failed to re-setup ISR, error %d\n",
@@ -3390,7 +3390,7 @@ int mpi3mr_init_ioc(struct mpi3mr_ioc *mrioc, u8 re_init)
 		goto out_failed;
 	}
 
-	if (re_init &&
+	if ((init_type != MPI3MR_IT_INIT) &&
 	    (mrioc->shost->nr_hw_queues > mrioc->num_op_reply_q)) {
 		retval = -1;
 		ioc_err(mrioc,
@@ -3422,7 +3422,7 @@ int mpi3mr_init_ioc(struct mpi3mr_ioc *mrioc, u8 re_init)
 		goto out_failed;
 	}
 
-	if (re_init) {
+	if (init_type != MPI3MR_IT_INIT) {
 		ioc_info(mrioc, "Issuing Port Enable\n");
 		retval = mpi3mr_issue_port_enable(mrioc, 0);
 		if (retval) {
@@ -3434,7 +3434,10 @@ int mpi3mr_init_ioc(struct mpi3mr_ioc *mrioc, u8 re_init)
 	return retval;
 
 out_failed:
-	mpi3mr_cleanup_ioc(mrioc, re_init);
+	if (init_type == MPI3MR_IT_INIT)
+		mpi3mr_cleanup_ioc(mrioc, MPI3MR_COMPLETE_CLEANUP);
+	else
+		mpi3mr_cleanup_ioc(mrioc, MPI3MR_REINIT_FAILURE);
 out_nocleanup:
 	return retval;
 }
@@ -3495,7 +3498,7 @@ static void mpi3mr_memset_op_req_q_buffers(struct mpi3mr_ioc *mrioc, u16 qidx)
  *
  * Return: Nothing.
  */
-static void mpi3mr_memset_buffers(struct mpi3mr_ioc *mrioc)
+void mpi3mr_memset_buffers(struct mpi3mr_ioc *mrioc)
 {
 	u16 i;
 
@@ -3710,7 +3713,7 @@ static void mpi3mr_issue_ioc_shutdown(struct mpi3mr_ioc *mrioc)
 /**
  * mpi3mr_cleanup_ioc - Cleanup controller
  * @mrioc: Adapter instance reference
- * @re_init: Cleanup due to a reinit or not
+ * @reason: Cleanup reason
  *
  * controller cleanup handler, Message unit reset or soft reset
  * and shutdown notification is issued to the controller and the
@@ -3718,11 +3721,11 @@ static void mpi3mr_issue_ioc_shutdown(struct mpi3mr_ioc *mrioc)
  *
  * Return: Nothing.
  */
-void mpi3mr_cleanup_ioc(struct mpi3mr_ioc *mrioc, u8 re_init)
+void mpi3mr_cleanup_ioc(struct mpi3mr_ioc *mrioc, u8 reason)
 {
 	enum mpi3mr_iocstate ioc_state;
 
-	if (!re_init)
+	if (reason == MPI3MR_COMPLETE_CLEANUP)
 		mpi3mr_stop_watchdog(mrioc);
 
 	mpi3mr_ioc_disable_intr(mrioc);
@@ -3737,11 +3740,11 @@ void mpi3mr_cleanup_ioc(struct mpi3mr_ioc *mrioc, u8 re_init)
 			    MPI3_SYSIF_HOST_DIAG_RESET_ACTION_SOFT_RESET,
 			    MPI3MR_RESET_FROM_MUR_FAILURE);
 
-		if (!re_init)
+		if (reason != MPI3MR_REINIT_FAILURE)
 			mpi3mr_issue_ioc_shutdown(mrioc);
 	}
 
-	if (!re_init) {
+	if (reason == MPI3MR_COMPLETE_CLEANUP) {
 		mpi3mr_free_mem(mrioc);
 		mpi3mr_cleanup_resources(mrioc);
 	}
@@ -3923,7 +3926,7 @@ int mpi3mr_soft_reset_handler(struct mpi3mr_ioc *mrioc,
 	mpi3mr_flush_host_io(mrioc);
 	mpi3mr_invalidate_devhandles(mrioc);
 	mpi3mr_memset_buffers(mrioc);
-	retval = mpi3mr_init_ioc(mrioc, 1);
+	retval = mpi3mr_init_ioc(mrioc, MPI3MR_IT_RESET);
 	if (retval) {
 		pr_err(IOCNAME "reinit after soft reset failed: reason %d\n",
 		    mrioc->name, reset_reason);
diff --git a/drivers/scsi/mpi3mr/mpi3mr_os.c b/drivers/scsi/mpi3mr/mpi3mr_os.c
index 24ac7ddec749..b092fc52d884 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_os.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_os.c
@@ -3795,7 +3795,7 @@ mpi3mr_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	}
 
 	mrioc->is_driver_loading = 1;
-	if (mpi3mr_init_ioc(mrioc, 0)) {
+	if (mpi3mr_init_ioc(mrioc, MPI3MR_IT_INIT)) {
 		ioc_err(mrioc, "failure at %s:%d/%s()!\n",
 		    __FILE__, __LINE__, __func__);
 		retval = -ENODEV;
@@ -3818,7 +3818,7 @@ mpi3mr_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return retval;
 
 addhost_failed:
-	mpi3mr_cleanup_ioc(mrioc, 0);
+	mpi3mr_cleanup_ioc(mrioc, MPI3MR_COMPLETE_CLEANUP);
 out_iocinit_failed:
 	destroy_workqueue(mrioc->fwevt_worker_thread);
 out_fwevtthread_failed:
@@ -3870,7 +3870,7 @@ static void mpi3mr_remove(struct pci_dev *pdev)
 		mpi3mr_tgtdev_del_from_list(mrioc, tgtdev);
 		mpi3mr_tgtdev_put(tgtdev);
 	}
-	mpi3mr_cleanup_ioc(mrioc, 0);
+	mpi3mr_cleanup_ioc(mrioc, MPI3MR_COMPLETE_CLEANUP);
 
 	spin_lock(&mrioc_list_lock);
 	list_del(&mrioc->list);
@@ -3910,7 +3910,7 @@ static void mpi3mr_shutdown(struct pci_dev *pdev)
 	spin_unlock_irqrestore(&mrioc->fwevt_lock, flags);
 	if (wq)
 		destroy_workqueue(wq);
-	mpi3mr_cleanup_ioc(mrioc, 0);
+	mpi3mr_cleanup_ioc(mrioc, MPI3MR_COMPLETE_CLEANUP);
 }
 
 #ifdef CONFIG_PM
@@ -3940,7 +3940,7 @@ static int mpi3mr_suspend(struct pci_dev *pdev, pm_message_t state)
 	mpi3mr_cleanup_fwevt_list(mrioc);
 	scsi_block_requests(shost);
 	mpi3mr_stop_watchdog(mrioc);
-	mpi3mr_cleanup_ioc(mrioc, 1);
+	mpi3mr_cleanup_ioc(mrioc, MPI3MR_SUSPEND);
 
 	device_state = pci_choose_state(pdev, state);
 	ioc_info(mrioc, "pdev=0x%p, slot=%s, entering operating state [D%d]\n",
@@ -3988,7 +3988,8 @@ static int mpi3mr_resume(struct pci_dev *pdev)
 	}
 
 	mrioc->stop_drv_processing = 0;
-	mpi3mr_init_ioc(mrioc, 1);
+	mpi3mr_memset_buffers(mrioc);
+	mpi3mr_init_ioc(mrioc, MPI3MR_IT_RESUME);
 	scsi_unblock_requests(shost);
 	mpi3mr_start_watchdog(mrioc);
 
-- 
2.30.2

