Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3E925B4C
	for <lists+linux-scsi@lfdr.de>; Wed, 22 May 2019 02:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbfEVAte (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 21 May 2019 20:49:34 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43744 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728183AbfEVAtd (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 21 May 2019 20:49:33 -0400
Received: by mail-pf1-f196.google.com with SMTP id c6so333064pfa.10
        for <linux-scsi@vger.kernel.org>; Tue, 21 May 2019 17:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SUnKxYhAN4+6nBCP66ac/DR2LVbWpgldXGaWm9XnYVc=;
        b=aVKtql943TpBlUIy5qkdhDePyep7hSJUEpbuSPA5h5G5Tg6bmaMOI8hDx2gMW0NTNb
         4us5U2eCGCQfYraTpdBi/AvmXPVFlAttPn3iKERrvL160gOyw69nncfPqsJhr1djcmHj
         XWO8NqV7rALLOaj9XiLNqqZ7lRNzrjZfrWAXYy0+g5i4Uv8jbG4U6yNssVHTy+MVr2GA
         jXpAFh5H0HIPlpOkGPspCqHayPIxajQGw6lezDNhi6yT/i14MtRZgYwMdzvbeOLDynTj
         WVHxc5OexiTV94KAHf6P6BlVTgGPV7o9s0kcbvYgJKX5xXMv0BSEMVHkKZVjzwBnbxOf
         rUBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SUnKxYhAN4+6nBCP66ac/DR2LVbWpgldXGaWm9XnYVc=;
        b=uPyMEZqQJiNXQLkeMWqiJ04QSwEsvnsNLAaTic1onf9pn71IlfdGOHpieDUwj1ba0Q
         se87+YVP9Qg+FaRDNZkh5GwqZFjqrbZ1kMs5hFLUeR5wZvtxMoLfxPxGtnvmkvhM0NMc
         Bbs2KMJjbzEssv2wEDb2B1z1OWU+jzcTJhuU4vy6ZF1fCz2I/3iQOKwZqB4syzE+RprW
         Ces7dZxCgCW+w/U6/8s8obzOdEuPmLsDyf8PXLVY3oL3msaCbJnTe4y5Pc2eSTpXlaio
         lJZe5dydExoVrNFS8Ip3qIb3IfU1E9qIZS3FD08tpjZKjdNe4YdQ6E9EhX7wFZ/i2/1D
         +94w==
X-Gm-Message-State: APjAAAV9HBNnAvxelimCLoh9WTuJrgEoYHll4DUzhzja5KaWkHQ0JqoZ
        wAtNiF4bXqgRKohKf8wvSjzautVd
X-Google-Smtp-Source: APXvYqzDBdP8in6oWYiykKLWCwUKzUQ/tu1JKyRAYHyMqwLfVuMmLviiwCByOnGjDSooBHn1gLH2sg==
X-Received: by 2002:a62:e201:: with SMTP id a1mr91429127pfi.67.1558486172375;
        Tue, 21 May 2019 17:49:32 -0700 (PDT)
Received: from pallmd1.broadcom.com ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j184sm22550121pge.83.2019.05.21.17.49.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 May 2019 17:49:32 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH 13/21] lpfc: Fix memory leak in abnormal exit path from lpfc_eq_create.
Date:   Tue, 21 May 2019 17:49:03 -0700
Message-Id: <20190522004911.573-14-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190522004911.573-1-jsmart2021@gmail.com>
References: <20190522004911.573-1-jsmart2021@gmail.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

eq create is leaking mailbox memory if it encounters an error.

rework error path to free the memory.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc_sli.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 946f3024d4db..4432060f7315 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -14641,8 +14641,10 @@ lpfc_eq_create(struct lpfc_hba *phba, struct lpfc_queue *eq, uint32_t imax)
 		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
 				"0360 Unsupported EQ count. (%d)\n",
 				eq->entry_count);
-		if (eq->entry_count < 256)
-			return -EINVAL;
+		if (eq->entry_count < 256) {
+			status = -EINVAL;
+			goto out;
+		}
 		/* fall through - otherwise default to smallest count */
 	case 256:
 		bf_set(lpfc_eq_context_count, &eq_create->u.request.context,
@@ -14694,7 +14696,7 @@ lpfc_eq_create(struct lpfc_hba *phba, struct lpfc_queue *eq, uint32_t imax)
 	eq->host_index = 0;
 	eq->notify_interval = LPFC_EQ_NOTIFY_INTRVL;
 	eq->max_proc_limit = LPFC_EQ_MAX_PROC_LIMIT;
-
+out:
 	mempool_free(mbox, phba->mbox_mem_pool);
 	return status;
 }
-- 
2.13.7

