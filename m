Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3455D216A05
	for <lists+linux-scsi@lfdr.de>; Tue,  7 Jul 2020 12:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgGGKVA (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 7 Jul 2020 06:21:00 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7262 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727936AbgGGKUn (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 7 Jul 2020 06:20:43 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7BD35A78D68840B548BE;
        Tue,  7 Jul 2020 18:20:34 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Tue, 7 Jul 2020 18:20:24 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <hare@suse.de>, <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <robert.w.love@intel.com>, <Neerav.Parikh@intel.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jingxiangfeng@huawei.com>
Subject: [PATCH] scsi: fcoe: add missed kfree() in an error path
Date:   Tue, 7 Jul 2020 18:24:31 +0800
Message-ID: <20200707102431.178675-1-jingxiangfeng@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

fcoe_fdmi_info() misses to call kfree() in an error path.
Add the missed function call to fix it.

Fixes: f07d46bbc9ba ("fcoe: Fix smatch warning in fcoe_fdmi_info function")
Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 drivers/scsi/fcoe/fcoe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/fcoe/fcoe.c b/drivers/scsi/fcoe/fcoe.c
index 25dae9f0b205..976f70cbe043 100644
--- a/drivers/scsi/fcoe/fcoe.c
+++ b/drivers/scsi/fcoe/fcoe.c
@@ -830,6 +830,7 @@ static void fcoe_fdmi_info(struct fc_lport *lport, struct net_device *netdev)
 		if (rc) {
 			printk(KERN_INFO "fcoe: Failed to retrieve FDMI "
 					"information from netdev.\n");
+			kfree(fdmi);
 			return;
 		}
 
-- 
2.17.1

