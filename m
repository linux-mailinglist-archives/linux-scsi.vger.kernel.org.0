Return-Path: <linux-scsi+bounces-12141-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DCDA2F1CC
	for <lists+linux-scsi@lfdr.de>; Mon, 10 Feb 2025 16:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B63011651F0
	for <lists+linux-scsi@lfdr.de>; Mon, 10 Feb 2025 15:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD6323ED6B;
	Mon, 10 Feb 2025 15:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T6RoTPH2"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB48223F263
	for <linux-scsi@vger.kernel.org>; Mon, 10 Feb 2025 15:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739201611; cv=none; b=Vavw6gjVrpCyGmyQ1BwrPu6P2HK15Li15bM2Zta7N03mzWm7iWpHqeKGysqU74Mb+yueTsfgQFyilcvjvFXIJ737h76EwviJgslqFZoAG7NjJf5ETiORgv0z06jbPjElR9T6Xa2OvsM9jKpe9qKupOwNLY9thafjShCryH/F2ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739201611; c=relaxed/simple;
	bh=02Lo1tE6iEG1kGJeBrFmTBWmHN3fFLj5oqGySsCSyIs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=QiVycNrreF4t9+EAbAxLviEikTn1Ifr29zXFmMaIJU0WB5wzuEZRDGVGXvf4USiy4FRgdwYonUlHilnbYYybRdLSDtzd8ZBWQINsKjPQAgwlsRX6vKPQvbQu4p9KS3Ba3He2MdTzmIQzjHVQSvnsPBCIh1RLwts80jWimYiTx20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T6RoTPH2; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43944c51e41so11106965e9.0
        for <linux-scsi@vger.kernel.org>; Mon, 10 Feb 2025 07:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739201608; x=1739806408; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TVrkz1XR/5L7o4lXRR2CcNoJwEZ5Op4zpWZ8bBSgElM=;
        b=T6RoTPH2ubWz+9E0R2HMCkV5lBDY94qIVJtJdoYruy3Yl2Ppk5z1dwMVGm38LLb5Ox
         wUywkZcwQJgUvdwU/RaxqgwuB4JUbVoqAIZfyBWOR316yWDY3pfrnoWkUg/sH+99x+yT
         D38nUSaZY9UTlXnKVeCx4RDdTUyPp+0lhx/ZkTJ5btAYRgf/zaxLTKNAM3i61v5sU/ey
         ViasJZ4J4UsAXEKfCw8mFxkNcoU87szrq/TZHpK6XXR6PkK6gRpAEpI3gNUlm7Q7N1VV
         s/Lf7MTaPsrH3wQML72O/Fl0Qm7ugZEVv8JRY2t0i1lFGaulmmfCBdwbPTbmJE8S88j5
         rwvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739201608; x=1739806408;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TVrkz1XR/5L7o4lXRR2CcNoJwEZ5Op4zpWZ8bBSgElM=;
        b=aHS9v1YJQq7Y+5BzdMGp0UvX6IHWnnjKsS+dm62qmK2hPebJVtMu5YaUrb1sYCoGUH
         3h4zSt8K6rJ1o7CxVRdpxo3umhYXMl49u57koyq8k1rn/pWPKEnM5XX0cUlElLKFw5uo
         fbvk2Vle4MRvm4E2zQFlOoIiEEahwZ7kjZaiLIx0uLyQA2uJ9fWJS6yAXN4VTRrc6e0v
         D0oGcfXeqB6WXI5vFrisrhy0SF8CGx8abmqcFxnfVRqVxeRNZftkkO2AfFyVV6OCLAj/
         K1v+r5dyBHBIVioPYtlu8u5yuscxMco4fbk5iB7IdbNLELz/4P5HqUw/ge1RgqK8IeWc
         TAxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJpwfCG7yHa+Xcd4ZpWcdSOAXfwxpXqQU71mQGEUp+CXXPUFJHulXXuCYYE9Tj8jyzSuIpGASVcxN3@vger.kernel.org
X-Gm-Message-State: AOJu0YyQwaHYEQPGgFe7lfpVJivrl1QXlwiMRakEeyW4jMH+zVrgNcJ0
	CX8uxgG6fgUmpTYoMQzdlhOkfvuY9Sd4bqrBZyKdo4ZLQiHeqU+XyGhLh+370CM=
X-Gm-Gg: ASbGncvxhZnFsvFtSJbmDthhv/mAprzfXnhhuSuY83Oj0pJmx8gmwn1eRDNI1mmWdyz
	ui3KNs6VsqpBxYAvKQWtCnB+Ge+dxyjcDYy7b8xJX3emZYtWFqfj+DEFEfEZqYHSIMVlj+UGj0C
	X3EH+VD5mKhaShWe7THNz8YR8FaFrBaD1ba6tguw4Gx+Tmp/m2Q9KiUWkhzSbtMi9sv0ipkzjlY
	Z1hN87qcVCK51F22jD/Gs2U3TkObjHfM39WwGYVnL4usZsxsZ5YGDhT1j4qOQbfTEYC+5tQ81GT
	hZdrnP8nWV2eUpeouHQi1WODQg7AlslZkLFQuOhLkBUnb//4G6VAUdSoRaaHhEoQCiuR
