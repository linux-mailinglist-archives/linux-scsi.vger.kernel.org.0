Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 309F71EEF20
	for <lists+linux-scsi@lfdr.de>; Fri,  5 Jun 2020 03:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgFEBfM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 4 Jun 2020 21:35:12 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:45494 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgFEBfJ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 4 Jun 2020 21:35:09 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200605013502epoutp04d4ba0c8fbe0fe32b32d6cd6ee27edbd5~Vge4ZodFV0288902889epoutp04x
        for <linux-scsi@vger.kernel.org>; Fri,  5 Jun 2020 01:35:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200605013502epoutp04d4ba0c8fbe0fe32b32d6cd6ee27edbd5~Vge4ZodFV0288902889epoutp04x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591320903;
        bh=yBOOpZHK+T1wXWIvlooCMpPM8S4RbTXRZae8l66y5Rw=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=G21YkRydt0rIic72KVVl6XnR5XMFmLGdaq6ZyfaCnU8fyp2BeNhA+v0CaVyGazI2Q
         YC2WvG9Tt2q0Kz9rd0jgZdEAJ8CfotaxNBKX8k1rcnSyxvtxAaqsK+pqJ3Eyopd1Cx
         UFfYjAPDOs/0Gz/pXtlAAwl9+dPpYR1FfuFwSvsQ=
Received: from epcpadp1 (unknown [182.195.40.11]) by epcas1p4.samsung.com
        (KnoxPortal) with ESMTP id
        20200605013502epcas1p41ed004e0b4cd398e11f11ee962c0f2e6~Vge31o3Wq1890718907epcas1p4N;
        Fri,  5 Jun 2020 01:35:02 +0000 (GMT)
Mime-Version: 1.0
Subject: [RFC PATCH 2/5] scsi: ufs: Add UFS-feature layer
Reply-To: daejun7.park@samsung.com
From:   Daejun Park <daejun7.park@samsung.com>
To:     Daejun Park <daejun7.park@samsung.com>,
        ALIM AKHTAR <alim.akhtar@samsung.com>,
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
        Sang-yoon Oh <sangyoon.oh@samsung.com>,
        Sung-Jun Park <sungjun07.park@samsung.com>,
        yongmyung lee <ymhungry.lee@samsung.com>,
        Jinyoung CHOI <j-young.choi@samsung.com>,
        Adel Choi <adel.choi@samsung.com>,
        BoRam Shin <boram.shin@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <963815509.21591320301642.JavaMail.epsvc@epcpadp1>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <336371513.41591320902369.JavaMail.epsvc@epcpadp1>
Date:   Fri, 05 Jun 2020 10:30:08 +0900
X-CMS-MailID: 20200605013008epcms2p17127588c869c75798abbfa6ebf2f7e57
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20200605011604epcms2p8bec8ef6682583d7248dc7d9dc1bfc882
References: <963815509.21591320301642.JavaMail.epsvc@epcpadp1>
        <231786897.01591320001492.JavaMail.epsvc@epcpadp1>
        <CGME20200605011604epcms2p8bec8ef6682583d7248dc7d9dc1bfc882@epcms2p1>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch is adding UFS feature layer to UFS core driver.

UFS Driver data structure (struct ufs_hba)
=09=E2=94=82
=E2=94=8C--------------=E2=94=90
=E2=94=82 UFS feature  =E2=94=82 <-- HPB module
=E2=94=82    layer     =E2=94=82 <-- other extended feature module
=E2=94=94--------------=E2=94=98
Each extended UFS-Feature module has a bus of ufs-ext feature type.
The UFS feature layer manages common APIs used by each extended feature
module. The APIs are set of UFS Query requests and UFS Vendor commands
related to each extended feature module.

The following 6 callback functions have been added to "ufshcd.c".
prep_fn: called after construct upiu structure
reset: called after proving hba
reset_host: called before ufshcd_host_reset_and_restore
suspend: called before ufshcd_suspend
resume: called after ufshcd_resume
rsp_upiu: called in ufshcd_transfer_rsp_status with SAM_STAT_GOOD state

Signed-off-by: Daejun Park <daejun7.park@samsung.com>
---
 drivers/scsi/ufs/Makefile     |   2 +-
 drivers/scsi/ufs/ufsfeature.c | 178 ++++++++++++++++++++++++++++++++++
 drivers/scsi/ufs/ufsfeature.h |  95 ++++++++++++++++++
 drivers/scsi/ufs/ufshcd.c     |  17 ++++
 drivers/scsi/ufs/ufshcd.h     |   3 +
 5 files changed, 294 insertions(+), 1 deletion(-)
 create mode 100644 drivers/scsi/ufs/ufsfeature.c
 create mode 100644 drivers/scsi/ufs/ufsfeature.h

