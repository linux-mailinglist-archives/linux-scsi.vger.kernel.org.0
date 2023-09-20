Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2852A7A8411
	for <lists+linux-scsi@lfdr.de>; Wed, 20 Sep 2023 15:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236567AbjITNzy (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 20 Sep 2023 09:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236571AbjITNzV (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 20 Sep 2023 09:55:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F721BB;
        Wed, 20 Sep 2023 06:55:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD60C433CA;
        Wed, 20 Sep 2023 13:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695218102;
        bh=UhZ2bFf+kQ/4U5ft9w5rMIxHdtUZwAuzeonecWsYoPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eJLCGwdgICaLXIZrTr7+mYT2koe4fNgIDvUYZ3o0QeZGPmKCJ/tcu1+5xbsVIl1aU
         mrABH92fw2KKpJlzpMFXTeIw72dtNWUAuoZnq4V196qZ/ntDaWS4kdbOvqweIixbtR
         cb9GQ7UnBrPk+X71neeDYDr0BndWqxtYNw9sCDxJEPbKbBOgNzSnoCgvB/FJtlNMWv
         2pn41unBEM2zyROSjWm9gcvcB+qK070oE5Y4Byk7u31QRRZI/DRxSD/LqoBdQY6597
         7B1CtajuGpESDdzoEmYaESi7Rb3qIUidqmDICbvQ/K2gyONzbAH61EHXpY6Yc54GqA
         218p5+b4GZR/A==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     linux-ide@vger.kernel.org
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        John Garry <john.g.garry@oracle.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Paul Ausbeck <paula@soe.ucsc.edu>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Joe Breuer <linux-kernel@jmbreuer.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Chia-Lin Kao <acelan.kao@canonical.com>
Subject: [PATCH v4 11/23] ata: libata-eh: Fix compilation warning in ata_eh_link_report()
Date:   Wed, 20 Sep 2023 22:54:27 +0900
Message-ID: <20230920135439.929695-12-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920135439.929695-1-dlemoal@kernel.org>
References: <20230920135439.929695-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The 6 bytes length of the tries_buf string in ata_eh_link_report() is
too short and results in a gcc compilation warning with W-!:

drivers/ata/libata-eh.c: In function ‘ata_eh_link_report’:
drivers/ata/libata-eh.c:2371:59: warning: ‘%d’ directive output may be truncated writing between 1 and 11 bytes into a region of size 4 [-Wformat-truncation=]
 2371 |                 snprintf(tries_buf, sizeof(tries_buf), " t%d",
      |                                                           ^~
drivers/ata/libata-eh.c:2371:56: note: directive argument in the range [-2147483648, 4]
 2371 |                 snprintf(tries_buf, sizeof(tries_buf), " t%d",
      |                                                        ^~~~~~
drivers/ata/libata-eh.c:2371:17: note: ‘snprintf’ output between 4 and 14 bytes into a destination of size 6
 2371 |                 snprintf(tries_buf, sizeof(tries_buf), " t%d",
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 2372 |                          ap->eh_tries);
      |                          ~~~~~~~~~~~~~

Avoid this warning by increasing the string size to 16B.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-eh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index b1b2c276371e..5686353e442c 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2332,7 +2332,7 @@ static void ata_eh_link_report(struct ata_link *link)
 	struct ata_eh_context *ehc = &link->eh_context;
 	struct ata_queued_cmd *qc;
 	const char *frozen, *desc;
-	char tries_buf[6] = "";
+	char tries_buf[16] = "";
 	int tag, nr_failed = 0;
 
 	if (ehc->i.flags & ATA_EHI_QUIET)
-- 
2.41.0

