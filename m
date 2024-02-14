Return-Path: <linux-scsi+bounces-2475-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D43FC8554AC
	for <lists+linux-scsi@lfdr.de>; Wed, 14 Feb 2024 22:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 049231C222D1
	for <lists+linux-scsi@lfdr.de>; Wed, 14 Feb 2024 21:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D4213EFFA;
	Wed, 14 Feb 2024 21:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xQ6hkxi3"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C1212F594
	for <linux-scsi@vger.kernel.org>; Wed, 14 Feb 2024 21:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707945874; cv=none; b=Hi8ZG/YcDX8WnK79eHtEyOEl1mIBQ21LwUR4P+KVYwPumghLh6JFXyvnV6bzpGfu0ItlZ6F9Bz2ZhrVARWhW0bOI+vSYEsdnXP3jkjhYFATARR3AL0S9GoaPOn+SIIt6A+L1G1nAOtgdK5A/0oU2iqxeKgOmPL/LZQIpQcVJ+BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707945874; c=relaxed/simple;
	bh=IGf0qRv4MvRX2Ks9nCU59UJLv4yaBbrr5plZ5rYitn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MGeMYDRwOKJW1fIn+zRAFwbUyB75W6cEGRzxK4XAU+dxafqKNP7Tj8d4woNd0jHKQfK48Q0oVoKrwS43CoGKsBW5NPjmLRZyyyBBIh68hYoe6+B8MKpLp8L37byHY4eRbD/B8sHRrrMKhfx6tcq9OnzOXrRb3T4W2Nv2/ue+2GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xQ6hkxi3; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d0d7985dfdso1972651fa.2
        for <linux-scsi@vger.kernel.org>; Wed, 14 Feb 2024 13:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707945871; x=1708550671; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l0QX2MbWN702W7ms/dTTAq3ESpiDX9cRPpztlNssmgQ=;
        b=xQ6hkxi3Me/wb+sYv4Fz0/pTrNSr7x2yPEYsPsSq8Pb8mWq4OOvzUSvjbcERxaui0E
         NOLII9xZ2cgWKSSOsdC2Bw+6vOceuUJZWsOhIqGZgz6KwNMIbmTI/R2d6znCsnCEZVsx
         jdkEMXe3Q85y4m9HLouAQZaCgIjppyV5kD4rjOSLpoPyiXE/NOCsRGN9W0uEMOn8G2/u
         CyBLQBEr9QlsLz7z+l3lrIlCmHrdc7QnD38XOvlyR9RovNj7QferYr5GEkcTNhCL5u0d
         fbbLKgE3WzejqlNhImB2tEnV+9CyCl0pMDMwcMBn9G7r9dnqGioOlRFYsgqOmuqtNLb5
         e0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707945871; x=1708550671;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l0QX2MbWN702W7ms/dTTAq3ESpiDX9cRPpztlNssmgQ=;
        b=qLfukWIF7EVb7YgpvtDrDY6nAFtWqUozBAGSmcTTsdrzXFKf++Y0t99HOjjXIsKN/7
         Jg71n0ueXk+/9YEkOeRIv0nmaGJ6/eKyV2dfypIhYoZjj3ULzz7B4a5RVxSP2vvj3vqh
         Cws5fVfhe4apyLq9TlKME9DKWe+/B0jSCH+7aYuWiycil7d/S3JCR6A1xCQtRb11zu1M
         KIDGA1XnachajoLu8SwjRaThkOaMZ3rGWnnBwANy7D6NwQIYX2bYxRqXu38hvhTaF1jz
         he7oiQP0HEZq8TP+sYaLJCjVaskt6XXRr7MMG/py9TxE7Npe+gLzqiqtjpWqlW/tngo6
         21uw==
