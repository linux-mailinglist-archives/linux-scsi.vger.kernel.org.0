Return-Path: <linux-scsi+bounces-5946-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE60C90C45F
	for <lists+linux-scsi@lfdr.de>; Tue, 18 Jun 2024 09:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D715281669
	for <lists+linux-scsi@lfdr.de>; Tue, 18 Jun 2024 07:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FEB146D6D;
	Tue, 18 Jun 2024 07:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ldU06kSN"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A32C139D00
	for <linux-scsi@vger.kernel.org>; Tue, 18 Jun 2024 07:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718694821; cv=none; b=RwPdRGDwzGJ7Wd2pSXVXXzapPfGxxFG3wNumIK5xhNSv5Gy1JSDOsB39PnfA7ppZ2l/R3lwNDsHDC8XwdYqV8boo9mi4FDY0sdkrZOUP6vNVLSUALuPMKdZaLN7iDqJ6hfTZcmoGhsGXUbz7eh7dJYN6Vv+e3FP9ur2SbDyLhpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718694821; c=relaxed/simple;
	bh=9ya6iEKqGg8De/4s6Ze4xDIb+xQaAQNCIrZCtIWF/7s=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=IqySCKVJErfXzFtC2CWBNKml3AXAqYxZM1Nc0pCI3uIeo4LXMPl4jRO0hs99Z7vbRwclPHKv4EVWyXc6mulZ/jXNeY6StO4Y/Y7QcL/GSJvgxroV++biSduhX9zTgpmB9+0/2h4cPwca66DR12Rxj+ctVwUHPaSrDm6SaKA1M5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ldU06kSN; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4217990f8baso46108985e9.2
        for <linux-scsi@vger.kernel.org>; Tue, 18 Jun 2024 00:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718694817; x=1719299617; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1wiBjLcn5WbWlRuyHrxpnQqW9c9nIklW7PRJKCt1+mI=;
        b=ldU06kSNw0FLOx0n2BJJ3b9TFaxXyCr755UCfA+09pmW4BWiyu/y/rYdPzSZedPGLI
         BLFc87rF+wBB97XUgdajI0/miFtn6wpU/PJqCu6l3rWw4x+99WbIivv9jDB6VAVzp8oI
         4H/qVj4imD6x0OuP63l8aMWF7kCKsrjfvwXsZc6oUuCGh0Srn7NMB5YCIvSJH0G5EPwe
         UjcNqynrSM4qCl9wmrHU6KPs2A1zIvC7HGy5z0iNuuS4NBtT9DR7rOj6p6t/rOr6UBkE
         YTTN9xOTKWsoGJURhYdOfxllvu0DHjKds8nyWnZg2YoN9VOWAOd/R6qrdBfAQ9P0f/CA
         8IWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718694817; x=1719299617;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1wiBjLcn5WbWlRuyHrxpnQqW9c9nIklW7PRJKCt1+mI=;
        b=kP44nxRbSS8ViqS1cqRYdclq+WkQ2DATP/bWUoiw4FffoLjSIBwXJfaaiNJKO/pkX2
         8pInKQawta6SG5zpCQPK84W9TenZUPmotxgZKiuCm78LpNmQC4WcpA4NPHg+OE97+9J5
         XhdF1Pmhow0kBg2IWYhhmp6FruR2TUlmmoSWKh83CCYFx9e5q61/TQXgCePA80ytNT1j
         2Ioirihhp3bsA2MHbL4uAIUIkjVcH+zfWo4/JspXE/jZ33wAhC9T6TxVowNz02Ev+opS
         PMpFAuNagYZWC+XKm5BRSl8RNSaLhoeExyitt+20OPlW5rIPeso51ezF7Zov6sI+6b1N
         iMIg==
X-Forwarded-Encrypted: i=1; AJvYcCV820sr05TT5xzh++fdmz2zO7/0zArmdVXR4oUnVwoYXh0ejuESSe8PdxcLIpqDa0B2TI8IPKjxTvqGhkPXiIIl1fEpS70f8S85Uw==
X-Gm-Message-State: AOJu0YwmS4AiUXsvN/O8I4kBeJY81hEdP7vbbI67grD3A1GlnQJx8s5W
	P1uSiEu/ymRdJzgCfr35aTMKSkT0KODhUg9Gy4pUG2S7t4CXDBBZSgYVqeO1FRY=
