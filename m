Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6109C26BCB2
	for <lists+linux-scsi@lfdr.de>; Wed, 16 Sep 2020 08:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgIPGVi (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 16 Sep 2020 02:21:38 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12302 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726444AbgIPGVg (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 16 Sep 2020 02:21:36 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BFC7E4511B1F92ED42A9;
        Wed, 16 Sep 2020 14:21:04 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Wed, 16 Sep 2020 14:20:54 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Satish Kharat <satishkh@cisco.com>,
        Sesidhar Baddela <sebaddel@cisco.com>,
        Karan Tilak Kumar <kartilak@cisco.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Qinglang Miao" <miaoqinglang@huawei.com>
Subject: [PATCH -next] scsi: fnic: remove unnecessary spin_lock_init()
Date:   Wed, 16 Sep 2020 14:21:35 +0800
Message-ID: <20200916062135.191095-1-miaoqinglang@huawei.com>
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

The spinlock fnic_list_lock is initialized statically. It is
unnecessary to initialize by spin_lock_init().

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/scsi/fnic/fnic_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/fnic/fnic_main.c b/drivers/scsi/fnic/fnic_main.c
index 825834885..d077e8e83 100644
--- a/drivers/scsi/fnic/fnic_main.c
+++ b/drivers/scsi/fnic/fnic_main.c
@@ -1097,7 +1097,6 @@ static int __init fnic_init_module(void)
 		goto err_create_fnic_workq;
 	}
 
-	spin_lock_init(&fnic_list_lock);
 	INIT_LIST_HEAD(&fnic_list);
 
 	fnic_fip_queue = create_singlethread_workqueue("fnic_fip_q");
-- 
2.23.0

