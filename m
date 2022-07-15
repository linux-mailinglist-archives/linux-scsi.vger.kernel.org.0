Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F1E575B26
	for <lists+linux-scsi@lfdr.de>; Fri, 15 Jul 2022 08:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiGOGCj (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 15 Jul 2022 02:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiGOGCg (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 15 Jul 2022 02:02:36 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AAC7A539
        for <linux-scsi@vger.kernel.org>; Thu, 14 Jul 2022 23:02:34 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26F1ifo8013575
        for <linux-scsi@vger.kernel.org>; Thu, 14 Jul 2022 23:02:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=FwKNVYn+/3M6VKWq+uG8gYxPeBoQiLHuH6iLxqzrpEs=;
 b=fZfiTpg9+qTeYjXa6ZBThjU5odaFtQwykEqmLbUYWFh1fuEwtXqA/BTsw8SXwxIVKZId
 E18CsjBh9hmlvbkIZC4ISGnI8zCAOi2yXqJfaV84ej1f4EqDodJKaYCxQ2De4whj3Dip
 nfcBJQkxVp+6wTbrDdOic4d60Xbwow9uY8kxX1O86/gVcDv6s+MXY9PTTSsPJidNYpJY
 Kuy9K0phKWwbZgeuh7hN/25IdqQcEjjfhFjZiLWwAVLBRCBINN8Pu92AqEVWCzErG8nt
 s73yy5Gze69Q2H0xTL9ZnLkf54DIW1Kx3VZ2cwS7CIGdPNCaV3DSEiAhgpujlFGIixws TA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3haxu9gkug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Thu, 14 Jul 2022 23:02:33 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 14 Jul
 2022 23:02:32 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 14 Jul 2022 23:02:32 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id 327C93F706D;
        Thu, 14 Jul 2022 23:02:32 -0700 (PDT)
From:   Nilesh Javali <njavali@marvell.com>
To:     <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>, <bhazarika@marvell.com>,
        <agurumurthy@marvell.com>
Subject: [PATCH 1/6] qla2xxx: Add debugfs create/delete helpers
Date:   Thu, 14 Jul 2022 23:02:22 -0700
Message-ID: <20220715060227.23923-2-njavali@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20220715060227.23923-1-njavali@marvell.com>
References: <20220715060227.23923-1-njavali@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: sRdLAjJ6WKkVjIJGUn-7zF6vReHd8qHt
X-Proofpoint-GUID: sRdLAjJ6WKkVjIJGUn-7zF6vReHd8qHt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-15_02,2022-07-14_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Arun Easi <aeasi@marvell.com>

Define a few helpful macros for creating debugfs files.

Signed-off-by: Arun Easi <aeasi@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
---
 drivers/scsi/qla2xxx/qla_def.h |  5 ++
 drivers/scsi/qla2xxx/qla_dfs.c | 90 ++++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 3ec6a200942e..22274b405d01 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -35,6 +35,11 @@
 
 #include <uapi/scsi/fc/fc_els.h>
 
+#define QLA_DFS_DEFINE_DENTRY(_debugfs_file_name) \
+	struct dentry *dfs_##_debugfs_file_name
+#define QLA_DFS_ROOT_DEFINE_DENTRY(_debugfs_file_name) \
+	struct dentry *qla_dfs_##_debugfs_file_name
+
 /* Big endian Fibre Channel S_ID (source ID) or D_ID (destination ID). */
 typedef struct {
 	uint8_t domain;
diff --git a/drivers/scsi/qla2xxx/qla_dfs.c b/drivers/scsi/qla2xxx/qla_dfs.c
index 85bd0e468d43..c3c8b9536ef6 100644
--- a/drivers/scsi/qla2xxx/qla_dfs.c
+++ b/drivers/scsi/qla2xxx/qla_dfs.c
@@ -489,6 +489,96 @@ qla_dfs_naqp_show(struct seq_file *s, void *unused)
 	return 0;
 }
 
+/*
+ * Helper macros for setting up debugfs entries.
+ * _name: The name of the debugfs entry
+ * _ctx_struct: The context that was passed when creating the debugfs file
+ *
+ * QLA_DFS_SETUP_RD could be used when there is only a show function.
+ * - show function take the name qla_dfs_<sysfs-name>_show
+ *
+ * QLA_DFS_SETUP_RW could be used when there are both show and write functions.
+ * - show function take the name  qla_dfs_<sysfs-name>_show
+ * - write function take the name qla_dfs_<sysfs-name>_write
+ *
+ * To have a new debugfs entry, do:
+ * 1. Create a "struct dentry *" in the appropriate structure in the format
+ * dfs_<sysfs-name>
+ * 2. Setup debugfs entries using QLA_DFS_SETUP_RD / QLA_DFS_SETUP_RW
+ * 3. Create debugfs file in qla2x00_dfs_setup() using QLA_DFS_CREATE_FILE
+ * or QLA_DFS_ROOT_CREATE_FILE
+ * 4. Remove debugfs file in qla2x00_dfs_remove() using QLA_DFS_REMOVE_FILE
+ * or QLA_DFS_ROOT_REMOVE_FILE
+ *
+ * Example for creating "TEST" sysfs file:
+ * 1. struct qla_hw_data { ... struct dentry *dfs_TEST; }
+ * 2. QLA_DFS_SETUP_RD(TEST, scsi_qla_host_t);
+ * 3. In qla2x00_dfs_setup():
+ * QLA_DFS_CREATE_FILE(ha, TEST, 0600, ha->dfs_dir, vha);
+ * 4. In qla2x00_dfs_remove():
+ * QLA_DFS_REMOVE_FILE(ha, TEST);
+ */
+#define QLA_DFS_SETUP_RD(_name, _ctx_struct)				\
+static int								\
+qla_dfs_##_name##_open(struct inode *inode, struct file *file)		\
+{									\
+	_ctx_struct *__ctx = inode->i_private;				\
+									\
+	return single_open(file, qla_dfs_##_name##_show, __ctx);	\
+}									\
+									\
+static const struct file_operations qla_dfs_##_name##_ops = {		\
+	.open           = qla_dfs_##_name##_open,			\
+	.read           = seq_read,					\
+	.llseek         = seq_lseek,					\
+	.release        = single_release,				\
+};
+
+#define QLA_DFS_SETUP_RW(_name, _ctx_struct)		 		\
+static int								\
+qla_dfs_##_name##_open(struct inode *inode, struct file *file)		\
+{									\
+	_ctx_struct *__ctx = inode->i_private;				\
+									\
+	return single_open(file, qla_dfs_##_name##_show, __ctx);	\
+}									\
+									\
+static const struct file_operations qla_dfs_##_name##_ops = {		\
+	.open           = qla_dfs_##_name##_open,			\
+	.read           = seq_read,					\
+	.llseek         = seq_lseek,					\
+	.release        = single_release,				\
+	.write		= qla_dfs_##_name##_write,			\
+};
+
+#define QLA_DFS_ROOT_CREATE_FILE(_name, _perm, _ctx)			\
+	do {								\
+		if (!qla_dfs_##_name)					\
+			qla_dfs_##_name = debugfs_create_file(#_name,	\
+					_perm, qla2x00_dfs_root, _ctx,	\
+					&qla_dfs_##_name##_ops);	\
+	} while (0)
+
+#define QLA_DFS_ROOT_REMOVE_FILE(_name)					\
+	do {								\
+		if (qla_dfs_##_name) {					\
+			debugfs_remove(qla_dfs_##_name);		\
+			qla_dfs_##_name = NULL;				\
+		}							\
+	} while (0)
+
+#define QLA_DFS_CREATE_FILE(_struct, _name, _perm, _parent, _ctx)	\
+	(_struct)->dfs_##_name = debugfs_create_file(#_name, _perm,	\
+				_parent, _ctx, &qla_dfs_##_name##_ops);
+
+#define QLA_DFS_REMOVE_FILE(_struct, _name)				\
+	do {								\
+		if ((_struct)->dfs_##_name) {				\
+			debugfs_remove((_struct)->dfs_##_name);		\
+			(_struct)->dfs_##_name = NULL;			\
+		}							\
+	} while (0)
+
 static int
 qla_dfs_naqp_open(struct inode *inode, struct file *file)
 {
-- 
2.19.0.rc0

