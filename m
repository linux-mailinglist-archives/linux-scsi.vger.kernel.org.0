Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE0A17628E
	for <lists+linux-scsi@lfdr.de>; Fri, 26 Jul 2019 11:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbfGZJuE (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 26 Jul 2019 05:50:04 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34590 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfGZJuD (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 26 Jul 2019 05:50:03 -0400
Received: by mail-pg1-f196.google.com with SMTP id n9so18307264pgc.1
        for <linux-scsi@vger.kernel.org>; Fri, 26 Jul 2019 02:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YLdfLrMSiT4KXAf/cjnjVZ2fM60YfkutQSVFLbjZHOQ=;
        b=cp4F4YKDtn8FmO7tNNvB1Zl3+soGtcVxxS1B3gZMO5dm5UHaIEj4ZvwJ49y/fcp7aF
         mYyqoW5O0g8Os9efZeigNDVGy3qdJDkXsKnCAGlnuMtVgVGJ6Jp5cDHrjpz8Id6GpWCS
         3ZdVi9q/2s4zkI6SjQEULEWmkQOnWdR5ZyDSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YLdfLrMSiT4KXAf/cjnjVZ2fM60YfkutQSVFLbjZHOQ=;
        b=mJLyOa1JKiu9oHVvi34jMQX/AYi26KMc0vYWv8LDMpXaSMBskLH25ZIhegp0vooGVy
         U1EmKd2vPkazdCats7rr04K9PHIo3vN5qYEwm8RSmM4Qvm3SGwQXD9Vg0yROF8yiKbHN
         YP0ctSpkXNICEb/4HT6mx5swE2rRqQVt85ChaSvtfAi3syA3oi3g/TsKsRjdHGaq6SaZ
         lGzzaCxiaC1kgHYuwhALCKFfHpi5gIjlDnJytSqibxQznEwSiF03VoUU5s5BTJ/28wYI
         KlDhM+WcXDK2P+4BoshktJn1XWb5spbAWb+ZUif6QbjfVM74Flo2DcScuB0xU/70f9sO
         /qhw==
X-Gm-Message-State: APjAAAXY2ivGrt5KSecblqB63nMI2w3GxwB2x1iPhnoC2UID5wn2JGGW
        2XGC4CzluTgXJuxHIziE5TTIyoZyscAH3cft+ZP82A==
X-Google-Smtp-Source: APXvYqw1c2xASRmY1awQwTYYEA2qAtfGkQi+5W6p4QqQ6+VOVIAsQpW0Ti3ZVLpjihaeVcD5W4AeV12h6Zw0qkafmD0=
X-Received: by 2002:a63:eb06:: with SMTP id t6mr85181196pgh.107.1564134601904;
 Fri, 26 Jul 2019 02:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190714034415epcms2p25f9787cb71993a30f58524d2f355b543@epcms2p2>
 <20190714034415epcms2p25f9787cb71993a30f58524d2f355b543@epcms2p2>
In-Reply-To: <20190714034415epcms2p25f9787cb71993a30f58524d2f355b543@epcms2p2>
From:   Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Date:   Fri, 26 Jul 2019 15:19:50 +0530
Message-ID: <CAK=zhgoqoTDZb=q9Cq7hC+RDNOC9GTKCnDdHeiPsYcKOaT8N6g@mail.gmail.com>
Subject: Re: [PATCH V2] mpt3sas: support target smid for [abort|query] task
To:     minwoo.im@samsung.com
Cc:     "sathya.prakash@broadcom.com" <sathya.prakash@broadcom.com>,
        "suganath-prabu.subramani@broadcom.com" 
        <suganath-prabu.subramani@broadcom.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "MPT-FusionLinux.pdl@broadcom.com" <MPT-FusionLinux.pdl@broadcom.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Euihyeok Kwon <eh81.kwon@samsung.com>,
        Sarah Cho <sohyeon.jo@samsung.com>,
        Sanggwan Lee <sanggwan.lee@samsung.com>,
        Gyeongmin Nam <gm.nam@samsung.com>,
        Sungjun Park <sj1228.park@samsung.com>,
        "minwoo.im.dev@gmail.com" <minwoo.im.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sun, Jul 14, 2019 at 9:14 AM Minwoo Im <minwoo.im@samsung.com> wrote:
>
> We can request task management IOCTL command(MPI2_FUNCTION_SCSI_TASK_MGMT)
> to /dev/mpt3ctl.  If the given task_type is either abort task or query
> task, it may need a field named "Initiator Port Transfer Tag to Manage"
> in the IU.
>
> Current code does not support to check target IPTT tag from the
> tm_request.  This patch introduces to check TaskMID given from the
> userspace as a target tag.  We have a rule of relationship between
> (struct request *req->tag) and smid in mpt3sas_base.c:
>
> 3318 u16
> 3319 mpt3sas_base_get_smid_scsiio(struct MPT3SAS_ADAPTER *ioc, u8 cb_idx,
> 3320         struct scsi_cmnd *scmd)
> 3321 {
> 3322         struct scsiio_tracker *request = scsi_cmd_priv(scmd);
> 3323         unsigned int tag = scmd->request->tag;
> 3324         u16 smid;
> 3325
> 3326         smid = tag + 1;
>
> So if we want to abort a request tagged #X, then we can pass (X + 1) to
> this IOCTL handler.  Otherwise, user space just can pass 0 TaskMID to
> abort the first outstanding smid which is legacy behaviour.
>
> Cc: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
> Cc: Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
> Cc: Sathya Prakash <sathya.prakash@broadcom.com>
> Cc: James E.J. Bottomley <jejb@linux.ibm.com>
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: MPT-FusionLinux.pdl@broadcom.com
> Signed-off-by: Minwoo Im <minwoo.im@samsung.com>

Acked-by:  Sreekanth Reddy <sreekanth.reddy@broadcom.com>

> ---
>  drivers/scsi/mpt3sas/mpt3sas_ctl.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
> index b2bb47c14d35..f6b8fd90610a 100644
> --- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
> +++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
> @@ -596,8 +596,16 @@ _ctl_set_task_mid(struct MPT3SAS_ADAPTER *ioc, struct mpt3_ioctl_command *karg,
>                 if (priv_data->sas_target->handle != handle)
>                         continue;
>                 st = scsi_cmd_priv(scmd);
> -               tm_request->TaskMID = cpu_to_le16(st->smid);
> -               found = 1;
> +
> +               /*
> +                * If the given TaskMID from the user space is zero, then the
> +                * first outstanding smid will be picked up.  Otherwise,
> +                * targeted smid will be the one.
> +                */
> +               if (!tm_request->TaskMID || tm_request->TaskMID == st->smid) {
> +                       tm_request->TaskMID = cpu_to_le16(st->smid);
> +                       found = 1;
> +               }
>         }
>
>         if (!found) {
> --
> 2.16.1
>
