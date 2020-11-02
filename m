Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031F42A302F
	for <lists+linux-scsi@lfdr.de>; Mon,  2 Nov 2020 17:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgKBQpf (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 2 Nov 2020 11:45:35 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:34704 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbgKBQpf (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 2 Nov 2020 11:45:35 -0500
IronPort-SDR: NryglGbWFyFfnmGvLZfX2v5qogyYUxTI9KvR7YwZwamlnYGS02QlKcHoV5hMB1Uy+lhnpIeFKt
 22/9Y/diyZAjBLfel8C+cnrrZkS+T2MB2mmM/Yt+bxJDwkRyNED6NQSXPdA3t0L8Qq+YVAfKhR
 rpT3Qsl9eIzCnBI+IFHO5PQ8RAM79mUZYxCaJ/bAmtNvs5D8Kxzr5QVuxFnUs+W56SCI6l1KJR
 DnY9xdF9L8Wokx5JuOzyVxP+IT3KqlNzmtQ4OxzsQgFP/2vJY8xEhbrnEkb1gJ4M3gxEy8HIPA
 vII=
X-IronPort-AV: E=Sophos;i="5.77,445,1596524400"; 
   d="scan'208";a="94753664"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Nov 2020 09:45:33 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 2 Nov 2020 09:45:33 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Mon, 2 Nov 2020 09:45:33 -0700
From:   Viswas G <Viswas.G@microchip.com.com>
To:     <linux-scsi@vger.kernel.org>
CC:     <Vasanthalakshmi.Tharmarajan@microchip.com>,
        <Viswas.G@microchip.com>, <Ruksar.devadi@microchip.com>,
        <martin.petersen@oracle.com>, <yuuzheng@google.com>,
        <vishakhavc@google.com>, <radha@google.com>,
        <akshatzen@google.com>, <jinpu.wang@cloud.ionos.com>
Subject: [PATCH V3 1/4] pm80xx: make mpi_build_cmd locking consistent
Date:   Mon, 2 Nov 2020 22:25:25 +0530
Message-ID: <20201102165528.26510-2-Viswas.G@microchip.com.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20201102165528.26510-1-Viswas.G@microchip.com.com>
References: <20201102165528.26510-1-Viswas.G@microchip.com.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: peter chang <dpf@google.com>

Driver submit all internal requests (like abort_task, event
acknowledgment etc.) through inbound queue 0. While submitting those,
driver does not acquire any lock and it may lead to a race when there
is an IO request coming in CPU0 and submitted through inbound queue 0.
To avoid this, lock acquisition has been moved to pm8001_mpi_build_cmd().
All command submission will go through this path.

Signed-off-by: peter chang <dpf@google.com>
Signed-off-by: Viswas G <Viswas.G@microchip.com>
Signed-off-by: Ruksar Devadi <Ruksar.devadi@microchip.com>
Signed-off-by: Radha Ramachandran <radha@google.com>
Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/scsi/pm8001/pm8001_hwi.c | 21 +++++++++++++++------
 drivers/scsi/pm8001/pm80xx_hwi.c |  8 --------
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
index 2b7b2954ec31..597d7a096a97 100644
--- a/drivers/scsi/pm8001/pm8001_hwi.c
+++ b/drivers/scsi/pm8001/pm8001_hwi.c
@@ -1356,12 +1356,19 @@ int pm8001_mpi_build_cmd(struct pm8001_hba_info *pm8001_ha,
 {
 	u32 Header = 0, hpriority = 0, bc = 1, category = 0x02;
 	void *pMessage;
-
-	if (pm8001_mpi_msg_free_get(circularQ, pm8001_ha->iomb_size,
-		&pMessage) < 0) {
+	unsigned long flags;
+	int q_index = circularQ - pm8001_ha->inbnd_q_tbl;
+	int rv = -1;
+
+	WARN_ON(q_index >= PM8001_MAX_INB_NUM);
+	spin_lock_irqsave(&circularQ->iq_lock, flags);
+	rv = pm8001_mpi_msg_free_get(circularQ, pm8001_ha->iomb_size,
+			&pMessage);
+	if (rv < 0) {
 		PM8001_IO_DBG(pm8001_ha,
-			pm8001_printk("No free mpi buffer\n"));
-		return -ENOMEM;
+			      pm8001_printk("No free mpi buffer\n"));
+		rv = -ENOMEM;
+		goto done;
 	}
 
 	if (nb > (pm8001_ha->iomb_size - sizeof(struct mpi_msg_hdr)))
@@ -1384,7 +1391,9 @@ int pm8001_mpi_build_cmd(struct pm8001_hba_info *pm8001_ha,
 		pm8001_printk("INB Q %x OPCODE:%x , UPDATED PI=%d CI=%d\n",
 			responseQueue, opCode, circularQ->producer_idx,
 			circularQ->consumer_index));
-	return 0;
+done:
+	spin_unlock_irqrestore(&circularQ->iq_lock, flags);
+	return rv;
 }
 
 u32 pm8001_mpi_msg_free_set(struct pm8001_hba_info *pm8001_ha, void *pMsg,
diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index 7593f248afb2..5fe50e0effcd 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -4281,7 +4281,6 @@ static int pm80xx_chip_smp_req(struct pm8001_hba_info *pm8001_ha,
 	char *preq_dma_addr = NULL;
 	__le64 tmp_addr;
 	u32 i, length;
-	unsigned long flags;
 
 	memset(&smp_cmd, 0, sizeof(smp_cmd));
 	/*
@@ -4377,10 +4376,8 @@ static int pm80xx_chip_smp_req(struct pm8001_hba_info *pm8001_ha,
 
 	build_smp_cmd(pm8001_dev->device_id, smp_cmd.tag,
 				&smp_cmd, pm8001_ha->smp_exp_mode, length);
-	spin_lock_irqsave(&circularQ->iq_lock, flags);
 	rc = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &smp_cmd,
 			sizeof(smp_cmd), 0);
-	spin_unlock_irqrestore(&circularQ->iq_lock, flags);
 	if (rc)
 		goto err_out_2;
 	return 0;
@@ -4444,7 +4441,6 @@ static int pm80xx_chip_ssp_io_req(struct pm8001_hba_info *pm8001_ha,
 	u64 phys_addr, start_addr, end_addr;
 	u32 end_addr_high, end_addr_low;
 	struct inbound_queue_table *circularQ;
-	unsigned long flags;
 	u32 q_index, cpu_id;
 	u32 opc = OPC_INB_SSPINIIOSTART;
 	memset(&ssp_cmd, 0, sizeof(ssp_cmd));
@@ -4582,10 +4578,8 @@ static int pm80xx_chip_ssp_io_req(struct pm8001_hba_info *pm8001_ha,
 			ssp_cmd.esgl = 0;
 		}
 	}
-	spin_lock_irqsave(&circularQ->iq_lock, flags);
 	ret = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc,
 			&ssp_cmd, sizeof(ssp_cmd), q_index);
-	spin_unlock_irqrestore(&circularQ->iq_lock, flags);
 	return ret;
 }
 
@@ -4819,10 +4813,8 @@ static int pm80xx_chip_sata_req(struct pm8001_hba_info *pm8001_ha,
 			}
 		}
 	}
-	spin_lock_irqsave(&circularQ->iq_lock, flags);
 	ret = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc,
 			&sata_cmd, sizeof(sata_cmd), q_index);
-	spin_unlock_irqrestore(&circularQ->iq_lock, flags);
 	return ret;
 }
 
-- 
2.16.3

