Return-Path: <linux-scsi+bounces-10963-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BF79F7E06
	for <lists+linux-scsi@lfdr.de>; Thu, 19 Dec 2024 16:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 425D87A062A
	for <lists+linux-scsi@lfdr.de>; Thu, 19 Dec 2024 15:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA27226551;
	Thu, 19 Dec 2024 15:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LgvlmS/X"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB93622653D
	for <linux-scsi@vger.kernel.org>; Thu, 19 Dec 2024 15:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734621991; cv=none; b=VBH1p3yKW4OFpJnhGp8A68w+zwOaksdK6ihYwsWWLSHbSPhbTsY+RJcwlY7hTW40Z8xCWcc1zqo3HY/r5E74J3Z8JN4lu2WiAbkfLtS2L+MBftZMKx2HY72ZNYU4NmgEzK+l0udhdYOK77uqFX2ArMeFULAT02npl6nDUhyGelc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734621991; c=relaxed/simple;
	bh=15RrTWKQpHCq/hvcLugkHfHdil5oe73YrQ2pQ1CJlL0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=T6470N2j5YS6dmwg3dBvAWsUT7SgyY515DrJ7dvT9k03DLAzRq0xeHyt3/RJs2IZURwzPw5DdabSknd7t+0SC9JvNOIT5TUq6cCEthEKXT4Ns10twM8j5Zl+6fI84fikD6FHMrRM02LGFWdyPp6lcGDaf/JjUe1SvpXDwk01p0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LgvlmS/X; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-436345cc17bso7151995e9.0
        for <linux-scsi@vger.kernel.org>; Thu, 19 Dec 2024 07:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734621987; x=1735226787; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VQ7HZmEeCGMgy0e+vPaSllNgD7jxFlhgiuqO+Gf6oic=;
        b=LgvlmS/Xe1DbBaOh2EqvwcEOO6YusRBXskAlnyEyADAINemZ4uoxyNdQRgHQtKqsNT
         MV6oZniWv4Kq9XUVQ8YwoGWrtsswxPn6+MOTDj44owNPi9LB/B/tVBjxmKDvyLmAWXtb
         obtY7syLHbEiJoZOjODqNq/ULJ4Jpb69CcQaTCCHGCVFusiAU5aeJnvaijslrJk3+9k0
         PltVSi3U3mAUkoOgfT6OaDlzviRbcpLf782u36qxGjdr6UDU4IeECcmkRh03Yx1lwVqn
         JG9ZSu2hT2yOM8Gnft0y4aC/3fLu7iejd+ymrtxNefdVegnZ1gBzRZTXv0zlACkpBI8A
         +Ebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734621987; x=1735226787;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VQ7HZmEeCGMgy0e+vPaSllNgD7jxFlhgiuqO+Gf6oic=;
        b=QdJI8mSYsAePmKsNkD5gOvGE+o8YpEHuATBH6JtS0fip6QUtPaN99j4wlIuFguSUT9
         OWJZCPm61aBauKf2k4DZYCSJh9IG2qtjpFxgFRcQAw9swigAWaB1gG+gXolOvaAOu+0C
         12AuW4Y2t8m8WoNKaSozvUkgSl/6BUvuB59wnIqbDcxbVgnIj76Yso7ELwbwgABUttVH
         hOazapEQ1NMmdVz1hIX/V6KEaVtTFpY39BnOWr2bHvaj4BxD+Olcd+L+v6tuCDLaOE9a
         MFfsCV9ebVuWD5u5ulIzgAULFT3cu/04WccAOKyIjcO5kMZYfEEqcgtknNY4i8JTfeE0
         vnsw==
X-Gm-Message-State: AOJu0YzBBPdHh91ivMWkCFvR8eLh+jKbptu75vFoBCWmITewX1Z9LrLS
	IZetC2DAWhLnGzJWj3K6iMCeq99ruIiJHvKvQQPza/0yFElibl0qgoTsQs2HKdw=
