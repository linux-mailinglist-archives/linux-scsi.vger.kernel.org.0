Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E04E224F18D
	for <lists+linux-scsi@lfdr.de>; Mon, 24 Aug 2020 05:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgHXDfA (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 23 Aug 2020 23:35:00 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34550 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726684AbgHXDfA (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 23 Aug 2020 23:35:00 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 013C253A7E5AA5D25A18;
        Mon, 24 Aug 2020 11:34:58 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Mon, 24 Aug 2020
 11:34:51 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <QLogic-Storage-Upstream@cavium.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>
CC:     Ye Bin <yebin10@huawei.com>
Subject: [PATCH] scsi: qedf: Fix null ptr reference in qedf_stag_change_work
Date:   Mon, 24 Aug 2020 11:34:36 +0800
Message-ID: <20200824033436.45570-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 drivers/scsi/qedf/qedf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qedf/qedf_main.c b/drivers/scsi/qedf/qedf_main.c
index 39c4bdc89937..c855ff3ad232 100644
--- a/drivers/scsi/qedf/qedf_main.c
+++ b/drivers/scsi/qedf/qedf_main.c
@@ -3874,7 +3874,7 @@ void qedf_stag_change_work(struct work_struct *work)
 	    container_of(work, struct qedf_ctx, stag_work.work);
 
 	if (!qedf) {
-		QEDF_ERR(&qedf->dbg_ctx, "qedf is NULL");
+		QEDF_ERR(NULL, "qedf is NULL");
 		return;
 	}
 	QEDF_ERR(&qedf->dbg_ctx, "Performing software context reset.\n");
-- 
2.25.4

