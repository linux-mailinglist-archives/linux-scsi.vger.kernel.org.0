Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81804762BD
	for <lists+linux-scsi@lfdr.de>; Fri, 26 Jul 2019 11:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfGZJpn (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 26 Jul 2019 05:45:43 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39529 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfGZJpm (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 26 Jul 2019 05:45:42 -0400
Received: by mail-pl1-f195.google.com with SMTP id b7so24602907pls.6
        for <linux-scsi@vger.kernel.org>; Fri, 26 Jul 2019 02:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qnzq2Q0YbGlfFNhZtqSC3w0Tnw1+DwoITbfFNQYhaUE=;
        b=SQxS3G+oyxMJq4puZiiGpuCkDnibWSJC8ycPC+ZPww3AvXtzTKEqirbmBJa+c0gN15
         unWQC0C2OlDQ//DH3nmHrDyGz4A69KzzUxjUavmXm52zeRsm8eXxl0FgqnGHzpBV/b3K
         TK/RnIYm86DAVn7WqEMkPSwgZVpAfSZKbTi0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qnzq2Q0YbGlfFNhZtqSC3w0Tnw1+DwoITbfFNQYhaUE=;
        b=Yfrx8rQsMzR2o5FXg9lLwBIwWoF+Ms0DFgSqXjzExj59ikVtZfFMZG5nVLwF1ze1U7
         S29g3gDpYWcNuvLgXfGXX+UPqFBfPh/MIMH1dlJEFDabpoqqFmh1IouPMQ4egjRMoJdG
         WO2XB2f445dGCJPRYWALQ31rSvn87rvUVnIc83+R7Vv8F04LrtPDYEaiQaEU8gyJmBaP
         4IGggPnq8fxFBFm97ujUewJWitAUWGjOPJMNV93cTU8a4RJIVo1dBPhhjd3YqEe7sRDj
         r2KRVgOyTDD4jId3YMLx0OX3YpPAP9/5vfO48eK0AWDSiCV8ual+EB/M8K0dnD1G1Tdc
         OCBw==
X-Gm-Message-State: APjAAAXjLJXc33N/32AykDvQJ8/frzOYGaBtxiI6bF98Jy6q8CmdqQoj
        AFLHB82WYoIwE/3u/BPwtm8W83fBcqYOAstxQb3lbA==
X-Google-Smtp-Source: APXvYqxt1kUJRKm7FdK3eFBtk/7DXR7gGLY+P0CuI74bQffhUNAGnT66PoNf0y4DydTOX2D4XU9rxMMAQtoL6S+N6bY=
X-Received: by 2002:a17:902:6a2:: with SMTP id 31mr90642470plh.296.1564134342010;
 Fri, 26 Jul 2019 02:45:42 -0700 (PDT)
MIME-Version: 1.0
References: <1561558950.3435.2.camel@linux.ibm.com> <20190726065205.GA22701@mwanda>
In-Reply-To: <20190726065205.GA22701@mwanda>
From:   Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Date:   Fri, 26 Jul 2019 15:15:30 +0530
Message-ID: <CAK=zhgpjPGuzi9Af9pM8QGy2P8nCLuAvFr-DqrW4OvX7QEOs8A@mail.gmail.com>
Subject: Re: [PATCH v2] scsi: mpt3sas: clean up a couple sizeof() uses
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        PDL-MPT-FUSIONLINUX <MPT-FusionLinux.pdl@broadcom.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, Jul 26, 2019 at 12:22 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> There is a copy and paste bug here.  It uses EVENT_TRIGGERS size instead
> of SCSI_TRIGGERS size but fortunately both size are 84 bytes so it
> doesn't affect runtime.
>
> These days the prefered style is to just say sizeof(object) instead of
> sizeof(type) so I have updated the function to the latest style as well.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Sreekanth Reddy <sreekanth.reddy@broadcom.com>

> ---
> v2: Update the style to the 21st Century
>
>  drivers/scsi/mpt3sas/mpt3sas_ctl.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
> index d4ecfbbe738c..41c54d4c9451 100644
> --- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
> +++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
> @@ -3278,9 +3278,8 @@ diag_trigger_scsi_store(struct device *cdev,
>         ssize_t sz;
>
>         spin_lock_irqsave(&ioc->diag_trigger_lock, flags);
> -       sz = min(sizeof(struct SL_WH_SCSI_TRIGGERS_T), count);
> -       memset(&ioc->diag_trigger_scsi, 0,
> -           sizeof(struct SL_WH_EVENT_TRIGGERS_T));
> +       sz = min(sizeof(ioc->diag_trigger_scsi), count);
> +       memset(&ioc->diag_trigger_scsi, 0, sizeof(ioc->diag_trigger_scsi));
>         memcpy(&ioc->diag_trigger_scsi, buf, sz);
>         if (ioc->diag_trigger_scsi.ValidEntries > NUM_VALID_ENTRIES)
>                 ioc->diag_trigger_scsi.ValidEntries = NUM_VALID_ENTRIES;
> --
> 2.20.1
>
