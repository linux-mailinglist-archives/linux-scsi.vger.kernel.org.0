Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5288C4BF88E
	for <lists+linux-scsi@lfdr.de>; Tue, 22 Feb 2022 13:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbiBVM6E (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 22 Feb 2022 07:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbiBVM57 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 22 Feb 2022 07:57:59 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A62AC062;
        Tue, 22 Feb 2022 04:57:32 -0800 (PST)
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K2zbf0ryJz67NkB;
        Tue, 22 Feb 2022 20:52:46 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Feb 2022 13:57:30 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Feb 2022 12:57:26 +0000
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <artur.paszkiewicz@intel.com>, <jinpu.wang@cloud.ionos.com>,
        <chenxiang66@hisilicon.com>, <damien.lemoal@opensource.wdc.com>,
        <hch@lst.de>
CC:     <Ajish.Koshy@microchip.com>, <yanaijie@huawei.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
        <liuqi115@huawei.com>, <Viswas.G@microchip.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v3 15/18] scsi: libsas: Add sas_lu_reset()
Date:   Tue, 22 Feb 2022 20:50:56 +0800
Message-ID: <1645534259-27068-16-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1645534259-27068-1-git-send-email-john.garry@huawei.com>
References: <1645534259-27068-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

Add a generic implementation of LU reset TMF handler, and use in LLDDs.

Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Yihang Li <liyihang6@hisilicon.com>
Tested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c |  4 +---
 drivers/scsi/libsas/sas_scsi_host.c   | 10 ++++++++++
 drivers/scsi/mvsas/mv_sas.c           |  4 +---
 drivers/scsi/pm8001/pm8001_sas.c      |  4 +---
 include/scsi/libsas.h                 |  1 +
 5 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 6826ddfeaca5..3773874b0c2e 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -1933,9 +1933,7 @@ static int hisi_sas_lu_reset(struct domain_device *device, u8 *lun)
 			hisi_sas_release_task(hisi_hba, device);
 		sas_put_local_phy(phy);
 	} else {
-		struct sas_tmf_task tmf_task = { .tmf =  TMF_LU_RESET };
-
-		rc = hisi_sas_debug_issue_ssp_tmf(device, lun, &tmf_task);
+		rc = sas_lu_reset(device, lun);
 		if (rc == TMF_RESP_FUNC_COMPLETE)
 			hisi_sas_release_task(hisi_hba, device);
 	}
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index ac669215c3bc..d6f29e13204e 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -1063,6 +1063,16 @@ int sas_clear_task_set(struct domain_device *dev, u8 *lun)
 }
 EXPORT_SYMBOL_GPL(sas_clear_task_set);
 
+int sas_lu_reset(struct domain_device *dev, u8 *lun)
+{
+	struct sas_tmf_task tmf_task = {
+		.tmf = TMF_LU_RESET,
+	};
+
+	return sas_execute_ssp_tmf(dev, lun, &tmf_task);
+}
+EXPORT_SYMBOL_GPL(sas_lu_reset);
+
 /*
  * Tell an upper layer that it needs to initiate an abort for a given task.
  * This should only ever be called by an LLDD.
diff --git a/drivers/scsi/mvsas/mv_sas.c b/drivers/scsi/mvsas/mv_sas.c
index 37604b1ebd46..fdaaa4380e74 100644
--- a/drivers/scsi/mvsas/mv_sas.c
+++ b/drivers/scsi/mvsas/mv_sas.c
@@ -1381,13 +1381,11 @@ int mvs_lu_reset(struct domain_device *dev, u8 *lun)
 {
 	unsigned long flags;
 	int rc = TMF_RESP_FUNC_FAILED;
-	struct sas_tmf_task tmf_task;
 	struct mvs_device * mvi_dev = dev->lldd_dev;
 	struct mvs_info *mvi = mvi_dev->mvi_info;
 
-	tmf_task.tmf = TMF_LU_RESET;
 	mvi_dev->dev_status = MVS_DEV_EH;
-	rc = mvs_debug_issue_ssp_tmf(dev, lun, &tmf_task);
+	rc = sas_lu_reset(dev, lun);
 	if (rc == TMF_RESP_FUNC_COMPLETE) {
 		spin_lock_irqsave(&mvi->lock, flags);
 		mvs_release_task(mvi, dev);
diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
index fd86490616e8..18e8420055b5 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -1112,7 +1112,6 @@ int pm8001_I_T_nexus_event_handler(struct domain_device *dev)
 int pm8001_lu_reset(struct domain_device *dev, u8 *lun)
 {
 	int rc = TMF_RESP_FUNC_FAILED;
-	struct sas_tmf_task tmf_task;
 	struct pm8001_device *pm8001_dev = dev->lldd_dev;
 	struct pm8001_hba_info *pm8001_ha = pm8001_find_ha_by_dev(dev);
 	DECLARE_COMPLETION_ONSTACK(completion_setstate);
@@ -1127,8 +1126,7 @@ int pm8001_lu_reset(struct domain_device *dev, u8 *lun)
 			pm8001_dev, DS_OPERATIONAL);
 		wait_for_completion(&completion_setstate);
 	} else {
-		tmf_task.tmf = TMF_LU_RESET;
-		rc = pm8001_issue_ssp_tmf(dev, lun, &tmf_task);
+		rc = sas_lu_reset(dev, lun);
 	}
 	/* If failed, fall-through I_T_Nexus reset */
 	pm8001_dbg(pm8001_ha, EH, "for device[%x]:rc=%d\n",
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index f71a47740ff8..7b1e2e7f5a6c 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -724,6 +724,7 @@ int sas_request_addr(struct Scsi_Host *shost, u8 *addr);
 
 int sas_abort_task_set(struct domain_device *dev, u8 *lun);
 int sas_clear_task_set(struct domain_device *dev, u8 *lun);
+int sas_lu_reset(struct domain_device *dev, u8 *lun);
 
 int sas_notify_port_event(struct asd_sas_phy *phy, enum port_event event,
 			  gfp_t gfp_flags);
-- 
2.26.2

