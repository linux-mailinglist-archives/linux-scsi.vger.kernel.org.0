Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6521D4FE7E6
	for <lists+linux-scsi@lfdr.de>; Tue, 12 Apr 2022 20:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbiDLS1l (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 12 Apr 2022 14:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358742AbiDLS1i (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 12 Apr 2022 14:27:38 -0400
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC02827B09
        for <linux-scsi@vger.kernel.org>; Tue, 12 Apr 2022 11:25:19 -0700 (PDT)
Received: by mail-pl1-f182.google.com with SMTP id s14so7928100plk.8
        for <linux-scsi@vger.kernel.org>; Tue, 12 Apr 2022 11:25:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fOU1/Pepe52OePCJAW6Boa1hD1Yk4gdg7f3FgGlBhdo=;
        b=r56/csFJ7Qo9xr+BnPR6lFQ2+vQSFRw2zVB43lCp95/Ab57Py0FmkjY2aTmZRF4p0v
         MVhJW54hSwun+7kJ4FzxCDaTK2/IGY8NND04FfGq2E0LqeyFnsdAfbXAiZmQXbCBh/vG
         rn7nStFr2hXx7I5ihkTGvLXb5X5iW6PbC4fbzFNcTUR6Cjj0wab1yyfQzvCAXtso0aKD
         ZT+isUWeoCHGP7s+bjxJqdLDFOcY4hZ0UiVnFqNIDumqHKhqN6RaidcuqIFvDsPiaJzX
         rtKhr4yCIwrd7szUsWt/T5Uj0sPaHB4PQ9LvaCAqeTbiVisKscvqT2X0lUj8Oxw3sTj5
         pXYQ==
X-Gm-Message-State: AOAM530eTgE2gthnI69Dib5ScbJ9g2m8l53zj0Vvz1ACtNWzgc/VgO6I
        K3wnC8k4t0tmnXhloBHevoU=
X-Google-Smtp-Source: ABdhPJyzNIjlel/IoZkzxhv0Z3d9ITFnOHZWVH2PXL4myh1aXGIflOj15IbhZkmn0ulGSYNiEfJ4BQ==
X-Received: by 2002:a17:90a:4890:b0:1bf:654e:e1a0 with SMTP id b16-20020a17090a489000b001bf654ee1a0mr6486889pjh.113.1649787919228;
        Tue, 12 Apr 2022 11:25:19 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:d4b2:56ee:d001:c159])
        by smtp.gmail.com with ESMTPSA id d18-20020a056a0010d200b004fa2e13ce80sm40367037pfu.76.2022.04.12.11.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 11:25:18 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Avri Altman <Avri.Altman@wdc.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Bean Huo <beanhuo@micron.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Keoseong Park <keosung.park@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2 26/29] scsi: ufs: Split the ufshcd.h header file
Date:   Tue, 12 Apr 2022 11:18:50 -0700
Message-Id: <20220412181853.3715080-27-bvanassche@acm.org>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
In-Reply-To: <20220412181853.3715080-1-bvanassche@acm.org>
References: <20220412181853.3715080-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Split the ufshcd.h header file into a header file that defines the
interface used by UFS drivers and another header file with declarations
and data structures only used by the UFS core.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/ufs/ufs-debugfs.c   |   1 +
 drivers/scsi/ufs/ufs-hwmon.c     |   1 +
 drivers/scsi/ufs/ufs-sysfs.c     |   2 +-
 drivers/scsi/ufs/ufs_bsg.c       |   1 +
 drivers/scsi/ufs/ufshcd-crypto.h |   2 +
 drivers/scsi/ufs/ufshcd-priv.h   | 279 +++++++++++++++++++++++++++++++
 drivers/scsi/ufs/ufshcd.c        |   2 +-
 drivers/scsi/ufs/ufshcd.h        | 222 ------------------------
 drivers/scsi/ufs/ufshpb.c        |   2 +-
 9 files changed, 287 insertions(+), 225 deletions(-)
 create mode 100644 drivers/scsi/ufs/ufshcd-priv.h

