Return-Path: <linux-scsi+bounces-2332-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A394584FFE9
	for <lists+linux-scsi@lfdr.de>; Fri,  9 Feb 2024 23:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DA7F1C229A4
	for <lists+linux-scsi@lfdr.de>; Fri,  9 Feb 2024 22:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B44E376FA;
	Fri,  9 Feb 2024 22:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h6/Ktfpe"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7EF36135
	for <linux-scsi@vger.kernel.org>; Fri,  9 Feb 2024 22:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707517745; cv=none; b=ZZYKaVa4ZIyqqhG/xcmAvHE6g3hBZW/OIDeRILWDg3vbTzn6QQFfO01yRnEa4IbJIAad5bsmwr6KcdZVmPPRfqGBooPhU3ISTWT0qLg3+L5YTXSesio021r4cwUKvV0mKDagCIUOMu+2nrwsXmvJXrEDHIIhvCxFh2fLK588iEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707517745; c=relaxed/simple;
	bh=5sVCaymYZCKpB8qlkdXh9YlHdVyEjWqznVQXWxc+eJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZpDmrFNNOS+avgQ1JX3rUbAnhuQfog8PUBnponvrVWZ41+DX5nhXtF9ZUgnjjNYvWfgcXHL1REOLNgR8z5/g1V4lFOb2lpEo1U9SeIxzPzfsxrUDOQXb7GL8IrdvZ7BHpnCO+k3bF73dyKBQMVPIlELpU+1hLMngRRzR4ivGAPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h6/Ktfpe; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5116643c64eso2455645e87.3
        for <linux-scsi@vger.kernel.org>; Fri, 09 Feb 2024 14:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707517741; x=1708122541; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fwoUZLlnFiDWvUskipp2BWlsoH+wO63gzAPp48xSTGY=;
        b=h6/Ktfpe2sh90u5ZUwT5mq7u4l9/vJxUiXvxh/3pitJIk28HGCBYCgdOIXd5VzzYvw
         1nwOq5NgDcZDSznSz0PzjlAUdwzodXsoFSbckqKfbOUHGx5CxGxKK1CRL/ysBgVmTvBf
         IQMEx/MBmuyRLY1MD2poJ4HToCTUNqpJLnS8bIve6XNSwsUTwHlB7jyCYbxl88Bat47Q
         YznC9W8QJ4p+oVUXsS08pAOYzTSZa0u1c0RoQpAbaUuMddbL61Kkr94LSvNhtMwGGDuY
         Fc7YlAZ0qsg3N8WYrS2qK5L24V+eqWljiZu/v2gxYWI7krwCoxmL8PCi2ENFRqTezete
         j1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707517741; x=1708122541;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fwoUZLlnFiDWvUskipp2BWlsoH+wO63gzAPp48xSTGY=;
        b=OBEzRCnpHbnr33OZe1UGIFpRBX5Fl4X/lqo98Tod0KqisJC9a4eUquQp1+eOzjxwjS
         FMcItuVlmrigQ2pstsl/FNQIR1RyltI6N6lyaFbbQUhY+asx7szePxh+Ii0IRUWux0al
         w1o/mrtRZrIKap39psrUgGjSYyKb+N1TjDyxvQce3BviQVdL6nkjn/RIgiuRTORl8tFR
         2/ehsPrge0MZro3aWYlGIkpgc1wbmRbDXDlKa3juljmGaDUlwjLlEOH0C0deJovTTHCF
         t4McBU3C77rG618S5kevUfh8BrHur2nglFwk03qE4fGEgBuyDGZcx6O+8pHsXShOsl6X
         Nypg==
X-Forwarded-Encrypted: i=1; AJvYcCWAWjDOPyEdaIphXilrx7oVsO6paEGi+2Tiz3XZQPBS7PkeFR4b8FMj7awlR0RgsjnEnax2t789Nm52spp8s2nOyvVMl+3VG1ldjQ==
X-Gm-Message-State: AOJu0YySddW8LyYzi4XkTAEw20jBLKZwH3kNqD0vMVsTwC1B6peHcWJi
	CjNDvoVHlo6uGj0692jM3HMcOFfbZevqjhFE0wBMxk0qlK4Cig2B4/JhkpWuZEY=
X-Google-Smtp-Source: AGHT+IERPVYeyp0knT0qnA7HFhsYNChUvgj95aMeOr/diQ4nogvMSFNqc1a5bd3dO7GrUmuJSqomCg==
X-Received: by 2002:a05:6512:159f:b0:511:52b4:8b93 with SMTP id bp31-20020a056512159f00b0051152b48b93mr253307lfb.29.1707517741660;
        Fri, 09 Feb 2024 14:29:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXXIL7E23F1528dwMyqLPO8dFBEbXqUIEZ5ey4jJ8Ty8PM1Xxsm4zWdxy5LIlu8NPft/2rUpeBguCkrQKj/ADAwSA64hNppuTH9I8PPNDlZS3qDhvHLLfdI4CnTPvvp8Dv/B0Z0ye1T3Y+W2YyzRcz9bgWGumGMzsx3pYLZhYlY3+LnZvOh8QGsOr+BcX4pFrdkgC68MXVDLqPD77OHINX/CpMy9OCED+Qw1njUyDFIujQkSFfmlokMdf4/XSJZG08/rs0uCA4EpcYoEoUOWsJHRy0S9LWS340FFynvQ3k3o3cqoWG3gkouhfkmb0SlbOgWzuy4inysPkec6pEK/Mxl+JvYNakPQTr4X3aSppYeiF/J/1W7lq0G1pOztBGqfaIWYRoE0zY8k3Uw8AdLzxnAGbfbV9DP8z0BHDnJt2mhf0CcdyLauag3UnGGd4arnGad2F+cyvAqWJiuPAXPeGTGoe1F0ksO0E8lQaww0a8Uo8vtlVO087puYn+TCVbNkrh6tQjxUA6fVQUFfKvD4f9xUje/gyoqPlIRsFunx0t2IUFEOYeHyL1QCHEHWyWVqTTtUWBmdn0VNs4AL5vxs1ap4d2/INjVlGqCYJgbSWcweA==
Received: from [192.168.192.207] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id hw13-20020a170907a0cd00b00a3820ec721csm1167406ejc.8.2024.02.09.14.28.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 14:29:01 -0800 (PST)
Message-ID: <1d67b626-12ef-484b-99e1-d5d6d3571d74@linaro.org>
Date: Fri, 9 Feb 2024 23:28:59 +0100
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] arm64: dts: qcom: msm8996: specify UFS core_clk
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
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <andy.gross@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>,
 Bart Van Assche <bvanassche@acm.org>, Andy Gross <agross@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240209-msm8996-fix-ufs-v1-0-107b52e57420@linaro.org>
 <20240209-msm8996-fix-ufs-v1-4-107b52e57420@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240209-msm8996-fix-ufs-v1-4-107b52e57420@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9.02.2024 22:50, Dmitry Baryshkov wrote:
> Follow the example of other platforms and specify core_clk frequencies
> in the frequency table in addition to the core_clk_src frequencies. The
> driver should be setting the leaf frequency instead of some interim
> clock freq.
> 
> Suggested-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> Fixes: 57fc67ef0d35 ("arm64: dts: qcom: msm8996: Add ufs related nodes")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

3.18 says the clock can even go as high as 240000000

Konrad

