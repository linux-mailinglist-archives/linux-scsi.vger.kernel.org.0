Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2EBE24AAE1
	for <lists+linux-scsi@lfdr.de>; Thu, 20 Aug 2020 02:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbgHTADr (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 19 Aug 2020 20:03:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:33582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726841AbgHTADn (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 19 Aug 2020 20:03:43 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C584921741;
        Thu, 20 Aug 2020 00:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597881823;
        bh=8vKLAkZ6WxQt+UZuDbu0chFB9hMbtXM+qxhcHfoNxr4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=noPVAgm2EFL1zk2JP0Lz+d5x4rTXa/W5f/CafaaqRhfJuQ9OO3M+3DZ7GtAaAHhJX
         SCHMHvHbhpTOvtICXd9qfpQHUhx9y6t34yb0UgzN1Um9XYhXrkjnEQJPbnuR5yPc3F
         RkTS7dPTWfpbc+H4DRwDUxs4M7w09VAlnEmS0/5U=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Javed Hasan <jhasan@marvell.com>,
        Girish Basrur <gbasrur@marvell.com>,
        Santosh Vernekar <svernekar@marvell.com>,
        Saurav Kashyap <skashyap@marvell.com>,
        Shyam Sundar <ssundar@marvell.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 10/13] scsi: libfc: Free skb in fc_disc_gpn_id_resp() for valid cases
Date:   Wed, 19 Aug 2020 20:03:25 -0400
Message-Id: <20200820000328.215755-10-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200820000328.215755-1-sashal@kernel.org>
References: <20200820000328.215755-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Javed Hasan <jhasan@marvell.com>

[ Upstream commit ec007ef40abb6a164d148b0dc19789a7a2de2cc8 ]

In fc_disc_gpn_id_resp(), skb is supposed to get freed in all cases except
for PTR_ERR. However, in some cases it didn't.

This fix is to call fc_frame_free(fp) before function returns.

Link: https://lore.kernel.org/r/20200729081824.30996-2-jhasan@marvell.com
Reviewed-by: Girish Basrur <gbasrur@marvell.com>
Reviewed-by: Santosh Vernekar <svernekar@marvell.com>
Reviewed-by: Saurav Kashyap <skashyap@marvell.com>
Reviewed-by: Shyam Sundar <ssundar@marvell.com>
Signed-off-by: Javed Hasan <jhasan@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/libfc/fc_disc.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/libfc/fc_disc.c b/drivers/scsi/libfc/fc_disc.c
index 28b50ab2fbb01..62f83cc151b22 100644
--- a/drivers/scsi/libfc/fc_disc.c
+++ b/drivers/scsi/libfc/fc_disc.c
@@ -605,8 +605,12 @@ static void fc_disc_gpn_id_resp(struct fc_seq *sp, struct fc_frame *fp,
 
 	if (PTR_ERR(fp) == -FC_EX_CLOSED)
 		goto out;
-	if (IS_ERR(fp))
-		goto redisc;
+	if (IS_ERR(fp)) {
+		mutex_lock(&disc->disc_mutex);
+		fc_disc_restart(disc);
+		mutex_unlock(&disc->disc_mutex);
+		goto out;
+	}
 
 	cp = fc_frame_payload_get(fp, sizeof(*cp));
 	if (!cp)
@@ -633,7 +637,7 @@ static void fc_disc_gpn_id_resp(struct fc_seq *sp, struct fc_frame *fp,
 				new_rdata->disc_id = disc->disc_id;
 				fc_rport_login(new_rdata);
 			}
-			goto out;
+			goto free_fp;
 		}
 		rdata->disc_id = disc->disc_id;
 		mutex_unlock(&rdata->rp_mutex);
@@ -650,6 +654,8 @@ static void fc_disc_gpn_id_resp(struct fc_seq *sp, struct fc_frame *fp,
 		fc_disc_restart(disc);
 		mutex_unlock(&disc->disc_mutex);
 	}
+free_fp:
+	fc_frame_free(fp);
 out:
 	kref_put(&rdata->kref, fc_rport_destroy);
 	if (!IS_ERR(fp))
-- 
2.25.1

