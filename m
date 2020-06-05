Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 072A11F0238
	for <lists+linux-scsi@lfdr.de>; Fri,  5 Jun 2020 23:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbgFEVlx (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 5 Jun 2020 17:41:53 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:55416 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728727AbgFEVlv (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 5 Jun 2020 17:41:51 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id A01C58EE17B;
        Fri,  5 Jun 2020 14:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1591393310;
        bh=48ApKiNXm1HVa5YUU3DA6ohP4QLZPkpj74quohwZYgg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Y0H7ex29UCo8zPQYDi5nCfRpjQWAm775FNM/UFgVrZh8rLlEge0bx+egKbRxEdFsF
         CY0SlgpElW2MMZHaVxCQ2EGsnkoXF+Liw172+53rQ+Du4in2k3oDMlgSsQksCkvN7p
         8OpMbLJvv5TRPstNgVE4jVP+fBLHNzwTOp6IuZJw=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 92iVsJ_6Q6Tk; Fri,  5 Jun 2020 14:41:50 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 06C268EE0CE;
        Fri,  5 Jun 2020 14:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1591393310;
        bh=48ApKiNXm1HVa5YUU3DA6ohP4QLZPkpj74quohwZYgg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Y0H7ex29UCo8zPQYDi5nCfRpjQWAm775FNM/UFgVrZh8rLlEge0bx+egKbRxEdFsF
         CY0SlgpElW2MMZHaVxCQ2EGsnkoXF+Liw172+53rQ+Du4in2k3oDMlgSsQksCkvN7p
         8OpMbLJvv5TRPstNgVE4jVP+fBLHNzwTOp6IuZJw=
Message-ID: <1591393308.4728.100.camel@HansenPartnership.com>
Subject: Re: [GIT PULL] first round of SCSI updates for the 5.6+ merge window
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 05 Jun 2020 14:41:48 -0700
In-Reply-To: <CAHk-=wjy8sMqjft6ALTo28UECex84uiYEo=BJbLUJ_CHrPmOEQ@mail.gmail.com>
References: <1591332925.3685.16.camel@HansenPartnership.com>
         <CAHk-=wjiQmscZHzOYKmMpFoy4h4xF1Mvf9O8i6qtTtS38t6Wsg@mail.gmail.com>
         <1591391891.4728.96.camel@HansenPartnership.com>
         <CAHk-=wjy8sMqjft6ALTo28UECex84uiYEo=BJbLUJ_CHrPmOEQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, 2020-06-05 at 14:25 -0700, Linus Torvalds wrote:
> On Fri, Jun 5, 2020 at 2:18 PM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > 
> > Um, no, shuffles feet ... I actually tagged the wrong branch:
> 
> Ok, now I see the changes, but I see more than you reported.
> 
> These seem to be new compared to your pull request:
> 
> Al Viro (4):
>       scsi: hpsa: Lift {BIG_,}IOCTL_Command_struct copy{in,out} into
> hpsa_ioctl()
>       scsi: hpsa: Don't bother with vmalloc for
> BIG_IOCTL_Command_struct
>       scsi: hpsa: Get rid of compat_alloc_user_space()
>       scsi: hpsa: hpsa_ioctl(): Tidy up a bit
> 
> Can Guo (1):
>       scsi: ufs: Don't update urgent bkops level when toggling auto
> bkops
> 
> Stanley Chu (1):
>       scsi: ufs: Remove redundant urgent_bkop_lvl initialization
> 
> They don't look alarming, but I don't like how I don't see what you
> _claim_ I should see.
> 
> Hmm?

Ah right, my MO is to do the first push and then start gathering for
the second.  pushing the tag again picked up the new stuff I've been
gathering.  Let me rewind the tag back to where it was for the original
push and then try again.

Done.  You should now see no stray additional patches on the scsi-misc
tag.

Sorry again, I believe I've actually fully verified the diffstat
matches this time ... (famous last words ..)

James


