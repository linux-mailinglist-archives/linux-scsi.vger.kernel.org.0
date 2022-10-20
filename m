Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7CB6062BE
	for <lists+linux-scsi@lfdr.de>; Thu, 20 Oct 2022 16:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiJTORc (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 20 Oct 2022 10:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiJTORb (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 20 Oct 2022 10:17:31 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBC05BC82
        for <linux-scsi@vger.kernel.org>; Thu, 20 Oct 2022 07:17:29 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MtV165mmdz1P74P
        for <linux-scsi@vger.kernel.org>; Thu, 20 Oct 2022 22:12:42 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 22:17:27 +0800
From:   Yihang Li <liyihang9@huawei.com>
To:     <john.garry@huawei.com>, <linuxarm@huawei.com>
CC:     <linux-scsi@vger.kernel.org>, <chenxiang66@hisilicon.com>,
        <prime.zeng@hisilicon.com>, <yangxingui@huawei.com>,
        <liyihang9@huawei.com>
Subject: [PATCH 0/2] Check and update the device link rate during discovery
Date:   Thu, 20 Oct 2022 22:16:33 +0800
Message-ID: <20221020141635.2479412-1-liyihang9@huawei.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

SATA devices attached to an expander maybe generate incorrect IOs when
physical link re-establish at a lower link rate. This is due to the
expander PHY attached to a SATA PHY is using link rate greater than the
physical PHY link rate which is re-established.

This patchset fixes the issue.

Yihang Li (2):
  scsi: libsas: Add sas_update_linkrate()
  scsi: libsas: Add sas_check_port_linkrate()

 drivers/scsi/libsas/sas_discover.c | 18 +++++++++++++-
 drivers/scsi/libsas/sas_expander.c | 40 ++++++++++++++++++++++++++++++
 drivers/scsi/libsas/sas_internal.h |  1 +
 3 files changed, 58 insertions(+), 1 deletion(-)

-- 
2.30.0

