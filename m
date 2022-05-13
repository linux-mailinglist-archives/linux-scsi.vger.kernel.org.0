Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25BE852689C
	for <lists+linux-scsi@lfdr.de>; Fri, 13 May 2022 19:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383125AbiEMRkY (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 13 May 2022 13:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383112AbiEMRkW (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 13 May 2022 13:40:22 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DCC377C6
        for <linux-scsi@vger.kernel.org>; Fri, 13 May 2022 10:40:20 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id x12so8130809pgj.7
        for <linux-scsi@vger.kernel.org>; Fri, 13 May 2022 10:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Ww/qFjWwrZ3PoYuCt3E6efWcKpC5tEXZBrJvZ8cR1LI=;
        b=O93qK4w/S03z5gd4Z+CP5yG9MFg/tvmoc9kyyCQqcV/Mz2YexNCrZo01E2mtLKBtxR
         TRkAlkWmi6D9g3qdIzer7hfnNqJj2J3f4FljvBmblziDyWfSxhbe/vKfL1AGgTuUTsKr
         DoWTcCkB9v6g+skYiRdCfCo3rbG2J6gdkmU3bmnAh3vq1mscALwOR24Gisf+2WZJxLKE
         8uNwQeg9/6kOmzB5byZmOYqLib0M+Y0lvl1FKEpi7xjYOm4zxe+J52sJOtAJy30DiobH
         8xcYSXp/WP6NWt85a5xY4DktYxvQ7eMPBZPMGHG3qn+uit9yW3UN2bZmVArwGTQ88de9
         dxlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Ww/qFjWwrZ3PoYuCt3E6efWcKpC5tEXZBrJvZ8cR1LI=;
        b=AbWFh+zaQI58Z2OqvROICfu8pQgiCzO+cm2f6MpKeiUsxsGwaMcHE6KlHahz6fA3Ev
         KBdrQnFm17RxRazjvUdQ1LidrcfmjTgjvoW/NEi2SpK5dDjKGUyu15KUp4iF6/9heTvX
         L4kKUZpzifiRzgNSOdgPPfBYMwueZcAy1mfmYLRu8EQ68I6rMF6aKutXlnlPFR9emz1d
         /pfFhgAnNRhTSgEny4wcGGssdXpMIzxNk6uBZpun9OVfXcNjFWpF1OZjzYYnWsT8b3Jr
         OCQFPjJqsoz06jrgkIXyNzs2Zl3V8dJ+iYrUsMNaRRE/Jr7ybqifI+5lLZi3KZpnevp0
         ClMA==
X-Gm-Message-State: AOAM53023fmrtJVZPHGgtlW/58gva+L8E1lEQswBsZGec+aWEU7NjtWf
        /Dlmb0to6y8Gna7jmkOkYyfX
X-Google-Smtp-Source: ABdhPJzraGPi1ax/y/zer2RyzKcWfeu62crVSXxE94AtGdfKOMGGkKDp4NJOyHwJem3eCBrEO733Rw==
X-Received: by 2002:a05:6a00:a85:b0:506:b9e:7f43 with SMTP id b5-20020a056a000a8500b005060b9e7f43mr5524669pfl.5.1652463620335;
        Fri, 13 May 2022 10:40:20 -0700 (PDT)
Received: from thinkpad ([117.202.184.246])
        by smtp.gmail.com with ESMTPSA id j18-20020a170902da9200b0015e8d4eb272sm2160673plx.188.2022.05.13.10.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 10:40:19 -0700 (PDT)
Date:   Fri, 13 May 2022 23:10:10 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-scsi@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 3/7] dt-bindings: ufs: common: add OPP table
Message-ID: <20220513174010.GC1922@thinkpad>
References: <20220513061347.46480-1-krzysztof.kozlowski@linaro.org>
 <20220513061347.46480-4-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220513061347.46480-4-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, May 13, 2022 at 08:13:43AM +0200, Krzysztof Kozlowski wrote:
> Except scaling UFS and bus clocks, it's necessary to scale also the
> voltages of regulators or power domain performance state levels.  Adding
> Operating Performance Points table allows to adjust power domain
> performance state, depending on the UFS clock speed.
> 
> OPPv2 deprecates previous property limited to clock scaling:
> freq-table-hz.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> ---
> 
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../devicetree/bindings/ufs/ufs-common.yaml   | 34 +++++++++++++++++--
>  1 file changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/ufs/ufs-common.yaml b/Documentation/devicetree/bindings/ufs/ufs-common.yaml
> index 47a4e9e1a775..d7d2c8a136bb 100644
> --- a/Documentation/devicetree/bindings/ufs/ufs-common.yaml
> +++ b/Documentation/devicetree/bindings/ufs/ufs-common.yaml
> @@ -20,11 +20,24 @@ properties:
>        items:
>          - description: Minimum frequency for given clock in Hz
>          - description: Maximum frequency for given clock in Hz
> +    deprecated: true
>      description: |
> +      Preferred is operating-points-v2.
> +
>        Array of <min max> operating frequencies in Hz stored in the same order
> -      as the clocks property. If this property is not defined or a value in the
> -      array is "0" then it is assumed that the frequency is set by the parent
> -      clock or a fixed rate clock source.
> +      as the clocks property. If either this property or operating-points-v2 is
> +      not defined or a value in the array is "0" then it is assumed that the
> +      frequency is set by the parent clock or a fixed rate clock source.
> +
> +  operating-points-v2:
> +    description:
> +      Preferred over freq-table-hz.
> +      If present, each OPP must contain array of frequencies stored in the same
> +      order for each clock.  If clock frequency in the array is "0" then it is
> +      assumed that the frequency is set by the parent clock or a fixed rate
> +      clock source.

This description mentions only the clocks and not voltages. But in theory, the
OPP table can contain other parameters like current, bandwidth, etc,... So to
avoid confusion, I'd suggest to get rid of the description.

> +
> +  opp-table: true
>  
>    interrupts:
>      maxItems: 1
> @@ -75,8 +88,23 @@ properties:
>  
>  dependencies:
>    freq-table-hz: [ 'clocks' ]
> +  operating-points-v2: [ 'clocks', 'clock-names' ]

What about voltage regulators if relevant opp property is present?

Thanks,
Mani

>  
>  required:
>    - interrupts
>  
> +allOf:
> +  - if:
> +      required:
> +        - freq-table-hz
> +    then:
> +      properties:
> +        operating-points-v2: false
> +  - if:
> +      required:
> +        - operating-points-v2
> +    then:
> +      properties:
> +        freq-table-hz: false
> +
>  additionalProperties: true
> -- 
> 2.32.0
> 

-- 
மணிவண்ணன் சதாசிவம்
