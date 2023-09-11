Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1801D79A20D
	for <lists+linux-scsi@lfdr.de>; Mon, 11 Sep 2023 06:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbjIKECn (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 11 Sep 2023 00:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232775AbjIKECf (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 11 Sep 2023 00:02:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336CAEB;
        Sun, 10 Sep 2023 21:02:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89764C433C9;
        Mon, 11 Sep 2023 04:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694404948;
        bh=gpppPWCZEQwhnTFL17aJ3VG1eZoC9cd3JCcMZRBN7a4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lWe1NzZC/O5DsElCnr6utNgwsKZ24yto6CB3i3aBz40nBndtHN+JqJ8vAHLhFKd1+
         zVFXrc82Wj/6z3t82qlKbwweNLud84DRHen8pcNPLtEAL0+166/7VueAQaMI/hN/dg
         HDuWVx74drdeybSt9eg08QiSGkluj2qt5mmQh/EmHiAW9VFmYZ/oOL43GHteIOzw30
         0kbvKZa3r0kmWXX7ae8o7BXFmi++ng+tIgaqFQoaVUZkecez/+oQQqn//neikO5041
         RTIncckgNq23JqiTZMDAlmxnxt+VtpVzOiZQrmaypFq6JDW1e3/QKEF3if5OaZCndq
         3VkGgqgMH6J5Q==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     linux-ide@vger.kernel.org
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        John Garry <john.g.garry@oracle.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Paul Ausbeck <paula@soe.ucsc.edu>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Joe Breuer <linux-kernel@jmbreuer.net>
Subject: [PATCH 04/19] ata: libata-scsi: Disable scsi device manage_start_stop
Date:   Mon, 11 Sep 2023 13:02:02 +0900
Message-ID: <20230911040217.253905-5-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911040217.253905-1-dlemoal@kernel.org>
References: <20230911040217.253905-1-dlemoal@kernel.org>
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

The introduction of a device link to create a consumer/supplier
relationship between the scsi device of an ATA device and the ATA port
of the ATA device fixed the ordering of the suspend and resume
operations. For suspend, the scsi device is suspended first and the ata
port after it. This is fine as this allows the synchronize cache and
START STOP UNIT commands issued by the scsi disk driver to be executed
before the ata port is disabled.

For resume operations, the ata port is resumed first, followed
by the scsi device. This allows having the request queue of the scsi
device to be unfrozen after the ata port restart is scheduled in EH,
thus avoiding to see new requests issued to the ATA device prematurely.
However, since libata sets manage_start_stop to 1, the scsi disk resume
operation also results in issuing a START STOP UNIT command to wakeup
the device. This is too late and that must be done before libata EH
resume handling starts revalidating the drive with IDENTIFY etc
commands. Commit 0a8589055936 ("ata,scsi: do not issue START STOP UNIT
on resume") disabled issuing the START STOP UNIT command to avoid
issues with it. However, this is incorrect as transitioning a device to
the active power mode from the standby power mode set on suspend
requires a media access command. The device link reset and subsequent
SET FEATURES, IDENTIFY and READ LOG commands executed in libata EH
context triggered by the ata port resume operation may thus fail.

Fix this by handling a device power mode transitions for suspend and
resume in libata EH context without relying on the scsi disk management
triggered with the manage_start_stop flag.

To do this, the following libata helper functions are introduced:

1) ata_dev_power_set_standby():

This function issues a STANDBY IMMEDIATE command to transitiom a device
to the standby power mode. For HDDs, this spins down the disks. This
function applies only to ATA and ZAC devices and does nothing otherwise.
This function also does nothing for devices that have the
ATA_FLAG_NO_POWEROFF_SPINDOWN or ATA_FLAG_NO_HIBERNATE_SPINDOWN flag
set.

For suspend, call ata_dev_power_set_standby() in
ata_eh_handle_port_suspend() before the port is disabled and frozen.
ata_eh_unload() is also modified to transition all enabled devices to
the standby power mode when the system is shutdown or devices removed.

2) ata_dev_power_set_active() and

This function applies to ATA or ZAC devices and issues a VERIFY command
for 1 sector at LBA 0 to transition the device to the active power mode.
For HDDs, since this function will complete only once the disk spin up.
Its execution uses the same timeouts as for reset, to give the drive
enough time to complete spinup without triggering a command timeout.

For resume, call ata_dev_power_set_active() in
ata_eh_revalidate_and_attach() after the port has been enabled and
before any other command is issued to the device.

With these changes, the manage_start_stop flag does not need to be set
in ata_scsi_dev_config().

Fixes: 0a8589055936 ("ata,scsi: do not issue START STOP UNIT on resume")
Fixes: a19a93e4c6a9 ("scsi: core: pm: Rely on the device driver core for async power management")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-core.c | 90 +++++++++++++++++++++++++++++++++++++++
 drivers/ata/libata-eh.c   | 46 +++++++++++++++++++-
 drivers/ata/libata-scsi.c | 14 ++----
 drivers/ata/libata.h      |  2 +
 include/linux/libata.h    |  6 ++-
 5 files changed, 144 insertions(+), 14 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 693cb3cd70cd..0cf0caf77907 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1972,6 +1972,96 @@ int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
 	return rc;
 }
 
