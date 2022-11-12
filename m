Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A4862698B
	for <lists+linux-scsi@lfdr.de>; Sat, 12 Nov 2022 14:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbiKLNLk (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 12 Nov 2022 08:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiKLNLj (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 12 Nov 2022 08:11:39 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C38D62
        for <linux-scsi@vger.kernel.org>; Sat, 12 Nov 2022 05:11:37 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N8bYd6dClzmVnT;
        Sat, 12 Nov 2022 21:11:17 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 12 Nov 2022 21:11:35 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 12 Nov
 2022 21:11:34 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-scsi@vger.kernel.org>
CC:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <yangyingliang@huawei.com>
Subject: [PATCH] scsi: scsi_debug: fix possible name leak in sdebug_add_host_helper()
Date:   Sat, 12 Nov 2022 21:10:10 +0800
Message-ID: <20221112131010.3757845-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Afer commit 1fa5ae857bb1 ("driver core: get rid of struct device's
bus_id string array"), the name of device is allocated dynamically,
it needs be freed, when device_register() returns error.

As comment of device_register() says, it should use put_device()
to give up the reference in the error path. So fix this by calling
put_device(), then the name can be freed in kobject_cleanup(), and
sdbg_host is freed in sdebug_release_adapter().

When the device release is not set, it means the device is not
initialized, we can not call put_device(), in this case, use
kfree() to free memory.

Fixes: 1fa5ae857bb1 ("driver core: get rid of struct device's bus_id string array")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/scsi/scsi_debug.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 697fc57bc711..104888bed801 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -7329,7 +7329,10 @@ static int sdebug_add_host_helper(int per_host_idx)
 		kfree(sdbg_devinfo->zstate);
 		kfree(sdbg_devinfo);
 	}
-	kfree(sdbg_host);
+	if (sdbg_host->dev.release)
+		put_device(&sdbg_host->dev);
+	else
+		kfree(sdbg_host);
 	pr_warn("%s: failed, errno=%d\n", __func__, -error);
 	return error;
 }
-- 
2.25.1

