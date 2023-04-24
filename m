Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49456E973A
	for <lists+linux-scsi@lfdr.de>; Thu, 20 Apr 2023 16:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbjDTOen (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 20 Apr 2023 10:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjDTOek (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 20 Apr 2023 10:34:40 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5314435BE
        for <linux-scsi@vger.kernel.org>; Thu, 20 Apr 2023 07:34:33 -0700 (PDT)
Received: from canpemm100004.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Q2Knx1yCQznc0M;
        Thu, 20 Apr 2023 22:30:45 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm100004.china.huawei.com
 (7.192.105.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 20 Apr
 2023 22:34:30 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <martin.petersen@oracle.com>, <jejb@linux.ibm.com>
CC:     <linux-scsi@vger.kernel.org>, <hare@suse.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <jinpu.wang@cloud.ionos.com>,
        <damien.lemoal@opensource.wdc.com>, <john.g.garry@oracle.com>,
        Jason Yan <yanaijie@huawei.com>
Subject: [PATCH v2 1/3] scsi: libsas: Simplify sas_check_eeds()
Date:   Thu, 20 Apr 2023 22:33:37 +0800
Message-ID: <20230420143339.2769414-2-yanaijie@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230420143339.2769414-1-yanaijie@huawei.com>
References: <20230420143339.2769414-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

In sas_check_eeds() there is an empty branch. We can reverse the
test expression and then remove the empty branch. Also the the test
expression is a little bit complex so it deserves an individual
function. And make the continuing prototype lines indented after
the opening parenthesis to follow the standard coding style.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/scsi/libsas/sas_expander.c | 39 +++++++++++++++---------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index dc670304f181..70fd4f439664 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -1198,37 +1198,36 @@ static void sas_print_parent_topology_bug(struct domain_device *child,
 		  sas_route_char(child, child_phy));
 }
 
+static bool sas_eeds_valid(struct domain_device *parent, struct domain_device *child)
+{
+	struct sas_discovery *disc = &parent->port->disc;
+
+	return (SAS_ADDR(disc->eeds_a) == SAS_ADDR(parent->sas_addr) ||
+		SAS_ADDR(disc->eeds_a) == SAS_ADDR(child->sas_addr)) &&
+	       (SAS_ADDR(disc->eeds_b) == SAS_ADDR(parent->sas_addr) ||
+		SAS_ADDR(disc->eeds_b) == SAS_ADDR(child->sas_addr));
+}
+
 static int sas_check_eeds(struct domain_device *child,
-				 struct ex_phy *parent_phy,
-				 struct ex_phy *child_phy)
+			  struct ex_phy *parent_phy,
+			  struct ex_phy *child_phy)
 {
 	int res = 0;
 	struct domain_device *parent = child->parent;
+	struct sas_discovery *disc = &parent->port->disc;
 
-	if (SAS_ADDR(parent->port->disc.fanout_sas_addr) != 0) {
+	if (SAS_ADDR(disc->fanout_sas_addr) != 0) {
 		res = -ENODEV;
 		pr_warn("edge ex %016llx phy S:%02d <--> edge ex %016llx phy S:%02d, while there is a fanout ex %016llx\n",
 			SAS_ADDR(parent->sas_addr),
 			parent_phy->phy_id,
 			SAS_ADDR(child->sas_addr),
 			child_phy->phy_id,
-			SAS_ADDR(parent->port->disc.fanout_sas_addr));
-	} else if (SAS_ADDR(parent->port->disc.eeds_a) == 0) {
-		memcpy(parent->port->disc.eeds_a, parent->sas_addr,
-		       SAS_ADDR_SIZE);
-		memcpy(parent->port->disc.eeds_b, child->sas_addr,
-		       SAS_ADDR_SIZE);
-	} else if (((SAS_ADDR(parent->port->disc.eeds_a) ==
-		    SAS_ADDR(parent->sas_addr)) ||
-		   (SAS_ADDR(parent->port->disc.eeds_a) ==
-		    SAS_ADDR(child->sas_addr)))
-		   &&
-		   ((SAS_ADDR(parent->port->disc.eeds_b) ==
-		     SAS_ADDR(parent->sas_addr)) ||
-		    (SAS_ADDR(parent->port->disc.eeds_b) ==
-		     SAS_ADDR(child->sas_addr))))
-		;
-	else {
+			SAS_ADDR(disc->fanout_sas_addr));
+	} else if (SAS_ADDR(disc->eeds_a) == 0) {
+		memcpy(disc->eeds_a, parent->sas_addr, SAS_ADDR_SIZE);
+		memcpy(disc->eeds_b, child->sas_addr, SAS_ADDR_SIZE);
+	} else if (!sas_eeds_valid(parent, child)) {
 		res = -ENODEV;
 		pr_warn("edge ex %016llx phy%02d <--> edge ex %016llx phy%02d link forms a third EEDS!\n",
 			SAS_ADDR(parent->sas_addr),
-- 
2.31.1

