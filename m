Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32A973459B
	for <lists+linux-scsi@lfdr.de>; Sun, 18 Jun 2023 10:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjFRIx7 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 18 Jun 2023 04:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjFRIx6 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 18 Jun 2023 04:53:58 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7243E4
        for <linux-scsi@vger.kernel.org>; Sun, 18 Jun 2023 01:53:55 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-977d55ac17bso391424566b.3
        for <linux-scsi@vger.kernel.org>; Sun, 18 Jun 2023 01:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687078434; x=1689670434;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YOqV3rtDI0CEwXVVct5W5QTJ26AQRGV9DPKnHoyoIyQ=;
        b=Zj+V58GInMfbtKYprzCSYWjBjv7MENDx3liQ1mLiiPKRVC0M87JHlg52gJlVfOKyIh
         ZWa6SH3qB8nijzClxj1aD9iwcNqO8ar4GRB1gRd04tCMxTOASO4lZwGD+T3mbmb0BJG1
         ZPHNtIX5xLZMNmYqAy1pFIsantKEsbI6WA1BV74JL6dWs6fFia2n5GpFiqifAS11ABFD
         3JI+0FuSgBNyqDmUVbmZfjWKa7LGBkior3iAT1J795YWg1i8otdJtkpKE7xOVnnXROOD
         yhcLJJi47PnyNTjLDAtBWTtW24DKuNUcod8sJq8Q9G2LJjN9IWFE/dKAUI4CWJv1HsaY
         FY6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687078434; x=1689670434;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YOqV3rtDI0CEwXVVct5W5QTJ26AQRGV9DPKnHoyoIyQ=;
        b=iJC4H83clW0MjAnmncxtpajjk2SjRVW3JDAJdlQYc4SJiaIYUWMcvu80kSblWLbrO0
         MoS9ydldyunS5NKPmsYu1w/3P8ZgjHN1ajffGPSG+j5bQbl5Eh7wEv4IT3KKGW3yIkwj
         zF0ePmmD4BllduC+9A6dZ4c/qeyWd6C6W2+hwfnoT2KUIE+8zltS1lvY/Ptk9s3iUp5j
         zwW44UkPg4WTp/ZkGv7O5dt6phtwyVy0tgzHauNZIZZLqVv0K8mLXNkcyLsIqofA6Cj0
         +OMb6+6pirqbke/Y0BLH7cubdWiK8iA+e8f6KYrEFKdoVSDPqRpdMEiag0k13fYzxFTF
         Qzxg==
X-Gm-Message-State: AC+VfDyn8IjtRBIowFA0l4NvC/DITO1WuxaqJ/0GW5Da5oqSPN12/xXq
        pztls+udXOo2ok9ndfv2s8Rc/g==
X-Google-Smtp-Source: ACHHUZ5XJfX3/rCW8fWgqzmOnFENO/jS3uPJQ7JC93XERneKvBVIK4hcgep9HTEjZOoGKJW1VKUthQ==
X-Received: by 2002:a17:907:a0c:b0:978:8e8c:1bcb with SMTP id bb12-20020a1709070a0c00b009788e8c1bcbmr6364791ejc.43.1687078434141;
        Sun, 18 Jun 2023 01:53:54 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id w19-20020a1709064a1300b00988955f7b5esm152722eju.157.2023.06.18.01.53.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jun 2023 01:53:53 -0700 (PDT)
Message-ID: <4aadaf24-11f6-5cc1-4fbd-addbef4f891b@linaro.org>
Date:   Sun, 18 Jun 2023 10:53:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v7 1/3] dt-bindings: ufs: qcom: Add ICE phandle
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
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
References: <20230408214041.533749-1-abel.vesa@linaro.org>
 <20230408214041.533749-2-abel.vesa@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230408214041.533749-2-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 08/04/2023 23:40, Abel Vesa wrote:
> Starting with SM8550, the ICE will have its own devicetree node
> so add the qcom,ice property to reference it.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> 
> The v6 is here:
> https://lore.kernel.org/all/20230407105029.2274111-3-abel.vesa@linaro.org/
> 
> Changes since v6:
>  * Dropped the minItems for both the qcom,ice and the reg in the
>    qcom,ice compatile subschema, like Krzysztof suggested
> 
> Changes since v5:
>  * dropped the sm8550 specific subschema and replaced it with one that
>    mutually excludes the qcom,ice vs both the ICE specific reg range
>    and the ICE clock
> 
> Changes since v4:
>  * Added check for sm8550 compatible w.r.t. qcom,ice in order to enforce
>    it while making sure none of the other platforms are allowed to use it
> 
> Changes since v3:
>  * dropped the "and drop core clock" part from subject line
> 
> Changes since v2:
>  * dropped all changes except the qcom,ice property
> 
> 
>  .../devicetree/bindings/ufs/qcom,ufs.yaml     | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> index c5a06c048389..10d426ba1959 100644
> --- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> +++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> @@ -70,6 +70,10 @@ properties:
>    power-domains:
>      maxItems: 1
>  
> +  qcom,ice:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: phandle to the Inline Crypto Engine node
> +
>    reg:
>      minItems: 1
>      maxItems: 2
> @@ -187,6 +191,26 @@ allOf:
>  
>      # TODO: define clock bindings for qcom,msm8994-ufshc
>  
> +  - if:
> +      properties:
> +        qcom,ice:

Un-reviewed. This is broken and was never tested. After applying this
patch, I can see many new warnings in all DTBs (so it is easy to spot
that it was not actually tested).

Your probably meant here:
  if:
    required:


Best regards,
Krzysztof

