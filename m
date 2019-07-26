Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F80A76E96
	for <lists+linux-scsi@lfdr.de>; Fri, 26 Jul 2019 18:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfGZQIN (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 26 Jul 2019 12:08:13 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:32050 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726141AbfGZQIN (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 26 Jul 2019 12:08:13 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x6QG5fBa017783;
        Fri, 26 Jul 2019 09:08:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=2PKUIoz3U9tfKMQRxvXXcTbbGTF7Yw+w28FO7cun8Qg=;
 b=XUOSoB/6ZJuQ3U2mbBhkNk9AXoV12UlV6/cBieXLLSWhtIFkDL5IdmEdcKLJ5tQFDKwk
 Gp5w6fR+7Gwhd00CiWGz9Hnm4qUuhlJsl2nbUMeKu72uIFGI48wji/IjWtz7RA4A8KL5
 IrOB9r+ZCuDsDK0Fe9bZKck991m0c4pCPRNQ/6TgJ74WyxoJf3BEeQuuXusAbb1vxeOq
 yFhnXXi43sCkyMBwRiC7MMQTwOCd9emsnXX/S2Ucfqc3D/0RFuFoHFsQJrDyD/B23mn9
 ZdtMYMrYvIdRzZOZiPN8W2wU87YPsuSDc7Th9lDlQCjTs1X1Se2lsJy1LbxgVktE9oFf mw== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2tx61rqjy9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 26 Jul 2019 09:08:10 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 26 Jul
 2019 09:08:09 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Fri, 26 Jul 2019 09:08:09 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id 9A28C3F7040;
        Fri, 26 Jul 2019 09:08:09 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id x6QG89ZW025770;
        Fri, 26 Jul 2019 09:08:09 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id x6QG89If025769;
        Fri, 26 Jul 2019 09:08:09 -0700
From:   Himanshu Madhani <hmadhani@marvell.com>
To:     <James.Bottomley@HansenPartnership.com>,
        <martin.petersen@oracle.com>
CC:     <hmadhani@marvell.com>, <linux-scsi@vger.kernel.org>
Subject: [PATCH 10/15] qla2xxx: Correct error handling during initialization failures
Date:   Fri, 26 Jul 2019 09:07:35 -0700
Message-ID: <20190726160740.25687-11-hmadhani@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190726160740.25687-1-hmadhani@marvell.com>
References: <20190726160740.25687-1-hmadhani@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-07-26_12:2019-07-26,2019-07-26 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Andrew Vasquez <andrewv@marvell.com>

Current code misses or fails to account for proper recovery during early
initialization failures:

- Properly unwind allocations during probe() failures.
- Protect against non-initialization memory allocations during
  unwinding.
- Propagate error status during HW initialization.
- Release SCSI host reference when memory allocations fail.

Signed-off-by: Andrew Vasquez <andrewv@marvell.com>
Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
---
 drivers/scsi/qla2xxx/qla_init.c |  4 ++++
 drivers/scsi/qla2xxx/qla_os.c   | 16 ++++++++++------
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 02bbc5bdaa43..1a8b4a587e0f 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -2293,6 +2293,10 @@ qla2x00_initialize_adapter(scsi_qla_host_t *vha)
 	if (qla_ini_mode_enabled(vha) || qla_dual_mode_enabled(vha))
 		rval = qla2x00_init_rings(vha);
 
+	/* No point in continuing if firmware initialization failed. */
+	if (rval != QLA_SUCCESS)
+		return rval;
+
 	ha->flags.chip_reset_done = 1;
 
 	if (rval == QLA_SUCCESS && IS_QLA84XX(ha)) {
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index d34f6ba36a03..17d581563eec 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -1809,8 +1809,13 @@ qla2x00_abort_all_cmds(scsi_qla_host_t *vha, int res)
 	int que;
 	struct qla_hw_data *ha = vha->hw;
 
+	/* Continue only if initialization complete. */
+	if (!ha->base_qpair)
+		return;
 	__qla2x00_abort_all_cmds(ha->base_qpair, res);
 
+	if (!ha->queue_pair_map)
+		return;
 	for (que = 0; que < ha->max_qpairs; que++) {
 		if (!ha->queue_pair_map[que])
 			continue;
@@ -3163,6 +3168,7 @@ qla2x00_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 		ql_log(ql_log_fatal, base_vha, 0x003d,
 		    "Failed to allocate memory for queue pointers..."
 		    "aborting.\n");
+		ret = -ENODEV;
 		goto probe_failed;
 	}
 
@@ -4717,7 +4723,7 @@ qla2x00_mem_free(struct qla_hw_data *ha)
 	mempool_destroy(ha->ctx_mempool);
 	ha->ctx_mempool = NULL;
 
-	if (ql2xenabledif) {
+	if (ql2xenabledif && ha->dif_bundl_pool) {
 		struct dsd_dma *dsd, *nxt;
 
 		list_for_each_entry_safe(dsd, nxt, &ha->pool.unusable.head,
@@ -4738,10 +4744,8 @@ qla2x00_mem_free(struct qla_hw_data *ha)
 			kfree(dsd);
 			ha->dif_bundle_kallocs--;
 		}
-	}
-
-	if (ha->dif_bundl_pool)
 		dma_pool_destroy(ha->dif_bundl_pool);
+	}
 	ha->dif_bundl_pool = NULL;
 
 	qlt_mem_free(ha);
@@ -4813,7 +4817,7 @@ struct scsi_qla_host *qla2x00_create_host(struct scsi_host_template *sht,
 	if (!vha->gnl.l) {
 		ql_log(ql_log_fatal, vha, 0xd04a,
 		    "Alloc failed for name list.\n");
-		scsi_remove_host(vha->host);
+		scsi_host_put(vha->host);
 		return NULL;
 	}
 
@@ -4825,7 +4829,7 @@ struct scsi_qla_host *qla2x00_create_host(struct scsi_host_template *sht,
 		    "Alloc failed for scan database.\n");
 		dma_free_coherent(&ha->pdev->dev, vha->gnl.size,
 		    vha->gnl.l, vha->gnl.ldma);
-		scsi_remove_host(vha->host);
+		scsi_host_put(vha->host);
 		return NULL;
 	}
 	INIT_DELAYED_WORK(&vha->scan.scan_work, qla_scan_work_fn);
-- 
2.12.0

