Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D5A6D6C67
	for <lists+linux-scsi@lfdr.de>; Tue,  4 Apr 2023 20:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236322AbjDDSjV (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 4 Apr 2023 14:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjDDSjE (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 4 Apr 2023 14:39:04 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DB5659D
        for <linux-scsi@vger.kernel.org>; Tue,  4 Apr 2023 11:38:08 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id a11so34903510lji.6
        for <linux-scsi@vger.kernel.org>; Tue, 04 Apr 2023 11:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680633487;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r0v+inyVMSxumUxkXEg0IMy1xpo29RCtCfHQnamMFuY=;
        b=SGviJSWpa4o4eiL6gw+EP/0NI2Wd1z4iACXy9aXPAznCuQ8RkmzpKgmtCAX0Vu6Vbw
         XyjPi+RTRoaJWKHYa/LalcxUMCvlLnAzfFJ/S2NqpM5gDM0dAS8ABstHajL/lc9MuthF
         jbj+JCvl1auodY4U82dEjEGDrp3/e651A2y5IqzNbQ0ztYiCwONYbeOZyXxLgKHzhaQV
         +c864JPo5eGLZa8Kh4kOxRSeWxjpHBzJYsLRTit/cuaMp2vYZxbaD4RvjSVyvFGIocWj
         IwqM0FoGXczljKBkqzhVl1U/zQPG11pHLMvwRBFqoCqqNqLNjx68224EaTgeLuNO7/5M
         x2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680633487;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r0v+inyVMSxumUxkXEg0IMy1xpo29RCtCfHQnamMFuY=;
        b=CXYialePgMrzyWdLn8+IBCtg+AQ2K45eIo5ZLfQKtcZboUQFaN8iYJPJcf0J6QHE0P
         JDaVxzF5BV01cGi2LeLqcBkIKdob8cG57ge7V2XuB7CxT/izxSVKx1QgixVrdH4H22O2
         FWETaF2MgwXjN8ea0IlYaC4e1uYVPRzv3uuS0xMbvoKu/+wbwUc5H5iRY6jYNxp1qdG5
         g+GqH6QG5e0UC/4Xj4ygQDppg9MHfC2LSdWuHHW18Y3+RFflID4Tz66QynplyAXWCAUD
         xDCBNBsda0njkFVmFfAo8M5QFObTsrUhgnonYsXz3chBKHQgf6Uo+88hyUGzrnCtxEd1
         gZBg==
X-Gm-Message-State: AAQBX9dzFE7qYciq0EKMWqhJbenwVsxhSI6nT4ip1Zz/GsuX3JKvOrl1
        lsbWUjUGQa83qtFQilUGxR6Gpw==
X-Google-Smtp-Source: AKy350aaeDXjGJ0QphUqfp4sFI+LB8O5NTshtcAt+oZjYG33GJY8acRCwNzZDjzLgMmBg+sCjqyEWg==
X-Received: by 2002:a2e:7d0f:0:b0:298:ad8e:e65 with SMTP id y15-20020a2e7d0f000000b00298ad8e0e65mr1209834ljc.21.1680633486886;
        Tue, 04 Apr 2023 11:38:06 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id u24-20020a2ea178000000b002a61bd34f63sm2471403ljl.84.2023.04.04.11.38.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 11:38:05 -0700 (PDT)
Message-ID: <3bf62942-117f-b016-0e64-31829816aa1d@linaro.org>
Date:   Tue, 4 Apr 2023 20:38:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 4/5] arm64: dts: qcom: sa8775p: add UFS nodes
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
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
References: <20230331195920.582620-1-brgl@bgdev.pl>
 <20230331195920.582620-5-brgl@bgdev.pl>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230331195920.582620-5-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org



On 31.03.2023 21:59, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add nodes for the UFS and its PHY on sa8775p platforms.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 54 +++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> index de5e8449397c..c737e67b9239 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> @@ -586,6 +586,60 @@ &clk_virt SLAVE_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS>,
>  			};
>  		};
>  
> +		ufs_mem_hc: ufs@1d84000 {
> +			compatible = "qcom,sa8775p-ufshc", "qcom,ufshc", "jedec,ufs-2.0";
> +			reg = <0x0 0x01d84000 0x0 0x3000>;
> +			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
> +			phys = <&ufs_mem_phy>;
> +			phy-names = "ufsphy";
> +			lanes-per-direction = <2>;
> +			#reset-cells = <1>;
> +			resets = <&gcc GCC_UFS_PHY_BCR>;
> +			reset-names = "rst";
> +			power-domains = <&gcc UFS_PHY_GDSC>;
> +			required-opps = <&rpmhpd_opp_nom>;
> +			iommus = <&apps_smmu 0x100 0x0>;
> +			clocks = <&gcc GCC_UFS_PHY_AXI_CLK>,
> +				 <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
> +				 <&gcc GCC_UFS_PHY_AHB_CLK>,
> +				 <&gcc GCC_UFS_PHY_UNIPRO_CORE_CLK>,
> +				 <&rpmhcc RPMH_CXO_CLK>,
> +				 <&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
> +				 <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
> +				 <&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>;
> +			clock-names = "core_clk",
> +				      "bus_aggr_clk",
> +				      "iface_clk",
> +				      "core_clk_unipro",
> +				      "ref_clk",
> +				      "tx_lane0_sync_clk",
> +				      "rx_lane0_sync_clk",
> +				      "rx_lane1_sync_clk";
> +			freq-table-hz = <75000000 300000000>,
> +					<0 0>,
> +					<0 0>,
> +					<75000000 300000000>,
> +					<0 0>,
> +					<0 0>,
> +					<0 0>,
> +					<0 0>;
> +			status = "disabled";
> +		};
> +
> +		ufs_mem_phy: phy@1d87000 {
> +			compatible = "qcom,sa8775p-qmp-ufs-phy";
> +			reg = <0x0 0x01d87000 0x0 0xe10>;
> +			clocks = <&rpmhcc RPMH_CXO_CLK>,
> +				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>,
> +				 <&gcc GCC_EDP_REF_CLKREF_EN>;
EDP? 0_o

Konrad
> +			clock-names = "ref", "ref_aux", "qref";
> +			power-domains = <&gcc UFS_PHY_GDSC>;
> +			resets = <&ufs_mem_hc 0>;
> +			reset-names = "ufsphy";
> +			#phy-cells = <0>;
> +			status = "disabled";
> +		};
> +
>  		tcsr_mutex: hwlock@1f40000 {
>  			compatible = "qcom,tcsr-mutex";
>  			reg = <0x0 0x01f40000 0x0 0x20000>;
