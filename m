Return-Path: <linux-scsi+bounces-9948-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DFC9CDED8
	for <lists+linux-scsi@lfdr.de>; Fri, 15 Nov 2024 14:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB373283930
	for <lists+linux-scsi@lfdr.de>; Fri, 15 Nov 2024 13:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3611BD014;
	Fri, 15 Nov 2024 13:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="diP3jVgx"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18621BBBEB
	for <linux-scsi@vger.kernel.org>; Fri, 15 Nov 2024 13:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731675823; cv=none; b=lLZgR/YFLymf8xHpjEw3j1NPw8AH9f508ArdJK9cEI+9HB5Cr37SpWyqYCZM5LNnP2q1zZ1OAD2wwyaC2WRCAU0ZpMJuBj7BmiXLjByphidoX5JU1YKWnCNhCFp2uBWY+j0Kfhz3xHdC47RDvhGm6qzK5IdR8Lv7c3/KPCMg9Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731675823; c=relaxed/simple;
	bh=d0Jk32LAVWCsrR2R9yjRNTCt7YxOC91w7aV8OHpRH1Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uSmCGihfpdrHPZZ8v9l9riQjxRV07GCFHtSGI4H3fxjxBCnvGt5wNYFNBEPF9bJgqhxwd3v6Sjx0D9FkCtaCp4h/iU8KYPbmC82XVKAvMCNRUfX0C6wKs9wDbMJPAyLaWKOWZDdwVlvROJt4yHvLjpGyCAgd8Hq7qE/wpUQBQ24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=diP3jVgx; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFCokul016585;
	Fri, 15 Nov 2024 05:03:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=K
	9PW9khijQ2alL+g7eGqVZGhwqYYjLjsoYhw1F2qwO4=; b=diP3jVgxqvCZlw5yk
	zfqmDfU/udmKUJJO+M737jG2DHvmG6O2NwHdS2KugtpJHsmaS1diedigPTu50Tys
	kU8+Y3NND8CNjcgMwu1Le1MtmEVvH5tonVjyuE5PMT0CQ9UxfIphFTyzMjEyUUfX
	kxEcWufkLG1sEAHtoEapq+nfdD8+9QYUbE/VgGDX5+e2N2k3NGQ1jYelchSf87TT
	zhHNqUEpT8XGKlnahOAR0HRZD7fE45yVqsU1lTFmjx777aTe9EP5GNDhi6QmE9JW
	MikcsxTqRHEyHOxZeJ2Xg8OFTb3uWRLWHMi2oAMw4SZPR0PxOTn0wNFiOkkldILr
	rtsgA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42weeau168-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 05:03:39 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 15 Nov 2024 05:03:37 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 15 Nov 2024 05:03:37 -0800
Received: from stgdev-a5u16.punelab.marvell.com (stgdev-a5u16.punelab.marvell.com [10.31.33.187])
	by maili.marvell.com (Postfix) with ESMTP id A36433F708A;
	Fri, 15 Nov 2024 05:03:35 -0800 (PST)
From: Nilesh Javali <njavali@marvell.com>
To: <martin.petersen@oracle.com>
CC: <linux-scsi@vger.kernel.org>, <GR-QLogic-Storage-Upstream@marvell.com>,
        <agurumurthy@marvell.com>, <sdeodhar@marvell.com>, <emilne@redhat.com>,
        <jmeneghi@redhat.com>
Subject: [PATCH 3/7] qla2xxx: Move FCE Trace buffer allocation to user control
Date: Fri, 15 Nov 2024 18:33:09 +0530
Message-ID: <20241115130313.46826-4-njavali@marvell.com>
X-Mailer: git-send-email 2.23.1
In-Reply-To: <20241115130313.46826-1-njavali@marvell.com>
References: <20241115130313.46826-1-njavali@marvell.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: eWbWTJf5YxavpHfFbXiaD2y8nxwRHE1D
X-Proofpoint-ORIG-GUID: eWbWTJf5YxavpHfFbXiaD2y8nxwRHE1D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

From: Quinn Tran <qutran@marvell.com>

Currently FCE Tracing is enabled to
log additional ELS events. Instead, user will
enable or disable this feature through debug FS.

