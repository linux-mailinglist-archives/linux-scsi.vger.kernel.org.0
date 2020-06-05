Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15F91F016C
	for <lists+linux-scsi@lfdr.de>; Fri,  5 Jun 2020 23:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbgFEVSO (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 5 Jun 2020 17:18:14 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:55214 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728248AbgFEVSO (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 5 Jun 2020 17:18:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id A9DD88EE17B;
        Fri,  5 Jun 2020 14:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1591391893;
        bh=fvQ5lXXp/5KD4vDVeCdckFEdmRAm58yLylnHAerd8EU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Y1Q6AJdFWs4C6umRRKaOSsAkd/aZ6/KFnDKUFTM3cXGn6h86cY8WVEgtgKRezjGvf
         QgB4Lh5qDjbdFrE3JKJDJlQK1fupF4Y4YDgbMV+T2FXYGD0Kv5QjpOM/6VXROHazGI
         6akCNl4ynYPVK+eWThXfjCi7o3PAX1v4XL1eLbBg=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3JikwkIJJBpC; Fri,  5 Jun 2020 14:18:13 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id E5F0F8EE0CE;
        Fri,  5 Jun 2020 14:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1591391893;
        bh=fvQ5lXXp/5KD4vDVeCdckFEdmRAm58yLylnHAerd8EU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Y1Q6AJdFWs4C6umRRKaOSsAkd/aZ6/KFnDKUFTM3cXGn6h86cY8WVEgtgKRezjGvf
         QgB4Lh5qDjbdFrE3JKJDJlQK1fupF4Y4YDgbMV+T2FXYGD0Kv5QjpOM/6VXROHazGI
         6akCNl4ynYPVK+eWThXfjCi7o3PAX1v4XL1eLbBg=
Message-ID: <1591391891.4728.96.camel@HansenPartnership.com>
Subject: Re: [GIT PULL] first round of SCSI updates for the 5.6+ merge window
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 05 Jun 2020 14:18:11 -0700
In-Reply-To: <CAHk-=wjiQmscZHzOYKmMpFoy4h4xF1Mvf9O8i6qtTtS38t6Wsg@mail.gmail.com>
References: <1591332925.3685.16.camel@HansenPartnership.com>
         <CAHk-=wjiQmscZHzOYKmMpFoy4h4xF1Mvf9O8i6qtTtS38t6Wsg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, 2020-06-05 at 14:11 -0700, Linus Torvalds wrote:
> On Thu, Jun 4, 2020 at 9:55 PM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-
> > misc
> 
>    "Already up to date."
> 
> Did you forget to force a push? That scsi-misc tag is your tag from
> April 10.

Um, no, shuffles feet ... I actually tagged the wrong branch:

https://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git/tag/?h=scsi-fixes

I've tagged the right branch now if you repull the scsi-misc tag. 
Sorry about that; I think it's finger memory from so many fixes
updates.

James

