Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD677AA02D
	for <lists+linux-scsi@lfdr.de>; Thu, 21 Sep 2023 22:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjIUUda (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 21 Sep 2023 16:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjIUUdJ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 21 Sep 2023 16:33:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A56CB0115;
        Thu, 21 Sep 2023 11:08:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1444CC433C8;
        Thu, 21 Sep 2023 18:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695319686;
        bh=8hABsLOS+0tD/beZ7PSGfLZG49udVrK1JwN5r0pQTUg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GL++TrZI777gfrkj4X9e0RO5ZiSLJqoT6YCq6S3funyLjNycWWnJNk9GJs2/1rtJq
         8ANtLdTh5EYUpAnu6AyFvJ+MbP+6hg4IZMZYs8rb6S4RGXrWaug73VOUkfvY2TzlXm
         k0Td0OMKGiT/OluvVMKdQNUUDO5T13xjq6fO19VpGK5LASdhrMlsV6ZmlsBjuBWWv3
         TWdd9cnX57reVO6Rkka9eq5UrMG3cE05MLX+n6tpZgleWz/oEIiMeS+yrGNQuMt0au
         B+c8X1J3qoiNmKo0rwNOf1mhaDI+DpzO3003CPNHQdhrk4jN+Hs31K/uTsuhi/V5Wt
         NVy6TyeCfFAoQ==
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
Subject: [PATCH v5 03/23] ata: libata-scsi: link ata port and scsi device
Date:   Fri, 22 Sep 2023 03:07:38 +0900
Message-ID: <20230921180758.955317-4-dlemoal@kernel.org>
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

There is no direct device ancestry defined between an ata_device and
its scsi device which prevents the power management code from correctly
ordering suspend and resume operations. Create such ancestry with the
ata device as the parent to ensure that the scsi device (child) is
suspended before the ata device and that resume handles the ata device
before the scsi device.

The parent-child (supplier-consumer) relationship is established between
the ata_port (parent) and the scsi device (child) with the function
device_add_link(). The parent used is not the ata_device as the PM
operations are defined per port and the status of all devices connected
through that port is controlled from the port operations.

The device link is established with the new function
ata_scsi_slave_alloc(), and this function is used to define the
->slave_alloc callback of the scsi host template of all ata drivers.

Fixes: a19a93e4c6a9 ("scsi: core: pm: Rely on the device driver core for async power management")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/ata/libata-scsi.c | 45 ++++++++++++++++++++++++++++++++++-----
 include/linux/libata.h    |  2 ++
 2 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index fb73c145b49a..8b43290ca2cd 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1089,6 +1089,42 @@ int ata_scsi_dev_config(struct scsi_device *sdev, struct ata_device *dev)
 	return 0;
 }
 
+/**
+ *	ata_scsi_slave_alloc - Early setup of SCSI device
+ *	@sdev: SCSI device to examine
+ *
+ *	This is called from scsi_alloc_sdev() when the scsi device
+ *	associated with an ATA device is scanned on a port.
+ *
+ *	LOCKING:
+ *	Defined by SCSI layer.  We don't really care.
+ */
+
+int ata_scsi_slave_alloc(struct scsi_device *sdev)
+{
+	struct ata_port *ap = ata_shost_to_port(sdev->host);
+	struct device_link *link;
+
+	ata_scsi_sdev_config(sdev);
+
+	/*
+	 * Create a link from the ata_port device to the scsi device to ensure
+	 * that PM does suspend/resume in the correct order: the scsi device is
+	 * consumer (child) and the ata port the supplier (parent).
+	 */
+	link = device_link_add(&sdev->sdev_gendev, &ap->tdev,
+			       DL_FLAG_STATELESS |
+			       DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE);
+	if (!link) {
+		ata_port_err(ap, "Failed to create link to scsi device %s\n",
+			     dev_name(&sdev->sdev_gendev));
+		return -ENODEV;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ata_scsi_slave_alloc);
+
 /**
  *	ata_scsi_slave_config - Set SCSI device attributes
  *	@sdev: SCSI device to examine
@@ -1105,14 +1141,11 @@ int ata_scsi_slave_config(struct scsi_device *sdev)
 {
 	struct ata_port *ap = ata_shost_to_port(sdev->host);
 	struct ata_device *dev = __ata_scsi_find_dev(ap, sdev);
-	int rc = 0;
-
-	ata_scsi_sdev_config(sdev);
 
 	if (dev)
-		rc = ata_scsi_dev_config(sdev, dev);
+		return ata_scsi_dev_config(sdev, dev);
 
-	return rc;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(ata_scsi_slave_config);
 
@@ -1136,6 +1169,8 @@ void ata_scsi_slave_destroy(struct scsi_device *sdev)
 	unsigned long flags;
 	struct ata_device *dev;
 
+	device_link_remove(&sdev->sdev_gendev, &ap->tdev);
+
 	spin_lock_irqsave(ap->lock, flags);
 	dev = __ata_scsi_find_dev(ap, sdev);
 	if (dev && dev->sdev) {
diff --git a/include/linux/libata.h b/include/linux/libata.h
index bf4913f4d7ac..4ece1b7a2a5b 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1148,6 +1148,7 @@ extern int ata_std_bios_param(struct scsi_device *sdev,
 			      struct block_device *bdev,
 			      sector_t capacity, int geom[]);
 extern void ata_scsi_unlock_native_capacity(struct scsi_device *sdev);
+extern int ata_scsi_slave_alloc(struct scsi_device *sdev);
 extern int ata_scsi_slave_config(struct scsi_device *sdev);
 extern void ata_scsi_slave_destroy(struct scsi_device *sdev);
 extern int ata_scsi_change_queue_depth(struct scsi_device *sdev,
@@ -1396,6 +1397,7 @@ extern const struct attribute_group *ata_common_sdev_groups[];
 	.this_id		= ATA_SHT_THIS_ID,		\
 	.emulated		= ATA_SHT_EMULATED,		\
 	.proc_name		= drv_name,			\
+	.slave_alloc		= ata_scsi_slave_alloc,		\
 	.slave_destroy		= ata_scsi_slave_destroy,	\
 	.bios_param		= ata_std_bios_param,		\
 	.unlock_native_capacity	= ata_scsi_unlock_native_capacity,\
-- 
2.41.0

