Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC2B427201
	for <lists+linux-scsi@lfdr.de>; Fri,  8 Oct 2021 22:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242391AbhJHU0C (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 8 Oct 2021 16:26:02 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:37497 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbhJHUZ7 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 8 Oct 2021 16:25:59 -0400
Received: by mail-pg1-f180.google.com with SMTP id r201so4161248pgr.4
        for <linux-scsi@vger.kernel.org>; Fri, 08 Oct 2021 13:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iuaiSrAc3yHvAWUA6fwUVhcNybLtBXZ3G8LIf9qVR04=;
        b=SDO0qFxaz67LuM5Y4PmAzC740JGy9ELOisOn7jAUJvdnb3o5LtwXmL/2cQOAlgaYoJ
         6pLQyu3QpcD9gHb3J369KKLyUhtyUr2H5lJY2da7tgAzSfu/arn1U2F9uSfhfVkSjXd7
         xOFWdjcfB/xnwuvKMCV9+u2NfnlXwW8u5ts3/YZJtu4BT3tIFKhx6oqfvDwOc0Nrv6ii
         pUDj+UQdtKOD2eRd0wbaU405ya08JzH1OHXnxYdIfBV3BvNs1UhNFkzHP5ULiM2Y6oCQ
         srdVthXZXOi2mUTdI8NPZ3qFbcP9LHBflFd5+xFdXRMGI2gA+hHaTNd4uFHBZChtHLL/
         /Yxw==
X-Gm-Message-State: AOAM531Thsme+q+ky5xmF7Ep2ermkCu0N2e5C/w6pbwunHMQtzQouFEe
        LMkvnvzmFs58ZT5rWELRais=
X-Google-Smtp-Source: ABdhPJx/Lgz/vYuoFXsPfWGq2vr6B+qaQ8LsMd8cO+sAYiZh5ZZMj4q4QCKnGJLqd06jKzqbZub+iw==
X-Received: by 2002:a05:6a00:10c6:b0:44c:56ff:91ea with SMTP id d6-20020a056a0010c600b0044c56ff91eamr12141875pfu.25.1633724643103;
        Fri, 08 Oct 2021 13:24:03 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:a8e9:7950:57f8:970])
        by smtp.gmail.com with ESMTPSA id x21sm170858pfa.186.2021.10.08.13.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 13:24:02 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [PATCH v3 02/46] ata: Switch to attribute groups
Date:   Fri,  8 Oct 2021 13:23:09 -0700
Message-Id: <20211008202353.1448570-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
In-Reply-To: <20211008202353.1448570-1-bvanassche@acm.org>
References: <20211008202353.1448570-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

