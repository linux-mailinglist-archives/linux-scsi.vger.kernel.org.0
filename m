Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDBE63F67E
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Dec 2022 18:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbiLARpX (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Dec 2022 12:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiLARo4 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Dec 2022 12:44:56 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9E0BBBE5
        for <linux-scsi@vger.kernel.org>; Thu,  1 Dec 2022 09:44:37 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id 21so2560250pfw.4
        for <linux-scsi@vger.kernel.org>; Thu, 01 Dec 2022 09:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3abCssckiIC20hZYw/bwI9pB44XETlrVptMf7eIENNo=;
        b=sbNb+4yOd1zk6qUTHWJ3+UugwTDJddrTcU25nMzZb8JL4nCotj0nA6ws6dAj03nxIJ
         dBdN9vr67llNmE+Bx2ZQAoQWBEixKmZlg3nt6aeg5eyG06RXWpf0hK+LUYt0HN+4Udmb
         RRHig18ymJS9SsNRecr8PWD5yn7mqaOTb/jnNH/EDGpvDTGlsW9bIC4J9V12+BqqLm+W
         v/7pQnVcet6bmZGg3qNxZdFozkkXg+4bbg5adHXwi3zkVXfMBKWFq1LlMS+9DsXWhVkp
         JWIT0DGviSznHDwaxe/+65JvxL3dg21rhmZ35/piJmBy41IV8HvUqOAw1q1fSWVOEwcv
         EWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3abCssckiIC20hZYw/bwI9pB44XETlrVptMf7eIENNo=;
        b=ASAY8suSSOd2kbwT0URn+kaBqWJSuC59e/GB27/PP+q72zSTGNfHZyXE8V/Urwxgvp
         8SOh500gnGcXWjc4zyZyUV4Jjzs6Eul/RawiG0+CGpyIzyzncqSinwDVsPCP/6calF4h
         6XQBz9xMiHvv92XJFGtwNcLikyhjydgkN5rbSrr7FPkdXGcHmSlEJIqTKLcsqucIL0Um
         BFAp0nsLA83/0MkVM9V79VSHydtMelNpHCEgKTz+HDutJ8B/OmHZkrw6RTEX9D/FizPq
         onC7VW0NTREnAvwZGBnmZIhe71FKUl/vDT/qUeLmzlqmDfHCNmh8Gknn5k8qDHBANZiU
         o5eA==
X-Gm-Message-State: ANoB5pl/Wc08DfS4U1oZbfYIf7XNzMuXJgumHBaytC444ghNDd/Yg8i2
        8Y7/GPF+ElekSON7Z6cjWtPy
X-Google-Smtp-Source: AA0mqf4fkNT3nl3jtvIMTF3vn3aqjF9RooqTcQn20+rsRszSfNuQ3pdwKUtJh6SdtSX5kGsBeH7EfQ==
X-Received: by 2002:a63:5308:0:b0:46f:cec6:8805 with SMTP id h8-20020a635308000000b0046fcec68805mr43582371pgb.612.1669916676739;
        Thu, 01 Dec 2022 09:44:36 -0800 (PST)
Received: from localhost.localdomain ([220.158.159.39])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902780400b0016d9b101413sm3898743pll.200.2022.12.01.09.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 09:44:35 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org
Cc:     quic_cang@quicinc.com, quic_asutoshd@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
        dmitry.baryshkov@linaro.org, ahalaney@redhat.com,
        abel.vesa@linaro.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
        bvanassche@acm.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 08/23] phy: qcom-qmp-ufs: Add HS G4 mode support to SM8250 SoC
Date:   Thu,  1 Dec 2022 23:13:13 +0530
Message-Id: <20221201174328.870152-9-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221201174328.870152-1-manivannan.sadhasivam@linaro.org>
References: <20221201174328.870152-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

UFS PHY in SM8250 SoC is capable of operating at HS G4 mode. Hence, add the
required register settings using the tables_hs_g4 struct instance. This
also requires a separate qmp_phy_cfg for SM8250 instead of reusing SM8150.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../phy/qualcomm/phy-qcom-qmp-pcs-ufs-v5.h    |  1 +
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c       | 62 ++++++++++++++++++-
 2 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v5.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v5.h
