Return-Path: <linux-scsi+bounces-2483-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C7D855EC9
	for <lists+linux-scsi@lfdr.de>; Thu, 15 Feb 2024 11:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3B282825A2
	for <lists+linux-scsi@lfdr.de>; Thu, 15 Feb 2024 10:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BBB66B4C;
	Thu, 15 Feb 2024 10:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XNt5uJA1"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDD166B2D
	for <linux-scsi@vger.kernel.org>; Thu, 15 Feb 2024 10:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707991770; cv=none; b=HJJ/MgFsFYb4cHHBCeNWyXou9GYBGr96HXqQliptmctMEkQ8J2+zOQytEQIwOUa3hDEu7jqDTMUXO924dv5gMQSTa/OZce+h3OEXCSZil8Av9OznAu8WwYNbvVDfSxxyO20vMXv8HkLt8oDJgHhO+leri9gfJy8Un8i5bzGmGWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707991770; c=relaxed/simple;
	bh=GZhvV2IpKlien4dqy5FmXi5nqRksnZljQwP9OjYw8kg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bI3gVgPvN37UaU6+i8zI71C/VUS04qgOSac+lGlpcEw/adHi3XvALuS9h3dUkyLKZph63rzV/weknK3Q1/soLSs0TZnBq/VEuX6QZRN1K3QfeMWQTgcI4FcuDY6LWl7acYmip13JpnRlHcAfwalpnW6ihQJQy2vIvH7iXd3EHKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XNt5uJA1; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5600c43caddso769883a12.2
        for <linux-scsi@vger.kernel.org>; Thu, 15 Feb 2024 02:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707991766; x=1708596566; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/w2dU5xsxOaEwTYqmvny0SXCHgVwlKr9Gar5lBMNJow=;
        b=XNt5uJA12SAuzAQcwayrrwrvbSeeHTGkTLOt1tLFHPe2DP1Jpx6sPPZrAJcABVgqF9
         3HKh10LR45haf/eauaXgGsHQapMVtW/dI5OOSwZ7PllfWWj0JgoCF0ZO4/LhUlSa0+gI
         YxSryt/ZHEyp5uqXsPDyIUy8ju32ARvzXpMU52nYOyXM1eASQY2oQXd111oJaFiR4nws
         et4D7Yc90PDDz4gtukWSL6zYWT+QM4eiZv60ohUkX1iYNZZnvrn3E2Yobr8BnVVjRruA
         gJS6CvgbXwD0KhGX+BMEyqQD4RIMYGo1lLRV3YS3daUQtjmsE8W3EcNqfqZSQoqHo40E
         prig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707991766; x=1708596566;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/w2dU5xsxOaEwTYqmvny0SXCHgVwlKr9Gar5lBMNJow=;
        b=np0BsRiPTrkaZI2fnv5MFKDwBx/aTWJvJUJfbyNqliZ/JeIb79GGlCpXM2GJz3Cyl+
         TfB1Fe7kjSyQfGiYY0UG6rpqImyHUcFPkrqk9w3B3xrlBQyDWseyzxg7DM+tF/llsxdw
         SkR+fcEqaQm3nHvHOziDWvocaSqMFXsN2iT0Sc0o2/NUUhtilY8JH0bvFOoARFueX/eg
         ZjOmuufACglNMn/Pbr2k6I3ZM5r7RjFOKIjeR1rFGfDdPYzngMHnuHRjVc9df6pVPKWP
         xNmsh5mOAiBe8n/w02/7kGLL94kyewWTor38TQ90mvjw6Ij18BgaMCQ8gwkT6Gho5Eq1
         O5Aw==
X-Forwarded-Encrypted: i=1; AJvYcCXbp6nK6p+TOiCkcVPePZXsS+NJ0d7kU9tj1VmQucFHhIpnixG2o/NNGdlBOkw8KnTekg5rNiITxy7iLFt3gwd75PgD2u4EhLhFgA==
X-Gm-Message-State: AOJu0Yw/LUCqdrFJ+8YrXlVt6ssmbnKi1ygTtaQ44waJ3tk/qmjoQsrz
	e8bvRG8W8f+Z3K8MKUDCD0X8Yuj+RtiiXhIBgNGhwO/7UbJXQhTyRw66oU/9sIY=
X-Google-Smtp-Source: AGHT+IEZPX7sUZCO9kZN3Q78xjE4IrrND9Rz9tV98R5vUDqSN88mcXo2c3MuFRAxWzzY5lIlAXEYGQ==
X-Received: by 2002:a17:906:6617:b0:a38:99ae:da8b with SMTP id b23-20020a170906661700b00a3899aeda8bmr886690ejp.56.1707991765803;
        Thu, 15 Feb 2024 02:09:25 -0800 (PST)
Received: from [192.168.192.135] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id h22-20020a17090634d600b00a3ca744438csm380427ejb.213.2024.02.15.02.09.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 02:09:21 -0800 (PST)
Message-ID: <c4e6bdc1-2b3e-43b9-b20d-c2207765cd2a@linaro.org>
Date: Thu, 15 Feb 2024 11:09:20 +0100
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
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Nitin Rawat <quic_nitirawa@quicinc.com>, Can Guo <quic_cang@quicinc.com>,
 Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>,
 Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-scsi@vger.kernel.org, devicetree@vger.kernel.org
References: <20240213-msm8996-fix-ufs-v2-0-650758c26458@linaro.org>
 <20240213-msm8996-fix-ufs-v2-3-650758c26458@linaro.org>
 <a0f7de54-7e6b-473e-94ac-bece804bd6e8@linaro.org>
 <CAA8EJpqPpn43bNca9Ld_XtoBYJTTMXcMhHywU8E9CgkeQEbwow@mail.gmail.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <CAA8EJpqPpn43bNca9Ld_XtoBYJTTMXcMhHywU8E9CgkeQEbwow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15.02.2024 09:19, Dmitry Baryshkov wrote:
> On Wed, 14 Feb 2024 at 23:24, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>> On 13.02.2024 12:22, Dmitry Baryshkov wrote:
>>> Follow the example of other platforms and specify core_clk frequencies
>>> in the frequency table in addition to the core_clk_src frequencies. The
>>> driver should be setting the leaf frequency instead of some interim
>>> clock freq.
>>>
>>> Suggested-by: Nitin Rawat <quic_nitirawa@quicinc.com>
>>> Fixes: 57fc67ef0d35 ("arm64: dts: qcom: msm8996: Add ufs related nodes")
>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>> ---
>>>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
>>> index 80d83e01bb4d..401c6cce9fec 100644
>>> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
>>> @@ -2072,7 +2072,7 @@ ufshc: ufshc@624000 {
>>>                               <&gcc GCC_UFS_RX_SYMBOL_0_CLK>;
>>>                       freq-table-hz =
>>>                               <100000000 200000000>,
>>> -                             <0 0>,
>>> +                             <100000000 200000000>,
>>
>> That's bus_clk, no?
> 
> No, it's a core_clk. The "core_clk_src" is removed in one of the next patches.

Just confirmed what you're saying is true, reading the raw diff was apparently
not convincing enough for my brain..

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