diff --git a/drivers/scsi/ufs/Makefile b/drivers/scsi/ufs/Makefile
index 94c6c5d7334b..fe3a92b06c87 100644
--- a/drivers/scsi/ufs/Makefile
+++ b/drivers/scsi/ufs/Makefile
@@ -5,7 +5,7 @@ obj-$(CONFIG_SCSI_UFS_DWC_TC_PLATFORM) +=3D tc-dwc-g210-plt=
frm.o ufshcd-dwc.o tc-d
 obj-$(CONFIG_SCSI_UFS_CDNS_PLATFORM) +=3D cdns-pltfrm.o
 obj-$(CONFIG_SCSI_UFS_QCOM) +=3D ufs-qcom.o
 obj-$(CONFIG_SCSI_UFSHCD) +=3D ufshcd-core.o
-ufshcd-core-y=09=09=09=09+=3D ufshcd.o ufs-sysfs.o
+ufshcd-core-y=09=09=09=09+=3D ufshcd.o ufs-sysfs.o ufsfeature.o
 ufshcd-core-$(CONFIG_SCSI_UFS_BSG)=09+=3D ufs_bsg.o
 obj-$(CONFIG_SCSI_UFSHCD_PCI) +=3D ufshcd-pci.o
 obj-$(CONFIG_SCSI_UFSHCD_PLATFORM) +=3D ufshcd-pltfrm.o
