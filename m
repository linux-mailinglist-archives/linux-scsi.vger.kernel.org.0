Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED6B23146
	for <lists+linux-scsi@lfdr.de>; Mon, 20 May 2019 12:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731000AbfETK00 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 20 May 2019 06:26:26 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43481 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbfETK00 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 20 May 2019 06:26:26 -0400
Received: by mail-pl1-f195.google.com with SMTP id gn7so2357430plb.10
        for <linux-scsi@vger.kernel.org>; Mon, 20 May 2019 03:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hc34eQzKOyUc3FMMgoIwpKaD/Z7DRDS45pfT7gVe6rw=;
        b=NOX+iMhu36+GhBU86NH1t2bOq5B4rzANeBVCFyBEOdegWKlaj1NlhO/02RtY8u9Qxc
         9ps6gFApbFQQqz7cOi3N2c5G3QUkQ+1jkSRSca1cI+yW3QEOMMBxuIIKPdeYVs5cZV5L
         Rv49KDdBanEGoOHiauUWg2oz4UgddG2JhCH+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hc34eQzKOyUc3FMMgoIwpKaD/Z7DRDS45pfT7gVe6rw=;
        b=b/fsnV2Hym8zvJGkEC/jG5/SFo2mCX9kmrp8cmx5bWmxMHS62ea/wEDT0ICSugOGfU
         P3HagNpwnJBqxtkpguNW7jUJQzyqmxbrrwC1wuPYZvi0UgacNRa4VUu1zweL/cg7HyXC
         ZzbmGwj8rzq1p3tov8htKoICIh3D7TPy2jXUigVPfJgRao/KU5F566P7n9V7LCeSThzk
         eTgJKNiFf003pQ2ECh1TVTO716h4YCvQaflDpylXvmiWVRJsaeSGoEVCvjOi3mgBKKdT
         Bai009jybvLi51bj5/sP6yqvWbwaTblGHvwA2KNduH9VCcCIh2GEsFBpeymHJqlYBE4Q
         hSNg==
X-Gm-Message-State: APjAAAW5dEYGekr/Yzo6GDKnMt53T4Vyyde8lnPP5UABE324WuRKGCDB
        vJf7kBNj5euJFAwjuAekI1IyiUU/9r9X7yFpMy66U7fn7Bx/KYmlOYwr+ACJLQocjZtv7v/FKKD
        QSjFKx1LV2c257Uh3y1yLzX26OZZojEn3M3M1AoAxpbMJh9teuIRsTtqAZLy5Zp6J1KE3oN6qZq
        It2Fm7mNHVuMrU/o497Q==
X-Google-Smtp-Source: APXvYqwsWS7n5bs+Zu0zgPFWoIUMbx5rvHduGr7EPmpRjX6xV3fkdFb/Yrh7zbuELWhJM6KinwUYgg==
X-Received: by 2002:a17:902:c01:: with SMTP id 1mr36319264pls.142.1558347984932;
        Mon, 20 May 2019 03:26:24 -0700 (PDT)
Received: from dhcp-10-123-20-26.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id j2sm15757309pfb.157.2019.05.20.03.26.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 03:26:24 -0700 (PDT)
From:   Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     suganath-prabu.subramani@broadcom.com, Sathya.Prakash@broadcom.com,
        sreekanth.reddy@broadcom.com
Subject: [PATCH v2 01/10] mpt3sas: function pointers of request descriptor
Date:   Mon, 20 May 2019 06:25:55 -0400
Message-Id: <20190520102604.3466-2-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20190520102604.3466-1-suganath-prabu.subramani@broadcom.com>
References: <20190520102604.3466-1-suganath-prabu.subramani@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Suganath Prabu <suganath-prabu.subramani@broadcom.com>

This code refactoring introduces function pointers.

Host uses Request Descriptors of different types for posting an entry
onto a request queue. Based on controller type and capabilities,
host can also use atomic descriptors other than normal
descriptors.
Using function pointer will avoid if-else statements