X-Google-Smtp-Source: AGHT+IHgsDDIzZ/362b0PgA4OgoceC2gDSnSj2avMSkRco2nZxuQFo3QskAu+sfcxQLy2Ge5sZ83CA==
X-Received: by 2002:a05:6000:1fab:b0:38d:df05:4f5 with SMTP id ffacd0b85a97d-38ddf05078fmr3599039f8f.42.1739201607906;
        Mon, 10 Feb 2025 07:33:27 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:8235:1ea0:1a75:c4d5? ([2a01:e0a:982:cbb0:8235:1ea0:1a75:c4d5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390db110dfsm188164975e9.36.2025.02.10.07.33.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 07:33:27 -0800 (PST)
Message-ID: <2d1ab1fe-6d98-4b54-910c-f371f708039d@linaro.org>
Date: Mon, 10 Feb 2025 16:33:18 +0100
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 0/5] Add UFS support for SM8750
To: Nitin Rawat <quic_nitirawa@quicinc.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Melody Olvera <quic_molvera@quicinc.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>,
 Bjorn Andersson <andersson@kernel.org>, Andy Gross <agross@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
 Trilok Soni <quic_tsoni@quicinc.com>, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
 Manish Pandey <quic_mapa@quicinc.com>
References: <20250113-sm8750_ufs_master-v1-0-b3774120eb8c@quicinc.com>
 <c6352263-8329-4409-b769-a22f98978ac8@oss.qualcomm.com>
 <20250209152140.cyry6g7ltccxcmyj@thinkpad>
 <ae9ba351-53c8-4389-b13b-7b23926a8390@linaro.org>
 <92e77d82-7c76-4cc4-8e7d-7b72b57ab416@quicinc.com>
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
In-Reply-To: <92e77d82-7c76-4cc4-8e7d-7b72b57ab416@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 10/02/2025 12:15, Nitin Rawat wrote:
> 
> 
> On 2/10/2025 3:09 PM, neil.armstrong@linaro.org wrote:
>> On 09/02/2025 16:21, Manivannan Sadhasivam wrote:
>>> On Fri, Feb 07, 2025 at 11:47:12PM +0100, Konrad Dybcio wrote:
>>>> On 13.01.2025 10:46 PM, Melody Olvera wrote:
>>>>> Add UFS support for SM8750 SoCs.
>>>>>
>>>>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>>>>> ---
>>>>> Nitin Rawat (5):
>>>>>        dt-bindings: phy: qcom,sc8280xp-qmp-ufs-phy: Document the SM8750 QMP UFS PHY
>>>>>        phy: qcom-qmp-ufs: Add PHY Configuration support for SM8750
>>>>>        dt-bindings: ufs: qcom: Document the SM8750 UFS Controller
>>>>>        arm64: dts: qcom: sm8750: Add UFS nodes for SM8750 SoC
>>>>>        arm64: dts: qcom: sm8750: Add UFS nodes for SM8750 QRD and MTP boards
>>>>
>>>> You still need the same workaround 8550/8650 have in the UFS driver
>>>> (UFSHCD_QUIRK_BROKEN_LSDBS_CAP) for it to work reliably, or at least
>>>> that was the case for me on a 8750 QRD.
>>>>
>>>> Please check whether we can make that quirk apply based on ctrl
>>>> version or so, so that we don't have to keep growing the compatible
>>>> list in the driver.
>>>>
>>>
>>> That would be a bizarre. When I added the quirk, I was told that it would affect
>>> only SM8550 and SM8650 (this one I learned later). I'm not against applying the
>>> quirk based on UFSHC version if the bug is carried forward, but that would be an
>>> indication of bad design.
>>
>> Isn't 8750 capable of using MCQ now ? because this is the whole issue behind
>> this UFSHCD_QUIRK_BROKEN_LSDBS_CAP, it's supposed to use MCQ by default... but
>> we don't.
>>
>> Is there any news about that ? It's a clear regression against downstream, not
>> having MCQ makes the UFS driver struggle to reach high bandwidth when the system
>> is busy because we can't spread the load over all CPUs and we have only single
>> queue to submit requests.
> 
> Hi Neil,
> 
> There is no relation b/w LSDBS_CAP Register and MCQ support.
> That registers just indicate when MCQ support is present on any SOC,
> whether Single queue mode is supported or not on that SOC.
> 
> In SM8650 and SM86550, just the pored value of that register was incorrect which was fixed by WA but actually functionality was present and working fine.
> 
> Pored value of that register has been fixed from SM8750 onwards.

Thanks for the explanation, but this doesn't answer about the state of MCQ
for SM8550, SM8650 and SM8750. I would've expected to have MCQ for SM8750
in the first patchset.

Neil

> 
> Regards,
> Nitin
> 
>>
>> Neil
>>
>>>
>>> - Mani
>>>
>>
> 


