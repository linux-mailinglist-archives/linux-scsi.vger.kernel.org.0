Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 360DB271CD9
	for <lists+linux-scsi@lfdr.de>; Mon, 21 Sep 2020 10:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgIUICk (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 21 Sep 2020 04:02:40 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13743 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726416AbgIUICh (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 21 Sep 2020 04:02:37 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EB4466583FD1CCC8DB78;
        Mon, 21 Sep 2020 16:02:35 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Mon, 21 Sep 2020
 16:02:29 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next] scsi: libsas: simplify the return expression of sas_discover_end_dev
Date:   Mon, 21 Sep 2020 16:24:53 +0800
Message-ID: <20200921082453.2592137-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Simplify the return expression.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/scsi/libsas/sas_discover.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/scsi/libsas/sas_discover.c b/drivers/scsi/libsas/sas_discover.c
index d0f9e90e3279..161c9b387da7 100644
--- a/drivers/scsi/libsas/sas_discover.c
+++ b/drivers/scsi/libsas/sas_discover.c
@@ -278,13 +278,7 @@ static void sas_resume_devices(struct work_struct *work)
  */
 int sas_discover_end_dev(struct domain_device *dev)
 {
-	int res;
-
-	res = sas_notify_lldd_dev_found(dev);
-	if (res)
-		return res;
-
-	return 0;
+	return sas_notify_lldd_dev_found(dev);
 }
 
 /* ---------- Device registration and unregistration ---------- */
-- 
2.25.1

