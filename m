Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32FB4633C53
	for <lists+linux-scsi@lfdr.de>; Tue, 22 Nov 2022 13:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbiKVMVh (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 22 Nov 2022 07:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbiKVMVd (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 22 Nov 2022 07:21:33 -0500
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D08A4E40D;
        Tue, 22 Nov 2022 04:21:30 -0800 (PST)
Received: from SHSend.spreadtrum.com (shmbx06.spreadtrum.com [10.0.1.11])
        by SHSQR01.spreadtrum.com with ESMTPS id 2AMCKfAY003659
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO);
        Tue, 22 Nov 2022 20:20:41 +0800 (CST)
        (envelope-from Zhe.Wang1@unisoc.com)
Received: from xm13705pcu.spreadtrum.com (10.13.3.189) by
 shmbx06.spreadtrum.com (10.0.1.11) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Tue, 22 Nov 2022 20:20:43 +0800
From:   Zhe Wang <zhe.wang1@unisoc.com>
To:     <martin.petersen@oracle.com>, <jejb@linux.ibm.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <alim.akhtar@samsung.com>, <avri.altman@wdc.com>
CC:     <linux-scsi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <orsonzhai@gmail.com>, <yuelin.tang@unisoc.com>,
        <zhenxiong.lai@unisoc.com>, <zhang.lyra@gmail.com>,
        <zhewang116@gmail.com>
Subject: [PATCH v3 2/2] scsi: ufs-unisoc: Add support for Unisoc UFS host controller
Date:   Tue, 22 Nov 2022 20:20:30 +0800
Message-ID: <20221122122030.7659-3-zhe.wang1@unisoc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221122122030.7659-1-zhe.wang1@unisoc.com>
References: <20221122122030.7659-1-zhe.wang1@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.3.189]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx06.spreadtrum.com (10.0.1.11)
X-MAIL: SHSQR01.spreadtrum.com 2AMCKfAY003659
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Add driver code for Unisoc ufs host controller, along with ufs
initialization.

Signed-off-by: Zhe Wang <zhe.wang1@unisoc.com>
---
 drivers/ufs/host/Kconfig    |  12 +
 drivers/ufs/host/Makefile   |   1 +
 drivers/ufs/host/ufs-sprd.c | 457 ++++++++++++++++++++++++++++++++++++
 drivers/ufs/host/ufs-sprd.h |  73 ++++++
 4 files changed, 543 insertions(+)
 create mode 100644 drivers/ufs/host/ufs-sprd.c
 create mode 100644 drivers/ufs/host/ufs-sprd.h

diff --git a/drivers/ufs/host/Kconfig b/drivers/ufs/host/Kconfig
index 4cc2dbd79ed0..90a7142ec846 100644
--- a/drivers/ufs/host/Kconfig
+++ b/drivers/ufs/host/Kconfig
@@ -124,3 +124,15 @@ config SCSI_UFS_EXYNOS
 
 	  Select this if you have UFS host controller on Samsung Exynos SoC.
 	  If unsure, say N.
+
+config SCSI_UFS_SPRD
+	tristate "Unisoc specific hooks to UFS controller platform driver"
+	depends on SCSI_UFSHCD_PLATFORM && (ARCH_SPRD || COMPILE_TEST)
+	help
+	  This selects the Unisoc specific additions to UFSHCD platform driver.
+	  UFS host on Unisoc needs some vendor specific configuration before
+	  accessing the hardware which includes PHY configuration and vendor
+	  specific registers.
+
+	  Select this if you have UFS controller on Unisoc chipset.
+	  If unsure, say N.
diff --git a/drivers/ufs/host/Makefile b/drivers/ufs/host/Makefile
index 7717ca93e7d5..a946c3b35c9d 100644
--- a/drivers/ufs/host/Makefile
+++ b/drivers/ufs/host/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_SCSI_UFS_HISI) += ufs-hisi.o
 obj-$(CONFIG_SCSI_UFS_MEDIATEK) += ufs-mediatek.o
 obj-$(CONFIG_SCSI_UFS_RENESAS) += ufs-renesas.o
 obj-$(CONFIG_SCSI_UFS_TI_J721E) += ti-j721e-ufs.o
