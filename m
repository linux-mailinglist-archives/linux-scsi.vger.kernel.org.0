Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D081C6A5D
	for <lists+linux-scsi@lfdr.de>; Wed,  6 May 2020 09:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbgEFHsU (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 6 May 2020 03:48:20 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50036 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728335AbgEFHsU (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 6 May 2020 03:48:20 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EDDA8548B739D91516FA;
        Wed,  6 May 2020 15:48:17 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Wed, 6 May 2020 15:48:10 +0800
From:   Samuel Zou <zou_wei@huawei.com>
To:     <njavali@marvell.com>, <GR-QLogic-Storage-Upstream@marvell.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Samuel Zou <zou_wei@huawei.com>
Subject: [PATCH -next] scsi: qla2xxx: Use PTR_ERR_OR_ZERO() to simplify code
Date:   Wed, 6 May 2020 15:54:10 +0800
Message-ID: <1588751650-37186-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fixes coccicheck warning:

drivers/scsi/qla2xxx/tcm_qla2xxx.c:1488:1-3: WARNING: PTR_ERR_OR_ZERO can be used

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Samuel Zou <zou_wei@huawei.com>
---
 drivers/scsi/qla2xxx/tcm_qla2xxx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/scsi/qla2xxx/tcm_qla2xxx.c b/drivers/scsi/qla2xxx/tcm_qla2xxx.c
index 1f0a185..7c4157e 100644
--- a/drivers/scsi/qla2xxx/tcm_qla2xxx.c
+++ b/drivers/scsi/qla2xxx/tcm_qla2xxx.c
@@ -1485,10 +1485,8 @@ static int tcm_qla2xxx_check_initiator_node_acl(
 				       sizeof(struct qla_tgt_cmd),
 				       TARGET_PROT_ALL, port_name,
 				       qlat_sess, tcm_qla2xxx_session_cb);
-	if (IS_ERR(se_sess))
-		return PTR_ERR(se_sess);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(se_sess);
 }
 
 static void tcm_qla2xxx_update_sess(struct fc_port *sess, port_id_t s_id,
-- 
2.6.2

