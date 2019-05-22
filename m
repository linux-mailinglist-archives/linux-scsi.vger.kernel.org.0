Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7F4425B43
	for <lists+linux-scsi@lfdr.de>; Wed, 22 May 2019 02:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbfEVAtZ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 21 May 2019 20:49:25 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44265 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbfEVAtY (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 21 May 2019 20:49:24 -0400
Received: by mail-pg1-f195.google.com with SMTP id n2so356649pgp.11
        for <linux-scsi@vger.kernel.org>; Tue, 21 May 2019 17:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yqgMSY9XAdmgbcg91K4UDyttzUETrPM5p9LWDQpbA7k=;
        b=B1mbj72E/5FTs9NJxKrQf1WGK/vfsNJp9ijfHzz8HJbpwLyo4d0LzKKRSm/91BMx1v
         5gwtjbZ2qCkKRUtmpJh3CozX05LMdJNoZHcfxmKXNGAH8zGuhBPqeLj7ashJeuq2CwKX
         2BKnICNmVz7Lx+WkG9WoahQ+kpYojxKmjSddmlgCHtOCBwQDTRK1Q6XM/303jYkVAcYV
         GCaTpLxfCYdb0qdLccWQEohIj48z94KwZQdu+hpa+EJE5zqX4GIWZUr8JzN20PdLg5Mt
         tLgEfSZBza1FJup0JOF7o2ArnWfg5NqEHtuo6QULdwBCo4fCa69GGzlRubtSd1OYD5Bo
         oFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yqgMSY9XAdmgbcg91K4UDyttzUETrPM5p9LWDQpbA7k=;
        b=cl0sEk40uylOZPKFYG1JGw78zzG6H0bUk42Mdg0e14VYJp03Zi6JCitqFyV6mz+jVX
         YBUt2Cr0CQu4lEMQuDquHkY+bE+6NKsXCynz3slaGna4DDwCh1zgwTzCbZiaKtgDDON7
         jCjx6JvWCvRVe8Dfe53MZy1n3+FQp6pGQqeXSisXCmuIhn0dF7ASP41PdP8Daj82o0kJ
         PIo+sKQDK99pONdDWtAjtyFnrbeBvN1oQN2Nps8TN4n1TRJL1xdwkia4WQ57efl50lG6
         YAxAOvTsfZbfyOlBqS5ZHuEMYXQLsUCKOxx8kaveKCAGh4FAqluVGtO+FDboN6q3FTz9
         AYvA==
X-Gm-Message-State: APjAAAUFveMehWFRMO8U+BqecCOIknwgEB00h1UTSH9lL0ZqCwjTZtJw
        iRKlTsx22QFVutQBBrLF3YcpUsML
X-Google-Smtp-Source: APXvYqxhX4vPmoWno/4v0sols97gqdE5LwvVyZQ+mSBwHQ3QMaj/pXfoTPqwNapknQglmqcEvAL6sw==
X-Received: by 2002:a63:ff0f:: with SMTP id k15mr85096157pgi.407.1558486163819;
        Tue, 21 May 2019 17:49:23 -0700 (PDT)
Received: from pallmd1.broadcom.com ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j184sm22550121pge.83.2019.05.21.17.49.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 May 2019 17:49:23 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH 02/21] lpfc: Fix nvmet target abort cmd matching
Date:   Tue, 21 May 2019 17:48:52 -0700
Message-Id: <20190522004911.573-3-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190522004911.573-1-jsmart2021@gmail.com>
References: <20190522004911.573-1-jsmart2021@gmail.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

After receiving an unsolicited ABTS (meaning rxid is 0xFFFF), the
driver used the oxid from the initiator to match against a local
xri which may have been allocated for the io. The xri would be the
rxid - it's an invalid check resulting in the command not being
matched or erroneously matched.

Change the lookup to use the oxid and the SID to match against
received IO's original values.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc_nvmet.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index d74bfd264495..c9011579aa0f 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -1497,6 +1497,7 @@ void
 lpfc_sli4_nvmet_xri_aborted(struct lpfc_hba *phba,
 			    struct sli4_wcqe_xri_aborted *axri)
 {
+#if (IS_ENABLED(CONFIG_NVME_TARGET_FC))
 	uint16_t xri = bf_get(lpfc_wcqe_xa_xri, axri);
 	uint16_t rxid = bf_get(lpfc_wcqe_xa_remote_xid, axri);
 	struct lpfc_nvmet_rcv_ctx *ctxp, *next_ctxp;
@@ -1562,6 +1563,7 @@ lpfc_sli4_nvmet_xri_aborted(struct lpfc_hba *phba,
 	}
 	spin_unlock(&phba->sli4_hba.abts_nvmet_buf_list_lock);
 	spin_unlock_irqrestore(&phba->hbalock, iflag);
+#endif
 }
 
 int
@@ -1572,19 +1574,23 @@ lpfc_nvmet_rcv_unsol_abort(struct lpfc_vport *vport,
 	struct lpfc_hba *phba = vport->phba;
 	struct lpfc_nvmet_rcv_ctx *ctxp, *next_ctxp;
 	struct nvmefc_tgt_fcp_req *rsp;
+	uint32_t sid;
 	uint16_t xri;
 	unsigned long iflag = 0;
 
 	xri = be16_to_cpu(fc_hdr->fh_ox_id);
+	sid = sli4_sid_from_fc_hdr(fc_hdr);
 
 	spin_lock_irqsave(&phba->hbalock, iflag);
 	spin_lock(&phba->sli4_hba.abts_nvmet_buf_list_lock);
 	list_for_each_entry_safe(ctxp, next_ctxp,
 				 &phba->sli4_hba.lpfc_abts_nvmet_ctx_list,
 				 list) {
-		if (ctxp->ctxbuf->sglq->sli4_xritag != xri)
+		if (ctxp->oxid != xri || ctxp->sid != sid)
 			continue;
 
+		xri = ctxp->ctxbuf->sglq->sli4_xritag;
+
 		spin_unlock(&phba->sli4_hba.abts_nvmet_buf_list_lock);
 		spin_unlock_irqrestore(&phba->hbalock, iflag);
 
@@ -1613,7 +1619,7 @@ lpfc_nvmet_rcv_unsol_abort(struct lpfc_vport *vport,
 			 xri, raw_smp_processor_id(), 1);
 
 	lpfc_printf_log(phba, KERN_INFO, LOG_NVME_ABTS,
-			"6320 NVMET Rcv ABTS:rjt xri x%x\n", xri);
+			"6320 NVMET Rcv ABTS:rjt xid x%x\n", xri);
 
 	/* Respond with BA_RJT accordingly */
 	lpfc_sli4_seq_abort_rsp(vport, fc_hdr, 0);
-- 
2.13.7

