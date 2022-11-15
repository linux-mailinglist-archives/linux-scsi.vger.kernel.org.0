Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0C2628F8F
	for <lists+linux-scsi@lfdr.de>; Tue, 15 Nov 2022 02:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbiKOBwP (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 14 Nov 2022 20:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbiKOBwO (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 14 Nov 2022 20:52:14 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996D112622;
        Mon, 14 Nov 2022 17:52:13 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NB8GK46yfzqSMv;
        Tue, 15 Nov 2022 09:48:25 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 09:52:12 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 15 Nov
 2022 09:52:11 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <target-devel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
CC:     <martin.petersen@oracle.com>, <hch@lst.de>,
        <michael.christie@oracle.com>, <yangyingliang@huawei.com>
Subject: [PATCH v2] scsi: target: tcm_loop: fix possible name leak in tcm_loop_setup_hba_bus()
Date:   Tue, 15 Nov 2022 09:50:42 +0800
Message-ID: <20221115015042.3652261-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

If device_register() fails in tcm_loop_setup_hba_bus(), the name allocated
by dev_set_name() need be freed. As comment of device_register() says, it
should use put_device() to give up the reference in the error path. So fix
this by calling put_device(), then the name can be freed in kobject_cleanup().
The 'tl_hba' will be freed in tcm_loop_release_adapter(), so it don't need
goto error label in this case.

Fixes: 3703b2c5d041 ("[SCSI] tcm_loop: Add multi-fabric Linux/SCSI LLD fabric module")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
v1 -> v2:
  Move put_device() in tcm_loop_setup_hba_bus().
---
 drivers/target/loopback/tcm_loop.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/target/loopback/tcm_loop.c b/drivers/target/loopback/tcm_loop.c
index 4407b56aa6d1..139031ccb700 100644
--- a/drivers/target/loopback/tcm_loop.c
+++ b/drivers/target/loopback/tcm_loop.c
@@ -397,6 +397,7 @@ static int tcm_loop_setup_hba_bus(struct tcm_loop_hba *tl_hba, int tcm_loop_host
 	ret = device_register(&tl_hba->dev);
 	if (ret) {
 		pr_err("device_register() failed for tl_hba->dev: %d\n", ret);
+		put_device(&tl_hba->dev);
 		return -ENODEV;
 	}
 
@@ -1073,7 +1074,7 @@ static struct se_wwn *tcm_loop_make_scsi_hba(
 	 */
 	ret = tcm_loop_setup_hba_bus(tl_hba, tcm_loop_hba_no_cnt);
 	if (ret)
-		goto out;
+		return ERR_PTR(ret);
 
 	sh = tl_hba->sh;
 	tcm_loop_hba_no_cnt++;
-- 
2.25.1

