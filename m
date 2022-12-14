Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA44764C3FD
	for <lists+linux-scsi@lfdr.de>; Wed, 14 Dec 2022 07:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237486AbiLNGpz (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 14 Dec 2022 01:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237455AbiLNGpe (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 14 Dec 2022 01:45:34 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED10527DED
        for <linux-scsi@vger.kernel.org>; Tue, 13 Dec 2022 22:45:28 -0800 (PST)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NX5SX2cyRzlXRj;
        Wed, 14 Dec 2022 14:44:28 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500004.china.huawei.com
 (7.192.104.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 14 Dec
 2022 14:45:26 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <martin.petersen@oracle.com>, <jejb@linux.ibm.com>
CC:     <linux-scsi@vger.kernel.org>, <hare@suse.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <jinpu.wang@cloud.ionos.com>,
        <damien.lemoal@opensource.wdc.com>, <john.g.garry@oracle.com>,
        Jason Yan <yanaijie@huawei.com>
Subject: [PATCH v3 4/5] scsi: libsas: factor out sas_ata_add_dev()
Date:   Wed, 14 Dec 2022 15:06:07 +0800
Message-ID: <20221214070608.4128546-5-yanaijie@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221214070608.4128546-1-yanaijie@huawei.com>
References: <20221214070608.4128546-1-yanaijie@huawei.com>
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

Factor out sas_ata_add_dev() and put it in sas_ata.c since it is a sata
related interface. Also follow the standard coding style to define an
inline empty function when CONFIG_SCSI_SAS_ATA is not enabled.

Cc: John Garry <john.g.garry@oracle.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/scsi/libsas/sas_ata.c      | 62 ++++++++++++++++++++++++++++++
 drivers/scsi/libsas/sas_expander.c | 54 +-------------------------
 include/scsi/sas_ata.h             |  9 +++++
 3 files changed, 73 insertions(+), 52 deletions(-)

diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index de3439ae358d..13fbb8629057 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -675,6 +675,68 @@ void sas_probe_sata(struct asd_sas_port *port)
 
 }
 
+int sas_ata_add_dev(struct domain_device *parent, struct ex_phy *phy,
+		    struct domain_device *child, int phy_id)
+{
+	struct sas_rphy *rphy;
+	int ret;
+
+	if (child->linkrate > parent->min_linkrate) {
+		struct sas_phy *cphy = child->phy;
+		enum sas_linkrate min_prate = cphy->minimum_linkrate,
+			parent_min_lrate = parent->min_linkrate,
+			min_linkrate = (min_prate > parent_min_lrate) ?
+					parent_min_lrate : 0;
+		struct sas_phy_linkrates rates = {
+			.maximum_linkrate = parent->min_linkrate,
+			.minimum_linkrate = min_linkrate,
+		};
+
+		pr_notice("ex %016llx phy%02d SATA device linkrate > min pathway connection rate, attempting to lower device linkrate\n",
+			  SAS_ADDR(child->sas_addr), phy_id);
+		ret = sas_smp_phy_control(parent, phy_id,
+					  PHY_FUNC_LINK_RESET, &rates);
+		if (ret) {
+			pr_err("ex %016llx phy%02d SATA device could not set linkrate (%d)\n",
+			       SAS_ADDR(child->sas_addr), phy_id, ret);
+			return ret;
+		}
+		pr_notice("ex %016llx phy%02d SATA device set linkrate successfully\n",
+			  SAS_ADDR(child->sas_addr), phy_id);
+		child->linkrate = child->min_linkrate;
+	}
+	ret = sas_get_ata_info(child, phy);
+	if (ret)
+		return ret;
+
+	sas_init_dev(child);
+	ret = sas_ata_init(child);
+	if (ret)
+		return ret;
+
+	rphy = sas_end_device_alloc(phy->port);
+	if (!rphy)
+		return ret;
+
+	rphy->identify.phy_identifier = phy_id;
+	child->rphy = rphy;
+	get_device(&rphy->dev);
+
+	list_add_tail(&child->disco_list_node, &parent->port->disco_list);
+
+	ret = sas_discover_sata(child);
+	if (ret) {
+		pr_notice("sas_discover_sata() for device %16llx at %016llx:%02d returned 0x%x\n",
+			  SAS_ADDR(child->sas_addr),
+			  SAS_ADDR(parent->sas_addr), phy_id, ret);
+		sas_rphy_free(child->rphy);
+		list_del(&child->disco_list_node);
+		return ret;
+	}
+
+	return 0;
+}
+
 static void sas_ata_flush_pm_eh(struct asd_sas_port *port, const char *func)
 {
 	struct domain_device *dev, *n;
diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index 29e1b93b0964..0e4e09a0286a 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -785,61 +785,11 @@ static struct domain_device *sas_ex_discover_end_dev(
 	sas_ex_get_linkrate(parent, child, phy);
 	sas_device_set_phy(child, phy->port);
 
-#ifdef CONFIG_SCSI_SAS_ATA
 	if ((phy->attached_tproto & SAS_PROTOCOL_STP) || phy->attached_sata_dev) {
-		if (child->linkrate > parent->min_linkrate) {
-			struct sas_phy *cphy = child->phy;
-			enum sas_linkrate min_prate = cphy->minimum_linkrate,
-				parent_min_lrate = parent->min_linkrate,
-				min_linkrate = (min_prate > parent_min_lrate) ?
-					       parent_min_lrate : 0;
-			struct sas_phy_linkrates rates = {
-				.maximum_linkrate = parent->min_linkrate,
-				.minimum_linkrate = min_linkrate,
-			};
-			int ret;
-
-			pr_notice("ex %016llx phy%02d SATA device linkrate > min pathway connection rate, attempting to lower device linkrate\n",
-				   SAS_ADDR(child->sas_addr), phy_id);
-			ret = sas_smp_phy_control(parent, phy_id,
-						  PHY_FUNC_LINK_RESET, &rates);
-			if (ret) {
-				pr_err("ex %016llx phy%02d SATA device could not set linkrate (%d)\n",
-				       SAS_ADDR(child->sas_addr), phy_id, ret);
-				goto out_free;
-			}
-			pr_notice("ex %016llx phy%02d SATA device set linkrate successfully\n",
-				  SAS_ADDR(child->sas_addr), phy_id);
-			child->linkrate = child->min_linkrate;
-		}
-		res = sas_get_ata_info(child, phy);
-		if (res)
-			goto out_free;
-
-		sas_init_dev(child);
-		res = sas_ata_init(child);
+		res = sas_ata_add_dev(parent, phy, child, phy_id);
 		if (res)
 			goto out_free;
-		rphy = sas_end_device_alloc(phy->port);
-		if (!rphy)
-			goto out_free;
-		rphy->identify.phy_identifier = phy_id;
-
-		child->rphy = rphy;
-		get_device(&rphy->dev);
-
-		list_add_tail(&child->disco_list_node, &parent->port->disco_list);
-
-		res = sas_discover_sata(child);
-		if (res) {
-			pr_notice("sas_discover_sata() for device %16llx at %016llx:%02d returned 0x%x\n",
-				  SAS_ADDR(child->sas_addr),
-				  SAS_ADDR(parent->sas_addr), phy_id, res);
-			goto out_list_del;
-		}
-	} else
-#endif
-	  if (phy->attached_tproto & SAS_PROTOCOL_SSP) {
+	} else if (phy->attached_tproto & SAS_PROTOCOL_SSP) {
 		child->dev_type = SAS_END_DEVICE;
 		rphy = sas_end_device_alloc(phy->port);
 		/* FIXME: error handling */
diff --git a/include/scsi/sas_ata.h b/include/scsi/sas_ata.h
index 7cdba456b746..eda2b502095d 100644
--- a/include/scsi/sas_ata.h
+++ b/include/scsi/sas_ata.h
@@ -37,6 +37,8 @@ int sas_execute_ata_cmd(struct domain_device *device, u8 *fis,
 			int force_phy_id);
 int smp_ata_check_ready_type(struct ata_link *link);
 int sas_discover_sata(struct domain_device *dev);
+int sas_ata_add_dev(struct domain_device *parent, struct ex_phy *phy,
+		    struct domain_device *child, int phy_id);
 #else
 
 #define SAS_ATA_DISABLED_NOTICE \
@@ -112,6 +114,13 @@ static inline int sas_discover_sata(struct domain_device *dev)
 	SAS_ATA_DISABLED_NOTICE;
 	return -ENXIO;
 }
+
+static inline int sas_ata_add_dev(struct domain_device *parent, struct ex_phy *phy,
+				  struct domain_device *child, int phy_id)
+{
+	SAS_ATA_DISABLED_NOTICE;
+	return -ENODEV;
+}
 #endif
 
 #endif /* _SAS_ATA_H_ */
-- 
2.31.1

