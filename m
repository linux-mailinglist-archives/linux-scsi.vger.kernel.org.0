Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0042D5ED4F6
	for <lists+linux-scsi@lfdr.de>; Wed, 28 Sep 2022 08:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbiI1Gjk (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 28 Sep 2022 02:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiI1Gjh (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 28 Sep 2022 02:39:37 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3385C1ED212;
        Tue, 27 Sep 2022 23:39:29 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mcmww0nW2zpStd;
        Wed, 28 Sep 2022 14:36:32 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500004.china.huawei.com
 (7.192.104.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 28 Sep
 2022 14:39:27 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <martin.petersen@oracle.com>, <jejb@linux.ibm.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hare@suse.com>, <hch@lst.de>, <bvanassche@acm.org>,
        <john.garry@huawei.com>, <jinpu.wang@cloud.ionos.com>,
        <damien.lemoal@opensource.wdc.com>, Jason Yan <yanaijie@huawei.com>
Subject: [PATCH v6 1/8] scsi: libsas: introduce sas address comparison helpers
Date:   Wed, 28 Sep 2022 15:01:23 +0800
Message-ID: <20220928070130.3657183-2-yanaijie@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220928070130.3657183-1-yanaijie@huawei.com>
References: <20220928070130.3657183-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Sas address comparison is widely used in libsas. However they are all
opencoded and to avoid the line spill over 80 columns, are mostly split
into multi-lines. Introduce some helpers to prepare some refactor.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/libsas/sas_internal.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/scsi/libsas/sas_internal.h b/drivers/scsi/libsas/sas_internal.h
index 8d0ad3abc7b5..3384429b7eb0 100644
--- a/drivers/scsi/libsas/sas_internal.h
+++ b/drivers/scsi/libsas/sas_internal.h
@@ -111,6 +111,23 @@ static inline void sas_smp_host_handler(struct bsg_job *job,
 }
 #endif
 
+static inline bool sas_phy_match_dev_addr(struct domain_device *dev,
+					 struct ex_phy *phy)
+{
+	return SAS_ADDR(dev->sas_addr) == SAS_ADDR(phy->attached_sas_addr);
+}
+
+static inline bool sas_phy_match_port_addr(struct asd_sas_port *port,
+					   struct ex_phy *phy)
+{
+	return SAS_ADDR(port->sas_addr) == SAS_ADDR(phy->attached_sas_addr);
+}
+
+static inline bool sas_phy_addr_match(struct ex_phy *p1, struct ex_phy *p2)
+{
+	return  SAS_ADDR(p1->attached_sas_addr) == SAS_ADDR(p2->attached_sas_addr);
+}
+
 static inline void sas_fail_probe(struct domain_device *dev, const char *func, int err)
 {
 	pr_warn("%s: for %s device %016llx returned %d\n",
-- 
2.31.1

