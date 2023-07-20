Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E0975A597
	for <lists+linux-scsi@lfdr.de>; Thu, 20 Jul 2023 07:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjGTFmL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 20 Jul 2023 01:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjGTFmF (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 20 Jul 2023 01:42:05 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C17519A4
        for <linux-scsi@vger.kernel.org>; Wed, 19 Jul 2023 22:41:53 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b8bbce9980so2173665ad.2
        for <linux-scsi@vger.kernel.org>; Wed, 19 Jul 2023 22:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689831712; x=1690436512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Va2eBrtKbuaaEbPPwCKeC0Kyjq5LXg7paK5APhMFzEM=;
        b=xLnxGFd2HmtSF3PXpB0D5d0+/m2n7fsIorTavzRqm9BqcyAc1fHRBo3LxPy7jpHpdS
         Ecz6g64YmNpneeW5rmjWCEE5bHwyCPDwc5YsU2Bojhbq/uB9LGdbxPPhR+9dzWbu0kEk
         0uJrON9rpWMe5ncnVO0mdkQDIE2HxB3MyVboe8dSf46ETE972cTdbtFOw3MKzyWR/uxr
         Z0VcXH1IGFs4BPLk/lZMfWmddSWM++mab4SaO7SSGnOOkuU6neTKeeEWlKR8tN6+G1tK
         Rgnj2T3fzcrJBFaLsSxh6qwjOe9BB17JMjyJkqqrhMHSJC+Kpk4YDMP8FEgD5+HEAZXi
         U9Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689831712; x=1690436512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Va2eBrtKbuaaEbPPwCKeC0Kyjq5LXg7paK5APhMFzEM=;
        b=KNCR/YCc8r4+KVpiVz7z7QnL6fIIHJC3jue/AhpWmuH8jLrFJB7OHOt4wK/u60JDD6
         p0lfOVUHCmIQeKetYUhWGI/Xbdrls5ofkIqKJgFnEk8a88unFrTAJ69MsvM4zDT4ECdf
         ZHyOo0f+pXG1Lge6NBtbsm27UThmdOklZv8wKub1nabUyJOV35M0hSS5/0vYIoUxtYBs
         y+dSI6E+OuzSsEJ3mLax6eesfdqR/LGVj0HwbO/d0KBAdc3/u+z8FcxpBOtliMQwJsfx
         52cKh+eb4yl6mQ0ke7HZdb+9QrkN+Fpi7GYv5bUiM0j/w1idAV+ANvCdvOj5hpMws3Um
         SEWQ==
X-Gm-Message-State: ABy/qLa81NG1hYhGFQRthkM4xxuuRUGGoxKdSwDDhz+BYrwBDvadclec
        lS+lvsRUrTWMOcooJdxEP6sR
X-Google-Smtp-Source: APBJJlFdRfTp2IRPTIrY/3bl9a41Yqj5CMCNFidrfdwoLr3tasQ9Tx6F4f5gzDmX6/s5JXl5+d68XA==
X-Received: by 2002:a17:902:d50c:b0:1b8:9b74:636b with SMTP id b12-20020a170902d50c00b001b89b74636bmr4266761plg.68.1689831712348;
        Wed, 19 Jul 2023 22:41:52 -0700 (PDT)
Received: from localhost.localdomain ([117.206.119.70])
        by smtp.gmail.com with ESMTPSA id r2-20020a170902be0200b001b85bb5fd77sm263367pls.119.2023.07.19.22.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 22:41:51 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 03/15] arm64: dts: qcom: sdm845: Add missing RPMh power domain to GCC
Date:   Thu, 20 Jul 2023 11:10:48 +0530
Message-Id: <20230720054100.9940-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230720054100.9940-1-manivannan.sadhasivam@linaro.org>
References: <20230720054100.9940-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

GCC and it's GDSCs are under the RPMh CX power domain. So let's add the
missing RPMh power domain to the GCC node.

Fixes: 6d4cf750d03a ("arm64: dts: sdm845: Add minimal dts/dtsi files for sdm845 SoC and MTP")
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Co-developed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 02a6ea0b8b2c..9ed74bf72d05 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1207,6 +1207,7 @@ gcc: clock-controller@100000 {
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
+			power-domains = <&rpmhpd SDM845_CX>;
 		};
 
 		qfprom@784000 {
-- 
2.25.1

