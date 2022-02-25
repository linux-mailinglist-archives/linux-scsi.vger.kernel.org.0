Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156D04C4302
	for <lists+linux-scsi@lfdr.de>; Fri, 25 Feb 2022 12:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239795AbiBYLDl (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 25 Feb 2022 06:03:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236456AbiBYLDk (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 25 Feb 2022 06:03:40 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A4322320C;
        Fri, 25 Feb 2022 03:03:09 -0800 (PST)
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K4n0T28Mgz684R2;
        Fri, 25 Feb 2022 19:02:01 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 25 Feb 2022 12:03:07 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 25 Feb 2022 11:03:04 +0000
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <chenxiang66@hisilicon.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <damien.lemoal@opensource.wdc.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v2 0/2] scsi: libsas: Some minor improvements
Date:   Fri, 25 Feb 2022 18:57:34 +0800
Message-ID: <1645786656-221630-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Martin,

This is just a couple of small improvements which we had sitting on our
dev branch. Please consider for 5.18.

Changes since v1:
- add RB tag (thanks)
- simplify C code in 2/2 

Thanks!

John Garry (2):
  scsi: libsas: Make sas_notify_{phy,port}_event() return void
  scsi: libsas: Use bool for queue_work() return code

 drivers/scsi/libsas/sas_event.c    | 50 ++++++++++++------------------
 drivers/scsi/libsas/sas_internal.h |  4 +--
 include/scsi/libsas.h              |  8 ++---
 3 files changed, 24 insertions(+), 38 deletions(-)

-- 
2.26.2