index bcca23493b7e..3aa4232f84a6 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v5.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v5.h
@@ -13,6 +13,7 @@
 #define QPHY_V5_PCS_UFS_PLL_CNTL			0x02c
 #define QPHY_V5_PCS_UFS_TX_LARGE_AMP_DRV_LVL		0x030
 #define QPHY_V5_PCS_UFS_TX_SMALL_AMP_DRV_LVL		0x038
+#define QPHY_V5_PCS_UFS_BIST_FIXED_PAT_CTRL		0x060
 #define QPHY_V5_PCS_UFS_TX_HSGEAR_CAPABILITY		0x074
 #define QPHY_V5_PCS_UFS_RX_HSGEAR_CAPABILITY		0x0b4
 #define QPHY_V5_PCS_UFS_DEBUG_BUS_CLKSEL		0x124
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
index 269f96a0f752..d5324c4e8513 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
@@ -449,6 +449,34 @@ static const struct qmp_phy_init_tbl sm8150_ufsphy_hs_g4_pcs[] = {
 	QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_BIST_FIXED_PAT_CTRL, 0x0a),
 };
 
+static const struct qmp_phy_init_tbl sm8250_ufsphy_hs_g4_tx[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_LANE_MODE_1, 0xe5),
+};
+
+static const struct qmp_phy_init_tbl sm8250_ufsphy_hs_g4_rx[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x5a),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_PI_CTRL2, 0x81),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FO_GAIN, 0x0e),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_TERM_BW, 0x6f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL1, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL2, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL3, 0x09),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL4, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x17),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_MEASURE_TIME, 0x20),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_LOW, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_HIGH, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_LOW, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH2, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH3, 0x7f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH4, 0x2c),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_LOW, 0x6d),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH, 0x6d),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH2, 0xed),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH4, 0x3c),
+};
+
 static const struct qmp_phy_init_tbl sm8350_ufsphy_serdes[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SYSCLK_EN_SEL, 0xd9),
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_HSCLK_SEL, 0x11),
@@ -805,6 +833,38 @@ static const struct qmp_phy_cfg sm8150_ufsphy_cfg = {
 	.regs			= sm8150_ufsphy_regs_layout,
 };
 
+static const struct qmp_phy_cfg sm8250_ufsphy_cfg = {
+	.lanes			= 2,
+
+	.tbls = {
+		.serdes		= sm8150_ufsphy_serdes,
+		.serdes_num	= ARRAY_SIZE(sm8150_ufsphy_serdes),
+		.tx		= sm8150_ufsphy_tx,
+		.tx_num		= ARRAY_SIZE(sm8150_ufsphy_tx),
+		.rx		= sm8150_ufsphy_rx,
+		.rx_num		= ARRAY_SIZE(sm8150_ufsphy_rx),
+		.pcs		= sm8150_ufsphy_pcs,
+		.pcs_num	= ARRAY_SIZE(sm8150_ufsphy_pcs),
+	},
+	.tbls_hs_b = {
+		.serdes		= sm8150_ufsphy_hs_b_serdes,
+		.serdes_num	= ARRAY_SIZE(sm8150_ufsphy_hs_b_serdes),
+	},
+	.tbls_hs_g4 = {
+		.tx		= sm8250_ufsphy_hs_g4_tx,
+		.tx_num		= ARRAY_SIZE(sm8250_ufsphy_hs_g4_tx),
+		.rx		= sm8250_ufsphy_hs_g4_rx,
+		.rx_num		= ARRAY_SIZE(sm8250_ufsphy_hs_g4_rx),
+		.pcs		= sm8150_ufsphy_hs_g4_pcs,
+		.pcs_num	= ARRAY_SIZE(sm8150_ufsphy_hs_g4_pcs),
+	},
+	.clk_list		= sdm845_ufs_phy_clk_l,
+	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= sm8150_ufsphy_regs_layout,
+};
+
 static const struct qmp_phy_cfg sm8350_ufsphy_cfg = {
 	.lanes			= 2,
 
@@ -1297,7 +1357,7 @@ static const struct of_device_id qmp_ufs_of_match_table[] = {
 		.data = &sm8150_ufsphy_cfg,
 	}, {
 		.compatible = "qcom,sm8250-qmp-ufs-phy",
-		.data = &sm8150_ufsphy_cfg,
+		.data = &sm8250_ufsphy_cfg,
 	}, {
 		.compatible = "qcom,sm8350-qmp-ufs-phy",
 		.data = &sm8350_ufsphy_cfg,
-- 
2.25.1

