Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 125701B5B7
	for <lists+linux-scsi@lfdr.de>; Mon, 13 May 2019 14:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729810AbfEMMUQ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 13 May 2019 08:20:16 -0400
Received: from mail-vs1-f54.google.com ([209.85.217.54]:43667 "EHLO
        mail-vs1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727414AbfEMMUQ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 13 May 2019 08:20:16 -0400
Received: by mail-vs1-f54.google.com with SMTP id d128so7823331vsc.10
        for <linux-scsi@vger.kernel.org>; Mon, 13 May 2019 05:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=t/fi2HyAjAx3eHLPrOFyeMntv5XS+3pxj6iTsfdNI3o=;
        b=GPjKUKZdszOcJMgD4jo4zKTA6D7QQLlBQiQnCVkvPIEoRerCUbISG+DyJFFGyMxeqY
         UtEWbo5MFo7vlQdyo1nPCF00jZnUGhWkgPQ38EyVCsG/RKQUV51lOLPAnwNSIIvDKLgL
         noVWnkiCeMOOImbcVt4Z07sAh9YYPuZ1wRlysf4T8jwuZX9J45Ic3Cg2JE325mOEhLTe
         /IzK5TxbFEf2lc2pqCKoMd6WAxmCA1BnMPyRtYa0wEZ73aKU5GTE753RhuWVPTd95x+Q
         Awbahn1pYgUDwpOgJlt79E8Yhnl4xh00fmLT8dybEUA0kpiRBUgbUYSG1SQDCRbe8HYy
         I2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=t/fi2HyAjAx3eHLPrOFyeMntv5XS+3pxj6iTsfdNI3o=;
        b=IPG/r92kss8c260m6cUndKGeKlYfLvMuWPWC3WTziwZxjhr/PVGL71qDvfC7tfE96N
         /QflnZiGecVopkv/Ekb8p/P017cWeF5xn34XTt0b6Dl7sX5IXFprtZpWZxYeF7DNzPk0
         Bv0Zxh9ncfS0yse6fXYHgz+fSJprLxUHQ8YOb6MG5EnpUrTJOliPO21SwMKWEoHFTju1
         JDSjXqLKYQTc/AJUCbOaLhe8dgzrE6qSth2fHw8sON2akL4V9ZcyTyBt2IgrVC7rhhdf
         /oR9WYhjYitItcdW7/reScCPa5zTmdQeBt6z3vJt/owU+z8mn06B66q34FPXposV1ScN
         UZfA==
X-Gm-Message-State: APjAAAXBg9mE2yXipi2w5hQZQC8bwGo/WI2XnB5vSJjLDTg8/aKGyc6V
        ijjwVJ8mF8IFYFEq1XAIc0nAS53a3p9Gnmpzlw==
X-Google-Smtp-Source: APXvYqy62UtkaZWfHmI7O3u8wSSMXkiUJ4ufu6NcMFA8bboo9nWgmv3TcvYGIM5vMk2K5v5ju3Ru2kZ7EE0JR/sY4qk=
X-Received: by 2002:a67:eb14:: with SMTP id a20mr5148731vso.151.1557750015147;
 Mon, 13 May 2019 05:20:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAP8WD_be_3=iHDpMYL+fKEFW6BbG8s=0TUPVm4ojiS7orOr0zA@mail.gmail.com>
 <20190513070218.GA25920@infradead.org>
In-Reply-To: <20190513070218.GA25920@infradead.org>
Reply-To: whiteheadm@acm.org
From:   tedheadster <tedheadster@gmail.com>
Date:   Mon, 13 May 2019 08:20:03 -0400
Message-ID: <CAP8WD_ZuOHn2VWjgYr-rLBd7Lm33nTvCvu7WKqW_0gfzqbbCLQ@mail.gmail.com>
Subject: Re: Poor SWIOTLB Performance with HIGHMEM64G
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Whitehead <whiteheadm@acm.org>, linux-scsi@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, May 13, 2019 at 3:02 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Sun, May 12, 2019 at 02:55:48PM -0400, tedheadster wrote:
> > Christoph,
> >   On the same hardware (reboot with different kernel) I am getting
> > _horrible_ disk I/O performance on the 5.1.1. kernel compiled on a
> > 32-bit platform using HIGHMEM64G (PAE) to access 32GiB of physical
> > memory.
> >
> > The numbers are truly terrible to copy a 16GiB file from one disk to a
> > different one:
>
> This sounds like your storage controller only supports 32-bit DMA.
> In that case any memory above that will be bounce buffered, that
> is copied from one piece of memory to another, which in addition
> to the copying will also create memory pressure.

I have this SATA controller (using ahci kernel driver):

 SATA controller [0106]: Intel Corporation C610/X99 series chipset
sSATA Controller [AHCI mode] [8086:8d62] (rev 05)

> What storage controller do you use?  Also if the CPU is 64-bit
> capable you really should use a 64-bit kernel with 32-bit userspace
> for a setup like that, as the VM folks do not spend any effort on
> optimizing large highmem setups.

I guess my request is for the VM folks to _indeed_ spend some effort
optimizing large highmem setups because a 700% slowdown should be
embarrassing. Who should I ask in that team about this?

I do have 64-bit hardware but I regrettably have to run it in 32-bit
mode with PAE support to access highmem64g memory.

- Matthew
