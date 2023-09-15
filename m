Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE897A13C4
	for <lists+linux-scsi@lfdr.de>; Fri, 15 Sep 2023 04:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjIOCUl (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 14 Sep 2023 22:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjIOCUk (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 14 Sep 2023 22:20:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EBC1A8
        for <linux-scsi@vger.kernel.org>; Thu, 14 Sep 2023 19:20:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A4E3C433C8;
        Fri, 15 Sep 2023 02:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694744436;
        bh=pEKtWgpU8TX2BFp9rB7es1/dLWKc1SHIGOJr+OJg+HA=;
        h=From:To:Cc:Subject:Date:From;
        b=fLDAl9IiADRIl/P+JbKpmw6PytNU9Ic+jU1WGxI4Qoo7eLlwCQOhgl4e7HFQdu6Pe
         Q7K2Z4P8n5XeyUMAWix6QNTlaLxuW2g68ISk7mtXxkI8fgNM9bvly6DheBfKA5LmC/
         iFZ/wlZRMlWRqYaA4XNEE3ccBdHGVglKrSm5/UF5mmVqkPk1ZwlpKQMn80ZHKIEgQD
         Z05FzR8Os94TCGth6EMoF1aSLnK4OTkMpPCGT+crjsNYAsJFcsauSdBT0S+IdMVkRS
         hiKg5dUoFHMSCctewCgEkiFAE+xEy5fDUabXNn7iOG5wf79ARAcFr+62cdcBD1aNaY
         eu6QmC//EZvPw==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     John David Anglin <dave.anglin@bell.net>
Subject: [PATCH] scsi: Do no try to probe for CDL on old drives
Date:   Fri, 15 Sep 2023 11:20:34 +0900
Message-ID: <20230915022034.678121-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Some old drives (e.g. an Ultra320 SCSI disk as reported by John) do not
seem to execute MAINTENANCE_IN / MI_REPORT_SUPPORTED_OPERATION_CODES
commands correctly and hang when a non-zero service action is specified
(one command format with service action case in scsi_report_opcode()).

Currently, CDL probing with scsi_cdl_check_cmd() is the only caller
using a non zero service action for scsi_report_opcode(). To avoid
issues with these old drives, do not attempt CDL probe if the device
reports support for an SPC version lower than 5 (CDL was introduced in
SPC-5). To keep things working with ATA devices which probe for the CDL
T2A and T2B pages introduced with SPC-6, modify ata_scsiop_inq_std() to
claim SPC-6 version compatibility for ATA drives supporting CDL.

SPC-6 standard version number is defined as Dh (= 13) in SPC-6 r09. Fix
scsi_probe_lun() to correctly capture this value by changing the bit
mask for the second byte of the INQUIRY response from 0x7 to 0xf.
include/scsi/scsi.h is modified to add the definition SCSI_SPC_6 with
the value 14 (Dh + 1). The missing definitions for the SCSI_SPC_4 and
SCSI_SPC_5 versions are also added.

Reported-by: John David Anglin <dave.anglin@bell.net>
Fixes: 624885209f31 ("scsi: core: Detect support for command duration limits")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-scsi.c |  3 +++
 drivers/scsi/scsi.c       | 11 +++++++++++
 drivers/scsi/scsi_scan.c  |  2 +-
 include/scsi/scsi.h       |  3 +++
 4 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 92ae4b4f30ac..7aa70af1fc07 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1828,6 +1828,9 @@ static unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf)
 		hdr[2] = 0x7; /* claim SPC-5 version compatibility */
 	}
 
+	if (args->dev->flags & ATA_DFLAG_CDL)
+		hdr[2] = 0xd; /* claim SPC-6 version compatibility */
+
 	memcpy(rbuf, hdr, sizeof(hdr));
 	memcpy(&rbuf[8], "ATA     ", 8);
 	ata_id_string(args->id, &rbuf[16], ATA_ID_PROD, 16);
diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index d0911bc28663..89367c4bf0ef 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -613,6 +613,17 @@ void scsi_cdl_check(struct scsi_device *sdev)
 	bool cdl_supported;
 	unsigned char *buf;
 
+	/*
+	 * Support for CDL was defined in SPC-5. Ignore devices reporting an
+	 * lower SPC version. This also avoids problems with old drives choking
+	 * on MAINTENANCE_IN / MI_REPORT_SUPPORTED_OPERATION_CODES with a
+	 * service action specified, as done in scsi_cdl_check_cmd().
+	 */
+	if (sdev->scsi_level < SCSI_SPC_5) {
+		sdev->cdl_supported = 0;
+		return;
+	}
+
 	buf = kmalloc(SCSI_CDL_CHECK_BUF_LEN, GFP_KERNEL);
 	if (!buf) {
 		sdev->cdl_supported = 0;
diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index 6650f63afec9..37dd6bbcffd3 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -822,7 +822,7 @@ static int scsi_probe_lun(struct scsi_device *sdev, unsigned char *inq_result,
 	 * device is attached at LUN 0 (SCSI_SCAN_TARGET_PRESENT) so
 	 * non-zero LUNs can be scanned.
 	 */
-	sdev->scsi_level = inq_result[2] & 0x07;
+	sdev->scsi_level = inq_result[2] & 0x0f;
 	if (sdev->scsi_level >= 2 ||
 	    (sdev->scsi_level == 1 && (inq_result[3] & 0x0f) == 1))
 		sdev->scsi_level++;
diff --git a/include/scsi/scsi.h b/include/scsi/scsi.h
index ec093594ba53..4498f845b112 100644
--- a/include/scsi/scsi.h
+++ b/include/scsi/scsi.h
@@ -157,6 +157,9 @@ enum scsi_disposition {
 #define SCSI_3          4        /* SPC */
 #define SCSI_SPC_2      5
 #define SCSI_SPC_3      6
+#define SCSI_SPC_4	7
+#define SCSI_SPC_5	8
+#define SCSI_SPC_6	14
 
 /*
  * INQ PERIPHERAL QUALIFIERS
-- 
2.41.0