Signed-off-by: Suganath Prabu <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c      | 38 ++++++++++++++++++--------------
 drivers/scsi/mpt3sas/mpt3sas_base.h      |  3 +++
 drivers/scsi/mpt3sas/mpt3sas_config.c    |  2 +-
 drivers/scsi/mpt3sas/mpt3sas_ctl.c       | 20 ++++++++---------
 drivers/scsi/mpt3sas/mpt3sas_scsih.c     | 20 ++++++++---------
 drivers/scsi/mpt3sas/mpt3sas_transport.c |  8 +++----
 6 files changed, 49 insertions(+), 42 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 05c0a1b..95f831e 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -1282,7 +1282,7 @@ _base_async_event(struct MPT3SAS_ADAPTER *ioc, u8 msix_index, u32 reply)
 	ack_request->EventContext = mpi_reply->EventContext;
 	ack_request->VF_ID = 0;  /* TODO */
 	ack_request->VP_ID = 0;
-	mpt3sas_base_put_smid_default(ioc, smid);
+	ioc->put_smid_default(ioc, smid);
 
  out:
 
@@ -3486,7 +3486,8 @@ _base_writeq(__u64 b, volatile void __iomem *addr, spinlock_t *writeq_lock)
  * @handle: device handle
  */
 static void
-_base_put_smid_mpi_ep_scsi_io(struct MPT3SAS_ADAPTER *ioc, u16 smid, u16 handle)
+_base_put_smid_mpi_ep_scsi_io(struct MPT3SAS_ADAPTER *ioc,
+	u16 smid, u16 handle)
 {
 	Mpi2RequestDescriptorUnion_t descriptor;
 	u64 *request = (u64 *)&descriptor;
@@ -3530,13 +3531,13 @@ _base_put_smid_scsi_io(struct MPT3SAS_ADAPTER *ioc, u16 smid, u16 handle)
 }
 
 /**
- * mpt3sas_base_put_smid_fast_path - send fast path request to firmware
+ * _base_put_smid_fast_path - send fast path request to firmware
  * @ioc: per adapter object
  * @smid: system request message index
  * @handle: device handle
  */
