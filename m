Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62B47149B5B
	for <lists+linux-scsi@lfdr.de>; Sun, 26 Jan 2020 16:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgAZPRv (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 26 Jan 2020 10:17:51 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:32834 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbgAZPRv (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 26 Jan 2020 10:17:51 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1ivjfX-00088L-B9; Sun, 26 Jan 2020 15:17:47 +0000
From:   Colin King <colin.king@canonical.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: mvsas: ensure loop counter phy_no  does not wrap and cause an infinite loop
Date:   Sun, 26 Jan 2020 15:17:47 +0000
Message-Id: <20200126151747.33320-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The loop counter phy_no is a u8 where as the upper limit of the loop
is a u32. In the event that upper limit is greater than 255 we end
up with an infinite loop since phy_no will wrap around an never reach
upper loop limit. Fix this by making phy_no a u32.

Addresses-Coverity: ("Infinite loop")
Fixes: 20b09c2992fe ("[SCSI] mvsas: add support for 94xx; layout change; bug fixes")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/mvsas/mv_sas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/mvsas/mv_sas.c b/drivers/scsi/mvsas/mv_sas.c
index a920eced92ec..9c03f23bde54 100644
--- a/drivers/scsi/mvsas/mv_sas.c
+++ b/drivers/scsi/mvsas/mv_sas.c
@@ -1940,7 +1940,7 @@ static void mvs_sig_time_out(struct timer_list *t)
 {
 	struct mvs_phy *phy = from_timer(phy, t, timer);
 	struct mvs_info *mvi = phy->mvi;
-	u8 phy_no;
+	u32 phy_no;
 
 	for (phy_no = 0; phy_no < mvi->chip->n_phy; phy_no++) {
 		if (&mvi->phy[phy_no] == phy) {
-- 
2.24.0

