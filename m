Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D84DD2B56E1
	for <lists+linux-scsi@lfdr.de>; Tue, 17 Nov 2020 03:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbgKQCjE (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 16 Nov 2020 21:39:04 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:7926 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbgKQCjE (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 16 Nov 2020 21:39:04 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CZqrS2JRyz6xF9;
        Tue, 17 Nov 2020 10:38:48 +0800 (CST)
Received: from euler.huawei.com (10.175.124.27) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Tue, 17 Nov 2020 10:38:51 +0800
From:   Wei Li <liwei391@huawei.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ondrej Zary <linux@zary.sk>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <guohanjun@huawei.com>
Subject: [PATCH] scsi: fdomain: Fix error return code in fdomain_probe()
Date:   Tue, 17 Nov 2020 10:38:44 +0800
Message-ID: <20201117023845.26736-1-liwei391@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

When it fail to request_region, it just jump to 'fail_disable',
while the 'ret' is not updated. So assign the return code before
that.

Fixes: 8674a8aa2c39 ("scsi: fdomain: Add PCMCIA support")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Li <liwei391@huawei.com>
---
 drivers/scsi/pcmcia/fdomain_cs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/pcmcia/fdomain_cs.c b/drivers/scsi/pcmcia/fdomain_cs.c
index e42acf314d06..6bde57ed6c50 100644
--- a/drivers/scsi/pcmcia/fdomain_cs.c
+++ b/drivers/scsi/pcmcia/fdomain_cs.c
@@ -45,8 +45,10 @@ static int fdomain_probe(struct pcmcia_device *link)
 		goto fail_disable;
 
 	if (!request_region(link->resource[0]->start, FDOMAIN_REGION_SIZE,
-			    "fdomain_cs"))
+			    "fdomain_cs")) {
+		ret = -ENOMEM;
 		goto fail_disable;
+	}
 
 	sh = fdomain_create(link->resource[0]->start, link->irq, 7, &link->dev);
 	if (!sh) {
-- 
2.17.1