+obj-$(CONFIG_SCSI_UFS_SPRD) += ufs-sprd.o
diff --git a/drivers/ufs/host/ufs-sprd.c b/drivers/ufs/host/ufs-sprd.c
new file mode 100644
index 000000000000..b952a154e549
--- /dev/null
+++ b/drivers/ufs/host/ufs-sprd.c
@@ -0,0 +1,457 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * UNISOC UFS Host Controller driver
+ *
+ * Copyright (C) 2022 Unisoc, Inc.
+ * Author: Zhe Wang <zhe.wang1@unisoc.com>
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include <linux/regulator/consumer.h>
+
+#include <ufs/ufshcd.h>
+#include "ufshcd-pltfrm.h"
+#include "ufs-sprd.h"
+
+static const struct of_device_id ufs_sprd_of_match[];
+
+static struct ufs_sprd_priv *ufs_sprd_get_priv_data(struct ufs_hba *hba)
+{
+	struct ufs_sprd_host *host = ufshcd_get_variant(hba);
+
+	WARN_ON(!host->priv);
+	return host->priv;
+}
+
+static void ufs_sprd_regmap_update(struct ufs_sprd_priv *priv, unsigned int index,
+				unsigned int reg, unsigned int bits,  unsigned int val)
+{
+	regmap_update_bits(priv->sysci[index].regmap, reg, bits, val);
+}
+
+static void ufs_sprd_regmap_read(struct ufs_sprd_priv *priv, unsigned int index,
+				unsigned int reg, unsigned int *val)
+{
+	regmap_read(priv->sysci[index].regmap, reg, val);
+}
+
+static void ufs_sprd_get_unipro_ver(struct ufs_hba *hba)
+{
+	struct ufs_sprd_host *host = ufshcd_get_variant(hba);
+
+	if (ufshcd_dme_get(hba, UIC_ARG_MIB(PA_LOCALVERINFO), &host->unipro_ver))
+		host->unipro_ver = 0;
+}
+
+static void ufs_sprd_ctrl_uic_compl(struct ufs_hba *hba, bool enable)
+{
+	u32 set = ufshcd_readl(hba, REG_INTERRUPT_ENABLE);
+
+	if (enable == true)
+		set |= UIC_COMMAND_COMPL;
+	else
+		set &= ~UIC_COMMAND_COMPL;
+	ufshcd_writel(hba, set, REG_INTERRUPT_ENABLE);
+}
+
+static int ufs_sprd_get_reset_ctrl(struct device *dev, struct ufs_sprd_rst *rci)
+{
+	rci->rc = devm_reset_control_get(dev, rci->name);
+	if (IS_ERR(rci->rc)) {
+		dev_err(dev, "failed to get reset ctrl:%s\n", rci->name);
+		return PTR_ERR(rci->rc);
+	}
+
+	return 0;
+}
+
+static int ufs_sprd_get_syscon_reg(struct device *dev, struct ufs_sprd_syscon *sysci)
+{
+	sysci->regmap = syscon_regmap_lookup_by_phandle(dev->of_node, sysci->name);
+	if (IS_ERR(sysci->regmap)) {
+		dev_err(dev, "failed to get ufs syscon:%s\n", sysci->name);
+		return PTR_ERR(sysci->regmap);
+	}
+
+	return 0;
+}
+
+static int ufs_sprd_get_vreg(struct device *dev, struct ufs_sprd_vreg *vregi)
+{
+	vregi->vreg = devm_regulator_get(dev, vregi->name);
+	if (IS_ERR(vregi->vreg)) {
+		dev_err(dev, "failed to get vreg:%s\n", vregi->name);
+		return PTR_ERR(vregi->vreg);
+	}
+
+	return 0;
+}
+
+static int ufs_sprd_parse_dt(struct device *dev, struct ufs_hba *hba, struct ufs_sprd_host *host)
+{
+	u32 i;
+	struct ufs_sprd_priv *priv = host->priv;
+	int ret = 0;
+
+	/* Parse UFS reset ctrl info */
+	for (i = 0; i < SPRD_UFS_RST_MAX; i++) {
+		if (!priv->rci[i].name)
+			continue;
+		ret = ufs_sprd_get_reset_ctrl(dev, &priv->rci[i]);
+		if (ret)
+			goto out;
+	}
+
+	/* Parse UFS syscon reg info */
+	for (i = 0; i < SPRD_UFS_SYSCON_MAX; i++) {
+		if (!priv->sysci[i].name)
+			continue;
+		ret = ufs_sprd_get_syscon_reg(dev, &priv->sysci[i]);
+		if (ret)
+			goto out;
+	}
+
+	/* Parse UFS vreg info */
+	for (i = 0; i < SPRD_UFS_VREG_MAX; i++) {
+		if (!priv->vregi[i].name)
+			continue;
+		ret = ufs_sprd_get_vreg(dev, &priv->vregi[i]);
+		if (ret)
+			goto out;
+	}
+
+out:
+	return ret;
+}
+
+static int ufs_sprd_common_init(struct ufs_hba *hba)
+{
+	struct device *dev = hba->dev;
+	struct ufs_sprd_host *host;
+	struct platform_device *pdev = to_platform_device(dev);
+	const struct of_device_id *of_id;
+	int ret = 0;
+
+	host = devm_kzalloc(dev, sizeof(*host), GFP_KERNEL);
+	if (!host)
+		return -ENOMEM;
+
+	of_id = of_match_node(ufs_sprd_of_match, pdev->dev.of_node);
+	if (of_id->data != NULL)
+		host->priv = container_of(of_id->data, struct ufs_sprd_priv,
+					  ufs_hba_sprd_vops);
+
+	host->hba = hba;
+	ufshcd_set_variant(hba, host);
+
+	hba->caps |= UFSHCD_CAP_CLK_GATING |
+		UFSHCD_CAP_CRYPTO |
+		UFSHCD_CAP_WB_EN;
+	hba->quirks |= UFSHCD_QUIRK_DELAY_BEFORE_DME_CMDS;
+
+	ret = ufs_sprd_parse_dt(dev, hba, host);
+
+	return ret;
+}
+
+static int sprd_ufs_pwr_change_notify(struct ufs_hba *hba,
+				      enum ufs_notify_change_status status,
+				      struct ufs_pa_layer_attr *dev_max_params,
+				      struct ufs_pa_layer_attr *dev_req_params)
+{
+	struct ufs_sprd_host *host = ufshcd_get_variant(hba);
+
+	if (status == PRE_CHANGE) {
+		memcpy(dev_req_params, dev_max_params,
+			sizeof(struct ufs_pa_layer_attr));
+		if (host->unipro_ver >= UFS_UNIPRO_VER_1_8)
+			ufshcd_dme_configure_adapt(hba, dev_req_params->gear_tx,
+						   PA_INITIAL_ADAPT);
+	}
+
+	return 0;
+}
+
+static int ufs_sprd_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op,
+			    enum ufs_notify_change_status status)
+{
+	unsigned long flags;
+
+	if (status == PRE_CHANGE) {
+		if (ufshcd_is_auto_hibern8_supported(hba)) {
+			spin_lock_irqsave(hba->host->host_lock, flags);
+			ufshcd_writel(hba, 0, REG_AUTO_HIBERNATE_IDLE_TIMER);
+			spin_unlock_irqrestore(hba->host->host_lock, flags);
+		}
+	}
+
+	return 0;
+}
+
+static void ufs_sprd_n6_host_reset(struct ufs_hba *hba)
+{
+	struct ufs_sprd_priv *priv = ufs_sprd_get_priv_data(hba);
+
+	dev_info(hba->dev, "ufs host reset!\n");
+
+	reset_control_assert(priv->rci[SPRD_UFSHCI_SOFT_RST].rc);
+	usleep_range(1000, 1100);
+	reset_control_deassert(priv->rci[SPRD_UFSHCI_SOFT_RST].rc);
+}
+
+static int ufs_sprd_n6_device_reset(struct ufs_hba *hba)
+{
+	struct ufs_sprd_priv *priv = ufs_sprd_get_priv_data(hba);
+
+	dev_info(hba->dev, "ufs device reset!\n");
+
+	reset_control_assert(priv->rci[SPRD_UFS_DEV_RST].rc);
+	usleep_range(1000, 1100);
+	reset_control_deassert(priv->rci[SPRD_UFS_DEV_RST].rc);
+
+	return 0;
+}
+
+static void ufs_sprd_n6_key_acc_enable(struct ufs_hba *hba)
+{
+	u32 val;
+	u32 retry = 10;
+	struct arm_smccc_res res;
+
+check_hce:
+	/* Key access only can be enabled under HCE enable */
+	val = ufshcd_readl(hba, REG_CONTROLLER_ENABLE);
+	if (!(val & CONTROLLER_ENABLE)) {
+		ufs_sprd_n6_host_reset(hba);
+		val |= CONTROLLER_ENABLE;
+		ufshcd_writel(hba, val, REG_CONTROLLER_ENABLE);
+		usleep_range(1000, 1100);
+		if (retry) {
+			retry--;
+			goto check_hce;
+		}
+		goto disable_crypto;
+	}
+
+	arm_smccc_smc(SPRD_SIP_SVC_STORAGE_UFS_CRYPTO_ENABLE,
+		      0, 0, 0, 0, 0, 0, 0, &res);
+	if (!res.a0)
+		return;
+
+disable_crypto:
+	dev_err(hba->dev, "key reg access enable fail, disable crypto\n");
+	hba->caps &= ~UFSHCD_CAP_CRYPTO;
+}
+
+static int ufs_sprd_n6_init(struct ufs_hba *hba)
+{
+	struct ufs_sprd_priv *priv;
+	int ret = 0;
+
+	ret = ufs_sprd_common_init(hba);
+	if (ret != 0)
+		return ret;
+
+	priv = ufs_sprd_get_priv_data(hba);
+
+	ret = regulator_enable(priv->vregi[SPRD_UFS_VDD_MPHY].vreg);
+	if (ret)
+		return -ENODEV;
+
+	if (hba->caps & UFSHCD_CAP_CRYPTO)
+		ufs_sprd_n6_key_acc_enable(hba);
+
+	return 0;
+}
+
+static int ufs_sprd_n6_phy_init(struct ufs_hba *hba)
+{
+	int ret = 0;
+	uint32_t val = 0;
+	uint32_t retry = 10;
+	uint32_t offset;
+	struct ufs_sprd_priv *priv = ufs_sprd_get_priv_data(hba);
+
+	ufshcd_dme_set(hba, UIC_ARG_MIB(0x8132), 0x90);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(0x811F), 0x01);
+	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x8009,
+				UIC_ARG_MPHY_RX_GEN_SEL_INDEX(0)), 0x01);
+	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x8009,
+				UIC_ARG_MPHY_RX_GEN_SEL_INDEX(1)), 0x01);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(0xD085), 0x01);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(0x8114), 0x01);
+
+	do {
+		/* phy_sram_init_done */
+		ufs_sprd_regmap_read(priv, SPRD_UFS_ANLG, 0xc, &val);
+		if ((val & 0x1) == 0x1) {
+			for (offset = 0x40; offset < 0x42; offset++) {
+				/* Lane afe calibration */
+				ufshcd_dme_set(hba, UIC_ARG_MIB(0x8116), 0x1c);
+				ufshcd_dme_set(hba, UIC_ARG_MIB(0x8117), offset);
+				ufshcd_dme_set(hba, UIC_ARG_MIB(0x8118), 0x04);
+				ufshcd_dme_set(hba, UIC_ARG_MIB(0x8119), 0x00);
+				ufshcd_dme_set(hba, UIC_ARG_MIB(0x811C), 0x01);
+				ufshcd_dme_set(hba, UIC_ARG_MIB(0xD085), 0x01);
+			}
+
+			goto update_phy;
+		}
+		udelay(1000);
+		retry--;
+	} while (retry > 0);
+
+	ret = -ETIMEDOUT;
+	goto out;
+
+update_phy:
+	/* phy_sram_ext_ld_done */
+	ufs_sprd_regmap_update(priv, SPRD_UFS_ANLG, 0xc, 0x2, 0);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(0xD085), 0x01);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(0xD0C1), 0x0);
+out:
+	return ret;
+}
+
+
+static int sprd_ufs_n6_hce_enable_notify(struct ufs_hba *hba,
+					 enum ufs_notify_change_status status)
+{
+	int err = 0;
+	struct ufs_sprd_priv *priv = ufs_sprd_get_priv_data(hba);
+
+	if (status == PRE_CHANGE) {
+		/* phy_sram_ext_ld_done */
+		ufs_sprd_regmap_update(priv, SPRD_UFS_ANLG, 0xc, 0x2, 0x2);
+		/* phy_sram_bypass */
+		ufs_sprd_regmap_update(priv, SPRD_UFS_ANLG, 0xc, 0x4, 0x4);
+
+		ufs_sprd_n6_host_reset(hba);
+
+		if (hba->caps & UFSHCD_CAP_CRYPTO)
+			ufs_sprd_n6_key_acc_enable(hba);
+	}
+
+	if (status == POST_CHANGE) {
+		err = ufs_sprd_n6_phy_init(hba);
+		if (err) {
+			dev_err(hba->dev, "Phy setup failed (%d)\n", err);
+			goto out;
+		}
+
+		ufs_sprd_get_unipro_ver(hba);
+	}
+out:
+	return err;
+}
+
+static void sprd_ufs_n6_h8_notify(struct ufs_hba *hba,
+				  enum uic_cmd_dme cmd,
+				  enum ufs_notify_change_status status)
+{
+	struct ufs_sprd_priv *priv = ufs_sprd_get_priv_data(hba);
+
+	if (status == PRE_CHANGE) {
+		if (cmd == UIC_CMD_DME_HIBER_ENTER)
+			/*
+			 * Disable UIC COMPL INTR to prevent access to UFSHCI after
+			 * checking HCS.UPMCRS
+			 */
+			ufs_sprd_ctrl_uic_compl(hba, false);
+
+		if (cmd == UIC_CMD_DME_HIBER_EXIT) {
+			ufs_sprd_regmap_update(priv, SPRD_UFS_AON_APB, APB_UFSDEV_REG,
+				APB_UFSDEV_REFCLK_EN, APB_UFSDEV_REFCLK_EN);
+			ufs_sprd_regmap_update(priv, SPRD_UFS_AON_APB, APB_USB31PLL_CTRL,
+				APB_USB31PLLV_REF2MPHY, APB_USB31PLLV_REF2MPHY);
+		}
+	}
+
+	if (status == POST_CHANGE) {
+		if (cmd == UIC_CMD_DME_HIBER_EXIT)
+			ufs_sprd_ctrl_uic_compl(hba, true);
+
+		if (cmd == UIC_CMD_DME_HIBER_ENTER) {
+			ufs_sprd_regmap_update(priv, SPRD_UFS_AON_APB, APB_UFSDEV_REG,
+				APB_UFSDEV_REFCLK_EN, 0);
+			ufs_sprd_regmap_update(priv, SPRD_UFS_AON_APB, APB_USB31PLL_CTRL,
+				APB_USB31PLLV_REF2MPHY, 0);
+		}
+	}
+}
+
+static struct ufs_sprd_priv n6_ufs = {
+	.rci[SPRD_UFSHCI_SOFT_RST] = { .name = "controller", },
+	.rci[SPRD_UFS_DEV_RST] = { .name = "device", },
+
+	.sysci[SPRD_UFS_ANLG] = { .name = "sprd,ufs-anlg-syscon", },
+	.sysci[SPRD_UFS_AON_APB] = { .name = "sprd,aon-apb-syscon", },
+
+	.vregi[SPRD_UFS_VDD_MPHY] = { .name = "vdd-mphy", },
+
+	.ufs_hba_sprd_vops = {
+		.name = "sprd,ums9620-ufs",
+		.init = ufs_sprd_n6_init,
+		.hce_enable_notify = sprd_ufs_n6_hce_enable_notify,
+		.pwr_change_notify = sprd_ufs_pwr_change_notify,
+		.hibern8_notify = sprd_ufs_n6_h8_notify,
+		.device_reset = ufs_sprd_n6_device_reset,
+		.suspend = ufs_sprd_suspend,
+	},
+};
+
+static const struct of_device_id ufs_sprd_of_match[] = {
+	{ .compatible = "sprd,ums9620-ufs", .data = &n6_ufs.ufs_hba_sprd_vops},
+	{},
+};
+
+static int ufs_sprd_probe(struct platform_device *pdev)
+{
+	int err;
+	struct device *dev = &pdev->dev;
+	const struct of_device_id *of_id;
+
+	of_id = of_match_node(ufs_sprd_of_match, dev->of_node);
+	err = ufshcd_pltfrm_init(pdev, of_id->data);
+	if (err)
+		dev_err(dev, "ufshcd_pltfrm_init() failed %d\n", err);
+
+	return err;
+}
+
+static int ufs_sprd_remove(struct platform_device *pdev)
+{
+	struct ufs_hba *hba =  platform_get_drvdata(pdev);
+
+	pm_runtime_get_sync(&(pdev)->dev);
+	ufshcd_remove(hba);
+	return 0;
+}
+
+static const struct dev_pm_ops ufs_sprd_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(ufshcd_system_suspend, ufshcd_system_resume)
+	SET_RUNTIME_PM_OPS(ufshcd_runtime_suspend, ufshcd_runtime_resume, NULL)
+	.prepare	 = ufshcd_suspend_prepare,
+	.complete	 = ufshcd_resume_complete,
+};
+
+static struct platform_driver ufs_sprd_pltform = {
+	.probe = ufs_sprd_probe,
+	.remove = ufs_sprd_remove,
+	.shutdown = ufshcd_pltfrm_shutdown,
+	.driver = {
+		.name = "ufshcd-sprd",
+		.pm = &ufs_sprd_pm_ops,
+		.of_match_table = ufs_sprd_of_match,
+	},
+};
+module_platform_driver(ufs_sprd_pltform);
+
+MODULE_AUTHOR("Zhe Wang <zhe.wang1@unisoc.com>");
+MODULE_DESCRIPTION("Unisoc UFS Host Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/ufs/host/ufs-sprd.h b/drivers/ufs/host/ufs-sprd.h
new file mode 100644
index 000000000000..8f685ddd56c8
--- /dev/null
+++ b/drivers/ufs/host/ufs-sprd.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * UNISOC UFS Host Controller driver
+ *
+ * Copyright (C) 2022 Unisoc, Inc.
+ * Author: Zhe Wang <zhe.wang1@unisoc.com>
+ */
+
+#ifndef _UFS_SPRD_H_
+#define _UFS_SPRD_H_
+
+#define APB_UFSDEV_REG		0xCE8
+#define APB_UFSDEV_REFCLK_EN	0x2
+#define APB_USB31PLL_CTRL	0xCFC
+#define APB_USB31PLLV_REF2MPHY	0x1
+
+#define SPRD_SIP_SVC_STORAGE_UFS_CRYPTO_ENABLE				\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,				\
+			   ARM_SMCCC_SMC_32,				\
+			   ARM_SMCCC_OWNER_SIP,				\
+			   0x0301)
+
+enum SPRD_UFS_RST_INDEX {
+	SPRD_UFSHCI_SOFT_RST,
+	SPRD_UFS_DEV_RST,
+
+	SPRD_UFS_RST_MAX
+};
+
+enum SPRD_UFS_SYSCON_INDEX {
+	SPRD_UFS_ANLG,
+	SPRD_UFS_AON_APB,
+
+	SPRD_UFS_SYSCON_MAX
+};
+
+enum SPRD_UFS_VREG_INDEX {
+	SPRD_UFS_VDD_MPHY,
+
+	SPRD_UFS_VREG_MAX
+};
+
+struct ufs_sprd_rst {
+	const char *name;
+	struct reset_control *rc;
+};
+
+struct ufs_sprd_syscon {
+	const char *name;
+	struct regmap *regmap;
+};
+
+struct ufs_sprd_vreg {
+	const char *name;
+	struct regulator *vreg;
+};
+
+struct ufs_sprd_priv {
+	struct ufs_sprd_rst rci[SPRD_UFS_RST_MAX];
+	struct ufs_sprd_syscon sysci[SPRD_UFS_SYSCON_MAX];
+	struct ufs_sprd_vreg vregi[SPRD_UFS_VREG_MAX];
+	const struct ufs_hba_variant_ops ufs_hba_sprd_vops;
+};
+
+struct ufs_sprd_host {
+	struct ufs_hba *hba;
+	struct ufs_sprd_priv *priv;
+	void __iomem *ufs_dbg_mmio;
+
+	enum ufs_unipro_ver unipro_ver;
+};
+
+#endif /* _UFS_SPRD_H_ */
-- 
2.17.1

