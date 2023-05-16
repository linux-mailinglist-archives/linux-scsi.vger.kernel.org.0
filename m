Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B6E7043AA
	for <lists+linux-scsi@lfdr.de>; Tue, 16 May 2023 04:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjEPCzq (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 15 May 2023 22:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjEPCzp (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 15 May 2023 22:55:45 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D414EE58
        for <linux-scsi@vger.kernel.org>; Mon, 15 May 2023 19:55:43 -0700 (PDT)
Received: from canpemm100004.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QL15g3VFZzsS8y;
        Tue, 16 May 2023 10:53:43 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm100004.china.huawei.com
 (7.192.105.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 16 May
 2023 10:55:41 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <linux-scsi@vger.kernel.org>
CC:     <martin.petersen@oracle.com>, <jejb@linux.ibm.com>,
        Jason Yan <yanaijie@huawei.com>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH] scsi: MAINTAINERS: Add a libsas entry
Date:   Tue, 16 May 2023 10:53:43 +0800
Message-ID: <20230516025343.2050704-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm100004.china.huawei.com (7.192.105.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

John has been reviewing libsas patches for years. And I have been
contributing to libsas for years and I am interested in reviewing and
testing libsas patches too. So add a libsas entry and add John and me
as reviewer.

Cc: John Garry <john.g.garry@oracle.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7e0b87d5aa2e..a789811f6092 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18767,6 +18767,16 @@ F:	include/linux/wait.h
 F:	include/uapi/linux/sched.h
 F:	kernel/sched/
 
+SCSI LIBSAS SUBSYSTEM
+R:	John Garry <john.g.garry@oracle.com>
+R:	Jason Yan <yanaijie@huawei.com>
+L:	linux-scsi@vger.kernel.org
+S:	Supported
+F:	drivers/scsi/libsas
+F:	include/scsi/libsas.h
+F:	include/scsi/sas_ata.h
+F:	Documentation/scsi/libsas.rst
+
 SCSI RDMA PROTOCOL (SRP) INITIATOR
 M:	Bart Van Assche <bvanassche@acm.org>
 L:	linux-rdma@vger.kernel.org
-- 
2.31.1

