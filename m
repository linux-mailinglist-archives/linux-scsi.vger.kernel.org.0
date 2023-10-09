Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935DC7BEC6B
	for <lists+linux-scsi@lfdr.de>; Mon,  9 Oct 2023 23:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378241AbjJIVMn (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 9 Oct 2023 17:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377082AbjJIVMm (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 9 Oct 2023 17:12:42 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0707B93
        for <linux-scsi@vger.kernel.org>; Mon,  9 Oct 2023 14:12:39 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-5044dd5b561so5958574e87.1
        for <linux-scsi@vger.kernel.org>; Mon, 09 Oct 2023 14:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696885957; x=1697490757; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jGoGhItmjXMm5592hTQT86oDx5AEAugpeAAG92Ldv9c=;
        b=XVQJc+0rZA8e6WctYFLbKYDlqtPNU0ZOYg/EpwZlsFUo4wMxi/Kwi+8ys0qxhealS8
         JVvJKdvbUZs9jSIwbRiT5f6faiSGpnnpbzof2hFjrHZBOozuBpMTlWoicCDA49T44VZj
         rBuRFOtEw7uN+kDke20ZmGLdqDk7hggxhnFqD+IoFyJfBCp4Ve9sRZaSHszSWM91jhIJ
         8v0PVpGGQbI/J0z5BRwruraF3K1wAiPFoRtloMxCKnIldNmVpQmJT+D+exEO4fNWc4SB
         tycTDPKn/zpB+dVuXUqA/itEo477KlsAekt6b4BVAm/o2NNxZw5LV9e+ikfOZTJfuLMq
         4KnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696885957; x=1697490757;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jGoGhItmjXMm5592hTQT86oDx5AEAugpeAAG92Ldv9c=;
        b=j9UZlkQlmK6vNtPGVfjiZ45kTEXv86HS2Ktm9jipF82DveCqIWt5REbtNd+OUJXG3P
         mM81TGtUrfz6Exi/EP7mWx6raR1czL8RcLVKMl3WbLacEma2ThF9dOXzHbzgHkkBhF7i
         MIh9R+6KYWlxrcu4JB5rqYPQSVwyZYgSDBhu3RtuRj48+Zq6EKMvTbxqqvO3FXVmj/Ve
         UoAXX5CEKg3ovhSbHL6cFE08T0q/cFcFlBawd1tYaU/QlHCQsRA6D8cdRDZNHc+IKRRO
         6wLbpY0Xac032MpDrofBXmNlCM9V5rx2wWNWGKOH9t8Mo4fyiCxpCXDa1NX7P6san1T6
         uChw==
X-Gm-Message-State: AOJu0YxeeRou5jqmGIXz5S9lw43hYr2qGmIa59b1Krq16JRbwhpv1rtf
        ithDaeLkDq7ga9ko1nLJFV0cmQ==
X-Google-Smtp-Source: AGHT+IES2gxCqlfZ4jVm2fkrFudmIdnYvMcqyuJquOODcke/lKVXTFzg0TPAm6K5BgdJCoKWv5t6WA==
X-Received: by 2002:a05:6512:138e:b0:503:7dd:7ebc with SMTP id fc14-20020a056512138e00b0050307dd7ebcmr18050066lfb.18.1696885957242;
        Mon, 09 Oct 2023 14:12:37 -0700 (PDT)
Received: from [172.30.204.90] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id w10-20020a19c50a000000b005056efabed0sm1563171lfe.29.2023.10.09.14.12.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 14:12:36 -0700 (PDT)
Message-ID: <c69dc6e0-30a8-460c-a718-99874b543534@linaro.org>
Date:   Mon, 9 Oct 2023 23:12:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] arm64: dts: qcom: sc7180: Add UFS nodes
Content-Language: en-US
To:     David Wronek <davidwronek@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Joe Mason <buddyjojo06@outlook.com>
Cc:     cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
        hexdump0815@googlemail.com, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org
References: <20231007140053.1731245-1-davidwronek@gmail.com>
 <20231007140053.1731245-6-davidwronek@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231007140053.1731245-6-davidwronek@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org



On 10/7/23 15:58, David Wronek wrote:
> Add the UFS and QMP PHY nodes for the Qualcomm SC7180 SoC.
> 
> Signed-off-by: David Wronek <davidwronek@gmail.com>
> ---
>   arch/arm64/boot/dts/qcom/sc7180.dtsi | 70 ++++++++++++++++++++++++++++
>   1 file changed, 70 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index 11f353d416b4..9f18be4fd61a 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -1532,6 +1532,76 @@ mmss_noc: interconnect@1740000 {
>   			qcom,bcm-voters = <&apps_bcm_voter>;
>   		};
>   
> +		ufs_mem_hc: ufshc@1d84000 {
> +			compatible = "qcom,sc7180-ufshc", "qcom,ufshc",
> +				     "jedec,ufs-2.0";
> +			reg = <0 0x01d84000 0 0x3000>,
> +			      <0 0x01d90000 0 0x8000>;
> +			reg-names = "std", "ice";
Recently the ICE was separated into its own node

> +			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
> +			phys = <&ufs_mem_phy>;
> +			phy-names = "ufsphy";
> +			lanes-per-direction = <1>;
> +			power-domains = <&gcc UFS_PHY_GDSC>;
> +			#reset-cells = <1>;
> +			resets = <&gcc GCC_UFS_PHY_BCR>;
> +			reset-names = "rst";
> +
> +			iommus = <&apps_smmu 0xa0 0x0>;
> +
> +			clock-names =
> +				"core_clk",
Remove the newline after the =, here and below

> +				"bus_aggr_clk",
> +				"iface_clk",
> +				"core_clk_unipro",
> +				"ref_clk",
> +				"tx_lane0_sync_clk",
> +				"rx_lane0_sync_clk",
> +				"ice_core_clk";
> +			clocks =
> +				<&gcc GCC_UFS_PHY_AXI_CLK>,
> +				<&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
> +				<&gcc GCC_UFS_PHY_AHB_CLK>,
> +				<&gcc GCC_UFS_PHY_UNIPRO_CORE_CLK>,
> +				<&rpmhcc RPMH_CXO_CLK>,
> +				<&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
> +				<&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
> +				<&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
> +			freq-table-hz =
> +				<50000000 200000000>,
> +				<0 0>,
> +				<0 0>,
> +				<37500000 150000000>,
> +				<0 0>,
> +				<0 0>,
> +				<0 0>,
> +				<0 300000000>;
> +
> +			interconnects = <&aggre1_noc MASTER_UFS_MEM 0 &mc_virt SLAVE_EBI1 0>,
> +				<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_UFS_MEM_CFG 0>;
Please make the <s align and use QCOM_ICC_TAG_ALWAYS from 
include/dt-bindings/interconnect/qcom,icc.h like in sa8775p.dtsi
> +			interconnect-names = "ufs-ddr", "cpu-ufs";
> +
> +			status = "disabled";
> +		};
> +
> +		ufs_mem_phy: phy@1d87000 {
> +			compatible = "qcom,sc7180-qmp-ufs-phy";
> +			reg = <0 0x01d87000 0 0x1000>;
> +
> +			clocks = <&gcc GCC_UFS_MEM_CLKREF_CLK>,
> +				<&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
Please align the <s

Konrad
