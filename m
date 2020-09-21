Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4855B2724D6
	for <lists+linux-scsi@lfdr.de>; Mon, 21 Sep 2020 15:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbgIUNLp (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 21 Sep 2020 09:11:45 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14201 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727386AbgIUNKs (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 21 Sep 2020 09:10:48 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 50707B989B32189575AF;
        Mon, 21 Sep 2020 21:10:44 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Mon, 21 Sep 2020 21:10:38 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Hannes Reinecke <hare@suse.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Qinglang Miao" <miaoqinglang@huawei.com>
Subject: [PATCH -next] scsi: fcoe: simplify the return expression of fcoe_sysfs_setup
Date:   Mon, 21 Sep 2020 21:11:02 +0800
Message-ID: <20200921131102.93084-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Simplify the return expression.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/scsi/fcoe/fcoe_sysfs.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/scsi/fcoe/fcoe_sysfs.c b/drivers/scsi/fcoe/fcoe_sysfs.c
index 2cb7a8c93..ffef2c8ed 100644
--- a/drivers/scsi/fcoe/fcoe_sysfs.c
+++ b/drivers/scsi/fcoe/fcoe_sysfs.c
@@ -1053,16 +1053,10 @@ EXPORT_SYMBOL_GPL(fcoe_fcf_device_add);
 
 int __init fcoe_sysfs_setup(void)
 {
-	int error;
-
 	atomic_set(&ctlr_num, 0);
 	atomic_set(&fcf_num, 0);
 
-	error = bus_register(&fcoe_bus_type);
-	if (error)
-		return error;
-
-	return 0;
+	return bus_register(&fcoe_bus_type);
 }
 
 void __exit fcoe_sysfs_teardown(void)
-- 
2.23.0

