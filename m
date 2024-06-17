Return-Path: <linux-scsi+bounces-5869-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C90C890A85B
	for <lists+linux-scsi@lfdr.de>; Mon, 17 Jun 2024 10:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6310A283C82
	for <lists+linux-scsi@lfdr.de>; Mon, 17 Jun 2024 08:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A85190475;
	Mon, 17 Jun 2024 08:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NDWXT+FJ"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DD5190078
	for <linux-scsi@vger.kernel.org>; Mon, 17 Jun 2024 08:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718612900; cv=none; b=WKL4hOuks2NxQzc0m+1IvD/DbXnnaKv+qRUlHJqVA9HJQ9P1dMu0UmZNvFUxtiF1BtomsIacnOnK35ge8pCFYbsRariV7y+7guqoRTbLhaAQK9eijyAt6ep//FLzTcTZCBSx4GtoxRgVAdF47jQbxEuwJj8MnBwplmf6MDNT4yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718612900; c=relaxed/simple;
	bh=K6WKrZipR1HW2Nwy44maXbhlNaIBfu93SoIf07ZvRDg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=etJRxvUW/EUWfrMcJzglRRWgdHBQcY1DNSrv21kDfJX0nPMAuEDOXzBt+lGCPlPwouoApnFcwfXrBv5EIs/XiqAfahd+GFLAxxT4rySp6PR+N8riEwb9KbSTLj6Kg8nBNlzn2ubeYAGcpG0vGmeCaoXGgDqn0wr971h5PCR0PGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NDWXT+FJ; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-35f275c7286so3675961f8f.2
        for <linux-scsi@vger.kernel.org>; Mon, 17 Jun 2024 01:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718612897; x=1719217697; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8FKw8oyL5tYNh6NJFd51xdlwMIJOVuWPAFK/tw0SYrc=;
        b=NDWXT+FJQwlK0l6jwHh4vJYltU6Crj6ju6Csfzz8e+68tMXCJU9nOlpQCQn21gVCqc
         sghbnXo/5Wo0Hp913Ao4ACZW+QTP/xeKw19XRRgxCbSJ1lOVFDxzgmF5EBAQDgstCwhm
         LByM9nZGJq1A59DXMMgGK+4cDMSaBHub2rAZGSsZRhDA+THcmQFBN937/tPekG+dCXUP
         cv1grAXOtvbqAWa/+ja6I677UQx2ht68JCQSuRq5xciqn0pJOnCCsS19/A05e0czjlgn
         wU34v7iiATFBpAQu3quOgL8xjuBKLuvwtRbb9RkZjuAvXcMVjRw2wMrmxgel84EeTIiF
         kPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718612897; x=1719217697;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8FKw8oyL5tYNh6NJFd51xdlwMIJOVuWPAFK/tw0SYrc=;
        b=KxQ7WiNQkfxZXU0IAzUSmKVSJoEwHuL2IgSyNJ+GdlXpnMHuy9A/QBVcRMsgsh3DfH
         Z5fD3mI21WBbZE6TOwd14IA67cq8unenSnBvjLfEdNFxlKXWlpU1LE62oQD1J+MuMVFa
         3LSVpeBaQvP4XkVNk+lIOE8wjZUctfNLZ/rzX0DGKz4sDnSSasNCwstFRGscBplMpOWL
         2+gmFzmTyT9bI/fWNJlI3Mo3lQAJPhtyHreEyy5bzXbdFtDNFbHlmBWp/LTbxoPbWr48
         fBtMPjz5oYvpVHm2jjfPglPRGq6MZyyt0THJpxNF/yd+9eKulQa2KNsao6h0TcptfOIz
         AZPA==
X-Forwarded-Encrypted: i=1; AJvYcCUsJRs33j2v+t0ZS/lqdT30ZGjcjuv5yaPtnBsig6R3EKJIohmHSa+969svJIYJQXii4U4VcEJ1oXlz3JW4TN+BFixRX6yZWIPbxg==
X-Gm-Message-State: AOJu0YyhSBgBg1ucj4NPTryc3Y4G8kCThVjyIW3/IimVpMaZMBlka/+c
	q4wIw1fS1C6NgW6vGMJSa0xey0eboK6PfIkEWJjPk6WzLabktmuulPjPBBUB8Fw=
X-Google-Smtp-Source: AGHT+IFrOz+mjUlG3efTdKq78Aa9DV/xnJ2m4Dx9LiRZX9rZHF10LWcnq84Nv/xPjoEhcoEzE7aaKA==
X-Received: by 2002:a5d:6912:0:b0:360:9398:8b25 with SMTP id ffacd0b85a97d-36093988b9fmr2177110f8f.70.1718612897050;
        Mon, 17 Jun 2024 01:28:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:7f86:d83c:9278:7757? ([2a01:e0a:982:cbb0:7f86:d83c:9278:7757])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750f0d71sm11303233f8f.86.2024.06.17.01.28.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 01:28:16 -0700 (PDT)
Message-ID: <109b1e46-f46f-4636-87d5-66266e04ccff@linaro.org>
Date: Mon, 17 Jun 2024 10:28:15 +0200
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v5 14/15] arm64: dts: qcom: sm8650: add hwkm support to
 ufs ice
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
 <20240617005825.1443206-15-quic_gaurkash@quicinc.com>
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
In-Reply-To: <20240617005825.1443206-15-quic_gaurkash@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 17/06/2024 02:51, Gaurav Kashyap wrote:
> The Inline Crypto Engine (ICE) for UFS/EMMC supports the
> Hardware Key Manager (HWKM) to securely manage storage
> keys. Enable using this hardware on sm8650.
> 
> This requires two changes:
> 1. Register size increase: HWKM is an additional piece of hardware
>     sitting alongside ICE, and extends the old ICE's register space.
> 2. Explicitly tell the ICE driver to use HWKM with ICE so that
>     wrapped keys are used in sm8650.
> 
> Reviewed-by: Om Prakash Singh <quic_omprsing@quicinc.com>
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
> ---
>   arch/arm64/boot/dts/qcom/sm8650.dtsi | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> index bb0b3c48ee4b..a34c4b7ccbac 100644
> --- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> @@ -2593,9 +2593,11 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
>   		ice: crypto@1d88000 {
>   			compatible = "qcom,sm8650-inline-crypto-engine",
>   				     "qcom,inline-crypto-engine";
> -			reg = <0 0x01d88000 0 0x8000>;
> +			reg = <0 0x01d88000 0 0x10000>;
>   
>   			clocks = <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
> +
> +			qcom,ice-use-hwkm;
>   		};
>   
>   		tcsr_mutex: hwlock@1f40000 {

Please split this (and next) in two patches:
- one extending the register size + Fixes tag so it can backported to stable kernels
- one adding qcom,ice-use-hwkm (if bindings maintainers agrees with this property)

And please send sm8550 before sm8650...

Thanks,
Neil

