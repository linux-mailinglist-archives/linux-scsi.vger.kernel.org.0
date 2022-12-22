Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3068654287
	for <lists+linux-scsi@lfdr.de>; Thu, 22 Dec 2022 15:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235623AbiLVON0 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 22 Dec 2022 09:13:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235559AbiLVOMf (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 22 Dec 2022 09:12:35 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA40303F1
        for <linux-scsi@vger.kernel.org>; Thu, 22 Dec 2022 06:11:39 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id u5so2006030pjy.5
        for <linux-scsi@vger.kernel.org>; Thu, 22 Dec 2022 06:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9LXdGVP9dxpaOugOFMrnDCyUZiHcY/u5VEvcCrjnpKE=;
        b=sEAZuCy9o1mSeZ+mOAF+2MpfasokgDnmXc8LSn05lHnTxhCmTkhTVkPygFTTLKDhiZ
         nixCIHoQz4+ceVMPOV8l6CPCGmNL/nQjE9wXY0f8N/Q+1xbJBuaj9EvBybl6jYyWiAan
         5fTz+ssWMIA3tVSpty3OIwg8gkvJeC8aonGebs/3otg1iGl50Ji8OhiTV8RXiKqD/feM
         ywqCABVk3r5mwBOVSldMLZp+krnjPcA50oIL3rr6aAMp9BZ2KcgPsj1oWVAj/bUP4RYZ
         FXX/RgA1P5h3cIVDjosBxIxNQqMJnztYhdcW/7dU/63ub1u9hqkA8c4B6Wq7g6lN2lvd
         lLIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9LXdGVP9dxpaOugOFMrnDCyUZiHcY/u5VEvcCrjnpKE=;
        b=VLomzetKoFWQUTUzrG4Jo8XM4iwUL/0aRygF+z2GegLZILvW34r3XE0QFbcmswAS58
         Ct14vEqf+yFiUC0IQe7reTk9shvytX4AVlMLroMigMU6HK/nBQdrVTD4GW96RU/ip/Nj
         HQBNtRVUsnYdDil3vFUndd112/P3OzsfoYgHHwkqKxSp61oTftnHMSiVaayU/FBLoVs5
         85pUFMpF3gwTyH5/EMs9xwLAzN3I5qHuo4dFHL23KHdEWRBcZ745I8om0gsueRxniw5X
         9QtUpoh3AVe1OJbm3whjHA8HOHv2aiDla2p80uSmXwhko+APWufaNcffh2rh7z4FetMv
         nZBA==
X-Gm-Message-State: AFqh2kpZ9K2okwxilgtHrAuQvhdXOzPeKR4Ua23lqdiUq9/E/2rQpZ0a
        UZYSbU1QQXQN7AbfuvmWu+Re
X-Google-Smtp-Source: AMrXdXs6kCUEn/CZL/Ia+qJ9szz8RsqG0cT+AqgbrzlUI0r6MdzQNrClwbaz2RWxvRBh3//sVlCyrQ==
X-Received: by 2002:a17:902:ef89:b0:189:bcf7:1ec0 with SMTP id iz9-20020a170902ef8900b00189bcf71ec0mr6659380plb.30.1671718298860;
        Thu, 22 Dec 2022 06:11:38 -0800 (PST)
Received: from localhost.localdomain ([117.217.177.177])
        by smtp.gmail.com with ESMTPSA id f8-20020a655908000000b0047829d1b8eesm832031pgu.31.2022.12.22.06.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 06:11:38 -0800 (PST)
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
Subject: [PATCH v5 12/23] phy: qcom-qmp-ufs: Add HS G4 mode support to SC8280XP SoC
Date:   Thu, 22 Dec 2022 19:39:50 +0530
Message-Id: <20221222141001.54849-13-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221222141001.54849-1-manivannan.sadhasivam@linaro.org>
References: <20221222141001.54849-1-manivannan.sadhasivam@linaro.org>
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

UFS PHY in SC8280XP SoC is capable of operating at HS G4 mode and the init
sequence is compatible with SM8350. Hence, add the tbls_hs_g4 instance
reusing the G4 init sequence of SM8350.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Tested-by: Andrew Halaney <ahalaney@redhat.com> # Qdrive3/sa8540p-ride
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
index 96e03d4249da..9f5526758985 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
@@ -763,6 +763,14 @@ static const struct qmp_phy_cfg sc8280xp_ufsphy_cfg = {
 		.serdes		= sm8350_ufsphy_hs_b_serdes,
 		.serdes_num	= ARRAY_SIZE(sm8350_ufsphy_hs_b_serdes),
 	},
+	.tbls_hs_g4 = {
+		.tx		= sm8350_ufsphy_g4_tx,
+		.tx_num		= ARRAY_SIZE(sm8350_ufsphy_g4_tx),
+		.rx		= sm8350_ufsphy_g4_rx,
+		.rx_num		= ARRAY_SIZE(sm8350_ufsphy_g4_rx),
+		.pcs		= sm8350_ufsphy_g4_pcs,
+		.pcs_num	= ARRAY_SIZE(sm8350_ufsphy_g4_pcs),
+	},
 	.clk_list		= sdm845_ufs_phy_clk_l,
 	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
 	.vreg_list		= qmp_phy_vreg_l,
-- 
2.25.1

