Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB59E1FC8B
	for <lists+linux-scsi@lfdr.de>; Thu, 16 May 2019 00:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfEOWXc (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 15 May 2019 18:23:32 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:36451 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfEOWXc (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 15 May 2019 18:23:32 -0400
Received: by mail-vs1-f65.google.com with SMTP id l20so1021374vsp.3
        for <linux-scsi@vger.kernel.org>; Wed, 15 May 2019 15:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=8ebkEV1+iLoOSqy5D6YfW4cMCgg7deGM4hwcmbSHkmM=;
        b=sS+lzePbiqPplWZrljYwqLygbv5/GeC4l0/Wb0b2AQQ68Z4HAbbAQQ6fcLU/Q19dIA
         7fCxTgE3/J60dXz/pdliFfjgJv4mlp/bVoll2WS/GX4c7oif1ryMfkjZ+/btcKeVFVGK
         KpnyhrpTs8yAjXGxFs+CXzIEc8c8vPA0f5KObq33JA/+YuMBhjzsZdB9axe/eQeiZmMf
         xHZpqYuNC/kuuKLcdQaufbDUhtbEdorZKlClIGOvPWtyvlLFnaB+309TQyx3XMN+c96T
         BV03X3Qgeg9nVgH3oLp5Z5j5ioTJ8eUQV4fRzbndj86JuXDcXGBhZyq/zj7bhxUvL9V9
         AUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=8ebkEV1+iLoOSqy5D6YfW4cMCgg7deGM4hwcmbSHkmM=;
        b=RMolwta+OltABWyFbaylGvyHi4y6IzdVWKx/835STS7KKD6mLkXR6wLxBBxi0mobnW
         W5SKQIKTDCr9aBWTPsdUuTWfc3lGKiWM1ox1pcwHF3zQEizkDlrc9x3C2h4/i/6+pKQC
         Isolgs2v6xRtGuCUcL1x82BJ80Xy4RB3Klpdy8Y0oAWxeMkBb+rTfVrptqU6oBwdtIEC
         fUkMOxMg6P3grkpj2C/egHEWAFh18g4U0AyZmrixAOu6C22V+1UNc4AMzJ6XNUyteSpR
         4sLj/xs71cl91fdt4G1xBXtsrUMAn9VNb0a7sp5xrXIf8K3id4Ti1H4F9GlR9pQqVDwi
         qFTg==
X-Gm-Message-State: APjAAAU/vRNvI4Qg5TzJomjoD9sbHlY2lx8piU8xdU2QMkT+on7kMU4J
        yq1To5LXC7+fQbf//OCwSvLFncE9o13oVGcMhrVsSx0=
X-Google-Smtp-Source: APXvYqy/Bwzfu1mYQfMkZiDaUf482jigrv3agd13FZNLQnZ95ldaZgxX0cCb9aYzsCdFuofOJ7gkn/LlPqHgG081Dg8=
X-Received: by 2002:a67:ee4f:: with SMTP id g15mr11823563vsp.38.1557959011499;
 Wed, 15 May 2019 15:23:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAP8WD_be_3=iHDpMYL+fKEFW6BbG8s=0TUPVm4ojiS7orOr0zA@mail.gmail.com>
 <20190513070218.GA25920@infradead.org> <CAP8WD_ZuOHn2VWjgYr-rLBd7Lm33nTvCvu7WKqW_0gfzqbbCLQ@mail.gmail.com>
 <20190513122846.GA15835@infradead.org>
In-Reply-To: <20190513122846.GA15835@infradead.org>
Reply-To: whiteheadm@acm.org
From:   tedheadster <tedheadster@gmail.com>
Date:   Wed, 15 May 2019 18:23:20 -0400
Message-ID: <CAP8WD_YTqcduLsYRU-tCsCLC9wvAp4624Ls350Eb98K_fs0+Hw@mail.gmail.com>
Subject: Re: Poor SWIOTLB Performance with HIGHMEM64G
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Whitehead <whiteheadm@acm.org>, linux-scsi@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, May 13, 2019 at 8:29 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, May 13, 2019 at 08:20:03AM -0400, tedheadster wrote:
> > On Mon, May 13, 2019 at 3:02 AM Christoph Hellwig <hch@infradead.org> wrote:
> > >
> > > On Sun, May 12, 2019 at 02:55:48PM -0400, tedheadster wrote:
> > > > Christoph,
> > > >   On the same hardware (reboot with different kernel) I am getting
> > > > _horrible_ disk I/O performance on the 5.1.1. kernel compiled on a
> > > > 32-bit platform using HIGHMEM64G (PAE) to access 32GiB of physical
> > > > memory.
> > > >
> > > > The numbers are truly terrible to copy a 16GiB file from one disk to a
> > > > different one:
> > >

Christoph,
  I believe I found the problem, and it does not relate to anything I
considered before. I forgot that I had chosen the SLOB memory
allocator for a previous test and it was still enabled. There was a
huge amount of locking slowing the system down while SLOB was
allocating new memory with its simple algorithm.

Switching to SLUB has improved it immensely. I am sorry I missed this
rather important item.

- Matthew
