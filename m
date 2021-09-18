Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2FE410228
	for <lists+linux-scsi@lfdr.de>; Sat, 18 Sep 2021 02:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344607AbhIRAIp (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 17 Sep 2021 20:08:45 -0400
Received: from mail-pl1-f174.google.com ([209.85.214.174]:36846 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344061AbhIRAIj (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 17 Sep 2021 20:08:39 -0400
Received: by mail-pl1-f174.google.com with SMTP id w6so7235340pll.3
        for <linux-scsi@vger.kernel.org>; Fri, 17 Sep 2021 17:07:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G/U5AT0JdS1JPpSLRlnz336WYbeTNuEagu7XBIhXTCc=;
        b=GmD7qQFJ1nIR3X+XEbXtya66Qg3vKRCxsKSyPmCEL2pMS+rzStzV5scgDCy+et7K6a
         5c3jwk1G/A8d8N9jCv4Anmgiz2TC9TKhxF+9XbsktMhwvp2bdDYEpkBpawWicLXf3cWc
         YdfTRVf+XlYR1bSGGOiEap2noyaq2vLRzNoDGICqgRlEkZAfCkPs45v9wZ7hwKecuR8T
         cMLYnhSyebAtj01iadB1rhFa0aeecY30P59kuGi9tWqHGLGVw0To3gz20z5HTMRM7MLn
         muJPXJTdRuRZkGvCoWT9jxxHMCR9BCNFblU0WErPCO9Hq0nMzFCr7bUGvrltEVYPZx2j
         K4wA==
X-Gm-Message-State: AOAM532niX+ImVrorUGKZirMEhnnPiPAdpgnz6YUfWRTbKHGFqXO+Zk/
        r+FPT+P1JSV/IKOIGCBdEn5EQfvka/Q=
X-Google-Smtp-Source: ABdhPJxgWCT+O7mwgTXdhMwTGxPv4mFQ012aljleDhN4t/bgJIZnMrpZYgQa3M3mgjXFMRd/Xc5pqQ==
X-Received: by 2002:a17:902:780f:b0:13a:3919:e365 with SMTP id p15-20020a170902780f00b0013a3919e365mr12032567pll.63.1631923636787;
        Fri, 17 Sep 2021 17:07:16 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:4c45:d635:d2d2:93])
        by smtp.gmail.com with ESMTPSA id bv16sm6403129pjb.12.2021.09.17.17.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 17:07:16 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        HighPoint Linux Team <linux@highpoint-tech.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH 37/84] hptiop: Call scsi_done() directly
Date:   Fri, 17 Sep 2021 17:05:20 -0700
Message-Id: <20210918000607.450448-38-bvanassche@acm.org>
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
 drivers/scsi/hptiop.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/hptiop.c b/drivers/scsi/hptiop.c
index 61cda7b7624f..f18f6a677c1b 100644
--- a/drivers/scsi/hptiop.c
+++ b/drivers/scsi/hptiop.c
@@ -769,7 +769,7 @@ static void hptiop_finish_scsi_req(struct hptiop_hba *hba, u32 tag,
 
 skip_resid:
 	dprintk("scsi_done(%p)\n", scp);
-	scp->scsi_done(scp);
+	scsi_done(scp);
 	free_req(hba, &hba->reqs[tag]);
 }
 
@@ -1002,9 +1002,6 @@ static int hptiop_queuecommand_lck(struct scsi_cmnd *scp,
 	int sg_count = 0;
 	struct hptiop_request *_req;
 
-	BUG_ON(!done);
-	scp->scsi_done = done;
-
 	_req = get_req(hba);
 	if (_req == NULL) {
 		dprintk("hptiop_queuecmd : no free req\n");
@@ -1059,7 +1056,7 @@ static int hptiop_queuecommand_lck(struct scsi_cmnd *scp,
 
 cmd_done:
 	dprintk("scsi_done(scp=%p)\n", scp);
-	scp->scsi_done(scp);
+	scsi_done(scp);
 	return 0;
 }
 
