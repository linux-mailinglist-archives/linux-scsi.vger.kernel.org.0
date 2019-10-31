Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B67ABEAA10
	for <lists+linux-scsi@lfdr.de>; Thu, 31 Oct 2019 06:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfJaFML (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 31 Oct 2019 01:12:11 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:38896 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbfJaFML (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 31 Oct 2019 01:12:11 -0400
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  viswas.g@microsemi.com designates 208.19.100.23 as permitted
  sender) identity=mailfrom; client-ip=208.19.100.23;
  receiver=esa4.microchip.iphmx.com;
  envelope-from="viswas.g@microsemi.com";
  x-sender="viswas.g@microsemi.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:208.19.100.20 ip4:208.19.100.21 ip4:208.19.100.22
  ip4:208.19.100.23 ip4:208.19.99.221 ip4:208.19.99.222
  ip4:208.19.99.223 ip4:208.19.99.225 -all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@smtp.microsemi.com) identity=helo;
  client-ip=208.19.100.23; receiver=esa4.microchip.iphmx.com;
  envelope-from="viswas.g@microsemi.com";
  x-sender="postmaster@smtp.microsemi.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=viswas.g@microsemi.com; spf=None smtp.helo=postmaster@smtp.microsemi.com; dmarc=fail (p=none dis=none) d=microchip.com
IronPort-SDR: FLGeHyb7AOFua0V8vJHMrBYjawjbj7IA32OcFvKEXKCi0EsgQWslHLff8Yt0H76xbntF/O8h2l
 I0Ncn2012S5MBFOiy+3mM7I8TlkYu7ThZS3FhHb7dQ3H1dX4rdpVHwyV4vyizaDRrGQRWWEIqd
 Ctq+2Ltn97G8XWs0yYODurZt1oU/bz+avUc9GuIk56ReqI19AiryxQPqLVfiH1PuLtmCZG2vyI
 m3iIS439Ou5+W7cMdnB4UmfgzFgM6fTrv+xCk6dlgwfT77lr/6zG6vxR/k4/ZxEH6uZIj3qLtF
 LR8=
X-IronPort-AV: E=Sophos;i="5.68,250,1569308400"; 
   d="scan'208";a="53588624"
