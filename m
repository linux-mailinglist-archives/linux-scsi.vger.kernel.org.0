Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85519410208
	for <lists+linux-scsi@lfdr.de>; Sat, 18 Sep 2021 02:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243429AbhIRAHw (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 17 Sep 2021 20:07:52 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:33423 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243089AbhIRAHv (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 17 Sep 2021 20:07:51 -0400
Received: by mail-pf1-f182.google.com with SMTP id s16so2405218pfk.0
        for <linux-scsi@vger.kernel.org>; Fri, 17 Sep 2021 17:06:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3g9GybVmhn5NcVSEf+e0j0/kR3Jt4ybQmvybi1gAxcA=;
        b=tZS/EawjWL+N4snqa4/f5GHaOgOdHtrjbjLFnzw2DIQL6q5rEhvgqL2ECSWhky4jiu
         6fUD/DAQis2x637htfkcc1fcq7VlAq1oAtDzuJv7SjtbjMyoWjEpWezjGr2nWx6m/69U
         FqAiGUUnP34kiBwmBGCwqdNPslHGLTg7wdojgwVfdwCCr1IbQB7GrbtscyUkth4UBBLv
         rBVqmXUPAts43ohr8NK20vKZK4FJaAmdsUl5NFdKzic9MiFJ0wLmF3KsW2kUIaIlepVX
         aMNRcq/RXo1N9LttTlDl2MJsIi8Xj0oSZWBcMHyBRpYVYS+NksfrE4yW2yc5uQHqDPAL
         2KzA==
X-Gm-Message-State: AOAM530InTu/taLlt+bzl0/X+sIHElh6wog5qTczdCSiTTeRGLul6c69
        Mwnwg6avwEXVmkJOp5fLMyI=
X-Google-Smtp-Source: ABdhPJxTB6UM/6FGbeiJaOhAwrMa9kqoVwVsuIt+5p+kA8ghwSOVa6bauDWrs0LFe7JuWE95g4bl4g==
X-Received: by 2002:a05:6a00:4:b0:43d:32f3:e861 with SMTP id h4-20020a056a00000400b0043d32f3e861mr13766205pfk.60.1631923588565;
        Fri, 17 Sep 2021 17:06:28 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:4c45:d635:d2d2:93])
        by smtp.gmail.com with ESMTPSA id bv16sm6403129pjb.12.2021.09.17.17.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 17:06:28 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Adam Radford <aradford@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH 10/84] 3w-sas: Call scsi_done() directly
Date:   Fri, 17 Sep 2021 17:04:53 -0700
Message-Id: <20210918000607.450448-11-bvanassche@acm.org>
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
 drivers/scsi/3w-sas.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/3w-sas.c b/drivers/scsi/3w-sas.c
index 4fde39da54e4..e6f51904f5b1 100644
--- a/drivers/scsi/3w-sas.c
+++ b/drivers/scsi/3w-sas.c
@@ -1216,7 +1216,7 @@ static irqreturn_t twl_interrupt(int irq, void *dev_instance)
 
 			/* Now complete the io */
 			scsi_dma_unmap(cmd);
-			cmd->scsi_done(cmd);
+			scsi_done(cmd);
 			tw_dev->state[request_id] = TW_S_COMPLETED;
 			twl_free_request_id(tw_dev, request_id);
 			tw_dev->posted_request_count--;
@@ -1369,7 +1369,7 @@ static int twl_reset_device_extension(TW_Device_Extension *tw_dev, int ioctl_res
 			if (cmd) {
 				cmd->result = (DID_RESET << 16);
 				scsi_dma_unmap(cmd);
-				cmd->scsi_done(cmd);
+				scsi_done(cmd);
 			}
 		}
 	}
@@ -1461,9 +1461,6 @@ static int twl_scsi_queue_lck(struct scsi_cmnd *SCpnt, void (*done)(struct scsi_
 		goto out;
 	}
 
-	/* Save done function into scsi_cmnd struct */
-	SCpnt->scsi_done = done;
-
 	/* Get a free request id */
 	twl_get_request_id(tw_dev, &request_id);
 
