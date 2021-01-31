Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1209D309CD5
	for <lists+linux-scsi@lfdr.de>; Sun, 31 Jan 2021 15:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhAaOXR (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 31 Jan 2021 09:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbhAaNur (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 31 Jan 2021 08:50:47 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE04C061573;
        Sun, 31 Jan 2021 05:50:05 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 190so10399208wmz.0;
        Sun, 31 Jan 2021 05:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rGnXaB9q6WJ9V1fKp+nQy/pq+xBbMaol02qjjKkh5p8=;
        b=aFn0Y/4GR1NwpLZIe6AxAA8KnuAF/eu79Pw9Xn+iZaAhPhUgeVWVv4+pAFoYMrLiB4
         BF6vX0Lu4md/f0E+xZ5Zw7ddvsIxXUiPavaQ6Gg4BxrJfA0g831gza4x1tt8EhR4GMNL
         x1lQ8RVMc/wW41dWEt5yqnFvH1I7Kt02hD9d/ySA/ul+uXJ3SoCQe6/niBQf5msDmxqV
         VZ9WL3qlc9H2EYxOBPiMkMYPjf6/vdHRTjPGMXB75YyIMLkV2qYqPHrkl7out4y+ee5i
         O4YhsTwMmmCbo53yhg6QMkYBW71V2hJvb7ijRAwYCw9VoOQhApApzFJN/02dg7RUC9MY
         srpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rGnXaB9q6WJ9V1fKp+nQy/pq+xBbMaol02qjjKkh5p8=;
        b=HfwszeNyWNtgWsIJG+7kcjY0RqKW9zK+e3Zj/uZ/PzbIaSJ0gA1SJEzxGgyd2lAeaN
         4uEQLqH+sOVNBHIrxJQVctQhq3a4/LFTge0Sj6V8t1suEnufTy96aiUBsgJiGRfZA1gp
         QzhIbe713gQPRdLDX6nG01omp8LJpWqsEOsXXnNz/2rPhMSdN66Dm0oHRKx/mI+iBcuM
         Srn+sIrIYe0UixyNoGn2fj5Ep+tIlkkOMFhVXFkPUXf5+TB/gt8eUz2uliJl6x7ycqjN
         FOvA/scmuhRCSQ4yp1zkCMl9YNUrJUlrBR4aUED+wp83x0t2PnCsxz5DjLfU4hqTupP/
         nXuw==
X-Gm-Message-State: AOAM532jAWiyX1klbN5VI4BvH5XtT8DenQAunay/XMN99KPTehKbWqvw
        +WktH/F5eoFoBGoCCG0ppAY=
X-Google-Smtp-Source: ABdhPJwjPQ7vvr8+1fczHwbzSPJgKZoYtadqG79wBrsqeoQCVxfmGfYgoAvtD7xKuGw3ayAEy2DC4w==
X-Received: by 2002:a05:600c:35d6:: with SMTP id r22mr11174364wmq.44.1612101004666;
        Sun, 31 Jan 2021 05:50:04 -0800 (PST)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id t15sm2204703wmi.48.2021.01.31.05.50.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 05:50:04 -0800 (PST)
Subject: Re: [PATCH v1 2/2] arm64: dts: mt6779: Support ufshci and ufsphy
To:     Stanley Chu <stanley.chu@mediatek.com>, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, avri.altman@wdc.com,
        alim.akhtar@samsung.com, jejb@linux.ibm.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kuohong.wang@mediatek.com, peter.wang@mediatek.com,
        chun-hung.wu@mediatek.com, andy.teng@mediatek.com,
        chaotian.jing@mediatek.com, cc.chou@mediatek.com,
        jiajie.hao@mediatek.com, alice.chao@mediatek.com,
        hanks.chen@mediatek.com
References: <20201223041345.24864-1-stanley.chu@mediatek.com>
 <20201223041345.24864-3-stanley.chu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <db2e6d9c-a20c-f9a2-e43d-607fb5a5bde4@gmail.com>
Date:   Sun, 31 Jan 2021 14:50:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20201223041345.24864-3-stanley.chu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org



On 23/12/2020 05:13, Stanley Chu wrote:
> Support UFS on MT6779 platforms by adding ufshci and ufsphy
> nodes in dts file.
> 
> Reviewed-by: Hanks Chen <hanks.chen@mediatek.com>
> Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt6779.dtsi | 36 +++++++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt6779.dtsi b/arch/arm64/boot/dts/mediatek/mt6779.dtsi
> index 370f309d32de..a8584b00cc9d 100644
> --- a/arch/arm64/boot/dts/mediatek/mt6779.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt6779.dtsi
> @@ -225,6 +225,41 @@
>  			#clock-cells = <1>;
>  		};
>  
> +		ufshci: ufshci@11270000 {
> +			compatible = "mediatek,mt8183-ufshci";
> +			reg = <0 0x11270000 0 0x2300>;
> +			interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_LOW 0>;
> +			phys = <&ufsphy>;
> +
> +			clocks = <&infracfg_ao CLK_INFRA_UFS>,
> +				 <&infracfg_ao CLK_INFRA_UFS_TICK>,
> +				 <&infracfg_ao CLK_INFRA_UFS_AXI>,
> +				 <&infracfg_ao CLK_INFRA_UNIPRO_TICK>,
> +				 <&infracfg_ao CLK_INFRA_UNIPRO_MBIST>,
> +				 <&topckgen CLK_TOP_FAES_UFSFDE>,
> +				 <&infracfg_ao CLK_INFRA_AES_UFSFDE>,
> +				 <&infracfg_ao CLK_INFRA_AES_BCLK>;
> +			clock-names = "ufs", "ufs_tick", "ufs_axi",
> +				      "unipro_tick", "unipro_mbist",
> +				      "aes_top", "aes_infra", "aes_bclk";
> +			freq-table-hz = <0 0>, <0 0>, <0 0>,
> +					<0 0>, <0 0>, <0 0>,
> +					<0 0>, <0 0>;

We are missing required property: vcc-supply

> +
> +			mediatek,ufs-disable-ah8;
> +			mediatek,ufs-support-va09;

Although supported in the driver, these are not defined in the binding document
(ufs-mediatek.txt). Before adding them, it would be good if you could update the
description to use yaml syntax instead.

Please also add "mediatek,ufs-boost-crypt" which is not defined in the binding
neither.

Regards,
Matthias

> +		};
> +
> +		ufsphy: phy@11fa0000 {
> +			compatible = "mediatek,mt8183-ufsphy";
> +			reg = <0 0x11fa0000 0 0xc000>;
> +			#phy-cells = <0>;
> +
> +			clocks = <&infracfg_ao CLK_INFRA_UNIPRO_SCK>,
> +				 <&infracfg_ao CLK_INFRA_UFS_MP_SAP_BCLK>;
> +			clock-names = "unipro", "mp";
> +		};
> +
>  		mfgcfg: clock-controller@13fbf000 {
>  			compatible = "mediatek,mt6779-mfgcfg", "syscon";
>  			reg = <0 0x13fbf000 0 0x1000>;
> @@ -266,6 +301,5 @@
>  			reg = <0 0x1b000000 0 0x1000>;
>  			#clock-cells = <1>;
>  		};
> -
>  	};
>  };
> 
