Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985074707EC
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Dec 2021 18:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241821AbhLJSAq (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 10 Dec 2021 13:00:46 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4246 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235577AbhLJSAp (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 10 Dec 2021 13:00:45 -0500
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J9dqX4yCKz67KPR;
        Sat, 11 Dec 2021 01:55:52 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 10 Dec 2021 18:57:08 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 10 Dec 2021 17:57:05 +0000
From:   John Garry <john.garry@huawei.com>
To:     <jinpu.wang@cloud.ionos.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <Viswas.G@microchip.com>, <Ajish.Koshy@microchip.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <damien.lemoal@opensource.wdc.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v2] scsi: pm8001: Fix phys_to_virt() usage on dma_addr_t
Date:   Sat, 11 Dec 2021 01:51:46 +0800
Message-ID: <1639158706-18446-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The driver supports a "direct" mode of operation, where the SMP req frame
is directly copied into the command payload (and vice-versa for the SMP
resp).

To get at the SMP req frame data in the scatterlist the driver uses
phys_to_virt() on the DMA mapped memory dma_addr_t . This is broken,
and subsequently crashes as follows when an IOMMU is enabled:

 Unable to handle kernel paging request at virtual address
ffff0000fcebfb00
	...
 pc : pm80xx_chip_smp_req+0x2d0/0x3d0
 lr : pm80xx_chip_smp_req+0xac/0x3d0
 pm80xx_chip_smp_req+0x2d0/0x3d0
 pm8001_task_exec.constprop.0+0x368/0x520
 pm8001_queue_command+0x1c/0x30
 smp_execute_task_sg+0xdc/0x204
 sas_discover_expander.part.0+0xac/0x6cc
 sas_discover_root_expander+0x8c/0x150
 sas_discover_domain+0x3ac/0x6a0
 process_one_work+0x1d0/0x354
 worker_thread+0x13c/0x470
 kthread+0x17c/0x190
 ret_from_fork+0x10/0x20
 Code: 371806e1 910006d6 6b16033f 54000249 (38766b05)
 ---[ end trace b91d59aaee98ea2d ]---
note: kworker/u192:0[7] exited with preempt_count 1

Instead use kmap_atomic().

Signed-off-by: John Garry <john.garry@huawei.com>
---
Difference to v1:
- use kmap_atomic() in both locations

diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index b9f6d83ff380..bed4ab071de5 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -3053,7 +3053,6 @@ mpi_smp_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
 	struct smp_completion_resp *psmpPayload;
 	struct task_status_struct *ts;
 	struct pm8001_device *pm8001_dev;
-	char *pdma_respaddr = NULL;
 
 	psmpPayload = (struct smp_completion_resp *)(piomb + 4);
 	status = le32_to_cpu(psmpPayload->status);
@@ -3080,19 +3079,23 @@ mpi_smp_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
 		if (pm8001_dev)
 			atomic_dec(&pm8001_dev->running_req);
 		if (pm8001_ha->smp_exp_mode == SMP_DIRECT) {
+			struct scatterlist *sg_resp = &t->smp_task.smp_resp;
+			u8 *payload;
+			void *to;
+
 			pm8001_dbg(pm8001_ha, IO,
 				   "DIRECT RESPONSE Length:%d\n",
 				   param);
-			pdma_respaddr = (char *)(phys_to_virt(cpu_to_le64
-						((u64)sg_dma_address
-						(&t->smp_task.smp_resp))));
+			to = kmap_atomic(sg_page(sg_resp));
+			payload = to + sg_resp->offset;
 			for (i = 0; i < param; i++) {
-				*(pdma_respaddr+i) = psmpPayload->_r_a[i];
+				*(payload + i) = psmpPayload->_r_a[i];
 				pm8001_dbg(pm8001_ha, IO,
 					   "SMP Byte%d DMA data 0x%x psmp 0x%x\n",
-					   i, *(pdma_respaddr + i),
+					   i, *(payload + i),
 					   psmpPayload->_r_a[i]);
 			}
+			kunmap_atomic(to);
 		}
 		break;
 	case IO_ABORTED:
@@ -4236,14 +4239,14 @@ static int pm80xx_chip_smp_req(struct pm8001_hba_info *pm8001_ha,
 	struct sas_task *task = ccb->task;
 	struct domain_device *dev = task->dev;
 	struct pm8001_device *pm8001_dev = dev->lldd_dev;
-	struct scatterlist *sg_req, *sg_resp;
+	struct scatterlist *sg_req, *sg_resp, *smp_req;
 	u32 req_len, resp_len;
 	struct smp_req smp_cmd;
 	u32 opc;
 	struct inbound_queue_table *circularQ;
-	char *preq_dma_addr = NULL;
-	__le64 tmp_addr;
 	u32 i, length;
+	u8 *payload;
+	u8 *to;
 
 	memset(&smp_cmd, 0, sizeof(smp_cmd));
 	/*
@@ -4280,8 +4283,9 @@ static int pm80xx_chip_smp_req(struct pm8001_hba_info *pm8001_ha,
 		pm8001_ha->smp_exp_mode = SMP_INDIRECT;
 
 
-	tmp_addr = cpu_to_le64((u64)sg_dma_address(&task->smp_task.smp_req));
-	preq_dma_addr = (char *)phys_to_virt(tmp_addr);
+	smp_req = &task->smp_task.smp_req;
+	to = kmap_atomic(sg_page(smp_req));
+	payload = to + smp_req->offset;
 
 	/* INDIRECT MODE command settings. Use DMA */
 	if (pm8001_ha->smp_exp_mode == SMP_INDIRECT) {
@@ -4289,7 +4293,7 @@ static int pm80xx_chip_smp_req(struct pm8001_hba_info *pm8001_ha,
 		/* for SPCv indirect mode. Place the top 4 bytes of
 		 * SMP Request header here. */
 		for (i = 0; i < 4; i++)
-			smp_cmd.smp_req16[i] = *(preq_dma_addr + i);
+			smp_cmd.smp_req16[i] = *(payload + i);
 		/* exclude top 4 bytes for SMP req header */
 		smp_cmd.long_smp_req.long_req_addr =
 			cpu_to_le64((u64)sg_dma_address
@@ -4320,20 +4324,20 @@ static int pm80xx_chip_smp_req(struct pm8001_hba_info *pm8001_ha,
 		pm8001_dbg(pm8001_ha, IO, "SMP REQUEST DIRECT MODE\n");
 		for (i = 0; i < length; i++)
 			if (i < 16) {
-				smp_cmd.smp_req16[i] = *(preq_dma_addr+i);
+				smp_cmd.smp_req16[i] = *(payload+i);
 				pm8001_dbg(pm8001_ha, IO,
 					   "Byte[%d]:%x (DMA data:%x)\n",
 					   i, smp_cmd.smp_req16[i],
-					   *(preq_dma_addr));
+					   *(payload));
 			} else {
-				smp_cmd.smp_req[i] = *(preq_dma_addr+i);
+				smp_cmd.smp_req[i] = *(payload+i);
 				pm8001_dbg(pm8001_ha, IO,
 					   "Byte[%d]:%x (DMA data:%x)\n",
 					   i, smp_cmd.smp_req[i],
-					   *(preq_dma_addr));
+					   *(payload));
 			}
 	}
-
+	kunmap_atomic(to);
 	build_smp_cmd(pm8001_dev->device_id, smp_cmd.tag,
 				&smp_cmd, pm8001_ha->smp_exp_mode, length);
 	rc = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &smp_cmd,
-- 
2.26.2

