Return-Path: <linux-scsi+bounces-431-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2B48014B3
	for <lists+linux-scsi@lfdr.de>; Fri,  1 Dec 2023 21:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95EFB1F20FD7
	for <lists+linux-scsi@lfdr.de>; Fri,  1 Dec 2023 20:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197F458AB1
	for <lists+linux-scsi@lfdr.de>; Fri,  1 Dec 2023 20:41:43 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB6BDD;
	Fri,  1 Dec 2023 12:27:51 -0800 (PST)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1cfcc9b3b5cso8607295ad.0;
        Fri, 01 Dec 2023 12:27:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701462471; x=1702067271;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1TFPInV3Tc8ZFH5rwZRwPYcB8wwI/zl+CFu8s3Ie1xU=;
        b=hhfbuBFnoT9UuZff9clCk5x+1Fv105MjcMJNnWTtQdbeHLXsXAjPQ10tPkSECoHreM
         oUZulqeyXaEp0xdX7H4ooeRzlGCdUptAi8c6r898R7D8ZbcubB4BtN407TmEtV6uHVTb
         3VO7azcQYt2tOUeocIXEEXuYLP8rP55sRd2vuLe3akR8KvsIPk8d28NYZHPcI3uJYpKz
         94t8fuH8WXEPswkDbqz49KgKHH7pk7mqgRFrMweNguk24dTIT7D+Rj5TUIYOZo96Tnny
         IFrXyWFwMVMH0rKSA9rrs67ZsBifMgO4yOHz9+Bw3lpMFv0LO+55dC3BUdJOWFTjtu8R
         25Ig==
X-Gm-Message-State: AOJu0YwlIyDqt835xeX/mFUEZHy/7IonP33YFcCrbrogiuV8Br+SBWie
	pqCyqD0m5CiuThvgu0bPv14=
X-Google-Smtp-Source: AGHT+IEPDjVtIn3LAftvRhiMx0r4y+ay+rjlITtJ30wwSBgS3pfnXWGK/B1TcLukDKXmQ8nLyPPJrQ==
X-Received: by 2002:a17:903:22c1:b0:1d0:1c45:fca6 with SMTP id y1-20020a17090322c100b001d01c45fca6mr105449plg.55.1701462470485;
        Fri, 01 Dec 2023 12:27:50 -0800 (PST)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id s2-20020a170902ea0200b001c9d011581dsm797614plg.164.2023.12.01.12.27.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 12:27:50 -0800 (PST)
Message-ID: <ac563d4a-29dc-4985-bdbf-f6e77ba74a82@acm.org>
Date: Fri, 1 Dec 2023 12:27:48 -0800
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] scsi: ufs: qcom: Export ufshcd_{enable/disable}_irq
 helpers and make use of them
Content-Language: en-US
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 martin.petersen@oracle.com, jejb@linux.ibm.com
Cc: andersson@kernel.org, konrad.dybcio@linaro.org,
 linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, quic_cang@quicinc.com
References: <20231201151417.65500-1-manivannan.sadhasivam@linaro.org>
 <20231201151417.65500-7-manivannan.sadhasivam@linaro.org>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231201151417.65500-7-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/1/23 07:14, Manivannan Sadhasivam wrote:
> Instead of duplicating the enable/disable IRQ part, let's export the
> helpers available in ufshcd driver and make use of them. This also fixes
> the possible redundant IRQ disable before asserting reset (when IRQ was
> already disabled).

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

