Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9BBE213023
	for <lists+linux-scsi@lfdr.de>; Fri,  3 Jul 2020 01:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbgGBXaK (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 2 Jul 2020 19:30:10 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:39030 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgGBXaJ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 2 Jul 2020 19:30:09 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200702233002epoutp04779058006b899545a10bd021a7955e67~eE1uoegAt1127611276epoutp04h
        for <linux-scsi@vger.kernel.org>; Thu,  2 Jul 2020 23:30:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200702233002epoutp04779058006b899545a10bd021a7955e67~eE1uoegAt1127611276epoutp04h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593732602;
        bh=EHpDiIKVdT2cwf7uxW6lRw4mxuAO6LVZpc2j10q9ZZ0=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=aw4n2LeTGpWkrhlA8lvt8pso8PMoeYGxRak314SyX3sQ/e7z5Yq92ni8dqILeWXFY
         5cwCYDig3BSJ9h9UHzOdIfCc/HOQkKe0AJ/LB7nlPmptti8pIJPrbfXHXsCRbPfo+U
         pc1/EfUkTJOaHuruTJIdsFOA/vpV/35Uowgysl1I=
Received: from epcpadp1 (unknown [182.195.40.11]) by epcas1p2.samsung.com
        (KnoxPortal) with ESMTP id
        20200702233002epcas1p2b616e1b27867c71328d5ca892ddfb5fa~eE1uOoHDF2788627886epcas1p2I;
        Thu,  2 Jul 2020 23:30:02 +0000 (GMT)
Mime-Version: 1.0
Subject: [PATCH v5 3/5] scsi: ufs: Introduce HPB module
Reply-To: daejun7.park@samsung.com
From:   Daejun Park <daejun7.park@samsung.com>
To:     Daejun Park <daejun7.park@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "tomas.winkler@intel.com" <tomas.winkler@intel.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        ALIM AKHTAR <alim.akhtar@samsung.com>,
        Sang-yoon Oh <sangyoon.oh@samsung.com>,
        Sung-Jun Park <sungjun07.park@samsung.com>,
        yongmyung lee <ymhungry.lee@samsung.com>,
        Jinyoung CHOI <j-young.choi@samsung.com>,
        Adel Choi <adel.choi@samsung.com>,
        BoRam Shin <boram.shin@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <231786897.01593732481555.JavaMail.epsvc@epcpadp2>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <231786897.01593732602076.JavaMail.epsvc@epcpadp1>
Date:   Fri, 03 Jul 2020 08:28:40 +0900
X-CMS-MailID: 20200702232840epcms2p6c331a710fe434f11a20b56b4e694bd77
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20200702231936epcms2p81557f83504ef1c1e81bfc81a0143a5b4
References: <231786897.01593732481555.JavaMail.epsvc@epcpadp2>
        <231786897.01593732302018.JavaMail.epsvc@epcpadp1>
        <963815509.21593732182531.JavaMail.epsvc@epcpadp2>
        <CGME20200702231936epcms2p81557f83504ef1c1e81bfc81a0143a5b4@epcms2p6>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This is a patch for the HPB module.
The HPB module queries UFS for device information during initialization.
We added the export symbol to two functions in ufshcd.c to initialize
the HPB module.

The HPB module can be loaded or built-in as needed.
The mininum size of the memory pool used in the HPB module is implemented
as a module parameter, so that it can be configurable by the user.

To gurantee a minimum memory pool size of 4MB:
$ insmod ufshpb.ko ufshpb_host_map_kbytes=4096

Signed-off-by: Daejun Park <daejun7.park@samsung.com>
---
 drivers/scsi/ufs/Kconfig  |   9 +
 drivers/scsi/ufs/Makefile |   1 +
 drivers/scsi/ufs/ufshcd.c |   2 +
 drivers/scsi/ufs/ufshpb.c | 778 ++++++++++++++++++++++++++++++++++++++
 drivers/scsi/ufs/ufshpb.h | 160 ++++++++
 5 files changed, 950 insertions(+)
 create mode 100644 drivers/scsi/ufs/ufshpb.c
 create mode 100644 drivers/scsi/ufs/ufshpb.h

diff --git a/drivers/scsi/ufs/Kconfig b/drivers/scsi/ufs/Kconfig
index 3188a50dfb51..5e480b2cea12 100644
--- a/drivers/scsi/ufs/Kconfig
+++ b/drivers/scsi/ufs/Kconfig
@@ -172,3 +172,12 @@ config SCSI_UFS_EXYNOS
 
 	  Select this if you have UFS host controller on EXYNOS chipset.
 	  If unsure, say N.
+
+config UFSHPB
+        tristate "Support UFS Host Performance Booster"
+        depends on SCSI_UFSHCD
+	help
+          A UFS HPB Feature improves random read performance. It caches
+          L2P map of UFS to host DRAM. The driver uses HPB read command
+          by piggybacking physical page number for bypassing FTL's L2P address
+          translation.
diff --git a/drivers/scsi/ufs/Makefile b/drivers/scsi/ufs/Makefile
index 433b871badfa..aa901b92e9e7 100644
--- a/drivers/scsi/ufs/Makefile
+++ b/drivers/scsi/ufs/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_SCSI_UFS_EXYNOS) += ufs-exynos.o
 obj-$(CONFIG_SCSI_UFSHCD) += ufshcd-core.o
 ufshcd-core-y				+= ufshcd.o ufs-sysfs.o ufsfeature.o
 ufshcd-core-$(CONFIG_SCSI_UFS_BSG)	+= ufs_bsg.o
