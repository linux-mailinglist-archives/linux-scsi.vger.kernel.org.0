Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63277327929
	for <lists+linux-scsi@lfdr.de>; Mon,  1 Mar 2021 09:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbhCAI05 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 1 Mar 2021 03:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbhCAI04 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 1 Mar 2021 03:26:56 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D28C06174A
        for <linux-scsi@vger.kernel.org>; Mon,  1 Mar 2021 00:26:16 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id i14so8971073pjz.4
        for <linux-scsi@vger.kernel.org>; Mon, 01 Mar 2021 00:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=02nNFKK+l8Y+yKpUl6oiINN43CgD3X28tI/v31aW7J0=;
        b=e4ZiDOovDWHg6VU1XXPDd5xUlYUx/SjI6lTu0FedSOPPc/xXU7poCLax8+Nh9PlZWT
         r2K0fGmfzvtA8+KtDoz/YiwObYWo/tN56anS6icZdmi4KN/MDHwwQ3FDg7d2XynWtw7/
         lqW02SnfqQF8MiqXBIa6ZATj8QMrT6QhwOxo3hkAvxnabfMTslIj95I8wBAFsFvfYKZu
         0tOhk1tXsv5Rh2pPLoge1HuiZJRdzJKzhXYrub8LHkmbpTgiTAckNPmr5ECdNVPjP3NH
         eluYuf7GK2Qqr4HU05INXtJRhL2ZIDawCH3r1SJMq+ufmSXEK2z+ulsM/1JKjcXJf9L0
         wIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=02nNFKK+l8Y+yKpUl6oiINN43CgD3X28tI/v31aW7J0=;
        b=QSwakV7i539ccqgnl1ExryvPLCX0TCMM7WykQg+j1i0f1NSbsXTfFBaM4bOZCAymlP
         3gbo02xZn6ABGPWSdZ2Dh+SJxkVDKHfZf+/ZoNgn4GUACQe98p+z46Srw+Q9fA9PKIC1
         STFTC5UkE1dwprpupw210p9B+pO/3lAkdBfsjTYX2baYIfgkG/0JRXzG7uBvmstR2RA5
         VuEZz2rkr/Jvs0f0CfpQE06upsNMjc2NBmc+/4GCJAk1JIMi9H+IfUPCZSerlzGLQZZ7
         T93ofkoqxCLHvt0fKHYx/nKpIBU5Pcep0IaxkrIdpn/pjVqxCCUqTHzMPjW2BlMIuvm2
         IaVA==
X-Gm-Message-State: AOAM530fNCAV5GuRM/DRHBSV5CtQ91Xp6ziQ70O7/3HTPA8rqVVvASEa
        ml+EGGzzMYg8Ebahi5nVCoCN7A==
X-Google-Smtp-Source: ABdhPJy1pJueXaKB10c3K5RfQhXW5+uKM602oOlrW6bDYihaEIyW012WHgqz9/0v5zEHRB3ABcH7Xw==
X-Received: by 2002:a17:902:bd44:b029:de:74ae:771e with SMTP id b4-20020a170902bd44b02900de74ae771emr14730949plx.73.1614587175615;
        Mon, 01 Mar 2021 00:26:15 -0800 (PST)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id a1sm12763426pff.156.2021.03.01.00.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 00:26:15 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-scsi@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH] scsi: ufs-qcom: initialize PHY for ACPI boot
Date:   Mon,  1 Mar 2021 16:26:09 +0800
Message-Id: <20210301082609.21051-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

When booting Lenovo Flex 5G laptop (powered by Qualcomm SC8180x SoC)
from ACPI, UFS is not working, because the generic QMP PHY driver that
takes care of UFS PHY init only works with DT.  It adds a specialized
PHY init function to get UFS work with ACPI boot on this platform,
where UFS 3.0 and QMP V4 PHY is combined to support UFS.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/scsi/ufs/Makefile       |   1 +
 drivers/scsi/ufs/ufs-qcom-phy.c | 349 ++++++++++++++++++++++++++++++++
 drivers/scsi/ufs/ufs-qcom.c     |   4 +
 drivers/scsi/ufs/ufs-qcom.h     |  11 +
 drivers/scsi/ufs/ufshci.h       |   1 +
 5 files changed, 366 insertions(+)
 create mode 100644 drivers/scsi/ufs/ufs-qcom-phy.c

