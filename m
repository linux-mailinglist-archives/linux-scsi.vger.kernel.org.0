Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7751F1E8F97
	for <lists+linux-scsi@lfdr.de>; Sat, 30 May 2020 10:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbgE3IQ2 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 30 May 2020 04:16:28 -0400
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:30359 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728714AbgE3IQ1 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 30 May 2020 04:16:27 -0400
Received: from localhost.localdomain ([93.23.15.192])
        by mwinf5d20 with ME
        id kwGQ2200848dfat03wGQZq; Sat, 30 May 2020 10:16:25 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 30 May 2020 10:16:25 +0200
X-ME-IP: 93.23.15.192
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     linux@armlinux.org.uk, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] scsi: acornscsi: Fix an error handling path in 'acornscsi_probe()'
Date:   Sat, 30 May 2020 10:16:22 +0200
Message-Id: <20200530081622.577888-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

'ret' is known to be 0 at this point.
So, explicitly return -ENOMEM if one of the 'ecardm_iomap()' calls fail.

Fixes: e95a1b656a98 ("[ARM] rpc: acornscsi: update to new style ecard driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/scsi/arm/acornscsi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/arm/acornscsi.c b/drivers/scsi/arm/acornscsi.c
index ddb52e7ba622..9a912fd0f70b 100644
--- a/drivers/scsi/arm/acornscsi.c
+++ b/drivers/scsi/arm/acornscsi.c
@@ -2911,8 +2911,10 @@ static int acornscsi_probe(struct expansion_card *ec, const struct ecard_id *id)
 
 	ashost->base = ecardm_iomap(ec, ECARD_RES_MEMC, 0, 0);
 	ashost->fast = ecardm_iomap(ec, ECARD_RES_IOCFAST, 0, 0);
-	if (!ashost->base || !ashost->fast)
+	if (!ashost->base || !ashost->fast) {
+		ret = -ENOMEM;
 		goto out_put;
+	}
 
 	host->irq = ec->irq;
 	ashost->host = host;
-- 
2.25.1

