Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F4087410241
	for <lists+linux-scsi@lfdr.de>; Sat, 18 Sep 2021 02:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245428AbhIRAJp (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 17 Sep 2021 20:09:45 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169]:35633 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344052AbhIRAJU (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 17 Sep 2021 20:09:20 -0400
Received: by mail-pl1-f169.google.com with SMTP id bb10so7240377plb.2
        for <linux-scsi@vger.kernel.org>; Fri, 17 Sep 2021 17:07:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dKE9o/+g4929dyCq2nGwYGFLUetIkYpKTXBeXH0/mTc=;
        b=1QcbUaWXwocyMLGGqnEaNGgs+Q5e7c3JOkaqBzOwbQLdwwpyo+MMf1xebvktgIcRqz
         liz+jx0Ee4yETvwKQhocbFpowRRUBTsoBBgfdEjNzezEBovJJinvLWEuzpoOerqdutEO
         fyUs1PgmTom5UIsC+PA0MRtnb1MEdUmbW8Q5zIIpKUdjy8P9rBZ8xhfn3MPdOFL4eGYP
         cOaVFZQ4eMPOfO07TMswFDuWx/Tj8792f1eXl+B8YKUcurx3EyqZ7nBaDVhr9S2zNJRs
         D33/IUBrA82S4feBGpjzcQuBzP8GTpvrfKy4Dq2+WooFRXnKZPyQS1S02HUkT7sIGZ0Y
         admg==
X-Gm-Message-State: AOAM5329CtQLW+PM7jYMNaHZfwv/nF79NR6exz53iGo1dREEGuoJsl/e
        fN15J1wmdnN0oPGEDHwWA1Xa7CAmDoQ=
X-Google-Smtp-Source: ABdhPJxfBMabGPW86dWT4q7JGinHF3BwH196817N/25GIZapmwHfmRU0FSLw/ni0/vA73sbVeQnplQ==
X-Received: by 2002:a17:90b:14cc:: with SMTP id jz12mr15348146pjb.203.1631923677906;
        Fri, 17 Sep 2021 17:07:57 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:4c45:d635:d2d2:93])
        by smtp.gmail.com with ESMTPSA id bv16sm6403129pjb.12.2021.09.17.17.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 17:07:57 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Geoff Levand <geoff@infradead.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 61/84] ps3rom: Call scsi_done() directly
Date:   Fri, 17 Sep 2021 17:05:44 -0700
Message-Id: <20210918000607.450448-62-bvanassche@acm.org>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
In-Reply-To: <20210918000607.450448-1-bvanassche@acm.org>
References: <20210918000607.450448-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Conditional statements are faster than indirect calls. Hence call
scsi_done() directly.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/ps3rom.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/ps3rom.c b/drivers/scsi/ps3rom.c
index 0f4b99d92f12..08e970300b3f 100644
--- a/drivers/scsi/ps3rom.c
+++ b/drivers/scsi/ps3rom.c
@@ -209,7 +209,6 @@ static int ps3rom_queuecommand_lck(struct scsi_cmnd *cmd,
 	int res;
 
 	priv->curr_cmd = cmd;
-	cmd->scsi_done = done;
 
 	opcode = cmd->cmnd[0];
 	/*
@@ -237,7 +236,7 @@ static int ps3rom_queuecommand_lck(struct scsi_cmnd *cmd,
 		scsi_build_sense(cmd, 0, ILLEGAL_REQUEST, 0, 0);
 		cmd->result = res;
 		priv->curr_cmd = NULL;
-		cmd->scsi_done(cmd);
+		scsi_done(cmd);
 	}
 
 	return 0;
@@ -321,7 +320,7 @@ static irqreturn_t ps3rom_interrupt(int irq, void *data)
 
 done:
 	priv->curr_cmd = NULL;
-	cmd->scsi_done(cmd);
+	scsi_done(cmd);
 	return IRQ_HANDLED;
 }
 