+/**
+ *	ata_dev_power_set_standby - Set a device power mode to standby
+ *	@dev: target device
+ *
+ *	Issue a STANDBY IMMEDIATE command to set a device power mode to standby.
+ *	For an HDD device, this spins down the disks.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ */
+void ata_dev_power_set_standby(struct ata_device *dev)
+{
+	unsigned long ap_flags = dev->link->ap->flags;
+	struct ata_taskfile tf;
+	unsigned int err_mask;
+
+	/* Issue STANDBY IMMEDIATE command only if supported by the device */
+	if (dev->class != ATA_DEV_ATA && dev->class != ATA_DEV_ZAC)
+		return;
+
+	/*
+	 * Some odd clown BIOSes issue spindown on power off (ACPI S4 or S5)
+	 * causing some drives to spin up and down again. For these, do nothing
+	 * if we are being called on shutdown.
+	 */
+	if ((ap_flags & ATA_FLAG_NO_POWEROFF_SPINDOWN) &&
+	    system_state == SYSTEM_POWER_OFF)
+		return;
+
+	if ((ap_flags & ATA_FLAG_NO_HIBERNATE_SPINDOWN) &&
+	    system_entering_hibernation())
+		return;
+
+	ata_tf_init(dev, &tf);
+	tf.flags |= ATA_TFLAG_DEVICE | ATA_TFLAG_ISADDR;
+	tf.protocol = ATA_PROT_NODATA;
+	tf.command = ATA_CMD_STANDBYNOW1;
+
+	ata_dev_notice(dev, "Entering standby power mode\n");
+
+	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, 0);
+	if (err_mask)
+		ata_dev_err(dev, "STANDBY IMMEDIATE failed (err_mask=0x%x)\n",
+			    err_mask);
+}
+
+/**
+ *	ata_dev_power_set_active -  Set a device power mode to active
+ *	@dev: target device
+ *
+ *	Issue a VERIFY command to enter to ensure that the device is in the
+ *	active power mode. For a spun-down HDD (standby or idle power mode),
+ *	the VERIFY command will complete after the disk spins up.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ */
+void ata_dev_power_set_active(struct ata_device *dev)
+{
+	struct ata_taskfile tf;
+	unsigned int err_mask;
+
+	/*
+	 * Issue READ VERIFY SECTORS command for 1 sector at lba=0 only
+	 * if supported by the device.
+	 */
+	if (dev->class != ATA_DEV_ATA && dev->class != ATA_DEV_ZAC)
+		return;
+
+	ata_tf_init(dev, &tf);
+	tf.flags |= ATA_TFLAG_DEVICE | ATA_TFLAG_ISADDR;
+	tf.protocol = ATA_PROT_NODATA;
+	tf.command = ATA_CMD_VERIFY;
+	tf.nsect = 1;
+	if (dev->flags & ATA_DFLAG_LBA) {
+		tf.flags |= ATA_TFLAG_LBA;
+		tf.device |= ATA_LBA;
+	} else {
+		/* CHS */
+		tf.lbal = 0x1; /* sect */
+	}
+
+	ata_dev_notice(dev, "Entering active power mode\n");
+
+	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, 0);
+	if (err_mask)
+		ata_dev_err(dev, "VERIFY failed (err_mask=0x%x)\n",
+			    err_mask);
+}
+
 /**
  *	ata_read_log_page - read a specific log page
  *	@dev: target device
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 159ba6ba19eb..43b0a1509548 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -147,6 +147,8 @@ ata_eh_cmd_timeout_table[ATA_EH_CMD_TIMEOUT_TABLE_SIZE] = {
 	  .timeouts = ata_eh_other_timeouts, },
 	{ .commands = CMDS(ATA_CMD_FLUSH, ATA_CMD_FLUSH_EXT),
 	  .timeouts = ata_eh_flush_timeouts },
+	{ .commands = CMDS(ATA_CMD_VERIFY),
+	  .timeouts = ata_eh_reset_timeouts },
 };
 #undef CMDS
 
@@ -498,7 +500,19 @@ static void ata_eh_unload(struct ata_port *ap)
 	struct ata_device *dev;
 	unsigned long flags;
 
-	/* Restore SControl IPM and SPD for the next driver and
+	/*
+	 * Unless we are restarting, transition all enabled devices to
+	 * standby power mode.
+	 */
+	if (system_state != SYSTEM_RESTART) {
+		ata_for_each_link(link, ap, PMP_FIRST) {
+			ata_for_each_dev(dev, link, ENABLED)
+				ata_dev_power_set_standby(dev);
+		}
+	}
+
+	/*
+	 * Restore SControl IPM and SPD for the next driver and
 	 * disable attached devices.
 	 */
 	ata_for_each_link(link, ap, PMP_FIRST) {
@@ -684,6 +698,10 @@ void ata_scsi_port_error_handler(struct Scsi_Host *host, struct ata_port *ap)
 			ehc->saved_xfer_mode[devno] = dev->xfer_mode;
 			if (ata_ncq_enabled(dev))
 				ehc->saved_ncq_enabled |= 1 << devno;
+
+			/* If we are resuming, wake up the device */
+			if (ap->pflags & ATA_PFLAG_RESUMING)
+				ehc->i.dev_action[devno] |= ATA_EH_SET_ACTIVE;
 		}
 	}
 
