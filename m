Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8C117E193
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387983AbfHAR4r (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 13:56:47 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43373 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731621AbfHAR4q (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:56:46 -0400
Received: by mail-pf1-f193.google.com with SMTP id i189so34507979pfg.10
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 10:56:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6v1O9CfR6TeRmnq7YFF7lfjikId/v4WXzcSDhTGUZPQ=;
        b=Ra4ND76QCWEORuD+QKKZL80IOqCjdRZLov8p7kIhPkt7CssDiIqOoU/hQ8b46FFGHF
         IkRZv3oozjhR52UkyQaEDgTkM+RSfjDsVup576ZkB+px/qWEo0p1x9tlICyJA5Hy+esg
         uRtPlGFPkXDRS6l7/p6WW/1sSJCROokjBSEpfRxwE6qjhL02Hfg+CGijIRyFrJ3EjIC/
         5gzvVPRuKqBHfMVbOKVVKaUyczVgooVHnn36VMCct3oN8vkf/NwLEMAmcmBuJXRmniDv
         uYWOs4dQqo+/jqelkE+qc4FOu+VJdWdXaLFB2zMfsACrxEGgLUCBWC6PoV2j95aHMMOE
         Ldvg==
X-Gm-Message-State: APjAAAV0AFUlDKQ7K+ltBjxTexGcPpdYMkv8K0kUoPVPRer/khvDtotW
        tHIVUycU2d6dKiW/0js6dcY=
X-Google-Smtp-Source: APXvYqxptjJsN/Ccte1e3j08kdtW4cUBBcnzrmqOWU31aE5t9wUQnwtB9nUmPMbdhRWQDogFlyfO8g==
X-Received: by 2002:a65:614a:: with SMTP id o10mr5333440pgv.407.1564682206026;
        Thu, 01 Aug 2019 10:56:46 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm73144114pfm.66.2019.08.01.10.56.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:56:45 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 18/59] qla2xxx: Simplify qla24xx_abort_sp_done()
Date:   Thu,  1 Aug 2019 10:55:33 -0700
Message-Id: <20190801175614.73655-19-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801175614.73655-1-bvanassche@acm.org>
References: <20190801175614.73655-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Instead of explicitly checking whether a timeout has occurred, ignore
the del_timer() return value.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_init.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index c24d7667d3c9..cab5f2f90714 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -122,13 +122,11 @@ static void qla24xx_abort_sp_done(void *ptr, int res)
 	srb_t *sp = ptr;
 	struct srb_iocb *abt = &sp->u.iocb_cmd;
 
-	if ((res == QLA_OS_TIMER_EXPIRED) ||
-	    del_timer(&sp->u.iocb_cmd.timer)) {
-		if (sp->flags & SRB_WAKEUP_ON_COMP)
-			complete(&abt->u.abt.comp);
-		else
-			sp->free(sp);
-	}
+	del_timer(&sp->u.iocb_cmd.timer);
+	if (sp->flags & SRB_WAKEUP_ON_COMP)
+		complete(&abt->u.abt.comp);
+	else
+		sp->free(sp);
 }
 
 static int qla24xx_async_abort_cmd(srb_t *cmd_sp, bool wait)
-- 
2.22.0.770.g0f2c4a37fd-goog