diff --git a/drivers/scsi/ufs/ufs-debugfs.c b/drivers/scsi/ufs/ufs-debugfs.c
index 4a0bbcf1757a..c10a8f09682b 100644
--- a/drivers/scsi/ufs/ufs-debugfs.c
+++ b/drivers/scsi/ufs/ufs-debugfs.c
@@ -5,6 +5,7 @@
 
 #include "ufs-debugfs.h"
 #include "ufshcd.h"
+#include "ufshcd-priv.h"
 
 static struct dentry *ufs_debugfs_root;
 
diff --git a/drivers/scsi/ufs/ufs-hwmon.c b/drivers/scsi/ufs/ufs-hwmon.c
index 74855491dc8f..c38d9d98a86d 100644
--- a/drivers/scsi/ufs/ufs-hwmon.c
+++ b/drivers/scsi/ufs/ufs-hwmon.c
@@ -8,6 +8,7 @@
 #include <linux/units.h>
 
 #include "ufshcd.h"
+#include "ufshcd-priv.h"
 
 struct ufs_hwmon_data {
 	struct ufs_hba *hba;
diff --git a/drivers/scsi/ufs/ufs-sysfs.c b/drivers/scsi/ufs/ufs-sysfs.c
index 95a4e64ce401..8a3c6442f291 100644
--- a/drivers/scsi/ufs/ufs-sysfs.c
+++ b/drivers/scsi/ufs/ufs-sysfs.c
@@ -8,7 +8,7 @@
 
 #include "ufs.h"
 #include "ufs-sysfs.h"
-#include "ufshcd.h"
+#include "ufshcd-priv.h"
 
 static const char *ufshcd_uic_link_state_to_string(
 			enum uic_link_state state)
diff --git a/drivers/scsi/ufs/ufs_bsg.c b/drivers/scsi/ufs/ufs_bsg.c
index fbcdfb713542..9e9b93867cab 100644
--- a/drivers/scsi/ufs/ufs_bsg.c
+++ b/drivers/scsi/ufs/ufs_bsg.c
@@ -10,6 +10,7 @@
 #include <scsi/scsi_host.h>
 #include "ufs_bsg.h"
 #include "ufshcd.h"
+#include "ufshcd-priv.h"
 
 static int ufs_bsg_get_query_desc_size(struct ufs_hba *hba, int *desc_len,
 				       struct utp_upiu_query *qr)
diff --git a/drivers/scsi/ufs/ufshcd-crypto.h b/drivers/scsi/ufs/ufshcd-crypto.h
index 57dd51256b57..9f98f18f9646 100644
--- a/drivers/scsi/ufs/ufshcd-crypto.h
+++ b/drivers/scsi/ufs/ufshcd-crypto.h
@@ -8,6 +8,8 @@
 
 #include <scsi/scsi_cmnd.h>
 #include "ufshcd.h"
+#include "ufshcd-priv.h"
+#include "ufshci.h"
 
 #ifdef CONFIG_SCSI_UFS_CRYPTO
 
diff --git a/drivers/scsi/ufs/ufshcd-priv.h b/drivers/scsi/ufs/ufshcd-priv.h
new file mode 100644
index 000000000000..3fa8ab94e4e1
--- /dev/null
+++ b/drivers/scsi/ufs/ufshcd-priv.h
@@ -0,0 +1,279 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef _UFSHCD_PRIV_H_
+#define _UFSHCD_PRIV_H_
+
+#include <linux/pm_runtime.h>
+#include "ufshcd.h"
+
+static inline bool ufshcd_is_user_access_allowed(struct ufs_hba *hba)
+{
+	return !hba->shutting_down;
+}
+
+void ufshcd_schedule_eh_work(struct ufs_hba *hba);
+
+static inline bool ufshcd_keep_autobkops_enabled_except_suspend(
+							struct ufs_hba *hba)
+{
+	return hba->caps & UFSHCD_CAP_KEEP_AUTO_BKOPS_ENABLED_EXCEPT_SUSPEND;
+}
+
+static inline u8 ufshcd_wb_get_query_index(struct ufs_hba *hba)
+{
+	if (hba->dev_info.wb_buffer_type == WB_BUF_MODE_LU_DEDICATED)
+		return hba->dev_info.wb_dedicated_lu;
+	return 0;
+}
+
+#ifdef CONFIG_SCSI_UFS_HWMON
+void ufs_hwmon_probe(struct ufs_hba *hba, u8 mask);
+void ufs_hwmon_remove(struct ufs_hba *hba);
+void ufs_hwmon_notify_event(struct ufs_hba *hba, u8 ee_mask);
+#else
+static inline void ufs_hwmon_probe(struct ufs_hba *hba, u8 mask) {}
+static inline void ufs_hwmon_remove(struct ufs_hba *hba) {}
+static inline void ufs_hwmon_notify_event(struct ufs_hba *hba, u8 ee_mask) {}
+#endif
+
+int ufshcd_read_desc_param(struct ufs_hba *hba,
+			   enum desc_idn desc_id,
+			   int desc_index,
+			   u8 param_offset,
+			   u8 *param_read_buf,
+			   u8 param_size);
+int ufshcd_query_attr_retry(struct ufs_hba *hba, enum query_opcode opcode,
+			    enum attr_idn idn, u8 index, u8 selector,
+			    u32 *attr_val);
+int ufshcd_query_attr(struct ufs_hba *hba, enum query_opcode opcode,
+		      enum attr_idn idn, u8 index, u8 selector, u32 *attr_val);
+int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
+	enum flag_idn idn, u8 index, bool *flag_res);
+void ufshcd_auto_hibern8_update(struct ufs_hba *hba, u32 ahit);
+
+#define SD_ASCII_STD true
+#define SD_RAW false
+int ufshcd_read_string_desc(struct ufs_hba *hba, u8 desc_index,
+			    u8 **buf, bool ascii);
+
+int ufshcd_hold(struct ufs_hba *hba, bool async);
+void ufshcd_release(struct ufs_hba *hba);
+
+void ufshcd_map_desc_id_to_length(struct ufs_hba *hba, enum desc_idn desc_id,
+				  int *desc_length);
+
+int ufshcd_send_uic_cmd(struct ufs_hba *hba, struct uic_command *uic_cmd);
+
+int ufshcd_exec_raw_upiu_cmd(struct ufs_hba *hba,
+			     struct utp_upiu_req *req_upiu,
+			     struct utp_upiu_req *rsp_upiu,
+			     int msgcode,
+			     u8 *desc_buff, int *buff_len,
+			     enum query_opcode desc_op);
+
+int ufshcd_wb_toggle(struct ufs_hba *hba, bool enable);
+
+/* Wrapper functions for safely calling variant operations */
+static inline const char *ufshcd_get_var_name(struct ufs_hba *hba)
+{
+	if (hba->vops)
+		return hba->vops->name;
+	return "";
+}
+
+static inline void ufshcd_vops_exit(struct ufs_hba *hba)
+{
+	if (hba->vops && hba->vops->exit)
+		return hba->vops->exit(hba);
+}
+
+static inline u32 ufshcd_vops_get_ufs_hci_version(struct ufs_hba *hba)
+{
+	if (hba->vops && hba->vops->get_ufs_hci_version)
+		return hba->vops->get_ufs_hci_version(hba);
+
+	return ufshcd_readl(hba, REG_UFS_VERSION);
+}
+
+static inline int ufshcd_vops_clk_scale_notify(struct ufs_hba *hba,
+			bool up, enum ufs_notify_change_status status)
+{
+	if (hba->vops && hba->vops->clk_scale_notify)
+		return hba->vops->clk_scale_notify(hba, up, status);
+	return 0;
+}
+
+static inline void ufshcd_vops_event_notify(struct ufs_hba *hba,
+					    enum ufs_event_type evt,
+					    void *data)
+{
+	if (hba->vops && hba->vops->event_notify)
+		hba->vops->event_notify(hba, evt, data);
+}
+
+static inline int ufshcd_vops_setup_clocks(struct ufs_hba *hba, bool on,
+					enum ufs_notify_change_status status)
+{
+	if (hba->vops && hba->vops->setup_clocks)
+		return hba->vops->setup_clocks(hba, on, status);
+	return 0;
+}
+
+static inline int ufshcd_vops_hce_enable_notify(struct ufs_hba *hba,
+						bool status)
+{
+	if (hba->vops && hba->vops->hce_enable_notify)
+		return hba->vops->hce_enable_notify(hba, status);
+
+	return 0;
+}
+static inline int ufshcd_vops_link_startup_notify(struct ufs_hba *hba,
+						bool status)
+{
+	if (hba->vops && hba->vops->link_startup_notify)
+		return hba->vops->link_startup_notify(hba, status);
+
+	return 0;
+}
+
+static inline int ufshcd_vops_pwr_change_notify(struct ufs_hba *hba,
+				  enum ufs_notify_change_status status,
+				  struct ufs_pa_layer_attr *dev_max_params,
+				  struct ufs_pa_layer_attr *dev_req_params)
+{
+	if (hba->vops && hba->vops->pwr_change_notify)
+		return hba->vops->pwr_change_notify(hba, status,
+					dev_max_params, dev_req_params);
+
+	return -ENOTSUPP;
+}
+
+static inline void ufshcd_vops_setup_task_mgmt(struct ufs_hba *hba,
+					int tag, u8 tm_function)
+{
+	if (hba->vops && hba->vops->setup_task_mgmt)
+		return hba->vops->setup_task_mgmt(hba, tag, tm_function);
+}
+
+static inline void ufshcd_vops_hibern8_notify(struct ufs_hba *hba,
+					enum uic_cmd_dme cmd,
+					enum ufs_notify_change_status status)
+{
+	if (hba->vops && hba->vops->hibern8_notify)
+		return hba->vops->hibern8_notify(hba, cmd, status);
+}
+
+static inline int ufshcd_vops_apply_dev_quirks(struct ufs_hba *hba)
+{
+	if (hba->vops && hba->vops->apply_dev_quirks)
+		return hba->vops->apply_dev_quirks(hba);
+	return 0;
+}
+
+static inline void ufshcd_vops_fixup_dev_quirks(struct ufs_hba *hba)
+{
+	if (hba->vops && hba->vops->fixup_dev_quirks)
+		hba->vops->fixup_dev_quirks(hba);
+}
+
+static inline int ufshcd_vops_suspend(struct ufs_hba *hba, enum ufs_pm_op op,
+				enum ufs_notify_change_status status)
+{
+	if (hba->vops && hba->vops->suspend)
+		return hba->vops->suspend(hba, op, status);
+
+	return 0;
+}
+
+static inline int ufshcd_vops_resume(struct ufs_hba *hba, enum ufs_pm_op op)
+{
+	if (hba->vops && hba->vops->resume)
+		return hba->vops->resume(hba, op);
+
+	return 0;
+}
+
+static inline void ufshcd_vops_dbg_register_dump(struct ufs_hba *hba)
+{
+	if (hba->vops && hba->vops->dbg_register_dump)
+		hba->vops->dbg_register_dump(hba);
+}
+
+static inline int ufshcd_vops_device_reset(struct ufs_hba *hba)
+{
+	if (hba->vops && hba->vops->device_reset)
+		return hba->vops->device_reset(hba);
+
+	return -EOPNOTSUPP;
+}
+
+static inline void ufshcd_vops_config_scaling_param(struct ufs_hba *hba,
+		struct devfreq_dev_profile *p,
+		struct devfreq_simple_ondemand_data *data)
+{
+	if (hba->vops && hba->vops->config_scaling_param)
+		hba->vops->config_scaling_param(hba, p, data);
+}
+
+extern struct ufs_pm_lvl_states ufs_pm_lvl_states[];
+
+/**
+ * ufshcd_scsi_to_upiu_lun - maps scsi LUN to UPIU LUN
+ * @scsi_lun: scsi LUN id
+ *
+ * Returns UPIU LUN id
+ */
+static inline u8 ufshcd_scsi_to_upiu_lun(unsigned int scsi_lun)
+{
+	if (scsi_is_wlun(scsi_lun))
+		return (scsi_lun & UFS_UPIU_MAX_UNIT_NUM_ID)
+			| UFS_UPIU_WLUN_ID;
+	else
+		return scsi_lun & UFS_UPIU_MAX_UNIT_NUM_ID;
+}
+
+int __ufshcd_write_ee_control(struct ufs_hba *hba, u32 ee_ctrl_mask);
+int ufshcd_write_ee_control(struct ufs_hba *hba);
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
+static inline int ufshcd_rpm_get_sync(struct ufs_hba *hba)
+{
+	return pm_runtime_get_sync(&hba->ufs_device_wlun->sdev_gendev);
+}
+
+static inline int ufshcd_rpm_put_sync(struct ufs_hba *hba)
+{
+	return pm_runtime_put_sync(&hba->ufs_device_wlun->sdev_gendev);
+}
+
+static inline void ufshcd_rpm_get_noresume(struct ufs_hba *hba)
+{
+	pm_runtime_get_noresume(&hba->ufs_device_wlun->sdev_gendev);
+}
+
+static inline int ufshcd_rpm_resume(struct ufs_hba *hba)
+{
+	return pm_runtime_resume(&hba->ufs_device_wlun->sdev_gendev);
+}
+
+static inline int ufshcd_rpm_put(struct ufs_hba *hba)
+{
+	return pm_runtime_put(&hba->ufs_device_wlun->sdev_gendev);
+}
+
+#endif /* _UFSHCD_PRIV_H_ */
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 5308f43bda6e..da8beed2767c 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -26,7 +26,7 @@
 #include <scsi/scsi_dbg.h>
 #include <scsi/scsi_driver.h>
 #include <scsi/scsi_eh.h>