X-Forwarded-Encrypted: i=1; AJvYcCUqlnnQlEPjLhTTMRD4zG4BxfDXDcKKc78YJt7ZuQTE4LmXa0G6A0x0pu6Nlu+qCd9U34FZ3KkfF1QrD2Yq3FcVkp4z7v0V92hfwA==
X-Gm-Message-State: AOJu0YxB1X+/LGmi0L9oEssa1j4IoKbFs+vDyjx4F0m7uO3Y8F6dkWGb
	n3vgqrmtyQTwBPlDFwOp6FGwQLzeh0xaocooyi5Eo+/HSb3hEPmVqmvlmjjN0yE=
X-Google-Smtp-Source: AGHT+IFSkPCLKL4sZs66B2sXrwTEpGpguFRHwoP1IAFO/tMcdCI41Nq68cS5gLRZtiiJNq6sEZizWw==
X-Received: by 2002:a05:651c:60f:b0:2d0:c77a:599c with SMTP id k15-20020a05651c060f00b002d0c77a599cmr2624880lje.4.1707945871124;
        Wed, 14 Feb 2024 13:24:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV9jjkpHnMenB0hCpQURltlOfwNLdMYhRghNpOTXDr6GlZwMVSSMsrdE6QVOT/EStNn05dVF3OsiQqxO7C7R0I0dWVjQaX/U5QWmm3p7oyePwptUfzIQ2BqUsumo8fy7J6kJiN5N6y3DfekycfkDCI8a4Ekg1S6YxEO0Oc25D/6VvuDL4+9rvOxGmVowwpZ4ZPjghabyLfijKiSapMaTYoSuy+Lvzjdv2SM6rL787dxg2G5UcxVOtbs5QwOX9gzhJZq5Gy8xIUbhIiCs4wE7TVAiFPEYj+4NC15msrLPLbZmzjHMm5XMeTbQ99GhhG/4Xn2c6gx/pkDwYJ4t8x11wb3pKU5+AK8uFxxXx07hdkOofagjQCKWIxsD6zhPYb3m4CQwMOfHD7MM7GM2Z8N8dpHaWnlhGOLmgsULB7SAYOc92MDPbJNFlibl0DqWriHhWOjBvfkA1LRyRhxagvJftcGZ1UnGxR51d0SRxiF1Y6Gy5OKlwtR3ORkPlzSlM1kSs0LcxTHBYCojtmZtV508GWPsfe0sUBOWBx22D3JvGVRaOZYFiXzQHVLIxiixyvxrmApXMrPAyHy/Zs=
Received: from [192.168.192.135] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id cs12-20020a0564020c4c00b00561e675a3casm2193381edb.68.2024.02.14.13.24.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 13:24:30 -0800 (PST)
Message-ID: <a0f7de54-7e6b-473e-94ac-bece804bd6e8@linaro.org>
Date: Wed, 14 Feb 2024 22:24:28 +0100
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] arm64: dts: qcom: msm8996: specify UFS core_clk
 frequencies
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Nitin Rawat <quic_nitirawa@quicinc.com>, Can Guo <quic_cang@quicinc.com>,
 Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>,
 Andy Gross <agross@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240213-msm8996-fix-ufs-v2-0-650758c26458@linaro.org>
 <20240213-msm8996-fix-ufs-v2-3-650758c26458@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240213-msm8996-fix-ufs-v2-3-650758c26458@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13.02.2024 12:22, Dmitry Baryshkov wrote:
> Follow the example of other platforms and specify core_clk frequencies
> in the frequency table in addition to the core_clk_src frequencies. The
> driver should be setting the leaf frequency instead of some interim
> clock freq.
> 
> Suggested-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> Fixes: 57fc67ef0d35 ("arm64: dts: qcom: msm8996: Add ufs related nodes")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index 80d83e01bb4d..401c6cce9fec 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -2072,7 +2072,7 @@ ufshc: ufshc@624000 {
>  				<&gcc GCC_UFS_RX_SYMBOL_0_CLK>;
>  			freq-table-hz =
>  				<100000000 200000000>,
> -				<0 0>,
> +				<100000000 200000000>,

That's bus_clk, no?

Konrad