Modify existing DFS knob to allow user to
enable or disable this feature.

echo [1 | 0] > /sys/kernel/debug/qla2xxx/qla2xxx_??/fce
cat  /sys/kernel/debug/qla2xxx/qla2xxx_??/fce

Cc: stable@vger.kernel.org
Fixes: df613b96077c ("[SCSI] qla2xxx: Add Fibre Channel Event (FCE) tracing support.")
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
---
 drivers/scsi/qla2xxx/qla_def.h  |   2 +
 drivers/scsi/qla2xxx/qla_dfs.c  | 124 ++++++++++++++++++++++++++------
 drivers/scsi/qla2xxx/qla_gbl.h  |   3 +
 drivers/scsi/qla2xxx/qla_init.c |  28 +++++---
 4 files changed, 126 insertions(+), 31 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 15066c112817..cb95b7b12051 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -4098,6 +4098,8 @@ struct qla_hw_data {
 		uint32_t	npiv_supported		:1;
 		uint32_t	pci_channel_io_perm_failure	:1;
 		uint32_t	fce_enabled		:1;
+		uint32_t	user_enabled_fce	:1;
+		uint32_t	fce_dump_buf_alloced	:1;
 		uint32_t	fac_supported		:1;
 
 		uint32_t	chip_reset_done		:1;
diff --git a/drivers/scsi/qla2xxx/qla_dfs.c b/drivers/scsi/qla2xxx/qla_dfs.c
index a1545dad0c0c..08273520c777 100644
--- a/drivers/scsi/qla2xxx/qla_dfs.c
+++ b/drivers/scsi/qla2xxx/qla_dfs.c
@@ -409,26 +409,31 @@ qla2x00_dfs_fce_show(struct seq_file *s, void *unused)
 
 	mutex_lock(&ha->fce_mutex);
 
-	seq_puts(s, "FCE Trace Buffer\n");
-	seq_printf(s, "In Pointer = %llx\n\n", (unsigned long long)ha->fce_wr);
-	seq_printf(s, "Base = %llx\n\n", (unsigned long long) ha->fce_dma);
-	seq_puts(s, "FCE Enable Registers\n");
-	seq_printf(s, "%08x %08x %08x %08x %08x %08x\n",
-	    ha->fce_mb[0], ha->fce_mb[2], ha->fce_mb[3], ha->fce_mb[4],
-	    ha->fce_mb[5], ha->fce_mb[6]);
-
-	fce = (uint32_t *) ha->fce;
-	fce_start = (unsigned long long) ha->fce_dma;
-	for (cnt = 0; cnt < fce_calc_size(ha->fce_bufs) / 4; cnt++) {
-		if (cnt % 8 == 0)
-			seq_printf(s, "\n%llx: ",
-			    (unsigned long long)((cnt * 4) + fce_start));
-		else
-			seq_putc(s, ' ');
-		seq_printf(s, "%08x", *fce++);
-	}
+	if (ha->flags.user_enabled_fce) {
+		seq_puts(s, "FCE Trace Buffer\n");
+		seq_printf(s, "In Pointer = %llx\n\n", (unsigned long long)ha->fce_wr);
+		seq_printf(s, "Base = %llx\n\n", (unsigned long long)ha->fce_dma);
+		seq_puts(s, "FCE Enable Registers\n");
+		seq_printf(s, "%08x %08x %08x %08x %08x %08x\n",
+			   ha->fce_mb[0], ha->fce_mb[2], ha->fce_mb[3], ha->fce_mb[4],
+			   ha->fce_mb[5], ha->fce_mb[6]);
+
+		fce = (uint32_t *)ha->fce;
+		fce_start = (unsigned long long)ha->fce_dma;
+		for (cnt = 0; cnt < fce_calc_size(ha->fce_bufs) / 4; cnt++) {
+			if (cnt % 8 == 0)
+				seq_printf(s, "\n%llx: ",
+					   (unsigned long long)((cnt * 4) + fce_start));
+			else
+				seq_putc(s, ' ');
+			seq_printf(s, "%08x", *fce++);
+		}
 
-	seq_puts(s, "\nEnd\n");
+		seq_puts(s, "\nEnd\n");
+	} else {
+		seq_puts(s, "FCE Trace is currently not enabled\n");
+		seq_puts(s, "\techo [ 1 | 0 ] > fce\n");
+	}
 
 	mutex_unlock(&ha->fce_mutex);
 
@@ -467,7 +472,7 @@ qla2x00_dfs_fce_release(struct inode *inode, struct file *file)
 	struct qla_hw_data *ha = vha->hw;
 	int rval;
 
-	if (ha->flags.fce_enabled)
+	if (ha->flags.fce_enabled || !ha->fce)
 		goto out;
 
 	mutex_lock(&ha->fce_mutex);
@@ -488,11 +493,88 @@ qla2x00_dfs_fce_release(struct inode *inode, struct file *file)
 	return single_release(inode, file);
 }
 
