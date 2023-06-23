Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7972973B1B0
	for <lists+linux-scsi@lfdr.de>; Fri, 23 Jun 2023 09:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjFWHbH (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 23 Jun 2023 03:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjFWHbG (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 23 Jun 2023 03:31:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566F32128
        for <linux-scsi@vger.kernel.org>; Fri, 23 Jun 2023 00:31:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7DB66198E
        for <linux-scsi@vger.kernel.org>; Fri, 23 Jun 2023 07:30:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D35D0C433C0;
        Fri, 23 Jun 2023 07:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687505459;
        bh=DRXD/f6g0JWBc8hYMCFtLqO8imOHceLXOWDtWDSAFuU=;
        h=From:To:Cc:Subject:Date:From;
        b=H3oJVFGJKhIp0fozg+9u5P3LjSNKKgYOjuf7cxsoc8OsIa8wIQoB/GiCGfFi79oVG
         FnnEKROz37GyriPPVE0TiskTG0lgnVVQwtXGBiwt+j/CZ8gqoThEt1v8HaSOJ5qlFX
         S0cwXCaWRt27b771DwJnWIxMQXM8/TAL1lm15AnlSPeGFZe/zkHM2+Rsw+NJUp0cqJ
         WPJMiYHbRst/nN0PuGSQSOloT0njLTMCSHcZ3ZJroH7X8hcgVGsFkPhVZnWI1e2btg
         g5UCZiFtQHr8Yu0t0Er8aA6Fe3oPeR9oQx97p/+mvzQbM+eRHrit/XqTQGqKs51OUO
         SsRRQXLslkL4w==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH v2] scsi: Simplify scsi_cdl_check_cmd()
Date:   Fri, 23 Jun 2023 16:30:57 +0900
Message-Id: <20230623073057.816199-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Reading the 800+ pages of SPC often leads to a brain shutdown and to
less than ideal code... This resulted in the checks of the rwcdlp and
cdlp fields in scsi_cdl_check_cmd() to have identical if-else branches.

Replace this with a comment describing the cases we are interested in
and replace the if-else code block with a simple test of the cdlp field
that is used as the function return value.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@inria.fr>
Closes: https://lore.kernel.org/r/202306221657.BJHEADkz-lkp@intel.com/
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
Changes from v1:
 * Reword the comment to follow SPC wording for "One_command parameter
   data format"

 drivers/scsi/scsi.c | 37 ++++++++++++++-----------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index c4bf99a842f3..d0911bc28663 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -586,31 +586,22 @@ static bool scsi_cdl_check_cmd(struct scsi_device *sdev, u8 opcode, u16 sa,
 	if ((buf[1] & 0x03) != 0x03)
 		return false;
 
-	/* See SPC-6, one command format of REPORT SUPPORTED OPERATION CODES */
+	/*
+	 * See SPC-6, One_command parameter data format for
+	 * REPORT SUPPORTED OPERATION CODES. We have the following cases
+	 * depending on rwcdlp (buf[0] & 0x01) value:
+	 *  - rwcdlp == 0: then cdlp indicates support for the A mode page when
+	 *		   it is equal to 1 and for the B mode page when it is
+	 *		   equal to 2.
+	 *  - rwcdlp == 1: then cdlp indicates support for the T2A mode page
+	 *		   when it is equal to 1 and for the T2B mode page when
+	 *		   it is equal to 2.
+	 * Overall, to detect support for command duration limits, we only need
+	 * to check that cdlp is 1 or 2.
+	 */
 	cdlp = (buf[1] & 0x18) >> 3;
-	if (buf[0] & 0x01) {
-		/* rwcdlp == 1 */
-		switch (cdlp) {
-		case 0x01:
-			/* T2A page */
-			return true;
-		case 0x02:
-			/* T2B page */
-			return true;
-		}
-	} else {
-		/* rwcdlp == 0 */
-		switch (cdlp) {
-		case 0x01:
-			/* A page */
-			return true;
-		case 0x02:
-			/* B page */
-			return true;
-		}
-	}
 
-	return false;
+	return cdlp == 0x01 || cdlp == 0x02;
 }
 
 /**
-- 
2.40.1

