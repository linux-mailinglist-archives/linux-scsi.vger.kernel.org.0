Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BC67ABCCC
	for <lists+linux-scsi@lfdr.de>; Sat, 23 Sep 2023 02:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjIWAbR (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 22 Sep 2023 20:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjIWAaf (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 22 Sep 2023 20:30:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAEF1A7;
        Fri, 22 Sep 2023 17:30:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95590C433C7;
        Sat, 23 Sep 2023 00:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695429006;
        bh=ivSqt8eYECZ8WOxEKDAq1kGxxTWXRhFriR2bEOYAGzA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RtjK9oKnQM0YI4+Nhp8vTUU/5jw7MUvkgDoLdXvad2czR+Sx0tCO3xSzNQ5scloGA
         sXMwNbzAZVEfk3dUR1rbso3xgN+d9fqW5kVGsFr8oFcEei6KRC+75BrcXAUAZFv4mS
         c2m5N592NJw6Ia5JmbmpzkKCEQZ6fOe9HZBc0CS/ob7Y4sU+NETDhXdgK+V41wQtwl
         fz9CHY5rCXyQYGIWS0odMLRrIy/4PUIVQ+H8mTMVRidRASMJieUwvHBCZEyFbNRIx6
         9MqXtFtYwQwLXdv2ire7cnfvGz1k0X818/jC1XGBUyjwlm+fdPepGBZwGvb2meffft
         riR0Bjf+HRtOQ==
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
Subject: [PATCH v6 21/23] ata: libata-eh: Improve reset error messages
Date:   Sat, 23 Sep 2023 09:29:30 +0900
Message-ID: <20230923002932.1082348-22-dlemoal@kernel.org>
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

Some drives are really slow to spinup on resume, resulting is a very
slow response to COMRESET and to error messages such as:

ata1: COMRESET failed (errno=-16)
ata1: link is slow to respond, please be patient (ready=0)
ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
ata1.00: configured for UDMA/133

Given that the slowness of the response is indicated with the message
"link is slow to respond..." and that resets are retried until the
device is detected as online after up to 1min (ata_eh_reset_timeouts),
there is no point in printing the "COMRESET failed" error message. Let's
not scare the user with non fatal errors and only warn about reset
failures in ata_eh_reset() when all reset retries have been exhausted.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Tested-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 drivers/ata/libata-eh.c   | 2 ++
 drivers/ata/libata-sata.c | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 5686353e442c..67387d602735 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2909,6 +2909,8 @@ int ata_eh_reset(struct ata_link *link, int classify,
 		 */
 		if (ata_is_host_link(link))
 			ata_eh_thaw_port(ap);
+		ata_link_warn(link, "%s failed\n",
+			      reset == hardreset ? "hardreset" : "softreset");
 		goto out;
 	}
 
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 83a9497e48e1..b6656c287175 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -621,7 +621,6 @@ int sata_link_hardreset(struct ata_link *link, const unsigned int *timing,
 		/* online is set iff link is online && reset succeeded */
 		if (online)
 			*online = false;
-		ata_link_err(link, "COMRESET failed (errno=%d)\n", rc);
 	}
 	return rc;
 }
-- 
2.41.0

