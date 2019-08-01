Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C094D7E535
	for <lists+linux-scsi@lfdr.de>; Fri,  2 Aug 2019 00:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389352AbfHAWJw (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 18:09:52 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42353 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731606AbfHAWJw (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 18:09:52 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so34830817pff.9
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 15:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0IaF+dQjFiPhSpK2O8/ZOCUOrv0WfZCBEf5uDFZ67LE=;
        b=GXwq5+O9I2LgFB0PzTXgp+/2+04SZq/jcZQ/QYo+aypMPf3X3jQMihDWOks8synhyO
         ZZ+mo0RrzwNpzVB7iQglPrnzRvCceAbPqg3994XDckY4U8k6MYAcWg+78ovQFDW7OytC
         PnKYoPAEmnl/uEE3IZ3bBCy1840lfOVyu80ofhPePDx8S/DMd+it/YuUI10tAEq5Fie/
         oA1n/Gs2VsXs76WyEtk5aBOSmRCnApoPZmgrP3XxWOw6HFBxxDTGfzkNp2tENaDf6/rz
         g5OYjZjiY/zFkzmfXXDoFOTYxx91hgwUSdxOMFs1jgfbtoNpqudk3Xgr4n7nfKKTeEVh
         6mtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0IaF+dQjFiPhSpK2O8/ZOCUOrv0WfZCBEf5uDFZ67LE=;
        b=Fw6Zrue9IRI8W01msin+V0ZDG4tajnnd10Zjc1VkLdvzE2cNUdmMJqP8VCrZLEz6Sk
         sjid4BiE8lNujIvYB1umOD9ZoOTr+ad25ahTbw9xdJWvVW5YJ3KvPjSMIDbNiO1dp3p2
         Az5iTGENwhjfVqgdSQm0FoXF9005cmK9REnspq0ARUQ3OBiwhVyozJJ1fwjGgUIm/CJ6
         hADfb2y/qAvtxl3DR96Q9+GI5sayhYqlXSEj9x0LMNif8uYR8kCLnISXtkOzkFrwZU/o
         oo71irKS+4zlxbEw2RcD1bc6D7NYPKVsDIrPkj6zVqGAmvRZ3NMjZmTtK4DSsST3ESxQ
         sopQ==
X-Gm-Message-State: APjAAAUng/lvog7UAi5BNNculjyrKg8Epb5LTsGF/i7hYVY14lIVNq4D
        H4sAkQ16QZPxTh0NkEqVZnF/z8OG
X-Google-Smtp-Source: APXvYqxapGfm160IUcbfWMt2+L23jY9wcHYjsIu3orDzXnc+GWDMKfu4BnduA55l0RP4Qax4gEnYMQ==
X-Received: by 2002:a62:3c3:: with SMTP id 186mr55889309pfd.21.1564697390120;
        Thu, 01 Aug 2019 15:09:50 -0700 (PDT)
Received: from pallmd1.broadcom.com ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id r75sm94767752pfc.18.2019.08.01.15.09.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Aug 2019 15:09:49 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        Ming Lei <tom.leiming@gmail.com>
Subject: [PATCH v2] lpfc: Mitigate high memory pre-allocation by SCSI-MQ
Date:   Thu,  1 Aug 2019 15:09:41 -0700
Message-Id: <20190801220941.19615-1-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

When SCSI-MQ is enabled, the SCSI-MQ layers will do pre-allocation of
MQ resources based on shost values set by the driver. In newer cases
of the driver, which attempts to set nr_hw_queues to the cpu count,
the multipliers become excessive, with a single shost having SCSI-MQ
pre-allocation reaching into the multiple GBytes range.  NPIV, which
creates additional shosts, only multiply this overhead. On lower-memory
systems, this can exhaust system memory very quickly, resulting in a
system crash or failures in the driver or elsewhere due to low memory
conditions.

After testing several scenarios, the situation can be mitigated by
limiting the value set in shost->nr_hw_queues to 4. Although the shost
values were changed, the driver still had per-cpu hardware queues of
its own that allowed parallelization per-cpu.  Testing revealed that
even with the smallish number for nr_hw_queues for SCSI-MQ, performance
levels remained near maximum with the within-driver affiinitization.

A module parameter was created to allow the value set for the
nr_hw_queues to be tunable.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
CC: Ming Lei <tom.leiming@gmail.com>

---
v2:
  revised to set nr_hw_queues to minimum of 2 per numa node or
      max value specified by module parameter.
  raised default value for module parameter to 8.
---
 drivers/scsi/lpfc/lpfc.h      |  1 +
 drivers/scsi/lpfc/lpfc_attr.c | 15 +++++++++++++++
 drivers/scsi/lpfc/lpfc_init.c | 10 ++++++----
 drivers/scsi/lpfc/lpfc_sli4.h |  5 +++++
 4 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index 2c3bb8a966e5..bade2e025ecf 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -824,6 +824,7 @@ struct lpfc_hba {
 	uint32_t cfg_cq_poll_threshold;
 	uint32_t cfg_cq_max_proc_limit;
 	uint32_t cfg_fcp_cpu_map;
+	uint32_t cfg_fcp_mq_threshold;
 	uint32_t cfg_hdw_queue;
 	uint32_t cfg_irq_chann;
 	uint32_t cfg_suppress_rsp;
diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index ea62322ffe2b..8d8c495b5b60 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -5709,6 +5709,19 @@ LPFC_ATTR_RW(nvme_embed_cmd, 1, 0, 2,
 	     "Embed NVME Command in WQE");
 
 /*
+ * lpfc_fcp_mq_threshold: Set the maximum number of Hardware Queues
+ * the driver will advertise it supports to the SCSI layer.
+ *
+ *      0    = Set nr_hw_queues by the number of CPUs or HW queues.
+ *      1,128 = Manually specify the maximum nr_hw_queue value to be set,
+ *
+ * Value range is [0,128]. Default value is 8.
+ */
+LPFC_ATTR_R(fcp_mq_threshold, LPFC_FCP_MQ_THRESHOLD_DEF,
+	    LPFC_FCP_MQ_THRESHOLD_MIN, LPFC_FCP_MQ_THRESHOLD_MAX,
+	    "Set the number of SCSI Queues advertised");
+
+/*
  * lpfc_hdw_queue: Set the number of Hardware Queues the driver
  * will advertise it supports to the NVME and  SCSI layers. This also
  * will map to the number of CQ/WQ pairs the driver will create.
@@ -6030,6 +6043,7 @@ struct device_attribute *lpfc_hba_attrs[] = {
 	&dev_attr_lpfc_cq_poll_threshold,
 	&dev_attr_lpfc_cq_max_proc_limit,
 	&dev_attr_lpfc_fcp_cpu_map,
+	&dev_attr_lpfc_fcp_mq_threshold,
 	&dev_attr_lpfc_hdw_queue,
 	&dev_attr_lpfc_irq_chann,
 	&dev_attr_lpfc_suppress_rsp,
@@ -7112,6 +7126,7 @@ lpfc_get_cfgparam(struct lpfc_hba *phba)
 	/* Initialize first burst. Target vs Initiator are different. */
 	lpfc_nvme_enable_fb_init(phba, lpfc_nvme_enable_fb);
 	lpfc_nvmet_fb_size_init(phba, lpfc_nvmet_fb_size);
+	lpfc_fcp_mq_threshold_init(phba, lpfc_fcp_mq_threshold);
 	lpfc_hdw_queue_init(phba, lpfc_hdw_queue);
 	lpfc_irq_chann_init(phba, lpfc_irq_chann);
 	lpfc_enable_bbcr_init(phba, lpfc_enable_bbcr);
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index faf43b1d3dbe..03998579d6ee 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -4309,10 +4309,12 @@ lpfc_create_port(struct lpfc_hba *phba, int instance, struct device *dev)
 	shost->max_cmd_len = 16;
 
 	if (phba->sli_rev == LPFC_SLI_REV4) {
-		if (phba->cfg_fcp_io_sched == LPFC_FCP_SCHED_BY_HDWQ)
-			shost->nr_hw_queues = phba->cfg_hdw_queue;
-		else
-			shost->nr_hw_queues = phba->sli4_hba.num_present_cpu;
+		if (!phba->cfg_fcp_mq_threshold ||
+		    phba->cfg_fcp_mq_threshold > phba->cfg_hdw_queue)
+			phba->cfg_fcp_mq_threshold = phba->cfg_hdw_queue;
+
+		shost->nr_hw_queues = min_t(int, 2 * num_possible_nodes(),
+					    phba->cfg_fcp_mq_threshold);
 
 		shost->dma_boundary =
 			phba->sli4_hba.pc_sli4_params.sge_supp_len-1;
diff --git a/drivers/scsi/lpfc/lpfc_sli4.h b/drivers/scsi/lpfc/lpfc_sli4.h
index 3aeca387b22a..329f7aa7e169 100644
--- a/drivers/scsi/lpfc/lpfc_sli4.h
+++ b/drivers/scsi/lpfc/lpfc_sli4.h
@@ -44,6 +44,11 @@
 #define LPFC_HBA_HDWQ_MAX	128
 #define LPFC_HBA_HDWQ_DEF	0
 
+/* FCP MQ queue count limiting */
+#define LPFC_FCP_MQ_THRESHOLD_MIN	0
+#define LPFC_FCP_MQ_THRESHOLD_MAX	128
+#define LPFC_FCP_MQ_THRESHOLD_DEF	8
+
 /* Common buffer size to accomidate SCSI and NVME IO buffers */
 #define LPFC_COMMON_IO_BUF_SZ	768
 
-- 
2.13.7

