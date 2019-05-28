Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 944502BF12
	for <lists+linux-scsi@lfdr.de>; Tue, 28 May 2019 08:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfE1GKT (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 28 May 2019 02:10:19 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35642 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbfE1GKT (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 28 May 2019 02:10:19 -0400
Received: by mail-qk1-f195.google.com with SMTP id l128so7996403qke.2
        for <linux-scsi@vger.kernel.org>; Mon, 27 May 2019 23:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CfzRW4N1S5mQQ9jKEqA6Swt1CN89Kjydym5ZfJt8dUU=;
        b=iK/5LXAIuLIO1C32CYwsHjikO7+xCvRY9jx7o7UCcogfiYLbP9BacScQJmso+Ya5v1
         1HueyBOqg3TriLfytDaOTDU/ZQ5RhnvMqlhl3Gw1laySJIlHispAhgo+cGDyxZqgZqTA
         R2bTx+4lIKnCAZVuF9ZuaY/PMJ4Bx8ZktZvbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CfzRW4N1S5mQQ9jKEqA6Swt1CN89Kjydym5ZfJt8dUU=;
        b=hmD0O9zhpmPoF8gRoJAOtpd+vL8w/aWBBc9dyZU9T+sQZzAoQqeDj5nWeVxBPEStPq
         3S/D7/Kxq7VViZZWSAkvlS2KRmG/hUU/fyM3fTTNpC7FCcn1F2kcz50Lhi9h8/dpzECK
         wVXT7BHoieZ442XTAlkicQ0wYFci3VkCNdXzheLWP900lpLB8jhSCNRFIOYDlX6+Wwe1
         R/BAyNAyEZLYIIX1WzEMPDG6fpEmy0o/PT3eZLR8yp2r3Vcr4TX2P1jexHiHtV4Z6E27
         /PxTANXgdEg72WFRnxJ9wDFFZJQJgohnBwlSOGEebV4dpZDMGWkEhGXbs0+vJWSX8lQF
         /Ulw==
X-Gm-Message-State: APjAAAVH6gNKeNOZrYNVcFDNhifHdfjZAIkRYm2mcwNZ2eLentX+xQNY
        uPUqBMHrvFoQL35GcdrfOjssar8UewvxAvWcGqCNHg==
X-Google-Smtp-Source: APXvYqxetHiiu8ZvaIWpXnfgto8rpHgFK3rGPtRdFeHg6oQR0w7N9F6nCetysUy/ssRqnaMDZXZDfsQ8gOXd3N9x6Ys=
X-Received: by 2002:ac8:3861:: with SMTP id r30mr4820195qtb.341.1559023818442;
 Mon, 27 May 2019 23:10:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190527005716.GA17015@zhanggen-UX430UQ>
In-Reply-To: <20190527005716.GA17015@zhanggen-UX430UQ>
From:   Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Date:   Tue, 28 May 2019 11:44:35 +0530
Message-ID: <CA+RiK64ddLM1Uhp_neqaX3HeaGqn-b=MgK3fGzXnee-o3SAVdg@mail.gmail.com>
Subject: Re: [PATCH] mpt3sas_ctl: fix double-fetch bug in _ctl_ioctl_main()
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Sathya Prakash <sathya.prakash@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        PDL-MPT-FUSIONLINUX <MPT-FusionLinux.pdl@broadcom.com>,
        Gen Zhang <blackgod016574@gmail.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Please consider this patch as Ack-by: Suganath Prabu S
<suganath-prabu.subramani@broadcom.com>

Thanks,
Suganath.


On Mon, May 27, 2019 at 6:27 AM Gen Zhang <blackgod016574@gmail.com> wrote:
>
> In _ctl_ioctl_main(), 'ioctl_header' is fetched the first time from
> userspace. 'ioctl_header.ioc_number' is then checked. The legal result
> is saved to 'ioc'. Then, in condition MPT3COMMAND, the whole struct is
> fetched again from the userspace. Then _ctl_do_mpt_command() is called,
> 'ioc' and 'karg' as inputs.
>
> However, a malicious user can change the 'ioc_number' between the two
> fetches, which will cause a potential security issues.  Moreover, a
> malicious user can provide a valid 'ioc_number' to pass the check in
> first fetch, and then modify it in the second fetch.
>
> To fix this, we need to recheck the 'ioc_number' in the second fetch.
>
> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> ---
> diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
> index b2bb47c..5181c03 100644
> --- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
> +++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
> @@ -2319,6 +2319,10 @@ _ctl_ioctl_main(struct file *file, unsigned int cmd, void __user *arg,
>                         break;
>                 }
>
> +               if (karg.hdr.ioc_number != ioctl_header.ioc_number) {
> +                       ret = -EINVAL;
> +                       break;
> +               }
>                 if (_IOC_SIZE(cmd) == sizeof(struct mpt3_ioctl_command)) {
>                         uarg = arg;
>                         ret = _ctl_do_mpt_command(ioc, karg, &uarg->mf);
