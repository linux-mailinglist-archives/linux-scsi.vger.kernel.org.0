Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E46B7329BF
	for <lists+linux-scsi@lfdr.de>; Mon,  3 Jun 2019 09:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbfFCHhq (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 3 Jun 2019 03:37:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57680 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfFCHhq (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 3 Jun 2019 03:37:46 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9B349C18B2CC;
        Mon,  3 Jun 2019 07:37:45 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B5E760BFB;
        Mon,  3 Jun 2019 07:37:38 +0000 (UTC)
Date:   Mon, 3 Jun 2019 15:37:34 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Ming Lei <tom.leiming@gmail.com>,
        John Garry <john.garry@huawei.com>, linux-scsi@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH RFC] hisi_sas_v3: multiqueue support
Message-ID: <20190603073733.GA11812@ming.t460p>
References: <20190531074158.76923-1-hare@suse.de>
 <20190531082116.GA12106@ming.t460p>
 <e81ca95e-95af-1078-c523-701120dd4ca7@suse.de>
 <20190531084600.GB12106@ming.t460p>
 <f7e184d4-3d90-2c36-84b8-702105dccafb@suse.de>
 <20190531230620.GB16190@ming.t460p>
 <fc049d0a-a7e3-894a-0680-574d86603ea5@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc049d0a-a7e3-894a-0680-574d86603ea5@suse.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 03 Jun 2019 07:37:45 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, Jun 03, 2019 at 08:08:18AM +0200, Hannes Reinecke wrote:
> On 6/1/19 1:06 AM, Ming Lei wrote:
> > On Fri, May 31, 2019 at 12:26:56PM +0200, Hannes Reinecke wrote:
> >> On 5/31/19 10:46 AM, Ming Lei wrote:
> [ .. ]
> >> First we check for the 'slot_index_alloc()' callback to handle weird v2
> >> allocation rules, _then_ we look for a tag, and only if we do _not_ have
> >> a tag we're using the bitmap.
> > 
> > OK, looks I miss the above change.
> > 
> >> And the bitmap is already correctly sized, as otherwise we'd have a
> >> clash between internal and tagged I/O commands even now.
> > 
> > But now the big problem is in the following two line code:
> > 
> > +       else if (blk_tag != (u32)-1)
> > +               rc = blk_mq_unique_tag_to_tag(blk_tag);
> > 
> > Request from different blk-mq hw queue has same tag returned from
> > blk_mq_unique_tag_to_tag().
> > 
> Yes, but the sbitmap allocator will ensure that each command will get a
> unique tag.

Each hw queue has independent sbitmap allocator, so commands with same
tag can come from different hw queue.

So you meant this RFC patch depends on the host-wide tags patchset I
posted?

> 
> > Now the biggest question is that if V3 hw supports per-queue tags,
> > If yes, it should be real MQ hardware, otherwise I guess commands with
> > same tag at the same time may not work for host-wide tags.
> > 
> 
> Of course you can't have different commands with the same tag. But the
> sbitmap allocator prevents this from happening, as for host-wide tags
> the tagset is _shared_ between all devices, so the sbitmap allocator
> will only ever run on _one_ tagset for all commands.

But blk-mq doesn't support host-wide tags yet, so how can this single
patch work?


Thanks,
Ming
