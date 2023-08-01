Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B1C76B37A
	for <lists+linux-scsi@lfdr.de>; Tue,  1 Aug 2023 13:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234281AbjHALlK (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 1 Aug 2023 07:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234248AbjHALlI (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 1 Aug 2023 07:41:08 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996F4E43
        for <linux-scsi@vger.kernel.org>; Tue,  1 Aug 2023 04:41:07 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 371ALieU015236
        for <linux-scsi@vger.kernel.org>; Tue, 1 Aug 2023 04:41:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=rwEQpcFxToN0YvNev/yDGAhrKcZBWQcafB5Y4LQW97E=;
 b=jgFtdVQBcPbOTQHKk9yFrgS2IYa0VpRg9YjWY3ejZ2iKIWq76+6IyJANdo1+jTivukxE
 YrgaEkhdZLO9XNM0LvArRBOhwNl1Ylo84zESOdpmkiYs+6402Y+s24IRrpJhJlzCrZkK
 dNFdFq6UcOQi1JIuyq5Tsh+S3Ad/YPx4ITkZsORed6HyKDFbRYD8ObnfUKWK4eMRdJXH
 0QjCINvLM4nfMklUn6Z1QFWPIryKKqoPNBgh0RsK0vW5gbWRDdHfkDdF/m9IwEvbhsF1
 e9pzbsEPSLbzvXeSe+Sptlm67grWSYnLfMINXBEnDdDrxw3tve3OParzXNsFq84TkuMl tQ== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3s707dg823-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Tue, 01 Aug 2023 04:41:07 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 1 Aug
 2023 04:41:05 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 1 Aug 2023 04:41:05 -0700
Received: from localhost.marvell.com (unknown [10.30.46.195])
        by maili.marvell.com (Postfix) with ESMTP id 8C1323F706D;
        Tue,  1 Aug 2023 04:41:03 -0700 (PDT)
From:   Nilesh Javali <njavali@marvell.com>
To:     <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>,
        <agurumurthy@marvell.com>, <sdeodhar@marvell.com>
Subject: [PATCH 02/10] qla2xxx: Flush mailbox commands on chip reset
Date:   Tue, 1 Aug 2023 17:10:49 +0530
Message-ID: <20230801114057.27039-3-njavali@marvell.com>
X-Mailer: git-send-email 2.23.1
In-Reply-To: <20230801114057.27039-1-njavali@marvell.com>
References: <20230801114057.27039-1-njavali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: sgSs6QeIcPDLQhzR98LPhu422H-FjqJm
X-Proofpoint-ORIG-GUID: sgSs6QeIcPDLQhzR98LPhu422H-FjqJm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_06,2023-08-01_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Quinn Tran <qutran@marvell.com>

Fix race condition between Interrupt thread and Chip reset
thread in trying to flush the same mailbox. With the race
condition, the "ha->mbx_intr_comp" will get an extra complete()
call. The extra complete call create erroneous mailbox timeout
condition when the next mailbox is sent where the mailbox call
does not wait for interrupt to arrive. Instead, it advance
without waiting.

Add lock protection around the check for mailbox completion.

Cc: stable@vger.kernel.org
Fixes: b2000805a9759 ("scsi: qla2xxx: Flush mailbox commands on chip reset")
Signed-off-by: Quinn Tran <quinn.tran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
---
 drivers/scsi/qla2xxx/qla_def.h  | 1 -
 drivers/scsi/qla2xxx/qla_init.c | 7 ++++---
 drivers/scsi/qla2xxx/qla_mbx.c  | 4 ----
 drivers/scsi/qla2xxx/qla_os.c   | 1 -
 4 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 806d08f4f310..5882e61141e6 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -4412,7 +4412,6 @@ struct qla_hw_data {
 	uint8_t		aen_mbx_count;
 	atomic_t	num_pend_mbx_stage1;
 	atomic_t	num_pend_mbx_stage2;
-	atomic_t	num_pend_mbx_stage3;
 	uint16_t	frame_payload_size;
 
 	uint32_t	login_retry_count;
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 2a9fbb3e12c9..ddc9b54f5703 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -7391,14 +7391,15 @@ qla2x00_abort_isp_cleanup(scsi_qla_host_t *vha)
 	}
 
 	/* purge MBox commands */
-	if (atomic_read(&ha->num_pend_mbx_stage3)) {
+	spin_lock_irqsave(&ha->hardware_lock, flags);
+	if (test_bit(MBX_INTR_WAIT, &ha->mbx_cmd_flags)) {
 		clear_bit(MBX_INTR_WAIT, &ha->mbx_cmd_flags);
 		complete(&ha->mbx_intr_comp);
 	}
+	spin_unlock_irqrestore(&ha->hardware_lock, flags);
 
 	i = 0;
-	while (atomic_read(&ha->num_pend_mbx_stage3) ||
-	    atomic_read(&ha->num_pend_mbx_stage2) ||
+	while (atomic_read(&ha->num_pend_mbx_stage2) ||
 	    atomic_read(&ha->num_pend_mbx_stage1)) {
 		msleep(20);
 		i++;
diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mbx.c
index b05f93037875..21ec32b4fb28 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -273,7 +273,6 @@ qla2x00_mailbox_command(scsi_qla_host_t *vha, mbx_cmd_t *mcp)
 		spin_unlock_irqrestore(&ha->hardware_lock, flags);
 
 		wait_time = jiffies;
-		atomic_inc(&ha->num_pend_mbx_stage3);
 		if (!wait_for_completion_timeout(&ha->mbx_intr_comp,
 		    mcp->tov * HZ)) {
 			ql_dbg(ql_dbg_mbx, vha, 0x117a,
@@ -290,7 +289,6 @@ qla2x00_mailbox_command(scsi_qla_host_t *vha, mbx_cmd_t *mcp)
 				spin_unlock_irqrestore(&ha->hardware_lock,
 				    flags);
 				atomic_dec(&ha->num_pend_mbx_stage2);
-				atomic_dec(&ha->num_pend_mbx_stage3);
 				rval = QLA_ABORTED;
 				goto premature_exit;
 			}
@@ -302,11 +300,9 @@ qla2x00_mailbox_command(scsi_qla_host_t *vha, mbx_cmd_t *mcp)
 			ha->flags.mbox_busy = 0;
 			spin_unlock_irqrestore(&ha->hardware_lock, flags);
 			atomic_dec(&ha->num_pend_mbx_stage2);
-			atomic_dec(&ha->num_pend_mbx_stage3);
 			rval = QLA_ABORTED;
 			goto premature_exit;
 		}
-		atomic_dec(&ha->num_pend_mbx_stage3);
 
 		if (time_after(jiffies, wait_time + 5 * HZ))
 			ql_log(ql_log_warn, vha, 0x1015, "cmd=0x%x, waited %d msecs\n",
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index d622d415a3c1..a18bcc86a21a 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -3007,7 +3007,6 @@ qla2x00_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	ha->max_exchg = FW_MAX_EXCHANGES_CNT;
 	atomic_set(&ha->num_pend_mbx_stage1, 0);
 	atomic_set(&ha->num_pend_mbx_stage2, 0);
-	atomic_set(&ha->num_pend_mbx_stage3, 0);
 	atomic_set(&ha->zio_threshold, DEFAULT_ZIO_THRESHOLD);
 	ha->last_zio_threshold = DEFAULT_ZIO_THRESHOLD;
 	INIT_LIST_HEAD(&ha->tmf_pending);
-- 
2.23.1

