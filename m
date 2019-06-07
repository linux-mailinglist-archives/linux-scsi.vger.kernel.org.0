Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB183845F
	for <lists+linux-scsi@lfdr.de>; Fri,  7 Jun 2019 08:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfFGGgO (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 7 Jun 2019 02:36:14 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:34846 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbfFGGgN (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 7 Jun 2019 02:36:13 -0400
Received: by mail-vs1-f65.google.com with SMTP id u124so535646vsu.2
        for <linux-scsi@vger.kernel.org>; Thu, 06 Jun 2019 23:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wUw9ISMPGHSgRh2KdM2HGIT34kJ3x6jiWvQJ3Y7JEOw=;
        b=ZIENBkuV+65B17001zA6jR4EfLu0gUD5mQO9Uehe+MYtDvP7sg6FaHCpOTZn0V7moO
         aeQeggPButGXdlh3l+1CJ0LRez4REvNOPCkvZfM0rdwngG6OTerORMZoab7XIizXIDdf
         VCk2Ekwn0j6PHyUBOsWjmlyOjzKJU2vVWjdPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wUw9ISMPGHSgRh2KdM2HGIT34kJ3x6jiWvQJ3Y7JEOw=;
        b=rFTyDl5G/42+0QQ4byHiJWPp8XKxBls2GhIKe8+djq1lWujDmNaEKGwzKIqpb/0T5H
         2NrGDr9sycTD5OYlYaN4eZNG4R7TsvGk8DrdlFhfXluz/7NVJ9CgWB67sXQ9RqMDwo6M
         3jMnmQP+UdoVqiEJllrZ4tIrkyDFb3fmI9pBDW844lkkgel54u2FQS9i7BQl6hPWobkr
         pclhistYil+m/FDFZZqGRFhg7nCAYJqCFuZHvzTTbtwE/lZBRMP3VhpvvkqQZYVfRYb/
         t8+p2yc3sduJnjl1A/RFLPKISpjsDnOJcYlFTqOb0vxuYxpEhdOCWhlhN7dkWRHTiyth
         lbjA==
X-Gm-Message-State: APjAAAUoCJCYK9UUXxToNr0xvFMY0jA4k3WpuPQutxDKEhL0Ujtbq6uO
        CaedRVSOlCK/xzp3OShrNmlFuRh1VoV3KTeJKzJNcw==
X-Google-Smtp-Source: APXvYqw9TJz+d26iMe8IX5YhwPQItF/uBMG5lcq6EkUJxtv8WLmxNcmMsoJw1P0kitqbTkvFQVVSXTEFjJuWpguXvAk=
X-Received: by 2002:a67:ebcb:: with SMTP id y11mr476318vso.138.1559889372706;
 Thu, 06 Jun 2019 23:36:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190525123705.8588-1-yuehaibing@huawei.com>
In-Reply-To: <20190525123705.8588-1-yuehaibing@huawei.com>
From:   Sumit Saxena <sumit.saxena@broadcom.com>
Date:   Fri, 7 Jun 2019 12:06:01 +0530
Message-ID: <CAL2rwxroDkKSRCN9inYZTGD79h+8AWn6LO3+=ND316=BVm40ug@mail.gmail.com>
Subject: Re: [PATCH -next] scsi: megaraid_sas: remove set but not used
 variable 'sge_sz'
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

On Sat, May 25, 2019 at 6:07 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/scsi/megaraid/megaraid_sas_base.c: In function megasas_create_frame_pool:
> drivers/scsi/megaraid/megaraid_sas_base.c:4124:6: warning: variable sge_sz set but not used [-Wunused-but-set-variable]
>
> It's not used any more since
> commit 200aed582d61 ("megaraid_sas: endianness related bug fixes and code optimization")
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Sumit Saxena <sumit.saxena@broadcom.com>

> ---
>  drivers/scsi/megaraid/megaraid_sas_base.c | 11 -----------
>  1 file changed, 11 deletions(-)
>
> diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
> index b26991dcf137..25281a2eb424 100644
> --- a/drivers/scsi/megaraid/megaraid_sas_base.c
> +++ b/drivers/scsi/megaraid/megaraid_sas_base.c
> @@ -4121,22 +4121,11 @@ static int megasas_create_frame_pool(struct megasas_instance *instance)
>  {
>         int i;
>         u16 max_cmd;
> -       u32 sge_sz;
>         u32 frame_count;
>         struct megasas_cmd *cmd;
>
>         max_cmd = instance->max_mfi_cmds;
>
> -       /*
> -        * Size of our frame is 64 bytes for MFI frame, followed by max SG
> -        * elements and finally SCSI_SENSE_BUFFERSIZE bytes for sense buffer
> -        */
> -       sge_sz = (IS_DMA64) ? sizeof(struct megasas_sge64) :
> -           sizeof(struct megasas_sge32);
> -
> -       if (instance->flag_ieee)
> -               sge_sz = sizeof(struct megasas_sge_skinny);
> -
>         /*
>          * For MFI controllers.
>          * max_num_sge = 60
> --
> 2.17.1
>
>
