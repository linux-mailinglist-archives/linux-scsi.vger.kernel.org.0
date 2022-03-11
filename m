Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770564D618D
	for <lists+linux-scsi@lfdr.de>; Fri, 11 Mar 2022 13:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348573AbiCKMbF (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 11 Mar 2022 07:31:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348587AbiCKMbC (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 11 Mar 2022 07:31:02 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE2B1B3086;
        Fri, 11 Mar 2022 04:29:58 -0800 (PST)
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KFQFp5c3Cz687Dc;
        Fri, 11 Mar 2022 20:28:30 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Mar 2022 13:29:50 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Mar 2022 12:29:46 +0000
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <damien.lemoal@opensource.wdc.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Ajish.Koshy@microchip.com>, <linuxarm@huawei.com>,
        <Viswas.G@microchip.com>, <hch@lst.de>, <liuqi115@huawei.com>,
        <chenxiang66@hisilicon.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH v2 3/4] scsi: pm8001: Use libsas internal abort support
Date:   Fri, 11 Mar 2022 20:23:51 +0800
Message-ID: <1647001432-239276-4-git-send-email-john.garry@huawei.com>
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

New special handling is added for SAS_PROTOCOL_INTERNAL_ABORT proto so that
we may use the common queue command API.

Signed-off-by: John Garry <john.garry@huawei.com>
Tested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/scsi/pm8001/pm8001_hwi.c |  27 +++--
 drivers/scsi/pm8001/pm8001_hwi.h |   5 -
 drivers/scsi/pm8001/pm8001_sas.c | 178 ++++++++++---------------------
 drivers/scsi/pm8001/pm8001_sas.h |   6 +-
 drivers/scsi/pm8001/pm80xx_hwi.h |   5 -
 5 files changed, 74 insertions(+), 147 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
index 048ff41852c9..f7466a895d3b 100644
--- a/drivers/scsi/pm8001/pm8001_hwi.c
+++ b/drivers/scsi/pm8001/pm8001_hwi.c
@@ -4477,22 +4477,25 @@ pm8001_chip_isr(struct pm8001_hba_info *pm8001_ha, u8 vec)
 }
 
 static int send_task_abort(struct pm8001_hba_info *pm8001_ha, u32 opc,
-	u32 dev_id, u8 flag, u32 task_tag, u32 cmd_tag)
+	u32 dev_id, enum sas_internal_abort type, u32 task_tag, u32 cmd_tag)
 {
 	struct task_abort_req task_abort;
 
 	memset(&task_abort, 0, sizeof(task_abort));
-	if (ABORT_SINGLE == (flag & ABORT_MASK)) {
+	if (type == SAS_INTERNAL_ABORT_SINGLE) {
 		task_abort.abort_all = 0;
 		task_abort.device_id = cpu_to_le32(dev_id);
 		task_abort.tag_to_abort = cpu_to_le32(task_tag);
-		task_abort.tag = cpu_to_le32(cmd_tag);
-	} else if (ABORT_ALL == (flag & ABORT_MASK)) {
+	} else if (type == SAS_INTERNAL_ABORT_DEV) {
 		task_abort.abort_all = cpu_to_le32(1);
 		task_abort.device_id = cpu_to_le32(dev_id);
-		task_abort.tag = cpu_to_le32(cmd_tag);
+	} else {
+		pm8001_dbg(pm8001_ha, EH, "unknown type (%d)\n", type);
+		return -EIO;
 	}
 
+	task_abort.tag = cpu_to_le32(cmd_tag);
+
 	return pm8001_mpi_build_cmd(pm8001_ha, 0, opc, &task_abort,
 				    sizeof(task_abort), 0);
 }
@@ -4501,12 +4504,16 @@ static int send_task_abort(struct pm8001_hba_info *pm8001_ha, u32 opc,
  * pm8001_chip_abort_task - SAS abort task when error or exception happened.
  */
 int pm8001_chip_abort_task(struct pm8001_hba_info *pm8001_ha,
-	struct pm8001_device *pm8001_dev, u8 flag, u32 task_tag, u32 cmd_tag)
+	struct pm8001_ccb_info *ccb)
 {
-	u32 opc, device_id;
+	struct sas_task *task = ccb->task;
+	struct sas_internal_abort_task *abort = &task->abort_task;
+	struct pm8001_device *pm8001_dev = ccb->device;
 	int rc = TMF_RESP_FUNC_FAILED;
+	u32 opc, device_id;
+
 	pm8001_dbg(pm8001_ha, EH, "cmd_tag = %x, abort task tag = 0x%x\n",
-		   cmd_tag, task_tag);
+		   ccb->ccb_tag, abort->tag);
 	if (pm8001_dev->dev_type == SAS_END_DEVICE)
 		opc = OPC_INB_SSP_ABORT;
 	else if (pm8001_dev->dev_type == SAS_SATA_DEV)
@@ -4514,8 +4521,8 @@ int pm8001_chip_abort_task(struct pm8001_hba_info *pm8001_ha,
 	else
 		opc = OPC_INB_SMP_ABORT;/* SMP */
 	device_id = pm8001_dev->device_id;
-	rc = send_task_abort(pm8001_ha, opc, device_id, flag,
-		task_tag, cmd_tag);
+	rc = send_task_abort(pm8001_ha, opc, device_id, abort->type,
+			     abort->tag, ccb->ccb_tag);
 	if (rc != TMF_RESP_FUNC_COMPLETE)
 		pm8001_dbg(pm8001_ha, EH, "rc= %d\n", rc);
 	return rc;
diff --git a/drivers/scsi/pm8001/pm8001_hwi.h b/drivers/scsi/pm8001/pm8001_hwi.h
index d1f3aa93325b..961d0465b923 100644
--- a/drivers/scsi/pm8001/pm8001_hwi.h
+++ b/drivers/scsi/pm8001/pm8001_hwi.h
@@ -434,11 +434,6 @@ struct task_abort_req {
 	u32	reserved[11];
 } __attribute__((packed, aligned(4)));
 
-/* These flags used for SSP SMP & SATA Abort */
-#define ABORT_MASK		0x3
-#define ABORT_SINGLE		0x0
-#define ABORT_ALL		0x1
-
 /**
  * brief the data structure of SSP SATA SMP Abort Response
  * use to describe SSP SMP & SATA Abort Response ( 64 bytes)
diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
index ac9c40c95070..3a863d776724 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -324,6 +324,18 @@ static int pm8001_task_prep_ata(struct pm8001_hba_info *pm8001_ha,
 	return PM8001_CHIP_DISP->sata_req(pm8001_ha, ccb);
 }
 
+/**
+  * pm8001_task_prep_internal_abort - the dispatcher function, prepare data
+  *				      for internal abort task
+  * @pm8001_ha: our hba card information
+  * @ccb: the ccb which attached to sata task
+  */
+static int pm8001_task_prep_internal_abort(struct pm8001_hba_info *pm8001_ha,
+					   struct pm8001_ccb_info *ccb)
+{
+	return PM8001_CHIP_DISP->task_abort(pm8001_ha, ccb);
+}
+
 /**
   * pm8001_task_prep_ssp_tm - the dispatcher function, prepare task management data
   * @pm8001_ha: our hba card information
@@ -367,6 +379,35 @@ static int sas_find_local_port_id(struct domain_device *dev)
 #define DEV_IS_GONE(pm8001_dev)	\
 	((!pm8001_dev || (pm8001_dev->dev_type == SAS_PHY_UNUSED)))
 
+
+static int pm8001_deliver_command(struct pm8001_hba_info *pm8001_ha,
+				  struct pm8001_ccb_info *ccb)
+{
+	struct sas_task *task = ccb->task;
+	enum sas_protocol task_proto = task->task_proto;
+	struct sas_tmf_task *tmf = task->tmf;
+	int is_tmf = !!tmf;
+
+	switch (task_proto) {
+	case SAS_PROTOCOL_SMP:
+		return pm8001_task_prep_smp(pm8001_ha, ccb);
+	case SAS_PROTOCOL_SSP:
+		if (is_tmf)
+			return pm8001_task_prep_ssp_tm(pm8001_ha, ccb, tmf);
+		return pm8001_task_prep_ssp(pm8001_ha, ccb);
+	case SAS_PROTOCOL_SATA:
+	case SAS_PROTOCOL_STP:
+		return pm8001_task_prep_ata(pm8001_ha, ccb);
+	case SAS_PROTOCOL_INTERNAL_ABORT:
+		return pm8001_task_prep_internal_abort(pm8001_ha, ccb);
+	default:
+		dev_err(pm8001_ha->dev, "unknown sas_task proto: 0x%x\n",
+			task_proto);
+	}
+
+	return -EINVAL;
+}
+
 /**
   * pm8001_queue_command - register for upper layer used, all IO commands sent
   * to HBA are from this interface.
@@ -379,16 +420,15 @@ int pm8001_queue_command(struct sas_task *task, gfp_t gfp_flags)
 	enum sas_protocol task_proto = task->task_proto;
 	struct domain_device *dev = task->dev;
 	struct pm8001_device *pm8001_dev = dev->lldd_dev;
+	bool internal_abort = sas_is_internal_abort(task);
 	struct pm8001_hba_info *pm8001_ha;
 	struct pm8001_port *port = NULL;
 	struct pm8001_ccb_info *ccb;
-	struct sas_tmf_task *tmf = task->tmf;
-	int is_tmf = !!task->tmf;
 	unsigned long flags;
 	u32 n_elem = 0;
 	int rc = 0;
 
-	if (!dev->port) {
+	if (!internal_abort && !dev->port) {
 		ts->resp = SAS_TASK_UNDELIVERED;
 		ts->stat = SAS_PHY_DOWN;
 		if (dev->dev_type != SAS_SATA_DEV)
@@ -410,7 +450,8 @@ int pm8001_queue_command(struct sas_task *task, gfp_t gfp_flags)
 	pm8001_dev = dev->lldd_dev;
 	port = &pm8001_ha->port[sas_find_local_port_id(dev)];
 
-	if (DEV_IS_GONE(pm8001_dev) || !port->port_attached) {
+	if (!internal_abort &&
+	    (DEV_IS_GONE(pm8001_dev) || !port->port_attached)) {
 		ts->resp = SAS_TASK_UNDELIVERED;
 		ts->stat = SAS_PHY_DOWN;
 		if (sas_protocol_ata(task_proto)) {
@@ -448,27 +489,7 @@ int pm8001_queue_command(struct sas_task *task, gfp_t gfp_flags)
 
 	atomic_inc(&pm8001_dev->running_req);
 
-	switch (task_proto) {
-	case SAS_PROTOCOL_SMP:
-		rc = pm8001_task_prep_smp(pm8001_ha, ccb);
-		break;
-	case SAS_PROTOCOL_SSP:
-		if (is_tmf)
-			rc = pm8001_task_prep_ssp_tm(pm8001_ha, ccb, tmf);
-		else
-			rc = pm8001_task_prep_ssp(pm8001_ha, ccb);
-		break;
-	case SAS_PROTOCOL_SATA:
-	case SAS_PROTOCOL_STP:
-		rc = pm8001_task_prep_ata(pm8001_ha, ccb);
-		break;
-	default:
-		dev_printk(KERN_ERR, pm8001_ha->dev,
-			   "unknown sas_task proto: 0x%x\n", task_proto);
-		rc = -EINVAL;
-		break;
-	}
-
+	rc = pm8001_deliver_command(pm8001_ha, ccb);
 	if (rc) {
 		atomic_dec(&pm8001_dev->running_req);
 		if (!sas_protocol_ata(task_proto) && n_elem)
@@ -668,87 +689,7 @@ void pm8001_task_done(struct sas_task *task)
 	complete(&task->slow_task->completion);
 }
 
-static void pm8001_tmf_timedout(struct timer_list *t)
-{
-	struct sas_task_slow *slow = from_timer(slow, t, timer);
-	struct sas_task *task = slow->task;
-	unsigned long flags;
-
-	spin_lock_irqsave(&task->task_state_lock, flags);
-	if (!(task->task_state_flags & SAS_TASK_STATE_DONE)) {
-		task->task_state_flags |= SAS_TASK_STATE_ABORTED;
-		complete(&task->slow_task->completion);
-	}
-	spin_unlock_irqrestore(&task->task_state_lock, flags);
-}
-
 #define PM8001_TASK_TIMEOUT 20
-static int
-pm8001_exec_internal_task_abort(struct pm8001_hba_info *pm8001_ha,
-	struct pm8001_device *pm8001_dev, struct domain_device *dev, u32 flag,
-	u32 task_tag)
-{
-	int res, retry;
-	struct pm8001_ccb_info *ccb;
-	struct sas_task *task = NULL;
-
-	for (retry = 0; retry < 3; retry++) {
-		task = sas_alloc_slow_task(GFP_KERNEL);
-		if (!task)
-			return -ENOMEM;
-
-		task->dev = dev;
-		task->task_proto = dev->tproto;
-		task->task_done = pm8001_task_done;
-		task->slow_task->timer.function = pm8001_tmf_timedout;
-		task->slow_task->timer.expires =
-			jiffies + PM8001_TASK_TIMEOUT * HZ;
-		add_timer(&task->slow_task->timer);
-
-		ccb = pm8001_ccb_alloc(pm8001_ha, pm8001_dev, task);
-		if (!ccb) {
-			res = -SAS_QUEUE_FULL;
-			break;
-		}
-
-		res = PM8001_CHIP_DISP->task_abort(pm8001_ha, pm8001_dev, flag,
-						   task_tag, ccb->ccb_tag);
-		if (res) {
-			del_timer(&task->slow_task->timer);
-			pm8001_dbg(pm8001_ha, FAIL,
-				   "Executing internal task failed\n");
-			pm8001_ccb_free(pm8001_ha, ccb);
-			break;
-		}
-
-		wait_for_completion(&task->slow_task->completion);
-		res = TMF_RESP_FUNC_FAILED;
-
-		/* Even TMF timed out, return direct. */
-		if (task->task_state_flags & SAS_TASK_STATE_ABORTED) {
-			pm8001_dbg(pm8001_ha, FAIL, "TMF task timeout.\n");
-			break;
-		}
-
-		if (task->task_status.resp == SAS_TASK_COMPLETE &&
-			task->task_status.stat == SAS_SAM_STAT_GOOD) {
-			res = TMF_RESP_FUNC_COMPLETE;
-			break;
-		}
-
-		pm8001_dbg(pm8001_ha, EH,
-			   " Task to dev %016llx response: 0x%x status 0x%x\n",
-			   SAS_ADDR(dev->sas_addr),
-			   task->task_status.resp,
-			   task->task_status.stat);
-		sas_free_task(task);
-		task = NULL;
-	}
-
-	BUG_ON(retry == 3 && task != NULL);
-	sas_free_task(task);
-	return res;
-}
 
 /**
   * pm8001_dev_gone_notify - see the comments for "pm8001_dev_found_notify"
@@ -769,8 +710,7 @@ static void pm8001_dev_gone_notify(struct domain_device *dev)
 			   pm8001_dev->device_id, pm8001_dev->dev_type);
 		if (atomic_read(&pm8001_dev->running_req)) {
 			spin_unlock_irqrestore(&pm8001_ha->lock, flags);
-			pm8001_exec_internal_task_abort(pm8001_ha, pm8001_dev,
-							dev, 1, 0);
+			sas_execute_internal_abort_dev(dev, 0, NULL);
 			while (atomic_read(&pm8001_dev->running_req))
 				msleep(20);
 			spin_lock_irqsave(&pm8001_ha->lock, flags);
@@ -893,8 +833,7 @@ int pm8001_I_T_nexus_reset(struct domain_device *dev)
 			goto out;
 		}
 		msleep(2000);
-		rc = pm8001_exec_internal_task_abort(pm8001_ha, pm8001_dev,
-						     dev, 1, 0);
+		rc = sas_execute_internal_abort_dev(dev, 0, NULL);
 		if (rc) {
 			pm8001_dbg(pm8001_ha, EH, "task abort failed %x\n"
 				   "with rc %d\n", pm8001_dev->device_id, rc);
@@ -939,8 +878,7 @@ int pm8001_I_T_nexus_event_handler(struct domain_device *dev)
 			goto out;
 		}
 		/* send internal ssp/sata/smp abort command to FW */
