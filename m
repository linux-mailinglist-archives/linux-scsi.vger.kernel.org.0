Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 850E81139A4
	for <lists+linux-scsi@lfdr.de>; Thu,  5 Dec 2019 03:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbfLECOZ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 4 Dec 2019 21:14:25 -0500
Received: from a27-55.smtp-out.us-west-2.amazonses.com ([54.240.27.55]:44650
        "EHLO a27-55.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728393AbfLECOZ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 4 Dec 2019 21:14:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1575512065;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        bh=sN9HQYh6wIVagBIBwBcjFatf2XSTX81OaYD+RTbaeUs=;
        b=GflQBvIFyXKw+XPR+/HIYL99fNjT3AfVf0QTd0Jm9UVn/SzNY1SxkgCoME4DVM9r
        4xuJWn4Q6888r/v9nbrMatan9S92R5ohzvnXbe5lLSTjXlvg6NkjetTy02mXAhkE24B
        ybY0d6CZkUOZo4ps4xmuNe+csbBbjeqX+lhLbdtY=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1575512065;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:Feedback-ID;
        bh=sN9HQYh6wIVagBIBwBcjFatf2XSTX81OaYD+RTbaeUs=;
        b=UNDyhtjZe6DF+H4AXuE5OkFRH3grYEMaBUNzW2p9rvBxogPisOI2NGvAR1a1k5Sa
        9HdE94WtZGP32gMg6BfnryoiEPMS1wFDOS+sPFpAnTKGKFVyTvB0zOnZHZhfrN4WDSl
        klyKsyb/eaZeZVvYz/pqHExTAg6JYSvtQg634QpM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 244C2C6430B
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=cang@codeaurora.org
From:   Can Guo <cang@codeaurora.org>
To:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        rnayak@codeaurora.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com, saravanak@google.com, salyzyn@google.com,
        cang@codeaurora.org
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 1/5] scsi: Adjust DBD setting in mode sense for caching mode page per LLD
Date:   Thu, 5 Dec 2019 02:14:25 +0000
Message-ID: <0101016ed3d643f9-ffd45d6c-c593-4a13-a18f-a32da3d3bb97-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1575512052-15999-1-git-send-email-cang@codeaurora.org>
References: <1575512052-15999-1-git-send-email-cang@codeaurora.org>
X-SES-Outgoing: 2019.12.05-54.240.27.55
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

UFS JEDEC standards require DBD field to be set to 1 in mode sense command.
This patch allows LLD to define the setting of DBD if required.

Signed-off-by: Can Guo <cang@codeaurora.org>
---
 drivers/scsi/scsi_lib.c    | 2 ++
 include/scsi/scsi_device.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 5447738..3812e90 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2108,6 +2108,8 @@ void scsi_exit_queue(void)
 
 	memset(data, 0, sizeof(*data));
 	memset(&cmd[0], 0, 12);
+
+	dbd = sdev->set_dbd_for_ms ? 8 : dbd;
 	cmd[1] = dbd & 0x18;	/* allows DBD and LLBA bits */
 	cmd[2] = modepage;
 
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index 3ed836d..f8312a3 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -172,6 +172,7 @@ struct scsi_device {
 				     * because we did a bus reset. */
 	unsigned use_10_for_rw:1; /* first try 10-byte read / write */
 	unsigned use_10_for_ms:1; /* first try 10-byte mode sense/select */
+	unsigned set_dbd_for_ms:1; /* Set "DBD" field in mode sense */
 	unsigned no_report_opcodes:1;	/* no REPORT SUPPORTED OPERATION CODES */
 	unsigned no_write_same:1;	/* no WRITE SAME command */
 	unsigned use_16_for_rw:1; /* Use read/write(16) over read/write(10) */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