-void
-mpt3sas_base_put_smid_fast_path(struct MPT3SAS_ADAPTER *ioc, u16 smid,
+static void
+_base_put_smid_fast_path(struct MPT3SAS_ADAPTER *ioc, u16 smid,
 	u16 handle)
 {
 	Mpi2RequestDescriptorUnion_t descriptor;
@@ -3553,13 +3554,13 @@ mpt3sas_base_put_smid_fast_path(struct MPT3SAS_ADAPTER *ioc, u16 smid,
 }
 
 /**
- * mpt3sas_base_put_smid_hi_priority - send Task Management request to firmware
+ * _base_put_smid_hi_priority - send Task Management request to firmware
  * @ioc: per adapter object
  * @smid: system request message index
  * @msix_task: msix_task will be same as msix of IO incase of task abort else 0.
  */
-void
-mpt3sas_base_put_smid_hi_priority(struct MPT3SAS_ADAPTER *ioc, u16 smid,
+static void
+_base_put_smid_hi_priority(struct MPT3SAS_ADAPTER *ioc, u16 smid,
 	u16 msix_task)
 {
 	Mpi2RequestDescriptorUnion_t descriptor;
@@ -3617,12 +3618,12 @@ mpt3sas_base_put_smid_nvme_encap(struct MPT3SAS_ADAPTER *ioc, u16 smid)
 }
 
 /**
- * mpt3sas_base_put_smid_default - Default, primarily used for config pages
+ * _base_put_smid_default - Default, primarily used for config pages
  * @ioc: per adapter object
  * @smid: system request message index
  */
-void
-mpt3sas_base_put_smid_default(struct MPT3SAS_ADAPTER *ioc, u16 smid)
+static void
+_base_put_smid_default(struct MPT3SAS_ADAPTER *ioc, u16 smid)
 {
 	Mpi2RequestDescriptorUnion_t descriptor;
 	void *mpi_req_iomem;
@@ -3953,7 +3954,7 @@ _base_display_fwpkg_version(struct MPT3SAS_ADAPTER *ioc)
 	ioc->build_sg(ioc, &mpi_request->SGL, 0, 0, fwpkg_data_dma,
 			data_length);
 	init_completion(&ioc->base_cmds.done);
-	mpt3sas_base_put_smid_default(ioc, smid);
+	ioc->put_smid_default(ioc, smid);
 	/* Wait for 15 seconds */
 	wait_for_completion_timeout(&ioc->base_cmds.done,
 			FW_IMG_HDR_READ_TIMEOUT*HZ);
@@ -5432,7 +5433,7 @@ mpt3sas_base_sas_iounit_control(struct MPT3SAS_ADAPTER *ioc,
 	    mpi_request->Operation == MPI2_SAS_OP_PHY_LINK_RESET)
 		ioc->ioc_link_reset_in_progress = 1;
 	init_completion(&ioc->base_cmds.done);
-	mpt3sas_base_put_smid_default(ioc, smid);
+	ioc->put_smid_default(ioc, smid);
 	wait_for_completion_timeout(&ioc->base_cmds.done,
 	    msecs_to_jiffies(10000));
 	if ((mpi_request->Operation == MPI2_SAS_OP_PHY_HARD_RESET ||
@@ -5511,7 +5512,7 @@ mpt3sas_base_scsi_enclosure_processor(struct MPT3SAS_ADAPTER *ioc,
 	ioc->base_cmds.smid = smid;
 	memcpy(request, mpi_request, sizeof(Mpi2SepReply_t));
 	init_completion(&ioc->base_cmds.done);
-	mpt3sas_base_put_smid_default(ioc, smid);
+	ioc->put_smid_default(ioc, smid);
 	wait_for_completion_timeout(&ioc->base_cmds.done,
 	    msecs_to_jiffies(10000));
 	if (!(ioc->base_cmds.status & MPT3_CMD_COMPLETE)) {
@@ -5915,7 +5916,7 @@ _base_send_port_enable(struct MPT3SAS_ADAPTER *ioc)
 	mpi_request->Function = MPI2_FUNCTION_PORT_ENABLE;
 
 	init_completion(&ioc->port_enable_cmds.done);
-	mpt3sas_base_put_smid_default(ioc, smid);
+	ioc->put_smid_default(ioc, smid);
 	wait_for_completion_timeout(&ioc->port_enable_cmds.done, 300*HZ);
 	if (!(ioc->port_enable_cmds.status & MPT3_CMD_COMPLETE)) {
 		ioc_err(ioc, "%s: timeout\n", __func__);
@@ -5974,7 +5975,7 @@ mpt3sas_port_enable(struct MPT3SAS_ADAPTER *ioc)
 	memset(mpi_request, 0, sizeof(Mpi2PortEnableRequest_t));
 	mpi_request->Function = MPI2_FUNCTION_PORT_ENABLE;
 
-	mpt3sas_base_put_smid_default(ioc, smid);
+	ioc->put_smid_default(ioc, smid);
 	return 0;
 }
 
@@ -6090,7 +6091,7 @@ _base_event_notification(struct MPT3SAS_ADAPTER *ioc)
 		mpi_request->EventMasks[i] =
 		    cpu_to_le32(ioc->event_masks[i]);
 	init_completion(&ioc->base_cmds.done);
-	mpt3sas_base_put_smid_default(ioc, smid);
+	ioc->put_smid_default(ioc, smid);
 	wait_for_completion_timeout(&ioc->base_cmds.done, 30*HZ);
 	if (!(ioc->base_cmds.status & MPT3_CMD_COMPLETE)) {
 		ioc_err(ioc, "%s: timeout\n", __func__);
@@ -6588,6 +6589,9 @@ mpt3sas_base_attach(struct MPT3SAS_ADAPTER *ioc)
 		break;
 	}
 
+	ioc->put_smid_default = &_base_put_smid_default;
+	ioc->put_smid_fast_path = &_base_put_smid_fast_path;
+	ioc->put_smid_hi_priority = &_base_put_smid_hi_priority;
 	if (ioc->is_mcpu_endpoint)
 		ioc->put_smid_scsi_io = &_base_put_smid_mpi_ep_scsi_io;
 	else
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.h b/drivers/scsi/mpt3sas/mpt3sas_base.h
index 480219f..d3f3c37 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.h
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.h
@@ -1422,6 +1422,9 @@ struct MPT3SAS_ADAPTER {
 	u8		is_gen35_ioc;
 	u8		is_aero_ioc;
 	PUT_SMID_IO_FP_HIP put_smid_scsi_io;
+	PUT_SMID_IO_FP_HIP put_smid_fast_path;
+	PUT_SMID_IO_FP_HIP put_smid_hi_priority;
+	PUT_SMID_DEFAULT put_smid_default;
 
 };
 
diff --git a/drivers/scsi/mpt3sas/mpt3sas_config.c b/drivers/scsi/mpt3sas/mpt3sas_config.c
index fb0a172..b18cbbc 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_config.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_config.c
@@ -380,7 +380,7 @@ _config_request(struct MPT3SAS_ADAPTER *ioc, Mpi2ConfigRequest_t
 	memcpy(config_request, mpi_request, sizeof(Mpi2ConfigRequest_t));
 	_config_display_some_debug(ioc, smid, "config_request", NULL);
 	init_completion(&ioc->config_cmds.done);
-	mpt3sas_base_put_smid_default(ioc, smid);
+	ioc->put_smid_default(ioc, smid);
 	wait_for_completion_timeout(&ioc->config_cmds.done, timeout*HZ);
 	if (!(ioc->config_cmds.status & MPT3_CMD_COMPLETE)) {
 		mpt3sas_base_check_cmd_timeout(ioc,
diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
index b2bb47c..bb16357 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
@@ -822,7 +822,7 @@ _ctl_do_mpt_command(struct MPT3SAS_ADAPTER *ioc, struct mpt3_ioctl_command karg,
 		if (mpi_request->Function == MPI2_FUNCTION_SCSI_IO_REQUEST)
 			ioc->put_smid_scsi_io(ioc, smid, device_handle);
 		else
-			mpt3sas_base_put_smid_default(ioc, smid);
+			ioc->put_smid_default(ioc, smid);
 		break;
 	}
 	case MPI2_FUNCTION_SCSI_TASK_MGMT:
@@ -859,7 +859,7 @@ _ctl_do_mpt_command(struct MPT3SAS_ADAPTER *ioc, struct mpt3_ioctl_command karg,
 		    tm_request->DevHandle));
 		ioc->build_sg_mpi(ioc, psge, data_out_dma, data_out_sz,
 		    data_in_dma, data_in_sz);
-		mpt3sas_base_put_smid_hi_priority(ioc, smid, 0);
+		ioc->put_smid_hi_priority(ioc, smid, 0);
 		break;
 	}
 	case MPI2_FUNCTION_SMP_PASSTHROUGH:
@@ -890,7 +890,7 @@ _ctl_do_mpt_command(struct MPT3SAS_ADAPTER *ioc, struct mpt3_ioctl_command karg,
 		}
 		ioc->build_sg(ioc, psge, data_out_dma, data_out_sz, data_in_dma,
 		    data_in_sz);
-		mpt3sas_base_put_smid_default(ioc, smid);
+		ioc->put_smid_default(ioc, smid);
 		break;
 	}
 	case MPI2_FUNCTION_SATA_PASSTHROUGH:
@@ -905,7 +905,7 @@ _ctl_do_mpt_command(struct MPT3SAS_ADAPTER *ioc, struct mpt3_ioctl_command karg,
 		}
 		ioc->build_sg(ioc, psge, data_out_dma, data_out_sz, data_in_dma,
 		    data_in_sz);
-		mpt3sas_base_put_smid_default(ioc, smid);
+		ioc->put_smid_default(ioc, smid);
 		break;
 	}
 	case MPI2_FUNCTION_FW_DOWNLOAD:
@@ -913,7 +913,7 @@ _ctl_do_mpt_command(struct MPT3SAS_ADAPTER *ioc, struct mpt3_ioctl_command karg,
 	{
 		ioc->build_sg(ioc, psge, data_out_dma, data_out_sz, data_in_dma,
 		    data_in_sz);
-		mpt3sas_base_put_smid_default(ioc, smid);
+		ioc->put_smid_default(ioc, smid);
 		break;
 	}
 	case MPI2_FUNCTION_TOOLBOX:
@@ -928,7 +928,7 @@ _ctl_do_mpt_command(struct MPT3SAS_ADAPTER *ioc, struct mpt3_ioctl_command karg,
 			ioc->build_sg_mpi(ioc, psge, data_out_dma, data_out_sz,
 				data_in_dma, data_in_sz);
 		}
-		mpt3sas_base_put_smid_default(ioc, smid);
+		ioc->put_smid_default(ioc, smid);
 		break;
 	}
 	case MPI2_FUNCTION_SAS_IO_UNIT_CONTROL:
@@ -948,7 +948,7 @@ _ctl_do_mpt_command(struct MPT3SAS_ADAPTER *ioc, struct mpt3_ioctl_command karg,
 	default:
 		ioc->build_sg_mpi(ioc, psge, data_out_dma, data_out_sz,
 		    data_in_dma, data_in_sz);
-		mpt3sas_base_put_smid_default(ioc, smid);
+		ioc->put_smid_default(ioc, smid);
 		break;
 	}
 
@@ -1576,7 +1576,7 @@ _ctl_diag_register_2(struct MPT3SAS_ADAPTER *ioc,
 			cpu_to_le32(ioc->product_specific[buffer_type][i]);
 
 	init_completion(&ioc->ctl_cmds.done);
-	mpt3sas_base_put_smid_default(ioc, smid);
+	ioc->put_smid_default(ioc, smid);
 	wait_for_completion_timeout(&ioc->ctl_cmds.done,
 	    MPT3_IOCTL_DEFAULT_TIMEOUT*HZ);
 
@@ -1903,7 +1903,7 @@ mpt3sas_send_diag_release(struct MPT3SAS_ADAPTER *ioc, u8 buffer_type,
 	mpi_request->VP_ID = 0;
 
 	init_completion(&ioc->ctl_cmds.done);
-	mpt3sas_base_put_smid_default(ioc, smid);
+	ioc->put_smid_default(ioc, smid);
 	wait_for_completion_timeout(&ioc->ctl_cmds.done,
 	    MPT3_IOCTL_DEFAULT_TIMEOUT*HZ);
 
@@ -2151,7 +2151,7 @@ _ctl_diag_read_buffer(struct MPT3SAS_ADAPTER *ioc, void __user *arg)
 	mpi_request->VP_ID = 0;
 
 	init_completion(&ioc->ctl_cmds.done);
-	mpt3sas_base_put_smid_default(ioc, smid);
+	ioc->put_smid_default(ioc, smid);
 	wait_for_completion_timeout(&ioc->ctl_cmds.done,
 	    MPT3_IOCTL_DEFAULT_TIMEOUT*HZ);
 
diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 1ccfbc7..1008c5e 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -2685,7 +2685,7 @@ mpt3sas_scsih_issue_tm(struct MPT3SAS_ADAPTER *ioc, u16 handle, u64 lun,
 	int_to_scsilun(lun, (struct scsi_lun *)mpi_request->LUN);
 	mpt3sas_scsih_set_tm_flag(ioc, handle);
 	init_completion(&ioc->tm_cmds.done);
-	mpt3sas_base_put_smid_hi_priority(ioc, smid, msix_task);
+	ioc->put_smid_hi_priority(ioc, smid, msix_task);
 	wait_for_completion_timeout(&ioc->tm_cmds.done, timeout*HZ);
 	if (!(ioc->tm_cmds.status & MPT3_CMD_COMPLETE)) {
 		if (mpt3sas_base_check_cmd_timeout(ioc,
@@ -3659,7 +3659,7 @@ _scsih_tm_tr_send(struct MPT3SAS_ADAPTER *ioc, u16 handle)
 	mpi_request->TaskType = MPI2_SCSITASKMGMT_TASKTYPE_TARGET_RESET;
 	mpi_request->MsgFlags = tr_method;
 	set_bit(handle, ioc->device_remove_in_progress);
-	mpt3sas_base_put_smid_hi_priority(ioc, smid, 0);
+	ioc->put_smid_hi_priority(ioc, smid, 0);
 	mpt3sas_trigger_master(ioc, MASTER_TRIGGER_DEVICE_REMOVAL);
 
 out:
@@ -3755,7 +3755,7 @@ _scsih_tm_tr_complete(struct MPT3SAS_ADAPTER *ioc, u16 smid, u8 msix_index,
 	mpi_request->Function = MPI2_FUNCTION_SAS_IO_UNIT_CONTROL;
 	mpi_request->Operation = MPI2_SAS_OP_REMOVE_DEVICE;
 	mpi_request->DevHandle = mpi_request_tm->DevHandle;
-	mpt3sas_base_put_smid_default(ioc, smid_sas_ctrl);
+	ioc->put_smid_default(ioc, smid_sas_ctrl);
 
 	return _scsih_check_for_pending_tm(ioc, smid);
 }
@@ -3881,7 +3881,7 @@ _scsih_tm_tr_volume_send(struct MPT3SAS_ADAPTER *ioc, u16 handle)
 	mpi_request->Function = MPI2_FUNCTION_SCSI_TASK_MGMT;
 	mpi_request->DevHandle = cpu_to_le16(handle);
 	mpi_request->TaskType = MPI2_SCSITASKMGMT_TASKTYPE_TARGET_RESET;
-	mpt3sas_base_put_smid_hi_priority(ioc, smid, 0);
+	ioc->put_smid_hi_priority(ioc, smid, 0);
 }
 
 /**
@@ -3970,7 +3970,7 @@ _scsih_issue_delayed_event_ack(struct MPT3SAS_ADAPTER *ioc, u16 smid, U16 event,
 	ack_request->EventContext = event_context;
 	ack_request->VF_ID = 0;  /* TODO */
 	ack_request->VP_ID = 0;
-	mpt3sas_base_put_smid_default(ioc, smid);
+	ioc->put_smid_default(ioc, smid);
 }
 
 /**
@@ -4026,7 +4026,7 @@ _scsih_issue_delayed_sas_io_unit_ctrl(struct MPT3SAS_ADAPTER *ioc,
 	mpi_request->Function = MPI2_FUNCTION_SAS_IO_UNIT_CONTROL;
 	mpi_request->Operation = MPI2_SAS_OP_REMOVE_DEVICE;
 	mpi_request->DevHandle = cpu_to_le16(handle);
-	mpt3sas_base_put_smid_default(ioc, smid);
+	ioc->put_smid_default(ioc, smid);
 }
 
 /**
@@ -4734,12 +4734,12 @@ scsih_qcmd(struct Scsi_Host *shost, struct scsi_cmnd *scmd)
 		if (sas_target_priv_data->flags & MPT_TARGET_FASTPATH_IO) {
 			mpi_request->IoFlags = cpu_to_le16(scmd->cmd_len |
 			    MPI25_SCSIIO_IOFLAGS_FAST_PATH);
-			mpt3sas_base_put_smid_fast_path(ioc, smid, handle);
+			ioc->put_smid_fast_path(ioc, smid, handle);
 		} else
 			ioc->put_smid_scsi_io(ioc, smid,
 			    le16_to_cpu(mpi_request->DevHandle));
 	} else
-		mpt3sas_base_put_smid_default(ioc, smid);
+		ioc->put_smid_default(ioc, smid);
 	return 0;
 
  out:
@@ -7601,7 +7601,7 @@ _scsih_ir_fastpath(struct MPT3SAS_ADAPTER *ioc, u16 handle, u8 phys_disk_num)
 			    handle, phys_disk_num));
 
 	init_completion(&ioc->scsih_cmds.done);
-	mpt3sas_base_put_smid_default(ioc, smid);
+	ioc->put_smid_default(ioc, smid);
 	wait_for_completion_timeout(&ioc->scsih_cmds.done, 10*HZ);
 
 	if (!(ioc->scsih_cmds.status & MPT3_CMD_COMPLETE)) {
@@ -9633,7 +9633,7 @@ _scsih_ir_shutdown(struct MPT3SAS_ADAPTER *ioc)
 	if (!ioc->hide_ir_msg)
 		ioc_info(ioc, "IR shutdown (sending)\n");
 	init_completion(&ioc->scsih_cmds.done);
-	mpt3sas_base_put_smid_default(ioc, smid);
+	ioc->put_smid_default(ioc, smid);
 	wait_for_completion_timeout(&ioc->scsih_cmds.done, 10*HZ);
 
 	if (!(ioc->scsih_cmds.status & MPT3_CMD_COMPLETE)) {
diff --git a/drivers/scsi/mpt3sas/mpt3sas_transport.c b/drivers/scsi/mpt3sas/mpt3sas_transport.c
index 60ae2d0..5324662 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_transport.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_transport.c
@@ -367,7 +367,7 @@ _transport_expander_report_manufacture(struct MPT3SAS_ADAPTER *ioc,
 			 ioc_info(ioc, "report_manufacture - send to sas_addr(0x%016llx)\n",
 				  (u64)sas_address));
 	init_completion(&ioc->transport_cmds.done);
-	mpt3sas_base_put_smid_default(ioc, smid);
+	ioc->put_smid_default(ioc, smid);
 	wait_for_completion_timeout(&ioc->transport_cmds.done, 10*HZ);
 
 	if (!(ioc->transport_cmds.status & MPT3_CMD_COMPLETE)) {
@@ -1139,7 +1139,7 @@ _transport_get_expander_phy_error_log(struct MPT3SAS_ADAPTER *ioc,
 				  (u64)phy->identify.sas_address,
 				  phy->number));
 	init_completion(&ioc->transport_cmds.done);
-	mpt3sas_base_put_smid_default(ioc, smid);
+	ioc->put_smid_default(ioc, smid);
 	wait_for_completion_timeout(&ioc->transport_cmds.done, 10*HZ);
 
 	if (!(ioc->transport_cmds.status & MPT3_CMD_COMPLETE)) {
@@ -1434,7 +1434,7 @@ _transport_expander_phy_control(struct MPT3SAS_ADAPTER *ioc,
 				  (u64)phy->identify.sas_address,
 				  phy->number, phy_operation));
 	init_completion(&ioc->transport_cmds.done);
-	mpt3sas_base_put_smid_default(ioc, smid);
+	ioc->put_smid_default(ioc, smid);
 	wait_for_completion_timeout(&ioc->transport_cmds.done, 10*HZ);
 
 	if (!(ioc->transport_cmds.status & MPT3_CMD_COMPLETE)) {
@@ -1911,7 +1911,7 @@ _transport_smp_handler(struct bsg_job *job, struct Scsi_Host *shost,
 			 ioc_info(ioc, "%s: sending smp request\n", __func__));
 
 	init_completion(&ioc->transport_cmds.done);
-	mpt3sas_base_put_smid_default(ioc, smid);
+	ioc->put_smid_default(ioc, smid);
 	wait_for_completion_timeout(&ioc->transport_cmds.done, 10*HZ);
 
 	if (!(ioc->transport_cmds.status & MPT3_CMD_COMPLETE)) {
-- 
1.8.3.1

