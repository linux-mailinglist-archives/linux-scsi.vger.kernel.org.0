Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 633A02ECAEE
	for <lists+linux-scsi@lfdr.de>; Thu,  7 Jan 2021 08:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbhAGH0U (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 7 Jan 2021 02:26:20 -0500
Received: from mga12.intel.com ([192.55.52.136]:48161 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbhAGH0U (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 7 Jan 2021 02:26:20 -0500
IronPort-SDR: 8wz9BQ4i0aEDm6d7RKU7wM0Rp0GkEbh9p5menuIJd3w4Vp1RgAYHhz4FMUZQD8BEPrnYoLuv85
 Uai/fgTAIjOA==
X-IronPort-AV: E=McAfee;i="6000,8403,9856"; a="156575780"
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; 
   d="scan'208";a="156575780"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2021 23:25:39 -0800
IronPort-SDR: t7jisXiJQVcm7lfRJ+iXscjEnXOxas+t7Ul5ykMJJ4FUCBhvKVt2HipNuvADULBwxbonkMxGsZ
 uvZZmOUxDhHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; 
   d="scan'208";a="462946934"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.149])
  by fmsmga001.fm.intel.com with ESMTP; 06 Jan 2021 23:25:37 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <huobean@gmail.com>, Can Guo <cang@codeaurora.org>,
        Stanley Chu <stanley.chu@mediatek.com>
Subject: [PATCH V4] scsi: ufs-debugfs: Add error counters
Date:   Thu,  7 Jan 2021 09:25:38 +0200
Message-Id: <20210107072538.21782-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

People testing have a need to know how many errors might be occurring
over time. Add error counters and expose them via debugfs.

A module initcall is used to create a debugfs root directory for
ufshcd-related items. In the case that modules are built-in, then
initialization is done in link order, so move ufshcd-core to the top of
the Makefile.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
Reviewed-by: Bean Huo <beanhuo@micron.com>
---


Changes in V4:
	Added Reviewed-by: Bean Huo <beanhuo@micron.com>

Changes in V3:
	Fixed link order to ensure correct initcall ordering when
	modules are built-in.
	Amended commit message accordingly.

Changes in V2:
	Add missing '#include "ufs-debugfs.h"' in ufs-debugfs.c
	Reported-by: kernel test robot <lkp@intel.com>


 drivers/scsi/ufs/Makefile      | 13 +++++---
 drivers/scsi/ufs/ufs-debugfs.c | 56 ++++++++++++++++++++++++++++++++++
 drivers/scsi/ufs/ufs-debugfs.h | 22 +++++++++++++
 drivers/scsi/ufs/ufshcd.c      | 19 ++++++++++++
 drivers/scsi/ufs/ufshcd.h      |  5 +++
 5 files changed, 111 insertions(+), 4 deletions(-)
 create mode 100644 drivers/scsi/ufs/ufs-debugfs.c
 create mode 100644 drivers/scsi/ufs/ufs-debugfs.h

diff --git a/drivers/scsi/ufs/Makefile b/drivers/scsi/ufs/Makefile
index 4679af1b564e..06f3a3fe4a44 100644
--- a/drivers/scsi/ufs/Makefile
+++ b/drivers/scsi/ufs/Makefile
@@ -1,5 +1,14 @@
 # SPDX-License-Identifier: GPL-2.0
 # UFSHCD makefile
+
+# The link order is important here. ufshcd-core must initialize
+# before vendor drivers.
+obj-$(CONFIG_SCSI_UFSHCD)		+= ufshcd-core.o
+ufshcd-core-y				+= ufshcd.o ufs-sysfs.o
+ufshcd-core-$(CONFIG_DEBUG_FS)		+= ufs-debugfs.o
+ufshcd-core-$(CONFIG_SCSI_UFS_BSG)	+= ufs_bsg.o
+ufshcd-core-$(CONFIG_SCSI_UFS_CRYPTO)	+= ufshcd-crypto.o
+
 obj-$(CONFIG_SCSI_UFS_DWC_TC_PCI) += tc-dwc-g210-pci.o ufshcd-dwc.o tc-dwc-g210.o
 obj-$(CONFIG_SCSI_UFS_DWC_TC_PLATFORM) += tc-dwc-g210-pltfrm.o ufshcd-dwc.o tc-dwc-g210.o
 obj-$(CONFIG_SCSI_UFS_CDNS_PLATFORM) += cdns-pltfrm.o
@@ -7,10 +16,6 @@ obj-$(CONFIG_SCSI_UFS_QCOM) += ufs_qcom.o
 ufs_qcom-y += ufs-qcom.o
 ufs_qcom-$(CONFIG_SCSI_UFS_CRYPTO) += ufs-qcom-ice.o
 obj-$(CONFIG_SCSI_UFS_EXYNOS) += ufs-exynos.o
-obj-$(CONFIG_SCSI_UFSHCD) += ufshcd-core.o
-ufshcd-core-y				+= ufshcd.o ufs-sysfs.o
-ufshcd-core-$(CONFIG_SCSI_UFS_BSG)	+= ufs_bsg.o
-ufshcd-core-$(CONFIG_SCSI_UFS_CRYPTO) += ufshcd-crypto.o
 obj-$(CONFIG_SCSI_UFSHCD_PCI) += ufshcd-pci.o
 obj-$(CONFIG_SCSI_UFSHCD_PLATFORM) += ufshcd-pltfrm.o
 obj-$(CONFIG_SCSI_UFS_HISI) += ufs-hisi.o
diff --git a/drivers/scsi/ufs/ufs-debugfs.c b/drivers/scsi/ufs/ufs-debugfs.c
new file mode 100644
index 000000000000..dee98dc72d29
--- /dev/null
+++ b/drivers/scsi/ufs/ufs-debugfs.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2020 Intel Corporation
+
+#include <linux/debugfs.h>
+
+#include "ufs-debugfs.h"
+#include "ufshcd.h"
+
+static struct dentry *ufs_debugfs_root;
+
+void __init ufs_debugfs_init(void)
+{
+	ufs_debugfs_root = debugfs_create_dir("ufshcd", NULL);
+}
+
+void __exit ufs_debugfs_exit(void)
+{
+	debugfs_remove_recursive(ufs_debugfs_root);
+}
+
+static int ufs_debugfs_stats_show(struct seq_file *s, void *data)
+{
+	struct ufs_hba *hba = s->private;
+	struct ufs_event_hist *e = hba->ufs_stats.event;
+
+#define PRT(fmt, typ) \
+	seq_printf(s, fmt, e[UFS_EVT_ ## typ].cnt)
+
+	PRT("PHY Adapter Layer errors (except LINERESET): %llu\n", PA_ERR);
+	PRT("Data Link Layer errors: %llu\n", DL_ERR);
+	PRT("Network Layer errors: %llu\n", NL_ERR);
+	PRT("Transport Layer errors: %llu\n", TL_ERR);
+	PRT("Generic DME errors: %llu\n", DME_ERR);
+	PRT("Auto-hibernate errors: %llu\n", AUTO_HIBERN8_ERR);
+	PRT("IS Fatal errors (CEFES, SBFES, HCFES, DFES): %llu\n", FATAL_ERR);
+	PRT("DME Link Startup errors: %llu\n", LINK_STARTUP_FAIL);
+	PRT("PM Resume errors: %llu\n", RESUME_ERR);
+	PRT("PM Suspend errors : %llu\n", SUSPEND_ERR);
+	PRT("Logical Unit Resets: %llu\n", DEV_RESET);
+	PRT("Host Resets: %llu\n", HOST_RESET);
+	PRT("SCSI command aborts: %llu\n", ABORT);
+#undef PRT
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(ufs_debugfs_stats);
+
+void ufs_debugfs_hba_init(struct ufs_hba *hba)
+{
+	hba->debugfs_root = debugfs_create_dir(dev_name(hba->dev), ufs_debugfs_root);
+	debugfs_create_file("stats", 0400, hba->debugfs_root, hba, &ufs_debugfs_stats_fops);
+}
+
+void ufs_debugfs_hba_exit(struct ufs_hba *hba)
+{
+	debugfs_remove_recursive(hba->debugfs_root);
+}
diff --git a/drivers/scsi/ufs/ufs-debugfs.h b/drivers/scsi/ufs/ufs-debugfs.h
new file mode 100644
index 000000000000..f35b39c4b4f5
--- /dev/null
+++ b/drivers/scsi/ufs/ufs-debugfs.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2020 Intel Corporation
+ */
+
+#ifndef __UFS_DEBUGFS_H__
+#define __UFS_DEBUGFS_H__
+
+struct ufs_hba;
+
+#ifdef CONFIG_DEBUG_FS
+void __init ufs_debugfs_init(void);
+void __exit ufs_debugfs_exit(void);
+void ufs_debugfs_hba_init(struct ufs_hba *hba);
+void ufs_debugfs_hba_exit(struct ufs_hba *hba);
+#else
+static inline void ufs_debugfs_init(void) {}
+static inline void ufs_debugfs_exit(void) {}
+static inline void ufs_debugfs_hba_init(struct ufs_hba *hba) {}
+static inline void ufs_debugfs_hba_exit(struct ufs_hba *hba) {}
+#endif
+
+#endif
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index bedb822a40a3..47ea0afa3a35 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -20,6 +20,7 @@
 #include "ufs_quirks.h"
 #include "unipro.h"
 #include "ufs-sysfs.h"
+#include "ufs-debugfs.h"
 #include "ufs_bsg.h"
 #include "ufshcd-crypto.h"
 #include <asm/unaligned.h>
@@ -4543,6 +4544,7 @@ void ufshcd_update_evt_hist(struct ufs_hba *hba, u32 id, u32 val)
 	e = &hba->ufs_stats.event[id];
 	e->val[e->pos] = val;
 	e->tstamp[e->pos] = ktime_get();
+	e->cnt += 1;
 	e->pos = (e->pos + 1) % UFS_EVENT_HIST_LENGTH;
 
 	ufshcd_vops_event_notify(hba, id, &val);
@@ -8331,6 +8333,8 @@ static int ufshcd_hba_init(struct ufs_hba *hba)
 	if (err)
 		goto out_disable_vreg;
 
+	ufs_debugfs_hba_init(hba);
+
 	hba->is_powered = true;
 	goto out;
 
@@ -8347,6 +8351,7 @@ static int ufshcd_hba_init(struct ufs_hba *hba)
 static void ufshcd_hba_exit(struct ufs_hba *hba)
 {
 	if (hba->is_powered) {
+		ufs_debugfs_hba_exit(hba);
 		ufshcd_variant_hba_exit(hba);
 		ufshcd_setup_vreg(hba, false);
 		ufshcd_suspend_clkscaling(hba);
@@ -9434,6 +9439,20 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 }
 EXPORT_SYMBOL_GPL(ufshcd_init);
 
+static int __init ufshcd_core_init(void)
+{
+	ufs_debugfs_init();
+	return 0;
+}
+
+static void __exit ufshcd_core_exit(void)
+{
+	ufs_debugfs_exit();
+}
+
+module_init(ufshcd_core_init);
+module_exit(ufshcd_core_exit);
+
 MODULE_AUTHOR("Santosh Yaragnavi <santosh.sy@samsung.com>");
 MODULE_AUTHOR("Vinayak Holikatti <h.vinayak@samsung.com>");
 MODULE_DESCRIPTION("Generic UFS host controller driver Core");
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 85f9d0fbfbd9..3f7db69ebc82 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -445,11 +445,13 @@ struct ufs_clk_scaling {
  * @pos: index to indicate cyclic buffer position
  * @reg: cyclic buffer for registers value
  * @tstamp: cyclic buffer for time stamp
+ * @cnt: error counter
  */
 struct ufs_event_hist {
 	int pos;
 	u32 val[UFS_EVENT_HIST_LENGTH];
 	ktime_t tstamp[UFS_EVENT_HIST_LENGTH];
+	unsigned long long cnt;
 };
 
 /**
@@ -823,6 +825,9 @@ struct ufs_hba {
 	u32 crypto_cfg_register;
 	struct blk_keyslot_manager ksm;
 #endif
+#ifdef CONFIG_DEBUG_FS
+	struct dentry *debugfs_root;
+#endif
 };
 
 /* Returns true if clocks can be gated. Otherwise false */
-- 
2.17.1

