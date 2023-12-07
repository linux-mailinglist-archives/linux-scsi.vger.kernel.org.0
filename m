Return-Path: <linux-scsi+bounces-674-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 602B7807E91
	for <lists+linux-scsi@lfdr.de>; Thu,  7 Dec 2023 03:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4B551F219D9
	for <lists+linux-scsi@lfdr.de>; Thu,  7 Dec 2023 02:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26F61095F
	for <lists+linux-scsi@lfdr.de>; Thu,  7 Dec 2023 02:33:12 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA11ED51;
	Wed,  6 Dec 2023 17:06:17 -0800 (PST)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d05199f34dso2904045ad.3;
        Wed, 06 Dec 2023 17:06:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701911177; x=1702515977;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uLC9SHWP9HzPPTfguvi7eCiTglb7l56HPdmyFvz6QMA=;
        b=HVxuqATRtNeh+PZj+0v6py1i7Dv9UwNXnH1iKyUmSQRZLpYLebOsJwKaIPqUaTC6ZT
         s7twbP32ZX7xEcDdDRbGEw1tnH+/C1++JETH+S0vNqE/QsYK5gupc2mxvH/B3vvIvlDE
         ZnwlYIHHSxOeb/WXnDx+kVBRlAwecfO3vUKFDJKFThR67G3CU/wh5Xzn4YvEkPe3NFFN
         b43/jUwdkKu9PHC2uy98Tdf6AU0Xd90kYskXD3LSOS/PiLEsdMjT/rBHebyxzBzj/pW9
         dD7UMq7rh2MBdlRNY6kuvL6+z7h2GA+T678TvMYPFEOw60wzOGJu7QlYniOV1JbMuITq
         A2Nw==
X-Gm-Message-State: AOJu0Yy3ypJpS3kUefVte/7pr78PscH7/pUYq0z53u314kyndHFXuvpX
	EXm/iog5S1VDwn7PANO90Ps=
X-Google-Smtp-Source: AGHT+IHwUB/whwiwrYuDeWnhqFHNTLsYBeNTQh7IPMwKHmtxCck1bYQoJP4rNoMnXUU8cBJoXNMMPA==
X-Received: by 2002:a17:902:b195:b0:1d0:6ffd:6e6e with SMTP id s21-20020a170902b19500b001d06ffd6e6emr1655754plr.102.1701911177129;
        Wed, 06 Dec 2023 17:06:17 -0800 (PST)
Received: from [172.20.2.177] (rrcs-173-197-90-226.west.biz.rr.com. [173.197.90.226])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c21500b001cfb573674fsm80938pll.30.2023.12.06.17.06.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 17:06:16 -0800 (PST)
Message-ID: <bf2b1671-2911-4d74-abfb-e6dbfe03d626@acm.org>
Date: Wed, 6 Dec 2023 15:06:14 -1000
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4] scsi: ufs: core: store min and max clk freq from OPP
 table
Content-Language: en-US
To: Nitin Rawat <quic_nitirawa@quicinc.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_cang@quicinc.com, Manish Pandey <quic_mapa@quicinc.com>
References: <20231206133812.21488-1-quic_nitirawa@quicinc.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231206133812.21488-1-quic_nitirawa@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/6/23 03:38, Nitin Rawat wrote:
> +	list_for_each_entry(clki, head, list) {
> +		if (!clki->name)
> +			continue;
> +
> +		clki->clk = devm_clk_get(hba->dev, clki->name);
> +		if (!IS_ERR(clki->clk)) {

Please change the above line into the following:

	if (IS_ERR(...))
		continue;

to reduce the indentation level of the code below this statement.

Thanks,

Bart.