-#include "ufshcd.h"
+#include "ufshcd-priv.h"
 #include "ufs_quirks.h"
 #include "unipro.h"
 #include "ufs-sysfs.h"
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index ab0c643296c0..16f69ab1b309 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -1007,11 +1007,6 @@ static inline bool ufshcd_is_wb_allowed(struct ufs_hba *hba)
 	return hba->caps & UFSHCD_CAP_WB_EN;
 }
 
-static inline bool ufshcd_is_user_access_allowed(struct ufs_hba *hba)
-{
-	return !hba->shutting_down;
-}
-
 #define ufshcd_writel(hba, val, reg)	\
 	writel((val), (hba)->mmio_base + (reg))
 #define ufshcd_readl(hba, reg)	\
@@ -1075,28 +1070,6 @@ static inline void *ufshcd_get_variant(struct ufs_hba *hba)
 	BUG_ON(!hba);
 	return hba->priv;
 }
-static inline bool ufshcd_keep_autobkops_enabled_except_suspend(
-							struct ufs_hba *hba)
-{
-	return hba->caps & UFSHCD_CAP_KEEP_AUTO_BKOPS_ENABLED_EXCEPT_SUSPEND;
-}
-
-static inline u8 ufshcd_wb_get_query_index(struct ufs_hba *hba)
-{
-	if (hba->dev_info.wb_buffer_type == WB_BUF_MODE_LU_DEDICATED)
-		return hba->dev_info.wb_dedicated_lu;
-	return 0;
-}
-
-#ifdef CONFIG_SCSI_UFS_HWMON
-void ufs_hwmon_probe(struct ufs_hba *hba, u8 mask);
-void ufs_hwmon_remove(struct ufs_hba *hba);
-void ufs_hwmon_notify_event(struct ufs_hba *hba, u8 ee_mask);
-#else
-static inline void ufs_hwmon_probe(struct ufs_hba *hba, u8 mask) {}
-static inline void ufs_hwmon_remove(struct ufs_hba *hba) {}
-static inline void ufs_hwmon_notify_event(struct ufs_hba *hba, u8 ee_mask) {}
-#endif
 
 #ifdef CONFIG_PM
 extern int ufshcd_runtime_suspend(struct device *dev);
