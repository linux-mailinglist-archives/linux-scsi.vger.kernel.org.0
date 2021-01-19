Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C08312FBA0F
	for <lists+linux-scsi@lfdr.de>; Tue, 19 Jan 2021 15:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403881AbhASOlR (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 19 Jan 2021 09:41:17 -0500
Received: from mga17.intel.com ([192.55.52.151]:24134 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395410AbhASOS1 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 19 Jan 2021 09:18:27 -0500
IronPort-SDR: cX/XSsh20EoFVN6T2HivWgYhzwldQBJ2JK88gK5eoWb9gGK8KXqY8xQiYUkgYj8hrWa/edcIDx
 +uZM51agd51Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9868"; a="158704833"
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="158704833"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 06:15:49 -0800
IronPort-SDR: fytKzeE1ACT3hDIVPJ34k0Spxc2B5SWzxlvnoBz2oZDkf872Pos3/Fq2Wl6XauXzC3fX/JMyaa
 6JXAgwVJB6mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="347189952"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.149])
  by fmsmga007.fm.intel.com with ESMTP; 19 Jan 2021 06:15:47 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <huobean@gmail.com>, Can Guo <cang@codeaurora.org>,
        Stanley Chu <stanley.chu@mediatek.com>
Subject: [PATCH 3/4] scsi: ufs-debugfs: Add user-defined exception_event_mask
Date:   Tue, 19 Jan 2021 16:15:41 +0200
Message-Id: <20210119141542.3808-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210119141542.3808-1-adrian.hunter@intel.com>
References: <20210119141542.3808-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Allow users to enable specific exception events via debugfs.

The bits enabled by the driver ee_drv_ctrl are separated from the bits
enabled by the user ee_usr_ctrl. The control mask ee_mask_ctrl is the
logical-or of those two. A mutex is needed to ensure that the masks match
what was written to the device.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/scsi/ufs/ufs-debugfs.c | 46 ++++++++++++++++++
 drivers/scsi/ufs/ufshcd.c      | 86 +++++++++++++++++++++-------------
 drivers/scsi/ufs/ufshcd.h      | 22 ++++++++-
 3 files changed, 120 insertions(+), 34 deletions(-)

diff --git a/drivers/scsi/ufs/ufs-debugfs.c b/drivers/scsi/ufs/ufs-debugfs.c
index dee98dc72d29..59729073b569 100644
--- a/drivers/scsi/ufs/ufs-debugfs.c
+++ b/drivers/scsi/ufs/ufs-debugfs.c
@@ -44,10 +44,56 @@ static int ufs_debugfs_stats_show(struct seq_file *s, void *data)
 }
 DEFINE_SHOW_ATTRIBUTE(ufs_debugfs_stats);
 
+static int ee_usr_mask_get(void *data, u64 *val)
+{
+	struct ufs_hba *hba = data;
+
+	*val = hba->ee_usr_mask;
+	return 0;
+}
+
+static int ufs_debugfs_get_user_access(struct ufs_hba *hba)
+__acquires(&hba->host_sem)
+{
+	down(&hba->host_sem);
+	if (!ufshcd_is_user_access_allowed(hba)) {
+		up(&hba->host_sem);
+		return -EBUSY;
+	}
+	pm_runtime_get_sync(hba->dev);
+	return 0;
+}
+
+static void ufs_debugfs_put_user_access(struct ufs_hba *hba)
+__releases(&hba->host_sem)
+{
+	pm_runtime_put_sync(hba->dev);
+	up(&hba->host_sem);
+}
+
+static int ee_usr_mask_set(void *data, u64 val)
+{
+	struct ufs_hba *hba = data;
+	int err;
+
+	if (val & ~(u64)MASK_EE_STATUS)
+		return -EINVAL;
+	err = ufs_debugfs_get_user_access(hba);
+	if (err)
+		return err;
+	err = ufshcd_update_ee_usr_mask(hba, val, MASK_EE_STATUS);
+	ufs_debugfs_put_user_access(hba);
+	return err;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(ee_usr_mask_fops, ee_usr_mask_get, ee_usr_mask_set, "%#llx\n");
+
 void ufs_debugfs_hba_init(struct ufs_hba *hba)
 {
 	hba->debugfs_root = debugfs_create_dir(dev_name(hba->dev), ufs_debugfs_root);
 	debugfs_create_file("stats", 0400, hba->debugfs_root, hba, &ufs_debugfs_stats_fops);
+	debugfs_create_file("exception_event_mask", 0600, hba->debugfs_root,
+			    hba, &ee_usr_mask_fops);
 }
 
 void ufs_debugfs_hba_exit(struct ufs_hba *hba)
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 7d46b2c278dd..d68f5ecc9b13 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -5147,6 +5147,46 @@ static irqreturn_t ufshcd_transfer_req_compl(struct ufs_hba *hba)
 	}
 }
 
