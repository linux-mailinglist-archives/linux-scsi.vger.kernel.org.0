Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C2F79C233
	for <lists+linux-scsi@lfdr.de>; Tue, 12 Sep 2023 04:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236606AbjILCH4 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 11 Sep 2023 22:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237215AbjILCCD (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 11 Sep 2023 22:02:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC2C1A4BC9;
        Mon, 11 Sep 2023 18:32:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A697C32796;
        Tue, 12 Sep 2023 00:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694480234;
        bh=zrxGHXP1PsTnGT20MsFh2wRHKiK5yBAjONqXzmPeyDw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EyBvYWBfITso0/AUxvIow6ulmvwHP5FpA8I67W2yu1CJkyXNPlYYgl5I4WixQEhEK
         WhuRZYaAOzdYcA9jlbIVJyTQOC5NYRbc4IvWoTA5D6sxnD1wZX/zw4i3fcIG5uAhep
         0LR8RkHcCLQkXmFSJHJUvh7i0QzFl/iMXRKPE2GqzRQ14ZHghrmtQEIOEKWe82s2YI
         kXfnXwZ8/lm4sxhqaL9UkWtXCtuXlw1xomqbXNP4/qVE0AQiHffgt8Gb1VtE+8UCyW
         00hK9kEsCWupFsm5Wj2oPXRwHcMFmm45tCvV6ZHthOesUmqrevgGCjnQLsa37IF0nD
         oNdln7OIcssNw==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     linux-ide@vger.kernel.org
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        John Garry <john.g.garry@oracle.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Paul Ausbeck <paula@soe.ucsc.edu>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Joe Breuer <linux-kernel@jmbreuer.net>
Subject: [PATCH v2 11/21] ata: libata-scsi: Cleanup ata_scsi_start_stop_xlat()
Date:   Tue, 12 Sep 2023 09:56:45 +0900
Message-ID: <20230912005655.368075-12-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912005655.368075-1-dlemoal@kernel.org>
References: <20230912005655.368075-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Now that libata does its own internal device power mode management
through libata EH, the scsi disk driver will not issue START STOP UNIT
commands anymore. We can receive this command only from user passthrough
operations. So there is no need to consider the system state and ATA
port flags for suspend to translate the command.

Since setting up the taskfile for the verify and standby
immediate commands is the same as done in ata_dev_power_set_active()
and ata_dev_power_set_standby(), factor out this code into the helper
function ata_dev_power_init_tf() to simplify ata_scsi_start_stop_xlat()
as well as ata_dev_power_set_active() and ata_dev_power_set_standby().

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-core.c | 55 +++++++++++++++++++++++----------------
 drivers/ata/libata-scsi.c | 53 +++++++------------------------------
 drivers/ata/libata.h      |  2 ++
 3 files changed, 44 insertions(+), 66 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 2405ac8b53f0..8d1949302a8a 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1972,6 +1972,35 @@ int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
 	return rc;
 }
 
+bool ata_dev_power_init_tf(struct ata_device *dev, struct ata_taskfile *tf,
+			   bool set_active)
+{
+	/* Only applies to ATA and ZAC devices */
+	if (dev->class != ATA_DEV_ATA && dev->class != ATA_DEV_ZAC)
+		return false;
+
+	ata_tf_init(dev, tf);
+	tf->flags |= ATA_TFLAG_DEVICE | ATA_TFLAG_ISADDR;
+	tf->protocol = ATA_PROT_NODATA;
+
+	if (set_active) {
+		/* VERIFY for 1 sector at lba=0 */
+		tf->command = ATA_CMD_VERIFY;
+		tf->nsect = 1;
+		if (dev->flags & ATA_DFLAG_LBA) {
+			tf->flags |= ATA_TFLAG_LBA;
+			tf->device |= ATA_LBA;
+		} else {
+			/* CHS */
+			tf->lbal = 0x1; /* sect */
+		}
+	} else {
+		tf->command = ATA_CMD_STANDBYNOW1;
+	}
+
+	return true;
+}
+
 /**
  *	ata_dev_power_set_standby - Set a device power mode to standby
  *	@dev: target device
@@ -1988,10 +2017,6 @@ void ata_dev_power_set_standby(struct ata_device *dev)
 	struct ata_taskfile tf;
 	unsigned int err_mask;
 
-	/* Issue STANDBY IMMEDIATE command only if supported by the device */
-	if (dev->class != ATA_DEV_ATA && dev->class != ATA_DEV_ZAC)
-		return;
-
 	/*
 	 * Some odd clown BIOSes issue spindown on power off (ACPI S4 or S5)
 	 * causing some drives to spin up and down again. For these, do nothing
@@ -2005,10 +2030,9 @@ void ata_dev_power_set_standby(struct ata_device *dev)
 	    system_entering_hibernation())
 		return;
 
-	ata_tf_init(dev, &tf);
-	tf.flags |= ATA_TFLAG_DEVICE | ATA_TFLAG_ISADDR;
-	tf.protocol = ATA_PROT_NODATA;
-	tf.command = ATA_CMD_STANDBYNOW1;
+	/* Issue STANDBY IMMEDIATE command only if supported by the device */
+	if (!ata_dev_power_init_tf(dev, &tf, false))
+		return;
 
 	ata_dev_notice(dev, "Entering standby power mode\n");
 
@@ -2038,22 +2062,9 @@ void ata_dev_power_set_active(struct ata_device *dev)
 	 * Issue READ VERIFY SECTORS command for 1 sector at lba=0 only
 	 * if supported by the device.
 	 */
