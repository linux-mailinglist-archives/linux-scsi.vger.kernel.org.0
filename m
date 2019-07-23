Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8FA71EE5
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jul 2019 20:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388681AbfGWSQw (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 23 Jul 2019 14:16:52 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:45329 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403791AbfGWSQi (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 23 Jul 2019 14:16:38 -0400
Received: by mail-vs1-f67.google.com with SMTP id h28so29495969vsl.12
        for <linux-scsi@vger.kernel.org>; Tue, 23 Jul 2019 11:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MSkiUPoJaljsYuDHJ6lt9nP9z02pxAFNV5R95iqHyrI=;
        b=OvduF8VyLrORhFzZ1ICw0D8FhVCvU2bPRyb4Ovqq9bl4q+R6wqLjH6WHPV55cdEiI5
         zM+CE5EdZxz0bq9V7zR5EFyG0WHBWsoIopM6nOO/EJ33ylQtjloy+c6HAjHpiwbtd6S/
         7mTniaqNbKTBlMerJ3blS4uYtKo9NpbFYTNao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MSkiUPoJaljsYuDHJ6lt9nP9z02pxAFNV5R95iqHyrI=;
        b=jzdsnap2KgZyN/OpOvWrrB2LHBEd6gFM1AyNIWsjzb4O/S+5pMjixmTKIzutf2PT6f
         hyYTnZyH+Wy/2FqIYH5W0dUGJ/0SvobT1klcJKuGUCL3DnHN4r5VLWLrnwcF2lpC1Lyo
         qxrbCzeJce5YJB11aMoiuDCTMyCqclVfHrhQEl5s0AuUc2cYRQ5dE0lac4+Jc6YbNEP5
         AtC1LwpNZ5D08mcfnWkaF87LrgsRsaZG1nTPiZ9+zXjRbd4plkmCxOnB6qaIhGUdSdFl
         h6hf+6EFTtfHfNNbXE/PptQA/iY2mmzXelaLQRq7Xf48X9njWfPEnO4u+08OOER+dX5R
         2u6w==
X-Gm-Message-State: APjAAAVu0SuqU90Vk/Q+lFXyDzdJc569knnotecAuwY/5AYfNzsNtro8
        KW4WEiB3flnUYRMLPHXTOiiXylfR/bfyrle31ZRHCw==
X-Google-Smtp-Source: APXvYqyIN5bGa/H7JHUbriHAu46jJ6x4alh+YsFWKmuC9+cT9DqsufkF9rej2EVnd6D+auRAci555vkg8ezzzLV9Bds=
X-Received: by 2002:a67:c496:: with SMTP id d22mr9422716vsk.205.1563905797030;
 Tue, 23 Jul 2019 11:16:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190722161524.23192-1-junxiao.bi@oracle.com>
In-Reply-To: <20190722161524.23192-1-junxiao.bi@oracle.com>
From:   Sumit Saxena <sumit.saxena@broadcom.com>
Date:   Tue, 23 Jul 2019 23:46:25 +0530
Message-ID: <CAL2rwxoGqznXyi_bdV-ODoHE2Mhv6gT=PH=3jXkQXPnUJrEUNw@mail.gmail.com>
Subject: Re: [PATCH RESEND] scsi: megaraid_sas: fix panic on loading firmware crashdump
To:     Junxiao Bi <junxiao.bi@oracle.com>
Cc:     "PDL,MEGARAIDLINUX" <megaraidlinux.pdl@broadcom.com>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, Jul 22, 2019 at 9:45 PM Junxiao Bi <junxiao.bi@oracle.com> wrote:
>
> While loading fw crashdump in function fw_crash_buffer_show(),
> left bytes in one dma chunk was not checked, if copying size
> over it, overflow access will cause kernel panic.
>
> Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
Acked-by: Sumit Saxena <sumit.saxena@broadcom.com>
> ---
>  drivers/scsi/megaraid/megaraid_sas_base.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
> index 80ab9700f1de..3eef0858fa8e 100644
> --- a/drivers/scsi/megaraid/megaraid_sas_base.c
> +++ b/drivers/scsi/megaraid/megaraid_sas_base.c
> @@ -3153,6 +3153,7 @@ fw_crash_buffer_show(struct device *cdev,
>                 (struct megasas_instance *) shost->hostdata;
>         u32 size;
>         unsigned long dmachunk = CRASH_DMA_BUF_SIZE;
> +       unsigned long chunk_left_bytes;
>         unsigned long src_addr;
>         unsigned long flags;
>         u32 buff_offset;
> @@ -3176,6 +3177,8 @@ fw_crash_buffer_show(struct device *cdev,
>         }
>
>         size = (instance->fw_crash_buffer_size * dmachunk) - buff_offset;
> +       chunk_left_bytes = dmachunk - (buff_offset % dmachunk);
> +       size = (size > chunk_left_bytes) ? chunk_left_bytes : size;
>         size = (size >= PAGE_SIZE) ? (PAGE_SIZE - 1) : size;
>
>         src_addr = (unsigned long)instance->crash_buf[buff_offset / dmachunk] +
> --
> 2.17.1
>
