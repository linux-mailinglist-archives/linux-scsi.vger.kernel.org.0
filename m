Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B43DC47B778
	for <lists+linux-scsi@lfdr.de>; Tue, 21 Dec 2021 03:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbhLUCAJ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 20 Dec 2021 21:00:09 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33860 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbhLUB7b (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 20 Dec 2021 20:59:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20605B810D9;
        Tue, 21 Dec 2021 01:59:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95FBC36AED;
        Tue, 21 Dec 2021 01:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640051968;
        bh=TAzXiSXldUDzDRYabJb9uvPoArf77XzfBfgN1MRt48Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AcxtbYTT8Pl2uzGKWg+ycnitj9El+Z7svymX06tvIEYjFwiCFeDtEjdNL7SjATPys
         EiMLEvsPycKjnbCOqLuLh7g+Mo8Fhab4/UHXeXK9OQlim1b8ZE4UIWVZgD11Cx1++k
         SUtpLC8A89DiI3bFCIUzfz6WWTZMsAwcQpKi7u/Mt0l9kZ47yoIHzAOXupl7PN0tSm
         9DUYpyzNfmSu5TU8GjzRxG5g37YaVebXMa1jNnO5Y2+77sy/zsXHgDAl5CJfFTJODM
         Dy+QhHe2zqL/m50YRBYUzjCK7OXhdyHyNM0jrOY7gn7gYUcMxsc7oF9ga7Ko7NUhxu
         CbwbV8nK0wnDQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     John Garry <john.garry@huawei.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, jinpu.wang@cloud.ionos.com,
        jejb@linux.ibm.com, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 09/19] scsi: pm8001: Fix phys_to_virt() usage on dma_addr_t
Date:   Mon, 20 Dec 2021 20:59:04 -0500
Message-Id: <20211221015914.116767-9-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211221015914.116767-1-sashal@kernel.org>
References: <20211221015914.116767-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: John Garry <john.garry@huawei.com>

[ Upstream commit 2fe24343922e0428fb68674a4fae099171141bc7 ]

The driver supports a "direct" mode of operation, where the SMP req frame
is directly copied into the command payload (and vice-versa for the SMP
resp).

To get at the SMP req frame data in the scatterlist the driver uses
phys_to_virt() on the DMA mapped memory dma_addr_t . This is broken, and
subsequently crashes as follows when an IOMMU is enabled:

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

--
Difference to v1:
- use kmap_atomic() in both locations
Difference to  v2:
- add whitespace around arithmetic (Damien)

Link: https://lore.kernel.org/r/1639390248-213603-1-git-send-email-john.garry@huawei.com
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: John Garry <john.garry@huawei.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/pm8001/pm80xx_hwi.c | 38 ++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index a203a4fc2674a..4badd2ad2a460 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -2965,7 +2965,6 @@ mpi_smp_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
 	struct smp_completion_resp *psmpPayload;
 	struct task_status_struct *ts;
 	struct pm8001_device *pm8001_dev;
-	char *pdma_respaddr = NULL;
 
 	psmpPayload = (struct smp_completion_resp *)(piomb + 4);
 	status = le32_to_cpu(psmpPayload->status);
@@ -2992,19 +2991,23 @@ mpi_smp_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
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
@@ -4133,14 +4136,14 @@ static int pm80xx_chip_smp_req(struct pm8001_hba_info *pm8001_ha,
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
@@ -4177,8 +4180,9 @@ static int pm80xx_chip_smp_req(struct pm8001_hba_info *pm8001_ha,
 		pm8001_ha->smp_exp_mode = SMP_INDIRECT;
 
 
-	tmp_addr = cpu_to_le64((u64)sg_dma_address(&task->smp_task.smp_req));
-	preq_dma_addr = (char *)phys_to_virt(tmp_addr);
+	smp_req = &task->smp_task.smp_req;
+	to = kmap_atomic(sg_page(smp_req));
+	payload = to + smp_req->offset;
 
 	/* INDIRECT MODE command settings. Use DMA */
 	if (pm8001_ha->smp_exp_mode == SMP_INDIRECT) {
@@ -4186,7 +4190,7 @@ static int pm80xx_chip_smp_req(struct pm8001_hba_info *pm8001_ha,
 		/* for SPCv indirect mode. Place the top 4 bytes of
 		 * SMP Request header here. */
 		for (i = 0; i < 4; i++)
-			smp_cmd.smp_req16[i] = *(preq_dma_addr + i);
+			smp_cmd.smp_req16[i] = *(payload + i);
 		/* exclude top 4 bytes for SMP req header */
 		smp_cmd.long_smp_req.long_req_addr =
 			cpu_to_le64((u64)sg_dma_address
@@ -4217,20 +4221,20 @@ static int pm80xx_chip_smp_req(struct pm8001_hba_info *pm8001_ha,
 		pm8001_dbg(pm8001_ha, IO, "SMP REQUEST DIRECT MODE\n");
 		for (i = 0; i < length; i++)
 			if (i < 16) {
-				smp_cmd.smp_req16[i] = *(preq_dma_addr+i);
+				smp_cmd.smp_req16[i] = *(payload + i);
 				pm8001_dbg(pm8001_ha, IO,
 					   "Byte[%d]:%x (DMA data:%x)\n",
 					   i, smp_cmd.smp_req16[i],
-					   *(preq_dma_addr));
+					   *(payload));
 			} else {
-				smp_cmd.smp_req[i] = *(preq_dma_addr+i);
+				smp_cmd.smp_req[i] = *(payload + i);
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
2.34.1

