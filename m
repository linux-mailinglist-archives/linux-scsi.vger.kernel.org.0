Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49A8A361E9
	for <lists+linux-scsi@lfdr.de>; Wed,  5 Jun 2019 18:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbfFEQz3 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 5 Jun 2019 12:55:29 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41320 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728835AbfFEQz2 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 5 Jun 2019 12:55:28 -0400
Received: by mail-lf1-f67.google.com with SMTP id 136so8085289lfa.8
        for <linux-scsi@vger.kernel.org>; Wed, 05 Jun 2019 09:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qOaRAXWCo/zxxZcR9hTtXYLfdhb6PKzipbU8a8AazNY=;
        b=AUA4Ho5wlSp1uIC/vY4e9boyj+61/ziB5vmf6E/WiCfkiKukaQvSKgMZWvbRmhl7/w
         6n8fg0U7McgUgT2ExFNu3dcY+0JN7qMsj8NzLh7MW/ZS1DKe3+F/Is9CZ4zQxBa8maJR
         YwBCpuIya8ODBqKTf9a8U1KyhbPtMzbIMKYw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qOaRAXWCo/zxxZcR9hTtXYLfdhb6PKzipbU8a8AazNY=;
        b=RcM9AAS6WD5s9ZaCCTdZtZyMs1Gl/ioJuqyndov93MhAOOBUVOEcBk5QfaMQlwEYMb
         9ew1+BFSkr699bB3U8UlW4qS/6bsFg7xPuU7QIzfP3m0VBPvCt69rifVA7rswn8CqJXg
         oIx4+afsFyVmjAOSTzXohbjrdd/BWYHqb32v1oYogeRda10TXjyz//cn36gXpzUekAlF
         aE9Mhy1EmnLS9+GAaT9bvY6e8cv9KHDjWZ2x8vlhZf4gkVTbko5TwjhGg1yJmtehbWIm
         MV8NgN0T35DATXPuJTL2g5fUbHkRuQ5BKOhQPzYIqp3Xei3Ss+NHoX6Yf7LXhTbUqvoH
         1lxg==
X-Gm-Message-State: APjAAAUqSS+X5p//0nHl9ZUEC14tzKa3k7XEp1BPePr04WjGjOveT4Ux
        I7Qmjt76j4b/kCbUhYjPyjHgrQ/Bads=
X-Google-Smtp-Source: APXvYqxQTu9WUSy9GFX7d8Gb6opfsR5Yd3tzQK7Qfl4gDBS/iDm5RFgsH+DqyGnri/9AP2Gk0m9+FA==
X-Received: by 2002:ac2:5285:: with SMTP id q5mr20581089lfm.146.1559753725828;
        Wed, 05 Jun 2019 09:55:25 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id d2sm4279199lfh.1.2019.06.05.09.55.25
        for <linux-scsi@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 09:55:25 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id m15so19624074lfh.4
        for <linux-scsi@vger.kernel.org>; Wed, 05 Jun 2019 09:55:25 -0700 (PDT)
X-Received: by 2002:ac2:4565:: with SMTP id k5mr17446359lfm.170.1559753724121;
 Wed, 05 Jun 2019 09:55:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190605073942.125577-1-hare@suse.de>
In-Reply-To: <20190605073942.125577-1-hare@suse.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 5 Jun 2019 09:55:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi3KGOrKANYbFr4+=pH3zED=xL0rnrLnOnSN+F90JJr7g@mail.gmail.com>
Message-ID: <CAHk-=wi3KGOrKANYbFr4+=pH3zED=xL0rnrLnOnSN+F90JJr7g@mail.gmail.com>
Subject: Re: [PATCH 0/4] libfc,fcoe: cleanup fc_rport_priv usage
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Jun 5, 2019 at 12:39 AM Hannes Reinecke <hare@suse.de> wrote:
>
> the fcoe vn2vn code is using the 'fc_rport_priv' structure as argument to its
> internal function, but is really expecting a struct fcoe_rport to immediately
> follow this one. This is not only confusing but also an error for new compilers.
> So clean up the usage by embedding fc_rport_priv into fcoe_rport, and use the
> fcoe_rport structure wherever possible.

Thanks, this looks much better than what I tried to do mechanically
that turned into a complete mess.

But that's just from scanning the patches, obviously no deep review
(much less testing).

                        Linus