+static int __ufshcd_write_ee_control(struct ufs_hba *hba, u32 ee_ctrl_mask)
+{
+	return ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_WRITE_ATTR,
+				       QUERY_ATTR_IDN_EE_CONTROL, 0, 0,
+				       &ee_ctrl_mask);
+}
+
+static int ufshcd_write_ee_control(struct ufs_hba *hba)
+{
+	int err;
+
+	mutex_lock(&hba->ee_ctrl_mutex);
+	err = __ufshcd_write_ee_control(hba, hba->ee_ctrl_mask);
+	mutex_unlock(&hba->ee_ctrl_mutex);
+	if (err)
+		dev_err(hba->dev, "%s: failed to write ee control %d\n",
+			__func__, err);
+	return err;
+}
+
+int ufshcd_update_ee_control(struct ufs_hba *hba, u16 *mask, u16 *other_mask,
+			     u16 set, u16 clr)
+{
+	u16 new_mask, ee_ctrl_mask;
+	int err = 0;
+
+	mutex_lock(&hba->ee_ctrl_mutex);
+	new_mask = (*mask & ~clr) | set;
+	ee_ctrl_mask = new_mask | *other_mask;
+	if (ee_ctrl_mask != hba->ee_ctrl_mask)
+		err = __ufshcd_write_ee_control(hba, ee_ctrl_mask);
+	/* Still need to update 'mask' even if 'ee_ctrl_mask' was unchanged */
+	if (!err) {
+		hba->ee_ctrl_mask = ee_ctrl_mask;
+		*mask = new_mask;
+	}
+	mutex_unlock(&hba->ee_ctrl_mutex);
+	return err;
+}
+
 /**
  * ufshcd_disable_ee - disable exception event
  * @hba: per-adapter instance
@@ -5157,22 +5197,9 @@ static irqreturn_t ufshcd_transfer_req_compl(struct ufs_hba *hba)
  *
  * Returns zero on success, non-zero error value on failure.
  */
-static int ufshcd_disable_ee(struct ufs_hba *hba, u16 mask)
+static inline int ufshcd_disable_ee(struct ufs_hba *hba, u16 mask)
 {
-	int err = 0;
-	u32 val;
-
-	if (!(hba->ee_ctrl_mask & mask))
-		goto out;
-
-	val = hba->ee_ctrl_mask & ~mask;
-	val &= MASK_EE_STATUS;
-	err = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_WRITE_ATTR,
-			QUERY_ATTR_IDN_EE_CONTROL, 0, 0, &val);
-	if (!err)
-		hba->ee_ctrl_mask &= ~mask;
-out:
-	return err;
+	return ufshcd_update_ee_drv_mask(hba, 0, mask);
 }
 
 /**
@@ -5185,22 +5212,9 @@ static int ufshcd_disable_ee(struct ufs_hba *hba, u16 mask)
  *
  * Returns zero on success, non-zero error value on failure.
  */
