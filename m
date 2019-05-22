Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00D7A25B4E
	for <lists+linux-scsi@lfdr.de>; Wed, 22 May 2019 02:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbfEVAtd (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 21 May 2019 20:49:33 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40457 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728180AbfEVAtc (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 21 May 2019 20:49:32 -0400
Received: by mail-pf1-f196.google.com with SMTP id u17so339542pfn.7
        for <linux-scsi@vger.kernel.org>; Tue, 21 May 2019 17:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KrMD7sQ5G+C5wnNN4XWbWIzy+HEyYIkwcK0jX9ZMEkc=;
        b=eWh8PIkPASvY0ZzKiHfyGxhE7f6RyEItxXe2tTx4AAvBkDzTGwHLNqeJt8ylCie8qn
         hIfELP485FmSptqLSKSDuvefl2eT6hVvGuF4IHAgQaUuiY4e2gG7GFNmyrfFcCm7LnUy
         piJ9kgeWpofEw1xHJEn0o9msNUZBVexW5LvGaiShMQGFgJIrgHsVw4Sbw7lg/qvWYd0a
         /A7vQ0R/spILizQrp+HH7HV6x3XySfDETEpT8sM0fJwuGUKiryfFm2OTOHS9hg/TUhyO
         EnYpzHIyf14OfaISPdOtBtuE/zZRYhc1BN8Re3EFWLA+98KBgBeOjOiwKxZoc/t/ebyO
         HIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KrMD7sQ5G+C5wnNN4XWbWIzy+HEyYIkwcK0jX9ZMEkc=;
        b=lGYmm1swQZX1Uavi/4dOH777bXw8IvgzSjQjDEKqP/0XAYrJXFYmlNjYNaG9tthpOC
         bdCuhKuQuhBULfIx8xcenGlukbwv4aQXe336W9uy59g66mnUF8dyODno8XuqNqr66z6w
         K9tIn+mb4QNx1H/wNzKi1/xRIL0cdvU6QGmaE1ferXSW+o3C1yPDALdXu+2VVF9HhR8U
         XNvWfaKAHaaCmBuEaDPeLr0c+k5DVtn+THPmxBeCTOzP+eQDkBe4ZuyOU4aYSqC/1DN/
         lnMdkcK7OZZdb+ZGMRrE2QaF2CYCL1Ak9mofQ8HyepBx3NP6cJPe2zCyK6layQfTqBcy
         82/w==
X-Gm-Message-State: APjAAAUfRrok2HAhUXu9pJbfn2JF/piyher/YNG8gL5hb8QN2J73TUnB
        sOkS5apAgKe5UdXKNJvegedrlasq
X-Google-Smtp-Source: APXvYqxEv8uRN78Sop2EiwufBCV7M4T//6eyzcs0TKUlNUigVB2GPpkaNcVdSmBGDFdsNkxrAYfVwg==
X-Received: by 2002:a63:950d:: with SMTP id p13mr86873284pgd.269.1558486171684;
        Tue, 21 May 2019 17:49:31 -0700 (PDT)
Received: from pallmd1.broadcom.com ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j184sm22550121pge.83.2019.05.21.17.49.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 May 2019 17:49:31 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH 12/21] lpfc: Rework misleading nvme not supported in firmware message
Date:   Tue, 21 May 2019 17:49:02 -0700
Message-Id: <20190522004911.573-13-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190522004911.573-1-jsmart2021@gmail.com>
References: <20190522004911.573-1-jsmart2021@gmail.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The driver unconditionally says fw doesn't support nvme when in
truth it was a driver parameter settings that disabled nvme support.

Rework the code validating nvme support to accurately report what
condition is disabling nvme support. Save state on whether nvme
fw supports nvme in case sysfs attributes change dynamically.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc_init.c | 55 +++++++++++++++++++++++++++++--------------
 drivers/scsi/lpfc/lpfc_sli4.h |  1 +
 2 files changed, 38 insertions(+), 18 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 70afa585b027..1468a4d7c501 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -11333,24 +11333,43 @@ lpfc_get_sli4_parameters(struct lpfc_hba *phba, LPFC_MBOXQ_t *mboxq)
 					   mbx_sli4_parameters);
 	phba->sli4_hba.extents_in_use = bf_get(cfg_ext, mbx_sli4_parameters);
 	phba->sli4_hba.rpi_hdrs_in_use = bf_get(cfg_hdrr, mbx_sli4_parameters);
