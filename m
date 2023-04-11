Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03A76DDB9D
	for <lists+linux-scsi@lfdr.de>; Tue, 11 Apr 2023 15:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjDKNFL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 11 Apr 2023 09:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjDKNFF (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 11 Apr 2023 09:05:05 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475C649D8
        for <linux-scsi@vger.kernel.org>; Tue, 11 Apr 2023 06:04:54 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l10-20020a05600c1d0a00b003f04bd3691eso15215286wms.5
        for <linux-scsi@vger.kernel.org>; Tue, 11 Apr 2023 06:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1681218293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eibFHvIgf05QKZ/3r3/eY9NPHy7GReZl9L/HNNvsxXE=;
        b=OjTJrHqjKnFcNtpxu+Jm5Qtw20XraHvEi7KW4YG5WJitLaThv138G8Ep+/ASeVEEfd
         ZDzqG+0RKLyMV9AZ2qtySMtce1bsorkt6nZviZVcsAtar6uLGjiVWx8MrKLJNy4ypnPb
         Fpn/DFqZ6iSw5WivvMhw3yhYLSMH2PHW+rULdXOXoyxGUB1V8Eq1sKGFGZnxApLpso+n
         yStFXsdWBkAHp4Zzthp04LtHgkXfp0esJVy01GetuGeyMFPFPApmQ2GrxPhimjrL4gW/
         P0mhTEbTDTvpjysE52MK0egEkotIv4w4+lfyGn42Hu6rbwYDLinBb2rfMpvxTGT2r+50
         wqxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681218293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eibFHvIgf05QKZ/3r3/eY9NPHy7GReZl9L/HNNvsxXE=;
        b=JImQevSPpGHekuAOgrVV8yVgugvIYCw7t436j0itAvQwJpP86T9Pc2vfs3Zbayo3El
         q1vxnSmUdY/rqj8YgpBAcrtea92li6tXp316pY84NultcJdjElxes04OkEZ6sdm6K8jY
         T/PkB8+0TS8ATNW8jV1g0CCNxXOVusFUU2m7FzkC8kNqgCgkwz7d2hKWgG2zqsBFlbcp
         PjNuV1TLflV3+DCIsGuqMSIryOkxPYtvbOuk0a6OSwxQobnxZFEaPl/W4BYBTx8IzZD2
         onQU/Y6X9ON3E3M0cofzxzA3hOhRMUZYweHOETJwDEW/KwyvrDY1qLQ4Rq9rnml57xys
         AHWw==
X-Gm-Message-State: AAQBX9dwR13CQsOktsHCsN0T9kyq7J0MvAOU6E20T2YaTw4B2paoE05f
        JchR+Yns08RAlVayD6ARS3G6jQ==
X-Google-Smtp-Source: AKy350Y/qWDD9jhMANGr002s2sMLeY1mCemNlu5GVy1e0LrfnYLry4tLbyvabwhYt2bJmEutw+9mJQ==
X-Received: by 2002:a1c:ed02:0:b0:3f0:7dd1:8e4b with SMTP id l2-20020a1ced02000000b003f07dd18e4bmr8941221wmh.6.1681218292676;
        Tue, 11 Apr 2023 06:04:52 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:a099:fc1d:c99a:bfc3])
        by smtp.gmail.com with ESMTPSA id t6-20020a7bc3c6000000b003f04646838esm16921301wmj.39.2023.04.11.06.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 06:04:52 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 3/5] phy: qualcomm: phy-qcom-qmp-ufs: add definitions for sa8775p
Date:   Tue, 11 Apr 2023 15:04:44 +0200
Message-Id: <20230411130446.401440-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230411130446.401440-1-brgl@bgdev.pl>
References: <20230411130446.401440-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add QMP PHY config for sa8775p and add support for the new compatible.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 38 +++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
index d58822049211..5612282eb378 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
@@ -853,6 +853,41 @@ static const struct qmp_phy_cfg msm8996_ufsphy_cfg = {
 	.no_pcs_sw_reset	= true,
 };
 
+
+static const struct qmp_phy_cfg sa8775p_ufsphy_cfg = {
+	.lanes			= 2,
+
+	.offsets		= &qmp_ufs_offsets,
+
+	.tbls = {
+		.serdes		= sm8350_ufsphy_serdes,
+		.serdes_num	= ARRAY_SIZE(sm8350_ufsphy_serdes),
+		.tx		= sm8350_ufsphy_tx,
+		.tx_num		= ARRAY_SIZE(sm8350_ufsphy_tx),
+		.rx		= sm8350_ufsphy_rx,
+		.rx_num		= ARRAY_SIZE(sm8350_ufsphy_rx),
+		.pcs		= sm8350_ufsphy_pcs,
+		.pcs_num	= ARRAY_SIZE(sm8350_ufsphy_pcs),
+	},
+	.tbls_hs_b = {
+		.serdes		= sm8350_ufsphy_hs_b_serdes,
+		.serdes_num	= ARRAY_SIZE(sm8350_ufsphy_hs_b_serdes),
+	},
+	.tbls_hs_g4 = {
+		.tx		= sm8350_ufsphy_g4_tx,
+		.tx_num		= ARRAY_SIZE(sm8350_ufsphy_g4_tx),
+		.rx		= sm8350_ufsphy_g4_rx,
+		.rx_num		= ARRAY_SIZE(sm8350_ufsphy_g4_rx),
+		.pcs		= sm8350_ufsphy_g4_pcs,
+		.pcs_num	= ARRAY_SIZE(sm8350_ufsphy_g4_pcs),
+	},
+	.clk_list		= sm8450_ufs_phy_clk_l,
+	.num_clks		= ARRAY_SIZE(sm8450_ufs_phy_clk_l),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= ufsphy_v5_regs_layout,
+};
+
 static const struct qmp_phy_cfg sc8280xp_ufsphy_cfg = {
 	.lanes			= 2,
 
@@ -1600,6 +1635,9 @@ static const struct of_device_id qmp_ufs_of_match_table[] = {
 	}, {
 		.compatible = "qcom,msm8998-qmp-ufs-phy",
 		.data = &sdm845_ufsphy_cfg,
+	}, {
+		.compatible = "qcom,sa8775p-qmp-ufs-phy",
+		.data = &sa8775p_ufsphy_cfg,
 	}, {
 		.compatible = "qcom,sc8180x-qmp-ufs-phy",
 		.data = &sm8150_ufsphy_cfg,
-- 
2.37.2