diff --git a/drivers/scsi/ufs/ufsfeature.c b/drivers/scsi/ufs/ufsfeature.c
new file mode 100644
index 000000000000..a6671962fad2
--- /dev/null
+++ b/drivers/scsi/ufs/ufsfeature.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Universal Flash Storage Feature Support
+ *
+ * Copyright (C) 2017-2018 Samsung Electronics Co., Ltd.
+ *
+ * Authors:
+ *=09Yongmyung Lee <ymhungry.lee@samsung.com>
+ *=09Jinyoung Choi <j-young.choi@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ * See the COPYING file in the top-level directory or visit
+ * <http://www.gnu.org/licenses/gpl-2.0.html>
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * This program is provided "AS IS" and "WITH ALL FAULTS" and
+ * without warranty of any kind. You are solely responsible for
+ * determining the appropriateness of using and distributing
+ * the program and assume all risks associated with your exercise
+ * of rights with respect to the program, including but not limited
+ * to infringement of third party rights, the risks and costs of
+ * program errors, damage to or loss of data, programs or equipment,
+ * and unavailability or interruption of operations. Under no
+ * circumstances will the contributor of this Program be liable for
+ * any damages of any kind arising from your use or distribution of
+ * this program.
+ *
+ * The Linux Foundation chooses to take subject only to the GPLv2
+ * license terms, and distributes only under these terms.
+ */
+
+#include "ufshcd.h"
+#include "ufsfeature.h"
+
+inline void ufsf_slave_configure(struct ufs_hba *hba,
+=09=09=09=09 struct scsi_device *sdev)
+{
+=09/* skip well-known LU */
+=09if (sdev->lun >=3D UFS_UPIU_MAX_UNIT_NUM_ID)
+=09=09return;
+
+=09if (!(hba->dev_info.b_ufs_feature_sup & UFS_FEATURE_SUPPORT_HPB_BIT))
+=09=09return;
+
+=09atomic_inc(&hba->ufsf.slave_conf_cnt);
+=09smp_mb__after_atomic(); /* for slave_conf_cnt */
+
+=09/* waiting sdev init.*/
+=09if (waitqueue_active(&hba->ufsf.sdev_wait))
+=09=09wake_up(&hba->ufsf.sdev_wait);
+}
+
+inline void ufsf_ops_prep_fn(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
+{
+=09struct ufshpb_driver *ufshpb_drv;
+
+=09ufshpb_drv =3D dev_get_drvdata(&hba->ufsf.hpb_dev);
+
+=09if (ufshpb_drv && ufshpb_drv->ufshpb_ops.prep_fn)
+=09=09ufshpb_drv->ufshpb_ops.prep_fn(hba, lrbp);
+}
+
+inline void ufsf_ops_rsp_upiu(struct ufs_hba *hba, struct ufshcd_lrb *lrbp=
)
+{
+=09struct ufshpb_driver *ufshpb_drv;
+
+=09ufshpb_drv =3D dev_get_drvdata(&hba->ufsf.hpb_dev);
+
+=09if (ufshpb_drv && ufshpb_drv->ufshpb_ops.rsp_upiu)
+=09=09ufshpb_drv->ufshpb_ops.rsp_upiu(hba, lrbp);
+}
+
+inline void ufsf_ops_reset_host(struct ufs_hba *hba)
+{
+=09struct ufshpb_driver *ufshpb_drv;
+
+=09ufshpb_drv =3D dev_get_drvdata(&hba->ufsf.hpb_dev);
+
+=09if (ufshpb_drv && ufshpb_drv->ufshpb_ops.reset_host)
+=09=09ufshpb_drv->ufshpb_ops.reset_host(hba);
+}
+
+inline void ufsf_ops_reset(struct ufs_hba *hba)
+{
+=09struct ufshpb_driver *ufshpb_drv;
+
+=09ufshpb_drv =3D dev_get_drvdata(&hba->ufsf.hpb_dev);
+
+=09if (ufshpb_drv && ufshpb_drv->ufshpb_ops.reset)
+=09=09ufshpb_drv->ufshpb_ops.reset(hba);
+}
+
+inline void ufsf_ops_suspend(struct ufs_hba *hba)
+{
+=09struct ufshpb_driver *ufshpb_drv;
+
+=09ufshpb_drv =3D dev_get_drvdata(&hba->ufsf.hpb_dev);
+
+=09if (ufshpb_drv && ufshpb_drv->ufshpb_ops.suspend)
+=09=09ufshpb_drv->ufshpb_ops.suspend(hba);
+}
+
+inline void ufsf_ops_resume(struct ufs_hba *hba)
+{
+=09struct ufshpb_driver *ufshpb_drv;
+
+=09ufshpb_drv =3D dev_get_drvdata(&hba->ufsf.hpb_dev);
+
+=09if (ufshpb_drv && ufshpb_drv->ufshpb_ops.resume)
+=09=09ufshpb_drv->ufshpb_ops.resume(hba);
+}
+
+struct device_type ufshpb_dev_type =3D {
+=09.name =3D "ufshpb_device"
+};
+EXPORT_SYMBOL(ufshpb_dev_type);
+
+static int ufsf_bus_match(struct device *dev,
+=09=09=09 struct device_driver *gendrv)
+{
+=09if (dev->type =3D=3D &ufshpb_dev_type)
+=09=09return 1;
+
+=09return 0;
+}
+
+struct bus_type ufsf_bus_type =3D {
+=09.name =3D "ufsf_bus",
+=09.match =3D ufsf_bus_match,
+};
+EXPORT_SYMBOL(ufsf_bus_type);
+
+static void ufsf_dev_release(struct device *dev)
+{
+=09put_device(dev->parent);
+}
+
+void ufsf_scan_features(struct ufs_hba *hba)
+{
+=09int ret;
+
+=09init_waitqueue_head(&hba->ufsf.sdev_wait);
+=09atomic_set(&hba->ufsf.slave_conf_cnt, 0);
+
+=09if (hba->dev_info.wspecversion >=3D HPB_SUPPORTED_VERSION &&
+=09    (hba->dev_info.b_ufs_feature_sup & UFS_FEATURE_SUPPORT_HPB_BIT)) {
+=09=09device_initialize(&hba->ufsf.hpb_dev);
+
+=09=09hba->ufsf.hpb_dev.bus =3D &ufsf_bus_type;
+=09=09hba->ufsf.hpb_dev.type =3D &ufshpb_dev_type;
+=09=09hba->ufsf.hpb_dev.parent =3D get_device(hba->dev);
+=09=09hba->ufsf.hpb_dev.release =3D ufsf_dev_release;
+
+=09=09dev_set_name(&hba->ufsf.hpb_dev, "ufshpb");
+=09=09ret =3D device_add(&hba->ufsf.hpb_dev);
+=09=09if (ret)
+=09=09=09dev_warn(hba->dev, "ufshpb: failed to add device\n");
+=09}
+}
+
+static int __init ufsf_init(void)
+{
+=09int ret;
+
+=09ret =3D bus_register(&ufsf_bus_type);
+=09if (ret)
+=09=09pr_err("%s bus_register failed\n", __func__);
+
+=09return ret;
+}
+device_initcall(ufsf_init);
diff --git a/drivers/scsi/ufs/ufsfeature.h b/drivers/scsi/ufs/ufsfeature.h
new file mode 100644
index 000000000000..cbac848ec6c6
--- /dev/null
+++ b/drivers/scsi/ufs/ufsfeature.h
@@ -0,0 +1,95 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Universal Flash Storage Feature Support
+ *
+ * Copyright (C) 2017-2018 Samsung Electronics Co., Ltd.
+ *
+ * Authors:
+ *=09Yongmyung Lee <ymhungry.lee@samsung.com>
+ *=09Jinyoung Choi <j-young.choi@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ * See the COPYING file in the top-level directory or visit
+ * <http://www.gnu.org/licenses/gpl-2.0.html>
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * This program is provided "AS IS" and "WITH ALL FAULTS" and
+ * without warranty of any kind. You are solely responsible for
+ * determining the appropriateness of using and distributing
+ * the program and assume all risks associated with your exercise
+ * of rights with respect to the program, including but not limited
+ * to infringement of third party rights, the risks and costs of
+ * program errors, damage to or loss of data, programs or equipment,
+ * and unavailability or interruption of operations. Under no
+ * circumstances will the contributor of this Program be liable for
+ * any damages of any kind arising from your use or distribution of
+ * this program.
+ *
+ * The Linux Foundation chooses to take subject only to the GPLv2
+ * license terms, and distributes only under these terms.
+ */
+
+#ifndef _UFSFEATURE_H_
+#define _UFSFEATURE_H_
+
+#define HPB_SUPPORTED_VERSION=09=09=090x0310
+#define UFS_FEATURE_SUPPORT_HPB_BIT=09=090x80
+
+struct ufs_hba;
+struct ufshcd_lrb;
+
+/**
+ * struct ufsf_operation - UFS feature specific callbacks
+ * @prep_fn: called after construct upiu structure
+ * @reset: called after proving hba
+ * @reset_host: called before ufshcd_host_reset_and_restore
+ * @suspend: called before ufshcd_suspend
+ * @resume: called after ufshcd_resume
+ * @rsp_upiu: called in ufshcd_transfer_rsp_status with SAM_STAT_GOOD stat=
e
+ */
+struct ufsf_operation {
+=09void (*prep_fn)(struct ufs_hba *hba, struct ufshcd_lrb *lrbp);
+=09void (*reset)(struct ufs_hba *hba);
+=09void (*reset_host)(struct ufs_hba *hba);
+=09void (*suspend)(struct ufs_hba *hba);
+=09void (*resume)(struct ufs_hba *hba);
+=09void (*rsp_upiu)(struct ufs_hba *hba, struct ufshcd_lrb *lrbp);
+};
+
+struct ufshpb_driver {
+=09struct device_driver drv;
+=09struct list_head lh_hpb_lu;
+
+=09struct ufsf_operation ufshpb_ops;
+
+=09/* memory management */
+=09struct kmem_cache *ufshpb_mctx_cache;
+=09mempool_t *ufshpb_mctx_pool;
+=09mempool_t *ufshpb_page_pool;
+
+=09struct workqueue_struct *ufshpb_wq;
+};
+
+struct ufsf_feature_info {
+=09atomic_t slave_conf_cnt;
+=09wait_queue_head_t sdev_wait;
+=09struct device hpb_dev;
+};
+
+void ufsf_slave_configure(struct ufs_hba *hba, struct scsi_device *sdev);
+void ufsf_scan_features(struct ufs_hba *hba);
+void ufsf_ops_prep_fn(struct ufs_hba *hba, struct ufshcd_lrb *lrbp);
+void ufsf_ops_rsp_upiu(struct ufs_hba *hba, struct ufshcd_lrb *lrbp);
+void ufsf_ops_reset_host(struct ufs_hba *hba);
+void ufsf_ops_reset(struct ufs_hba *hba);
+void ufsf_ops_suspend(struct ufs_hba *hba);
+void ufsf_ops_resume(struct ufs_hba *hba);
+
+#endif /* End of Header */
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 5db18f444ea9..de57ba2a0b03 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -2525,6 +2525,8 @@ static int ufshcd_queuecommand(struct Scsi_Host *host=
, struct scsi_cmnd *cmd)
=20
 =09ufshcd_comp_scsi_upiu(hba, lrbp);
=20
+=09ufsf_ops_prep_fn(hba, lrbp);
+
 =09err =3D ufshcd_map_sg(hba, lrbp);
 =09if (err) {
 =09=09lrbp->cmd =3D NULL;
@@ -4645,6 +4647,8 @@ static int ufshcd_slave_configure(struct scsi_device =
*sdev)
 =09struct ufs_hba *hba =3D shost_priv(sdev->host);
 =09struct request_queue *q =3D sdev->request_queue;
=20
+=09ufsf_slave_configure(hba, sdev);
+
 =09blk_queue_update_dma_pad(q, PRDT_DATA_BYTE_COUNT_PAD - 1);
=20
 =09if (ufshcd_is_rpm_autosuspend_allowed(hba))
@@ -4765,6 +4769,9 @@ ufshcd_transfer_rsp_status(struct ufs_hba *hba, struc=
t ufshcd_lrb *lrbp)
 =09=09=09=09 */
 =09=09=09=09pm_runtime_get_noresume(hba->dev);
 =09=09=09}
+
+=09=09=09if (scsi_status =3D=3D SAM_STAT_GOOD)
+=09=09=09=09ufsf_ops_rsp_upiu(hba, lrbp);
 =09=09=09break;
 =09=09case UPIU_TRANSACTION_REJECT_UPIU:
 =09=09=09/* TODO: handle Reject UPIU Response */
@@ -6508,6 +6515,8 @@ static int ufshcd_host_reset_and_restore(struct ufs_h=
ba *hba)
 =09 * Stop the host controller and complete the requests
 =09 * cleared by h/w
 =09 */
+=09ufsf_ops_reset_host(hba);
+
 =09ufshcd_hba_stop(hba);
=20
 =09spin_lock_irqsave(hba->host->host_lock, flags);
@@ -6934,6 +6943,7 @@ static int ufs_get_device_desc(struct ufs_hba *hba)
 =09/* getting Specification Version in big endian format */
 =09dev_info->wspecversion =3D desc_buf[DEVICE_DESC_PARAM_SPEC_VER] << 8 |
 =09=09=09=09      desc_buf[DEVICE_DESC_PARAM_SPEC_VER + 1];
+=09dev_info->b_ufs_feature_sup =3D desc_buf[DEVICE_DESC_PARAM_UFS_FEAT];
=20
 =09model_index =3D desc_buf[DEVICE_DESC_PARAM_PRDCT_NAME];
=20
@@ -7350,6 +7360,7 @@ static int ufshcd_add_lus(struct ufs_hba *hba)
 =09}
