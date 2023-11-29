Return-Path: <linux-scsi+bounces-309-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EC97FDF9E
	for <lists+linux-scsi@lfdr.de>; Wed, 29 Nov 2023 19:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 411ECB20B17
	for <lists+linux-scsi@lfdr.de>; Wed, 29 Nov 2023 18:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8003B790
	for <lists+linux-scsi@lfdr.de>; Wed, 29 Nov 2023 18:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1B5120;
	Wed, 29 Nov 2023 10:11:42 -0800 (PST)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6cb74a527ceso17672b3a.2;
        Wed, 29 Nov 2023 10:11:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701281501; x=1701886301;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4gLDX8cWt3JEEqgRokj5ykqsN5muXxo/Ge+Xctz4FUg=;
        b=aEV/etGefOoxFxJpyfpe/BJ9/3bIUh7vcvKsG4AM0pMsRd96l4Tr+o6o9z3Pie6GlR
         Kg2z+I9A6WHY3aLpKOMDwfxd5M7bHrn8bQVtJIYnLYU/ItcZCUMxmgUgM2XX6m27Kayi
         gGFtjwBzedabiMRok7kUV/KE+RQfZhlB884Lvce7Kh9+Kms4wsHiolnlZBp6rtOnchQd
         UFIT0brXj7npTB4+lCwpLx6X/F9JY7cginbktC8RzmxfrUwP2EeDLPBHPO7ffZyxlxRa
         7i+nZJ9bv4HOjymbGLywVwzeL4GC+jfG2FfB0MsCfMiitlHBcvFDzPAmi/JF+apUN1Hj
         HwQQ==
X-Gm-Message-State: AOJu0YwPSDX6XGxiUiOxhDIfuMvw+nkS2R5+CNGn9qrTcVTK/QXX1XIB
	CznU0AA9slbbVwMb3CqVPRw=
X-Google-Smtp-Source: AGHT+IGy+4WYJhTiQIOswP/E41L9YL8AuNEuZh5o79tqLq/ynbibB9mZf/1DyU/qOz7NtDQNLElZ2g==
X-Received: by 2002:a05:6a20:e68c:b0:18b:d344:6acd with SMTP id mz12-20020a056a20e68c00b0018bd3446acdmr19899607pzb.10.1701281501391;
        Wed, 29 Nov 2023 10:11:41 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:af8d:714d:9855:3f9d? ([2620:0:1000:8411:af8d:714d:9855:3f9d])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ee8900b001b7f40a8959sm12648546pld.76.2023.11.29.10.11.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 10:11:40 -0800 (PST)
Message-ID: <0cc74796-2369-4c02-a78f-4f1d5e8337dc@acm.org>
Date: Wed, 29 Nov 2023 10:11:38 -0800
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/10] scsi: ufs: host: Rename structure ufs_dev_params
 to ufs_host_params
Content-Language: en-US
To: Can Guo <quic_cang@quicinc.com>, mani@kernel.org,
 adrian.hunter@intel.com, cmd4@qualcomm.com, beanhuo@micron.com,
 avri.altman@wdc.com, junwoo80.lee@samsung.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Alim Akhtar <alim.akhtar@samsung.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Stanley Chu <stanley.chu@mediatek.com>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Nitin Rawat <quic_nitirawa@quicinc.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Brian Masney <bmasney@redhat.com>,
 "moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES"
 <linux-samsung-soc@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>,
 "moderated list:UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER..."
 <linux-mediatek@lists.infradead.org>
References: <1701246516-11626-1-git-send-email-quic_cang@quicinc.com>
 <1701246516-11626-2-git-send-email-quic_cang@quicinc.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1701246516-11626-2-git-send-email-quic_cang@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/29/23 00:28, Can Guo wrote:
> Structure ufs_dev_params is actually used in UFS host vendor drivers to
> declare host specific power mode parameters, like ufs_<vendor>_params or
> host_cap, which makes the code not very straightforward to read. Rename the
> structure ufs_dev_params to ufs_host_params and unify the declarations in
> all vendor drivers to host_params.
> 
> In addition, rename the two functions ufshcd_init_pwr_dev_param() and
> ufshcd_get_pwr_dev_param() which work based on the ufs_host_params to
> ufshcd_init_host_params() and ufshcd_negotiate_pwr_params() respectively to
> avoid confusions.
> 
> This change does not change any functionalities or logic.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

