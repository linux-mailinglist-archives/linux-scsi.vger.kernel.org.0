Return-Path: <linux-scsi+bounces-15445-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D07B0EDB7
	for <lists+linux-scsi@lfdr.de>; Wed, 23 Jul 2025 10:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 125F918911F1
	for <lists+linux-scsi@lfdr.de>; Wed, 23 Jul 2025 08:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABE1283138;
	Wed, 23 Jul 2025 08:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9CTpHx6"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD5F283129
	for <linux-scsi@vger.kernel.org>; Wed, 23 Jul 2025 08:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753260855; cv=none; b=n4oSf5GjNLDTPp1sMKNr225sHjvvaHC+Bv2//8XWtBv5RMzpgemvjl7qA3NUeTGdhJtu/sCG10zCfa7oha45iGW2nTbMVyO8IM6sGNHzsxsDTUXeyE45KIHAQIvTTJzIqZ2jgfy2mPeapuC8rQvYymvvp/rtQDwYQ+uW28A9Cjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753260855; c=relaxed/simple;
	bh=oPq0am38a3k2Gitk/kUvysvrroy39y43lK8PEvLoK6M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nGVd1bcvGYQ5xw96x5g/ecRIicbvOSIqLJs9E2SGfeK1Il2H/8QP5AViTPYA21k+5cmKJJDWGRhxzdWVJezQNsnq8cru3RSN+AVc0FOK2+moZ4aztTgWutNcq7i/ZMo54qvUHa94X3pipnn+b2eJKO2vNeZuyPV5rvD9223G9ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9CTpHx6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011EFC4CEF7;
	Wed, 23 Jul 2025 08:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753260854;
	bh=oPq0am38a3k2Gitk/kUvysvrroy39y43lK8PEvLoK6M=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=f9CTpHx6b5TAos4llGmuXtmvZRuPqfmAVppssZEJ/85TZ80Dbv86+8BvfcOlSwG/2
	 N/UHpKdLQctUv2Gj3Bvd6mfpdJ8nZi14Lb6QZ+HaiZyVce9BWAQ1DyISHYnZkow1al
	 KXShSVb9zCU8/+3oPdgjuT1upSHhuq214WmHoFxCXwCuyrj1HXgJHDK9ghmNYPUtxi
	 VP3UNO2djo2SyApfXmD1gq1pwv+WT6akseyAEyuczfzLawTcdhBLjoHI7lSyUCE7hE
	 NOkqfbFESLN8LZCAZst1k19eGG2RJmJPLiuAYaOAxLb5gT6JbZz9QCSXZwPL4syVie
	 lhgqO0yUKK1Uw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 4/5] scsi: libsas: Move declarations of internal functions to sas_internal.h
Date: Wed, 23 Jul 2025 17:51:42 +0900
Message-ID: <20250723085143.134333-5-dlemoal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250723085143.134333-1-dlemoal@kernel.org>
References: <20250723085143.134333-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the declaration of all functions used only within libsas from
include/scsi/sas_ata.h to drivers/scsi/libsas/sas_internal.h.

No functional changes.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/libsas/sas_internal.h | 74 ++++++++++++++++++++++++++++++
 include/scsi/sas_ata.h             | 68 +--------------------------
 2 files changed, 75 insertions(+), 67 deletions(-)

diff --git a/drivers/scsi/libsas/sas_internal.h b/drivers/scsi/libsas/sas_internal.h
index 03d6ec1eb970..16f8d81d7531 100644
--- a/drivers/scsi/libsas/sas_internal.h
+++ b/drivers/scsi/libsas/sas_internal.h
@@ -222,4 +222,78 @@ static inline void sas_put_device(struct domain_device *dev)
 	kref_put(&dev->kref, sas_free_device);
 }
 