=20
 =09ufs_bsg_probe(hba);
+=09ufsf_scan_features(hba);
 =09scsi_scan_host(hba->host);
 =09pm_runtime_put_sync(hba->dev);
=20
@@ -7442,6 +7453,7 @@ static int ufshcd_probe_hba(struct ufs_hba *hba, bool=
 async)
 =09/* Enable Auto-Hibernate if configured */
 =09ufshcd_auto_hibern8_enable(hba);
=20
+=09ufsf_ops_reset(hba);
 out:
=20
 =09trace_ufshcd_init(dev_name(hba->dev), ret,
@@ -8199,6 +8211,8 @@ static int ufshcd_suspend(struct ufs_hba *hba, enum u=
fs_pm_op pm_op)
 =09=09req_link_state =3D UIC_LINK_OFF_STATE;
 =09}
=20
+=09ufsf_ops_suspend(hba);
+
 =09/*
 =09 * If we can't transition into any of the low power modes
 =09 * just gate the clocks.
@@ -8320,6 +8334,7 @@ static int ufshcd_suspend(struct ufs_hba *hba, enum u=
fs_pm_op pm_op)
 =09hba->clk_gating.is_suspended =3D false;
 =09hba->dev_info.b_rpm_dev_flush_capable =3D false;
 =09ufshcd_release(hba);
+=09ufsf_ops_resume(hba);
 out:
 =09if (hba->dev_info.b_rpm_dev_flush_capable) {
 =09=09schedule_delayed_work(&hba->rpm_dev_flush_recheck_work,
@@ -8416,6 +8431,8 @@ static int ufshcd_resume(struct ufs_hba *hba, enum uf=
s_pm_op pm_op)
 =09/* Enable Auto-Hibernate if configured */
 =09ufshcd_auto_hibern8_enable(hba);
=20
+=09ufsf_ops_resume(hba);
+
 =09if (hba->dev_info.b_rpm_dev_flush_capable) {
 =09=09hba->dev_info.b_rpm_dev_flush_capable =3D false;
 =09=09cancel_delayed_work(&hba->rpm_dev_flush_recheck_work);
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index bf97d616e597..47866ab722ff 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -71,6 +71,7 @@
 #include "ufs.h"
 #include "ufs_quirks.h"
 #include "ufshci.h"
+#include "ufsfeature.h"
=20
 #define UFSHCD "ufshcd"
 #define UFSHCD_DRIVER_VERSION "0.2"
@@ -746,6 +747,8 @@ struct ufs_hba {
 =09bool wb_buf_flush_enabled;
 =09bool wb_enabled;
 =09struct delayed_work rpm_dev_flush_recheck_work;
+
+=09struct ufsf_feature_info ufsf;
 };
=20
 /* Returns true if clocks can be gated. Otherwise false */
--=20
2.17.1
