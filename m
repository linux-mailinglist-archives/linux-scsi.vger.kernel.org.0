Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24F5F15F264
	for <lists+linux-scsi@lfdr.de>; Fri, 14 Feb 2020 19:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392776AbgBNSJF (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 14 Feb 2020 13:09:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:33878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731419AbgBNPyH (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 14 Feb 2020 10:54:07 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC4F424676;
        Fri, 14 Feb 2020 15:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695646;
        bh=1L6PruW8DRWloz+xn+Gy+OBmxLDKPYs4iLoR6I/pKrg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RiJ6WX+SD4eabAAC8DAz/a74nd32UMTzPD1Bx/2xCcYCBtCXZZaXNxjV5Fbl9dFa3
         VjG7UdV/Z8P5JyhccGH3WPoUcDTh0Id37h1pNZKJI7R3LOD0tEqmeq2AqAypiZGhTS
         +a4WHzhojxAa6mLovYyIMydNRHYriqC3nUseRDlk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chen Zhou <chenzhou10@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 240/542] scsi: ibmvscsi_tgt: remove set but not used variables 'iue' and 'sd'
Date:   Fri, 14 Feb 2020 10:43:52 -0500
Message-Id: <20200214154854.6746-240-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Chen Zhou <chenzhou10@huawei.com>

[ Upstream commit 4aca8fe7716669e39f7857b2e1fc5dfd4475b7e5 ]

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c: In function ibmvscsis_send_messages:
drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:1888:19: warning: variable iue set but not used [-Wunused-but-set-variable]
drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c: In function ibmvscsis_queue_data_in:
drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:3806:8: warning: variable sd set but not used [-Wunused-but-set-variable]

Link: https://lore.kernel.org/r/20191213064042.161840-1-chenzhou10@huawei.com
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
index 54b8c6f9daf4b..d9e94e81da017 100644
--- a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
+++ b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
@@ -1877,7 +1877,6 @@ static void ibmvscsis_send_messages(struct scsi_info *vscsi)
 	 */
 	struct viosrp_crq *crq = (struct viosrp_crq *)&msg_hi;
 	struct ibmvscsis_cmd *cmd, *nxt;
-	struct iu_entry *iue;
 	long rc = ADAPT_SUCCESS;
 	bool retry = false;
 
@@ -1931,8 +1930,6 @@ static void ibmvscsis_send_messages(struct scsi_info *vscsi)
 					 */
 					vscsi->credit += 1;
 				} else {
-					iue = cmd->iue;
-
 					crq->valid = VALID_CMD_RESP_EL;
 					crq->format = cmd->rsp.format;
 
@@ -3796,7 +3793,6 @@ static int ibmvscsis_queue_data_in(struct se_cmd *se_cmd)
 						 se_cmd);
 	struct iu_entry *iue = cmd->iue;
 	struct scsi_info *vscsi = cmd->adapter;
-	char *sd;
 	uint len = 0;
 	int rc;
 
@@ -3804,7 +3800,6 @@ static int ibmvscsis_queue_data_in(struct se_cmd *se_cmd)
 			       1);
 	if (rc) {
 		dev_err(&vscsi->dev, "srp_transfer_data failed: %d\n", rc);
-		sd = se_cmd->sense_buffer;
 		se_cmd->scsi_sense_length = 18;
 		memset(se_cmd->sense_buffer, 0, se_cmd->scsi_sense_length);
 		/* Logical Unit Communication Time-out asc/ascq = 0x0801 */
-- 
2.20.1

