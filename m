Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12B433B2278
	for <lists+linux-scsi@lfdr.de>; Wed, 23 Jun 2021 23:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhFWVcq (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 23 Jun 2021 17:32:46 -0400
Received: from mail-pj1-f54.google.com ([209.85.216.54]:35559 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhFWVcq (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 23 Jun 2021 17:32:46 -0400
Received: by mail-pj1-f54.google.com with SMTP id pf4-20020a17090b1d84b029016f6699c3f2so4630294pjb.0;
        Wed, 23 Jun 2021 14:30:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fdjwEWE24Dy/IG34lYYHtdW9bawi+R/sEfDdB4k+M44=;
        b=FP5/8F1Q9PKqRetB/0wLbCeY21JvfejTSTlRyoDbK2knKIFPGw532IijKh+Ur8enWe
         XLX6WtD6c8frWRGZqn6JowXzR0EmwqEG0BBafI0NFXMmgtpcPkXLKsjyyz/MAV5r2ub8
         L3y6TP7UKVcbSzeLxgawqvkOBklB0k64AE5glPasPWcCHAFutYu6ARwUYwPco4Eooy+S
         bVEUAK1vSm4mlbqlGcQxyIxt6oZXDRxtIXD0Osy4B3klKV7n4BPTrlC+GylCjJ7UOiFp
         7uwzcQnXN17j4TjFZnHyC8wm2Nw29KtOnyWOBl7YXiHOG3Q8tTW/WKrYRG+JiXYjo24J
         c4+w==
X-Gm-Message-State: AOAM530sR8NLpij8hmPB+AWhRJk9j4m2uh0DlndPF+CMYEcBczFfJsAP
        xl54hGi//qC0JYXOJXpTlRkOPCdls8c=
X-Google-Smtp-Source: ABdhPJy7DX5Ast8uucUZKUgFPqMCI4ozmIf83KEET693R9mgkhDLUap6BnyNimy1ur33fhmUdJW+Hg==
X-Received: by 2002:a17:90a:6fc5:: with SMTP id e63mr1750174pjk.90.1624483827344;
        Wed, 23 Jun 2021 14:30:27 -0700 (PDT)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id l10sm6094468pjg.26.2021.06.23.14.30.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 14:30:26 -0700 (PDT)
Subject: Re: [PATCH v4 07/10] scsi: ufs: Simplify error handling preparation
To:     Can Guo <cang@codeaurora.org>, asutoshd@codeaurora.org,
        nguyenb@codeaurora.org, hongwus@codeaurora.org,
        ziqichen@codeaurora.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Bean Huo <beanhuo@micron.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1624433711-9339-1-git-send-email-cang@codeaurora.org>
 <1624433711-9339-9-git-send-email-cang@codeaurora.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <dbe3e867-7e47-e306-038e-2e578845c5ba@acm.org>
Date:   Wed, 23 Jun 2021 14:30:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1624433711-9339-9-git-send-email-cang@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 6/23/21 12:35 AM, Can Guo wrote:
> -static void ufshcd_err_handling_prepare(struct ufs_hba *hba)
> +static int ufshcd_err_handling_prepare(struct ufs_hba *hba)
>  {
>  	/*
>  	 * It is not safe to perform error handling while suspend or resume is
>  	 * in progress. Hence the lock_system_sleep() call.
>  	 */
>  	lock_system_sleep();
> +	/*
> +	 * Exclusively call pm_runtime_get_sync(hba->dev) once, in case
> +	 * following ufshcd_rpm_get_sync() fails.
> +	 */
> +	pm_runtime_get_sync(hba->dev);
> +	if (pm_runtime_suspended(hba->dev) || hba->is_sys_suspended) {
> +		pm_runtime_put(hba->dev);
> +		unlock_system_sleep();
> +		return -EINVAL;
> +	}

There is code present in ufshcd_queuecommand() that may trigger data
corruption to prevent that the above pm_runtime_get_sync() call triggers
a deadlock. I think we need a better solution.

Thanks,

Bart.
