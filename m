Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2305E24B8D1
	for <lists+linux-scsi@lfdr.de>; Thu, 20 Aug 2020 13:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbgHTL1b (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 20 Aug 2020 07:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730645AbgHTKFu (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 20 Aug 2020 06:05:50 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41727C061386
        for <linux-scsi@vger.kernel.org>; Thu, 20 Aug 2020 03:05:47 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id d11so728782ejt.13
        for <linux-scsi@vger.kernel.org>; Thu, 20 Aug 2020 03:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pbe+IJf4ZBxt6yUxRRrQR1l3UQTW2eLx6AT4PE1gQKg=;
        b=foA95pAMne0k+ZduK2+JsEaA0Kd3Xk6AJeP12ZUtsQO8oCEqpY6AC2jWiQeJjjQrKA
         n//Z/S/hwU9sUSwrh2bpFx9EjO5w8H5vkm5cyHDHvlSF0L7E3fVBHC7P2Ym9zd8UwQZN
         UTTFBKoIkLT88Lc8FZLz7dV6a5Tegh0nandB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pbe+IJf4ZBxt6yUxRRrQR1l3UQTW2eLx6AT4PE1gQKg=;
        b=VgvJBlG4FT0cV2osevaYTTpKSjYBNs1L8xzNo7j1K1CsIQ0Biz4daHYumAgoNXTB47
         TQqisXRN3ADRnV56saFNoJvfyCAVxxjHrZ/7119wygMJCRKiEDxZrA8yNEc4siwp2LzU
         I4iJPWs5SE7klurC3Zsl62UmiRNs1qgCASCXVir+sSSadSHokD9YRTtEw8f9VmxEhbBz
         +O6eBRzP8Ts36OOjQlGM/3HmQyoTPRNPK6BFdYcaS7RHYHDI994qq3i/F4s0UNeL9tSn
         qLxMu+woj0blaP8zO/nqWp1uYejDTEK8XS+J2n/Opr4aqmvp1YWFHduy7PID7Bc3g6qs
         PPfg==
X-Gm-Message-State: AOAM5311tnYOaWF8DPE88jRKdJ8eHiJ+0OQ1tZ3wS6Oc5XUlDWMlYFH2
        quhbQOcpq48Rq/R4WmW8i/EeQAq0XVc9qG3z
X-Google-Smtp-Source: ABdhPJwJTTOaSX6j0z2zh0cQ8NJ8/r6giO9butphwT9HK1hqDwGzhAJ/bGwhECoIG/fIyMqPUnI5+Q==
X-Received: by 2002:a17:906:9989:: with SMTP id af9mr2406615ejc.385.1597917946140;
        Thu, 20 Aug 2020 03:05:46 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id k6sm1148733ejj.41.2020.08.20.03.05.44
        for <linux-scsi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 03:05:45 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id r15so1414653wrp.13
        for <linux-scsi@vger.kernel.org>; Thu, 20 Aug 2020 03:05:44 -0700 (PDT)
X-Received: by 2002:a5d:6744:: with SMTP id l4mr2628495wrw.105.1597917944145;
 Thu, 20 Aug 2020 03:05:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200819065555.1802761-1-hch@lst.de> <20200819065555.1802761-6-hch@lst.de>
 <CAAFQd5COLxjydDYrfx47ht8tj-aNPiaVnC+WyQA7nvpW4gs=ww@mail.gmail.com>
 <20200819135454.GA17098@lst.de> <CAAFQd5BuXP7t3d-Rwft85j=KTyXq7y4s24mQxLr=VoY9krEGZw@mail.gmail.com>
 <20200820044347.GA4533@lst.de> <20200820052004.GA5305@lst.de>
In-Reply-To: <20200820052004.GA5305@lst.de>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 20 Aug 2020 12:05:29 +0200
X-Gmail-Original-Message-ID: <CAAFQd5CFiA2WBaaPQ9ezvMjYZfNw37c42UEy9Pk7kJyCi1mLzQ@mail.gmail.com>
Message-ID: <CAAFQd5CFiA2WBaaPQ9ezvMjYZfNw37c42UEy9Pk7kJyCi1mLzQ@mail.gmail.com>
Subject: Re: [PATCH 05/28] media/v4l2: remove V4L2-FLAG-MEMORY-NON-CONSISTENT
To:     Christoph Hellwig <hch@lst.de>
Cc:     alsa-devel@alsa-project.org, linux-ia64@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        nouveau@lists.freedesktop.org, linux-nvme@lists.infradead.org,
        linux-mips@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        linux-mm@kvack.org,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        linux-scsi@vger.kernel.org,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Pawel Osciak <pawel@osciak.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-parisc@vger.kernel.org, netdev@vger.kernel.org,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, Aug 20, 2020 at 7:20 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Aug 20, 2020 at 06:43:47AM +0200, Christoph Hellwig wrote:
> > On Wed, Aug 19, 2020 at 03:57:53PM +0200, Tomasz Figa wrote:
> > > > > Could you explain what makes you think it's unused? It's a feature of
> > > > > the UAPI generally supported by the videobuf2 framework and relied on
> > > > > by Chromium OS to get any kind of reasonable performance when
> > > > > accessing V4L2 buffers in the userspace.
> > > >
> > > > Because it doesn't do anything except on PARISC and non-coherent MIPS,
> > > > so by definition it isn't used by any of these media drivers.
> > >
> > > It's still an UAPI feature, so we can't simply remove the flag, it
> > > must stay there as a no-op, until the problem is resolved.
> >
> > Ok, I'll switch to just ignoring it for the next version.
>
> So I took a deeper look.  I don't really think it qualifies as a UAPI
> in our traditional sense.  For one it only appeared in 5.9-rc1, so we
> can trivially expedite the patch into 5.9-rc and not actually make it
> show up in any released kernel version.  And even as of the current
> Linus' tree the only user is a test driver.  So I really think the best
> way to go ahead is to just revert it ASAP as the design wasn't thought
> out at all.

The UAPI and V4L2/videobuf2 changes are in good shape and the only
wrong part is the use of DMA API, which was based on an earlier email
guidance anyway, and a change to the synchronization part . I find
conclusions like the above insulting for people who put many hours
into designing and implementing the related functionality, given the
complexity of the videobuf2 framework and how ill-defined the DMA API
was, and would feel better if such could be avoided in future
communication.

That said, we can revert it on the basis of the implementation issues,
but I feel like we wouldn't get anything by doing so, because as I
said, the design is sane and most of the implementation is fine as
well. Instead. I'd suggest simply removing the use of the attribute
being removed, so that the feature stays no-op until the DMA API
provides a way to implement it or we just migrate videobuf2 to stop
using the DMA API as much as possible, like many drivers in the DRM
subsystem did.

Best regards,
Tomasz
