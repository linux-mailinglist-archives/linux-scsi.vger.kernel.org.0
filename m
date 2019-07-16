Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72C0B6A219
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Jul 2019 08:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbfGPGIs (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 16 Jul 2019 02:08:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42016 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbfGPGIs (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 16 Jul 2019 02:08:48 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ABF403082E8E;
        Tue, 16 Jul 2019 06:08:47 +0000 (UTC)
Received: from ming.t460p (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F0A4600C4;
        Tue, 16 Jul 2019 06:08:36 +0000 (UTC)
Date:   Tue, 16 Jul 2019 14:08:30 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>
Subject: Re: [RFC PATCH 2/7] blk-mq: add blk-mq flag of
 BLK_MQ_F_NO_MANAGED_IRQ
Message-ID: <20190716060828.GA1094@ming.t460p>
References: <20190712024726.1227-1-ming.lei@redhat.com>
 <20190712024726.1227-3-ming.lei@redhat.com>
 <ce954a60-5a7a-a13d-b999-6f973a440d22@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce954a60-5a7a-a13d-b999-6f973a440d22@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 16 Jul 2019 06:08:47 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, Jul 16, 2019 at 10:53:00AM +0800, John Garry wrote:
> 在 12/07/2019 10:47, Ming Lei 写道:
> > We will stop hw queue and wait for completion of in-flight requests
> > when one hctx is becoming dead in the following patch. This way may
> > cause dead-lock for some stacking blk-mq drivers, such as dm-rq and
> > loop.
> > 
> > Add blk-mq flag of BLK_MQ_F_NO_MANAGED_IRQ and mark it for dm-rq and
> > loop, so we needn't to wait for completion of in-flight requests of
> > dm-rq & loop, then the potential dead-lock can be avoided.
> 
> Wouldn't it make more sense to have the flag name be like
> BLK_MQ_F_DONT_DRAIN_STOPPED_HCTX?
> 
> I did not think that blk-mq is specifically concerned with managed
> interrupts, but only their indirect effect.

I am fine with either one, however it is easier for drivers to
recognize if this flag should be set, given BLK_MQ_F_NO_MANAGED_IRQ
is self-explained.

Also on the other side, this patchset serves a generic blk-mq fix
for managed IRQ issue, so it is reasonable for all drivers which
don't use managed IRQ to set the flag.

> 
> > 
> > Cc: Bart Van Assche <bvanassche@acm.org>
> > Cc: Hannes Reinecke <hare@suse.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Keith Busch <keith.busch@intel.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >   block/blk-mq-debugfs.c | 1 +
> >   drivers/block/loop.c   | 2 +-
> >   drivers/md/dm-rq.c     | 2 +-
> >   include/linux/blk-mq.h | 1 +
> >   4 files changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> > index af40a02c46ee..24fff8c90942 100644
> > --- a/block/blk-mq-debugfs.c
> > +++ b/block/blk-mq-debugfs.c
> > @@ -240,6 +240,7 @@ static const char *const hctx_flag_name[] = {
> >   	HCTX_FLAG_NAME(TAG_SHARED),
> >   	HCTX_FLAG_NAME(BLOCKING),
> >   	HCTX_FLAG_NAME(NO_SCHED),
> > +	HCTX_FLAG_NAME(NO_MANAGED_IRQ),
> >   };
> >   #undef HCTX_FLAG_NAME
> > diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> > index 44c9985f352a..199d76e8bf46 100644
> > --- a/drivers/block/loop.c
> > +++ b/drivers/block/loop.c
> > @@ -1986,7 +1986,7 @@ static int loop_add(struct loop_device **l, int i)
> >   	lo->tag_set.queue_depth = 128;
> >   	lo->tag_set.numa_node = NUMA_NO_NODE;
> >   	lo->tag_set.cmd_size = sizeof(struct loop_cmd);
> > -	lo->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
> > +	lo->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_NO_MANAGED_IRQ;
> 
> nit: at this point in the series you're setting a flag which is never
> checked.

Yeah, I see, and this way is a bit easier for review purpose.

thanks,
Ming
