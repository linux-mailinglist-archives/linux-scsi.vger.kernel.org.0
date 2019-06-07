Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D814F3847B
	for <lists+linux-scsi@lfdr.de>; Fri,  7 Jun 2019 08:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfFGGkI (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 7 Jun 2019 02:40:08 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:39102 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbfFGGkH (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 7 Jun 2019 02:40:07 -0400
Received: by mail-vk1-f195.google.com with SMTP id f6so194671vka.6
        for <linux-scsi@vger.kernel.org>; Thu, 06 Jun 2019 23:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CKhb4oCF7D3bqEsoqNhCVNdLG8S+Ey80GvxfLYnC/Lc=;
        b=f4OdmP+qS6pC/zAcoeFc32wmbdUfirfCvBWVMueiLutQhc9DWgoSGN7oHAgSTMYV3I
         gmE44ShcRgS7eSRmdtWScatlgVhS3ESP++RYpg2JF07acIMELQWV4q5mBacMmxuPc4rX
         1S0INFUsptCO60dtZmVlSapJ7fwb5lTSbX9/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CKhb4oCF7D3bqEsoqNhCVNdLG8S+Ey80GvxfLYnC/Lc=;
        b=jxOiS20E/0KXMmmyYan2HdlYJmgB0S0sSkfsoiQJeJKqW6rpuLwCII0jmDAylHUO0F
         XHpDaUiQFOJ+pAbuZJUwkI6fopI7u53V1/x6n9tAyTaqDTn1/0/78u/maXMcHE84XWhU
         z9B+4zIPUOIF5dfHpN1eqWi7yLz4INScxvMohdU5KEyHTAFlj3uptRPSWorogBmGzaJN
         No2vzG28MdzghCM10vf7csrczU+0XVyunY9GcBR8MKRl8E7vU6GjXTx5VTe8RetElYhu
         MHSjrg6ibzRnA/6rgr8CC49sCrvlu9v/wuuJi0Q+wPwtkv84YCxsuFgSYVRsCOiWCZqS
         wgqA==
X-Gm-Message-State: APjAAAVETH5nc8M32nnzBuA+oCoWLkGlnWRSsAToCG5W4EHGYEVsKCyb
        OWwn9ArvVDOcH3D/RsKIdImXKBshWRMs4UEHZuu+Yw==
X-Google-Smtp-Source: APXvYqx5lzcXabWM0mfXfKnyl8GMY3abr37WvKDF/0SGDSXb7F0V+Uk7Rd1wKFD/vKUBvTY6sAPm5qWY4W/STmImnck=
X-Received: by 2002:a1f:e184:: with SMTP id y126mr14807148vkg.3.1559889606637;
 Thu, 06 Jun 2019 23:40:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190525124006.21284-1-yuehaibing@huawei.com>
In-Reply-To: <20190525124006.21284-1-yuehaibing@huawei.com>
From:   Sumit Saxena <sumit.saxena@broadcom.com>
Date:   Fri, 7 Jun 2019 12:09:55 +0530
Message-ID: <CAL2rwxpg7b8H1+xxNgw4tw2yOnNhxRfsnwfxUPA5b93ajvX9Hw@mail.gmail.com>
Subject: Re: [PATCH -next] scsi: megaraid_sas: remove set but not used
 variables 'buff_addr' and 'ci_h'
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        "PDL,MEGARAIDLINUX" <megaraidlinux.pdl@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sat, May 25, 2019 at 6:10 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fixes gcc '-Wunused-but-set-variable' warnings:
>
> drivers/scsi/megaraid/megaraid_sas_base.c: In function megasas_fw_crash_buffer_show:
> drivers/scsi/megaraid/megaraid_sas_base.c:3138:16: warning: variable buff_addr set but not used [-Wunused-but-set-variable]
> drivers/scsi/megaraid/megaraid_sas_base.c: In function megasas_get_pd_list:
> drivers/scsi/megaraid/megaraid_sas_base.c:4426:13: warning: variable ci_h set but not used [-Wunused-but-set-variable]
>
> 'buff_addr' is never used since inroduction in
> commit fc62b3fc9021 ("megaraid_sas : Firmware crash dump feature support")
>
> 'ci_h' is not used since commit 9b3d028f3468 ("scsi: megaraid_sas:
> Pre-allocate frequently used DMA buffers")
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Sumit Saxena <sumit.saxena@broadcom.com>
> ---
>  drivers/scsi/megaraid/megaraid_sas_base.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
> index 39d173ed5b69..92e576228d5f 100644
> --- a/drivers/scsi/megaraid/megaraid_sas_base.c
> +++ b/drivers/scsi/megaraid/megaraid_sas_base.c
> @@ -3135,7 +3135,6 @@ megasas_fw_crash_buffer_show(struct device *cdev,
>         struct megasas_instance *instance =
>                 (struct megasas_instance *) shost->hostdata;
>         u32 size;
> -       unsigned long buff_addr;
>         unsigned long dmachunk = CRASH_DMA_BUF_SIZE;
>         unsigned long src_addr;
>         unsigned long flags;
> @@ -3152,8 +3151,6 @@ megasas_fw_crash_buffer_show(struct device *cdev,
>                 return -EINVAL;
>         }
>
> -       buff_addr = (unsigned long) buf;
> -
>         if (buff_offset > (instance->fw_crash_buffer_size * dmachunk)) {
>                 dev_err(&instance->pdev->dev,
>                         "Firmware crash dump offset is out of range\n");
> @@ -4401,7 +4398,6 @@ megasas_get_pd_list(struct megasas_instance *instance)
>         struct megasas_dcmd_frame *dcmd;
>         struct MR_PD_LIST *ci;
>         struct MR_PD_ADDRESS *pd_addr;
> -       dma_addr_t ci_h = 0;
>
>         if (instance->pd_list_not_supported) {
>                 dev_info(&instance->pdev->dev, "MR_DCMD_PD_LIST_QUERY "
> @@ -4410,7 +4406,6 @@ megasas_get_pd_list(struct megasas_instance *instance)
>         }
>
>         ci = instance->pd_list_buf;
> -       ci_h = instance->pd_list_buf_h;
>
>         cmd = megasas_get_cmd(instance);
>
> --
> 2.17.1
>
>
