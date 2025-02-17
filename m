Return-Path: <linux-scsi+bounces-12226-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E36A334D9
	for <lists+linux-scsi@lfdr.de>; Thu, 13 Feb 2025 02:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD0503A6E3F
	for <lists+linux-scsi@lfdr.de>; Thu, 13 Feb 2025 01:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56E613792B;
	Thu, 13 Feb 2025 01:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OVQum+SR"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0CE80034
	for <linux-scsi@vger.kernel.org>; Thu, 13 Feb 2025 01:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739410827; cv=none; b=Sb3rSG746JevNevu7hJnMc56o4aYX3ChAjcAYOUXFKpDJUnw8l0mxooy5XxLDpKEhwfEAVm76YNOnQ655pBWrspQ+a2baJG55aS6njaQ6h0xx1GJLFrnWpNpijmnRkjuJ0tbAGFM/A1k6t8md5br66Vam+4KdUoLBkagrQmDrTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739410827; c=relaxed/simple;
	bh=aEQeP1/+onuX+PjWKbMsQB4H6vriAuogTu4pb8jYfaU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=DyZaxKRwv9fLKld8YNU68CgXfFGPPpao2sa5aeFQHdANVxciKcqQeBu4g2nBDRzD3dEzK9LddAEjjkMZxLChrj6/AKJoBQkROJGaYTlREDezv1Vr+sO7NSLmhdJuhRk91V4QUZeXlNA08ktcSto0b4ZRIquSwH/Yl+wggGo110w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OVQum+SR; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21f92258aa6so7126095ad.3
        for <linux-scsi@vger.kernel.org>; Wed, 12 Feb 2025 17:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739410824; x=1740015624; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=49f30FxjjBREp//5ApyBma9xdT6EjbQMWISR8FRoG74=;
        b=OVQum+SRaTPlgq8KH/gbFfoLxG6rdO+4Ek40uFLqp2JF7CWhcBwiZjqrETe21IHH6A
         bTEs5JntVusBwedO9A1NvOC6Rb2eqgTuavCKaeKNCdl05O5NGdLvYBWPQqLToX7kGP9D
         bxnoMXpXrxMM6RHN1b5zZOSYgZ9CCkLpgb944=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739410824; x=1740015624;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=49f30FxjjBREp//5ApyBma9xdT6EjbQMWISR8FRoG74=;
        b=MGbiN0o+u9eLrqr2e3F8J0LQgjXhLFaSIL5KggvbW1RyVTWtyNbVLM1/Nkiivz9Ej7
         Qtw7ICEYBXNbIoEBKFFMZoWFebkP716ZGTokpM1HGI5+jZLv4JIqEOK5CQ9cBlCpAnc0
         wgteixvlLRrIKEmaBhfL1ya6x0H0Gqg1KuakULwS0PaCbTYTSLa4pOztkosEqJgpHwWQ
         ZEcMF9dB4xH7av+YzN+VcT/qa8mM/xO6Jvj0e8OpyGUplyiEL2TOrle4mPJ7Zhn+wpig
         5AXpW+8/9YiPFwYcNBXmE/nK79pbn6FaL/8kYr7zS27ZpXM6gXqWoWKQo/DCqZ9zioy7
         4FsA==
X-Gm-Message-State: AOJu0YzFlhnOETdxsM1+x3ajtey12PKFqDXUro7+1OpV4sCEwfIxc/zY
	ur5Gt7QdnXL5SCt7H6qqc8r/9NYoEVgbPy7JWhvHimecE9WQWzbQuOJX8yulWMdVb7PzndKaQkd
	y+wczC1gObEt7MBUpS/4WM/lB+qjUqXYBuLM28EvQCOF2wAd4YP+/4lyeklkKujiFDap/ajU47q
	8Q6N3RcjmQ2S984yiQtEcoX0zJQ6U1DLnNcMDgFE+wGG7iAy+q/NFwnP3HrsPacOJB
X-Gm-Gg: ASbGncu6FLKAp9d/nGKxH0kjoSuUFHCQgfKpDFup5VOyAmD8GgOwSaxEdl0r86b0F38
	yPoyYFBzPmtnVLATghRgvSnhC2ZCEUMl2gO6a0/U7AKTBXLUAAU3dA3gKRRQF6ONxZ4FmrLjavv
	k+kNF7UQ9zoLkbaAu8VsxY9xHRzh4jaaL/xobw31/sOk7NhNOqqLe6BxkoZHM0OM+3kD+mc6WNo
	LqkHqvo+4BtaHeIcp/iCoTmEhiQyhRW80w9Ip4NjqoA3gAFcQZyyetxQFPTYQdKpj1Q9haTOji9
	jL69mgzXMn5qBzSPtdy89yOC547zzQwm5Pz6il4Jsueas90c5VLKnVryGR7CodKEEn/BTzBNg/F
	HlD+dySXL6kqu1AK6LRF/KJA=