@@ -743,6 +761,8 @@ void ata_scsi_port_error_handler(struct Scsi_Host *host, struct ata_port *ap)
 	/* clean up */
 	spin_lock_irqsave(ap->lock, flags);
 
+	ap->pflags &= ~ATA_PFLAG_RESUMING;
+
 	if (ap->pflags & ATA_PFLAG_LOADING)
 		ap->pflags &= ~ATA_PFLAG_LOADING;
 	else if ((ap->pflags & ATA_PFLAG_SCSI_HOTPLUG) &&
@@ -1218,6 +1238,13 @@ void ata_eh_detach_dev(struct ata_device *dev)
 	struct ata_eh_context *ehc = &link->eh_context;
 	unsigned long flags;
 
+	/*
+	 * If the device is still enabled, transition it to standby power mode
+	 * (i.e. spin down HDDs).
+	 */
+	if (ata_dev_enabled(dev))
+		ata_dev_power_set_standby(dev);
+
 	ata_dev_disable(dev);
 
 	spin_lock_irqsave(ap->lock, flags);
@@ -3026,6 +3053,15 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
 		if (ehc->i.flags & ATA_EHI_DID_RESET)
 			readid_flags |= ATA_READID_POSTRESET;
 
+		/*
+		 * When resuming, before executing any command, make sure to
+		 * transition the device to the active power mode.
+		 */
+		if ((action & ATA_EH_SET_ACTIVE) && ata_dev_enabled(dev)) {
+			ata_dev_power_set_active(dev);
+			ata_eh_done(link, dev, ATA_EH_SET_ACTIVE);
+		}
+
 		if ((action & ATA_EH_REVALIDATE) && ata_dev_enabled(dev)) {
 			WARN_ON(dev->class == ATA_DEV_PMP);
 
@@ -3999,6 +4035,7 @@ static void ata_eh_handle_port_suspend(struct ata_port *ap)
 	unsigned long flags;
 	int rc = 0;
 	struct ata_device *dev;
+	struct ata_link *link;
 
 	/* are we suspending? */
 	spin_lock_irqsave(ap->lock, flags);
@@ -4011,6 +4048,12 @@ static void ata_eh_handle_port_suspend(struct ata_port *ap)
 
 	WARN_ON(ap->pflags & ATA_PFLAG_SUSPENDED);
 
+	/* Set all devices attached to the port in standby mode */
+	ata_for_each_link(link, ap, HOST_FIRST) {
+		ata_for_each_dev(dev, link, ENABLED)
+			ata_dev_power_set_standby(dev);
+	}
+
 	/*
 	 * If we have a ZPODD attached, check its zero
 	 * power ready status before the port is frozen.
@@ -4093,6 +4136,7 @@ static void ata_eh_handle_port_resume(struct ata_port *ap)
 	/* update the flags */
 	spin_lock_irqsave(ap->lock, flags);
 	ap->pflags &= ~(ATA_PFLAG_PM_PENDING | ATA_PFLAG_SUSPENDED);
+	ap->pflags |= ATA_PFLAG_RESUMING;
 	spin_unlock_irqrestore(ap->lock, flags);
 }
 #endif /* CONFIG_PM */
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index f63cf6e7332e..9bb1ace8bf79 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1050,14 +1050,6 @@ int ata_scsi_dev_config(struct scsi_device *sdev, struct ata_device *dev)
 		}
 	} else {
 		sdev->sector_size = ata_id_logical_sector_size(dev->id);
-		/*
-		 * Stop the drive on suspend but do not issue START STOP UNIT
-		 * on resume as this is not necessary and may fail: the device
-		 * will be woken up by ata_port_pm_resume() with a port reset
-		 * and device revalidation.
-		 */
-		sdev->manage_start_stop = 1;
-		sdev->no_start_on_resume = 1;
 	}
 
 	/*
@@ -1231,7 +1223,7 @@ static unsigned int ata_scsi_start_stop_xlat(struct ata_queued_cmd *qc)
 	}
 
 	if (cdb[4] & 0x1) {
-		tf->nsect = 1;	/* 1 sector, lba=0 */
+		tf->nsect = 1;  /* 1 sector, lba=0 */
 
 		if (qc->dev->flags & ATA_DFLAG_LBA) {
 			tf->flags |= ATA_TFLAG_LBA;
@@ -1247,7 +1239,7 @@ static unsigned int ata_scsi_start_stop_xlat(struct ata_queued_cmd *qc)
 			tf->lbah = 0x0; /* cyl high */
 		}
 
