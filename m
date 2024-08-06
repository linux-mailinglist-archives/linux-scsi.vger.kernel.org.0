Return-Path: <linux-scsi+bounces-7167-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 948809494B9
	for <lists+linux-scsi@lfdr.de>; Tue,  6 Aug 2024 17:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AEA2286A11
	for <lists+linux-scsi@lfdr.de>; Tue,  6 Aug 2024 15:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504E322334;
	Tue,  6 Aug 2024 15:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="KmFcQ+P4"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-m3271.qiye.163.com (mail-m3271.qiye.163.com [220.197.32.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD723A1B0;
	Tue,  6 Aug 2024 15:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722958814; cv=none; b=sfHyqaTpN0sj/CaNKuEqyg/3uPlFhUzgaMnhsHCqv1u/FNMoHtHrTCM0SKEpwiNs8bIPLlnnfGeXlw4zjs6KXK+mXjlCYvPkTt3f6IOpv5gUI7Fpv+KVw6kSg0cKvfDLZ0TBxtxp5fA8y26s2GRk+LkvkCLImSyNX9eceiQFVCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722958814; c=relaxed/simple;
	bh=oiVij8yXrQ4HoHUAyyPgV/zKGLN0rn2QIxMusS0V/js=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=auJo9ErCmC9AxmcAAf/2dOnLM8spEssvUsS7jq8WYe6g8rRRm9am/D2ZlK1LeDeMJMGWsf5jO/t8VIz2tJ137ZLgVF/kSs5ke94lSGctFNuKGd8d7upn4AIYrPp/5kkN4TboJWk138Y28d+3cq/wpuqsjAiBC9kjV3R5ajYMUt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=KmFcQ+P4; arc=none smtp.client-ip=220.197.32.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
DKIM-Signature: a=rsa-sha256;
	b=KmFcQ+P45xnoXdRESCCWOieY/RF9ihx0sCUaCOywFSvf4TaN/Vug2Bm1NdYK4XieF5H0KyHres+mqomSq5RkBqPiuPeg3aRV2gsNArdUNQoIqn/bMzGC3K/d3+nxdHRudbyGKqbX81sP9YsjDNwshRbh4q/QfPYM3pcNQz+cLJU=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=rYU1gGIy7sPRNpW+QDl/fzqGRyqJB+0BOpvkXIZ7LIA=;
	h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTPA id F3E83460517;
	Tue,  6 Aug 2024 15:20:31 +0800 (CST)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Rob Herring <robh+dt@kernel.org>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	YiFeng Zhao <zyf@rock-chips.com>,
	Liang Chen <cl@rock-chips.com>,
	linux-scsi@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v1 3/3] scsi: ufs: rockchip: init support for UFS
Date: Tue,  6 Aug 2024 15:20:00 +0800
Message-Id: <1722928800-137042-4-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1722928800-137042-1-git-send-email-shawn.lin@rock-chips.com>
References: <1722928800-137042-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkJLSVZMSR9CHx9PH0oYHx5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
	NVSktLVUpCS0tZBg++
X-HM-Tid: 0a91268fa05303aekunmf3e83460517
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NU06MRw6CzI*CxIPCjwwTikw
	ME4aChpVSlVKTElJQklDQ0hISExOVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUpCTUhKNwY+
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>

RK3576 contains a UFS controller, add init support fot it.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

 drivers/ufs/host/Kconfig        |  12 +
 drivers/ufs/host/Makefile       |   1 +
 drivers/ufs/host/ufs-rockchip.c | 477 ++++++++++++++++++++++++++++++++++++++++
 drivers/ufs/host/ufs-rockchip.h |  52 +++++
 4 files changed, 542 insertions(+)
 create mode 100644 drivers/ufs/host/ufs-rockchip.c
 create mode 100644 drivers/ufs/host/ufs-rockchip.h

diff --git a/drivers/ufs/host/Kconfig b/drivers/ufs/host/Kconfig
index 580c8d0..fafaa33 100644
--- a/drivers/ufs/host/Kconfig
+++ b/drivers/ufs/host/Kconfig
@@ -142,3 +142,15 @@ config SCSI_UFS_SPRD
 
 	  Select this if you have UFS controller on Unisoc chipset.
 	  If unsure, say N.
+
+config SCSI_UFS_ROCKCHIP
+	tristate "Rockchip specific hooks to UFS controller platform driver"
+	depends on SCSI_UFSHCD_PLATFORM && (ARCH_ROCKCHIP || COMPILE_TEST)
+	help
+	  This selects the Rockchip specific additions to UFSHCD platform driver.
+	  UFS host on Rockchip needs some vendor specific configuration before
+	  accessing the hardware which includes PHY configuration and vendor
+	  specific registers.
+
+	  Select this if you have UFS controller on Rockchip chipset.
+	  If unsure, say N.
diff --git a/drivers/ufs/host/Makefile b/drivers/ufs/host/Makefile
index 4573aea..2f97feb 100644
--- a/drivers/ufs/host/Makefile
+++ b/drivers/ufs/host/Makefile
@@ -10,5 +10,6 @@ obj-$(CONFIG_SCSI_UFSHCD_PLATFORM) += ufshcd-pltfrm.o
 obj-$(CONFIG_SCSI_UFS_HISI) += ufs-hisi.o
 obj-$(CONFIG_SCSI_UFS_MEDIATEK) += ufs-mediatek.o
 obj-$(CONFIG_SCSI_UFS_RENESAS) += ufs-renesas.o
+obj-$(CONFIG_SCSI_UFS_ROCKCHIP) += ufs-rockchip.o
 obj-$(CONFIG_SCSI_UFS_SPRD) += ufs-sprd.o
 obj-$(CONFIG_SCSI_UFS_TI_J721E) += ti-j721e-ufs.o
diff --git a/drivers/ufs/host/ufs-rockchip.c b/drivers/ufs/host/ufs-rockchip.c
new file mode 100644
index 0000000..3220d6f
--- /dev/null
+++ b/drivers/ufs/host/ufs-rockchip.c
@@ -0,0 +1,477 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Rockchip UFS Host Controller driver
+ *
+ * Copyright (C) 2024 Rockchip Electronics Co.Ltd.
+ */
+
+#include <linux/clk.h>
+#include <linux/gpio.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+
+#include <ufs/ufshcd.h>
+#include <ufs/unipro.h>
+#include "ufshcd-pltfrm.h"
+#include "ufshcd-dwc.h"
+#include "ufs-rockchip.h"
+
+static inline bool ufshcd_is_device_present(struct ufs_hba *hba)
+{
+	return ufshcd_readl(hba, REG_CONTROLLER_STATUS) & DEVICE_PRESENT;
+}
+
+static int ufs_rockchip_hce_enable_notify(struct ufs_hba *hba,
+					 enum ufs_notify_change_status status)
+{
+	int err = 0;
+
+	if (status == PRE_CHANGE) {
+		int retry_outer = 3;
+		int retry_inner;
+start:
+		if (ufshcd_is_hba_active(hba))
+			/* change controller state to "reset state" */
+			ufshcd_hba_stop(hba);
+
+		/* UniPro link is disabled at this point */
+		ufshcd_set_link_off(hba);
+
+		/* start controller initialization sequence */
+		ufshcd_writel(hba, CONTROLLER_ENABLE, REG_CONTROLLER_ENABLE);
+
+		usleep_range(100, 200);
+
+		/* wait for the host controller to complete initialization */
+		retry_inner = 50;
+		while (!ufshcd_is_hba_active(hba)) {
+			if (retry_inner) {
+				retry_inner--;
+			} else {
+				dev_err(hba->dev,
+					"Controller enable failed\n");
+				if (retry_outer) {
+					retry_outer--;
+					goto start;
+				}
+				return -EIO;
+			}
+			usleep_range(1000, 1100);
+		}
+	} else { /* POST_CHANGE */
+		err = ufshcd_vops_phy_initialization(hba);
+	}
+
+	return err;
+}
+
+static void ufs_rockchip_set_pm_lvl(struct ufs_hba *hba)
+{
+	hba->rpm_lvl = UFS_PM_LVL_1;
+	hba->spm_lvl = UFS_PM_LVL_3;
+}
+
+static const unsigned char rk3576_phy_value[15][4] = {
+	{0x03, 0x38, 0x50, 0x80},
+	{0x03, 0x14, 0x58, 0x80},
+	{0x03, 0x26, 0x58, 0x80},
+	{0x03, 0x49, 0x58, 0x80},
+	{0x03, 0x5A, 0x58, 0x80},
+	{0xC3, 0x38, 0x50, 0xC0},
+	{0xC3, 0x14, 0x58, 0xC0},
+	{0xC3, 0x26, 0x58, 0xC0},
+	{0xC3, 0x49, 0x58, 0xC0},
+	{0xC3, 0x5A, 0x58, 0xC0},
+	{0x43, 0x38, 0x50, 0xC0},
+	{0x43, 0x14, 0x58, 0xC0},
+	{0x43, 0x26, 0x58, 0xC0},
+	{0x43, 0x49, 0x58, 0xC0},
+	{0x43, 0x5A, 0x58, 0xC0}
+};
+
+static int ufs_rockchip_rk3576_phy_init(struct ufs_hba *hba)
+{
+	struct ufs_rockchip_host *host = ufshcd_get_variant(hba);
+	u32 try_case = host->phy_config_mode, value;
+
+	if (try_case >= ARRAY_SIZE(rk3576_phy_value))
+		try_case = 0;
+
+	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(PA_LOCAL_TX_LCC_ENABLE, 0x0), 0x0);
+	/* enable the mphy DME_SET cfg */
+	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x200, 0x0), 0x40);
+	for (int i = 0; i < 2; i++) {
+		/* Configuration M-TX */
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0xaa, SEL_TX_LANE0 + i), 0x06);
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0xa9, SEL_TX_LANE0 + i), 0x02);
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0xad, SEL_TX_LANE0 + i), 0x44);
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0xac, SEL_TX_LANE0 + i), 0xe6);
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0xab, SEL_TX_LANE0 + i), 0x07);
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x94, SEL_TX_LANE0 + i), 0x93);
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x93, SEL_TX_LANE0 + i), 0xc9);
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x7f, SEL_TX_LANE0 + i), 0x00);
+		/* Configuration M-RX */
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x12, SEL_RX_LANE0 + i), 0x06);
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x11, SEL_RX_LANE0 + i), 0x00);
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x1d, SEL_RX_LANE0 + i), 0x58);
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x1c, SEL_RX_LANE0 + i), 0x8c);
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x1b, SEL_RX_LANE0 + i), 0x02);
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x25, SEL_RX_LANE0 + i), 0xf6);
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x2f, SEL_RX_LANE0 + i), 0x69);
+	}
+	/* disable the mphy DME_SET cfg */
+	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x200, 0x0), 0x00);
+
+	ufs_sys_writel(host->mphy_base, 0x80, 0x08C);
+	ufs_sys_writel(host->mphy_base, 0xB5, 0x110);
+	ufs_sys_writel(host->mphy_base, 0xB5, 0x250);
+
+	value = rk3576_phy_value[try_case][0];
+	ufs_sys_writel(host->mphy_base, value, 0x134);
+	ufs_sys_writel(host->mphy_base, value, 0x274);
+
+	value = rk3576_phy_value[try_case][1];
+	ufs_sys_writel(host->mphy_base, value, 0x0E0);
+	ufs_sys_writel(host->mphy_base, value, 0x220);
+
+	value = rk3576_phy_value[try_case][2];
+	ufs_sys_writel(host->mphy_base, value, 0x164);
+	ufs_sys_writel(host->mphy_base, value, 0x2A4);
+
+	value = rk3576_phy_value[try_case][3];
+	ufs_sys_writel(host->mphy_base, value, 0x178);
+	ufs_sys_writel(host->mphy_base, value, 0x2B8);
+
+	ufs_sys_writel(host->mphy_base, 0x18, 0x1B0);
+	ufs_sys_writel(host->mphy_base, 0x18, 0x2F0);
+
+	ufs_sys_writel(host->mphy_base, 0x03, 0x128);
+	ufs_sys_writel(host->mphy_base, 0x03, 0x268);
+
+	ufs_sys_writel(host->mphy_base, 0x20, 0x12C);
+	ufs_sys_writel(host->mphy_base, 0x20, 0x26C);
+
+	ufs_sys_writel(host->mphy_base, 0xC0, 0x120);
+	ufs_sys_writel(host->mphy_base, 0xC0, 0x260);
+
+	ufs_sys_writel(host->mphy_base, 0x03, 0x094);
+
+	ufs_sys_writel(host->mphy_base, 0x03, 0x1B4);
+	ufs_sys_writel(host->mphy_base, 0x03, 0x2F4);
+
+	ufs_sys_writel(host->mphy_base, 0xC0, 0x08C);
+	udelay(1);
+	ufs_sys_writel(host->mphy_base, 0x00, 0x08C);
+
+	udelay(200);
+	/* start link up */
+	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(MIB_T_DBG_CPORT_TX_ENDIAN, 0), 0x0);
+	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(MIB_T_DBG_CPORT_RX_ENDIAN, 0), 0x0);
+	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(N_DEVICEID, 0), 0x0);
+	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(N_DEVICEID_VALID, 0), 0x1);
+	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(T_PEERDEVICEID, 0), 0x1);
+	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(T_CONNECTIONSTATE, 0), 0x1);
+
+	return 0;
+}
+
+static int ufs_rockchip_common_init(struct ufs_hba *hba)
+{
+	struct device *dev = hba->dev;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct ufs_rockchip_host *host;
+	int err = 0;
+
+	host = devm_kzalloc(dev, sizeof(*host), GFP_KERNEL);
+	if (!host)
+		return -ENOMEM;
+
+	/* system control register for hci */
+	host->ufs_sys_ctrl = devm_platform_ioremap_resource_byname(pdev, "hci_grf");
+	if (IS_ERR(host->ufs_sys_ctrl)) {
+		dev_err(dev, "cannot ioremap for hci system control register\n");
+		return PTR_ERR(host->ufs_sys_ctrl);
+	}
+
+	/* system control register for mphy */
+	host->ufs_phy_ctrl = devm_platform_ioremap_resource_byname(pdev, "mphy_grf");
+	if (IS_ERR(host->ufs_phy_ctrl)) {
+		dev_err(dev, "cannot ioremap for mphy system control register\n");
+		return PTR_ERR(host->ufs_phy_ctrl);
+	}
+
+	/* mphy base register */
+	host->mphy_base = devm_platform_ioremap_resource_byname(pdev, "mphy");
+	if (IS_ERR(host->mphy_base)) {
+		dev_err(dev, "cannot ioremap for mphy base register\n");
+		return PTR_ERR(host->mphy_base);
+	}
+
+	host->rst = devm_reset_control_array_get_exclusive(dev);
+	if (IS_ERR(host->rst)) {
+		dev_err(dev, "failed to get reset control\n");
+		return PTR_ERR(host->rst);
+	}
+
+	reset_control_assert(host->rst);
+	udelay(1);
+	reset_control_deassert(host->rst);
+
+	host->ref_out_clk = devm_clk_get(dev, "ref_out");
+	if (IS_ERR(host->ref_out_clk)) {
+		dev_err(dev, "ciu-drive not available\n");
+		return PTR_ERR(host->ref_out_clk);
+	}
+	err = clk_prepare_enable(host->ref_out_clk);
+	if (err) {
+		dev_err(dev, "failed to enable ref out clock %d\n", err);
+		return err;
+	}
+
+	host->rst_gpio = devm_gpiod_get(&pdev->dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(host->rst_gpio)) {
+		dev_err(&pdev->dev, "invalid reset-gpios property in node\n");
+		err = PTR_ERR(host->rst_gpio);
+		goto out;
+	}
+	udelay(20);
+	gpiod_set_value_cansleep(host->rst_gpio, 1);
+
+	host->clks[0].id = "core";
+	host->clks[1].id = "pclk";
+	host->clks[2].id = "pclk_mphy";
+	err = devm_clk_bulk_get_optional(dev, UFS_MAX_CLKS, host->clks);
+	if (err) {
+		dev_err(dev, "failed to get clocks %d\n", err);
+		goto out;
+	}
+
+	err = clk_bulk_prepare_enable(UFS_MAX_CLKS, host->clks);
+	if (err) {
+		dev_err(dev, "failed to enable clocks %d\n", err);
+		goto out;
+	}
+
+	if (device_property_read_u32(dev, "ufs-phy-config-mode",
+				     &host->phy_config_mode))
+		host->phy_config_mode = 0;
+
+	pm_runtime_set_active(&pdev->dev);
+
+	host->hba = hba;
+	ufs_rockchip_set_pm_lvl(hba);
+
+	ufshcd_set_variant(hba, host);
+
+	return 0;
+out:
+	clk_disable_unprepare(host->ref_out_clk);
+	return err;
+}
+
+static int ufs_rockchip_rk3576_init(struct ufs_hba *hba)
+{
+	int ret = 0;
+	struct device *dev = hba->dev;
+
+	hba->quirks = UFSHCI_QUIRK_BROKEN_HCE | UFSHCD_QUIRK_SKIP_DEF_UNIPRO_TIMEOUT_SETTING;
+
+	/* Enable BKOPS when suspend */
+	hba->caps |= UFSHCD_CAP_AUTO_BKOPS_SUSPEND;
+	/* Enable putting device into deep sleep */
+	hba->caps |= UFSHCD_CAP_DEEPSLEEP;
+	/* Enable devfreq of UFS */
+	hba->caps |= UFSHCD_CAP_CLK_SCALING;
+	/* Enable WriteBooster */
+	hba->caps |= UFSHCD_CAP_WB_EN;
+
+	ret = ufs_rockchip_common_init(hba);
+	if (ret) {
+		dev_err(dev, "ufs common init fail\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int ufs_rockchip_device_reset(struct ufs_hba *hba)
+{
+	struct ufs_rockchip_host *host = ufshcd_get_variant(hba);
+
+	if (!host->rst_gpio)
+		return -EOPNOTSUPP;
+
+	gpiod_set_value_cansleep(host->rst_gpio, 0);
+	udelay(20);
+
+	gpiod_set_value_cansleep(host->rst_gpio, 1);
+	udelay(20);
+
+	return 0;
+}
+
+static const struct ufs_hba_variant_ops ufs_hba_rk3576_vops = {
+	.name = "rk3576",
+	.init = ufs_rockchip_rk3576_init,
+	.device_reset = ufs_rockchip_device_reset,
+	.hce_enable_notify = ufs_rockchip_hce_enable_notify,
+	.phy_initialization = ufs_rockchip_rk3576_phy_init,
+};
+
+static const struct of_device_id ufs_rockchip_of_match[] = {
+	{ .compatible = "rockchip,rk3576-ufs", .data = &ufs_hba_rk3576_vops},
+	{},
+};
+MODULE_DEVICE_TABLE(of, ufs_rockchip_of_match);
+
+static int ufs_rockchip_probe(struct platform_device *pdev)
+{
+	int err;
+	struct device *dev = &pdev->dev;
+	const struct ufs_hba_variant_ops *vops;
+
+	vops = device_get_match_data(dev);
+	err = ufshcd_pltfrm_init(pdev, vops);
+	if (err)
+		dev_err(dev, "ufshcd_pltfrm_init() failed %d\n", err);
+
+	return err;
+}
+
+static void ufs_rockchip_remove(struct platform_device *pdev)
+{
+	struct ufs_hba *hba = platform_get_drvdata(pdev);
+	struct ufs_rockchip_host *host = ufshcd_get_variant(hba);
+
+	pm_runtime_forbid(&pdev->dev);
+	pm_runtime_get_noresume(&pdev->dev);
+	ufshcd_remove(hba);
+	ufshcd_dealloc_host(hba);
+	clk_disable_unprepare(host->ref_out_clk);
+}
+
+static int ufs_rockchip_restore_link(struct ufs_hba *hba, bool is_store)
+{
+	struct ufs_rockchip_host *host = ufshcd_get_variant(hba);
+	int err, retry = 3;
+
+	if (is_store) {
+		host->ie = ufshcd_readl(hba, REG_INTERRUPT_ENABLE);
+		host->ahit = ufshcd_readl(hba, REG_AUTO_HIBERNATE_IDLE_TIMER);
+		return 0;
+	}
+
+	/* Enable controller */
+	err = ufshcd_hba_enable(hba);
+	if (err)
+		return err;
+
+	/* Link startup and wait for DP */
+	do {
+		err = ufshcd_dme_link_startup(hba);
+		if (!err && ufshcd_is_device_present(hba)) {
+			dev_dbg_ratelimited(hba->dev, "rockchip link startup successfully.\n");
+			break;
+		}
+	} while (retry--);
+
+	if (retry < 0) {
+		dev_err(hba->dev, "rockchip link startup failed.\n");
+		return -ENXIO;
+	}
+
+	/* Restore negotiated power mode */
+	err = ufshcd_config_pwr_mode(hba, &(hba->pwr_info));
+	if (err)
+		dev_err(hba->dev, "Failed to restore power mode, err = %d\n", err);
+
+	/* Restore task and transfer list */
+	ufshcd_writel(hba, 0xffffffff, REG_INTERRUPT_STATUS);
+	ufshcd_make_hba_operational(hba);
+
+	/* Restore lost regs */
+	ufshcd_writel(hba, host->ie, REG_INTERRUPT_ENABLE);
+	ufshcd_writel(hba, host->ahit, REG_AUTO_HIBERNATE_IDLE_TIMER);
+	ufshcd_writel(hba, 0x1, REG_UTP_TRANSFER_REQ_LIST_RUN_STOP);
+	ufshcd_writel(hba, 0x1, REG_UTP_TASK_REQ_LIST_RUN_STOP);
+
+	return err;
+}
+
+static int ufs_rockchip_runtime_suspend(struct device *dev)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+	struct ufs_rockchip_host *host = ufshcd_get_variant(hba);
+
+	clk_disable_unprepare(host->ref_out_clk);
+	return ufs_rockchip_restore_link(hba, true);
+}
+
+static int ufs_rockchip_runtime_resume(struct device *dev)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+	struct ufs_rockchip_host *host = ufshcd_get_variant(hba);
+	int err;
+
+	err = clk_prepare_enable(host->ref_out_clk);
+	if (err) {
+		dev_err(hba->dev, "failed to enable ref out clock %d\n", err);
+		return err;
+	}
+
+	reset_control_assert(host->rst);
+	udelay(1);
+	reset_control_deassert(host->rst);
+
+	return ufs_rockchip_restore_link(hba, false);
+}
+
+static int ufs_rockchip_suspend(struct device *dev)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+
+	if (pm_runtime_suspended(hba->dev))
+		return 0;
+
+	ufs_rockchip_restore_link(hba, true);
+
+	return 0;
+}
+
+static int ufs_rockchip_resume(struct device *dev)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+
+	if (pm_runtime_suspended(hba->dev))
+		return 0;
+
+	/* Reset device if possible */
+	ufs_rockchip_device_reset(hba);
+	ufs_rockchip_restore_link(hba, false);
+
+	return 0;
+}
+
+static const struct dev_pm_ops ufs_rockchip_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(ufs_rockchip_suspend, ufs_rockchip_resume)
+	SET_RUNTIME_PM_OPS(ufs_rockchip_runtime_suspend, ufs_rockchip_runtime_resume, NULL)
+	.prepare	 = ufshcd_suspend_prepare,
+	.complete	 = ufshcd_resume_complete,
+};
+
+static struct platform_driver ufs_rockchip_pltform = {
+	.probe = ufs_rockchip_probe,
+	.remove = ufs_rockchip_remove,
+	.driver = {
+		.name = "ufshcd-rockchip",
+		.pm = &ufs_rockchip_pm_ops,
+		.of_match_table = of_match_ptr(ufs_rockchip_of_match),
+	},
+};
+module_platform_driver(ufs_rockchip_pltform);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Rockchip UFS Host Driver");
diff --git a/drivers/ufs/host/ufs-rockchip.h b/drivers/ufs/host/ufs-rockchip.h
new file mode 100644
index 0000000..7f3c260
--- /dev/null
+++ b/drivers/ufs/host/ufs-rockchip.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Rockchip UFS Host Controller driver
+ *
+ * Copyright (C) 2024 Rockchip Electronics Co.Ltd.
+ */
+
+#ifndef _UFS_ROCKCHIP_H_
+#define _UFS_ROCKCHIP_H_
+
+#define UFS_MAX_CLKS 3
+
+#define SEL_TX_LANE0 0x0
+#define SEL_TX_LANE1 0x1
+#define SEL_TX_LANE2 0x2
+#define SEL_TX_LANE3 0x3
+#define SEL_RX_LANE0 0x4
+#define SEL_RX_LANE1 0x5
+#define SEL_RX_LANE2 0x6
+#define SEL_RX_LANE3 0x7
+
+#define MIB_T_DBG_CPORT_TX_ENDIAN	0xc022
+#define MIB_T_DBG_CPORT_RX_ENDIAN	0xc023
+
+struct ufs_rockchip_host {
+	struct ufs_hba *hba;
+	void __iomem *ufs_phy_ctrl;
+	void __iomem *ufs_sys_ctrl;
+	void __iomem *mphy_base;
+	struct gpio_desc *rst_gpio;
+	struct reset_control *rst;
+	struct clk *ref_out_clk;
+	struct clk_bulk_data clks[UFS_MAX_CLKS];
+	uint64_t caps;
+	uint32_t phy_config_mode;
+	bool in_suspend;
+	u32 ie;
+	u32 ahit;
+};
+
+#define ufs_sys_writel(base, val, reg)                                    \
+	writel((val), (base) + (reg))
+#define ufs_sys_readl(base, reg) readl((base) + (reg))
+#define ufs_sys_set_bits(base, mask, reg)                                 \
+	ufs_sys_writel(                                                   \
+		(base), ((mask) | (ufs_sys_readl((base), (reg)))), (reg))
+#define ufs_sys_ctrl_clr_bits(base, mask, reg)                                 \
+	ufs_sys_writel((base),                                            \
+			    ((~(mask)) & (ufs_sys_readl((base), (reg)))), \
+			    (reg))
+
+#endif /* _UFS_ROCKCHIP_H_ */
-- 
2.7.4


