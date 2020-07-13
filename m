Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61F7B219F8A
	for <lists+linux-scsi@lfdr.de>; Thu,  9 Jul 2020 14:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgGIMCA (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 9 Jul 2020 08:02:00 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50162 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726327AbgGIMB7 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 9 Jul 2020 08:01:59 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0552E267F62BF821754F;
        Thu,  9 Jul 2020 20:01:58 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Thu, 9 Jul 2020 20:01:48 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <hare@suse.de>, <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <robert.w.love@intel.com>, <Neerav.Parikh@intel.com>,
        <Markus.Elfring@web.de>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jingxiangfeng@huawei.com>
Subject: [PATCH v2] scsi: fcoe: add missed kfree() in an error path
Date:   Thu, 9 Jul 2020 20:05:46 +0800
Message-ID: <20200709120546.38453-1-jingxiangfeng@huawei.com>
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
Add a label 'free_fdmi' and jump to it.

Fixes: f07d46bbc9ba ("fcoe: Fix smatch warning in fcoe_fdmi_info function")
Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 drivers/scsi/fcoe/fcoe.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/fcoe/fcoe.c b/drivers/scsi/fcoe/fcoe.c
index 25dae9f0b205..a63057a03772 100644
--- a/drivers/scsi/fcoe/fcoe.c
+++ b/drivers/scsi/fcoe/fcoe.c
@@ -830,7 +830,7 @@ static void fcoe_fdmi_info(struct fc_lport *lport, struct net_device *netdev)
 		if (rc) {
 			printk(KERN_INFO "fcoe: Failed to retrieve FDMI "
 					"information from netdev.\n");
-			return;
+			goto free_fdmi;
 		}
 
 		snprintf(fc_host_serial_number(lport->host),
@@ -868,6 +868,7 @@ static void fcoe_fdmi_info(struct fc_lport *lport, struct net_device *netdev)
 
 		/* Enable FDMI lport states */
 		lport->fdmi_enabled = 1;
+free_fdmi:
 		kfree(fdmi);
 	} else {
 		lport->fdmi_enabled = 0;
-- 
2.17.1

