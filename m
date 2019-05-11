Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0775B1A94D
	for <lists+linux-scsi@lfdr.de>; Sat, 11 May 2019 21:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbfEKTtv (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 11 May 2019 15:49:51 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:34230 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfEKTtv (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 11 May 2019 15:49:51 -0400
Received: by mail-yw1-f66.google.com with SMTP id n76so7617773ywd.1
        for <linux-scsi@vger.kernel.org>; Sat, 11 May 2019 12:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quadstor-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MkM8jE9Q+TsqgXxYhBWUVRqHQ22qSu8uqVV2wHI/RpY=;
        b=sTwLNOp4+/Bsz3H+5A2Yr1jHOThKqR7DpTFhkuoTpiLQnqo1PJfRx6pcTcFOKnYTWH
         zBB21XSLcZqvOQzV7a4cOyooo+aUPMB34n8KPRNy/m81JTP2BLoHeMBJT3kwuCAiBQ59
         ALgi6QcXlD7X9rJKNfTL1yqKVy2YawI4x2NAZrDMMDmJCjIO+WmM99KZk/hIvVF3j+cK
         bFlDHejLimDzMYeVzB+MkCD6J0cVKH/OsUFQq2nGJ2eZzth0cZPxfvOLMv2Tan1Aptlz
         FIZUPc7ekSOv/bL8byYctVzmx337hkamK3mbsqvlQroTMXviLe8GOF0dmaDdI8Bfq5zi
         UbXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MkM8jE9Q+TsqgXxYhBWUVRqHQ22qSu8uqVV2wHI/RpY=;
        b=AH2VdFQJ2SVv2auvpWM4/lbzTOU3pEKurDBK66eRcHUqA+Ea0+DWRjQPZK/9B1noXt
         cZOmTlOrFeIjLy3+FuYPVg1b+4GMQvLlOp4aKa68l70veEg2ygo/O0aeECgaVlwav9YU
         E+NEsyUTMCvk4UWQM4Ce7wH/8BXI5g1b+p7VBQlmLCEkg1ioRFQfdkGGIOgXaPG1teHW
         /hPX4arsSGuBx3J9s1qwM2sfEZuMCtZaa0r72yabWPPu0S3gnOH6qIyN3gjmi/gmWzUX
         N5UYqmhUIouaSnfqdoE3+6kQN8sZEgAQfZhkYIOaxSKe+IkeWppqITQfkbQZI+9I0RXE
         051Q==
X-Gm-Message-State: APjAAAX5tDmsAN43m1AYOT8AKEEvZTxV80sb+WnkE2uT+FeFfCm2XxdK
        A6MGlm8qRaACQ65R4zkOlqyEcHNccoL8YktL8ujH6w==
X-Google-Smtp-Source: APXvYqy1Y6Bca+E2VR/4JIjAbw6cj3I07k8gqVJ7jHJlb2igzDTVTiMHwO8WEvfz/UzACawtI2J5H6vlbIyp4qdFD6A=
X-Received: by 2002:a25:ba4c:: with SMTP id z12mr9181393ybj.344.1557604190223;
 Sat, 11 May 2019 12:49:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-_EfwKNP5bK-ew7d+T4k8V3faOeFpR8-s_k6PGECSUFoMH9w@mail.gmail.com>
 <5973BD42-5E6A-4937-BFC6-8A09F04014FB@marvell.com>
In-Reply-To: <5973BD42-5E6A-4937-BFC6-8A09F04014FB@marvell.com>
From:   Shivaram Upadhyayula <shivaram.u@quadstor.com>
Date:   Sun, 12 May 2019 01:19:39 +0530
Message-ID: <CAN-_EfxyskvqmX5Zz62vvsyaY0hkw+f2QjiuwMu-5izEUeg1pQ@mail.gmail.com>
Subject: Re: Problems with logout in qlt_free_session_done
To:     Giridhar Malavali <gmalavali@marvell.com>
Cc:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi,

On Thu, May 9, 2019 at 3:50 AM Giridhar Malavali <gmalavali@marvell.com> wr=
ote:
>
>
>
> =EF=BB=BFOn 5/8/19, 1:42 PM, "linux-scsi-owner@vger.kernel.org on behalf =
of Shivaram Upadhyayula" <linux-scsi-owner@vger.kernel.org on behalf of shi=
varam.u@quadstor.com> wrote:
>
>     Hi,
>
>     There seem to be a few issues when trying to do a logout
>     qla_target.c:qlt_free_session_done in 4.19.41
>
>     1. When the logout timesout qla2x00_sp_timeout is called. This
>     function assumes sp->qpair is valid, but this isn't the case if mq is
>     not enabled

With the upstream driver a sp->qpair is always valid, so the crash is
only specific to the 4.19.x driver

>
>     2. qla2x00_async_iocb_timeout also assumes that sp->qpair is valid.
>     Also only if qla24xx_async_abort_cmd() fails is sp->done() called,
>     sp->done in this case is qlt_logo_completion_handler() which will
>     never be called if qla24xx_async_abort_cmd() succeeds

This is a problem with the upstream driver too. I haven't tried to
build this driver so my comments are based on my experience with
4.19.41.

In qla2x00_async_iocb_timeout, lets take the case of SRB_LOGOUT_CMD

        switch (sp->type) {
..

        case SRB_LOGOUT_CMD:
        <...>
                rc =3D qla24xx_async_abort_cmd(sp, false);
                if (rc) {
....
                        sp->done(sp, QLA_FUNCTION_TIMEOUT);
                }

sp->done() is called only if qla24xx_async_abort_cmd() fails (rc !=3D
0).  The same for case SRB_LOGIN_CMD.

Regards,
Shivaram

>     3. qla24xx_async_abort_cmd() can lead to "scheduling while atomic" if
>     called from qla2x00_async_iocb_timeout. The wait parameter can be use=
d
>     to alloc with GFP_ATOMIC
>
>     Please see diff https://www.quadstor.com/patches/srb-logout.diff
>     generated against 4.9.41
>
> >> We have addressed issues related to above in our latest upstream drive=
r. Can you check and let us know whether you still see the above issues.
>
> -- Giri
>
>     Regards,
>     Shivaram
>
>     --
>     Virtual Tape Library https://www.quadstor.com/virtual-tape-library.ht=
ml
>     Storage Virtualization with VAAI
>     https://www.quadstor.com/storage-virtualization.html
>
>


--=20
Virtual Tape Library https://www.quadstor.com/virtual-tape-library.html
Storage Virtualization with VAAI
https://www.quadstor.com/storage-virtualization.html
