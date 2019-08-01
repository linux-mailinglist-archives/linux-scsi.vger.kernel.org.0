Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 039A57E1BE
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388114AbfHAR5m (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 13:57:42 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33048 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387963AbfHAR5l (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:57:41 -0400
Received: by mail-pf1-f194.google.com with SMTP id g2so34512011pfq.0
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 10:57:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b6Ac8/nkkw/M2heiCR84E76S9bPeGD4zNaujCXgsNdU=;
        b=E1JuIUlVFeNwGRzYXKd9Hq8zBA2hPnXjWdLM8hMdGTzFGg1gz2Rl4+Iz6NcYpdw6mk
         xNiV6XZez+Cb0Q/ZeBOyqcOck7YsbJQ6ee8lVVAYx1D7ULVTlv3K71cf+jPFv3xodRTB
         nNLpbyeb0HwNqtWzVscshyvoBLEuzxjQmriR+Yi2rTAi7hyeqW4NQuynhQtanIEgB6OA
         4ZvDHK65xMq8/Cs5WFODGqtzQWS3JJHDrkLOEwXvkDsqPkXHDgwVZ8wnurUCgT2IaUEj
         /K9gP1sLvI381Zvu+bahqNF+57XCZlGRH6uDyFVqlp70ic4YwPjWh2eal8ZtvXcrsGml
         Oyjw==
X-Gm-Message-State: APjAAAXFpUQaSttR+fSx/alCqhHNtzg8pT6F6c7/efzWyiUNcffCeNu7
        Bb0Wg94EQSZEkdnzZTsCoPc=
X-Google-Smtp-Source: APXvYqyrnQ+U+8kRMoNDDWone2eD57NnkqvNj70rtbcAHVuU21WNeLfHLWAFQaP5Plr8NsVWc2htHQ==
X-Received: by 2002:aa7:8007:: with SMTP id j7mr54395000pfi.154.1564682261224;
        Thu, 01 Aug 2019 10:57:41 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm73144114pfm.66.2019.08.01.10.57.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:57:40 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 58/59] qla2xxx: Simplify qla24xx_async_abort_cmd()
Date:   Thu,  1 Aug 2019 10:56:13 -0700
Message-Id: <20190801175614.73655-59-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801175614.73655-1-bvanassche@acm.org>
References: <20190801175614.73655-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Make the code easier to read by converting 'goto' statements into
'return' statements.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_init.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 990922967939..a2eae62a1b86 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -136,7 +136,7 @@ static int qla24xx_async_abort_cmd(srb_t *cmd_sp, bool wait)
 	sp = qla2xxx_get_qpair_sp(cmd_sp->vha, cmd_sp->qpair, cmd_sp->fcport,
 				  GFP_ATOMIC);
 	if (!sp)
-		goto done;
+		return rval;
 
 	abt_iocb = &sp->u.iocb_cmd;
 	sp->type = SRB_ABT_CMD;
@@ -160,20 +160,18 @@ static int qla24xx_async_abort_cmd(srb_t *cmd_sp, bool wait)
 	       cmd_sp->type);
 
 	rval = qla2x00_start_sp(sp);
-	if (rval != QLA_SUCCESS)
-		goto done_free_sp;
+	if (rval != QLA_SUCCESS) {
+		sp->free(sp);
+		return rval;
+	}
 
 	if (wait) {
 		wait_for_completion(&abt_iocb->u.abt.comp);
 		rval = abt_iocb->u.abt.comp_status == CS_COMPLETE ?
 			QLA_SUCCESS : QLA_FUNCTION_FAILED;
-	} else {
-		goto done;
+		sp->free(sp);
 	}
 
-done_free_sp:
-	sp->free(sp);
-done:
 	return rval;
 }
 
-- 
2.22.0.770.g0f2c4a37fd-goog

