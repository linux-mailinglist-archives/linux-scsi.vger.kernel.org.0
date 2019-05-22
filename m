Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4D5F25B4A
	for <lists+linux-scsi@lfdr.de>; Wed, 22 May 2019 02:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbfEVAtb (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 21 May 2019 20:49:31 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36535 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728165AbfEVAt3 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 21 May 2019 20:49:29 -0400
Received: by mail-pl1-f195.google.com with SMTP id d21so180397plr.3
        for <linux-scsi@vger.kernel.org>; Tue, 21 May 2019 17:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ch1GpZn4+x/spa9si74gDQsnT6AMvKZB+KZkFHXzv0A=;
        b=eThR142ug9oZviGCXQv4uU8/eHA7VrKe1XLNdx/+SpNg0iHRkDf8NWpigWg7xm4C+R
         kZWhE5Hj4K8URmhRMwu53ZCd4GkVuwH4+lA3zUeVqCoERxWt5SOrtTAyn00R/iGzpI1Q
         pt/rRHpUl152tLS2ZseiArUrky47h7+WWTcYpfhsZgLgkz9T6/ID3TFJ9vAPrTPVAykS
         pwcDSXibCJAb11zNbQSwGXvQgRZZPn5m7it9FFWLDPjWM+DJKVvZNY8SkhnoOkZF1DAT
         YWy/9uu2/ZEKhr/5Ospngxi7Qj4LT5Vid/VuiK1qikz/BIXboCU/NTLyZhiLvzPyeLc0
         zNyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ch1GpZn4+x/spa9si74gDQsnT6AMvKZB+KZkFHXzv0A=;
        b=MiHd5DPBr/FbgdWgXAj7VgbsK8Ylz48Bh523EmH4cREqdJ0FZnwGMiCzeUw3vn0XFz
         AYmlfbEudwd/Nw9qat5b7Usjj2Vgd5Qs6zI2vkHH+f2yaHx+r1FwT/idRei3W9Z+/lVb
         xNmBacuFF993XUI/XqBRi+Yf22HeLOeqp0a7SMlPNy+kTjiId4ibYq0PDkisTL6EsBZh
         CjbeAe1LIGBcWLnuJ2O/OyfdzfJ5lFAhi7Z+A+den0WrNvuAfZRH09ASllD8RY/Vl8YN
         b0TGNkZwKnANHxAW4j7gcJT3r04vsTfBC507bhUvz8+qFyd+7kt1LIjgr8qu9izSWBsC
         ln1g==
X-Gm-Message-State: APjAAAVKKlXk1OQLebdhbJ0HpDcj775fn8j7XtiBV9r4iV5HDcjmHb6a
        b8gxN5AVQeuf9E3qh/9hNvufomKq
X-Google-Smtp-Source: APXvYqxu0jq1bXAgsupBdIS5DccZm7K8412WXs61QiT/W7UP3WVsDU7ydKGHvoHSsTYDW9XxHjoz4Q==
X-Received: by 2002:a17:902:704c:: with SMTP id h12mr31590563plt.65.1558486169181;
        Tue, 21 May 2019 17:49:29 -0700 (PDT)
Received: from pallmd1.broadcom.com ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j184sm22550121pge.83.2019.05.21.17.49.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 May 2019 17:49:28 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH 09/21] lpfc: Prevent 'use after free' memory overwrite in nvmet LS handling.
Date:   Tue, 21 May 2019 17:48:59 -0700
Message-Id: <20190522004911.573-10-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190522004911.573-1-jsmart2021@gmail.com>
References: <20190522004911.573-1-jsmart2021@gmail.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Use-after-free memory overwrite detected. Problem reported
by Ewan Milne at Red Hat after running lpfc target with additional
memory checking enabled.

Race condition when lpfc_nvmet_xmt_ls_rsp_cmp frees the ctxp
memory in interrupt context before lpfc_nvmet_xmt_ls_rsp
clears a field in the ctxp after successfully issuing the wqe.

Remove the unnecessary ctxp write after reposting the rq buffer. The
ctxp->rqb_buffer field is not checked in LS handling after the wqe
is submitted.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Reported-by: Ewan Milne <emilne@redhat.com>
---
 drivers/scsi/lpfc/lpfc_nvmet.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index a943b2a20001..08c2c4e3515b 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -907,7 +907,6 @@ lpfc_nvmet_xmt_ls_rsp(struct nvmet_fc_target_port *tgtport,
 		 * before freeing ctxp and iocbq.
 		 */
 		lpfc_in_buf_free(phba, &nvmebuf->dbuf);
-		ctxp->rqb_buffer = 0;
 		atomic_inc(&nvmep->xmt_ls_rsp);
 		return 0;
 	}
-- 
2.13.7

