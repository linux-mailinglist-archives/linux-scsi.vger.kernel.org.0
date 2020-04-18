Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 813EA1AEDA2
	for <lists+linux-scsi@lfdr.de>; Sat, 18 Apr 2020 15:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgDRNxG (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 18 Apr 2020 09:53:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:54744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726396AbgDRNsa (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 18 Apr 2020 09:48:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 891C9221F4;
        Sat, 18 Apr 2020 13:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587217710;
        bh=zxMAMCUGege0v8kJLkpgkDzKu7rKYEby4bGm0U/va+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CnG+BTpJVDcAmu9HFi3UCzPv1ChjwVaeLUKORpX5U+FhcnhmsK+d+beWuk3seDXoL
         37WajJYb0tf92TXCsONixsgRwynKxxNiJ35GKXGtZcbgY/MtQ2ObGtL+KoPD07WR1S
         uv8GoO2XIUSIBAeT1OeV4WsgIJrif4RbQUKLeiyM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Javed Hasan <jhasan@marvell.com>,
        Saurav Kashyap <skashyap@marvell.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 12/73] scsi: libfc: If PRLI rejected, move rport to PLOGI state
Date:   Sat, 18 Apr 2020 09:47:14 -0400
Message-Id: <20200418134815.6519-12-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418134815.6519-1-sashal@kernel.org>
References: <20200418134815.6519-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Javed Hasan <jhasan@marvell.com>

[ Upstream commit 45e544bfdab2014d11c7595b8ccc3c4715a09015 ]

If PRLI reject code indicates "rejected status", move rport state machine
back to PLOGI state.

Link: https://lore.kernel.org/r/20200327060208.17104-2-skashyap@marvell.com
Signed-off-by: Javed Hasan <jhasan@marvell.com>
Signed-off-by: Saurav Kashyap <skashyap@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/libfc/fc_rport.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/libfc/fc_rport.c b/drivers/scsi/libfc/fc_rport.c
index da6e97d8dc3bb..6bb8917b99a19 100644
--- a/drivers/scsi/libfc/fc_rport.c
+++ b/drivers/scsi/libfc/fc_rport.c
@@ -1208,9 +1208,15 @@ static void fc_rport_prli_resp(struct fc_seq *sp, struct fc_frame *fp,
 		rjt = fc_frame_payload_get(fp, sizeof(*rjt));
 		if (!rjt)
 			FC_RPORT_DBG(rdata, "PRLI bad response\n");
-		else
+		else {
 			FC_RPORT_DBG(rdata, "PRLI ELS rejected, reason %x expl %x\n",
 				     rjt->er_reason, rjt->er_explan);
+			if (rjt->er_reason == ELS_RJT_UNAB &&
+			    rjt->er_explan == ELS_EXPL_PLOGI_REQD) {
+				fc_rport_enter_plogi(rdata);
+				goto out;
+			}
+		}
 		fc_rport_error_retry(rdata, FC_EX_ELS_RJT);
 	}
 
-- 
2.20.1

