Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F0826F8F3
	for <lists+linux-scsi@lfdr.de>; Fri, 18 Sep 2020 11:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgIRJHw (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 18 Sep 2020 05:07:52 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50942 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725874AbgIRJHw (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 18 Sep 2020 05:07:52 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 55A4A1514625D3BF7801;
        Fri, 18 Sep 2020 17:07:50 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Fri, 18 Sep 2020 17:07:39 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <fthain@telegraphics.com.au>, <schmitzmic@gmail.com>,
        <linux@armlinux.org.uk>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <jingxiangfeng@huawei.com>
Subject: [PATCH] scsi: remove redundant initialization of variable ret
Date:   Fri, 18 Sep 2020 17:07:47 +0800
Message-ID: <20200918090747.44645-1-jingxiangfeng@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The variable ret is being initialized with '-ENOMEM' that is
meaningless. So remove it.

Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 drivers/scsi/arm/oak.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/arm/oak.c b/drivers/scsi/arm/oak.c
index 7c9d361e91a9..78f33d57c3e8 100644
--- a/drivers/scsi/arm/oak.c
+++ b/drivers/scsi/arm/oak.c
@@ -120,7 +120,7 @@ static struct scsi_host_template oakscsi_template = {
 static int oakscsi_probe(struct expansion_card *ec, const struct ecard_id *id)
 {
 	struct Scsi_Host *host;
-	int ret = -ENOMEM;
+	int ret;
 
 	ret = ecard_request_resources(ec);
 	if (ret)
-- 
2.17.1