struct device supports attribute groups directly but does not support
struct device_attribute directly. Hence switch to attribute groups.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/ata/ahci.h        |  8 +++---
 drivers/ata/ata_piix.c    |  8 +++---
 drivers/ata/libahci.c     | 52 ++++++++++++++++++++++++++-------------
 drivers/ata/libata-sata.c | 19 ++++++++++----
 drivers/ata/libata-scsi.c | 15 ++++++++---
 drivers/ata/pata_macio.c  |  2 +-
 drivers/ata/sata_mv.c     |  2 +-
 drivers/ata/sata_nv.c     |  4 +--
 drivers/ata/sata_sil24.c  |  2 +-
 include/linux/libata.h    |  8 +++---
 10 files changed, 79 insertions(+), 41 deletions(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 2e89499bd9c3..eeac5482f1d1 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -376,8 +376,8 @@ struct ahci_host_priv {
 
 extern int ahci_ignore_sss;
 
-extern struct device_attribute *ahci_shost_attrs[];
-extern struct device_attribute *ahci_sdev_attrs[];
+extern const struct attribute_group *ahci_shost_groups[];
+extern const struct attribute_group *ahci_sdev_groups[];
 
 /*
  * This must be instantiated by the edge drivers.  Read the comments
@@ -388,8 +388,8 @@ extern struct device_attribute *ahci_sdev_attrs[];
 	.can_queue		= AHCI_MAX_CMDS,			\
 	.sg_tablesize		= AHCI_MAX_SG,				\
 	.dma_boundary		= AHCI_DMA_BOUNDARY,			\
-	.shost_attrs		= ahci_shost_attrs,			\
-	.sdev_attrs		= ahci_sdev_attrs,			\
+	.shost_groups		= ahci_shost_groups,			\
+	.sdev_groups		= ahci_sdev_groups,			\
 	.change_queue_depth     = ata_scsi_change_queue_depth,		\
 	.tag_alloc_policy       = BLK_TAG_ALLOC_RR,             	\
 	.slave_configure        = ata_scsi_slave_config
diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 3ca7720e7d8f..0b2fcf0d1d6c 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -1085,14 +1085,16 @@ static struct ata_port_operations ich_pata_ops = {
 	.set_dmamode		= ich_set_dmamode,
 };
 
-static struct device_attribute *piix_sidpr_shost_attrs[] = {
-	&dev_attr_link_power_management_policy,
+static struct attribute *piix_sidpr_shost_attrs[] = {
+	&dev_attr_link_power_management_policy.attr,
 	NULL
 };
 
+ATTRIBUTE_GROUPS(piix_sidpr_shost);
+
 static struct scsi_host_template piix_sidpr_sht = {
 	ATA_BMDMA_SHT(DRV_NAME),
-	.shost_attrs		= piix_sidpr_shost_attrs,
+	.shost_groups		= piix_sidpr_shost_groups,
 };
 
 static struct ata_port_operations piix_sidpr_sata_ops = {
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 5b3fa2cbe722..28430c093a7f 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -108,28 +108,46 @@ static DEVICE_ATTR(em_buffer, S_IWUSR | S_IRUGO,
 		   ahci_read_em_buffer, ahci_store_em_buffer);
 static DEVICE_ATTR(em_message_supported, S_IRUGO, ahci_show_em_supported, NULL);
 
-struct device_attribute *ahci_shost_attrs[] = {
-	&dev_attr_link_power_management_policy,
-	&dev_attr_em_message_type,
-	&dev_attr_em_message,
-	&dev_attr_ahci_host_caps,
-	&dev_attr_ahci_host_cap2,
-	&dev_attr_ahci_host_version,
-	&dev_attr_ahci_port_cmd,
-	&dev_attr_em_buffer,
-	&dev_attr_em_message_supported,
+static struct attribute *ahci_shost_attrs[] = {
+	&dev_attr_link_power_management_policy.attr,
+	&dev_attr_em_message_type.attr,
+	&dev_attr_em_message.attr,
+	&dev_attr_ahci_host_caps.attr,
+	&dev_attr_ahci_host_cap2.attr,
+	&dev_attr_ahci_host_version.attr,
+	&dev_attr_ahci_port_cmd.attr,
+	&dev_attr_em_buffer.attr,
+	&dev_attr_em_message_supported.attr,
 	NULL
 };
-EXPORT_SYMBOL_GPL(ahci_shost_attrs);
 
-struct device_attribute *ahci_sdev_attrs[] = {
-	&dev_attr_sw_activity,
-	&dev_attr_unload_heads,
-	&dev_attr_ncq_prio_supported,
-	&dev_attr_ncq_prio_enable,
+static const struct attribute_group ahci_shost_attr_group = {
+	.attrs = ahci_shost_attrs
+};
+
+const struct attribute_group *ahci_shost_groups[] = {
+	&ahci_shost_attr_group,
+	NULL
+};
+EXPORT_SYMBOL_GPL(ahci_shost_groups);
+
+struct attribute *ahci_sdev_attrs[] = {
+	&dev_attr_sw_activity.attr,
+	&dev_attr_unload_heads.attr,
+	&dev_attr_ncq_prio_supported.attr,
+	&dev_attr_ncq_prio_enable.attr,
+	NULL
+};
+
+static const struct attribute_group ahci_sdev_attr_group = {
+	.attrs = ahci_sdev_attrs
+};
+
+const struct attribute_group *ahci_sdev_groups[] = {
+	&ahci_sdev_attr_group,
 	NULL
 };
-EXPORT_SYMBOL_GPL(ahci_sdev_attrs);
+EXPORT_SYMBOL_GPL(ahci_sdev_groups);
 
 struct ata_port_operations ahci_ops = {
 	.inherits		= &sata_pmp_port_ops,
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 8f3ff830ab0c..79e0f86aa3ae 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -922,13 +922,22 @@ DEVICE_ATTR(ncq_prio_enable, S_IRUGO | S_IWUSR,
 	    ata_ncq_prio_enable_show, ata_ncq_prio_enable_store);
 EXPORT_SYMBOL_GPL(dev_attr_ncq_prio_enable);
 
-struct device_attribute *ata_ncq_sdev_attrs[] = {
-	&dev_attr_unload_heads,
-	&dev_attr_ncq_prio_enable,
-	&dev_attr_ncq_prio_supported,
+struct attribute *ata_ncq_sdev_attrs[] = {
+	&dev_attr_unload_heads.attr,
+	&dev_attr_ncq_prio_enable.attr,
+	&dev_attr_ncq_prio_supported.attr,
 	NULL
 };
-EXPORT_SYMBOL_GPL(ata_ncq_sdev_attrs);
+
+static const struct attribute_group ata_ncq_sdev_attr_group = {
+	.attrs = ata_ncq_sdev_attrs
+};
+
+const struct attribute_group *ata_ncq_sdev_groups[] = {
+	&ata_ncq_sdev_attr_group,
+	NULL
+};
+EXPORT_SYMBOL_GPL(ata_ncq_sdev_groups);
 
 static ssize_t
 ata_scsi_em_message_store(struct device *dev, struct device_attribute *attr,
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 1fb4611f7eeb..75c54b2761bf 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -234,11 +234,20 @@ static void ata_scsi_set_invalid_parameter(struct ata_device *dev,
 				     field, 0xff, 0);
 }
 
-struct device_attribute *ata_common_sdev_attrs[] = {
-	&dev_attr_unload_heads,
+static struct attribute *ata_common_sdev_attrs[] = {
+	&dev_attr_unload_heads.attr,
 	NULL
 };
-EXPORT_SYMBOL_GPL(ata_common_sdev_attrs);
+
+static const struct attribute_group ata_common_sdev_attr_group = {
+	.attrs = ata_common_sdev_attrs
+};
+
+const struct attribute_group *ata_common_sdev_groups[] = {
+	&ata_common_sdev_attr_group,
+	NULL
+};
+EXPORT_SYMBOL_GPL(ata_common_sdev_groups);
 
 /**
  *	ata_std_bios_param - generic bios head/sector/cylinder calculator used by sd.
diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
index be0ca8d5b345..16e8aa184a75 100644
--- a/drivers/ata/pata_macio.c
+++ b/drivers/ata/pata_macio.c
@@ -923,7 +923,7 @@ static struct scsi_host_template pata_macio_sht = {
 	 */
 	.max_segment_size	= MAX_DBDMA_SEG,
 	.slave_configure	= pata_macio_slave_config,
-	.sdev_attrs		= ata_common_sdev_attrs,
+	.sdev_groups		= ata_common_sdev_groups,
 	.can_queue		= ATA_DEF_QUEUE,
 	.tag_alloc_policy	= BLK_TAG_ALLOC_RR,
 };
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 9d86203e1e7a..24130e551b26 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -670,7 +670,7 @@ static struct scsi_host_template mv6_sht = {
 	.can_queue		= MV_MAX_Q_DEPTH - 1,
 	.sg_tablesize		= MV_MAX_SG_CT / 2,
 	.dma_boundary		= MV_DMA_BOUNDARY,
-	.sdev_attrs             = ata_ncq_sdev_attrs,
+	.sdev_groups		= ata_ncq_sdev_groups,
 	.change_queue_depth	= ata_scsi_change_queue_depth,
 	.tag_alloc_policy	= BLK_TAG_ALLOC_RR,
 	.slave_configure	= ata_scsi_slave_config
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index c385d18ce87b..16272c111208 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -380,7 +380,7 @@ static struct scsi_host_template nv_adma_sht = {
 	.sg_tablesize		= NV_ADMA_SGTBL_TOTAL_LEN,
 	.dma_boundary		= NV_ADMA_DMA_BOUNDARY,
 	.slave_configure	= nv_adma_slave_config,
-	.sdev_attrs             = ata_ncq_sdev_attrs,
+	.sdev_groups		= ata_ncq_sdev_groups,
 	.change_queue_depth     = ata_scsi_change_queue_depth,
 	.tag_alloc_policy	= BLK_TAG_ALLOC_RR,
 };
@@ -391,7 +391,7 @@ static struct scsi_host_template nv_swncq_sht = {
 	.sg_tablesize		= LIBATA_MAX_PRD,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= nv_swncq_slave_config,
-	.sdev_attrs             = ata_ncq_sdev_attrs,
+	.sdev_groups		= ata_ncq_sdev_groups,
 	.change_queue_depth     = ata_scsi_change_queue_depth,
 	.tag_alloc_policy	= BLK_TAG_ALLOC_RR,
 };
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 06a1e27c4f84..f99ec6f7d7c0 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -379,7 +379,7 @@ static struct scsi_host_template sil24_sht = {
 	.sg_tablesize		= SIL24_MAX_SGE,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.tag_alloc_policy	= BLK_TAG_ALLOC_FIFO,
-	.sdev_attrs		= ata_ncq_sdev_attrs,
+	.sdev_groups		= ata_ncq_sdev_groups,
 	.change_queue_depth	= ata_scsi_change_queue_depth,
 	.slave_configure	= ata_scsi_slave_config
 };
diff --git a/include/linux/libata.h b/include/linux/libata.h
index c0c64f03e107..bd1b782d1bbf 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1388,7 +1388,7 @@ extern int ata_link_nr_enabled(struct ata_link *link);
  */
 extern const struct ata_port_operations ata_base_port_ops;
 extern const struct ata_port_operations sata_port_ops;
-extern struct device_attribute *ata_common_sdev_attrs[];
+extern const struct attribute_group *ata_common_sdev_groups[];
 
 /*
  * All sht initializers (BASE, PIO, BMDMA, NCQ) must be instantiated
@@ -1418,14 +1418,14 @@ extern struct device_attribute *ata_common_sdev_attrs[];
 
 #define ATA_BASE_SHT(drv_name)					\
 	ATA_SUBBASE_SHT(drv_name),				\
-	.sdev_attrs		= ata_common_sdev_attrs
+	.sdev_groups		= ata_common_sdev_groups
 
 #ifdef CONFIG_SATA_HOST
-extern struct device_attribute *ata_ncq_sdev_attrs[];
+extern const struct attribute_group *ata_ncq_sdev_groups[];
 
 #define ATA_NCQ_SHT(drv_name)					\
 	ATA_SUBBASE_SHT(drv_name),				\
-	.sdev_attrs		= ata_ncq_sdev_attrs,		\
+	.sdev_groups		= ata_ncq_sdev_groups,		\
 	.change_queue_depth	= ata_scsi_change_queue_depth
 #endif
 