-		tf->command = ATA_CMD_VERIFY;	/* READ VERIFY */
+		tf->command = ATA_CMD_VERIFY;   /* READ VERIFY */
 	} else {
 		/* Some odd clown BIOSen issue spindown on power off (ACPI S4
 		 * or S5) causing some drives to spin up and down again.
@@ -1257,7 +1249,7 @@ static unsigned int ata_scsi_start_stop_xlat(struct ata_queued_cmd *qc)
 			goto skip;
 
 		if ((qc->ap->flags & ATA_FLAG_NO_HIBERNATE_SPINDOWN) &&
-		     system_entering_hibernation())
+		    system_entering_hibernation())
 			goto skip;
 
 		/* Issue ATA STANDBY IMMEDIATE command */
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 079981e7156a..a5ee06f0234a 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -60,6 +60,8 @@ extern int ata_dev_reread_id(struct ata_device *dev, unsigned int readid_flags);
 extern int ata_dev_revalidate(struct ata_device *dev, unsigned int new_class,
 			      unsigned int readid_flags);
 extern int ata_dev_configure(struct ata_device *dev);
+extern void ata_dev_power_set_standby(struct ata_device *dev);
+extern void ata_dev_power_set_active(struct ata_device *dev);
 extern int sata_down_spd_limit(struct ata_link *link, u32 spd_limit);
 extern int ata_down_xfermask_limit(struct ata_device *dev, unsigned int sel);
 extern unsigned int ata_dev_set_feature(struct ata_device *dev,
diff --git a/include/linux/libata.h b/include/linux/libata.h
index c8cfea386c16..6593c79b7290 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -192,6 +192,7 @@ enum {
 	ATA_PFLAG_UNLOADING	= (1 << 9), /* driver is being unloaded */
 	ATA_PFLAG_UNLOADED	= (1 << 10), /* driver is unloaded */
 
+	ATA_PFLAG_RESUMING	= (1 << 16),  /* port is being resumed */
 	ATA_PFLAG_SUSPENDED	= (1 << 17), /* port is suspended (power) */
 	ATA_PFLAG_PM_PENDING	= (1 << 18), /* PM operation pending */
 	ATA_PFLAG_INIT_GTM_VALID = (1 << 19), /* initial gtm data valid */
@@ -314,9 +315,10 @@ enum {
 	ATA_EH_ENABLE_LINK	= (1 << 3),
 	ATA_EH_PARK		= (1 << 5), /* unload heads and stop I/O */
 	ATA_EH_GET_SUCCESS_SENSE = (1 << 6), /* Get sense data for successful cmd */
+	ATA_EH_SET_ACTIVE	= (1 << 7), /* Set a device to active power mode */
 
 	ATA_EH_PERDEV_MASK	= ATA_EH_REVALIDATE | ATA_EH_PARK |
-				  ATA_EH_GET_SUCCESS_SENSE,
+				  ATA_EH_GET_SUCCESS_SENSE | ATA_EH_SET_ACTIVE,
 	ATA_EH_ALL_ACTIONS	= ATA_EH_REVALIDATE | ATA_EH_RESET |
 				  ATA_EH_ENABLE_LINK,
 
@@ -353,7 +355,7 @@ enum {
 	/* This should match the actual table size of
 	 * ata_eh_cmd_timeout_table in libata-eh.c.
 	 */
-	ATA_EH_CMD_TIMEOUT_TABLE_SIZE = 7,
+	ATA_EH_CMD_TIMEOUT_TABLE_SIZE = 8,
 
 	/* Horkage types. May be set by libata or controller on drives
 	   (some horkage may be drive/controller pair dependent */
-- 
2.41.0