diff --git a/drivers/scsi/ufs/Makefile b/drivers/scsi/ufs/Makefile
index 06f3a3fe4a44..15f561de0cbf 100644
--- a/drivers/scsi/ufs/Makefile
+++ b/drivers/scsi/ufs/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_SCSI_UFS_CDNS_PLATFORM) += cdns-pltfrm.o
 obj-$(CONFIG_SCSI_UFS_QCOM) += ufs_qcom.o
 ufs_qcom-y += ufs-qcom.o
 ufs_qcom-$(CONFIG_SCSI_UFS_CRYPTO) += ufs-qcom-ice.o
+ufs_qcom-$(CONFIG_ACPI) += ufs-qcom-phy.o
 obj-$(CONFIG_SCSI_UFS_EXYNOS) += ufs-exynos.o
 obj-$(CONFIG_SCSI_UFSHCD_PCI) += ufshcd-pci.o
 obj-$(CONFIG_SCSI_UFSHCD_PLATFORM) += ufshcd-pltfrm.o
diff --git a/drivers/scsi/ufs/ufs-qcom-phy.c b/drivers/scsi/ufs/ufs-qcom-phy.c
new file mode 100644
index 000000000000..113292f9637d
--- /dev/null
+++ b/drivers/scsi/ufs/ufs-qcom-phy.c
@@ -0,0 +1,349 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2021, Linaro Limited
+ */
+
+#include <linux/iopoll.h>
+
+#include "ufshcd.h"
+
+/* Only for QMP V4 PHY - QSERDES COM registers */
+#define QSERDES_V4_COM_SSC_EN_CENTER			0x010
+#define QSERDES_V4_COM_SSC_PER1				0x01c
+#define QSERDES_V4_COM_SSC_PER2				0x020
+#define QSERDES_V4_COM_SSC_STEP_SIZE1_MODE0		0x024
+#define QSERDES_V4_COM_SSC_STEP_SIZE2_MODE0		0x028
+#define QSERDES_V4_COM_SSC_STEP_SIZE1_MODE1		0x030
+#define QSERDES_V4_COM_SSC_STEP_SIZE2_MODE1		0x034
+#define QSERDES_V4_COM_CLK_ENABLE1			0x048
+#define QSERDES_V4_COM_SYSCLK_BUF_ENABLE		0x050
+#define QSERDES_V4_COM_PLL_IVCO				0x058
+#define QSERDES_V4_COM_CMN_IPTRIM			0x060
+#define QSERDES_V4_COM_CP_CTRL_MODE0			0x074
+#define QSERDES_V4_COM_CP_CTRL_MODE1			0x078
+#define QSERDES_V4_COM_PLL_RCTRL_MODE0			0x07c
+#define QSERDES_V4_COM_PLL_RCTRL_MODE1			0x080
+#define QSERDES_V4_COM_PLL_CCTRL_MODE0			0x084
+#define QSERDES_V4_COM_PLL_CCTRL_MODE1			0x088
+#define QSERDES_V4_COM_SYSCLK_EN_SEL			0x094
+#define QSERDES_V4_COM_LOCK_CMP_EN			0x0a4
+#define QSERDES_V4_COM_LOCK_CMP1_MODE0			0x0ac
+#define QSERDES_V4_COM_LOCK_CMP2_MODE0			0x0b0
+#define QSERDES_V4_COM_LOCK_CMP1_MODE1			0x0b4
+#define QSERDES_V4_COM_DEC_START_MODE0			0x0bc
+#define QSERDES_V4_COM_LOCK_CMP2_MODE1			0x0b8
+#define QSERDES_V4_COM_DEC_START_MODE1			0x0c4
+#define QSERDES_V4_COM_DIV_FRAC_START1_MODE0		0x0cc
+#define QSERDES_V4_COM_DIV_FRAC_START2_MODE0		0x0d0
+#define QSERDES_V4_COM_DIV_FRAC_START3_MODE0		0x0d4
+#define QSERDES_V4_COM_DIV_FRAC_START1_MODE1		0x0d8
+#define QSERDES_V4_COM_DIV_FRAC_START2_MODE1		0x0dc
+#define QSERDES_V4_COM_DIV_FRAC_START3_MODE1		0x0e0
+#define QSERDES_V4_COM_VCO_TUNE_MAP			0x10c
+#define QSERDES_V4_COM_VCO_TUNE1_MODE0			0x110
+#define QSERDES_V4_COM_VCO_TUNE2_MODE0			0x114
+#define QSERDES_V4_COM_VCO_TUNE1_MODE1			0x118
+#define QSERDES_V4_COM_VCO_TUNE2_MODE1			0x11c
+#define QSERDES_V4_COM_VCO_TUNE_INITVAL2		0x124
+#define QSERDES_V4_COM_CLK_SELECT			0x154
+#define QSERDES_V4_COM_HSCLK_SEL			0x158
+#define QSERDES_V4_COM_HSCLK_HS_SWITCH_SEL		0x15c
+#define QSERDES_V4_COM_CORECLK_DIV_MODE1		0x16c
+#define QSERDES_V4_COM_SVS_MODE_CLK_SEL			0x184
+#define QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE1_MODE0	0x1ac
+#define QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE2_MODE0	0x1b0
+#define QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE1_MODE1	0x1b4
+#define QSERDES_V4_COM_BIN_VCOCAL_HSCLK_SEL		0x1bc
+#define QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE2_MODE1	0x1b8
+
+/* Only for QMP V4 PHY - TX registers */
+#define QSERDES_V4_TX_RES_CODE_LANE_TX			0x34
+#define QSERDES_V4_TX_RES_CODE_LANE_RX			0x38
+#define QSERDES_V4_TX_RES_CODE_LANE_OFFSET_TX		0x3c
+#define QSERDES_V4_TX_RES_CODE_LANE_OFFSET_RX		0x40
+#define QSERDES_V4_TX_LANE_MODE_1			0x84
+#define QSERDES_V4_TX_LANE_MODE_2			0x88
+#define QSERDES_V4_TX_RCV_DETECT_LVL_2			0x9c
+#define QSERDES_V4_TX_PWM_GEAR_1_DIVIDER_BAND0_1	0xd8
+#define QSERDES_V4_TX_PWM_GEAR_2_DIVIDER_BAND0_1	0xdC
+#define QSERDES_V4_TX_PWM_GEAR_3_DIVIDER_BAND0_1	0xe0
+#define QSERDES_V4_TX_PWM_GEAR_4_DIVIDER_BAND0_1	0xe4
+#define QSERDES_V4_TX_TRAN_DRVR_EMP_EN			0xb8
+#define QSERDES_V4_TX_PI_QEC_CTRL			0x104
+
+/* Only for QMP V4 PHY - RX registers */
+#define QSERDES_V4_RX_UCDR_FO_GAIN			0x008
+#define QSERDES_V4_RX_UCDR_SO_GAIN			0x014
+#define QSERDES_V4_RX_UCDR_FASTLOCK_FO_GAIN		0x030
+#define QSERDES_V4_RX_UCDR_SO_SATURATION_AND_ENABLE	0x034
+#define QSERDES_V4_RX_UCDR_FASTLOCK_COUNT_LOW		0x03c
+#define QSERDES_V4_RX_UCDR_FASTLOCK_COUNT_HIGH		0x040
+#define QSERDES_V4_RX_UCDR_PI_CONTROLS			0x044
+#define QSERDES_V4_RX_UCDR_PI_CTRL2			0x048
+#define QSERDES_V4_RX_UCDR_SB2_THRESH1			0x04c
+#define QSERDES_V4_RX_UCDR_SB2_THRESH2			0x050
+#define QSERDES_V4_RX_UCDR_SB2_GAIN1			0x054
+#define QSERDES_V4_RX_UCDR_SB2_GAIN2			0x058
+#define QSERDES_V4_RX_AUX_DATA_TCOARSE_TFINE		0x060
+#define QSERDES_V4_RX_RCLK_AUXDATA_SEL			0x064
+#define QSERDES_V4_RX_AC_JTAG_ENABLE			0x068
+#define QSERDES_V4_RX_AC_JTAG_MODE			0x078
+#define QSERDES_V4_RX_RX_TERM_BW			0x080
+#define QSERDES_V4_RX_VGA_CAL_CNTRL1			0x0d4
+#define QSERDES_V4_RX_VGA_CAL_CNTRL2			0x0d8
+#define QSERDES_V4_RX_GM_CAL				0x0dc
+#define QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL1		0x0e8
+#define QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL2		0x0ec
+#define QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL3		0x0f0
+#define QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL4		0x0f4
+#define QSERDES_V4_RX_RX_IDAC_TSETTLE_LOW		0x0f8
+#define QSERDES_V4_RX_RX_IDAC_TSETTLE_HIGH		0x0fc
+#define QSERDES_V4_RX_RX_IDAC_MEASURE_TIME		0x100
+#define QSERDES_V4_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1	0x110
+#define QSERDES_V4_RX_RX_OFFSET_ADAPTOR_CNTRL2		0x114
+#define QSERDES_V4_RX_SIGDET_ENABLES			0x118
+#define QSERDES_V4_RX_SIGDET_CNTRL			0x11c
+#define QSERDES_V4_RX_SIGDET_LVL			0x120
+#define QSERDES_V4_RX_SIGDET_DEGLITCH_CNTRL		0x124
+#define QSERDES_V4_RX_RX_BAND				0x128
+#define QSERDES_V4_RX_RX_MODE_00_LOW			0x170
+#define QSERDES_V4_RX_RX_MODE_00_HIGH			0x174
+#define QSERDES_V4_RX_RX_MODE_00_HIGH2			0x178
+#define QSERDES_V4_RX_RX_MODE_00_HIGH3			0x17c
+#define QSERDES_V4_RX_RX_MODE_00_HIGH4			0x180
+#define QSERDES_V4_RX_RX_MODE_01_LOW			0x184
+#define QSERDES_V4_RX_RX_MODE_01_HIGH			0x188
+#define QSERDES_V4_RX_RX_MODE_01_HIGH2			0x18c
+#define QSERDES_V4_RX_RX_MODE_01_HIGH3			0x190
+#define QSERDES_V4_RX_RX_MODE_01_HIGH4			0x194
+#define QSERDES_V4_RX_RX_MODE_10_LOW			0x198
+#define QSERDES_V4_RX_RX_MODE_10_HIGH			0x19c
+#define QSERDES_V4_RX_RX_MODE_10_HIGH2			0x1a0
+#define QSERDES_V4_RX_RX_MODE_10_HIGH3			0x1a4
+#define QSERDES_V4_RX_RX_MODE_10_HIGH4			0x1a8
+#define QSERDES_V4_RX_DFE_EN_TIMER			0x1b4
+#define QSERDES_V4_RX_DFE_CTLE_POST_CAL_OFFSET		0x1b8
+#define QSERDES_V4_RX_DCC_CTRL1				0x1bc
+#define QSERDES_V4_RX_VTH_CODE				0x1c4
+
+/* Only for QMP V4 PHY - UFS PCS registers */
+#define QPHY_V4_PCS_UFS_PHY_START			0x000
+#define QPHY_V4_PCS_UFS_POWER_DOWN_CONTROL		0x004
+#define QPHY_V4_PCS_UFS_SW_RESET			0x008
+#define QPHY_V4_PCS_UFS_TIMER_20US_CORECLK_STEPS_MSB	0x00c
+#define QPHY_V4_PCS_UFS_TIMER_20US_CORECLK_STEPS_LSB	0x010
+#define QPHY_V4_PCS_UFS_PLL_CNTL			0x02c
+#define QPHY_V4_PCS_UFS_TX_LARGE_AMP_DRV_LVL		0x030
+#define QPHY_V4_PCS_UFS_TX_SMALL_AMP_DRV_LVL		0x038
+#define QPHY_V4_PCS_UFS_BIST_FIXED_PAT_CTRL		0x060
+#define QPHY_V4_PCS_UFS_TX_HSGEAR_CAPABILITY		0x074
+#define QPHY_V4_PCS_UFS_RX_HSGEAR_CAPABILITY		0x0b4
+#define QPHY_V4_PCS_UFS_DEBUG_BUS_CLKSEL		0x124
+#define QPHY_V4_PCS_UFS_LINECFG_DISABLE			0x148
+#define QPHY_V4_PCS_UFS_RX_MIN_HIBERN8_TIME		0x150
+#define QPHY_V4_PCS_UFS_RX_SIGDET_CTRL2			0x158
+#define QPHY_V4_PCS_UFS_TX_PWM_GEAR_BAND		0x160
+#define QPHY_V4_PCS_UFS_TX_HS_GEAR_BAND			0x168
+#define QPHY_V4_PCS_UFS_READY_STATUS			0x180
+#define QPHY_V4_PCS_UFS_TX_MID_TERM_CTRL1		0x1d8
+#define QPHY_V4_PCS_UFS_MULTI_LANE_CTRL1		0x1e0
+
+struct ufsphy_init_tbl {
+	unsigned int offset;
+	unsigned int val;
+};
+
+static const struct ufsphy_init_tbl ufsphy_serdes_tbl[] = {
+	{ QSERDES_V4_COM_SYSCLK_EN_SEL, 0xd9 },
+	{ QSERDES_V4_COM_HSCLK_SEL, 0x11 },
+	{ QSERDES_V4_COM_HSCLK_HS_SWITCH_SEL, 0x00 },
+	{ QSERDES_V4_COM_LOCK_CMP_EN, 0x01 },
+	{ QSERDES_V4_COM_VCO_TUNE_MAP, 0x02 },
+	{ QSERDES_V4_COM_PLL_IVCO, 0x0f },
+	{ QSERDES_V4_COM_VCO_TUNE_INITVAL2, 0x00 },
+	{ QSERDES_V4_COM_BIN_VCOCAL_HSCLK_SEL, 0x11 },
+	{ QSERDES_V4_COM_DEC_START_MODE0, 0x82 },
+	{ QSERDES_V4_COM_CP_CTRL_MODE0, 0x06 },
+	{ QSERDES_V4_COM_PLL_RCTRL_MODE0, 0x16 },
+	{ QSERDES_V4_COM_PLL_CCTRL_MODE0, 0x36 },
+	{ QSERDES_V4_COM_LOCK_CMP1_MODE0, 0xff },
+	{ QSERDES_V4_COM_LOCK_CMP2_MODE0, 0x0c },
+	{ QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE1_MODE0, 0xac },
+	{ QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE2_MODE0, 0x1e },
+	{ QSERDES_V4_COM_DEC_START_MODE1, 0x98 },
+	{ QSERDES_V4_COM_CP_CTRL_MODE1, 0x06 },
+	{ QSERDES_V4_COM_PLL_RCTRL_MODE1, 0x16 },
+	{ QSERDES_V4_COM_PLL_CCTRL_MODE1, 0x36 },
+	{ QSERDES_V4_COM_LOCK_CMP1_MODE1, 0x32 },
+	{ QSERDES_V4_COM_LOCK_CMP2_MODE1, 0x0f },
+	{ QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE1_MODE1, 0xdd },
+	{ QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE2_MODE1, 0x23 },
+	/* Rate B */
+	{ QSERDES_V4_COM_VCO_TUNE_MAP, 0x06 },
+};
+
+static const struct ufsphy_init_tbl ufsphy_tx_tbl[] = {
+	{ QSERDES_V4_TX_PWM_GEAR_1_DIVIDER_BAND0_1, 0x06 },
+	{ QSERDES_V4_TX_PWM_GEAR_2_DIVIDER_BAND0_1, 0x03 },
+	{ QSERDES_V4_TX_PWM_GEAR_3_DIVIDER_BAND0_1, 0x01 },
+	{ QSERDES_V4_TX_PWM_GEAR_4_DIVIDER_BAND0_1, 0x00 },
+	{ QSERDES_V4_TX_LANE_MODE_1, 0x05 },
+	{ QSERDES_V4_TX_TRAN_DRVR_EMP_EN, 0x0c },
+};
+
+static const struct ufsphy_init_tbl ufsphy_rx_tbl[] = {
+	{ QSERDES_V4_RX_SIGDET_LVL, 0x24 },
+	{ QSERDES_V4_RX_SIGDET_CNTRL, 0x0f },
+	{ QSERDES_V4_RX_SIGDET_DEGLITCH_CNTRL, 0x1e },
+	{ QSERDES_V4_RX_RX_BAND, 0x18 },
+	{ QSERDES_V4_RX_UCDR_FASTLOCK_FO_GAIN, 0x0a },
+	{ QSERDES_V4_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x4b },
+	{ QSERDES_V4_RX_UCDR_PI_CONTROLS, 0xf1 },
+	{ QSERDES_V4_RX_UCDR_FASTLOCK_COUNT_LOW, 0x80 },
+	{ QSERDES_V4_RX_UCDR_PI_CTRL2, 0x80 },
+	{ QSERDES_V4_RX_UCDR_FO_GAIN, 0x0c },
+	{ QSERDES_V4_RX_UCDR_SO_GAIN, 0x04 },
+	{ QSERDES_V4_RX_RX_TERM_BW, 0x1b },
+	{ QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL2, 0x06 },
+	{ QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL3, 0x04 },
+	{ QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL4, 0x1d },
+	{ QSERDES_V4_RX_RX_OFFSET_ADAPTOR_CNTRL2, 0x00 },
+	{ QSERDES_V4_RX_RX_IDAC_MEASURE_TIME, 0x10 },
+	{ QSERDES_V4_RX_RX_IDAC_TSETTLE_LOW, 0xc0 },
+	{ QSERDES_V4_RX_RX_IDAC_TSETTLE_HIGH, 0x00 },
+	{ QSERDES_V4_RX_RX_MODE_00_LOW, 0x36 },
+	{ QSERDES_V4_RX_RX_MODE_00_HIGH, 0x36 },
+	{ QSERDES_V4_RX_RX_MODE_00_HIGH2, 0xf6 },
+	{ QSERDES_V4_RX_RX_MODE_00_HIGH3, 0x3b },
+	{ QSERDES_V4_RX_RX_MODE_00_HIGH4, 0x3d },
+	{ QSERDES_V4_RX_RX_MODE_01_LOW, 0xe0 },
+	{ QSERDES_V4_RX_RX_MODE_01_HIGH, 0xc8 },
+	{ QSERDES_V4_RX_RX_MODE_01_HIGH2, 0xc8 },
+	{ QSERDES_V4_RX_RX_MODE_01_HIGH3, 0x3b },
+	{ QSERDES_V4_RX_RX_MODE_01_HIGH4, 0xb1 },
+	{ QSERDES_V4_RX_RX_MODE_10_LOW, 0xe0 },
+	{ QSERDES_V4_RX_RX_MODE_10_HIGH, 0xc8 },
+	{ QSERDES_V4_RX_RX_MODE_10_HIGH2, 0xc8 },
+	{ QSERDES_V4_RX_RX_MODE_10_HIGH3, 0x3b },
+	{ QSERDES_V4_RX_RX_MODE_10_HIGH4, 0xb1 },
+};
+
+static const struct ufsphy_init_tbl ufsphy_pcs_tbl[] = {
+	{ QPHY_V4_PCS_UFS_RX_SIGDET_CTRL2, 0x6d },
+	{ QPHY_V4_PCS_UFS_TX_LARGE_AMP_DRV_LVL, 0x0a },
+	{ QPHY_V4_PCS_UFS_TX_SMALL_AMP_DRV_LVL, 0x02 },
+	{ QPHY_V4_PCS_UFS_TX_MID_TERM_CTRL1, 0x43 },
+	{ QPHY_V4_PCS_UFS_DEBUG_BUS_CLKSEL, 0x1f },
+	{ QPHY_V4_PCS_UFS_RX_MIN_HIBERN8_TIME, 0xff },
+	{ QPHY_V4_PCS_UFS_MULTI_LANE_CTRL1, 0x02 },
+};
+
+#define UFSPHY_SERDES_OFFSET		0x3000
+#define UFSPHY_TX_OFFSET		0x3400
+#define UFSPHY_RX_OFFSET		0x3600
+#define UFSPHY_TX2_OFFSET		0x3800
+#define UFSPHY_RX2_OFFSET		0x3a00
+#define UFSPHY_PCS_OFFSET		0x3c00
+
+#define SW_RESET			BIT(0)
+#define SW_PWRDN			BIT(0)
+#define SERDES_START			BIT(0)
+#define PCS_READY			BIT(0)
+
+#define GCC_UFS_PHY_BCR_ADDR		0x177000
+#define BCR_RESET			BIT(0)
+
+#define PHY_INIT_COMPLETE_TIMEOUT	10000
+
+static int ufs_qcom_phy_reset(void)
+{
+	void __iomem *reg;
+	u32 val;
+
+	reg = ioremap(GCC_UFS_PHY_BCR_ADDR, 4);
+	if (!reg)
+		return -ENOMEM;
+
+	/* assert */
+	val = readl(reg);
+	val |= BCR_RESET;
+	writel(val, reg);
+
+	/*
+	 * The hardware requirement for delay between assert/deassert
+	 * is at least 3-4 sleep clock (32.7KHz) cycles, which comes to
+	 * ~125us (4/32768). To be on the safe side add 200us delay.
+	 */
+	usleep_range(200, 210);
+
+	/* deassert */
+	val = readl(reg);
+	val &= ~BCR_RESET;
+	writel(val, reg);
+
+	usleep_range(1000, 1100);
+
+	iounmap(reg);
+	return 0;
+}
+
+static void ufsphy_configure_hw(void __iomem *base,
+				const struct ufsphy_init_tbl tbl[], int num)
+{
+	const struct ufsphy_init_tbl *t = tbl;
+	int i;
+
+	for (i = 0; i < num; i++, t++)
+		writel(t->val, base + t->offset);
+}
+
+int ufs_qcom_phy_init(struct ufs_hba *hba)
+{
+	void __iomem *pcs = hba->mmio_base + UFSPHY_PCS_OFFSET;
+	u32 val;
+	int ret;
+
+	ret = ufs_qcom_phy_reset();
+	if (ret)
+		return ret;
+
+	val = readl(pcs + QPHY_V4_PCS_UFS_POWER_DOWN_CONTROL);
+	val |= SW_PWRDN;
+	writel(val, pcs + QPHY_V4_PCS_UFS_POWER_DOWN_CONTROL);
+
+	ufsphy_configure_hw(hba->mmio_base + UFSPHY_SERDES_OFFSET,
+			    ufsphy_serdes_tbl, ARRAY_SIZE(ufsphy_serdes_tbl));
+	ufsphy_configure_hw(hba->mmio_base + UFSPHY_TX_OFFSET,
+			    ufsphy_tx_tbl, ARRAY_SIZE(ufsphy_tx_tbl));
+	ufsphy_configure_hw(hba->mmio_base + UFSPHY_TX2_OFFSET,
+			    ufsphy_tx_tbl, ARRAY_SIZE(ufsphy_tx_tbl));
+	ufsphy_configure_hw(hba->mmio_base + UFSPHY_RX_OFFSET,
+			    ufsphy_rx_tbl, ARRAY_SIZE(ufsphy_rx_tbl));
+	ufsphy_configure_hw(hba->mmio_base + UFSPHY_RX2_OFFSET,
+			    ufsphy_rx_tbl, ARRAY_SIZE(ufsphy_rx_tbl));
+	ufsphy_configure_hw(pcs, ufsphy_pcs_tbl, ARRAY_SIZE(ufsphy_pcs_tbl));
+
+	/*
+	 * Pull out PHY from POWER DOWN state.
+	 * This is active low enable signal to power-down PHY.
+	 */
+	/* Pull PHY out of reset state */
+	val = readl(pcs + QPHY_V4_PCS_UFS_SW_RESET);
+	val &= ~SW_RESET;
+	writel(val, pcs + QPHY_V4_PCS_UFS_SW_RESET);
+
+	/* Start SerDes and Phy-Coding-Sublayer */
+	val = readl(pcs + QPHY_V4_PCS_UFS_PHY_START);
+	val |= SERDES_START;
+	writel(val, pcs + QPHY_V4_PCS_UFS_PHY_START);
+
+	ret = readl_poll_timeout(pcs + QPHY_V4_PCS_UFS_READY_STATUS,
+				 val, (val & PCS_READY) == PCS_READY,
+				 10, PHY_INIT_COMPLETE_TIMEOUT);
+	if (ret) {
+		dev_err(hba->dev, "ufsphy initialization timed-out\n");
+		return ret;
+	}
+
+	return 0;
+}
diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
index f97d7b0ae3b6..1b45157d9dc9 100644
--- a/drivers/scsi/ufs/ufs-qcom.c
+++ b/drivers/scsi/ufs/ufs-qcom.c
@@ -292,6 +292,10 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
 	bool is_rate_B = (UFS_QCOM_LIMIT_HS_RATE == PA_HS_MODE_B)
 							? true : false;
 
