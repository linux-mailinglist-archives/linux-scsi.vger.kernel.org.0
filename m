Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFBF76DDCC
	for <lists+linux-scsi@lfdr.de>; Thu,  3 Aug 2023 04:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbjHCCDS (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 2 Aug 2023 22:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjHCCDD (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 2 Aug 2023 22:03:03 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2757F13E
        for <linux-scsi@vger.kernel.org>; Wed,  2 Aug 2023 19:03:02 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RGX8k47ySzNmk1;
        Thu,  3 Aug 2023 09:59:34 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.202) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 10:03:00 +0800
From:   Zhu Wang <wangzhu9@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <kay.sievers@vrfy.org>, <tonyj@suse.de>, <gregkh@suse.de>,
        <linux-scsi@vger.kernel.org>, <bvanassche@acm.org>
CC:     <wangzhu9@huawei.com>
Subject: [PATCH -next v3] SCSI: fix possible memory leak while device_add() fails
Date:   Thu, 3 Aug 2023 10:02:30 +0800
Message-ID: <20230803020230.226903-1-wangzhu9@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.202]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

If device_add() returns error, the name allocated by dev_set_name() need
be freed. As comment of device_add() says, it should use put_device() to
decrease the reference count in the error path. So fix this by calling
put_device, then the name can be freed in kobject_cleanp().

Fixes: ee959b00c335 ("SCSI: convert struct class_device to struct device")
Signed-off-by: Zhu Wang <wangzhu9@huawei.com>

---
Changes in v2:
- Move the new put_device() call from under if to under err_out label.

---
Changes in v3:
- Swap put_device() and list_del(), perform the error recovery actions
in the opposite order of the corresponding actions.
---
 drivers/scsi/raid_class.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/raid_class.c b/drivers/scsi/raid_class.c
index 898a0bdf8df6..711252e52d8e 100644
--- a/drivers/scsi/raid_class.c
+++ b/drivers/scsi/raid_class.c
@@ -248,6 +248,7 @@ int raid_component_add(struct raid_template *r,struct device *raid_dev,
 	return 0;
 
 err_out:
+	put_device(&rc->dev);
 	list_del(&rc->node);
 	rd->component_count--;
 	put_device(component_dev);
-- 
2.17.1

