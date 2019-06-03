Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64E6B32CE9
	for <lists+linux-scsi@lfdr.de>; Mon,  3 Jun 2019 11:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbfFCJb6 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 3 Jun 2019 05:31:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50446 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727870AbfFCJb6 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 3 Jun 2019 05:31:58 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D866581DFC;
        Mon,  3 Jun 2019 09:31:57 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5064560490;
        Mon,  3 Jun 2019 09:31:38 +0000 (UTC)
Date:   Mon, 3 Jun 2019 17:31:29 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hannes Reinecke <hare@suse.com>
Cc:     Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Ming Lei <tom.leiming@gmail.com>,
        John Garry <john.garry@huawei.com>, linux-scsi@vger.kernel.org
Subject: Re: [PATCH RFC] hisi_sas_v3: multiqueue support
Message-ID: <20190603093128.GD11812@ming.t460p>
References: <20190531082116.GA12106@ming.t460p>
 <e81ca95e-95af-1078-c523-701120dd4ca7@suse.de>
 <20190531084600.GB12106@ming.t460p>
 <f7e184d4-3d90-2c36-84b8-702105dccafb@suse.de>
 <20190531230620.GB16190@ming.t460p>
 <fc049d0a-a7e3-894a-0680-574d86603ea5@suse.de>
 <20190603073733.GA11812@ming.t460p>
 <f0901773-0faf-7a4e-bb17-3e584de00c4f@suse.de>
 <20190603081621.GC11812@ming.t460p>
 <cd22b399-789d-c0fd-5748-5feeea90c0ee@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd22b399-789d-c0fd-5748-5feeea90c0ee@suse.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 03 Jun 2019 09:31:57 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, Jun 03, 2019 at 10:47:24AM +0200, Hannes Reinecke wrote:
> On 6/3/19 10:16 AM, Ming Lei wrote:
> > On Mon, Jun 03, 2019 at 09:46:39AM +0200, Hannes Reinecke wrote:
> >> On 6/3/19 9:37 AM, Ming Lei wrote:
> >>> On Mon, Jun 03, 2019 at 08:08:18AM +0200, Hannes Reinecke wrote:
> >>>> On 6/1/19 1:06 AM, Ming Lei wrote:
> >>>>> On Fri, May 31, 2019 at 12:26:56PM +0200, Hannes Reinecke wrote:
> >>>>>> On 5/31/19 10:46 AM, Ming Lei wrote:
> >>>> [ .. ]
> >>>>>> First we check for the 'slot_index_alloc()' callback to handle weird v2
> >>>>>> allocation rules, _then_ we look for a tag, and only if we do _not_ have
> >>>>>> a tag we're using the bitmap.
> >>>>>
> >>>>> OK, looks I miss the above change.
> >>>>>
> >>>>>> And the bitmap is already correctly sized, as otherwise we'd have a
> >>>>>> clash between internal and tagged I/O commands even now.
> >>>>>
> >>>>> But now the big problem is in the following two line code:
> >>>>>
> >>>>> +       else if (blk_tag != (u32)-1)
> >>>>> +               rc = blk_mq_unique_tag_to_tag(blk_tag);
> >>>>>
> >>>>> Request from different blk-mq hw queue has same tag returned from
> >>>>> blk_mq_unique_tag_to_tag().
> >>>>>
> >>>> Yes, but the sbitmap allocator will ensure that each command will get a
> >>>> unique tag.
> >>>
> >>> Each hw queue has independent sbitmap allocator, so commands with same
> >>> tag can come from different hw queue.
> >>>
> >> It does not for SCSI.
> >> See below.
> >>
> >>> So you meant this RFC patch depends on the host-wide tags patchset I
> >>> posted?
> >>>
> >>>>
> >>>>> Now the biggest question is that if V3 hw supports per-queue tags,
> >>>>> If yes, it should be real MQ hardware, otherwise I guess commands with
> >>>>> same tag at the same time may not work for host-wide tags.
> >>>>>
> >>>>
> >>>> Of course you can't have different commands with the same tag. But the
> >>>> sbitmap allocator prevents this from happening, as for host-wide tags
> >>>> the tagset is _shared_ between all devices, so the sbitmap allocator
> >>>> will only ever run on _one_ tagset for all commands.
> >>>
> >>> But blk-mq doesn't support host-wide tags yet, so how can this single
> >>> patch work?
> >>>
> >> Wrong. It does:
> >>
> >> struct request_queue *scsi_mq_alloc_queue(struct scsi_device *sdev)
> >> {
> >> 	sdev->request_queue = blk_mq_init_queue(&sdev->host->tag_set);
> >> 	if (IS_ERR(sdev->request_queue))
> >> 		return NULL;
> >>
> >> 	sdev->request_queue->queuedata = sdev;
> >> 	__scsi_init_queue(sdev->host, sdev->request_queue);
> >> 	blk_queue_flag_set(QUEUE_FLAG_SCSI_PASSTHROUGH, sdev->request_queue);
> >> 	return sdev->request_queue;
> >> }
> >>
> >>
> >> IE every scsi device is using the tagset from the host.
> > 
> > Looks we are not in the same page, and you misunderstood two concepts:
> > scsi's host-wide tagset, and the new host-tags of BLK_MQ_F_HOST_TAGS.
> > 
> > I admit that the new flag of BLK_MQ_F_HOST_TAGS is misleading.
> > 
> > Now let me clarify it a bit:
> > 
> > 1) the current SCSI hostwide tags means all LUNs share the host tagset,
> > but the tagset may include multiple hw queues, and each hw queue still
> > has independent tags, that is why blk-mq provides blk_mq_unique_tag().
> > In short, each LUN's hw queue has independent tags.
> > 
> Which is where I fundamentally disagree.
> Each hw queue does _not_ have independent tags.
> Each hw queue will use tags from the same (host-wide) tagset; the tags
> themselves will be allocated for each queue on an ad-hoc base, ie there
> is no fixed mapping between tag values and hardware queues.

