Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64AF11E8EEE
	for <lists+linux-scsi@lfdr.de>; Sat, 30 May 2020 09:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbgE3HgA (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 30 May 2020 03:36:00 -0400
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:38994 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728762AbgE3HgA (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 30 May 2020 03:36:00 -0400
Received: from localhost.localdomain ([93.23.15.192])
        by mwinf5d20 with ME
        id kvbx2200848dfat03vbyza; Sat, 30 May 2020 09:35:58 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 30 May 2020 09:35:58 +0200
X-ME-IP: 93.23.15.192
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     linux@armlinux.org.uk, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] scsi: cumana_2: Fix different dev_id between 'request_irq()' and 'free_irq()'
Date:   Sat, 30 May 2020 09:35:55 +0200
Message-Id: <20200530073555.577414-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The dev_id used in 'request_irq()' and 'free_irq()' should match.
So use 'host' in both cases.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/scsi/arm/cumana_2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/arm/cumana_2.c b/drivers/scsi/arm/cumana_2.c
index 65691c21f133..3a3bf53fa925 100644
--- a/drivers/scsi/arm/cumana_2.c
+++ b/drivers/scsi/arm/cumana_2.c
@@ -426,7 +426,7 @@ static int cumanascsi2_probe(struct expansion_card *ec,
 		goto out_free;
 
 	ret = request_irq(ec->irq, cumanascsi_2_intr,
-			  0, "cumanascsi2", info);
+			  0, "cumanascsi2", host);
 	if (ret) {
 		printk("scsi%d: IRQ%d not free: %d\n",
 		       host->host_no, ec->irq, ret);
-- 
2.25.1

