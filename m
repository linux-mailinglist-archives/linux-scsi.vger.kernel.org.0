Return-Path: <linux-scsi+bounces-2482-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEFD855EC6
	for <lists+linux-scsi@lfdr.de>; Thu, 15 Feb 2024 11:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA2921F24087
	for <lists+linux-scsi@lfdr.de>; Thu, 15 Feb 2024 10:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277FD66B2D;
	Thu, 15 Feb 2024 10:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pB1Qx2Mh"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BFE66B4C
	for <linux-scsi@vger.kernel.org>; Thu, 15 Feb 2024 10:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707991709; cv=none; b=MKWE3ZUOZq9VizWng/ihTLDc6HaXQJWwCLOVSCMJE8OjWCcRp+wrxJKUDdliVy3tAITk21/V9C9TxjU+11DZYXt9lotxFBvj01rXNbw7dzKtNKzRbxFIq0ONo1Ws7aF5Bw4dPSGpTfUZHzo2bBVTdoVgoW7U0qeUgTrXSRwK+CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707991709; c=relaxed/simple;
	bh=1XW6dJGVap1RTXpvTalbBTgq8po7T8yAj0Db/h1SwOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L2uPuDVU75mXozrnGdymfGtJP/9rB0N2UAjZbiys3r6B94CjDTFPtssaYJEfeR4xWFbbcI/BI8mpfx9KIUiSQtOwu52yneY+QxGT2VdMZdeShuLMMxqrx82iJoZLL1piehbJEF284V+2h6bvaVUt6eBTqYzWmjI4ynEfJGHV14U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pB1Qx2Mh; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3d6d160529so81889266b.0
        for <linux-scsi@vger.kernel.org>; Thu, 15 Feb 2024 02:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707991704; x=1708596504; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1yjCWaZLj3Bg+5utErLSqApvP2nKRZIX0oRCEMSazYI=;
        b=pB1Qx2Mhb2VsFOj3VYRZjKDoSg5DrONZr6qTaOArknRlEDYf7h+LppnT/XAdE+A0kL
         XN5wLOzN9nZB1oPzxr3pT/LeqJ8eGCfVy4LITYhg6uEs3VK8WgvBJ3sLCI7yDe0G9jeV
         d7FwQEaDgupPfabVZW89S3VpEF6sKXTbqO8qsJ478vqUL64EKkz0KXSSuB1dbGD63Wzq
         JzYpfzP4FBQR8vsEpLzdofqLY6vn7ft5Tvcoksb/fu4Gsm68ffyAV7b4XsJQMXn8TRQE
         3xc6yt508pfwsCXiWpRmESvqZe/Ng++gyMjgFk8mHhxKlFhcW078Tgk6/G7Gh9Z7whSR
         Exww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707991704; x=1708596504;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1yjCWaZLj3Bg+5utErLSqApvP2nKRZIX0oRCEMSazYI=;
        b=dPXTkLO1wyP3uGoMG6YTh7A86dyqxqCBjWon6QDqIDF5oIfhcBD+ybQq6HQDm683cj
         iT6FEFlYPXgVpBzmtx29LH3nGCEmHbntQJDjqAs6UdvAWe1aIqdmSqFYNc4QiLzOioPs
         g4Bys4T0Xq8uvG/bG3tlfbX4Pn5sE0Ti5Nb9eGvZ4j6eTLubvFQ4F2koYHt1L6N/3uBH
         XDuuIRxO4u8/U2y8scfmf+RRep8wik7lF0YPaAEENVYzW70uSFxFPXZRh8GTilwjwITz
         /S95iEaoeipczAxha8p4PFp9NkTEAgIe0tSf7oQztKbDp/Sp4j+K/xdPIUcnhcGbHLkz
         u9+w==
X-Forwarded-Encrypted: i=1; AJvYcCUbMgDmxxXpUDuehylip2Qe43yQyJb/eJfu5F9AiwfFpgRuT6SlJONzBK/7jCTEDUeq3+R5tW08HTQ532EDIL/QmpOsWWB7cTPF9g==
X-Gm-Message-State: AOJu0Yz4x5RJvZ/IoaNyS9BrE90iE1m9+AcS2THsDEXUGBw2YKSBJyVk
	w/r9vEG759mTE5uPhEmXDuj329EqAHq2O7EfNrLDZ2zIyGn/YxssJ8Moi0FW7Dw=
X-Google-Smtp-Source: AGHT+IFE/GHHRU0Axhmv7YFm0niGgsMkvygmGJ0wxS9m8WWz4yCSUAf84JDW4bgIMRVUJt/YvcNLKA==
X-Received: by 2002:a17:906:71cc:b0:a3c:8f4c:b1d with SMTP id i12-20020a17090671cc00b00a3c8f4c0b1dmr923386ejk.63.1707991704450;
        Thu, 15 Feb 2024 02:08:24 -0800 (PST)
Received: from [192.168.192.135] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id h22-20020a17090634d600b00a3ca744438csm380427ejb.213.2024.02.15.02.08.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 02:08:23 -0800 (PST)
Message-ID: <43d248ea-fbfc-498b-b279-13074f010310@linaro.org>
Date: Thu, 15 Feb 2024 11:08:20 +0100
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] arm64: dts: qcom: msm8996: unbreak UFS HCD support
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
 <20240213-msm8996-fix-ufs-v2-2-650758c26458@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240213-msm8996-fix-ufs-v2-2-650758c26458@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13.02.2024 12:22, Dmitry Baryshkov wrote:
> Since the commit b4e13e1ae95e ("scsi: ufs: qcom: Add multiple frequency
> support for MAX_CORE_CLK_1US_CYCLES") the Qualcomm UFS driver uses
> core_clk_unipro values from frequency table to calculate cycles_in_1us.
> The DT file for MSM8996  passed 0 HZ frequencies there, resulting in
> broken UFS support on that platform. Fix the corresponding clock values
> in the frequency table.
> 
> Suggested-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> Fixes: 57fc67ef0d35 ("arm64: dts: qcom: msm8996: Add ufs related nodes")
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Okay, so this one apparently doesn't apply, seems like commit
68c4c20848d71b0e69c3403becb5dd23e89e5896 ("arm64: dts: qcom: msm8996:
Define UFS UniPro clock limits") did the exact same

Konrad

