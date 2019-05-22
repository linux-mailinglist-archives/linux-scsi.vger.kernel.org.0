Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8F1225B45
	for <lists+linux-scsi@lfdr.de>; Wed, 22 May 2019 02:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbfEVAt0 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 21 May 2019 20:49:26 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45315 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbfEVAt0 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 21 May 2019 20:49:26 -0400
Received: by mail-pg1-f194.google.com with SMTP id i21so355064pgi.12
        for <linux-scsi@vger.kernel.org>; Tue, 21 May 2019 17:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wB7NADiRW3dEmTOyxx6TXaa0Cw9K2E6Iq3U4WtpT5gg=;
        b=Z2KQq+0oX83Rg4SqNAhZDl0PVs32Bjf7k4V1FGaSIHqj80Fu/UfftKUiFAvFSbpnwx
         GTLl6HqjwWn0GJc1zYKZ28NiTJMoH9uzi81HIRHhQ2QPnJRZDDTvj7eEq7tX8vUgOcMJ
         Vu15mDqF7XHpfCnQuazXt2gOb1mRHqqedgSBDhQoUxHsAoK8i4EUlGEai7JWMk/Yzd9E
         6YvbOOGnQcEKoGAX7YPpI8IXgdJHC6KHEJfPGHh1XZ+I2Nr6Jqv5BC7Km2UrbU4nAHWK
         LptBi70mCy8iwm+d093cL0gHzeq3W77fSZ8aTtTRgMeSUFn5BzpuQ5v8F6QR2XlEYu9i
         ar8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wB7NADiRW3dEmTOyxx6TXaa0Cw9K2E6Iq3U4WtpT5gg=;
        b=iLMEjhLqSY9reQuN7bmPkmirxdinS695cRLgxGUl3kxQpX1dvu9M/g/FrlIN4mtpEp
         jsugP+N53bGns1HkG8RDaCRzJ42Lfz3xZlmn4Z/PeVfWO5ZO1j3OQb4lSmqtH6dSBy4C
         CjxDHGhJID+3oWwBRdkvTA+SvqexHa5M6EDhGTB1fxogoJxzJ89TM5ZX9ifF9KCGMyEB
         ULCaMk7J/1xECgvhOvFXdDGTgh6ukLyhfanu46ZTAQnnZFeDGlIRXqQJD9ZnwgIA8l6x
         +RZrXsRMCeHnrX5PMQj57bE1jXZv4Hx05+Ks8ysGruHdMAzAQMFy9EUZTIQdODJSrSwz
         kysA==
X-Gm-Message-State: APjAAAXukkh48aFYmr3uLDX4YE6fVniKM6ybDTllQaws++j3ePPVMBYU
        kUxLGkpbnX94CCAmDce88rMx9Pkl
X-Google-Smtp-Source: APXvYqw/VXWQmVlkyIrAAiFwjZo4YAI7nYrjc4E3/1LkB0sPzZ4lhAV8+8vFoFsse1S2yUVTvmx+qQ==
X-Received: by 2002:a63:f146:: with SMTP id o6mr86503001pgk.179.1558486165417;
        Tue, 21 May 2019 17:49:25 -0700 (PDT)
Received: from pallmd1.broadcom.com ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j184sm22550121pge.83.2019.05.21.17.49.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 May 2019 17:49:25 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH 04/21] lpfc: Revise message when stuck due to unresponsive adapter
Date:   Tue, 21 May 2019 17:48:54 -0700
Message-Id: <20190522004911.573-5-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190522004911.573-1-jsmart2021@gmail.com>
References: <20190522004911.573-1-jsmart2021@gmail.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Revise a stalled adapter message to also include the number of jobs
that are stalling the thread.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc_nvme.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
index 9d99cb915390..39514d4c279d 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -2143,7 +2143,9 @@ lpfc_nvme_lport_unreg_wait(struct lpfc_vport *vport,
 			   struct completion *lport_unreg_cmp)
 {
 	u32 wait_tmo;
-	int ret;
+	int ret, i, pending = 0;
+	struct lpfc_sli_ring  *pring;
+	struct lpfc_hba  *phba = vport->phba;
 
 	/* Host transport has to clean up and confirm requiring an indefinite
 	 * wait. Print a message if a 10 second wait expires and renew the
@@ -2153,10 +2155,18 @@ lpfc_nvme_lport_unreg_wait(struct lpfc_vport *vport,
 	while (true) {
 		ret = wait_for_completion_timeout(lport_unreg_cmp, wait_tmo);
 		if (unlikely(!ret)) {
+			pending = 0;
+			for (i = 0; i < phba->cfg_hdw_queue; i++) {
+				pring = phba->sli4_hba.hdwq[i].nvme_wq->pring;
+				if (!pring)
+					continue;
+				if (pring->txcmplq_cnt)
+					pending += pring->txcmplq_cnt;
+			}
 			lpfc_printf_vlog(vport, KERN_ERR, LOG_NVME_IOERR,
 					 "6176 Lport %p Localport %p wait "
-					 "timed out. Renewing.\n",
-					 lport, vport->localport);
+					 "timed out. Pending %d. Renewing.\n",
+					 lport, vport->localport, pending);
 			continue;
 		}
 		break;
-- 
2.13.7