+static ssize_t
+qla2x00_dfs_fce_write(struct file *file, const char __user *buffer,
+		      size_t count, loff_t *pos)
+{
+	struct seq_file *s = file->private_data;
+	struct scsi_qla_host *vha = s->private;
+	struct qla_hw_data *ha = vha->hw;
+	char *buf;
+	int rc = 0;
+	unsigned long enable;
+
+	if (!IS_QLA25XX(ha) && !IS_QLA81XX(ha) && !IS_QLA83XX(ha) &&
+	    !IS_QLA27XX(ha) && !IS_QLA28XX(ha)) {
+		ql_dbg(ql_dbg_user, vha, 0xd034,
+		       "this adapter does not support FCE.");
+		return -EINVAL;
+	}
+
+	buf = memdup_user_nul(buffer, count);
+	if (IS_ERR(buf)) {
+		ql_dbg(ql_dbg_user, vha, 0xd037,
+		    "fail to copy user buffer.");
+		return PTR_ERR(buf);
+	}
+
+	enable = kstrtoul(buf, 0, 0);
+	rc = count;
+
+	mutex_lock(&ha->fce_mutex);
+
+	if (enable) {
+		if (ha->flags.user_enabled_fce) {
+			mutex_unlock(&ha->fce_mutex);
+			goto out_free;
+		}
+		ha->flags.user_enabled_fce = 1;
+		if (!ha->fce) {
+			rc = qla2x00_alloc_fce_trace(vha);
+			if (rc) {
+				ha->flags.user_enabled_fce = 0;
+				mutex_unlock(&ha->fce_mutex);
+				goto out_free;
+			}
+
+			/* adjust fw dump buffer to take into account of this feature */
+			if (!ha->flags.fce_dump_buf_alloced)
+				qla2x00_alloc_fw_dump(vha);
+		}
+
+		if (!ha->flags.fce_enabled)
+			qla_enable_fce_trace(vha);
+
+		ql_dbg(ql_dbg_user, vha, 0xd045, "User enabled FCE .\n");
+	} else {
+		if (!ha->flags.user_enabled_fce) {
+			mutex_unlock(&ha->fce_mutex);
+			goto out_free;
+		}
+		ha->flags.user_enabled_fce = 0;
+		if (ha->flags.fce_enabled) {
+			qla2x00_disable_fce_trace(vha, NULL, NULL);
+			ha->flags.fce_enabled = 0;
+		}
+
+		qla2x00_free_fce_trace(ha);
+		/* no need to re-adjust fw dump buffer */
+
+		ql_dbg(ql_dbg_user, vha, 0xd04f, "User disabled FCE .\n");
+	}
+
+	mutex_unlock(&ha->fce_mutex);
+out_free:
+	kfree(buf);
+	return rc;
+}
+
 static const struct file_operations dfs_fce_ops = {
 	.open		= qla2x00_dfs_fce_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
 	.release	= qla2x00_dfs_fce_release,
+	.write		= qla2x00_dfs_fce_write,
 };
 
 static int
@@ -626,8 +708,6 @@ qla2x00_dfs_setup(scsi_qla_host_t *vha)
 	if (!IS_QLA25XX(ha) && !IS_QLA81XX(ha) && !IS_QLA83XX(ha) &&
 	    !IS_QLA27XX(ha) && !IS_QLA28XX(ha))
 		goto out;
-	if (!ha->fce)
-		goto out;
 
 	if (qla2x00_dfs_root)
 		goto create_dir;
