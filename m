Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2253E1F0180
	for <lists+linux-scsi@lfdr.de>; Fri,  5 Jun 2020 23:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbgFEVZh (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 5 Jun 2020 17:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbgFEVZf (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 5 Jun 2020 17:25:35 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF355C08C5C3
        for <linux-scsi@vger.kernel.org>; Fri,  5 Jun 2020 14:25:33 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id a9so9902733ljn.6
        for <linux-scsi@vger.kernel.org>; Fri, 05 Jun 2020 14:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=su7aBmgFp3s3EJEbluac4gd2OffM4+Zbo0KIh4RzQsY=;
        b=BFxg4A1iQISYNle2o8Aci5KXRtbIdPHwQx4ahwVCRIsqw7qP2LtsnzMGqouiwT/1Ne
         Gh+CpFuVtvi7JTd652vUpzoNdKMVixC6MQbw/ApfQeW6EMncuiHAV/EkbQ6FpIMX1Cfl
         cJDAMDEF6JteXq2Kw8YyEVH4kk1sJf5fPD26A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=su7aBmgFp3s3EJEbluac4gd2OffM4+Zbo0KIh4RzQsY=;
        b=i0z2Iw0bOtL6jvnF7vh5kO9SUlAQlW9Gf8NcW6E7DfmUMALkMqTX0ntnCvYR8FFWeL
         1kNEGXKbwhdyNFAgehf0mOoztYzOWLcMMBjTr1qv6jAsw5sMr6kV2VQe1B7oVe1uzuBn
         W0uwT7M8CCYZde4SkItPvTO0PoWrRQuiZJr1BaH7FYvAN4gh4R89XVfErJ0gN+3GZd74
         rVWou4JS3AaHT/zRD7PwTSqMH2NqQVE4dcLjjQrXsuhBLvkzQwV4hQoeiHuLk7VEYgNz
         MNq1OISdUQPA+Oh3Fz4Bu72aUS+PM0hMy7+AmOiglcIq0GZal13/0Jlt6mAA4pMff/nY
         XOUg==
X-Gm-Message-State: AOAM533WI6FqyDHIOQERVckLcJbn9V5c2mt5G5goEHFo5HIDpfxQBiqA
        Ugw5ypIm/Nf/u/cDcSIyLs4aPV3FoZw=
X-Google-Smtp-Source: ABdhPJwV0THyIA4gXXxtONbpx36w/UbFkoPpfjtLx1GskGwszGVZKWZgUqBh7dCy4IOmcImnUVJa4w==
X-Received: by 2002:a2e:7307:: with SMTP id o7mr6063713ljc.40.1591392331541;
        Fri, 05 Jun 2020 14:25:31 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id t22sm1471399lji.90.2020.06.05.14.25.30
        for <linux-scsi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2020 14:25:30 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id j18so406668lji.2
        for <linux-scsi@vger.kernel.org>; Fri, 05 Jun 2020 14:25:30 -0700 (PDT)
X-Received: by 2002:a2e:b5d9:: with SMTP id g25mr5996890ljn.285.1591392329927;
 Fri, 05 Jun 2020 14:25:29 -0700 (PDT)
MIME-Version: 1.0
References: <1591332925.3685.16.camel@HansenPartnership.com>
 <CAHk-=wjiQmscZHzOYKmMpFoy4h4xF1Mvf9O8i6qtTtS38t6Wsg@mail.gmail.com> <1591391891.4728.96.camel@HansenPartnership.com>
In-Reply-To: <1591391891.4728.96.camel@HansenPartnership.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 5 Jun 2020 14:25:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjy8sMqjft6ALTo28UECex84uiYEo=BJbLUJ_CHrPmOEQ@mail.gmail.com>
Message-ID: <CAHk-=wjy8sMqjft6ALTo28UECex84uiYEo=BJbLUJ_CHrPmOEQ@mail.gmail.com>
Subject: Re: [GIT PULL] first round of SCSI updates for the 5.6+ merge window
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, Jun 5, 2020 at 2:18 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> Um, no, shuffles feet ... I actually tagged the wrong branch:

Ok, now I see the changes, but I see more than you reported.

These seem to be new compared to your pull request:

Al Viro (4):
      scsi: hpsa: Lift {BIG_,}IOCTL_Command_struct copy{in,out} into
hpsa_ioctl()
      scsi: hpsa: Don't bother with vmalloc for BIG_IOCTL_Command_struct
      scsi: hpsa: Get rid of compat_alloc_user_space()
      scsi: hpsa: hpsa_ioctl(): Tidy up a bit

Can Guo (1):
      scsi: ufs: Don't update urgent bkops level when toggling auto bkops

Stanley Chu (1):
      scsi: ufs: Remove redundant urgent_bkop_lvl initialization

They don't look alarming, but I don't like how I don't see what you
_claim_ I should see.

Hmm?

              Linus
