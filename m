Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10AC97E1BF
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388115AbfHAR5n (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 13:57:43 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46002 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387963AbfHAR5n (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:57:43 -0400
Received: by mail-pf1-f195.google.com with SMTP id r1so34496312pfq.12
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 10:57:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RijsylXpnp4M2sUQR9QXzbpeCFWjhhYLleZCTwiO2Q4=;
        b=IsYrUVRU5r7r4zbUza+lSsUFxOvpHQcGPpHdYMC23WUv1OZO+/oSvaGGbehbgNGKOV
         dOdkUJtkixknid9Tu0Suud7Ko+1bX0ucF3XX1e7RHOImEOxJH/e5yndNqNPSteBwugru
         jm3PGgnrFJtFvBC/jHbcqd/YSRxe/dVKoKeamMd5R5VdN09Tn1tVTrfTFvi77yz1swde
         xA9lrTbdi0KtdzPOKByqpEJzh8Z9C62XbCf8eN2YWeVYm8TW6IZxS/jktlsNEesULpF2
         +KQxK9dutS6MAQ87M4xXH01M19+ty5XeSXYkkMvwqkiwd4xNBrlrFsELVwghlVjIMj+v
         h7AQ==
X-Gm-Message-State: APjAAAVoUHtvMkT3sk8WHNphp49rFnKKnAIpj/kGcAui3rx2RGCZSIzH
        leS0wYHWeowJKFUaY1dQEjhNfRJ3
X-Google-Smtp-Source: APXvYqy1/rf4KIeeltaJG7OV5NQgiJcmp8+aEm4X1dM5vuvq6R654Tn3O+gNLR8bY+Z+2ob0LP7f4g==
X-Received: by 2002:a62:8344:: with SMTP id h65mr54934898pfe.85.1564682262441;
        Thu, 01 Aug 2019 10:57:42 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm73144114pfm.66.2019.08.01.10.57.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:57:41 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 59/59] qla2xxx: Fix a NULL pointer dereference
Date:   Thu,  1 Aug 2019 10:56:14 -0700
Message-Id: <20190801175614.73655-60-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801175614.73655-1-bvanassche@acm.org>
References: <20190801175614.73655-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

BUG: KASAN: null-ptr-deref in qla24xx_handle_plogi_done_event+0x134/0x9f0 [qla2xxx]
Read of size 4 at addr 00000000000000a0 by task swapper/2/0

CPU: 2 PID: 0 Comm: swapper/2 Not tainted 5.2.0-dbg+ #1
Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
Call Trace:
 <IRQ>
 dump_stack+0x8a/0xd6
 __kasan_report.cold+0x5/0x41
 kasan_report+0x16/0x20
 __asan_load4+0x7e/0x80
 qla24xx_handle_plogi_done_event+0x134/0x9f0 [qla2xxx]
 qla2x00_els_dcmd2_sp_done+0x15f/0x230 [qla2xxx]
 qla24xx_els_ct_entry+0x3b3/0x610 [qla2xxx]
 qla24xx_process_response_queue+0x514/0x10e0 [qla2xxx]
 qla24xx_msix_rsp_q+0x80/0x100 [qla2xxx]
 __handle_irq_event_percpu+0x72/0x450
 handle_irq_event_percpu+0x74/0xf0
 handle_irq_event+0x5e/0x8f
 handle_edge_irq+0x13a/0x320
 handle_irq+0x30/0x40
 do_IRQ+0x91/0x190
 common_interrupt+0xf/0xf
 </IRQ>
RIP: 0010:default_idle+0x31/0x230

Fixes: 8777e4314d39 ("scsi: qla2xxx: Migrate NVME N2N handling into state machine") # v4.19.
Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_iocb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_iocb.c b/drivers/scsi/qla2xxx/qla_iocb.c
index 7021fbeb6d23..e92e52aa6e9b 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -2755,7 +2755,8 @@ static void qla2x00_els_dcmd2_sp_done(srb_t *sp, int res)
 		} else {
 			memset(&ea, 0, sizeof(ea));
 			ea.fcport = fcport;
-			ea.rc = res;
+			ea.data[0] = MBS_COMMAND_COMPLETE;
+			ea.sp = sp;
 			qla24xx_handle_plogi_done_event(vha, &ea);
 		}
 
-- 
2.22.0.770.g0f2c4a37fd-goog

