Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E87E22AFA5
	for <lists+linux-scsi@lfdr.de>; Mon, 27 May 2019 10:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbfE0IBM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 27 May 2019 04:01:12 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:41746 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfE0IBL (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 27 May 2019 04:01:11 -0400
Received: by mail-ua1-f67.google.com with SMTP id l14so6129612uah.8
        for <linux-scsi@vger.kernel.org>; Mon, 27 May 2019 01:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pBSUB4SN9OQHrj4cS3m08A0jB5J8vJS1S0v+4XLlE6Q=;
        b=ZhhQ0nQYNF4NIRNcn8EBoMCENvbjo/FT16CK5aZsaQlVJzsTPPRM1WjKPMMVjZMqa0
         NMLtpPdg0Z3+IdtejtnhYB8qZEupLY4/qS90T+Uf2jaMcSJFK9CEAQ2T3MFDXkPDDddD
         bZJbsRElCU//XHK/eBO0PhkTi93SQzsshlT5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pBSUB4SN9OQHrj4cS3m08A0jB5J8vJS1S0v+4XLlE6Q=;
        b=llCDyBUxSii3tqerKtx7DZ2T0uIdz40EFW/QeAJ52BxI/YGAb/bG7NTg3JdUtZeKec
         rITfMByFuyVkCx4iTDs9QK0vqYJTZdP6P4EZNZOf0maP8swZmaW0Rj19tpj1bdEvivas
         Fb9oeo9T4xGb6Xlds6QoDSKyOAKckgTtJXkWwCt+Gb3wnkjMIrdeZc4X6pXlyWPjlp1F
         91sFsFnNYgYU/rSsdNWnNdgWzLO2OQ9/HBcHRpTq70BQ+BMxNf1AsZ5YEqEBAQWWbnW/
         B2IYHIaN2DyqdNJq0ZDlyFRsZLjdvh6XYKWTkI3hxUFJTvYivN72zx4W+9dT7tbjS3L1
         QFOw==
X-Gm-Message-State: APjAAAUlfhSEopI1H60RuzD33oZBkrMlZNWxVkoILNfyetbtgd7ikwZt
        iY5w41T9ys0BcRdhduW1N4hlKUTJ00pjL8fKnYmvfQ==
X-Google-Smtp-Source: APXvYqzkfGtl1QOJitY9/IYlk2BjiUCahgGT/Fg6vPpgSQhBy5rvKcyR1VEpJW2OnRnxzyHMeqdv4eqfq1dQsogSskQ=
X-Received: by 2002:ab0:70d1:: with SMTP id r17mr20075942ual.136.1558944070794;
 Mon, 27 May 2019 01:01:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190525124202.8120-1-yuehaibing@huawei.com>
In-Reply-To: <20190525124202.8120-1-yuehaibing@huawei.com>
From:   Sumit Saxena <sumit.saxena@broadcom.com>
Date:   Mon, 27 May 2019 13:30:59 +0530
Message-ID: <CAL2rwxrmVuTsR=JY4h5agyTPMdsZA1xgvdC09O9XV3gDMTm2BQ@mail.gmail.com>
Subject: Re: [PATCH -next] scsi: megaraid_sas: remove set but not used
 variables 'host' and 'wait_time'
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>, jejb@linux.ibm.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        "PDL,MEGARAIDLINUX" <megaraidlinux.pdl@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sat, May 25, 2019 at 6:14 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fixes gcc '-Wunused-but-set-variable' warnings:
>
> drivers/scsi/megaraid/megaraid_sas_base.c: In function megasas_suspend:
> drivers/scsi/megaraid/megaraid_sas_base.c:7269:20: warning: variable host set but not used [-Wunused-but-set-variable]
> drivers/scsi/megaraid/megaraid_sas_base.c: In function megasas_aen_polling:
> drivers/scsi/megaraid/megaraid_sas_base.c:8397:15: warning: variable wait_time set but not used [-Wunused-but-set-variable]
>
> 'host' is never used since introduction in
> commit 31ea7088974c ("[SCSI] megaraid_sas: add hibernation support")
>
> 'wait_time' is not used since commit
> 11c71cb4ab7c ("megaraid_sas: Do not allow PCI access during OCR")
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Sumit Saxena <sumit.saxena@broadcom.com>

> ---
>  drivers/scsi/megaraid/megaraid_sas_base.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
> index 92e576228d5f..ed0f6ca578e5 100644
> --- a/drivers/scsi/megaraid/megaraid_sas_base.c
> +++ b/drivers/scsi/megaraid/megaraid_sas_base.c
> @@ -7239,11 +7239,9 @@ static void megasas_shutdown_controller(struct megasas_instance *instance,
>  static int
>  megasas_suspend(struct pci_dev *pdev, pm_message_t state)
>  {
> -       struct Scsi_Host *host;
>         struct megasas_instance *instance;
>
>         instance = pci_get_drvdata(pdev);
> -       host = instance->host;
>         instance->unload = 1;
>
>         dev_info(&pdev->dev, "%s is called\n", __func__);
> @@ -8367,7 +8365,7 @@ megasas_aen_polling(struct work_struct *work)
>         struct megasas_instance *instance = ev->instance;
>         union megasas_evt_class_locale class_locale;
>         int event_type = 0;
> -       u32 seq_num, wait_time = MEGASAS_RESET_WAIT_TIME;
> +       u32 seq_num;
>         int error;
>         u8  dcmd_ret = DCMD_SUCCESS;
>
> @@ -8377,10 +8375,6 @@ megasas_aen_polling(struct work_struct *work)
>                 return;
>         }
>
> -       /* Adjust event workqueue thread wait time for VF mode */
> -       if (instance->requestorId)
> -               wait_time = MEGASAS_ROUTINE_WAIT_TIME_VF;
> -
>         /* Don't run the event workqueue thread if OCR is running */
>         mutex_lock(&instance->reset_mutex);
>
> --
> 2.17.1
>
>
