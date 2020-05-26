Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B931ABF41
	for <lists+linux-scsi@lfdr.de>; Thu, 16 Apr 2020 13:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633318AbgDPLbo (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 16 Apr 2020 07:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506318AbgDPLbb (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 16 Apr 2020 07:31:31 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7A1C061A0C
        for <linux-scsi@vger.kernel.org>; Thu, 16 Apr 2020 04:31:30 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id f3so20687097ioj.1
        for <linux-scsi@vger.kernel.org>; Thu, 16 Apr 2020 04:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mUSnG0Ya6qMFU5CuR5R18Syz+9lEY5xc41Z0O54p8tg=;
        b=F382OoCnA4w62U1Dq4fSZpfkLv//mcRvaH8mgN/rBTMxmvPk/iu0BSX44SHPJ1Ctur
         G9YKMENtgTo5KpUi+umuELacsnn98BvX/BU6lpfMPVIvtFrparCNmRSCDJgTI/WK5Q4W
         aLZu7Zy6JQ9wTjGa7POQRD+KSlmkM3RR1MyyId1yUMXJYZCYCR9e/ye4bWPXfM0CDq4i
         li3pFQVVIlTrJAWDS2AMVhnsGwr/kIwW037O4UCQYuuMaAQJx1ZdT5hUtPvAuvQ2nGOt
         OBXyfN5LWKwN7tGOW2b5rz/r4C0ue+sZLq+7BYIW2WIOfvNHilIsNvy8qnAyUVMajCHE
         I3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mUSnG0Ya6qMFU5CuR5R18Syz+9lEY5xc41Z0O54p8tg=;
        b=Hwrqva7qR2Bjlnp6fTqff7HaLphyK20MroKGClhskmr4lzgxhcQcDNp/5kjMkBxvdE
         pDGf90LjWivkjwEscvEvN7o9UvKPZt3l9pz/sBa5Y/DKocaedx2h5X2evuaQ2UFBw2g9
         1KwydUMJE0VC8D7+rV/DHEefhu7cZ7m6MJ6vwzSdaYhYmfVaKeolfHu6VHmODlREqy0Q
         XpuUNbguWYgngI3FS9K0y1UxEliGAd0psp+zOfdT1f3BXAvCzq/dQRVOSXTqyphlJSAv
         X3nX65QFdtDDaOU6WsiBa00Tte9xdeWD3v0jihp0fP6nASUDE8oKuurhDOdMj0uaV1Yx
         CHWg==
X-Gm-Message-State: AGi0PuYTtV3+8ubTZzflZL1dvnDLNOHNbhs3skQCEcq9ktihqvtd45uU
        oTr6CpfMBBzzBDBDSdNPAp7HCHQG3Jeg3sYZbiNtYg==
X-Google-Smtp-Source: APiQypKLBcdIq/FcUcVRffs67E5KMJOQisScjOUqEnecHX4Vv5fMFFhEZqkXzFtgyRvnjayqqhiX/tKJjjh8Cq6UPY0=
X-Received: by 2002:a02:a517:: with SMTP id e23mr29269786jam.56.1587036689424;
 Thu, 16 Apr 2020 04:31:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200413094938.6182-1-deepak.ukey@microchip.com> <20200413094938.6182-2-deepak.ukey@microchip.com>
In-Reply-To: <20200413094938.6182-2-deepak.ukey@microchip.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Thu, 16 Apr 2020 13:31:18 +0200
Message-ID: <CAMGffEnsrmvBKLnVJei+wkp=N3nOFhqGkZoLDkb4WM6Np-N+qA@mail.gmail.com>
Subject: Re: [PATCH 1/3] pm80xx : Support for get phy profile functionality.
To:     Deepak Ukey <deepak.ukey@microchip.com>
Cc:     Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        Vasanthalakshmi.Tharmarajan@microchip.com,
        Viswas G <Viswas.G@microchip.com>,
        Jinpu Wang <jinpu.wang@profitbricks.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>, dpf@google.com,
        yuuzheng@google.com, Vikram Auradkar <auradkar@google.com>,
        vishakhavc@google.com, bjashnani@google.com,
        Radha Ramachandran <radha@google.com>, akshatzen@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, Apr 13, 2020 at 11:40 AM Deepak Ukey <deepak.ukey@microchip.com> wrote:
>
> From: Viswas G <Viswas.G@microchip.com>
>
> Added the support to get the phy profile which gives information
> about the phy states, port and errors on phy.
>
> Signed-off-by: Deepak Ukey <deepak.ukey@microchip.com>
> Signed-off-by: Viswas G <Viswas.G@microchip.com>
> Signed-off-by: Radha Ramachandran <radha@google.com>

Hi,

I failed to find where do you initialize the phyprofile_completion,
did I miss something?

Thanks!
Jinpu

> ---
>  drivers/scsi/pm8001/pm8001_ctl.h  | 27 +++++++++++++
>  drivers/scsi/pm8001/pm8001_init.c |  1 +
>  drivers/scsi/pm8001/pm8001_sas.c  |  1 +
>  drivers/scsi/pm8001/pm8001_sas.h  |  5 +++
>  drivers/scsi/pm8001/pm80xx_hwi.c  | 82 ++++++++++++++++++++++++++++++++++++++-
>  drivers/scsi/pm8001/pm80xx_hwi.h  |  2 +
>  6 files changed, 116 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/scsi/pm8001/pm8001_ctl.h b/drivers/scsi/pm8001/pm8001_ctl.h
> index d0d43a250b9e..5a1cbd54164c 100644
> --- a/drivers/scsi/pm8001/pm8001_ctl.h
> +++ b/drivers/scsi/pm8001/pm8001_ctl.h
> @@ -41,6 +41,33 @@
>  #ifndef PM8001_CTL_H_INCLUDED
>  #define PM8001_CTL_H_INCLUDED
>
> +struct phy_profile {
> +       char            phy_id;
> +       unsigned int    phy_state:4;
> +       unsigned int    nlr:4;
> +       unsigned int    plr:4;
> +       unsigned int    reserved1:12;
> +       unsigned char   port_id;
> +       unsigned int    prts:4;
> +       unsigned int    reserved2:20;
> +} __packed;
> +
> +struct phy_errcnt {
> +       unsigned int    InvalidDword;
> +       unsigned int    runningDisparityError;
> +       unsigned int    codeViolation;
> +       unsigned int    LossOfSyncDW;
> +       unsigned int    phyResetProblem;
> +       unsigned int    inboundCRCError;
> +};
> +
> +struct phy_prof_resp {
> +       union {
> +               struct phy_profile status;
> +               struct phy_errcnt errcnt;
> +       } phy;
> +};
> +
>  #define IOCTL_BUF_SIZE         4096
>  #define HEADER_LEN                     28
>  #define SIZE_OFFSET                    16
> diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
> index a8f5344fdfda..68005d0cb33d 100644
> --- a/drivers/scsi/pm8001/pm8001_init.c
> +++ b/drivers/scsi/pm8001/pm8001_init.c
> @@ -502,6 +502,7 @@ static struct pm8001_hba_info *pm8001_pci_alloc(struct pci_dev *pdev,
>         else
>                 pm8001_ha->iomb_size = IOMB_SIZE_SPC;
>
> +       pm8001_ha->phyprofile_completion = NULL;
>  #ifdef PM8001_USE_TASKLET
>         /* Tasklet for non msi-x interrupt handler */
>         if ((!pdev->msix_cap || !pci_msi_enabled())
> diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
> index b7cbc312843e..3a69d8d1d52e 100644
> --- a/drivers/scsi/pm8001/pm8001_sas.c
> +++ b/drivers/scsi/pm8001/pm8001_sas.c
> @@ -283,6 +283,7 @@ int pm8001_scan_finished(struct Scsi_Host *shost, unsigned long time)
>         * is empirically about all it takes) */
>         if (time < HZ)
>                 return 0;
> +
>         /* Wait for discovery to finish */
>         sas_drain_work(ha);
>         return 1;
> diff --git a/drivers/scsi/pm8001/pm8001_sas.h b/drivers/scsi/pm8001/pm8001_sas.h
> index ae7ba9b3c4bc..cba4e9b95c58 100644
> --- a/drivers/scsi/pm8001/pm8001_sas.h
> +++ b/drivers/scsi/pm8001/pm8001_sas.h
> @@ -56,6 +56,7 @@
>  #include <scsi/sas_ata.h>
>  #include <linux/atomic.h>
>  #include "pm8001_defs.h"
> +#include "pm8001_ctl.h"
>
>  #define DRV_NAME               "pm80xx"
>  #define DRV_VERSION            "0.1.39"
> @@ -244,6 +245,8 @@ struct pm8001_dispatch {
>         int (*sas_diag_execute_req)(struct pm8001_hba_info *pm8001_ha,
>                 u32 state);
>         int (*sas_re_init_req)(struct pm8001_hba_info *pm8001_ha);
> +       int (*get_phy_profile_req)(struct pm8001_hba_info *pm8001_ha,
> +               int phy, int page);
>  };
>
>  struct pm8001_chip_info {
> @@ -561,6 +564,8 @@ struct pm8001_hba_info {
>         u32                     reset_in_progress;
>         u32                     non_fatal_count;
>         u32                     non_fatal_read_length;
> +       struct completion       *phyprofile_completion;
> +       struct phy_prof_resp    phy_profile_resp;
>  };
>
>  struct pm8001_work {
> diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
> index 4d205ebaee87..0f4f18b0e480 100644
> --- a/drivers/scsi/pm8001/pm80xx_hwi.c
> +++ b/drivers/scsi/pm8001/pm80xx_hwi.c
> @@ -3792,7 +3792,6 @@ static int mpi_set_controller_config_resp(struct pm8001_hba_info *pm8001_ha,
>         PM8001_MSG_DBG(pm8001_ha, pm8001_printk(
>                         "SET CONTROLLER RESP: status 0x%x qlfr_pgcd 0x%x\n",
>                         status, err_qlfr_pgcd));
> -
>         return 0;
>  }
>
> @@ -3818,9 +3817,59 @@ static int mpi_get_controller_config_resp(struct pm8001_hba_info *pm8001_ha,
>  static int mpi_get_phy_profile_resp(struct pm8001_hba_info *pm8001_ha,
>                         void *piomb)
>  {
> +       u32 tag, page_code;
> +       struct phy_profile *phy_profile, *phy_prof;
> +       struct phy_errcnt *phy_err, *phy_err_cnt;
> +       struct get_phy_profile_resp *pPayload =
> +               (struct get_phy_profile_resp *)(piomb + 4);
> +       u32 status = le32_to_cpu(pPayload->status);
> +
> +       page_code = (u8)((pPayload->ppc_phyid & 0xFF00) >> 8);
> +
>         PM8001_MSG_DBG(pm8001_ha,
> -                       pm8001_printk(" pm80xx_addition_functionality\n"));
> +               pm8001_printk(" pm80xx_addition_functionality\n"));
> +       if (status) {
> +               /* status is FAILED */
> +               PM8001_FAIL_DBG(pm8001_ha, pm8001_printk(
> +                       "mpiGetPhyProfileReq failed  with status 0x%08x\n",
> +                       status));
> +       }
>
> +       tag = le32_to_cpu(pPayload->tag);
> +       if (pm8001_ha->phyprofile_completion != NULL) {
> +               if (status) {
> +                       /* signal fail status */
> +                       memset(&pm8001_ha->phy_profile_resp, 0xff,
> +                                       sizeof(pm8001_ha->phy_profile_resp));
> +               } else if (page_code == SAS_PHY_GENERAL_STATUS_PAGE) {
> +                       phy_profile =
> +                       (struct phy_profile *)&pm8001_ha->phy_profile_resp;
> +                       phy_prof =
> +                       (struct phy_profile *)pPayload->ppc_specific_rsp;
> +                       phy_profile->phy_id = le32_to_cpu(phy_prof->phy_id);
> +                       phy_profile->phy_state =
> +                                       le32_to_cpu(phy_prof->phy_state);
> +                       phy_profile->plr = le32_to_cpu(phy_prof->plr);
> +                       phy_profile->nlr = le32_to_cpu(phy_prof->nlr);
> +                       phy_profile->port_id = le32_to_cpu(phy_prof->port_id);
> +                       phy_profile->prts = le32_to_cpu(phy_prof->prts);
> +               } else if (page_code == SAS_PHY_ERR_COUNTERS_PAGE) {
> +                       phy_err =
> +                       (struct phy_errcnt *)&pm8001_ha->phy_profile_resp;
> +                       phy_err_cnt =
> +                       (struct phy_errcnt *)pPayload->ppc_specific_rsp;
> +                       phy_err->InvalidDword =
> +                       le32_to_cpu(phy_err_cnt->InvalidDword);
> +                       phy_err->runningDisparityError =
> +                       le32_to_cpu(phy_err_cnt->runningDisparityError);
> +                       phy_err->LossOfSyncDW =
> +                       le32_to_cpu(phy_err_cnt->LossOfSyncDW);
> +                       phy_err->phyResetProblem =
> +                       le32_to_cpu(phy_err_cnt->phyResetProblem);
> +               }
> +               complete(pm8001_ha->phyprofile_completion);
> +       }
> +       pm8001_tag_free(pm8001_ha, tag);
>         return 0;
>  }
>
> @@ -5013,6 +5062,34 @@ pm80xx_chip_isr(struct pm8001_hba_info *pm8001_ha, u8 vec)
>         return IRQ_HANDLED;
>  }
>
> +int pm8001_chip_get_phy_profile(struct pm8001_hba_info *pm8001_ha,
> +               int phy_id, int page_code)
> +{
> +
> +       u32 tag;
> +       struct get_phy_profile_req payload;
> +       struct inbound_queue_table *circularQ;
> +       int rc, ppc_phyid;
> +       u32 opc = OPC_INB_GET_PHY_PROFILE;
> +
> +       memset(&payload, 0, sizeof(payload));
> +
> +       rc = pm8001_tag_alloc(pm8001_ha, &tag);
> +       if (rc)
> +               PM8001_FAIL_DBG(pm8001_ha, pm8001_printk("Invalid tag\n"));
> +
> +       circularQ = &pm8001_ha->inbnd_q_tbl[0];
> +
> +       payload.tag = cpu_to_le32(tag);
> +       ppc_phyid = (page_code & 0xFF)  << 8 | (phy_id & 0xFF);
> +       payload.ppc_phyid = cpu_to_le32(ppc_phyid);
> +
> +       pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &payload,
> +                       sizeof(payload), 0);
> +
> +       return rc;
> +}
> +
>  void mpi_set_phy_profile_req(struct pm8001_hba_info *pm8001_ha,
>         u32 operation, u32 phyid, u32 length, u32 *buf)
>  {
> @@ -5113,4 +5190,5 @@ const struct pm8001_dispatch pm8001_80xx_dispatch = {
>         .set_nvmd_req           = pm8001_chip_set_nvmd_req,
>         .fw_flash_update_req    = pm8001_chip_fw_flash_update_req,
>         .set_dev_state_req      = pm8001_chip_set_dev_state_req,
> +       .get_phy_profile_req    = pm8001_chip_get_phy_profile,
>  };
> diff --git a/drivers/scsi/pm8001/pm80xx_hwi.h b/drivers/scsi/pm8001/pm80xx_hwi.h
> index 701951a0f715..b5119c5479da 100644
> --- a/drivers/scsi/pm8001/pm80xx_hwi.h
> +++ b/drivers/scsi/pm8001/pm80xx_hwi.h
> @@ -175,7 +175,9 @@
>  #define PHY_STOP_ERR_DEVICE_ATTACHED   0x1046
>
>  /* phy_profile */
> +#define SAS_PHY_ERR_COUNTERS_PAGE      0x01
>  #define SAS_PHY_ANALOG_SETTINGS_PAGE   0x04
> +#define SAS_PHY_GENERAL_STATUS_PAGE    0x05
>  #define PHY_DWORD_LENGTH               0xC
>
>  /* Thermal related */
> --
> 2.16.3
>