+	if (has_acpi_companion(hba->dev) &&
+	    hba->ufs_version == UFSHCI_VERSION_30)
+		return ufs_qcom_phy_init(hba);
+
 	/* Reset UFS Host Controller and PHY */
 	ret = ufs_qcom_host_reset(hba);
 	if (ret)
diff --git a/drivers/scsi/ufs/ufs-qcom.h b/drivers/scsi/ufs/ufs-qcom.h
index 8208e3a3ef59..69a26f0f05ce 100644
--- a/drivers/scsi/ufs/ufs-qcom.h
+++ b/drivers/scsi/ufs/ufs-qcom.h
@@ -269,4 +269,15 @@ static inline int ufs_qcom_ice_resume(struct ufs_qcom_host *host)
 #define ufs_qcom_ice_program_key NULL
 #endif /* !CONFIG_SCSI_UFS_CRYPTO */
 
+/* ufs-qcom-phy.c */
+
+#ifdef CONFIG_ACPI
+int ufs_qcom_phy_init(struct ufs_hba *hba);
+#else
+static inline int ufs_qcom_phy_init(struct ufs_hba *hba)
+{
+	return 0;
+}
+#endif
+
 #endif /* UFS_QCOM_H_ */
diff --git a/drivers/scsi/ufs/ufshci.h b/drivers/scsi/ufs/ufshci.h
index 6795e1f0e8f8..48f6c191f26b 100644
--- a/drivers/scsi/ufs/ufshci.h
+++ b/drivers/scsi/ufs/ufshci.h
@@ -80,6 +80,7 @@ enum {
 	UFSHCI_VERSION_11 = 0x00010100, /* 1.1 */
 	UFSHCI_VERSION_20 = 0x00000200, /* 2.0 */
 	UFSHCI_VERSION_21 = 0x00000210, /* 2.1 */
+	UFSHCI_VERSION_30 = 0x00000300, /* 3.0 */
 };
 
 /*
-- 
2.17.1