diff --git a/drivers/scsi/qla2xxx/qla_gbl.h b/drivers/scsi/qla2xxx/qla_gbl.h
index cededfda9d0e..e556f57c91af 100644
--- a/drivers/scsi/qla2xxx/qla_gbl.h
+++ b/drivers/scsi/qla2xxx/qla_gbl.h
@@ -11,6 +11,9 @@
 /*
  * Global Function Prototypes in qla_init.c source file.
  */
+int  qla2x00_alloc_fce_trace(scsi_qla_host_t *);
+void qla2x00_free_fce_trace(struct qla_hw_data *ha);
+void qla_enable_fce_trace(scsi_qla_host_t *);
 extern int qla2x00_initialize_adapter(scsi_qla_host_t *);
 extern int qla24xx_post_prli_work(struct scsi_qla_host *vha, fc_port_t *fcport);
 
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 31fc6a0eca3e..79cdfec2bca3 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -2681,7 +2681,7 @@ qla83xx_nic_core_fw_load(scsi_qla_host_t *vha)
 	return rval;
 }
 
-static void qla_enable_fce_trace(scsi_qla_host_t *vha)
+void qla_enable_fce_trace(scsi_qla_host_t *vha)
 {
 	int rval;
 	struct qla_hw_data *ha = vha->hw;
@@ -3717,25 +3717,24 @@ qla24xx_chip_diag(scsi_qla_host_t *vha)
 	return rval;
 }
 
-static void
-qla2x00_alloc_fce_trace(scsi_qla_host_t *vha)
+int qla2x00_alloc_fce_trace(scsi_qla_host_t *vha)
 {
 	dma_addr_t tc_dma;
 	void *tc;
 	struct qla_hw_data *ha = vha->hw;
 
 	if (!IS_FWI2_CAPABLE(ha))
-		return;
+		return -EINVAL;
 
 	if (!IS_QLA25XX(ha) && !IS_QLA81XX(ha) && !IS_QLA83XX(ha) &&
 	    !IS_QLA27XX(ha) && !IS_QLA28XX(ha))
-		return;
+		return -EINVAL;
 
 	if (ha->fce) {
 		ql_dbg(ql_dbg_init, vha, 0x00bd,
 		       "%s: FCE Mem is already allocated.\n",
 		       __func__);
-		return;
+		return -EIO;
 	}
 
 	/* Allocate memory for Fibre Channel Event Buffer. */
@@ -3745,7 +3744,7 @@ qla2x00_alloc_fce_trace(scsi_qla_host_t *vha)
 		ql_log(ql_log_warn, vha, 0x00be,
 		       "Unable to allocate (%d KB) for FCE.\n",
 		       FCE_SIZE / 1024);
-		return;
+		return -ENOMEM;
 	}
 
 	ql_dbg(ql_dbg_init, vha, 0x00c0,
@@ -3754,6 +3753,16 @@ qla2x00_alloc_fce_trace(scsi_qla_host_t *vha)
 	ha->fce_dma = tc_dma;
 	ha->fce = tc;
 	ha->fce_bufs = FCE_NUM_BUFFERS;
+	return 0;
+}
+
+void qla2x00_free_fce_trace(struct qla_hw_data *ha)
+{
+	if (!ha->fce)
+		return;
+	dma_free_coherent(&ha->pdev->dev, FCE_SIZE, ha->fce, ha->fce_dma);
+	ha->fce = NULL;
+	ha->fce_dma = 0;
 }
 
 static void
@@ -3844,9 +3853,10 @@ qla2x00_alloc_fw_dump(scsi_qla_host_t *vha)
 		if (ha->tgt.atio_ring)
 			mq_size += ha->tgt.atio_q_length * sizeof(request_t);
 
-		qla2x00_alloc_fce_trace(vha);
-		if (ha->fce)
+		if (ha->fce) {
 			fce_size = sizeof(struct qla2xxx_fce_chain) + FCE_SIZE;
+			ha->flags.fce_dump_buf_alloced = 1;
+		}
 		qla2x00_alloc_eft_trace(vha);
 		if (ha->eft)
 			eft_size = EFT_SIZE;
-- 
2.23.1


