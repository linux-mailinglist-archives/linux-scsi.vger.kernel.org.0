Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A986C33D47
	for <lists+linux-scsi@lfdr.de>; Tue,  4 Jun 2019 04:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbfFDCqI (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 3 Jun 2019 22:46:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49124 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbfFDCqI (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 3 Jun 2019 22:46:08 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4A725300159E;
        Tue,  4 Jun 2019 02:46:07 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 584FA60C91;
        Tue,  4 Jun 2019 02:45:58 +0000 (UTC)
Date:   Tue, 4 Jun 2019 10:45:54 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Ming Lei <tom.leiming@gmail.com>,
        John Garry <john.garry@huawei.com>, linux-scsi@vger.kernel.org
Subject: Re: [PATCH RFC] hisi_sas_v3: multiqueue support
Message-ID: <20190604024553.GA7208@ming.t460p>
References: <20190531084600.GB12106@ming.t460p>
 <f7e184d4-3d90-2c36-84b8-702105dccafb@suse.de>
 <20190531230620.GB16190@ming.t460p>
 <fc049d0a-a7e3-894a-0680-574d86603ea5@suse.de>
 <20190603073733.GA11812@ming.t460p>
 <f0901773-0faf-7a4e-bb17-3e584de00c4f@suse.de>
 <20190603081621.GC11812@ming.t460p>
 <cd22b399-789d-c0fd-5748-5feeea90c0ee@suse.com>
 <20190603093128.GD11812@ming.t460p>
 <0ba81c9b-18f5-f846-5a70-3f63096b8c19@suse.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <0ba81c9b-18f5-f846-5a70-3f63096b8c19@suse.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 04 Jun 2019 02:46:07 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 03, 2019 at 01:38:53PM +0200, Hannes Reinecke wrote:
> On 6/3/19 11:31 AM, Ming Lei wrote:
> > On Mon, Jun 03, 2019 at 10:47:24AM +0200, Hannes Reinecke wrote:
> >> On 6/3/19 10:16 AM, Ming Lei wrote:
> >>> On Mon, Jun 03, 2019 at 09:46:39AM +0200, Hannes Reinecke wrote:
> >>>> On 6/3/19 9:37 AM, Ming Lei wrote:
> >>>>> On Mon, Jun 03, 2019 at 08:08:18AM +0200, Hannes Reinecke wrote:
> >>>>>> On 6/1/19 1:06 AM, Ming Lei wrote:
> >>>>>>> On Fri, May 31, 2019 at 12:26:56PM +0200, Hannes Reinecke wrote:
> >>>>>>>> On 5/31/19 10:46 AM, Ming Lei wrote:
> >>>>>> [ .. ]
> >>>>>>>> First we check for the 'slot_index_alloc()' callback to handle weird v2
> >>>>>>>> allocation rules, _then_ we look for a tag, and only if we do _not_ have
> >>>>>>>> a tag we're using the bitmap.
> >>>>>>>
> >>>>>>> OK, looks I miss the above change.
> >>>>>>>
> >>>>>>>> And the bitmap is already correctly sized, as otherwise we'd have a
> >>>>>>>> clash between internal and tagged I/O commands even now.
> >>>>>>>
> >>>>>>> But now the big problem is in the following two line code:
> >>>>>>>
> >>>>>>> +       else if (blk_tag != (u32)-1)
> >>>>>>> +               rc = blk_mq_unique_tag_to_tag(blk_tag);
> >>>>>>>
> >>>>>>> Request from different blk-mq hw queue has same tag returned from
> >>>>>>> blk_mq_unique_tag_to_tag().
> >>>>>>>
> >>>>>> Yes, but the sbitmap allocator will ensure that each command will get a
> >>>>>> unique tag.
> >>>>>
> >>>>> Each hw queue has independent sbitmap allocator, so commands with same
> >>>>> tag can come from different hw queue.
> >>>>>
> >>>> It does not for SCSI.
> >>>> See below.
> >>>>
> >>>>> So you meant this RFC patch depends on the host-wide tags patchset I
> >>>>> posted?
> >>>>>
> >>>>>>
> >>>>>>> Now the biggest question is that if V3 hw supports per-queue tags,
> >>>>>>> If yes, it should be real MQ hardware, otherwise I guess commands with
> >>>>>>> same tag at the same time may not work for host-wide tags.
> >>>>>>>
> >>>>>>
> >>>>>> Of course you can't have different commands with the same tag. But the
> >>>>>> sbitmap allocator prevents this from happening, as for host-wide tags
> >>>>>> the tagset is _shared_ between all devices, so the sbitmap allocator
> >>>>>> will only ever run on _one_ tagset for all commands.
> >>>>>
> >>>>> But blk-mq doesn't support host-wide tags yet, so how can this single
> >>>>> patch work?
> >>>>>
> >>>> Wrong. It does:
> >>>>
> >>>> struct request_queue *scsi_mq_alloc_queue(struct scsi_device *sdev)
> >>>> {
> >>>> 	sdev->request_queue = blk_mq_init_queue(&sdev->host->tag_set);
> >>>> 	if (IS_ERR(sdev->request_queue))
> >>>> 		return NULL;
> >>>>
> >>>> 	sdev->request_queue->queuedata = sdev;
> >>>> 	__scsi_init_queue(sdev->host, sdev->request_queue);
> >>>> 	blk_queue_flag_set(QUEUE_FLAG_SCSI_PASSTHROUGH, sdev->request_queue);
> >>>> 	return sdev->request_queue;
> >>>> }
> >>>>
> >>>>
> >>>> IE every scsi device is using the tagset from the host.
> >>>
> >>> Looks we are not in the same page, and you misunderstood two concepts:
> >>> scsi's host-wide tagset, and the new host-tags of BLK_MQ_F_HOST_TAGS.
> >>>
> >>> I admit that the new flag of BLK_MQ_F_HOST_TAGS is misleading.
> >>>
> >>> Now let me clarify it a bit:
> >>>
> >>> 1) the current SCSI hostwide tags means all LUNs share the host tagset,
> >>> but the tagset may include multiple hw queues, and each hw queue still
> >>> has independent tags, that is why blk-mq provides blk_mq_unique_tag().
> >>> In short, each LUN's hw queue has independent tags.
> >>>
> >> Which is where I fundamentally disagree.
> >> Each hw queue does _not_ have independent tags.
> >> Each hw queue will use tags from the same (host-wide) tagset; the tags
> >> themselves will be allocated for each queue on an ad-hoc base, ie there
> >> is no fixed mapping between tag values and hardware queues.
> > 
> > Tagset is set of tags, and one tags is for serving one hw queue.
> > 
> > Each hw queue has its own tags, please see __blk_mq_alloc_rq_map()
> > in which standalone sbitmap allocator and rq pool is allocated to
> > each hw queue represented by 'hctx_idx'.
> > 
> Yes, but ...

So you agree the theory.

> 
> > And for each hw queue, the allocated tag value for request is in
> > the range of 0 ~ queue_depth - 1, that is why I say requests from
> > different hw queue may have same tag.
> > 
> 
> But this is not what I have been observing working with lpfc and qla2xxx.
> Both drivers have been converted to using scsi-mq with nr_hw_queues > 1
> some years ago, and do work just fine.
> And none of those drivers allow for re-using an in-flight tag on
> different hardware queues.

Really?

Just run quick grep on the two drivers, looks both don't use cmnd->tag or
rq->tag.

> If your reasoning is correct none of these drivers would work.
> 
> > Your RFC patch changes to allow requests with same tag submitted to driver
> > & hardware at the same time, so we should double-check if hisi_v3 hardware
> > is happy with this change.
> > 
> > John, is hisi_sas v3 fine with this way?
> > 
> As mentioned above, I don't think this can happen.

Then prove where I am wrong.

Just attach a little bcc script, which should have been done by
bpftrace easily, just not found how to pass multiple variable as key.

1) run the attached bcc script in another terminal

