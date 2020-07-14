Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C66FE21F553
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Jul 2020 16:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgGNOtn (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 14 Jul 2020 10:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgGNOtn (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 14 Jul 2020 10:49:43 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C347AC061755
        for <linux-scsi@vger.kernel.org>; Tue, 14 Jul 2020 07:49:42 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j4so22179718wrp.10
        for <linux-scsi@vger.kernel.org>; Tue, 14 Jul 2020 07:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Zi5GYhpQQMVV7cmlCA8KTTigfHDyvtxo0VxbZp2YE8o=;
        b=cVWljfDHGfZY9IMeigMttD42CdSHCn/xddsi2qc+u5MJSmSZyQEv60MmY/McXy9Y5Z
         Nrnc7CLFuWW919/0IVmwB0V+nMZfUzpwtLoI/S+Z7cc4MonjLW/njT+oEP++TGEA5ix+
         N4ypKdms4qxu6J3QL5wJSBRmGMr2TeRiDgMLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Zi5GYhpQQMVV7cmlCA8KTTigfHDyvtxo0VxbZp2YE8o=;
        b=tj3ojzNChUCX5xLPSRxs4RS0TTbVzGHbaAcjahnOkFv/PiMwmLAVe3HQ50/NDrWENU
         nZP23BALbeRwl/TUOAN18YRf2ZYyUTdTuQkxXKmPPV9PzGQ7dJZg9mI6JwDG5FkHs+23
         H8nYmZgfVq4Hgbbvp9qL2b752+R/Lb0mJKJhxfErj8SuD9SniBmgQP11HIkvnGsaNHpg
         D/+rfYjpIWtnc9H5AIo1ZW4buvT+SZd4rdnk0InkSH/FUDYWn2WE/68gssW5BTatc5ke
         pxNNYSjotdPYcup684cH/800cyoKsr8rynWDOaTPsmoKPpbFUSFUQGRH4n5f+TI2CBEr
         U7Pw==
X-Gm-Message-State: AOAM533rDpD6mTvF89bsn4T4YR2LRmYQW04PiLzXvIVFVb1q7+NmCQ6n
        uLI+IFyOZFSDbccVpylIl4QF8cgxpfV6OsUNCRm0C8C+/pSx9m6znsDb3bykHPmBYFd6pU3dhwV
        Q6eUUS+bEeOGz/fsPgsIofDb01Y7HzUteM0qX5I4HtbVrsvFcwJIelvAMlpWUv56J/dZrbSCYrC
        bYtgw=
X-Google-Smtp-Source: ABdhPJwzX29bPY97iJAdwhYKe+xSitZnn0kSCViod8sm1i/Ag177gmTQrmoeVUsKEHi3cP2vVSGyGA==
X-Received: by 2002:a5d:4687:: with SMTP id u7mr6444902wrq.357.1594738181007;
        Tue, 14 Jul 2020 07:49:41 -0700 (PDT)
Received: from [10.230.185.151] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id k126sm5195273wme.17.2020.07.14.07.49.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 07:49:40 -0700 (PDT)
Subject: Re: [PATCH] lpfc: Quieten some printks
To:     Anton Blanchard <anton@ozlabs.org>, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org
References: <20200713083908.1104927-1-anton@ozlabs.org>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <4af09584-cbbd-6045-e258-c2bd0f3f8ccc@broadcom.com>
Date:   Tue, 14 Jul 2020 07:49:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200713083908.1104927-1-anton@ozlabs.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org



On 7/13/2020 1:39 AM, Anton Blanchard wrote:
> On a big box the lpfc driver emits a few thousand "Set Affinity" lines
> to the console. Reduce the priority of these from KERN_ERR to KERN_INFO,
> and also fix a few printks that had no log level.
>
> Signed-off-by: Anton Blanchard <anton@ozlabs.org>
> ---
>   drivers/scsi/lpfc/lpfc_init.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
> index 6637f84a3d1b..daa41ddaf33d 100644
> --- a/drivers/scsi/lpfc/lpfc_init.c
> +++ b/drivers/scsi/lpfc/lpfc_init.c
> @@ -11008,7 +11008,7 @@ lpfc_cpu_affinity_check(struct lpfc_hba *phba, int vectors)
>   		/* 1 to 1, the first LPFC_CPU_FIRST_IRQ cpus to a unique hdwq */
>   		cpup->hdwq = idx;
>   		idx++;
> -		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
> +		lpfc_printf_log(phba, KERN_INFO, LOG_INIT,
>   				"3333 Set Affinity: CPU %d (phys %d core %d): "
>   				"hdwq %d eq %d flg x%x\n",
>   				cpu, cpup->phys_id, cpup->core_id,
> @@ -11086,7 +11086,7 @@ lpfc_cpu_affinity_check(struct lpfc_hba *phba, int vectors)
>   			start_cpu = first_cpu;
>   		cpup->hdwq = new_cpup->hdwq;
>    logit:
> -		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
> +		lpfc_printf_log(phba, KERN_INFO, LOG_INIT,
>   				"3335 Set Affinity: CPU %d (phys %d core %d): "
>   				"hdwq %d eq %d flg x%x\n",
>   				cpu, cpup->phys_id, cpup->core_id,
> @@ -13974,8 +13974,8 @@ lpfc_init(void)
>   {
>   	int error = 0;
>   
> -	printk(LPFC_MODULE_DESC "\n");
> -	printk(LPFC_COPYRIGHT "\n");
> +	pr_info(LPFC_MODULE_DESC "\n");
> +	pr_info(LPFC_COPYRIGHT "\n");
>   
>   	error = misc_register(&lpfc_mgmt_dev);
>   	if (error)

Reviewed-by: James Smart <james.smart@broadcom.com>

Certainly agree.

Thanks

-- james




