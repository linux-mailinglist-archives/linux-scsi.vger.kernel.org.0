Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2491AEA36
	for <lists+linux-scsi@lfdr.de>; Sat, 18 Apr 2020 08:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgDRGjt (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 18 Apr 2020 02:39:49 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46642 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725856AbgDRGjt (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 18 Apr 2020 02:39:49 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 50F7E2C517DEDF7A82E2;
        Sat, 18 Apr 2020 14:39:48 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Sat, 18 Apr 2020
 14:39:39 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <Kai.Makisara@kolumbus.fi>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <arnd@arndb.de>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] scsi: st: remove unneeded variable 'result' in st_release()
Date:   Sat, 18 Apr 2020 15:06:05 +0800
Message-ID: <20200418070605.11450-1-yanaijie@huawei.com>
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

Also remove a strange '^L' after this function.

Fix the following coccicheck warning:

drivers/scsi/st.c:1460:5-11: Unneeded variable: "result". Return "0" on
line 1473

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/scsi/st.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index c5f9b348b438..4bf4ab3b70f4 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -1457,7 +1457,6 @@ static int st_flush(struct file *filp, fl_owner_t id)
    accessing this tape. */
 static int st_release(struct inode *inode, struct file *filp)
 {
-	int result = 0;
 	struct scsi_tape *STp = filp->private_data;
 
 	if (STp->door_locked == ST_LOCKED_AUTO)
@@ -1470,9 +1469,9 @@ static int st_release(struct inode *inode, struct file *filp)
 	scsi_autopm_put_device(STp->device);
 	scsi_tape_put(STp);
 
-	return result;
+	return 0;
 }
-
+
 /* The checks common to both reading and writing */
 static ssize_t rw_checks(struct scsi_tape *STp, struct file *filp, size_t count)
 {
-- 
2.21.1

