Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24BC537AFA7
	for <lists+linux-scsi@lfdr.de>; Tue, 11 May 2021 21:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbhEKTxL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 11 May 2021 15:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbhEKTw6 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 11 May 2021 15:52:58 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA393C061760
        for <linux-scsi@vger.kernel.org>; Tue, 11 May 2021 12:51:51 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id t193so3978737pgb.4
        for <linux-scsi@vger.kernel.org>; Tue, 11 May 2021 12:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ta/7fEjsyMzuKXtGUdnudrcfJaRyKInM8Oleh4vjzzg=;
        b=cYxX5XLqMiY9ig77+y0P18oIhdZkIBxfRPxl6SMSznAfna7nd+BY8TcTAmOZ6JEkA1
         tFpLsHIYp0KUpye7w6NN9wpkUeRY8Iq1ERUAyt8ECkvllwkfweyoOtINI433Zqz22v2V
         GLAwX2lCnGfiCXWhox3+XhMHUIRzHkTS1+WzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ta/7fEjsyMzuKXtGUdnudrcfJaRyKInM8Oleh4vjzzg=;
        b=mn9buvVeLbTHX9WOke+LiYRQXIx0mG0hLG5FplUlCyuLqINt/Kfy8LUTiNZ8BS7662
         zRRh2oiDsHbWFGYBhQmtdpieJjmIgAQL88PjcboRLwfNoU/ph+pnXwDcvCL6KYqjfCXo
         rwH2oxhoyddDFQT48tbpfs9hjEFZdsD9PbIyra2gvYadTQrmEe7TN9EEaQ+uI+xdLviD
         n0qIF6baz/1ajY18jVQ7mSFe1V3gBMSEmtZ73WCnH1kV4DS0uEmFRICGIdTH/X3PymKw
         E659DxCGSzPVfCu8hrbZhTw9rKW1TuTPmm7giUBnnYCdZHSBuPyJYecJ42GJtOJGJGHg
         yRZw==
X-Gm-Message-State: AOAM531lu3kyEaN1tO6tyxJbI3zcWYSB/d2Z05t4GfQiSKL5cL67C8cc
        VSGdA20wqZFhKrD9xjBZ0EFGnS2GM2R/2n38tHBiA+J1OMmWaYpxIXPWdsi2G5V9MViMeLtHkLH
        y0j+TC1dAlJpT7bFauw4qoI8M6gNTL5X9x1zUw2qL3AD/ywVOHdjsen5+/3CVVTwntuaUiiElfe
        hoIcNfdg==
X-Google-Smtp-Source: ABdhPJxkmmvBwdB6uNIoMhfHSexkZJ+ZKCupk8C4sEOXilE6CQmvogaC92KizVTDZFiPHdHF31uuQQ==
X-Received: by 2002:a63:8f17:: with SMTP id n23mr32832404pgd.82.1620762710757;
        Tue, 11 May 2021 12:51:50 -0700 (PDT)
Received: from drv-bst-rhel8.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id b3sm6317581pfv.61.2021.05.11.12.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 12:51:50 -0700 (PDT)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        steve.hagan@broadcom.com, peter.rivera@broadcom.com,
        mpi3mr-linuxdrv.pdl@broadcom.com,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        sathya.prakash@broadcom.com, hare@suse.de, thenzl@redhat.com
Subject: [PATCH v4 13/24] mpi3mr: implement scsi error handler hooks
Date:   Wed, 12 May 2021 01:24:12 +0530
Message-Id: <20210511195423.2134562-14-kashyap.desai@broadcom.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20210511195423.2134562-1-kashyap.desai@broadcom.com>
References: <20210511195423.2134562-1-kashyap.desai@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000ac7e2c05c213392f"
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

--000000000000ac7e2c05c213392f

SCSI EH hook is added.
Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

Cc: sathya.prakash@broadcom.com
Cc: hare@suse.de
Cc: thenzl@redhat.com
---
 drivers/scsi/mpi3mr/mpi3mr.h    |   3 +
 drivers/scsi/mpi3mr/mpi3mr_fw.c |  35 ++++
 drivers/scsi/mpi3mr/mpi3mr_os.c | 347 ++++++++++++++++++++++++++++++++
 3 files changed, 385 insertions(+)

