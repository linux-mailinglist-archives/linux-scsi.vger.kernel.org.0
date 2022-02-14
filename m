Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A2A4B5C4E
	for <lists+linux-scsi@lfdr.de>; Mon, 14 Feb 2022 22:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbiBNVFS (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 14 Feb 2022 16:05:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiBNVFL (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 14 Feb 2022 16:05:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9879B1074F6
        for <linux-scsi@vger.kernel.org>; Mon, 14 Feb 2022 13:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644872701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QFa/C7hsD8TBo2bxq6Ox7fdMRVM3Jlm+WFaGNTtn3oU=;
        b=VjHKylAhYU10PDxm0/Q+OKMSgOuYOPc1293q95cHd2SrS284/g9XdL0Hp7brpejo/IU2bE
        lo3+5QzrMIbVWBQmPZrSN5IqEfpZhVlyC37ZQpwl8WV8RoNDw2wWs3HU3iEWOdO0eVVJ4o
        2QWxE/s5Dnhq4ynq74U43TVe19MYt7Y=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-199-apTHjW__Nymgn2RFSkZ_4A-1; Mon, 14 Feb 2022 15:46:45 -0500
X-MC-Unique: apTHjW__Nymgn2RFSkZ_4A-1
Received: by mail-lj1-f197.google.com with SMTP id bx17-20020a05651c199100b00244b2f9b56cso2277102ljb.22
        for <linux-scsi@vger.kernel.org>; Mon, 14 Feb 2022 12:46:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QFa/C7hsD8TBo2bxq6Ox7fdMRVM3Jlm+WFaGNTtn3oU=;
        b=DAUQRlriNQmrQ6h+oFW0COSkHbcv1nY5PF0S6ZR4ldJdbHzIMJrTxlA3XCVn6GxW6h
         DZB8O3omnPX6ztNtqCER/E9TiaXn5NM0ienlyfiiOmaeTsInGgL/uCZkTaYsBgIgTV9X
         nsALHU0d6wfjZ7wWQVJqtOMkpqDL5R/84brEDBGvjmqVcvV3Le8x0GuUjdjaP+Gde05v
         sEouPeG0yxVvODLqCnwh7nA+UcV5utGoW2U3XPoq8EB7/cQpri4pQZxu+kPB01I2Arg2
         QnlwVoFczKNBEhny36YPBDddGrYTgMdFv0k9//a6jUNz/hscu/kj+S+8t4QtZS7JZUy3
         1CrA==
X-Gm-Message-State: AOAM533f5nIg3LAAliPRUvNmbxCfOWmB8/0wm0zUybDcH1uE49kWx3Af
        exKZ2jCjeiuQ5QAA7JEVzRzV1laPC54XRdfQ7/dyLIGdwMQekOuhDzGY3cYYVAAsdwGd5u3Vc+T
        rcn4CITbNco7JIQDy/IrKWN89qXNUS4sbteQdTw==
X-Received: by 2002:a05:6512:33d3:: with SMTP id d19mr594972lfg.455.1644871603871;
        Mon, 14 Feb 2022 12:46:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyf+IwspQH45HUHccmqR4itV/B2LG276Q0jZmyCIx4fEZ4V+USy5abuLeg0hpTeAygEHqjtweiD484igQaq9wQ=
X-Received: by 2002:a05:6512:33d3:: with SMTP id d19mr594952lfg.455.1644871603588;
 Mon, 14 Feb 2022 12:46:43 -0800 (PST)
MIME-Version: 1.0
References: <20220212163120.15385-1-jsmart2021@gmail.com>
In-Reply-To: <20220212163120.15385-1-jsmart2021@gmail.com>
From:   Ewan Milne <emilne@redhat.com>
Date:   Mon, 14 Feb 2022 15:46:32 -0500
Message-ID: <CAGtn9rmu2yA6hyyHMMvg_EAR+rXdMMWF=D03kRkv8U99ncsJDQ@mail.gmail.com>
Subject: Re: [PATCH] lpfc: fix pt2pt nvme PRLI reject LOGO loop
To:     James Smart <jsmart2021@gmail.com>
Cc:     linux-scsi@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Reviewed-by: Ewan D. Milne <emilne@redhat.com>

On Sat, Feb 12, 2022 at 11:32 AM James Smart <jsmart2021@gmail.com> wrote:
>
> When connected point to point, the driver does not know the FC4's
> supported by the other end. In Fabrics, it can query the nameserver.
> Thus the driver must send PRLI's for the FC4s it supports and enable
> support based on the acc(ept) or rej(ect) of the respective FC4 PRLI.
> Currently the driver supports SCSI and NVMe PRLI's.
>
> Unfortunately, although the behavior is per standard, many devices
> have come to expect only SCSI PRLI's. In this particular example, the
> NVMe PRLI is properly RJT'd but the target decided that it must LOGO after
> seeing the unexpected NVMe PRLI. The LOGO causes the sequence to restart
> and login is now in an infinite failure loop.
>
> Fix the problem by having the driver, on a pt2pt link, remember NVMe PRLI
> accept or reject status across logout as long as the link stays "up".
> When retrying login, if the prior NVMe PRLI was rejected, it will not be
> sent on the next login.
>
> Cut against 5.18/scsi-queue
>
> Cc: <stable@vger.kernel.org> # v5.4+
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> ---
>  drivers/scsi/lpfc/lpfc.h           |  1 +
>  drivers/scsi/lpfc/lpfc_attr.c      |  3 +++
>  drivers/scsi/lpfc/lpfc_els.c       | 20 +++++++++++++++++++-
>  drivers/scsi/lpfc/lpfc_nportdisc.c |  5 +++--
>  4 files changed, 26 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
> index a1e0a106c132..98cabe09c040 100644
> --- a/drivers/scsi/lpfc/lpfc.h
> +++ b/drivers/scsi/lpfc/lpfc.h
> @@ -592,6 +592,7 @@ struct lpfc_vport {
>  #define FC_VPORT_LOGO_RCVD      0x200    /* LOGO received on vport */
>  #define FC_RSCN_DISCOVERY       0x400   /* Auth all devices after RSCN */
>  #define FC_LOGO_RCVD_DID_CHNG   0x800    /* FDISC on phys port detect DID chng*/
> +#define FC_PT2PT_NO_NVME        0x1000   /* Don't send NVME PRLI */
>  #define FC_SCSI_SCAN_TMO        0x4000  /* scsi scan timer running */
>  #define FC_ABORT_DISCOVERY      0x8000  /* we want to abort discovery */
>  #define FC_NDISC_ACTIVE         0x10000         /* NPort discovery active */
> diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
> index bac78fbce8d6..fa8415259cb8 100644
> --- a/drivers/scsi/lpfc/lpfc_attr.c
> +++ b/drivers/scsi/lpfc/lpfc_attr.c
> @@ -1315,6 +1315,9 @@ lpfc_issue_lip(struct Scsi_Host *shost)
>         pmboxq->u.mb.mbxCommand = MBX_DOWN_LINK;
>         pmboxq->u.mb.mbxOwner = OWN_HOST;
>
> +       if ((vport->fc_flag & FC_PT2PT) && (vport->fc_flag & FC_PT2PT_NO_NVME))
> +               vport->fc_flag &= ~FC_PT2PT_NO_NVME;
> +
>         mbxstatus = lpfc_sli_issue_mbox_wait(phba, pmboxq, LPFC_MBOX_TMO * 2);
>
>         if ((mbxstatus == MBX_SUCCESS) &&
> diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
> index db5ccae1b63d..f936833c9909 100644
> --- a/drivers/scsi/lpfc/lpfc_els.c
> +++ b/drivers/scsi/lpfc/lpfc_els.c
> @@ -1072,7 +1072,8 @@ lpfc_cmpl_els_flogi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
>
>                 /* FLOGI failed, so there is no fabric */
>                 spin_lock_irq(shost->host_lock);
> -               vport->fc_flag &= ~(FC_FABRIC | FC_PUBLIC_LOOP);
> +               vport->fc_flag &= ~(FC_FABRIC | FC_PUBLIC_LOOP |
> +                                   FC_PT2PT_NO_NVME);
>                 spin_unlock_irq(shost->host_lock);
>
>                 /* If private loop, then allow max outstanding els to be
> @@ -4607,6 +4608,23 @@ lpfc_els_retry(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
>                 /* Added for Vendor specifc support
>                  * Just keep retrying for these Rsn / Exp codes
>                  */
> +               if ((vport->fc_flag & FC_PT2PT) &&
> +                   cmd == ELS_CMD_NVMEPRLI) {
> +                       switch (stat.un.b.lsRjtRsnCode) {
> +                       case LSRJT_UNABLE_TPC:
> +                       case LSRJT_INVALID_CMD:
> +                       case LSRJT_LOGICAL_ERR:
> +                       case LSRJT_CMD_UNSUPPORTED:
> +                               lpfc_printf_vlog(vport, KERN_WARNING, LOG_ELS,
> +                                                "0168 NVME PRLI LS_RJT "
> +                                                "reason %x port doesn't "
> +                                                "support NVME, disabling NVME\n",
> +                                                stat.un.b.lsRjtRsnCode);
> +                               retry = 0;
> +                               vport->fc_flag |= FC_PT2PT_NO_NVME;
> +                               goto out_retry;
> +                       }
> +               }
>                 switch (stat.un.b.lsRjtRsnCode) {
>                 case LSRJT_UNABLE_TPC:
>                         /* The driver has a VALID PLOGI but the rport has
> diff --git a/drivers/scsi/lpfc/lpfc_nportdisc.c b/drivers/scsi/lpfc/lpfc_nportdisc.c
> index 7d717a4ac14d..fdf5e777bf11 100644
> --- a/drivers/scsi/lpfc/lpfc_nportdisc.c
> +++ b/drivers/scsi/lpfc/lpfc_nportdisc.c
> @@ -1961,8 +1961,9 @@ lpfc_cmpl_reglogin_reglogin_issue(struct lpfc_vport *vport,
>                          * is configured try it.
>                          */
>                         ndlp->nlp_fc4_type |= NLP_FC4_FCP;
> -                       if ((vport->cfg_enable_fc4_type == LPFC_ENABLE_BOTH) ||
> -                           (vport->cfg_enable_fc4_type == LPFC_ENABLE_NVME)) {
> +                       if ((!(vport->fc_flag & FC_PT2PT_NO_NVME)) &&
> +                           (vport->cfg_enable_fc4_type == LPFC_ENABLE_BOTH ||
> +                           vport->cfg_enable_fc4_type == LPFC_ENABLE_NVME)) {
>                                 ndlp->nlp_fc4_type |= NLP_FC4_NVME;
>                                 /* We need to update the localport also */
>                                 lpfc_nvme_update_localport(vport);
> --
> 2.26.2
>

