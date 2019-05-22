Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E295925B48
	for <lists+linux-scsi@lfdr.de>; Wed, 22 May 2019 02:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbfEVAt3 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 21 May 2019 20:49:29 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45942 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728153AbfEVAt3 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 21 May 2019 20:49:29 -0400
Received: by mail-pf1-f193.google.com with SMTP id s11so328908pfm.12
        for <linux-scsi@vger.kernel.org>; Tue, 21 May 2019 17:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=de13heP8GurAC0k8VaKozAE/7LTqjlixmb+w3JaByBM=;
        b=lCwRt0Ti5+hAZ4VcH3gqgdS97vhRGp5YeU1wHKBRwpiBCrgxXhzryea7eG0SG+eVUg
         7k/RsDwXQJ53TaI5Y/hfxaOH1XJirO0o5wx+0rkesdohst4tSQWTT8iLj3E0S28gE5Fk
         UkHF9l0nCRwZQ2jzek4EsGjuJTogaC52IBs5kNz/SgeTRBnYEUeMkfR3XHgEzmSOWRIL
         DvGz73rk+D6VQYnXXJDKy7Lo/u9dfb1mI4zaslO4mgGIdRGK1OzV2oD3x1xXWaJn9mHG
         V9X2j6cKI391dLvaWqi/5CrzA26y3UZckJzUrjt8KVM0p5hoPqjqdTXS/4wywEHiqpR8
         QDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=de13heP8GurAC0k8VaKozAE/7LTqjlixmb+w3JaByBM=;
        b=S7qhJeIu4am9W6rtqQtzFv6KPSFWq1dJljYCan1ogWuN9w6kIXz3TF+d7agqRXnye8
         qgk1gr3nIg9JLSfATcW/EbZQCu9ylfjbgKxG4q00hfqBB4ZxFWNeyFJPyx6ckLgkFJvb
         UNZAz8vOHCSWuAiyy382DtouK6VWndxoVxudmLuvGwvii/DEGR/ULmWpJ2cQALHhH1bl
         ps2ekeByaAlhGKPSdasKAQSE3E4sBIoznPVmmsIemzbr3/PgdCZrxU6aHacv3lGZs6Ys
         0wGk1tPA0YUUem+xEMNcpSC04vTA87ltqTUbbRKcXvS0xyMjLr6FQ9nPezsWE7ATAzcu
         JDhQ==
X-Gm-Message-State: APjAAAXYamr9htsAMg4pWReLWi+K3Qq7l3vjQgQgqzuE9vn3XR0D+Kra
        2TK31qNWYlXJ16m+NOQ74qmK3e4L
X-Google-Smtp-Source: APXvYqyNpUFqzB3KVednXjDmi6Cf5uV0BuCxui0j5ZcCxWMqupErzhBlM20yNiCmpSCR69/NwwzWCQ==
X-Received: by 2002:a65:62d8:: with SMTP id m24mr85852278pgv.141.1558486168426;
        Tue, 21 May 2019 17:49:28 -0700 (PDT)
Received: from pallmd1.broadcom.com ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j184sm22550121pge.83.2019.05.21.17.49.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 May 2019 17:49:28 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH 08/21] lpfc: Fix PT2PT PLOGI collison stopping discovery
Date:   Tue, 21 May 2019 17:48:58 -0700
Message-Id: <20190522004911.573-9-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190522004911.573-1-jsmart2021@gmail.com>
References: <20190522004911.573-1-jsmart2021@gmail.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Under heavy load the target stops responding, the drivers aborts
timeout and we start recovery by logging out of the target, but
the target is never logged into again.

In a point-to-point scenario, there were battling PLOGI's. When we
received a PLOGI request after having sent one, the driver cancels
the processing of the original plogi. However, the completion path
of the remaining plogi was coded to skip the reg_rpi that should
be happening on the 2nd plogi.

Correct by adding a simple pt2pt check such that the 2nd plogi isn't
skipped and the reg_login occurs.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc_els.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index c8fb0b455f2a..532728ee1f95 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -4196,6 +4196,7 @@ lpfc_cmpl_els_rsp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		if ((rspiocb->iocb.ulpStatus == 0)
 		    && (ndlp->nlp_flag & NLP_ACC_REGLOGIN)) {
 			if (!lpfc_unreg_rpi(vport, ndlp) &&
+			    (!(vport->fc_flag & FC_PT2PT)) &&
 			    (ndlp->nlp_state ==  NLP_STE_PLOGI_ISSUE ||
 			     ndlp->nlp_state == NLP_STE_REG_LOGIN_ISSUE)) {
 				lpfc_printf_vlog(vport, KERN_INFO,
-- 
2.13.7

