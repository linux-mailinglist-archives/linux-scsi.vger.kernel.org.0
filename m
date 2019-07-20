Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 525C36F072
	for <lists+linux-scsi@lfdr.de>; Sat, 20 Jul 2019 21:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725812AbfGTTWA (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 20 Jul 2019 15:22:00 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39134 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfGTTWA (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 20 Jul 2019 15:22:00 -0400
Received: by mail-lj1-f196.google.com with SMTP id v18so33756394ljh.6
        for <linux-scsi@vger.kernel.org>; Sat, 20 Jul 2019 12:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g6Hj8M8rT9QYNaXrUFIkmHEC7WjSCrwMzEEwDkrcFNo=;
        b=AeBwNcbbLQzhyc+6C4cFrYQhLSY99vuinZzQ+v25KmtGIqMQAlF8S+Ys1uRMOENH7x
         9Cc04t4QsM9RzErkatdhp8dvwn8qG5x0golL+08UEj2qSkQayXFE3vEfKy2OVQD11Med
         Oql/lVMbzpCLNi4JALQai60r15ogJUUfOARaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g6Hj8M8rT9QYNaXrUFIkmHEC7WjSCrwMzEEwDkrcFNo=;
        b=GNOUALvUD7oD1lRD0jfXVir6tdSujcApDLI0TB2kFZb/nNLBGFf+atqKzvlXd1LVku
         jeW4J7t5ZibJHkbQUG5gleBQ+m3j2Va6Tins4wJ7gNLtJDPO7+i2K35Wy5NjYKfZpPFs
         ORev+/LwwNNvvegMWf+G3eejlhuM35GsH+aEz7rHK26OxelhYS/xXTT+Zz2DW3ZZ6bT6
         IfOB5W3UwyM9Q4t/trtGBx/ugxAzm/K/lzM1HjqObVNEMPnWSDumRY97WXyPXxF5Le4k
         bBFctXl+YrCB4vFDD8rjK9jfWkpNmxkFuQ50UlIqSve/EmXJMppazvaEba5MgASdbINM
         b2XA==
X-Gm-Message-State: APjAAAWTATY2JciI4xZPVaYCk4m633QYZb5rg/GwvkHlYMxZU270wXWd
        HFM0NNjEr/y/lCH2qowAlDklFvTLmwc=
X-Google-Smtp-Source: APXvYqxISmTv4srzNdDid2tnWixkp15T8TFe34ritjBO5tIaFU60dwknk32nEk2IR0U1+aqEbyjaTA==
X-Received: by 2002:a2e:2411:: with SMTP id k17mr31516684ljk.136.1563650517456;
        Sat, 20 Jul 2019 12:21:57 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id m17sm6587717lji.16.2019.07.20.12.21.55
        for <linux-scsi@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Jul 2019 12:21:56 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id k18so33781079ljc.11
        for <linux-scsi@vger.kernel.org>; Sat, 20 Jul 2019 12:21:55 -0700 (PDT)
X-Received: by 2002:a2e:b003:: with SMTP id y3mr31372236ljk.72.1563650515726;
 Sat, 20 Jul 2019 12:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190604093028.79673-1-hare@suse.de>
In-Reply-To: <20190604093028.79673-1-hare@suse.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 20 Jul 2019 12:21:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wheOAo2tQ2mfsSE2iAxxURg62jVt9QsZBL1TPL52aZbvQ@mail.gmail.com>
Message-ID: <CAHk-=wheOAo2tQ2mfsSE2iAxxURg62jVt9QsZBL1TPL52aZbvQ@mail.gmail.com>
Subject: Re: [PATCH] fcoe: avoid memset across pointer boundaries
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, Jun 4, 2019 at 2:30 AM Hannes Reinecke <hare@suse.de> wrote:
>
> Gcc-9 complains for a memset across pointer boundaries, which happens
> as the code tries to allocate a flexible array on the stack.
> Turns out we cannot do this without relying on gcc-isms, so
> this patch converts the stack allocation in proper kzalloc() calls.
>
> Signed-off-by: Hannes Reinecke <hare@suse.com>

So this patch apparently isn't making it into 5.3?

The gcc-9 warnings are still there, and as annoying as they were
originally. Appended for your viewing "pleasure" once again, in case
you don't have gcc-9 installed..

          Linus

---
In file included from ./include/linux/bitmap.h:9,
                 from ./include/linux/cpumask.h:12,
                 from ./arch/x86/include/asm/cpumask.h:5,
                 from ./arch/x86/include/asm/msr.h:11,
                 from ./arch/x86/include/asm/processor.h:21,
                 from ./arch/x86/include/asm/cpufeature.h:5,
                 from ./arch/x86/include/asm/thread_info.h:53,
                 from ./include/linux/thread_info.h:38,
                 from ./arch/x86/include/asm/preempt.h:7,
                 from ./include/linux/preempt.h:78,
                 from ./include/linux/spinlock.h:51,
                 from ./include/linux/seqlock.h:36,
                 from ./include/linux/time.h:6,
                 from ./include/linux/stat.h:19,
                 from ./include/linux/module.h:10,
                 from drivers/scsi/fcoe/fcoe_ctlr.c:10:
In function =E2=80=98memset=E2=80=99,
    inlined from =E2=80=98fcoe_ctlr_vlan_parse=E2=80=99 at drivers/scsi/fco=
e/fcoe_ctlr.c:2818:2,
    inlined from =E2=80=98fcoe_ctlr_vlan_recv=E2=80=99 at drivers/scsi/fcoe=
/fcoe_ctlr.c:2993:7:
./include/linux/string.h:344:9: warning: =E2=80=98__builtin_memset=E2=80=99=
 offset
[569, 600] from the object at =E2=80=98buf=E2=80=99 is out of the bounds of=
 referenced
subobject =E2=80=98rdata=E2=80=99 with type =E2=80=98struct fc_rport_priv=
=E2=80=99 at offset 0
[-Warray-bounds]
  344 |  return __builtin_memset(p, c, size);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
In function =E2=80=98memset=E2=80=99,
    inlined from =E2=80=98fcoe_ctlr_vn_parse=E2=80=99 at drivers/scsi/fcoe/=
fcoe_ctlr.c:2287:2,
    inlined from =E2=80=98fcoe_ctlr_vn_recv=E2=80=99 at drivers/scsi/fcoe/f=
coe_ctlr.c:2760:7:
./include/linux/string.h:344:9: warning: =E2=80=98__builtin_memset=E2=80=99=
 offset
[569, 600] from the object at =E2=80=98buf=E2=80=99 is out of the bounds of=
 referenced
subobject =E2=80=98rdata=E2=80=99 with type =E2=80=98struct fc_rport_priv=
=E2=80=99 at offset 0
[-Warray-bounds]
  344 |  return __builtin_memset(p, c, size);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
