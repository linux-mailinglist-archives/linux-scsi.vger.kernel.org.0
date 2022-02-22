Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410974BF893
	for <lists+linux-scsi@lfdr.de>; Tue, 22 Feb 2022 13:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbiBVM6H (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 22 Feb 2022 07:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbiBVM5u (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 22 Feb 2022 07:57:50 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85749BBBD;
        Tue, 22 Feb 2022 04:57:01 -0800 (PST)
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K2zgh1CCSz67xhs;
        Tue, 22 Feb 2022 20:56:16 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Tue, 22 Feb 2022 13:56:59 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Feb 2022 12:56:55 +0000
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
Subject: [PATCH v3 07/18] scsi: libsas: Add struct sas_tmf_task
Date:   Tue, 22 Feb 2022 20:50:48 +0800
Message-ID: <1645534259-27068-8-git-send-email-john.garry@huawei.com>
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

Some of the LLDDs which use libsas have their own definition of a struct
to hold TMF info, so add a common struct for libsas.

Also add an interim force phy id field for hisi_sas driver, which will be
removed once the STP "TMF" code is factored out.

Even though some LLDDs (pm8001) use a u32 for the tag, u16 will be adequate,
as that named driver only uses tags in range [0, 1024).

Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Yihang Li <liyihang6@hisilicon.com>
Tested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/scsi/hisi_sas/hisi_sas.h       |  9 +--------
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 22 +++++++++++-----------
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c |  2 +-
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |  4 ++--
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  2 +-
 drivers/scsi/mvsas/mv_defs.h           |  5 -----
 drivers/scsi/mvsas/mv_sas.c            | 20 ++++++++++----------
 drivers/scsi/pm8001/pm8001_hwi.c       |  4 ++--
 drivers/scsi/pm8001/pm8001_sas.c       | 18 +++++++++---------
 drivers/scsi/pm8001/pm8001_sas.h       | 10 +++-------
 include/scsi/libsas.h                  |  9 +++++++++
 11 files changed, 49 insertions(+), 56 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas.h b/drivers/scsi/hisi_sas/hisi_sas.h
index 15a58c955516..fe0c15bbfca9 100644
--- a/drivers/scsi/hisi_sas/hisi_sas.h
+++ b/drivers/scsi/hisi_sas/hisi_sas.h
@@ -234,13 +234,6 @@ struct hisi_sas_device {
 	spinlock_t lock; /* For protecting slots */
 };
 
-struct hisi_sas_tmf_task {
-	int force_phy;
-	int phy_id;
-	u8 tmf;
-	u16 tag_of_task_to_be_managed;
-};
-
 struct hisi_sas_slot {
 	struct list_head entry;
 	struct list_head delivery;
@@ -259,7 +252,7 @@ struct hisi_sas_slot {
 	dma_addr_t cmd_hdr_dma;
 	struct timer_list internal_abort_timer;
 	bool is_internal;
-	struct hisi_sas_tmf_task *tmf;
+	struct sas_tmf_task *tmf;
 	/* Do not reorder/change members after here */
 	void	*buf;
 	dma_addr_t buf_dma;
diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 5bacf849c36a..88e641143b82 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -11,7 +11,7 @@
 	((!dev) || (dev->dev_type == SAS_PHY_UNUSED))
 
 static int hisi_sas_debug_issue_ssp_tmf(struct domain_device *device,
-				u8 *lun, struct hisi_sas_tmf_task *tmf);
+				u8 *lun, struct sas_tmf_task *tmf);
 static int
 hisi_sas_internal_task_abort(struct hisi_hba *hisi_hba,
 			     struct domain_device *device,
@@ -464,7 +464,7 @@ void hisi_sas_task_deliver(struct hisi_hba *hisi_hba,
 }
 
 static int hisi_sas_task_exec(struct sas_task *task, gfp_t gfp_flags,
-			      struct hisi_sas_tmf_task *tmf)
+			      struct sas_tmf_task *tmf)
 {
 	int n_elem = 0, n_elem_dif = 0, n_elem_req = 0;
 	struct domain_device *device = task->dev;
@@ -672,7 +672,7 @@ static int hisi_sas_init_device(struct domain_device *device)
 {
 	int rc = TMF_RESP_FUNC_COMPLETE;
 	struct scsi_lun lun;
-	struct hisi_sas_tmf_task tmf_task;
+	struct sas_tmf_task tmf_task;
 	int retry = HISI_SAS_DISK_RECOVER_CNT;
 	struct hisi_hba *hisi_hba = dev_to_hisi_hba(device);
 	struct device *dev = hisi_hba->dev;
@@ -1236,7 +1236,7 @@ static void hisi_sas_tmf_timedout(struct timer_list *t)
 #define INTERNAL_ABORT_TIMEOUT		(6 * HZ)
 static int hisi_sas_exec_internal_tmf_task(struct domain_device *device,
 					   void *parameter, u32 para_len,
-					   struct hisi_sas_tmf_task *tmf)
+					   struct sas_tmf_task *tmf)
 {
 	struct hisi_sas_device *sas_dev = device->lldd_dev;
 	struct hisi_hba *hisi_hba = sas_dev->hisi_hba;
@@ -1371,7 +1371,7 @@ static int hisi_sas_softreset_ata_disk(struct domain_device *device)
 	struct hisi_hba *hisi_hba = dev_to_hisi_hba(device);
 	struct device *dev = hisi_hba->dev;
 	int s = sizeof(struct host_to_dev_fis);
-	struct hisi_sas_tmf_task tmf = {};
+	struct sas_tmf_task tmf = {};
 
 	ata_for_each_link(link, ap, EDGE) {
 		int pmp = sata_srst_pmp(link);
@@ -1405,7 +1405,7 @@ static int hisi_sas_softreset_ata_disk(struct domain_device *device)
 }
 
 static int hisi_sas_debug_issue_ssp_tmf(struct domain_device *device,
-				u8 *lun, struct hisi_sas_tmf_task *tmf)
+				u8 *lun, struct sas_tmf_task *tmf)
 {
 	struct sas_ssp_task ssp_task;
 
@@ -1512,7 +1512,7 @@ static void hisi_sas_send_ata_reset_each_phy(struct hisi_hba *hisi_hba,
 					     struct asd_sas_port *sas_port,
 					     struct domain_device *device)
 {
-	struct hisi_sas_tmf_task tmf_task = { .force_phy = 1 };
+	struct sas_tmf_task tmf_task = { .force_phy = 1 };
 	struct ata_port *ap = device->sata_dev.ap;
 	struct device *dev = hisi_hba->dev;
 	int s = sizeof(struct host_to_dev_fis);
@@ -1664,7 +1664,7 @@ static int hisi_sas_controller_reset(struct hisi_hba *hisi_hba)
 static int hisi_sas_abort_task(struct sas_task *task)
 {
 	struct scsi_lun lun;
-	struct hisi_sas_tmf_task tmf_task;
+	struct sas_tmf_task tmf_task;
 	struct domain_device *device = task->dev;
 	struct hisi_sas_device *sas_dev = device->lldd_dev;
 	struct hisi_hba *hisi_hba;
@@ -1773,7 +1773,7 @@ static int hisi_sas_abort_task_set(struct domain_device *device, u8 *lun)
 {
 	struct hisi_hba *hisi_hba = dev_to_hisi_hba(device);
 	struct device *dev = hisi_hba->dev;
-	struct hisi_sas_tmf_task tmf_task;
+	struct sas_tmf_task tmf_task;
 	int rc;
 
 	rc = hisi_sas_internal_task_abort(hisi_hba, device,
@@ -1924,7 +1924,7 @@ static int hisi_sas_lu_reset(struct domain_device *device, u8 *lun)
 			hisi_sas_release_task(hisi_hba, device);
 		sas_put_local_phy(phy);
 	} else {
-		struct hisi_sas_tmf_task tmf_task = { .tmf =  TMF_LU_RESET };
+		struct sas_tmf_task tmf_task = { .tmf =  TMF_LU_RESET };
 
 		rc = hisi_sas_debug_issue_ssp_tmf(device, lun, &tmf_task);
 		if (rc == TMF_RESP_FUNC_COMPLETE)
@@ -1982,7 +1982,7 @@ static int hisi_sas_clear_nexus_ha(struct sas_ha_struct *sas_ha)
 static int hisi_sas_query_task(struct sas_task *task)
 {
 	struct scsi_lun lun;
-	struct hisi_sas_tmf_task tmf_task;
+	struct sas_tmf_task tmf_task;
 	int rc = TMF_RESP_FUNC_FAILED;
 
 	if (task->lldd_task && task->task_proto & SAS_PROTOCOL_SSP) {
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
index 6914e992a02e..763888144aef 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
@@ -958,7 +958,7 @@ static void prep_ssp_v1_hw(struct hisi_hba *hisi_hba,
 	struct hisi_sas_port *port = slot->port;
 	struct sas_ssp_task *ssp_task = &task->ssp_task;
 	struct scsi_cmnd *scsi_cmnd = ssp_task->cmd;
-	struct hisi_sas_tmf_task *tmf = slot->tmf;
+	struct sas_tmf_task *tmf = slot->tmf;
 	int has_data = 0, priority = !!tmf;
 	u8 *buf_cmd, fburst = 0;
 	u32 dw1, dw2;
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index eaaf9e8b4ca4..5bab51dc21b3 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -1742,7 +1742,7 @@ static void prep_ssp_v2_hw(struct hisi_hba *hisi_hba,
 	struct hisi_sas_port *port = slot->port;
 	struct sas_ssp_task *ssp_task = &task->ssp_task;
 	struct scsi_cmnd *scsi_cmnd = ssp_task->cmd;
-	struct hisi_sas_tmf_task *tmf = slot->tmf;
+	struct sas_tmf_task *tmf = slot->tmf;
 	int has_data = 0, priority = !!tmf;
 	u8 *buf_cmd;
 	u32 dw1 = 0, dw2 = 0;
@@ -2491,7 +2491,7 @@ static void prep_ata_v2_hw(struct hisi_hba *hisi_hba,
 	struct hisi_sas_cmd_hdr *hdr = slot->cmd_hdr;
 	struct asd_sas_port *sas_port = device->port;
 	struct hisi_sas_port *port = to_hisi_sas_port(sas_port);
-	struct hisi_sas_tmf_task *tmf = slot->tmf;
+	struct sas_tmf_task *tmf = slot->tmf;
 	u8 *buf_cmd;
 	int has_data = 0, hdr_tag = 0;
 	u32 dw0, dw1 = 0, dw2 = 0;
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index e472068cc256..a57f247481ed 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -1219,7 +1219,7 @@ static void prep_ssp_v3_hw(struct hisi_hba *hisi_hba,
 	struct hisi_sas_port *port = slot->port;
 	struct sas_ssp_task *ssp_task = &task->ssp_task;
 	struct scsi_cmnd *scsi_cmnd = ssp_task->cmd;
-	struct hisi_sas_tmf_task *tmf = slot->tmf;
+	struct sas_tmf_task *tmf = slot->tmf;
 	int has_data = 0, priority = !!tmf;
 	unsigned char prot_op;
 	u8 *buf_cmd;
diff --git a/drivers/scsi/mvsas/mv_defs.h b/drivers/scsi/mvsas/mv_defs.h
index 199ab49aa047..7123a2efbf58 100644
--- a/drivers/scsi/mvsas/mv_defs.h
+++ b/drivers/scsi/mvsas/mv_defs.h
@@ -486,9 +486,4 @@ enum datapres_field {
 	SENSE_DATA	= 2,
 };
 
-/* define task management IU */
-struct mvs_tmf_task{
-	u8 tmf;
-	u16 tag_of_task_to_be_managed;
-};
 #endif
diff --git a/drivers/scsi/mvsas/mv_sas.c b/drivers/scsi/mvsas/mv_sas.c
index e9182333e077..53509996db9f 100644
--- a/drivers/scsi/mvsas/mv_sas.c
+++ b/drivers/scsi/mvsas/mv_sas.c
@@ -556,7 +556,7 @@ static int mvs_task_prep_ata(struct mvs_info *mvi,
 
 static int mvs_task_prep_ssp(struct mvs_info *mvi,
 			     struct mvs_task_exec_info *tei, int is_tmf,
-			     struct mvs_tmf_task *tmf)
+			     struct sas_tmf_task *tmf)
 {
 	struct sas_task *task = tei->task;
 	struct mvs_cmd_hdr *hdr = tei->hdr;
@@ -696,7 +696,7 @@ static int mvs_task_prep_ssp(struct mvs_info *mvi,
 
 #define	DEV_IS_GONE(mvi_dev)	((!mvi_dev || (mvi_dev->dev_type == SAS_PHY_UNUSED)))
 static int mvs_task_prep(struct sas_task *task, struct mvs_info *mvi, int is_tmf,
-				struct mvs_tmf_task *tmf, int *pass)
+				struct sas_tmf_task *tmf, int *pass)
 {
 	struct domain_device *dev = task->dev;
 	struct mvs_device *mvi_dev = dev->lldd_dev;
@@ -839,7 +839,7 @@ static int mvs_task_prep(struct sas_task *task, struct mvs_info *mvi, int is_tmf
 
 static int mvs_task_exec(struct sas_task *task, gfp_t gfp_flags,
 				struct completion *completion, int is_tmf,
-				struct mvs_tmf_task *tmf)
+				struct sas_tmf_task *tmf)
 {
 	struct mvs_info *mvi = NULL;
 	u32 rc = 0;
@@ -1277,7 +1277,7 @@ static void mvs_tmf_timedout(struct timer_list *t)
 
 #define MVS_TASK_TIMEOUT 20
 static int mvs_exec_internal_tmf_task(struct domain_device *dev,
-			void *parameter, u32 para_len, struct mvs_tmf_task *tmf)
+			void *parameter, u32 para_len, struct sas_tmf_task *tmf)
 {
 	int res, retry;
 	struct sas_task *task = NULL;
@@ -1352,7 +1352,7 @@ static int mvs_exec_internal_tmf_task(struct domain_device *dev,
 }
 
 static int mvs_debug_issue_ssp_tmf(struct domain_device *dev,
-				u8 *lun, struct mvs_tmf_task *tmf)
+				u8 *lun, struct sas_tmf_task *tmf)
 {
 	struct sas_ssp_task ssp_task;
 	if (!(dev->tproto & SAS_PROTOCOL_SSP))
@@ -1384,7 +1384,7 @@ int mvs_lu_reset(struct domain_device *dev, u8 *lun)
 {
 	unsigned long flags;
 	int rc = TMF_RESP_FUNC_FAILED;
-	struct mvs_tmf_task tmf_task;
+	struct sas_tmf_task tmf_task;
 	struct mvs_device * mvi_dev = dev->lldd_dev;
 	struct mvs_info *mvi = mvi_dev->mvi_info;
 
@@ -1428,7 +1428,7 @@ int mvs_query_task(struct sas_task *task)
 {
 	u32 tag;
 	struct scsi_lun lun;
-	struct mvs_tmf_task tmf_task;
+	struct sas_tmf_task tmf_task;
 	int rc = TMF_RESP_FUNC_FAILED;
 
 	if (task->lldd_task && task->task_proto & SAS_PROTOCOL_SSP) {
@@ -1465,7 +1465,7 @@ int mvs_query_task(struct sas_task *task)
 int mvs_abort_task(struct sas_task *task)
 {
 	struct scsi_lun lun;
-	struct mvs_tmf_task tmf_task;
+	struct sas_tmf_task tmf_task;
 	struct domain_device *dev = task->dev;
 	struct mvs_device *mvi_dev = (struct mvs_device *)dev->lldd_dev;
 	struct mvs_info *mvi;
@@ -1542,7 +1542,7 @@ int mvs_abort_task(struct sas_task *task)
 int mvs_abort_task_set(struct domain_device *dev, u8 *lun)
 {
 	int rc;
-	struct mvs_tmf_task tmf_task;
+	struct sas_tmf_task tmf_task;
 
 	tmf_task.tmf = TMF_ABORT_TASK_SET;
 	rc = mvs_debug_issue_ssp_tmf(dev, lun, &tmf_task);
@@ -1553,7 +1553,7 @@ int mvs_abort_task_set(struct domain_device *dev, u8 *lun)
 int mvs_clear_task_set(struct domain_device *dev, u8 *lun)
 {
 	int rc = TMF_RESP_FUNC_FAILED;
-	struct mvs_tmf_task tmf_task;
+	struct sas_tmf_task tmf_task;
 
 	tmf_task.tmf = TMF_CLEAR_TASK_SET;
 	rc = mvs_debug_issue_ssp_tmf(dev, lun, &tmf_task);
diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
index 4683fee87b84..575c6ecfdce3 100644
--- a/drivers/scsi/pm8001/pm8001_hwi.c
+++ b/drivers/scsi/pm8001/pm8001_hwi.c
@@ -4602,7 +4602,7 @@ int pm8001_chip_abort_task(struct pm8001_hba_info *pm8001_ha,
  * @tmf: task management function.
  */
 int pm8001_chip_ssp_tm_req(struct pm8001_hba_info *pm8001_ha,
-	struct pm8001_ccb_info *ccb, struct pm8001_tmf_task *tmf)
+	struct pm8001_ccb_info *ccb, struct sas_tmf_task *tmf)
 {
 	struct sas_task *task = ccb->task;
 	struct domain_device *dev = task->dev;
@@ -4614,7 +4614,7 @@ int pm8001_chip_ssp_tm_req(struct pm8001_hba_info *pm8001_ha,
 
 	memset(&sspTMCmd, 0, sizeof(sspTMCmd));
 	sspTMCmd.device_id = cpu_to_le32(pm8001_dev->device_id);
-	sspTMCmd.relate_tag = cpu_to_le32(tmf->tag_of_task_to_be_managed);
+	sspTMCmd.relate_tag = cpu_to_le32((u32)tmf->tag_of_task_to_be_managed);
 	sspTMCmd.tmf = cpu_to_le32(tmf->tmf);
 	memcpy(sspTMCmd.lun, task->ssp_task.LUN, 8);
 	sspTMCmd.tag = cpu_to_le32(ccb->ccb_tag);
diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
index bd3513e1882e..a93b7f0bb358 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -336,7 +336,7 @@ static int pm8001_task_prep_ata(struct pm8001_hba_info *pm8001_ha,
   * @tmf: the task management IU
   */
 static int pm8001_task_prep_ssp_tm(struct pm8001_hba_info *pm8001_ha,
-	struct pm8001_ccb_info *ccb, struct pm8001_tmf_task *tmf)
+	struct pm8001_ccb_info *ccb, struct sas_tmf_task *tmf)
 {
 	return PM8001_CHIP_DISP->ssp_tm_req(pm8001_ha, ccb, tmf);
 }
@@ -379,7 +379,7 @@ static int sas_find_local_port_id(struct domain_device *dev)
   * @tmf: the task management IU
   */
 static int pm8001_task_exec(struct sas_task *task,
-	gfp_t gfp_flags, int is_tmf, struct pm8001_tmf_task *tmf)
+	gfp_t gfp_flags, int is_tmf, struct sas_tmf_task *tmf)
 {
 	struct domain_device *dev = task->dev;
 	struct pm8001_hba_info *pm8001_ha;
@@ -728,7 +728,7 @@ static void pm8001_tmf_timedout(struct timer_list *t)
   * this function, note it is also with the task execute interface.
   */
 static int pm8001_exec_internal_tmf_task(struct domain_device *dev,
-	void *parameter, u32 para_len, struct pm8001_tmf_task *tmf)
+	void *parameter, u32 para_len, struct sas_tmf_task *tmf)
 {
 	int res, retry;
 	struct sas_task *task = NULL;
@@ -919,7 +919,7 @@ void pm8001_dev_gone(struct domain_device *dev)
 }
 
 static int pm8001_issue_ssp_tmf(struct domain_device *dev,
-	u8 *lun, struct pm8001_tmf_task *tmf)
+	u8 *lun, struct sas_tmf_task *tmf)
 {
 	struct sas_ssp_task ssp_task;
 	if (!(dev->tproto & SAS_PROTOCOL_SSP))
@@ -1120,7 +1120,7 @@ int pm8001_I_T_nexus_event_handler(struct domain_device *dev)
 int pm8001_lu_reset(struct domain_device *dev, u8 *lun)
 {
 	int rc = TMF_RESP_FUNC_FAILED;
-	struct pm8001_tmf_task tmf_task;
+	struct sas_tmf_task tmf_task;
 	struct pm8001_device *pm8001_dev = dev->lldd_dev;
 	struct pm8001_hba_info *pm8001_ha = pm8001_find_ha_by_dev(dev);
 	DECLARE_COMPLETION_ONSTACK(completion_setstate);
@@ -1149,7 +1149,7 @@ int pm8001_query_task(struct sas_task *task)
 {
 	u32 tag = 0xdeadbeef;
 	struct scsi_lun lun;
-	struct pm8001_tmf_task tmf_task;
+	struct sas_tmf_task tmf_task;
 	int rc = TMF_RESP_FUNC_FAILED;
 	if (unlikely(!task || !task->lldd_task || !task->dev))
 		return rc;
@@ -1198,7 +1198,7 @@ int pm8001_abort_task(struct sas_task *task)
 	struct pm8001_hba_info *pm8001_ha;
 	struct scsi_lun lun;
 	struct pm8001_device *pm8001_dev;
-	struct pm8001_tmf_task tmf_task;
+	struct sas_tmf_task tmf_task;
 	int rc = TMF_RESP_FUNC_FAILED, ret;
 	u32 phy_id, port_id;
 	struct sas_task_slow slow_task;
@@ -1352,7 +1352,7 @@ int pm8001_abort_task(struct sas_task *task)
 
 int pm8001_abort_task_set(struct domain_device *dev, u8 *lun)
 {
-	struct pm8001_tmf_task tmf_task;
+	struct sas_tmf_task tmf_task;
 
 	tmf_task.tmf = TMF_ABORT_TASK_SET;
 	return pm8001_issue_ssp_tmf(dev, lun, &tmf_task);
@@ -1360,7 +1360,7 @@ int pm8001_abort_task_set(struct domain_device *dev, u8 *lun)
 
 int pm8001_clear_task_set(struct domain_device *dev, u8 *lun)
 {
-	struct pm8001_tmf_task tmf_task;
+	struct sas_tmf_task tmf_task;
 	struct pm8001_device *pm8001_dev = dev->lldd_dev;
 	struct pm8001_hba_info *pm8001_ha = pm8001_find_ha_by_dev(dev);
 
diff --git a/drivers/scsi/pm8001/pm8001_sas.h b/drivers/scsi/pm8001/pm8001_sas.h
index 3ea53a0d0cc1..0b1086042ca6 100644
--- a/drivers/scsi/pm8001/pm8001_sas.h
+++ b/drivers/scsi/pm8001/pm8001_sas.h
@@ -99,11 +99,7 @@ extern const struct pm8001_dispatch pm8001_80xx_dispatch;
 struct pm8001_hba_info;
 struct pm8001_ccb_info;
 struct pm8001_device;
-/* define task management IU */
-struct pm8001_tmf_task {
-	u8	tmf;
-	u32	tag_of_task_to_be_managed;
-};
+
 struct pm8001_ioctl_payload {
 	u32	signature;
 	u16	major_function;
@@ -203,7 +199,7 @@ struct pm8001_dispatch {
 		struct pm8001_device *pm8001_dev, u8 flag, u32 task_tag,
 		u32 cmd_tag);
 	int (*ssp_tm_req)(struct pm8001_hba_info *pm8001_ha,
-		struct pm8001_ccb_info *ccb, struct pm8001_tmf_task *tmf);
+		struct pm8001_ccb_info *ccb, struct sas_tmf_task *tmf);
 	int (*get_nvmd_req)(struct pm8001_hba_info *pm8001_ha, void *payload);
 	int (*set_nvmd_req)(struct pm8001_hba_info *pm8001_ha, void *payload);
 	int (*fw_flash_update_req)(struct pm8001_hba_info *pm8001_ha,
@@ -687,7 +683,7 @@ int pm8001_chip_set_nvmd_req(struct pm8001_hba_info *pm8001_ha, void *payload);
 int pm8001_chip_get_nvmd_req(struct pm8001_hba_info *pm8001_ha, void *payload);
 int pm8001_chip_ssp_tm_req(struct pm8001_hba_info *pm8001_ha,
 				struct pm8001_ccb_info *ccb,
-				struct pm8001_tmf_task *tmf);
+				struct sas_tmf_task *tmf);
 int pm8001_chip_abort_task(struct pm8001_hba_info *pm8001_ha,
 				struct pm8001_device *pm8001_dev,
 				u8 flag, u32 task_tag, u32 cmd_tag);
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index cd2b2b67bf93..7a55853fad7b 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -576,6 +576,15 @@ struct sas_ssp_task {
 	struct scsi_cmnd *cmd;
 };
 
+struct sas_tmf_task {
+	u8 tmf;
+	u16 tag_of_task_to_be_managed;
+
+	/* Temp */
+	int force_phy;
+	int phy_id;
+};
+
 struct sas_task {
 	struct domain_device *dev;
 
-- 
2.26.2

