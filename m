Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAB66F487C
	for <lists+linux-scsi@lfdr.de>; Fri,  8 Nov 2019 12:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390986AbfKHLo7 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 8 Nov 2019 06:44:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:60016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390976AbfKHLo7 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 8 Nov 2019 06:44:59 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 114E1222CE;
        Fri,  8 Nov 2019 11:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213497;
        bh=gqs9gQ7s25NNbdz7US0n6CuViu4lUSJFlynEk4UMfHg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qNrOsXLA2zKuGXwTNMAi99tO9azth4Zp3ZDbM6flCIYHmlOoo9pWRzd4PT0ZQoZjE
         bUJCtQNhSolEDnaamq/3MpqA503ZTnv956QFSMGPm8TbsHvU4j86A36xYlUw8DUQNu
         faRC3P/2vMEBnhFWQxZWYtpBtJV1cLtpjiv3JnBI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Deepak Ukey <deepak.ukey@microchip.com>,
        Viswas G <Viswas.G@microchip.com>,
        Jack Wang <jinpu.wang@profitbricks.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 075/103] scsi: pm80xx: Fixed system hang issue during kexec boot
Date:   Fri,  8 Nov 2019 06:42:40 -0500
Message-Id: <20191108114310.14363-75-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108114310.14363-1-sashal@kernel.org>
References: <20191108114310.14363-1-sashal@kernel.org>
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
index 10546faac58c6..f374abfb7f1f8 100644
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
index d1fcd21f7f7dd..e64a13f0bce17 100644
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
index e81a8fa7ef1a8..e954ecd3f6c08 100644
--- a/drivers/scsi/pm8001/pm8001_sas.h
+++ b/drivers/scsi/pm8001/pm8001_sas.h
@@ -529,6 +529,7 @@ struct pm8001_hba_info {
 	u32			logging_level;
 	u32			fw_status;
 	u32			smp_exp_mode;
+	bool			controller_fatal_error;
 	const struct firmware 	*fw_image;
 	struct isr_param irq_vector[PM8001_MAX_MSIX_VEC];
 };
diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index eb4fee61df729..9edd61c063a1a 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -572,6 +572,9 @@ static void update_main_config_table(struct pm8001_hba_info *pm8001_ha)
 		pm8001_ha->main_cfg_tbl.pm80xx_tbl.pcs_event_log_size);
 	pm8001_mw32(address, MAIN_PCS_EVENT_LOG_OPTION,
 		pm8001_ha->main_cfg_tbl.pm80xx_tbl.pcs_event_log_severity);
+	/* Update Fatal error interrupt vector */
+	pm8001_ha->main_cfg_tbl.pm80xx_tbl.fatal_err_interrupt |=
+					((pm8001_ha->number_of_intr - 1) << 8);
 	pm8001_mw32(address, MAIN_FATAL_ERROR_INTERRUPT,
 		pm8001_ha->main_cfg_tbl.pm80xx_tbl.fatal_err_interrupt);
 	pm8001_mw32(address, MAIN_EVENT_CRC_CHECK,
@@ -1099,6 +1102,9 @@ static int pm80xx_chip_init(struct pm8001_hba_info *pm8001_ha)
 		return -EBUSY;
 	}
 
+	/* Initialize the controller fatal error flag */
+	pm8001_ha->controller_fatal_error = false;
+
 	/* Initialize pci space address eg: mpi offset */
 	init_pci_device_addresses(pm8001_ha);
 	init_default_table_values(pm8001_ha);
@@ -1207,13 +1213,17 @@ pm80xx_chip_soft_rst(struct pm8001_hba_info *pm8001_ha)
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
@@ -3717,6 +3727,46 @@ static void process_one_iomb(struct pm8001_hba_info *pm8001_ha, void *piomb)
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
@@ -3724,10 +3774,28 @@ static int process_oq(struct pm8001_hba_info *pm8001_ha, u8 vec)
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
index 7a443bad61634..411b414a9a0ef 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.h
+++ b/drivers/scsi/pm8001/pm80xx_hwi.h
@@ -1288,6 +1288,9 @@ typedef struct SASProtocolTimerConfig SASProtocolTimerConfig_t;
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

