Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B08E2E896C
	for <lists+linux-scsi@lfdr.de>; Sun,  3 Jan 2021 01:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbhACARc (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 2 Jan 2021 19:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbhACARc (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 2 Jan 2021 19:17:32 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C996EC0613C1
        for <linux-scsi@vger.kernel.org>; Sat,  2 Jan 2021 16:16:51 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id iq13so7684888pjb.3
        for <linux-scsi@vger.kernel.org>; Sat, 02 Jan 2021 16:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JgjUe5w4slwLjxbuMZGbJaaBWik0mmAnLfFJ73jPLKI=;
        b=FBNCoNFMwklCmvxSfy5O1CiVPsRzHf1xOvQHTPyAeuEUAuCMGbgvKDYWO2vBOJcbgf
         GEALpNtiK2ZsqwNAHoyzssJ16DF3z6cMuSOrn10GMfY42LsQyTi0GfJgL2DmFLUqLeTE
         ekB54ppuCsii3M2li3nhghXREuEYfbJSxv5VPMKArhdkJthBuUPENG5C445F2sODw9Yi
         wbFdRfo4GiWKI0Db+ZEcYEkwfHy80v2QjkHlqjkyfqpVe37vcRFvmqiEh9nceOUUyq5x
         Om5gtQ8eEliSF8EGCQarYUeA6Fg+U5dSTHOfvoyxGAiDUvxOVtlr5VReWybNh9+GIEjd
         gxxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JgjUe5w4slwLjxbuMZGbJaaBWik0mmAnLfFJ73jPLKI=;
        b=oddnoE111RgQhiSUz/boVjDGDV+XnLq4mK7TAqnBoQaz63FY5cjSGqdpOhjgx7DrSc
         KUsqi6UUXBJd/gFDSm4QvZzJpMx/KrPTuuR2kwTiuJyx//Q+e4m24laNI+2zRzwdhypS
         hYBrWbnJIN9T8bKHbKyJ3K+EkGHWiByKEpwOm6VOUvRZLt4ZtSEm2tICDoBYophe0Gih
         iFAts+4syK1Uvf650Qhqny26ugOExsrEwq9ppzy8n5ec9O6x4ac+WBnLqmGHgeeKCs/W
         a+qR7iYKM5+o9H8sq/eJVnDQe2F5AofTnPQJ3WSO6PIRQtyC9EPRdXIv2VslpGAnZ6ZF
         p2Tw==
X-Gm-Message-State: AOAM530XtgnceDpmbgKQuAYXo9c4dRd/fSpKd2If/SBuzru+frjIx5PO
        3UIx5DIsQk7FqnPoFAE8pN6pIskG68A=
X-Google-Smtp-Source: ABdhPJzxjkNrhJfqXkK6BdSnmxAjCIS2sMTmXrY580pjkyTSOw/aFpFnXFQy/PuZ9al0eIj/Brv1dw==
X-Received: by 2002:a17:902:ee0b:b029:db:c808:ccef with SMTP id z11-20020a170902ee0bb02900dbc808ccefmr66724239plb.85.1609633011236;
        Sat, 02 Jan 2021 16:16:51 -0800 (PST)
Received: from localhost.localdomain ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id q12sm55671867pgj.24.2021.01.02.16.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jan 2021 16:16:50 -0800 (PST)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH 01/15] lpfc: Fix PLOGI S_ID of 0 on pt2pt config
Date:   Sat,  2 Jan 2021 16:16:25 -0800
Message-Id: <20210103001639.1995-2-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210103001639.1995-1-jsmart2021@gmail.com>
References: <20210103001639.1995-1-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Under some pt2pt situations, the other end of the link may issue a LOGO
after successfully completing PLOGI and assigning addresses to the port.
Thus the driver may attempt a new PLOGI to re-create the login, but the
LOGO handling cleared the address back to 0. Once this happens, the other
end, which may be address 0, gets all confused and this cannot be
resolved without an administrative action to bounce the link.

Fix by assuming that address assignment only occurs on the 1st PLOGI
after link up, and regardless of login state, the address assignment
sticks.  The FC standards aren't particularly clear in this situation
(it only describes initial PLOGI), but there is nothing that contradicts
this and behaviors on the devices tested appears to conform to the
understanding.

Thus, don't reset the port address to 0 as part of LOGO handling. Port
addresses will only reset on link down.

Co-developed-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc_els.c | 31 +++++--------------------------
 1 file changed, 5 insertions(+), 26 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index 96c087b8b474..e099caa04535 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -2815,7 +2815,6 @@ lpfc_cmpl_els_logo(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	struct lpfc_nodelist *ndlp = (struct lpfc_nodelist *) cmdiocb->context1;
 	struct lpfc_vport *vport = ndlp->vport;
 	IOCB_t *irsp;
-	struct lpfcMboxq *mbox;
 	unsigned long flags;
 	uint32_t skip_recovery = 0;
 
@@ -2884,31 +2883,11 @@ lpfc_cmpl_els_logo(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	lpfc_els_free_iocb(phba, cmdiocb);
 	lpfc_nlp_put(ndlp);
 
-	/* If we are in pt2pt mode, we could rcv new S_ID on PLOGI */
-	if ((vport->fc_flag & FC_PT2PT) &&
-		!(vport->fc_flag & FC_PT2PT_PLOGI)) {
-		phba->pport->fc_myDID = 0;
-
-		if ((vport->cfg_enable_fc4_type == LPFC_ENABLE_BOTH) ||
-		    (vport->cfg_enable_fc4_type == LPFC_ENABLE_NVME)) {
-			if (phba->nvmet_support)
-				lpfc_nvmet_update_targetport(phba);
-			else
-				lpfc_nvme_update_localport(phba->pport);
-		}
-
-		mbox = mempool_alloc(phba->mbox_mem_pool, GFP_KERNEL);
-		if (mbox) {
-			lpfc_config_link(phba, mbox);
-			mbox->mbox_cmpl = lpfc_sli_def_mbox_cmpl;
-			mbox->vport = vport;
-			if (lpfc_sli_issue_mbox(phba, mbox, MBX_NOWAIT) ==
-				MBX_NOT_FINISHED) {
-				mempool_free(mbox, phba->mbox_mem_pool);
-				skip_recovery = 1;
-			}
-		}
-	}
+	/* At this point, the LOGO processing is complete. NOTE: For a
+	 * pt2pt topology, we are assuming the NPortID will only change
+	 * on link up processing. For a LOGO / PLOGI initiated by the
+	 * Initiator, we are assuming the NPortID is not going to change.
+	 */
 
 	/*
 	 * If the node is a target, the handling attempts to recover the port.
-- 
2.26.2

