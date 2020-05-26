Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF021BF7FF
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Apr 2020 14:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgD3MRw (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 30 Apr 2020 08:17:52 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49804 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725280AbgD3MRw (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 30 Apr 2020 08:17:52 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2EB592BA704D9C0DA4C8;
        Thu, 30 Apr 2020 20:17:49 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Thu, 30 Apr 2020
 20:17:41 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <QLogic-Storage-Upstream@cavium.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <mrangankar@marvell.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] scsi: qedi: remove Comparison of 0/1 to bool variable
Date:   Thu, 30 Apr 2020 20:17:06 +0800
Message-ID: <20200430121706.14879-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fix the following coccicheck warning:

drivers/scsi/qedi/qedi_main.c:1309:5-25: WARNING: Comparison of 0/1 to
bool variable
drivers/scsi/qedi/qedi_main.c:1315:5-25: WARNING: Comparison of 0/1 to
bool variable

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/scsi/qedi/qedi_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.c
index 4dd965860c98..46584e16d635 100644
--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -1306,13 +1306,13 @@ static irqreturn_t qedi_msix_handler(int irq, void *dev_id)
 			  "process already running\n");
 	}
 
-	if (qedi_fp_has_work(fp) == 0)
+	if (!qedi_fp_has_work(fp))
 		qed_sb_update_sb_idx(fp->sb_info);
 
 	/* Check for more work */
 	rmb();
 
-	if (qedi_fp_has_work(fp) == 0)
+	if (!qedi_fp_has_work(fp))
 		qed_sb_ack(fp->sb_info, IGU_INT_ENABLE, 1);
 	else
 		goto process_again;
-- 
2.21.1

