Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59736769CC2
	for <lists+linux-scsi@lfdr.de>; Mon, 31 Jul 2023 18:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbjGaQf4 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 31 Jul 2023 12:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbjGaQfd (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 31 Jul 2023 12:35:33 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8161BCF
        for <linux-scsi@vger.kernel.org>; Mon, 31 Jul 2023 09:35:21 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bba48b0bd2so29472855ad.3
        for <linux-scsi@vger.kernel.org>; Mon, 31 Jul 2023 09:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690821320; x=1691426120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0fZoRzqsVsl2DrqFfH7FNxDnDstpZGeIPe8SX7WYfkY=;
        b=apDEw9guhDGR1m7e1txjCAEYGfIwqTYB4bhVZlXDoTvkw8YSH2H+pkHwbPdY+APTsx
         rJioXo+74YcllhyJuKU6YGL7X+g2zzk+XWT/pR5pjDMUCjRng/vWiZvYgNxntlua/eW1
         wfvjDYqJWyDlYyMHN6aNZujeIHNFaYULQQagg/wsrgoX70i92T6L8oBhL7mGnDUt1/Sn
         xNAQJZBuDTAVTkfvx83O6Md02Iz4OxRwpG/ituEEmnwtWSLZ81TWJMx0LLtNuZr6s80/
         kYES5bwflQmjzF7sr7CUwUhbNHd5F3xltkfYoz6WF+BZ6+9cj3NffYlrXY3C4jipcxo0
         n8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690821320; x=1691426120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0fZoRzqsVsl2DrqFfH7FNxDnDstpZGeIPe8SX7WYfkY=;
        b=NJFJSZyHpYTSbTtU9hmPy3sZVbGBymzNahAvsSpoR9dwGukqxtX1nj/6vLaHWjHn3V
         yAdjcbGSIYr7l+UwXAuBr18qJbmraIj4jLIm4eDL79gRfCMcveWTTH2Z/ulurr6hk47C
         jCWKxqHyDmmlJl4alKyefXgZ3y/6nsrh1DED5vcHPsVvjiYUdqfgD0LiDy7votbvEC5u
         97O15GbPNBYIFV49SuNbCN7UhR4W2apQtyNcUXDrQ4Zo4hXcdTtWyPkaIJHPK4fF3feN
         fjlZOuvT8gj5LUfp9kx5rlxTuHk83G++igtV1745MI7WbuCtI7i/Zd4cwvJJ7r4Sw0jU
         gRTg==
X-Gm-Message-State: ABy/qLbIxbSv5s67X1izC6cVPOWC1Sni9mPel+GXj1o23Fn0LAmV8Q/y
        C//MNIEUw37npv6xvCsLsNKF
X-Google-Smtp-Source: APBJJlFD6Q3yZrZ6q0f+zYz+e0z7c4v939MtPJ9CfXKp3aOr8Hxgi+nwz9LAgxmhJ9nlJKP3PKPHnQ==
X-Received: by 2002:a17:902:854b:b0:1bc:13d0:7219 with SMTP id d11-20020a170902854b00b001bc13d07219mr2783802plo.41.1690821320721;
        Mon, 31 Jul 2023 09:35:20 -0700 (PDT)
Received: from localhost.localdomain ([117.193.209.129])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902e88800b001bb1f09189bsm8779541plg.221.2023.07.31.09.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 09:35:20 -0700 (PDT)
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
Subject: [PATCH v3 5/6] arm64: dts: qcom: sdm845: Add OPP table support to UFSHC
Date:   Mon, 31 Jul 2023 22:03:56 +0530
Message-Id: <20230731163357.49045-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230731163357.49045-1-manivannan.sadhasivam@linaro.org>
References: <20230731163357.49045-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

UFS host controller, when scaling gears, should choose appropriate
performance state of RPMh power domain controller along with clock
frequency. So let's add the OPP table support to specify both clock
frequency and RPMh performance states replacing the old "freq-table-hz"
property.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
[mani: Splitted pd change and used rpmhpd_opp_low_svs]
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 42 +++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 055ca80c0075..2ea6eb44953e 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2605,22 +2605,44 @@ ufs_mem_hc: ufshc@1d84000 {
 				<&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
 				<&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>,
 				<&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
-			freq-table-hz =
-				<50000000 200000000>,
-				<0 0>,
-				<0 0>,
-				<37500000 150000000>,
-				<0 0>,
-				<0 0>,
-				<0 0>,
-				<0 0>,
-				<75000000 300000000>;
+
+			operating-points-v2 = <&ufs_opp_table>;
 
 			interconnects = <&aggre1_noc MASTER_UFS_MEM 0 &mem_noc SLAVE_EBI1 0>,
 					<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_UFS_MEM_CFG 0>;
 			interconnect-names = "ufs-ddr", "cpu-ufs";
 
 			status = "disabled";
+
+			ufs_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-50000000 {
+					opp-hz = /bits/ 64 <50000000>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <37500000>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <75000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+				};
+
+				opp-200000000 {
+					opp-hz = /bits/ 64 <200000000>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <150000000>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <300000000>;
+					required-opps = <&rpmhpd_opp_nom>;
+				};
+			};
 		};
 
 		ufs_mem_phy: phy@1d87000 {
-- 
2.25.1

