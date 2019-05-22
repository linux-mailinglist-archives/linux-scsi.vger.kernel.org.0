Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4844425B44
	for <lists+linux-scsi@lfdr.de>; Wed, 22 May 2019 02:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbfEVAtZ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 21 May 2019 20:49:25 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44265 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbfEVAtZ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 21 May 2019 20:49:25 -0400
Received: by mail-pg1-f194.google.com with SMTP id n2so356655pgp.11
        for <linux-scsi@vger.kernel.org>; Tue, 21 May 2019 17:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HwHpllSGXEnnagT/c/OmgyMimlVroFXqaZCeTvxYnG4=;
        b=I6KLCha2KxD0UmhdBV/50m5Br4UJv0IwlFnPSL2uZHzA6vc+I6SuYTVNlmpjfRUyXr
         nOtB0WMrQhlaYFkDBRo17dtlwxLB7gmYCrFgYLyxWE/P+X23cf7nuuluLqm6v9+Lh/Yw
         k55j2/5tv6ktj80jxfzzOGte98GqPDU0Yc60E58UqJB2EVMwL4RP/QteHu0bwwHhycq7
         E6ECOCAXzAM+nlNKsQAn7Vt6pF2glMKAv0UvMA6PlwbnCgNBG4QDVn1/Z4rKgzhRvKdT
         PogIviqcC0bTljhw48ykyYrTgZ0hhbAa/FIn9VPJc43lrNMoHvWzpzwaV+lEDvmdKwXe
         1yuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HwHpllSGXEnnagT/c/OmgyMimlVroFXqaZCeTvxYnG4=;
        b=iPUqEQqKR7K3cVu8h6oH/2TRPHikF0NYyR612I/MUyYIDQARGw89YE2tMe2AtrTJox
         VS/NysA116E/KcaxnxWYNa1Do30PsvZJk5FM2qog0IH4jw3Aus54b7ZaMdJRpOTqMyv9
         3ER4f7SQlcwAp5lA7ZC1xeXXkQhNSK+sXYr34c/h0O8L0GdRzHltBUqdPn/oLqR7dgXf
         VAkubu4UsEXchvjvev4PocB9CP8zE6UY7IkdUTpEZWl9W5krpZwGawMiXaHLlG0Q/fOO
         /EhLOoBdRblqsDNlTVjh22wz9jstgD/OXwhZlKtVNdg3HI68hZGwO4H0szDZd6briptk
         Xq8w==
X-Gm-Message-State: APjAAAWgBGedYgZdslwcQaPBsLbbOyMEbAxvD7hJTa8uyxlZpSQBoU1W
        lHlB5K8C6ik63vYGPK4+zvF7hsY9
X-Google-Smtp-Source: APXvYqxe7xp+CKDc6J9yl76CsV0B1qfvTir3zc0+2QQsBdQnVtbEnT32bl4a3RHmpetUeIlWdPmKRg==
X-Received: by 2002:a65:44c8:: with SMTP id g8mr87373150pgs.443.1558486164593;
        Tue, 21 May 2019 17:49:24 -0700 (PDT)
Received: from pallmd1.broadcom.com ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j184sm22550121pge.83.2019.05.21.17.49.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 May 2019 17:49:24 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH 03/21] lpfc: Correct nvmet buffer free race condition
Date:   Tue, 21 May 2019 17:48:53 -0700
Message-Id: <20190522004911.573-4-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190522004911.573-1-jsmart2021@gmail.com>
References: <20190522004911.573-1-jsmart2021@gmail.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

A race condition resulted in receive buffers being placed in the
free list twice.

Change the locking and handling to check whether the "other" path
will be freeing the entry in a later thread and skip it if it is.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc_nvmet.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index c9011579aa0f..3a11861b7ad6 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -343,16 +343,23 @@ lpfc_nvmet_ctxbuf_post(struct lpfc_hba *phba, struct lpfc_nvmet_ctxbuf *ctx_buf)
 	}
 
 	if (ctxp->rqb_buffer) {
-		nvmebuf = ctxp->rqb_buffer;
 		spin_lock_irqsave(&ctxp->ctxlock, iflag);
-		ctxp->rqb_buffer = NULL;
-		if (ctxp->flag & LPFC_NVMET_CTX_REUSE_WQ) {
-			ctxp->flag &= ~LPFC_NVMET_CTX_REUSE_WQ;
-			spin_unlock_irqrestore(&ctxp->ctxlock, iflag);
-			nvmebuf->hrq->rqbp->rqb_free_buffer(phba, nvmebuf);
+		nvmebuf = ctxp->rqb_buffer;
+		/* check if freed in another path whilst acquiring lock */
+		if (nvmebuf) {
+			ctxp->rqb_buffer = NULL;
+			if (ctxp->flag & LPFC_NVMET_CTX_REUSE_WQ) {
+				ctxp->flag &= ~LPFC_NVMET_CTX_REUSE_WQ;
+				spin_unlock_irqrestore(&ctxp->ctxlock, iflag);
+				nvmebuf->hrq->rqbp->rqb_free_buffer(phba,
+								    nvmebuf);
+			} else {
+				spin_unlock_irqrestore(&ctxp->ctxlock, iflag);
+				/* repost */
+				lpfc_rq_buf_free(phba, &nvmebuf->hbuf);
+			}
 		} else {
 			spin_unlock_irqrestore(&ctxp->ctxlock, iflag);
-			lpfc_rq_buf_free(phba, &nvmebuf->hbuf); /* repost */
 		}
 	}
 	ctxp->state = LPFC_NVMET_STE_FREE;
-- 
2.13.7