X-Gm-Gg: ASbGnctzJZFLzKS+VE54VutGX6AhZE0Wj1VjqgUy3avdDHfVd1OKcKZ94Zh2eU2cpqV
	Psj+bd80udUXqf/zXG/MIKc/rNOase+vkOezbP5QV7Q7OF+JQEZiiAH5QmCoXhgblbu2WzXNaDJ
	MgF7rM14jxcV6BQHKPdxbPWSKZVsp+f4+u1rankSq4w57U5WBuhU/CtEejmL+mRX/rmatl6Uj+c
	SgMXxYs3ZW4PgUdoPAPrjqxY4aDfACmw7TFfBgcymHbW0ZrgRFs8razDRhDDwV5h9X539RWQn6i
	41Pw5n4XsUor0s3W9QkIm1GczgAJeo7U2w==
X-Google-Smtp-Source: AGHT+IEy1xHzK9K7OC7FPc2fyDm4x3L6AUfcIgdgbQdf1FCaNr7K1xPzw5OtAxsv5OKQ4c4RA4lwuA==
X-Received: by 2002:a05:600c:4fd3:b0:434:a929:42bb with SMTP id 5b1f17b1804b1-4365536f6camr66630715e9.18.1734621985918;
        Thu, 19 Dec 2024 07:26:25 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:a0fd:4342:76af:7533? ([2a01:e0a:982:cbb0:a0fd:4342:76af:7533])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c829235sm1779437f8f.15.2024.12.19.07.26.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 07:26:25 -0800 (PST)
Message-ID: <145dd6ae-be08-4f19-9e9d-abc238b35b8c@linaro.org>
Date: Thu, 19 Dec 2024 16:26:24 +0100
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 0/3] scsi: ufs: qcom: Suspend fixes
To: manivannan.sadhasivam@linaro.org, Alim Akhtar <alim.akhtar@samsung.com>,
 Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Abel Vesa <abel.vesa@linaro.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, Amit Pundir <amit.pundir@linaro.org>,
 Nitin Rawat <quic_nitirawa@quicinc.com>, stable@vger.kernel.org,
 Ram Kumar Dwivedi <quic_rdwivedi@quicinc.com>
References: <20241213-ufs-qcom-suspend-fix-v2-0-1de6cd2d6146@linaro.org>
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
In-Reply-To: <20241213-ufs-qcom-suspend-fix-v2-0-1de6cd2d6146@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/12/2024 14:53, Manivannan Sadhasivam via B4 Relay wrote:
> Hi,
> 
> This series fixes the several suspend issues on Qcom platforms. Patch 1 fixes
> the resume failure with spm_lvl=5 suspend on most of the Qcom platforms. For
> this patch, I couldn't figure out the exact commit that caused the issue. So I
> used the commit that introduced reinit support as a placeholder.
> 
> Patch 3 fixes the suspend issue on SM8550 and SM8650 platforms where UFS
> PHY retention is not supported. Hence the default spm_lvl=3 suspend fails. So
> this patch configures spm_lvl=5 as the default suspend level to force UFSHC/
> device powerdown during suspend. This supersedes the previous series [1] that
> tried to fix the issue in clock drivers.
> 
> This series is tested on Qcom SM8550 MTP and Qcom RB5 boards.
> 
> [1] https://lore.kernel.org/linux-arm-msm/20241107-ufs-clk-fix-v1-0-6032ff22a052@linaro.org
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
> Changes in v2:
> - Changed 'ufs_qcom_drvdata::quirks' type to 'enum ufshcd_quirks'
> - Collected tags
> - Link to v1: https://lore.kernel.org/r/20241211-ufs-qcom-suspend-fix-v1-0-83ebbde76b1c@linaro.org
> 
> ---
> Manivannan Sadhasivam (3):
>        scsi: ufs: qcom: Power off the PHY if it was already powered on in ufs_qcom_power_up_sequence()
>        scsi: ufs: qcom: Allow passing platform specific OF data
>        scsi: ufs: qcom: Power down the controller/device during system suspend for SM8550/SM8650 SoCs
> 
>   drivers/ufs/core/ufshcd-priv.h |  6 ------
>   drivers/ufs/core/ufshcd.c      |  1 -
>   drivers/ufs/host/ufs-qcom.c    | 31 +++++++++++++++++++------------
>   drivers/ufs/host/ufs-qcom.h    |  5 +++++
>   include/ufs/ufshcd.h           |  2 --
>   5 files changed, 24 insertions(+), 21 deletions(-)
> ---
> base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
> change-id: 20241211-ufs-qcom-suspend-fix-5618e9c56d93
> 
> Best regards,

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD

