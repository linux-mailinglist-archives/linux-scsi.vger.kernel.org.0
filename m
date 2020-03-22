Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2E2C18EB6E
	for <lists+linux-scsi@lfdr.de>; Sun, 22 Mar 2020 19:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgCVSN0 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 22 Mar 2020 14:13:26 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36833 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgCVSN0 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 22 Mar 2020 14:13:26 -0400
Received: by mail-pl1-f194.google.com with SMTP id g2so4881433plo.3
        for <linux-scsi@vger.kernel.org>; Sun, 22 Mar 2020 11:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3U/Cf2Hg9JttCTSxzS4B5yHlcszwxqOAIpfaulTkiEs=;
        b=JEn+HgsuMFHJB/tL2jN4aQ7V7PBinp/aphpsRGXd67D0rmDppxZF9tKFH2WyuWtBI3
         IIEZhkoZI4T6dBNY3753qUhHYJHeTIKqM1psb14SvCvLqpSrSbZlVUctnCXvEihGG6zH
         ji3jycXBZ/Ri3P9D43ihTbJ2JOXW8fSYvGmfKKxEFlX88k2YhUGUgq97vg/4eI1SF/UJ
         9NoiCWiHQxGQ2nSdFMf+Ajrshs5CMf/+EISpp8Vbx0HnhcOazGisA0fzRVrgkNCloNvg
         aOxbVYn0gR5opWu3LHG7CXsaC2voP2NKCic2HEAxtQ47TFXsnN0coX1hSlQz/HJi/sra
         eoqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3U/Cf2Hg9JttCTSxzS4B5yHlcszwxqOAIpfaulTkiEs=;
        b=MZsafXHf0+MkzcsL2Rb9Ov90Bh5twQW7VmumiBOkSKpKO4nUN5nVIS42O5vho0CN0T
         SWx+t7vLz0P+h4mkaCST2B0CZ+64ktFPmc/uRrfm6YN1ebsfDG0Z+51WO9Spfv9oQNBH
         HGpLhqCdyAmjCRNzKc1cUmlm/8JK2hqpzpwYBgtFS8oXI7OH+yq7S7ODIMdA2Hf88a5p
         ExebWCi5Kx8DIZaURrGacj3g6IdFZWR+GEQ/Vbja3aWMa62jPTJeQHAO9S2tj3dM7Mts
         SvJow3BhNbSEr3rtHaEyRYeuJusuBrU6rfeeNK58y1GxJzqFKDjSE00/YNU7GQDgLT/H
         bBLg==
X-Gm-Message-State: ANhLgQ3ccK+aIHAC5ooi9RaNbnIW4s2nihK6W4hHGfhKsYF4kP7TFM3X
        eYe8sYOI+i3YEb/EU3TEbtr0PPV2
X-Google-Smtp-Source: ADFU+vvR43x4gw/8uawwuPCBwa9g9x0t63JziO6hx87FctTMtLR2BymjkOn4tYNVzGEAnndgh+4/2w==
X-Received: by 2002:a17:902:9b95:: with SMTP id y21mr18133924plp.101.1584900804045;
        Sun, 22 Mar 2020 11:13:24 -0700 (PDT)
Received: from localhost.localdomain.localdomain (ip68-5-146-102.oc.oc.cox.net. [68.5.146.102])
        by smtp.gmail.com with ESMTPSA id bt19sm1331657pjb.3.2020.03.22.11.13.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Mar 2020 11:13:23 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH 10/12] lpfc: Make debugfs ktime stats generic for NVME and SCSI
Date:   Sun, 22 Mar 2020 11:13:02 -0700
Message-Id: <20200322181304.37655-11-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200322181304.37655-1-jsmart2021@gmail.com>
References: <20200322181304.37655-1-jsmart2021@gmail.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Currently driver ktime stats, measuring code paths, is NVME-specific.