X-Google-Smtp-Source: AGHT+IF351jzl8S26Xu8gS4HHE4XTyMQ4mg3cSmGWI8lKl2CD2m7j5E1EBFMfLUdrh4MTOGP/5b6Bw==
X-Received: by 2002:a05:6a21:3382:b0:1e1:afa9:d397 with SMTP id adf61e73a8af0-1ee5c74ccd3mr8673620637.15.1739410824468;
        Wed, 12 Feb 2025 17:40:24 -0800 (PST)
Received: from dhcp-135-24-192-142.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242761714sm106145b3a.133.2025.02.12.17.40.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Feb 2025 17:40:23 -0800 (PST)
From: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
To: linux-scsi@vger.kernel.org,
	martin.petersen@oracle.com
Cc: sathya.prakash@broadcom.com,
	ranjan.kumar@broadcom.com,
	suganath-prabu.subramani@broadcom.com,
	sumit.saxena@broadcom.com,
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Subject: [PATCH 2/5] mpt3sas: Add support for MCTP Passthrough commands
Date: Wed, 12 Feb 2025 17:26:53 -0800
Message-Id: <1739410016-27503-3-git-send-email-shivasharan.srikanteshwara@broadcom.com>
X-Mailer: git-send-email 2.4.3
In-Reply-To: <1739410016-27503-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
References: <1739410016-27503-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>

The MPI specification defines support for sending MCTP management commands
as a passthrough function to the IOC.
This patch adds support for driver to discover the IOC capability to
support MCTP passthrough function. Driver will support applications and
kernel modules to send MPT commands containing the MCTP passthrough request
to firmware through an MPI request.

Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Signed-off-by: Sathya Prakash <sathya.prakash@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c |  11 ++
 drivers/scsi/mpt3sas/mpt3sas_ctl.c  | 265 ++++++++++++++++++++++++++++
 drivers/scsi/mpt3sas/mpt3sas_ctl.h  |  42 +++++
 3 files changed, 318 insertions(+)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index dc43cfa83088..f0e8139654b5 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -1202,6 +1202,11 @@ _base_sas_ioc_info(struct MPT3SAS_ADAPTER *ioc, MPI2DefaultReply_t *mpi_reply,
 		    ioc->sge_size;
 		func_str = "nvme_encapsulated";
 		break;
+	case MPI2_FUNCTION_MCTP_PASSTHROUGH:
+		frame_sz = sizeof(Mpi26MctpPassthroughRequest_t) +
+		    ioc->sge_size;
+		func_str = "mctp_passthru";
+		break;
 	default:
 		frame_sz = 32;
 		func_str = "unknown";
@@ -4874,6 +4879,12 @@ _base_display_ioc_capabilities(struct MPT3SAS_ADAPTER *ioc)
 		i++;
 	}
 
