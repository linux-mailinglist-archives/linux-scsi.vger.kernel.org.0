Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA9E225A2A
	for <lists+linux-scsi@lfdr.de>; Mon, 20 Jul 2020 10:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgGTIg3 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 20 Jul 2020 04:36:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7792 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726015AbgGTIg3 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 20 Jul 2020 04:36:29 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E8CAEEA2684CE04A3397;
        Mon, 20 Jul 2020 16:36:26 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Mon, 20 Jul 2020
 16:36:16 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     <hare@suse.de>, <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] scsi: fcoe: use eth_zero_addr() to clear mac address
Date:   Mon, 20 Jul 2020 16:39:04 +0800
Message-ID: <1595234344-13955-1-git-send-email-linmiaohe@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Miaohe Lin <linmiaohe@huawei.com>

Use eth_zero_addr() to clear mac address insetad of memset().

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 drivers/scsi/fcoe/fcoe_ctlr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/fcoe/fcoe_ctlr.c b/drivers/scsi/fcoe/fcoe_ctlr.c
index 1791a393795d..ef92cfacadc1 100644
--- a/drivers/scsi/fcoe/fcoe_ctlr.c
+++ b/drivers/scsi/fcoe/fcoe_ctlr.c
@@ -336,7 +336,7 @@ static void fcoe_ctlr_announce(struct fcoe_ctlr *fip)
 		printk(KERN_NOTICE "libfcoe: host%d: "
 		       "FIP Fibre-Channel Forwarder MAC %pM deselected\n",
 		       fip->lp->host->host_no, fip->dest_addr);
-		memset(fip->dest_addr, 0, ETH_ALEN);
+		eth_zero_addr(fip->dest_addr);
 	}
 	if (sel) {
 		printk(KERN_INFO "libfcoe: host%d: FIP selected "
-- 
2.19.1

