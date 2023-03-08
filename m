Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECD56B03BD
	for <lists+linux-scsi@lfdr.de>; Wed,  8 Mar 2023 11:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjCHKKB (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 8 Mar 2023 05:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjCHKJ6 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 8 Mar 2023 05:09:58 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772647B111
        for <linux-scsi@vger.kernel.org>; Wed,  8 Mar 2023 02:09:52 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id k14so20623599lfj.7
        for <linux-scsi@vger.kernel.org>; Wed, 08 Mar 2023 02:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678270191;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=48aNbwgEHUhRck6RQPE3THIY0DWr0lbu5a/+Lgdggd4=;
        b=ZpIS/ppyxfpXVtWdulOE8xfF9Trl8FC1LTCOGkEGgcYDHAzfMZ0atkilaKPxpJvAWN
         8/r5IBkuBVTlKiuk/0IvmuJAe/0NNMQYwsfpqBSj/aON3fvWkOMzOyYK+HPszgxKdE8O
         WLY8W94YzAgaMh+USZUe+iWyNB5gTgdpKEs5GIqQoPXHWoze4mRx0MVGcnXcu2/LVKv0
         vJaRoJcdxIvGFklGv398ovf9T0BKN+aEFVYbpLH1xzZV3oUIFlzD9m0AAWBOP5G09DxY
         sMmb9q7McAkQUVwwtQ/fJfjkAFsllWEGOgB+ey8DZ6yJB62xIjqCpKEBBQ7FNgx1+nRn
         ldTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678270191;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=48aNbwgEHUhRck6RQPE3THIY0DWr0lbu5a/+Lgdggd4=;
        b=vF4OXeCw8fnDT8yVjrE2G+T7/YMWyikt5/yJvcHH+J7glflnYGIslhDpW439wbLtwY
         K4DEHBro/EDvwS2D4ZOzMFoYIK1+NJhqgKD2UFJZtUmSLLP6JukTVHAe160pkkims05p
         PscH5Hs5SeTxsAnEd2Bttx5cV01POuL0ZUMHYbLiWat4834OC3YQL6MknaShoLDVrbGn
         niefU19BMrQHbSED/3KkNwlyfOHiDxT6QJK+HDOKV/yiwCd5cKQ7YHpBPyF5YoUzfiCs
         qCVrUN/xB2vYUvW9BZ+pNCmofR4PhGPamW3FW98XwrBrDZFLi181bHc/S9utOo1DpRpP
         /+VQ==
X-Gm-Message-State: AO0yUKUcbwujviezeeDiOQz9WPgS4Iw8lw5/I3OBNk886Ilj2q3Wv3y3
        vKHCnZD3DCgUJdLvYuAAZTflKyuCkf1+cuw5UwA=
X-Google-Smtp-Source: AK7set/s4WTptWdpKAuGcr/1Ufve3MJkvhM6ta3Z9PV0H8GqEWXsPUHjTWDVZBqRuABACPYawiXzmA==
X-Received: by 2002:ac2:558e:0:b0:4dc:852d:9b88 with SMTP id v14-20020ac2558e000000b004dc852d9b88mr4906462lfg.45.1678270190690;
        Wed, 08 Mar 2023 02:09:50 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id d21-20020ac25455000000b004dc7fe3a2d3sm2283801lfn.135.2023.03.08.02.09.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 02:09:50 -0800 (PST)
Message-ID: <25c17af5-8f6b-a2c3-dab3-f9bc69711db7@linaro.org>
Date:   Wed, 8 Mar 2023 11:09:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 3/6] phy: qcom-qmp: Add SM6125 UFS PHY support
Content-Language: en-US
To:     Lux Aliaga <they@mint.lgbt>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
        bvanassche@acm.org, keescook@chromium.org, tony.luck@intel.com,
        gpiccoli@igalia.com
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-hardening@vger.kernel.org,
        phone-devel@vger.kernel.org, martin.botka@somainline.org,
        marijn.suijten@somainline.org
References: <20230306170817.3806-1-they@mint.lgbt>
 <20230306170817.3806-4-they@mint.lgbt>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230306170817.3806-4-they@mint.lgbt>
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



On 6.03.2023 18:08, Lux Aliaga wrote:
> The SM6125 UFS PHY is compatible with the one from SM6115. Add a
> compatible for it and modify the config from SM6115 to make them
> compatible with the SC8280XP binding
> 
> Signed-off-by: Lux Aliaga <they@mint.lgbt>
> Reviewed-by: Martin Botka <martin.botka@somainline.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> index 318eea35b972..44c29fdfc551 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> @@ -620,6 +620,13 @@ static const char * const qmp_phy_vreg_l[] = {
>  	"vdda-phy", "vdda-pll",
>  };
>  
> +static const struct qmp_ufs_offsets qmp_ufs_offsets_v3_660 = {
> +	.serdes		= 0,
> +	.pcs		= 0xc00,
> +	.tx		= 0x400,
> +	.rx		= 0x600,
> +};
> +
>  static const struct qmp_ufs_offsets qmp_ufs_offsets_v5 = {
>  	.serdes		= 0,
>  	.pcs		= 0xc00,
> @@ -693,6 +700,8 @@ static const struct qmp_phy_cfg sdm845_ufsphy_cfg = {
>  static const struct qmp_phy_cfg sm6115_ufsphy_cfg = {
>  	.lanes			= 1,
>  
> +	.offsets		= &qmp_ufs_offsets_v3_660,
Will this not trigger OOB r/w for the users of qcom,sm6115-smp-ufs-phy
which specify the regions separately (old binding style)?

Konrad
> +
>  	.serdes_tbl		= sm6115_ufsphy_serdes_tbl,
>  	.serdes_tbl_num		= ARRAY_SIZE(sm6115_ufsphy_serdes_tbl),
>  	.tx_tbl			= sm6115_ufsphy_tx_tbl,
> @@ -1172,6 +1181,9 @@ static const struct of_device_id qmp_ufs_of_match_table[] = {
>  	}, {
>  		.compatible = "qcom,sm6115-qmp-ufs-phy",
>  		.data = &sm6115_ufsphy_cfg,
> +	}, {
> +		.compatible = "qcom,sm6125-qmp-ufs-phy",
> +		.data = &sm6115_ufsphy_cfg,
>  	}, {
>  		.compatible = "qcom,sm6350-qmp-ufs-phy",
>  		.data = &sdm845_ufsphy_cfg,
