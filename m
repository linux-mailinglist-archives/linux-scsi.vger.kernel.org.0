Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81FF75BB7C1
	for <lists+linux-scsi@lfdr.de>; Sat, 17 Sep 2022 12:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiIQKcb (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 17 Sep 2022 06:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiIQKc1 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 17 Sep 2022 06:32:27 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D462B31348;
        Sat, 17 Sep 2022 03:32:24 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MV6cx53QgzpStj;
        Sat, 17 Sep 2022 18:29:37 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500004.china.huawei.com
 (7.192.104.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 17 Sep
 2022 18:32:21 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <martin.petersen@oracle.com>, <jejb@linux.ibm.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hare@suse.com>, <hch@lst.de>, <bvanassche@acm.org>,
        <john.garry@huawei.com>, <jinpu.wang@cloud.ionos.com>,
        Jason Yan <yanaijie@huawei.com>
Subject: [PATCH 1/7] scsi: libsas: introduce sas address conversion and comparation helpers
Date:   Sat, 17 Sep 2022 18:43:05 +0800
Message-ID: <20220917104311.1878250-2-yanaijie@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220917104311.1878250-1-yanaijie@huawei.com>
References: <20220917104311.1878250-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Sas address conversion and comparation is widely used in libsas and
drivers. However they are all opencoded and to avoid the line spill over
80 columns, are mostly split into multi-lines. Introduce some helpers to
prepare some refactor.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 include/scsi/libsas.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index 2dbead74a2af..382aedf31fa4 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -648,6 +648,38 @@ static inline bool sas_is_internal_abort(struct sas_task *task)
 	return task->task_proto == SAS_PROTOCOL_INTERNAL_ABORT;
 }
 
+static inline unsigned long long ex_phy_addr(struct ex_phy *phy)
+{
+	return SAS_ADDR(phy->attached_sas_addr);
+}
+
+static inline unsigned long long dev_addr(struct domain_device *dev)
+{
+	return SAS_ADDR(dev->sas_addr);
+}
+
+static inline unsigned long long port_addr(struct asd_sas_port *port)
+{
+	return SAS_ADDR(port->sas_addr);
+}
+
+static inline bool dev_and_phy_addr_same(struct domain_device *dev,
+					 struct ex_phy *phy)
+{
+	return dev_addr(dev) == ex_phy_addr(phy);
+}
+
+static inline bool port_and_phy_addr_same(struct asd_sas_port *port,
+					  struct ex_phy *phy)
+{
+	return port_addr(port) == ex_phy_addr(phy);
+}
+
+static inline bool ex_phy_addr_same(struct ex_phy *phy1, struct ex_phy *phy2)
+{
+	return  ex_phy_addr(phy1) ==  ex_phy_addr(phy2);
+}
+
 struct sas_domain_function_template {
 	/* The class calls these to notify the LLDD of an event. */
 	void (*lldd_port_formed)(struct asd_sas_phy *);
-- 
2.31.1

