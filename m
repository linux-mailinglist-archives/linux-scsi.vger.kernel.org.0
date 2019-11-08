Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64D7CF49C7
	for <lists+linux-scsi@lfdr.de>; Fri,  8 Nov 2019 13:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389543AbfKHLli (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 8 Nov 2019 06:41:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:55080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732178AbfKHLlh (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 8 Nov 2019 06:41:37 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD68721D7B;
        Fri,  8 Nov 2019 11:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213295;
        bh=iooMRrUzKpZwG98xHGVPX3V+QQnKKnXvvoq8CkKhwqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e2XJLSpj0kis+FkWuFZ+n+fYZgrq6IrSZaj8CTZZbhd/7VBAo7CTxXTIGXyDTjPI7
         l7TaDeXvXEYoMPNfNtcx0U/Io1DALi51NsK2/0/Qpce9F351/IZKirOPRGPW1VexGc
         q0rU9EuJ8CZPIHERSNfJkBA6SprbAW8MZubDu0X4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Deepak Ukey <deepak.ukey@microchip.com>,
        Viswas G <Viswas.G@microchip.com>,
        Jack Wang <jinpu.wang@profitbricks.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 153/205] scsi: pm80xx: Fixed system hang issue during kexec boot
Date:   Fri,  8 Nov 2019 06:37:00 -0500
Message-Id: <20191108113752.12502-153-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108113752.12502-1-sashal@kernel.org>
References: <20191108113752.12502-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Deepak Ukey <deepak.ukey@microchip.com>

[ Upstream commit 72349b62a571effd6faadd0600b8e657dd87afbf ]

When the firmware is not responding, execution of kexec boot causes a system
hang. When firmware assertion happened, driver get notified with interrupt
vector updated in MPI configuration table. Then, the driver will read
scratchpad register and set controller_fatal_error flag to true.

Signed-off-by: Deepak Ukey <deepak.ukey@microchip.com>
Signed-off-by: Viswas G <Viswas.G@microchip.com>
Acked-by: Jack Wang <jinpu.wang@profitbricks.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/pm8001/pm8001_hwi.c |  6 +++
 drivers/scsi/pm8001/pm8001_sas.c |  7 +++
 drivers/scsi/pm8001/pm8001_sas.h |  1 +
 drivers/scsi/pm8001/pm80xx_hwi.c | 80 +++++++++++++++++++++++++++++---
 drivers/scsi/pm8001/pm80xx_hwi.h |  3 ++
 5 files changed, 91 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
index 4dd6cad330e8e..3e814c0469fbd 100644
--- a/drivers/scsi/pm8001/pm8001_hwi.c
+++ b/drivers/scsi/pm8001/pm8001_hwi.c
@@ -1479,6 +1479,12 @@ u32 pm8001_mpi_msg_consume(struct pm8001_hba_info *pm8001_ha,
 		} else {
 			u32 producer_index;
 			void *pi_virt = circularQ->pi_virt;
+			/* spurious interrupt during setup if
+			 * kexec-ing and driver doing a doorbell access
+			 * with the pre-kexec oq interrupt setup
+			 */
+			if (!pi_virt)
+				break;
 			/* Update the producer index from SPC */
 			producer_index = pm8001_read_32(pi_virt);
 			circularQ->producer_index = cpu_to_le32(producer_index);
diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
index 576a0f091933b..59feda261e088 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -374,6 +374,13 @@ static int pm8001_task_exec(struct sas_task *task,
 		return 0;
 	}
 	pm8001_ha = pm8001_find_ha_by_dev(task->dev);
+	if (pm8001_ha->controller_fatal_error) {
+		struct task_status_struct *ts = &t->task_status;
+
+		ts->resp = SAS_TASK_UNDELIVERED;
+		t->task_done(t);
+		return 0;
+	}
 	PM8001_IO_DBG(pm8001_ha, pm8001_printk("pm8001_task_exec device \n "));
 	spin_lock_irqsave(&pm8001_ha->lock, flags);
 	do {
diff --git a/drivers/scsi/pm8001/pm8001_sas.h b/drivers/scsi/pm8001/pm8001_sas.h
index 80b4dd6df0c25..1816e351071fa 100644
--- a/drivers/scsi/pm8001/pm8001_sas.h
+++ b/drivers/scsi/pm8001/pm8001_sas.h
@@ -538,6 +538,7 @@ struct pm8001_hba_info {
 	u32			logging_level;
 	u32			fw_status;
 	u32			smp_exp_mode;
+	bool			controller_fatal_error;
 	const struct firmware 	*fw_image;
 	struct isr_param irq_vector[PM8001_MAX_MSIX_VEC];
 	u32			reset_in_progress;
diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index 42f0405601ad1..5021aed87f33a 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -577,6 +577,9 @@ static void update_main_config_table(struct pm8001_hba_info *pm8001_ha)
 		pm8001_ha->main_cfg_tbl.pm80xx_tbl.pcs_event_log_size);
 	pm8001_mw32(address, MAIN_PCS_EVENT_LOG_OPTION,
 		pm8001_ha->main_cfg_tbl.pm80xx_tbl.pcs_event_log_severity);
+	/* Update Fatal error interrupt vector */
+	pm8001_ha->main_cfg_tbl.pm80xx_tbl.fatal_err_interrupt |=
+					((pm8001_ha->number_of_intr - 1) << 8);
 	pm8001_mw32(address, MAIN_FATAL_ERROR_INTERRUPT,
 		pm8001_ha->main_cfg_tbl.pm80xx_tbl.fatal_err_interrupt);
 	pm8001_mw32(address, MAIN_EVENT_CRC_CHECK,
@@ -1110,6 +1113,9 @@ static int pm80xx_chip_init(struct pm8001_hba_info *pm8001_ha)
 		return -EBUSY;
 	}
 
+	/* Initialize the controller fatal error flag */
+	pm8001_ha->controller_fatal_error = false;
+
 	/* Initialize pci space address eg: mpi offset */
 	init_pci_device_addresses(pm8001_ha);
 	init_default_table_values(pm8001_ha);
@@ -1218,13 +1224,17 @@ pm80xx_chip_soft_rst(struct pm8001_hba_info *pm8001_ha)
 	u32 bootloader_state;
 	u32 ibutton0, ibutton1;
 
-	/* Check if MPI is in ready state to reset */
-	if (mpi_uninit_check(pm8001_ha) != 0) {
-		PM8001_FAIL_DBG(pm8001_ha,
-			pm8001_printk("MPI state is not ready\n"));
-		return -1;
+	/* Process MPI table uninitialization only if FW is ready */
+	if (!pm8001_ha->controller_fatal_error) {
+		/* Check if MPI is in ready state to reset */
+		if (mpi_uninit_check(pm8001_ha) != 0) {
+			regval = pm8001_cr32(pm8001_ha, 0, MSGU_SCRATCH_PAD_1);
+			PM8001_FAIL_DBG(pm8001_ha, pm8001_printk(
+				"MPI state is not ready scratch1 :0x%x\n",
+				regval));
+			return -1;
+		}
 	}
-
 	/* checked for reset register normal state; 0x0 */
 	regval = pm8001_cr32(pm8001_ha, 0, SPC_REG_SOFT_RESET);
 	PM8001_INIT_DBG(pm8001_ha,
@@ -3752,6 +3762,46 @@ static void process_one_iomb(struct pm8001_hba_info *pm8001_ha, void *piomb)
 	}
 }
 
+static void print_scratchpad_registers(struct pm8001_hba_info *pm8001_ha)
+{
+	PM8001_FAIL_DBG(pm8001_ha,
+		pm8001_printk("MSGU_SCRATCH_PAD_0: 0x%x\n",
+			pm8001_cr32(pm8001_ha, 0, MSGU_SCRATCH_PAD_0)));
+	PM8001_FAIL_DBG(pm8001_ha,
+		pm8001_printk("MSGU_SCRATCH_PAD_1:0x%x\n",
+			pm8001_cr32(pm8001_ha, 0, MSGU_SCRATCH_PAD_1)));
+	PM8001_FAIL_DBG(pm8001_ha,
+		pm8001_printk("MSGU_SCRATCH_PAD_2: 0x%x\n",
+			pm8001_cr32(pm8001_ha, 0, MSGU_SCRATCH_PAD_2)));
+	PM8001_FAIL_DBG(pm8001_ha,
+		pm8001_printk("MSGU_SCRATCH_PAD_3: 0x%x\n",
+			pm8001_cr32(pm8001_ha, 0, MSGU_SCRATCH_PAD_3)));
+	PM8001_FAIL_DBG(pm8001_ha,
+		pm8001_printk("MSGU_HOST_SCRATCH_PAD_0: 0x%x\n",
+			pm8001_cr32(pm8001_ha, 0, MSGU_HOST_SCRATCH_PAD_0)));
+	PM8001_FAIL_DBG(pm8001_ha,
+		pm8001_printk("MSGU_HOST_SCRATCH_PAD_1: 0x%x\n",
+			pm8001_cr32(pm8001_ha, 0, MSGU_HOST_SCRATCH_PAD_1)));
+	PM8001_FAIL_DBG(pm8001_ha,
+		pm8001_printk("MSGU_HOST_SCRATCH_PAD_2: 0x%x\n",
+			pm8001_cr32(pm8001_ha, 0, MSGU_HOST_SCRATCH_PAD_2)));
+	PM8001_FAIL_DBG(pm8001_ha,
+		pm8001_printk("MSGU_HOST_SCRATCH_PAD_3: 0x%x\n",
+			pm8001_cr32(pm8001_ha, 0, MSGU_HOST_SCRATCH_PAD_3)));
+	PM8001_FAIL_DBG(pm8001_ha,
+		pm8001_printk("MSGU_HOST_SCRATCH_PAD_4: 0x%x\n",
+			pm8001_cr32(pm8001_ha, 0, MSGU_HOST_SCRATCH_PAD_4)));
+	PM8001_FAIL_DBG(pm8001_ha,
+		pm8001_printk("MSGU_HOST_SCRATCH_PAD_5: 0x%x\n",
+			pm8001_cr32(pm8001_ha, 0, MSGU_HOST_SCRATCH_PAD_5)));
+	PM8001_FAIL_DBG(pm8001_ha,
+		pm8001_printk("MSGU_RSVD_SCRATCH_PAD_0: 0x%x\n",
+			pm8001_cr32(pm8001_ha, 0, MSGU_HOST_SCRATCH_PAD_6)));
+	PM8001_FAIL_DBG(pm8001_ha,
+		pm8001_printk("MSGU_RSVD_SCRATCH_PAD_1: 0x%x\n",
+			pm8001_cr32(pm8001_ha, 0, MSGU_HOST_SCRATCH_PAD_7)));
+}
+
 static int process_oq(struct pm8001_hba_info *pm8001_ha, u8 vec)
 {
 	struct outbound_queue_table *circularQ;
@@ -3759,10 +3809,28 @@ static int process_oq(struct pm8001_hba_info *pm8001_ha, u8 vec)
 	u8 uninitialized_var(bc);
 	u32 ret = MPI_IO_STATUS_FAIL;
 	unsigned long flags;
+	u32 regval;
 
+	if (vec == (pm8001_ha->number_of_intr - 1)) {
+		regval = pm8001_cr32(pm8001_ha, 0, MSGU_SCRATCH_PAD_1);
+		if ((regval & SCRATCH_PAD_MIPSALL_READY) !=
+					SCRATCH_PAD_MIPSALL_READY) {
+			pm8001_ha->controller_fatal_error = true;
+			PM8001_FAIL_DBG(pm8001_ha, pm8001_printk(
+				"Firmware Fatal error! Regval:0x%x\n", regval));
+			print_scratchpad_registers(pm8001_ha);
+			return ret;
+		}
+	}
 	spin_lock_irqsave(&pm8001_ha->lock, flags);
 	circularQ = &pm8001_ha->outbnd_q_tbl[vec];
 	do {
+		/* spurious interrupt during setup if kexec-ing and
+		 * driver doing a doorbell access w/ the pre-kexec oq
+		 * interrupt setup.
+		 */
+		if (!circularQ->pi_virt)
+			break;
 		ret = pm8001_mpi_msg_consume(pm8001_ha, circularQ, &pMsg1, &bc);
 		if (MPI_IO_STATUS_SUCCESS == ret) {
 			/* process the outbound message */
diff --git a/drivers/scsi/pm8001/pm80xx_hwi.h b/drivers/scsi/pm8001/pm80xx_hwi.h
index 889e69ce3689b..7dd2699d0efb5 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.h
+++ b/drivers/scsi/pm8001/pm80xx_hwi.h
@@ -1384,6 +1384,9 @@ typedef struct SASProtocolTimerConfig SASProtocolTimerConfig_t;
 #define SCRATCH_PAD_BOOT_LOAD_SUCCESS	0x0
 #define SCRATCH_PAD_IOP0_READY		0xC00
 #define SCRATCH_PAD_IOP1_READY		0x3000
+#define SCRATCH_PAD_MIPSALL_READY	(SCRATCH_PAD_IOP1_READY | \
+					SCRATCH_PAD_IOP0_READY | \
+					SCRATCH_PAD_RAAE_READY)
 
 /* boot loader state */
 #define SCRATCH_PAD1_BOOTSTATE_MASK		0x70	/* Bit 4-6 */
-- 
2.20.1