@@ -1230,13 +1203,6 @@ int __ufshcd_suspend_prepare(struct device *dev, bool rpm_ok_for_spm);
 void ufshcd_resume_complete(struct device *dev);
 
 /* Wrapper functions for safely calling variant operations */
-static inline const char *ufshcd_get_var_name(struct ufs_hba *hba)
-{
-	if (hba->vops)
-		return hba->vops->name;
-	return "";
-}
-
 static inline int ufshcd_vops_init(struct ufs_hba *hba)
 {
 	if (hba->vops && hba->vops->init)
@@ -1245,61 +1211,6 @@ static inline int ufshcd_vops_init(struct ufs_hba *hba)
 	return 0;
 }
 
-static inline void ufshcd_vops_exit(struct ufs_hba *hba)
-{
-	if (hba->vops && hba->vops->exit)
-		return hba->vops->exit(hba);
-}
-
-static inline u32 ufshcd_vops_get_ufs_hci_version(struct ufs_hba *hba)
-{
-	if (hba->vops && hba->vops->get_ufs_hci_version)
-		return hba->vops->get_ufs_hci_version(hba);
-
-	return ufshcd_readl(hba, REG_UFS_VERSION);
-}
-
-static inline int ufshcd_vops_clk_scale_notify(struct ufs_hba *hba,
-			bool up, enum ufs_notify_change_status status)
-{
-	if (hba->vops && hba->vops->clk_scale_notify)
-		return hba->vops->clk_scale_notify(hba, up, status);
-	return 0;
-}
-
-static inline void ufshcd_vops_event_notify(struct ufs_hba *hba,
-					    enum ufs_event_type evt,
-					    void *data)
-{
-	if (hba->vops && hba->vops->event_notify)
-		hba->vops->event_notify(hba, evt, data);
-}
-
-static inline int ufshcd_vops_setup_clocks(struct ufs_hba *hba, bool on,
-					enum ufs_notify_change_status status)
-{
-	if (hba->vops && hba->vops->setup_clocks)
-		return hba->vops->setup_clocks(hba, on, status);
-	return 0;
-}
-
-static inline int ufshcd_vops_hce_enable_notify(struct ufs_hba *hba,
-						bool status)
-{
-	if (hba->vops && hba->vops->hce_enable_notify)
-		return hba->vops->hce_enable_notify(hba, status);
-
-	return 0;
-}
-static inline int ufshcd_vops_link_startup_notify(struct ufs_hba *hba,
-						bool status)
-{
-	if (hba->vops && hba->vops->link_startup_notify)
-		return hba->vops->link_startup_notify(hba, status);
-
-	return 0;
-}
-
 static inline int ufshcd_vops_phy_initialization(struct ufs_hba *hba)
 {
 	if (hba->vops && hba->vops->phy_initialization)
@@ -1308,102 +1219,8 @@ static inline int ufshcd_vops_phy_initialization(struct ufs_hba *hba)
 	return 0;
 }
 
