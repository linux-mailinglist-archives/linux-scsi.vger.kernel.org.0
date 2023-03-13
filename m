Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4336B76E7
	for <lists+linux-scsi@lfdr.de>; Mon, 13 Mar 2023 12:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjCMLx4 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 13 Mar 2023 07:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjCMLw6 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 13 Mar 2023 07:52:58 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E9E6513B
        for <linux-scsi@vger.kernel.org>; Mon, 13 Mar 2023 04:52:26 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id az3-20020a05600c600300b003ed2920d585so827161wmb.2
        for <linux-scsi@vger.kernel.org>; Mon, 13 Mar 2023 04:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678708340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOM0wU6k8YL6zyefl9B75iw3o3Fd7bxtMEc8BcltPP0=;
        b=Yo1hi2naG0TMf+Cn9+92jHE5y5ZQeGL2G+B5oUkfpmybCcARGI/7I1AXzrsFQjcWiV
         8AVEXZfwN4N2infnF2YabGPFC6jZgqHR6KaSHDTnN2J9G7qlq1z4GJUGWILm4ND9cEmS
         i5GOo7xxBxsRM5Vxd6FIrU3YSoFTjHRGDlE27R5p5iRPAoB8HYfjvIPE+Aeolt+QTUgm
         kULNFWKJPUWPph19SJfjPntRxFYdOUuopzvkEVaH93E2WcphTJGOWDCX8Is5Cx558V/a
         haVkS8SWk6LJSshrTPtyaLryB3HegkrM/YwRTJtl3cwOAIyQWLT8oNOVg+HE2gR+Cafc
         tn+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678708340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GOM0wU6k8YL6zyefl9B75iw3o3Fd7bxtMEc8BcltPP0=;
        b=3Fj+uxMMt3C9MqTZaFztxvhI+2OYHGYn4k4VAWRLGeHjOfLwFcD+gO4ZUJlg6a74H1
         8jjddIqoqUkiaN8va+f6Cea28H54xGQKUbEImcw3npFfgzm2s7CaXjMmeLwSQZTosNMh
         LB1Gdz0KF2Gi5JFTtpuhBRP7/JoP/jdQkZQswO2QVkraZ4iiYqzcvYRkFmTkGXCnkXXQ
         jtQNR5K2W1CKmXmzg1Ai9wteyY/O4gw2Vqg8rjFMa9GpNOPiOxQVNAkQAO3qJIz6PLPC
         VgQfsNrzjbNBS1WNlM7orpYAUEmqgjGJl0NrH1e093nfHHaatoXPFuw2HfRVL7TkJ4rf
         4/xw==
X-Gm-Message-State: AO0yUKWivZ4yzANHp2XJT2UDA4sFW3eWoxxLJPo5SJzGjavKBYeZZBzz
        lHym5HHPMLAX5O5hg5kYrMtjyw==
X-Google-Smtp-Source: AK7set/Kw84B38cC6AtJ9OlHXUgfEIZvrnDse4SJG4dI+SPVu9lcD061f0fGRffAQAAHmggiK8UiRg==
X-Received: by 2002:a05:600c:3b04:b0:3df:d431:cf64 with SMTP id m4-20020a05600c3b0400b003dfd431cf64mr10835575wms.39.1678708340264;
        Mon, 13 Mar 2023 04:52:20 -0700 (PDT)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id u15-20020a05600c440f00b003e21dcccf9fsm8801090wmn.16.2023.03.13.04.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 04:52:19 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: [RFC PATCH v3 7/7] arm64: dts: qcom: sm8550: Add the Inline Crypto Engine node
Date:   Mon, 13 Mar 2023 13:52:02 +0200
Message-Id: <20230313115202.3960700-8-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230313115202.3960700-1-abel.vesa@linaro.org>
References: <20230313115202.3960700-1-abel.vesa@linaro.org>
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

Add support for UFS ICE by adding the qcom,ice property and the
ICE dedicated devicetree node. While at it, add the reg-name property
to the UFS HC node to be in line with older platforms.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

Changes since v2:
 * dropped all changes for the older platforms
 * added the suppor for ICE with the new approach to the SM8550

 arch/arm64/boot/dts/qcom/sm8550.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index ec45f13e55c9..ac7bf1e1a2ab 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -1882,6 +1882,7 @@ ufs_mem_hc: ufs@1d84000 {
 			compatible = "qcom,sm8550-ufshc", "qcom,ufshc",
 				     "jedec,ufs-2.0";
 			reg = <0x0 0x01d84000 0x0 0x3000>;
+			reg-names = "std";
 			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
 			phys = <&ufs_mem_phy>;
 			phy-names = "ufsphy";
@@ -1924,9 +1925,18 @@ ufs_mem_hc: ufs@1d84000 {
 				<0 0>,
 				<0 0>,
 				<0 0>;
+			qcom,ice = <&ice>;
+
 			status = "disabled";
 		};
 
+		ice: crypto@1d88000 {
+			compatible = "qcom,sm8550-inline-crypto-engine",
+				     "qcom,inline-crypto-engine";
+			reg = <0 0x01d88000 0 0x8000>;
+			clocks = <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
+		};
+
 		tcsr_mutex: hwlock@1f40000 {
 			compatible = "qcom,tcsr-mutex";
 			reg = <0 0x01f40000 0 0x20000>;
-- 
2.34.1

