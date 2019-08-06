Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D49E583C00
	for <lists+linux-scsi@lfdr.de>; Tue,  6 Aug 2019 23:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbfHFVjg (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 6 Aug 2019 17:39:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:55272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729351AbfHFVha (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 6 Aug 2019 17:37:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B4A821874;
        Tue,  6 Aug 2019 21:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565127450;
        bh=i4cYp5VFecvi+4i+fcVFtpNTa9F1GwX1EdbRRya6u1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kOs2QvBPtmFhyoFqmjFIrcVjMZjf2x/lTrC1dgP5WMr+2W4Zt1gdwuHE+VWaAZa3f
         kWwkhKSUnrWfjfKyuBX9RV3PdLWBZV+7IphO5RxeToLj0mpKN94M2spDemjCJ4GsWJ
         Ji0/wX6aSQBDSeDKvAI2txumhQiIMuimu3dpTQh8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Don Brace <don.brace@microsemi.com>,
        Bader Ali - Saleh <bader.alisaleh@microsemi.com>,
        Scott Teel <scott.teel@microsemi.com>,
        Scott Benesh <scott.benesh@microsemi.com>,
        Kevin Barnett <kevin.barnett@microsemi.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, esc.storagedev@microsemi.com,
        linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 07/17] scsi: hpsa: correct scsi command status issue after reset
Date:   Tue,  6 Aug 2019 17:37:04 -0400
Message-Id: <20190806213715.20487-7-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806213715.20487-1-sashal@kernel.org>
References: <20190806213715.20487-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Don Brace <don.brace@microsemi.com>

[ Upstream commit eeebce1862970653cdf5c01e98bc669edd8f529a ]

Reviewed-by: Bader Ali - Saleh <bader.alisaleh@microsemi.com>
Reviewed-by: Scott Teel <scott.teel@microsemi.com>
Reviewed-by: Scott Benesh <scott.benesh@microsemi.com>
Reviewed-by: Kevin Barnett <kevin.barnett@microsemi.com>
Signed-off-by: Don Brace <don.brace@microsemi.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/hpsa.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index 9f98c7211ec24..b82df8cdf9626 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -2236,6 +2236,8 @@ static int handle_ioaccel_mode2_error(struct ctlr_info *h,
 	case IOACCEL2_SERV_RESPONSE_COMPLETE:
 		switch (c2->error_data.status) {
 		case IOACCEL2_STATUS_SR_TASK_COMP_GOOD:
+			if (cmd)
+				cmd->result = 0;
 			break;
 		case IOACCEL2_STATUS_SR_TASK_COMP_CHK_COND:
 			cmd->result |= SAM_STAT_CHECK_CONDITION;
@@ -2423,8 +2425,10 @@ static void process_ioaccel2_completion(struct ctlr_info *h,
 
 	/* check for good status */
 	if (likely(c2->error_data.serv_response == 0 &&
-			c2->error_data.status == 0))
+			c2->error_data.status == 0)) {
+		cmd->result = 0;
 		return hpsa_cmd_free_and_done(h, c, cmd);
+	}
 
 	/*
 	 * Any RAID offload error results in retry which will use
@@ -5511,6 +5515,12 @@ static int hpsa_scsi_queue_command(struct Scsi_Host *sh, struct scsi_cmnd *cmd)
 	}
 	c = cmd_tagged_alloc(h, cmd);
 
+	/*
+	 * This is necessary because the SML doesn't zero out this field during
+	 * error recovery.
+	 */
+	cmd->result = 0;
+
 	/*
 	 * Call alternate submit routine for I/O accelerated commands.
 	 * Retries always go down the normal I/O path.
-- 
2.20.1

