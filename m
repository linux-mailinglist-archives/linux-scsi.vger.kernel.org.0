Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9038674429E
	for <lists+linux-scsi@lfdr.de>; Fri, 30 Jun 2023 21:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbjF3TOX (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 30 Jun 2023 15:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjF3TOV (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 30 Jun 2023 15:14:21 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B838F3C35
        for <linux-scsi@vger.kernel.org>; Fri, 30 Jun 2023 12:14:20 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9928abc11deso258968066b.1
        for <linux-scsi@vger.kernel.org>; Fri, 30 Jun 2023 12:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688152459; x=1690744459;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AFSZt7xSvjgnwowljwfaSL0KYBrFwIuNSlq3FmFfoLk=;
        b=L1lUeXrgKTQWTiHX++f/o0dPzCF+QreuDM+I/RZo99sUZ95IJTAYUk5gUC7Krs37f7
         RH50oaRldEJ8bd5UW7KySkT1XeRwF0mPSLP6QX1n/L0YRt3WYK//4gEBncxMZG5sfec+
         g1gXtnMzJQ+vAE1oUGrZNPhcM4snJ8wX1T6jc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688152459; x=1690744459;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AFSZt7xSvjgnwowljwfaSL0KYBrFwIuNSlq3FmFfoLk=;
        b=EwHvLAJwqVM2Q5L3zXzRKMofy41AHfsQNafym17YCgeSm4ggvfJ/W98FZ64fBcKAMj
         Mehe7VbeZhyEUzCZZzzE4PpAyvAf7BmaLrQqWAaPSOrTQSLcm/u5Ubb9ALte3Mh3rlmM
         1sIhWKEi55ML+10WeFnPHgRyMqPC2fikvBDhA0pF2l2dgwzU7dx6hgE+dQl5rz0Wu81Y
         3HIpzHVtHUK/QFcVxbPomLbewDxBoK/G0qbwXSTqZ/y5NNm/RZ6bWWNx/e+UFjZFZrCH
         dNcNzCNjZPXcfibnED/XthztPCfDdJHmj1VYQzfh09tEMKy7E61L5N/cO2Y7DIv3y5Xj
         /hRw==
X-Gm-Message-State: ABy/qLZEi/BV7TbPoqd11FPoPcNgJNMbBBtK1Cm/Pfnvf4dNOEgdlR1+
        njJ/MD2LvRXV9fW1J4Yw2b0NdF5qPuueOQhAIDN/W4Y+
X-Google-Smtp-Source: APBJJlGzzaLGLbdFjs0hxDh+fP9Dd/WsMzlQfDO1sjEmHpcs0TfQUTkdeSNcLouW3B1ElzCmJsoOhQ==
X-Received: by 2002:a17:906:1c42:b0:992:825d:71f1 with SMTP id l2-20020a1709061c4200b00992825d71f1mr2524989ejg.39.1688152458981;
        Fri, 30 Jun 2023 12:14:18 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id e7-20020a170906248700b00992a8a54f32sm2445322ejb.139.2023.06.30.12.14.18
        for <linux-scsi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 12:14:18 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-51d9a925e9aso2461707a12.0
        for <linux-scsi@vger.kernel.org>; Fri, 30 Jun 2023 12:14:18 -0700 (PDT)
X-Received: by 2002:a05:6402:b16:b0:51d:8100:863c with SMTP id
 bm22-20020a0564020b1600b0051d8100863cmr2317798edb.25.1688152457976; Fri, 30
 Jun 2023 12:14:17 -0700 (PDT)
MIME-Version: 1.0
References: <23bd2eafa9b9a23e4a8a96fc0180bba9e77e42ca.camel@HansenPartnership.com>
In-Reply-To: <23bd2eafa9b9a23e4a8a96fc0180bba9e77e42ca.camel@HansenPartnership.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 30 Jun 2023 12:14:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjgnB11KzroXS+Gi1TQO19uf0FvkMBn=V7mcQ8q78ucnQ@mail.gmail.com>
Message-ID: <CAHk-=wjgnB11KzroXS+Gi1TQO19uf0FvkMBn=V7mcQ8q78ucnQ@mail.gmail.com>
Subject: Re: [GIT PULL] first round of SCSI updates for the 6.4+ merge window
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, 29 Jun 2023 at 05:48, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
>    We have a couple of major core changes impacting other
> systems: Command Duration Limits, which spills into block and ATA and
> block level Persistent Reservation Operations, which touches block,
> nvme, target and dm (both of which are added with merge commits
> containing a cover letter explaining what's going on).

Random side note - as an outsider that then sees a trivial conflict
due to the split of the nmve side into a file called 'pr.c', I can
only say that my reaction to that was "what a horrible filename".

Maybe it makes sense to people that are very into nvme, but honestly,
considering it's a new special thing, I kind of doubt it.

We really don't lack the disk-space to use more descriptive names for
files. "pr.c" really is pretty horrid.

It's not like that file even had a comment at the top about what it was.

And yes, while I was looking around, I realized that we've had that
<linux/pr.h> header file forever. So this inscrutable naming isn't
new.

We have a few other horrors here. Quickly, without looking at them,
what is 'rv.h' of 'nd.h'?

But three old wrongs don't make a right.

              Linus