diff --git a/drivers/scsi/mpi3mr/mpi3mr.h b/drivers/scsi/mpi3mr/mpi3mr.h
index 89d75d522b30..d6aab3b04eff 100644
--- a/drivers/scsi/mpi3mr/mpi3mr.h
+++ b/drivers/scsi/mpi3mr/mpi3mr.h
@@ -97,6 +97,7 @@ extern struct list_head mrioc_list;
 /* command/controller interaction timeout definitions in seconds */
 #define MPI3MR_INTADMCMD_TIMEOUT		10
 #define MPI3MR_PORTENABLE_TIMEOUT		300
+#define MPI3MR_ABORTTM_TIMEOUT			30
 #define MPI3MR_RESETTM_TIMEOUT			30
 #define MPI3MR_RESET_HOST_IOWAIT_TIMEOUT	5
 #define MPI3MR_TSUPDATE_INTERVAL		900
@@ -626,6 +627,7 @@ struct scmd_priv {
  * @chain_bitmap_sz: Chain buffer allocator bitmap size
  * @chain_bitmap: Chain buffer allocator bitmap
  * @chain_buf_lock: Chain buffer list lock
+ * @host_tm_cmds: Command tracker for task management commands
  * @dev_rmhs_cmds: Command tracker for device removal commands
  * @devrem_bitmap_sz: Device removal bitmap size
  * @devrem_bitmap: Device removal bitmap
@@ -748,6 +750,7 @@ struct mpi3mr_ioc {
 	void *chain_bitmap;
 	spinlock_t chain_buf_lock;
 
+	struct mpi3mr_drv_cmd host_tm_cmds;
 	struct mpi3mr_drv_cmd dev_rmhs_cmds[MPI3MR_NUM_DEVRMCMD];
 	u16 devrem_bitmap_sz;
 	void *devrem_bitmap;
diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
index 023b9f6f374b..b733a008f81e 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@ -172,6 +172,8 @@ mpi3mr_get_drv_cmd(struct mpi3mr_ioc *mrioc, u16 host_tag,
 	switch (host_tag) {
 	case MPI3MR_HOSTTAG_INITCMDS:
 		return &mrioc->init_cmds;
+	case MPI3MR_HOSTTAG_BLK_TMS:
+		return &mrioc->host_tm_cmds;
 	case MPI3MR_HOSTTAG_INVALID:
 		if (def_reply && def_reply->function ==
 		    MPI3_FUNCTION_EVENT_NOTIFICATION)
@@ -2033,6 +2035,26 @@ static int mpi3mr_alloc_reply_sense_bufs(struct mpi3mr_ioc *mrioc)
 			goto out_failed;
 	}
 
+	mrioc->host_tm_cmds.reply = kzalloc(mrioc->facts.reply_sz, GFP_KERNEL);
+	if (!mrioc->host_tm_cmds.reply)
+		goto out_failed;
+
+	mrioc->dev_handle_bitmap_sz = mrioc->facts.max_devhandle / 8;
+	if (mrioc->facts.max_devhandle % 8)
+		mrioc->dev_handle_bitmap_sz++;
+	mrioc->removepend_bitmap = kzalloc(mrioc->dev_handle_bitmap_sz,
+	    GFP_KERNEL);
+	if (!mrioc->removepend_bitmap)
+		goto out_failed;
+
+	mrioc->devrem_bitmap_sz = MPI3MR_NUM_DEVRMCMD / 8;
+	if (MPI3MR_NUM_DEVRMCMD % 8)
+		mrioc->devrem_bitmap_sz++;
+	mrioc->devrem_bitmap = kzalloc(mrioc->devrem_bitmap_sz,
+	    GFP_KERNEL);
+	if (!mrioc->devrem_bitmap)
+		goto out_failed;
+
 	mrioc->num_reply_bufs = mrioc->facts.max_reqs + MPI3MR_NUM_EVT_REPLIES;
 	mrioc->reply_free_qsz = mrioc->num_reply_bufs + 1;
 	mrioc->num_sense_bufs = mrioc->facts.max_reqs / MPI3MR_SENSEBUF_FACTOR;
@@ -3046,6 +3068,8 @@ static void mpi3mr_memset_buffers(struct mpi3mr_ioc *mrioc)
 	memset(mrioc->admin_reply_base, 0, mrioc->admin_reply_q_sz);
 
 	memset(mrioc->init_cmds.reply, 0, sizeof(*mrioc->init_cmds.reply));
+	memset(mrioc->host_tm_cmds.reply, 0,
+	    sizeof(*mrioc->host_tm_cmds.reply));
 	for (i = 0; i < MPI3MR_NUM_DEVRMCMD; i++)
 		memset(mrioc->dev_rmhs_cmds[i].reply, 0,
 		    sizeof(*mrioc->dev_rmhs_cmds[i].reply));
@@ -3139,6 +3163,15 @@ static void mpi3mr_free_mem(struct mpi3mr_ioc *mrioc)
 	kfree(mrioc->init_cmds.reply);
 	mrioc->init_cmds.reply = NULL;
 
+	kfree(mrioc->host_tm_cmds.reply);
+	mrioc->host_tm_cmds.reply = NULL;
+
+	kfree(mrioc->removepend_bitmap);
+	mrioc->removepend_bitmap = NULL;
+
+	kfree(mrioc->devrem_bitmap);
+	mrioc->devrem_bitmap = NULL;
+
 	kfree(mrioc->chain_bitmap);
 	mrioc->chain_bitmap = NULL;
 
@@ -3317,6 +3350,8 @@ static void mpi3mr_flush_drv_cmds(struct mpi3mr_ioc *mrioc)
 
 	cmdptr = &mrioc->init_cmds;
 	mpi3mr_drv_cmd_comp_reset(mrioc, cmdptr);
+	cmdptr = &mrioc->host_tm_cmds;
+	mpi3mr_drv_cmd_comp_reset(mrioc, cmdptr);
 
 	for (i = 0; i < MPI3MR_NUM_DEVRMCMD; i++) {
 		cmdptr = &mrioc->dev_rmhs_cmds[i];
diff --git a/drivers/scsi/mpi3mr/mpi3mr_os.c b/drivers/scsi/mpi3mr/mpi3mr_os.c
index d3ace6cdd3fd..d3eedc2ac410 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_os.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_os.c
@@ -2059,6 +2059,212 @@ static int mpi3mr_build_sg_scmd(struct mpi3mr_ioc *mrioc,
 	return ret;
 }
 
+/**
+ * mpi3mr_print_response_code - print TM response as a string
+ * @mrioc: Adapter instance reference
+ * @resp_code: TM response code
+ *
+ * Print TM response code as a readable string.
+ *
+ * Return: Nothing.
+ */
+static void mpi3mr_print_response_code(struct mpi3mr_ioc *mrioc, u8 resp_code)
+{
+	char *desc;
+
+	switch (resp_code) {
+	case MPI3MR_RSP_TM_COMPLETE:
+		desc = "task management request completed";
+		break;
+	case MPI3MR_RSP_INVALID_FRAME:
+		desc = "invalid frame";
+		break;
+	case MPI3MR_RSP_TM_NOT_SUPPORTED:
+		desc = "task management request not supported";
+		break;
+	case MPI3MR_RSP_TM_FAILED:
+		desc = "task management request failed";
+		break;
+	case MPI3MR_RSP_TM_SUCCEEDED:
+		desc = "task management request succeeded";
+		break;
+	case MPI3MR_RSP_TM_INVALID_LUN:
+		desc = "invalid lun";
+		break;
+	case MPI3MR_RSP_TM_OVERLAPPED_TAG:
+		desc = "overlapped tag attempted";
+		break;
+	case MPI3MR_RSP_IO_QUEUED_ON_IOC:
+		desc = "task queued, however not sent to target";
+		break;
+	default:
+		desc = "unknown";
+		break;
+	}
+	ioc_info(mrioc, "%s :response_code(0x%01x): %s\n", __func__,
+	    resp_code, desc);
+}
+
+/**
+ * mpi3mr_issue_tm - Issue Task Management request
+ * @mrioc: Adapter instance reference
+ * @tm_type: Task Management type
+ * @handle: Device handle
+ * @lun: lun ID
+ * @htag: Host tag of the TM request
+ * @drv_cmd: Internal command tracker
+ * @resp_code: Response code place holder
+ * @cmd_priv: SCSI command private data
+ *
+ * Issues a Task Management Request to the controller for a
+ * specified target, lun and command and wait for its completion
+ * and check TM response. Recover the TM if it timed out by
+ * issuing controller reset.
+ *
+ * Return: 0 on success, non-zero on errors
+ */
+static int mpi3mr_issue_tm(struct mpi3mr_ioc *mrioc, u8 tm_type,
+	u16 handle, uint lun, u16 htag, ulong timeout,
+	struct mpi3mr_drv_cmd *drv_cmd,
+	u8 *resp_code, struct scmd_priv *cmd_priv)
+{
+	struct _mpi3_scsi_task_mgmt_request tm_req;
+	struct _mpi3_scsi_task_mgmt_reply *tm_reply = NULL;
+	int retval = 0;
+	struct mpi3mr_tgt_dev *tgtdev = NULL;
+	struct mpi3mr_stgt_priv_data *scsi_tgt_priv_data = NULL;
+	struct op_req_qinfo *op_req_q = NULL;
+
+	ioc_info(mrioc, "%s :Issue TM: TM type (0x%x) for devhandle 0x%04x\n",
+	     __func__, tm_type, handle);
+	if (mrioc->unrecoverable) {
+		retval = -1;
+		ioc_err(mrioc, "%s :Issue TM: Unrecoverable controller\n",
+		    __func__);
+		goto out;
+	}
+
+	memset(&tm_req, 0, sizeof(tm_req));
+	mutex_lock(&drv_cmd->mutex);
+	if (drv_cmd->state & MPI3MR_CMD_PENDING) {
+		retval = -1;
+		ioc_err(mrioc, "%s :Issue TM: Command is in use\n", __func__);
+		mutex_unlock(&drv_cmd->mutex);
+		goto out;
+	}
+	if (mrioc->reset_in_progress) {
+		retval = -1;
+		ioc_err(mrioc, "%s :Issue TM: Reset in progress\n", __func__);
+		mutex_unlock(&drv_cmd->mutex);
+		goto out;
+	}
+
+	drv_cmd->state = MPI3MR_CMD_PENDING;
+	drv_cmd->is_waiting = 1;
+	drv_cmd->callback = NULL;
+	tm_req.dev_handle = cpu_to_le16(handle);
+	tm_req.task_type = tm_type;
+	tm_req.host_tag = cpu_to_le16(htag);
+
+	int_to_scsilun(lun, (struct scsi_lun *)tm_req.lun);
+	tm_req.function = MPI3_FUNCTION_SCSI_TASK_MGMT;
+
+	tgtdev = mpi3mr_get_tgtdev_by_handle(mrioc, handle);
+	if (tgtdev && tgtdev->starget && tgtdev->starget->hostdata) {
+		scsi_tgt_priv_data = (struct mpi3mr_stgt_priv_data *)
+		    tgtdev->starget->hostdata;
+		atomic_inc(&scsi_tgt_priv_data->block_io);
+	}
+	if (cmd_priv) {
+		op_req_q = &mrioc->req_qinfo[cmd_priv->req_q_idx];
+		tm_req.task_host_tag = cpu_to_le16(cmd_priv->host_tag);
+		tm_req.task_request_queue_id = cpu_to_le16(op_req_q->qid);
+	}
+	if (tgtdev && (tgtdev->dev_type == MPI3_DEVICE_DEVFORM_PCIE)) {
+		if (cmd_priv && tgtdev->dev_spec.pcie_inf.abort_to)
+			timeout = tgtdev->dev_spec.pcie_inf.abort_to;
+		else if (!cmd_priv && tgtdev->dev_spec.pcie_inf.reset_to)
+			timeout = tgtdev->dev_spec.pcie_inf.reset_to;
+	}
+
+	init_completion(&drv_cmd->done);
+	retval = mpi3mr_admin_request_post(mrioc, &tm_req, sizeof(tm_req), 1);
+	if (retval) {
+		ioc_err(mrioc, "%s :Issue TM: Admin Post failed\n", __func__);
+		goto out_unlock;
+	}
+	wait_for_completion_timeout(&drv_cmd->done, (timeout * HZ));
+
+	if (!(drv_cmd->state & MPI3MR_CMD_COMPLETE)) {
+		ioc_err(mrioc, "%s :Issue TM: command timed out\n", __func__);
+		drv_cmd->is_waiting = 0;
+		retval = -1;
+		mpi3mr_soft_reset_handler(mrioc,
+		    MPI3MR_RESET_FROM_TM_TIMEOUT, 1);
+		goto out_unlock;
+	}
+
+	if (drv_cmd->state & MPI3MR_CMD_REPLY_VALID)
+		tm_reply = (struct _mpi3_scsi_task_mgmt_reply *)drv_cmd->reply;
+
+	if (drv_cmd->ioc_status != MPI3_IOCSTATUS_SUCCESS) {
+		ioc_err(mrioc,
+		    "%s :Issue TM: handle(0x%04x) Failed ioc_status(0x%04x) Loginfo(0x%08x)\n",
+		    __func__, handle, drv_cmd->ioc_status,
+		    drv_cmd->ioc_loginfo);
+		retval = -1;
+		goto out_unlock;
+	}
+
+	if (!tm_reply) {
+		ioc_err(mrioc, "%s :Issue TM: No TM Reply message\n", __func__);
+		retval = -1;
+		goto out_unlock;
+	}
+
+	*resp_code = le32_to_cpu(tm_reply->response_data) &
+	    MPI3MR_RI_MASK_RESPCODE;
+	switch (*resp_code) {
+	case MPI3MR_RSP_TM_SUCCEEDED:
+	case MPI3MR_RSP_TM_COMPLETE:
+		break;
+	case MPI3MR_RSP_IO_QUEUED_ON_IOC:
+		if (tm_type != MPI3_SCSITASKMGMT_TASKTYPE_QUERY_TASK)
+			retval = -1;
+		break;
+	default:
+		retval = -1;
+		break;
+	}
+
+	ioc_info(mrioc,
+	    "%s :Issue TM: Completed TM type (0x%x) handle(0x%04x) ",
+	    __func__, tm_type, handle);
+	ioc_info(mrioc,
+	    "with ioc_status(0x%04x), loginfo(0x%08x), term_count(0x%08x)\n",
+	    drv_cmd->ioc_status, drv_cmd->ioc_loginfo,
+	    le32_to_cpu(tm_reply->termination_count));
+	mpi3mr_print_response_code(mrioc, *resp_code);
+
+out_unlock:
+	drv_cmd->state = MPI3MR_CMD_NOTUSED;
+	mutex_unlock(&drv_cmd->mutex);
+	if (scsi_tgt_priv_data)
+		atomic_dec_if_positive(&scsi_tgt_priv_data->block_io);
+	if (tgtdev)
+		mpi3mr_tgtdev_put(tgtdev);
+	if (!retval) {
+		/*
+		 * Flush all IRQ handlers by calling synchronize_irq().
+		 * mpi3mr_ioc_disable_intr() takes care of it.
+		 */
+		mpi3mr_ioc_disable_intr(mrioc);
+		mpi3mr_ioc_enable_intr(mrioc);
+	}
+out:
+	return retval;
+}
+
 /**
  * mpi3mr_bios_param - BIOS param callback
  * @sdev: SCSI device reference
@@ -2116,6 +2322,143 @@ static int mpi3mr_map_queues(struct Scsi_Host *shost)
 	    mrioc->pdev, mrioc->op_reply_q_offset);
 }
 
+/**
+ * mpi3mr_eh_host_reset - Host reset error handling callback
+ * @scmd: SCSI command reference
+ *
+ * Issue controller reset if the scmd is for a Physical Device,
+ * if the scmd is for RAID volume, then wait for
+ * MPI3MR_RAID_ERRREC_RESET_TIMEOUT and checke whether any
+ * pending I/Os prior to issuing reset to the controller.
+ *
+ * Return: SUCCESS of successful reset else FAILED
+ */
+static int mpi3mr_eh_host_reset(struct scsi_cmnd *scmd)
+{
+	struct mpi3mr_ioc *mrioc = shost_priv(scmd->device->host);
+	int retval = FAILED, ret;
+
+	ret = mpi3mr_soft_reset_handler(mrioc,
+	    MPI3MR_RESET_FROM_EH_HOS, 1);
+	if (ret)
+		goto out;
+
+	retval = SUCCESS;
+out:
+	sdev_printk(KERN_INFO, scmd->device,
+	    "Host reset is %s for scmd(%p)\n",
+	    ((retval == SUCCESS) ? "SUCCESS" : "FAILED"), scmd);
+
+	return retval;
+}
+
+/**
+ * mpi3mr_eh_target_reset - Target reset error handling callback
+ * @scmd: SCSI command reference
+ *
+ * Issue Target reset Task Management and verify the scmd is
+ * terminated successfully and return status accordingly.
+ *
+ * Return: SUCCESS of successful termination of the scmd else
+ *         FAILED
+ */
+static int mpi3mr_eh_target_reset(struct scsi_cmnd *scmd)
+{
+	struct mpi3mr_ioc *mrioc = shost_priv(scmd->device->host);
+	struct mpi3mr_stgt_priv_data *stgt_priv_data;
+	struct mpi3mr_sdev_priv_data *sdev_priv_data;
+	u16 dev_handle;
+	u8 resp_code = 0;
+	int retval = FAILED, ret = 0;
+
+	sdev_printk(KERN_INFO, scmd->device,
+	    "Attempting Target Reset! scmd(%p)\n", scmd);
+	scsi_print_command(scmd);
+
+	sdev_priv_data = scmd->device->hostdata;
+	if (!sdev_priv_data || !sdev_priv_data->tgt_priv_data) {
+		sdev_printk(KERN_INFO, scmd->device,
+		    "SCSI device is not available\n");
+		retval = SUCCESS;
+		goto out;
+	}
+
+	stgt_priv_data = sdev_priv_data->tgt_priv_data;
+	dev_handle = stgt_priv_data->dev_handle;
+	sdev_printk(KERN_INFO, scmd->device,
+	    "Target Reset is issued to handle(0x%04x)\n",
+	    dev_handle);
+
+	ret = mpi3mr_issue_tm(mrioc,
+	    MPI3_SCSITASKMGMT_TASKTYPE_TARGET_RESET, dev_handle,
+	    sdev_priv_data->lun_id, MPI3MR_HOSTTAG_BLK_TMS,
+	    MPI3MR_RESETTM_TIMEOUT, &mrioc->host_tm_cmds, &resp_code, NULL);
+
+	if (ret)
+		goto out;
+
+	retval = SUCCESS;
+out:
+	sdev_printk(KERN_INFO, scmd->device,
+	    "Target reset is %s for scmd(%p)\n",
+	    ((retval == SUCCESS) ? "SUCCESS" : "FAILED"), scmd);
+
+	return retval;
+}
+
+/**
+ * mpi3mr_eh_dev_reset- Device reset error handling callback
+ * @scmd: SCSI command reference
+ *
+ * Issue lun reset Task Management and verify the scmd is
+ * terminated successfully and return status accordingly.
+ *
+ * Return: SUCCESS of successful termination of the scmd else
+ *         FAILED
+ */
+static int mpi3mr_eh_dev_reset(struct scsi_cmnd *scmd)
+{
+	struct mpi3mr_ioc *mrioc = shost_priv(scmd->device->host);
+	struct mpi3mr_stgt_priv_data *stgt_priv_data;
+	struct mpi3mr_sdev_priv_data *sdev_priv_data;
+	u16 dev_handle;
+	u8 resp_code = 0;
+	int retval = FAILED, ret = 0;
+
+	sdev_printk(KERN_INFO, scmd->device,
+	    "Attempting Device(lun) Reset! scmd(%p)\n", scmd);
+	scsi_print_command(scmd);
+
+	sdev_priv_data = scmd->device->hostdata;
+	if (!sdev_priv_data || !sdev_priv_data->tgt_priv_data) {
+		sdev_printk(KERN_INFO, scmd->device,
+		    "SCSI device is not available\n");
+		retval = SUCCESS;
+		goto out;
+	}
+
+	stgt_priv_data = sdev_priv_data->tgt_priv_data;
+	dev_handle = stgt_priv_data->dev_handle;
+	sdev_printk(KERN_INFO, scmd->device,
+	    "Device(lun) Reset is issued to handle(0x%04x)\n", dev_handle);
+
+	ret = mpi3mr_issue_tm(mrioc,
+	    MPI3_SCSITASKMGMT_TASKTYPE_LOGICAL_UNIT_RESET, dev_handle,
+	    sdev_priv_data->lun_id, MPI3MR_HOSTTAG_BLK_TMS,
+	    MPI3MR_RESETTM_TIMEOUT, &mrioc->host_tm_cmds, &resp_code, NULL);
+
+	if (ret)
+		goto out;
+
+	retval = SUCCESS;
+out:
+	sdev_printk(KERN_INFO, scmd->device,
+	    "Device(lun) reset is %s for scmd(%p)\n",
+	    ((retval == SUCCESS) ? "SUCCESS" : "FAILED"), scmd);
+
+	return retval;
+}
+
 /**
  * mpi3mr_scan_start - Scan start callback handler
  * @shost: SCSI host reference
@@ -2542,6 +2885,9 @@ static struct scsi_host_template mpi3mr_driver_template = {
 	.slave_destroy			= mpi3mr_slave_destroy,
 	.scan_finished			= mpi3mr_scan_finished,
 	.scan_start			= mpi3mr_scan_start,
+	.eh_device_reset_handler	= mpi3mr_eh_dev_reset,
+	.eh_target_reset_handler	= mpi3mr_eh_target_reset,
+	.eh_host_reset_handler		= mpi3mr_eh_host_reset,
 	.bios_param			= mpi3mr_bios_param,
 	.map_queues			= mpi3mr_map_queues,
 	.no_write_same			= 1,
@@ -2628,6 +2974,7 @@ mpi3mr_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	mutex_init(&mrioc->reset_mutex);
 	mpi3mr_init_drv_cmd(&mrioc->init_cmds, MPI3MR_HOSTTAG_INITCMDS);
+	mpi3mr_init_drv_cmd(&mrioc->host_tm_cmds, MPI3MR_HOSTTAG_BLK_TMS);
 
 	for (i = 0; i < MPI3MR_NUM_DEVRMCMD; i++)
 		mpi3mr_init_drv_cmd(&mrioc->dev_rmhs_cmds[i],
-- 
2.18.1


--000000000000ac7e2c05c213392f
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
P3lSxcw4Cg90iKHqfpwLnGNc9AGXHMxUCukpnAHRlivljilKHMx1ymb180BLmtF+ZLm6KrFLQWzB
4KeiUOMtKM13wJrQubqTeZgB1XA+89jeLYlxagVsMyksdwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRprYXNoeWFwLmRlc2FpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUkTOZp9jXE3yPj4ieKeDT
OiNyCtswDQYJKoZIhvcNAQELBQADggEBABG1KCh7cLjStywh4S37nKE1eE8KPyAxDzQCkhxYLBVj
gnnhaLmEOayEucPAsM1hCRAm/vR3RQ27lMXBGveCHaq9RZkzTjGSbzr8adOGK3CluPrasNf5StX3
GSk4HwCapA39BDUrhnc/qG5vHwLrgA1jwAvSy8e/vn4F4h+KPrPoFNd1OnCafedbuiEXTqTkn5Rk
vZ2AOTcSbxvmyKBMb/iu1vn7AAoui0d8GYCPoz8shf2iWMSUXVYJAMrtRHVJr47J5jlopF5F2ghC
MzNfx6QsmJhYiRByd8L9sUOjp/DMgkC6H93PyYpYMiBGapgNf6UMsLg/1kx5DATNwhPAJbkxggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxwO04DXOeYbZtr
4mAwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIKZSNaG5hZBcIQomV2kItG7ochEx
UQCdOXGNaUSe1L8qMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIx
MDUxMTE5NTE1MVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQClpgIGG3oA2x90sLlf4msUwSKig8ZP9yXs2uoeHOD3G7mQ
SNMBosPgl6YQsjthB2gR1LaS8P4kVmnihgIG2LrxfS5uqnPH4Glk8t8HFWpXKm5vxvm8r9JRopFn
YxQ7JqJKWhhrsHnLRYGgXCRA9jPTTCGgaLL/agnRkMNzG1coqLAa/mgJH1fiZ+evFaV/rkK2npLP
oggn/mB9F5GHJoMchp/UY00Et2U/o6d4VVAUh/j9iPP623eBEZ15nYbmmISoNyVZkTCR/5xwvuGQ
/1kHYIOFFNBG/i7TaNACaA1RSS/OCOrrUoacHAw6+CtRNrQbuRu26uVaRB7KLlH0KIsh
--000000000000ac7e2c05c213392f--
