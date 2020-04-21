Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 742001B1CFF
	for <lists+linux-scsi@lfdr.de>; Tue, 21 Apr 2020 05:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgDUDlB (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 20 Apr 2020 23:41:01 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56592 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726958AbgDUDlB (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 20 Apr 2020 23:41:01 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3BDBC3DA52F0CFB0E359;
        Tue, 21 Apr 2020 11:40:57 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Tue, 21 Apr 2020
 11:40:49 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <QLogic-Storage-Upstream@qlogic.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <skashyap@marvell.com>,
        <jhasan@marvell.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] scsi: bnx2fc: remove unneeded semicolon in bnx2fc_fcoe.c
Date:   Tue, 21 Apr 2020 11:40:19 +0800
Message-ID: <20200421034019.27949-1-yanaijie@huawei.com>
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

drivers/scsi/bnx2fc/bnx2fc_fcoe.c:948:4-5: Unneeded semicolon
drivers/scsi/bnx2fc/bnx2fc_fcoe.c:968:4-5: Unneeded semicolon

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
index 1cbb431fa682..0e33324e16f5 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
@@ -945,7 +945,7 @@ static void bnx2fc_indicate_netevent(void *context, unsigned long event,
 				 */
 				if (interface->enabled)
 					fcoe_ctlr_link_up(ctlr);
-			};
+			}
 		} else if (fcoe_ctlr_link_down(ctlr)) {
 			switch (cdev->enabled) {
 			case FCOE_CTLR_DISABLED:
@@ -965,7 +965,7 @@ static void bnx2fc_indicate_netevent(void *context, unsigned long event,
 				put_cpu();
 				fcoe_clean_pending_queue(lport);
 				wait_for_upload = 1;
-			};
+			}
 		}
 	}
 	mutex_unlock(&bnx2fc_dev_lock);
-- 
2.21.1

