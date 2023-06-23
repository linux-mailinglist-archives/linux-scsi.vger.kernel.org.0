Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961C273B73F
	for <lists+linux-scsi@lfdr.de>; Fri, 23 Jun 2023 14:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjFWMb5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 23 Jun 2023 08:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjFWMbz (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 23 Jun 2023 08:31:55 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5391EB7
        for <linux-scsi@vger.kernel.org>; Fri, 23 Jun 2023 05:31:54 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f9b4a71623so6539635e9.1
        for <linux-scsi@vger.kernel.org>; Fri, 23 Jun 2023 05:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687523513; x=1690115513;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XgzDLcXuxZvPzDXTcXShPjq83v8v5x+qH2Z62iL4DPg=;
        b=CD+qIGYvt+dSmpznE82wTIGr4VptpJ/PIixLD99ZuOBsha/Jq9ouAFjL58nrH0dBxy
         zfBzaz0xgNKbkIRHM9tX9uNEr1tTDXMr4AwPe1G+ONtNpSzXGNa3VSWq0DVAvTUwdc1Q
         rh2+hc8fh/gbSyrYA1rgITta0tFAxGxtDJDrIYapoGgmRzFP33WSSB3NnVdOPPidsNxX
         JLR9t1ISQyqWq0Dp57CJze9kcRWeNxAfmSrBeY+tvN4HhudyjxQktJc1HCXs98D7qGlN
         XbEkzduwUNeghh5R0helD2Vgvg1972rl08aOOhc9hf0XrjoVV03J4f8HudUCwMRXN1Zh
         6ezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687523513; x=1690115513;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XgzDLcXuxZvPzDXTcXShPjq83v8v5x+qH2Z62iL4DPg=;
        b=htbCfpOq7XfXuHsr5GkD7l5rLKrJkR9aApxQtzjvPE3ttardUTCxXys7NYOW/jfLF8
         BefXvoCpHoCiXKPVPTpIoSCW5hXIWM4hkHW2t2oaePGWKCiA0Dy/5gn1UCJGUEDhKwAY
         0SnCDXW24YCpCahzRqaLrvcyLrg/G89tu1i4nB3NzfhFngD+cXy6C1f7CuRPNDQVkawR
         touAGdSgRSLMHRWlo2drVnulXnS+yb1SJpkgTO6UMJvIFruij0OOoYKY/FnxHMGUMmxe
         eDSgs5IN9s8XZdRmbjgVMBkpvLa4ubF6qa1a8Isr0JZ2IH6Ej9LyGyAwMPJephmHum1m
         3feg==
X-Gm-Message-State: AC+VfDyMqcOU6N988YhVScx0+fhgXNm/84Ca7Qx/yNEkmzjNLHG20b0H
        SeL3V02KSI/rgIs64CH+3Xn1Nw==
X-Google-Smtp-Source: ACHHUZ5e6B4A10qr4sU19GSEERbThxTSpkM5Nxxs2SbsMRH0g1fPLSc0U76ji2Me1MW1Q0bA5+BR2g==
X-Received: by 2002:a05:600c:ad9:b0:3fa:7db9:86b0 with SMTP id c25-20020a05600c0ad900b003fa7db986b0mr951097wmr.37.1687523512696;
        Fri, 23 Jun 2023 05:31:52 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id x13-20020a1c7c0d000000b003f9c859894esm2273353wmc.7.2023.06.23.05.31.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 05:31:52 -0700 (PDT)
Message-ID: <cd84b8c6-fac7-ecef-26be-792a1b04a102@linaro.org>
Date:   Fri, 23 Jun 2023 14:31:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 5/5] scsi: dt-bindings: ufs: qcom: Fix warning for sdm845
 by adding reg-names
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Luca Weiss <luca.weiss@fairphone.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20230623113009.2512206-1-abel.vesa@linaro.org>
 <20230623113009.2512206-6-abel.vesa@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230623113009.2512206-6-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 23/06/2023 13:30, Abel Vesa wrote:
> There is a warning on dtbs check for sdm845, amongst other platforms,
> about the reg-names being unevaluated. Fix that by adding reg-names to
> the clocks and reg properties check for such platforms.
> 
> Fixes: 462c5c0aa798 ("dt-bindings: ufs: qcom,ufs: convert to dtschema")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> index 0209713d1f88..894b57117314 100644
> --- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> +++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> @@ -166,6 +166,10 @@ allOf:
>          reg:
>            minItems: 2
>            maxItems: 2
> +        reg-names:
> +          items:
> +            - const: std
> +            - const: ice

reg-names looks like a new property, so it should be defined in
top-level and just constrained per-variant.

Also there was similar approach:
https://lore.kernel.org/all/20221209-dt-binding-ufs-v2-2-dc7a04699579@fairphone.com/

but I guess no resends and it can be superseded.

Best regards,
Krzysztof

