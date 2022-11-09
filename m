Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70C8622537
	for <lists+linux-scsi@lfdr.de>; Wed,  9 Nov 2022 09:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiKIIU5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 9 Nov 2022 03:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiKIIU4 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 9 Nov 2022 03:20:56 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA6719C36
        for <linux-scsi@vger.kernel.org>; Wed,  9 Nov 2022 00:20:54 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N6dBR1HCJzJnR9;
        Wed,  9 Nov 2022 16:17:51 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 16:20:51 +0800
From:   Zhou Guanghui <zhouguanghui1@huawei.com>
To:     <lduncan@suse.com>, <cleech@redhat.com>,
        <michael.christie@oracle.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <open-iscsi@googlegroups.com>, <linux-scsi@vger.kernel.org>
Subject: [-next] scsi: iscsi: fix possible memory leak in iscsi_register_transport
Date:   Wed, 9 Nov 2022 08:19:17 +0000
Message-ID: <20221109081917.34311-1-zhouguanghui1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,WEIRD_QUOTING autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

"unreferenced object 0xffff888117908420 (size 16):
  comm ""modprobe"", pid 18125, jiffies 4319017437 (age 73.039s)
  hex dump (first 16 bytes):
    62 65 32 69 73 63 73 69 00 84 90 17 81 88 ff ff  be2iscsi........
  backtrace:
    [<00000000f78a13b3>] __kmem_cache_alloc_node+0x157/0x220
    [<00000000200a51a4>] __kmalloc_node_track_caller+0x44/0x1b0
    [<0000000033ea4d64>] kstrdup+0x3a/0x70
    [<00000000ec6d2980>] kstrdup_const+0x41/0x60
    [<0000000055015f6f>] kvasprintf_const+0xf5/0x180
    [<000000009dd443d2>] kobject_set_name_vargs+0x56/0x150
    [<00000000f3448e98>] dev_set_name+0xab/0xe0
    [<0000000080ab8992>] iscsi_register_transport+0x1f8/0x610 [scsi_transport_iscsi]
    [<000000005e2c324d>] 0xffffffffc1260012
    [<00000000df6e6a36>] do_one_initcall+0xcb/0x4d0
    [<00000000181109df>] do_init_module+0x1ca/0x5f0
    [<00000000b3c4fec8>] load_module+0x6133/0x70f0
    [<00000000feb08394>] __do_sys_finit_module+0x12f/0x1c0
    [<00000000ca6af44d>] do_syscall_64+0x37/0x90
    [<00000000132e1a8b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd"

If device_register() returns error in iscsi_register_transport(),
the name allocated by the dev_set_name() need be freed.

Fix this by calling put_device(), the name will be freed in the
kobject_cleanup(), and the priv will be freed in
iscsi_transport_release.

Signed-off-by: Zhou Guanghui <zhouguanghui1@huawei.com>
---
 drivers/scsi/scsi_transport_iscsi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index cd3db9684e52..51e2c0f5e2d0 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -4815,7 +4815,7 @@ iscsi_register_transport(struct iscsi_transport *tt)
 	dev_set_name(&priv->dev, "%s", tt->name);
 	err = device_register(&priv->dev);
 	if (err)
-		goto free_priv;
+		goto put_dev;
 
 	err = sysfs_create_group(&priv->dev.kobj, &iscsi_transport_group);
 	if (err)
@@ -4850,8 +4850,8 @@ iscsi_register_transport(struct iscsi_transport *tt)
 unregister_dev:
 	device_unregister(&priv->dev);
 	return NULL;
-free_priv:
-	kfree(priv);
+put_dev:
+	put_device(&priv->dev);
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(iscsi_register_transport);
-- 
2.17.1

