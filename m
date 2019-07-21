Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F27A6F348
	for <lists+linux-scsi@lfdr.de>; Sun, 21 Jul 2019 14:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfGUMvE (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 21 Jul 2019 08:51:04 -0400
Received: from smtp11.smtpout.orange.fr ([80.12.242.133]:53979 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbfGUMvE (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 21 Jul 2019 08:51:04 -0400
Received: from localhost.localdomain ([92.140.204.221])
        by mwinf5d34 with ME
        id fQr0200024n7eLC03Qr03l; Sun, 21 Jul 2019 14:51:01 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 21 Jul 2019 14:51:01 +0200
X-ME-IP: 92.140.204.221
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     hare@suse.de, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] scsi: fcoe: fix a typo
Date:   Sun, 21 Jul 2019 14:50:39 +0200
Message-Id: <20190721125039.13268-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

#define relative to FCOE CTLR start with FCOE_CTLR, except
FCOE_CTRL_SOL_TOV.

This is likely a typo and CTRL should be CTLR here as well.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/scsi/fcoe/fcoe_ctlr.c | 2 +-
 include/scsi/libfcoe.h        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/fcoe/fcoe_ctlr.c b/drivers/scsi/fcoe/fcoe_ctlr.c
index 0d7770d07405..5aaa3298de6f 100644
--- a/drivers/scsi/fcoe/fcoe_ctlr.c
+++ b/drivers/scsi/fcoe/fcoe_ctlr.c
@@ -1019,7 +1019,7 @@ static void fcoe_ctlr_recv_adv(struct fcoe_ctlr *fip, struct sk_buff *skb)
 {
 	struct fcoe_fcf *fcf;
 	struct fcoe_fcf new;
-	unsigned long sol_tov = msecs_to_jiffies(FCOE_CTRL_SOL_TOV);
+	unsigned long sol_tov = msecs_to_jiffies(FCOE_CTLR_SOL_TOV);
 	int first = 0;
 	int mtu_valid;
 	int found = 0;
diff --git a/include/scsi/libfcoe.h b/include/scsi/libfcoe.h
index c50fb297e265..dc14b52577f7 100644
--- a/include/scsi/libfcoe.h
+++ b/include/scsi/libfcoe.h
@@ -31,7 +31,7 @@
  * FIP tunable parameters.
  */
 #define FCOE_CTLR_START_DELAY	2000	/* mS after first adv. to choose FCF */
-#define FCOE_CTRL_SOL_TOV	2000	/* min. solicitation interval (mS) */
+#define FCOE_CTLR_SOL_TOV	2000	/* min. solicitation interval (mS) */
 #define FCOE_CTLR_FCF_LIMIT	20	/* max. number of FCF entries */
 #define FCOE_CTLR_VN2VN_LOGIN_LIMIT 3	/* max. VN2VN rport login retries */
 
-- 
2.20.1