Convert the stats routines such that the code paths are generic, providing
status for NVME and SCSI. Added ktime stat calls in SCSI queuecommand and
cmpl routines.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc.h         |   2 +-
 drivers/scsi/lpfc/lpfc_crtn.h    |   1 +
 drivers/scsi/lpfc/lpfc_debugfs.c | 129 ++++++++++++++++++++++++++++++++-------
 drivers/scsi/lpfc/lpfc_debugfs.h |   2 +-
 drivers/scsi/lpfc/lpfc_nvme.c    |  88 +-------------------------
 drivers/scsi/lpfc/lpfc_scsi.c    |  23 +++++++
 drivers/scsi/lpfc/lpfc_sli.h     |   2 +-
 7 files changed, 137 insertions(+), 110 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index e4924b9fa69c..747eda6ff8a4 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -480,7 +480,7 @@ struct lpfc_vport {
 	struct dentry *debug_nodelist;
 	struct dentry *debug_nvmestat;
 	struct dentry *debug_scsistat;
-	struct dentry *debug_nvmektime;
+	struct dentry *debug_ioktime;
 	struct dentry *debug_hdwqstat;
 	struct dentry *vport_debugfs_root;
 	struct lpfc_debugfs_trc *disc_trc;
diff --git a/drivers/scsi/lpfc/lpfc_crtn.h b/drivers/scsi/lpfc/lpfc_crtn.h
index a0ef3bac0612..76dc8d9493d2 100644
--- a/drivers/scsi/lpfc/lpfc_crtn.h
+++ b/drivers/scsi/lpfc/lpfc_crtn.h
@@ -588,6 +588,7 @@ struct lpfc_io_buf *lpfc_get_io_buf(struct lpfc_hba *phba,
 				int);
 void lpfc_release_io_buf(struct lpfc_hba *phba, struct lpfc_io_buf *ncmd,
 			 struct lpfc_sli4_hdw_queue *qp);
+void lpfc_io_ktime(struct lpfc_hba *phba, struct lpfc_io_buf *ncmd);
 void lpfc_nvme_cmd_template(void);
 void lpfc_nvmet_cmd_template(void);
 void lpfc_nvme_cancel_iocb(struct lpfc_hba *phba, struct lpfc_iocbq *pwqeIn);
diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
index 1b8be1006cbe..8a6e02aa553f 100644
--- a/drivers/scsi/lpfc/lpfc_debugfs.c
+++ b/drivers/scsi/lpfc/lpfc_debugfs.c
@@ -1300,8 +1300,88 @@ lpfc_debugfs_scsistat_data(struct lpfc_vport *vport, char *buf, int size)
 	return len;
 }
 
+void
+lpfc_io_ktime(struct lpfc_hba *phba, struct lpfc_io_buf *lpfc_cmd)
+{
+	uint64_t seg1, seg2, seg3, seg4;
+	uint64_t segsum;
+
+	if (!lpfc_cmd->ts_last_cmd ||
+	    !lpfc_cmd->ts_cmd_start ||
+	    !lpfc_cmd->ts_cmd_wqput ||
+	    !lpfc_cmd->ts_isr_cmpl ||
+	    !lpfc_cmd->ts_data_io)
+		return;
+
+	if (lpfc_cmd->ts_data_io < lpfc_cmd->ts_cmd_start)
+		return;
+	if (lpfc_cmd->ts_cmd_start < lpfc_cmd->ts_last_cmd)
+		return;
+	if (lpfc_cmd->ts_cmd_wqput < lpfc_cmd->ts_cmd_start)
+		return;
+	if (lpfc_cmd->ts_isr_cmpl < lpfc_cmd->ts_cmd_wqput)
+		return;
+	if (lpfc_cmd->ts_data_io < lpfc_cmd->ts_isr_cmpl)
+		return;
+	/*
+	 * Segment 1 - Time from Last FCP command cmpl is handed
+	 * off to NVME Layer to start of next command.
+	 * Segment 2 - Time from Driver receives a IO cmd start
+	 * from NVME Layer to WQ put is done on IO cmd.
+	 * Segment 3 - Time from Driver WQ put is done on IO cmd
+	 * to MSI-X ISR for IO cmpl.
+	 * Segment 4 - Time from MSI-X ISR for IO cmpl to when
+	 * cmpl is handled off to the NVME Layer.
+	 */
+	seg1 = lpfc_cmd->ts_cmd_start - lpfc_cmd->ts_last_cmd;
+	if (seg1 > 5000000)  /* 5 ms - for sequential IOs only */
+		seg1 = 0;
+
+	/* Calculate times relative to start of IO */
+	seg2 = (lpfc_cmd->ts_cmd_wqput - lpfc_cmd->ts_cmd_start);
+	segsum = seg2;
+	seg3 = lpfc_cmd->ts_isr_cmpl - lpfc_cmd->ts_cmd_start;
+	if (segsum > seg3)
+		return;
+	seg3 -= segsum;
+	segsum += seg3;
+
+	seg4 = lpfc_cmd->ts_data_io - lpfc_cmd->ts_cmd_start;
+	if (segsum > seg4)
+		return;
+	seg4 -= segsum;
+
+	phba->ktime_data_samples++;
+	phba->ktime_seg1_total += seg1;
+	if (seg1 < phba->ktime_seg1_min)
+		phba->ktime_seg1_min = seg1;
+	else if (seg1 > phba->ktime_seg1_max)
+		phba->ktime_seg1_max = seg1;
+	phba->ktime_seg2_total += seg2;
+	if (seg2 < phba->ktime_seg2_min)
+		phba->ktime_seg2_min = seg2;
+	else if (seg2 > phba->ktime_seg2_max)
+		phba->ktime_seg2_max = seg2;
+	phba->ktime_seg3_total += seg3;
+	if (seg3 < phba->ktime_seg3_min)
+		phba->ktime_seg3_min = seg3;
+	else if (seg3 > phba->ktime_seg3_max)
+		phba->ktime_seg3_max = seg3;
+	phba->ktime_seg4_total += seg4;
+	if (seg4 < phba->ktime_seg4_min)
+		phba->ktime_seg4_min = seg4;
+	else if (seg4 > phba->ktime_seg4_max)
+		phba->ktime_seg4_max = seg4;
+
+	lpfc_cmd->ts_last_cmd = 0;
+	lpfc_cmd->ts_cmd_start = 0;
+	lpfc_cmd->ts_cmd_wqput  = 0;
+	lpfc_cmd->ts_isr_cmpl = 0;
+	lpfc_cmd->ts_data_io = 0;
+}
+
 /**
- * lpfc_debugfs_nvmektime_data - Dump target node list to a buffer
+ * lpfc_debugfs_ioktime_data - Dump target node list to a buffer
  * @vport: The vport to gather target node info from.
  * @buf: The buffer to dump log into.
  * @size: The maximum amount of data to process.
@@ -1314,13 +1394,13 @@ lpfc_debugfs_scsistat_data(struct lpfc_vport *vport, char *buf, int size)
  * not exceed @size.
  **/
 static int
