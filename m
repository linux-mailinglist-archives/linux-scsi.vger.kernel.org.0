Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFD2C213020
	for <lists+linux-scsi@lfdr.de>; Fri,  3 Jul 2020 01:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgGBX2J (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 2 Jul 2020 19:28:09 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:38126 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbgGBX2H (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 2 Jul 2020 19:28:07 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200702232802epoutp0410cb096c3fbc103c1e84dcea8d4e8bca~eEz_ZH3DS0981909819epoutp04a
        for <linux-scsi@vger.kernel.org>; Thu,  2 Jul 2020 23:28:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200702232802epoutp0410cb096c3fbc103c1e84dcea8d4e8bca~eEz_ZH3DS0981909819epoutp04a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593732482;
        bh=7bdDrtKfhDIeoE6nA3jqgvIZ53z3Zzgsj9GRaApA+3s=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=h/RcjT8ZmIrya7guSxQDosusgIvDLkydXqiDWNLn82oHvfdF+04eiL83LQycWYy7x
         +Rt/07zdcMyejMGIaP6TkKP/2y//SWef1rUeR3Kb8b/4ZmZQ7yAvVbpvfgRZvyHq52
         lz4EeIvOrBLlk84hxj4ifFJuNhQmIG6NxpVOQJaE=
Received: from epcpadp2 (unknown [182.195.40.12]) by epcas1p1.samsung.com
        (KnoxPortal) with ESMTP id
        20200702232801epcas1p1cafab29e1b4ffb80b930cd2ade5956af~eEz9-a6Dx2105821058epcas1p1Q;
        Thu,  2 Jul 2020 23:28:01 +0000 (GMT)
Mime-Version: 1.0
Subject: [PATCH v5 2/5] scsi: ufs: Add UFS-feature layer
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
In-Reply-To: <231786897.01593732302018.JavaMail.epsvc@epcpadp1>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <231786897.01593732481555.JavaMail.epsvc@epcpadp2>
Date:   Fri, 03 Jul 2020 08:25:48 +0900
X-CMS-MailID: 20200702232548epcms2p40e7f103a652035059f8c823e32672bcc
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20200702231936epcms2p81557f83504ef1c1e81bfc81a0143a5b4
References: <231786897.01593732302018.JavaMail.epsvc@epcpadp1>
        <963815509.21593732182531.JavaMail.epsvc@epcpadp2>
        <CGME20200702231936epcms2p81557f83504ef1c1e81bfc81a0143a5b4@epcms2p4>
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

Other extended features can also be implemented using the proposed APIs.
For example, in Write Booster, "prep_fn" can be used to guarantee the
lifetime of UFS by updating the amount of write IO.
And reset/reset_host/suspend/resume can be used to manage the kernel task
for checking lifetime of UFS.

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
 drivers/scsi/ufs/ufsfeature.c | 148 ++++++++++++++++++++++++++++++++++
 drivers/scsi/ufs/ufsfeature.h |  69 ++++++++++++++++
 drivers/scsi/ufs/ufshcd.c     |  17 ++++
 drivers/scsi/ufs/ufshcd.h     |   3 +
 5 files changed, 238 insertions(+), 1 deletion(-)
 create mode 100644 drivers/scsi/ufs/ufsfeature.c
 create mode 100644 drivers/scsi/ufs/ufsfeature.h

diff --git a/drivers/scsi/ufs/Makefile b/drivers/scsi/ufs/Makefile
index f0c5b95ec9cc..433b871badfa 100644
--- a/drivers/scsi/ufs/Makefile
+++ b/drivers/scsi/ufs/Makefile
@@ -6,7 +6,7 @@ obj-$(CONFIG_SCSI_UFS_CDNS_PLATFORM) +=3D cdns-pltfrm.o
 obj-$(CONFIG_SCSI_UFS_QCOM) +=3D ufs-qcom.o
 obj-$(CONFIG_SCSI_UFS_EXYNOS) +=3D ufs-exynos.o
 obj-$(CONFIG_SCSI_UFSHCD) +=3D ufshcd-core.o
-ufshcd-core-y=09=09=09=09+=3D ufshcd.o ufs-sysfs.o
+ufshcd-core-y=09=09=09=09+=3D ufshcd.o ufs-sysfs.o ufsfeature.o
 ufshcd-core-$(CONFIG_SCSI_UFS_BSG)=09+=3D ufs_bsg.o
 obj-$(CONFIG_SCSI_UFSHCD_PCI) +=3D ufshcd-pci.o
 obj-$(CONFIG_SCSI_UFSHCD_PLATFORM) +=3D ufshcd-pltfrm.o
diff --git a/drivers/scsi/ufs/ufsfeature.c b/drivers/scsi/ufs/ufsfeature.c
new file mode 100644
index 000000000000..94c6be6babd3
--- /dev/null
+++ b/drivers/scsi/ufs/ufsfeature.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Universal Flash Storage Feature Support
+ *
+ * Copyright (C) 2017-2018 Samsung Electronics Co., Ltd.
+ *
+ * Authors:
+ *=09Yongmyung Lee <ymhungry.lee@samsung.com>
+ *=09Jinyoung Choi <j-young.choi@samsung.com>
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
+=09if (!(hba->dev_info.b_ufs_feature_sup & UFS_DEV_HPB_SUPPORT))
+=09=09return;
+
+=09atomic_inc(&hba->ufsf.slave_conf_cnt);
+
+=09wake_up(&hba->ufsf.sdev_wait);
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
+=09    (hba->dev_info.b_ufs_feature_sup & UFS_DEV_HPB_SUPPORT)) {
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
index 000000000000..1822d9d8e745
--- /dev/null
+++ b/drivers/scsi/ufs/ufsfeature.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Universal Flash Storage Feature Support
+ *
+ * Copyright (C) 2017-2018 Samsung Electronics Co., Ltd.
+ *
+ * Authors:
+ *=09Yongmyung Lee <ymhungry.lee@samsung.com>
+ *=09Jinyoung Choi <j-young.choi@samsung.com>
+ */
+
+#ifndef _UFSFEATURE_H_
+#define _UFSFEATURE_H_
+
+#define HPB_SUPPORTED_VERSION=09=09=090x0310
+
+struct ufs_hba;
+struct ufshcd_lrb;
+
+/**
+ * struct ufsf_operation - UFS feature specific callbacks
+ * @prep_fn: called after construct upiu structure. The prep_fn should wor=
k
+ *=09     properly even if it processes the same SCSI command multiple
+ *=09     times by requeuing.
+ * @reset: called after probing hba
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
index 59358bb75014..d02106bf80d8 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -2533,6 +2533,8 @@ static int ufshcd_queuecommand(struct Scsi_Host *host=
, struct scsi_cmnd *cmd)
=20
 =09ufshcd_comp_scsi_upiu(hba, lrbp);
=20
+=09ufsf_ops_prep_fn(hba, lrbp);
+
 =09err =3D ufshcd_map_sg(hba, lrbp);
 =09if (err) {
 =09=09lrbp->cmd =3D NULL;
@@ -4665,6 +4667,8 @@ static int ufshcd_slave_configure(struct scsi_device =
*sdev)
 =09struct ufs_hba *hba =3D shost_priv(sdev->host);
 =09struct request_queue *q =3D sdev->request_queue;
=20
+=09ufsf_slave_configure(hba, sdev);
+
 =09blk_queue_update_dma_pad(q, PRDT_DATA_BYTE_COUNT_PAD - 1);
=20
 =09if (ufshcd_is_rpm_autosuspend_allowed(hba))
@@ -4791,6 +4795,9 @@ ufshcd_transfer_rsp_status(struct ufs_hba *hba, struc=
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
@@ -6539,6 +6546,8 @@ static int ufshcd_host_reset_and_restore(struct ufs_h=
ba *hba)
 =09 * Stop the host controller and complete the requests
 =09 * cleared by h/w
 =09 */
+=09ufsf_ops_reset_host(hba);
+
 =09ufshcd_hba_stop(hba);
=20
 =09spin_lock_irqsave(hba->host->host_lock, flags);
@@ -6973,6 +6982,7 @@ static int ufs_get_device_desc(struct ufs_hba *hba)
 =09/* getting Specification Version in big endian format */
 =09dev_info->wspecversion =3D desc_buf[DEVICE_DESC_PARAM_SPEC_VER] << 8 |
 =09=09=09=09      desc_buf[DEVICE_DESC_PARAM_SPEC_VER + 1];
+=09dev_info->b_ufs_feature_sup =3D desc_buf[DEVICE_DESC_PARAM_UFS_FEAT];
=20
 =09model_index =3D desc_buf[DEVICE_DESC_PARAM_PRDCT_NAME];
=20
@@ -7343,6 +7353,7 @@ static int ufshcd_add_lus(struct ufs_hba *hba)
 =09}
=20
 =09ufs_bsg_probe(hba);
+=09ufsf_scan_features(hba);
 =09scsi_scan_host(hba->host);
 =09pm_runtime_put_sync(hba->dev);
=20
@@ -7431,6 +7442,7 @@ static int ufshcd_probe_hba(struct ufs_hba *hba, bool=
 async)
 =09/* Enable Auto-Hibernate if configured */
 =09ufshcd_auto_hibern8_enable(hba);
=20
+=09ufsf_ops_reset(hba);
 out:
=20
 =09trace_ufshcd_init(dev_name(hba->dev), ret,
@@ -8188,6 +8200,8 @@ static int ufshcd_suspend(struct ufs_hba *hba, enum u=
fs_pm_op pm_op)
 =09=09req_link_state =3D UIC_LINK_OFF_STATE;
 =09}
=20
+=09ufsf_ops_suspend(hba);
+
 =09/*
 =09 * If we can't transition into any of the low power modes
 =09 * just gate the clocks.
@@ -8309,6 +8323,7 @@ static int ufshcd_suspend(struct ufs_hba *hba, enum u=
fs_pm_op pm_op)
 =09hba->clk_gating.is_suspended =3D false;
 =09hba->dev_info.b_rpm_dev_flush_capable =3D false;
 =09ufshcd_release(hba);
+=09ufsf_ops_resume(hba);
 out:
 =09if (hba->dev_info.b_rpm_dev_flush_capable) {
 =09=09schedule_delayed_work(&hba->rpm_dev_flush_recheck_work,
@@ -8405,6 +8420,8 @@ static int ufshcd_resume(struct ufs_hba *hba, enum uf=
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
index c774012582b4..6fe5c9b3a0e7 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -46,6 +46,7 @@
 #include "ufs.h"
 #include "ufs_quirks.h"
 #include "ufshci.h"
+#include "ufsfeature.h"
=20
 #define UFSHCD "ufshcd"
 #define UFSHCD_DRIVER_VERSION "0.2"
@@ -736,6 +737,8 @@ struct ufs_hba {
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


