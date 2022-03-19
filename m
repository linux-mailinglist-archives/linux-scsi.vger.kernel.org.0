Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220564DE69A
	for <lists+linux-scsi@lfdr.de>; Sat, 19 Mar 2022 08:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242298AbiCSHCw (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 19 Mar 2022 03:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235400AbiCSHCt (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 19 Mar 2022 03:02:49 -0400
Received: from smtp.smtpout.orange.fr (smtp05.smtpout.orange.fr [80.12.242.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8B519BE76
        for <linux-scsi@vger.kernel.org>; Sat, 19 Mar 2022 00:01:28 -0700 (PDT)
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id VT5ZnbL9ovjW4VT5ZnU3SP; Sat, 19 Mar 2022 08:01:27 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 19 Mar 2022 08:01:27 +0100
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Bottomley <James.Bottomley@SteelEye.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-scsi@vger.kernel.org
Subject: [PATCH] zorro: Fix a resource leak in zorro7xx_remove_one()
Date:   Sat, 19 Mar 2022 08:01:24 +0100
Message-Id: <247066a3104d25f9a05de8b3270fc3c848763bcc.1647673264.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The error handling path of the probe releases a resource that is not freed
in the remove function.

In some cases, a ioremap() must be undone.

Add the missing iounmap() call in the remove function.

Fixes: 45804fbb00ee ("[SCSI] 53c700: Amiga Zorro NCR53c710 SCSI")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/scsi/zorro7xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/zorro7xx.c b/drivers/scsi/zorro7xx.c
index 27b9e2baab1a..7acf9193a9e8 100644
--- a/drivers/scsi/zorro7xx.c
+++ b/drivers/scsi/zorro7xx.c
@@ -159,6 +159,8 @@ static void zorro7xx_remove_one(struct zorro_dev *z)
 	scsi_remove_host(host);
 
 	NCR_700_release(host);
+	if (host->base > 0x01000000)
+		iounmap(hostdata->base);
 	kfree(hostdata);
 	free_irq(host->irq, host);
 	zorro_release_device(z);
-- 
2.32.0