-static inline int ufshcd_vops_pwr_change_notify(struct ufs_hba *hba,
-				  enum ufs_notify_change_status status,
-				  struct ufs_pa_layer_attr *dev_max_params,
-				  struct ufs_pa_layer_attr *dev_req_params)
-{
-	if (hba->vops && hba->vops->pwr_change_notify)
-		return hba->vops->pwr_change_notify(hba, status,
-					dev_max_params, dev_req_params);
-
-	return -ENOTSUPP;
-}
-
-static inline void ufshcd_vops_setup_task_mgmt(struct ufs_hba *hba,
-					int tag, u8 tm_function)
-{
-	if (hba->vops && hba->vops->setup_task_mgmt)
-		return hba->vops->setup_task_mgmt(hba, tag, tm_function);
-}
-
-static inline void ufshcd_vops_hibern8_notify(struct ufs_hba *hba,
-					enum uic_cmd_dme cmd,
-					enum ufs_notify_change_status status)
-{
-	if (hba->vops && hba->vops->hibern8_notify)
-		return hba->vops->hibern8_notify(hba, cmd, status);
-}
-
-static inline int ufshcd_vops_apply_dev_quirks(struct ufs_hba *hba)
-{
-	if (hba->vops && hba->vops->apply_dev_quirks)
-		return hba->vops->apply_dev_quirks(hba);
-	return 0;
-}
-
-static inline void ufshcd_vops_fixup_dev_quirks(struct ufs_hba *hba)
-{
-	if (hba->vops && hba->vops->fixup_dev_quirks)
-		hba->vops->fixup_dev_quirks(hba);
-}
-
-static inline int ufshcd_vops_suspend(struct ufs_hba *hba, enum ufs_pm_op op,
-				enum ufs_notify_change_status status)
-{
-	if (hba->vops && hba->vops->suspend)
-		return hba->vops->suspend(hba, op, status);
-
-	return 0;
-}
-
-static inline int ufshcd_vops_resume(struct ufs_hba *hba, enum ufs_pm_op op)
-{
-	if (hba->vops && hba->vops->resume)
-		return hba->vops->resume(hba, op);
-
-	return 0;
-}
-
-static inline void ufshcd_vops_dbg_register_dump(struct ufs_hba *hba)
-{
-	if (hba->vops && hba->vops->dbg_register_dump)
-		hba->vops->dbg_register_dump(hba);
-}
-
-static inline int ufshcd_vops_device_reset(struct ufs_hba *hba)
-{
-	if (hba->vops && hba->vops->device_reset)
-		return hba->vops->device_reset(hba);
-
-	return -EOPNOTSUPP;
-}
-
-static inline void ufshcd_vops_config_scaling_param(struct ufs_hba *hba,
-		struct devfreq_dev_profile *p,
-		struct devfreq_simple_ondemand_data *data)
-{
-	if (hba->vops && hba->vops->config_scaling_param)
-		hba->vops->config_scaling_param(hba, p, data);
-}
-
 extern struct ufs_pm_lvl_states ufs_pm_lvl_states[];
 
