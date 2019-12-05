Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D30211142C6
	for <lists+linux-scsi@lfdr.de>; Thu,  5 Dec 2019 15:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729502AbfLEOgh (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 5 Dec 2019 09:36:37 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36706 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729426AbfLEOgh (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 5 Dec 2019 09:36:37 -0500
Received: by mail-ot1-f67.google.com with SMTP id i4so2778691otr.3
        for <linux-scsi@vger.kernel.org>; Thu, 05 Dec 2019 06:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockbridge-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nb1iCxXYbt2jkN74UTYTGkL9Q0crXuctu/rAfI3chic=;
        b=Mliv1jVwJONxPxX8a+HIrkjg+1+iqeWdjJtk5PSTsbTpVYpYK9rnTYc9IlzCWSFp6C
         hLRbRY6NqdzU1TbcsV4pre8NqQZU57la7/w15fp3tcEcKMpxuOPcs8i+1sk5KJrShNsT
         biPNn/LJyLs9i+ykuRTqjeBacKl/swEJlB6Ttljja+laCFHVPq84rZEPT6GzOuteNa5X
         NtRXQOicvkVx/5wUs5HbiQHw8WeBTesrNWlpIWpPwnrBCVL/bBz6AEsjSIZWz2tyzRe4
         O5gjrF9HyKIJNiWKeygmUnfRMrGtpcZSR2dwY1LITYqQSbCWMO3MdSeGvBKjUesbOur8
         hI0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nb1iCxXYbt2jkN74UTYTGkL9Q0crXuctu/rAfI3chic=;
        b=ZoqN4Q9gTtfaQcK5YseE8SmyH61EXMGc3KRko9h2bPW25DP5OnKFslP7hwaNboCrie
         aJEKm7evJqcs3dtWSWy0yHRxCODjaFvtpW8wrmpZeeKWHOw3XkfSepp8ucnOIvy4CuNa
         hNFfbXAoth8WLxF0hHeGAX6DH7OmCuQl36hMuoB15HOtaZAxj8H3uhf3xaxgyQUms4Dy
         r997eKeikpzQNDOnmadKyGUiJnIJT+PEyhGAO3ocv9GqXy8GJCu+YJlQ+NTSjt5X031x
         L8x9j9vYAaDKvSYCD1MLpWiBgIiz+b8hwutInLsGQt508znxwcfs8VnurVvqrFyH+WXn
         fA5w==
X-Gm-Message-State: APjAAAXIa5+gGMVHTCBzZn1gh+3c1jBjjjGIeVCszW5uzWlYLtCRxjtX
        SeE27q2jArf1WhuYm63eZUGR5e0tlvVnIrKW2bqC3w==
X-Google-Smtp-Source: APXvYqzGI+fRlB/GMXFu6Wwbd4QM3eRy5QYgmqsBwAn/vjLzUklIRe/Ogzd3OhFZVBzVUTgdbpdfwtlUMu6+ljI8xcQ=
X-Received: by 2002:a05:6830:2141:: with SMTP id r1mr6342822otd.124.1575556596256;
 Thu, 05 Dec 2019 06:36:36 -0800 (PST)
MIME-Version: 1.0
References: <CAAFE1beMkvyRctGqpffd3o_QtDH0CrmQSb=fV4GzqMUXWzPyOw@mail.gmail.com>
 <20191203005849.GB25002@ming.t460p> <CAAFE1bcG8c1Q3iwh-LUjruBMAuFTJ4qWxNGsnhfKvGWHNLAeEQ@mail.gmail.com>
 <20191203031444.GB6245@ming.t460p> <CAAFE1besnb=HV4C_buORYpWbkXecmtybwX8d_Ka2NsKmiym53w@mail.gmail.com>
 <CAAFE1bfpUWCZrtR8v3S++0-+gi8DJ79X3e0XqDe93i8nuGTnNg@mail.gmail.com>
 <20191203124558.GA22805@ming.t460p> <CAAFE1bfB2Km+e=T0ahwq0r9BQrBMnSguQQ+y=yzYi3tursS+TQ@mail.gmail.com>
 <20191204010529.GA3910@ming.t460p> <CAAFE1bcJmRP5OSu=5asNTpvkF=kjEZu=GafaS9h52776tVgpPA@mail.gmail.com>
 <20191204230225.GA26189@ming.t460p> <d9d39d10-d3f3-f2d8-b32e-96896ba0cdb2@grimberg.me>
In-Reply-To: <d9d39d10-d3f3-f2d8-b32e-96896ba0cdb2@grimberg.me>
From:   Stephen Rust <srust@blockbridge.com>
Date:   Thu, 5 Dec 2019 09:36:25 -0500
Message-ID: <CAAFE1bcgKAuzmE+eYXvcj6y4SykoaWfXgzR+f2N73K_2RfZ6LA@mail.gmail.com>
Subject: Re: Data corruption in kernel 5.1+ with iSER attached ramdisk
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Rob Townley <rob.townley@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        target-devel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Max Gurtovoy <maxg@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Sagi,

On Thu, Dec 5, 2019 at 4:17 AM Sagi Grimberg <sagi@grimberg.me> wrote:
>
> Just got this one (Thanks for CCing me Ming, been extremely busy
> lately).

No problem, thanks for looking into it!

> So it looks from the report that this is the immediate-data and
> unsolicited data-out flows, which indeed seem to violate the alignment
> assumption. The reason is that isert post recv a contig rx_desc which
> has both the headers and the data, and when it gets immediate_data it
> will set the data sg to rx_desc+offset (which are the headers).
>
> Stephen,
> As a work-around for now, you should turn off immediate-data in your LIO
> target. I'll work on a fix.

I have confirmed that turning off ImmediateData in the target (and
reconnecting) is a successful workaround for this test case. All of
the I/O as reported by bio_add_page() is aligned.

Using the previously described bpftrace script with 512 offset:

# bpftrace lio.bt
Attaching 4 probes...
512 0
512 0 1 131071
4096 0
4096 0 0 0
4096 0
4096 0 0 8
4096 0
4096 0 0 131064
4096 0
4096 0 1 131064
4096 0
4096 0 0 0
4096 0
4096 0 0 8
512 0
512 0 0 131071
4096 0
4096 0 0 130944
4096 0
4096 0 0 131056

> Thanks for reporting!

Please let me know if you need any additional information, or if I can
assist further. I would be happy to test any patches when you are
ready.

Thanks,
Steve
