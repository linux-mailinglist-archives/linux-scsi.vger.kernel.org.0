Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D01E328808D
	for <lists+linux-scsi@lfdr.de>; Fri,  9 Oct 2020 04:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731012AbgJICyn (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 8 Oct 2020 22:54:43 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14805 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729308AbgJICyn (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 8 Oct 2020 22:54:43 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 19A08A205533E1D9086A;
        Fri,  9 Oct 2020 10:54:40 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Fri, 9 Oct 2020
 10:54:29 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <njavali@marvell.com>, <GR-QLogic-Storage-Upstream@marvell.com>,
        <linux-scsi@vger.kernel.org>, <martin.petersen@oracle.com>
CC:     Ye Bin <yebin10@huawei.com>
Subject: [PATCH] scsi: qla2xxx: Fix uninitialized variable reference in qla_nvme_post_cmd
Date:   Fri, 9 Oct 2020 11:05:16 +0800
Message-ID: <20201009030516.123801-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.16.2.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fix follow warning:
[drivers/scsi/qla2xxx/qla_nvme.c:564]: (error) Uninitialized variable: rval

Fixes: b994718760fa ("scsi: qla2xxx: Use constant when it is known")
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 drivers/scsi/qla2xxx/qla_nvme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index ae47e0eb0311..1f9005125313 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -561,7 +561,7 @@ static int qla_nvme_post_cmd(struct nvme_fc_local_port *lport,
 	vha = fcport->vha;
 
 	if (!(fcport->nvme_flag & NVME_FLAG_REGISTERED))
-		return rval;
+		return -ENODEV;
 
 	if (test_bit(ABORT_ISP_ACTIVE, &vha->dpc_flags) ||
 	    (qpair && !qpair->fw_started) || fcport->deleted)
-- 
2.16.2.dirty