-	if (dev->class != ATA_DEV_ATA && dev->class != ATA_DEV_ZAC)
+	if (!ata_dev_power_init_tf(dev, &tf, true))
 		return;
 
-	ata_tf_init(dev, &tf);
-	tf.flags |= ATA_TFLAG_DEVICE | ATA_TFLAG_ISADDR;
-	tf.protocol = ATA_PROT_NODATA;
-	tf.command = ATA_CMD_VERIFY;
-	tf.nsect = 1;
-	if (dev->flags & ATA_DFLAG_LBA) {
-		tf.flags |= ATA_TFLAG_LBA;
-		tf.device |= ATA_LBA;
-	} else {
-		/* CHS */
-		tf.lbal = 0x1; /* sect */
-	}
-
 	ata_dev_notice(dev, "Entering active power mode\n");
 
 	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, 0);
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index f2d4460ab450..92ae4b4f30ac 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1196,7 +1196,6 @@ EXPORT_SYMBOL_GPL(ata_scsi_slave_destroy);
 static unsigned int ata_scsi_start_stop_xlat(struct ata_queued_cmd *qc)
 {
 	struct scsi_cmnd *scmd = qc->scsicmd;
-	struct ata_taskfile *tf = &qc->tf;
 	const u8 *cdb = scmd->cmnd;
 	u16 fp;
 	u8 bp = 0xff;
@@ -1206,54 +1205,24 @@ static unsigned int ata_scsi_start_stop_xlat(struct ata_queued_cmd *qc)
 		goto invalid_fld;
 	}
 
-	tf->flags |= ATA_TFLAG_DEVICE | ATA_TFLAG_ISADDR;
-	tf->protocol = ATA_PROT_NODATA;
-	if (cdb[1] & 0x1) {
-		;	/* ignore IMMED bit, violates sat-r05 */
-	}
+	/* LOEJ bit set not supported */
 	if (cdb[4] & 0x2) {
 		fp = 4;
 		bp = 1;
-		goto invalid_fld;       /* LOEJ bit set not supported */
+		goto invalid_fld;
 	}
+
+	/* Power conditions not supported */
 	if (((cdb[4] >> 4) & 0xf) != 0) {
 		fp = 4;
 		bp = 3;
-		goto invalid_fld;       /* power conditions not supported */
+		goto invalid_fld;
 	}
 
-	if (cdb[4] & 0x1) {
-		tf->nsect = 1;  /* 1 sector, lba=0 */
-
-		if (qc->dev->flags & ATA_DFLAG_LBA) {
-			tf->flags |= ATA_TFLAG_LBA;
-
-			tf->lbah = 0x0;
-			tf->lbam = 0x0;
-			tf->lbal = 0x0;
-			tf->device |= ATA_LBA;
-		} else {
-			/* CHS */
-			tf->lbal = 0x1; /* sect */
-			tf->lbam = 0x0; /* cyl low */
-			tf->lbah = 0x0; /* cyl high */
-		}
-
-		tf->command = ATA_CMD_VERIFY;   /* READ VERIFY */
-	} else {
-		/* Some odd clown BIOSen issue spindown on power off (ACPI S4
-		 * or S5) causing some drives to spin up and down again.
-		 */
-		if ((qc->ap->flags & ATA_FLAG_NO_POWEROFF_SPINDOWN) &&
-		    system_state == SYSTEM_POWER_OFF)
-			goto skip;
-
-		if ((qc->ap->flags & ATA_FLAG_NO_HIBERNATE_SPINDOWN) &&
-		    system_entering_hibernation())
-			goto skip;
-
-		/* Issue ATA STANDBY IMMEDIATE command */
-		tf->command = ATA_CMD_STANDBYNOW1;
+	/* Ignore IMMED bit (cdb[1] & 0x1), violates sat-r05 */
+	if (!ata_dev_power_init_tf(qc->dev, &qc->tf, cdb[4] & 0x1)) {
+		ata_scsi_set_sense(qc->dev, scmd, ABORTED_COMMAND, 0, 0);
+		return 1;
 	}
 
 	/*
@@ -1268,12 +1237,8 @@ static unsigned int ata_scsi_start_stop_xlat(struct ata_queued_cmd *qc)
  invalid_fld:
 	ata_scsi_set_invalid_field(qc->dev, scmd, fp, bp);
 	return 1;
- skip:
-	scmd->result = SAM_STAT_GOOD;
-	return 1;
 }
 
-
 /**
  *	ata_scsi_flush_xlat - Translate SCSI SYNCHRONIZE CACHE command
  *	@qc: Storage for translated ATA taskfile
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index c57e094c3af9..af0e718f2b72 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -62,6 +62,8 @@ extern int ata_dev_reread_id(struct ata_device *dev, unsigned int readid_flags);
 extern int ata_dev_revalidate(struct ata_device *dev, unsigned int new_class,
 			      unsigned int readid_flags);
 extern int ata_dev_configure(struct ata_device *dev);
+extern bool ata_dev_power_init_tf(struct ata_device *dev,
+				  struct ata_taskfile *tf, bool set_active);
 extern void ata_dev_power_set_standby(struct ata_device *dev);
 extern void ata_dev_power_set_active(struct ata_device *dev);
 extern int sata_down_spd_limit(struct ata_link *link, u32 spd_limit);
-- 
2.41.0

