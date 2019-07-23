Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0207B716EE
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jul 2019 13:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731282AbfGWL2F (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 23 Jul 2019 07:28:05 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34874 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731276AbfGWL2B (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 23 Jul 2019 07:28:01 -0400
Received: by mail-pg1-f194.google.com with SMTP id s1so12978575pgr.2
        for <linux-scsi@vger.kernel.org>; Tue, 23 Jul 2019 04:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=M085sQxZRNbz0OBDy5dlhICQwU4DuRFnxzjIAf3um2Q=;
        b=Y/HU4gBu9cfcIksRpnfWvBh3ybK9Bdyb0tmjGu2jg+zF1zDuRdlJGxKPMPadJiVqQS
         9jIk1wVgo+/DmqjMa8XIFinj35cZdfffqzX94lAcwGZpjzd0kOUHhJ4OjM1RNhdkPzFA
         3CUz89uvZhtOmr12Jxz1gVcaI1WmTk3pE4n40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=M085sQxZRNbz0OBDy5dlhICQwU4DuRFnxzjIAf3um2Q=;
        b=cyE8rsCK0YCr1xPx3ztPXVTRGEdGNyqWCc7kdD4H2+wIt9AQ8DX4EDFfGy/e1CHahd
         T4AYYx/WJZNy4iWcwPpoEvk2yVago1TrjVgt2LYipYjKDK8Q0VwXeiOImUYXOavZuRyL
         +UckhcAr7h3FFt6W1OzRLfk/zvZ4TKX5ltKB1TY2dcdlg9/k2yRSs9EgYsSQs8azPSyM
         Sx3skSICe2IyHaPMjWKoETeSCbcyUlXfD5ClmeteqGyf4bNULdwM7N/z6xbprCQaRdLm
         jbtVrr9SpvDylpL2aPQKGV1GvCzmFb16U5A2D7+lQhtj7Oo+2q5hzSz5h9G5Qapkhynd
         8Rcg==
X-Gm-Message-State: APjAAAWtvpSifMJIwS5Vi7mVzbCdszGDEJ7rs9DDXRkTvjVmgzd/ABXB
        C/7vZEsvLPazgAGu4M9TKRNlyvozFwh+yUDZBG+U1w==
X-Google-Smtp-Source: APXvYqzZDkTOgdXMUeFY02PsNikZPUtkh8JUhyh0C8GPkwyZQsAdDCcvXpyCzfTYtmLlC5j4vyeCjt4Ewfi4KJPcXuk=
X-Received: by 2002:a63:b346:: with SMTP id x6mr76347800pgt.218.1563881280431;
 Tue, 23 Jul 2019 04:28:00 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190714034415epcms2p25f9787cb71993a30f58524d2f355b543@epcms2p2>
 <20190714034415epcms2p25f9787cb71993a30f58524d2f355b543@epcms2p2> <860cc8cf-6419-c649-b2d9-19b82f6ebc99@suse.de>
In-Reply-To: <860cc8cf-6419-c649-b2d9-19b82f6ebc99@suse.de>
From:   Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Date:   Tue, 23 Jul 2019 16:57:49 +0530
Message-ID: <CAK=zhgocY3Ute_6RiowaWsOROx3+Nzq6+WvkobmR_SB0Rt9_1g@mail.gmail.com>
Subject: Re: [PATCH V2] mpt3sas: support target smid for [abort|query] task
To:     Hannes Reinecke <hare@suse.de>
Cc:     minwoo.im@samsung.com,
        "sathya.prakash@broadcom.com" <sathya.prakash@broadcom.com>,
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, Jul 15, 2019 at 11:43 AM Hannes Reinecke <hare@suse.de> wrote:
>
> On 7/14/19 5:44 AM, Minwoo Im wrote:
> > We can request task management IOCTL command(MPI2_FUNCTION_SCSI_TASK_MG=
MT)
> > to /dev/mpt3ctl.  If the given task_type is either abort task or query
> > task, it may need a field named "Initiator Port Transfer Tag to Manage"
> > in the IU.
> >
> > Current code does not support to check target IPTT tag from the
> > tm_request.  This patch introduces to check TaskMID given from the
> > userspace as a target tag.  We have a rule of relationship between
> > (struct request *req->tag) and smid in mpt3sas_base.c:
> >
> > 3318 u16
> > 3319 mpt3sas_base_get_smid_scsiio(struct MPT3SAS_ADAPTER *ioc, u8 cb_id=
x,
> > 3320         struct scsi_cmnd *scmd)
> > 3321 {
> > 3322         struct scsiio_tracker *request =3D scsi_cmd_priv(scmd);
> > 3323         unsigned int tag =3D scmd->request->tag;
> > 3324         u16 smid;
> > 3325
> > 3326         smid =3D tag + 1;
> >
> > So if we want to abort a request tagged #X, then we can pass (X + 1) to
> > this IOCTL handler.  Otherwise, user space just can pass 0 TaskMID to
> > abort the first outstanding smid which is legacy behaviour.
> >
> > Cc: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
> > Cc: Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
> > Cc: Sathya Prakash <sathya.prakash@broadcom.com>
> > Cc: James E.J. Bottomley <jejb@linux.ibm.com>
> > Cc: Martin K. Petersen <martin.petersen@oracle.com>
> > Cc: MPT-FusionLinux.pdl@broadcom.com
> > Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
> > ---
> >  drivers/scsi/mpt3sas/mpt3sas_ctl.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c b/drivers/scsi/mpt3sas/=
mpt3sas_ctl.c
> > index b2bb47c14d35..f6b8fd90610a 100644
> > --- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
> > +++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
> > @@ -596,8 +596,16 @@ _ctl_set_task_mid(struct MPT3SAS_ADAPTER *ioc, str=
uct mpt3_ioctl_command *karg,
> >               if (priv_data->sas_target->handle !=3D handle)
> >                       continue;
> >               st =3D scsi_cmd_priv(scmd);
> > -             tm_request->TaskMID =3D cpu_to_le16(st->smid);
> > -             found =3D 1;
> > +
> > +             /*
> > +              * If the given TaskMID from the user space is zero, then=
 the
> > +              * first outstanding smid will be picked up.  Otherwise,
> > +              * targeted smid will be the one.
> > +              */
> > +             if (!tm_request->TaskMID || tm_request->TaskMID =3D=3D st=
->smid) {
> > +                     tm_request->TaskMID =3D cpu_to_le16(st->smid);
> > +                     found =3D 1;
> > +             }
> >       }
> >
> >       if (!found) {
> >
> I think this is fundamentally wrong.
> ABORT_TASK is used to abort a single task, which of course has to be
> known beforehand. If you don't know the task, what exactly do you hope
> to achieve here? Aborting random I/O?
> Or, even worse, aborting I/O the driver uses internally and corrupt the
> internal workflow of the driver?
>
> We should simply disallow any ABORT TASK from userspace if the TaskMID
> is zero. And I would even argue to disabllow ABORT TASK from userspace
> completely, as the smid is never relayed to userland, and as such the
> user cannot know which task should be aborted.

Hannes,

This interface was added long time back in mpt2sas driver and I don't
have exact reason of adding this interface at that time.
But I know that this interface is still used by BRCM test team & few
customers only for some functionality and regression testing.

Thanks,
Sreekanth

>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                Teamlead Storage & Networking
> hare@suse.de                                   +49 911 74053 688
> SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg
> GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah
> HRB 21284 (AG N=C3=BCrnberg)
