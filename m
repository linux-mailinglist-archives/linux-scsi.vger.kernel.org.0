Return-Path: <linux-scsi+bounces-28-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C070E7F362E
	for <lists+linux-scsi@lfdr.de>; Tue, 21 Nov 2023 19:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F10921C209DF
	for <lists+linux-scsi@lfdr.de>; Tue, 21 Nov 2023 18:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540F018E02
	for <lists+linux-scsi@lfdr.de>; Tue, 21 Nov 2023 18:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFEA12A;
	Tue, 21 Nov 2023 09:57:35 -0800 (PST)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1cf50cc2f85so28106835ad.1;
        Tue, 21 Nov 2023 09:57:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700589455; x=1701194255;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VerxGTg54Ge3nIcqcHewvtLdmH0svTb7Qyi+B5TIC1g=;
        b=XO6y+bVREZHIaIHbG5qXiDUNpA8GRvp+fyoEY2i4DunsAxUVme+qcsmzTCAUdLbJc4
         UobPidw446fratRMY0aqzXJhDliaGM0EZtO+xR0ssVVmJFpJOuHUCxviPKQjmmE0YUb8
         jKZIku4VuO0GnZ3Fy0fCBBJB0OZyzzLaNw8nSmCARXQ3mI8/NyKiRSg1CGf33QIL4iTP
         PXN3W2pIrquk92029XeWOZXPxNFQWUR9dnH3ije3rhDuDzAEQk25jw6/zHe1QA6mWubY
         MmHcClbgORuSkV/hvypDkany/xkWQSw+hl79oX7Ser0Tb8kR135UqjW6El1ECJRPe7GE
         57+Q==
X-Gm-Message-State: AOJu0YwILfsyIdYme8ODCrpIDt/LzNawQIU1E1Bi4tUqLFDmNPAnZkqS
	h6qBZO/I52Ew4jE/AwO99Fo=
X-Google-Smtp-Source: AGHT+IEAbu3suP8whz3NCQkEIS3yeBbVQrCHGkbzk9iiZV7XkmXqQ4Xh0p0IUyJOAuxCQlTSej9ScQ==
X-Received: by 2002:a17:902:e5ca:b0:1cf:6373:b8a5 with SMTP id u10-20020a170902e5ca00b001cf6373b8a5mr6481837plf.25.1700589454616;
        Tue, 21 Nov 2023 09:57:34 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:bb61:2ac8:4d61:2b3d? ([2620:0:1000:8411:bb61:2ac8:4d61:2b3d])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902d48c00b001b7cbc5871csm8230146plg.53.2023.11.21.09.57.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 09:57:34 -0800 (PST)
Message-ID: <f92655ec-96ab-4f3d-8f5b-a5b9780adc5a@acm.org>
Date: Tue, 21 Nov 2023 09:57:29 -0800
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] scsi: ufs: core: fix racing issue during
 ufshcd_mcq_abort
Content-Language: en-US
To: SEO HOYOUNG <hy50.seo@samsung.com>, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
 jejb@linux.ibm.com, martin.petersen@oracle.com, beanhuo@micron.com,
 kwangwon.min@samsung.com, kwmad.kim@samsung.com, sh425.lee@samsung.com,
 sc.suh@samsung.com, quic_nguyenb@quicinc.com, cpgs@samsung.com,
 grant.jung@samsung.com, junwoo80.lee@samsung.com
References: <CGME20231121070851epcas2p2ba11977edde23d3dcb87581e410806c8@epcas2p2.samsung.com>
 <20231121071128.7743-1-hy50.seo@samsung.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231121071128.7743-1-hy50.seo@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/20/23 23:11, SEO HOYOUNG wrote:
> Bart said that lrbp->cmd could be changed before ufshcd_clear_cmd() was
> called, so lrbp->cmd check was moved to ufshcd_clear_cmd().
> In the case of legacy mode, spin_lock is used to protect before clear cmd,
> but spin_lock cannot be used due to mcq mode, so it is necessary to check
> the status of lrbp->cmd.

Does this mean that the race that I mentioned has not been addressed at all?
ufshcd_mcq_sq_cleanup() is called by ufshcd_clear_cmd(). No locks are held by
ufshcd_eh_device_reset_handler() when it calls ufshcd_clear_cmd(). So I think
there is still a race between the code added by this patch and the completion
interrupt.

Thanks,

Bart.

> Change-Id: Id8412190e60286d00a30820591566835cefbf47e

No Change-Ids in patches that are posted on upstream mailing lists please.

> diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
> index 2ba8ec254dce..deb6dac724c8 100644
> --- a/drivers/ufs/core/ufs-mcq.c
> +++ b/drivers/ufs/core/ufs-mcq.c
> @@ -507,6 +507,10 @@ int ufshcd_mcq_sq_cleanup(struct ufs_hba *hba, int task_tag)
>   	if (hba->quirks & UFSHCD_QUIRK_MCQ_BROKEN_RTC)
>   		return -ETIMEDOUT;
>   
> +	if (!ufshcd_cmd_inflight(cmd) ||
> +	    test_bit(SCMD_STATE_COMPLETE, &cmd->state))
> +		return 0;
> +
>   	if (task_tag != hba->nutrs - UFSHCD_NUM_RESERVED) {
>   		if (!cmd)
>   			return -EINVAL;

Thanks,

Bart.

