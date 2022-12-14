Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1AA64CAE9
	for <lists+linux-scsi@lfdr.de>; Wed, 14 Dec 2022 14:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238231AbiLNNRa (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 14 Dec 2022 08:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237522AbiLNNR1 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 14 Dec 2022 08:17:27 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68FAEE16
        for <linux-scsi@vger.kernel.org>; Wed, 14 Dec 2022 05:17:25 -0800 (PST)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NXG4y3VZkzqT3l;
        Wed, 14 Dec 2022 21:13:06 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500004.china.huawei.com
 (7.192.104.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 14 Dec
 2022 21:17:23 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <martin.petersen@oracle.com>, <jejb@linux.ibm.com>
CC:     <linux-scsi@vger.kernel.org>, <hare@suse.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <jinpu.wang@cloud.ionos.com>,
        <damien.lemoal@opensource.wdc.com>, <john.g.garry@oracle.com>,
        Jason Yan <yanaijie@huawei.com>,
        Jack Wang <jinpu.wang@ionos.com>
Subject: [PATCH v4 1/5] scsi: libsas: move sas_get_ata_command_set() up to save the declaration
Date:   Wed, 14 Dec 2022 21:38:04 +0800
Message-ID: <20221214133808.1649122-2-yanaijie@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221214133808.1649122-1-yanaijie@huawei.com>
References: <20221214133808.1649122-1-yanaijie@huawei.com>
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

There is a sas_get_ata_command_set() declaration above sas_get_ata_info()
to make it compile ok. However this function is defined in the same file
below. So move it up to save the forward declaration.

Also remove the variable 'fis' which is not needed in this function.

Cc: John Garry <john.g.garry@oracle.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/scsi/libsas/sas_ata.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index f7439bf9cdc6..de3439ae358d 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -239,7 +239,17 @@ static struct sas_internal *dev_to_sas_internal(struct domain_device *dev)
 	return to_sas_internal(dev->port->ha->core.shost->transportt);
 }
 
-static int sas_get_ata_command_set(struct domain_device *dev);
+static int sas_get_ata_command_set(struct domain_device *dev)
+{
+	struct ata_taskfile tf;
+
+	if (dev->dev_type == SAS_SATA_PENDING)
+		return ATA_DEV_UNKNOWN;
+
+	ata_tf_from_fis(dev->frame_rcvd, &tf);
+
+	return ata_dev_classify(&tf);
+}
 
 int sas_get_ata_info(struct domain_device *dev, struct ex_phy *phy)
 {
@@ -637,20 +647,6 @@ void sas_ata_task_abort(struct sas_task *task)
 	complete(waiting);
 }
 
-static int sas_get_ata_command_set(struct domain_device *dev)
-{
-	struct dev_to_host_fis *fis =
-		(struct dev_to_host_fis *) dev->frame_rcvd;
-	struct ata_taskfile tf;
-
-	if (dev->dev_type == SAS_SATA_PENDING)
-		return ATA_DEV_UNKNOWN;
-
-	ata_tf_from_fis((const u8 *)fis, &tf);
-
-	return ata_dev_classify(&tf);
-}
-
 void sas_probe_sata(struct asd_sas_port *port)
 {
 	struct domain_device *dev, *n;
-- 
2.31.1

