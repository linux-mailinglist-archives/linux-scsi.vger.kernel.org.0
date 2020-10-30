Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D81629FE7C
	for <lists+linux-scsi@lfdr.de>; Fri, 30 Oct 2020 08:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725790AbgJ3HfC (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 30 Oct 2020 03:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgJ3HfC (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 30 Oct 2020 03:35:02 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD57C0613CF
        for <linux-scsi@vger.kernel.org>; Fri, 30 Oct 2020 00:35:00 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id w1so4464494edv.11
        for <linux-scsi@vger.kernel.org>; Fri, 30 Oct 2020 00:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Oa8yKAntXqZUyms0Fw59tJYgGH2ITryrxLj9SlCJWY0=;
        b=T59CBVD+pFU2t1dwEIg63EUCGjQmTR/vQRYsnEegyENxm2kDLBo/YBXOLzKET3/ufC
         SYFExX++9jZyvzaUbgwpMApkeCNdz9cY3W7W3RGJ+pc+RJGfRTx/cBzKJ2N2ColKuQ5X
         7kjnpKWI97Kij7iu3X2fTNtrziucgQCMwCSqWGI3K1I0mRjbknn7pxVW68SnbheSIrzO
         8PFNCyGHTcGrvScqlad+HcbM/5Z0hJ9HkMfcyEU+gZK5XuOzgB+Oe+hgWfXjG7ipH7TM
         TDnTBoQ7g1/M0kF30osLXw+DV0WbTcKHBfmGPWyIMk/zftwYTPCSWCgw8n8T5PwRvc+U
         Bmsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oa8yKAntXqZUyms0Fw59tJYgGH2ITryrxLj9SlCJWY0=;
        b=GJz5flT8qpMVIt3QYYKMSc41LUzo+p7pDR3KUYKMcBLx6DzWGElvv9KwzTkCqRzovQ
         y0/kLUFVF7ToQGjL055Xa+tdmvqqUsa2C+XHeILE4JXCxkEzxsNbnI7EUBI32w+yrkVa
         PY/19NTnCGs3Z2Wsp/CGVSk1Yqr5LMJg3pZv6X+5VtIUaopZ/hQANO09ZFOr3REgWlAE
         hk65RdBts/y2niOf/Mti/9fRl2uOU8IWU50SaxOZhKCC5aVyBf8+7TfKSeLYgqE0lbSO
         5tZop0yD+dWpw3/5T4raprsOmKtRlAJYx72uiomOBOM+UvyNYKlhR4V9tC3CIkt5oB7c
         qdcw==
X-Gm-Message-State: AOAM530rTOQJP3mUV9+Gl1+k39xqEbGB4d1woJJmR1h1ktG5WAefFvv9
        YEb+6OlQt6FzDnAE7+MLIk8TfBu7yYis5NawjOJa+Q==
X-Google-Smtp-Source: ABdhPJy0SvD+QW5xg/Mt8ZR9n9OOrI75GPJWuOdSE+L1yEFAumwuMhKFmFNrxIlw/VIfTSenEt95caxSpawETgYxJ5s=
X-Received: by 2002:a05:6402:3056:: with SMTP id bu22mr902424edb.252.1604043298603;
 Fri, 30 Oct 2020 00:34:58 -0700 (PDT)
MIME-Version: 1.0
References: <20201030060913.14886-1-Viswas.G@microchip.com.com> <20201030060913.14886-3-Viswas.G@microchip.com.com>
In-Reply-To: <20201030060913.14886-3-Viswas.G@microchip.com.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Fri, 30 Oct 2020 08:34:47 +0100
Message-ID: <CAMGffE=Y-ZTd3BSAATPBYUMFM5XkjmFrDNBXyW0LPuDEBv04PQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/4] pm80xx: make running_req atomic.
To:     Viswas G <Viswas.G@microchip.com.com>
Cc:     Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        Vasanthalakshmi.Tharmarajan@microchip.com,
        Viswas G <Viswas.G@microchip.com>, Ruksar.devadi@microchip.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        yuuzheng@google.com, vishakhavc@google.com,
        Radha Ramachandran <radha@google.com>, akshatzen@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, Oct 30, 2020 at 6:59 AM Viswas G <Viswas.G@microchip.com.com> wrote:
>
> From: Viswas G <Viswas.G@microchip.com>
>
> Incorrect value of the running_req was causing the driver unload
> to be stuck during the sas lldd_dev_gone notification handling.
> During sata IO completion, for some of the error status, driver
> is scheduling event handler and running_req is decremented from that.
> But there are some other error status (like IO_DS_IN_RECOVERY,
> IO_XFER_ERR_LAST_PIO_DATAIN_CRC_ERR) where the IO have been completed
> by fw/driver, but running_req is not decremented.
>
> Also During NCQ error handling, driver itself will initiate
> READ_LOG_EXT and ABORT_ALL. When libsas/libata initiate READ_LOG_EXT
> (0x2F), driver increments the running_req. But this will be completed
> by the driver in pm80xx_chip_sata_req(), but running_req was not
> decremented.
>
> Signed-off-by: Viswas G <Viswas.G@microchip.com>
> Signed-off-by: Ruksar Devadi <Ruksar.devadi@microchip.com>
Looks good to me!
Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
>  drivers/scsi/pm8001/pm8001_hwi.c  |  58 +++++++++++++++++-----
>  drivers/scsi/pm8001/pm8001_init.c |   2 +-
>  drivers/scsi/pm8001/pm8001_sas.c  |  11 +++--
>  drivers/scsi/pm8001/pm8001_sas.h  |   2 +-
>  drivers/scsi/pm8001/pm80xx_hwi.c  | 101 ++++++++++++++++++++++++++++++++++----
>  5 files changed, 147 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
> index 597d7a096a97..9e9a546da959 100644
> --- a/drivers/scsi/pm8001/pm8001_hwi.c
> +++ b/drivers/scsi/pm8001/pm8001_hwi.c
> @@ -1587,7 +1587,7 @@ void pm8001_work_fn(struct work_struct *work)
>                 ts->stat = SAS_QUEUE_FULL;
>                 pm8001_dev = ccb->device;
>                 if (pm8001_dev)
> -                       pm8001_dev->running_req--;
> +                       atomic_dec(&pm8001_dev->running_req);
>                 spin_lock_irqsave(&t->task_state_lock, flags1);
>                 t->task_state_flags &= ~SAS_TASK_STATE_PENDING;
>                 t->task_state_flags &= ~SAS_TASK_AT_INITIATOR;
> @@ -1942,7 +1942,7 @@ mpi_ssp_completion(struct pm8001_hba_info *pm8001_ha , void *piomb)
>                         sas_ssp_task_response(pm8001_ha->dev, t, iu);
>                 }
>                 if (pm8001_dev)
> -                       pm8001_dev->running_req--;
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_ABORTED:
>                 PM8001_IO_DBG(pm8001_ha,
> @@ -1958,7 +1958,7 @@ mpi_ssp_completion(struct pm8001_hba_info *pm8001_ha , void *piomb)
>                 ts->stat = SAS_DATA_UNDERRUN;
>                 ts->residual = param;
>                 if (pm8001_dev)
> -                       pm8001_dev->running_req--;
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_NO_DEVICE:
>                 PM8001_IO_DBG(pm8001_ha,
> @@ -2172,7 +2172,7 @@ static void mpi_ssp_event(struct pm8001_hba_info *pm8001_ha , void *piomb)
>                 ts->stat = SAS_DATA_OVERRUN;
>                 ts->residual = 0;
>                 if (pm8001_dev)
> -                       pm8001_dev->running_req--;
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_XFER_ERROR_BREAK:
>                 PM8001_IO_DBG(pm8001_ha,
> @@ -2487,7 +2487,7 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
>                                         pm8001_printk("response to large\n"));
>                 }
>                 if (pm8001_dev)
> -                       pm8001_dev->running_req--;
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_ABORTED:
>                 PM8001_IO_DBG(pm8001_ha,
> @@ -2495,7 +2495,7 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
>                 ts->resp = SAS_TASK_COMPLETE;
>                 ts->stat = SAS_ABORTED_TASK;
>                 if (pm8001_dev)
> -                       pm8001_dev->running_req--;
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>                 /* following cases are to do cases */
>         case IO_UNDERFLOW:
> @@ -2506,19 +2506,23 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
>                 ts->stat = SAS_DATA_UNDERRUN;
>                 ts->residual =  param;
>                 if (pm8001_dev)
> -                       pm8001_dev->running_req--;
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_NO_DEVICE:
>                 PM8001_IO_DBG(pm8001_ha,
>                         pm8001_printk("IO_NO_DEVICE\n"));
>                 ts->resp = SAS_TASK_UNDELIVERED;
>                 ts->stat = SAS_PHY_DOWN;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_XFER_ERROR_BREAK:
>                 PM8001_IO_DBG(pm8001_ha,
>                         pm8001_printk("IO_XFER_ERROR_BREAK\n"));
>                 ts->resp = SAS_TASK_COMPLETE;
>                 ts->stat = SAS_INTERRUPTED;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_XFER_ERROR_PHY_NOT_READY:
>                 PM8001_IO_DBG(pm8001_ha,
> @@ -2526,6 +2530,8 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
>                 ts->resp = SAS_TASK_COMPLETE;
>                 ts->stat = SAS_OPEN_REJECT;
>                 ts->open_rej_reason = SAS_OREJ_RSVD_RETRY;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_OPEN_CNX_ERROR_PROTOCOL_NOT_SUPPORTED:
>                 PM8001_IO_DBG(pm8001_ha,
> @@ -2534,6 +2540,8 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
>                 ts->resp = SAS_TASK_COMPLETE;
>                 ts->stat = SAS_OPEN_REJECT;
>                 ts->open_rej_reason = SAS_OREJ_EPROTO;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_OPEN_CNX_ERROR_ZONE_VIOLATION:
>                 PM8001_IO_DBG(pm8001_ha,
> @@ -2541,6 +2549,8 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
>                 ts->resp = SAS_TASK_COMPLETE;
>                 ts->stat = SAS_OPEN_REJECT;
>                 ts->open_rej_reason = SAS_OREJ_UNKNOWN;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_OPEN_CNX_ERROR_BREAK:
>                 PM8001_IO_DBG(pm8001_ha,
> @@ -2548,6 +2558,8 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
>                 ts->resp = SAS_TASK_COMPLETE;
>                 ts->stat = SAS_OPEN_REJECT;
>                 ts->open_rej_reason = SAS_OREJ_RSVD_CONT0;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_OPEN_CNX_ERROR_IT_NEXUS_LOSS:
>                 PM8001_IO_DBG(pm8001_ha,
> @@ -2587,6 +2599,8 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
>                 ts->resp = SAS_TASK_COMPLETE;
>                 ts->stat = SAS_OPEN_REJECT;
>                 ts->open_rej_reason = SAS_OREJ_CONN_RATE;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_OPEN_CNX_ERROR_STP_RESOURCES_BUSY:
>                 PM8001_IO_DBG(pm8001_ha,
> @@ -2610,48 +2624,64 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
>                 ts->resp = SAS_TASK_COMPLETE;
>                 ts->stat = SAS_OPEN_REJECT;
>                 ts->open_rej_reason = SAS_OREJ_WRONG_DEST;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_XFER_ERROR_NAK_RECEIVED:
>                 PM8001_IO_DBG(pm8001_ha,
>                         pm8001_printk("IO_XFER_ERROR_NAK_RECEIVED\n"));
>                 ts->resp = SAS_TASK_COMPLETE;
>                 ts->stat = SAS_NAK_R_ERR;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_XFER_ERROR_ACK_NAK_TIMEOUT:
>                 PM8001_IO_DBG(pm8001_ha,
>                         pm8001_printk("IO_XFER_ERROR_ACK_NAK_TIMEOUT\n"));
>                 ts->resp = SAS_TASK_COMPLETE;
>                 ts->stat = SAS_NAK_R_ERR;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_XFER_ERROR_DMA:
>                 PM8001_IO_DBG(pm8001_ha,
>                         pm8001_printk("IO_XFER_ERROR_DMA\n"));
>                 ts->resp = SAS_TASK_COMPLETE;
>                 ts->stat = SAS_ABORTED_TASK;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_XFER_ERROR_SATA_LINK_TIMEOUT:
>                 PM8001_IO_DBG(pm8001_ha,
>                         pm8001_printk("IO_XFER_ERROR_SATA_LINK_TIMEOUT\n"));
>                 ts->resp = SAS_TASK_UNDELIVERED;
>                 ts->stat = SAS_DEV_NO_RESPONSE;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_XFER_ERROR_REJECTED_NCQ_MODE:
>                 PM8001_IO_DBG(pm8001_ha,
>                         pm8001_printk("IO_XFER_ERROR_REJECTED_NCQ_MODE\n"));
>                 ts->resp = SAS_TASK_COMPLETE;
>                 ts->stat = SAS_DATA_UNDERRUN;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_XFER_OPEN_RETRY_TIMEOUT:
>                 PM8001_IO_DBG(pm8001_ha,
>                         pm8001_printk("IO_XFER_OPEN_RETRY_TIMEOUT\n"));
>                 ts->resp = SAS_TASK_COMPLETE;
>                 ts->stat = SAS_OPEN_TO;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_PORT_IN_RESET:
>                 PM8001_IO_DBG(pm8001_ha,
>                         pm8001_printk("IO_PORT_IN_RESET\n"));
>                 ts->resp = SAS_TASK_COMPLETE;
>                 ts->stat = SAS_DEV_NO_RESPONSE;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_DS_NON_OPERATIONAL:
>                 PM8001_IO_DBG(pm8001_ha,
> @@ -2672,6 +2702,8 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
>                         pm8001_printk("  IO_DS_IN_RECOVERY\n"));
>                 ts->resp = SAS_TASK_COMPLETE;
>                 ts->stat = SAS_DEV_NO_RESPONSE;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_DS_IN_ERROR:
>                 PM8001_IO_DBG(pm8001_ha,
> @@ -2693,6 +2725,8 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
>                 ts->resp = SAS_TASK_COMPLETE;
>                 ts->stat = SAS_OPEN_REJECT;
>                 ts->open_rej_reason = SAS_OREJ_RSVD_RETRY;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         default:
>                 PM8001_DEVIO_DBG(pm8001_ha,
> @@ -2700,6 +2734,8 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
>                 /* not allowed case. Therefore, return failed status */
>                 ts->resp = SAS_TASK_COMPLETE;
>                 ts->stat = SAS_DEV_NO_RESPONSE;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         }
>         spin_lock_irqsave(&t->task_state_lock, flags);
> @@ -2776,7 +2812,7 @@ static void mpi_sata_event(struct pm8001_hba_info *pm8001_ha , void *piomb)
>                 ts->stat = SAS_DATA_OVERRUN;
>                 ts->residual = 0;
>                 if (pm8001_dev)
> -                       pm8001_dev->running_req--;
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_XFER_ERROR_BREAK:
>                 PM8001_IO_DBG(pm8001_ha,
> @@ -2976,7 +3012,7 @@ mpi_smp_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
>                 ts->resp = SAS_TASK_COMPLETE;
>                 ts->stat = SAM_STAT_GOOD;
>                 if (pm8001_dev)
> -                       pm8001_dev->running_req--;
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_ABORTED:
>                 PM8001_IO_DBG(pm8001_ha,
> @@ -2984,7 +3020,7 @@ mpi_smp_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
>                 ts->resp = SAS_TASK_COMPLETE;
>                 ts->stat = SAS_ABORTED_TASK;
>                 if (pm8001_dev)
> -                       pm8001_dev->running_req--;
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_OVERFLOW:
>                 PM8001_IO_DBG(pm8001_ha, pm8001_printk("IO_UNDERFLOW\n"));
> @@ -2992,7 +3028,7 @@ mpi_smp_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
>                 ts->stat = SAS_DATA_OVERRUN;
>                 ts->residual = 0;
>                 if (pm8001_dev)
> -                       pm8001_dev->running_req--;
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_NO_DEVICE:
>                 PM8001_IO_DBG(pm8001_ha, pm8001_printk("IO_NO_DEVICE\n"));
> diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
> index 3cf3e58b6979..fb471ad3720a 100644
> --- a/drivers/scsi/pm8001/pm8001_init.c
> +++ b/drivers/scsi/pm8001/pm8001_init.c
> @@ -412,7 +412,7 @@ static int pm8001_alloc(struct pm8001_hba_info *pm8001_ha,
>                 pm8001_ha->devices[i].dev_type = SAS_PHY_UNUSED;
>                 pm8001_ha->devices[i].id = i;
>                 pm8001_ha->devices[i].device_id = PM8001_MAX_DEVICES;
> -               pm8001_ha->devices[i].running_req = 0;
> +               atomic_set(&pm8001_ha->devices[i].running_req, 0);
>         }
>         pm8001_ha->flags = PM8001F_INIT_TIME;
>         /* Initialize tags */
> diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
> index 9889bab7d31c..d6e0bc588698 100644
> --- a/drivers/scsi/pm8001/pm8001_sas.c
> +++ b/drivers/scsi/pm8001/pm8001_sas.c
> @@ -456,9 +456,11 @@ static int pm8001_task_exec(struct sas_task *task,
>                 ccb->device = pm8001_dev;
>                 switch (task_proto) {
>                 case SAS_PROTOCOL_SMP:
> +                       atomic_inc(&pm8001_dev->running_req);
>                         rc = pm8001_task_prep_smp(pm8001_ha, ccb);
>                         break;
>                 case SAS_PROTOCOL_SSP:
> +                       atomic_inc(&pm8001_dev->running_req);
>                         if (is_tmf)
>                                 rc = pm8001_task_prep_ssp_tm(pm8001_ha,
>                                         ccb, tmf);
> @@ -467,6 +469,7 @@ static int pm8001_task_exec(struct sas_task *task,
>                         break;
>                 case SAS_PROTOCOL_SATA:
>                 case SAS_PROTOCOL_STP:
> +                       atomic_inc(&pm8001_dev->running_req);
>                         rc = pm8001_task_prep_ata(pm8001_ha, ccb);
>                         break;
>                 default:
> @@ -479,13 +482,13 @@ static int pm8001_task_exec(struct sas_task *task,
>                 if (rc) {
>                         PM8001_IO_DBG(pm8001_ha,
>                                 pm8001_printk("rc is %x\n", rc));
> +                       atomic_dec(&pm8001_dev->running_req);
>                         goto err_out_tag;
>                 }
>                 /* TODO: select normal or high priority */
>                 spin_lock(&t->task_state_lock);
>                 t->task_state_flags |= SAS_TASK_AT_INITIATOR;
>                 spin_unlock(&t->task_state_lock);
> -               pm8001_dev->running_req++;
>         } while (0);
>         rc = 0;
>         goto out_done;
> @@ -886,11 +889,11 @@ static void pm8001_dev_gone_notify(struct domain_device *dev)
>                 PM8001_DISC_DBG(pm8001_ha,
>                         pm8001_printk("found dev[%d:%x] is gone.\n",
>                         pm8001_dev->device_id, pm8001_dev->dev_type));
> -               if (pm8001_dev->running_req) {
> +               if (atomic_read(&pm8001_dev->running_req)) {
>                         spin_unlock_irqrestore(&pm8001_ha->lock, flags);
>                         pm8001_exec_internal_task_abort(pm8001_ha, pm8001_dev ,
>                                 dev, 1, 0);
> -                       while (pm8001_dev->running_req)
> +                       while (atomic_read(&pm8001_dev->running_req))
>                                 msleep(20);
>                         spin_lock_irqsave(&pm8001_ha->lock, flags);
>                 }
> @@ -968,7 +971,7 @@ void pm8001_open_reject_retry(
>                 ts->stat = SAS_OPEN_REJECT;
>                 ts->open_rej_reason = SAS_OREJ_RSVD_RETRY;
>                 if (pm8001_dev)
> -                       pm8001_dev->running_req--;
> +                       atomic_dec(&pm8001_dev->running_req);
>                 spin_lock_irqsave(&task->task_state_lock, flags1);
>                 task->task_state_flags &= ~SAS_TASK_STATE_PENDING;
>                 task->task_state_flags &= ~SAS_TASK_AT_INITIATOR;
> diff --git a/drivers/scsi/pm8001/pm8001_sas.h b/drivers/scsi/pm8001/pm8001_sas.h
> index 95663e138083..091574721ea1 100644
> --- a/drivers/scsi/pm8001/pm8001_sas.h
> +++ b/drivers/scsi/pm8001/pm8001_sas.h
> @@ -293,7 +293,7 @@ struct pm8001_device {
>         struct completion       *dcompletion;
>         struct completion       *setds_completion;
>         u32                     device_id;
> -       u32                     running_req;
> +       atomic_t                running_req;
>  };
>
>  struct pm8001_prd_imt {
> diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
> index 5fe50e0effcd..1ba93fb76093 100644
> --- a/drivers/scsi/pm8001/pm80xx_hwi.c
> +++ b/drivers/scsi/pm8001/pm80xx_hwi.c
> @@ -1960,13 +1960,15 @@ mpi_ssp_completion(struct pm8001_hba_info *pm8001_ha , void *piomb)
>                         sas_ssp_task_response(pm8001_ha->dev, t, iu);
>                 }
>                 if (pm8001_dev)
> -                       pm8001_dev->running_req--;
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_ABORTED:
>                 PM8001_IO_DBG(pm8001_ha,
>                         pm8001_printk("IO_ABORTED IOMB Tag\n"));
>                 ts->resp = SAS_TASK_COMPLETE;
>                 ts->stat = SAS_ABORTED_TASK;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_UNDERFLOW:
>                 /* SSP Completion with error */
> @@ -1977,13 +1979,15 @@ mpi_ssp_completion(struct pm8001_hba_info *pm8001_ha , void *piomb)
>                 ts->stat = SAS_DATA_UNDERRUN;
>                 ts->residual = param;
>                 if (pm8001_dev)
> -                       pm8001_dev->running_req--;
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_NO_DEVICE:
>                 PM8001_IO_DBG(pm8001_ha,
>                         pm8001_printk("IO_NO_DEVICE\n"));
>                 ts->resp = SAS_TASK_UNDELIVERED;
>                 ts->stat = SAS_PHY_DOWN;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_XFER_ERROR_BREAK:
>                 PM8001_IO_DBG(pm8001_ha,
> @@ -1992,6 +1996,8 @@ mpi_ssp_completion(struct pm8001_hba_info *pm8001_ha , void *piomb)
>                 ts->stat = SAS_OPEN_REJECT;
>                 /* Force the midlayer to retry */
>                 ts->open_rej_reason = SAS_OREJ_RSVD_RETRY;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_XFER_ERROR_PHY_NOT_READY:
>                 PM8001_IO_DBG(pm8001_ha,
> @@ -1999,6 +2005,8 @@ mpi_ssp_completion(struct pm8001_hba_info *pm8001_ha , void *piomb)
>                 ts->resp = SAS_TASK_COMPLETE;
>                 ts->stat = SAS_OPEN_REJECT;
>                 ts->open_rej_reason = SAS_OREJ_RSVD_RETRY;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_XFER_ERROR_INVALID_SSP_RSP_FRAME:
>                 PM8001_IO_DBG(pm8001_ha,
> @@ -2006,6 +2014,8 @@ mpi_ssp_completion(struct pm8001_hba_info *pm8001_ha , void *piomb)
>                 ts->resp = SAS_TASK_COMPLETE;
>                 ts->stat = SAS_OPEN_REJECT;
>                 ts->open_rej_reason = SAS_OREJ_RSVD_RETRY;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_OPEN_CNX_ERROR_PROTOCOL_NOT_SUPPORTED:
>                 PM8001_IO_DBG(pm8001_ha,
> @@ -2013,6 +2023,8 @@ mpi_ssp_completion(struct pm8001_hba_info *pm8001_ha , void *piomb)
>                 ts->resp = SAS_TASK_COMPLETE;
>                 ts->stat = SAS_OPEN_REJECT;
>                 ts->open_rej_reason = SAS_OREJ_EPROTO;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_OPEN_CNX_ERROR_ZONE_VIOLATION:
>                 PM8001_IO_DBG(pm8001_ha,
> @@ -2020,6 +2032,8 @@ mpi_ssp_completion(struct pm8001_hba_info *pm8001_ha , void *piomb)
>                 ts->resp = SAS_TASK_COMPLETE;
>                 ts->stat = SAS_OPEN_REJECT;
>                 ts->open_rej_reason = SAS_OREJ_UNKNOWN;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_OPEN_CNX_ERROR_BREAK:
>                 PM8001_IO_DBG(pm8001_ha,
> @@ -2027,6 +2041,8 @@ mpi_ssp_completion(struct pm8001_hba_info *pm8001_ha , void *piomb)
>                 ts->resp = SAS_TASK_COMPLETE;
>                 ts->stat = SAS_OPEN_REJECT;
>                 ts->open_rej_reason = SAS_OREJ_RSVD_RETRY;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_OPEN_CNX_ERROR_IT_NEXUS_LOSS:
>         case IO_XFER_OPEN_RETRY_BACKOFF_THRESHOLD_REACHED:
> @@ -2050,6 +2066,8 @@ mpi_ssp_completion(struct pm8001_hba_info *pm8001_ha , void *piomb)
>                 ts->resp = SAS_TASK_COMPLETE;
>                 ts->stat = SAS_OPEN_REJECT;
>                 ts->open_rej_reason = SAS_OREJ_BAD_DEST;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_OPEN_CNX_ERROR_CONNECTION_RATE_NOT_SUPPORTED:
>                 PM8001_IO_DBG(pm8001_ha, pm8001_printk(
> @@ -2057,6 +2075,8 @@ mpi_ssp_completion(struct pm8001_hba_info *pm8001_ha , void *piomb)
>                 ts->resp = SAS_TASK_COMPLETE;
>                 ts->stat = SAS_OPEN_REJECT;
>                 ts->open_rej_reason = SAS_OREJ_CONN_RATE;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_OPEN_CNX_ERROR_WRONG_DESTINATION:
>                 PM8001_IO_DBG(pm8001_ha,
> @@ -2064,6 +2084,8 @@ mpi_ssp_completion(struct pm8001_hba_info *pm8001_ha , void *piomb)
>                 ts->resp = SAS_TASK_UNDELIVERED;
>                 ts->stat = SAS_OPEN_REJECT;
>                 ts->open_rej_reason = SAS_OREJ_WRONG_DEST;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_XFER_ERROR_NAK_RECEIVED:
>                 PM8001_IO_DBG(pm8001_ha,
> @@ -2071,18 +2093,24 @@ mpi_ssp_completion(struct pm8001_hba_info *pm8001_ha , void *piomb)
>                 ts->resp = SAS_TASK_COMPLETE;
>                 ts->stat = SAS_OPEN_REJECT;
>                 ts->open_rej_reason = SAS_OREJ_RSVD_RETRY;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_XFER_ERROR_ACK_NAK_TIMEOUT:
>                 PM8001_IO_DBG(pm8001_ha,
>                         pm8001_printk("IO_XFER_ERROR_ACK_NAK_TIMEOUT\n"));
>                 ts->resp = SAS_TASK_COMPLETE;
>                 ts->stat = SAS_NAK_R_ERR;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_XFER_ERROR_DMA:
>                 PM8001_IO_DBG(pm8001_ha,
>                 pm8001_printk("IO_XFER_ERROR_DMA\n"));
>                 ts->resp = SAS_TASK_COMPLETE;
>                 ts->stat = SAS_OPEN_REJECT;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_XFER_OPEN_RETRY_TIMEOUT:
>                 PM8001_IO_DBG(pm8001_ha,
> @@ -2090,18 +2118,24 @@ mpi_ssp_completion(struct pm8001_hba_info *pm8001_ha , void *piomb)
>                 ts->resp = SAS_TASK_COMPLETE;
>                 ts->stat = SAS_OPEN_REJECT;
>                 ts->open_rej_reason = SAS_OREJ_RSVD_RETRY;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_XFER_ERROR_OFFSET_MISMATCH:
>                 PM8001_IO_DBG(pm8001_ha,
>                         pm8001_printk("IO_XFER_ERROR_OFFSET_MISMATCH\n"));
>                 ts->resp = SAS_TASK_COMPLETE;
>                 ts->stat = SAS_OPEN_REJECT;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_PORT_IN_RESET:
>                 PM8001_IO_DBG(pm8001_ha,
>                         pm8001_printk("IO_PORT_IN_RESET\n"));
>                 ts->resp = SAS_TASK_COMPLETE;
>                 ts->stat = SAS_OPEN_REJECT;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_DS_NON_OPERATIONAL:
>                 PM8001_IO_DBG(pm8001_ha,
> @@ -2118,18 +2152,24 @@ mpi_ssp_completion(struct pm8001_hba_info *pm8001_ha , void *piomb)
>                         pm8001_printk("IO_DS_IN_RECOVERY\n"));
>                 ts->resp = SAS_TASK_COMPLETE;
>                 ts->stat = SAS_OPEN_REJECT;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_TM_TAG_NOT_FOUND:
>                 PM8001_IO_DBG(pm8001_ha,
>                         pm8001_printk("IO_TM_TAG_NOT_FOUND\n"));
>                 ts->resp = SAS_TASK_COMPLETE;
>                 ts->stat = SAS_OPEN_REJECT;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_SSP_EXT_IU_ZERO_LEN_ERROR:
>                 PM8001_IO_DBG(pm8001_ha,
>                         pm8001_printk("IO_SSP_EXT_IU_ZERO_LEN_ERROR\n"));
>                 ts->resp = SAS_TASK_COMPLETE;
>                 ts->stat = SAS_OPEN_REJECT;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_OPEN_CNX_ERROR_HW_RESOURCE_BUSY:
>                 PM8001_IO_DBG(pm8001_ha,
> @@ -2137,6 +2177,8 @@ mpi_ssp_completion(struct pm8001_hba_info *pm8001_ha , void *piomb)
>                 ts->resp = SAS_TASK_COMPLETE;
>                 ts->stat = SAS_OPEN_REJECT;
>                 ts->open_rej_reason = SAS_OREJ_RSVD_RETRY;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         default:
>                 PM8001_DEVIO_DBG(pm8001_ha,
> @@ -2144,6 +2186,8 @@ mpi_ssp_completion(struct pm8001_hba_info *pm8001_ha , void *piomb)
>                 /* not allowed case. Therefore, return failed status */
>                 ts->resp = SAS_TASK_COMPLETE;
>                 ts->stat = SAS_OPEN_REJECT;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         }
>         PM8001_IO_DBG(pm8001_ha,
> @@ -2203,7 +2247,7 @@ static void mpi_ssp_event(struct pm8001_hba_info *pm8001_ha , void *piomb)
>                 ts->stat = SAS_DATA_OVERRUN;
>                 ts->residual = 0;
>                 if (pm8001_dev)
> -                       pm8001_dev->running_req--;
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_XFER_ERROR_BREAK:
>                 PM8001_IO_DBG(pm8001_ha,
> @@ -2528,7 +2572,7 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
>                                         pm8001_printk("response too large\n"));
>                 }
>                 if (pm8001_dev)
> -                       pm8001_dev->running_req--;
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_ABORTED:
>                 PM8001_IO_DBG(pm8001_ha,
> @@ -2536,7 +2580,7 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
>                 ts->resp = SAS_TASK_COMPLETE;
>                 ts->stat = SAS_ABORTED_TASK;
>                 if (pm8001_dev)
> -                       pm8001_dev->running_req--;
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>                 /* following cases are to do cases */
>         case IO_UNDERFLOW:
> @@ -2547,19 +2591,23 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
>                 ts->stat = SAS_DATA_UNDERRUN;
>                 ts->residual = param;
>                 if (pm8001_dev)
> -                       pm8001_dev->running_req--;
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_NO_DEVICE:
>                 PM8001_IO_DBG(pm8001_ha,
>                         pm8001_printk("IO_NO_DEVICE\n"));
>                 ts->resp = SAS_TASK_UNDELIVERED;
>                 ts->stat = SAS_PHY_DOWN;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_XFER_ERROR_BREAK:
>                 PM8001_IO_DBG(pm8001_ha,
>                         pm8001_printk("IO_XFER_ERROR_BREAK\n"));
>                 ts->resp = SAS_TASK_COMPLETE;
>                 ts->stat = SAS_INTERRUPTED;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_XFER_ERROR_PHY_NOT_READY:
>                 PM8001_IO_DBG(pm8001_ha,
> @@ -2567,6 +2615,8 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
>                 ts->resp = SAS_TASK_COMPLETE;
>                 ts->stat = SAS_OPEN_REJECT;
>                 ts->open_rej_reason = SAS_OREJ_RSVD_RETRY;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_OPEN_CNX_ERROR_PROTOCOL_NOT_SUPPORTED:
>                 PM8001_IO_DBG(pm8001_ha, pm8001_printk(
> @@ -2574,6 +2624,8 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
>                 ts->resp = SAS_TASK_COMPLETE;
>                 ts->stat = SAS_OPEN_REJECT;
>                 ts->open_rej_reason = SAS_OREJ_EPROTO;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_OPEN_CNX_ERROR_ZONE_VIOLATION:
>                 PM8001_IO_DBG(pm8001_ha,
> @@ -2581,6 +2633,8 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
>                 ts->resp = SAS_TASK_COMPLETE;
>                 ts->stat = SAS_OPEN_REJECT;
>                 ts->open_rej_reason = SAS_OREJ_UNKNOWN;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_OPEN_CNX_ERROR_BREAK:
>                 PM8001_IO_DBG(pm8001_ha,
> @@ -2588,6 +2642,8 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
>                 ts->resp = SAS_TASK_COMPLETE;
>                 ts->stat = SAS_OPEN_REJECT;
>                 ts->open_rej_reason = SAS_OREJ_RSVD_CONT0;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_OPEN_CNX_ERROR_IT_NEXUS_LOSS:
>         case IO_XFER_OPEN_RETRY_BACKOFF_THRESHOLD_REACHED:
> @@ -2631,6 +2687,8 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
>                 ts->resp = SAS_TASK_COMPLETE;
>                 ts->stat = SAS_OPEN_REJECT;
>                 ts->open_rej_reason = SAS_OREJ_CONN_RATE;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_OPEN_CNX_ERROR_STP_RESOURCES_BUSY:
>                 PM8001_IO_DBG(pm8001_ha, pm8001_printk(
> @@ -2653,48 +2711,64 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
>                 ts->resp = SAS_TASK_COMPLETE;
>                 ts->stat = SAS_OPEN_REJECT;
>                 ts->open_rej_reason = SAS_OREJ_WRONG_DEST;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_XFER_ERROR_NAK_RECEIVED:
>                 PM8001_IO_DBG(pm8001_ha,
>                         pm8001_printk("IO_XFER_ERROR_NAK_RECEIVED\n"));
>                 ts->resp = SAS_TASK_COMPLETE;
>                 ts->stat = SAS_NAK_R_ERR;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_XFER_ERROR_ACK_NAK_TIMEOUT:
>                 PM8001_IO_DBG(pm8001_ha,
>                         pm8001_printk("IO_XFER_ERROR_ACK_NAK_TIMEOUT\n"));
>                 ts->resp = SAS_TASK_COMPLETE;
>                 ts->stat = SAS_NAK_R_ERR;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_XFER_ERROR_DMA:
>                 PM8001_IO_DBG(pm8001_ha,
>                         pm8001_printk("IO_XFER_ERROR_DMA\n"));
>                 ts->resp = SAS_TASK_COMPLETE;
>                 ts->stat = SAS_ABORTED_TASK;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_XFER_ERROR_SATA_LINK_TIMEOUT:
>                 PM8001_IO_DBG(pm8001_ha,
>                         pm8001_printk("IO_XFER_ERROR_SATA_LINK_TIMEOUT\n"));
>                 ts->resp = SAS_TASK_UNDELIVERED;
>                 ts->stat = SAS_DEV_NO_RESPONSE;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_XFER_ERROR_REJECTED_NCQ_MODE:
>                 PM8001_IO_DBG(pm8001_ha,
>                         pm8001_printk("IO_XFER_ERROR_REJECTED_NCQ_MODE\n"));
>                 ts->resp = SAS_TASK_COMPLETE;
>                 ts->stat = SAS_DATA_UNDERRUN;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_XFER_OPEN_RETRY_TIMEOUT:
>                 PM8001_IO_DBG(pm8001_ha,
>                         pm8001_printk("IO_XFER_OPEN_RETRY_TIMEOUT\n"));
>                 ts->resp = SAS_TASK_COMPLETE;
>                 ts->stat = SAS_OPEN_TO;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_PORT_IN_RESET:
>                 PM8001_IO_DBG(pm8001_ha,
>                         pm8001_printk("IO_PORT_IN_RESET\n"));
>                 ts->resp = SAS_TASK_COMPLETE;
>                 ts->stat = SAS_DEV_NO_RESPONSE;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_DS_NON_OPERATIONAL:
>                 PM8001_IO_DBG(pm8001_ha,
> @@ -2715,6 +2789,8 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
>                         pm8001_printk("IO_DS_IN_RECOVERY\n"));
>                 ts->resp = SAS_TASK_COMPLETE;
>                 ts->stat = SAS_DEV_NO_RESPONSE;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_DS_IN_ERROR:
>                 PM8001_IO_DBG(pm8001_ha,
> @@ -2736,6 +2812,8 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
>                 ts->resp = SAS_TASK_COMPLETE;
>                 ts->stat = SAS_OPEN_REJECT;
>                 ts->open_rej_reason = SAS_OREJ_RSVD_RETRY;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         default:
>                 PM8001_DEVIO_DBG(pm8001_ha,
> @@ -2743,6 +2821,8 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
>                 /* not allowed case. Therefore, return failed status */
>                 ts->resp = SAS_TASK_COMPLETE;
>                 ts->stat = SAS_DEV_NO_RESPONSE;
> +               if (pm8001_dev)
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         }
>         spin_lock_irqsave(&t->task_state_lock, flags);
> @@ -2820,7 +2900,7 @@ static void mpi_sata_event(struct pm8001_hba_info *pm8001_ha , void *piomb)
>                 ts->stat = SAS_DATA_OVERRUN;
>                 ts->residual = 0;
>                 if (pm8001_dev)
> -                       pm8001_dev->running_req--;
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_XFER_ERROR_BREAK:
>                 PM8001_IO_DBG(pm8001_ha,
> @@ -3040,7 +3120,7 @@ mpi_smp_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
>                 ts->resp = SAS_TASK_COMPLETE;
>                 ts->stat = SAM_STAT_GOOD;
>                 if (pm8001_dev)
> -                       pm8001_dev->running_req--;
> +                       atomic_dec(&pm8001_dev->running_req);
>                 if (pm8001_ha->smp_exp_mode == SMP_DIRECT) {
>                         PM8001_IO_DBG(pm8001_ha,
>                                 pm8001_printk("DIRECT RESPONSE Length:%d\n",
> @@ -3063,7 +3143,7 @@ mpi_smp_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
>                 ts->resp = SAS_TASK_COMPLETE;
>                 ts->stat = SAS_ABORTED_TASK;
>                 if (pm8001_dev)
> -                       pm8001_dev->running_req--;
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_OVERFLOW:
>                 PM8001_IO_DBG(pm8001_ha, pm8001_printk("IO_UNDERFLOW\n"));
> @@ -3071,7 +3151,7 @@ mpi_smp_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
>                 ts->stat = SAS_DATA_OVERRUN;
>                 ts->residual = 0;
>                 if (pm8001_dev)
> -                       pm8001_dev->running_req--;
> +                       atomic_dec(&pm8001_dev->running_req);
>                 break;
>         case IO_NO_DEVICE:
>                 PM8001_IO_DBG(pm8001_ha, pm8001_printk("IO_NO_DEVICE\n"));
> @@ -4809,6 +4889,7 @@ static int pm80xx_chip_sata_req(struct pm8001_hba_info *pm8001_ha,
>                                                         flags);
>                                 pm8001_ccb_task_free_done(pm8001_ha, task,
>                                                                 ccb, tag);
> +                               atomic_dec(&pm8001_ha_dev->running_req);
>                                 return 0;
>                         }
>                 }
> --
> 2.16.3
>
