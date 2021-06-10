Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0BE23A25CE
	for <lists+linux-scsi@lfdr.de>; Thu, 10 Jun 2021 09:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhFJHwF (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 10 Jun 2021 03:52:05 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:5366 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbhFJHwE (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 10 Jun 2021 03:52:04 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4G0wyT270gz6w7B;
        Thu, 10 Jun 2021 15:46:09 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 10 Jun 2021 15:50:01 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 10 Jun 2021 15:50:01 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi <linux-scsi@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] scsi: libcxgbi: remove unnecessary oom message
Date:   Thu, 10 Jun 2021 15:49:52 +0800
Message-ID: <20210610074952.15765-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fixes scripts/checkpatch.pl warning:
WARNING: Possible unnecessary 'out of memory' message

Remove it can help us save a bit of memory.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/scsi/cxgbi/libcxgbi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/cxgbi/libcxgbi.c b/drivers/scsi/cxgbi/libcxgbi.c
index 8c7d4dda4cf2994..df370fb5dd86f96 100644
--- a/drivers/scsi/cxgbi/libcxgbi.c
+++ b/drivers/scsi/cxgbi/libcxgbi.c
@@ -556,12 +556,11 @@ EXPORT_SYMBOL_GPL(cxgbi_sock_free_cpl_skbs);
 
 static struct cxgbi_sock *cxgbi_sock_create(struct cxgbi_device *cdev)
 {
-	struct cxgbi_sock *csk = kzalloc(sizeof(*csk), GFP_NOIO);
+	struct cxgbi_sock *csk;
 
-	if (!csk) {
-		pr_info("alloc csk %zu failed.\n", sizeof(*csk));
+	csk = kzalloc(sizeof(*csk), GFP_NOIO);
+	if (!csk)
 		return NULL;
-	}
 
 	if (cdev->csk_alloc_cpls(csk) < 0) {
 		pr_info("csk 0x%p, alloc cpls failed.\n", csk);
-- 
2.26.0.106.g9fadedd


