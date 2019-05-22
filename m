Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8123D25B4D
	for <lists+linux-scsi@lfdr.de>; Wed, 22 May 2019 02:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbfEVAte (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 21 May 2019 20:49:34 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37667 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728165AbfEVAtb (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 21 May 2019 20:49:31 -0400
Received: by mail-pl1-f194.google.com with SMTP id p15so179188pll.4
        for <linux-scsi@vger.kernel.org>; Tue, 21 May 2019 17:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hE7RU2gTsXp7a1/zfkhwqyxBxkgBabYLcwxgJQRKJpY=;
        b=M51J2vWSe8UBrUK+DSt0wThoiN3+BtevwLO849zO2EiDSrUOjEdtVMg9OWQPoKr090
         SBJdpGIUjh/0kbsYFhtv7Ghn3++izIpy9FZ4PGazOesIe+3BNoQTpjfeG7tEaY+FSU5A
         STXT0WWyLipjwvTV5+iqB76s0svJUmvFtddvREMeDUCpMcUiSkWy8wQwTXX2zHtjpxHz
         jVsofjC9B0c6bfd6itEmykXkNZulhMHMX1RDaIu2YXICW73gxWYRguydC3K2AmpB+/j7
         SXAmP1rgqCd1D5gw94JWowATU2GSukD6SHGnSo8DZEpy0jzPbfB+hmA+Ncx2ZOtFIdo1
         IBDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hE7RU2gTsXp7a1/zfkhwqyxBxkgBabYLcwxgJQRKJpY=;
        b=W34Yb+1DOW68oI8/ziHp3w+wbj/k4SZnKr6UWUuIuNFJgPZIq1+2nbYLHDBc3Ypejc
         nUY6LHhMCOAAEy5LAoaakwQ+WTunRoTcu9Sj9f2kVrJogksTIfmkPOjPgXcocd5epx9g
         m5DVBiPFy4XdM/IVgYcpoiT38gk6dhLWHfbjwFleGSwAfIpfZ8Kl03XS6MBe8rRhMcdH
         KqUS/sQ40mos7oZmdaSPF56sLjXEqOGwABmcf07un/Ihug9wAhvQjz2oDxuLUrk5xLJQ
         F45CxYPPXFUwqw8WQT5w9tiStSS4EuW+/Mz9xiFZqafyp6Zr9Fpr6JJeTcSA5Pyb0AaR
         m1LA==
X-Gm-Message-State: APjAAAVB31wgJl+m+CMQuv65QXMzVQ0xI0QrhuWfbCE7ZJ6oIS1nO/Q7
        USqgdTmJy54dfN5mi4q57nOqrpfw
X-Google-Smtp-Source: APXvYqzE84H09EvWnQ73qSjqVdhw/Mk6YCjzXnB6HAlclSbbk7H8lN0VsKoDjdSuu4dIgsPz1TJQ1Q==
X-Received: by 2002:a17:902:f081:: with SMTP id go1mr39658997plb.211.1558486170897;
        Tue, 21 May 2019 17:49:30 -0700 (PDT)
Received: from pallmd1.broadcom.com ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j184sm22550121pge.83.2019.05.21.17.49.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 May 2019 17:49:30 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH 11/21] lpfc: Fix hardlockup in scsi_cmd_iocb_cmpl
Date:   Tue, 21 May 2019 17:49:01 -0700
Message-Id: <20190522004911.573-12-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190522004911.573-1-jsmart2021@gmail.com>
References: <20190522004911.573-1-jsmart2021@gmail.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

There is a race condition with the abort handler declaring a waitq
item on it's stack, followed by a timeout in the abort handler that
has it give up on the abort return to its caller. When the io is
finally aborted and its completion handler called, it references
the waitq element that the abort_handler set up, which is no longer
valid resulting in a deadlock.

Fix by clearing the waitq reference, under lock, when the abort
handler timeout gives up. Have the completion handler validate the
waitq before referencing it.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc_scsi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index 3873d5b97bc6..5a5a9bbe6023 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -3879,10 +3879,8 @@ lpfc_scsi_cmd_iocb_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *pIocbIn,
 	 */
 	spin_lock(&lpfc_cmd->buf_lock);
 	lpfc_cmd->cur_iocbq.iocb_flag &= ~LPFC_DRIVER_ABORTED;
-	if (lpfc_cmd->waitq) {
+	if (lpfc_cmd->waitq)
 		wake_up(lpfc_cmd->waitq);
-		lpfc_cmd->waitq = NULL;
-	}
 	spin_unlock(&lpfc_cmd->buf_lock);
 
 	lpfc_release_scsi_buf(phba, lpfc_cmd);
@@ -4718,6 +4716,9 @@ lpfc_abort_handler(struct scsi_cmnd *cmnd)
 				 iocb->sli4_xritag, ret,
 				 cmnd->device->id, cmnd->device->lun);
 	}
+
+	lpfc_cmd->waitq = NULL;
+
 	spin_unlock(&lpfc_cmd->buf_lock);
 	goto out;
 
-- 
2.13.7

