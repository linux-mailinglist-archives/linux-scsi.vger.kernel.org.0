Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2388A3E5A2E
	for <lists+linux-scsi@lfdr.de>; Tue, 10 Aug 2021 14:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240697AbhHJMm4 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 10 Aug 2021 08:42:56 -0400
Received: from smtpbg587.qq.com ([113.96.223.105]:44878 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229679AbhHJMmz (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 10 Aug 2021 08:42:55 -0400
X-QQ-mid: bizesmtp47t1628599343tiwn62hb
Received: from localhost.localdomain (unknown [171.223.97.227])
        by esmtp6.qq.com (ESMTP) with 
        id ; Tue, 10 Aug 2021 20:42:22 +0800 (CST)
X-QQ-SSF: 01000000004000B0C000B00A0000000
X-QQ-FEAT: KdN0SWBFoH4QKx12XdY3uwO5ZKjKHJON5Mx/VawX7qFgnRJk+R+e+AudoLIER
        /QdHTr30DCa5+0UVTEAb8tmCLV5h3d9M7b6YW2L2b78r7pBJmrRJ/Me0GErjnbvTxtS/m9h
        v+pKo4df0nJMbyj7g6pP4l4bqFs4yuphJ5rntsZuarRkgC8A9zxjTSGEF3iLfU9Na8Ua+ra
        GBPzqz0HHKhvL2q8cwPylc0gYUSc0XV+JXInFJXP9o9PTmSVKnDKzdfydvLbXEIuZW7T9Or
        YQHkzYsBwH77OEe++I6VNyIPftMBz1mqMQvXyxNS54Td4cAiThWU2h6VdXbxBGiTg6nHYzi
        apRQrk2PRQ5IY/A8sqCrxkSSMynRg==
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     martin.petersen@oracle.com
Cc:     jejb@linux.ibm.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] scsi: qlogicpti: Remove unneeded semicolon
Date:   Tue, 10 Aug 2021 20:42:16 +0800
Message-Id: <20210810124216.77866-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam3
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The semicolon after a code block bracket is unneeded in C. Thus, we can
remove the redundant semicolon from the code safely.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/scsi/qlogicpti.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/qlogicpti.c b/drivers/scsi/qlogicpti.c
index d84e218d32cb..d1d5ede38500 100644
--- a/drivers/scsi/qlogicpti.c
+++ b/drivers/scsi/qlogicpti.c
@@ -513,7 +513,7 @@ static int qlogicpti_load_firmware(struct qlogicpti *qpti)
 		       qpti->qpti_id);
 		err = 1;
 		goto out;
-	}		
+	}
 	sbus_writew(SBUS_CTRL_RESET, qpti->qregs + SBUS_CTRL);
 	sbus_writew((DMA_CTRL_CCLEAR | DMA_CTRL_CIRQ), qpti->qregs + CMD_DMA_CTRL);
 	sbus_writew((DMA_CTRL_CCLEAR | DMA_CTRL_CIRQ), qpti->qregs + DATA_DMA_CTRL);
@@ -563,7 +563,7 @@ static int qlogicpti_load_firmware(struct qlogicpti *qpti)
 		       qpti->qpti_id);
 		err = 1;
 		goto out;
-	}		
+	}
 
 	/* Load it up.. */
 	for (i = 0; i < risc_code_length; i++) {
@@ -1136,7 +1136,7 @@ static struct scsi_cmnd *qlogicpti_intr_handler(struct qlogicpti *qpti)
 
 	if (!(sbus_readw(qpti->qregs + SBUS_STAT) & SBUS_STAT_RINT))
 		return NULL;
-		
+
 	in_ptr = sbus_readw(qpti->qregs + MBOX5);
 	sbus_writew(HCCTRL_CRIRQ, qpti->qregs + HCCTRL);
 	if (sbus_readw(qpti->qregs + SBUS_SEMAPHORE) & SBUS_SEMAPHORE_LCK) {
@@ -1150,7 +1150,7 @@ static struct scsi_cmnd *qlogicpti_intr_handler(struct qlogicpti *qpti)
 		case COMMAND_ERROR:
 		case COMMAND_PARAM_ERROR:
 			break;
-		};
+		}
 		sbus_writew(0, qpti->qregs + SBUS_SEMAPHORE);
 	}
 
@@ -1364,7 +1364,7 @@ static int qpti_sbus_probe(struct platform_device *op)
 		printk("(FCode %s)", fcode);
 	if (of_find_property(dp, "differential", NULL) != NULL)
 		qpti->differential = 1;
-			
+
 	printk("\nqlogicpti%d: [%s Wide, using %s interface]\n",
 		qpti->qpti_id,
 		(qpti->ultra ? "Ultra" : "Fast"),
-- 
2.32.0

