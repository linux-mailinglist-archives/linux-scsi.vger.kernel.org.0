Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC67A25458D
	for <lists+linux-scsi@lfdr.de>; Thu, 27 Aug 2020 14:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgH0M7Q (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 27 Aug 2020 08:59:16 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41234 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726009AbgH0M7O (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 27 Aug 2020 08:59:14 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 29AD3CB95655F8104BF9;
        Thu, 27 Aug 2020 20:58:47 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Thu, 27 Aug 2020
 20:58:37 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <aacraid@microsemi.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <hare@suse.de>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] scsi: dpt_i2o: remove set but not used 'pHba'
Date:   Thu, 27 Aug 2020 20:58:12 +0800
Message-ID: <20200827125812.427753-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This addresses the following gcc warning with "make W=1":

drivers/scsi/dpt_i2o.c: In function ‘adpt_slave_configure’:
drivers/scsi/dpt_i2o.c:411:12: warning: variable ‘pHba’ set but not used
[-Wunused-but-set-variable]
  411 |  adpt_hba* pHba;
      |            ^~~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/scsi/dpt_i2o.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/scsi/dpt_i2o.c b/drivers/scsi/dpt_i2o.c
index f654ad8a3d69..4251212acbbe 100644
--- a/drivers/scsi/dpt_i2o.c
+++ b/drivers/scsi/dpt_i2o.c
@@ -408,9 +408,6 @@ static void adpt_inquiry(adpt_hba* pHba)
 static int adpt_slave_configure(struct scsi_device * device)
 {
 	struct Scsi_Host *host = device->host;
-	adpt_hba* pHba;
-
-	pHba = (adpt_hba *) host->hostdata[0];
 
 	if (host->can_queue && device->tagged_supported) {
 		scsi_change_queue_depth(device,
-- 
2.25.4

