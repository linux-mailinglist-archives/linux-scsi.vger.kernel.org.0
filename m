Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01F94E2A7C
	for <lists+linux-scsi@lfdr.de>; Mon, 21 Mar 2022 15:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347899AbiCUOZR (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 21 Mar 2022 10:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352559AbiCUOWj (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 21 Mar 2022 10:22:39 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5118818689A
        for <linux-scsi@vger.kernel.org>; Mon, 21 Mar 2022 07:16:35 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id k10so4797071oia.0
        for <linux-scsi@vger.kernel.org>; Mon, 21 Mar 2022 07:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QH3AWcYu7AkrcxCD+1AyJsqFqXIRrhSBVQz3h8P5LfU=;
        b=a6jbebu58k8yNzCyy4LCvlCQfQ5EzUFQADfFplTD2dfiDuiewpP7F1xnW4RRu/3Hl2
         Neot+S3ZbVaxnTtRDhtUsIZ0HDQ7KFpEdw++9id9UisJ+P1+wlkUbdOr+Wo7Fhiz/YSx
         Gsz5gzPENQPO4Pv5fQIjyAe3t2x/eCF0rGlxm1ER6f/99PTPtcM7xkKkMOqWw6Sjq2YI
         J12f/TWMw9dUxicqEYP7RNMREIqVgf7ElH+0hDXNpZCnD7pmg4MjSHa3/t4cIcdQIqIm
         ZHDJlecpJAwyR71E0IPtlqUKPzedq/5+2dX+vBxD2XI8YVqqmfu6joNwPe7YTGhvPPYN
         2OFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QH3AWcYu7AkrcxCD+1AyJsqFqXIRrhSBVQz3h8P5LfU=;
        b=RGEF27KekpXWTOatZ9S5L6XI47vqwZ0C3Tvs+pYGS74WBnV/Bz/DL7HvF0d0Ye3tm4
         4oZhoSrTaPsFRUZUaxkI/jFnlRvm2h93GaOOicQm8oW0fGeCLRDINhn2FN/BMLhomDsO
         1+f8DGzQXB2dWsS7MUIUFcUATK+CNvgt0UHBcZcHA2mNx6OiBCpI7RffCbmh5gOq0MLP
         7dusEhugdXNozyDGSUhPZjSNlC2qVamGMlY3St9nj3CXTqmUtMjqcIy8uZMpwKPyonQo
         yuOUzZB/uRuPBhlClPJHNU8FGe1yf6HlNaEK7uSJXG5fB1DZLkw1fH9/bdLOYZ7anbyL
         yC+Q==
X-Gm-Message-State: AOAM533uBkKCn/EA/QmJkiqq72RD07o3aSOkPuEipZislmKWJ48SxM38
        +JM7RJoTxD2j39Plcb1K4QfZaQ==
X-Google-Smtp-Source: ABdhPJxr4m2fEljzSzrW1Im9R0W5tgP6mwWuY4H+a54HyaHHJTHSHL/qeGghCZ3NUXyPTdlVO8s+JQ==
X-Received: by 2002:a05:6808:47:b0:2ec:bddc:c677 with SMTP id v7-20020a056808004700b002ecbddcc677mr13705279oic.250.1647872190940;
        Mon, 21 Mar 2022 07:16:30 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id j9-20020a056830270900b005b22854f3besm7439539otu.39.2022.03.21.07.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 07:16:29 -0700 (PDT)
Date:   Mon, 21 Mar 2022 09:16:27 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
Subject: Re: [RFT] ufs: qcom: drop custom Android boot parameters
Message-ID: <YjiIu7BGP4fG13ct@builder.lan>
References: <20220320110616.18355-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220320110616.18355-1-krzk@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sun 20 Mar 06:06 CDT 2022, Krzysztof Kozlowski wrote:

> The QCOM UFS driver requires an androidboot.bootdevice command line
> argument matching the UFS device name.  If the name is different, it
> refuses to probe.  Thise androidboot.bootdevice is provided by
> stock/vendor (from an Android-based device) bootloader.
> 
> This does not make sense from Linux point of view.  Driver should be
> able to boot regardless of bootloader.  Driver should not depend on some
> Android custom environment data.
> 
> Cc: Luca Weiss <luca.weiss@fairphone.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
> 
> Not tested, please kindly provide tests.
> 
> See also:
> https://lore.kernel.org/linux-devicetree/f61abc2b-3ce8-7b1f-3d28-8a4a03ec58eb@kernel.org/T/#u
> ---
>  drivers/scsi/ufs/ufs-qcom.c | 15 ---------------
>  1 file changed, 15 deletions(-)
> 
> diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
> index 0d2e950d0865..586c0e567ff9 100644
> --- a/drivers/scsi/ufs/ufs-qcom.c
> +++ b/drivers/scsi/ufs/ufs-qcom.c
> @@ -957,18 +957,6 @@ static const struct reset_control_ops ufs_qcom_reset_ops = {
>  	.deassert = ufs_qcom_reset_deassert,
>  };
>  
> -#define	ANDROID_BOOT_DEV_MAX	30
> -static char android_boot_dev[ANDROID_BOOT_DEV_MAX];
> -
> -#ifndef MODULE
> -static int __init get_android_boot_dev(char *str)
> -{
> -	strlcpy(android_boot_dev, str, ANDROID_BOOT_DEV_MAX);
> -	return 1;
> -}
> -__setup("androidboot.bootdevice=", get_android_boot_dev);
> -#endif
> -
>  /**
>   * ufs_qcom_init - bind phy with controller
>   * @hba: host controller instance
> @@ -988,9 +976,6 @@ static int ufs_qcom_init(struct ufs_hba *hba)
>  	struct resource *res;
>  	struct ufs_clk_info *clki;
>  
> -	if (strlen(android_boot_dev) && strcmp(android_boot_dev, dev_name(dev)))
> -		return -ENODEV;
> -
>  	host = devm_kzalloc(dev, sizeof(*host), GFP_KERNEL);
>  	if (!host) {
>  		err = -ENOMEM;
> -- 
> 2.32.0
> 
