Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F228E25B4B
	for <lists+linux-scsi@lfdr.de>; Wed, 22 May 2019 02:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbfEVAtd (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 21 May 2019 20:49:33 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36537 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728153AbfEVAtb (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 21 May 2019 20:49:31 -0400
Received: by mail-pl1-f195.google.com with SMTP id d21so180409plr.3
        for <linux-scsi@vger.kernel.org>; Tue, 21 May 2019 17:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xmLUUzk8AUHFUinh2BQF66VpDpUdo6v5ekPIei2arX4=;
        b=qqj9v4XpstD7S3RwDNY8kc1oSlhjXnVoA02XK34vcv4wcf+KCl7o0aMoICU4NoVUdZ
         TaTlr1Kw5Wa7EM2NMZadokPmkBCsW55yeP1bkjnICz6/GIw/NyJyjlhKWw37FVECcLdh
         flWRlNNQVAJ6zgCyCuxjZ2Oh6U+vrU5wUeygJDABWS51aAqfUUeClvJ84jyS8ZvF0wHU
         zml0pMaa3eIka7G2WuVOlE5a4XO/iRu9DwpaoponIP1Gx+2EtDX667eRUWGfPaPT/qTR
         3mQJ71o6Wo0OrpUqdxiH7q5Wu5AZuqepGu46/WH5ZDhb7hEixHTAToaEc81p4PRw4mgy
         8sKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xmLUUzk8AUHFUinh2BQF66VpDpUdo6v5ekPIei2arX4=;
        b=U+waYKrWfIJuCffrh6gqAuF7dqWSC/rUsxdeW6nfQqFPq0WHUQHv8MoiuaV/Drg+FU
         FfiQDPJiH5PNtogrK46pZyHsvIifAT4GmHd/rVVr8KTenZNI0bHoVP8uDEF4nRaUfm5j
         XLczntkkO9KJHW9Fsd/tou82gPMl89PCN1MlPd6z+CGpdygIpZc/qwsdb7U7OHDzsoy5
         9Mdl2dpDpbdFZe8yV89ZLlY3cK7GGnZTZVDEC7WdwXIKt7hWPlp1Gk4fp0lS+klyCJdU
         PvMe/dsT1uwpR4puaDovfBLLdwSU3rZOl6aN4YJot/9ls6Jw64zdSWvQCB3li6XroayQ
         gbkw==
X-Gm-Message-State: APjAAAVAMD+iXe03SaAWlU2u0JM4lc/NcOzoKV/BQ/vLKg7YZi10lNMn
        TmIhLLLyWbKTHCDtWIpLTKTRJkWX
X-Google-Smtp-Source: APXvYqxsmBwJCOUwENOL9/D6OO6F21vyZWZ+Zk28WYm0JXYmJNuc5rugk/KVrSBP2ui6ZKMLYupi+A==
X-Received: by 2002:a17:902:b695:: with SMTP id c21mr87146086pls.160.1558486170033;
        Tue, 21 May 2019 17:49:30 -0700 (PDT)
Received: from pallmd1.broadcom.com ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j184sm22550121pge.83.2019.05.21.17.49.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 May 2019 17:49:29 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH 10/21] lpfc: Cancel queued work for an IO when processing a received ABTS.
Date:   Tue, 21 May 2019 17:49:00 -0700
Message-Id: <20190522004911.573-11-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190522004911.573-1-jsmart2021@gmail.com>
References: <20190522004911.573-1-jsmart2021@gmail.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

When queued work is executed posting a new command to the transport
the driver is reporting a null buffer.

The driver had received an ABTS which matched a command that had
been scheduled for delivery to the transport. The driver proceeded
to cancel the command, but the work item was never cancelled.

Fix by cancelling the queued work item. Also turns out the ABTS
response was not properly sending a BA_ACC, so set the flag to
send the ACC.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc_nvmet.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index 08c2c4e3515b..36e8d842d973 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -1766,6 +1766,7 @@ lpfc_nvmet_rcv_unsol_abort(struct lpfc_vport *vport,
 			nvmet_fc_rcv_fcp_abort(phba->targetport,
 					       &ctxp->ctx.fcp_req);
 		} else {
+			cancel_work_sync(&ctxp->ctxbuf->defer_work);
 			spin_lock_irqsave(&ctxp->ctxlock, iflag);
 			lpfc_nvmet_defer_release(phba, ctxp);
 			spin_unlock_irqrestore(&ctxp->ctxlock, iflag);
@@ -1777,7 +1778,7 @@ lpfc_nvmet_rcv_unsol_abort(struct lpfc_vport *vport,
 			lpfc_nvmet_sol_fcp_issue_abort(phba, ctxp, ctxp->sid,
 						       ctxp->oxid);
 
-		lpfc_sli4_seq_abort_rsp(vport, fc_hdr, 0);
+		lpfc_sli4_seq_abort_rsp(vport, fc_hdr, 1);
 		return 0;
 	}
 
-- 
2.13.7

