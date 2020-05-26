Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E9D1BDBD1
	for <lists+linux-scsi@lfdr.de>; Wed, 29 Apr 2020 14:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgD2MR0 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 Apr 2020 08:17:26 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39160 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726524AbgD2MR0 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 29 Apr 2020 08:17:26 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2E69B2FDDB8262AA5332;
        Wed, 29 Apr 2020 20:16:17 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Wed, 29 Apr 2020 20:16:11 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <aacraid@microsemi.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <wangxiongfeng2@huawei.com>
Subject: [PATCH] scsi: dpt_i2o: Remove always false 'chan < 0' statement
Date:   Wed, 29 Apr 2020 20:10:18 +0800
Message-ID: <1588162218-61757-1-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The channel index is represented by an unsigned variable 'u32 chan'. We
don't need to check whether it is less than zero. The following
statement is always false and let's remove it.
	'chan < 0'

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/scsi/dpt_i2o.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/dpt_i2o.c b/drivers/scsi/dpt_i2o.c
index 02dff3a..2cf8895 100644
--- a/drivers/scsi/dpt_i2o.c
+++ b/drivers/scsi/dpt_i2o.c
@@ -1120,7 +1120,7 @@ static struct adpt_device* adpt_find_device(adpt_hba* pHba, u32 chan, u32 id, u6
 {
 	struct adpt_device* d;
 
-	if(chan < 0 || chan >= MAX_CHANNEL)
+	if (chan >= MAX_CHANNEL)
 		return NULL;
 	
 	d = pHba->channel[chan].device[id];
-- 
1.7.12.4

