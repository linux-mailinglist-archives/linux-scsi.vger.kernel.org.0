Return-Path: <linux-scsi+bounces-2330-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F36EB84FFD8
	for <lists+linux-scsi@lfdr.de>; Fri,  9 Feb 2024 23:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C1651F22768
	for <lists+linux-scsi@lfdr.de>; Fri,  9 Feb 2024 22:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01EA24A18;
	Fri,  9 Feb 2024 22:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VeuEIQhh"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC9721350
	for <linux-scsi@vger.kernel.org>; Fri,  9 Feb 2024 22:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707517570; cv=none; b=OGjE7Oy8CfisBEJMzSPAjMgKjIdmlYxEZ9F5nOJ8gG7KQelnJgbvCRDctfHL+FiZTKxxH7m9K7L89uaxU1L6Ovwb+prNgVawu35nL22S+/H5zxizn0rv9AScviSCrUQbF0fCLWEV0ay/MlMvyGbvvGA/0n7JofZ/5Ha21cuJsqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707517570; c=relaxed/simple;
	bh=hrlixnvfaMKcR+Mz2pLMiXCcHS4q6KYRBYEA3ptrVPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=omb7X0x12G9+T1ILP05aBsDrxCL8luBQHZilI61Tuz/kVW56hzbExSL+n8PrnmCeiPXN1JuVDySP6XZmUprX0uyph9LCBeaJQxxvVEMMuGPCo8fBMuYTbyIpPF1NIkkxQefyyuCXEN/u3UxAP2aJH7wSVbJKySwfLfkOibJ51aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VeuEIQhh; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5114fa38434so1634341e87.0
        for <linux-scsi@vger.kernel.org>; Fri, 09 Feb 2024 14:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707517567; x=1708122367; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yphHxXwb0WbMrWU82ru1cxhNr1b3+e/qN26jPPunEow=;
        b=VeuEIQhhhQp1nBVfGs5TEIzl0D6wWxJF5voMbei6OQLW0RZFC27tH29+Z3g0c9+vR5
         nu2MRtaYXD7RcdW71exa/UpdmZiVvrFu9Tmu43O/Y27BR7U/oIiqL/KA6TFXZmQW3MBB
         U/mj/KB8CELriJomKEuJZ1w9ZlLfWpz8HKnYuyCh/bgTqAY5fXC6RJZmTiGg9xQZLhvK
         EgsZay9UyMKq/apvRpK2d/8bNEepeKxuH6nM+VjzHs7H12MZNlrpfaQw5DNAGLdlNoUp
         J/V9W4JudaOCSWfGNsTQ94CGtOGycwR/xOkRhSh6+bxvnrfwOUz3mf4MZT3cHH+IltfW
         oe6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707517567; x=1708122367;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yphHxXwb0WbMrWU82ru1cxhNr1b3+e/qN26jPPunEow=;
        b=gxOwmB6lB9PE0a5rh9VecSZcKpUlo9T8c8TE5KfQrpfLMhubBdLmugFJvDpDbNUhqA
         sCPMejjSP9JHFJIOgcZ4s6Fv/q47tvoVIsDCagsdQxYVuI4aQMwWrGpywr8kPok7p75W
         sZ/mjlMAcH/MORS9Rxy9HP4CItEoGXjxmnzFSbmdN6FJloGyohDUuvCrKdZihI5PNkwx
         8Q/190UIzAruYoS4xmwlNJqaUiJAOEN/FZSaMtH02W1wxvESKYbJPfKBlS/yT6SiGzPv
         kgE19c6xe233HNpzKHKuZ6mlLWOT0lyFmwty2LAnvsVlduKxATuLIheikijN+te+56yN
         lJ+w==
X-Gm-Message-State: AOJu0Yxp8q07OHHicDW0WIDIeUhF3Cj82GMb3GaI8Vw658dXuDSK4xa8
	crwTbLFcLhGZUeunVZwOWSY8PDcrzCV07eR/QHDYvilQvEapA6x8RrS6TfsLBJQ=
X-Google-Smtp-Source: AGHT+IFU5eAqt0XT0MXQ016FSr6wKNINoKdQ+iMslKY4+vdsWpXkEZpHelFbpxspwtMeN9/ZCsvm1Q==
X-Received: by 2002:ac2:5465:0:b0:511:5f08:f147 with SMTP id e5-20020ac25465000000b005115f08f147mr236251lfn.25.1707517566884;
        Fri, 09 Feb 2024 14:26:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVY5NCtz7AXZMav2qJqqGxlPLXdA/uqK6c597CF51AQLfvl981I+6K2TTblLnh9pwIKtgNO4DLoARMSW/qEhiKtlRx/fI0g2qbnLsJWB31CYMfGZyhfrQUstb5N699OZ/ARY28YlIRReGkNcVGQubSHlXrstyoA/zTffsPpdVaoO1Q218ZnSEUoK/fW9Zd8zUPKmboC/6c/IGZ8ml+ntVnzaz3dLn7e7kfLn759NZzsjfHmoQsMLTOaawI+d7rehiHYg8++CeV8MTbn4zYT6+3ICOrXby9A8UNHDLWhF8qoKjTqIw8b+xcRi/HdGpvyzeo/5QTGDhz8TMIn7Ea5RLFgSkCgcI/dnvX2jDsXKpXN+wdsHcsdO3dUZhlTJd2y5+8LeN7RYqZyzzLIZO56sdc2blFotd2gT3TSG/d1UWKt+5fxyAotPsNzaGMjihPhyLViXVx+b2yrOLpxxJ7gbJNTlRelttTP2gA27ZD5Ciiupcm9lD9AEWKg2Co0rTOGg5inF/YgvVUDDndkxk9YAavDyn7HHMNvMiRnig56o6o/wg9q8bGp029uoMsmev/VfwO3kvPysJI1yHjANsUgz4tT/ltUyEqsHUZuiQriKOENtg==
Received: from [192.168.192.207] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id hw13-20020a170907a0cd00b00a3820ec721csm1167406ejc.8.2024.02.09.14.26.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 14:26:06 -0800 (PST)
Message-ID: <ea493d76-900a-492a-87f6-365453e8bea0@linaro.org>
Date: Fri, 9 Feb 2024 23:26:03 +0100
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] scsi: ufs: qcom: provide default cycles_in_1us value
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
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <andy.gross@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>,
 Bart Van Assche <bvanassche@acm.org>, Andy Gross <agross@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240209-msm8996-fix-ufs-v1-0-107b52e57420@linaro.org>
 <20240209-msm8996-fix-ufs-v1-2-107b52e57420@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240209-msm8996-fix-ufs-v1-2-107b52e57420@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9.02.2024 22:50, Dmitry Baryshkov wrote:
> The MSM8996 DT doesn't provide frequency limits for the core_clk_unipro
> clock, which results in miscalculation of the cycles_in_1us value.
> Provide the backwards-compatible default to support existing MSM8996
> DT files.
> 
> Fixes: b4e13e1ae95e ("scsi: ufs: qcom: Add multiple frequency support for MAX_CORE_CLK_1US_CYCLES")
> Cc: Nitin Rawat <quic_nitirawa@quicinc.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

