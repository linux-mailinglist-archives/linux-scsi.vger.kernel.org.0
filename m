Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5317ABCC3
	for <lists+linux-scsi@lfdr.de>; Sat, 23 Sep 2023 02:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjIWAay (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 22 Sep 2023 20:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjIWAaL (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 22 Sep 2023 20:30:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11ED1CC1;
        Fri, 22 Sep 2023 17:30:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F06C433C8;
        Sat, 23 Sep 2023 00:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695429000;
        bh=tIQ/APgi+9Mtiz/2aAn4OUJwm8gHKymE8WJyLlZD5/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W5CbdYGGaCytv4Wb5j1c8Cc4FjLCUO5FgJ+ZUZccLalW/xNj9z6OBbWLFRrfCU+Gm
         G8rKJLXdYrCZzW2PFUGfjrRy4moYcZuu8ExpjGnENCS52LWP64kVSQkoUU1scvHxJr
         4chwgMw9XyDe0r15pve5s9T28kNlaG7DQ2NXrtJKoLzh5YgciL/EZ0gh/iC9TkWAk2
         PxkmQdFg//+cWK/AjxRzr7xti8PW0wj8I2ihUFjy/MhSBVidqbRIrHsibQdMmFz4HH
         Uks8p3tv4KhLK3iDRIRf9+JU4dbCQN7fnBLmkNepIWFvUjfdsPgTGX/TSAFN7eRDss
         u1KtBUIy9hiAQ==
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
Subject: [PATCH v6 17/23] ata: libata-core: Remove ata_port_resume_async()
Date:   Sat, 23 Sep 2023 09:29:26 +0900
Message-ID: <20230923002932.1082348-18-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230923002932.1082348-1-dlemoal@kernel.org>
References: <20230923002932.1082348-1-dlemoal@kernel.org>
MIME-Version: 1.0
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

Remove ata_port_resume_async() and replace it with a modified
ata_port_resume() taking an additional bool argument indicating if
ata EH resume operation should be executed synchronously or
asynchronously. With this change, the variable ata_port_resume_ehi is
not longer necessary and its value (ATA_EHI_XXX flags) passed directly
to ata_port_request_pm().

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Tested-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 drivers/ata/libata-core.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 291fc686ff08..6773a1e52dad 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5219,22 +5219,17 @@ static int ata_port_pm_poweroff(struct device *dev)
 	return 0;
 }
 
-static const unsigned int ata_port_resume_ehi = ATA_EHI_NO_AUTOPSY
-						| ATA_EHI_QUIET;
-
-static void ata_port_resume(struct ata_port *ap, pm_message_t mesg)
+static void ata_port_resume(struct ata_port *ap, pm_message_t mesg,
+			    bool async)
 {
-	ata_port_request_pm(ap, mesg, ATA_EH_RESET, ata_port_resume_ehi, false);
-}
-
-static void ata_port_resume_async(struct ata_port *ap, pm_message_t mesg)
-{
-	ata_port_request_pm(ap, mesg, ATA_EH_RESET, ata_port_resume_ehi, true);
+	ata_port_request_pm(ap, mesg, ATA_EH_RESET,
+			    ATA_EHI_NO_AUTOPSY | ATA_EHI_QUIET,
+			    async);
 }
 
 static int ata_port_pm_resume(struct device *dev)
 {
-	ata_port_resume_async(to_ata_port(dev), PMSG_RESUME);
+	ata_port_resume(to_ata_port(dev), PMSG_RESUME, true);
 	pm_runtime_disable(dev);
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
@@ -5273,7 +5268,7 @@ static int ata_port_runtime_suspend(struct device *dev)
 
 static int ata_port_runtime_resume(struct device *dev)
 {
-	ata_port_resume(to_ata_port(dev), PMSG_AUTO_RESUME);
+	ata_port_resume(to_ata_port(dev), PMSG_AUTO_RESUME, false);
 	return 0;
 }
 
@@ -5303,7 +5298,7 @@ EXPORT_SYMBOL_GPL(ata_sas_port_suspend);
 
 void ata_sas_port_resume(struct ata_port *ap)
 {
-	ata_port_resume_async(ap, PMSG_RESUME);
+	ata_port_resume(ap, PMSG_RESUME, true);
 }
 EXPORT_SYMBOL_GPL(ata_sas_port_resume);
 
-- 
2.41.0