X-Google-Smtp-Source: AGHT+IHS9iZxX2xl/jBNg4f+neP7mB0SCIizLgvgWkWOKv8wSW3XcXSQF6qHt2nKb5aYk3tH9re1MA==
X-Received: by 2002:a05:600c:154d:b0:421:8028:a507 with SMTP id 5b1f17b1804b1-4230482b872mr76976565e9.18.1718694816781;
        Tue, 18 Jun 2024 00:13:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:7f31:be49:5b98:50cd? ([2a01:e0a:982:cbb0:7f31:be49:5b98:50cd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422a1e68d04sm196876345e9.36.2024.06.18.00.13.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 00:13:36 -0700 (PDT)
Message-ID: <ad7f22f5-21e4-4411-88f3-7daa448d2c83@linaro.org>
Date: Tue, 18 Jun 2024 09:13:34 +0200
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v5 04/15] soc: qcom: ice: add hwkm support in ice
To: Gaurav Kashyap <quic_gaurkash@quicinc.com>,
 linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
 andersson@kernel.org, ebiggers@google.com, srinivas.kandagatla@linaro.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, robh+dt@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 kernel@quicinc.com, linux-crypto@vger.kernel.org,
 devicetree@vger.kernel.org, quic_omprsing@quicinc.com,
 quic_nguyenb@quicinc.com, bartosz.golaszewski@linaro.org,
 konrad.dybcio@linaro.org, ulf.hansson@linaro.org, jejb@linux.ibm.com,
 martin.petersen@oracle.com, mani@kernel.org, davem@davemloft.net,
 herbert@gondor.apana.org.au, psodagud@quicinc.com, quic_apurupa@quicinc.com,
 sonalg@quicinc.com
References: <20240617005825.1443206-1-quic_gaurkash@quicinc.com>
 <20240617005825.1443206-5-quic_gaurkash@quicinc.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20240617005825.1443206-5-quic_gaurkash@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/06/2024 02:50, Gaurav Kashyap wrote:
> Qualcomm's ICE (Inline Crypto Engine) contains a proprietary
> key management hardware called Hardware Key Manager (HWKM).
> This patch integrates HWKM support in ICE when it is
> available. HWKM primarily provides hardware wrapped key support
> where the ICE (storage) keys are not available in software and
> protected in hardware.
> 
> When HWKM software support is not fully available (from Trustzone),
> there can be a scenario where the ICE hardware supports HWKM, but
> it cannot be used for wrapped keys. In this case, standard keys have
> to be used without using HWKM. Hence, providing a toggle controlled
> by a devicetree entry to use HWKM or not.
> 
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
> ---
>   drivers/soc/qcom/ice.c | 153 +++++++++++++++++++++++++++++++++++++++--
>   include/soc/qcom/ice.h |   1 +
>   2 files changed, 150 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/soc/qcom/ice.c b/drivers/soc/qcom/ice.c
> index 6f941d32fffb..d5e74cf2946b 100644
> --- a/drivers/soc/qcom/ice.c
> +++ b/drivers/soc/qcom/ice.c
> @@ -26,6 +26,40 @@

<snip>

> +
>   static struct qcom_ice *qcom_ice_create(struct device *dev,
>   					void __iomem *base)
>   {
> @@ -239,6 +382,8 @@ static struct qcom_ice *qcom_ice_create(struct device *dev,
>   		engine->core_clk = devm_clk_get_enabled(dev, NULL);
>   	if (IS_ERR(engine->core_clk))
>   		return ERR_CAST(engine->core_clk);
> +	engine->use_hwkm = of_property_read_bool(dev->of_node,
> +						 "qcom,ice-use-hwkm");

Please drop this property and instead add an scm function calling:

__qcom_scm_is_call_available(QCOM_SCM_SVC_ES, QCOM_SCM_ES_DERIVE_SW_SECRET)

like

bool qcom_scm_derive_sw_secret_available(void)
{
	if (!__qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_ES,
					  QCOM_SCM_ES_DERIVE_SW_SECRET))
		return false;

	return true;
}

You may perhaps only call qcom_scm_derive_sw_secret_available() for some
ICE versions.

Neil

>   
>   	if (!qcom_ice_check_supported(engine))
>   		return ERR_PTR(-EOPNOTSUPP);
> diff --git a/include/soc/qcom/ice.h b/include/soc/qcom/ice.h
> index 9dd835dba2a7..1f52e82e3e1c 100644
> --- a/include/soc/qcom/ice.h
> +++ b/include/soc/qcom/ice.h
> @@ -34,5 +34,6 @@ int qcom_ice_program_key(struct qcom_ice *ice,
>   			 const struct blk_crypto_key *bkey,
>   			 u8 data_unit_size, int slot);
>   int qcom_ice_evict_key(struct qcom_ice *ice, int slot);
> +bool qcom_ice_hwkm_supported(struct qcom_ice *ice);
>   struct qcom_ice *of_qcom_ice_get(struct device *dev);
>   #endif /* __QCOM_ICE_H__ */


