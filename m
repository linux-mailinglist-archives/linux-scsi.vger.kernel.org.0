Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 702DF7B67E
	for <lists+linux-scsi@lfdr.de>; Wed, 31 Jul 2019 02:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbfGaAIG (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 30 Jul 2019 20:08:06 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42076 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfGaAIG (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 30 Jul 2019 20:08:06 -0400
Received: by mail-pg1-f196.google.com with SMTP id t132so30902968pgb.9
        for <linux-scsi@vger.kernel.org>; Tue, 30 Jul 2019 17:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+pr19sAtvJiG2lnIbrgkMW1M0VdKkC/b2Q5Z+hvu1tM=;
        b=NyY9LTatnmTalZvkgVkdDZ9tJ+V9IdSrsboaVHf5BiSs9VW6KG9uo2xj0N0R4HCwKv
         HdrHxHg+N133Q6WBlBCUeCnBcyllmzrrLM9mTHTFDpOoiRstQmHOx/JBVAH74i25ThrP
         JslgS4VmZrzFJEaCET36l9v9pIu7siH7QGqjpusL7+zjBL6eDMBGG1E7WoT+b9Snbg4t
         v4Ml9cFXeU0ofz1zhjy1QTEXl52ApxBDUt6TjYRpDxUc32t7wVuj/2Ds9OqEjdRj4VGy
         vfH1mk2k3c8JtTB7YExGVAPgVA9w6775KP9/P+Tt4zXGjLPm0EfqmA7Jn/LnbYCOFmVV
         USkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+pr19sAtvJiG2lnIbrgkMW1M0VdKkC/b2Q5Z+hvu1tM=;
        b=Z2LIj05Phu9qr/JSVfyLmgKw34npKB1ANr/J/19nEEGeHBVjyvsiTkEXBv3DaIeDlG
         cGUcXo2/6rVOfzgTFgXiAXkrHbS2w9ztWMCZc8Pr8ZT5iWzIcb/h3jhO1Jqj268DOx8W
         a7TisU8dIVDiaq2QDg4eSY9JJLz8jVvJqyzTGSWoeMgGZUY9mrcFvZ21HBh+50pl86RL
         KIB11S2RRkNWAkGsvJ3GiN786U904Rr5CiCVLYHHpd2bSZvlobjLaT53vARS+MOuaaQs
         WZboiNXuWj6Ut8JzwrOAMgZ0xNuUf2atOnmQftNXxBXE17knkYa5FUD4POq1+7o7TmuQ
         1XjA==
X-Gm-Message-State: APjAAAUZFcTQAF5JYJmdmK+EsR/0QUT03Mkvo2pt63eanXkfubVO1oB1
        2BSGImZQ2066abibswuHoN8Q/mgZ
X-Google-Smtp-Source: APXvYqx3dgkNdO6M1AoxLnCpinhykguIxR0R8HKvGP68VcuJ6HxGRgPYxGsu2gYKrAXDyJwCQ7zsUw==
X-Received: by 2002:a63:e48:: with SMTP id 8mr23908758pgo.389.1564531685222;
        Tue, 30 Jul 2019 17:08:05 -0700 (PDT)
Received: from os42.localdomain ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id n5sm69544468pfn.38.2019.07.30.17.08.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Jul 2019 17:08:04 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH] lpfc: Mitigate high memory pre-allocation by SCSI-MQ
Date:   Tue, 30 Jul 2019 17:07:59 -0700
Message-Id: <20190731000759.6272-1-jsmart2021@gmail.com>
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
---
 drivers/scsi/lpfc/lpfc.h      |  1 +
 drivers/scsi/lpfc/lpfc_attr.c | 17 +++++++++++++++++
 drivers/scsi/lpfc/lpfc_init.c | 12 ++++++++----
 drivers/scsi/lpfc/lpfc_sli4.h |  5 +++++
 4 files changed, 31 insertions(+), 4 deletions(-)

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
index ea62322ffe2b..d267f57d1738 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -5709,6 +5709,19 @@ LPFC_ATTR_RW(nvme_embed_cmd, 1, 0, 2,
 	     "Embed NVME Command in WQE");
 
 /*
+ * lpfc_fcp_mq_threshold: Set the number of Hardware Queues the driver
+ * will advertise it supports to the SCSI layer.
+ *
+ *      0    = Configure nr_hw_queues by the number of CPUs or HW queues.
+ *      1,128 = Manually specify nr_hw_queue value to be advertised,
+ *
+ * Value range is [0,128]. Default value is 4.
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
@@ -7135,6 +7150,8 @@ lpfc_get_cfgparam(struct lpfc_hba *phba)
 	phba->cfg_enable_pbde = 0;
 
 	/* A value of 0 means use the number of CPUs found in the system */
+	if (phba->cfg_fcp_mq_threshold == 0)
+		phba->cfg_fcp_mq_threshold = phba->sli4_hba.num_present_cpu;
 	if (phba->cfg_hdw_queue == 0)
 		phba->cfg_hdw_queue = phba->sli4_hba.num_present_cpu;
 	if (phba->cfg_irq_chann == 0)
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index faf43b1d3dbe..3e387ee95610 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -4309,10 +4309,14 @@ lpfc_create_port(struct lpfc_hba *phba, int instance, struct device *dev)
 	shost->max_cmd_len = 16;
 
 	if (phba->sli_rev == LPFC_SLI_REV4) {
-		if (phba->cfg_fcp_io_sched == LPFC_FCP_SCHED_BY_HDWQ)
-			shost->nr_hw_queues = phba->cfg_hdw_queue;
-		else
-			shost->nr_hw_queues = phba->sli4_hba.num_present_cpu;
+		if (phba->cfg_fcp_mq_threshold > phba->sli4_hba.num_present_cpu)
+			phba->cfg_fcp_mq_threshold =
+				phba->sli4_hba.num_present_cpu;
+		if (phba->cfg_fcp_io_sched == LPFC_FCP_SCHED_BY_HDWQ &&
+		    phba->cfg_fcp_mq_threshold > phba->cfg_hdw_queue)
+			phba->cfg_fcp_mq_threshold = phba->cfg_hdw_queue;
+
+		shost->nr_hw_queues = phba->cfg_fcp_mq_threshold;
 
 		shost->dma_boundary =
 			phba->sli4_hba.pc_sli4_params.sge_supp_len-1;
diff --git a/drivers/scsi/lpfc/lpfc_sli4.h b/drivers/scsi/lpfc/lpfc_sli4.h
index 3aeca387b22a..ccd0392720e3 100644
--- a/drivers/scsi/lpfc/lpfc_sli4.h
+++ b/drivers/scsi/lpfc/lpfc_sli4.h
@@ -44,6 +44,11 @@
 #define LPFC_HBA_HDWQ_MAX	128
 #define LPFC_HBA_HDWQ_DEF	0
 
+/* FCP MQ queue count limiting */
+#define LPFC_FCP_MQ_THRESHOLD_MIN	0
+#define LPFC_FCP_MQ_THRESHOLD_MAX	128
+#define LPFC_FCP_MQ_THRESHOLD_DEF	4
+
 /* Common buffer size to accomidate SCSI and NVME IO buffers */
 #define LPFC_COMMON_IO_BUF_SZ	768
 
-- 
2.13.7

