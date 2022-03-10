Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69C14D437A
	for <lists+linux-scsi@lfdr.de>; Thu, 10 Mar 2022 10:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240814AbiCJJ1d (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 10 Mar 2022 04:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240793AbiCJJ11 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 10 Mar 2022 04:27:27 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD301139CEA
        for <linux-scsi@vger.kernel.org>; Thu, 10 Mar 2022 01:26:26 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22A1dlxH024974
        for <linux-scsi@vger.kernel.org>; Thu, 10 Mar 2022 01:26:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=xr8l3HAlXWQj5jb/Rl5aN3xoL4nJU15Xj0Gc3wx0zyE=;
 b=fkIBCevWz7ARECkdUKsPVnM0D03A0SrbVzXPSGQ59bQXZeaHzXJs8YheEoohsZSwMQkB
 AOWEpug5ELcRjijcGvPnwL1WLDuSgt+QVl9ZRyfpsflT10IxtG4ANJ3aCNgJAwbqLa8c
 0VKpYPAyFY6NGFK/jBGyWq7y14dcnimoyCYR0uCZdd7xsYQxgh3dFezqLDeHSyjItUBZ
 LxexXUr3+KarwwskbgYNGBSy03/h1TXXhi5UIX4Fs3mlKtbs0/rUFWovC+CIQ1hdUBO+
 NTiPvTMuY0+jNvcENMmkNPMub4fxniz5N41biazRKMO2v4Jw+Hl7A8mOJBd9L+YSv1qD 4Q== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3ep38pmd7x-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Thu, 10 Mar 2022 01:26:25 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 10 Mar
 2022 01:26:23 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 10 Mar 2022 01:26:23 -0800
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id 210E53F705C;
        Thu, 10 Mar 2022 01:26:23 -0800 (PST)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id 22A9QMQO023001;
        Thu, 10 Mar 2022 01:26:22 -0800
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id 22A9QMfp023000;
        Thu, 10 Mar 2022 01:26:22 -0800
From:   Nilesh Javali <njavali@marvell.com>
To:     <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>
Subject: [PATCH v2 04/13] qla2xxx: Fix missed DMA unmap for NVME ls requests
Date:   Thu, 10 Mar 2022 01:25:55 -0800
Message-ID: <20220310092604.22950-5-njavali@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20220310092604.22950-1-njavali@marvell.com>
References: <20220310092604.22950-1-njavali@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: jvacIHfaPQHzKFAAN4EO9VMW22SdjH9_
X-Proofpoint-ORIG-GUID: jvacIHfaPQHzKFAAN4EO9VMW22SdjH9_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-10_03,2022-03-09_01,2022-02-23_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Arun Easi <aeasi@marvell.com>

At NVME ELS request time, request structure is DMA mapped
and never unmapped. Fix this by calling the unmap on
ELS completion.

Cc: stable@vger.kernel.org
Fixes: e84067d74301 ("scsi: qla2xxx: Add FC-NVMe F/W initialization and transport registration")
Signed-off-by: Arun Easi <aeasi@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
---
 drivers/scsi/qla2xxx/qla_nvme.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index 3bf5cbd754a7..794a95b2e3b4 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -175,6 +175,18 @@ static void qla_nvme_release_fcp_cmd_kref(struct kref *kref)
 	qla2xxx_rel_qpair_sp(sp->qpair, sp);
 }
 
+static void qla_nvme_ls_unmap(struct srb *sp, struct nvmefc_ls_req *fd)
+{
+	if (sp->flags & SRB_DMA_VALID) {
+		struct srb_iocb *nvme = &sp->u.iocb_cmd;
+		struct qla_hw_data *ha = sp->fcport->vha->hw;
+
+		dma_unmap_single(&ha->pdev->dev, nvme->u.nvme.cmd_dma,
+				 fd->rqstlen, DMA_TO_DEVICE);
+		sp->flags &= ~SRB_DMA_VALID;
+	}
+}
+
 static void qla_nvme_release_ls_cmd_kref(struct kref *kref)
 {
 	struct srb *sp = container_of(kref, struct srb, cmd_kref);
@@ -191,6 +203,8 @@ static void qla_nvme_release_ls_cmd_kref(struct kref *kref)
 	spin_unlock_irqrestore(&priv->cmd_lock, flags);
 
 	fd = priv->fd;
+
+	qla_nvme_ls_unmap(sp, fd);
 	fd->done(fd, priv->comp_status);
 out:
 	qla2x00_rel_sp(sp);
@@ -361,6 +375,8 @@ static int qla_nvme_ls_req(struct nvme_fc_local_port *lport,
 	dma_sync_single_for_device(&ha->pdev->dev, nvme->u.nvme.cmd_dma,
 	    fd->rqstlen, DMA_TO_DEVICE);
 
+	sp->flags |= SRB_DMA_VALID;
+
 	rval = qla2x00_start_sp(sp);
 	if (rval != QLA_SUCCESS) {
 		ql_log(ql_log_warn, vha, 0x700e,
@@ -368,6 +384,7 @@ static int qla_nvme_ls_req(struct nvme_fc_local_port *lport,
 		wake_up(&sp->nvme_ls_waitq);
 		sp->priv = NULL;
 		priv->sp = NULL;
+		qla_nvme_ls_unmap(sp, fd);
 		qla2x00_rel_sp(sp);
 		return rval;
 	}
-- 
2.19.0.rc0

