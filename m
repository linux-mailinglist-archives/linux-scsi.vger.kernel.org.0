Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A02F81C817A
	for <lists+linux-scsi@lfdr.de>; Thu,  7 May 2020 07:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgEGFTv (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 7 May 2020 01:19:51 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44168 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgEGFTv (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 7 May 2020 01:19:51 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0475JWS2009620;
        Thu, 7 May 2020 00:19:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588828772;
        bh=c4YaCY7TeANm0KI2GLZhgL6HdjrKVOJUzKfSAvHzsR4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=VqeP7CWmP0CPXhHEZF5MA6gPzkXYFrR/ry3E03gb0b9KVSj/hOeSAevUWgsrUH/lU
         KTT1XPUP1jw5QLMoPzr1AUFJ4IdXnKaZUVddD2J+xEZoiPl2nX29OBTRAf5hqmNsNo
         gOzuvvGTFm6TowZisc3CwcjmH+smDC+h7E6Kmis8=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0475JWAN061204
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 May 2020 00:19:32 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 7 May
 2020 00:19:32 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 7 May 2020 00:19:32 -0500
Received: from [10.250.233.85] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0475JRfE127994;
        Thu, 7 May 2020 00:19:28 -0500
Subject: Re: [PATCH v7 07/10] phy: samsung-ufs: add UFS PHY driver for samsung
 SoC
To:     Alim Akhtar <alim.akhtar@samsung.com>, <robh@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <krzk@kernel.org>, <avri.altman@wdc.com>,
        <martin.petersen@oracle.com>, <kwmad.kim@samsung.com>,
        <stanley.chu@mediatek.com>, <cang@codeaurora.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>
References: <20200426173024.63069-1-alim.akhtar@samsung.com>
 <CGME20200426174217epcas5p2c7d1606b641b73f67a169b8d22f0637d@epcas5p2.samsung.com>
 <20200426173024.63069-8-alim.akhtar@samsung.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <b0239aa5-004e-fc88-93a4-5b0d6f174ca3@ti.com>
Date:   Thu, 7 May 2020 10:49:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200426173024.63069-8-alim.akhtar@samsung.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

+Vinod

Hi Alim,

On 4/26/2020 11:00 PM, Alim Akhtar wrote:
> This patch introduces Samsung UFS PHY driver. This driver
> supports to deal with phy calibration and power control
> according to UFS host driver's behavior.
> 
> Reviewed-by: Kiwoong Kim <kwmad.kim@samsung.com>
> Signed-off-by: Seungwon Jeon <essuuj@gmail.com>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Tested-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  drivers/phy/samsung/Kconfig           |   9 +
>  drivers/phy/samsung/Makefile          |   1 +
>  drivers/phy/samsung/phy-exynos7-ufs.h |  85 ++++++
>  drivers/phy/samsung/phy-samsung-ufs.c | 369 ++++++++++++++++++++++++++
>  drivers/phy/samsung/phy-samsung-ufs.h | 142 ++++++++++
>  5 files changed, 606 insertions(+)
>  create mode 100644 drivers/phy/samsung/phy-exynos7-ufs.h
>  create mode 100644 drivers/phy/samsung/phy-samsung-ufs.c
>  create mode 100644 drivers/phy/samsung/phy-samsung-ufs.h
> 
> diff --git a/drivers/phy/samsung/Kconfig b/drivers/phy/samsung/Kconfig
> index 9e483d1fdaf2..fc1e3c17f842 100644
> --- a/drivers/phy/samsung/Kconfig
> +++ b/drivers/phy/samsung/Kconfig
> @@ -29,6 +29,15 @@ config PHY_EXYNOS_PCIE
>  	  Enable PCIe PHY support for Exynos SoC series.
>  	  This driver provides PHY interface for Exynos PCIe controller.
>  
> +config PHY_SAMSUNG_UFS
> +	tristate "SAMSUNG SoC series UFS PHY driver"
> +	depends on OF && (ARCH_EXYNOS || COMPILE_TEST)
> +	select GENERIC_PHY
> +	help
> +	  Enable this to support the Samsung UFS PHY driver for
> +	  Samsung SoCs. This driver provides the interface for UFS
> +	  host controller to do PHY related programming.
> +
>  config PHY_SAMSUNG_USB2
>  	tristate "Samsung USB 2.0 PHY driver"
>  	depends on HAS_IOMEM
> diff --git a/drivers/phy/samsung/Makefile b/drivers/phy/samsung/Makefile
> index db9b1aa0de6e..3959100fe8a2 100644
> --- a/drivers/phy/samsung/Makefile
> +++ b/drivers/phy/samsung/Makefile
> @@ -2,6 +2,7 @@
>  obj-$(CONFIG_PHY_EXYNOS_DP_VIDEO)	+= phy-exynos-dp-video.o
>  obj-$(CONFIG_PHY_EXYNOS_MIPI_VIDEO)	+= phy-exynos-mipi-video.o
>  obj-$(CONFIG_PHY_EXYNOS_PCIE)		+= phy-exynos-pcie.o
> +obj-$(CONFIG_PHY_SAMSUNG_UFS)		+= phy-samsung-ufs.o
>  obj-$(CONFIG_PHY_SAMSUNG_USB2)		+= phy-exynos-usb2.o
>  phy-exynos-usb2-y			+= phy-samsung-usb2.o
>  phy-exynos-usb2-$(CONFIG_PHY_EXYNOS4210_USB2)	+= phy-exynos4210-usb2.o
> diff --git a/drivers/phy/samsung/phy-exynos7-ufs.h b/drivers/phy/samsung/phy-exynos7-ufs.h
> new file mode 100644
> index 000000000000..da981c1ac040
> --- /dev/null
> +++ b/drivers/phy/samsung/phy-exynos7-ufs.h
> @@ -0,0 +1,85 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * UFS PHY driver data for Samsung EXYNOS7 SoC
> + *
> + * Copyright (C) 2015 Samsung Electronics Co., Ltd.
> + */
> +#ifndef _PHY_EXYNOS7_UFS_H_
> +#define _PHY_EXYNOS7_UFS_H_
> +
> +#include "phy-samsung-ufs.h"
> +
> +#define EXYNOS7_EMBEDDED_COMBO_PHY_CTRL	0x720
> +#define EXYNOS7_EMBEDDED_COMBO_PHY_CTRL_MASK	0x1
> +#define EXYNOS7_EMBEDDED_COMBO_PHY_CTRL_EN	BIT(0)
> +
> +/* Calibration for phy initialization */
> +static const struct samsung_ufs_phy_cfg exynos7_pre_init_cfg[] = {
> +	PHY_COMN_REG_CFG(0x00f, 0xfa, PWR_MODE_ANY),
> +	PHY_COMN_REG_CFG(0x010, 0x82, PWR_MODE_ANY),
> +	PHY_COMN_REG_CFG(0x011, 0x1e, PWR_MODE_ANY),
> +	PHY_COMN_REG_CFG(0x017, 0x84, PWR_MODE_ANY),
> +	PHY_TRSV_REG_CFG(0x035, 0x58, PWR_MODE_ANY),
> +	PHY_TRSV_REG_CFG(0x036, 0x32, PWR_MODE_ANY),
> +	PHY_TRSV_REG_CFG(0x037, 0x40, PWR_MODE_ANY),
> +	PHY_TRSV_REG_CFG(0x03b, 0x83, PWR_MODE_ANY),
> +	PHY_TRSV_REG_CFG(0x042, 0x88, PWR_MODE_ANY),
> +	PHY_TRSV_REG_CFG(0x043, 0xa6, PWR_MODE_ANY),
> +	PHY_TRSV_REG_CFG(0x048, 0x74, PWR_MODE_ANY),
> +	PHY_TRSV_REG_CFG(0x04c, 0x5b, PWR_MODE_ANY),
> +	PHY_TRSV_REG_CFG(0x04d, 0x83, PWR_MODE_ANY),
> +	PHY_TRSV_REG_CFG(0x05c, 0x14, PWR_MODE_ANY),
> +	END_UFS_PHY_CFG
> +};
> +
> +static const struct samsung_ufs_phy_cfg exynos7_post_init_cfg[] = {
> +	END_UFS_PHY_CFG
> +};
> +
> +/* Calibration for HS mode series A/B */
> +static const struct samsung_ufs_phy_cfg exynos7_pre_pwr_hs_cfg[] = {
> +	PHY_COMN_REG_CFG(0x00f, 0xfa, PWR_MODE_HS_ANY),
> +	PHY_COMN_REG_CFG(0x010, 0x82, PWR_MODE_HS_ANY),
> +	PHY_COMN_REG_CFG(0x011, 0x1e, PWR_MODE_HS_ANY),
> +	/* Setting order: 1st(0x16, 2nd(0x15) */
> +	PHY_COMN_REG_CFG(0x016, 0xff, PWR_MODE_HS_ANY),
> +	PHY_COMN_REG_CFG(0x015, 0x80, PWR_MODE_HS_ANY),
> +	PHY_COMN_REG_CFG(0x017, 0x94, PWR_MODE_HS_ANY),
> +	PHY_TRSV_REG_CFG(0x036, 0x32, PWR_MODE_HS_ANY),
> +	PHY_TRSV_REG_CFG(0x037, 0x43, PWR_MODE_HS_ANY),
> +	PHY_TRSV_REG_CFG(0x038, 0x3f, PWR_MODE_HS_ANY),
> +	PHY_TRSV_REG_CFG(0x042, 0x88, PWR_MODE_HS_G2_SER_A),
> +	PHY_TRSV_REG_CFG(0x042, 0xbb, PWR_MODE_HS_G2_SER_B),
> +	PHY_TRSV_REG_CFG(0x043, 0xa6, PWR_MODE_HS_ANY),
> +	PHY_TRSV_REG_CFG(0x048, 0x74, PWR_MODE_HS_ANY),
> +	PHY_TRSV_REG_CFG(0x034, 0x35, PWR_MODE_HS_G2_SER_A),
> +	PHY_TRSV_REG_CFG(0x034, 0x36, PWR_MODE_HS_G2_SER_B),
> +	PHY_TRSV_REG_CFG(0x035, 0x5b, PWR_MODE_HS_G2_SER_A),
> +	PHY_TRSV_REG_CFG(0x035, 0x5c, PWR_MODE_HS_G2_SER_B),
> +	END_UFS_PHY_CFG
> +};
> +
> +/* Calibration for HS mode series A/B atfer PMC */
> +static const struct samsung_ufs_phy_cfg exynos7_post_pwr_hs_cfg[] = {
> +	PHY_COMN_REG_CFG(0x015, 0x00, PWR_MODE_HS_ANY),
> +	PHY_TRSV_REG_CFG(0x04d, 0x83, PWR_MODE_HS_ANY),
> +	END_UFS_PHY_CFG
> +};
> +
> +static const struct samsung_ufs_phy_cfg *exynos7_ufs_phy_cfgs[CFG_TAG_MAX] = {
> +	[CFG_PRE_INIT]		= exynos7_pre_init_cfg,
> +	[CFG_POST_INIT]		= exynos7_post_init_cfg,
> +	[CFG_PRE_PWR_HS]	= exynos7_pre_pwr_hs_cfg,
> +	[CFG_POST_PWR_HS]	= exynos7_post_pwr_hs_cfg,
> +};
> +
> +static struct samsung_ufs_phy_drvdata exynos7_ufs_phy = {
> +	.cfg = exynos7_ufs_phy_cfgs,
> +	.isol = {
> +		.offset = EXYNOS7_EMBEDDED_COMBO_PHY_CTRL,
> +		.mask = EXYNOS7_EMBEDDED_COMBO_PHY_CTRL_MASK,
> +		.en = EXYNOS7_EMBEDDED_COMBO_PHY_CTRL_EN,
> +	},
> +};
> +
> +#endif /* _PHY_EXYNOS7_UFS_H_ */
> diff --git a/drivers/phy/samsung/phy-samsung-ufs.c b/drivers/phy/samsung/phy-samsung-ufs.c
> new file mode 100644
> index 000000000000..4c8334bba3e9
> --- /dev/null
> +++ b/drivers/phy/samsung/phy-samsung-ufs.c
> @@ -0,0 +1,369 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * UFS PHY driver for Samsung SoC
> + *
> + * Copyright (C) 2015 Samsung Electronics Co., Ltd.

2020
> + * Author: Seungwon Jeon <essuuj@gmail.com>
> + * Author: Alim Akhtar <alim.akhtar@samsung.com>
> + *
> + */
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/of.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#include "phy-samsung-ufs.h"
> +
> +#define for_each_phy_lane(phy, i) \
> +	for (i = 0; i < (phy)->lane_cnt; i++)
> +#define for_each_phy_cfg(cfg) \
> +	for (; (cfg)->id; (cfg)++)
> +
> +#define PHY_DEF_LANE_CNT	1
> +
> +static void samsung_ufs_phy_config(struct samsung_ufs_phy *phy,
> +			const struct samsung_ufs_phy_cfg *cfg, u8 lane)
> +{
> +	enum {LANE_0, LANE_1}; /* lane index */
> +
> +	switch (lane) {
> +	case LANE_0:
> +		writel(cfg->val, (phy)->reg_pma + cfg->off_0);
> +		break;
> +	case LANE_1:
> +		if (cfg->id == PHY_TRSV_BLK)
> +			writel(cfg->val, (phy)->reg_pma + cfg->off_1);
> +		break;
> +	}
> +}
> +
> +int samsung_ufs_phy_wait_for_lock_acq(struct phy *phy)
> +{
> +	struct samsung_ufs_phy *ufs_phy = get_samsung_ufs_phy(phy);
> +	const unsigned int timeout_us = 100000;
> +	const unsigned int sleep_us = 10;
> +	u32 val;
> +	int err;
> +
> +	err = readl_poll_timeout(
> +			ufs_phy->reg_pma + PHY_APB_ADDR(PHY_PLL_LOCK_STATUS),
> +			val, (val & PHY_PLL_LOCK_BIT), sleep_us, timeout_us);
> +	if (err) {
> +		dev_err(ufs_phy->dev,
> +			"failed to get phy pll lock acquisition %d\n", err);
> +		goto out;
> +	}
> +
> +	err = readl_poll_timeout(
> +			ufs_phy->reg_pma + PHY_APB_ADDR(PHY_CDR_LOCK_STATUS),
> +			val, (val & PHY_CDR_LOCK_BIT), sleep_us, timeout_us);
> +	if (err) {
> +		dev_err(ufs_phy->dev,
> +			"failed to get phy cdr lock acquisition %d\n", err);
> +		goto out;
> +	}
> +
> +out:
> +	return err;
> +}
> +
> +int samsung_ufs_phy_calibrate(struct phy *phy)
> +{
> +	struct samsung_ufs_phy *ufs_phy = get_samsung_ufs_phy(phy);
> +	struct samsung_ufs_phy_cfg **cfgs = ufs_phy->cfg;
> +	const struct samsung_ufs_phy_cfg *cfg;
> +	int i;
> +	int err = 0;
> +
> +	if (unlikely(ufs_phy->ufs_phy_state < CFG_PRE_INIT ||
> +		     ufs_phy->ufs_phy_state >= CFG_TAG_MAX)) {
> +		dev_err(ufs_phy->dev, "invalid phy config index %d\n",
> +							ufs_phy->ufs_phy_state);
> +		return -EINVAL;
> +	}
> +
> +	if (ufs_phy->is_pre_init)
> +		ufs_phy->is_pre_init = false;
> +	if (ufs_phy->is_post_init) {
> +		ufs_phy->is_post_init = false;
> +		ufs_phy->ufs_phy_state = CFG_POST_INIT;
> +	}
> +	if (ufs_phy->is_pre_pmc) {
> +		ufs_phy->is_pre_pmc = false;
> +		ufs_phy->ufs_phy_state = CFG_PRE_PWR_HS;
> +	}
> +	if (ufs_phy->is_post_pmc) {
> +		ufs_phy->is_post_pmc = false;
> +		ufs_phy->ufs_phy_state = CFG_POST_PWR_HS;
> +	}
> +
> +	switch (ufs_phy->ufs_phy_state) {
> +	case CFG_PRE_INIT:
> +		ufs_phy->is_post_init = true;
> +		break;
> +	case CFG_POST_INIT:
> +		ufs_phy->is_pre_pmc = true;
> +		break;
> +	case CFG_PRE_PWR_HS:
> +		ufs_phy->is_post_pmc = true;
> +		break;
> +	case CFG_POST_PWR_HS:
> +		break;
> +	default:
> +		dev_err(ufs_phy->dev, "wrong state for phy calibration\n");
> +	}
> +
> +	cfg = cfgs[ufs_phy->ufs_phy_state];
> +	if (!cfg)
> +		goto out;
> +
> +	for_each_phy_cfg(cfg) {
> +		for_each_phy_lane(ufs_phy, i) {
> +			samsung_ufs_phy_config(ufs_phy, cfg, i);
> +		}
> +	}

Okay, here you are using a state machine for the PHY configuration because of
the way the PHY is integrated with the UFS. Would be nice to have the state
machine documented somewhere. I only have the PHY patch in my inbox.
> +
> +	if (ufs_phy->ufs_phy_state == CFG_POST_PWR_HS)
> +		err = samsung_ufs_phy_wait_for_lock_acq(phy);
> +out:
> +	return err;
> +}
> +
> +static int samsung_ufs_phy_symbol_clk_init(struct samsung_ufs_phy *phy)
> +{
> +	struct clk *clk;
> +	int ret = 0;
> +
> +	clk = devm_clk_get(phy->dev, "tx0_symbol_clk");

There is no "exit" callback in phy_ops which means if there are multiple
phy_init calls, this clock will not be freed. This could be moved to "probe" IMO.
> +	if (IS_ERR(clk)) {
> +		dev_err(phy->dev, "failed to get tx0_symbol_clk clock\n");
> +		goto out;
> +	} else {

"else" here and below is not required. Something like below

	clk = devm_clk_get(phy->dev, "tx0_symbol_clk");
	if (IS_ERR(clk)) {
		dev_err(phy->dev, "failed to get tx0_symbol_clk clock\n");
		goto out;
	}
	phy->tx0_symbol_clk = clk;
	
> +		phy->tx0_symbol_clk = clk;
> +	}
> +
> +	clk = devm_clk_get(phy->dev, "rx0_symbol_clk");
> +	if (IS_ERR(clk)) {
> +		dev_err(phy->dev, "failed to get rx0_symbol_clk clock\n");
> +		goto out;
> +	} else {
> +		phy->rx0_symbol_clk = clk;
> +	}
> +
> +	clk = devm_clk_get(phy->dev, "rx1_symbol_clk");
> +	if (IS_ERR(clk)) {
> +		dev_err(phy->dev, "failed to get rx1_symbol_clk clock\n");
> +		goto out;
> +	} else {
> +		phy->rx1_symbol_clk = clk;
> +	}
> +
> +	ret = clk_prepare_enable(phy->tx0_symbol_clk);
> +	if (ret) {
> +		dev_err(phy->dev, "%s: tx0_symbol_clk enable failed %d\n",
> +				__func__, ret);
> +		goto out;
> +	}
> +	ret = clk_prepare_enable(phy->rx0_symbol_clk);
> +	if (ret) {
> +		dev_err(phy->dev, "%s: rx0_symbol_clk enable failed %d\n",
> +				__func__, ret);
> +		goto out;
> +	}
> +	ret = clk_prepare_enable(phy->rx1_symbol_clk);
> +	if (ret) {
> +		dev_err(phy->dev, "%s: rx1_symbol_clk enable failed %d\n",
> +				__func__, ret);
> +		goto out;
> +	}

All these clocks are never disabled?
> +out:
> +	return ret;
> +}
> +
> +static int samsung_ufs_phy_clks_init(struct samsung_ufs_phy *phy)
> +{
> +	struct clk *phy_ref_clk;
> +	int ret;
> +
> +	phy_ref_clk = devm_clk_get(phy->dev, "ref_clk");
> +	if (IS_ERR(phy_ref_clk))
> +		dev_err(phy->dev, "failed to get ref_clk clock\n");
> +	else
> +		phy->ref_clk = phy_ref_clk;
> +
> +	ret = clk_prepare_enable(phy->ref_clk);
> +	if (ret) {
> +		dev_err(phy->dev, "%s: ref_clk enable failed %d\n",
> +				__func__, ret);
> +		return ret;
> +	}
> +
> +	dev_info(phy->dev, "UFS MPHY ref_clk_rate = %ld\n", clk_get_rate(phy_ref_clk));
> +
> +	return 0;
> +}
> +
> +static int samsung_ufs_phy_init(struct phy *phy)
> +{
> +	struct samsung_ufs_phy *_phy = get_samsung_ufs_phy(phy);
> +	int ret;
> +
> +	_phy->lane_cnt = phy->attrs.bus_width;
> +	_phy->ufs_phy_state = CFG_PRE_INIT;
> +
> +	_phy->is_pre_init = true;
> +	_phy->is_post_init = false;
> +	_phy->is_pre_pmc = false;
> +	_phy->is_post_pmc = false;
> +
> +
> +	if (of_device_is_compatible(_phy->dev->of_node,
> +				"samsung,exynos7-ufs-phy")) {

Can't it be added in driver data for this compatible?
> +		ret = samsung_ufs_phy_symbol_clk_init(_phy);
> +		if (ret)
> +			dev_err(_phy->dev,
> +				"failed to set ufs phy symbol clocks\n");
> +	}
> +
> +	ret = samsung_ufs_phy_clks_init(_phy);
> +	if (ret)
> +		dev_err(_phy->dev, "failed to set ufs phy  clocks\n");
> +
> +	samsung_ufs_phy_calibrate(phy);
> +
> +	return 0;
> +}
> +
> +static int samsung_ufs_phy_power_on(struct phy *phy)
> +{
> +	struct samsung_ufs_phy *_phy = get_samsung_ufs_phy(phy);
> +
> +	samsung_ufs_phy_ctrl_isol(_phy, false);
> +	return 0;
> +}
> +
> +static int samsung_ufs_phy_power_off(struct phy *phy)
> +{
> +	struct samsung_ufs_phy *_phy = get_samsung_ufs_phy(phy);
> +
> +	samsung_ufs_phy_ctrl_isol(_phy, true);
> +	clk_disable_unprepare(_phy->ref_clk);
> +	return 0;
> +}
> +
> +static int samsung_ufs_phy_set_mode(struct phy *generic_phy,
> +					enum phy_mode mode, int submode)
> +{
> +	struct samsung_ufs_phy *_phy = get_samsung_ufs_phy(generic_phy);
> +
> +	_phy->mode = PHY_MODE_INVALID;
> +
> +	if (mode > 0)
> +		_phy->mode = mode;
> +
> +	return 0;
> +}
> +
> +static struct phy_ops samsung_ufs_phy_ops = {
> +	.init		= samsung_ufs_phy_init,
> +	.power_on	= samsung_ufs_phy_power_on,
> +	.power_off	= samsung_ufs_phy_power_off,
> +	.calibrate	= samsung_ufs_phy_calibrate,
> +	.set_mode	= samsung_ufs_phy_set_mode,

missing .owner.
> +}
> +;
> +static const struct of_device_id samsung_ufs_phy_match[];
> +
> +static int samsung_ufs_phy_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct resource *res;
> +	const struct of_device_id *match;
> +	struct samsung_ufs_phy *phy;
> +	struct phy *gen_phy;
> +	struct phy_provider *phy_provider;
> +	const struct samsung_ufs_phy_drvdata *drvdata;
> +	int err = 0;
> +
> +	match = of_match_node(samsung_ufs_phy_match, dev->of_node);
> +	if (!match) {
> +		err = -EINVAL;
> +		dev_err(dev, "failed to get match_node\n");
> +		goto out;
> +	}
> +
> +	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
> +	if (!phy) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "phy-pma");
> +	phy->reg_pma = devm_ioremap_resource(dev, res);

devm_platform_ioremap_resource_byname() instead?
> +	if (IS_ERR(phy->reg_pma)) {
> +		err = PTR_ERR(phy->reg_pma);
> +		goto out;
> +	}
> +
> +	phy->reg_pmu = syscon_regmap_lookup_by_phandle(
> +				dev->of_node, "samsung,pmu-syscon");
> +	if (IS_ERR(phy->reg_pmu)) {
> +		err = PTR_ERR(phy->reg_pmu);
> +		dev_err(dev, "failed syscon remap for pmu\n");
> +		goto out;
> +	}
> +
> +	gen_phy = devm_phy_create(dev, NULL, &samsung_ufs_phy_ops);
> +	if (IS_ERR(gen_phy)) {
> +		err = PTR_ERR(gen_phy);
> +		dev_err(dev, "failed to create PHY for ufs-phy\n");
> +		goto out;
> +	}
> +
> +	drvdata = match->data;
> +	phy->dev = dev;
> +	phy->drvdata = drvdata;
> +	phy->cfg = (struct samsung_ufs_phy_cfg **)drvdata->cfg;
> +	phy->isol = &drvdata->isol;
> +	phy->lane_cnt = PHY_DEF_LANE_CNT;
> +
> +	phy_set_drvdata(gen_phy, phy);
> +
> +	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> +	if (IS_ERR(phy_provider)) {
> +		err = PTR_ERR(phy_provider);
> +		dev_err(dev, "failed to register phy-provider\n");
> +		goto out;
> +	}
> +out:
> +	return err;
> +}
> +
> +static const struct of_device_id samsung_ufs_phy_match[] = {
> +	{
> +		.compatible = "samsung,exynos7-ufs-phy",
> +		.data = &exynos7_ufs_phy,
> +	},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, samsung_ufs_phy_match);
> +
> +static struct platform_driver samsung_ufs_phy_driver = {
> +	.probe  = samsung_ufs_phy_probe,
> +	.driver = {
> +		.name = "samsung-ufs-phy",
> +		.of_match_table = samsung_ufs_phy_match,
> +	},
> +};
> +module_platform_driver(samsung_ufs_phy_driver);
> +MODULE_DESCRIPTION("Samsung SoC UFS PHY Driver");
> +MODULE_AUTHOR("Seungwon Jeon <essuuj@gmail.com>");
> +MODULE_AUTHOR("Alim Akhtar <alim.akhtar@samsung.com>");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/phy/samsung/phy-samsung-ufs.h b/drivers/phy/samsung/phy-samsung-ufs.h
> new file mode 100644
> index 000000000000..27dc1b573469
> --- /dev/null
> +++ b/drivers/phy/samsung/phy-samsung-ufs.h
> @@ -0,0 +1,142 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * UFS PHY driver for Samsung EXYNOS SoC
> + *
> + * Copyright (C) 2015 Samsung Electronics Co., Ltd.

2020

Thanks
Kishon
