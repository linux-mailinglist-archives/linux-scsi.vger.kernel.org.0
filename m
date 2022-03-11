Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4BF74D6189
	for <lists+linux-scsi@lfdr.de>; Fri, 11 Mar 2022 13:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348583AbiCKMa6 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 11 Mar 2022 07:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348568AbiCKMaw (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 11 Mar 2022 07:30:52 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426A71C910;
        Fri, 11 Mar 2022 04:29:49 -0800 (PST)
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KFQGd4n4gz688Wb;
        Fri, 11 Mar 2022 20:29:13 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Mar 2022 13:29:46 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Mar 2022 12:29:42 +0000
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <damien.lemoal@opensource.wdc.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Ajish.Koshy@microchip.com>, <linuxarm@huawei.com>,
        <Viswas.G@microchip.com>, <hch@lst.de>, <liuqi115@huawei.com>,
        <chenxiang66@hisilicon.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH v2 2/4] scsi: libsas: Add sas_execute_internal_abort_dev()
Date:   Fri, 11 Mar 2022 20:23:50 +0800
Message-ID: <1647001432-239276-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1647001432-239276-1-git-send-email-john.garry@huawei.com>
References: <1647001432-239276-1-git-send-email-john.garry@huawei.com>
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

Add support for a "device" variant of internal abort, which will abort all
pending IOs for a specific device.

Signed-off-by: John Garry <john.garry@huawei.com>
Tested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/scsi/libsas/sas_scsi_host.c | 8 ++++++++
 include/scsi/libsas.h               | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index bb6baa52264d..13142ec97f1d 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -994,6 +994,14 @@ int sas_execute_internal_abort_single(struct domain_device *device, u16 tag,
 }
 EXPORT_SYMBOL_GPL(sas_execute_internal_abort_single);
 
+int sas_execute_internal_abort_dev(struct domain_device *device,
+				   unsigned int qid, void *data)
+{
+	return sas_execute_internal_abort(device, SAS_INTERNAL_ABORT_DEV,
+					  SCSI_NO_TAG, qid, data);
+}
+EXPORT_SYMBOL_GPL(sas_execute_internal_abort_dev);
+
 int sas_execute_tmf(struct domain_device *device, void *parameter,
 		    int para_len, int force_phy_id,
 		    struct sas_tmf_task *tmf)
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index 2d30d57916e5..71f632b2d2bd 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -560,6 +560,7 @@ struct sas_ata_task {
 /* LLDDs rely on these values */
 enum sas_internal_abort {
 	SAS_INTERNAL_ABORT_SINGLE	= 0,
+	SAS_INTERNAL_ABORT_DEV		= 1,
 };
 
 struct sas_internal_abort_task {
@@ -641,6 +642,11 @@ extern struct sas_task *sas_alloc_task(gfp_t flags);
 extern struct sas_task *sas_alloc_slow_task(gfp_t flags);
 extern void sas_free_task(struct sas_task *task);
 
+static inline bool sas_is_internal_abort(struct sas_task *task)
+{
+	return task->task_proto == SAS_PROTOCOL_INTERNAL_ABORT;
+}
+
 struct sas_domain_function_template {
 	/* The class calls these to notify the LLDD of an event. */
 	void (*lldd_port_formed)(struct asd_sas_phy *);
@@ -697,6 +703,8 @@ extern int sas_bios_param(struct scsi_device *, struct block_device *,
 int sas_execute_internal_abort_single(struct domain_device *device,
 				      u16 tag, unsigned int qid,
 				      void *data);
+int sas_execute_internal_abort_dev(struct domain_device *device,
+				   unsigned int qid, void *data);
 extern struct scsi_transport_template *
 sas_domain_attach_transport(struct sas_domain_function_template *);
 extern struct device_attribute dev_attr_phy_event_threshold;
-- 
2.26.2