-/**
- * ufshcd_scsi_to_upiu_lun - maps scsi LUN to UPIU LUN
- * @scsi_lun: scsi LUN id
- *
- * Returns UPIU LUN id
- */
-static inline u8 ufshcd_scsi_to_upiu_lun(unsigned int scsi_lun)
-{
-	if (scsi_is_wlun(scsi_lun))
-		return (scsi_lun & UFS_UPIU_MAX_UNIT_NUM_ID)
-			| UFS_UPIU_WLUN_ID;
-	else
-		return scsi_lun & UFS_UPIU_MAX_UNIT_NUM_ID;
-}
-
 int ufshcd_dump_regs(struct ufs_hba *hba, size_t offset, size_t len,
 		     const char *prefix);
 
@@ -1412,43 +1229,4 @@ int ufshcd_write_ee_control(struct ufs_hba *hba);
 int ufshcd_update_ee_control(struct ufs_hba *hba, u16 *mask, u16 *other_mask,
 			     u16 set, u16 clr);
 
-static inline int ufshcd_update_ee_drv_mask(struct ufs_hba *hba,
-					    u16 set, u16 clr)
-{
-	return ufshcd_update_ee_control(hba, &hba->ee_drv_mask,
-					&hba->ee_usr_mask, set, clr);
-}
-
-static inline int ufshcd_update_ee_usr_mask(struct ufs_hba *hba,
-					    u16 set, u16 clr)
-{
-	return ufshcd_update_ee_control(hba, &hba->ee_usr_mask,
-					&hba->ee_drv_mask, set, clr);
-}
-
-static inline int ufshcd_rpm_get_sync(struct ufs_hba *hba)
-{
-	return pm_runtime_get_sync(&hba->ufs_device_wlun->sdev_gendev);
-}
-
-static inline int ufshcd_rpm_put_sync(struct ufs_hba *hba)
-{
-	return pm_runtime_put_sync(&hba->ufs_device_wlun->sdev_gendev);
-}
-
-static inline void ufshcd_rpm_get_noresume(struct ufs_hba *hba)
-{
-	pm_runtime_get_noresume(&hba->ufs_device_wlun->sdev_gendev);
-}
-
-static inline int ufshcd_rpm_resume(struct ufs_hba *hba)
-{
-	return pm_runtime_resume(&hba->ufs_device_wlun->sdev_gendev);
-}
-
-static inline int ufshcd_rpm_put(struct ufs_hba *hba)
-{
-	return pm_runtime_put(&hba->ufs_device_wlun->sdev_gendev);
-}
-
 #endif /* End of Header */
diff --git a/drivers/scsi/ufs/ufshpb.c b/drivers/scsi/ufs/ufshpb.c
index 5a974642779f..5fae0861b488 100644
--- a/drivers/scsi/ufs/ufshpb.c
+++ b/drivers/scsi/ufs/ufshpb.c
@@ -15,7 +15,7 @@
 #include <linux/module.h>
 #include <scsi/scsi_cmnd.h>
 
-#include "ufshcd.h"
+#include "ufshcd-priv.h"
 #include "ufshpb.h"
 #include "../sd.h"
 
