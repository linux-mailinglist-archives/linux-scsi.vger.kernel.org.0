Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06EF225D0B5
	for <lists+linux-scsi@lfdr.de>; Fri,  4 Sep 2020 06:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgIDExK (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 4 Sep 2020 00:53:10 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:22150 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725765AbgIDExJ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 4 Sep 2020 00:53:09 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0844nvnR015131
        for <linux-scsi@vger.kernel.org>; Thu, 3 Sep 2020 21:53:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=d7iHBgtP/o0011AKfJD0sX9tsQUOhJXaogP1p1n0E9g=;
 b=B3mjbuRXnRFRKrBL+VW6dP2TA6AS81dKhYak1Bcr4dE4TrESSetmPzif47NhQNARgg9b
 HQQc9aBg6eWi9qUZQN+2nePHqJMeM8itrNGt6yiBHmaHdqw8KlCOS4Znxx+rQYdZwL+C
 npT1eQBIRVpDMBYNvOvSkpkmjR+snO4ZKhymLWOuDmvprdBEWGd1/UcwagIhzYssJlM7
 THJDzusA3uuXqLas0zxT9+Dfb8wmy4J/47xttvLhH6XQDxx4YFjFvzZdZwFJ7fXGREGH
 rTImVn8DB/RPawLaj4du7Ww+kpQ/l+xtO3ucKCa08khatBtuePmiEDvw6Ujj/Op6xCQK xQ== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 337phqfuvp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Thu, 03 Sep 2020 21:53:08 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 3 Sep
 2020 21:53:06 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 3 Sep
 2020 21:53:05 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 3 Sep 2020 21:53:05 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id E09EA3F703F;
        Thu,  3 Sep 2020 21:53:04 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id 0844r4FU023695;
        Thu, 3 Sep 2020 21:53:04 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id 0844r4Rx023686;
        Thu, 3 Sep 2020 21:53:04 -0700
From:   Nilesh Javali <njavali@marvell.com>
To:     <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>
Subject: [PATCH v3 03/13] qla2xxx: Allow dev_loss_tmo setting for FC-NVMe devices
Date:   Thu, 3 Sep 2020 21:51:18 -0700
Message-ID: <20200904045128.23631-4-njavali@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20200904045128.23631-1-njavali@marvell.com>
References: <20200904045128.23631-1-njavali@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-04_02:2020-09-03,2020-09-04 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Arun Easi <aeasi@marvell.com>

Add a remote port debugfs entry to get/set dev_loss_tmo for NVMe
devices.

Signed-off-by: Arun Easi <aeasi@marvell.com>
Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Reported-by: kernel test robot <lkp@intel.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
---
 drivers/scsi/qla2xxx/qla_dfs.c | 58 ++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_dfs.c b/drivers/scsi/qla2xxx/qla_dfs.c
index 3c4b9b549b17..616ce891818d 100644
--- a/drivers/scsi/qla2xxx/qla_dfs.c
+++ b/drivers/scsi/qla2xxx/qla_dfs.c
@@ -12,6 +12,61 @@
 static struct dentry *qla2x00_dfs_root;
 static atomic_t qla2x00_dfs_root_count;
 
+#define QLA_DFS_RPORT_DEVLOSS_TMO	1
+
+static int
+qla_dfs_rport_get(struct fc_port *fp, int attr_id, u64 *val)
+{
+	switch (attr_id) {
+	case QLA_DFS_RPORT_DEVLOSS_TMO:
+		/* Only supported for FC-NVMe devices that are registered. */
+		if (!(fp->nvme_flag & NVME_FLAG_REGISTERED))
+			return -EIO;
+		*val = fp->nvme_remote_port->dev_loss_tmo;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int
+qla_dfs_rport_set(struct fc_port *fp, int attr_id, u64 val)
+{
+	switch (attr_id) {
+	case QLA_DFS_RPORT_DEVLOSS_TMO:
+		/* Only supported for FC-NVMe devices that are registered. */
+		if (!(fp->nvme_flag & NVME_FLAG_REGISTERED))
+			return -EIO;
+#if (IS_ENABLED(CONFIG_NVME_FC))
+		return nvme_fc_set_remoteport_devloss(fp->nvme_remote_port,
+						      val);
+#else /* CONFIG_NVME_FC */
+		return -EINVAL;
+#endif /* CONFIG_NVME_FC */
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+#define DEFINE_QLA_DFS_RPORT_RW_ATTR(_attr_id, _attr)		\
+static int qla_dfs_rport_##_attr##_get(void *data, u64 *val)	\
+{								\
+	struct fc_port *fp = data;				\
+	return qla_dfs_rport_get(fp, _attr_id, val);		\
+}								\
+static int qla_dfs_rport_##_attr##_set(void *data, u64 val)	\
+{								\
+	struct fc_port *fp = data;				\
+	return qla_dfs_rport_set(fp, _attr_id, val);		\
+}								\
+DEFINE_DEBUGFS_ATTRIBUTE(qla_dfs_rport_##_attr##_fops,		\
+		qla_dfs_rport_##_attr##_get,			\
+		qla_dfs_rport_##_attr##_set, "%llu\n")
+
+DEFINE_QLA_DFS_RPORT_RW_ATTR(QLA_DFS_RPORT_DEVLOSS_TMO, dev_loss_tmo);
+
 void
 qla2x00_dfs_create_rport(scsi_qla_host_t *vha, struct fc_port *fp)
 {
@@ -24,6 +79,9 @@ qla2x00_dfs_create_rport(scsi_qla_host_t *vha, struct fc_port *fp)
 	fp->dfs_rport_dir = debugfs_create_dir(wwn, vha->dfs_rport_root);
 	if (!fp->dfs_rport_dir)
 		return;
+	if (NVME_TARGET(vha->hw, fp))
+		debugfs_create_file("dev_loss_tmo", 0600, fp->dfs_rport_dir,
+				    fp, &qla_dfs_rport_dev_loss_tmo_fops);
 }
 
 void
-- 
2.19.0.rc0

