Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26FA47A18AF
	for <lists+linux-scsi@lfdr.de>; Fri, 15 Sep 2023 10:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbjIOI0b (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 15 Sep 2023 04:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbjIOI0Y (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 15 Sep 2023 04:26:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399263AA0;
        Fri, 15 Sep 2023 01:24:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94BA7C433CB;
        Fri, 15 Sep 2023 08:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694765716;
        bh=4DKquiB4S/emfjkbWLYiqKJhCjGbwS78HSyGtZ17Wws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aZtsC65dmv+dk1tC8OLwys+2kqv24YNjJhaiNnPLNstTwW4FKcMNHTfs4ldlPC02Z
         QaUyBfDEtgIEtRiuL+hEKpao2FdzGGelFwtgdWLbxAG+srpQkaAJkXmTbH5I01M9Y2
         U1c6hNWusVTXYgEx0Su7rrFbjpGbhEim4yevKi9Afn0VH8ayOf93JSEaFE5zbEX7LL
         kkcb5VZqu2lqUAmkpRB95I/kfYr8/Ilr/VAOvLiPxZWeDkj4yisKZ8GOfJZYj2JEG5
         GqGVIekKjGD/R160+8/cXh2du4hOJBVWzFCBNaJ4Ly5WhvKN3GAROaE1fL8Jjlg/rb
         OKvf3Q4BqQ/Pg==
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
Subject: [PATCH v3 03/23] ata: libata-scsi: link ata port and scsi device
Date:   Fri, 15 Sep 2023 17:14:47 +0900
Message-ID: <20230915081507.761711-4-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230915081507.761711-1-dlemoal@kernel.org>
References: <20230915081507.761711-1-dlemoal@kernel.org>
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
ata_scsi_dev_alloc(). This function is used to define the ->slave_alloc
callback of the scsi host template of most drivers.

Fixes: a19a93e4c6a9 ("scsi: core: pm: Rely on the device driver core for async power management")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/ahci.h        |  1 +
 drivers/ata/libata-scsi.c | 49 +++++++++++++++++++++++++++++++++++----
 drivers/ata/libata.h      |  1 +
 drivers/ata/pata_macio.c  |  1 +
 drivers/ata/sata_mv.c     |  1 +
 drivers/ata/sata_nv.c     |  2 ++
 drivers/ata/sata_sil24.c  |  1 +
 include/linux/libata.h    |  3 +++
 8 files changed, 54 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 4bae95b06ae3..72085756f4ba 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -398,6 +398,7 @@ extern const struct attribute_group *ahci_sdev_groups[];
 	.sdev_groups		= ahci_sdev_groups,			\
 	.change_queue_depth     = ata_scsi_change_queue_depth,		\
 	.tag_alloc_policy       = BLK_TAG_ALLOC_RR,             	\
+	.slave_alloc		= ata_scsi_slave_alloc,			\
 	.slave_configure        = ata_scsi_slave_config
 
 extern struct ata_port_operations ahci_ops;
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index d3f28b82c97b..eef76af1af90 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1089,6 +1089,46 @@ int ata_scsi_dev_config(struct scsi_device *sdev, struct ata_device *dev)
 	return 0;
 }
 
+int ata_scsi_dev_alloc(struct scsi_device *sdev, struct ata_port *ap)
+{
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
+
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
+	return ata_scsi_dev_alloc(sdev, ata_shost_to_port(sdev->host));
+}
+EXPORT_SYMBOL_GPL(ata_scsi_slave_alloc);
+
 /**
  *	ata_scsi_slave_config - Set SCSI device attributes
  *	@sdev: SCSI device to examine
@@ -1105,14 +1145,11 @@ int ata_scsi_slave_config(struct scsi_device *sdev)
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
 
@@ -1136,6 +1173,8 @@ void ata_scsi_slave_destroy(struct scsi_device *sdev)
 	unsigned long flags;
 	struct ata_device *dev;
 
+	device_link_remove(&sdev->sdev_gendev, &ap->tdev);
+
 	spin_lock_irqsave(ap->lock, flags);
 	dev = __ata_scsi_find_dev(ap, sdev);
 	if (dev && dev->sdev) {
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 6e7d352803bd..079981e7156a 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -111,6 +111,7 @@ extern struct ata_device *ata_scsi_find_dev(struct ata_port *ap,
 extern int ata_scsi_add_hosts(struct ata_host *host,
 			      const struct scsi_host_template *sht);
 extern void ata_scsi_scan_host(struct ata_port *ap, int sync);
+extern int ata_scsi_dev_alloc(struct scsi_device *sdev, struct ata_port *ap);
 extern int ata_scsi_offline_dev(struct ata_device *dev);
 extern bool ata_scsi_sense_is_valid(u8 sk, u8 asc, u8 ascq);
 extern void ata_scsi_set_sense(struct ata_device *dev,
diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
index 17f6ccee53c7..32968b4cf8e4 100644
--- a/drivers/ata/pata_macio.c
+++ b/drivers/ata/pata_macio.c
@@ -918,6 +918,7 @@ static const struct scsi_host_template pata_macio_sht = {
 	 * use 64K minus 256
 	 */
 	.max_segment_size	= MAX_DBDMA_SEG,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= pata_macio_slave_config,
 	.sdev_groups		= ata_common_sdev_groups,
 	.can_queue		= ATA_DEF_QUEUE,
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index d105db5c7d81..353ac7b2f14a 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -673,6 +673,7 @@ static const struct scsi_host_template mv6_sht = {
 	.sdev_groups		= ata_ncq_sdev_groups,
 	.change_queue_depth	= ata_scsi_change_queue_depth,
 	.tag_alloc_policy	= BLK_TAG_ALLOC_RR,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config
 };
 
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 0a0cee755bde..5428dc2ec5e3 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -380,6 +380,7 @@ static const struct scsi_host_template nv_adma_sht = {
 	.can_queue		= NV_ADMA_MAX_CPBS,
 	.sg_tablesize		= NV_ADMA_SGTBL_TOTAL_LEN,
 	.dma_boundary		= NV_ADMA_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= nv_adma_slave_config,
 	.sdev_groups		= ata_ncq_sdev_groups,
 	.change_queue_depth     = ata_scsi_change_queue_depth,
@@ -391,6 +392,7 @@ static const struct scsi_host_template nv_swncq_sht = {
 	.can_queue		= ATA_MAX_QUEUE - 1,
 	.sg_tablesize		= LIBATA_MAX_PRD,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= nv_swncq_slave_config,
 	.sdev_groups		= ata_ncq_sdev_groups,
 	.change_queue_depth     = ata_scsi_change_queue_depth,
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 142e70bfc498..e0b1b3625031 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -381,6 +381,7 @@ static const struct scsi_host_template sil24_sht = {
 	.tag_alloc_policy	= BLK_TAG_ALLOC_FIFO,
 	.sdev_groups		= ata_ncq_sdev_groups,
 	.change_queue_depth	= ata_scsi_change_queue_depth,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config
 };
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 52d58b13e5ee..c8cfea386c16 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1144,6 +1144,7 @@ extern int ata_std_bios_param(struct scsi_device *sdev,
 			      struct block_device *bdev,
 			      sector_t capacity, int geom[]);
 extern void ata_scsi_unlock_native_capacity(struct scsi_device *sdev);
+extern int ata_scsi_slave_alloc(struct scsi_device *sdev);
 extern int ata_scsi_slave_config(struct scsi_device *sdev);
 extern void ata_scsi_slave_destroy(struct scsi_device *sdev);
 extern int ata_scsi_change_queue_depth(struct scsi_device *sdev,
@@ -1401,12 +1402,14 @@ extern const struct attribute_group *ata_common_sdev_groups[];
 	__ATA_BASE_SHT(drv_name),				\
 	.can_queue		= ATA_DEF_QUEUE,		\
 	.tag_alloc_policy	= BLK_TAG_ALLOC_RR,		\
+	.slave_alloc		= ata_scsi_slave_alloc,		\
 	.slave_configure	= ata_scsi_slave_config
 
 #define ATA_SUBBASE_SHT_QD(drv_name, drv_qd)			\
 	__ATA_BASE_SHT(drv_name),				\
 	.can_queue		= drv_qd,			\
 	.tag_alloc_policy	= BLK_TAG_ALLOC_RR,		\
+	.slave_alloc		= ata_scsi_slave_alloc,		\
 	.slave_configure	= ata_scsi_slave_config
 
 #define ATA_BASE_SHT(drv_name)					\
-- 
2.41.0

