Return-Path: <linux-scsi+bounces-5472-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C150A901DDF
	for <lists+linux-scsi@lfdr.de>; Mon, 10 Jun 2024 11:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6A9B1C214A5
	for <lists+linux-scsi@lfdr.de>; Mon, 10 Jun 2024 09:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5F86F313;
	Mon, 10 Jun 2024 09:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D56KGOoj"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8F36BFA3
	for <linux-scsi@vger.kernel.org>; Mon, 10 Jun 2024 09:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718010637; cv=none; b=bDDcKOMvu7JeSIki+tZWt6l5gq7CP6Fst5IjX0ocrfmcxwJACuII43i9o1z8oRVd25viu9kHMNbVqRiM2dhvPzG0t5znDMvyFOl48vSDbC+v1pfD4wtp3fe9uH15MO82W2b+U+LXkYLxHBTIMtmvBMllv33KMeIbGTnzfq2NOew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718010637; c=relaxed/simple;
	bh=oD8k4CPYedNl9qRkPpLrC2Q63V7OG1YprvgihWjuQ8U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jQfH5yCSpAWWTEWT2lYLdW28YHX0KJsB1NPX5OWEYSiT5E7rYOscR+uYX0187rotxHxG2Q5uAU0QNXcqAFAbSW+HzFt760ypWfBxBC16lYFqbbZeE0e7zNiklFx9o4CsW8+a34+2s5nmt0l0zmdzFE2+mH0XEDIK1CNt3WIx/6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D56KGOoj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D45C2BBFC;
	Mon, 10 Jun 2024 09:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718010636;
	bh=oD8k4CPYedNl9qRkPpLrC2Q63V7OG1YprvgihWjuQ8U=;
	h=From:To:Cc:Subject:Date:From;
	b=D56KGOoj0zj9DkWg88/Ecy3M/2QSgvNmBu2a4pJd9/1l40hyJ6Y6gFzLiCeJJ3b6S
	 UNVLSo+LadXttpZGCqj7UyiXxMhVdLVBTi+2z7McXYLvX5n6U620j7Dr+1K+pZ84cb
	 nEJt7YAvwaQl/XOug5XFQrsSkAUpdze++oNIonnAq1GhLadvjpnvZuvLJY56m9gEak
	 Dn5IlYg8XWlLFSnBjvbN7D7AtfZY2vEIro96jmKTS8Z0VuFpEGvjQSL7r3YZg2EcU6
	 B0gUTT24Fkd7fU+vXKWlZUU2aL6lVpRYRKqfJERKKBx3Ah+NvzdKP2j4yXbJb/WT7c
	 2PLIRs+1Q1ANA==
From: Damien Le Moal <dlemoal@kernel.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Cc: Sathya Prakash <sathya.prakash@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Subject: [PATCH v3] scsi: mpi3mr: Fix ATA NCQ priority support
Date: Mon, 10 Jun 2024 18:10:35 +0900
Message-ID: <20240610091035.250399-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function mpi3mr_qcmd() of the mpi3mr driver is able to indicate to
the HBA if a read or write command directed at an ATA device should be
translated to an NCQ read/write command with the high prioiryt bit set
when the request uses the RT priority class and the user has enabled NCQ
priority through sysfs.

However, unlike the mpt3sas driver, the mpi3mr driver does not define
the sas_ncq_prio_supported and sas_ncq_prio_enable sysfs attributes, so
the ncq_prio_enable field of struct mpi3mr_sdev_priv_data is never
actually set and NCQ Priority cannot ever be used.

Fix this by defining these missing atributes to allow a user to check if
an ATA device supports NCQ priority and to enable/disable the use of NCQ
priority. To do this, lift the function scsih_ncq_prio_supp() out of the
mpt3sas driver and make it the generic scsi sas transport function
sas_ata_ncq_prio_supported(). Nothing in that function is hardware
specific, so this function can be used in both the mpt3sas driver and
the mpi3mr driver.

Reported-by: Scott McCoy <scott.mccoy@wdc.com>
Fixes: 023ab2a9b4ed ("scsi: mpi3mr: Add support for queue command processing")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
---

Changes from v2:
 - Improved comment for the function sas_ata_ncq_prio_supported() as
   suggested by Niklas.
 - Added review tag

