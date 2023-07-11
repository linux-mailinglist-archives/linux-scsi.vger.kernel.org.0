Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9C574E46E
	for <lists+linux-scsi@lfdr.de>; Tue, 11 Jul 2023 04:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjGKCok (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 10 Jul 2023 22:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjGKCoi (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 10 Jul 2023 22:44:38 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6487B1AC
        for <linux-scsi@vger.kernel.org>; Mon, 10 Jul 2023 19:44:37 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R0QCv6hjKzVhkT;
        Tue, 11 Jul 2023 10:43:23 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 kwepemi500016.china.huawei.com (7.221.188.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 11 Jul 2023 10:44:34 +0800
From:   chenxiang <chenxiang66@hisilicon.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-scsi@vger.kernel.org>,
        Xiang Chen <chenxiang66@hisilicon.com>
Subject: [PATCH 0/3] Some misc changes
Date:   Tue, 11 Jul 2023 11:14:57 +0800
Message-ID: <1689045300-44318-1-git-send-email-chenxiang66@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Xiang Chen <chenxiang66@hisilicon.com>

This series contain some fixes including:
- Fix completed I/O analysed as failed
- Block requests before a debugfs snapshot
- Delete unused lock in function hisi_sas_port_notify_formed()

Xingui Yang (1):
  scsi: hisi_sas: Fix normally completed I/O analysed as failed

Yihang Li (2):
  scsi: hisi_sas: Block requests before a debugfs snapshot
  scsi: hisi_sas: Delete unused lock in hisi_sas_port_notify_formed()

 drivers/scsi/hisi_sas/hisi_sas_main.c  |  5 -----
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 11 +++++++++--
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 16 +++++++++++-----
 3 files changed, 20 insertions(+), 12 deletions(-)

-- 
2.8.1