Received: from unknown (HELO smtp.microsemi.com) ([208.19.100.23])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Oct 2019 22:12:10 -0700
Received: from AVMBX2.microsemi.net (10.100.34.32) by AVMBX3.microsemi.net
 (10.100.34.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Wed, 30 Oct
 2019 22:12:09 -0700
Received: from localhost (10.41.130.49) by avmbx2.microsemi.net (10.100.34.32)
 with Microsoft SMTP Server id 15.1.1847.3 via Frontend Transport; Wed, 30 Oct
 2019 22:12:08 -0700
From:   Deepak Ukey <deepak.ukey@microchip.com>
To:     <linux-scsi@vger.kernel.org>
CC:     <Vasanthalakshmi.Tharmarajan@microchip.com>,
        <Viswas.G@microchip.com>, <deepak.ukey@microchip.com>,
        <jinpu.wang@profitbricks.com>, <martin.petersen@oracle.com>,
        <dpf@google.com>, <jsperbeck@google.com>, <auradkar@google.com>,
        <ianyar@google.com>
Subject: [PATCH 04/12] pm80xx : Squashed logging cleanup changes.
Date:   Thu, 31 Oct 2019 10:42:33 +0530
Message-ID: <20191031051241.6762-5-deepak.ukey@microchip.com>
X-Mailer: git-send-email 2.19.0-rc1
In-Reply-To: <20191031051241.6762-1-deepak.ukey@microchip.com>
References: <20191031051241.6762-1-deepak.ukey@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: peter chang <dpf@google.com>

The default logging doesn't include the device name, so it's
difficult to determine which controller is being logged about in
error scenarios. The logging level was only settable via sysfs,
which made it inconvenient for actual debugging. This changes the
default to only cover error handling.

Signed-off-by: peter chang <dpf@google.com>
Signed-off-by: Deepak Ukey <deepak.ukey@microchip.com>
Signed-off-by: Viswas G <Viswas.G@microchip.com>
---
 drivers/scsi/pm8001/pm8001_hwi.c  |  62 ++++++++++++++------
 drivers/scsi/pm8001/pm8001_init.c |   6 +-
 drivers/scsi/pm8001/pm8001_sas.c  |   6 +-
 drivers/scsi/pm8001/pm8001_sas.h  |  15 ++++-
 drivers/scsi/pm8001/pm80xx_hwi.c  | 118 +++++++++++++++++++++++++++++++++-----
 5 files changed, 170 insertions(+), 37 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
index 68a8217032d0..2c1c722eca17 100644
--- a/drivers/scsi/pm8001/pm8001_hwi.c
+++ b/drivers/scsi/pm8001/pm8001_hwi.c
@@ -1364,7 +1364,7 @@ int pm8001_mpi_build_cmd(struct pm8001_hba_info *pm8001_ha,
 	/*Update the PI to the firmware*/
 	pm8001_cw32(pm8001_ha, circularQ->pi_pci_bar,
 		circularQ->pi_offset, circularQ->producer_idx);
-	PM8001_IO_DBG(pm8001_ha,
+	PM8001_DEVIO_DBG(pm8001_ha,
 		pm8001_printk("INB Q %x OPCODE:%x , UPDATED PI=%d CI=%d\n",
 			responseQueue, opCode, circularQ->producer_idx,
 			circularQ->consumer_index));
@@ -1436,6 +1436,10 @@ u32 pm8001_mpi_msg_consume(struct pm8001_hba_info *pm8001_ha,
 			/* read header */
 			header_tmp = pm8001_read_32(msgHeader);
 			msgHeader_tmp = cpu_to_le32(header_tmp);
+			PM8001_DEVIO_DBG(pm8001_ha, pm8001_printk(
+				"outbound opcode msgheader:%x ci=%d pi=%d\n",
+				msgHeader_tmp, circularQ->consumer_idx,
+				circularQ->producer_index));
 			if (0 != (le32_to_cpu(msgHeader_tmp) & 0x80000000)) {
 				if (OPC_OUB_SKIP_ENTRY !=
 					(le32_to_cpu(msgHeader_tmp) & 0xfff)) {
@@ -1604,7 +1608,8 @@ void pm8001_work_fn(struct work_struct *work)
 				break;
 
 			default:
-				pm8001_printk("...query task failed!!!\n");
+				PM8001_DEVIO_DBG(pm8001_ha, pm8001_printk(
+					"...query task failed!!!\n"));
 				break;
 			});
 
@@ -1890,6 +1895,11 @@ mpi_ssp_completion(struct pm8001_hba_info *pm8001_ha , void *piomb)
 			pm8001_printk("SAS Address of IO Failure Drive:"
 			"%016llx", SAS_ADDR(t->dev->sas_addr)));
 
+	if (status)
+		PM8001_IOERR_DBG(pm8001_ha, pm8001_printk(
+			"status:0x%x, tag:0x%x, task:0x%p\n",
+			status, tag, t));
+
 	switch (status) {
 	case IO_SUCCESS:
 		PM8001_IO_DBG(pm8001_ha, pm8001_printk("IO_SUCCESS"
@@ -2072,7 +2082,7 @@ mpi_ssp_completion(struct pm8001_hba_info *pm8001_ha , void *piomb)
 		ts->open_rej_reason = SAS_OREJ_RSVD_RETRY;
 		break;
 	default:
-		PM8001_IO_DBG(pm8001_ha,
+		PM8001_DEVIO_DBG(pm8001_ha,
 			pm8001_printk("Unknown status 0x%x\n", status));
 		/* not allowed case. Therefore, return failed status */
 		ts->resp = SAS_TASK_COMPLETE;
@@ -2125,7 +2135,7 @@ static void mpi_ssp_event(struct pm8001_hba_info *pm8001_ha , void *piomb)
 	if (unlikely(!t || !t->lldd_task || !t->dev))
 		return;
 	ts = &t->task_status;
-	PM8001_IO_DBG(pm8001_ha,
+	PM8001_DEVIO_DBG(pm8001_ha,
 		pm8001_printk("port_id = %x,device_id = %x\n",
 		port_id, dev_id));
 	switch (event) {
@@ -2263,7 +2273,7 @@ static void mpi_ssp_event(struct pm8001_hba_info *pm8001_ha , void *piomb)
 			pm8001_printk("  IO_XFER_CMD_FRAME_ISSUED\n"));
 		return;
 	default:
-		PM8001_IO_DBG(pm8001_ha,
+		PM8001_DEVIO_DBG(pm8001_ha,
 			pm8001_printk("Unknown status 0x%x\n", event));
 		/* not allowed case. Therefore, return failed status */
 		ts->resp = SAS_TASK_COMPLETE;
@@ -2352,6 +2362,12 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
 			pm8001_printk("ts null\n"));
 		return;
 	}
+
+	if (status)
+		PM8001_IOERR_DBG(pm8001_ha, pm8001_printk(
+			"status:0x%x, tag:0x%x, task::0x%p\n",
+			status, tag, t));
+
 	/* Print sas address of IO failed device */
 	if ((status != IO_SUCCESS) && (status != IO_OVERFLOW) &&
 		(status != IO_UNDERFLOW)) {
@@ -2652,7 +2668,7 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
 		ts->open_rej_reason = SAS_OREJ_RSVD_RETRY;
 		break;
 	default:
-		PM8001_IO_DBG(pm8001_ha,
+		PM8001_DEVIO_DBG(pm8001_ha,
 			pm8001_printk("Unknown status 0x%x\n", status));
 		/* not allowed case. Therefore, return failed status */
 		ts->resp = SAS_TASK_COMPLETE;
@@ -2723,7 +2739,7 @@ static void mpi_sata_event(struct pm8001_hba_info *pm8001_ha , void *piomb)
 	if (unlikely(!t || !t->lldd_task || !t->dev))
 		return;
 	ts = &t->task_status;
-	PM8001_IO_DBG(pm8001_ha, pm8001_printk(
+	PM8001_DEVIO_DBG(pm8001_ha, pm8001_printk(
 		"port_id:0x%x, device_id:0x%x, tag:0x%x, event:0x%x\n",
 		port_id, dev_id, tag, event));
 	switch (event) {
@@ -2872,7 +2888,7 @@ static void mpi_sata_event(struct pm8001_hba_info *pm8001_ha , void *piomb)
 		ts->stat = SAS_OPEN_TO;
 		break;
 	default:
-		PM8001_IO_DBG(pm8001_ha,
+		PM8001_DEVIO_DBG(pm8001_ha,
 			pm8001_printk("Unknown status 0x%x\n", event));
 		/* not allowed case. Therefore, return failed status */
 		ts->resp = SAS_TASK_COMPLETE;
@@ -2917,9 +2933,13 @@ mpi_smp_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
 	t = ccb->task;
 	ts = &t->task_status;
 	pm8001_dev = ccb->device;
-	if (status)
+	if (status) {
 		PM8001_FAIL_DBG(pm8001_ha,
 			pm8001_printk("smp IO status 0x%x\n", status));
+		PM8001_IOERR_DBG(pm8001_ha,
+			pm8001_printk("status:0x%x, tag:0x%x, task:0x%p\n",
+			status, tag, t));
+	}
 	if (unlikely(!t || !t->lldd_task || !t->dev))
 		return;
 
@@ -3070,7 +3090,7 @@ mpi_smp_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
 		ts->open_rej_reason = SAS_OREJ_RSVD_RETRY;
 		break;
 	default:
-		PM8001_IO_DBG(pm8001_ha,
+		PM8001_DEVIO_DBG(pm8001_ha,
 			pm8001_printk("Unknown status 0x%x\n", status));
 		ts->resp = SAS_TASK_COMPLETE;
 		ts->stat = SAS_DEV_NO_RESPONSE;
@@ -3416,7 +3436,7 @@ hw_event_sas_phy_up(struct pm8001_hba_info *pm8001_ha, void *piomb)
 		pm8001_get_lrate_mode(phy, link_rate);
 		break;
 	default:
-		PM8001_MSG_DBG(pm8001_ha,
+		PM8001_DEVIO_DBG(pm8001_ha,
 			pm8001_printk("unknown device type(%x)\n", deviceType));
 		break;
 	}
@@ -3463,7 +3483,7 @@ hw_event_sata_phy_up(struct pm8001_hba_info *pm8001_ha, void *piomb)
 	struct sas_ha_struct *sas_ha = pm8001_ha->sas;
 	struct pm8001_phy *phy = &pm8001_ha->phy[phy_id];
 	unsigned long flags;
-	PM8001_MSG_DBG(pm8001_ha,
+	PM8001_DEVIO_DBG(pm8001_ha,
 		pm8001_printk("HW_EVENT_SATA_PHY_UP port id = %d,"
 		" phy id = %d\n", port_id, phy_id));
 	port->port_state =  portstate;
@@ -3541,7 +3561,7 @@ hw_event_phy_down(struct pm8001_hba_info *pm8001_ha, void *piomb)
 		break;
 	default:
 		port->port_attached = 0;
-		PM8001_MSG_DBG(pm8001_ha,
+		PM8001_DEVIO_DBG(pm8001_ha,
 			pm8001_printk(" phy Down and(default) = %x\n",
 			portstate));
 		break;
@@ -3689,7 +3709,7 @@ int pm8001_mpi_fw_flash_update_resp(struct pm8001_hba_info *pm8001_ha,
 			pm8001_printk(": FLASH_UPDATE_DISABLED\n"));
 		break;
 	default:
-		PM8001_MSG_DBG(pm8001_ha,
+		PM8001_DEVIO_DBG(pm8001_ha,
 			pm8001_printk("No matched status = %d\n", status));
 		break;
 	}
@@ -3805,8 +3825,9 @@ static int mpi_hw_event(struct pm8001_hba_info *pm8001_ha, void* piomb)
 	struct sas_ha_struct *sas_ha = pm8001_ha->sas;
 	struct pm8001_phy *phy = &pm8001_ha->phy[phy_id];
 	struct asd_sas_phy *sas_phy = sas_ha->sas_phy[phy_id];
-	PM8001_MSG_DBG(pm8001_ha,
-		pm8001_printk("outbound queue HW event & event type : "));
+	PM8001_DEVIO_DBG(pm8001_ha, pm8001_printk(
+		"SPC HW event for portid:%d, phyid:%d, event:%x, status:%x\n",
+		port_id, phy_id, eventType, status));
 	switch (eventType) {
 	case HW_EVENT_PHY_START_STATUS:
 		PM8001_MSG_DBG(pm8001_ha,
@@ -3990,7 +4011,7 @@ static int mpi_hw_event(struct pm8001_hba_info *pm8001_ha, void* piomb)
 			pm8001_printk("EVENT_BROADCAST_ASYNCH_EVENT\n"));
 		break;
 	default:
-		PM8001_MSG_DBG(pm8001_ha,
+		PM8001_DEVIO_DBG(pm8001_ha,
 			pm8001_printk("Unknown event type = %x\n", eventType));
 		break;
 	}
@@ -4161,7 +4182,7 @@ static void process_one_iomb(struct pm8001_hba_info *pm8001_ha, void *piomb)
 			pm8001_printk("OPC_OUB_SAS_RE_INITIALIZE\n"));
 		break;
 	default:
-		PM8001_MSG_DBG(pm8001_ha,
+		PM8001_DEVIO_DBG(pm8001_ha,
 			pm8001_printk("Unknown outbound Queue IOMB OPC = %x\n",
 			opc));
 		break;
@@ -4649,6 +4670,9 @@ static irqreturn_t
 pm8001_chip_isr(struct pm8001_hba_info *pm8001_ha, u8 vec)
 {
 	pm8001_chip_interrupt_disable(pm8001_ha, vec);
+	PM8001_DEVIO_DBG(pm8001_ha, pm8001_printk(
+		"irq vec %d, ODMR:0x%x\n",
+		vec, pm8001_cr32(pm8001_ha, 0, 0x30)));
 	process_oq(pm8001_ha, vec);
 	pm8001_chip_interrupt_enable(pm8001_ha, vec);
 	return IRQ_HANDLED;
@@ -4960,6 +4984,8 @@ pm8001_chip_fw_flash_update_req(struct pm8001_hba_info *pm8001_ha,
 	if (!fw_control_context)
 		return -ENOMEM;
 	fw_control = (struct fw_control_info *)&ioctl_payload->func_specific;
+	PM8001_DEVIO_DBG(pm8001_ha, pm8001_printk(
+		"dma fw_control context input length :%x\n", fw_control->len));
 	memcpy(buffer, fw_control->buffer, fw_control->len);
 	flash_update_info.sgl.addr = cpu_to_le64(phys_addr);
 	flash_update_info.sgl.im_len.len = cpu_to_le32(fw_control->len);
diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index 3374f553c617..b7cc3d05a3e0 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -42,6 +42,10 @@
 #include "pm8001_sas.h"
 #include "pm8001_chips.h"
 
+static ulong logging_level = PM8001_FAIL_LOGGING | PM8001_IOERR_LOGGING;
+module_param(logging_level, ulong, 0644);
+MODULE_PARM_DESC(logging_level, " bits for enabling logging info.");
+
 static struct scsi_transport_template *pm8001_stt;
 
 /**
@@ -466,7 +470,7 @@ static struct pm8001_hba_info *pm8001_pci_alloc(struct pci_dev *pdev,
 	pm8001_ha->sas = sha;
 	pm8001_ha->shost = shost;
 	pm8001_ha->id = pm8001_id++;
-	pm8001_ha->logging_level = 0x01;
+	pm8001_ha->logging_level = logging_level;
 	sprintf(pm8001_ha->name, "%s%d", DRV_NAME, pm8001_ha->id);
 	/* IOMB size is 128 for 8088/89 controllers */
 	if (pm8001_ha->chip_id != chip_8001)
diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
index 81160e99c75e..447a66d60275 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -119,7 +119,7 @@ int pm8001_mem_alloc(struct pci_dev *pdev, void **virt_addr,
 	mem_virt_alloc = dma_alloc_coherent(&pdev->dev, mem_size + align,
 					    &mem_dma_handle, GFP_KERNEL);
 	if (!mem_virt_alloc) {
-		pm8001_printk("memory allocation error\n");
+		pr_err("pm80xx: memory allocation error\n");
 		return -1;
 	}
 	*pphys_addr = mem_dma_handle;
@@ -249,6 +249,8 @@ int pm8001_phy_control(struct asd_sas_phy *sas_phy, enum phy_func func,
 		spin_unlock_irqrestore(&pm8001_ha->lock, flags);
 		return 0;
 	default:
+		PM8001_DEVIO_DBG(pm8001_ha,
+			pm8001_printk("func 0x%x\n", func));
 		rc = -EOPNOTSUPP;
 	}
 	msleep(300);
@@ -1179,7 +1181,7 @@ int pm8001_query_task(struct sas_task *task)
 			break;
 		}
 	}
-	pm8001_printk(":rc= %d\n", rc);
+	pr_err("pm80xx: rc= %d\n", rc);
 	return rc;
 }
 
diff --git a/drivers/scsi/pm8001/pm8001_sas.h b/drivers/scsi/pm8001/pm8001_sas.h
index ff17c6aff63d..9e0da7bccb45 100644
--- a/drivers/scsi/pm8001/pm8001_sas.h
+++ b/drivers/scsi/pm8001/pm8001_sas.h
@@ -66,8 +66,11 @@
 #define PM8001_EH_LOGGING	0x10 /* libsas EH function logging*/
 #define PM8001_IOCTL_LOGGING	0x20 /* IOCTL message logging */
 #define PM8001_MSG_LOGGING	0x40 /* misc message logging */
-#define pm8001_printk(format, arg...)	printk(KERN_INFO "pm80xx %s %d:" \
-			format, __func__, __LINE__, ## arg)
+#define PM8001_DEV_LOGGING	0x80 /* development message logging */
+#define PM8001_DEVIO_LOGGING	0x100 /* development io message logging */
+#define PM8001_IOERR_LOGGING	0x200 /* development io err message logging */
+#define pm8001_printk(format, arg...)	pr_info("%s:: %s  %d:" \
+			format, pm8001_ha->name, __func__, __LINE__, ## arg)
 #define PM8001_CHECK_LOGGING(HBA, LEVEL, CMD)	\
 do {						\
 	if (unlikely(HBA->logging_level & LEVEL))	\
@@ -97,6 +100,14 @@ do {						\
 #define PM8001_MSG_DBG(HBA, CMD)		\
 	PM8001_CHECK_LOGGING(HBA, PM8001_MSG_LOGGING, CMD)
 
+#define PM8001_DEV_DBG(HBA, CMD)		\
+	PM8001_CHECK_LOGGING(HBA, PM8001_DEV_LOGGING, CMD)
+
+#define PM8001_DEVIO_DBG(HBA, CMD)		\
+	PM8001_CHECK_LOGGING(HBA, PM8001_DEVIO_LOGGING, CMD)
+
+#define PM8001_IOERR_DBG(HBA, CMD)		\
+	PM8001_CHECK_LOGGING(HBA, PM8001_IOERR_LOGGING, CMD)
 
 #define PM8001_USE_TASKLET
 #define PM8001_USE_MSIX
diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index 1a1adda15db8..6057610263c1 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -317,6 +317,25 @@ static void read_main_config_table(struct pm8001_hba_info *pm8001_ha)
 		pm8001_mr32(address, MAIN_MPI_ILA_RELEASE_TYPE);
 	pm8001_ha->main_cfg_tbl.pm80xx_tbl.inc_fw_version =
 		pm8001_mr32(address, MAIN_MPI_INACTIVE_FW_VERSION);
+
+	PM8001_DEV_DBG(pm8001_ha, pm8001_printk(
+		"Main cfg table: sign:%x interface rev:%x fw_rev:%x\n",
+		pm8001_ha->main_cfg_tbl.pm80xx_tbl.signature,
+		pm8001_ha->main_cfg_tbl.pm80xx_tbl.interface_rev,
+		pm8001_ha->main_cfg_tbl.pm80xx_tbl.firmware_rev));
+
+	PM8001_DEV_DBG(pm8001_ha, pm8001_printk(
+		"table offset: gst:%x iq:%x oq:%x int vec:%x phy attr:%x\n",
+		pm8001_ha->main_cfg_tbl.pm80xx_tbl.gst_offset,
+		pm8001_ha->main_cfg_tbl.pm80xx_tbl.inbound_queue_offset,
+		pm8001_ha->main_cfg_tbl.pm80xx_tbl.outbound_queue_offset,
+		pm8001_ha->main_cfg_tbl.pm80xx_tbl.int_vec_table_offset,
+		pm8001_ha->main_cfg_tbl.pm80xx_tbl.phy_attr_table_offset));
+
+	PM8001_DEV_DBG(pm8001_ha, pm8001_printk(
+		"Main cfg table; ila rev:%x Inactive fw rev:%x\n",
+		pm8001_ha->main_cfg_tbl.pm80xx_tbl.ila_version,
+		pm8001_ha->main_cfg_tbl.pm80xx_tbl.inc_fw_version));
 }
 
 /**
@@ -521,6 +540,11 @@ static void init_default_table_values(struct pm8001_hba_info *pm8001_ha)
 			pm8001_mr32(addressib, (offsetib + 0x18));
 		pm8001_ha->inbnd_q_tbl[i].producer_idx		= 0;
 		pm8001_ha->inbnd_q_tbl[i].consumer_index	= 0;
+
+		PM8001_DEV_DBG(pm8001_ha, pm8001_printk(
+			"IQ %d pi_bar 0x%x pi_offset 0x%x\n", i,
+			pm8001_ha->inbnd_q_tbl[i].pi_pci_bar,
+			pm8001_ha->inbnd_q_tbl[i].pi_offset));
 	}
 	for (i = 0; i < PM8001_MAX_SPCV_OUTB_NUM; i++) {
 		pm8001_ha->outbnd_q_tbl[i].element_size_cnt	=
@@ -549,6 +573,11 @@ static void init_default_table_values(struct pm8001_hba_info *pm8001_ha)
 			pm8001_mr32(addressob, (offsetob + 0x18));
 		pm8001_ha->outbnd_q_tbl[i].consumer_idx		= 0;
 		pm8001_ha->outbnd_q_tbl[i].producer_index	= 0;
+
+		PM8001_DEV_DBG(pm8001_ha, pm8001_printk(
+			"OQ %d ci_bar 0x%x ci_offset 0x%x\n", i,
+			pm8001_ha->outbnd_q_tbl[i].ci_pci_bar,
+			pm8001_ha->outbnd_q_tbl[i].ci_offset));
 	}
 }
 
@@ -582,6 +611,10 @@ static void update_main_config_table(struct pm8001_hba_info *pm8001_ha)
 					((pm8001_ha->number_of_intr - 1) << 8);
 	pm8001_mw32(address, MAIN_FATAL_ERROR_INTERRUPT,
 		pm8001_ha->main_cfg_tbl.pm80xx_tbl.fatal_err_interrupt);
+	PM8001_DEV_DBG(pm8001_ha, pm8001_printk(
+		"Updated Fatal error interrupt vector 0x%x\n",
+		pm8001_mr32(address, MAIN_FATAL_ERROR_INTERRUPT)));
+
 	pm8001_mw32(address, MAIN_EVENT_CRC_CHECK,
 		pm8001_ha->main_cfg_tbl.pm80xx_tbl.crc_core_dump);
 
@@ -591,6 +624,9 @@ static void update_main_config_table(struct pm8001_hba_info *pm8001_ha)
 	pm8001_ha->main_cfg_tbl.pm80xx_tbl.gpio_led_mapping |= 0x20000000;
 	pm8001_mw32(address, MAIN_GPIO_LED_FLAGS_OFFSET,
 		pm8001_ha->main_cfg_tbl.pm80xx_tbl.gpio_led_mapping);
+	PM8001_DEV_DBG(pm8001_ha, pm8001_printk(
+		"Programming DW 0x21 in main cfg table with 0x%x\n",
+		pm8001_mr32(address, MAIN_GPIO_LED_FLAGS_OFFSET)));
 
 	pm8001_mw32(address, MAIN_PORT_RECOVERY_TIMER,
 		pm8001_ha->main_cfg_tbl.pm80xx_tbl.port_recovery_timer);
@@ -629,6 +665,21 @@ static void update_inbnd_queue_table(struct pm8001_hba_info *pm8001_ha,
 		pm8001_ha->inbnd_q_tbl[number].ci_upper_base_addr);
 	pm8001_mw32(address, offset + IB_CI_BASE_ADDR_LO_OFFSET,
 		pm8001_ha->inbnd_q_tbl[number].ci_lower_base_addr);
+
+	PM8001_DEV_DBG(pm8001_ha, pm8001_printk(
+		"IQ %d: Element pri size 0x%x\n",
+		number,
+		pm8001_ha->inbnd_q_tbl[number].element_pri_size_cnt));
+
+	PM8001_DEV_DBG(pm8001_ha, pm8001_printk(
+		"IQ upr base addr 0x%x IQ lwr base addr 0x%x\n",
+		pm8001_ha->inbnd_q_tbl[number].upper_base_addr,
+		pm8001_ha->inbnd_q_tbl[number].lower_base_addr));
+
+	PM8001_DEV_DBG(pm8001_ha, pm8001_printk(
+		"CI upper base addr 0x%x CI lower base addr 0x%x\n",
+		pm8001_ha->inbnd_q_tbl[number].ci_upper_base_addr,
+		pm8001_ha->inbnd_q_tbl[number].ci_lower_base_addr));
 }
 
 /**
@@ -652,6 +703,21 @@ static void update_outbnd_queue_table(struct pm8001_hba_info *pm8001_ha,
 		pm8001_ha->outbnd_q_tbl[number].pi_lower_base_addr);
 	pm8001_mw32(address, offset + OB_INTERRUPT_COALES_OFFSET,
 		pm8001_ha->outbnd_q_tbl[number].interrup_vec_cnt_delay);
+
+	PM8001_DEV_DBG(pm8001_ha, pm8001_printk(
+		"OQ %d: Element pri size 0x%x\n",
+		number,
+		pm8001_ha->outbnd_q_tbl[number].element_size_cnt));
+
+	PM8001_DEV_DBG(pm8001_ha, pm8001_printk(
+		"OQ upr base addr 0x%x OQ lwr base addr 0x%x\n",
+		pm8001_ha->outbnd_q_tbl[number].upper_base_addr,
+		pm8001_ha->outbnd_q_tbl[number].lower_base_addr));
+
+	PM8001_DEV_DBG(pm8001_ha, pm8001_printk(
+		"PI upper base addr 0x%x PI lower base addr 0x%x\n",
+		pm8001_ha->outbnd_q_tbl[number].pi_upper_base_addr,
+		pm8001_ha->outbnd_q_tbl[number].pi_lower_base_addr));
 }
 
 /**
@@ -797,7 +863,7 @@ static void init_pci_device_addresses(struct pm8001_hba_info *pm8001_ha)
 	value = pm8001_cr32(pm8001_ha, 0, MSGU_SCRATCH_PAD_0);
 	offset = value & 0x03FFFFFF; /* scratch pad 0 TBL address */
 
-	PM8001_INIT_DBG(pm8001_ha,
+	PM8001_DEV_DBG(pm8001_ha,
 		pm8001_printk("Scratchpad 0 Offset: 0x%x value 0x%x\n",
 				offset, value));
 	pcilogic = (value & 0xFC000000) >> 26;
@@ -885,6 +951,10 @@ pm80xx_set_thermal_config(struct pm8001_hba_info *pm8001_ha)
 				(THERMAL_ENABLE << 8) | page_code;
 	payload.cfg_pg[1] = (LTEMPHIL << 24) | (RTEMPHIL << 8);
 
+	PM8001_DEV_DBG(pm8001_ha, pm8001_printk(
+		"Setting up thermal config. cfg_pg 0 0x%x cfg_pg 1 0x%x\n",
+		payload.cfg_pg[0], payload.cfg_pg[1]));
+
 	rc = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &payload, 0);
 	if (rc)
 		pm8001_tag_free(pm8001_ha, tag);
@@ -1090,6 +1160,10 @@ static int pm80xx_encrypt_update(struct pm8001_hba_info *pm8001_ha)
 	payload.new_curidx_ksop = ((1 << 24) | (1 << 16) | (1 << 8) |
 					KEK_MGMT_SUBOP_KEYCARDUPDATE);
 
+	PM8001_DEV_DBG(pm8001_ha, pm8001_printk(
+		"Saving Encryption info to flash. payload 0x%x\n",
+		payload.new_curidx_ksop));
+
 	rc = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &payload, 0);
 	if (rc)
 		pm8001_tag_free(pm8001_ha, tag);
@@ -1570,6 +1644,10 @@ mpi_ssp_completion(struct pm8001_hba_info *pm8001_ha , void *piomb)
 	if (unlikely(!t || !t->lldd_task || !t->dev))
 		return;
 	ts = &t->task_status;
+
+	PM8001_DEV_DBG(pm8001_ha, pm8001_printk(
+		"tag::0x%x, status::0x%x task::0x%p\n", tag, status, t));
+
 	/* Print sas address of IO failed device */
 	if ((status != IO_SUCCESS) && (status != IO_OVERFLOW) &&
 		(status != IO_UNDERFLOW))
@@ -1772,7 +1850,7 @@ mpi_ssp_completion(struct pm8001_hba_info *pm8001_ha , void *piomb)
 		ts->open_rej_reason = SAS_OREJ_RSVD_RETRY;
 		break;
 	default:
-		PM8001_IO_DBG(pm8001_ha,
+		PM8001_DEVIO_DBG(pm8001_ha,
 			pm8001_printk("Unknown status 0x%x\n", status));
 		/* not allowed case. Therefore, return failed status */
 		ts->resp = SAS_TASK_COMPLETE;
@@ -1826,7 +1904,7 @@ static void mpi_ssp_event(struct pm8001_hba_info *pm8001_ha , void *piomb)
 	if (unlikely(!t || !t->lldd_task || !t->dev))
 		return;
 	ts = &t->task_status;
-	PM8001_IO_DBG(pm8001_ha,
+	PM8001_IOERR_DBG(pm8001_ha,
 		pm8001_printk("port_id:0x%x, tag:0x%x, event:0x%x\n",
 				port_id, tag, event));
 	switch (event) {
@@ -1963,7 +2041,7 @@ static void mpi_ssp_event(struct pm8001_hba_info *pm8001_ha , void *piomb)
 		ts->stat = SAS_DATA_OVERRUN;
 		break;
 	case IO_XFER_ERROR_INTERNAL_CRC_ERROR:
-		PM8001_IO_DBG(pm8001_ha,
+		PM8001_IOERR_DBG(pm8001_ha,
 			pm8001_printk("IO_XFR_ERROR_INTERNAL_CRC_ERROR\n"));
 		/* TBC: used default set values */
 		ts->resp = SAS_TASK_COMPLETE;
@@ -1974,7 +2052,7 @@ static void mpi_ssp_event(struct pm8001_hba_info *pm8001_ha , void *piomb)
 			pm8001_printk("IO_XFER_CMD_FRAME_ISSUED\n"));
 		return;
 	default:
-		PM8001_IO_DBG(pm8001_ha,
+		PM8001_DEVIO_DBG(pm8001_ha,
 			pm8001_printk("Unknown status 0x%x\n", event));
 		/* not allowed case. Therefore, return failed status */
 		ts->resp = SAS_TASK_COMPLETE;
@@ -2062,6 +2140,12 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
 			pm8001_printk("ts null\n"));
 		return;
 	}
+
+	if (unlikely(status))
+		PM8001_IOERR_DBG(pm8001_ha, pm8001_printk(
+			"status:0x%x, tag:0x%x, task::0x%p\n",
+			status, tag, t));
+
 	/* Print sas address of IO failed device */
 	if ((status != IO_SUCCESS) && (status != IO_OVERFLOW) &&
 		(status != IO_UNDERFLOW)) {
@@ -2365,7 +2449,7 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
 		ts->open_rej_reason = SAS_OREJ_RSVD_RETRY;
 		break;
 	default:
-		PM8001_IO_DBG(pm8001_ha,
+		PM8001_DEVIO_DBG(pm8001_ha,
 			pm8001_printk("Unknown status 0x%x\n", status));
 		/* not allowed case. Therefore, return failed status */
 		ts->resp = SAS_TASK_COMPLETE;
@@ -2437,7 +2521,7 @@ static void mpi_sata_event(struct pm8001_hba_info *pm8001_ha , void *piomb)
 	}
 
 	ts = &t->task_status;
-	PM8001_IO_DBG(pm8001_ha,
+	PM8001_IOERR_DBG(pm8001_ha,
 		pm8001_printk("port_id:0x%x, tag:0x%x, event:0x%x\n",
 				port_id, tag, event));
 	switch (event) {
@@ -2657,6 +2741,9 @@ mpi_smp_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
 	if (unlikely(!t || !t->lldd_task || !t->dev))
 		return;
 
+	PM8001_DEV_DBG(pm8001_ha,
+		pm8001_printk("tag::0x%x status::0x%x\n", tag, status));
+
 	switch (status) {
 
 	case IO_SUCCESS:
@@ -2824,7 +2911,7 @@ mpi_smp_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
 		ts->open_rej_reason = SAS_OREJ_RSVD_RETRY;
 		break;
 	default:
-		PM8001_IO_DBG(pm8001_ha,
+		PM8001_DEVIO_DBG(pm8001_ha,
 			pm8001_printk("Unknown status 0x%x\n", status));
 		ts->resp = SAS_TASK_COMPLETE;
 		ts->stat = SAS_DEV_NO_RESPONSE;
@@ -2966,7 +3053,7 @@ hw_event_sas_phy_up(struct pm8001_hba_info *pm8001_ha, void *piomb)
 		pm8001_get_lrate_mode(phy, link_rate);
 		break;
 	default:
-		PM8001_MSG_DBG(pm8001_ha,
+		PM8001_DEVIO_DBG(pm8001_ha,
 			pm8001_printk("unknown device type(%x)\n", deviceType));
 		break;
 	}
@@ -3015,7 +3102,7 @@ hw_event_sata_phy_up(struct pm8001_hba_info *pm8001_ha, void *piomb)
 	struct sas_ha_struct *sas_ha = pm8001_ha->sas;
 	struct pm8001_phy *phy = &pm8001_ha->phy[phy_id];
 	unsigned long flags;
-	PM8001_MSG_DBG(pm8001_ha, pm8001_printk(
+	PM8001_DEVIO_DBG(pm8001_ha, pm8001_printk(
 		"port id %d, phy id %d link_rate %d portstate 0x%x\n",
 				port_id, phy_id, link_rate, portstate));
 
@@ -3103,7 +3190,7 @@ hw_event_phy_down(struct pm8001_hba_info *pm8001_ha, void *piomb)
 		break;
 	default:
 		port->port_attached = 0;
-		PM8001_MSG_DBG(pm8001_ha,
+		PM8001_DEVIO_DBG(pm8001_ha,
 			pm8001_printk(" Phy Down and(default) = 0x%x\n",
 			portstate));
 		break;
@@ -3195,7 +3282,7 @@ static int mpi_hw_event(struct pm8001_hba_info *pm8001_ha, void *piomb)
 	struct pm8001_phy *phy = &pm8001_ha->phy[phy_id];
 	struct pm8001_port *port = &pm8001_ha->port[port_id];
 	struct asd_sas_phy *sas_phy = sas_ha->sas_phy[phy_id];
-	PM8001_MSG_DBG(pm8001_ha,
+	PM8001_DEV_DBG(pm8001_ha,
 		pm8001_printk("portid:%d phyid:%d event:0x%x status:0x%x\n",
 				port_id, phy_id, eventType, status));
 
@@ -3380,7 +3467,7 @@ static int mpi_hw_event(struct pm8001_hba_info *pm8001_ha, void *piomb)
 			pm8001_printk("EVENT_BROADCAST_ASYNCH_EVENT\n"));
 		break;
 	default:
-		PM8001_MSG_DBG(pm8001_ha,
+		PM8001_DEVIO_DBG(pm8001_ha,
 			pm8001_printk("Unknown event type 0x%x\n", eventType));
 		break;
 	}
@@ -3762,7 +3849,7 @@ static void process_one_iomb(struct pm8001_hba_info *pm8001_ha, void *piomb)
 		ssp_coalesced_comp_resp(pm8001_ha, piomb);
 		break;
 	default:
-		PM8001_MSG_DBG(pm8001_ha, pm8001_printk(
+		PM8001_DEVIO_DBG(pm8001_ha, pm8001_printk(
 			"Unknown outbound Queue IOMB OPC = 0x%x\n", opc));
 		break;
 	}
@@ -4645,6 +4732,9 @@ static irqreturn_t
 pm80xx_chip_isr(struct pm8001_hba_info *pm8001_ha, u8 vec)
 {
 	pm80xx_chip_interrupt_disable(pm8001_ha, vec);
+	PM8001_DEVIO_DBG(pm8001_ha, pm8001_printk(
+		"irq vec %d, ODMR:0x%x\n",
+		vec, pm8001_cr32(pm8001_ha, 0, 0x30)));
 	process_oq(pm8001_ha, vec);
 	pm80xx_chip_interrupt_enable(pm8001_ha, vec);
 	return IRQ_HANDLED;
-- 
2.16.3