2) load null_blk via:

rmmod null_blk;modprobe null_blk queue_mode=2 irqmode=2 completion_nsec=1000000 submit_queues=2 hw_queue_depth=4

3) run the following fio:
fio --bs=4k --size=128G  --rw=randread --direct=1 --ioengine=libaio --iodepth=16 --runtime=10 --name=fiotest --filename=/dev/nullb0 --numjobs=8

Then ctrl+C on the bcc script, and you will see how many requests with
same tag from different queues are handled concurrently.

BTW, this test is run on dual core VM/Fedora 30, and bcc package is
required.

Thanks,
Ming

--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="io_tag.py"

#!/usr/bin/python3

from __future__ import print_function
from bcc import BPF
from time import sleep

bpf_text="""
#include <uapi/linux/ptrace.h>
#include <linux/blkdev.h>
#include <linux/blk-mq.h>

struct key_t {
    /*
      'q' should have been tagset, so we can observe IOs from multi devices,
      however, it is enought to show same tag requests are inflight from
      different hw queue.
    */
    void *q; 
    u64 tag;
};

BPF_HASH(inflight, struct key_t);

/*
 dist is the histogram indexed by rq->tag, the count records that
 how many same tag request is in-flight at the same time.
*/
BPF_HISTOGRAM(dist);

int kprobe__null_queue_rq(struct pt_regs *ctx, struct blk_mq_hw_ctx *hctx,
                         const struct blk_mq_queue_data *bd)
{
    struct request *rq = bd->rq;
    int tag = rq->tag;
    void *q = rq->q;
    struct key_t key = {
        .q = q,
        .tag = tag,
    };
    u64 zero = 0;

    if (inflight.lookup(&key)) 
	dist.increment(tag);
    else
        inflight.update(&key, &zero);

    return 0;
}

int kprobe__null_complete_rq(struct pt_regs *ctx, struct request *rq)
{
    int tag = rq->tag;
    void *q = rq->q;
    struct key_t key = {
        .q = q,
        .tag = tag,
    };

    inflight.delete(&key);
    return 0;
}
"""

# load BPF program
b = BPF(text=bpf_text)

# header
print("Tracing... Hit Ctrl-C to end.")

# trace until Ctrl-C
try:
	sleep(99999999)
except KeyboardInterrupt:
	print()

# output
b["dist"].print_linear_hist("inflight rqs with same tags")

--mP3DRpeJDSE+ciuQ--