+#ifdef CONFIG_SCSI_SAS_ATA
+
+int sas_ata_init(struct domain_device *dev);
+void sas_ata_task_abort(struct sas_task *task);
+int sas_discover_sata(struct domain_device *dev);
+int sas_ata_add_dev(struct domain_device *parent, struct ex_phy *phy,
+		    struct domain_device *child, int phy_id);
+void sas_ata_strategy_handler(struct Scsi_Host *shost);
+void sas_ata_eh(struct Scsi_Host *shost, struct list_head *work_q);
+void sas_ata_end_eh(struct ata_port *ap);
+void sas_ata_wait_eh(struct domain_device *dev);
+void sas_probe_sata(struct asd_sas_port *port);
+void sas_suspend_sata(struct asd_sas_port *port);
+void sas_resume_sata(struct asd_sas_port *port);
+
+#else
+
+static inline int sas_ata_init(struct domain_device *dev)
+{
+	return 0;
+}
+
+static inline void sas_ata_task_abort(struct sas_task *task)
+{
+}
+
+static inline void sas_ata_strategy_handler(struct Scsi_Host *shost)
+{
+}
+
+static inline void sas_ata_eh(struct Scsi_Host *shost, struct list_head *work_q)
+{
+}
+
+static inline void sas_ata_end_eh(struct ata_port *ap)
+{
+}
+
+static inline void sas_ata_wait_eh(struct domain_device *dev)
+{
+}
+
+static inline void sas_probe_sata(struct asd_sas_port *port)
+{
+}
+
+static inline void sas_suspend_sata(struct asd_sas_port *port)
+{
+}
+
+static inline void sas_resume_sata(struct asd_sas_port *port)
+{
+}
+
+static inline void sas_ata_disabled_notice(void)
+{
+	pr_notice_once("ATA device seen but CONFIG_SCSI_SAS_ATA=N\n");
+}
+
+static inline int sas_discover_sata(struct domain_device *dev)
+{
+	sas_ata_disabled_notice();
+	return -ENXIO;
+}
+
+static inline int sas_ata_add_dev(struct domain_device *parent, struct ex_phy *phy,
+				  struct domain_device *child, int phy_id)
+{
+	sas_ata_disabled_notice();
+	return -ENODEV;
+}
+
+#endif
+
 #endif /* _SAS_INTERNAL_H_ */
diff --git a/include/scsi/sas_ata.h b/include/scsi/sas_ata.h
index 5e3475975aee..a161c0222931 100644
--- a/include/scsi/sas_ata.h
+++ b/include/scsi/sas_ata.h
@@ -28,77 +28,24 @@ static inline bool dev_is_sata(struct domain_device *dev)
 	}
 }
 
-int sas_ata_init(struct domain_device *dev);
-void sas_ata_task_abort(struct sas_task *task);
-void sas_ata_strategy_handler(struct Scsi_Host *shost);
-void sas_ata_eh(struct Scsi_Host *shost, struct list_head *work_q);
 void sas_ata_schedule_reset(struct domain_device *dev);
-void sas_ata_wait_eh(struct domain_device *dev);
-void sas_probe_sata(struct asd_sas_port *port);
-void sas_suspend_sata(struct asd_sas_port *port);
-void sas_resume_sata(struct asd_sas_port *port);
-void sas_ata_end_eh(struct ata_port *ap);
 void sas_ata_device_link_abort(struct domain_device *dev, bool force_reset);
-int sas_execute_ata_cmd(struct domain_device *device, u8 *fis,
-			int force_phy_id);
+int sas_execute_ata_cmd(struct domain_device *device, u8 *fis, int force_phy_id);
 int smp_ata_check_ready_type(struct ata_link *link);
-int sas_discover_sata(struct domain_device *dev);
-int sas_ata_add_dev(struct domain_device *parent, struct ex_phy *phy,
-		    struct domain_device *child, int phy_id);
 
 extern const struct attribute_group sas_ata_sdev_attr_group;
 
 #else
 
-static inline void sas_ata_disabled_notice(void)
-{
-	pr_notice_once("ATA device seen but CONFIG_SCSI_SAS_ATA=N\n");
-}
-
 static inline bool dev_is_sata(struct domain_device *dev)
 {
 	return false;
 }
-static inline int sas_ata_init(struct domain_device *dev)
-{
-	return 0;
-}
-static inline void sas_ata_task_abort(struct sas_task *task)
-{
-}
-
-static inline void sas_ata_strategy_handler(struct Scsi_Host *shost)
-{
-}
-
-static inline void sas_ata_eh(struct Scsi_Host *shost, struct list_head *work_q)
-{
-}
 
 static inline void sas_ata_schedule_reset(struct domain_device *dev)
 {
 }
 
-static inline void sas_ata_wait_eh(struct domain_device *dev)
-{
-}
-
-static inline void sas_probe_sata(struct asd_sas_port *port)
-{
-}
-
-static inline void sas_suspend_sata(struct asd_sas_port *port)
-{
-}
-
-static inline void sas_resume_sata(struct asd_sas_port *port)
-{
-}
-
-static inline void sas_ata_end_eh(struct ata_port *ap)
-{
-}
-
 static inline void sas_ata_device_link_abort(struct domain_device *dev,
 					     bool force_reset)
 {
@@ -115,19 +62,6 @@ static inline int smp_ata_check_ready_type(struct ata_link *link)
 	return 0;
 }
 
-static inline int sas_discover_sata(struct domain_device *dev)
-{
-	sas_ata_disabled_notice();
-	return -ENXIO;
-}
-
-static inline int sas_ata_add_dev(struct domain_device *parent, struct ex_phy *phy,
-				  struct domain_device *child, int phy_id)
-{
-	sas_ata_disabled_notice();
-	return -ENODEV;
-}
-
 #define sas_ata_sdev_attr_group ((struct attribute_group) {})
 
 #endif
-- 
2.50.1


