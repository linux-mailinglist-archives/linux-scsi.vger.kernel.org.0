Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 369FE2E712F
	for <lists+linux-scsi@lfdr.de>; Tue, 29 Dec 2020 14:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgL2NyG (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 29 Dec 2020 08:54:06 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10094 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbgL2NyF (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 29 Dec 2020 08:54:05 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4D4wp62smJzM9yc;
        Tue, 29 Dec 2020 21:52:14 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Tue, 29 Dec 2020 21:53:07 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <james.smart@broadcom.com>, <dick.kennedy@broadcom.com>,
        Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] scsi: lpfc: Use kzalloc for allocating only one thing
Date:   Tue, 29 Dec 2020 21:53:46 +0800
Message-ID: <20201229135346.24257-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Use kzalloc rather than kcalloc(1,...)

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
@@

- kcalloc(1,
+ kzalloc(
          ...)
// </smpl>

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/scsi/lpfc/lpfc_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
index c9a327b13e5c..f550a52dab4f 100644
--- a/drivers/scsi/lpfc/lpfc_debugfs.c
+++ b/drivers/scsi/lpfc/lpfc_debugfs.c
@@ -3033,7 +3033,7 @@ lpfc_debugfs_hdwqstat_open(struct inode *inode, struct file *file)
 		goto out;
 
 	 /* Round to page boundary */
-	debug->buffer = kcalloc(1, LPFC_SCSISTAT_SIZE, GFP_KERNEL);
+	debug->buffer = kzalloc(LPFC_SCSISTAT_SIZE, GFP_KERNEL);
 	if (!debug->buffer) {
 		kfree(debug);
 		goto out;
-- 
2.22.0

