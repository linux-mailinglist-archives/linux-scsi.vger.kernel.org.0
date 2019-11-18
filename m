Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2B3010027C
	for <lists+linux-scsi@lfdr.de>; Mon, 18 Nov 2019 11:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfKRKf5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 18 Nov 2019 05:35:57 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6696 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726541AbfKRKf5 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 18 Nov 2019 05:35:57 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E7C4AB5F3B462A5884FD;
        Mon, 18 Nov 2019 18:35:55 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Mon, 18 Nov 2019
 18:35:49 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <hmadhani@marvell.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH -next v2] scsi: qla2xxx: Use PTR_ERR_OR_ZERO() to simplify code
Date:   Mon, 18 Nov 2019 18:43:12 +0800
Message-ID: <1574073792-26475-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fixes coccicheck warning:

drivers/scsi/qla2xxx/tcm_qla2xxx.c:1462:1-3: WARNING: PTR_ERR_OR_ZERO can be used

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 drivers/scsi/qla2xxx/tcm_qla2xxx.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/scsi/qla2xxx/tcm_qla2xxx.c b/drivers/scsi/qla2xxx/tcm_qla2xxx.c
index 042a2431..a82ad17 100644
--- a/drivers/scsi/qla2xxx/tcm_qla2xxx.c
+++ b/drivers/scsi/qla2xxx/tcm_qla2xxx.c
@@ -1459,10 +1459,7 @@ static int tcm_qla2xxx_check_initiator_node_acl(
 				       sizeof(struct qla_tgt_cmd),
 				       TARGET_PROT_ALL, port_name,
 				       qlat_sess, tcm_qla2xxx_session_cb);
-	if (IS_ERR(se_sess))
-		return PTR_ERR(se_sess);
-
-	return 0;
+	return PTR_ERR_OR_ZERO(se_sess);
 }

 static void tcm_qla2xxx_update_sess(struct fc_port *sess, port_id_t s_id,
--
2.7.4

