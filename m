Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C44B521F85
	for <lists+linux-scsi@lfdr.de>; Fri, 17 May 2019 23:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfEQVUd (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 17 May 2019 17:20:33 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:39031 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbfEQVUd (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 17 May 2019 17:20:33 -0400
Received: by mail-lj1-f176.google.com with SMTP id a10so7507796ljf.6
        for <linux-scsi@vger.kernel.org>; Fri, 17 May 2019 14:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TeG6rEmkcjh6hsbhIni+X0M4ao2fCvuLYPl9D/OPgmE=;
        b=d3YwA7IHFLGisd9uu9yYMbG89YFREzsaXn8L9GK8jHU/c0VcceV3lgAYucSxVuRIBm
         FvtO/1clDFuC1lO3mu7dZDcyBVuugXShHFSzscIXYDoL/J7+LoN0Xx2GBrO84CyTj93W
         lmp1jxHZmFhWSipBZ0y+mPuv+wl4eU/a6XI18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TeG6rEmkcjh6hsbhIni+X0M4ao2fCvuLYPl9D/OPgmE=;
        b=ePyHMifF+MQenkVFQkO9RZ6/MbWTRFOV5tQ1nhgGnNuFrg50qpxr26cVVesZ2Q63dV
         8L794YhctNx+jIOcvNpmxuUtAeFtlalDC/2Km907Ihd+FSLqUy8jlyXdTOGMd3B/+ODu
         /xPUA9rt99qUiLjgZr0ZCmRpU26VP9C2GGcJFXAw4uiTwLILGGw4JuinNA9mVwohmf4f
         YDYI1luwFtoIj7I+rHqO4vV092ulMcm1QcMsOzKnl0WEGxGami/zextkawOsTV70PL17
         dOksBM3C8Cqq/Q+MlCS0RohOBTtUr5hdxqBSOLwuhaPvVrPadGh186tLd/LHkHYVx4vO
         6+dA==
X-Gm-Message-State: APjAAAWsH4v2lUcYNy6ExPpdMPxLmupT7c6UHhmYsp30/pLCyvi0SKSG
        T6HY+np+ZbwXPkKKUw1j+SccWQ5Ku+E=
X-Google-Smtp-Source: APXvYqybqx0/zqDEpH7Za6wviNOrugZc1yyHyDwfgSBBbqkbHi43ZRZBIsVYAvugNy/2n5EHhzh2AA==
X-Received: by 2002:a2e:a294:: with SMTP id k20mr23477132lja.118.1558128031147;
        Fri, 17 May 2019 14:20:31 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id v1sm1903170lfa.93.2019.05.17.14.20.30
        for <linux-scsi@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 14:20:30 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id f1so6296906lfl.6
        for <linux-scsi@vger.kernel.org>; Fri, 17 May 2019 14:20:30 -0700 (PDT)
X-Received: by 2002:a19:7d42:: with SMTP id y63mr21391396lfc.54.1558128029916;
 Fri, 17 May 2019 14:20:29 -0700 (PDT)
MIME-Version: 1.0
References: <1558104285.3050.8.camel@HansenPartnership.com>
In-Reply-To: <1558104285.3050.8.camel@HansenPartnership.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 May 2019 14:20:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiAdmRv-Piq6LKvgLDgQC+AV-RYK2O-RC09SRRGq3v1cw@mail.gmail.com>
Message-ID: <CAHk-=wiAdmRv-Piq6LKvgLDgQC+AV-RYK2O-RC09SRRGq3v1cw@mail.gmail.com>
Subject: Re: [GIT PULL] final round of SCSI updates for the 5.1+ merge window
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, May 17, 2019 at 7:44 AM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> This is the final round of mostly small fixes in our initial
> submit.  The fix for the read only regressions is the most extensive
> change and also intrudes outside of SCSI because the partition and read
> only handling is mostly in block.

No. That code is insane. It looks very fishy indeed to me, and I'm not
pulling it this late in the game.

If the partition table gets re-read, the old read-only state should go
away - for all ew know, the partition numbers may have changed, for
chrissake! So you can't just say "oh, partition number 1 used to be
read-only, so now we need to keep it read-only". That partition might
be something completely different after the parition table has been
invalidated.

So the new model that code uses looks completely bogus to me, and is
not anything we've ever done before.

Just revert the oneliner SCSI change that caused the regression.

             Linus
