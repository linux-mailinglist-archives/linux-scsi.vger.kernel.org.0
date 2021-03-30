Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05AD234E811
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Mar 2021 14:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbhC3M5L (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 30 Mar 2021 08:57:11 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:15399 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbhC3M46 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 30 Mar 2021 08:56:58 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F8qD23wGwznTpm;
        Tue, 30 Mar 2021 20:54:58 +0800 (CST)
Received: from huawei.com (10.175.103.91) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Tue, 30 Mar 2021
 20:56:29 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
CC:     <martin.petersen@oracle.com>
Subject: [PATCH -next] scsi: fnic: remove unnecessary spin_lock_init() and INIT_LIST_HEAD()
Date:   Tue, 30 Mar 2021 20:59:11 +0800
Message-ID: <20210330125911.1050879-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The spinlock and list head of fnic_list is initialized statically.
It is unnecessary to initialize by spin_lock_init() and INIT_LIST_HEAD().

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/scsi/fnic/fnic_main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/scsi/fnic/fnic_main.c b/drivers/scsi/fnic/fnic_main.c
index 186c3ab4456b..786f9d2704b6 100644
--- a/drivers/scsi/fnic/fnic_main.c
+++ b/drivers/scsi/fnic/fnic_main.c
@@ -1100,9 +1100,6 @@ static int __init fnic_init_module(void)
 		goto err_create_fnic_workq;
 	}
 
-	spin_lock_init(&fnic_list_lock);
-	INIT_LIST_HEAD(&fnic_list);
-
 	fnic_fip_queue = create_singlethread_workqueue("fnic_fip_q");
 	if (!fnic_fip_queue) {
 		printk(KERN_ERR PFX "fnic FIP work queue create failed\n");
-- 
2.25.1