-static int ufshcd_enable_ee(struct ufs_hba *hba, u16 mask)
+static inline int ufshcd_enable_ee(struct ufs_hba *hba, u16 mask)
 {
-	int err = 0;
-	u32 val;
-
-	if (hba->ee_ctrl_mask & mask)
-		goto out;
-
-	val = hba->ee_ctrl_mask | mask;
-	val &= MASK_EE_STATUS;
-	err = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_WRITE_ATTR,
-			QUERY_ATTR_IDN_EE_CONTROL, 0, 0, &val);
-	if (!err)
-		hba->ee_ctrl_mask |= mask;
-out:
-	return err;
+	return ufshcd_update_ee_drv_mask(hba, mask, 0);
 }
 
 /**
@@ -5626,9 +5640,7 @@ static void ufshcd_exception_event_handler(struct work_struct *work)
 
 	trace_ufshcd_exception_event(dev_name(hba->dev), status);
 
-	status &= hba->ee_ctrl_mask;
-
-	if (status & MASK_EE_URGENT_BKOPS)
+	if (status & hba->ee_drv_mask & MASK_EE_URGENT_BKOPS)
 		ufshcd_bkops_exception_event_handler(hba);
 
 out:
@@ -7914,6 +7926,8 @@ static int ufshcd_probe_hba(struct ufs_hba *hba, bool async)
 	ufshcd_set_active_icc_lvl(hba);
 
 	ufshcd_wb_config(hba);
+	if (hba->ee_usr_mask)
+		ufshcd_write_ee_control(hba);
 	/* Enable Auto-Hibernate if configured */
 	ufshcd_auto_hibern8_enable(hba);
 
@@ -8916,6 +8930,9 @@ static int ufshcd_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 		 */
 		ufshcd_urgent_bkops(hba);
 
+	if (hba->ee_usr_mask)
+		ufshcd_write_ee_control(hba);
+
 	hba->clk_gating.is_suspended = false;
 
 	if (hba->clk_scaling.is_allowed)
@@ -9362,6 +9379,9 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 	/* Initialize mutex for device management commands */
 	mutex_init(&hba->dev_cmd.lock);
 
+	/* Initialize mutex for exception event control */
+	mutex_init(&hba->ee_ctrl_mutex);
+
 	init_rwsem(&hba->clk_scaling_lock);
 
 	ufshcd_init_clk_gating(hba);
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 5bbe4715d4e9..ff9601f8d9e6 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -761,7 +761,10 @@ struct ufs_hba {
 	u32 ufshcd_state;
 	u32 eh_flags;
 	u32 intr_mask;
-	u16 ee_ctrl_mask;
+	u16 ee_ctrl_mask; /* Exception event mask */
+	u16 ee_drv_mask;  /* Exception event mask for driver */
+	u16 ee_usr_mask;  /* Exception event mask for user (via debugfs) */
+	struct mutex ee_ctrl_mutex;
 	bool is_powered;
 	bool shutting_down;
 	struct semaphore host_sem;
@@ -1273,4 +1276,21 @@ static inline u8 ufshcd_scsi_to_upiu_lun(unsigned int scsi_lun)
 int ufshcd_dump_regs(struct ufs_hba *hba, size_t offset, size_t len,
 		     const char *prefix);
 
+int ufshcd_update_ee_control(struct ufs_hba *hba, u16 *mask, u16 *other_mask,
+			     u16 set, u16 clr);
+
+static inline int ufshcd_update_ee_drv_mask(struct ufs_hba *hba,
+					    u16 set, u16 clr)
+{
+	return ufshcd_update_ee_control(hba, &hba->ee_drv_mask,
+					&hba->ee_usr_mask, set, clr);
+}
+
+static inline int ufshcd_update_ee_usr_mask(struct ufs_hba *hba,
+					    u16 set, u16 clr)
+{
+	return ufshcd_update_ee_control(hba, &hba->ee_usr_mask,
+					&hba->ee_drv_mask, set, clr);
+}
+
 #endif /* End of Header */
-- 
2.17.1