+	if (ioc->facts.IOCCapabilities &
+	    MPI26_IOCFACTS_CAPABILITY_MCTP_PASSTHRU) {
+		pr_cont("%sMCTP Passthru", i ? "," : "");
+		i++;
+	}
+
 	iounit_pg1_flags = le32_to_cpu(ioc->iounit_pg1.Flags);
 	if (!(iounit_pg1_flags & MPI2_IOUNITPAGE1_NATIVE_COMMAND_Q_DISABLE)) {
 		pr_cont("%sNCQ", i ? "," : "");
diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
index 87784c96249a..54a8a9c3ce5f 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
@@ -186,6 +186,9 @@ _ctl_display_some_debug(struct MPT3SAS_ADAPTER *ioc, u16 smid,
 	case MPI2_FUNCTION_NVME_ENCAPSULATED:
 		desc = "nvme_encapsulated";
 		break;
+	case MPI2_FUNCTION_MCTP_PASSTHROUGH:
+		desc = "mctp_passthrough";
+		break;
 	}
 
 	if (!desc)
@@ -652,6 +655,40 @@ _ctl_set_task_mid(struct MPT3SAS_ADAPTER *ioc, struct mpt3_ioctl_command *karg,
 	return 0;
 }
 
+/**
+ * _ctl_send_mctp_passthru_req - Send an MCTP passthru request
+ * @ioc: per adapter object
+ * @mctp_passthru_req: MPI mctp passhthru request from caller
+ * @psge: pointer to the H2DSGL
+ * @data_out_dma: DMA buffer for H2D SGL
+ * @data_out_sz: H2D length
+ * @data_in_dma: DMA buffer for D2H SGL
+ * @data_in_sz: D2H length
+ * @smid: SMID to submit the request
+ *
+ */
+static void
+_ctl_send_mctp_passthru_req(
+	struct MPT3SAS_ADAPTER *ioc,
+	Mpi26MctpPassthroughRequest_t *mctp_passthru_req, void *psge,
+	dma_addr_t data_out_dma, int data_out_sz,
+	dma_addr_t data_in_dma, int data_in_sz,
+	u16 smid)
+{
+	mctp_passthru_req->H2DLength = data_out_sz;
+	mctp_passthru_req->D2HLength = data_in_sz;
+
+	/* Build the H2D SGL from the data out buffer */
+	ioc->build_sg(ioc, psge, data_out_dma, data_out_sz, 0, 0);
+
+	psge += ioc->sge_size_ieee;
+
+	/* Build the D2H SGL for the data in buffer*/
+	ioc->build_sg(ioc, psge, 0, 0, data_in_dma, data_in_sz);
+
+	ioc->put_smid_default(ioc, smid);
+}
+
 /**
  * _ctl_do_mpt_command - main handler for MPT3COMMAND opcode
  * @ioc: per adapter object
@@ -792,6 +829,23 @@ _ctl_do_mpt_command(struct MPT3SAS_ADAPTER *ioc, struct mpt3_ioctl_command karg,
 
 	init_completion(&ioc->ctl_cmds.done);
 	switch (mpi_request->Function) {
+	case MPI2_FUNCTION_MCTP_PASSTHROUGH:
+	{
+		Mpi26MctpPassthroughRequest_t *mctp_passthru_req =
+						(Mpi26MctpPassthroughRequest_t *)request;
+
+		if (!(ioc->facts.IOCCapabilities & MPI26_IOCFACTS_CAPABILITY_MCTP_PASSTHRU)) {
+			ioc_err(ioc, "%s: MCTP Passthrough request not supported\n",
+				__func__);
+			mpt3sas_base_free_smid(ioc, smid);
+			ret = -EINVAL;
+			goto out;
+		}
+
+		_ctl_send_mctp_passthru_req(ioc, mctp_passthru_req, psge, data_out_dma,
+					data_out_sz, data_in_dma, data_in_sz, smid);
+		break;
+	}
 	case MPI2_FUNCTION_NVME_ENCAPSULATED:
 	{
 		nvme_encap_request = (Mpi26NVMeEncapsulatedRequest_t *)request;
@@ -2786,6 +2840,217 @@ _ctl_ioctl_main(struct file *file, unsigned int cmd, void __user *arg,
 	return ret;
 }
 
+/**
+ * _ctl_get_mpt_mctp_passthru_adapter - Traverse the IOC list and return the IOC at
+ *					dev_index positionthat support MCTP passhtru
+ * @dev_index: position in the mpt3sas_ioc_list to search for
+ * Return pointer to the IOC on success
+ *	  NULL if device not found error
+ */
+static struct MPT3SAS_ADAPTER *
+_ctl_get_mpt_mctp_passthru_adapter(int dev_index)
+{
+	struct MPT3SAS_ADAPTER *ioc = NULL;
+	int count = 0;
+
+	spin_lock(&gioc_lock);
+	/* Traverse ioc list and return number of IOC that support MCTP passthru */
+	list_for_each_entry(ioc, &mpt3sas_ioc_list, list) {
+		if (ioc->facts.IOCCapabilities & MPI26_IOCFACTS_CAPABILITY_MCTP_PASSTHRU) {
+			if (count == dev_index) {
+				spin_unlock(&gioc_lock);
+				return 0;
+			}
+		}
+	}
+	spin_unlock(&gioc_lock);
+
+	return NULL;
+}
+
+/**
+ * mpt3sas_get_device_count - Retrieve the count of MCTP passthrough
+ *				capable devices managed by the driver.
+ *
+ * Returns number of devices that support MCTP passthrough.
+ */
+int
+mpt3sas_get_device_count(void)
+{
+	int count = 0;
+	struct MPT3SAS_ADAPTER *ioc = NULL;
+
+	spin_lock(&gioc_lock);
+	/* Traverse ioc list and return number of IOC that support MCTP passthru */
+	list_for_each_entry(ioc, &mpt3sas_ioc_list, list)
+		if (ioc->facts.IOCCapabilities & MPI26_IOCFACTS_CAPABILITY_MCTP_PASSTHRU)
+			count++;
+
+	spin_unlock(&gioc_lock);
+
+	return count;
+}
+EXPORT_SYMBOL(mpt3sas_get_device_count);
+
+/**
+ * mpt3sas_send_passthru_cmd - Send an MPI MCTP passthrough command to
+ *				firmware
+ * @command: The MPI MCTP passthrough command to send to firmware
+ *
+ * Returns 0 on success, anything else is error.
+ */
+int mpt3sas_send_mctp_passthru_req(struct mpt3_passthru_command *command)
+{
+	struct MPT3SAS_ADAPTER *ioc;
+	MPI2RequestHeader_t *mpi_request = NULL, *request;
+	MPI2DefaultReply_t *mpi_reply;
+	Mpi26MctpPassthroughRequest_t *mctp_passthru_req;
+	u16 smid;
+	unsigned long timeout;
+	u8 issue_reset = 0;
+	u32 sz;
+	void *psge;
+	void *data_out = NULL;
+	dma_addr_t data_out_dma = 0;
+	size_t data_out_sz = 0;
+	void *data_in = NULL;
+	dma_addr_t data_in_dma = 0;
+	size_t data_in_sz = 0;
+	long ret;
+
+	/* Retrieve ioc from dev_index */
+	ioc = _ctl_get_mpt_mctp_passthru_adapter(command->dev_index);
+	if (!ioc)
+		return -ENODEV;
+
+	mutex_lock(&ioc->pci_access_mutex);
+	if (ioc->shost_recovery ||
+	    ioc->pci_error_recovery || ioc->is_driver_loading ||
+	    ioc->remove_host) {
+		ret = -EAGAIN;
+		goto unlock_pci_access;
+	}
+
+	/* Lock the ctl_cmds mutex to ensure a single ctl cmd is pending */
+	if (mutex_lock_interruptible(&ioc->ctl_cmds.mutex)) {
+		ret = -ERESTARTSYS;
+		goto unlock_pci_access;
+	}
+
+	if (ioc->ctl_cmds.status != MPT3_CMD_NOT_USED) {
+		ioc_err(ioc, "%s: ctl_cmd in use\n", __func__);
+		ret = -EAGAIN;
+		goto unlock_ctl_cmds;
+	}
+
+	ret = mpt3sas_wait_for_ioc(ioc,	IOC_OPERATIONAL_WAIT_COUNT);
+	if (ret)
+		goto unlock_ctl_cmds;
+
+	mpi_request = (MPI2RequestHeader_t *)command->mpi_request;
+	if (mpi_request->Function != MPI2_FUNCTION_MCTP_PASSTHROUGH) {
+		ioc_err(ioc, "%s: Invalid request receveid, Function 0x%x\n",
+			__func__, mpi_request->Function);
+		ret = -EINVAL;
+		goto unlock_ctl_cmds;
+	}
+
+	/* Use first reserved smid for passthrough commands */
+	smid = ioc->scsiio_depth - INTERNAL_SCSIIO_CMDS_COUNT + 1;
+	ret = 0;
+	ioc->ctl_cmds.status = MPT3_CMD_PENDING;
+	memset(ioc->ctl_cmds.reply, 0, ioc->reply_sz);
+	request = mpt3sas_base_get_msg_frame(ioc, smid);
+	memset(request, 0, ioc->request_sz);
+	memcpy(request, command->mpi_request, sizeof(Mpi26MctpPassthroughRequest_t));
+	ioc->ctl_cmds.smid = smid;
+	data_out_sz = command->data_out_size;
+	data_in_sz = command->data_in_size;
+
+	/* obtain dma-able memory for data transfer */
+	if (data_out_sz) /* WRITE */ {
+		data_out = dma_alloc_coherent(&ioc->pdev->dev, data_out_sz,
+					      &data_out_dma, GFP_ATOMIC);
+		if (!data_out) {
+			ret = -ENOMEM;
+			mpt3sas_base_free_smid(ioc, smid);
+			goto out;
+		}
+		memcpy(data_out, command->data_out_buf_ptr, data_out_sz);
+
+	}
+
+	if (data_in_sz) /* READ */ {
+		data_in = dma_alloc_coherent(&ioc->pdev->dev, data_in_sz,
+					     &data_in_dma, GFP_ATOMIC);
+		if (!data_in) {
+			ret = -ENOMEM;
+			mpt3sas_base_free_smid(ioc, smid);
+			goto out;
+		}
+	}
+
+	psge = &((Mpi26MctpPassthroughRequest_t *)request)->H2DSGL;
+
+	init_completion(&ioc->ctl_cmds.done);
+
+	mctp_passthru_req = (Mpi26MctpPassthroughRequest_t *)request;
+
+	_ctl_send_mctp_passthru_req(ioc, mctp_passthru_req, psge, data_out_dma,
+				data_out_sz, data_in_dma, data_in_sz, smid);
+
+	timeout = command->timeout;
+	if (timeout < MPT3_IOCTL_DEFAULT_TIMEOUT)
+		timeout = MPT3_IOCTL_DEFAULT_TIMEOUT;
+
+	wait_for_completion_timeout(&ioc->ctl_cmds.done, timeout*HZ);
+	if (!(ioc->ctl_cmds.status & MPT3_CMD_COMPLETE)) {
+		mpt3sas_check_cmd_timeout(ioc,
+		    ioc->ctl_cmds.status, mpi_request,
+		    sizeof(Mpi26MctpPassthroughRequest_t), issue_reset);
+		goto issue_host_reset;
+	}
+
+	mpi_reply = ioc->ctl_cmds.reply;
+
+	/* copy out xdata to user */
+	if (data_in_sz)
+		memcpy(command->data_in_buf_ptr, data_in, data_in_sz);
+
+	/* copy out reply message frame to user */
+	if (command->max_reply_bytes) {
+		sz = min_t(u32, command->max_reply_bytes, ioc->reply_sz);
+		memcpy(command->reply_frame_buf_ptr, ioc->ctl_cmds.reply, sz);
+	}
+
+issue_host_reset:
+	if (issue_reset) {
+		ret = -ENODATA;
+		mpt3sas_base_hard_reset_handler(ioc, FORCE_BIG_HAMMER);
+	}
+
+out:
+	/* free memory associated with sg buffers */
+	if (data_in)
+		dma_free_coherent(&ioc->pdev->dev, data_in_sz, data_in,
+		    data_in_dma);
+
+	if (data_out)
+		dma_free_coherent(&ioc->pdev->dev, data_out_sz, data_out,
+		    data_out_dma);
+
+	ioc->ctl_cmds.status = MPT3_CMD_NOT_USED;
+
+unlock_ctl_cmds:
+	mutex_unlock(&ioc->ctl_cmds.mutex);
+
+unlock_pci_access:
+	mutex_unlock(&ioc->pci_access_mutex);
+	return ret;
+
+}
+EXPORT_SYMBOL(mpt3sas_send_mctp_passthru_req);
+
 /**
  * _ctl_ioctl - mpt3ctl main ioctl entry point (unlocked)
  * @file: (struct file)
diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.h b/drivers/scsi/mpt3sas/mpt3sas_ctl.h
index 171709e91006..6bc1fffb7a33 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_ctl.h
+++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.h
@@ -458,4 +458,46 @@ struct mpt3_enable_diag_sbr_reload {
 	struct mpt3_ioctl_header hdr;
 };
 
+/**
+ * struct mpt3_passthru_command - generic mpt firmware passthru command
+ * @dev_index - device index
+ * @timeout - command timeout in seconds. (if zero then use driver default
+ *  value).
+ * @reply_frame_buf_ptr - MPI reply location
+ * @data_in_buf_ptr - destination for read
+ * @data_out_buf_ptr - data source for write
+ * @max_reply_bytes - maximum number of reply bytes to be sent to app.
+ * @data_in_size - number bytes for data transfer in (read)
+ * @data_out_size - number bytes for data transfer out (write)
+ * @mpi_request - request frame
+ */
+struct mpt3_passthru_command {
+	u8 dev_index;
+	uint32_t timeout;
+	void *reply_frame_buf_ptr;
+	void *data_in_buf_ptr;
+	void *data_out_buf_ptr;
+	uint32_t max_reply_bytes;
+	uint32_t data_in_size;
+	uint32_t data_out_size;
+	Mpi26MctpPassthroughRequest_t *mpi_request;
+};
+
+/*
+ * mpt3sas_get_device_count - Retrieve the count of MCTP passthrough
+ *			      capable devices managed by the driver.
+ *
+ * Returns number of devices that support MCTP passthrough.
+ */
+int mpt3sas_get_device_count(void);
+
+/*
+ * mpt3sas_send_passthru_cmd - Send an MPI MCTP passthrough command to
+ *			       firmware
+ * @command: The MPI MCTP passthrough command to send to firmware
+ *
+ * Returns 0 on success, anything else is error .
+ */
+int mpt3sas_send_mctp_passthru_req(struct mpt3_passthru_command *command);
+
 #endif /* MPT3SAS_CTL_H_INCLUDED */
-- 
2.43.0