-		rc = pm8001_exec_internal_task_abort(pm8001_ha, pm8001_dev,
-						     dev, 1, 0);
+		sas_execute_internal_abort_dev(dev, 0, NULL);
 		msleep(100);
 
 		/* deregister the target device */
@@ -955,8 +893,7 @@ int pm8001_I_T_nexus_event_handler(struct domain_device *dev)
 		wait_for_completion(&completion_setstate);
 	} else {
 		/* send internal ssp/sata/smp abort command to FW */
-		rc = pm8001_exec_internal_task_abort(pm8001_ha, pm8001_dev,
-						     dev, 1, 0);
+		sas_execute_internal_abort_dev(dev, 0, NULL);
 		msleep(100);
 
 		/* deregister the target device */
@@ -983,8 +920,7 @@ int pm8001_lu_reset(struct domain_device *dev, u8 *lun)
 	DECLARE_COMPLETION_ONSTACK(completion_setstate);
 	if (dev_is_sata(dev)) {
 		struct sas_phy *phy = sas_get_local_phy(dev);
-		rc = pm8001_exec_internal_task_abort(pm8001_ha, pm8001_dev,
-						     dev, 1, 0);
+		sas_execute_internal_abort_dev(dev, 0, NULL);
 		rc = sas_phy_reset(phy, 1);
 		sas_put_local_phy(phy);
 		pm8001_dev->setds_completion = &completion_setstate;
@@ -1084,8 +1020,7 @@ int pm8001_abort_task(struct sas_task *task)
 	spin_unlock_irqrestore(&task->task_state_lock, flags);
 	if (task->task_proto & SAS_PROTOCOL_SSP) {
 		rc = sas_abort_task(task, tag);
-		pm8001_exec_internal_task_abort(pm8001_ha, pm8001_dev,
-			pm8001_dev->sas_device, 0, tag);
+		sas_execute_internal_abort_single(dev, tag, 0, NULL);
 	} else if (task->task_proto & SAS_PROTOCOL_SATA ||
 		task->task_proto & SAS_PROTOCOL_STP) {
 		if (pm8001_ha->chip_id == chip_8006) {
@@ -1158,8 +1093,7 @@ int pm8001_abort_task(struct sas_task *task)
 			 * is removed from the ccb. on success the caller is
 			 * going to free the task.
 			 */
-			ret = pm8001_exec_internal_task_abort(pm8001_ha,
-				pm8001_dev, pm8001_dev->sas_device, 1, tag);
+			ret = sas_execute_internal_abort_dev(dev, 0, NULL);
 			if (ret)
 				goto out;
 			ret = wait_for_completion_timeout(
@@ -1175,14 +1109,12 @@ int pm8001_abort_task(struct sas_task *task)
 				pm8001_dev, DS_OPERATIONAL);
 			wait_for_completion(&completion);
 		} else {
-			rc = pm8001_exec_internal_task_abort(pm8001_ha,
-				pm8001_dev, pm8001_dev->sas_device, 0, tag);
+			ret = sas_execute_internal_abort_single(dev, tag, 0, NULL);
 		}
 		rc = TMF_RESP_FUNC_COMPLETE;
 	} else if (task->task_proto & SAS_PROTOCOL_SMP) {
 		/* SMP */
-		rc = pm8001_exec_internal_task_abort(pm8001_ha, pm8001_dev,
-			pm8001_dev->sas_device, 0, tag);
+		rc = sas_execute_internal_abort_single(dev, tag, 0, NULL);
 
 	}
 out:
diff --git a/drivers/scsi/pm8001/pm8001_sas.h b/drivers/scsi/pm8001/pm8001_sas.h
index d522bd0bb46b..060ab680a7ed 100644
--- a/drivers/scsi/pm8001/pm8001_sas.h
+++ b/drivers/scsi/pm8001/pm8001_sas.h
@@ -196,8 +196,7 @@ struct pm8001_dispatch {
 	int (*phy_ctl_req)(struct pm8001_hba_info *pm8001_ha,
 		u32 phy_id, u32 phy_op);
 	int (*task_abort)(struct pm8001_hba_info *pm8001_ha,
-		struct pm8001_device *pm8001_dev, u8 flag, u32 task_tag,
-		u32 cmd_tag);
+		struct pm8001_ccb_info *ccb);
 	int (*ssp_tm_req)(struct pm8001_hba_info *pm8001_ha,
 		struct pm8001_ccb_info *ccb, struct sas_tmf_task *tmf);
 	int (*get_nvmd_req)(struct pm8001_hba_info *pm8001_ha, void *payload);
@@ -683,8 +682,7 @@ int pm8001_chip_ssp_tm_req(struct pm8001_hba_info *pm8001_ha,
 				struct pm8001_ccb_info *ccb,
 				struct sas_tmf_task *tmf);
 int pm8001_chip_abort_task(struct pm8001_hba_info *pm8001_ha,
-				struct pm8001_device *pm8001_dev,
-				u8 flag, u32 task_tag, u32 cmd_tag);
+				struct pm8001_ccb_info *ccb);
 int pm8001_chip_dereg_dev_req(struct pm8001_hba_info *pm8001_ha, u32 device_id);
 void pm8001_chip_make_sg(struct scatterlist *scatter, int nr, void *prd);
 void pm8001_work_fn(struct work_struct *work);
diff --git a/drivers/scsi/pm8001/pm80xx_hwi.h b/drivers/scsi/pm8001/pm80xx_hwi.h
index b9d9d113809b..acf6e3005b84 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.h
+++ b/drivers/scsi/pm8001/pm80xx_hwi.h
@@ -672,11 +672,6 @@ struct task_abort_req {
 	u32	reserved[27];
 } __attribute__((packed, aligned(4)));
 
-/* These flags used for SSP SMP & SATA Abort */
-#define ABORT_MASK		0x3
-#define ABORT_SINGLE		0x0
-#define ABORT_ALL		0x1
-
 /**
  * brief the data structure of SSP SATA SMP Abort Response
  * use to describe SSP SMP & SATA Abort Response ( 64 bytes)
-- 
2.26.2

