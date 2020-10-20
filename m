Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C5D284641
	for <lists+linux-scsi@lfdr.de>; Tue,  6 Oct 2020 08:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbgJFGp0 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 6 Oct 2020 02:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgJFGpZ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 6 Oct 2020 02:45:25 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6324C0613A7
        for <linux-scsi@vger.kernel.org>; Mon,  5 Oct 2020 23:45:24 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id lw21so11985491ejb.6
        for <linux-scsi@vger.kernel.org>; Mon, 05 Oct 2020 23:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hA/XjTdZei3VmPNdn7XOHYLmfw9BC8RrrRV97BsAAzI=;
        b=MsU+AwV8sD1uHrJdU7GCX9yvYepnXPptXAV6gq7JQpUUQ+LJo3GWhuH0JT5q69h5Fx
         Z+o+AwY7MXQtDh/I0HkriI7oesqlh3PGvvn8wzTZaHZiSbVhMPh5mHrM4WTasHeEon1j
         x3jIEE9D+YuNrXNkHGUolGIvCru0JPZc7JFupxs6DpJAh2LBWPq0ezph3I+lHLA+FB3u
         g2CJ9NmRD5QcZ5PByc3WZIutAwvfnBDADXzAjihwuopDoaXeaUKlMLjJi7vFHneBYuoe
         edc5rtSz0He3iW8/h5hKN9pBd/WpKh+t9kuJJj6mrf/IqnfEfEYz3D0IwPSw6WBb6Dx2
         g07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hA/XjTdZei3VmPNdn7XOHYLmfw9BC8RrrRV97BsAAzI=;
        b=adn3blooaSaja2bC8oj4Yx7rhT1ra7x7ZNRu+cpwdiLz50YyYVK3byToWPmII4cClE
         z1/X2YXaBsU0Ob0eIAzephnhjbIMFqBKaS8HogYyj8+Sfk/weKwYNrhHzGik5IFuB+re
         Xxz5ZyMlxx4IgbntFOEK3ixbuVyaeKtbPZfNSj0CX90gKkwfvmRB59AYJ3m1IWgmFAOi
         zYQajeH6Nzsn4DngddZRLm5vsoLuwYAF+Ttz1ro3HTQ0fUBETjcc1fI7MbVCY0It+jxU
         cVpV/HsK7KxG4aMUXUQmrDuapalwox190pp/IeompnWbhufdOAeVcUbZKsC2ouPA+anF
         1hWw==
X-Gm-Message-State: AOAM533cz7j+5JBTJycrhccC1c1zakCb2t8WhJyvrfTXdSVDty1aMdMO
        7fnHY3fZCiMGRuERcMp3eDCrYEaAhr5/gJCRCmob5A==
X-Google-Smtp-Source: ABdhPJxLkDsx49XySRaYfTliWsAhZ2xPWvyk9qiVsixDiRNVUATC5r3Jj6YiP/NFee+LSYUlkEJwHwAVN1O/GwTeipw=
X-Received: by 2002:a17:906:3397:: with SMTP id v23mr3570281eja.212.1601966723075;
 Mon, 05 Oct 2020 23:45:23 -0700 (PDT)
MIME-Version: 1.0
References: <20201005145011.23674-1-Viswas.G@microchip.com.com> <20201005145011.23674-2-Viswas.G@microchip.com.com>
In-Reply-To: <20201005145011.23674-2-Viswas.G@microchip.com.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 6 Oct 2020 08:45:12 +0200
Message-ID: <CAMGffEmmyhO0a+BmiN1UcPHRcdxE88z8uzBdfMu1ESFE4_H92Q@mail.gmail.com>
Subject: Re: [PATCH V2 1/4] pm80xx: Increase number of supported queues.
To:     Viswas G <Viswas.G@microchip.com.com>
Cc:     Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        Vasanthalakshmi.Tharmarajan@microchip.com,
        Viswas G <Viswas.G@microchip.com>, Ruksar.devadi@microchip.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, Oct 5, 2020 at 4:40 PM Viswas G <Viswas.G@microchip.com.com> wrote:
