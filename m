Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 393327E1A3
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387944AbfHAR5I (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 13:57:08 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45510 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731544AbfHAR5I (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:57:08 -0400
Received: by mail-pg1-f194.google.com with SMTP id o13so34604396pgp.12
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 10:57:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AVpkL8LCp0VF1cWIPxdVWS1cNHZaX9oeQPH0MuywviY=;
        b=DT9a6JFjR7gxsdenyuOvdWN0T6I9gdbtPwtROOG+Lx6zpKudgXZmX83CJbNTPs13jx
         rj2DZ/mhKXP1k1GDrh9xT9QQwa/kueszOWZhHv5DJOFAOAa31sTBbrKC1i5v2zHr+0Vx
         ETsJxs4vKDUxEJh3QkVQiI84n7FS4Q1AzFBg7cxVcrsth4GGKdSUqdqyZUyIrRf9xcMo
         ToKOwPTZOjyu+JAR7IUSUSzHcqPUQz/rfuhzALlCmYnZFmK63Ms6ye8/gnaZQXCAbs+t
         MxCc3o9AMEml8dV4MnGVlsorMCywxIm88so9u8+MR1nV7d6PGz7rFNadHNsdL7ISuPol
         6z1Q==
X-Gm-Message-State: APjAAAUZJodtqhYlWJB7qFaKc/2EcoavmOzXFeyuoW3Ca+H4UW5LTBc1
        IcCYSlJrthe48XKVHf11+H4=
X-Google-Smtp-Source: APXvYqxFdzCzwgexYiZhttj3r67XXiYOaiOmjaE/RYWnyGTBdV0AOOj17L3M0QLnmScRLwc48zZXHg==
X-Received: by 2002:a63:2a08:: with SMTP id q8mr88098762pgq.415.1564682227278;
        Thu, 01 Aug 2019 10:57:07 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm73144114pfm.66.2019.08.01.10.57.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:57:06 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 34/59] qla2xxx: Check the PCI info string output buffer size
Date:   Thu,  1 Aug 2019 10:55:49 -0700
Message-Id: <20190801175614.73655-35-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801175614.73655-1-bvanassche@acm.org>
References: <20190801175614.73655-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Pass the output buffer size to the code that generates a PCI info string
and check the output buffer size while generating a PCI info string.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_attr.c |  3 +-
 drivers/scsi/qla2xxx/qla_def.h  |  2 +-
 drivers/scsi/qla2xxx/qla_gbl.h  |  2 +-
 drivers/scsi/qla2xxx/qla_mr.c   |  8 ++---
 drivers/scsi/qla2xxx/qla_os.c   | 59 ++++++++++++++-------------------
 5 files changed, 32 insertions(+), 42 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_attr.c b/drivers/scsi/qla2xxx/qla_attr.c
index e3de20918efb..e9c449ef515c 100644
--- a/drivers/scsi/qla2xxx/qla_attr.c
+++ b/drivers/scsi/qla2xxx/qla_attr.c
@@ -1125,7 +1125,8 @@ qla2x00_pci_info_show(struct device *dev, struct device_attribute *attr,
 	char pci_info[30];
 
 	return scnprintf(buf, PAGE_SIZE, "%s\n",
-	    vha->hw->isp_ops->pci_info_str(vha, pci_info));
+			 vha->hw->isp_ops->pci_info_str(vha, pci_info,
+							sizeof(pci_info)));
 }
 
 static ssize_t
diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 1c6811bd5625..8c8279ef3e32 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -3112,7 +3112,7 @@ struct isp_operations {
 	void (*update_fw_options) (struct scsi_qla_host *);
 	int (*load_risc) (struct scsi_qla_host *, uint32_t *);
 
-	char * (*pci_info_str) (struct scsi_qla_host *, char *);
+	char * (*pci_info_str)(struct scsi_qla_host *, char *, size_t);
 	char * (*fw_version_str)(struct scsi_qla_host *, char *, size_t);
 
 	irq_handler_t intr_handler;
diff --git a/drivers/scsi/qla2xxx/qla_gbl.h b/drivers/scsi/qla2xxx/qla_gbl.h
index fc54e7c86463..2d9664086f15 100644
--- a/drivers/scsi/qla2xxx/qla_gbl.h
+++ b/drivers/scsi/qla2xxx/qla_gbl.h
@@ -732,7 +732,7 @@ extern int qlafx00_initialize_adapter(struct scsi_qla_host *);
 extern int qlafx00_soft_reset(scsi_qla_host_t *);
 extern int qlafx00_chip_diag(scsi_qla_host_t *);
 extern void qlafx00_config_rings(struct scsi_qla_host *);
-extern char *qlafx00_pci_info_str(struct scsi_qla_host *, char *);
+extern char *qlafx00_pci_info_str(struct scsi_qla_host *, char *, size_t);
 extern char *qlafx00_fw_version_str(struct scsi_qla_host *, char *, size_t);
 extern irqreturn_t qlafx00_intr_handler(int, void *);
 extern void qlafx00_enable_intrs(struct qla_hw_data *);
diff --git a/drivers/scsi/qla2xxx/qla_mr.c b/drivers/scsi/qla2xxx/qla_mr.c
index 9e3f2f462a2e..759fcfecc310 100644
--- a/drivers/scsi/qla2xxx/qla_mr.c
+++ b/drivers/scsi/qla2xxx/qla_mr.c
@@ -688,14 +688,12 @@ qlafx00_config_rings(struct scsi_qla_host *vha)
 }
 
 char *
