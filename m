Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBA8082C46
	for <lists+linux-scsi@lfdr.de>; Tue,  6 Aug 2019 09:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732027AbfHFHF7 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 6 Aug 2019 03:05:59 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:34685 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731807AbfHFHF5 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 6 Aug 2019 03:05:57 -0400
Received: by mail-vs1-f65.google.com with SMTP id m23so57681493vso.1
        for <linux-scsi@vger.kernel.org>; Tue, 06 Aug 2019 00:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nvNLdWRzNCcP/1tMguZTrB/Ret9xhkOHTVDfmzeadKU=;
        b=cBNuGU4Dr8PNxOG4ZXsD1SeAcDdS2PkACRvfDIJni+NMYiI6xg8Z3QBrHu8RM3OnDB
         8wnSQRm1UoqZt/3vMiKQ90iQxecWGqvo0J+py/fnUuxiWlqxMkXHQhOG0x85badHtAHY
         ZreuyxdeX5OU0y20ts8cmzeJZgM3pv7EjchVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nvNLdWRzNCcP/1tMguZTrB/Ret9xhkOHTVDfmzeadKU=;
        b=H0aR2MXqURVoxEmZ04ZK4mT5c4t4ejAjfembV5+5VP8SK052OLe7x7NA9cq0CHI+qf
         Io7okq+miNgkDoOaMkYguc8rD+csGB6jvihcCnDQll7vIvOu8WUaL4t2F/u64pbLcKKU
         APFlOYtVAAQ79ut1NMImIgtXmCZ2NvHirbn6bAPGj+SSVVhwZpQF2H5jbPkEv8Apwe8Q
         Bv5UvdAcuZUBmczykGNgVo3s5J2I7TNRcFnSfB8hB+YwhAgwMvq2/9grgXbHQfblN6CL
         aZ2CJtt3CmQ51IsxzY74MIghQ1TlEPr/hsCIz+BIMMLuSSqkRHkNjepp0QzK2X/71+GE
         Lr/g==
X-Gm-Message-State: APjAAAXuyC1NNZlprFnfa3Cp684KgZNiSagCRcA6v1RqmygNvVjMMt2Z
        NbrxKVeboCNrihoBiUzB32P+TU186nJxz0g0dM+8+Q==
X-Google-Smtp-Source: APXvYqwYKN6dkaPv4TtdWshELFYcyApVXP7DfanyMLNrK7YPEHywULSCcTgrkVrXVdFSaMz6ImBxPm40vHRDi0p9GHg=
X-Received: by 2002:a67:f355:: with SMTP id p21mr1369725vsm.204.1565075156521;
 Tue, 06 Aug 2019 00:05:56 -0700 (PDT)
MIME-Version: 1.0
References: <1564151143-22889-1-git-send-email-cai@lca.pw>
In-Reply-To: <1564151143-22889-1-git-send-email-cai@lca.pw>
From:   Sumit Saxena <sumit.saxena@broadcom.com>
Date:   Tue, 6 Aug 2019 12:35:45 +0530
Message-ID: <CAL2rwxpSNMDUD3gRwXmuMZ2ZMjAOdg=ebprhB2v3n8f+Z4AcxA@mail.gmail.com>
Subject: Re: [PATCH] scsi/megaraid_sas: fix a compilation warning
To:     Qian Cai <cai@lca.pw>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>,
        "PDL,MEGARAIDLINUX" <megaraidlinux.pdl@broadcom.com>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, Jul 26, 2019 at 7:55 PM Qian Cai <cai@lca.pw> wrote:
>
> The commit de516379e85f ("scsi: megaraid_sas: changes to function
> prototypes") introduced a comilation warning due to it changed the
> function prototype of read_fw_status_reg() to take an instance pointer
> instead, but forgot to remove an unused variable.
>
> drivers/scsi/megaraid/megaraid_sas_fusion.c: In function
> 'megasas_fusion_update_can_queue':
> drivers/scsi/megaraid/megaraid_sas_fusion.c:326:39: warning: variable
> 'reg_set' set but not used [-Wunused-but-set-variable]
>   struct megasas_register_set __iomem *reg_set;
>                                        ^~~~~~~
> Fixes: de516379e85f ("scsi: megaraid_sas: changes to function prototypes")
> Signed-off-by: Qian Cai <cai@lca.pw>
Acked-by: Sumit Saxena <sumit.saxena@broadcom.com>
> ---
>  drivers/scsi/megaraid/megaraid_sas_fusion.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
> index a32b3f0fcd15..e8092d59d575 100644
> --- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
> +++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
> @@ -323,9 +323,6 @@ inline void megasas_return_cmd_fusion(struct megasas_instance *instance,
>  {
>         u16 cur_max_fw_cmds = 0;
>         u16 ldio_threshold = 0;
> -       struct megasas_register_set __iomem *reg_set;
> -
> -       reg_set = instance->reg_set;
>
>         /* ventura FW does not fill outbound_scratch_pad_2 with queue depth */
>         if (instance->adapter_type < VENTURA_SERIES)
> --
> 1.8.3.1
>
