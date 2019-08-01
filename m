Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0157E1B3
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388084AbfHAR52 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 13:57:28 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36976 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388080AbfHAR51 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:57:27 -0400
Received: by mail-pf1-f194.google.com with SMTP id 19so34502292pfa.4
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 10:57:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xmp2SGIdYuWja4fEfmbZiTzNGOWwojyagn21+uQAszs=;
        b=a66PrnJwkXdLP13FQ5Ej3YAWxCPqvPX8XnA6fmOHXNih24tyGSsAb5NUevTzoDHTKS
         ibWP7FGX6g++aYNSjMs0IVuOV8d7eAwdBW079e30n5ST2/ayn2dh+QA/ZFOUFKYuFsOt
         lzJpY06FWve6VQQefQwhmn02YyuhoXfn1TTKcaxJ62BsIteOsD4+TE/rl3TfFSN5ToR0
         yoAKBeHs1jSjVzka4hxWYRvp5fZt8BVH1SszZRvYSITpApz1Fq2r0nVlHnI5UK8VOIxc
         +xQj2QDpHAN0k3VSG9zWxoqU5sjYZWkQ0eHziMRtdZlrQOlDh6GVf1LQg0ZQcoTz25ZB
         +4ug==
X-Gm-Message-State: APjAAAVpyj03mdbyKxD4GUe5RhKClDP2ZPhqX37MIvPNqE7TOe7c8QRI
        2Deuh3bd03lukb1GWr7wYqYiAYnR
X-Google-Smtp-Source: APXvYqxgO88oCFtlYb6O1SDt2QlN18E6jkE/0ojYvWG8DOncDVqHW5eiP/AbGq6PGUMUwX+9spN6LA==
X-Received: by 2002:a17:90a:9dca:: with SMTP id x10mr37687pjv.100.1564682247206;
        Thu, 01 Aug 2019 10:57:27 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm73144114pfm.66.2019.08.01.10.57.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:57:26 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 48/59] qla2xxx: Rename qla24xx_async_abort_command() into qla24xx_sync_abort_command()
Date:   Thu,  1 Aug 2019 10:56:03 -0700
Message-Id: <20190801175614.73655-49-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801175614.73655-1-bvanassche@acm.org>
References: <20190801175614.73655-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Since this function waits until aborting completed, change the function
name to make clear that this is a synchronous function.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_gbl.h  | 2 +-
 drivers/scsi/qla2xxx/qla_init.c | 6 +++++-
 drivers/scsi/qla2xxx/qla_mbx.c  | 2 +-
 drivers/scsi/qla2xxx/qla_os.c   | 2 +-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_gbl.h b/drivers/scsi/qla2xxx/qla_gbl.h
index bbfbe3a34a7e..047d92a01d4a 100644
--- a/drivers/scsi/qla2xxx/qla_gbl.h
+++ b/drivers/scsi/qla2xxx/qla_gbl.h
@@ -400,7 +400,7 @@ qla24xx_get_isp_stats(scsi_qla_host_t *, struct link_statistics *,
     dma_addr_t, uint16_t);
 
 extern int qla24xx_abort_command(srb_t *);
-extern int qla24xx_async_abort_command(srb_t *);
+extern int qla24xx_sync_abort_command(srb_t *);
 extern int
 qla24xx_abort_target(struct fc_port *, uint64_t, int);
 extern int
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 3fa8ca63429c..835ca1b147cf 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -1857,8 +1857,12 @@ qla2x00_async_tm_cmd(fc_port_t *fcport, uint32_t flags, uint32_t lun,
 	return rval;
 }
 
+/**
+ * qla24xx_sync_abort_command - abort an SRB and wait until it has been aborted
+ * @sp: SRB to abort.
+ */
 int
-qla24xx_async_abort_command(srb_t *sp)
+qla24xx_sync_abort_command(srb_t *sp)
 {
 	unsigned long   flags = 0;
 
diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mbx.c
index a82b6db2fa9d..65c33f4c5a89 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -3134,7 +3134,7 @@ qla24xx_abort_command(srb_t *sp)
 		return QLA_FUNCTION_FAILED;
 
 	if (ql2xasynctmfenable)
-		return qla24xx_async_abort_command(sp);
+		return qla24xx_sync_abort_command(sp);
 
 	spin_lock_irqsave(qpair->qp_lock_ptr, flags);
 	for (handle = 1; handle < req->num_outstanding_cmds; handle++) {
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 835572d7d71a..05e63bde22e3 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -2431,7 +2431,7 @@ static struct isp_operations qlafx00_isp_ops = {
 	.intr_handler		= qlafx00_intr_handler,
 	.enable_intrs		= qlafx00_enable_intrs,
 	.disable_intrs		= qlafx00_disable_intrs,
-	.abort_command		= qla24xx_async_abort_command,
+	.abort_command		= qla24xx_sync_abort_command,
 	.target_reset		= qlafx00_abort_target,
 	.lun_reset		= qlafx00_lun_reset,
 	.fabric_login		= NULL,
-- 
2.22.0.770.g0f2c4a37fd-goog

