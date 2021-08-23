Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBCA73F45C5
	for <lists+linux-scsi@lfdr.de>; Mon, 23 Aug 2021 09:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbhHWH3X (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 23 Aug 2021 03:29:23 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:17842 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234993AbhHWH3U (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 23 Aug 2021 03:29:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1629703717; x=1661239717;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JpjFyvi7ueIYRcYhT3/kIy/XI6x99FFgQRCJqdXMxgM=;
  b=t+DjdvJo+Y5lgPtf5DuPTt+xZhuwagtwvGpAf7D1AgGez5xnffzsv2eu
   ZY7DlpT5TH67iE7r8AlW4eiy1JSD7WR6vZEea+14Ux5ZDasPFQp8vZz2L
   RpRfFOL/1CZIbyTwy6Q5jdA86lxONXLLakyH+7+cdq5pgmLjBb1RbW2gM
   ztPxsmZ9CcuRz97Qa31KyZO5Ck3ha9zfSr9HVl9eJ+tCV/OQonEVzv9PH
   q4gFrEBGIs1y8/ycSrAx9FR/dP1J+6XNEu7z7OMt7L3Qpv6Vbvk6rF5PS
   DwiiIxhqymenRwMp995scfGZ5Qqv2Oj0gZ73+dWr7DE2slB0IEFvyLnd/
   g==;
IronPort-SDR: umNEFenqyuN4AIyOAiZ5vNFv4pau9GXtfK75l4GnLAh01TU/CcxuzQkhjSAVv1j3gBKv5+Y4Hn
 rVQYxB7HcmVNzA/QqceESoTlxOxwU3rRHZ4LGwRLD7zpRXZZE1hUp8rreg4plR88I/CTZhGXPL
 3IJRmbRydIdEb+ZtwQllB/6aH+Sky8fnMH9iewyifUiD6csdodD0D8RU+uZPAjUHyQ9CuNXi2T
 UV7+j6TUVu8DFQE9RYa2wYihx3lq9YLjAvsBLTZQ/pLR7NIAe1QcMfpPkJuj6MQXRihXoWGGDf
 3vgDNP3ysmbzbYFPA+sPl/dq
X-IronPort-AV: E=Sophos;i="5.84,343,1620716400"; 
   d="scan'208";a="141156979"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Aug 2021 00:28:37 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 23 Aug 2021 00:28:37 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Mon, 23 Aug 2021 00:28:37 -0700
From:   Ajish Koshy <Ajish.Koshy@microchip.com>
To:     <linux-scsi@vger.kernel.org>
CC:     <Vasanthalakshmi.Tharmarajan@microchip.com>,
        <Viswas.G@microchip.com>, <Ruksar.devadi@microchip.com>,
        <Ashokkumar.N@microchip.com>,
        Jinpu Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCH 2/4] scsi: pm80xx: fix lockup due to commit <1f02beff224e>
Date:   Mon, 23 Aug 2021 13:53:36 +0530
Message-ID: <20210823082338.67309-3-Ajish.Koshy@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210823082338.67309-1-Ajish.Koshy@microchip.com>
References: <20210823082338.67309-1-Ajish.Koshy@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Upstream commit <1f02beff224e> introduced a lock per outbound
queue, where the driver before that was using a global lock
for all outbound queues. While processing the IO responses
and events, driver takes the outbound queue spinlock and
later it is supposed to release the same spin lock in
pm8001_ccb_task_free_done() before calling command done().
Since the older code was using a global lock,
pm8001_ccb_task_free_done() was also releasing the global
spin lock. With the commit <1f02beff224e>,
pm8001_ccb_task_free_done() remains the same and it was
still using the global lock.

So when driver completes a SATA command,the global spinlock
will be in a locked state.
mpi_sata_completion()->spin_lock(&pm8001_ha->lock);

Later when driver gets a scsi command for SATA drive,
pm8001_task_exec() tries to acquire the global lock and leads
to lockup crash.

Signed-off-by: Ajish Koshy <Ajish.Koshy@microchip.com>
Signed-off-by: Viswas G <Viswas.G@microchip.com>
---
 drivers/scsi/pm8001/pm8001_sas.h |  3 +-
 drivers/scsi/pm8001/pm80xx_hwi.c | 53 ++++++++++++++++++++++++++------
 2 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_sas.h b/drivers/scsi/pm8001/pm8001_sas.h
index 1a016a421280..3274d88a9ccc 100644
--- a/drivers/scsi/pm8001/pm8001_sas.h
+++ b/drivers/scsi/pm8001/pm8001_sas.h
@@ -458,6 +458,7 @@ struct outbound_queue_table {
 	__le32			producer_index;
 	u32			consumer_idx;
 	spinlock_t		oq_lock;
+	unsigned long		lock_flags;
 };
 struct pm8001_hba_memspace {
 	void __iomem  		*memvirtaddr;
@@ -740,9 +741,7 @@ pm8001_ccb_task_free_done(struct pm8001_hba_info *pm8001_ha,
 {
 	pm8001_ccb_task_free(pm8001_ha, task, ccb, ccb_idx);
 	smp_mb(); /*in order to force CPU ordering*/
-	spin_unlock(&pm8001_ha->lock);
 	task->task_done(task);
-	spin_lock(&pm8001_ha->lock);
 }
 
 #endif
diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index cec932f830b8..1ae2f5c6042c 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -2379,7 +2379,8 @@ static void mpi_ssp_event(struct pm8001_hba_info *pm8001_ha, void *piomb)
 
 /*See the comments for mpi_ssp_completion */
 static void
-mpi_sata_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
+mpi_sata_completion(struct pm8001_hba_info *pm8001_ha,
+		struct outbound_queue_table *circularQ, void *piomb)
 {
 	struct sas_task *t;
 	struct pm8001_ccb_info *ccb;
@@ -2616,7 +2617,11 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
 				IO_OPEN_CNX_ERROR_IT_NEXUS_LOSS);
 			ts->resp = SAS_TASK_UNDELIVERED;
 			ts->stat = SAS_QUEUE_FULL;
+			spin_unlock_irqrestore(&circularQ->oq_lock,
+					circularQ->lock_flags);
 			pm8001_ccb_task_free_done(pm8001_ha, t, ccb, tag);
+			spin_lock_irqsave(&circularQ->oq_lock,
+					circularQ->lock_flags);
 			return;
 		}
 		break;
@@ -2632,7 +2637,11 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
 				IO_OPEN_CNX_ERROR_IT_NEXUS_LOSS);
 			ts->resp = SAS_TASK_UNDELIVERED;
 			ts->stat = SAS_QUEUE_FULL;
+			spin_unlock_irqrestore(&circularQ->oq_lock,
+					circularQ->lock_flags);
 			pm8001_ccb_task_free_done(pm8001_ha, t, ccb, tag);
+			spin_lock_irqsave(&circularQ->oq_lock,
+					circularQ->lock_flags);
 			return;
 		}
 		break;
