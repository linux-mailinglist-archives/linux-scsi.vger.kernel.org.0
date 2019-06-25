Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAB15292D
	for <lists+linux-scsi@lfdr.de>; Tue, 25 Jun 2019 12:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731168AbfFYKNk (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 25 Jun 2019 06:13:40 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38797 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727763AbfFYKNk (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 25 Jun 2019 06:13:40 -0400
Received: by mail-wm1-f67.google.com with SMTP id s15so2343180wmj.3
        for <linux-scsi@vger.kernel.org>; Tue, 25 Jun 2019 03:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l4FI2Mjv3obtQY3/kX1+h+mCrl5QXonexmBJsaf11W8=;
        b=SS+1RaB8fWsRaVLnbZ929zTGt5EpJBybsCPsBYmNHJAygZgjJ/TBudQL0YaGc2yb0I
         k5h6VB7eR7iUOHA2EVX20zAox7vRYFI1tufDCRGAQM/7U/cQeHvq1hsV4m7aaC3QjgDN
         hJ/94G9VOBdHzRgJpvYLnlw//S43TWBeaNHjj94Nz7WYkq8Wl/zZShFqfBzfRIysAl+d
         dyrsz7NeXCCOP/gzMFstYZC6V/GL5hetGBojSFAmL1oDIMp1paJB7stdfupdfmg1c9Km
         WDmicsMqRcNHOBBKT0JQycKRWbY9SQ9dv1pCHZXj2+ZHd6TnK3yClD6kkRiagiKv4cMA
         75bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l4FI2Mjv3obtQY3/kX1+h+mCrl5QXonexmBJsaf11W8=;
        b=i7GtU1FJ4TLb1TLr5CiPAZB+d8dDcsmnc6yDF2IY+6YIUYBxmB0zHMf90UBfgouPDe
         k1Mm84H6mbR09Bv/7WpRITj2yENWHeCHZlrAuWMVSHktAT+dGv8Jla56AQkASYEudKIi
         /s7o8BUpUQCFRpSYg8OlwurvsEl1T+VbKBmVtqs5Mu1ZAze7GfBibjH8qNpVgES5z9uR
         bBFKW7enFtzmOf91Swvs2EzbmcJX/60v9vv8N2OLqds+1Vsw0twAlYZI0LZnWw9gjLWI
         TjX/hANyCbXV+Z9KpdvU7ap64qwzCd3SsAzAVf/c1KPaRiY7b5ZnFy8vfwzCsQkJLNk0
         dBmA==
X-Gm-Message-State: APjAAAXUNk5YEdbv62Q+SmAew/lAEV1unvyR26Z8E2rLI9dwBTe5LVi+
        UXwZ4J8/Dx65FOlnzCNsjkXTwvuBO9Wy33lMNMQRDg==
X-Google-Smtp-Source: APXvYqxPYJG5ZjsEZZmkb6U8+3mLsdyorGI/HYfaK27AwGYFPQ81uz6PkwuGOaEBnEEewUSX+Ax+uqZ417P3kUQd1JY=
X-Received: by 2002:a1c:b457:: with SMTP id d84mr20750077wmf.153.1561457618074;
 Tue, 25 Jun 2019 03:13:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190624082228.27433-1-deepak.ukey@microchip.com> <20190624082228.27433-2-deepak.ukey@microchip.com>
In-Reply-To: <20190624082228.27433-2-deepak.ukey@microchip.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 25 Jun 2019 12:13:27 +0200
Message-ID: <CAMGffEmVTxCBPUsqbSZRL-eH0dzT+PdTftmFFEMP_Jw7Uxb2tA@mail.gmail.com>
Subject: Re: [PATCH 1/3] pm80xx : Fixed kernel panic during error recovery for
 SATA drive.
To:     Deepak Ukey <deepak.ukey@microchip.com>
Cc:     Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        Vasanthalakshmi.Tharmarajan@microchip.com, Viswas.G@microcchip.com,
        Jack Wang <jinpu.wang@profitbricks.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Deepak,

Thanks for the patch, comment inline.
On Mon, Jun 24, 2019 at 10:22 AM Deepak Ukey <deepak.ukey@microchip.com> wrote:
>
> Disabling the SATA drive interface cause kernel panic. When the drive
> Interface is disabled, device should be deregistered after aborting
> all pending IO's.
Can you share the call trace for the panic?

>
> Signed-off-by: Deepak Ukey <deepak.ukey@microchip.com>
> Signed-off-by: Viswas G <Viswas.G@microchip.com>
> ---
>  drivers/scsi/pm8001/pm8001_sas.c | 6 +++++-
>  drivers/scsi/pm8001/pm80xx_hwi.c | 2 +-
>  drivers/scsi/pm8001/pm80xx_hwi.h | 1 +
>  3 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
> index 88eef3b..0d680f3 100644
> --- a/drivers/scsi/pm8001/pm8001_sas.c
> +++ b/drivers/scsi/pm8001/pm8001_sas.c
> @@ -889,6 +889,8 @@ static void pm8001_dev_gone_notify(struct domain_device *dev)
>                         pm8001_exec_internal_task_abort(pm8001_ha, pm8001_dev ,
>                                 dev, 1, 0);
>                         spin_lock_irqsave(&pm8001_ha->lock, flags);
> +                       while (pm8001_dev->running_req)
> +                               msleep(20);
We are holding spin lock, and sleep, are you sure it's right?
>                 }
>                 PM8001_CHIP_DISP->dereg_dev_req(pm8001_ha, device_id);
>                 pm8001_free_dev(pm8001_dev);
> @@ -1256,8 +1258,10 @@ int pm8001_abort_task(struct sas_task *task)
>                         PM8001_MSG_DBG(pm8001_ha,
>                                 pm8001_printk("Waiting for Port reset\n"));
>                         wait_for_completion(&completion_reset);
> -                       if (phy->port_reset_status)
> +                       if (phy->port_reset_status) {
> +                               pm8001_dev_gone_notify(dev);
>                                 goto out;
> +                       }
>
>                         /*
>                          * 4. SATA Abort ALL
> diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
> index 301de40..63e8af7 100644
> --- a/drivers/scsi/pm8001/pm80xx_hwi.c
> +++ b/drivers/scsi/pm8001/pm80xx_hwi.c
> @@ -604,7 +604,7 @@ static void update_main_config_table(struct pm8001_hba_info *pm8001_ha)
>                 pm8001_ha->main_cfg_tbl.pm80xx_tbl.port_recovery_timer &=
>                                         0x0000ffff;
>                 pm8001_ha->main_cfg_tbl.pm80xx_tbl.port_recovery_timer |=
> -                                       0x140000;
> +                                       CHIP_8006_PORT_RECOVERY_TIMEOUT;
>         }
>         pm8001_mw32(address, MAIN_PORT_RECOVERY_TIMER,
>                         pm8001_ha->main_cfg_tbl.pm80xx_tbl.port_recovery_timer);
> diff --git a/drivers/scsi/pm8001/pm80xx_hwi.h b/drivers/scsi/pm8001/pm80xx_hwi.h
> index 84d7426..a22bb4d 100644
> --- a/drivers/scsi/pm8001/pm80xx_hwi.h
> +++ b/drivers/scsi/pm8001/pm80xx_hwi.h
> @@ -230,6 +230,7 @@
>  #define SAS_MAX_AIP                     0x200000
>  #define IT_NEXUS_TIMEOUT       0x7D0
>  #define PORT_RECOVERY_TIMEOUT  ((IT_NEXUS_TIMEOUT/100) + 30)
> +#define CHIP_8006_PORT_RECOVERY_TIMEOUT 0x640000
This value is 4x bigger than the original, is it a intended, can you
mention is in commit message why?
>
>  #ifdef __LITTLE_ENDIAN_BITFIELD
>  struct sas_identify_frame_local {
> --
> 1.8.5.6
>

Regards,
Jack
