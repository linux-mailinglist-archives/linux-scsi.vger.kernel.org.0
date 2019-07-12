Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5A266918
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jul 2019 10:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbfGLIZ7 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 12 Jul 2019 04:25:59 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33083 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfGLIZ7 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 12 Jul 2019 04:25:59 -0400
Received: by mail-pg1-f196.google.com with SMTP id m4so4218303pgk.0
        for <linux-scsi@vger.kernel.org>; Fri, 12 Jul 2019 01:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/RTxoumVNtB1PBld0antS4Z7J0pCK7ZhiGq0s+u+T8Q=;
        b=BAFql+HaVxohUfVl9mYP/S5YzuA9cwdMGK2nCDIC66akftcSMq/vzOqHPsPfc6/6QO
         3jbIxFLWL9RGB511maoma3UoAL51vux8VnJePTL/VCgMZPr6RxN5Bw1+YMc/2Gt+m8we
         3O5VAqNXBto7Ij4ZOE6HDlreMkSzh4Wj+AQqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/RTxoumVNtB1PBld0antS4Z7J0pCK7ZhiGq0s+u+T8Q=;
        b=gXLdnVV3GVhG3vOh4AuOhpA7B7M0DuamVYgjpkdDYl3lnCP21JTB9tfD/V+RipLGtY
         RPRyPdbVVQrijAhO95Bd/NjEJHpk3CuCwsr8nVfR0uy7NmGboQt9EXlyUiNaCg99JzAD
         dN0ns+2XwFNIJLZzdH9b+oxxEu+WotSNF53T6PopOESS9332fWS6TPZ97Mdcul2HNYMB
         z4UmtNQNX6LW8FKriTkV1rxcWjI3STgvqCutUCk+ygyePEG+J/IhF4S5egYJkE5L08tk
         YXOxBwgwUymH5UAZcn0DRBtQclEqcQ3/uEau1ivdbnP8GdfE6Z5yXUKFRexexVrQVEPL
         qazA==
X-Gm-Message-State: APjAAAXGyfcMYbx117BJEMzaQAleE0kdgGTycEDDYG8TE0auMly+NJBs
        rLSgWoO4DdOaWCPnxfYVvkr0IMAyYJeOQfF0BK+5uA==
X-Google-Smtp-Source: APXvYqwAnknqjQvGUnrEC5ubqLeQGMCESFeladMIiOfwXF9UrCGRG+5+L2hqDm0nBHA51jOduboUlYnwqXtHNbzKgbU=
X-Received: by 2002:a17:90a:ac14:: with SMTP id o20mr10306970pjq.114.1562919958370;
 Fri, 12 Jul 2019 01:25:58 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190621063708epcms2p309f4173afabe5de28942ba15d13987f7@epcms2p3>
 <20190621063708epcms2p309f4173afabe5de28942ba15d13987f7@epcms2p3>
In-Reply-To: <20190621063708epcms2p309f4173afabe5de28942ba15d13987f7@epcms2p3>
From:   Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Date:   Fri, 12 Jul 2019 13:55:47 +0530
Message-ID: <CAK=zhgr_T8vA=BCdFCT37RxGCgS3xr8Wp9MEMK_9nZ=oYHy=7Q@mail.gmail.com>
Subject: Re: [RESEND RFC PATCH] mpt3sas: support target smid for [abort|query] task
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
        Gyeongmin Nam <gm.nam@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, Jun 21, 2019 at 12:07 PM Minwoo Im <minwoo.im@samsung.com> wrote:
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
> this IOCTL handler.
>
> Cc: Sathya Prakash <sathya.prakash@broadcom.com>
> Cc: Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
> Cc: James E.J. Bottomley <jejb@linux.ibm.com>
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: MPT-FusionLinux.pdl@broadcom.com
> Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
> ---
>  drivers/scsi/mpt3sas/mpt3sas_ctl.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
> index b2bb47c14d35..5c7539dae713 100644
> --- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
> +++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
> @@ -596,15 +596,17 @@ _ctl_set_task_mid(struct MPT3SAS_ADAPTER *ioc, struct mpt3_ioctl_command *karg,
>                 if (priv_data->sas_target->handle != handle)
>                         continue;
>                 st = scsi_cmd_priv(scmd);
> -               tm_request->TaskMID = cpu_to_le16(st->smid);
> -               found = 1;
> +               if (tm_request->TaskMID == st->smid) {

I think it will difficult for the user to find the smid that he want
to abort. For this user has to enable the scsi logging level and get
the tag and pass the ioctl with tag +1 value in TaskMID field. And
hence currently driver will loop over all the smid's and if it fines
any outstanding smid then it will issue task abort or task query TM
for this outstanding smid to the HBA firmware.

May be we can do like below,
* First check whether user provided "TaskMID" is non zero or not. if
user provided TaskMID is non-zero and if this TaskMID is outstanding
then driver will issue TaskAbort/QueryTask TM with this TaskMID value
else driver will loop over all the smid's and if finds any smid is
outstanding then it will issue TaskAbort/QueryTask TM with TaskMID
value set to outstanding smid.

With the above logic still legacy application will be supported
without breaking anything where they provide TaskMID filed as zero.
And it also allows the user to abort the IO which he wants.

Thanks,
Sreekanth

> +                       tm_request->TaskMID = cpu_to_le16(st->smid);
> +                       found = 1;
> +               }
>         }
>
>         if (!found) {
>                 dctlprintk(ioc,
> -                          ioc_info(ioc, "%s: handle(0x%04x), lun(%d), no active mid!!\n",
> +                          ioc_info(ioc, "%s: handle(0x%04x), lun(%d), no matched mid(%d)!!\n",
>                                     desc, le16_to_cpu(tm_request->DevHandle),
> -                                   lun));
> +                                   lun, tm_request->TaskMID));
>                 tm_reply = ioc->ctl_cmds.reply;
>                 tm_reply->DevHandle = tm_request->DevHandle;
>                 tm_reply->Function = MPI2_FUNCTION_SCSI_TASK_MGMT;
> --
> 2.16.1
