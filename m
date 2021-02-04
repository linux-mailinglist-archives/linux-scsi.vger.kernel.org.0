Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00D8D30ED23
	for <lists+linux-scsi@lfdr.de>; Thu,  4 Feb 2021 08:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbhBDHSa (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 4 Feb 2021 02:18:30 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:35254 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231791AbhBDHSZ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 4 Feb 2021 02:18:25 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UNpW3vb_1612423059;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UNpW3vb_1612423059)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 04 Feb 2021 15:17:39 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     njavali@marvell.com
Cc:     mrangankar@marvell.com, GR-QLogic-Storage-Upstream@marvell.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] scsi: qla4xxx: Remove unneeded return variable
Date:   Thu,  4 Feb 2021 15:17:37 +0800
Message-Id: <1612423057-72018-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch removes unneeded return variables, using only
'0' instead.
It fixes the following warning detected by coccinelle:
./drivers/scsi/qla4xxx/ql4_os.c:3642:5-7: Unneeded variable: "rc".
Return "0" on line 3741

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/scsi/qla4xxx/ql4_os.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
index a4b014e..ed92534 100644
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -3639,7 +3639,6 @@ static int qla4xxx_copy_to_fwddb_param(struct iscsi_bus_flash_session *sess,
 				       struct dev_db_entry *fw_ddb_entry)
 {
 	uint16_t options;
-	int rc = 0;
 
 	options = le16_to_cpu(fw_ddb_entry->options);
 	SET_BITVAL(conn->is_fw_assigned_ipv6,  options, BIT_11);
@@ -3738,7 +3737,7 @@ static int qla4xxx_copy_to_fwddb_param(struct iscsi_bus_flash_session *sess,
 
 	COPY_ISID(fw_ddb_entry->isid, sess->isid);
 
-	return rc;
+	return 0;
 }
 
 static void qla4xxx_copy_to_sess_conn_params(struct iscsi_conn *conn,
-- 
1.8.3.1

