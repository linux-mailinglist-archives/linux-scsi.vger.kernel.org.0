Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3688290A
	for <lists+linux-scsi@lfdr.de>; Tue,  6 Aug 2019 03:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731063AbfHFBKN (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 5 Aug 2019 21:10:13 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38055 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728851AbfHFBKN (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 5 Aug 2019 21:10:13 -0400
Received: by mail-wm1-f65.google.com with SMTP id s15so53355908wmj.3
        for <linux-scsi@vger.kernel.org>; Mon, 05 Aug 2019 18:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3OMtWao6LHSslOs2swh9faCSlPyzi0Y8bzAOp4d8kMM=;
        b=Jd9d9Js8w2/5k1BWxQv8SQv316mObfVf6JDARWtVLihSlcg6AFa8cgDyi/VXg8M0f8
         M0et3rtnkb/JxG5u8s/I1pagmK/0NfDDoohmlRXv4Zm/O5FmQ9QwtD+eMm7pX6UstuvL
         c8xfAYOGnNKPtZj3ewF1UNkNx0MWxSNShARaq36dv3t8dHON73qFntZ58f9KjcWg08kA
         xipCEzQPi9s9/kkkaogx701kR7Uwru3un26pl3x0T8+6K/excTQ8lwzCOuw7rnf14Rn8
         YEORpogxOlyHlUXkCr/m3w+kOHaYO2sHCl/FxIHsDu+NLaTaqImT7O9lbN3nyrOsMMv8
         eKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3OMtWao6LHSslOs2swh9faCSlPyzi0Y8bzAOp4d8kMM=;
        b=ICDT1f2DyukCtz6I5/VYPB83++/s/xAtqrO7OZ3As3XYDrJjExJt5/Ru1NenwnjDT+
         ZONfUS7DqQmUSoO8EBWFJdr3zrxdXQ4MIxHTH7x2ev9AzUSpG5wGntYK9JTKXzCPH1C/
         RGojMxZuGN80MDsBbZpyfSI/PibpFOnUdxXMbc9FKWHHrvvixMZw/GvpNecPaeyzEN/X
         BOGzMjq0DSyMug4d2RuIVfMwxFqBdxeyWJTc4nFk8LlRVHlqgSxddk0b+Xpyw+9S1x1B
         h0DwPzLLT4K4Ly3OV6BVqBnG/t+491P4W/0K8K4/MqFf0U6XLfjWeSwuikHJ3vubK4f9
         7kCQ==
X-Gm-Message-State: APjAAAU9yE3ixOXRm+If/Fodv/3HxxIk1UKShbeYEs6MBxcHQ0uqKDdn
        K9h/N2OQXTm3+xiI6GqsTE/AOiKEdO+1R1hu0WQ=
X-Google-Smtp-Source: APXvYqxyR5fsCDOsLhMNoa6aJvq6dWY2srm0wpnzfpZqa+ESIMUtP+z8sCsQw4Hig0MDaJ3j7bHcebxpkyD31L4F+RY=
X-Received: by 2002:a05:600c:204c:: with SMTP id p12mr787693wmg.121.1565053810593;
 Mon, 05 Aug 2019 18:10:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190801220941.19615-1-jsmart2021@gmail.com>
In-Reply-To: <20190801220941.19615-1-jsmart2021@gmail.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Tue, 6 Aug 2019 09:09:58 +0800
Message-ID: <CACVXFVO7vmGJj_N_MT7roZDmWNHbEGR=MsOqkpb7NTptF3=DOw@mail.gmail.com>
Subject: Re: [PATCH v2] lpfc: Mitigate high memory pre-allocation by SCSI-MQ
To:     James Smart <jsmart2021@gmail.com>
Cc:     Linux SCSI List <linux-scsi@vger.kernel.org>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, Aug 2, 2019 at 6:09 AM James Smart <jsmart2021@gmail.com> wrote:
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

I guess the numa node number is 4 in your test machine. Per my observation,
the performance is often very close if the hw queue count is set as numa node
number.

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
> CC: Ming Lei <tom.leiming@gmail.com>
>
> ---
> v2:
>   revised to set nr_hw_queues to minimum of 2 per numa node or
>       max value specified by module parameter.
>   raised default value for module parameter to 8.
> ---
>  drivers/scsi/lpfc/lpfc.h      |  1 +
>  drivers/scsi/lpfc/lpfc_attr.c | 15 +++++++++++++++
>  drivers/scsi/lpfc/lpfc_init.c | 10 ++++++----
>  drivers/scsi/lpfc/lpfc_sli4.h |  5 +++++
>  4 files changed, 27 insertions(+), 4 deletions(-)
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
> index ea62322ffe2b..8d8c495b5b60 100644
> --- a/drivers/scsi/lpfc/lpfc_attr.c
> +++ b/drivers/scsi/lpfc/lpfc_attr.c
> @@ -5709,6 +5709,19 @@ LPFC_ATTR_RW(nvme_embed_cmd, 1, 0, 2,
>              "Embed NVME Command in WQE");
>
>  /*
> + * lpfc_fcp_mq_threshold: Set the maximum number of Hardware Queues
> + * the driver will advertise it supports to the SCSI layer.
> + *
> + *      0    = Set nr_hw_queues by the number of CPUs or HW queues.
> + *      1,128 = Manually specify the maximum nr_hw_queue value to be set,
> + *
> + * Value range is [0,128]. Default value is 8.
> + */
> +LPFC_ATTR_R(fcp_mq_threshold, LPFC_FCP_MQ_THRESHOLD_DEF,
> +           LPFC_FCP_MQ_THRESHOLD_MIN, LPFC_FCP_MQ_THRESHOLD_MAX,
> +           "Set the number of SCSI Queues advertised");
> +
> +/*
>   * lpfc_hdw_queue: Set the number of Hardware Queues the driver
>   * will advertise it supports to the NVME and  SCSI layers. This also
>   * will map to the number of CQ/WQ pairs the driver will create.
> @@ -6030,6 +6043,7 @@ struct device_attribute *lpfc_hba_attrs[] = {
>         &dev_attr_lpfc_cq_poll_threshold,
>         &dev_attr_lpfc_cq_max_proc_limit,
>         &dev_attr_lpfc_fcp_cpu_map,
> +       &dev_attr_lpfc_fcp_mq_threshold,
>         &dev_attr_lpfc_hdw_queue,
>         &dev_attr_lpfc_irq_chann,
>         &dev_attr_lpfc_suppress_rsp,
> @@ -7112,6 +7126,7 @@ lpfc_get_cfgparam(struct lpfc_hba *phba)
>         /* Initialize first burst. Target vs Initiator are different. */
>         lpfc_nvme_enable_fb_init(phba, lpfc_nvme_enable_fb);
>         lpfc_nvmet_fb_size_init(phba, lpfc_nvmet_fb_size);
> +       lpfc_fcp_mq_threshold_init(phba, lpfc_fcp_mq_threshold);
>         lpfc_hdw_queue_init(phba, lpfc_hdw_queue);
>         lpfc_irq_chann_init(phba, lpfc_irq_chann);
>         lpfc_enable_bbcr_init(phba, lpfc_enable_bbcr);
> diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
> index faf43b1d3dbe..03998579d6ee 100644
> --- a/drivers/scsi/lpfc/lpfc_init.c
> +++ b/drivers/scsi/lpfc/lpfc_init.c
> @@ -4309,10 +4309,12 @@ lpfc_create_port(struct lpfc_hba *phba, int instance, struct device *dev)
>         shost->max_cmd_len = 16;
>
>         if (phba->sli_rev == LPFC_SLI_REV4) {
> -               if (phba->cfg_fcp_io_sched == LPFC_FCP_SCHED_BY_HDWQ)
> -                       shost->nr_hw_queues = phba->cfg_hdw_queue;
> -               else
> -                       shost->nr_hw_queues = phba->sli4_hba.num_present_cpu;
> +               if (!phba->cfg_fcp_mq_threshold ||
> +                   phba->cfg_fcp_mq_threshold > phba->cfg_hdw_queue)
> +                       phba->cfg_fcp_mq_threshold = phba->cfg_hdw_queue;
> +
> +               shost->nr_hw_queues = min_t(int, 2 * num_possible_nodes(),
> +                                           phba->cfg_fcp_mq_threshold);

Hi James,

I am wondering why you use 2 * num_possible_nodes() as the limit instead of
num_possible_nodes(), could you explain it a bit?

Thanks,
Ming Lei
