Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2DF07E1B0
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388063AbfHAR50 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 13:57:26 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39888 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387957AbfHAR5Z (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:57:25 -0400
Received: by mail-pg1-f195.google.com with SMTP id u17so34626014pgi.6
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 10:57:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1VtYE7vJhEjgeWDBhJpimsojBLHC1wCWOt6NhyDQYB8=;
        b=KlkzCXstU3PDekfoCgSSwOJw6/rHw1HiwKMkV2BcwuYWqwuChtHX8NsuKqpOEh5LqL
         Y5TEcnXH72OkakAGKaRzN3ccr1JY2mlesKs/WTJL2EkiZrlnNPMWEfI8vy+7KVuCUAQo
         CPEb+i7Yy61kCsPqJ4Ct7fuoR1WdfUHv4LQiOEam8xrksToQEBt2hYKhMRTKnN0GUvoG
         WJBynxXxCrh+icDBrvoui65MIO7GvYC67rdYdUyijpuCaw3Ak+gu0d/VxgOtSBDAsYvI
         rnioq+C4INsucBtF8vu5s/EsV9Fkl3RxJ0SIf3JdVtKlzVBXDgHPaXmj/NkNaMZ/hDi9
         VmqQ==
X-Gm-Message-State: APjAAAUxym3fcW1fNGR4B+A1Sy/es5tEOLX2h3SprLeMJOEpNxjE+66f
        3gx4MZayegBcmob5ilh6bP8=
X-Google-Smtp-Source: APXvYqxP2FGS6aTRFHCM8ASHFT8PfYvBpcJBHlJLP8x80/+sjuZrlEwyzVmIxCoELz3EiSl9DFDnMA==
X-Received: by 2002:a62:6454:: with SMTP id y81mr52988648pfb.13.1564682244421;
        Thu, 01 Aug 2019 10:57:24 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm73144114pfm.66.2019.08.01.10.57.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:57:23 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 46/59] qla2xxx: Make qlt_handle_abts_completion() more robust
Date:   Thu,  1 Aug 2019 10:56:01 -0700
Message-Id: <20190801175614.73655-47-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801175614.73655-1-bvanassche@acm.org>
References: <20190801175614.73655-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Avoid that this function crashes if mcmd == NULL.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_target.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index d25c3fa43601..cc0c99b5f3fb 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -5731,7 +5731,7 @@ static void qlt_handle_abts_completion(struct scsi_qla_host *vha,
 			    entry->error_subcode2);
 			ha->tgt.tgt_ops->free_mcmd(mcmd);
 		}
-	} else {
+	} else if (mcmd) {
 		ha->tgt.tgt_ops->free_mcmd(mcmd);
 	}
 }
-- 
2.22.0.770.g0f2c4a37fd-goog

