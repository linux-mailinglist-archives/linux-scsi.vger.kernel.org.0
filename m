Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98DD715E083
	for <lists+linux-scsi@lfdr.de>; Fri, 14 Feb 2020 17:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392268AbgBNQOM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 14 Feb 2020 11:14:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:43422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392178AbgBNQOK (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 14 Feb 2020 11:14:10 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D341246D3;
        Fri, 14 Feb 2020 16:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696850;
        bh=XKoTIc29oW1apUheo+XZNDmTHb2Iqz0eGdKtiIjddzw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RqxdNLqOFfiJ4ZSakMqxUt5MvN1nZrs1u5SePLmmLM3EnvWbrXJIvkrjipLjQFln3
         RJkqJsvrmxpbIfB0ThkwwAfBNmJkZJ+YaHWJGYg0daq/tMhNvCBWSObv3tA6+A2DWV
         93vpjuk7TYyMUGabkcO5y1rrCiqm3CUi+hOZ4cOI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chen Zhou <chenzhou10@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 111/252] scsi: ibmvscsi_tgt: remove set but not used variables 'iue' and 'sd'
Date:   Fri, 14 Feb 2020 11:09:26 -0500
Message-Id: <20200214161147.15842-111-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214161147.15842-1-sashal@kernel.org>
References: <20200214161147.15842-1-sashal@kernel.org>
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
index f42a619198c46..9b368a2afb252 100644
--- a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
+++ b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
@@ -1885,7 +1885,6 @@ static void ibmvscsis_send_messages(struct scsi_info *vscsi)
 	 */
 	struct viosrp_crq *crq = (struct viosrp_crq *)&msg_hi;
 	struct ibmvscsis_cmd *cmd, *nxt;
-	struct iu_entry *iue;
 	long rc = ADAPT_SUCCESS;
 	bool retry = false;
 
@@ -1939,8 +1938,6 @@ static void ibmvscsis_send_messages(struct scsi_info *vscsi)
 					 */
 					vscsi->credit += 1;
 				} else {
-					iue = cmd->iue;
-
 					crq->valid = VALID_CMD_RESP_EL;
 					crq->format = cmd->rsp.format;
 
@@ -3814,7 +3811,6 @@ static int ibmvscsis_queue_data_in(struct se_cmd *se_cmd)
 						 se_cmd);
 	struct iu_entry *iue = cmd->iue;
 	struct scsi_info *vscsi = cmd->adapter;
-	char *sd;
 	uint len = 0;
 	int rc;
 
@@ -3822,7 +3818,6 @@ static int ibmvscsis_queue_data_in(struct se_cmd *se_cmd)
 			       1);
 	if (rc) {
 		dev_err(&vscsi->dev, "srp_transfer_data failed: %d\n", rc);
-		sd = se_cmd->sense_buffer;
 		se_cmd->scsi_sense_length = 18;
 		memset(se_cmd->sense_buffer, 0, se_cmd->scsi_sense_length);
 		/* Logical Unit Communication Time-out asc/ascq = 0x0801 */
-- 
2.20.1