@@ -2656,7 +2665,11 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
 				IO_OPEN_CNX_ERROR_STP_RESOURCES_BUSY);
 			ts->resp = SAS_TASK_UNDELIVERED;
 			ts->stat = SAS_QUEUE_FULL;
+			spin_unlock_irqrestore(&circularQ->oq_lock,
+					circularQ->lock_flags);
 			pm8001_ccb_task_free_done(pm8001_ha, t, ccb, tag);
+			spin_lock_irqsave(&circularQ->oq_lock,
+					circularQ->lock_flags);
 			return;
 		}
 		break;
@@ -2727,7 +2740,11 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
 					IO_DS_NON_OPERATIONAL);
 			ts->resp = SAS_TASK_UNDELIVERED;
 			ts->stat = SAS_QUEUE_FULL;
+			spin_unlock_irqrestore(&circularQ->oq_lock,
+					circularQ->lock_flags);
 			pm8001_ccb_task_free_done(pm8001_ha, t, ccb, tag);
+			spin_lock_irqsave(&circularQ->oq_lock,
+					circularQ->lock_flags);
 			return;
 		}
 		break;
@@ -2747,7 +2764,11 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
 					IO_DS_IN_ERROR);
 			ts->resp = SAS_TASK_UNDELIVERED;
 			ts->stat = SAS_QUEUE_FULL;
+			spin_unlock_irqrestore(&circularQ->oq_lock,
+					circularQ->lock_flags);
 			pm8001_ccb_task_free_done(pm8001_ha, t, ccb, tag);
+			spin_lock_irqsave(&circularQ->oq_lock,
+					circularQ->lock_flags);
 			return;
 		}
 		break;
@@ -2785,12 +2806,17 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
 		pm8001_ccb_task_free(pm8001_ha, t, ccb, tag);
 	} else {
 		spin_unlock_irqrestore(&t->task_state_lock, flags);
+		spin_unlock_irqrestore(&circularQ->oq_lock,
+				circularQ->lock_flags);
 		pm8001_ccb_task_free_done(pm8001_ha, t, ccb, tag);
+		spin_lock_irqsave(&circularQ->oq_lock,
+				circularQ->lock_flags);
 	}
 }
 
 /*See the comments for mpi_ssp_completion */
-static void mpi_sata_event(struct pm8001_hba_info *pm8001_ha, void *piomb)
+static void mpi_sata_event(struct pm8001_hba_info *pm8001_ha,
+		struct outbound_queue_table *circularQ, void *piomb)
 {
 	struct sas_task *t;
 	struct task_status_struct *ts;
@@ -2890,7 +2916,11 @@ static void mpi_sata_event(struct pm8001_hba_info *pm8001_ha, void *piomb)
 				IO_OPEN_CNX_ERROR_IT_NEXUS_LOSS);
 			ts->resp = SAS_TASK_COMPLETE;
 			ts->stat = SAS_QUEUE_FULL;
