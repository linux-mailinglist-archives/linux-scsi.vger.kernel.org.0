Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95DCD792855
	for <lists+linux-scsi@lfdr.de>; Tue,  5 Sep 2023 18:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236840AbjIEQGO (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 5 Sep 2023 12:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343917AbjIEC53 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 4 Sep 2023 22:57:29 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23BECC9;
        Mon,  4 Sep 2023 19:57:25 -0700 (PDT)
Received: from dggpemm500012.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RfqpP0YmVzMl5w;
        Tue,  5 Sep 2023 10:54:05 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 dggpemm500012.china.huawei.com (7.185.36.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 5 Sep 2023 10:57:23 +0800
From:   Xingui Yang <yangxingui@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <john.g.garry@oracle.com>, <damien.lemoal@opensource.wdc.com>
CC:     <andriy.shevchenko@linux.intel.com>, <akpm@linux-foundation.org>,
        <viro@zeniv.linux.org.uk>, <himanshu.madhani@cavium.com>,
        <felipe.balbi@linux.intel.com>, <gregkh@linuxfoundation.org>,
        <uma.shankar@intel.com>, <anshuman.gupta@intel.com>,
        <animesh.manna@intel.com>, <linux-usb@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yangxingui@huawei.com>,
        <prime.zeng@hisilicon.com>, <kangfenglong@huawei.com>,
        <chenxiang66@hisilicon.com>
Subject: [PATCH v6 0/3] Add helper macro DEFINE_SHOW_STORE_ATTRIBUTE() at seq_file.c
Date:   Tue, 5 Sep 2023 02:48:32 +0000
Message-ID: <20230905024835.43219-1-yangxingui@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500012.china.huawei.com (7.185.36.89)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

We already own DEFINE_SHOW_ATTRIBUTE() helper macro for defining attribute
for read-only file, but we found many of drivers also want a helper macro
for read-write file too.

So we add this helper macro to reduce duplicated code.

Changes from v5:
- Undelete the unused macros in qla_dfs.c and rewrite them using reference
  to the new macro on Andy's suggestion.
- Adjust some descriptions in commit based on Andy's suggestion.

Changes from v4:
- Reduce the scope to scsi subsystem based on Andy's suggestion.
- Remove unused macros in qla_dfs.c
- Adjust some descriptions in commit.

Changes from v3:
- Add AI Viro's comment to v1->v2's revision description.
- Fixed a spelling mistakes of "marco" to "macro".

Changes from v2:
- Fixed some spelling mistakes in commit.
- Revision description are added for easy tracing.

Changes from v1:
- Rename DEFINE_STORE_ATTRIBUTE() to DEFINE_SHOW_STORE_ATTRIBUTE().
- AI Viro points out that he doesn't like the definition of macros
  like DEFINE_SHOW_ATTRIBUTE.

Luo Jiaxing (3):
  seq_file: Add helper macro to define attribute for rw file
  scsi: hisi_sas: Use DEFINE_SHOW_STORE_ATTRIBUTE() helper for debugfs
  scsi: qla2xxx: Use DEFINE_SHOW_STORE_ATTRIBUTE() helper for debugfs

 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 137 ++-----------------------
 drivers/scsi/qla2xxx/qla_dfs.c         |  59 ++---------
 include/linux/seq_file.h               |  15 +++
 3 files changed, 31 insertions(+), 180 deletions(-)

-- 
2.17.1