-lpfc_debugfs_nvmektime_data(struct lpfc_vport *vport, char *buf, int size)
+lpfc_debugfs_ioktime_data(struct lpfc_vport *vport, char *buf, int size)
 {
 	struct lpfc_hba   *phba = vport->phba;
 	int len = 0;
 
 	if (phba->nvmet_support == 0) {
-		/* NVME Initiator */
+		/* Initiator */
 		len += scnprintf(buf + len, PAGE_SIZE - len,
 				"ktime %s: Total Samples: %lld\n",
 				(phba->ktime_on ?  "Enabled" : "Disabled"),
@@ -1330,8 +1410,8 @@ lpfc_debugfs_nvmektime_data(struct lpfc_vport *vport, char *buf, int size)
 
 		len += scnprintf(
 			buf + len, PAGE_SIZE - len,
-			"Segment 1: Last NVME Cmd cmpl "
-			"done -to- Start of next NVME cnd (in driver)\n");
+			"Segment 1: Last Cmd cmpl "
+			"done -to- Start of next Cmd (in driver)\n");
 		len += scnprintf(
 			buf + len, PAGE_SIZE - len,
 			"avg:%08lld min:%08lld max %08lld\n",
@@ -1341,7 +1421,7 @@ lpfc_debugfs_nvmektime_data(struct lpfc_vport *vport, char *buf, int size)
 			phba->ktime_seg1_max);
 		len += scnprintf(
 			buf + len, PAGE_SIZE - len,
-			"Segment 2: Driver start of NVME cmd "
+			"Segment 2: Driver start of Cmd "
 			"-to- Firmware WQ doorbell\n");
 		len += scnprintf(
 			buf + len, PAGE_SIZE - len,
@@ -1364,7 +1444,7 @@ lpfc_debugfs_nvmektime_data(struct lpfc_vport *vport, char *buf, int size)
 		len += scnprintf(
 			buf + len, PAGE_SIZE - len,
 			"Segment 4: MSI-X ISR cmpl -to- "
-			"NVME cmpl done\n");
+			"Cmd cmpl done\n");
 		len += scnprintf(
 			buf + len, PAGE_SIZE - len,
 			"avg:%08lld min:%08lld max %08lld\n",
@@ -2727,7 +2807,7 @@ lpfc_debugfs_scsistat_write(struct file *file, const char __user *buf,
 }
 
 static int
-lpfc_debugfs_nvmektime_open(struct inode *inode, struct file *file)
+lpfc_debugfs_ioktime_open(struct inode *inode, struct file *file)
 {
 	struct lpfc_vport *vport = inode->i_private;
 	struct lpfc_debug *debug;
@@ -2738,14 +2818,14 @@ lpfc_debugfs_nvmektime_open(struct inode *inode, struct file *file)
 		goto out;
 
 	 /* Round to page boundary */
-	debug->buffer = kmalloc(LPFC_NVMEKTIME_SIZE, GFP_KERNEL);
+	debug->buffer = kmalloc(LPFC_IOKTIME_SIZE, GFP_KERNEL);
 	if (!debug->buffer) {
 		kfree(debug);
 		goto out;
 	}
 
-	debug->len = lpfc_debugfs_nvmektime_data(vport, debug->buffer,
-		LPFC_NVMEKTIME_SIZE);
+	debug->len = lpfc_debugfs_ioktime_data(vport, debug->buffer,
+		LPFC_IOKTIME_SIZE);
 
 	debug->i_private = inode->i_private;
 	file->private_data = debug;
@@ -2756,8 +2836,8 @@ lpfc_debugfs_nvmektime_open(struct inode *inode, struct file *file)
 }
 
 static ssize_t
-lpfc_debugfs_nvmektime_write(struct file *file, const char __user *buf,
-			     size_t nbytes, loff_t *ppos)
+lpfc_debugfs_ioktime_write(struct file *file, const char __user *buf,
+			   size_t nbytes, loff_t *ppos)
 {
 	struct lpfc_debug *debug = file->private_data;
 	struct lpfc_vport *vport = (struct lpfc_vport *)debug->i_private;
@@ -5467,13 +5547,13 @@ static const struct file_operations lpfc_debugfs_op_scsistat = {
 	.release =      lpfc_debugfs_release,
 };
 
-#undef lpfc_debugfs_op_nvmektime
-static const struct file_operations lpfc_debugfs_op_nvmektime = {
+#undef lpfc_debugfs_op_ioktime
+static const struct file_operations lpfc_debugfs_op_ioktime = {
 	.owner =        THIS_MODULE,
-	.open =         lpfc_debugfs_nvmektime_open,
+	.open =         lpfc_debugfs_ioktime_open,
 	.llseek =       lpfc_debugfs_lseek,
 	.read =         lpfc_debugfs_read,
-	.write =	lpfc_debugfs_nvmektime_write,
+	.write =	lpfc_debugfs_ioktime_write,
 	.release =      lpfc_debugfs_release,
 };
 
@@ -6111,11 +6191,16 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 		goto debug_failed;
 	}
 
-	snprintf(name, sizeof(name), "nvmektime");
-	vport->debug_nvmektime =
+	snprintf(name, sizeof(name), "ioktime");
+	vport->debug_ioktime =
 		debugfs_create_file(name, 0644,
 				    vport->vport_debugfs_root,
-				    vport, &lpfc_debugfs_op_nvmektime);
+				    vport, &lpfc_debugfs_op_ioktime);
+	if (!vport->debug_ioktime) {
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
+				 "0815 Cannot create debugfs ioktime\n");
+		goto debug_failed;
+	}
 
 	snprintf(name, sizeof(name), "hdwqstat");
 	vport->debug_hdwqstat =
@@ -6252,8 +6337,8 @@ lpfc_debugfs_terminate(struct lpfc_vport *vport)
 	debugfs_remove(vport->debug_scsistat); /* scsistat */
 	vport->debug_scsistat = NULL;
 
-	debugfs_remove(vport->debug_nvmektime); /* nvmektime */
-	vport->debug_nvmektime = NULL;
+	debugfs_remove(vport->debug_ioktime); /* ioktime */
+	vport->debug_ioktime = NULL;
 
 	debugfs_remove(vport->debug_hdwqstat); /* hdwqstat */
 	vport->debug_hdwqstat = NULL;
diff --git a/drivers/scsi/lpfc/lpfc_debugfs.h b/drivers/scsi/lpfc/lpfc_debugfs.h
index 6643b9bfd4f3..7ab6d3b08698 100644
--- a/drivers/scsi/lpfc/lpfc_debugfs.h
+++ b/drivers/scsi/lpfc/lpfc_debugfs.h
@@ -46,7 +46,7 @@
 
 /* nvmestat output buffer size */
 #define LPFC_NVMESTAT_SIZE 8192
-#define LPFC_NVMEKTIME_SIZE 8192
+#define LPFC_IOKTIME_SIZE 8192
 #define LPFC_NVMEIO_TRC_SIZE 8192
 
 /* scsistat output buffer size */
diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
index 38936b7ce043..0db052a5f542 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -899,88 +899,6 @@ lpfc_nvme_adj_fcp_sgls(struct lpfc_vport *vport,
 	sgl->sge_len = cpu_to_le32(nCmd->rsplen);
 }
 
-#ifdef CONFIG_SCSI_LPFC_DEBUG_FS
-static void
-lpfc_nvme_ktime(struct lpfc_hba *phba,
-		struct lpfc_io_buf *lpfc_ncmd)
-{
-	uint64_t seg1, seg2, seg3, seg4;
-	uint64_t segsum;
-
-	if (!lpfc_ncmd->ts_last_cmd ||
-	    !lpfc_ncmd->ts_cmd_start ||
-	    !lpfc_ncmd->ts_cmd_wqput ||
-	    !lpfc_ncmd->ts_isr_cmpl ||
-	    !lpfc_ncmd->ts_data_nvme)
-		return;
-
-	if (lpfc_ncmd->ts_data_nvme < lpfc_ncmd->ts_cmd_start)
-		return;
-	if (lpfc_ncmd->ts_cmd_start < lpfc_ncmd->ts_last_cmd)
-		return;
-	if (lpfc_ncmd->ts_cmd_wqput < lpfc_ncmd->ts_cmd_start)
-		return;
-	if (lpfc_ncmd->ts_isr_cmpl < lpfc_ncmd->ts_cmd_wqput)
-		return;
-	if (lpfc_ncmd->ts_data_nvme < lpfc_ncmd->ts_isr_cmpl)
-		return;
-	/*
-	 * Segment 1 - Time from Last FCP command cmpl is handed
-	 * off to NVME Layer to start of next command.
-	 * Segment 2 - Time from Driver receives a IO cmd start
-	 * from NVME Layer to WQ put is done on IO cmd.
-	 * Segment 3 - Time from Driver WQ put is done on IO cmd
-	 * to MSI-X ISR for IO cmpl.
-	 * Segment 4 - Time from MSI-X ISR for IO cmpl to when
-	 * cmpl is handled off to the NVME Layer.
-	 */
-	seg1 = lpfc_ncmd->ts_cmd_start - lpfc_ncmd->ts_last_cmd;
-	if (seg1 > 5000000)  /* 5 ms - for sequential IOs only */
-		seg1 = 0;
-
-	/* Calculate times relative to start of IO */
-	seg2 = (lpfc_ncmd->ts_cmd_wqput - lpfc_ncmd->ts_cmd_start);
-	segsum = seg2;
-	seg3 = lpfc_ncmd->ts_isr_cmpl - lpfc_ncmd->ts_cmd_start;
-	if (segsum > seg3)
-		return;
-	seg3 -= segsum;
-	segsum += seg3;
-
-	seg4 = lpfc_ncmd->ts_data_nvme - lpfc_ncmd->ts_cmd_start;
-	if (segsum > seg4)
-		return;
-	seg4 -= segsum;
-
-	phba->ktime_data_samples++;
-	phba->ktime_seg1_total += seg1;
-	if (seg1 < phba->ktime_seg1_min)
-		phba->ktime_seg1_min = seg1;
-	else if (seg1 > phba->ktime_seg1_max)
-		phba->ktime_seg1_max = seg1;
-	phba->ktime_seg2_total += seg2;
-	if (seg2 < phba->ktime_seg2_min)
-		phba->ktime_seg2_min = seg2;
-	else if (seg2 > phba->ktime_seg2_max)
-		phba->ktime_seg2_max = seg2;
-	phba->ktime_seg3_total += seg3;
-	if (seg3 < phba->ktime_seg3_min)
-		phba->ktime_seg3_min = seg3;
-	else if (seg3 > phba->ktime_seg3_max)
-		phba->ktime_seg3_max = seg3;
-	phba->ktime_seg4_total += seg4;
-	if (seg4 < phba->ktime_seg4_min)
-		phba->ktime_seg4_min = seg4;
-	else if (seg4 > phba->ktime_seg4_max)
-		phba->ktime_seg4_max = seg4;
-
-	lpfc_ncmd->ts_last_cmd = 0;
-	lpfc_ncmd->ts_cmd_start = 0;
-	lpfc_ncmd->ts_cmd_wqput  = 0;
-	lpfc_ncmd->ts_isr_cmpl = 0;
-	lpfc_ncmd->ts_data_nvme = 0;
-}
-#endif
 
 /**
  * lpfc_nvme_io_cmd_wqe_cmpl - Complete an NVME-over-FCP IO
@@ -1183,9 +1101,9 @@ lpfc_nvme_io_cmd_wqe_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *pwqeIn,
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
 	if (lpfc_ncmd->ts_cmd_start) {
 		lpfc_ncmd->ts_isr_cmpl = pwqeIn->isr_timestamp;
-		lpfc_ncmd->ts_data_nvme = ktime_get_ns();
-		phba->ktime_last_cmd = lpfc_ncmd->ts_data_nvme;
-		lpfc_nvme_ktime(phba, lpfc_ncmd);
+		lpfc_ncmd->ts_data_io = ktime_get_ns();
+		phba->ktime_last_cmd = lpfc_ncmd->ts_data_io;
+		lpfc_io_ktime(phba, lpfc_ncmd);
 	}
 	if (unlikely(phba->hdwqstat_on & LPFC_CHECK_NVME_IO)) {
 		cpu = raw_smp_processor_id();
diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index 3caa4fd2b55f..ad62fb3f3a54 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -4025,6 +4025,14 @@ lpfc_scsi_cmd_iocb_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *pIocbIn,
 	lpfc_cmd->pCmd = NULL;
 	spin_unlock(&lpfc_cmd->buf_lock);
 
+#ifdef CONFIG_SCSI_LPFC_DEBUG_FS
+	if (lpfc_cmd->ts_cmd_start) {
+		lpfc_cmd->ts_isr_cmpl = pIocbIn->isr_timestamp;
+		lpfc_cmd->ts_data_io = ktime_get_ns();
+		phba->ktime_last_cmd = lpfc_cmd->ts_data_io;
+		lpfc_io_ktime(phba, lpfc_cmd);
+	}
+#endif
 	/* The sdev is not guaranteed to be valid post scsi_done upcall. */
 	cmd->scsi_done(cmd);
 
@@ -4497,6 +4505,12 @@ lpfc_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *cmnd)
 	struct lpfc_io_buf *lpfc_cmd;
 	struct fc_rport *rport = starget_to_rport(scsi_target(cmnd->device));
 	int err, idx;
+#ifdef CONFIG_SCSI_LPFC_DEBUG_FS
+	uint64_t start = 0L;
+
+	if (phba->ktime_on)
+		start = ktime_get_ns();
+#endif
 
 	rdata = lpfc_rport_data_from_scsi_device(cmnd->device);
 
@@ -4622,6 +4636,15 @@ lpfc_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *cmnd)
 #endif
 	err = lpfc_sli_issue_iocb(phba, LPFC_FCP_RING,
 				  &lpfc_cmd->cur_iocbq, SLI_IOCB_RET_IOCB);
+#ifdef CONFIG_SCSI_LPFC_DEBUG_FS
+	if (start) {
+		lpfc_cmd->ts_cmd_start = start;
+		lpfc_cmd->ts_last_cmd = phba->ktime_last_cmd;
+		lpfc_cmd->ts_cmd_wqput = ktime_get_ns();
+	} else {
+		lpfc_cmd->ts_cmd_start = 0;
+	}
+#endif
 	if (err) {
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_FCP,
 				 "3376 FCP could not issue IOCB err %x"
diff --git a/drivers/scsi/lpfc/lpfc_sli.h b/drivers/scsi/lpfc/lpfc_sli.h
index 7bcf922a8be2..93d976ea8c5d 100644
--- a/drivers/scsi/lpfc/lpfc_sli.h
+++ b/drivers/scsi/lpfc/lpfc_sli.h
@@ -446,6 +446,6 @@ struct lpfc_io_buf {
 	uint64_t ts_last_cmd;
 	uint64_t ts_cmd_wqput;
 	uint64_t ts_isr_cmpl;
-	uint64_t ts_data_nvme;
+	uint64_t ts_data_io;
 #endif
 };
-- 
2.16.4

