Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC68B79FD08
	for <lists+linux-scsi@lfdr.de>; Thu, 14 Sep 2023 09:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236229AbjINHQZ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 14 Sep 2023 03:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236168AbjINHQZ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 14 Sep 2023 03:16:25 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5197CFA
        for <linux-scsi@vger.kernel.org>; Thu, 14 Sep 2023 00:16:20 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso9705321fa.1
        for <linux-scsi@vger.kernel.org>; Thu, 14 Sep 2023 00:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694675779; x=1695280579; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U7SrPQRJuK4tHzsE8n6A80x2pTokYnOBQDatv0CVuDU=;
        b=uti4irkc/imu88lmXQ7ZiF/40I+CzVSFATcK5BzueCC3ndBmcg488zqDGt+y0PeI0w
         5ITxHU8q9qdUbUXlEVm+rIRcxpNDAeayviAu8+6XMeb8bI7Sd0X+lDCHAMwz1l1oRD5F
         47pp/kP6XrL8CSmLGd34Wmw+bpoUYDY2B8JUs5dn2mE22QgdE8WgSxI+uDArmuxSn34v
         M9YHpo23rkWjG2FzBqQ2nwz2XEnSlLdAXFJk4hy/vc466L/in64+YiH2CM5RERt7DHfh
         O9aLdTTDpzWSGG0jm+8hfQLmVS+S88E14uG3jojzlLIMKu2Gtkj2S9nBsL/CLmMrN6qv
         c6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694675779; x=1695280579;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U7SrPQRJuK4tHzsE8n6A80x2pTokYnOBQDatv0CVuDU=;
        b=vsvbn9sMh9VfXXxheP7wyQiyPzZjDq7V35I7fAdGTpn+TS2SvIww5msa7fHnRvPDe2
         TlZlGqO11ni5c9McH3uAvcfV9jRGBF2mj7qGgBBFhdSdhsBiC+qgx7hBV5cfo/A6Bkau
         q6lHBepabwva7wCxvKVRy+qYwZDdy07ZAtkGi5py3JEbKXSRXDSLqdQ/M7FpOuMJN02n
         Ky3c835KE6zY9UIWgM+cOczOHcfM2/4hGAwsdz/62qZ1bSUDtLtliYE6GoLtneArJwed
         qWkptC8qk7mzNUQr8AdST6axyo2/cDuggpcryroXCJYPTHy66zuS3ouqww+3UbLS1jDa
         VwQQ==
X-Gm-Message-State: AOJu0YwyK4+7JGU/9A/uJHZqQmzaJns5zSXtD4Mh1VdePPJvD3tKYD8S
        no8wd0Cp9lwtkBjNiy9k62GU5Q==
X-Google-Smtp-Source: AGHT+IFitqCCdZTcNe2aSaytxGYa0WadIwjc1hNgHYxmqTfCFqIzAlese3qhtNRPnl1aL81WJPb/Zw==
X-Received: by 2002:a2e:9590:0:b0:2bd:ddf:8aa7 with SMTP id w16-20020a2e9590000000b002bd0ddf8aa7mr4055748ljh.0.1694675779129;
        Thu, 14 Sep 2023 00:16:19 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id r6-20020a5d4e46000000b003198a9d758dsm912172wrt.78.2023.09.14.00.16.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 00:16:18 -0700 (PDT)
Message-ID: <1e89183a-b42a-b447-0c1a-bbfe646705ef@linaro.org>
Date:   Thu, 14 Sep 2023 09:16:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2] scsi: ufs: qcom: dt-bindings: Add MCQ properties
Content-Language: en-US
To:     Ziqi Chen <quic_ziqichen@quicinc.com>, quic_asutoshd@quicinc.com,
        quic_cang@quicinc.com, bvanassche@acm.org, mani@kernel.org,
        adrian.hunter@intel.com, beanhuo@micron.com, avri.altman@wdc.com,
        martin.petersen@oracle.com, quic_nguyenb@quicinc.com,
        quic_nitirawa@quicinc.com
Cc:     linux-scsi@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1694675158-38301-1-git-send-email-quic_ziqichen@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1694675158-38301-1-git-send-email-quic_ziqichen@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 14/09/2023 09:05, Ziqi Chen wrote:
> Remove the maxItem limitation to property 'reg',
> and add description for the property 'msi-parent'.
> 
> Signed-off-by: Ziqi Chen <quic_ziqichen@quicinc.com>
> ---
>  Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> index bdfa86a..5ec2717 100644
> --- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> +++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> @@ -77,7 +77,13 @@ properties:
>  
>    reg:
>      minItems: 1
> -    maxItems: 2

So 20 items are allowed? No, that's not correct.


> +    description:
> +      Register base addresses and lengths of the UFS areas.

Drop description - it's useless and redundant.

> +
> +  reg-names:
> +    minItems: 1
> +    description:
> +      Names of the reg areas to use during resource lookup.

Drop such description it's useless, instead list and describe items.

Also, why all devices now have two regs? No, this is just wrong. And
haven't we been here with two items?


>  
>    required-opps:
>      maxItems: 1
> @@ -97,6 +103,10 @@ properties:
>      description:
>        GPIO connected to the RESET pin of the UFS memory device.
>  
> +  msi-parent:
> +    description:
> +      Pointer to the hardware entity that serves as the MSI controller for thi UFS controller.

typo in "thi". Not wrapped according to Linux coding style (as written
in coding style document). BTW, this is usually just "true" and without
need for description.


Best regards,
Krzysztof