-qlafx00_pci_info_str(struct scsi_qla_host *vha, char *str)
+qlafx00_pci_info_str(struct scsi_qla_host *vha, char *str, size_t str_len)
 {
 	struct qla_hw_data *ha = vha->hw;
 
-	if (pci_is_pcie(ha->pdev)) {
-		strcpy(str, "PCIe iSA");
-		return str;
-	}
+	if (pci_is_pcie(ha->pdev))
+		strlcpy(str, "PCIe iSA", str_len);
 	return str;
 }
 
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index cc24af941f7d..927db23695e7 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -536,80 +536,70 @@ static void qla2x00_free_queues(struct qla_hw_data *ha)
 }
 
 static char *
-qla2x00_pci_info_str(struct scsi_qla_host *vha, char *str)
+qla2x00_pci_info_str(struct scsi_qla_host *vha, char *str, size_t str_len)
 {
 	struct qla_hw_data *ha = vha->hw;
-	static char *pci_bus_modes[] = {
+	static const char *const pci_bus_modes[] = {
 		"33", "66", "100", "133",
 	};
 	uint16_t pci_bus;
 
-	strcpy(str, "PCI");
 	pci_bus = (ha->pci_attr & (BIT_9 | BIT_10)) >> 9;
 	if (pci_bus) {
-		strcat(str, "-X (");
-		strcat(str, pci_bus_modes[pci_bus]);
+		snprintf(str, str_len, "PCI-X (%s MHz)",
+			 pci_bus_modes[pci_bus]);
 	} else {
 		pci_bus = (ha->pci_attr & BIT_8) >> 8;
-		strcat(str, " (");
-		strcat(str, pci_bus_modes[pci_bus]);
+		snprintf(str, str_len, "PCI (%s MHz)", pci_bus_modes[pci_bus]);
 	}
-	strcat(str, " MHz)");
 
-	return (str);
+	return str;
 }
 
 static char *
-qla24xx_pci_info_str(struct scsi_qla_host *vha, char *str)
+qla24xx_pci_info_str(struct scsi_qla_host *vha, char *str, size_t str_len)
 {
-	static char *pci_bus_modes[] = { "33", "66", "100", "133", };
+	static const char *const pci_bus_modes[] = {
+		"33", "66", "100", "133",
+	};
 	struct qla_hw_data *ha = vha->hw;
 	uint32_t pci_bus;
 
 	if (pci_is_pcie(ha->pdev)) {
-		char lwstr[6];
 		uint32_t lstat, lspeed, lwidth;
+		const char *speed_str;
 
 		pcie_capability_read_dword(ha->pdev, PCI_EXP_LNKCAP, &lstat);
 		lspeed = lstat & PCI_EXP_LNKCAP_SLS;
 		lwidth = (lstat & PCI_EXP_LNKCAP_MLW) >> 4;
 
-		strcpy(str, "PCIe (");
 		switch (lspeed) {
 		case 1:
-			strcat(str, "2.5GT/s ");
+			speed_str = "2.5GT/s";
 			break;
 		case 2:
-			strcat(str, "5.0GT/s ");
+			speed_str = "5.0GT/s";
 			break;
 		case 3:
-			strcat(str, "8.0GT/s ");
+			speed_str = "8.0GT/s";
 			break;
 		default:
-			strcat(str, "<unknown> ");
+			speed_str = "<unknown>";
 			break;
 		}
-		snprintf(lwstr, sizeof(lwstr), "x%d)", lwidth);
-		strcat(str, lwstr);
+		snprintf(str, str_len, "PCIe (%s x%d)", speed_str, lwidth);
 
 		return str;
 	}
 
-	strcpy(str, "PCI");
 	pci_bus = (ha->pci_attr & CSRX_PCIX_BUS_MODE_MASK) >> 8;
-	if (pci_bus == 0 || pci_bus == 8) {
-		strcat(str, " (");
-		strcat(str, pci_bus_modes[pci_bus >> 3]);
-	} else {
-		strcat(str, "-X ");
-		if (pci_bus & BIT_2)
-			strcat(str, "Mode 2");
-		else
-			strcat(str, "Mode 1");
-		strcat(str, " (");
-		strcat(str, pci_bus_modes[pci_bus & ~BIT_2]);
-	}
-	strcat(str, " MHz)");
+	if (pci_bus == 0 || pci_bus == 8)
+		snprintf(str, str_len, "PCI (%s MHz)",
+			 pci_bus_modes[pci_bus >> 3]);
+	else
+		snprintf(str, str_len, "PCI-X Mode %d (%s MHz)",
+			 pci_bus & 4 ? 2 : 1,
+			 pci_bus_modes[pci_bus & 3]);
 
 	return str;
 }
@@ -3452,7 +3442,8 @@ qla2x00_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	    "QLogic %s - %s.\n", ha->model_number, ha->model_desc);
 	ql_log(ql_log_info, base_vha, 0x00fc,
 	    "ISP%04X: %s @ %s hdma%c host#=%ld fw=%s.\n",
-	    pdev->device, ha->isp_ops->pci_info_str(base_vha, pci_info),
+	    pdev->device, ha->isp_ops->pci_info_str(base_vha, pci_info,
+						       sizeof(pci_info)),
 	    pci_name(pdev), ha->flags.enable_64bit_addressing ? '+' : '-',
 	    base_vha->host_no,
 	    ha->isp_ops->fw_version_str(base_vha, fw_str, sizeof(fw_str)));
-- 
2.22.0.770.g0f2c4a37fd-goog

