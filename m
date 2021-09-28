Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 219C541A7BF
	for <lists+linux-scsi@lfdr.de>; Tue, 28 Sep 2021 07:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239166AbhI1F7a (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 28 Sep 2021 01:59:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:49524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239171AbhI1F6i (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 28 Sep 2021 01:58:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 285E561159;
        Tue, 28 Sep 2021 05:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632808594;
        bh=Qlnfsy33Fa5GLT82aBUq02M+g7d+tQhUIXd/wlt7r+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sXXhe3ND+YnbfG3JX6L9MvkoMF0d0XeNJeLo6HlMBOXInBydlfNbPV4wiRtW75ltw
         guRc3926spKcC88sMfvs2rV9j57/AwCn/H1vOG4TqSTV3YWRKzmamzAyOx0SFuwhsL
         ybJNxKGtuZ2WEz6e7mVnaDUs/iWaXxjVKZjIRY0+lHoURYXFRMsgOdy74yODhOOBSa
         QlpX0QrXW11myTO6893x+HZR89NG8P3V3cP9pB3a6Zo89lt7K35YPnVvXTqF25TJ8e
         zGCfWM02oRwQ2Bigzou9vpscul1oB7yc6T7pQGnNISrLd69wh+itj8s2Gj/ph7BCAj
         G1oDI88a/S3lw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wen Xiong <wenxiong@linux.ibm.com>,
        Brian King <brking@linux.ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.14 33/40] scsi: ses: Retry failed Send/Receive Diagnostic commands
Date:   Tue, 28 Sep 2021 01:55:17 -0400
Message-Id: <20210928055524.172051-33-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210928055524.172051-1-sashal@kernel.org>
References: <20210928055524.172051-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Wen Xiong <wenxiong@linux.ibm.com>

[ Upstream commit fbdac19e642899455b4e64c63aafe2325df7aafa ]

Setting SCSI logging level with error=3, we saw some errors from enclosues:

[108017.360833] ses 0:0:9:0: tag#641 Done: NEEDS_RETRY Result: hostbyte=DID_ERROR driverbyte=DRIVER_OK cmd_age=0s
[108017.360838] ses 0:0:9:0: tag#641 CDB: Receive Diagnostic 1c 01 01 00 20 00
[108017.427778] ses 0:0:9:0: Power-on or device reset occurred
[108017.427784] ses 0:0:9:0: tag#641 Done: SUCCESS Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
[108017.427788] ses 0:0:9:0: tag#641 CDB: Receive Diagnostic 1c 01 01 00 20 00
[108017.427791] ses 0:0:9:0: tag#641 Sense Key : Unit Attention [current]
[108017.427793] ses 0:0:9:0: tag#641 Add. Sense: Bus device reset function occurred
[108017.427801] ses 0:0:9:0: Failed to get diagnostic page 0x1
[108017.427804] ses 0:0:9:0: Failed to bind enclosure -19
[108017.427895] ses 0:0:10:0: Attached Enclosure device
[108017.427942] ses 0:0:10:0: Attached scsi generic sg18 type 13

Retry if the Send/Receive Diagnostic commands complete with a transient
error status (NOT_READY or UNIT_ATTENTION with ASC 0x29).

Link: https://lore.kernel.org/r/1631849061-10210-2-git-send-email-wenxiong@linux.ibm.com
Reviewed-by: Brian King <brking@linux.ibm.com>
Reviewed-by: James Bottomley <jejb@linux.ibm.com>
Signed-off-by: Wen Xiong <wenxiong@linux.ibm.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/ses.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/ses.c b/drivers/scsi/ses.c
index c2afba2a5414..43e682297fd5 100644
--- a/drivers/scsi/ses.c
+++ b/drivers/scsi/ses.c
@@ -87,9 +87,16 @@ static int ses_recv_diag(struct scsi_device *sdev, int page_code,
 		0
 	};
 	unsigned char recv_page_code;
+	unsigned int retries = SES_RETRIES;
+	struct scsi_sense_hdr sshdr;
+
+	do {
+		ret = scsi_execute_req(sdev, cmd, DMA_FROM_DEVICE, buf, bufflen,
+				       &sshdr, SES_TIMEOUT, 1, NULL);
+	} while (ret > 0 && --retries && scsi_sense_valid(&sshdr) &&
+		 (sshdr.sense_key == NOT_READY ||
+		  (sshdr.sense_key == UNIT_ATTENTION && sshdr.asc == 0x29)));
 
-	ret =  scsi_execute_req(sdev, cmd, DMA_FROM_DEVICE, buf, bufflen,
-				NULL, SES_TIMEOUT, SES_RETRIES, NULL);
 	if (unlikely(ret))
 		return ret;
 
@@ -121,9 +128,16 @@ static int ses_send_diag(struct scsi_device *sdev, int page_code,
 		bufflen & 0xff,
 		0
 	};
+	struct scsi_sense_hdr sshdr;
+	unsigned int retries = SES_RETRIES;
+
+	do {
+		result = scsi_execute_req(sdev, cmd, DMA_TO_DEVICE, buf, bufflen,
+					  &sshdr, SES_TIMEOUT, 1, NULL);
+	} while (result > 0 && --retries && scsi_sense_valid(&sshdr) &&
+		 (sshdr.sense_key == NOT_READY ||
+		  (sshdr.sense_key == UNIT_ATTENTION && sshdr.asc == 0x29)));
 
-	result = scsi_execute_req(sdev, cmd, DMA_TO_DEVICE, buf, bufflen,
-				  NULL, SES_TIMEOUT, SES_RETRIES, NULL);
 	if (result)
 		sdev_printk(KERN_ERR, sdev, "SEND DIAGNOSTIC result: %8x\n",
 			    result);
-- 
2.33.0