Tagset is set of tags, and one tags is for serving one hw queue.

Each hw queue has its own tags, please see __blk_mq_alloc_rq_map()
in which standalone sbitmap allocator and rq pool is allocated to
each hw queue represented by 'hctx_idx'.

And for each hw queue, the allocated tag value for request is in
the range of 0 ~ queue_depth - 1, that is why I say requests from
different hw queue may have same tag.

Your RFC patch changes to allow requests with same tag submitted to driver
& hardware at the same time, so we should double-check if hisi_v3 hardware
is happy with this change.

John, is hisi_sas v3 fine with this way?

> Which is why there is blk_mq_unique_tag(); this precisely returns a tag
> which is unique across all devices from this host by shifting the queue
> number on top of the actual tag number:
> 
> u32 blk_mq_unique_tag(struct request *rq)
> {
> 	return (rq->mq_hctx->queue_num << BLK_MQ_UNIQUE_TAG_BITS) |
> 		(rq->tag & BLK_MQ_UNIQUE_TAG_MASK);
> }
>

See the two line code in your patch again:

+       else if (blk_tag != (u32)-1)
+               rc = blk_mq_unique_tag_to_tag(blk_tag);

rc is same with rq->tag, which can be same for requests submitted from
different hw queues at the same time.

Then look at the following code in hisi_sas_task_prep():

        slot_idx = rc;
        slot = &hisi_hba->slot_info[slot_idx];

Your patch causes the same .slot_info[] used by more than 1 requsts at
the same time. I don't think this way can work because .slot_info is
host-wide, instead of hw queue wide.

> So the tagset itself is not split across devices, and all devices can
> (potentially) use all tags from the tagset.

Right, I never said this kind of split.

> 
> > 
> > 2) some drivers(hisi_v3 hw, hpsa, megraid_sas, mpt3sas) only support
> > single hw queue, but has multiple reply queue which can avoid CPU
> > lockup, so we are working towards converting the private reply queue
> > into blk-mq hw queue. That is what BLK_MQ_F_HOST_TAGS covers.
> > 
> I am aware.
> 
> > Now you think 1) is enough for converting the private reply queue into
> > blk-mq hw queue, that is definitely not correct since blk-mq MQ doesn't
> > support shared tags among hw queues.
> > 
> Currently blk-mq assumes a symmetric submission/completion model, ie it
> is assumed that a multiqueue device will have the same number of
> submissions and completion queues.
> 
> For the HBAs listed above the submission works by writing an address
> into a single dedicated PCI register, whereas there are completion
> queues per interrupt. So we really have a 1:n mapping between submission
> and completion queues.
> 
> Which is what your patchset is trying to address, and I'm perfectly fine
> with this.
> 
> All I'm arguing is that hisi_sas v3 really maps onto the original model,
> seeing that is has per-queue submission paths, and as such maps more
> closely on the original model for blk-mq.
> Hence I do think that hisi_sas v3 should benefit more from moving to
> that 'full' blk-mq model, and not the simplified 1:n model you are
> proposing.

It depends on if hisi_sas V3 hardware supports independent tags for
each queue.

As I said, your patch changes to submit requests with same tag(returned
from blk_mq_unique_tag_to_tag) to hisi_sas V3 hardware. If the hardware
is fine with this way, we can convert it to typical MQ model, that is
definitely the best way.


Thanks,
Ming
