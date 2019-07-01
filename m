Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD1E43D06
	for <lists+linux-scsi@lfdr.de>; Thu, 13 Jun 2019 17:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732177AbfFMPi7 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 13 Jun 2019 11:38:59 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:38047 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731939AbfFMJ5q (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 13 Jun 2019 05:57:46 -0400
Received: by mail-vs1-f68.google.com with SMTP id k9so3087129vso.5
        for <linux-scsi@vger.kernel.org>; Thu, 13 Jun 2019 02:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xbxjq+/UWnkmz/Lz2NuZarwVK3ifkKHPS3ppszMgh6E=;
        b=fEqFpleuGhOamNp5m2EH71DOiuFlFeO8LAoM/7Lp8TSo2eVpZ9KPxeKGpTLl5GjcwV
         S3d/AsmOzAXn2VmPPGGFecfnZaHbXbcxYJ+UVbXEz+fkjYrgIs2yGsUVg9uCX7fQmPrd
         Vshj30LgbeysHLD1OUon+3yIb+M7yDp2isl3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xbxjq+/UWnkmz/Lz2NuZarwVK3ifkKHPS3ppszMgh6E=;
        b=Qde7uG6JCTDZzK+T30ga+45KC05o6uNYLe/5tTWIeQ9sYTGAd57aFZDM1u0rAkn/2m
         KEZK0lH2Yp55GFpETqjDKKaKqE7z7KoXY6KXBhaWE6PJPzvahUseTDs9Bc1L8MMPvpT+
         a7Ptw2Q/0SHRjm2GDaddeFTSLkzs6yjwSwF9pRGF8avbiyY13cnxJhVD4CN3SM5EexWV
         Ea4x6qccGSSZGolZDZ6u4mpBvuWVjuGDdZuPLVDHzyvvM7wxEhRXBoXnNnHOnPj4d80T
         FpkvwDDa2SXPEq5TUTgkBoPJ1UnLW9ZD4M7xKdoAKFDZGpMec6rSiUumkZG6SVvFq5b5
         GxRA==
X-Gm-Message-State: APjAAAWcVD/CPorlaZIlJVTkxuXf7jc0KGT3TAEPxjDFB+lbTxJJyQIK
        eUFDgmRiNKeyGrhHOFMrsoFMoBF+vvG0TMGVang3iA==
X-Google-Smtp-Source: APXvYqy8eW2B7bGa1hDxGrsKEeZEhxQC13lqGDOpm+tCyesLdD1fgE55BDfcTpopDHtmpo3xBKwWIrlu4iHQQYmeJtk=
X-Received: by 2002:a67:ebcb:: with SMTP id y11mr8620799vso.138.1560419865266;
 Thu, 13 Jun 2019 02:57:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190607184053.GA11513@embeddedor>
In-Reply-To: <20190607184053.GA11513@embeddedor>
From:   Sumit Saxena <sumit.saxena@broadcom.com>
Date:   Thu, 13 Jun 2019 15:27:33 +0530
Message-ID: <CAL2rwxpUyVE5T2QBT7ze5QoeH3KgkXCWPwjgQKuAUrd4VxHEOg@mail.gmail.com>
Subject: Re: [PATCH] scsi: megaraid_sas: Use struct_size() helper
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "PDL,MEGARAIDLINUX" <megaraidlinux.pdl@broadcom.com>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sat, Jun 8, 2019 at 12:10 AM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
>
> struct MR_PD_CFG_SEQ_NUM_SYNC {
>         ...
>         struct MR_PD_CFG_SEQ seq[1];
> } __packed;
>
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes.
>
> So, replace the following form:
>
> sizeof(struct MR_PD_CFG_SEQ_NUM_SYNC) + (sizeof(struct MR_PD_CFG_SEQ) * (MAX_PHYSICAL_DEVICES - 1))
>
> with:
>
> struct_size(pd_sync, seq, MAX_PHYSICAL_DEVICES - 1)
>
> This code was detected with the help of Coccinelle.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Acked-by: Sumit Saxena <sumit.saxena@broadcom.com>

> ---
>  drivers/scsi/megaraid/megaraid_sas_fusion.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
> index a25b6b4b6548..56bd524dddbf 100644
> --- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
> +++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
> @@ -1191,7 +1191,7 @@ megasas_ioc_init_fusion(struct megasas_instance *instance)
>  int
>  megasas_sync_pd_seq_num(struct megasas_instance *instance, bool pend) {
>         int ret = 0;
> -       u32 pd_seq_map_sz;
> +       size_t pd_seq_map_sz;
>         struct megasas_cmd *cmd;
>         struct megasas_dcmd_frame *dcmd;
>         struct fusion_context *fusion = instance->ctrl_context;
> @@ -1200,9 +1200,7 @@ megasas_sync_pd_seq_num(struct megasas_instance *instance, bool pend) {
>
>         pd_sync = (void *)fusion->pd_seq_sync[(instance->pd_seq_map_id & 1)];
>         pd_seq_h = fusion->pd_seq_phys[(instance->pd_seq_map_id & 1)];
> -       pd_seq_map_sz = sizeof(struct MR_PD_CFG_SEQ_NUM_SYNC) +
> -                       (sizeof(struct MR_PD_CFG_SEQ) *
> -                       (MAX_PHYSICAL_DEVICES - 1));
> +       pd_seq_map_sz = struct_size(pd_sync, seq, MAX_PHYSICAL_DEVICES - 1);
>
>         cmd = megasas_get_cmd(instance);
>         if (!cmd) {
> --
> 2.21.0
>
