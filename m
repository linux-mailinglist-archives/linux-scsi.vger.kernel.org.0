Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD55E6B5629
	for <lists+linux-scsi@lfdr.de>; Sat, 11 Mar 2023 01:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjCKAG1 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 10 Mar 2023 19:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjCKAGV (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 10 Mar 2023 19:06:21 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F39812EE71
        for <linux-scsi@vger.kernel.org>; Fri, 10 Mar 2023 16:06:07 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id z5so7040995ljc.8
        for <linux-scsi@vger.kernel.org>; Fri, 10 Mar 2023 16:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678493165;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nvWd6RnRtPsl4syozMKjmZ8lJWkYg+/DrGeZ1RVg3jg=;
        b=m9oP/nOWxDKYfkbYYH6incjMnwiXyGPjUkjfMHEQS36/WFVBYT5Hnbr47iAQ/Jhn78
         mkZil2n4ckEpjDFr8OaCad28O332YGrB7MWsbnIAe2fJCMBkiwhwJ6uGXtywhdM7piMv
         eqSDzVnPm79KE0scs6ON3AO/sJ26Lsan5neIp+OCG7Ynu8fDeBx1imbLSc2sIVvhTHvU
         NyCeAgUtOwpJnE/mT9lYD4y2TvkOpTfPAZRBf0VS7hDADGzIu86KEwXr1huV8eVOR3Au
         E1SljP/x16mk2BE/2B8b88BQXwdOICJ7/pYyNJmy6qQUVK5ZQ3ykCObPbTYCsCtRE0Or
         Mrgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678493165;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nvWd6RnRtPsl4syozMKjmZ8lJWkYg+/DrGeZ1RVg3jg=;
        b=YfA2NqY4N5sae8ctyVxtpoqsjrovdmDTxuAxSXED7xXZr2w89tMaG/nTyOAagO8DiY
         gMlPSLe8EcUH4iiGxDgo86Vapcbe8EDiEcSQlvsRDNgQaLaWz+Q4ChqpRNx+u+Vh21DB
         0uyoR95fqDhLL//VVfbpZGGTBPoLqkhCGoTp+ldszB8ajbV3vkIg4fheH5ECvS9TQNmt
         CpzcXYJ1CzvmVWYb0rr+oFYz7HLgN0e+6w+qJcewUIq0wL7WWn93VtAWLDeMeDjOAuET
         OVDXSzc1ur1P6CzDc7HHL3oMtvA5SafIHeck2aYjm9gAspwGjUiucIoEt83Lsbz+zxF7
         LRrw==
X-Gm-Message-State: AO0yUKUIMB+B8mDLC2XIYYBeTgShwc5jgIda/z+2kZ8+qnO4Nc1V3BDz
        cI1tXonJqNniPb8flO1q7zKWlOEr+m52oGhxFOA=
X-Google-Smtp-Source: AK7set9/2QfL4loiubmYv5vdmt0lQ9s1Km9YMcKFQl/SUMpIYys4kYlQEHTjc8qKGK4W2556vpzckA==
X-Received: by 2002:a2e:b173:0:b0:295:b054:6809 with SMTP id a19-20020a2eb173000000b00295b0546809mr8729234ljm.8.1678493165492;
        Fri, 10 Mar 2023 16:06:05 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id y20-20020a2e5454000000b00295a33eda65sm155824ljd.137.2023.03.10.16.06.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 16:06:05 -0800 (PST)
Message-ID: <128a4831-a094-3e5a-282b-8e40b2cfd960@linaro.org>
Date:   Sat, 11 Mar 2023 01:06:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/3] ufs: qcom: add __maybe_unused to OF ID table
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-scsi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20230310214435.275127-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230310214435.275127-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org



On 10.03.2023 22:44, Krzysztof Kozlowski wrote:
> The driver can be built on ACPI and its .of_match_table uses
> of_match_ptr(), thus annotate the actual table as maybe unused.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/ufs/host/ufs-qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index a02cd866e2f8..82d02e7f3b4f 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -1693,7 +1693,7 @@ static int ufs_qcom_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static const struct of_device_id ufs_qcom_of_match[] = {
> +static const struct of_device_id ufs_qcom_of_match[] __maybe_unused = {
>  	{ .compatible = "qcom,ufshc"},
>  	{},
>  };
