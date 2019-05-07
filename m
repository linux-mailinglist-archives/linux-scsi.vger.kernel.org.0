Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF84168C0
	for <lists+linux-scsi@lfdr.de>; Tue,  7 May 2019 19:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbfEGRGj (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 7 May 2019 13:06:39 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36999 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbfEGRGj (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 7 May 2019 13:06:39 -0400
Received: by mail-pg1-f193.google.com with SMTP id e6so8618848pgc.4
        for <linux-scsi@vger.kernel.org>; Tue, 07 May 2019 10:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yNfF0OLHN6RAYdrSTgE7wi1GtYkO8fhy4g0HrI4qchw=;
        b=YUTOC9cqg18unrgkDYkr2sbsuBXWi+tV3ip47p+Ydga8f4NNQ7Q2xaJ3BGmph1IoxW
         XKNtXWj5IrcYXAPZXPdVUuCblYTbOGocLgsyn98VKq9w9YFrGdGxy0b1Z3lhX4TV6hsF
         19O4kVX+44NMLGOaxRthSXmupo4v3rhtM+2bI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yNfF0OLHN6RAYdrSTgE7wi1GtYkO8fhy4g0HrI4qchw=;
        b=LDWT23SOnH+7Vt8K/tne4rsNgCZOYoioCWaJrhuVkBHwK7atoZ6/Oo7/+HoFwlA9Fg
         f9mQgl7ssVeWoQSdQ5Qv2wOWlue0MVtUIsTni6KVksRgkvvWpCDMyhSSqPDCotdd9rWt
         kmwxBBLr2Q0lUF6h1orQsls4hZ30ZYZ9VowfZ8veGK762+ejGMcb3wzNSTDMSPDlgHEP
         JPnrDtlFo3xOp+F2FVIsGx+MPaY67nyROECALCfm+Qe7sf8qbqH4LyjDxuELZJVt49hV
         rhrdu6HsPVpB8X44AA/zQK8PfR0zL0JXT4YgW21pvSKuYJMrTAKZB0PhLot7j6GAQrz1
         r9BQ==
X-Gm-Message-State: APjAAAWJ/+dmBF6szg6tNAk+A6WNGXL9leeDDsA12jNKYWpAthLzxlM2
        Xn9ViJKTGlixuTp4CP1xdagR0xX7zXGuiMLrmoqnJnh5qS8//GseZsY3suVX7U2WG9zUygtLJVh
        4jlb7gkkT8V4wj7eF4OIm+jMPvO0a05U+jpPrccdsz/z0SXLsgB8k+JG/wakdVoRkmCE5sF5IQq
        Zs3OCZZ2pcVtp18kHrB/UG
X-Google-Smtp-Source: APXvYqy36s1Al9MKC+ETSKiDqw4yeMgH6OnXl66DUoNwTvSwAk+KBzUyz9OIKe0F18/ozSAw4uVNLg==
X-Received: by 2002:a65:4144:: with SMTP id x4mr41581918pgp.282.1557248797559;
        Tue, 07 May 2019 10:06:37 -0700 (PDT)
Received: from dhcp-135-24-192-142.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id r74sm17527791pfa.71.2019.05.07.10.06.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 10:06:36 -0700 (PDT)
From:   Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Subject: [PATCH v2 08/21] megaraid_sas: Enhance prints in OCR and TM path
Date:   Tue,  7 May 2019 10:05:37 -0700
Message-Id: <1557248750-4099-9-git-send-email-shivasharan.srikanteshwara@broadcom.com>
X-Mailer: git-send-email 2.4.3
In-Reply-To: <1557248750-4099-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
References: <1557248750-4099-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch enhances the existing debug prints in reset and
task management path.
These debug prints in adapter reset path helps with debugging issues
related to IO timeouts that are seen frequently in the field.
Add additional debug prints to dump the pending command frames before
initiating a adapter reset.
Also, print FastPath IOs that are outstanding.

Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
---
 drivers/scsi/megaraid/megaraid_sas.h        |  4 +-
 drivers/scsi/megaraid/megaraid_sas_base.c   | 69 ++++++++++++++++++++++-------
 drivers/scsi/megaraid/megaraid_sas_fusion.c | 44 +++++++++---------
 3 files changed, 80 insertions(+), 37 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas.h b/drivers/scsi/megaraid/megaraid_sas.h
index 6be748f302cf..27980d68cf1b 100644
--- a/drivers/scsi/megaraid/megaraid_sas.h
+++ b/drivers/scsi/megaraid/megaraid_sas.h
@@ -1495,7 +1495,8 @@ struct megasas_ctrl_info {
 #define MEGASAS_FW_BUSY				1
 
 /* Driver's internal Logging levels*/
-#define OCR_LOGS    (1 << 0)
+#define OCR_DEBUG    (1 << 0)
+#define TM_DEBUG     (1 << 1)
 
 #define SCAN_PD_CHANNEL	0x1
 #define SCAN_VD_CHANNEL	0x2
@@ -2647,4 +2648,5 @@ int megasas_adp_reset_wait_for_ready(struct megasas_instance *instance,
 				     bool do_adp_reset,
 				     int ocr_context);
 int megasas_irqpoll(struct irq_poll *irqpoll, int budget);
+void megasas_dump_fusion_io(struct scsi_cmnd *scmd);
 #endif				/*LSI_MEGARAID_SAS_H */
diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 102a7e40996e..032d91b1f3ba 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -55,6 +55,7 @@
 #include <scsi/scsi_device.h>
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_tcq.h>
+#include <scsi/scsi_dbg.h>
 #include "megaraid_sas_fusion.h"
 #include "megaraid_sas.h"
 
@@ -2833,23 +2834,63 @@ blk_eh_timer_return megasas_reset_timer(struct scsi_cmnd *scmd)
 }
 
 /**
- * megasas_dump_frame -	This function will dump MPT/MFI frame
+ * megasas_dump -	This function will provide hexdump
+ * @ptr:		Pointer starting which memory should be dumped
+ * @size:		Size of memory to be dumped
  */
-static inline void
-megasas_dump_frame(void *mpi_request, int sz)
+inline void
+megasas_dump(void *ptr, int sz)
 {
 	int i;
-	__le32 *mfp = (__le32 *)mpi_request;
+	__le32 *loc = (__le32 *)ptr;
 
-	printk(KERN_INFO "IO request frame:\n\t");
 	for (i = 0; i < sz / sizeof(__le32); i++) {
 		if (i && ((i % 8) == 0))
 			printk("\n\t");
-		printk("%08x ", le32_to_cpu(mfp[i]));
+		printk("%08x ", le32_to_cpu(loc[i]));
 	}
 	printk("\n");
 }
 
+/**
+ * megasas_dump_fusion_io -	This function will print key details
+ *				of SCSI IO
+ * @scmd:			SCSI command pointer of SCSI IO
+ */
+void
+megasas_dump_fusion_io(struct scsi_cmnd *scmd)
+{
+	struct megasas_cmd_fusion *cmd;
+	union MEGASAS_REQUEST_DESCRIPTOR_UNION *req_desc;
+	struct megasas_instance *instance;
+
+	cmd = (struct megasas_cmd_fusion *)scmd->SCp.ptr;
+	instance = (struct megasas_instance *)scmd->device->host->hostdata;
+
+	scmd_printk(KERN_INFO, scmd,
+		    "scmd: (0x%p)  retries: 0x%x  allowed: 0x%x\n",
+		    scmd, scmd->retries, scmd->allowed);
+	scsi_print_command(scmd);
+
+	if (cmd) {
+		req_desc = (union MEGASAS_REQUEST_DESCRIPTOR_UNION *)cmd->request_desc;
+		scmd_printk(KERN_INFO, scmd, "Request descriptor details:\n");
+		scmd_printk(KERN_INFO, scmd,
+			    "RequestFlags:0x%x  MSIxIndex:0x%x  SMID:0x%x  LMID:0x%x  DevHandle:0x%x\n",
+			    req_desc->SCSIIO.RequestFlags,
+			    req_desc->SCSIIO.MSIxIndex, req_desc->SCSIIO.SMID,
+			    req_desc->SCSIIO.LMID, req_desc->SCSIIO.DevHandle);
+
+		printk(KERN_INFO "IO request frame:\n");
+		megasas_dump(cmd->io_request,
+			     MEGA_MPI2_RAID_DEFAULT_IO_FRAME_SIZE);
+		printk(KERN_INFO "Chain frame:\n");
+		megasas_dump(cmd->sg_frame,
+			     instance->max_chain_frame_sz);
+	}
+
+}
+
 /**
  * megasas_reset_bus_host -	Bus & host reset handler entry point
  */
@@ -2861,24 +2902,20 @@ static int megasas_reset_bus_host(struct scsi_cmnd *scmd)
 	instance = (struct megasas_instance *)scmd->device->host->hostdata;
 
 	scmd_printk(KERN_INFO, scmd,
-		"Controller reset is requested due to IO timeout\n"
-		"SCSI command pointer: (%p)\t SCSI host state: %d\t"
-		" SCSI host busy: %d\t FW outstanding: %d\n",
-		scmd, scmd->device->host->shost_state,
+		"OCR is requested due to IO timeout!!\n");
+
+	scmd_printk(KERN_INFO, scmd,
+		"SCSI host state: %d  SCSI host busy: %d  FW outstanding: %d\n",
+		scmd->device->host->shost_state,
 		scsi_host_busy(scmd->device->host),
 		atomic_read(&instance->fw_outstanding));
-
 	/*
 	 * First wait for all commands to complete
 	 */
 	if (instance->adapter_type == MFI_SERIES) {
 		ret = megasas_generic_reset(scmd);
 	} else {
-		struct megasas_cmd_fusion *cmd;
-		cmd = (struct megasas_cmd_fusion *)scmd->SCp.ptr;
-		if (cmd)
-			megasas_dump_frame(cmd->io_request,
-				MEGA_MPI2_RAID_DEFAULT_IO_FRAME_SIZE);
+		megasas_dump_fusion_io(scmd);
 		ret = megasas_reset_fusion(scmd->device->host,
 				SCSIIO_TIMEOUT_OCR);
 	}
diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index ef0b15e4de2d..b4f798b458f0 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -122,7 +122,7 @@ megasas_adp_reset_wait_for_ready(struct megasas_instance *instance,
 	 * Block access to PCI config space from userspace
 	 * when diag reset is initiated from driver
 	 */
-	if (megasas_dbg_lvl & OCR_LOGS)
+	if (megasas_dbg_lvl & OCR_DEBUG)
 		dev_info(&instance->pdev->dev,
 			 "Block access to PCI config space %s %d\n",
 			 __func__, __LINE__);
@@ -145,7 +145,7 @@ megasas_adp_reset_wait_for_ready(struct megasas_instance *instance,
 
 	ret = SUCCESS;
 out:
-	if (megasas_dbg_lvl & OCR_LOGS)
+	if (megasas_dbg_lvl & OCR_DEBUG)
 		dev_info(&instance->pdev->dev,
 			 "Unlock access to PCI config space %s %d\n",
 			 __func__, __LINE__);
@@ -4519,9 +4519,6 @@ int megasas_task_abort_fusion(struct scsi_cmnd *scmd)
 
 	instance = (struct megasas_instance *)scmd->device->host->hostdata;
 
-	scmd_printk(KERN_INFO, scmd, "task abort called for scmd(%p)\n", scmd);
-	scsi_print_command(scmd);
-
 	if (atomic_read(&instance->adprecovery) != MEGASAS_HBA_OPERATIONAL) {
 		dev_err(&instance->pdev->dev, "Controller is not OPERATIONAL,"
 		"SCSI host:%d\n", instance->host->host_no);
@@ -4564,7 +4561,7 @@ int megasas_task_abort_fusion(struct scsi_cmnd *scmd)
 		goto out;
 	}
 	sdev_printk(KERN_INFO, scmd->device,
-		"attempting task abort! scmd(%p) tm_dev_handle 0x%x\n",
+		"attempting task abort! scmd(0x%p) tm_dev_handle 0x%x\n",
 		scmd, devhandle);
 
 	mr_device_priv_data->tm_busy = 1;
@@ -4575,9 +4572,12 @@ int megasas_task_abort_fusion(struct scsi_cmnd *scmd)
 	mr_device_priv_data->tm_busy = 0;
 
 	mutex_unlock(&instance->reset_mutex);
-out:
-	sdev_printk(KERN_INFO, scmd->device, "task abort: %s scmd(%p)\n",
+	scmd_printk(KERN_INFO, scmd, "task abort %s!! scmd(0x%p)\n",
 			((ret == SUCCESS) ? "SUCCESS" : "FAILED"), scmd);
+out:
+	scsi_print_command(scmd);
+	if (megasas_dbg_lvl & TM_DEBUG)
+		megasas_dump_fusion_io(scmd);
 
 	return ret;
 }
@@ -4600,9 +4600,6 @@ int megasas_reset_target_fusion(struct scsi_cmnd *scmd)
 
 	instance = (struct megasas_instance *)scmd->device->host->hostdata;
 
-	sdev_printk(KERN_INFO, scmd->device,
-		    "target reset called for scmd(%p)\n", scmd);
-
 	if (atomic_read(&instance->adprecovery) != MEGASAS_HBA_OPERATIONAL) {
 		dev_err(&instance->pdev->dev, "Controller is not OPERATIONAL,"
 		"SCSI host:%d\n", instance->host->host_no);
@@ -4611,8 +4608,8 @@ int megasas_reset_target_fusion(struct scsi_cmnd *scmd)
 	}
 
 	if (!mr_device_priv_data) {
-		sdev_printk(KERN_INFO, scmd->device, "device been deleted! "
-			"scmd(%p)\n", scmd);
+		sdev_printk(KERN_INFO, scmd->device,
+			    "device been deleted! scmd: (0x%p)\n", scmd);
 		scmd->result = DID_NO_CONNECT << 16;
 		ret = SUCCESS;
 		goto out;
@@ -4635,7 +4632,7 @@ int megasas_reset_target_fusion(struct scsi_cmnd *scmd)
 	}
 
 	sdev_printk(KERN_INFO, scmd->device,
-		"attempting target reset! scmd(%p) tm_dev_handle 0x%x\n",
+		"attempting target reset! scmd(0x%p) tm_dev_handle: 0x%x\n",
 		scmd, devhandle);
 	mr_device_priv_data->tm_busy = 1;
 	ret = megasas_issue_tm(instance, devhandle,
@@ -4644,10 +4641,10 @@ int megasas_reset_target_fusion(struct scsi_cmnd *scmd)
 			mr_device_priv_data);
 	mr_device_priv_data->tm_busy = 0;
 	mutex_unlock(&instance->reset_mutex);
-out:
-	scmd_printk(KERN_NOTICE, scmd, "megasas: target reset %s!!\n",
+	scmd_printk(KERN_NOTICE, scmd, "target reset %s!!\n",
 		(ret == SUCCESS) ? "SUCCESS" : "FAILED");
 
+out:
 	return ret;
 }
 
@@ -4692,7 +4689,7 @@ int megasas_reset_fusion(struct Scsi_Host *shost, int reason)
 	struct megasas_instance *instance;
 	struct megasas_cmd_fusion *cmd_fusion, *r1_cmd;
 	struct fusion_context *fusion;
-	u32 abs_state, status_reg, reset_adapter;
+	u32 abs_state, status_reg, reset_adapter, fpio_count = 0;
 	u32 io_timeout_in_crash_mode = 0;
 	struct scsi_cmnd *scmd_local = NULL;
 	struct scsi_device *sdev;
@@ -4766,7 +4763,7 @@ int megasas_reset_fusion(struct Scsi_Host *shost, int reason)
 		if (convert)
 			reason = 0;
 
-		if (megasas_dbg_lvl & OCR_LOGS)
+		if (megasas_dbg_lvl & OCR_DEBUG)
 			dev_info(&instance->pdev->dev, "\nPending SCSI commands:\n");
 
 		/* Now return commands back to the OS */
@@ -4779,13 +4776,17 @@ int megasas_reset_fusion(struct Scsi_Host *shost, int reason)
 			}
 			scmd_local = cmd_fusion->scmd;
 			if (cmd_fusion->scmd) {
-				if (megasas_dbg_lvl & OCR_LOGS) {
+				if (megasas_dbg_lvl & OCR_DEBUG) {
 					sdev_printk(KERN_INFO,
 						cmd_fusion->scmd->device, "SMID: 0x%x\n",
 						cmd_fusion->index);
-					scsi_print_command(cmd_fusion->scmd);
+					megasas_dump_fusion_io(cmd_fusion->scmd);
 				}
 
+				if (cmd_fusion->io_request->Function ==
+					MPI2_FUNCTION_SCSI_IO_REQUEST)
+					fpio_count++;
+
 				scmd_local->result =
 					megasas_check_mpio_paths(instance,
 							scmd_local);
@@ -4798,6 +4799,9 @@ int megasas_reset_fusion(struct Scsi_Host *shost, int reason)
 			}
 		}
 
+		dev_info(&instance->pdev->dev, "Outstanding fastpath IOs: %d\n",
+			fpio_count);
+
 		atomic_set(&instance->fw_outstanding, 0);
 
 		status_reg = instance->instancet->read_fw_status_reg(instance);
-- 
2.16.1

