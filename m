Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41FAE2FCB88
	for <lists+linux-scsi@lfdr.de>; Wed, 20 Jan 2021 08:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbhATHc7 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 20 Jan 2021 02:32:59 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:48810 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726218AbhATHc5 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 20 Jan 2021 02:32:57 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=abaci-bugfix@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UMJDC-C_1611127920;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:abaci-bugfix@linux.alibaba.com fp:SMTPD_---0UMJDC-C_1611127920)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 20 Jan 2021 15:32:05 +0800
From:   Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
To:     njavali@marvell.com
Cc:     GR-QLogic-Storage-Upstream@marvell.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
Subject: [PATCH] scsi: qla2xxx: Assign boolean values to a bool variable
Date:   Wed, 20 Jan 2021 15:31:59 +0800
Message-Id: <1611127919-56551-1-git-send-email-abaci-bugfix@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fix the following coccicheck warnings:

./drivers/scsi/qla2xxx/qla_isr.c:780:2-18: WARNING: Assignment
of 0/1 to bool variable.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
---
 drivers/scsi/qla2xxx/qla_isr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index f9142db..77a7acd 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -761,7 +761,7 @@ static struct purex_item *qla27xx_copy_fpin_pkt(struct scsi_qla_host *vha,
 qla27xx_handle_8200_aen(scsi_qla_host_t *vha, uint16_t *mb)
 {
 	struct qla_hw_data *ha = vha->hw;
-	bool reset_isp_needed = 0;
+	bool reset_isp_needed = false;
 
 	ql_log(ql_log_warn, vha, 0x02f0,
 	       "MPI Heartbeat stop. MPI reset is%s needed. "
@@ -777,7 +777,7 @@ static struct purex_item *qla27xx_copy_fpin_pkt(struct scsi_qla_host *vha,
 
 	if (ql2xfulldump_on_mpifail) {
 		ha->isp_ops->fw_dump(vha);
-		reset_isp_needed = 1;
+		reset_isp_needed = true;
 	}
 
 	ha->isp_ops->mpi_fw_dump(vha, 1);
-- 
1.8.3.1

