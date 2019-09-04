Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06D88A7938
	for <lists+linux-scsi@lfdr.de>; Wed,  4 Sep 2019 05:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbfIDDTh (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 3 Sep 2019 23:19:37 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6197 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727065AbfIDDTh (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 3 Sep 2019 23:19:37 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AD1F964A5027FFA3A10A;
        Wed,  4 Sep 2019 11:19:34 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Wed, 4 Sep 2019 11:19:25 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <martin.petersen@oracle.com>, <jejb@linux.ibm.com>
CC:     <linux-scsi@vger.kernel.org>, <zhongjiang@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] scsi: qedi: remove an redundant null check before kfree_skb
Date:   Wed, 4 Sep 2019 11:16:32 +0800
Message-ID: <1567566992-8147-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

kfree_skb has taken null pointer into account. Hence it is unnecessary
to check it before kfree_skb. Just remove the condition.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/scsi/qedi/qedi_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.c
index acb930b..dabf425 100644
--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -789,8 +789,7 @@ static void qedi_ll2_free_skbs(struct qedi_ctx *qedi)
 	spin_lock_bh(&qedi->ll2_lock);
 	list_for_each_entry_safe(work, work_tmp, &qedi->ll2_skb_list, list) {
 		list_del(&work->list);
-		if (work->skb)
-			kfree_skb(work->skb);
+		kfree_skb(work->skb);
 		kfree(work);
 	}
 	spin_unlock_bh(&qedi->ll2_lock);
-- 
1.7.12.4

