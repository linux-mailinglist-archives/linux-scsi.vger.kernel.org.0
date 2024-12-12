Return-Path: <linux-scsi+bounces-10810-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C07609EDD69
	for <lists+linux-scsi@lfdr.de>; Thu, 12 Dec 2024 03:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 137852815FC
	for <lists+linux-scsi@lfdr.de>; Thu, 12 Dec 2024 02:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1827B127E18;
	Thu, 12 Dec 2024 02:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="LY2eqAba"
X-Original-To: linux-scsi@vger.kernel.org
Received: from rcdn-iport-2.cisco.com (rcdn-iport-2.cisco.com [173.37.86.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD8C5C8F7;
	Thu, 12 Dec 2024 02:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733969498; cv=none; b=p4eyjkVo2JjgEpEluOneY5S4PyxouncFIAR+w5T6fKY/rJl/+1ca0OqGNn0i9y9Xm0N86BrK2Hvl4pXsc39xX3Zcff70k0O88w4rkPpPquCOhXUxw9S1B5PrAh68s+aXDp9XJJmyEeRb19TjeWEasnVL6RaAN2c7t6KycyKsRAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733969498; c=relaxed/simple;
	bh=Ebe5OTHUuXmLEn6eZouJDS9+Cce9BL4QCN0l/vKV9c4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RMyqXpmQ5OWkT2J2rnlrVoiZSp5lyJvubxRwyHB/KOn6Myih4Vx465TJgBImJ1THlR37k1biTq4XJJdQjhbeswPHpiAZNXXTsM9HLvbZmRFqobtfoHcQxBt68tuuLaMdKUOR6b2AKVcLkp/M8Rz51AvdrYaZ9UjIibxLgAWV8zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=LY2eqAba; arc=none smtp.client-ip=173.37.86.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=41695; q=dns/txt;
  s=iport; t=1733969496; x=1735179096;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rV33pQt9fS0320oFsUUFaasE6H3wEa1h4hZmfa8lSaY=;
  b=LY2eqAbaVnMSL1uulOCr/WMA9CD4HWDjCABT4NVqQdyN5ixLVgM7NX9O
   DG5VaCGHV91M6UWpPBm0qeqzQaXpTAQ2CLGA5sOn2ORRssiSO9DcFQ989
   L6Ety/1hHBrin/LKgW76zgDfXWAsIzdD/qE5FfjphXkvtm58Wgasvly39
   k=;
X-CSE-ConnectionGUID: bxdylylkToOhdOuc8Rrxfw==
X-CSE-MsgGUID: olm9171ES7K1LbBZC+I05w==
X-IPAS-Result: =?us-ascii?q?A0ApAACMRVpn/5T/Ja1aHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?wcBAQsBghsvgU9DGS+McolRgRadBYElA1YPAQEBD0QEAQGFBwKKawImNAkOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQEBAQEBCwEBBQEBAQIBBwWBDhOGCIZbAgEDGgEMC?=
 =?us-ascii?q?wFGEFFWGYIpWIJlA68VgXkzgQHeM4FtgUgBjUlwhHcnFQaBSUSBFYE7gTcHb?=
 =?us-ascii?q?4FSiTUEgjyCZ4N5gW+KHoFcHS+CLowdSIEhA1khEQFVEw0KCwcFgXUDOQwLM?=
 =?us-ascii?q?RWDYEY9gklpSTcCDQI2giR8gk2FGYRpYy8DAwMDgzmGJIIZgV9AAwsYDUgRL?=
 =?us-ascii?q?DcUGwY+bgebS0aDWgcxShMBewYtDjIKRgEfCjqSXQkBBwqPcoIggTSfToQko?=
 =?us-ascii?q?UQaM6pRmHujXBgZN4RmgWc8gVkzGggbFTuCZ1IZD44tFsQPJTI8AgcLAQEDC?=
 =?us-ascii?q?YZLiiRgAQE?=
IronPort-Data: A9a23:36FrPa6I1UwItBMI+xzgJQxRtCnGchMFZxGqfqrLsTDasY5as4F+v
 mdKCG2PPayCYWLyeYhzYIjioBtQusDWmNBkTQtuqSFgZn8b8sCt6fZ1gavT04J+CuWZESqLO
 u1HMoGowPgcFyGa/lH1dOC89RGQ7InQLpLkEunIJyttcgFtTSYlmHpLlvUw6mJSqYDR7zil5
 5Wr+aUzBHf/g2QoazhNsvrewP9SlK2aVA0w7wRWic9j5Dcyp1FNZLoDKKe4KWfPQ4U8NoaSW
 +bZwbilyXjS9hErB8nNuu6TnpoiG+O60aCm0xK6aoD66vRwjnVaPpUTaJLwXXxqZwChxLid/
 jniWauYEm/FNoWU8AgUvoIx/ytWZcWq85efSZSzXFD6I0DuKxPRL/tS4E4eN50U6+JmBWJy8
 tsYJBcQZUC5nfK43+fuIgVsrpxLwMjDJogTvDRkiDreF/tjGMmFSKTR7tge1zA17ixMNa+BP
 IxCNnw1MUmGOkEfUrsUIMpWcOOAhXDlbzxcoVG9rqss6G+Vxwt0uFToGICFI4TXFZ0LxC50o
 ErB+2GoW05DGefA6mOh+FierazuxX7kDdd6+LqQs6QCbEeo7m4eChc+UVq9vOn/i0S7HdlYL
 iQ8/yM0sak0slSmUtTnRBC+iHmetxUYVpxbFOhSwAWMzLfEpgWUHG4JShZfZ9E88sw7Xzon0
 hmOhdyBLThutqCFDGmW7ba8szy/I24WIHUEaCtCShEKi+QPu6kphR7JC9ImG6mvg5isQHf7w
 iuBq241gLB7YdM36phXNGvv21qEzqUlhCZsjukLdgpJNj9EWbM=
IronPort-HdrOrdr: A9a23:/3IZuK4x5zSgKfGTeAPXwOfXdLJyesId70hD6qm+c3Bom6uj5q
 STdZsguyMc5Ax6ZJhko6HiBEDiewK4yXcW2+gs1N6ZNWGMhILrFvAB0WKI+VLd8kPFm9J15O
 NJb7V+BNrsDVJzkMr2pDWjH81I+qjhzEnRv4fjJ7MHd3ASV0mmhD0JbDqmLg==
X-Talos-CUID: =?us-ascii?q?9a23=3ALS68lGkoU+7YOUyoe0dRJmWxgvfXOXfNwGbUMku?=
 =?us-ascii?q?7NWFOSLGyVFTAwrl0ndU7zg=3D=3D?=
X-Talos-MUID: 9a23:IqSHXwnWe0cdyZcJk2DednplMMI5uvv3JXtSsswiseO2Hm9RY2qC2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,227,1728950400"; 
   d="scan'208";a="281058062"
Received: from rcdn-l-core-11.cisco.com ([173.37.255.148])
  by rcdn-iport-2.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 12 Dec 2024 02:11:28 +0000
Received: from fedora.cisco.com (unknown [10.24.83.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kartilak@cisco.com)
	by rcdn-l-core-11.cisco.com (Postfix) with ESMTPSA id 3BC8E18000259;
	Thu, 12 Dec 2024 02:11:27 +0000 (GMT)
From: Karan Tilak Kumar <kartilak@cisco.com>
To: sebaddel@cisco.com
Cc: arulponn@cisco.com,
	djhawar@cisco.com,
	gcboffa@cisco.com,
	mkai2@cisco.com,
	satishkh@cisco.com,
	aeasi@cisco.com,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Karan Tilak Kumar <kartilak@cisco.com>
Subject: [PATCH v7 11/15] scsi: fnic: Modify fnic interfaces to use FDLS
Date: Wed, 11 Dec 2024 18:03:08 -0800
Message-ID: <20241212020312.4786-12-kartilak@cisco.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241212020312.4786-1-kartilak@cisco.com>
References: <20241212020312.4786-1-kartilak@cisco.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: kartilak@cisco.com
X-Outbound-SMTP-Client: 10.24.83.168, [10.24.83.168]
X-Outbound-Node: rcdn-l-core-11.cisco.com

Modify fnic driver interfaces to use FDLS and
supporting functions.
Refactor code in fnic_probe and fnic_remove.
Get fnic from shost_priv.
Add error handling in stats processing functions.
Modify some print statements.
Add support to do module unload cleanup.
Use placeholder functions/modify function declarations
to not break compilation.

Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
Reviewed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Reviewed-by: Gian Carlo Boffa <gcboffa@cisco.com>
Co-developed-by: Arun Easi <aeasi@cisco.com>
Signed-off-by: Arun Easi <aeasi@cisco.com>
Co-developed-by: Karan Tilak Kumar <kartilak@cisco.com>
Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>
---
Changes between v5 and v6:
    Rebase to 6.14/scsi-queue.
    Incorporate review comments from Martin:
	Fix GCC 13.3 warnings.

Changes between v4 and v5:
    Incorporate review comments from Martin:
        Modify fnic_get_stats to suppress compiler warning.
        Modify attribution appropriately.

Changes between v2 and v3:
    Modify scsi_unload to fix null pointer exception during fnic_remove.
    Replace fnic->host with fnic->lport->host to prevent compilation
    errors.

Changes between v1 and v2:
    Incorporate review comments from Hannes from other patches:
        Replace pr_info with dev_info.
        Replace pr_err with dev_err.
---
 drivers/scsi/fnic/fnic.h         |  14 +-
 drivers/scsi/fnic/fnic_attrs.c   |  12 +-
 drivers/scsi/fnic/fnic_debugfs.c |  28 +-
 drivers/scsi/fnic/fnic_fcs.c     |  16 +
 drivers/scsi/fnic/fnic_main.c    | 498 +++++++++++++++++--------------
 drivers/scsi/fnic/fnic_res.c     |  30 +-
 drivers/scsi/fnic/fnic_scsi.c    |  39 +++
 drivers/scsi/fnic/fnic_stats.h   |   2 +
 drivers/scsi/fnic/fnic_trace.c   |   6 +
 9 files changed, 398 insertions(+), 247 deletions(-)

diff --git a/drivers/scsi/fnic/fnic.h b/drivers/scsi/fnic/fnic.h
index 1cfd9dcb5444..19e8775f1bfc 100644
--- a/drivers/scsi/fnic/fnic.h
+++ b/drivers/scsi/fnic/fnic.h
@@ -85,6 +85,7 @@
 #define IS_FNIC_FCP_INITIATOR(fnic) (fnic->role == FNIC_ROLE_FCP_INITIATOR)
 
 #define FNIC_FW_RESET_TIMEOUT        60000	/* mSec   */
+#define FNIC_FCOE_MAX_CMD_LEN        16
 /* Retry supported by rport (returned by PRLI service parameters) */
 #define FNIC_FC_RP_FLAGS_RETRY            0x1
 
@@ -344,6 +345,7 @@ struct fnic {
 	int fnic_num;
 	enum fnic_role_e role;
 	struct fnic_iport_s iport;
+	struct Scsi_Host *host;
 	struct fc_lport *lport;
 	struct fcoe_ctlr ctlr;		/* FIP FCoE controller structure */
 	struct vnic_dev_bar bar0;
@@ -464,11 +466,6 @@ struct fnic {
 	____cacheline_aligned struct vnic_intr intr[FNIC_MSIX_INTR_MAX];
 };
 
-static inline struct fnic *fnic_from_ctlr(struct fcoe_ctlr *fip)
-{
-	return container_of(fip, struct fnic, ctlr);
-}
-
 extern struct workqueue_struct *fnic_event_queue;
 extern struct workqueue_struct *fnic_fip_queue;
 extern const struct attribute_group *fnic_host_groups[];
@@ -500,6 +497,7 @@ int fnic_eh_host_reset_handler(struct scsi_cmnd *sc);
 int fnic_host_reset(struct Scsi_Host *shost);
 void fnic_reset(struct Scsi_Host *shost);
 int fnic_issue_fc_host_lip(struct Scsi_Host *shost);
+void fnic_get_host_port_state(struct Scsi_Host *shost);
 void fnic_scsi_fcpio_reset(struct fnic *fnic);
 int fnic_wq_copy_cmpl_handler(struct fnic *fnic, int copy_work_to_do, unsigned int cq_index);
 int fnic_wq_cmpl_handler(struct fnic *fnic, int);
@@ -512,7 +510,7 @@ const char *fnic_state_to_str(unsigned int state);
 void fnic_mq_map_queues_cpus(struct Scsi_Host *host);
 void fnic_log_q_error(struct fnic *fnic);
 void fnic_handle_link_event(struct fnic *fnic);
-void fnic_stats_debugfs_init(struct fnic *fnic);
+int fnic_stats_debugfs_init(struct fnic *fnic);
 void fnic_stats_debugfs_remove(struct fnic *fnic);
 int fnic_is_abts_pending(struct fnic *, struct scsi_cmnd *);
 
@@ -541,6 +539,10 @@ unsigned int fnic_count_lun_ioreqs_wq(struct fnic *fnic, u32 hwq,
 						  struct scsi_device *device);
 unsigned int fnic_count_lun_ioreqs(struct fnic *fnic,
 					   struct scsi_device *device);
+void fnic_scsi_unload(struct fnic *fnic);
+void fnic_scsi_unload_cleanup(struct fnic *fnic);
+int fnic_get_debug_info(struct stats_debug_info *info,
+			struct fnic *fnic);
 
 struct fnic_scsi_iter_data {
 	struct fnic *fnic;
diff --git a/drivers/scsi/fnic/fnic_attrs.c b/drivers/scsi/fnic/fnic_attrs.c
index 0c5e57c7e322..705718f0809b 100644
--- a/drivers/scsi/fnic/fnic_attrs.c
+++ b/drivers/scsi/fnic/fnic_attrs.c
@@ -11,8 +11,8 @@
 static ssize_t fnic_show_state(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
-	struct fc_lport *lp = shost_priv(class_to_shost(dev));
-	struct fnic *fnic = lport_priv(lp);
+	struct fnic *fnic =
+		*((struct fnic **) shost_priv(class_to_shost(dev)));
 
 	return sysfs_emit(buf, "%s\n", fnic_state_str[fnic->state]);
 }
@@ -26,9 +26,13 @@ static ssize_t fnic_show_drv_version(struct device *dev,
 static ssize_t fnic_show_link_state(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
-	struct fc_lport *lp = shost_priv(class_to_shost(dev));
+	struct fnic *fnic =
+		*((struct fnic **) shost_priv(class_to_shost(dev)));
 
-	return sysfs_emit(buf, "%s\n", (lp->link_up) ? "Link Up" : "Link Down");
+	return sysfs_emit(buf, "%s\n",
+					  ((fnic->iport.state != FNIC_IPORT_STATE_INIT) &&
+					   (fnic->iport.state != FNIC_IPORT_STATE_LINK_WAIT)) ?
+					  "Link Up" : "Link Down");
 }
 
 static DEVICE_ATTR(fnic_state, S_IRUGO, fnic_show_state, NULL);
diff --git a/drivers/scsi/fnic/fnic_debugfs.c b/drivers/scsi/fnic/fnic_debugfs.c
index 2619a2d4f5f1..3748bbe190f7 100644
--- a/drivers/scsi/fnic/fnic_debugfs.c
+++ b/drivers/scsi/fnic/fnic_debugfs.c
@@ -7,6 +7,9 @@
 #include <linux/vmalloc.h>
 #include "fnic.h"
 
+extern int fnic_get_debug_info(struct stats_debug_info *debug_buffer,
+							   struct fnic *fnic);
+
 static struct dentry *fnic_trace_debugfs_root;
 static struct dentry *fnic_trace_debugfs_file;
 static struct dentry *fnic_trace_enable;
@@ -593,6 +596,7 @@ static int fnic_stats_debugfs_open(struct inode *inode,
 	debug->buf_size = buf_size;
 	memset((void *)debug->debug_buffer, 0, buf_size);
 	debug->buffer_len = fnic_get_stats_data(debug, fnic_stats);
+	debug->buffer_len += fnic_get_debug_info(debug, fnic);
 
 	file->private_data = debug;
 
@@ -673,26 +677,48 @@ static const struct file_operations fnic_reset_debugfs_fops = {
  * It will create file stats and reset_stats under statistics/host# directory
  * to log per fnic stats.
  */
-void fnic_stats_debugfs_init(struct fnic *fnic)
+int fnic_stats_debugfs_init(struct fnic *fnic)
 {
+	int rc = -1;
 	char name[16];
 
 	snprintf(name, sizeof(name), "host%d", fnic->lport->host->host_no);
 
+	if (!fnic_stats_debugfs_root) {
+		pr_debug("fnic_stats root doesn't exist\n");
+		return rc;
+	}
+
 	fnic->fnic_stats_debugfs_host = debugfs_create_dir(name,
 						fnic_stats_debugfs_root);
 
+	if (!fnic->fnic_stats_debugfs_host) {
+		pr_debug("Cannot create host directory\n");
+		return rc;
+	}
+
 	fnic->fnic_stats_debugfs_file = debugfs_create_file("stats",
 						S_IFREG|S_IRUGO|S_IWUSR,
 						fnic->fnic_stats_debugfs_host,
 						fnic,
 						&fnic_stats_debugfs_fops);
 
+	if (!fnic->fnic_stats_debugfs_file) {
+		pr_debug("Cannot create host stats file\n");
+		return rc;
+	}
+
 	fnic->fnic_reset_debugfs_file = debugfs_create_file("reset_stats",
 						S_IFREG|S_IRUGO|S_IWUSR,
 						fnic->fnic_stats_debugfs_host,
 						fnic,
 						&fnic_reset_debugfs_fops);
+	if (!fnic->fnic_reset_debugfs_file) {
+		pr_debug("Cannot create host stats file\n");
+		return rc;
+	}
+	rc = 0;
+	return rc;
 }
 
 /*
diff --git a/drivers/scsi/fnic/fnic_fcs.c b/drivers/scsi/fnic/fnic_fcs.c
index b2669f2ddb53..8dba1168b652 100644
--- a/drivers/scsi/fnic/fnic_fcs.c
+++ b/drivers/scsi/fnic/fnic_fcs.c
@@ -63,6 +63,22 @@ static inline  void fnic_fdls_set_fcoe_dstmac(struct fnic *fnic,
 	memcpy(fnic->iport.fcfmac, dst_mac, 6);
 }
 
+void fnic_get_host_port_state(struct Scsi_Host *shost)
+{
+	struct fnic *fnic = *((struct fnic **) shost_priv(shost));
+	struct fnic_iport_s *iport = &fnic->iport;
+	unsigned long flags;
+
+	spin_lock_irqsave(&fnic->fnic_lock, flags);
+	if (!fnic->link_status)
+		fc_host_port_state(shost) = FC_PORTSTATE_LINKDOWN;
+	else if (iport->state == FNIC_IPORT_STATE_READY)
+		fc_host_port_state(shost) = FC_PORTSTATE_ONLINE;
+	else
+		fc_host_port_state(shost) = FC_PORTSTATE_OFFLINE;
+	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
+}
+
 void fnic_fdls_link_status_change(struct fnic *fnic, int linkup)
 {
 	struct fnic_iport_s *iport = &fnic->iport;
diff --git a/drivers/scsi/fnic/fnic_main.c b/drivers/scsi/fnic/fnic_main.c
index a6c2cb49465b..44cbb04b2421 100644
--- a/drivers/scsi/fnic/fnic_main.c
+++ b/drivers/scsi/fnic/fnic_main.c
@@ -67,6 +67,11 @@ unsigned int fnic_fdmi_support = 1;
 module_param(fnic_fdmi_support, int, 0644);
 MODULE_PARM_DESC(fnic_fdmi_support, "FDMI support");
 
+static unsigned int fnic_tgt_id_binding = 1;
+module_param(fnic_tgt_id_binding, uint, 0644);
+MODULE_PARM_DESC(fnic_tgt_id_binding,
+		 "Target ID binding (0 for none. 1 for binding by WWPN (default))");
+
 unsigned int io_completions = FNIC_DFLT_IO_COMPLETIONS;
 module_param(io_completions, int, S_IRUGO|S_IWUSR);
 MODULE_PARM_DESC(io_completions, "Max CQ entries to process at a time");
@@ -146,7 +151,7 @@ static struct fc_function_template fnic_fc_functions = {
 	.get_host_speed = fnic_get_host_speed,
 	.show_host_speed = 1,
 	.show_host_port_type = 1,
-	.get_host_port_state = fc_get_host_port_state,
+	.get_host_port_state = fnic_get_host_port_state,
 	.show_host_port_state = 1,
 	.show_host_symbolic_name = 1,
 	.show_rport_maxframe_size = 1,
@@ -158,79 +163,79 @@ static struct fc_function_template fnic_fc_functions = {
 	.show_rport_dev_loss_tmo = 1,
 	.set_rport_dev_loss_tmo = fnic_set_rport_dev_loss_tmo,
 	.issue_fc_host_lip = fnic_issue_fc_host_lip,
-	.get_fc_host_stats = fnic_get_stats,
+	.get_fc_host_stats = NULL,
 	.reset_fc_host_stats = fnic_reset_host_stats,
-	.dd_fcrport_size = sizeof(struct fc_rport_libfc_priv),
+	.dd_fcrport_size = sizeof(struct rport_dd_data_s),
 	.terminate_rport_io = fnic_terminate_rport_io,
-	.bsg_request = fc_lport_bsg_request,
+	.bsg_request = NULL,
 };
 
 static void fnic_get_host_speed(struct Scsi_Host *shost)
 {
-	struct fc_lport *lp = shost_priv(shost);
-	struct fnic *fnic = lport_priv(lp);
+	struct fnic *fnic = *((struct fnic **) shost_priv(shost));
 	u32 port_speed = vnic_dev_port_speed(fnic->vdev);
 
+	FNIC_MAIN_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				  "port_speed: %d Mbps", port_speed);
+
 	/* Add in other values as they get defined in fw */
 	switch (port_speed) {
+	case DCEM_PORTSPEED_1G:
+		fc_host_speed(shost) = FC_PORTSPEED_1GBIT;
+		break;
+	case DCEM_PORTSPEED_2G:
+		fc_host_speed(shost) = FC_PORTSPEED_2GBIT;
+		break;
+	case DCEM_PORTSPEED_4G:
+		fc_host_speed(shost) = FC_PORTSPEED_4GBIT;
+		break;
+	case DCEM_PORTSPEED_8G:
+		fc_host_speed(shost) = FC_PORTSPEED_8GBIT;
+		break;
 	case DCEM_PORTSPEED_10G:
 		fc_host_speed(shost) = FC_PORTSPEED_10GBIT;
 		break;
+	case DCEM_PORTSPEED_16G:
+		fc_host_speed(shost) = FC_PORTSPEED_16GBIT;
+		break;
 	case DCEM_PORTSPEED_20G:
 		fc_host_speed(shost) = FC_PORTSPEED_20GBIT;
 		break;
 	case DCEM_PORTSPEED_25G:
 		fc_host_speed(shost) = FC_PORTSPEED_25GBIT;
 		break;
+	case DCEM_PORTSPEED_32G:
+		fc_host_speed(shost) = FC_PORTSPEED_32GBIT;
+		break;
 	case DCEM_PORTSPEED_40G:
 	case DCEM_PORTSPEED_4x10G:
 		fc_host_speed(shost) = FC_PORTSPEED_40GBIT;
 		break;
+	case DCEM_PORTSPEED_50G:
+		fc_host_speed(shost) = FC_PORTSPEED_50GBIT;
+		break;
+	case DCEM_PORTSPEED_64G:
+		fc_host_speed(shost) = FC_PORTSPEED_64GBIT;
+		break;
 	case DCEM_PORTSPEED_100G:
 		fc_host_speed(shost) = FC_PORTSPEED_100GBIT;
 		break;
+	case DCEM_PORTSPEED_128G:
+		fc_host_speed(shost) = FC_PORTSPEED_128GBIT;
+		break;
 	default:
+		FNIC_MAIN_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					  "Unknown FC speed: %d Mbps", port_speed);
 		fc_host_speed(shost) = FC_PORTSPEED_UNKNOWN;
 		break;
 	}
 }
 
+/* Placeholder function */
 static struct fc_host_statistics *fnic_get_stats(struct Scsi_Host *host)
 {
-	int ret;
-	struct fc_lport *lp = shost_priv(host);
-	struct fnic *fnic = lport_priv(lp);
-	struct fc_host_statistics *stats = &lp->host_stats;
-	struct vnic_stats *vs;
-	unsigned long flags;
-
-	if (time_before(jiffies, fnic->stats_time + HZ / FNIC_STATS_RATE_LIMIT))
-		return stats;
-	fnic->stats_time = jiffies;
-
-	spin_lock_irqsave(&fnic->fnic_lock, flags);
-	ret = vnic_dev_stats_dump(fnic->vdev, &fnic->stats);
-	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
-
-	if (ret) {
-		FNIC_MAIN_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
-			      "fnic: Get vnic stats failed"
-			      " 0x%x", ret);
-		return stats;
-	}
-	vs = fnic->stats;
-	stats->tx_frames = vs->tx.tx_unicast_frames_ok;
-	stats->tx_words  = vs->tx.tx_unicast_bytes_ok / 4;
-	stats->rx_frames = vs->rx.rx_unicast_frames_ok;
-	stats->rx_words  = vs->rx.rx_unicast_bytes_ok / 4;
-	stats->error_frames = vs->tx.tx_errors + vs->rx.rx_errors;
-	stats->dumped_frames = vs->tx.tx_drops + vs->rx.rx_drop;
-	stats->invalid_crc_count = vs->rx.rx_crc_errors;
-	stats->seconds_since_last_reset =
-			(jiffies - fnic->stats_reset_time) / HZ;
-	stats->fcp_input_megabytes = div_u64(fnic->fcp_input_bytes, 1000000);
-	stats->fcp_output_megabytes = div_u64(fnic->fcp_output_bytes, 1000000);
-
+	struct fnic *fnic = *((struct fnic **) shost_priv(host));
+	struct fc_host_statistics *stats = &fnic->fnic_stats.host_stats;
 	return stats;
 }
 
@@ -311,8 +316,7 @@ void fnic_dump_fchost_stats(struct Scsi_Host *host,
 static void fnic_reset_host_stats(struct Scsi_Host *host)
 {
 	int ret;
-	struct fc_lport *lp = shost_priv(host);
-	struct fnic *fnic = lport_priv(lp);
+	struct fnic *fnic = *((struct fnic **) shost_priv(host));
 	struct fc_host_statistics *stats;
 	unsigned long flags;
 
@@ -527,9 +531,23 @@ static void fnic_set_vlan(struct fnic *fnic, u16 vlan_id)
 	vnic_dev_set_default_vlan(fnic->vdev, vlan_id);
 }
 
+static void fnic_scsi_init(struct fnic *fnic)
+{
+	struct Scsi_Host *host = fnic->lport->host;
+
+	snprintf(fnic->name, sizeof(fnic->name) - 1, "%s%d", DRV_NAME,
+			 host->host_no);
+
+	host->transportt = fnic_fc_transport;
+}
+
 static int fnic_scsi_drv_init(struct fnic *fnic)
 {
 	struct Scsi_Host *host = fnic->lport->host;
+	int err;
+	struct pci_dev *pdev = fnic->pdev;
+	struct fnic_iport_s *iport = &fnic->iport;
+	int hwq;
 
 	/* Configure maximum outstanding IO reqs*/
 	if (fnic->config.io_throttle_count != FNIC_UCSM_DFLT_THROTTLE_CNT_BLD)
@@ -540,7 +558,7 @@ static int fnic_scsi_drv_init(struct fnic *fnic)
 	fnic->fnic_max_tag_id = host->can_queue;
 	host->max_lun = fnic->config.luns_per_tgt;
 	host->max_id = FNIC_MAX_FCP_TARGET;
-	host->max_cmd_len = FCOE_MAX_CMD_LEN;
+	host->max_cmd_len = FNIC_FCOE_MAX_CMD_LEN;
 
 	host->nr_hw_queues = fnic->wq_copy_count;
 
@@ -550,13 +568,62 @@ static int fnic_scsi_drv_init(struct fnic *fnic)
 	dev_info(&fnic->pdev->dev, "fnic: max_id: %d max_cmd_len: %d nr_hw_queues: %d",
 			host->max_id, host->max_cmd_len, host->nr_hw_queues);
 
+	for (hwq = 0; hwq < fnic->wq_copy_count; hwq++) {
+		fnic->sw_copy_wq[hwq].ioreq_table_size = fnic->fnic_max_tag_id;
+		fnic->sw_copy_wq[hwq].io_req_table =
+			kzalloc((fnic->sw_copy_wq[hwq].ioreq_table_size + 1) *
+					sizeof(struct fnic_io_req *), GFP_KERNEL);
+	}
+
+	dev_info(&fnic->pdev->dev, "fnic copy wqs: %d, Q0 ioreq table size: %d\n",
+			fnic->wq_copy_count, fnic->sw_copy_wq[0].ioreq_table_size);
+
+	fnic_scsi_init(fnic);
+
+	err = scsi_add_host(fnic->lport->host, &pdev->dev);
+	if (err) {
+		dev_err(&fnic->pdev->dev, "fnic: scsi add host failed: aborting\n");
+		return -1;
+	}
+	fc_host_maxframe_size(fnic->lport->host) = iport->max_payload_size;
+	fc_host_dev_loss_tmo(fnic->lport->host) =
+		fnic->config.port_down_timeout / 1000;
+	sprintf(fc_host_symbolic_name(fnic->lport->host),
+			DRV_NAME " v" DRV_VERSION " over %s", fnic->name);
+	fc_host_port_type(fnic->lport->host) = FC_PORTTYPE_NPORT;
+	fc_host_node_name(fnic->lport->host) = iport->wwnn;
+	fc_host_port_name(fnic->lport->host) = iport->wwpn;
+	fc_host_supported_classes(fnic->lport->host) = FC_COS_CLASS3;
+	memset(fc_host_supported_fc4s(fnic->lport->host), 0,
+		   sizeof(fc_host_supported_fc4s(fnic->lport->host)));
+	fc_host_supported_fc4s(fnic->lport->host)[2] = 1;
+	fc_host_supported_fc4s(fnic->lport->host)[7] = 1;
+	fc_host_supported_speeds(fnic->lport->host) = 0;
+	fc_host_supported_speeds(fnic->lport->host) |= FC_PORTSPEED_8GBIT;
+
+	dev_info(&fnic->pdev->dev, "shost_data: 0x%p\n", fnic->lport->host->shost_data);
+	if (fnic->lport->host->shost_data != NULL) {
+		if (fnic_tgt_id_binding == 0) {
+			dev_info(&fnic->pdev->dev, "Setting target binding to NONE\n");
+			fc_host_tgtid_bind_type(fnic->lport->host) = FC_TGTID_BIND_NONE;
+		} else {
+			dev_info(&fnic->pdev->dev, "Setting target binding to WWPN\n");
+			fc_host_tgtid_bind_type(fnic->lport->host) = FC_TGTID_BIND_BY_WWPN;
+		}
+	}
+
+	fnic->io_req_pool = mempool_create_slab_pool(2, fnic_io_req_cache);
+	if (!fnic->io_req_pool) {
+		scsi_remove_host(fnic->lport->host);
+		return -ENOMEM;
+	}
+
 	return 0;
 }
 
 void fnic_mq_map_queues_cpus(struct Scsi_Host *host)
 {
-	struct fc_lport *lp = shost_priv(host);
-	struct fnic *fnic = lport_priv(lp);
+	struct fnic *fnic = *((struct fnic **) shost_priv(host));
 	struct pci_dev *l_pdev = fnic->pdev;
 	int intr_mode = fnic->config.intr_mode;
 	struct blk_mq_queue_map *qmap = &host->tag_set.map[HCTX_TYPE_DEFAULT];
@@ -581,31 +648,27 @@ void fnic_mq_map_queues_cpus(struct Scsi_Host *host)
 
 static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
-	struct Scsi_Host *host;
-	struct fc_lport *lp;
+	struct Scsi_Host *host = NULL;
 	struct fnic *fnic;
 	mempool_t *pool;
+	struct fnic_iport_s *iport;
 	int err = 0;
 	int fnic_id = 0;
 	int i;
 	unsigned long flags;
-	int hwq;
 	char *desc, *subsys_desc;
 	int len;
 
 	/*
-	 * Allocate SCSI Host and set up association between host,
-	 * local port, and fnic
+	 * Allocate fnic
 	 */
-	lp = libfc_host_alloc(&fnic_host_template, sizeof(struct fnic));
-	if (!lp) {
-		dev_err(&pdev->dev, "Unable to alloc libfc local port\n");
+	fnic = kzalloc(sizeof(struct fnic), GFP_KERNEL);
+	if (!fnic) {
 		err = -ENOMEM;
-		goto err_out;
+		goto err_out_fnic_alloc;
 	}
 
-	host = lp->host;
-	fnic = lport_priv(lp);
+	iport = &fnic->iport;
 
 	fnic_id = ida_alloc(&fnic_ida, GFP_KERNEL);
 	if (fnic_id < 0) {
@@ -613,17 +676,9 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		err = fnic_id;
 		goto err_out_ida_alloc;
 	}
-	fnic->lport = lp;
-	fnic->ctlr.lp = lp;
-	fnic->link_events = 0;
-	fnic->pdev = pdev;
 
-	snprintf(fnic->name, sizeof(fnic->name) - 1, "%s%d", DRV_NAME,
-		 host->host_no);
-
-	host->transportt = fnic_fc_transport;
+	fnic->pdev = pdev;
 	fnic->fnic_num = fnic_id;
-	fnic_stats_debugfs_init(fnic);
 
 	/* Find model name from PCIe subsys ID */
 	if (fnic_get_desc_by_devid(pdev, &desc, &subsys_desc) == 0) {
@@ -645,13 +700,13 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	err = pci_enable_device(pdev);
 	if (err) {
 		dev_err(&fnic->pdev->dev, "Cannot enable PCI device, aborting.\n");
-		goto err_out_free_hba;
+		goto err_out_pci_enable_device;
 	}
 
 	err = pci_request_regions(pdev, DRV_NAME);
 	if (err) {
 		dev_err(&fnic->pdev->dev, "Cannot enable PCI resources, aborting\n");
-		goto err_out_disable_device;
+		goto err_out_pci_request_regions;
 	}
 
 	pci_set_master(pdev);
@@ -666,7 +721,7 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		if (err) {
 			dev_err(&fnic->pdev->dev, "No usable DMA configuration "
 				     "aborting\n");
-			goto err_out_release_regions;
+			goto err_out_set_dma_mask;
 		}
 	}
 
@@ -674,7 +729,7 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (!(pci_resource_flags(pdev, 0) & IORESOURCE_MEM)) {
 		dev_err(&fnic->pdev->dev, "BAR0 not memory-map'able, aborting.\n");
 		err = -ENODEV;
-		goto err_out_release_regions;
+		goto err_out_map_bar;
 	}
 
 	fnic->bar0.vaddr = pci_iomap(pdev, 0, 0);
@@ -685,7 +740,7 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		dev_err(&fnic->pdev->dev, "Cannot memory-map BAR0 res hdr, "
 			     "aborting.\n");
 		err = -ENODEV;
-		goto err_out_release_regions;
+		goto err_out_fnic_map_bar;
 	}
 
 	fnic->vdev = vnic_dev_register(NULL, fnic, pdev, &fnic->bar0);
@@ -693,43 +748,68 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		dev_err(&fnic->pdev->dev, "vNIC registration failed, "
 			     "aborting.\n");
 		err = -ENODEV;
-		goto err_out_iounmap;
+		goto err_out_dev_register;
 	}
 
 	err = vnic_dev_cmd_init(fnic->vdev);
 	if (err) {
 		dev_err(&fnic->pdev->dev, "vnic_dev_cmd_init() returns %d, aborting\n",
 				err);
-		goto err_out_vnic_unregister;
+		goto err_out_dev_cmd_init;
 	}
 
 	err = fnic_dev_wait(fnic->vdev, vnic_dev_open,
 			    vnic_dev_open_done, CMD_OPENF_RQ_ENABLE_THEN_POST);
 	if (err) {
 		dev_err(&fnic->pdev->dev, "vNIC dev open failed, aborting.\n");
-		goto err_out_dev_cmd_deinit;
+		goto err_out_dev_open;
 	}
 
 	err = vnic_dev_init(fnic->vdev, 0);
 	if (err) {
 		dev_err(&fnic->pdev->dev, "vNIC dev init failed, aborting.\n");
-		goto err_out_dev_close;
+		goto err_out_dev_init;
 	}
 
-	err = vnic_dev_mac_addr(fnic->vdev, fnic->ctlr.ctl_src_addr);
+	err = vnic_dev_mac_addr(fnic->vdev, iport->hwmac);
 	if (err) {
 		dev_err(&fnic->pdev->dev, "vNIC get MAC addr failed\n");
-		goto err_out_dev_close;
+		goto err_out_dev_mac_addr;
 	}
 	/* set data_src for point-to-point mode and to keep it non-zero */
-	memcpy(fnic->data_src_addr, fnic->ctlr.ctl_src_addr, ETH_ALEN);
+	memcpy(fnic->data_src_addr, iport->hwmac, ETH_ALEN);
 
 	/* Get vNIC configuration */
 	err = fnic_get_vnic_config(fnic);
 	if (err) {
 		dev_err(&fnic->pdev->dev, "Get vNIC configuration failed, "
 			     "aborting.\n");
-		goto err_out_dev_close;
+		goto err_out_fnic_get_config;
+	}
+
+	switch (fnic->config.flags & 0xff0) {
+	case VFCF_FC_INITIATOR:
+		{
+			host =
+				scsi_host_alloc(&fnic_host_template,
+								sizeof(struct fnic *));
+			if (!host) {
+				dev_err(&fnic->pdev->dev, "Unable to allocate scsi host\n");
+				err = -ENOMEM;
+				goto err_out_scsi_host_alloc;
+			}
+			*((struct fnic **) shost_priv(host)) = fnic;
+
+			fnic->lport->host = host;
+			fnic->role = FNIC_ROLE_FCP_INITIATOR;
+			dev_info(&fnic->pdev->dev, "fnic: %d is scsi initiator\n",
+					fnic->fnic_num);
+		}
+		break;
+	default:
+		dev_info(&fnic->pdev->dev, "fnic: %d has no role defined\n", fnic->fnic_num);
+		err = -EINVAL;
+		goto err_out_fnic_role;
 	}
 
 	/* Setup PCI resources */
@@ -741,23 +821,14 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (err) {
 		dev_err(&fnic->pdev->dev, "Failed to set intr mode, "
 			     "aborting.\n");
-		goto err_out_dev_close;
+		goto err_out_fnic_set_intr_mode;
 	}
 
 	err = fnic_alloc_vnic_resources(fnic);
 	if (err) {
 		dev_err(&fnic->pdev->dev, "Failed to alloc vNIC resources, "
 			     "aborting.\n");
-		goto err_out_clear_intr;
-	}
-
-	fnic_scsi_drv_init(fnic);
-
-	for (hwq = 0; hwq < fnic->wq_copy_count; hwq++) {
-		fnic->sw_copy_wq[hwq].ioreq_table_size = fnic->fnic_max_tag_id;
-		fnic->sw_copy_wq[hwq].io_req_table =
-					kzalloc((fnic->sw_copy_wq[hwq].ioreq_table_size + 1) *
-					sizeof(struct fnic_io_req *), GFP_KERNEL);
+		goto err_out_fnic_alloc_vnic_res;
 	}
 	dev_info(&fnic->pdev->dev, "fnic copy wqs: %d, Q0 ioreq table size: %d\n",
 			fnic->wq_copy_count, fnic->sw_copy_wq[0].ioreq_table_size);
@@ -775,14 +846,9 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		fnic->fw_ack_index[i] = -1;
 	}
 
-	err = -ENOMEM;
-	fnic->io_req_pool = mempool_create_slab_pool(2, fnic_io_req_cache);
-	if (!fnic->io_req_pool)
-		goto err_out_free_resources;
-
 	pool = mempool_create_slab_pool(2, fnic_sgl_cache[FNIC_SGL_CACHE_DFLT]);
 	if (!pool)
-		goto err_out_free_ioreq_pool;
+		goto err_out_free_resources;
 	fnic->io_sgl_pool[FNIC_SGL_CACHE_DFLT] = pool;
 
 	pool = mempool_create_slab_pool(2, fnic_sgl_cache[FNIC_SGL_CACHE_MAX]);
@@ -810,8 +876,7 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		/* enable directed and multicast */
 		vnic_dev_packet_filter(fnic->vdev, 1, 1, 0, 0, 0);
 		vnic_dev_add_addr(fnic->vdev, FIP_ALL_ENODE_MACS);
-		vnic_dev_add_addr(fnic->vdev, fnic->ctlr.ctl_src_addr);
-		fcoe_ctlr_init(&fnic->ctlr, FIP_MODE_AUTO);
+		vnic_dev_add_addr(fnic->vdev, iport->hwmac);
 		spin_lock_init(&fnic->vlans_lock);
 		INIT_WORK(&fnic->fip_frame_work, fnic_handle_fip_frame);
 		INIT_LIST_HEAD(&fnic->fip_frame_queue);
@@ -823,8 +888,6 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		fnic->set_vlan = fnic_set_vlan;
 	} else {
 		dev_info(&fnic->pdev->dev, "firmware uses non-FIP mode\n");
-		fcoe_ctlr_init(&fnic->ctlr, FIP_MODE_NON_FIP);
-		fnic->ctlr.state = FIP_ST_NON_FIP;
 	}
 	fnic->state = FNIC_IN_FC_MODE;
 
@@ -838,7 +901,7 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	err = fnic_notify_set(fnic);
 	if (err) {
 		dev_err(&fnic->pdev->dev, "Failed to alloc notify buffer, aborting.\n");
-		goto err_out_free_max_pool;
+		goto err_out_fnic_notify_set;
 	}
 
 	/* Setup notify timer when using MSI interrupts */
@@ -851,80 +914,43 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		if (err) {
 			dev_err(&fnic->pdev->dev, "fnic_alloc_rq_frame can't alloc "
 				     "frame\n");
-			goto err_out_rq_buf;
+			goto err_out_alloc_rq_buf;
 		}
 	}
 
-	/* Enable all queues */
-	for (i = 0; i < fnic->raw_wq_count; i++)
-		vnic_wq_enable(&fnic->wq[i]);
-	for (i = 0; i < fnic->rq_count; i++) {
-		if (!ioread32(&fnic->rq[i].ctrl->enable))
-			vnic_rq_enable(&fnic->rq[i]);
-	}
-	for (i = 0; i < fnic->wq_copy_count; i++)
-		vnic_wq_copy_enable(&fnic->hw_copy_wq[i]);
+	init_completion(&fnic->reset_completion_wait);
 
-	err = fnic_request_intr(fnic);
-	if (err) {
-		dev_err(&fnic->pdev->dev, "Unable to request irq.\n");
-		goto err_out_request_intr;
-	}
-
-	/*
-	 * Initialization done with PCI system, hardware, firmware.
-	 * Add host to SCSI
-	 */
-	err = scsi_add_host(lp->host, &pdev->dev);
-	if (err) {
-		dev_err(&fnic->pdev->dev, "fnic: scsi_add_host failed...exiting\n");
-		goto err_out_scsi_add_host;
-	}
-
-
-	/* Start local port initiatialization */
-
-	lp->link_up = 0;
-
-	lp->max_retry_count = fnic->config.flogi_retries;
-	lp->max_rport_retry_count = fnic->config.plogi_retries;
-	lp->service_params = (FCP_SPPF_INIT_FCN | FCP_SPPF_RD_XRDY_DIS |
-			      FCP_SPPF_CONF_COMPL);
+	/* Start local port initialization */
+	iport->max_flogi_retries = fnic->config.flogi_retries;
+	iport->max_plogi_retries = fnic->config.plogi_retries;
+	iport->plogi_timeout = fnic->config.plogi_timeout;
+	iport->service_params =
+		(FNIC_FCP_SP_INITIATOR | FNIC_FCP_SP_RD_XRDY_DIS |
+		 FNIC_FCP_SP_CONF_CMPL);
 	if (fnic->config.flags & VFCF_FCP_SEQ_LVL_ERR)
-		lp->service_params |= FCP_SPPF_RETRY;
-
-	lp->boot_time = jiffies;
-	lp->e_d_tov = fnic->config.ed_tov;
-	lp->r_a_tov = fnic->config.ra_tov;
-	lp->link_supported_speeds = FC_PORTSPEED_10GBIT;
-	fc_set_wwnn(lp, fnic->config.node_wwn);
-	fc_set_wwpn(lp, fnic->config.port_wwn);
-
-	if (!fc_exch_mgr_alloc(lp, FC_CLASS_3, FCPIO_HOST_EXCH_RANGE_START,
-			       FCPIO_HOST_EXCH_RANGE_END, NULL)) {
-		err = -ENOMEM;
-		goto err_out_fc_exch_mgr_alloc;
-	}
+		iport->service_params |= FNIC_FCP_SP_RETRY;
 
-	fc_lport_init_stats(lp);
-	fnic->stats_reset_time = jiffies;
+	iport->boot_time = jiffies;
+	iport->e_d_tov = fnic->config.ed_tov;
+	iport->r_a_tov = fnic->config.ra_tov;
+	iport->link_supported_speeds = FNIC_PORTSPEED_10GBIT;
+	iport->wwpn = fnic->config.port_wwn;
+	iport->wwnn = fnic->config.node_wwn;
 
-	fc_lport_config(lp);
+	iport->max_payload_size = fnic->config.maxdatafieldsize;
 
-	if (fc_set_mfs(lp, fnic->config.maxdatafieldsize +
-		       sizeof(struct fc_frame_header))) {
-		err = -EINVAL;
-		goto err_out_free_exch_mgr;
+	if ((iport->max_payload_size < FNIC_MIN_DATA_FIELD_SIZE) ||
+		(iport->max_payload_size > FNIC_FC_MAX_PAYLOAD_LEN) ||
+		((iport->max_payload_size % 4) != 0)) {
+		iport->max_payload_size = FNIC_FC_MAX_PAYLOAD_LEN;
 	}
-	fc_host_maxframe_size(lp->host) = lp->mfs;
-	fc_host_dev_loss_tmo(lp->host) = fnic->config.port_down_timeout / 1000;
 
-	sprintf(fc_host_symbolic_name(lp->host),
-		DRV_NAME " v" DRV_VERSION " over %s", fnic->name);
+	iport->flags |= FNIC_FIRST_LINK_UP;
 
-	spin_lock_irqsave(&fnic_list_lock, flags);
-	list_add_tail(&fnic->list, &fnic_list);
-	spin_unlock_irqrestore(&fnic_list_lock, flags);
+	timer_setup(&(iport->fabric.retry_timer), fdls_fabric_timer_callback,
+				0);
+
+	fnic->stats_reset_time = jiffies;
 
 	INIT_WORK(&fnic->link_work, fnic_handle_link);
 	INIT_WORK(&fnic->frame_work, fnic_handle_frame);
@@ -935,71 +961,110 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	INIT_LIST_HEAD(&fnic->tx_queue);
 	INIT_LIST_HEAD(&fnic->tport_event_list);
 
-	fc_fabric_login(lp);
+	INIT_DELAYED_WORK(&iport->oxid_pool.schedule_oxid_free_retry,
+	fdls_schedule_oxid_free_retry_work);
+
+	/* Initialize the oxid reclaim list and work struct */
+	INIT_LIST_HEAD(&iport->oxid_pool.oxid_reclaim_list);
+	INIT_DELAYED_WORK(&iport->oxid_pool.oxid_reclaim_work, fdls_reclaim_oxid_handler);
+
+	/* Enable all queues */
+	for (i = 0; i < fnic->raw_wq_count; i++)
+		vnic_wq_enable(&fnic->wq[i]);
+	for (i = 0; i < fnic->rq_count; i++) {
+		if (!ioread32(&fnic->rq[i].ctrl->enable))
+			vnic_rq_enable(&fnic->rq[i]);
+	}
+	for (i = 0; i < fnic->wq_copy_count; i++)
+		vnic_wq_copy_enable(&fnic->hw_copy_wq[i]);
 
 	vnic_dev_enable(fnic->vdev);
 
+	err = fnic_request_intr(fnic);
+	if (err) {
+		dev_err(&fnic->pdev->dev, "Unable to request irq.\n");
+		goto err_out_fnic_request_intr;
+	}
+
+	fnic_notify_timer_start(fnic);
+
+	fnic_fdls_init(fnic, (fnic->config.flags & VFCF_FIP_CAPABLE));
+
+	if (IS_FNIC_FCP_INITIATOR(fnic) && fnic_scsi_drv_init(fnic))
+		goto err_out_scsi_drv_init;
+
+	err = fnic_stats_debugfs_init(fnic);
+	if (err) {
+		dev_err(&fnic->pdev->dev, "Failed to initialize debugfs for stats\n");
+		goto err_out_free_stats_debugfs;
+	}
+
 	for (i = 0; i < fnic->intr_count; i++)
 		vnic_intr_unmask(&fnic->intr[i]);
 
-	fnic_notify_timer_start(fnic);
+	spin_lock_irqsave(&fnic_list_lock, flags);
+	list_add_tail(&fnic->list, &fnic_list);
+	spin_unlock_irqrestore(&fnic_list_lock, flags);
 
 	return 0;
 
-err_out_free_exch_mgr:
-	fc_exch_mgr_free(lp);
-err_out_fc_exch_mgr_alloc:
-	fc_remove_host(lp->host);
-	scsi_remove_host(lp->host);
-err_out_scsi_add_host:
+err_out_free_stats_debugfs:
+	fnic_stats_debugfs_remove(fnic);
+	scsi_remove_host(fnic->lport->host);
+err_out_scsi_drv_init:
 	fnic_free_intr(fnic);
-err_out_request_intr:
-	for (i = 0; i < fnic->rq_count; i++)
+err_out_fnic_request_intr:
+err_out_alloc_rq_buf:
+	for (i = 0; i < fnic->rq_count; i++) {
+		if (ioread32(&fnic->rq[i].ctrl->enable))
+			vnic_rq_disable(&fnic->rq[i]);
 		vnic_rq_clean(&fnic->rq[i], fnic_free_rq_buf);
-err_out_rq_buf:
+	}
 	vnic_dev_notify_unset(fnic->vdev);
+err_out_fnic_notify_set:
 	mempool_destroy(fnic->frame_elem_pool);
 err_out_fdls_frame_elem_pool:
 	mempool_destroy(fnic->frame_pool);
 err_out_fdls_frame_pool:
-err_out_free_max_pool:
 	mempool_destroy(fnic->io_sgl_pool[FNIC_SGL_CACHE_MAX]);
 err_out_free_dflt_pool:
 	mempool_destroy(fnic->io_sgl_pool[FNIC_SGL_CACHE_DFLT]);
-err_out_free_ioreq_pool:
-	mempool_destroy(fnic->io_req_pool);
 err_out_free_resources:
-	for (hwq = 0; hwq < fnic->wq_copy_count; hwq++)
-		kfree(fnic->sw_copy_wq[hwq].io_req_table);
 	fnic_free_vnic_resources(fnic);
-err_out_clear_intr:
+err_out_fnic_alloc_vnic_res:
 	fnic_clear_intr_mode(fnic);
-err_out_dev_close:
+err_out_fnic_set_intr_mode:
+	if (IS_FNIC_FCP_INITIATOR(fnic))
+		scsi_host_put(fnic->lport->host);
+err_out_fnic_role:
+err_out_scsi_host_alloc:
+err_out_fnic_get_config:
+err_out_dev_mac_addr:
+err_out_dev_init:
 	vnic_dev_close(fnic->vdev);
-err_out_dev_cmd_deinit:
-err_out_vnic_unregister:
+err_out_dev_open:
+err_out_dev_cmd_init:
 	vnic_dev_unregister(fnic->vdev);
-err_out_iounmap:
+err_out_dev_register:
 	fnic_iounmap(fnic);
-err_out_release_regions:
+err_out_fnic_map_bar:
+err_out_map_bar:
+err_out_set_dma_mask:
 	pci_release_regions(pdev);
-err_out_disable_device:
+err_out_pci_request_regions:
 	pci_disable_device(pdev);
-err_out_free_hba:
-	fnic_stats_debugfs_remove(fnic);
+err_out_pci_enable_device:
 	ida_free(&fnic_ida, fnic->fnic_num);
 err_out_ida_alloc:
-	scsi_host_put(lp->host);
-err_out:
+	kfree(fnic);
+err_out_fnic_alloc:
 	return err;
 }
 
 static void fnic_remove(struct pci_dev *pdev)
 {
 	struct fnic *fnic = pci_get_drvdata(pdev);
-	struct fc_lport *lp = fnic->lport;
 	unsigned long flags;
-	int hwq;
 
 	/*
 	 * Sometimes when probe() fails and do not exit with an error code,
@@ -1009,26 +1074,21 @@ static void fnic_remove(struct pci_dev *pdev)
 	if (!fnic)
 		return;
 
-	/*
-	 * Mark state so that the workqueue thread stops forwarding
-	 * received frames and link events to the local port. ISR and
-	 * other threads that can queue work items will also stop
-	 * creating work items on the fnic workqueue
-	 */
 	spin_lock_irqsave(&fnic->fnic_lock, flags);
 	fnic->stop_rx_link_events = 1;
 	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
 
-	if (vnic_dev_get_intr_mode(fnic->vdev) == VNIC_DEV_INTR_MODE_MSI)
-		del_timer_sync(&fnic->notify_timer);
-
 	/*
 	 * Flush the fnic event queue. After this call, there should
 	 * be no event queued for this fnic device in the workqueue
 	 */
 	flush_workqueue(fnic_event_queue);
-	fnic_free_txq(&fnic->frame_queue);
-	fnic_free_txq(&fnic->tx_queue);
+
+	if (IS_FNIC_FCP_INITIATOR(fnic))
+		fnic_scsi_unload(fnic);
+
+	if (vnic_dev_get_intr_mode(fnic->vdev) == VNIC_DEV_INTR_MODE_MSI)
+		del_timer_sync(&fnic->notify_timer);
 
 	if (fnic->config.flags & VFCF_FIP_CAPABLE) {
 		del_timer_sync(&fnic->retry_fip_timer);
@@ -1043,19 +1103,6 @@ static void fnic_remove(struct pci_dev *pdev)
 	if ((fnic_fdmi_support == 1) && (fnic->iport.fabric.fdmi_pending > 0))
 		del_timer_sync(&fnic->iport.fabric.fdmi_timer);
 
-	/*
-	 * Log off the fabric. This stops all remote ports, dns port,
-	 * logs off the fabric. This flushes all rport, disc, lport work
-	 * before returning
-	 */
-	fc_fabric_logoff(fnic->lport);
-
-	spin_lock_irqsave(&fnic->fnic_lock, flags);
-	fnic->in_remove = 1;
-	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
-
-	fcoe_ctlr_destroy(&fnic->ctlr);
-	fc_lport_destroy(lp);
 	fnic_stats_debugfs_remove(fnic);
 
 	/*
@@ -1069,11 +1116,9 @@ static void fnic_remove(struct pci_dev *pdev)
 	list_del(&fnic->list);
 	spin_unlock_irqrestore(&fnic_list_lock, flags);
 
-	fc_remove_host(fnic->lport->host);
-	scsi_remove_host(fnic->lport->host);
-	for (hwq = 0; hwq < fnic->wq_copy_count; hwq++)
-		kfree(fnic->sw_copy_wq[hwq].io_req_table);
-	fc_exch_mgr_free(fnic->lport);
+	fnic_free_txq(&fnic->frame_queue);
+	fnic_free_txq(&fnic->tx_queue);
+
 	vnic_dev_notify_unset(fnic->vdev);
 	fnic_free_intr(fnic);
 	fnic_free_vnic_resources(fnic);
@@ -1083,8 +1128,13 @@ static void fnic_remove(struct pci_dev *pdev)
 	fnic_iounmap(fnic);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
+	pci_set_drvdata(pdev, NULL);
 	ida_free(&fnic_ida, fnic->fnic_num);
-	scsi_host_put(lp->host);
+	if (IS_FNIC_FCP_INITIATOR(fnic)) {
+		fnic_scsi_unload_cleanup(fnic);
+		scsi_host_put(fnic->lport->host);
+	}
+	kfree(fnic);
 }
 
 static struct pci_driver fnic_driver = {
@@ -1236,8 +1286,10 @@ static void __exit fnic_cleanup_module(void)
 {
 	pci_unregister_driver(&fnic_driver);
 	destroy_workqueue(fnic_event_queue);
-	if (fnic_fip_queue)
+	if (fnic_fip_queue) {
+		flush_workqueue(fnic_fip_queue);
 		destroy_workqueue(fnic_fip_queue);
+	}
 	kmem_cache_destroy(fnic_sgl_cache[FNIC_SGL_CACHE_MAX]);
 	kmem_cache_destroy(fnic_sgl_cache[FNIC_SGL_CACHE_DFLT]);
 	kmem_cache_destroy(fnic_io_req_cache);
diff --git a/drivers/scsi/fnic/fnic_res.c b/drivers/scsi/fnic/fnic_res.c
index dd24e25574db..763475587b7f 100644
--- a/drivers/scsi/fnic/fnic_res.c
+++ b/drivers/scsi/fnic/fnic_res.c
@@ -58,6 +58,11 @@ int fnic_get_vnic_config(struct fnic *fnic)
 	GET_CONFIG(intr_mode);
 	GET_CONFIG(wq_copy_count);
 
+	if ((c->flags & (VFCF_FC_INITIATOR)) == 0) {
+		dev_info(&fnic->pdev->dev, "vNIC role not defined (def role: FC Init)\n");
+		c->flags |= VFCF_FC_INITIATOR;
+	}
+
 	c->wq_enet_desc_count =
 		min_t(u32, VNIC_FNIC_WQ_DESCS_MAX,
 		      max_t(u32, VNIC_FNIC_WQ_DESCS_MIN,
@@ -137,29 +142,28 @@ int fnic_get_vnic_config(struct fnic *fnic)
 
 	c->wq_copy_count = min_t(u16, FNIC_WQ_COPY_MAX, c->wq_copy_count);
 
-	dev_info(&fnic->pdev->dev, "vNIC MAC addr %pM "
-		     "wq/wq_copy/rq %d/%d/%d\n",
-		     fnic->ctlr.ctl_src_addr,
+	dev_info(&fnic->pdev->dev, "fNIC MAC addr %p wq/wq_copy/rq %d/%d/%d\n",
+			fnic->data_src_addr,
 		     c->wq_enet_desc_count, c->wq_copy_desc_count,
 		     c->rq_desc_count);
-	dev_info(&fnic->pdev->dev, "vNIC node wwn %llx port wwn %llx\n",
+	dev_info(&fnic->pdev->dev, "fNIC node wwn 0x%llx port wwn 0x%llx\n",
 		     c->node_wwn, c->port_wwn);
-	dev_info(&fnic->pdev->dev, "vNIC ed_tov %d ra_tov %d\n",
+	dev_info(&fnic->pdev->dev, "fNIC ed_tov %d ra_tov %d\n",
 		     c->ed_tov, c->ra_tov);
-	dev_info(&fnic->pdev->dev, "vNIC mtu %d intr timer %d\n",
+	dev_info(&fnic->pdev->dev, "fNIC mtu %d intr timer %d\n",
 		     c->maxdatafieldsize, c->intr_timer);
-	dev_info(&fnic->pdev->dev, "vNIC flags 0x%x luns per tgt %d\n",
+	dev_info(&fnic->pdev->dev, "fNIC flags 0x%x luns per tgt %d\n",
 		     c->flags, c->luns_per_tgt);
-	dev_info(&fnic->pdev->dev, "vNIC flogi_retries %d flogi timeout %d\n",
+	dev_info(&fnic->pdev->dev, "fNIC flogi_retries %d flogi timeout %d\n",
 		     c->flogi_retries, c->flogi_timeout);
-	dev_info(&fnic->pdev->dev, "vNIC plogi retries %d plogi timeout %d\n",
+	dev_info(&fnic->pdev->dev, "fNIC plogi retries %d plogi timeout %d\n",
 		     c->plogi_retries, c->plogi_timeout);
-	dev_info(&fnic->pdev->dev, "vNIC io throttle count %d link dn timeout %d\n",
+	dev_info(&fnic->pdev->dev, "fNIC io throttle count %d link dn timeout %d\n",
 		     c->io_throttle_count, c->link_down_timeout);
-	dev_info(&fnic->pdev->dev, "vNIC port dn io retries %d port dn timeout %d\n",
+	dev_info(&fnic->pdev->dev, "fNIC port dn io retries %d port dn timeout %d\n",
 		     c->port_down_io_retries, c->port_down_timeout);
-	dev_info(&fnic->pdev->dev, "vNIC wq_copy_count: %d\n", c->wq_copy_count);
-	dev_info(&fnic->pdev->dev, "vNIC intr mode: %d\n", c->intr_mode);
+	dev_info(&fnic->pdev->dev, "fNIC wq_copy_count: %d\n", c->wq_copy_count);
+	dev_info(&fnic->pdev->dev, "fNIC intr mode: %d\n", c->intr_mode);
 
 	return 0;
 }
diff --git a/drivers/scsi/fnic/fnic_scsi.c b/drivers/scsi/fnic/fnic_scsi.c
index a38672ac224e..09d0ad597b3a 100644
--- a/drivers/scsi/fnic/fnic_scsi.c
+++ b/drivers/scsi/fnic/fnic_scsi.c
@@ -1944,6 +1944,45 @@ void fnic_terminate_rport_io(struct fc_rport *rport)
 	}
 }
 
+/*
+ * FCP-SCSI specific handling for module unload
+ *
+ */
+void fnic_scsi_unload(struct fnic *fnic)
+{
+	unsigned long flags;
+
+	/*
+	 * Mark state so that the workqueue thread stops forwarding
+	 * received frames and link events to the local port. ISR and
+	 * other threads that can queue work items will also stop
+	 * creating work items on the fnic workqueue
+	 */
+	spin_lock_irqsave(&fnic->fnic_lock, flags);
+	fnic->iport.state = FNIC_IPORT_STATE_LINK_WAIT;
+	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
+
+	if (fdls_get_state(&fnic->iport.fabric) != FDLS_STATE_INIT)
+		fnic_scsi_fcpio_reset(fnic);
+
+	spin_lock_irqsave(&fnic->fnic_lock, flags);
+	fnic->in_remove = 1;
+	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
+
+	fnic_flush_tport_event_list(fnic);
+	fnic_delete_fcp_tports(fnic);
+}
+
+void fnic_scsi_unload_cleanup(struct fnic *fnic)
+{
+	int hwq = 0;
+
+	fc_remove_host(fnic->host);
+	scsi_remove_host(fnic->host);
+	for (hwq = 0; hwq < fnic->wq_copy_count; hwq++)
+		kfree(fnic->sw_copy_wq[hwq].io_req_table);
+}
+
 /*
  * This function is exported to SCSI for sending abort cmnds.
  * A SCSI IO is represented by a io_req in the driver.
diff --git a/drivers/scsi/fnic/fnic_stats.h b/drivers/scsi/fnic/fnic_stats.h
index 1f1a1ec90a23..817b27c7d023 100644
--- a/drivers/scsi/fnic/fnic_stats.h
+++ b/drivers/scsi/fnic/fnic_stats.h
@@ -3,6 +3,7 @@
 #ifndef _FNIC_STATS_H_
 #define _FNIC_STATS_H_
 #define FNIC_MQ_MAX_QUEUES 64
+#include <scsi/scsi_transport_fc.h>
 
 struct stats_timestamps {
 	struct timespec64 last_reset_time;
@@ -116,6 +117,7 @@ struct fnic_stats {
 	struct reset_stats reset_stats;
 	struct fw_stats fw_stats;
 	struct vlan_stats vlan_stats;
+	struct fc_host_statistics host_stats;
 	struct misc_stats misc_stats;
 };
 
diff --git a/drivers/scsi/fnic/fnic_trace.c b/drivers/scsi/fnic/fnic_trace.c
index aaa4ea02fb7c..d717886808df 100644
--- a/drivers/scsi/fnic/fnic_trace.c
+++ b/drivers/scsi/fnic/fnic_trace.c
@@ -458,6 +458,12 @@ int fnic_get_stats_data(struct stats_debug_info *debug,
 
 }
 
+int fnic_get_debug_info(struct stats_debug_info *info, struct fnic *fnic)
+{
+	/* Placeholder function */
+	return 0;
+}
+
 /*
  * fnic_trace_buf_init - Initialize fnic trace buffer logging facility
  *
-- 
2.47.0


