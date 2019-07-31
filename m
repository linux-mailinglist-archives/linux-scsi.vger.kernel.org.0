Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B362B7B801
	for <lists+linux-scsi@lfdr.de>; Wed, 31 Jul 2019 04:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfGaCbp (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 30 Jul 2019 22:31:45 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43590 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfGaCbo (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 30 Jul 2019 22:31:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id p13so67838347wru.10
        for <linux-scsi@vger.kernel.org>; Tue, 30 Jul 2019 19:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mK5awaGODBitIbEv1ECjc6oodMU3pryVoINMLbed2tA=;
        b=ubrxWUoO0vQWTAJ66pFXPS0H4rV5TvtuNOv4FTfU3VSB3gy8E2p8tBqVec5IZXL90T
         9gZeAgbkzWRujgv4IPEs+IdghGUzEpST3hyhlgWg5sqI+5UL70NPQMqeRyXtENHODUR7
         yo47TUpOyIoFA3wukKpzH4B1glZ0PWh+sft5oFKhPguHqMdwmnbeWzaD5hO4lXLJCpho
         6BIg8WwU8S/Zm60eXymyK2OZ2UtVRt6QSL5X6n9G4DCTO/nkLxwSUE44MP4q57awaTiN
         atRZTcaJgFXX5uCGKKnbu9ipWDah9MQFPQEwSfpuNLx42qZ7C9cUtLeTeP0uE6A+lfYe
         LZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mK5awaGODBitIbEv1ECjc6oodMU3pryVoINMLbed2tA=;
        b=or7veyoJK93aMzeDN/PwI07XreCqvZMnI3zwC64l5y7+zmqZkzmBhSYP5pQZFBd+m1
         BKGniacVJVhbLqIG234TajYr8PrlzIHD+gvQBxwqjxGbjMsMdioGJjM3QtqdZgDnrBU4
         svGNB+bZMJPHNC3HUFeOUM7z0goUJWb/vPkrF1GLpUhgxDXHCACl8M/Q1Mhjs2QMVWgv
         NpIPGRrazNwnFHS3qP+VisQoB+/o7yoXpb/GsvnCUjei/eAEweKZWVt7rgUlAQmG6v/P
         1XcMl/IU6bq6D/mXFm1gcUHlEdPQgBgScB4ZT1gA6itWdWlvKdmHYRiFdTK7oV5uT1uZ
         pi+Q==
X-Gm-Message-State: APjAAAX72IpIfhbghup1CZvMKiJNAYMrNaWDXNcac0Y4nigEqobMCWLL
        AI3g9/wT2rWVVwgQmDo8Y55iWAztl4Ck8QgHB2K2+gBHFvg=
X-Google-Smtp-Source: APXvYqyXKGzaUQeaIhsF1eV7B/anX/THEmCHj00OuRe9qYYlMCjyD9jEUYTHU7kHWNlNYqRwS56caiLrkcTLj3+7UzY=
X-Received: by 2002:adf:e4c6:: with SMTP id v6mr124431035wrm.315.1564540302162;
 Tue, 30 Jul 2019 19:31:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190731000759.6272-1-jsmart2021@gmail.com>
In-Reply-To: <20190731000759.6272-1-jsmart2021@gmail.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Wed, 31 Jul 2019 10:31:30 +0800
Message-ID: <CACVXFVOSWQDvaeSJ_UFxB7pS=6QvTVhL0-MdTTcd1yWNWFAomA@mail.gmail.com>
Subject: Re: [PATCH] lpfc: Mitigate high memory pre-allocation by SCSI-MQ
To:     James Smart <jsmart2021@gmail.com>
Cc:     Linux SCSI List <linux-scsi@vger.kernel.org>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Jul 31, 2019 at 8:24 AM James Smart <jsmart2021@gmail.com> wrote:
>
> When SCSI-MQ is enabled, the SCSI-MQ layers will do pre-allocation of
> MQ resources based on shost values set by the driver. In newer cases
> of the driver, which attempts to set nr_hw_queues to the cpu count,
> the multipliers become excessive, with a single shost having SCSI-MQ
> pre-allocation reaching into the multiple GBytes range.  NPIV, which
> creates additional shosts, only multiply this overhead. On lower-memory
> systems, this can exhaust system memory very quickly, resulting in a
> system crash or failures in the driver or elsewhere due to low memory
> conditions.
>
> After testing several scenarios, the situation can be mitigated by
> limiting the value set in shost->nr_hw_queues to 4. Although the shost
> values were changed, the driver still had per-cpu hardware queues of
> its own that allowed parallelization per-cpu.  Testing revealed that
> even with the smallish number for nr_hw_queues for SCSI-MQ, performance
> levels remained near maximum with the within-driver affiinitization.
>
> A module parameter was created to allow the value set for the
> nr_hw_queues to be tunable.
>
> Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> ---
>  drivers/scsi/lpfc/lpfc.h      |  1 +
>  drivers/scsi/lpfc/lpfc_attr.c | 17 +++++++++++++++++
>  drivers/scsi/lpfc/lpfc_init.c | 12 ++++++++----
>  drivers/scsi/lpfc/lpfc_sli4.h |  5 +++++
>  4 files changed, 31 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
> index 2c3bb8a966e5..bade2e025ecf 100644
> --- a/drivers/scsi/lpfc/lpfc.h
> +++ b/drivers/scsi/lpfc/lpfc.h
> @@ -824,6 +824,7 @@ struct lpfc_hba {
>         uint32_t cfg_cq_poll_threshold;
>         uint32_t cfg_cq_max_proc_limit;
>         uint32_t cfg_fcp_cpu_map;
> +       uint32_t cfg_fcp_mq_threshold;
>         uint32_t cfg_hdw_queue;
>         uint32_t cfg_irq_chann;
>         uint32_t cfg_suppress_rsp;
> diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
> index ea62322ffe2b..d267f57d1738 100644
> --- a/drivers/scsi/lpfc/lpfc_attr.c
> +++ b/drivers/scsi/lpfc/lpfc_attr.c
> @@ -5709,6 +5709,19 @@ LPFC_ATTR_RW(nvme_embed_cmd, 1, 0, 2,
>              "Embed NVME Command in WQE");
>
>  /*
> + * lpfc_fcp_mq_threshold: Set the number of Hardware Queues the driver
> + * will advertise it supports to the SCSI layer.
> + *
> + *      0    = Configure nr_hw_queues by the number of CPUs or HW queues.
> + *      1,128 = Manually specify nr_hw_queue value to be advertised,
> + *
> + * Value range is [0,128]. Default value is 4.
> + */
> +LPFC_ATTR_R(fcp_mq_threshold, LPFC_FCP_MQ_THRESHOLD_DEF,
> +           LPFC_FCP_MQ_THRESHOLD_MIN, LPFC_FCP_MQ_THRESHOLD_MAX,
> +           "Set the number of SCSI Queues advertised");

Hi James,

Could the default hw queue count be set as numa node number? This way
should work
fine most of times.

Thanks,
Ming Lei
