Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250CA75E12F
	for <lists+linux-scsi@lfdr.de>; Sun, 23 Jul 2023 12:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjGWKT4 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 23 Jul 2023 06:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjGWKTz (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 23 Jul 2023 06:19:55 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87D9120;
        Sun, 23 Jul 2023 03:19:54 -0700 (PDT)
Received: from kwepemm600012.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R7zj95Mw9zNmJ5;
        Sun, 23 Jul 2023 18:16:29 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 23 Jul 2023 18:19:50 +0800
From:   Wenchao Hao <haowenchao2@huawei.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Douglas Gilbert <dgilbert@interlog.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <error27@gmail.com>, <louhongxiang@huawei.com>,
        Wenchao Hao <haowenchao2@huawei.com>
Subject: [PATCH v3 0/9] scsi:scsi_debug: Add error injection for single device
Date:   Mon, 24 Jul 2023 07:40:56 +0800
Message-ID: <20230723234105.1628982-1-haowenchao2@huawei.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600012.china.huawei.com (7.193.23.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The original error injection mechanism was based on scsi_host which
could not inject fault for a single SCSI device.

This patchset provides the ability to inject errors for a single
SCSI device. Now we supports inject timeout errors, queuecommand
errors, and hostbyte, driverbyte, statusbyte, and sense data for
specific SCSI Command. Two new error injection is defined to make
abort command or reset LUN failed.

Besides error injection for single device, this patchset add a
new interface to make reset target failed for each scsi_target.

The first two patch add an debugfs interface to add and inquiry single
device's error injection info; the third patch defined how to remove
an injection which has been added. The following 5 patches use the
injection info and generate the related error type. The last one just
Add a new interface to make reset target failed.

V3:
  - Add two more error types to fail abort command and lun reset
  - Fix memleak when rmmod scsi_debug without clearing errors injected
  - Fix memkeak because did not implement release in sdebug_error_fops
  - Fix possible NULL point access in scsi_debug_slave_destroy
  - Move specific error type's description to each single patch which
    implement this error type
  - Add interface to make target reset fail

V2:
  - Using debugfs rather than sysfs attribute interface to manage error

Wenchao Hao (9):
  scsi:scsi_debug: create scsi_debug directory in the debugfs filesystem
  scsi:scsi_debug: Add interface to manage single device's error inject
  scsi:scsi_debug: Define grammar to remove added error injection
  scsi:scsi_debug: timeout command if the error is injected
  scsi:scsi_debug: Return failed value if the error is injected
  scsi:scsi_debug: set command's result and sense data if the error is injected
  scsi:scsi_debug: Add new error injection abort failed
  scsi:scsi_debug: Add new error injection reset lun failed
  scsi:scsi_debug: Add debugfs interface to fail target reset

 drivers/scsi/scsi_debug.c | 503 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 498 insertions(+), 5 deletions(-)

-- 
2.35.3

