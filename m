Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672C77AA1B2
	for <lists+linux-scsi@lfdr.de>; Thu, 21 Sep 2023 23:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbjIUVFw (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 21 Sep 2023 17:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232717AbjIUVEt (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 21 Sep 2023 17:04:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC870B0591;
        Thu, 21 Sep 2023 11:08:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32187C433C7;
        Thu, 21 Sep 2023 18:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695319706;
        bh=ppb7nxzr/j9CNCzkeE3W0KsRJrVXxnoD+Up1RAuza+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IrY86cpwVSG71w6rJlFX7+17Tx57L9IoKXlOE6xkd1VLa9lz/ZJy0fiqm6wSnq8JE
         SHIG2g0s/qSTKEv0xx9xZkZTrHSo2m67nkAy0Ed2k0mck/k4krtJOEwhBstH/gWdeX
         MkHZ78OVoCv1spCGQVvJ1J06QyFqrZ+qcEsq7x6silvPuhiCgbbH5iT0ANRdTSpJmg
         nv1CF35iGsco3jWfsTJGuMgTvjrXHn/v40Vxx7ejR/wlFUWNQWM46oPVyyY/KSWk8q
         frdEQAiEguP+Gys25Ce2iwfID7Sjz6txPKyocYxObsE+XUbW5aSuivdhtRO82/G4hG
         Jd1G9G8IPitmg==
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
Subject: [PATCH v5 14/23] ata: libata-core: Synchronize ata_port_detach() with hotplug
Date:   Fri, 22 Sep 2023 03:07:49 +0900
Message-ID: <20230921180758.955317-15-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230921180758.955317-1-dlemoal@kernel.org>
References: <20230921180758.955317-1-dlemoal@kernel.org>
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

The call to async_synchronize_cookie() to synchronize a port removal
and hotplug probe is done in ata_host_detach() right before calling
ata_port_detach(). Move this call at the beginning of ata_port_detach()
to ensure that this operation is always synchronized with probe.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Tested-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/ata/libata-core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 8e326a445765..de661780a31e 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6065,6 +6065,9 @@ static void ata_port_detach(struct ata_port *ap)
 	struct ata_link *link;
 	struct ata_device *dev;
 
+	/* Ensure ata_port probe has completed */
+	async_synchronize_cookie(ap->cookie + 1);
+
 	/* Wait for any ongoing EH */
 	ata_port_wait_eh(ap);
 
@@ -6129,11 +6132,8 @@ void ata_host_detach(struct ata_host *host)
 {
 	int i;
 
-	for (i = 0; i < host->n_ports; i++) {
-		/* Ensure ata_port probe has completed */
-		async_synchronize_cookie(host->ports[i]->cookie + 1);
+	for (i = 0; i < host->n_ports; i++)
 		ata_port_detach(host->ports[i]);
-	}
 
 	/* the host is dead now, dissociate ACPI */
 	ata_acpi_dissociate(host);
-- 
2.41.0