>
> From: Viswas G <Viswas.G@microchip.com>
>
> Current driver uses fixed number of Inbound and Outbound queues and all
> of the IO, TMF and internal requests are submitted through those. Global
> spin lock is used to control the shared access. This will create a
> lock contention and it is real bottleneck in the IO path. To avoid this,
> the number of supported Inbound and outbound queues is increased to 64,
> and the number of queues used are decided based on number of CPU cores
> online and number of MSIX allocated. Also, added locks per queue
> instead of using the global lock.
>
> Signed-off-by: Viswas G <Viswas.G@microchip.com>
> Signed-off-by: Ruksar Devadi <Ruksar.devadi@microchip.com>
looks good.
Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
>  drivers/scsi/pm8001/pm8001_ctl.c  |   6 +-
>  drivers/scsi/pm8001/pm8001_defs.h |  17 +++---
>  drivers/scsi/pm8001/pm8001_hwi.c  |  32 ++++++-----
>  drivers/scsi/pm8001/pm8001_init.c | 117 ++++++++++++++++++++++++--------------
>  drivers/scsi/pm8001/pm8001_sas.h  |  11 +++-
>  drivers/scsi/pm8001/pm80xx_hwi.c  |  81 +++++++++++++++-----------
>  6 files changed, 160 insertions(+), 104 deletions(-)
>
> diff --git a/drivers/scsi/pm8001/pm8001_ctl.c b/drivers/scsi/pm8001/pm8001_ctl.c
> index 77c805db2724..3587f7c8a428 100644
> --- a/drivers/scsi/pm8001/pm8001_ctl.c
> +++ b/drivers/scsi/pm8001/pm8001_ctl.c
> @@ -408,9 +408,10 @@ static ssize_t pm8001_ctl_ib_queue_log_show(struct device *cdev,
>         int offset;
>         char *str = buf;
>         int start = 0;
> +       u32 ib_offset = pm8001_ha->ib_offset;
>  #define IB_MEMMAP(c)   \
>                 (*(u32 *)((u8 *)pm8001_ha->     \
> -               memoryMap.region[IB].virt_ptr + \
> +               memoryMap.region[ib_offset].virt_ptr +  \
>                 pm8001_ha->evtlog_ib_offset + (c)))
>
>         for (offset = 0; offset < IB_OB_READ_TIMES; offset++) {
> @@ -442,9 +443,10 @@ static ssize_t pm8001_ctl_ob_queue_log_show(struct device *cdev,
>         int offset;
>         char *str = buf;
>         int start = 0;
> +       u32 ob_offset = pm8001_ha->ob_offset;
>  #define OB_MEMMAP(c)   \
>                 (*(u32 *)((u8 *)pm8001_ha->     \
> -               memoryMap.region[OB].virt_ptr + \
> +               memoryMap.region[ob_offset].virt_ptr +  \
>                 pm8001_ha->evtlog_ob_offset + (c)))
>
>         for (offset = 0; offset < IB_OB_READ_TIMES; offset++) {
> diff --git a/drivers/scsi/pm8001/pm8001_defs.h b/drivers/scsi/pm8001/pm8001_defs.h
> index 1c7f15fd69ce..a4f52a5a449e 100644
> --- a/drivers/scsi/pm8001/pm8001_defs.h
> +++ b/drivers/scsi/pm8001/pm8001_defs.h
> @@ -77,10 +77,8 @@ enum port_type {
>  /* driver compile-time configuration */
>  #define        PM8001_MAX_CCB           256    /* max ccbs supported */
>  #define PM8001_MPI_QUEUE         1024   /* maximum mpi queue entries */
> -#define        PM8001_MAX_INB_NUM       1
> -#define        PM8001_MAX_OUTB_NUM      1
> -#define        PM8001_MAX_SPCV_INB_NUM         1
> -#define        PM8001_MAX_SPCV_OUTB_NUM        4
> +#define        PM8001_MAX_INB_NUM       64
> +#define        PM8001_MAX_OUTB_NUM      64
>  #define        PM8001_CAN_QUEUE         508    /* SCSI Queue depth */
>
>  /* Inbound/Outbound queue size */
> @@ -94,11 +92,6 @@ enum port_type {
>  #define        PM8001_MAX_MSIX_VEC      64     /* max msi-x int for spcv/ve */
>
>  #define USI_MAX_MEMCNT_BASE    5
> -#define IB                     (USI_MAX_MEMCNT_BASE + 1)
> -#define CI                     (IB + PM8001_MAX_SPCV_INB_NUM)
> -#define OB                     (CI + PM8001_MAX_SPCV_INB_NUM)
> -#define PI                     (OB + PM8001_MAX_SPCV_OUTB_NUM)
> -#define USI_MAX_MEMCNT         (PI + PM8001_MAX_SPCV_OUTB_NUM)
>  #define        CONFIG_SCSI_PM8001_MAX_DMA_SG   528
>  #define PM8001_MAX_DMA_SG      CONFIG_SCSI_PM8001_MAX_DMA_SG
>  enum memory_region_num {
> @@ -112,6 +105,12 @@ enum memory_region_num {
>  };
>  #define        PM8001_EVENT_LOG_SIZE    (128 * 1024)
>
> +/**
> + * maximum DMA memory regions(number of IBQ + number of IBQ CI
> + * + number of  OBQ + number of OBQ PI)
> + */
> +#define USI_MAX_MEMCNT (USI_MAX_MEMCNT_BASE + 1 + ((2 * PM8001_MAX_INB_NUM) \
> +                       + (2 * PM8001_MAX_OUTB_NUM)))
>  /*error code*/
>  enum mpi_err {
>         MPI_IO_STATUS_SUCCESS = 0x0,
> diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
> index e9a939230b15..e9106575a30f 100644
> --- a/drivers/scsi/pm8001/pm8001_hwi.c
> +++ b/drivers/scsi/pm8001/pm8001_hwi.c
> @@ -189,6 +189,10 @@ static void init_default_table_values(struct pm8001_hba_info *pm8001_ha)
>         u32 offsetib, offsetob;
>         void __iomem *addressib = pm8001_ha->inbnd_q_tbl_addr;
>         void __iomem *addressob = pm8001_ha->outbnd_q_tbl_addr;
> +       u32 ib_offset = pm8001_ha->ib_offset;
> +       u32 ob_offset = pm8001_ha->ob_offset;
> +       u32 ci_offset = pm8001_ha->ci_offset;
> +       u32 pi_offset = pm8001_ha->pi_offset;
>
>         pm8001_ha->main_cfg_tbl.pm8001_tbl.inbound_q_nppd_hppd          = 0;
>         pm8001_ha->main_cfg_tbl.pm8001_tbl.outbound_hw_event_pid0_3     = 0;
> @@ -223,19 +227,19 @@ static void init_default_table_values(struct pm8001_hba_info *pm8001_ha)
>                 pm8001_ha->inbnd_q_tbl[i].element_pri_size_cnt  =
>                         PM8001_MPI_QUEUE | (pm8001_ha->iomb_size << 16) | (0x00<<30);
>                 pm8001_ha->inbnd_q_tbl[i].upper_base_addr       =
> -                       pm8001_ha->memoryMap.region[IB + i].phys_addr_hi;
> +                       pm8001_ha->memoryMap.region[ib_offset + i].phys_addr_hi;
>                 pm8001_ha->inbnd_q_tbl[i].lower_base_addr       =
> -               pm8001_ha->memoryMap.region[IB + i].phys_addr_lo;
> +               pm8001_ha->memoryMap.region[ib_offset + i].phys_addr_lo;
>                 pm8001_ha->inbnd_q_tbl[i].base_virt             =
> -                       (u8 *)pm8001_ha->memoryMap.region[IB + i].virt_ptr;
> +                 (u8 *)pm8001_ha->memoryMap.region[ib_offset + i].virt_ptr;
>                 pm8001_ha->inbnd_q_tbl[i].total_length          =
> -                       pm8001_ha->memoryMap.region[IB + i].total_len;
> +                       pm8001_ha->memoryMap.region[ib_offset + i].total_len;
>                 pm8001_ha->inbnd_q_tbl[i].ci_upper_base_addr    =
> -                       pm8001_ha->memoryMap.region[CI + i].phys_addr_hi;
> +                       pm8001_ha->memoryMap.region[ci_offset + i].phys_addr_hi;
>                 pm8001_ha->inbnd_q_tbl[i].ci_lower_base_addr    =
> -                       pm8001_ha->memoryMap.region[CI + i].phys_addr_lo;
> +                       pm8001_ha->memoryMap.region[ci_offset + i].phys_addr_lo;
>                 pm8001_ha->inbnd_q_tbl[i].ci_virt               =
> -                       pm8001_ha->memoryMap.region[CI + i].virt_ptr;
> +                       pm8001_ha->memoryMap.region[ci_offset + i].virt_ptr;
>                 offsetib = i * 0x20;
>                 pm8001_ha->inbnd_q_tbl[i].pi_pci_bar            =
>                         get_pci_bar_index(pm8001_mr32(addressib,
> @@ -249,21 +253,21 @@ static void init_default_table_values(struct pm8001_hba_info *pm8001_ha)
>                 pm8001_ha->outbnd_q_tbl[i].element_size_cnt     =
>                         PM8001_MPI_QUEUE | (pm8001_ha->iomb_size << 16) | (0x01<<30);
>                 pm8001_ha->outbnd_q_tbl[i].upper_base_addr      =
> -                       pm8001_ha->memoryMap.region[OB + i].phys_addr_hi;
> +                       pm8001_ha->memoryMap.region[ob_offset + i].phys_addr_hi;
>                 pm8001_ha->outbnd_q_tbl[i].lower_base_addr      =
> -                       pm8001_ha->memoryMap.region[OB + i].phys_addr_lo;
> +                       pm8001_ha->memoryMap.region[ob_offset + i].phys_addr_lo;
>                 pm8001_ha->outbnd_q_tbl[i].base_virt            =
> -                       (u8 *)pm8001_ha->memoryMap.region[OB + i].virt_ptr;
> +                 (u8 *)pm8001_ha->memoryMap.region[ob_offset + i].virt_ptr;
>                 pm8001_ha->outbnd_q_tbl[i].total_length         =
> -                       pm8001_ha->memoryMap.region[OB + i].total_len;
> +                       pm8001_ha->memoryMap.region[ob_offset + i].total_len;
>                 pm8001_ha->outbnd_q_tbl[i].pi_upper_base_addr   =
> -                       pm8001_ha->memoryMap.region[PI + i].phys_addr_hi;
> +                       pm8001_ha->memoryMap.region[pi_offset + i].phys_addr_hi;
>                 pm8001_ha->outbnd_q_tbl[i].pi_lower_base_addr   =
> -                       pm8001_ha->memoryMap.region[PI + i].phys_addr_lo;
> +                       pm8001_ha->memoryMap.region[pi_offset + i].phys_addr_lo;
>                 pm8001_ha->outbnd_q_tbl[i].interrup_vec_cnt_delay       =
>                         0 | (10 << 16) | (i << 24);
>                 pm8001_ha->outbnd_q_tbl[i].pi_virt              =
> -                       pm8001_ha->memoryMap.region[PI + i].virt_ptr;
> +                       pm8001_ha->memoryMap.region[pi_offset + i].virt_ptr;
>                 offsetob = i * 0x24;
>                 pm8001_ha->outbnd_q_tbl[i].ci_pci_bar           =
>                         get_pci_bar_index(pm8001_mr32(addressob,
> diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
> index 20fa96cbc9d3..c744f846e08d 100644
> --- a/drivers/scsi/pm8001/pm8001_init.c
> +++ b/drivers/scsi/pm8001/pm8001_init.c
> @@ -264,12 +264,36 @@ static u32 pm8001_request_irq(struct pm8001_hba_info *pm8001_ha);
>  static int pm8001_alloc(struct pm8001_hba_info *pm8001_ha,
>                         const struct pci_device_id *ent)
>  {
> -       int i;
> +       int i, count = 0, rc = 0;
> +       u32 ci_offset, ib_offset, ob_offset, pi_offset;
> +       struct inbound_queue_table *circularQ;
> +
>         spin_lock_init(&pm8001_ha->lock);
>         spin_lock_init(&pm8001_ha->bitmap_lock);
>         PM8001_INIT_DBG(pm8001_ha,
>                 pm8001_printk("pm8001_alloc: PHY:%x\n",
>                                 pm8001_ha->chip->n_phy));
> +
> +       /* Setup Interrupt */
> +       rc = pm8001_setup_irq(pm8001_ha);
> +       if (rc) {
> +               PM8001_FAIL_DBG(pm8001_ha, pm8001_printk(
> +                               "pm8001_setup_irq failed [ret: %d]\n", rc));
> +               goto err_out_shost;
> +       }
> +       /* Request Interrupt */
> +       rc = pm8001_request_irq(pm8001_ha);
> +       if (rc)
> +               goto err_out_shost;
> +
> +       count = pm8001_ha->max_q_num;
> +       /* Queues are chosen based on the number of cores/msix availability */
> +       ib_offset = pm8001_ha->ib_offset  = USI_MAX_MEMCNT_BASE + 1;
> +       ci_offset = pm8001_ha->ci_offset  = ib_offset + count;
> +       ob_offset = pm8001_ha->ob_offset  = ci_offset + count;
> +       pi_offset = pm8001_ha->pi_offset  = ob_offset + count;
> +       pm8001_ha->max_memcnt = pi_offset + count;
> +
>         for (i = 0; i < pm8001_ha->chip->n_phy; i++) {
>                 pm8001_phy_init(pm8001_ha, i);
>                 pm8001_ha->port[i].wide_port_phymap = 0;
> @@ -293,54 +317,62 @@ static int pm8001_alloc(struct pm8001_hba_info *pm8001_ha,
>         pm8001_ha->memoryMap.region[IOP].total_len = PM8001_EVENT_LOG_SIZE;
>         pm8001_ha->memoryMap.region[IOP].alignment = 32;
>
> -       for (i = 0; i < PM8001_MAX_SPCV_INB_NUM; i++) {
> +       for (i = 0; i < count; i++) {
> +               circularQ = &pm8001_ha->inbnd_q_tbl[i];
> +               spin_lock_init(&circularQ->iq_lock);
>                 /* MPI Memory region 3 for consumer Index of inbound queues */
> -               pm8001_ha->memoryMap.region[CI+i].num_elements = 1;
> -               pm8001_ha->memoryMap.region[CI+i].element_size = 4;
> -               pm8001_ha->memoryMap.region[CI+i].total_len = 4;
> -               pm8001_ha->memoryMap.region[CI+i].alignment = 4;
> +               pm8001_ha->memoryMap.region[ci_offset+i].num_elements = 1;
> +               pm8001_ha->memoryMap.region[ci_offset+i].element_size = 4;
> +               pm8001_ha->memoryMap.region[ci_offset+i].total_len = 4;
> +               pm8001_ha->memoryMap.region[ci_offset+i].alignment = 4;
>
>                 if ((ent->driver_data) != chip_8001) {
>                         /* MPI Memory region 5 inbound queues */
> -                       pm8001_ha->memoryMap.region[IB+i].num_elements =
> +                       pm8001_ha->memoryMap.region[ib_offset+i].num_elements =
>                                                 PM8001_MPI_QUEUE;
> -                       pm8001_ha->memoryMap.region[IB+i].element_size = 128;
> -                       pm8001_ha->memoryMap.region[IB+i].total_len =
> +                       pm8001_ha->memoryMap.region[ib_offset+i].element_size
> +                                                               = 128;
> +                       pm8001_ha->memoryMap.region[ib_offset+i].total_len =
>                                                 PM8001_MPI_QUEUE * 128;
> -                       pm8001_ha->memoryMap.region[IB+i].alignment = 128;
> +                       pm8001_ha->memoryMap.region[ib_offset+i].alignment
> +                                                               = 128;
>                 } else {
> -                       pm8001_ha->memoryMap.region[IB+i].num_elements =
> +                       pm8001_ha->memoryMap.region[ib_offset+i].num_elements =
>                                                 PM8001_MPI_QUEUE;
> -                       pm8001_ha->memoryMap.region[IB+i].element_size = 64;
> -                       pm8001_ha->memoryMap.region[IB+i].total_len =
> +                       pm8001_ha->memoryMap.region[ib_offset+i].element_size
> +                                                               = 64;
> +                       pm8001_ha->memoryMap.region[ib_offset+i].total_len =
>                                                 PM8001_MPI_QUEUE * 64;
> -                       pm8001_ha->memoryMap.region[IB+i].alignment = 64;
> +                       pm8001_ha->memoryMap.region[ib_offset+i].alignment = 64;
>                 }
>         }
>
> -       for (i = 0; i < PM8001_MAX_SPCV_OUTB_NUM; i++) {
> +       for (i = 0; i < count; i++) {
>                 /* MPI Memory region 4 for producer Index of outbound queues */
> -               pm8001_ha->memoryMap.region[PI+i].num_elements = 1;
> -               pm8001_ha->memoryMap.region[PI+i].element_size = 4;
> -               pm8001_ha->memoryMap.region[PI+i].total_len = 4;
> -               pm8001_ha->memoryMap.region[PI+i].alignment = 4;
> +               pm8001_ha->memoryMap.region[pi_offset+i].num_elements = 1;
> +               pm8001_ha->memoryMap.region[pi_offset+i].element_size = 4;
> +               pm8001_ha->memoryMap.region[pi_offset+i].total_len = 4;
> +               pm8001_ha->memoryMap.region[pi_offset+i].alignment = 4;
>
>                 if (ent->driver_data != chip_8001) {
>                         /* MPI Memory region 6 Outbound queues */
> -                       pm8001_ha->memoryMap.region[OB+i].num_elements =
> +                       pm8001_ha->memoryMap.region[ob_offset+i].num_elements =
>                                                 PM8001_MPI_QUEUE;
> -                       pm8001_ha->memoryMap.region[OB+i].element_size = 128;
> -                       pm8001_ha->memoryMap.region[OB+i].total_len =
> +                       pm8001_ha->memoryMap.region[ob_offset+i].element_size
> +                                                               = 128;
> +                       pm8001_ha->memoryMap.region[ob_offset+i].total_len =
>                                                 PM8001_MPI_QUEUE * 128;
> -                       pm8001_ha->memoryMap.region[OB+i].alignment = 128;
> +                       pm8001_ha->memoryMap.region[ob_offset+i].alignment
> +                                                               = 128;
>                 } else {
>                         /* MPI Memory region 6 Outbound queues */
> -                       pm8001_ha->memoryMap.region[OB+i].num_elements =
> +                       pm8001_ha->memoryMap.region[ob_offset+i].num_elements =
>                                                 PM8001_MPI_QUEUE;
> -                       pm8001_ha->memoryMap.region[OB+i].element_size = 64;
> -                       pm8001_ha->memoryMap.region[OB+i].total_len =
> +                       pm8001_ha->memoryMap.region[ob_offset+i].element_size
> +                                                               = 64;
> +                       pm8001_ha->memoryMap.region[ob_offset+i].total_len =
>                                                 PM8001_MPI_QUEUE * 64;
> -                       pm8001_ha->memoryMap.region[OB+i].alignment = 64;
> +                       pm8001_ha->memoryMap.region[ob_offset+i].alignment = 64;
>                 }
>
>         }
> @@ -369,7 +401,7 @@ static int pm8001_alloc(struct pm8001_hba_info *pm8001_ha,
>         pm8001_ha->memoryMap.region[FORENSIC_MEM].total_len = 0x10000;
>         pm8001_ha->memoryMap.region[FORENSIC_MEM].element_size = 0x10000;
>         pm8001_ha->memoryMap.region[FORENSIC_MEM].alignment = 0x10000;
> -       for (i = 0; i < USI_MAX_MEMCNT; i++) {
> +       for (i = 0; i < pm8001_ha->max_memcnt; i++) {
>                 if (pm8001_mem_alloc(pm8001_ha->pdev,
>                         &pm8001_ha->memoryMap.region[i].virt_ptr,
>                         &pm8001_ha->memoryMap.region[i].phys_addr,
> @@ -405,6 +437,8 @@ static int pm8001_alloc(struct pm8001_hba_info *pm8001_ha,
>         /* Initialize tags */
>         pm8001_tag_init(pm8001_ha);
>         return 0;
> +err_out_shost:
> +       scsi_remove_host(pm8001_ha->shost);
>  err_out:
>         return 1;
>  }
> @@ -899,7 +933,8 @@ static int pm8001_configure_phy_settings(struct pm8001_hba_info *pm8001_ha)
>  static u32 pm8001_setup_msix(struct pm8001_hba_info *pm8001_ha)
>  {
>         u32 number_of_intr;
> -       int rc;
> +       int rc, cpu_online_count;
> +       unsigned int allocated_irq_vectors;
>
>         /* SPCv controllers supports 64 msi-x */
>         if (pm8001_ha->chip_id == chip_8001) {
> @@ -908,13 +943,21 @@ static u32 pm8001_setup_msix(struct pm8001_hba_info *pm8001_ha)
>                 number_of_intr = PM8001_MAX_MSIX_VEC;
>         }
>
> +       cpu_online_count = num_online_cpus();
> +       number_of_intr = min_t(int, cpu_online_count, number_of_intr);
>         rc = pci_alloc_irq_vectors(pm8001_ha->pdev, number_of_intr,
>                         number_of_intr, PCI_IRQ_MSIX);
> -       number_of_intr = rc;
> +       allocated_irq_vectors = rc;
>         if (rc < 0)
>                 return rc;
> +
> +       /*Assigns the number of interrupts */
> +       number_of_intr = min_t(int, allocated_irq_vectors, number_of_intr);
>         pm8001_ha->number_of_intr = number_of_intr;
>
> +       /*maximum queue number updating in HBA structure */
> +       pm8001_ha->max_q_num = number_of_intr;
> +
>         PM8001_INIT_DBG(pm8001_ha, pm8001_printk(
>                 "pci_alloc_irq_vectors request ret:%d no of intr %d\n",
>                                 rc, pm8001_ha->number_of_intr));
> @@ -1069,13 +1112,6 @@ static int pm8001_pci_probe(struct pci_dev *pdev,
>                 rc = -ENOMEM;
>                 goto err_out_free;
>         }
> -       /* Setup Interrupt */
> -       rc = pm8001_setup_irq(pm8001_ha);
> -       if (rc) {
> -               PM8001_FAIL_DBG(pm8001_ha, pm8001_printk(
> -                       "pm8001_setup_irq failed [ret: %d]\n", rc));
> -               goto err_out_shost;
> -       }
>
>         PM8001_CHIP_DISP->chip_soft_rst(pm8001_ha);
>         rc = PM8001_CHIP_DISP->chip_init(pm8001_ha);
> @@ -1088,13 +1124,6 @@ static int pm8001_pci_probe(struct pci_dev *pdev,
>         rc = scsi_add_host(shost, &pdev->dev);
>         if (rc)
>                 goto err_out_ha_free;
> -       /* Request Interrupt */
> -       rc = pm8001_request_irq(pm8001_ha);
> -       if (rc) {
> -               PM8001_FAIL_DBG(pm8001_ha, pm8001_printk(
> -                       "pm8001_request_irq failed [ret: %d]\n", rc));
> -               goto err_out_shost;
> -       }
>
>         PM8001_CHIP_DISP->interrupt_enable(pm8001_ha, 0);
>         if (pm8001_ha->chip_id != chip_8001) {
> diff --git a/drivers/scsi/pm8001/pm8001_sas.h b/drivers/scsi/pm8001/pm8001_sas.h
> index ae7ba9b3c4bc..bdfce3c3f619 100644
> --- a/drivers/scsi/pm8001/pm8001_sas.h
> +++ b/drivers/scsi/pm8001/pm8001_sas.h
> @@ -468,6 +468,7 @@ struct inbound_queue_table {
>         u32                     reserved;
>         __le32                  consumer_index;
>         u32                     producer_idx;
> +       spinlock_t              iq_lock;
>  };
>  struct outbound_queue_table {
>         u32                     element_size_cnt;
> @@ -524,8 +525,8 @@ struct pm8001_hba_info {
>         void __iomem    *fatal_tbl_addr; /*MPI IVT Table Addr */
>         union main_cfg_table    main_cfg_tbl;
>         union general_status_table      gs_tbl;
> -       struct inbound_queue_table      inbnd_q_tbl[PM8001_MAX_SPCV_INB_NUM];
> -       struct outbound_queue_table     outbnd_q_tbl[PM8001_MAX_SPCV_OUTB_NUM];
> +       struct inbound_queue_table      inbnd_q_tbl[PM8001_MAX_INB_NUM];
> +       struct outbound_queue_table     outbnd_q_tbl[PM8001_MAX_OUTB_NUM];
>         struct sas_phy_attribute_table  phy_attr_table;
>                                         /* MPI SAS PHY attributes */
>         u8                      sas_addr[SAS_ADDR_SIZE];
> @@ -561,6 +562,12 @@ struct pm8001_hba_info {
>         u32                     reset_in_progress;
>         u32                     non_fatal_count;
>         u32                     non_fatal_read_length;
> +       u32 max_q_num;
> +       u32 ib_offset;
> +       u32 ob_offset;
> +       u32 ci_offset;
> +       u32 pi_offset;
> +       u32 max_memcnt;
>  };
>
>  struct pm8001_work {
> diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
> index b42f41d1ed49..26e9e8877107 100644
> --- a/drivers/scsi/pm8001/pm80xx_hwi.c
> +++ b/drivers/scsi/pm8001/pm80xx_hwi.c
> @@ -720,7 +720,7 @@ static void read_inbnd_queue_table(struct pm8001_hba_info *pm8001_ha)
>  {
>         int i;
>         void __iomem *address = pm8001_ha->inbnd_q_tbl_addr;
> -       for (i = 0; i < PM8001_MAX_SPCV_INB_NUM; i++) {
> +       for (i = 0; i < PM8001_MAX_INB_NUM; i++) {
>                 u32 offset = i * 0x20;
>                 pm8001_ha->inbnd_q_tbl[i].pi_pci_bar =
>                         get_pci_bar_index(pm8001_mr32(address,
> @@ -738,7 +738,7 @@ static void read_outbnd_queue_table(struct pm8001_hba_info *pm8001_ha)
>  {
>         int i;
>         void __iomem *address = pm8001_ha->outbnd_q_tbl_addr;
> -       for (i = 0; i < PM8001_MAX_SPCV_OUTB_NUM; i++) {
> +       for (i = 0; i < PM8001_MAX_OUTB_NUM; i++) {
>                 u32 offset = i * 0x24;
>                 pm8001_ha->outbnd_q_tbl[i].ci_pci_bar =
>                         get_pci_bar_index(pm8001_mr32(address,
> @@ -758,6 +758,10 @@ static void init_default_table_values(struct pm8001_hba_info *pm8001_ha)
>         u32 offsetib, offsetob;
>         void __iomem *addressib = pm8001_ha->inbnd_q_tbl_addr;
>         void __iomem *addressob = pm8001_ha->outbnd_q_tbl_addr;
> +       u32 ib_offset = pm8001_ha->ib_offset;
> +       u32 ob_offset = pm8001_ha->ob_offset;
> +       u32 ci_offset = pm8001_ha->ci_offset;
> +       u32 pi_offset = pm8001_ha->pi_offset;
>
>         pm8001_ha->main_cfg_tbl.pm80xx_tbl.upper_event_log_addr         =
>                 pm8001_ha->memoryMap.region[AAP1].phys_addr_hi;
> @@ -778,23 +782,23 @@ static void init_default_table_values(struct pm8001_hba_info *pm8001_ha)
>         /* Disable end to end CRC checking */
>         pm8001_ha->main_cfg_tbl.pm80xx_tbl.crc_core_dump = (0x1 << 16);
>
> -       for (i = 0; i < PM8001_MAX_SPCV_INB_NUM; i++) {
> +       for (i = 0; i < pm8001_ha->max_q_num; i++) {
>                 pm8001_ha->inbnd_q_tbl[i].element_pri_size_cnt  =
>                         PM8001_MPI_QUEUE | (pm8001_ha->iomb_size << 16) | (0x00<<30);
>                 pm8001_ha->inbnd_q_tbl[i].upper_base_addr       =
> -                       pm8001_ha->memoryMap.region[IB + i].phys_addr_hi;
> +                       pm8001_ha->memoryMap.region[ib_offset + i].phys_addr_hi;
>                 pm8001_ha->inbnd_q_tbl[i].lower_base_addr       =
> -               pm8001_ha->memoryMap.region[IB + i].phys_addr_lo;
> +               pm8001_ha->memoryMap.region[ib_offset + i].phys_addr_lo;
>                 pm8001_ha->inbnd_q_tbl[i].base_virt             =
> -                       (u8 *)pm8001_ha->memoryMap.region[IB + i].virt_ptr;
> +                 (u8 *)pm8001_ha->memoryMap.region[ib_offset + i].virt_ptr;
>                 pm8001_ha->inbnd_q_tbl[i].total_length          =
> -                       pm8001_ha->memoryMap.region[IB + i].total_len;
> +                       pm8001_ha->memoryMap.region[ib_offset + i].total_len;
>                 pm8001_ha->inbnd_q_tbl[i].ci_upper_base_addr    =
> -                       pm8001_ha->memoryMap.region[CI + i].phys_addr_hi;
> +                       pm8001_ha->memoryMap.region[ci_offset + i].phys_addr_hi;
>                 pm8001_ha->inbnd_q_tbl[i].ci_lower_base_addr    =
> -                       pm8001_ha->memoryMap.region[CI + i].phys_addr_lo;
> +                       pm8001_ha->memoryMap.region[ci_offset + i].phys_addr_lo;
>                 pm8001_ha->inbnd_q_tbl[i].ci_virt               =
> -                       pm8001_ha->memoryMap.region[CI + i].virt_ptr;
> +                       pm8001_ha->memoryMap.region[ci_offset + i].virt_ptr;
>                 offsetib = i * 0x20;
>                 pm8001_ha->inbnd_q_tbl[i].pi_pci_bar            =
>                         get_pci_bar_index(pm8001_mr32(addressib,
> @@ -809,25 +813,25 @@ static void init_default_table_values(struct pm8001_hba_info *pm8001_ha)
>                         pm8001_ha->inbnd_q_tbl[i].pi_pci_bar,
>                         pm8001_ha->inbnd_q_tbl[i].pi_offset));
>         }
> -       for (i = 0; i < PM8001_MAX_SPCV_OUTB_NUM; i++) {
> +       for (i = 0; i < pm8001_ha->max_q_num; i++) {
>                 pm8001_ha->outbnd_q_tbl[i].element_size_cnt     =
>                         PM8001_MPI_QUEUE | (pm8001_ha->iomb_size << 16) | (0x01<<30);
>                 pm8001_ha->outbnd_q_tbl[i].upper_base_addr      =
> -                       pm8001_ha->memoryMap.region[OB + i].phys_addr_hi;
> +                       pm8001_ha->memoryMap.region[ob_offset + i].phys_addr_hi;
>                 pm8001_ha->outbnd_q_tbl[i].lower_base_addr      =
> -                       pm8001_ha->memoryMap.region[OB + i].phys_addr_lo;
> +                       pm8001_ha->memoryMap.region[ob_offset + i].phys_addr_lo;
>                 pm8001_ha->outbnd_q_tbl[i].base_virt            =
> -                       (u8 *)pm8001_ha->memoryMap.region[OB + i].virt_ptr;
> +                 (u8 *)pm8001_ha->memoryMap.region[ob_offset + i].virt_ptr;
>                 pm8001_ha->outbnd_q_tbl[i].total_length         =
> -                       pm8001_ha->memoryMap.region[OB + i].total_len;
> +                       pm8001_ha->memoryMap.region[ob_offset + i].total_len;
>                 pm8001_ha->outbnd_q_tbl[i].pi_upper_base_addr   =
> -                       pm8001_ha->memoryMap.region[PI + i].phys_addr_hi;
> +                       pm8001_ha->memoryMap.region[pi_offset + i].phys_addr_hi;
>                 pm8001_ha->outbnd_q_tbl[i].pi_lower_base_addr   =
> -                       pm8001_ha->memoryMap.region[PI + i].phys_addr_lo;
> +                       pm8001_ha->memoryMap.region[pi_offset + i].phys_addr_lo;
>                 /* interrupt vector based on oq */
>                 pm8001_ha->outbnd_q_tbl[i].interrup_vec_cnt_delay = (i << 24);
>                 pm8001_ha->outbnd_q_tbl[i].pi_virt              =
> -                       pm8001_ha->memoryMap.region[PI + i].virt_ptr;
> +                       pm8001_ha->memoryMap.region[pi_offset + i].virt_ptr;
>                 offsetob = i * 0x24;
>                 pm8001_ha->outbnd_q_tbl[i].ci_pci_bar           =
>                         get_pci_bar_index(pm8001_mr32(addressob,
> @@ -871,7 +875,7 @@ static void update_main_config_table(struct pm8001_hba_info *pm8001_ha)
>                 pm8001_ha->main_cfg_tbl.pm80xx_tbl.pcs_event_log_severity);
>         /* Update Fatal error interrupt vector */
>         pm8001_ha->main_cfg_tbl.pm80xx_tbl.fatal_err_interrupt |=
> -                                       ((pm8001_ha->number_of_intr - 1) << 8);
> +                                       ((pm8001_ha->max_q_num - 1) << 8);
>         pm8001_mw32(address, MAIN_FATAL_ERROR_INTERRUPT,
>                 pm8001_ha->main_cfg_tbl.pm80xx_tbl.fatal_err_interrupt);
>         PM8001_DEV_DBG(pm8001_ha, pm8001_printk(
> @@ -1010,8 +1014,12 @@ static int mpi_init_check(struct pm8001_hba_info *pm8001_ha)
>                 value &= SPCv_MSGU_CFG_TABLE_UPDATE;
>         } while ((value != 0) && (--max_wait_count));
>
> -       if (!max_wait_count)
> -               return -1;
> +       if (!max_wait_count) {
> +               /* additional check */
> +               PM8001_FAIL_DBG(pm8001_ha, pm8001_printk(
> +                       "Inb doorbell clear not toggled[value:%x]\n", value));
> +               return -EBUSY;
> +       }
>         /* check the MPI-State for initialization upto 100ms*/
>         max_wait_count = 100 * 1000;/* 100 msec */
>         do {
> @@ -1022,12 +1030,12 @@ static int mpi_init_check(struct pm8001_hba_info *pm8001_ha)
>         } while ((GST_MPI_STATE_INIT !=
>                 (gst_len_mpistate & GST_MPI_STATE_MASK)) && (--max_wait_count));
>         if (!max_wait_count)
> -               return -1;
> +               return -EBUSY;
>
>         /* check MPI Initialization error */
>         gst_len_mpistate = gst_len_mpistate >> 16;
>         if (0x0000 != gst_len_mpistate)
> -               return -1;
> +               return -EBUSY;
>
>         return 0;
>  }
> @@ -1469,11 +1477,10 @@ static int pm80xx_chip_init(struct pm8001_hba_info *pm8001_ha)
>
>         /* update main config table ,inbound table and outbound table */
>         update_main_config_table(pm8001_ha);
> -       for (i = 0; i < PM8001_MAX_SPCV_INB_NUM; i++)
> +       for (i = 0; i < pm8001_ha->max_q_num; i++) {
>                 update_inbnd_queue_table(pm8001_ha, i);
> -       for (i = 0; i < PM8001_MAX_SPCV_OUTB_NUM; i++)
>                 update_outbnd_queue_table(pm8001_ha, i);
> -
> +       }
>         /* notify firmware update finished and check initialization status */
>         if (0 == mpi_init_check(pm8001_ha)) {
>                 PM8001_INIT_DBG(pm8001_ha,
> @@ -4191,7 +4198,7 @@ static int process_oq(struct pm8001_hba_info *pm8001_ha, u8 vec)
>         unsigned long flags;
>         u32 regval;
>
> -       if (vec == (pm8001_ha->number_of_intr - 1)) {
> +       if (vec == (pm8001_ha->max_q_num - 1)) {
>                 regval = pm8001_cr32(pm8001_ha, 0, MSGU_SCRATCH_PAD_1);
>                 if ((regval & SCRATCH_PAD_MIPSALL_READY) !=
>                                         SCRATCH_PAD_MIPSALL_READY) {
> @@ -4274,6 +4281,7 @@ static int pm80xx_chip_smp_req(struct pm8001_hba_info *pm8001_ha,
>         char *preq_dma_addr = NULL;
>         __le64 tmp_addr;
>         u32 i, length;
> +       unsigned long flags;
>
>         memset(&smp_cmd, 0, sizeof(smp_cmd));
>         /*
> @@ -4369,8 +4377,10 @@ static int pm80xx_chip_smp_req(struct pm8001_hba_info *pm8001_ha,
>
>         build_smp_cmd(pm8001_dev->device_id, smp_cmd.tag,
>                                 &smp_cmd, pm8001_ha->smp_exp_mode, length);
> +       spin_lock_irqsave(&circularQ->iq_lock, flags);
>         rc = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &smp_cmd,
>                         sizeof(smp_cmd), 0);
> +       spin_unlock_irqrestore(&circularQ->iq_lock, flags);
>         if (rc)
>                 goto err_out_2;
>         return 0;
> @@ -4434,7 +4444,8 @@ static int pm80xx_chip_ssp_io_req(struct pm8001_hba_info *pm8001_ha,
>         u64 phys_addr, start_addr, end_addr;
>         u32 end_addr_high, end_addr_low;
>         struct inbound_queue_table *circularQ;
> -       u32 q_index;
> +       unsigned long flags;
> +       u32 q_index, cpu_id;
>         u32 opc = OPC_INB_SSPINIIOSTART;
>         memset(&ssp_cmd, 0, sizeof(ssp_cmd));
>         memcpy(ssp_cmd.ssp_iu.lun, task->ssp_task.LUN, 8);
> @@ -4453,7 +4464,8 @@ static int pm80xx_chip_ssp_io_req(struct pm8001_hba_info *pm8001_ha,
>         ssp_cmd.ssp_iu.efb_prio_attr |= (task->ssp_task.task_attr & 7);
>         memcpy(ssp_cmd.ssp_iu.cdb, task->ssp_task.cmd->cmnd,
>                        task->ssp_task.cmd->cmd_len);
> -       q_index = (u32) (pm8001_dev->id & 0x00ffffff) % PM8001_MAX_INB_NUM;
> +       cpu_id = smp_processor_id();
> +       q_index = (u32) (cpu_id) % (pm8001_ha->max_q_num);
>         circularQ = &pm8001_ha->inbnd_q_tbl[q_index];
>
>         /* Check if encryption is set */
> @@ -4576,9 +4588,10 @@ static int pm80xx_chip_ssp_io_req(struct pm8001_hba_info *pm8001_ha,
>                         ssp_cmd.esgl = 0;
>                 }
>         }
> -       q_index = (u32) (pm8001_dev->id & 0x00ffffff) % PM8001_MAX_OUTB_NUM;
> +       spin_lock_irqsave(&circularQ->iq_lock, flags);
>         ret = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc,
>                         &ssp_cmd, sizeof(ssp_cmd), q_index);
> +       spin_unlock_irqrestore(&circularQ->iq_lock, flags);
>         return ret;
>  }
>
> @@ -4590,7 +4603,7 @@ static int pm80xx_chip_sata_req(struct pm8001_hba_info *pm8001_ha,
>         struct pm8001_device *pm8001_ha_dev = dev->lldd_dev;
>         u32 tag = ccb->ccb_tag;
>         int ret;
> -       u32 q_index;
> +       u32 q_index, cpu_id;
>         struct sata_start_req sata_cmd;
>         u32 hdr_tag, ncg_tag = 0;
>         u64 phys_addr, start_addr, end_addr;
> @@ -4601,7 +4614,8 @@ static int pm80xx_chip_sata_req(struct pm8001_hba_info *pm8001_ha,
>         unsigned long flags;
>         u32 opc = OPC_INB_SATA_HOST_OPSTART;
>         memset(&sata_cmd, 0, sizeof(sata_cmd));
> -       q_index = (u32) (pm8001_ha_dev->id & 0x00ffffff) % PM8001_MAX_INB_NUM;
> +       cpu_id = smp_processor_id();
> +       q_index = (u32) (cpu_id) % (pm8001_ha->max_q_num);
>         circularQ = &pm8001_ha->inbnd_q_tbl[q_index];
>
>         if (task->data_dir == DMA_NONE) {
> @@ -4817,9 +4831,10 @@ static int pm80xx_chip_sata_req(struct pm8001_hba_info *pm8001_ha,
>                         }
>                 }
>         }
> -       q_index = (u32) (pm8001_ha_dev->id & 0x00ffffff) % PM8001_MAX_OUTB_NUM;
> +       spin_lock_irqsave(&circularQ->iq_lock, flags);
>         ret = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc,
>                         &sata_cmd, sizeof(sata_cmd), q_index);
> +       spin_unlock_irqrestore(&circularQ->iq_lock, flags);
>         return ret;
>  }
>
> --
> 2.16.3
>
