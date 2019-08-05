Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5ABB80FC7
	for <lists+linux-scsi@lfdr.de>; Mon,  5 Aug 2019 02:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfHEAgW (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 4 Aug 2019 20:36:22 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44298 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbfHEAgV (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 4 Aug 2019 20:36:21 -0400
Received: by mail-ed1-f68.google.com with SMTP id k8so77053196edr.11;
        Sun, 04 Aug 2019 17:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qu1SlTXZhUWK45zuZk7QKnR3x5h9TT7qch2dobJvjmU=;
        b=QvXlLBkQSJpCdW5FCsQrr4LyK7KQoVB2/IouVLBUJTKFu/uycU8BYPyRwi8QqVdskl
         hNWvTYvsyZExH4iy4V97xYqE+1ixGAEknwxfkaAZ+YOaAGgniH2Titnac8RJx05CfB5E
         r4QkQ/2IL2cUn3xIYPesHcnSY/vHCwY9N1+koSMbQ+Fyl2bIyMwXXRLe7JaED3ZgSFG0
         ipoApMYVUJhuTSTbfMNAYMLI+RWje+rAvex6Vj5RyYcQp1wZP9j0ovxLqRcVet83fnUP
         nMypgYiw40Q+gVU9op5oWyVCuBAO9cd61NQMn025edzkN5mCXD4L35+w3Z8e4mXnkZJG
         CGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qu1SlTXZhUWK45zuZk7QKnR3x5h9TT7qch2dobJvjmU=;
        b=MoUghqWDC/IHv0CkM9fo9NuJ+CvPR28EfQwIurPGWg2Tjo8L4E4mcVuWBhAYd2fXsR
         6Zo/dSPumqjURQs2COw4l1+BeD8D+DllPmwJ+7kaaJLrUDnZ00fiEUuC2p6f8ljIRlCO
         D24j9FM6AVmmn76O1jWy5rCyq4iSuUyf4n6hcxAYNzrSNJZO8Zgg/DAFRpxso32ibhUh
         Or//Aoo3k7+VxQb8tJNYNYgkZdT1ERCMRsXsEo9TVF/Ix3WSeLAoTo9zARu3H2OldzXK
         dyLlLmnxx02l+OcTG3rg0uBrKnoljqhsxM8zE9426DIGCb9FYn2y5ZTKm88CIKrNhipi
         y3CA==
X-Gm-Message-State: APjAAAWqTaHTIvho5WxX+5N+dngNxt0bRHyhLBegI102nWMo/q3QHhoW
        RST8kmpd45TD3cZqsWRkTtBbL78+L6EAE+8YakA=
X-Google-Smtp-Source: APXvYqyNy9TlNF+TLNVhMmkV26H9PcBhGwSU/mhKPpblR5BNyuZ5+3e0AenY9wlLdEaJTHpJhtqos1TRQsMUZWjYpIM=
X-Received: by 2002:a17:906:ccc3:: with SMTP id ot3mr116792547ejb.113.1564965379544;
 Sun, 04 Aug 2019 17:36:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190802103830.8881-1-lizhongfs@gmail.com> <5D446BC2.9000303@redhat.com>
In-Reply-To: <5D446BC2.9000303@redhat.com>
From:   Li Zhong <lizhongfs@gmail.com>
Date:   Mon, 5 Aug 2019 08:36:08 +0800
Message-ID: <CABKycOVsj-rgqHc_ouRaWh49pr5+h3G9KdryejcGSTLSOri+5A@mail.gmail.com>
Subject: Re: [RFC PATCH] target: tcmu: clean the nl_cmd of the udev when nl
 send fails
To:     Mike Christie <mchristi@redhat.com>
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        martin.petersen@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sat, Aug 3, 2019 at 12:58 AM Mike Christie <mchristi@redhat.com> wrote:
>
> On 08/02/2019 05:38 AM, Li Zhong wrote:
> > If the userspace process crashes while we send the nl msg, it is possible
> > that the cmd in curr_nl_cmd of tcmu_dev never gets reset to 0, and
> > and returns busy for other commands after the userspace process is
> > restartd.
> >
> > More details below:
> >
> > /backstores/user:file/file> set attribute dev_size=2048
> > Cannot set attribute dev_size: [Errno 3] No such process
> > /backstores/user:file/file> set attribute dev_size=2048
> > Cannot set attribute dev_size: [Errno 16] Device or resource busy
> >
> > with following kernel messages:
> > [173605.747169] Unable to reconfigure device
> > [173616.686674] tcmu daemon: command reply support 1.
> > [173623.866978] netlink cmd 3 already executing on file
> > [173623.866984] Unable to reconfigure device
> >
> > Also, it is not safe to leave the nl_cmd in the list, and not get
> > deleted.
> >
> > This patch removes the nl_cmd from the list, and clear its data if
> > it is not sent successfully.
> >
> > Signed-off-by: Li Zhong <lizhongfs@gmail.com>
> > ---
> >  drivers/target/target_core_user.c | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/drivers/target/target_core_user.c b/drivers/target/target_core_user.c
> > index 04eda111920e..4ae3103e204c 100644
> > --- a/drivers/target/target_core_user.c
> > +++ b/drivers/target/target_core_user.c
> > @@ -1708,6 +1708,24 @@ static int tcmu_init_genl_cmd_reply(struct tcmu_dev *udev, int cmd)
> >       return 0;
> >  }
> >
> > +static void tcmu_destroy_genl_cmd_reply(struct tcmu_dev *udev)
> > +{
> > +     struct tcmu_nl_cmd *nl_cmd = &udev->curr_nl_cmd;
> > +
> > +     if (!tcmu_kern_cmd_reply_supported)
> > +             return;
> > +
> > +     if (udev->nl_reply_supported <= 0)
> > +             return;
> > +
> > +     mutex_lock(&tcmu_nl_cmd_mutex);
> > +
> > +     list_del(&nl_cmd->nl_list);
> > +     memset(nl_cmd, 0, sizeof(*nl_cmd));
> > +
> > +     mutex_unlock(&tcmu_nl_cmd_mutex);
> > +}
> > +
> >  static int tcmu_wait_genl_cmd_reply(struct tcmu_dev *udev)
> >  {
> >       struct tcmu_nl_cmd *nl_cmd = &udev->curr_nl_cmd;
> > @@ -1788,6 +1806,9 @@ static int tcmu_netlink_event_send(struct tcmu_dev *udev,
> >       if (ret == 0 ||
> >          (ret == -ESRCH && cmd == TCMU_CMD_ADDED_DEVICE))
> >               return tcmu_wait_genl_cmd_reply(udev);
> > +     else
> > +             /* If failure, remove from the list and clear the nl_cmd */
>
> Drop the comment. We know it is in the failure path already and the
> function name tells us it cleans up the command.

Thank you for the review, Will drop it.

>
> > +             tcmu_destroy_genl_cmd_reply(udev);
> >
>
