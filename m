Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486D364CAE8
	for <lists+linux-scsi@lfdr.de>; Wed, 14 Dec 2022 14:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237959AbiLNNR2 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 14 Dec 2022 08:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237778AbiLNNR1 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 14 Dec 2022 08:17:27 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4A81B1F0
        for <linux-scsi@vger.kernel.org>; Wed, 14 Dec 2022 05:17:26 -0800 (PST)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NXG4x6b4hzqT8S;
        Wed, 14 Dec 2022 21:13:05 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500004.china.huawei.com
 (7.192.104.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 14 Dec
 2022 21:17:22 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <martin.petersen@oracle.com>, <jejb@linux.ibm.com>
CC:     <linux-scsi@vger.kernel.org>, <hare@suse.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <jinpu.wang@cloud.ionos.com>,
        <damien.lemoal@opensource.wdc.com>, <john.g.garry@oracle.com>,
        Jason Yan <yanaijie@huawei.com>
Subject: [PATCH v4 0/5] scsi: libsas: Some coding style fixes and cleanups
Date:   Wed, 14 Dec 2022 21:38:03 +0800
Message-ID: <20221214133808.1649122-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

A few coding style fixes and cleanups. There should be no functional
changes in this series besides the debug log prints.

v1->v2:
  1. Drop patch #2 in v1.
  2. Other misc changes suggested by John.

v2->v3:
  1. Add John's tag for patch #1 #3 #5.
  2. /s/sata/SATA/
  3. Make a global macro for prints of CONFIG_SCSI_SAS_ATA=N

v3->v4:
  1. Add John and Jack's tag.
  2. Change the macro for prints of CONFIG_SCSI_SAS_ATA=N to a function.

Jason Yan (5):
  scsi: libsas: move sas_get_ata_command_set() up to save the
    declaration
  scsi: libsas: change the coding style of sas_discover_sata()
  scsi: libsas: remove useless dev_list delete in
    sas_ex_discover_end_dev()
  scsi: libsas: factor out sas_ata_add_dev()
  scsi: libsas: factor out sas_ex_add_dev()

 drivers/scsi/libsas/sas_ata.c      |  88 ++++++++++++++++----
 drivers/scsi/libsas/sas_discover.c |   6 --
 drivers/scsi/libsas/sas_expander.c | 125 ++++++++++-------------------
 include/scsi/libsas.h              |   1 -
 include/scsi/sas_ata.h             |  20 +++++
 5 files changed, 134 insertions(+), 106 deletions(-)

-- 
2.31.1

