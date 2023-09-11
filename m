Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8A179A190
	for <lists+linux-scsi@lfdr.de>; Mon, 11 Sep 2023 05:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbjIKDCQ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 10 Sep 2023 23:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbjIKDCP (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 10 Sep 2023 23:02:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10F7B5
        for <linux-scsi@vger.kernel.org>; Sun, 10 Sep 2023 20:02:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D304AC433C7;
        Mon, 11 Sep 2023 03:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694401330;
        bh=rm8oAeml4Fso2EJJG0Mn8if0XSAptGJAfMiW/S0nT68=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fljarLCf+9kknbWgVHJ42jThCnw4pYyOaT9+KcF+AcClF5scFvjxyf/JozTJefxFX
         9hRJ+YREBSlh7BrYxClNU/s1wuT4eKrnwn0eUNU6mYWIJ/Vj/IuwzbgaNb+xcVUgYq
         yihsm482dqoCvKmde9NOgaAJELvODDmKqni1XeBImlaluSveu0xXPBsfPTj4FN1Ds0
         tmoDXPqHinODPgp3ZdhTqAHM2j/BZqGbIgV/ODN+TtTJi28Eym/+Wu2bUex53QMzLD
         bN26WCsaO238Ut7Jvip2XtGiYuRs34661lRmZ5ZDutOtTpwiAJ+MMDmZq6EmqtHbBF
         oobWJBPoRB6MQ==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     Jack Wang <jinpu.wang@ionos.com>
Subject: [PATCH 01/10] scsi: pm8001: Setup IRQs on resume
Date:   Mon, 11 Sep 2023 12:01:58 +0900
Message-ID: <20230911030207.242917-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911030207.242917-1-dlemoal@kernel.org>
References: <20230911030207.242917-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The function pm8001_pci_resume() only calls pm8001_request_irq() without
calling pm8001_setup_irq(). This causes the IRQ allocation to fail,
whihc leads all drives being removed from the system.

Fix this issue by integrating the code for pm8001_setup_irq() directly
inside pm8001_request_irq() so that msix setup is performed both during
normal initialization and resume operations.

Fixes: dbf9bfe61571 ("[SCSI] pm8001: add SAS/SATA HBA driver")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/scsi/pm8001/pm8001_init.c | 51 +++++++++++--------------------
 1 file changed, 17 insertions(+), 34 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index 5e5ce1e74c3b..443a3176c6c0 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -273,7 +273,6 @@ static irqreturn_t pm8001_interrupt_handler_intx(int irq, void *dev_id)
 	return ret;
 }
 
-static u32 pm8001_setup_irq(struct pm8001_hba_info *pm8001_ha);
 static u32 pm8001_request_irq(struct pm8001_hba_info *pm8001_ha);
 
 /**
@@ -294,13 +293,6 @@ static int pm8001_alloc(struct pm8001_hba_info *pm8001_ha,
 	pm8001_dbg(pm8001_ha, INIT, "pm8001_alloc: PHY:%x\n",
 		   pm8001_ha->chip->n_phy);
 
-	/* Setup Interrupt */
-	rc = pm8001_setup_irq(pm8001_ha);
-	if (rc) {
-		pm8001_dbg(pm8001_ha, FAIL,
-			   "pm8001_setup_irq failed [ret: %d]\n", rc);
-		goto err_out;
-	}
 	/* Request Interrupt */
 	rc = pm8001_request_irq(pm8001_ha);
 	if (rc)
@@ -1031,47 +1023,38 @@ static u32 pm8001_request_msix(struct pm8001_hba_info *pm8001_ha)
 }
 #endif
 
-static u32 pm8001_setup_irq(struct pm8001_hba_info *pm8001_ha)
-{
-	struct pci_dev *pdev;
-
-	pdev = pm8001_ha->pdev;
-
-#ifdef PM8001_USE_MSIX
-	if (pci_find_capability(pdev, PCI_CAP_ID_MSIX))
-		return pm8001_setup_msix(pm8001_ha);
-	pm8001_dbg(pm8001_ha, INIT, "MSIX not supported!!!\n");
-#endif
-	return 0;
-}
-
 /**
  * pm8001_request_irq - register interrupt
  * @pm8001_ha: our ha struct.
  */
 static u32 pm8001_request_irq(struct pm8001_hba_info *pm8001_ha)
 {
-	struct pci_dev *pdev;
+	struct pci_dev *pdev = pm8001_ha->pdev;
+#ifdef PM8001_USE_MSIX
 	int rc;
 
-	pdev = pm8001_ha->pdev;
+	if (pci_find_capability(pdev, PCI_CAP_ID_MSIX)) {
+		rc = pm8001_setup_msix(pm8001_ha);
+		if (rc) {
+			pm8001_dbg(pm8001_ha, FAIL,
+				   "pm8001_setup_irq failed [ret: %d]\n", rc);
+			return rc;
+		}
 
-#ifdef PM8001_USE_MSIX
-	if (pdev->msix_cap && pci_msi_enabled())
-		return pm8001_request_msix(pm8001_ha);
-	else {
-		pm8001_dbg(pm8001_ha, INIT, "MSIX not supported!!!\n");
-		goto intx;
+		if (pdev->msix_cap && pci_msi_enabled())
+			return pm8001_request_msix(pm8001_ha);
 	}
+
+	pm8001_dbg(pm8001_ha, INIT, "MSIX not supported!!!\n");
 #endif
 
-intx:
 	/* initialize the INT-X interrupt */
 	pm8001_ha->irq_vector[0].irq_id = 0;
 	pm8001_ha->irq_vector[0].drv_inst = pm8001_ha;
-	rc = request_irq(pdev->irq, pm8001_interrupt_handler_intx, IRQF_SHARED,
-		pm8001_ha->name, SHOST_TO_SAS_HA(pm8001_ha->shost));
-	return rc;
+
+	return request_irq(pdev->irq, pm8001_interrupt_handler_intx,
+			   IRQF_SHARED, pm8001_ha->name,
+			   SHOST_TO_SAS_HA(pm8001_ha->shost));
 }
 
 /**
-- 
2.41.0