+obj-$(CONFIG_UFSHPB) += ufshpb.o
 obj-$(CONFIG_SCSI_UFSHCD_PCI) += ufshcd-pci.o
 obj-$(CONFIG_SCSI_UFSHCD_PLATFORM) += ufshcd-pltfrm.o
 obj-$(CONFIG_SCSI_UFS_HISI) += ufs-hisi.o
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index d02106bf80d8..367fb36e579a 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -2863,6 +2863,7 @@ int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
 	ufshcd_release(hba);
 	return err;
 }
+EXPORT_SYMBOL(ufshcd_query_flag);
 
 /**
  * ufshcd_query_attr - API function for sending attribute requests
@@ -3061,6 +3062,7 @@ int ufshcd_query_descriptor_retry(struct ufs_hba *hba,
 
 	return err;
 }
+EXPORT_SYMBOL(ufshcd_query_descriptor_retry);
 
 /**
  * ufshcd_map_desc_id_to_length - map descriptor IDN to its length
diff --git a/drivers/scsi/ufs/ufshpb.c b/drivers/scsi/ufs/ufshpb.c
new file mode 100644
index 000000000000..c63955a457b1
--- /dev/null
+++ b/drivers/scsi/ufs/ufshpb.c
@@ -0,0 +1,778 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Universal Flash Storage Host Performance Booster
+ *
+ * Copyright (C) 2017-2018 Samsung Electronics Co., Ltd.
+ *
+ * Authors:
+ *	Yongmyung Lee <ymhungry.lee@samsung.com>
+ *	Jinyoung Choi <j-young.choi@samsung.com>
+ */
+
+#include <asm/unaligned.h>
+
+#include "ufshcd.h"
+#include "ufshpb.h"
+
+static struct ufshpb_driver ufshpb_drv;
+unsigned int ufshpb_host_map_kbytes = 1 * 1024;
+
+static int ufshpb_create_sysfs(struct ufs_hba *hba, struct ufshpb_lu *hpb);
+
+static inline int ufshpb_is_valid_srgn(struct ufshpb_region *rgn,
+			     struct ufshpb_subregion *srgn)
+{
+	return rgn->rgn_state != HPB_RGN_INACTIVE &&
+		srgn->srgn_state == HPB_SRGN_VALID;
+}
+
+static inline int ufshpb_get_state(struct ufshpb_lu *hpb)
+{
+	return atomic_read(&hpb->hpb_state);
+}
+
+static inline void ufshpb_set_state(struct ufshpb_lu *hpb, int state)
+{
+	atomic_set(&hpb->hpb_state, state);
+}
+
+static inline int ufshpb_lu_get_dev(struct ufshpb_lu *hpb)
+{
+	if (get_device(&hpb->hpb_lu_dev))
+		return 0;
+
+	return -ENODEV;
+}
+
+static inline int ufshpb_lu_get(struct ufshpb_lu *hpb)
+{
+	if (!hpb || (ufshpb_get_state(hpb) != HPB_PRESENT))
+		return -ENODEV;
+
+	if (ufshpb_lu_get_dev(hpb))
+		return -ENODEV;
+
+	return 0;
+}
+
+static inline void ufshpb_lu_put(struct ufshpb_lu *hpb)
+{
+	put_device(&hpb->hpb_lu_dev);
+}
+
+static void ufshpb_init_subregion_tbl(struct ufshpb_lu *hpb,
+				      struct ufshpb_region *rgn)
+{
+	int srgn_idx;
+
+	for (srgn_idx = 0; srgn_idx < rgn->srgn_cnt; srgn_idx++) {
+		struct ufshpb_subregion *srgn = rgn->srgn_tbl + srgn_idx;
+
+		srgn->rgn_idx = rgn->rgn_idx;
+		srgn->srgn_idx = srgn_idx;
+		srgn->srgn_state = HPB_SRGN_UNUSED;
+	}
+}
+
+static inline int ufshpb_alloc_subregion_tbl(struct ufshpb_lu *hpb,
+					     struct ufshpb_region *rgn,
+					     int srgn_cnt)
+{
+	rgn->srgn_tbl = kvcalloc(srgn_cnt, sizeof(struct ufshpb_subregion),
+				 GFP_KERNEL);
+	if (!rgn->srgn_tbl)
+		return -ENOMEM;
+
+	rgn->srgn_cnt = srgn_cnt;
+	return 0;
+}
+
+static void ufshpb_init_lu_parameter(struct ufs_hba *hba,
+				     struct ufshpb_lu *hpb,
+				     struct ufshpb_dev_info *hpb_dev_info,
+				     struct ufshpb_lu_info *hpb_lu_info)
+{
+	u32 entries_per_rgn;
+	u64 rgn_mem_size;
+
+
+	hpb->lu_pinned_start = hpb_lu_info->pinned_start;
+	hpb->lu_pinned_end = hpb_lu_info->num_pinned ?
+		(hpb_lu_info->pinned_start + hpb_lu_info->num_pinned - 1)
+		: PINNED_NOT_SET;
+
+	rgn_mem_size = (1ULL << hpb_dev_info->rgn_size) * HPB_RGN_SIZE_UNIT
+		/ HPB_ENTRY_BLOCK_SIZE * HPB_ENTRY_SIZE;
+	hpb->srgn_mem_size = (1ULL << hpb_dev_info->srgn_size)
+		* HPB_RGN_SIZE_UNIT / HPB_ENTRY_BLOCK_SIZE * HPB_ENTRY_SIZE;
+
+	entries_per_rgn = rgn_mem_size / HPB_ENTRY_SIZE;
+	hpb->entries_per_rgn_shift = ilog2(entries_per_rgn);
+	hpb->entries_per_rgn_mask = entries_per_rgn - 1;
+
+	hpb->entries_per_srgn = hpb->srgn_mem_size /  HPB_ENTRY_SIZE;
+	hpb->entries_per_srgn_shift = ilog2(hpb->entries_per_srgn);
+	hpb->entries_per_srgn_mask = hpb->entries_per_srgn - 1;
+
+	hpb->srgns_per_rgn = rgn_mem_size / hpb->srgn_mem_size;
+
+	hpb->rgns_per_lu = DIV_ROUND_UP(hpb_lu_info->num_blocks,
+				(rgn_mem_size / HPB_ENTRY_SIZE));
+	hpb->srgns_per_lu = DIV_ROUND_UP(hpb_lu_info->num_blocks,
+				(hpb->srgn_mem_size / HPB_ENTRY_SIZE));
+
+	hpb->pages_per_srgn = hpb->srgn_mem_size / PAGE_SIZE;
+
+	dev_info(hba->dev, "ufshpb(%d): region memory size - %llu (bytes)\n",
+		 hpb->lun, rgn_mem_size);
+	dev_info(hba->dev, "ufshpb(%d): subregion memory size - %u (bytes)\n",
+		 hpb->lun, hpb->srgn_mem_size);
+	dev_info(hba->dev, "ufshpb(%d): total blocks per lu - %d\n",
+		 hpb->lun, hpb_lu_info->num_blocks);
+	dev_info(hba->dev, "ufshpb(%d): subregions per region - %d, regions per lu - %u",
+		 hpb->lun, hpb->srgns_per_rgn, hpb->rgns_per_lu);
+}
+
+
+static int ufshpb_alloc_region_tbl(struct ufs_hba *hba, struct ufshpb_lu *hpb)
+{
+	struct ufshpb_region *rgn_table, *rgn;
+	int rgn_idx, i;
+	int ret = 0;
+
+	rgn_table = kvcalloc(hpb->rgns_per_lu, sizeof(struct ufshpb_region),
+			    GFP_KERNEL);
+	if (!rgn_table)
+		return -ENOMEM;
+
+	hpb->rgn_tbl = rgn_table;
+
+	for (rgn_idx = 0; rgn_idx < hpb->rgns_per_lu; rgn_idx++) {
+		int srgn_cnt = hpb->srgns_per_rgn;
+
+		rgn = rgn_table + rgn_idx;
+		rgn->rgn_idx = rgn_idx;
+
+		if (rgn_idx == hpb->rgns_per_lu - 1)
+			srgn_cnt = ((hpb->srgns_per_lu - 1) %
+				    hpb->srgns_per_rgn) + 1;
+
+		ret = ufshpb_alloc_subregion_tbl(hpb, rgn, srgn_cnt);
+		if (ret)
+			goto release_srgn_table;
+		ufshpb_init_subregion_tbl(hpb, rgn);
+
+		rgn->rgn_state = HPB_RGN_INACTIVE;
+	}
+
+	return 0;
+
+release_srgn_table:
+	for (i = 0; i < rgn_idx; i++) {
+		rgn = rgn_table + i;
+		if (rgn->srgn_tbl)
+			kvfree(rgn->srgn_tbl);
+	}
+	kvfree(rgn_table);
+	return ret;
+}
+
+static void ufshpb_destroy_subregion_tbl(struct ufshpb_lu *hpb,
+					 struct ufshpb_region *rgn)
+{
+	int srgn_idx;
+
+	for (srgn_idx = 0; srgn_idx < rgn->srgn_cnt; srgn_idx++) {
+		struct ufshpb_subregion *srgn;
+
+		srgn = rgn->srgn_tbl + srgn_idx;
+		srgn->srgn_state = HPB_SRGN_UNUSED;
+	}
+}
+
+static void ufshpb_destroy_region_tbl(struct ufshpb_lu *hpb)
+{
+	int rgn_idx;
+
+	for (rgn_idx = 0; rgn_idx < hpb->rgns_per_lu; rgn_idx++) {
+		struct ufshpb_region *rgn;
+
+		rgn = hpb->rgn_tbl + rgn_idx;
+		if (rgn->rgn_state != HPB_RGN_INACTIVE) {
+			rgn->rgn_state = HPB_RGN_INACTIVE;
+
+			ufshpb_destroy_subregion_tbl(hpb, rgn);
+		}
+
+		kvfree(rgn->srgn_tbl);
+	}
+
+	kvfree(hpb->rgn_tbl);
+}
+
+static int ufshpb_lu_hpb_init(struct ufs_hba *hba, struct ufshpb_lu *hpb,
+			      struct ufshpb_dev_info *hpb_dev_info)
+{
+	int ret;
+
+	spin_lock_init(&hpb->hpb_state_lock);
+
+	ret = ufshpb_alloc_region_tbl(hba, hpb);
+
+	ret = ufshpb_create_sysfs(hba, hpb);
+	if (ret)
+		goto release_rgn_table;
+
+	return 0;
+
+release_rgn_table:
+	ufshpb_destroy_region_tbl(hpb);
+	return ret;
+}
+
+static struct ufshpb_lu *ufshpb_alloc_hpb_lu(struct ufs_hba *hba, int lun,
+				     struct ufshpb_dev_info *hpb_dev_info,
+				     struct ufshpb_lu_info *hpb_lu_info)
+{
+	struct ufshpb_lu *hpb;
+	int ret;
+
+	hpb = kzalloc(sizeof(struct ufshpb_lu), GFP_KERNEL);
+	if (!hpb)
+		return NULL;
+
+	hpb->ufsf = &hba->ufsf;
+	hpb->lun = lun;
+
+	ufshpb_init_lu_parameter(hba, hpb, hpb_dev_info, hpb_lu_info);
+
+	ret = ufshpb_lu_hpb_init(hba, hpb, hpb_dev_info);
+	if (ret) {
+		dev_err(hba->dev, "hpb lu init failed. ret %d", ret);
+		goto release_hpb;
+	}
+
+	return hpb;
+release_hpb:
+	kfree(hpb);
+	return NULL;
+}
+
+static void ufshpb_lu_release(struct ufshpb_lu *hpb)
+{
+	ufshpb_destroy_region_tbl(hpb);
+
+	list_del_init(&hpb->list_hpb_lu);
+}
+
+static void ufshpb_issue_hpb_reset_query(struct ufs_hba *hba)
+{
+	int err;
+	int retries;
+
+	for (retries = 0; retries < HPB_RESET_REQ_RETRIES; retries++) {
+		err = ufshcd_query_flag(hba, UPIU_QUERY_OPCODE_SET_FLAG,
+				QUERY_FLAG_IDN_HPB_RESET, 0, NULL);
+		if (err)
+			dev_dbg(hba->dev,
+				"%s: failed with error %d, retries %d\n",
+				__func__, err, retries);
+		else
+			break;
+	}
+
+	if (err) {
+		dev_err(hba->dev,
+			"%s setting fHpbReset flag failed with error %d\n",
+			__func__, err);
+		return;
+	}
+}
+
+static void ufshpb_check_hpb_reset_query(struct ufs_hba *hba)
+{
+	int err;
+	bool flag_res = true;
+	int try = 0;
+
+	/* wait for the device to complete HPB reset query */
+	do {
+		if (++try == HPB_RESET_REQ_RETRIES)
+			break;
+
+		dev_info(hba->dev,
+			"%s start flag reset polling %d times\n",
+			__func__, try);
+
+		/* Poll fHpbReset flag to be cleared */
+		err = ufshcd_query_flag(hba, UPIU_QUERY_OPCODE_READ_FLAG,
+				QUERY_FLAG_IDN_HPB_RESET, 0, &flag_res);
+		usleep_range(1000, 1100);
+	} while (flag_res);
+
+	if (err) {
+		dev_err(hba->dev,
+			"%s reading fHpbReset flag failed with error %d\n",
+			__func__, err);
+		return;
+	}
+
+	if (flag_res) {
+		dev_err(hba->dev,
+			"%s fHpbReset was not cleared by the device\n",
+			__func__);
+	}
+}
+
+static void ufshpb_reset(struct ufs_hba *hba)
+{
+	struct ufshpb_lu *hpb;
+
+	list_for_each_entry(hpb, &ufshpb_drv.lh_hpb_lu, list_hpb_lu) {
+		if (ufshpb_lu_get_dev(hpb))
+			continue;
+
+		ufshpb_set_state(hpb, HPB_PRESENT);
+		ufshpb_lu_put(hpb);
+	}
+}
+
+static void ufshpb_reset_host(struct ufs_hba *hba)
+{
+	struct ufshpb_lu *hpb;
+
+	list_for_each_entry(hpb, &ufshpb_drv.lh_hpb_lu, list_hpb_lu) {
+		if (ufshpb_lu_get(hpb))
+			continue;
+
+		dev_info(&hpb->hpb_lu_dev, "ufshpb run reset_host");
+
+		ufshpb_set_state(hpb, HPB_RESET);
+		ufshpb_lu_put(hpb);
+	}
+}
+
+static void ufshpb_suspend(struct ufs_hba *hba)
+{
+	struct ufshpb_lu *hpb;
+
+	list_for_each_entry(hpb, &ufshpb_drv.lh_hpb_lu, list_hpb_lu) {
+		if (ufshpb_lu_get(hpb))
+			continue;
+
+		dev_info(&hpb->hpb_lu_dev, "ufshpb goto suspend");
+		ufshpb_set_state(hpb, HPB_SUSPEND);
+
+		ufshpb_lu_put(hpb);
+	}
+}
+
+static void ufshpb_resume(struct ufs_hba *hba)
+{
+	struct ufshpb_lu *hpb;
+
+	list_for_each_entry(hpb, &ufshpb_drv.lh_hpb_lu, list_hpb_lu) {
+		if (ufshpb_lu_get_dev(hpb))
+			continue;
+
+		dev_info(&hpb->hpb_lu_dev, "ufshpb resume");
+		ufshpb_set_state(hpb, HPB_PRESENT);
+		ufshpb_lu_put(hpb);
+	}
+}
+
+static void ufshpb_stat_init(struct ufshpb_lu *hpb)
+{
+	atomic_set(&hpb->stats.hit_cnt, 0);
+	atomic_set(&hpb->stats.miss_cnt, 0);
+	atomic_set(&hpb->stats.rb_noti_cnt, 0);
+	atomic_set(&hpb->stats.rb_active_cnt, 0);
+	atomic_set(&hpb->stats.rb_inactive_cnt, 0);
+	atomic_set(&hpb->stats.map_req_cnt, 0);
+}
+
+/* SYSFS functions */
+#define ufshpb_sysfs_attr_show_func(__name)				\
+static ssize_t __name##_show(struct device *dev,		\
+					 struct device_attribute *attr,	\
+					 char *buf)			\
+{									\
+	struct ufshpb_lu *hpb;						\
+	hpb = container_of(dev, struct ufshpb_lu, hpb_lu_dev);		\
+	return snprintf(buf, PAGE_SIZE, "%d\n",			\
+			atomic_read(&hpb->stats.__name));		\
+}
+
+ufshpb_sysfs_attr_show_func(hit_cnt);
+ufshpb_sysfs_attr_show_func(miss_cnt);
+ufshpb_sysfs_attr_show_func(rb_noti_cnt);
+ufshpb_sysfs_attr_show_func(rb_active_cnt);
+ufshpb_sysfs_attr_show_func(rb_inactive_cnt);
+ufshpb_sysfs_attr_show_func(map_req_cnt);
+
+static DEVICE_ATTR_RO(hit_cnt);
+static DEVICE_ATTR_RO(miss_cnt);
+static DEVICE_ATTR_RO(rb_noti_cnt);
+static DEVICE_ATTR_RO(rb_active_cnt);
+static DEVICE_ATTR_RO(rb_inactive_cnt);
+static DEVICE_ATTR_RO(map_req_cnt);
+
+static struct attribute *hpb_dev_attrs[] = {
+	&dev_attr_hit_cnt.attr,
+	&dev_attr_miss_cnt.attr,
+	&dev_attr_rb_noti_cnt.attr,
+	&dev_attr_rb_active_cnt.attr,
+	&dev_attr_rb_inactive_cnt.attr,
+	&dev_attr_map_req_cnt.attr,
+	NULL,
+};
+
+static struct attribute_group ufshpb_sysfs_group = {
+	.attrs = hpb_dev_attrs,
+};
+
+static inline void ufshpb_dev_release(struct device *dev)
+{
+	struct ufs_hba *hba;
+	struct ufsf_feature_info *ufsf;
+	struct ufshpb_lu *hpb;
+
+	hpb = container_of(dev, struct ufshpb_lu, hpb_lu_dev);
+	ufsf = hpb->ufsf;
+	hba = container_of(ufsf, struct ufs_hba, ufsf);
+
+	ufshpb_lu_release(hpb);
+	dev_info(dev, "%s: release success\n", __func__);
+	put_device(dev->parent);
+
+	kfree(hpb);
+}
+
+static int ufshpb_create_sysfs(struct ufs_hba *hba, struct ufshpb_lu *hpb)
+{
+	int ret;
+
+	device_initialize(&hpb->hpb_lu_dev);
+
+	ufshpb_stat_init(hpb);
+
+	hpb->hpb_lu_dev.parent = get_device(&hba->ufsf.hpb_dev);
+	hpb->hpb_lu_dev.release = ufshpb_dev_release;
+	dev_set_name(&hpb->hpb_lu_dev, "ufshpb_lu%d", hpb->lun);
+
+	ret = device_add(&hpb->hpb_lu_dev);
+	if (ret) {
+		dev_err(hba->dev, "ufshpb(%d) device_add failed",
+			hpb->lun);
+		return -ENODEV;
+	}
+
+	if (device_add_group(&hpb->hpb_lu_dev, &ufshpb_sysfs_group))
+		dev_err(hba->dev, "ufshpb(%d) create file error\n",
+			hpb->lun);
+
+	return 0;
+}
+
+static int ufshpb_read_desc(struct ufs_hba *hba, u8 desc_id, u8 desc_index,
+			  u8 selector, u8 *desc_buf)
+{
+	int err = 0;
+	int size;
+
+	ufshcd_map_desc_id_to_length(hba, desc_id, &size);
+
+	pm_runtime_get_sync(hba->dev);
+
+	err = ufshcd_query_descriptor_retry(hba, UPIU_QUERY_OPCODE_READ_DESC,
+					    desc_id, desc_index,
+					    selector,
+					    desc_buf, &size);
+	if (err)
+		dev_err(hba->dev, "read desc failed: %d, id %d, idx %d\n",
+			err, desc_id, desc_index);
+
+	pm_runtime_put_sync(hba->dev);
+
+	return err;
+}
+
+static int ufshpb_get_geo_info(struct ufs_hba *hba, u8 *geo_buf,
+			       struct ufshpb_dev_info *hpb_dev_info)
+{
+	int hpb_device_max_active_rgns = 0;
+	int hpb_num_lu;
+
+	hpb_num_lu = geo_buf[GEOMETRY_DESC_HPB_NUMBER_LU];
+	if (hpb_num_lu == 0) {
+		dev_err(hba->dev, "No HPB LU supported\n");
+		return -ENODEV;
+	}
+
+	hpb_dev_info->rgn_size = geo_buf[GEOMETRY_DESC_HPB_REGION_SIZE];
+	hpb_dev_info->srgn_size = geo_buf[GEOMETRY_DESC_HPB_SUBREGION_SIZE];
+	hpb_device_max_active_rgns =
+		get_unaligned_be16(geo_buf +
+			GEOMETRY_DESC_HPB_DEVICE_MAX_ACTIVE_REGIONS);
+
+	if (hpb_dev_info->rgn_size == 0 || hpb_dev_info->srgn_size == 0 ||
+	    hpb_device_max_active_rgns == 0) {
+		dev_err(hba->dev, "No HPB supported device\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int ufshpb_get_dev_info(struct ufs_hba *hba,
+			       struct ufshpb_dev_info *hpb_dev_info,
+			       u8 *desc_buf)
+{
+	int ret;
+	int version;
+	u8 hpb_mode;
+
+	ret = ufshpb_read_desc(hba, QUERY_DESC_IDN_DEVICE, 0, 0, desc_buf);
+	if (ret) {
+		dev_err(hba->dev, "%s: idn: %d query request failed\n",
+			__func__, QUERY_DESC_IDN_DEVICE);
+		return -ENODEV;
+	}
+
+	hpb_mode = desc_buf[DEVICE_DESC_PARAM_HPB_CONTROL];
+	if (hpb_mode == HPB_HOST_CONTROL) {
+		dev_err(hba->dev, "%s: host control mode is not supported.\n",
+			__func__);
+		return -ENODEV;
+	}
+
+	version = get_unaligned_be16(desc_buf + DEVICE_DESC_PARAM_HPB_VER);
+	if (version != HPB_SUPPORT_VERSION) {
+		dev_err(hba->dev, "%s: HPB %x version is not supported.\n",
+			__func__, version);
+		return -ENODEV;
+	}
+
+	/*
+	 * Get the number of user logical unit to check whether all
+	 * scsi_device finish initialization
+	 */
+	hpb_dev_info->num_lu = desc_buf[DEVICE_DESC_PARAM_NUM_LU];
+
+	ret = ufshpb_read_desc(hba, QUERY_DESC_IDN_GEOMETRY, 0, 0, desc_buf);
+	if (ret) {
+		dev_err(hba->dev, "%s: idn: %d query request failed\n",
+			__func__, QUERY_DESC_IDN_DEVICE);
+		return ret;
+	}
+
+	ret = ufshpb_get_geo_info(hba, desc_buf, hpb_dev_info);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int ufshpb_get_lu_info(struct ufs_hba *hba, int lun,
+				    struct ufshpb_lu_info *hpb_lu_info,
+				    u8 *desc_buf)
+{
+	u16 max_active_rgns;
+	u8 lu_enable;
+	int ret;
+
+	ret = ufshpb_read_desc(hba, QUERY_DESC_IDN_UNIT, lun, 0, desc_buf);
+	if (ret) {
+		dev_err(hba->dev,
+			"%s: idn: %d lun: %d  query request failed",
+			__func__, QUERY_DESC_IDN_UNIT, lun);
+		return ret;
+	}
+
+	lu_enable = desc_buf[UNIT_DESC_PARAM_LU_ENABLE];
+	if (lu_enable != LU_ENABLED_HPB_FUNC)
+		return -ENODEV;
+
+	max_active_rgns = get_unaligned_be16(
+			desc_buf + UNIT_DESC_HPB_LU_MAX_ACTIVE_REGIONS);
+	if (!max_active_rgns) {
+		dev_err(hba->dev,
+			"lun %d wrong number of max active regions\n", lun);
+		return -ENODEV;
+	}
+
+	hpb_lu_info->num_blocks = get_unaligned_be64(
+			desc_buf + UNIT_DESC_PARAM_LOGICAL_BLK_COUNT);
+	hpb_lu_info->pinned_start = get_unaligned_be16(
+			desc_buf + UNIT_DESC_HPB_LU_PIN_REGION_START_OFFSET);
+	hpb_lu_info->num_pinned = get_unaligned_be16(
+			desc_buf + UNIT_DESC_HPB_LU_NUM_PIN_REGIONS);
+	hpb_lu_info->max_active_rgns = max_active_rgns;
+
+	return 0;
+}
+
+static void ufshpb_scan_hpb_lu(struct ufs_hba *hba,
+			       struct ufshpb_dev_info *hpb_dev_info,
+			       u8 *desc_buf)
+{
+	struct scsi_device *sdev;
+	struct ufshpb_lu *hpb;
+	int find_hpb_lu = 0;
+	int ret;
+
+	INIT_LIST_HEAD(&ufshpb_drv.lh_hpb_lu);
+
+	shost_for_each_device(sdev, hba->host) {
+		struct ufshpb_lu_info hpb_lu_info = { 0 };
+		int lun = sdev->lun;
+
+		if (lun >= hba->dev_info.max_lu_supported)
+			continue;
+
+		ret = ufshpb_get_lu_info(hba, lun, &hpb_lu_info, desc_buf);
+		if (ret)
+			continue;
+
+		hpb = ufshpb_alloc_hpb_lu(hba, lun, hpb_dev_info,
+					  &hpb_lu_info);
+		if (!hpb)
+			continue;
+
+		hpb->sdev_ufs_lu = sdev;
+		sdev->hostdata = hpb;
+
+		list_add_tail(&hpb->list_hpb_lu, &ufshpb_drv.lh_hpb_lu);
+		find_hpb_lu++;
+	}
+
+	if (!find_hpb_lu)
+		return;
+
+	ufshpb_check_hpb_reset_query(hba);
+	dev_set_drvdata(&hba->ufsf.hpb_dev, &ufshpb_drv);
+
+	list_for_each_entry(hpb, &ufshpb_drv.lh_hpb_lu, list_hpb_lu) {
+		dev_info(&hpb->hpb_lu_dev, "set state to present\n");
+		ufshpb_set_state(hpb, HPB_PRESENT);
+	}
+}
+
+static int ufshpb_probe(struct device *dev)
+{
+	struct ufs_hba *hba;
+	struct ufsf_feature_info *ufsf;
+	struct ufshpb_dev_info hpb_dev_info = { 0 };
+	char *desc_buf;
+	int ret;
+
+	if (dev->type != &ufshpb_dev_type)
+		return -ENODEV;
+
+	ufsf = container_of(dev, struct ufsf_feature_info, hpb_dev);
+	hba = container_of(ufsf, struct ufs_hba, ufsf);
+
+	desc_buf = kzalloc(QUERY_DESC_MAX_SIZE, GFP_KERNEL);
+	if (!desc_buf)
+		goto release_desc_buf;
+
+	ret = ufshpb_get_dev_info(hba, &hpb_dev_info, desc_buf);
+	if (ret)
+		goto release_desc_buf;
+
+	/*
+	 * Because HPB driver uses scsi_device data structure,
+	 * we should wait at this point until finishing initialization of all
+	 * scsi devices. Even if timeout occurs, HPB driver will search
+	 * the scsi_device list on struct scsi_host (shost->__host list_head)
+	 * and can find out HPB logical units in all scsi_devices
+	 */
+	wait_event_timeout(hba->ufsf.sdev_wait,
+			   (atomic_read(&hba->ufsf.slave_conf_cnt)
+				== hpb_dev_info.num_lu),
+			   SDEV_WAIT_TIMEOUT);
+
+	ufshpb_issue_hpb_reset_query(hba);
+
+	dev_dbg(hba->dev, "ufshpb: slave count %d, lu count %d\n",
+		atomic_read(&hba->ufsf.slave_conf_cnt), hpb_dev_info.num_lu);
+
+	ufshpb_scan_hpb_lu(hba, &hpb_dev_info, desc_buf);
+
+release_desc_buf:
+	kfree(desc_buf);
+	return 0;
+}
+
+static int ufshpb_remove(struct device *dev)
+{
+	struct ufshpb_lu *hpb, *n_hpb;
+	struct ufsf_feature_info *ufsf;
+	struct scsi_device *sdev;
+
+	ufsf = container_of(dev, struct ufsf_feature_info, hpb_dev);
+
+	dev_set_drvdata(&ufsf->hpb_dev, NULL);
+
+	list_for_each_entry_safe(hpb, n_hpb, &ufshpb_drv.lh_hpb_lu,
+				 list_hpb_lu) {
+		ufshpb_set_state(hpb, HPB_FAILED);
+
+		sdev = hpb->sdev_ufs_lu;
+		sdev->hostdata = NULL;
+
+		device_del(&hpb->hpb_lu_dev);
+
+		dev_info(&hpb->hpb_lu_dev, "hpb_lu_dev refcnt %d\n",
+			 kref_read(&hpb->hpb_lu_dev.kobj.kref));
+		put_device(&hpb->hpb_lu_dev);
+	}
+	dev_info(dev, "ufshpb: remove success\n");
+
+	return 0;
+}
+
+static struct ufshpb_driver ufshpb_drv = {
+	.drv = {
+		.name = "ufshpb_driver",
+		.owner = THIS_MODULE,
+		.probe = ufshpb_probe,
+		.remove = ufshpb_remove,
+		.bus = &ufsf_bus_type,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+	.ufshpb_ops = {
+		.reset = ufshpb_reset,
+		.reset_host = ufshpb_reset_host,
+		.suspend = ufshpb_suspend,
+		.resume = ufshpb_resume,
+	},
+};
+
+module_param(ufshpb_host_map_kbytes, uint, 0644);
+MODULE_PARM_DESC(ufshpb_host_map_kbytes,
+	 "ufshpb host mapping memory kilo-bytes for ufshpb memory-pool");
+
+static int __init ufshpb_init(void)
+{
+	int ret;
+
+	ret = driver_register(&ufshpb_drv.drv);
+	if (ret)
+		pr_err("ufshpb: driver register failed\n");
+
+	return ret;
+}
+
+static void __exit ufshpb_exit(void)
+{
+	driver_unregister(&ufshpb_drv.drv);
+}
+
+MODULE_AUTHOR("Yongmyong Lee <ymhungry.lee@samsung.com>");
+MODULE_AUTHOR("Jinyoung Choi <j-young.choi@samsung.com>");
+MODULE_DESCRIPTION("UFS Host Performance Booster Driver");
+
+module_init(ufshpb_init);
+module_exit(ufshpb_exit);
+MODULE_LICENSE("GPL");
diff --git a/drivers/scsi/ufs/ufshpb.h b/drivers/scsi/ufs/ufshpb.h
new file mode 100644
index 000000000000..78ede7bb5957
--- /dev/null
+++ b/drivers/scsi/ufs/ufshpb.h
@@ -0,0 +1,160 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Universal Flash Storage Host Performance Booster
+ *
+ * Copyright (C) 2017-2018 Samsung Electronics Co., Ltd.
+ *
+ * Authors:
+ *	Yongmyung Lee <ymhungry.lee@samsung.com>
+ *	Jinyoung Choi <j-young.choi@samsung.com>
+ */
+
+#ifndef _UFSHPB_H_
+#define _UFSHPB_H_
+
+/* hpb response UPIU macro */
+#define MAX_ACTIVE_NUM				2
+#define MAX_INACTIVE_NUM			2
+#define HPB_RSP_NONE				0x00
+#define HPB_RSP_REQ_REGION_UPDATE		0x01
+#define HPB_RSP_DEV_RESET			0x02
+#define DEV_DATA_SEG_LEN			0x14
+#define DEV_SENSE_SEG_LEN			0x12
+#define DEV_DES_TYPE				0x80
+#define DEV_ADDITIONAL_LEN			0x10
+
+/* hpb map & entries macro */
+#define HPB_RGN_SIZE_UNIT			512
+#define HPB_ENTRY_BLOCK_SIZE			4096
+#define HPB_ENTRY_SIZE				0x8
+#define PINNED_NOT_SET				U32_MAX
+
+/* hpb support chunk size */
+#define HPB_MULTI_CHUNK_HIGH			1
+
+/* hpb vender defined opcode */
+#define UFSHPB_READ				0xF8
+#define UFSHPB_READ_BUFFER			0xF9
+#define UFSHPB_READ_BUFFER_ID			0x01
+#define HPB_READ_BUFFER_CMD_LENGTH		10
+#define LU_ENABLED_HPB_FUNC			0x02
+
+#define SDEV_WAIT_TIMEOUT			(10 * HZ)
+#define MAP_REQ_TIMEOUT				(30 * HZ)
+#define HPB_RESET_REQ_RETRIES			10
+#define HPB_RESET_REQ_MSLEEP			2
+
+#define HPB_SUPPORT_VERSION			0x100
+
+enum UFSHPB_MODE {
+	HPB_HOST_CONTROL,
+	HPB_DEVICE_CONTROL,
+};
+
+enum UFSHPB_STATE {
+	HPB_PRESENT = 1,
+	HPB_SUSPEND,
+	HPB_FAILED,
+	HPB_RESET,
+};
+
+enum HPB_RGN_STATE {
+	HPB_RGN_INACTIVE,
+	HPB_RGN_ACTIVE,
+	/* pinned regions are always active */
+	HPB_RGN_PINNED,
+};
+
+enum HPB_SRGN_STATE {
+	HPB_SRGN_UNUSED,
+	HPB_SRGN_INVALID,
+	HPB_SRGN_VALID,
+	HPB_SRGN_ISSUED,
+};
+
+/**
+ * struct ufshpb_dev_info - UFSHPB device related info
+ * @num_lu: the number of user logical unit to check whether all lu finished
+ *          initialization
+ * @rgn_size: device reported HPB region size
+ * @srgn_size: device reported HPB sub-region size
+ */
+struct ufshpb_dev_info {
+	int num_lu;
+	int rgn_size;
+	int srgn_size;
+};
+
+/**
+ * struct ufshpb_lu_info - UFSHPB logical unit related info
+ * @num_blocks: the number of logical block
+ * @pinned_start: the start region number of pinned region
+ * @num_pinned: the number of pinned regions
+ * @max_active_rgns: maximum number of active regions
+ */
+struct ufshpb_lu_info {
+	int num_blocks;
+	int pinned_start;
+	int num_pinned;
+	int max_active_rgns;
+};
+
+struct ufshpb_subregion {
+	enum HPB_SRGN_STATE srgn_state;
+	int rgn_idx;
+	int srgn_idx;
+};
+
+struct ufshpb_region {
+	struct ufshpb_subregion *srgn_tbl;
+	enum HPB_RGN_STATE rgn_state;
+	int rgn_idx;
+	int srgn_cnt;
+};
+
+struct ufshpb_stats {
+	atomic_t hit_cnt;
+	atomic_t miss_cnt;
+	atomic_t rb_noti_cnt;
+	atomic_t rb_active_cnt;
+	atomic_t rb_inactive_cnt;
+	atomic_t map_req_cnt;
+};
+
+struct ufshpb_lu {
+	int lun;
+
+	struct device hpb_lu_dev;
+	struct scsi_device *sdev_ufs_lu;
+
+	struct ufshpb_region *rgn_tbl;
+
+	spinlock_t hpb_state_lock;
+	atomic_t hpb_state; /* hpb_state_lock */
+
+	/* pinned region information */
+	u32 lu_pinned_start;
+	u32 lu_pinned_end;
+
+	/* HPB related configuration */
+	u32 rgns_per_lu;
+	u32 srgns_per_lu;
+	int srgns_per_rgn;
+	u32 srgn_mem_size;
+	u32 entries_per_rgn_mask;
+	u32 entries_per_rgn_shift;
+	u32 entries_per_srgn;
+	u32 entries_per_srgn_mask;
+	u32 entries_per_srgn_shift;
+	u32 pages_per_srgn;
+
+	struct ufshpb_stats stats;
+
+	struct ufsf_feature_info *ufsf;
+	struct list_head list_hpb_lu;
+};
+
+extern struct device_type ufshpb_dev_type;
+extern struct bus_type ufsf_bus_type;
+
+#endif /* End of Header */
-- 
2.17.1


