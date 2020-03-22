Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C878F18EB6C
	for <lists+linux-scsi@lfdr.de>; Sun, 22 Mar 2020 19:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgCVSNY (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 22 Mar 2020 14:13:24 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:51360 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgCVSNX (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 22 Mar 2020 14:13:23 -0400
Received: by mail-pj1-f68.google.com with SMTP id hg10so5029326pjb.1
        for <linux-scsi@vger.kernel.org>; Sun, 22 Mar 2020 11:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pQig+XNviGvRA8buHX3MHVFnyVzlna3ANhTwtlb0Qtw=;
        b=QN2wdMg9skY7oXGsgbR2eKOO05cDG5vjHtkZBwhhs89JgbJgWfrawPPgbEI550ovGB
         nUiv+8oy6ouXhRrHiCn96rVJyWJt0w+s6H06dtOMHZ85FBpN+btTkvYq9lyS7jwZtjQC
         VmMt4KX/IE0sMOfSOZ0fZaMwXFxk8HV5KnuDVmfw/ZOzbwoQhGKQKwlSaKFB2/l6du9c
         a+/6CVNkO8geuuantFSxCckZfl7WkaSJM1DcbQOKJLb3M4PjUy2kqXzSpNY4dRjhV0wF
         dtj+Y7DTATdgm/PAXAiIbGynWEr9a1FkeZfYGL6u1TbceNotsB+IHXR1hbvoKrJBxz3N
         so9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pQig+XNviGvRA8buHX3MHVFnyVzlna3ANhTwtlb0Qtw=;
        b=qqQQo5aL2XZs6dkj7dFOPr39V6NP//b9Dv7FpmpCbOP7BiB0JuOg9kmLX0lSmDNWl0
         4Mof+CCV4dRMGgbgaQ3XY9a0q2S6SAv8S895t+1MAw/9gDr7LqwhV3umafa5fbZ8b7Vi
         m5p51z0DNt7rp/z/thLoLujAk/uvqbciPg5rTdPYstDIkOiTcg3tMgj4K1IjHnIsRh8e
         ryzncU9cBPRjyZzi7aROYvuFwLejRztJOBcqUKcksXnaOvlToj9VOmkwcM34+ZRzw/sJ
         p8R8x5bAIEel+nDGgNiONZOhD0TaH/i7zvdQgrHZkGdLN9+hwWsAcHiOdspKpqd0QIYb
         flKQ==
X-Gm-Message-State: ANhLgQ3vRQfRT++zZMedaM5KFqEdLY4WoS2nWhDydGdKP6La6IW9lbB2
        iDS6qFBTqVl8CFj5gPps/zBjLPla
X-Google-Smtp-Source: ADFU+vurhV0X+yTJfWoSWSUy7xjFjObagFC3MJ9a5RHQ5DxBTt15m5XEh4l7w/IwBvRrlxpltPdgKQ==
X-Received: by 2002:a17:902:7201:: with SMTP id ba1mr3930341plb.198.1584900801202;
        Sun, 22 Mar 2020 11:13:21 -0700 (PDT)
Received: from localhost.localdomain.localdomain (ip68-5-146-102.oc.oc.cox.net. [68.5.146.102])
        by smtp.gmail.com with ESMTPSA id bt19sm1331657pjb.3.2020.03.22.11.13.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Mar 2020 11:13:20 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH 08/12] lpfc: Fix erroneous cpu limit of 128 on I/O statistics
Date:   Sun, 22 Mar 2020 11:13:00 -0700
Message-Id: <20200322181304.37655-9-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200322181304.37655-1-jsmart2021@gmail.com>
References: <20200322181304.37655-1-jsmart2021@gmail.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The cpu io statistics were capped by a hard define limit of 128. This
effectively was a max number of cpu's, not an actual cpu cou nor actual
cpu numbers which can be even larger that both of those values. This made
stats off/misleading and on large cpu count systems, wrong.

Fix the stats so that all cpus can have a stats struct.
Fix the looping such that it loops by hdwq, finds cpus that used the
hdwq, and sum the stats, then display.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc.h         |   9 +-
 drivers/scsi/lpfc/lpfc_debugfs.c | 204 +++++++++++++++++++++++----------------
 drivers/scsi/lpfc/lpfc_debugfs.h |   1 -
 drivers/scsi/lpfc/lpfc_init.c    |  28 ++++++
 drivers/scsi/lpfc/lpfc_nvme.c    |  45 ++++-----
 drivers/scsi/lpfc/lpfc_nvmet.c   |  55 +++++------
 drivers/scsi/lpfc/lpfc_scsi.c    |  23 +----
 drivers/scsi/lpfc/lpfc_sli4.h    |  19 ++--
 8 files changed, 215 insertions(+), 169 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index e940a49f9f02..e4924b9fa69c 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -481,7 +481,7 @@ struct lpfc_vport {
 	struct dentry *debug_nvmestat;
 	struct dentry *debug_scsistat;
 	struct dentry *debug_nvmektime;
-	struct dentry *debug_cpucheck;
+	struct dentry *debug_hdwqstat;
 	struct dentry *vport_debugfs_root;
 	struct lpfc_debugfs_trc *disc_trc;
 	atomic_t disc_trc_cnt;
@@ -1175,12 +1175,11 @@ struct lpfc_hba {
 	uint16_t sfp_warning;
 
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
-	uint16_t cpucheck_on;
+	uint16_t hdwqstat_on;
 #define LPFC_CHECK_OFF		0
 #define LPFC_CHECK_NVME_IO	1
-#define LPFC_CHECK_NVMET_RCV	2
-#define LPFC_CHECK_NVMET_IO	4
-#define LPFC_CHECK_SCSI_IO	8
+#define LPFC_CHECK_NVMET_IO	2
+#define LPFC_CHECK_SCSI_IO	4
 	uint16_t ktime_on;
 	uint64_t ktime_data_samples;
 	uint64_t ktime_status_samples;
diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
index 819335b16c2e..1b8be1006cbe 100644
--- a/drivers/scsi/lpfc/lpfc_debugfs.c
+++ b/drivers/scsi/lpfc/lpfc_debugfs.c
@@ -1603,42 +1603,50 @@ lpfc_debugfs_nvmeio_trc_data(struct lpfc_hba *phba, char *buf, int size)
 }
 
 /**
- * lpfc_debugfs_cpucheck_data - Dump target node list to a buffer
+ * lpfc_debugfs_hdwqstat_data - Dump I/O stats to a buffer
  * @vport: The vport to gather target node info from.
  * @buf: The buffer to dump log into.
  * @size: The maximum amount of data to process.
  *
  * Description:
- * This routine dumps the NVME statistics associated with @vport
+ * This routine dumps the NVME + SCSI statistics associated with @vport
  *
  * Return Value:
  * This routine returns the amount of bytes that were dumped into @buf and will
  * not exceed @size.
  **/
 static int
-lpfc_debugfs_cpucheck_data(struct lpfc_vport *vport, char *buf, int size)
+lpfc_debugfs_hdwqstat_data(struct lpfc_vport *vport, char *buf, int size)
 {
 	struct lpfc_hba   *phba = vport->phba;
 	struct lpfc_sli4_hdw_queue *qp;
-	int i, j, max_cnt;
-	int len = 0;
+	struct lpfc_hdwq_stat *c_stat;
+	int i, j, len;
 	uint32_t tot_xmt;
 	uint32_t tot_rcv;
 	uint32_t tot_cmpl;
+	char tmp[LPFC_MAX_SCSI_INFO_TMP_LEN] = {0};
 
-	len += scnprintf(buf + len, PAGE_SIZE - len,
-			"CPUcheck %s ",
-			(phba->cpucheck_on & LPFC_CHECK_NVME_IO ?
-				"Enabled" : "Disabled"));
-	if (phba->nvmet_support) {
-		len += scnprintf(buf + len, PAGE_SIZE - len,
-				"%s\n",
-				(phba->cpucheck_on & LPFC_CHECK_NVMET_RCV ?
-					"Rcv Enabled\n" : "Rcv Disabled\n"));
-	} else {
-		len += scnprintf(buf + len, PAGE_SIZE - len, "\n");
-	}
-	max_cnt = size - LPFC_DEBUG_OUT_LINE_SZ;
+	scnprintf(tmp, sizeof(tmp), "HDWQ Stats:\n\n");
+	if (strlcat(buf, tmp, size) >= size)
+		goto buffer_done;
+
+	scnprintf(tmp, sizeof(tmp), "(NVME Accounting: %s) ",
+		  (phba->hdwqstat_on &
+		  (LPFC_CHECK_NVME_IO | LPFC_CHECK_NVMET_IO) ?
+		  "Enabled" : "Disabled"));
+	if (strlcat(buf, tmp, size) >= size)
+		goto buffer_done;
+
+	scnprintf(tmp, sizeof(tmp), "(SCSI Accounting: %s) ",
+		  (phba->hdwqstat_on & LPFC_CHECK_SCSI_IO ?
+		  "Enabled" : "Disabled"));
+	if (strlcat(buf, tmp, size) >= size)
+		goto buffer_done;
+
+	scnprintf(tmp, sizeof(tmp), "\n\n");
+	if (strlcat(buf, tmp, size) >= size)
+		goto buffer_done;
 
 	for (i = 0; i < phba->cfg_hdw_queue; i++) {
 		qp = &phba->sli4_hba.hdwq[i];
@@ -1646,46 +1654,76 @@ lpfc_debugfs_cpucheck_data(struct lpfc_vport *vport, char *buf, int size)
 		tot_rcv = 0;
 		tot_xmt = 0;
 		tot_cmpl = 0;
-		for (j = 0; j < LPFC_CHECK_CPU_CNT; j++) {
-			tot_xmt += qp->cpucheck_xmt_io[j];
-			tot_cmpl += qp->cpucheck_cmpl_io[j];
-			if (phba->nvmet_support)
-				tot_rcv += qp->cpucheck_rcv_io[j];
-		}
 
-		/* Only display Hardware Qs with something */
-		if (!tot_xmt && !tot_cmpl && !tot_rcv)
-			continue;
+		for_each_present_cpu(j) {
+			c_stat = per_cpu_ptr(phba->sli4_hba.c_stat, j);
+
+			/* Only display for this HDWQ */
+			if (i != c_stat->hdwq_no)
+				continue;
 
-		len += scnprintf(buf + len, PAGE_SIZE - len,
-				"HDWQ %03d: ", i);
-		for (j = 0; j < LPFC_CHECK_CPU_CNT; j++) {
 			/* Only display non-zero counters */
-			if (!qp->cpucheck_xmt_io[j] &&
-			    !qp->cpucheck_cmpl_io[j] &&
-			    !qp->cpucheck_rcv_io[j])
+			if (!c_stat->xmt_io && !c_stat->cmpl_io &&
+			    !c_stat->rcv_io)
 				continue;
+
+			if (!tot_xmt && !tot_cmpl && !tot_rcv) {
+				/* Print HDWQ string only the first time */
+				scnprintf(tmp, sizeof(tmp), "[HDWQ %d]:\t", i);
+				if (strlcat(buf, tmp, size) >= size)
+					goto buffer_done;
+			}
+
+			tot_xmt += c_stat->xmt_io;
+			tot_cmpl += c_stat->cmpl_io;
+			if (phba->nvmet_support)
+				tot_rcv += c_stat->rcv_io;
+
+			scnprintf(tmp, sizeof(tmp), "| [CPU %d]: ", j);
+			if (strlcat(buf, tmp, size) >= size)
+				goto buffer_done;
+
 			if (phba->nvmet_support) {
-				len += scnprintf(buf + len, PAGE_SIZE - len,
-						"CPU %03d: %x/%x/%x ", j,
-						qp->cpucheck_rcv_io[j],
-						qp->cpucheck_xmt_io[j],
-						qp->cpucheck_cmpl_io[j]);
+				scnprintf(tmp, sizeof(tmp),
+					  "XMT 0x%x CMPL 0x%x RCV 0x%x |",
+					  c_stat->xmt_io, c_stat->cmpl_io,
+					  c_stat->rcv_io);
+				if (strlcat(buf, tmp, size) >= size)
+					goto buffer_done;
 			} else {
-				len += scnprintf(buf + len, PAGE_SIZE - len,
-						"CPU %03d: %x/%x ", j,
-						qp->cpucheck_xmt_io[j],
-						qp->cpucheck_cmpl_io[j]);
+				scnprintf(tmp, sizeof(tmp),
+					  "XMT 0x%x CMPL 0x%x |",
+					  c_stat->xmt_io, c_stat->cmpl_io);
+				if (strlcat(buf, tmp, size) >= size)
+					goto buffer_done;
 			}
 		}
-		len += scnprintf(buf + len, PAGE_SIZE - len,
-				"Total: %x\n", tot_xmt);
-		if (len >= max_cnt) {
-			len += scnprintf(buf + len, PAGE_SIZE - len,
-					"Truncated ...\n");
-			return len;
+
+		/* Check if nothing to display */
+		if (!tot_xmt && !tot_cmpl && !tot_rcv)
+			continue;
+
+		scnprintf(tmp, sizeof(tmp), "\t->\t[HDWQ Total: ");
+		if (strlcat(buf, tmp, size) >= size)
+			goto buffer_done;
+
+		if (phba->nvmet_support) {
+			scnprintf(tmp, sizeof(tmp),
+				  "XMT 0x%x CMPL 0x%x RCV 0x%x]\n\n",
+				  tot_xmt, tot_cmpl, tot_rcv);
+			if (strlcat(buf, tmp, size) >= size)
+				goto buffer_done;
+		} else {
+			scnprintf(tmp, sizeof(tmp),
+				  "XMT 0x%x CMPL 0x%x]\n\n",
+				  tot_xmt, tot_cmpl);
+			if (strlcat(buf, tmp, size) >= size)
+				goto buffer_done;
 		}
 	}
+
+buffer_done:
+	len = strnlen(buf, size);
 	return len;
 }
 
@@ -2921,7 +2959,7 @@ lpfc_debugfs_nvmeio_trc_write(struct file *file, const char __user *buf,
 }
 
 static int
-lpfc_debugfs_cpucheck_open(struct inode *inode, struct file *file)
+lpfc_debugfs_hdwqstat_open(struct inode *inode, struct file *file)
 {
 	struct lpfc_vport *vport = inode->i_private;
 	struct lpfc_debug *debug;
@@ -2932,14 +2970,14 @@ lpfc_debugfs_cpucheck_open(struct inode *inode, struct file *file)
 		goto out;
 
 	 /* Round to page boundary */
-	debug->buffer = kmalloc(LPFC_CPUCHECK_SIZE, GFP_KERNEL);
+	debug->buffer = kcalloc(1, LPFC_SCSISTAT_SIZE, GFP_KERNEL);
 	if (!debug->buffer) {
 		kfree(debug);
 		goto out;
 	}
 
-	debug->len = lpfc_debugfs_cpucheck_data(vport, debug->buffer,
-		LPFC_CPUCHECK_SIZE);
+	debug->len = lpfc_debugfs_hdwqstat_data(vport, debug->buffer,
+						LPFC_SCSISTAT_SIZE);
 
 	debug->i_private = inode->i_private;
 	file->private_data = debug;
@@ -2950,16 +2988,16 @@ lpfc_debugfs_cpucheck_open(struct inode *inode, struct file *file)
 }
 
 static ssize_t
-lpfc_debugfs_cpucheck_write(struct file *file, const char __user *buf,
+lpfc_debugfs_hdwqstat_write(struct file *file, const char __user *buf,
 			    size_t nbytes, loff_t *ppos)
 {
 	struct lpfc_debug *debug = file->private_data;
 	struct lpfc_vport *vport = (struct lpfc_vport *)debug->i_private;
 	struct lpfc_hba   *phba = vport->phba;
-	struct lpfc_sli4_hdw_queue *qp;
+	struct lpfc_hdwq_stat *c_stat;
 	char mybuf[64];
 	char *pbuf;
-	int i, j;
+	int i;
 
 	if (nbytes > 64)
 		nbytes = 64;
@@ -2972,41 +3010,39 @@ lpfc_debugfs_cpucheck_write(struct file *file, const char __user *buf,
 
 	if ((strncmp(pbuf, "on", sizeof("on") - 1) == 0)) {
 		if (phba->nvmet_support)
-			phba->cpucheck_on |= LPFC_CHECK_NVMET_IO;
+			phba->hdwqstat_on |= LPFC_CHECK_NVMET_IO;
 		else
-			phba->cpucheck_on |= (LPFC_CHECK_NVME_IO |
+			phba->hdwqstat_on |= (LPFC_CHECK_NVME_IO |
 				LPFC_CHECK_SCSI_IO);
 		return strlen(pbuf);
 	} else if ((strncmp(pbuf, "nvme_on", sizeof("nvme_on") - 1) == 0)) {
 		if (phba->nvmet_support)
-			phba->cpucheck_on |= LPFC_CHECK_NVMET_IO;
+			phba->hdwqstat_on |= LPFC_CHECK_NVMET_IO;
 		else
-			phba->cpucheck_on |= LPFC_CHECK_NVME_IO;
+			phba->hdwqstat_on |= LPFC_CHECK_NVME_IO;
 		return strlen(pbuf);
 	} else if ((strncmp(pbuf, "scsi_on", sizeof("scsi_on") - 1) == 0)) {
-		phba->cpucheck_on |= LPFC_CHECK_SCSI_IO;
+		if (!phba->nvmet_support)
+			phba->hdwqstat_on |= LPFC_CHECK_SCSI_IO;
 		return strlen(pbuf);
-	} else if ((strncmp(pbuf, "rcv",
-		   sizeof("rcv") - 1) == 0)) {
-		if (phba->nvmet_support)
-			phba->cpucheck_on |= LPFC_CHECK_NVMET_RCV;
-		else
-			return -EINVAL;
+	} else if ((strncmp(pbuf, "nvme_off", sizeof("nvme_off") - 1) == 0)) {
+		phba->hdwqstat_on &= ~(LPFC_CHECK_NVME_IO |
+				       LPFC_CHECK_NVMET_IO);
+		return strlen(pbuf);
+	} else if ((strncmp(pbuf, "scsi_off", sizeof("scsi_off") - 1) == 0)) {
+		phba->hdwqstat_on &= ~LPFC_CHECK_SCSI_IO;
 		return strlen(pbuf);
 	} else if ((strncmp(pbuf, "off",
 		   sizeof("off") - 1) == 0)) {
-		phba->cpucheck_on = LPFC_CHECK_OFF;
+		phba->hdwqstat_on = LPFC_CHECK_OFF;
 		return strlen(pbuf);
 	} else if ((strncmp(pbuf, "zero",
 		   sizeof("zero") - 1) == 0)) {
-		for (i = 0; i < phba->cfg_hdw_queue; i++) {
-			qp = &phba->sli4_hba.hdwq[i];
-
-			for (j = 0; j < LPFC_CHECK_CPU_CNT; j++) {
-				qp->cpucheck_rcv_io[j] = 0;
-				qp->cpucheck_xmt_io[j] = 0;
-				qp->cpucheck_cmpl_io[j] = 0;
-			}
+		for_each_present_cpu(i) {
+			c_stat = per_cpu_ptr(phba->sli4_hba.c_stat, i);
+			c_stat->xmt_io = 0;
+			c_stat->cmpl_io = 0;
+			c_stat->rcv_io = 0;
 		}
 		return strlen(pbuf);
 	}
@@ -5451,13 +5487,13 @@ static const struct file_operations lpfc_debugfs_op_nvmeio_trc = {
 	.release =      lpfc_debugfs_release,
 };
 
-#undef lpfc_debugfs_op_cpucheck
-static const struct file_operations lpfc_debugfs_op_cpucheck = {
+#undef lpfc_debugfs_op_hdwqstat
+static const struct file_operations lpfc_debugfs_op_hdwqstat = {
 	.owner =        THIS_MODULE,
-	.open =         lpfc_debugfs_cpucheck_open,
+	.open =         lpfc_debugfs_hdwqstat_open,
 	.llseek =       lpfc_debugfs_lseek,
 	.read =         lpfc_debugfs_read,
-	.write =	lpfc_debugfs_cpucheck_write,
+	.write =	lpfc_debugfs_hdwqstat_write,
 	.release =      lpfc_debugfs_release,
 };
 
@@ -6081,11 +6117,11 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 				    vport->vport_debugfs_root,
 				    vport, &lpfc_debugfs_op_nvmektime);
 
-	snprintf(name, sizeof(name), "cpucheck");
-	vport->debug_cpucheck =
+	snprintf(name, sizeof(name), "hdwqstat");
+	vport->debug_hdwqstat =
 		debugfs_create_file(name, 0644,
 				    vport->vport_debugfs_root,
-				    vport, &lpfc_debugfs_op_cpucheck);
+				    vport, &lpfc_debugfs_op_hdwqstat);
 
 	/*
 	 * The following section is for additional directories/files for the
@@ -6219,8 +6255,8 @@ lpfc_debugfs_terminate(struct lpfc_vport *vport)
 	debugfs_remove(vport->debug_nvmektime); /* nvmektime */
 	vport->debug_nvmektime = NULL;
 
-	debugfs_remove(vport->debug_cpucheck); /* cpucheck */
-	vport->debug_cpucheck = NULL;
+	debugfs_remove(vport->debug_hdwqstat); /* hdwqstat */
+	vport->debug_hdwqstat = NULL;
 
 	if (vport->vport_debugfs_root) {
 		debugfs_remove(vport->vport_debugfs_root); /* vportX */
diff --git a/drivers/scsi/lpfc/lpfc_debugfs.h b/drivers/scsi/lpfc/lpfc_debugfs.h
index 20f2537af511..6643b9bfd4f3 100644
--- a/drivers/scsi/lpfc/lpfc_debugfs.h
+++ b/drivers/scsi/lpfc/lpfc_debugfs.h
@@ -47,7 +47,6 @@
 /* nvmestat output buffer size */
 #define LPFC_NVMESTAT_SIZE 8192
 #define LPFC_NVMEKTIME_SIZE 8192
-#define LPFC_CPUCHECK_SIZE 8192
 #define LPFC_NVMEIO_TRC_SIZE 8192
 
 /* scsistat output buffer size */
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 1dadf247a0aa..4104bdcdbb6f 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -6951,6 +6951,17 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
 		rc = -ENOMEM;
 		goto out_free_hba_cpu_map;
 	}
+
+#ifdef CONFIG_SCSI_LPFC_DEBUG_FS
+	phba->sli4_hba.c_stat = alloc_percpu(struct lpfc_hdwq_stat);
+	if (!phba->sli4_hba.c_stat) {
+		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+				"3332 Failed allocating per cpu hdwq stats\n");
+		rc = -ENOMEM;
+		goto out_free_hba_eq_info;
+	}
+#endif
+
 	/*
 	 * Enable sr-iov virtual functions if supported and configured
 	 * through the module parameter.
@@ -6970,6 +6981,10 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
 
 	return 0;
 
+#ifdef CONFIG_SCSI_LPFC_DEBUG_FS
+out_free_hba_eq_info:
+	free_percpu(phba->sli4_hba.eq_info);
+#endif
 out_free_hba_cpu_map:
 	kfree(phba->sli4_hba.cpu_map);
 out_free_hba_eq_hdl:
@@ -7008,6 +7023,9 @@ lpfc_sli4_driver_resource_unset(struct lpfc_hba *phba)
 	struct lpfc_fcf_conn_entry *conn_entry, *next_conn_entry;
 
 	free_percpu(phba->sli4_hba.eq_info);
+#ifdef CONFIG_SCSI_LPFC_DEBUG_FS
+	free_percpu(phba->sli4_hba.c_stat);
+#endif
 
 	/* Free memory allocated for msi-x interrupt vector to CPU mapping */
 	kfree(phba->sli4_hba.cpu_map);
@@ -10848,6 +10866,9 @@ lpfc_cpu_affinity_check(struct lpfc_hba *phba, int vectors)
 #ifdef CONFIG_X86
 	struct cpuinfo_x86 *cpuinfo;
 #endif
+#ifdef CONFIG_SCSI_LPFC_DEBUG_FS
+	struct lpfc_hdwq_stat *c_stat;
+#endif
 
 	max_phys_id = 0;
 	min_phys_id = LPFC_VECTOR_MAP_EMPTY;
@@ -11099,10 +11120,17 @@ lpfc_cpu_affinity_check(struct lpfc_hba *phba, int vectors)
 	idx = 0;
 	for_each_possible_cpu(cpu) {
 		cpup = &phba->sli4_hba.cpu_map[cpu];
+#ifdef CONFIG_SCSI_LPFC_DEBUG_FS
+		c_stat = per_cpu_ptr(phba->sli4_hba.c_stat, cpu);
+		c_stat->hdwq_no = cpup->hdwq;
+#endif
 		if (cpup->hdwq != LPFC_VECTOR_MAP_EMPTY)
 			continue;
 
 		cpup->hdwq = idx++ % phba->cfg_hdw_queue;
+#ifdef CONFIG_SCSI_LPFC_DEBUG_FS
+		c_stat->hdwq_no = cpup->hdwq;
+#endif
 		lpfc_printf_log(phba, KERN_INFO, LOG_INIT,
 				"3340 Set Affinity: not present "
 				"CPU %d hdwq %d\n",
diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
index 32b28651039e..38936b7ce043 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -1012,6 +1012,9 @@ lpfc_nvme_io_cmd_wqe_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *pwqeIn,
 	uint32_t code, status, idx;
 	uint16_t cid, sqhd, data;
 	uint32_t *ptr;
+#ifdef CONFIG_SCSI_LPFC_DEBUG_FS
+	int cpu;
+#endif
 
 	/* Sanity check on return of outstanding command */
 	if (!lpfc_ncmd) {
@@ -1184,19 +1187,15 @@ lpfc_nvme_io_cmd_wqe_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *pwqeIn,
 		phba->ktime_last_cmd = lpfc_ncmd->ts_data_nvme;
 		lpfc_nvme_ktime(phba, lpfc_ncmd);
 	}
-	if (unlikely(phba->cpucheck_on & LPFC_CHECK_NVME_IO)) {
-		uint32_t cpu;
-		idx = lpfc_ncmd->cur_iocbq.hba_wqidx;
+	if (unlikely(phba->hdwqstat_on & LPFC_CHECK_NVME_IO)) {
 		cpu = raw_smp_processor_id();
-		if (cpu < LPFC_CHECK_CPU_CNT) {
-			if (lpfc_ncmd->cpu != cpu)
-				lpfc_printf_vlog(vport,
-						 KERN_INFO, LOG_NVME_IOERR,
-						 "6701 CPU Check cmpl: "
-						 "cpu %d expect %d\n",
-						 cpu, lpfc_ncmd->cpu);
-			phba->sli4_hba.hdwq[idx].cpucheck_cmpl_io[cpu]++;
-		}
+		this_cpu_inc(phba->sli4_hba.c_stat->cmpl_io);
+		if (lpfc_ncmd->cpu != cpu)
+			lpfc_printf_vlog(vport,
+					 KERN_INFO, LOG_NVME_IOERR,
+					 "6701 CPU Check cmpl: "
+					 "cpu %d expect %d\n",
+					 cpu, lpfc_ncmd->cpu);
 	}
 #endif
 
@@ -1745,19 +1744,17 @@ lpfc_nvme_fcp_io_submit(struct nvme_fc_local_port *pnvme_lport,
 	if (lpfc_ncmd->ts_cmd_start)
 		lpfc_ncmd->ts_cmd_wqput = ktime_get_ns();
 
-	if (phba->cpucheck_on & LPFC_CHECK_NVME_IO) {
+	if (phba->hdwqstat_on & LPFC_CHECK_NVME_IO) {
 		cpu = raw_smp_processor_id();
-		if (cpu < LPFC_CHECK_CPU_CNT) {
-			lpfc_ncmd->cpu = cpu;
-			if (idx != cpu)
-				lpfc_printf_vlog(vport,
-						 KERN_INFO, LOG_NVME_IOERR,
-						"6702 CPU Check cmd: "
-						"cpu %d wq %d\n",
-						lpfc_ncmd->cpu,
-						lpfc_queue_info->index);
-			phba->sli4_hba.hdwq[idx].cpucheck_xmt_io[cpu]++;
-		}
+		this_cpu_inc(phba->sli4_hba.c_stat->xmt_io);
+		lpfc_ncmd->cpu = cpu;
+		if (idx != cpu)
+			lpfc_printf_vlog(vport,
+					 KERN_INFO, LOG_NVME_IOERR,
+					"6702 CPU Check cmd: "
+					"cpu %d wq %d\n",
+					lpfc_ncmd->cpu,
+					lpfc_queue_info->index);
 	}
 #endif
 	return 0;
diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index ae89d1450912..565419bf8d74 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -707,7 +707,7 @@ lpfc_nvmet_xmt_fcp_op_cmp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
 	struct lpfc_nvmet_rcv_ctx *ctxp;
 	uint32_t status, result, op, start_clean, logerr;
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
-	uint32_t id;
+	int id;
 #endif
 
 	ctxp = cmdwqe->context2;
@@ -814,16 +814,14 @@ lpfc_nvmet_xmt_fcp_op_cmp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
 		rsp->done(rsp);
 	}
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
-	if (phba->cpucheck_on & LPFC_CHECK_NVMET_IO) {
+	if (phba->hdwqstat_on & LPFC_CHECK_NVMET_IO) {
 		id = raw_smp_processor_id();
-		if (id < LPFC_CHECK_CPU_CNT) {
-			if (ctxp->cpu != id)
-				lpfc_printf_log(phba, KERN_INFO, LOG_NVME_IOERR,
-						"6704 CPU Check cmdcmpl: "
-						"cpu %d expect %d\n",
-						id, ctxp->cpu);
-			phba->sli4_hba.hdwq[rsp->hwqid].cpucheck_cmpl_io[id]++;
-		}
+		this_cpu_inc(phba->sli4_hba.c_stat->cmpl_io);
+		if (ctxp->cpu != id)
+			lpfc_printf_log(phba, KERN_INFO, LOG_NVME_IOERR,
+					"6704 CPU Check cmdcmpl: "
+					"cpu %d expect %d\n",
+					id, ctxp->cpu);
 	}
 #endif
 }
@@ -931,6 +929,9 @@ lpfc_nvmet_xmt_fcp_op(struct nvmet_fc_target_port *tgtport,
 	struct lpfc_sli_ring *pring;
 	unsigned long iflags;
 	int rc;
+#ifdef CONFIG_SCSI_LPFC_DEBUG_FS
+	int id;
+#endif
 
 	if (phba->pport->load_flag & FC_UNLOADING) {
 		rc = -ENODEV;
@@ -954,16 +955,14 @@ lpfc_nvmet_xmt_fcp_op(struct nvmet_fc_target_port *tgtport,
 	if (!ctxp->hdwq)
 		ctxp->hdwq = &phba->sli4_hba.hdwq[rsp->hwqid];
 
-	if (phba->cpucheck_on & LPFC_CHECK_NVMET_IO) {
-		int id = raw_smp_processor_id();
-		if (id < LPFC_CHECK_CPU_CNT) {
-			if (rsp->hwqid != id)
-				lpfc_printf_log(phba, KERN_INFO, LOG_NVME_IOERR,
-						"6705 CPU Check OP: "
-						"cpu %d expect %d\n",
-						id, rsp->hwqid);
-			phba->sli4_hba.hdwq[rsp->hwqid].cpucheck_xmt_io[id]++;
-		}
+	if (phba->hdwqstat_on & LPFC_CHECK_NVMET_IO) {
+		id = raw_smp_processor_id();
+		this_cpu_inc(phba->sli4_hba.c_stat->xmt_io);
+		if (rsp->hwqid != id)
+			lpfc_printf_log(phba, KERN_INFO, LOG_NVME_IOERR,
+					"6705 CPU Check OP: "
+					"cpu %d expect %d\n",
+					id, rsp->hwqid);
 		ctxp->cpu = id; /* Setup cpu for cmpl check */
 	}
 #endif
@@ -2270,15 +2269,13 @@ lpfc_nvmet_unsol_fcp_buffer(struct lpfc_hba *phba,
 	size = nvmebuf->bytes_recv;
 
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
-	if (phba->cpucheck_on & LPFC_CHECK_NVMET_RCV) {
-		if (current_cpu < LPFC_CHECK_CPU_CNT) {
-			if (idx != current_cpu)
-				lpfc_printf_log(phba, KERN_INFO, LOG_NVME_IOERR,
-						"6703 CPU Check rcv: "
-						"cpu %d expect %d\n",
-						current_cpu, idx);
-			phba->sli4_hba.hdwq[idx].cpucheck_rcv_io[current_cpu]++;
-		}
+	if (phba->hdwqstat_on & LPFC_CHECK_NVMET_IO) {
+		this_cpu_inc(phba->sli4_hba.c_stat->rcv_io);
+		if (idx != current_cpu)
+			lpfc_printf_log(phba, KERN_INFO, LOG_NVME_IOERR,
+					"6703 CPU Check rcv: "
+					"cpu %d expect %d\n",
+					current_cpu, idx);
 	}
 #endif
 
diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index be62795715f7..3caa4fd2b55f 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -3805,9 +3805,6 @@ lpfc_scsi_cmd_iocb_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *pIocbIn,
 	struct Scsi_Host *shost;
 	int idx;
 	uint32_t logit = LOG_FCP;
-#ifdef CONFIG_SCSI_LPFC_DEBUG_FS
-	int cpu;
-#endif
 
 	/* Guard against abort handler being called at same time */
 	spin_lock(&lpfc_cmd->buf_lock);
@@ -3826,11 +3823,8 @@ lpfc_scsi_cmd_iocb_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *pIocbIn,
 		phba->sli4_hba.hdwq[idx].scsi_cstat.io_cmpls++;
 
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
-	if (unlikely(phba->cpucheck_on & LPFC_CHECK_SCSI_IO)) {
-		cpu = raw_smp_processor_id();
-		if (cpu < LPFC_CHECK_CPU_CNT && phba->sli4_hba.hdwq)
-			phba->sli4_hba.hdwq[idx].cpucheck_cmpl_io[cpu]++;
-	}
+	if (unlikely(phba->hdwqstat_on & LPFC_CHECK_SCSI_IO))
+		this_cpu_inc(phba->sli4_hba.c_stat->cmpl_io);
 #endif
 	shost = cmd->device->host;
 
@@ -4503,9 +4497,6 @@ lpfc_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *cmnd)
 	struct lpfc_io_buf *lpfc_cmd;
 	struct fc_rport *rport = starget_to_rport(scsi_target(cmnd->device));
 	int err, idx;
-#ifdef CONFIG_SCSI_LPFC_DEBUG_FS
-	int cpu;
-#endif
 
 	rdata = lpfc_rport_data_from_scsi_device(cmnd->device);
 
@@ -4626,14 +4617,8 @@ lpfc_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *cmnd)
 	lpfc_scsi_prep_cmnd(vport, lpfc_cmd, ndlp);
 
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
-	if (unlikely(phba->cpucheck_on & LPFC_CHECK_SCSI_IO)) {
-		cpu = raw_smp_processor_id();
-		if (cpu < LPFC_CHECK_CPU_CNT) {
-			struct lpfc_sli4_hdw_queue *hdwq =
-					&phba->sli4_hba.hdwq[lpfc_cmd->hdwq_no];
-			hdwq->cpucheck_xmt_io[cpu]++;
-		}
-	}
+	if (unlikely(phba->hdwqstat_on & LPFC_CHECK_SCSI_IO))
+		this_cpu_inc(phba->sli4_hba.c_stat->xmt_io);
 #endif
 	err = lpfc_sli_issue_iocb(phba, LPFC_FCP_RING,
 				  &lpfc_cmd->cur_iocbq, SLI_IOCB_RET_IOCB);
diff --git a/drivers/scsi/lpfc/lpfc_sli4.h b/drivers/scsi/lpfc/lpfc_sli4.h
index d963ca871383..8da7429e385a 100644
--- a/drivers/scsi/lpfc/lpfc_sli4.h
+++ b/drivers/scsi/lpfc/lpfc_sli4.h
@@ -697,13 +697,6 @@ struct lpfc_sli4_hdw_queue {
 	struct lpfc_lock_stat lock_conflict;
 #endif
 
-#ifdef CONFIG_SCSI_LPFC_DEBUG_FS
-#define LPFC_CHECK_CPU_CNT    128
-	uint32_t cpucheck_rcv_io[LPFC_CHECK_CPU_CNT];
-	uint32_t cpucheck_xmt_io[LPFC_CHECK_CPU_CNT];
-	uint32_t cpucheck_cmpl_io[LPFC_CHECK_CPU_CNT];
-#endif
-
 	/* Per HDWQ pool resources */
 	struct list_head sgl_list;
 	struct list_head cmd_rsp_buf_list;
@@ -740,6 +733,15 @@ struct lpfc_sli4_hdw_queue {
 #define lpfc_qp_spin_lock(lock, qp, lstat) spin_lock(lock)
 #endif
 
+#ifdef CONFIG_SCSI_LPFC_DEBUG_FS
+struct lpfc_hdwq_stat {
+	u32 hdwq_no;
+	u32 rcv_io;
+	u32 xmt_io;
+	u32 cmpl_io;
+};
+#endif
+
 struct lpfc_sli4_hba {
 	void __iomem *conf_regs_memmap_p; /* Kernel memory mapped address for
 					   * config space registers
@@ -921,6 +923,9 @@ struct lpfc_sli4_hba {
 	struct cpumask numa_mask;
 	uint16_t curr_disp_cpu;
 	struct lpfc_eq_intr_info __percpu *eq_info;
+#ifdef CONFIG_SCSI_LPFC_DEBUG_FS
+	struct lpfc_hdwq_stat __percpu *c_stat;
+#endif
 	uint32_t conf_trunk;
 #define lpfc_conf_trunk_port0_WORD	conf_trunk
 #define lpfc_conf_trunk_port0_SHIFT	0
-- 
2.16.4

