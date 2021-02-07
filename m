Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7678E31221C
	for <lists+linux-scsi@lfdr.de>; Sun,  7 Feb 2021 08:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhBGG7w (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 7 Feb 2021 01:59:52 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:37808 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229506AbhBGG7Y (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 7 Feb 2021 01:59:24 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UO3Fm3M_1612681120;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UO3Fm3M_1612681120)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 07 Feb 2021 14:58:40 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     Johannes.Thumshirn@wdc.com
Cc:     njavali@marvell.com, mrangankar@marvell.com,
        GR-QLogic-Storage-Upstream@marvell.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] scsi: qla4xxx: turn qla4xxx_copy_from_fwddb_param() into void
Date:   Sun,  7 Feb 2021 14:58:38 +0800
Message-Id: <1612681118-59482-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This function always return '0' and no callers use the return value.
So make it a void function.

This eliminates the following coccicheck warning:
./drivers/scsi/qla4xxx/ql4_os.c:3642:5-7: Unneeded variable: "rc".
Return "0" on line 3741

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/scsi/qla4xxx/ql4_os.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
index a4b014e..18dcb68 100644
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -3634,12 +3634,11 @@ static int qla4xxx_copy_from_fwddb_param(struct iscsi_bus_flash_session *sess,
 	return rc;
 }
 
-static int qla4xxx_copy_to_fwddb_param(struct iscsi_bus_flash_session *sess,
+static void qla4xxx_copy_to_fwddb_param(struct iscsi_bus_flash_session *sess,
 				       struct iscsi_bus_flash_conn *conn,
 				       struct dev_db_entry *fw_ddb_entry)
 {
 	uint16_t options;
-	int rc = 0;
 
 	options = le16_to_cpu(fw_ddb_entry->options);
 	SET_BITVAL(conn->is_fw_assigned_ipv6,  options, BIT_11);
@@ -3738,7 +3737,7 @@ static int qla4xxx_copy_to_fwddb_param(struct iscsi_bus_flash_session *sess,
 
 	COPY_ISID(fw_ddb_entry->isid, sess->isid);
 
-	return rc;
+	return;
 }
 
 static void qla4xxx_copy_to_sess_conn_params(struct iscsi_conn *conn,
-- 
1.8.3.1

