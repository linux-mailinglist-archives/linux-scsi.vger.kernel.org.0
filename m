Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF9532E1D48
	for <lists+linux-scsi@lfdr.de>; Wed, 23 Dec 2020 15:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbgLWOP3 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 23 Dec 2020 09:15:29 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:9477 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728650AbgLWOP0 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 23 Dec 2020 09:15:26 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4D1FZ55M7vzhvTy;
        Wed, 23 Dec 2020 22:14:05 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Wed, 23 Dec 2020 22:14:29 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <kashyap.desai@broadcom.com>, <sumit.saxena@broadcom.com>,
        <shivasharan.srikanteshwara@broadcom.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <megaraidlinux.pdl@broadcom.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] scsi: megaraid: Use DEFINE_SPINLOCK() for spinlock
Date:   Wed, 23 Dec 2020 22:15:05 +0800
Message-ID: <20201223141505.1123-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

spinlock can be initialized automatically with DEFINE_SPINLOCK()
rather than explicitly calling spin_lock_init().

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index e158d3d62056..206089507b9f 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -199,7 +199,7 @@ static bool support_nvme_encapsulation;
 static bool support_pci_lane_margining;
 
 /* define lock for aen poll */
-static spinlock_t poll_aen_lock;
+static DEFINE_SPINLOCK(poll_aen_lock);
 
 extern struct dentry *megasas_debugfs_root;
 
@@ -8875,8 +8875,6 @@ static int __init megasas_init(void)
 	 */
 	pr_info("megasas: %s\n", MEGASAS_VERSION);
 
-	spin_lock_init(&poll_aen_lock);
-
 	support_poll_for_event = 2;
 	support_device_change = 1;
 	support_nvme_encapsulation = true;
-- 
2.22.0

