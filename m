Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85C8C50496
	for <lists+linux-scsi@lfdr.de>; Mon, 24 Jun 2019 10:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbfFXIaV (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 24 Jun 2019 04:30:21 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:63786 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726612AbfFXIaV (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 24 Jun 2019 04:30:21 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5O8UABr025698
        for <linux-scsi@vger.kernel.org>; Mon, 24 Jun 2019 01:30:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=uKu3aP8fHwrtOs7ov9atA4Ul8K35VQEiTcf+O74BQlk=;
 b=T8/uaY2yKjKW5i+hFLBTWTEWapzFGMlfm6W1lBuB3yqNr4oeLg6swny3xgWVpnyZUYSV
 UeCvNi6aXelGJwdxMrLNIBizoi6DnrnUNjVk4g6ybNxJIE7nzyjFE+gYEe2Xnkz3IQEy
 YV/C155kkBWqrJCtKE9vMnPQF4J0/8t/vdVKI//d1zDkHCD9Nq0g8wBpgn/aiz34xKYh
 QiP7iziM+FAimUq7NcNJ98nM5sqPvuRebQDO+DFtv9IbcBz+zZFnu6vbumekhvyByHLd
 2r1h4VvIGuWoI/aYRSZ8jO9dcQbrdoWIVuPwgp+VSnkvdRnraZxwAHOf7O/sCfueECor Ng== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2t9kujdw88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Mon, 24 Jun 2019 01:30:19 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 24 Jun
 2019 01:30:17 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Mon, 24 Jun 2019 01:30:17 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id 246ED3F703F;
        Mon, 24 Jun 2019 01:30:17 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id x5O8UGUq023239;
        Mon, 24 Jun 2019 01:30:17 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id x5O8UGcU023238;
        Mon, 24 Jun 2019 01:30:16 -0700
From:   Saurav Kashyap <skashyap@marvell.com>
To:     <martin.petersen@oracle.com>
CC:     <gbasrur@marvell.com>, <svernekar@marvell.com>,
        <linux-scsi@vger.kernel.org>
Subject: [PATCH 5/6] bnx2fc: Limit the IO size according to the FW capability.
Date:   Mon, 24 Jun 2019 01:29:59 -0700
Message-ID: <20190624083000.23074-6-skashyap@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190624083000.23074-1-skashyap@marvell.com>
References: <20190624083000.23074-1-skashyap@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-24_06:,,
 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

- Reduce the sg_tablesize to 255.
- Reduce the MAX BDs firmware can handle to 255.
- Return IO to ML if BD goes more then 255 after split.
- Correct the size of each BD split to 0xffff.

Signed-off-by: Saurav Kashyap <skashyap@marvell.com>
---
 drivers/scsi/bnx2fc/bnx2fc.h      |  5 +++--
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c |  3 ++-
 drivers/scsi/bnx2fc/bnx2fc_io.c   | 11 +++++++++++
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/bnx2fc/bnx2fc.h b/drivers/scsi/bnx2fc/bnx2fc.h
index 14cc692..170abe9 100644
--- a/drivers/scsi/bnx2fc/bnx2fc.h
+++ b/drivers/scsi/bnx2fc/bnx2fc.h
@@ -75,8 +75,9 @@
 #define BNX2X_DOORBELL_PCI_BAR		2
 
 #define BNX2FC_MAX_BD_LEN		0xffff
-#define BNX2FC_BD_SPLIT_SZ		0x8000
-#define BNX2FC_MAX_BDS_PER_CMD		256
+#define BNX2FC_BD_SPLIT_SZ		0xffff
+#define BNX2FC_MAX_BDS_PER_CMD		255
+#define BNX2FC_FW_MAX_BDS_PER_CMD	255
 
 #define BNX2FC_SQ_WQES_MAX	256
 
diff --git a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
index a75e74a..7796799 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
@@ -2971,7 +2971,8 @@ static struct scsi_host_template bnx2fc_shost_template = {
 	.this_id		= -1,
 	.cmd_per_lun		= 3,
 	.sg_tablesize		= BNX2FC_MAX_BDS_PER_CMD,
-	.max_sectors		= 1024,
+	.dma_boundary           = 0x7fff,
+	.max_sectors		= 0x3fbf,
 	.track_queue_depth	= 1,
 	.slave_configure	= bnx2fc_slave_configure,
 	.shost_attrs		= bnx2fc_host_attrs,
diff --git a/drivers/scsi/bnx2fc/bnx2fc_io.c b/drivers/scsi/bnx2fc/bnx2fc_io.c
index d7eb5e1..ff0c696 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_io.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_io.c
@@ -1660,6 +1660,7 @@ static int bnx2fc_map_sg(struct bnx2fc_cmd *io_req)
 	u64 addr;
 	int i;
 
+	WARN_ON(scsi_sg_count(sc) > BNX2FC_MAX_BDS_PER_CMD);
 	/*
 	 * Use dma_map_sg directly to ensure we're using the correct
 	 * dev struct off of pcidev.
@@ -1707,6 +1708,16 @@ static int bnx2fc_build_bd_list_from_sg(struct bnx2fc_cmd *io_req)
 	}
 	io_req->bd_tbl->bd_valid = bd_count;
 
+	/*
+	 * Return the command to ML if BD count increase the max number
+	 * that can be handled by FW.
+	 */
+	if (bd_count > BNX2FC_FW_MAX_BDS_PER_CMD) {
+		pr_err("bd_count = %d increased FW supported max BD(255), task_id = 0x%x\n",
+		       bd_count, io_req->xid);
+		return -ENOMEM;
+	}
+
 	return 0;
 }
 
-- 
1.8.3.1