-	phba->nvme_support = (bf_get(cfg_nvme, mbx_sli4_parameters) &&
-			      bf_get(cfg_xib, mbx_sli4_parameters));
-
-	if ((phba->cfg_enable_fc4_type == LPFC_ENABLE_FCP) ||
-	    !phba->nvme_support) {
-		phba->nvme_support = 0;
-		phba->nvmet_support = 0;
-		phba->cfg_nvmet_mrq = 0;
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT | LOG_NVME,
-				"6101 Disabling NVME support: "
-				"Not supported by firmware: %d %d\n",
-				bf_get(cfg_nvme, mbx_sli4_parameters),
-				bf_get(cfg_xib, mbx_sli4_parameters));
-
-		/* If firmware doesn't support NVME, just use SCSI support */
-		if (!(phba->cfg_enable_fc4_type & LPFC_ENABLE_FCP))
-			return -ENODEV;
-		phba->cfg_enable_fc4_type = LPFC_ENABLE_FCP;
+
+	/* Check for firmware nvme support */
+	rc = (bf_get(cfg_nvme, mbx_sli4_parameters) &&
+		     bf_get(cfg_xib, mbx_sli4_parameters));
+
+	if (rc) {
+		/* Save this to indicate the Firmware supports NVME */
+		sli4_params->nvme = 1;
+
+		/* Firmware NVME support, check driver FC4 NVME support */
+		if (phba->cfg_enable_fc4_type == LPFC_ENABLE_FCP) {
+			lpfc_printf_log(phba, KERN_INFO, LOG_INIT | LOG_NVME,
+					"6133 Disabling NVME support: "
+					"FC4 type not supported: x%x\n",
+					phba->cfg_enable_fc4_type);
+			goto fcponly;
+		}
+	} else {
+		/* No firmware NVME support, check driver FC4 NVME support */
+		sli4_params->nvme = 0;
+		if (phba->cfg_enable_fc4_type & LPFC_ENABLE_NVME) {
+			lpfc_printf_log(phba, KERN_ERR, LOG_INIT | LOG_NVME,
+					"6101 Disabling NVME support: Not "
+					"supported by firmware (%d %d) x%x\n",
+					bf_get(cfg_nvme, mbx_sli4_parameters),
+					bf_get(cfg_xib, mbx_sli4_parameters),
+					phba->cfg_enable_fc4_type);
+fcponly:
+			phba->nvme_support = 0;
+			phba->nvmet_support = 0;
+			phba->cfg_nvmet_mrq = 0;
+
+			/* If no FC4 type support, move to just SCSI support */
+			if (!(phba->cfg_enable_fc4_type & LPFC_ENABLE_FCP))
+				return -ENODEV;
+			phba->cfg_enable_fc4_type = LPFC_ENABLE_FCP;
+		}
 	}
 
 	/* Only embed PBDE for if_type 6, PBDE support requires xib be set */
diff --git a/drivers/scsi/lpfc/lpfc_sli4.h b/drivers/scsi/lpfc/lpfc_sli4.h
index 12ffe5736921..8b28a55c73bb 100644
--- a/drivers/scsi/lpfc/lpfc_sli4.h
+++ b/drivers/scsi/lpfc/lpfc_sli4.h
@@ -514,6 +514,7 @@ struct lpfc_pc_sli4_params {
 #define LPFC_WQ_SZ64_SUPPORT	1
 #define LPFC_WQ_SZ128_SUPPORT	2
 	uint8_t wqpcnt;
+	uint8_t nvme;
 };
 
 #define LPFC_CQ_4K_PAGE_SZ	0x1
-- 
2.13.7

