Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F59D1BF92B
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Apr 2020 15:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgD3NUT (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 30 Apr 2020 09:20:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:60756 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726955AbgD3NUL (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 30 Apr 2020 09:20:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 95B0AAF69;
        Thu, 30 Apr 2020 13:20:02 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        John Garry <john.garry@huawei.com>,
        Ming Lei <ming.lei@redhat.com>,
        Bart van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH RFC v3 32/41] pm8001: kill pm8001_issue_ssp_tmf()
Date:   Thu, 30 Apr 2020 15:18:55 +0200
Message-Id: <20200430131904.5847-33-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200430131904.5847-1-hare@suse.de>
References: <20200430131904.5847-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Just a wrapper around pm8001_exec_internal_tmf_task(), so call it
directly and kill the wrapper.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/pm8001/pm8001_sas.c | 42 ++++++++++++++++------------------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
index b7cbc312843e..eb645e4a5940 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -700,16 +700,15 @@ static void pm8001_tmf_timedout(struct timer_list *t)
 /**
   * pm8001_exec_internal_tmf_task - execute some task management commands.
   * @dev: the wanted device.
+  * @lun: the logical unit number of the device
   * @tmf: which task management wanted to be take.
-  * @para_len: para_len.
-  * @parameter: ssp task parameter.
   *
   * when errors or exception happened, we may want to do something, for example
   * abort the issued task which result in this execption, it is done by calling
   * this function, note it is also with the task execute interface.
   */
 static int pm8001_exec_internal_tmf_task(struct domain_device *dev,
-	void *parameter, u32 para_len, struct pm8001_tmf_task *tmf)
+	u8 *lun, struct pm8001_tmf_task *tmf)
 {
 	int res, retry;
 	struct sas_task *task = NULL;
@@ -717,6 +716,9 @@ static int pm8001_exec_internal_tmf_task(struct domain_device *dev,
 	struct pm8001_device *pm8001_dev = dev->lldd_dev;
 	DECLARE_COMPLETION_ONSTACK(completion_setstate);
 
+	if (!(dev->tproto & SAS_PROTOCOL_SSP))
+		return TMF_RESP_FUNC_ESUPP;
+
 	for (retry = 0; retry < 3; retry++) {
 		task = sas_alloc_slow_task(GFP_KERNEL);
 		if (!task)
@@ -724,7 +726,7 @@ static int pm8001_exec_internal_tmf_task(struct domain_device *dev,
 
 		task->dev = dev;
 		task->task_proto = dev->tproto;
-		memcpy(&task->ssp_task, parameter, para_len);
+		memcpy(task->ssp_task.LUN, lun, 8);
 		task->task_done = pm8001_task_done;
 		task->slow_task->timer.function = pm8001_tmf_timedout;
 		task->slow_task->timer.expires = jiffies + PM8001_TASK_TIMEOUT*HZ;
@@ -909,18 +911,6 @@ void pm8001_dev_gone(struct domain_device *dev)
 	pm8001_dev_gone_notify(dev);
 }
 
-static int pm8001_issue_ssp_tmf(struct domain_device *dev,
-	u8 *lun, struct pm8001_tmf_task *tmf)
-{
-	struct sas_ssp_task ssp_task;
-	if (!(dev->tproto & SAS_PROTOCOL_SSP))
-		return TMF_RESP_FUNC_ESUPP;
-
-	strncpy((u8 *)&ssp_task.LUN, lun, 8);
-	return pm8001_exec_internal_tmf_task(dev, &ssp_task, sizeof(ssp_task),
-		tmf);
-}
-
 /* retry commands by ha, by task and/or by device */
 void pm8001_open_reject_retry(
 	struct pm8001_hba_info *pm8001_ha,
@@ -1127,7 +1117,7 @@ int pm8001_lu_reset(struct domain_device *dev, u8 *lun)
 		wait_for_completion(&completion_setstate);
 	} else {
 		tmf_task.tmf = TMF_LU_RESET;
-		rc = pm8001_issue_ssp_tmf(dev, lun, &tmf_task);
+		rc = pm8001_exec_internal_tmf_task(dev, lun, &tmf_task);
 	}
 	/* If failed, fall-through I_T_Nexus reset */
 	PM8001_EH_DBG(pm8001_ha, pm8001_printk("for device[%x]:rc=%d\n",
@@ -1162,10 +1152,10 @@ int pm8001_query_task(struct sas_task *task)
 		for (i = 0; i < 16; i++)
 			printk(KERN_INFO "%02x ", cmnd->cmnd[i]);
 		printk(KERN_INFO "]\n");
-		tmf_task.tmf = 	TMF_QUERY_TASK;
+		tmf_task.tmf = TMF_QUERY_TASK;
 		tmf_task.tag_of_task_to_be_managed = tag;
 
-		rc = pm8001_issue_ssp_tmf(dev, lun.scsi_lun, &tmf_task);
+		rc = pm8001_exec_internal_tmf_task(dev, lun.scsi_lun, &tmf_task);
 		switch (rc) {
 		/* The task is still in Lun, release it then */
 		case TMF_RESP_FUNC_SUCC:
@@ -1225,9 +1215,11 @@ int pm8001_abort_task(struct sas_task *task)
 		int_to_scsilun(cmnd->device->lun, &lun);
 		tmf_task.tmf = TMF_ABORT_TASK;
 		tmf_task.tag_of_task_to_be_managed = tag;
-		rc = pm8001_issue_ssp_tmf(dev, lun.scsi_lun, &tmf_task);
-		pm8001_exec_internal_task_abort(pm8001_ha, pm8001_dev,
-			pm8001_dev->sas_device, 0, tag);
+		rc = pm8001_exec_internal_tmf_task(dev, lun.scsi_lun,
+						   &tmf_task);
+		if (rc == TMF_RESP_FUNC_SUCC)
+			pm8001_exec_internal_task_abort(pm8001_ha, pm8001_dev,
+				pm8001_dev->sas_device, 0, tag);
 	} else if (task->task_proto & SAS_PROTOCOL_SATA ||
 		task->task_proto & SAS_PROTOCOL_STP) {
 		if (pm8001_ha->chip_id == chip_8006) {
@@ -1337,7 +1329,7 @@ int pm8001_abort_task_set(struct domain_device *dev, u8 *lun)
 	struct pm8001_tmf_task tmf_task;
 
 	tmf_task.tmf = TMF_ABORT_TASK_SET;
-	return pm8001_issue_ssp_tmf(dev, lun, &tmf_task);
+	return pm8001_exec_internal_tmf_task(dev, lun, &tmf_task);
 }
 
 int pm8001_clear_aca(struct domain_device *dev, u8 *lun)
@@ -1345,7 +1337,7 @@ int pm8001_clear_aca(struct domain_device *dev, u8 *lun)
 	struct pm8001_tmf_task tmf_task;
 
 	tmf_task.tmf = TMF_CLEAR_ACA;
-	return pm8001_issue_ssp_tmf(dev, lun, &tmf_task);
+	return pm8001_exec_internal_tmf_task(dev, lun, &tmf_task);
 }
 
 int pm8001_clear_task_set(struct domain_device *dev, u8 *lun)
@@ -1358,6 +1350,6 @@ int pm8001_clear_task_set(struct domain_device *dev, u8 *lun)
 		pm8001_printk("I_T_L_Q clear task set[%x]\n",
 		pm8001_dev->device_id));
 	tmf_task.tmf = TMF_CLEAR_TASK_SET;
-	return pm8001_issue_ssp_tmf(dev, lun, &tmf_task);
+	return pm8001_exec_internal_tmf_task(dev, lun, &tmf_task);
 }
 
-- 
2.16.4

