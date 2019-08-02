Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76D40801BA
	for <lists+linux-scsi@lfdr.de>; Fri,  2 Aug 2019 22:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388153AbfHBU0Y (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 2 Aug 2019 16:26:24 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42870 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728855AbfHBU0Y (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 2 Aug 2019 16:26:24 -0400
Received: by mail-pg1-f196.google.com with SMTP id t132so36598114pgb.9
        for <linux-scsi@vger.kernel.org>; Fri, 02 Aug 2019 13:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pXd5Sh59+0KWnvfDeF62XEU9kCcb/Oyc4pZRfeprjAg=;
        b=Q3CDbf3URre+fekQ969ksr0VifzmKkJEFjXFZxGvDy7DFfM4cQbatdMealqP3x1cCW
         6cePsA8Bpxz4zBov6l1Hhbft0E/go7sGFCvoQrLNyI8hKLqtzdhyKNGqqjNsUKBtxqNw
         YP/JaovRdtL3/6zlDGrQwIrDfCfHOgZjsurw9B6kR0N971yOgqRi/6k9W+1ldOiA5Poe
         EcKLO07SRiQkAEZei3oCHXar4M9SkVGfalQQo0xDam3UEEeueNXcF56ErLuNsFIPkdv7
         SRk7xs3TXX9dzgxBjLCXulzQkWSL3VA5OGYBycfkhi/ihM0Qq0YlFAg0i+LsPrfwwsV5
         gq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pXd5Sh59+0KWnvfDeF62XEU9kCcb/Oyc4pZRfeprjAg=;
        b=P4KTjRUIMH8M1LxqELMLPlCJlztdrdZfnnsUhwyeRFtF1ze8Gfzsr+fLBUq1gTYuLF
         1iSeP7I+5vvGpxQOwCTxWLr41oLxEwdOBlwyrIQfp5aIjlLnBs3Un99pPwd/21Yhp3Yj
         cK4XM2E6yJwObyNh1AlQOhVdP0tAf/MHPRo+Z7/EaC/TBMPSo3D2yXWMPZHHp/ucpBEO
         F84iUmrpLVZ6cL/SLa45zd2xmr55MvsBEIRNDOYZtD6utDwDbvUIWU8ZTyuMkQNdcO7y
         FGfFVmFK0X1tQFIAZaYAF/oAMSWT0n/SAWL1okBc4CvrAsSoExfNl9fe0DPHMG7htJAX
         Rn9g==
X-Gm-Message-State: APjAAAW3NWRwIQ73x5HUiVU1XenJCduFEpCYdvZmxXxgXoj4NsKdTgw1
        bvVW/e1kPYx/iSRIsemp168vt4rq
X-Google-Smtp-Source: APXvYqwnrLjyFuMadImLWfzRC6rtVPY5oRXeYYQ9FHHUiouIOerj1iILfJq3qEHhTpVCPkXSUofMFA==
X-Received: by 2002:a17:90a:e38f:: with SMTP id b15mr6142959pjz.85.1564777583716;
        Fri, 02 Aug 2019 13:26:23 -0700 (PDT)
Received: from pallmd1.broadcom.com ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id u24sm17720340pgk.31.2019.08.02.13.26.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 Aug 2019 13:26:23 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH] lpfc: Fix crash when cpu count is 1 and null irq affinity mask
Date:   Fri,  2 Aug 2019 13:26:12 -0700
Message-Id: <20190802202612.25799-1-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

When a configurations runs with a single cpu (such as a kdump kernel),
which causes the driver to request a single vector, when the driver
subsequently requests an irq affinity mask, the mask comes back null.
The driver currently does nothing in this scenario, which leaves
mappings to hardware queues incomplete and crashes the system.

Fix by recognizing the null mask and assigning the vector to the first
cpu in the system.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc_init.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 03998579d6ee..1ac98becb5ba 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -10778,12 +10778,31 @@ lpfc_cpu_affinity_check(struct lpfc_hba *phba, int vectors)
 	/* This loop sets up all CPUs that are affinitized with a
 	 * irq vector assigned to the driver. All affinitized CPUs
 	 * will get a link to that vectors IRQ and EQ.
+	 *
+	 * NULL affinity mask handling:
+	 * If irq count is greater than one, log an error message.
+	 * If the null mask is received for the first irq, find the
+	 * first present cpu, and assign the eq index to ensure at
+	 * least one EQ is assigned.
 	 */
 	for (idx = 0; idx <  phba->cfg_irq_chann; idx++) {
 		/* Get a CPU mask for all CPUs affinitized to this vector */
 		maskp = pci_irq_get_affinity(phba->pcidev, idx);
-		if (!maskp)
-			continue;
+		if (!maskp) {
+			if (phba->cfg_irq_chann > 1)
+				lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+						"3329 No affinity mask found "
+						"for vector %d (%d)\n",
+						idx, phba->cfg_irq_chann);
+			if (!idx) {
+				cpu = cpumask_first(cpu_present_mask);
+				cpup = &phba->sli4_hba.cpu_map[cpu];
+				cpup->eq = idx;
+				cpup->irq = pci_irq_vector(phba->pcidev, idx);
+				cpup->flag |= LPFC_CPU_FIRST_IRQ;
+			}
+			break;
+		}
 
 		i = 0;
 		/* Loop through all CPUs associated with vector idx */
-- 
2.13.7