+			spin_unlock_irqrestore(&circularQ->oq_lock,
+					circularQ->lock_flags);
 			pm8001_ccb_task_free_done(pm8001_ha, t, ccb, tag);
+			spin_lock_irqsave(&circularQ->oq_lock,
+					circularQ->lock_flags);
 			return;
 		}
 		break;
@@ -3002,7 +3032,11 @@ static void mpi_sata_event(struct pm8001_hba_info *pm8001_ha, void *piomb)
 		pm8001_ccb_task_free(pm8001_ha, t, ccb, tag);
 	} else {
 		spin_unlock_irqrestore(&t->task_state_lock, flags);
+		spin_unlock_irqrestore(&circularQ->oq_lock,
+				circularQ->lock_flags);
 		pm8001_ccb_task_free_done(pm8001_ha, t, ccb, tag);
+		spin_lock_irqsave(&circularQ->oq_lock,
+				circularQ->lock_flags);
 	}
 }
 
@@ -3906,7 +3940,8 @@ static int ssp_coalesced_comp_resp(struct pm8001_hba_info *pm8001_ha,
  * @pm8001_ha: our hba card information
  * @piomb: IO message buffer
  */
-static void process_one_iomb(struct pm8001_hba_info *pm8001_ha, void *piomb)
+static void process_one_iomb(struct pm8001_hba_info *pm8001_ha,
+		struct outbound_queue_table *circularQ, void *piomb)
 {
 	__le32 pHeader = *(__le32 *)piomb;
 	u32 opc = (u32)((le32_to_cpu(pHeader)) & 0xFFF);
@@ -3948,11 +3983,11 @@ static void process_one_iomb(struct pm8001_hba_info *pm8001_ha, void *piomb)
 		break;
 	case OPC_OUB_SATA_COMP:
 		pm8001_dbg(pm8001_ha, MSG, "OPC_OUB_SATA_COMP\n");
-		mpi_sata_completion(pm8001_ha, piomb);
+		mpi_sata_completion(pm8001_ha, circularQ, piomb);
 		break;
 	case OPC_OUB_SATA_EVENT:
 		pm8001_dbg(pm8001_ha, MSG, "OPC_OUB_SATA_EVENT\n");
-		mpi_sata_event(pm8001_ha, piomb);
+		mpi_sata_event(pm8001_ha, circularQ, piomb);
 		break;
 	case OPC_OUB_SSP_EVENT:
 		pm8001_dbg(pm8001_ha, MSG, "OPC_OUB_SSP_EVENT\n");
@@ -4121,7 +4156,6 @@ static int process_oq(struct pm8001_hba_info *pm8001_ha, u8 vec)
 	void *pMsg1 = NULL;
 	u8 bc;
 	u32 ret = MPI_IO_STATUS_FAIL;
-	unsigned long flags;
 	u32 regval;
 
 	if (vec == (pm8001_ha->max_q_num - 1)) {
@@ -4138,7 +4172,7 @@ static int process_oq(struct pm8001_hba_info *pm8001_ha, u8 vec)
 		}
 	}
 	circularQ = &pm8001_ha->outbnd_q_tbl[vec];
-	spin_lock_irqsave(&circularQ->oq_lock, flags);
+	spin_lock_irqsave(&circularQ->oq_lock, circularQ->lock_flags);
 	do {
 		/* spurious interrupt during setup if kexec-ing and
 		 * driver doing a doorbell access w/ the pre-kexec oq
@@ -4149,7 +4183,8 @@ static int process_oq(struct pm8001_hba_info *pm8001_ha, u8 vec)
 		ret = pm8001_mpi_msg_consume(pm8001_ha, circularQ, &pMsg1, &bc);
 		if (MPI_IO_STATUS_SUCCESS == ret) {
 			/* process the outbound message */
-			process_one_iomb(pm8001_ha, (void *)(pMsg1 - 4));
+			process_one_iomb(pm8001_ha, circularQ,
+						(void *)(pMsg1 - 4));
 			/* free the message from the outbound circular buffer */
 			pm8001_mpi_msg_free_set(pm8001_ha, pMsg1,
 							circularQ, bc);
@@ -4164,7 +4199,7 @@ static int process_oq(struct pm8001_hba_info *pm8001_ha, u8 vec)
 				break;
 		}
 	} while (1);
-	spin_unlock_irqrestore(&circularQ->oq_lock, flags);
+	spin_unlock_irqrestore(&circularQ->oq_lock, circularQ->lock_flags);
 	return ret;
 }
 
-- 
2.27.0

