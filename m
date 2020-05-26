Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1D81B1CFD
	for <lists+linux-scsi@lfdr.de>; Tue, 21 Apr 2020 05:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgDUDkr (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 20 Apr 2020 23:40:47 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2812 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726958AbgDUDkr (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 20 Apr 2020 23:40:47 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4179391B6F4ABA58CE27;
        Tue, 21 Apr 2020 11:40:45 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Tue, 21 Apr 2020
 11:40:39 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <hare@suse.de>, <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <zhengbin13@huawei.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] scsi: fcoe: remove unneeded semicolon in fcoe.c
Date:   Tue, 21 Apr 2020 11:40:08 +0800
Message-ID: <20200421034008.27865-1-yanaijie@huawei.com>
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

drivers/scsi/fcoe/fcoe.c:1918:3-4: Unneeded semicolon
drivers/scsi/fcoe/fcoe.c:1930:3-4: Unneeded semicolon

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/scsi/fcoe/fcoe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/fcoe/fcoe.c b/drivers/scsi/fcoe/fcoe.c
index 25dae9f0b205..cb41d166e0c0 100644
--- a/drivers/scsi/fcoe/fcoe.c
+++ b/drivers/scsi/fcoe/fcoe.c
@@ -1915,7 +1915,7 @@ static int fcoe_device_notification(struct notifier_block *notifier,
 		case FCOE_CTLR_ENABLED:
 		case FCOE_CTLR_UNUSED:
 			fcoe_ctlr_link_up(ctlr);
-		};
+		}
 	} else if (fcoe_ctlr_link_down(ctlr)) {
 		switch (cdev->enabled) {
 		case FCOE_CTLR_DISABLED:
@@ -1927,7 +1927,7 @@ static int fcoe_device_notification(struct notifier_block *notifier,
 			stats->LinkFailureCount++;
 			put_cpu();
 			fcoe_clean_pending_queue(lport);
-		};
+		}
 	}
 out:
 	return rc;
-- 
2.21.1

