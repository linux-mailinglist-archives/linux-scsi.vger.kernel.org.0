Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1692D87BF
	for <lists+linux-scsi@lfdr.de>; Sat, 12 Dec 2020 17:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439353AbgLLQLB (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 12 Dec 2020 11:11:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:57726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439499AbgLLQKu (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 12 Dec 2020 11:10:50 -0500
From:   Sasha Levin <sashal@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>,
        MPT-FusionLinux.pdl@avagotech.com, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 4/5] scsi: mpt3sas: Increase IOCInit request timeout to 30s
Date:   Sat, 12 Dec 2020 11:09:08 -0500
Message-Id: <20201212160910.2335511-4-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201212160910.2335511-1-sashal@kernel.org>
References: <20201212160910.2335511-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Sreekanth Reddy <sreekanth.reddy@broadcom.com>

[ Upstream commit 85dad327d9b58b4c9ce08189a2707167de392d23 ]

Currently the IOCInit request message timeout is set to 10s. This is not
sufficient in some scenarios such as during HBA FW downgrade operations.

Increase the IOCInit request timeout to 30s.

Link: https://lore.kernel.org/r/20201130082733.26120-1-sreekanth.reddy@broadcom.com
Signed-off-by: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 601a93953307d..16716b2644020 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -4477,7 +4477,7 @@ _base_send_ioc_init(struct MPT3SAS_ADAPTER *ioc)
 
 	r = _base_handshake_req_reply_wait(ioc,
 	    sizeof(Mpi2IOCInitRequest_t), (u32 *)&mpi_request,
-	    sizeof(Mpi2IOCInitReply_t), (u16 *)&mpi_reply, 10);
+	    sizeof(Mpi2IOCInitReply_t), (u16 *)&mpi_reply, 30);
 
 	if (r != 0) {
 		pr_err(MPT3SAS_FMT "%s: handshake failed (r=%d)\n",
-- 
2.27.0