Changes from v1:
 - Moved scsih_ncq_prio_supp() to be a function in scsi_transport_sas.c
   and renamed that function to sas_ata_ncq_prio_supported().

 drivers/scsi/mpi3mr/mpi3mr_app.c     | 62 ++++++++++++++++++++++++++++
 drivers/scsi/mpt3sas/mpt3sas_base.h  |  3 --
 drivers/scsi/mpt3sas/mpt3sas_ctl.c   |  4 +-
 drivers/scsi/mpt3sas/mpt3sas_scsih.c | 23 -----------
 drivers/scsi/scsi_transport_sas.c    | 23 +++++++++++
 include/scsi/scsi_transport_sas.h    |  2 +
 6 files changed, 89 insertions(+), 28 deletions(-)

diff --git a/drivers/scsi/mpi3mr/mpi3mr_app.c b/drivers/scsi/mpi3mr/mpi3mr_app.c
index 1638109a68a0..cd261b48eb46 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_app.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_app.c
@@ -2163,10 +2163,72 @@ persistent_id_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(persistent_id);
 
+/**
+ * sas_ncq_prio_supported_show - Indicate if device supports NCQ priority
+ * @dev: pointer to embedded device
+ * @attr: sas_ncq_prio_supported attribute descriptor
+ * @buf: the buffer returned
+ *
+ * A sysfs 'read-only' sdev attribute, only works with SATA devices
+ */
+static ssize_t
+sas_ncq_prio_supported_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	struct scsi_device *sdev = to_scsi_device(dev);
+
+	return sysfs_emit(buf, "%d\n", sas_ata_ncq_prio_supported(sdev));
+}
+static DEVICE_ATTR_RO(sas_ncq_prio_supported);
+
+/**
+ * sas_ncq_prio_enable_show - send prioritized io commands to device
+ * @dev: pointer to embedded device
+ * @attr: sas_ncq_prio_enable attribute descriptor
+ * @buf: the buffer returned
+ *
+ * A sysfs 'read/write' sdev attribute, only works with SATA devices
+ */
+static ssize_t
+sas_ncq_prio_enable_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct mpi3mr_sdev_priv_data *sdev_priv_data =  sdev->hostdata;
+
+	if (!sdev_priv_data)
+		return 0;
+
+	return sysfs_emit(buf, "%d\n", sdev_priv_data->ncq_prio_enable);
+}
+
+static ssize_t
+sas_ncq_prio_enable_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct mpi3mr_sdev_priv_data *sdev_priv_data =  sdev->hostdata;
+	bool ncq_prio_enable = 0;
+
+	if (kstrtobool(buf, &ncq_prio_enable))
+		return -EINVAL;
+
+	if (!sas_ata_ncq_prio_supported(sdev))
+		return -EINVAL;
+
+	sdev_priv_data->ncq_prio_enable = ncq_prio_enable;
+
+	return strlen(buf);
+}
+static DEVICE_ATTR_RW(sas_ncq_prio_enable);
+
 static struct attribute *mpi3mr_dev_attrs[] = {
 	&dev_attr_sas_address.attr,
 	&dev_attr_device_handle.attr,
 	&dev_attr_persistent_id.attr,
+	&dev_attr_sas_ncq_prio_supported.attr,
+	&dev_attr_sas_ncq_prio_enable.attr,
 	NULL,
 };
 
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.h b/drivers/scsi/mpt3sas/mpt3sas_base.h
index bf100a4ebfc3..fe1e96fda284 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.h
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.h
@@ -2048,9 +2048,6 @@ void
 mpt3sas_setup_direct_io(struct MPT3SAS_ADAPTER *ioc, struct scsi_cmnd *scmd,
 	struct _raid_device *raid_device, Mpi25SCSIIORequest_t *mpi_request);
 
-/* NCQ Prio Handling Check */
-bool scsih_ncq_prio_supp(struct scsi_device *sdev);
-
 void mpt3sas_setup_debugfs(struct MPT3SAS_ADAPTER *ioc);
 void mpt3sas_destroy_debugfs(struct MPT3SAS_ADAPTER *ioc);
 void mpt3sas_init_debugfs(void);
diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
index 1c9fd26195b8..87784c96249a 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
@@ -4088,7 +4088,7 @@ sas_ncq_prio_supported_show(struct device *dev,
 {
 	struct scsi_device *sdev = to_scsi_device(dev);
 
-	return sysfs_emit(buf, "%d\n", scsih_ncq_prio_supp(sdev));
+	return sysfs_emit(buf, "%d\n", sas_ata_ncq_prio_supported(sdev));
 }
 static DEVICE_ATTR_RO(sas_ncq_prio_supported);
 
@@ -4123,7 +4123,7 @@ sas_ncq_prio_enable_store(struct device *dev,
 	if (kstrtobool(buf, &ncq_prio_enable))
 		return -EINVAL;
 
-	if (!scsih_ncq_prio_supp(sdev))
+	if (!sas_ata_ncq_prio_supported(sdev))
 		return -EINVAL;
 
 	sas_device_priv_data->ncq_prio_enable = ncq_prio_enable;
diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 12d08d8ba538..870ec2cb4af4 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -12571,29 +12571,6 @@ scsih_pci_mmio_enabled(struct pci_dev *pdev)
 	return PCI_ERS_RESULT_RECOVERED;
 }
 
-/**
- * scsih_ncq_prio_supp - Check for NCQ command priority support
- * @sdev: scsi device struct
- *
- * This is called when a user indicates they would like to enable
- * ncq command priorities. This works only on SATA devices.
- */
-bool scsih_ncq_prio_supp(struct scsi_device *sdev)
-{
-	struct scsi_vpd *vpd;
-	bool ncq_prio_supp = false;
-
-	rcu_read_lock();
-	vpd = rcu_dereference(sdev->vpd_pg89);
-	if (!vpd || vpd->len < 214)
-		goto out;
-
-	ncq_prio_supp = (vpd->data[213] >> 4) & 1;
-out:
-	rcu_read_unlock();
-
-	return ncq_prio_supp;
-}
 /*
  * The pci device ids are defined in mpi/mpi2_cnfg.h.
  */
diff --git a/drivers/scsi/scsi_transport_sas.c b/drivers/scsi/scsi_transport_sas.c
index 424a89513814..454c990a5d7c 100644
--- a/drivers/scsi/scsi_transport_sas.c
+++ b/drivers/scsi/scsi_transport_sas.c
@@ -416,6 +416,29 @@ unsigned int sas_is_tlr_enabled(struct scsi_device *sdev)
 }
 EXPORT_SYMBOL_GPL(sas_is_tlr_enabled);
 
+/**
+ * sas_ata_ncq_prio_supported - Check for ATA NCQ command priority support
+ * @sdev: SCSI device
+ *
+ * Check if an ATA device supports NCQ priority using VPD page 89h (ATA
+ * Information). Since this VPD page is implemented only for ATA devices,
+ * this function always returns false for SCSI devices."
+ */
+bool sas_ata_ncq_prio_supported(struct scsi_device *sdev)
+{
+	struct scsi_vpd *vpd;
+	bool ncq_prio_supported = false;
+
+	rcu_read_lock();
+	vpd = rcu_dereference(sdev->vpd_pg89);
+	if (vpd && vpd->len >= 214)
+		ncq_prio_supported = (vpd->data[213] >> 4) & 1;
+	rcu_read_unlock();
+
+	return ncq_prio_supported;
+}
+EXPORT_SYMBOL_GPL(sas_ata_ncq_prio_supported);
+
 /*
  * SAS Phy attributes
  */
diff --git a/include/scsi/scsi_transport_sas.h b/include/scsi/scsi_transport_sas.h
index 0e75b9277c8c..e3b6ce3cbf88 100644
--- a/include/scsi/scsi_transport_sas.h
+++ b/include/scsi/scsi_transport_sas.h
@@ -200,6 +200,8 @@ unsigned int sas_is_tlr_enabled(struct scsi_device *);
 void sas_disable_tlr(struct scsi_device *);
 void sas_enable_tlr(struct scsi_device *);
 
+bool sas_ata_ncq_prio_supported(struct scsi_device *sdev);
+
 extern struct sas_rphy *sas_end_device_alloc(struct sas_port *);
 extern struct sas_rphy *sas_expander_alloc(struct sas_port *, enum sas_device_type);
 void sas_rphy_free(struct sas_rphy *);
-- 
2.45.2


