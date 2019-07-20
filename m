Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 850EE6F0FC
	for <lists+linux-scsi@lfdr.de>; Sun, 21 Jul 2019 01:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbfGTXFq (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 20 Jul 2019 19:05:46 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:39838 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725922AbfGTXFq (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 20 Jul 2019 19:05:46 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id E7E738EE109;
        Sat, 20 Jul 2019 16:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1563663946;
        bh=1HI2ZB1eHUIMJm8Xpzvk8CJ6Q0gix2nvWokM73s72lY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=dXdfGGfWgMHoKVKX7uDbOQGvUlj3ffNIdXYdrzhGFa1o+oFvTaz42SSVzo1YVP4F+
         aVRp3JYV2N69ogIPOcEzUELI04MF4Oqq0nVFrNqM6ZL7qgQSiOuw8Xzk802+4eISP+
         AW0o/MAaROBsfdYuWh8q7c5gJaYx9jxCGgl4CKjM=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yPx_wDLn99RA; Sat, 20 Jul 2019 16:05:45 -0700 (PDT)
Received: from [192.168.12.43] (p511103-ipngn2301koufu.yamanashi.ocn.ne.jp [118.6.44.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 64E6B8EE0DF;
        Sat, 20 Jul 2019 16:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1563663944;
        bh=1HI2ZB1eHUIMJm8Xpzvk8CJ6Q0gix2nvWokM73s72lY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=VNGQoOAoTLGSz5ta5OBK4YGWYXw+WShBc6kTx57IdB7FE2I1rAb2741ZUXjRvkWe7
         7z+UVT27qorfvDxSTJZ7wYSJuQayj1GA+B0EgYMnnMsAjCcXY0aOXLrpmGmrSMRXYk
         7xQVDz3+Ejnb/6h2v3BOOfXh3dwwPK/KZIAOKwV8=
Message-ID: <1563663940.3478.8.camel@HansenPartnership.com>
Subject: Re: [PATCH] fcoe: avoid memset across pointer boundaries
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>
Date:   Sun, 21 Jul 2019 08:05:40 +0900
In-Reply-To: <CAHk-=wheOAo2tQ2mfsSE2iAxxURg62jVt9QsZBL1TPL52aZbvQ@mail.gmail.com>
References: <20190604093028.79673-1-hare@suse.de>
         <CAHk-=wheOAo2tQ2mfsSE2iAxxURg62jVt9QsZBL1TPL52aZbvQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sat, 2019-07-20 at 12:21 -0700, Linus Torvalds wrote:
> On Tue, Jun 4, 2019 at 2:30 AM Hannes Reinecke <hare@suse.de> wrote:
> > 
> > Gcc-9 complains for a memset across pointer boundaries, which
> > happens as the code tries to allocate a flexible array on the
> > stack. Turns out we cannot do this without relying on gcc-isms, so
> > this patch converts the stack allocation in proper kzalloc() calls.
> > 
> > Signed-off-by: Hannes Reinecke <hare@suse.com>
> 
> So this patch apparently isn't making it into 5.3?
> 
> The gcc-9 warnings are still there, and as annoying as they were
> originally. Appended for your viewing "pleasure" once again, in case
> you don't have gcc-9 installed..

Is that a Reviewed-By or Tested-by?  If so we can slide it into one of
the -rc candidates.

James

