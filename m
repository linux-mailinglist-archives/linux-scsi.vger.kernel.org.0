Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE53332B13
	for <lists+linux-scsi@lfdr.de>; Mon,  3 Jun 2019 10:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbfFCIr2 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 3 Jun 2019 04:47:28 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:33189 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfFCIr1 (ORCPT
        <rfc822;groupwise-linux-scsi@vger.kernel.org:0:0>);
        Mon, 3 Jun 2019 04:47:27 -0400
Received: from [10.160.4.48] (charybdis.suse.de [149.44.162.66])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Mon, 03 Jun 2019 10:47:25 +0200
Subject: Re: [PATCH RFC] hisi_sas_v3: multiqueue support
To:     Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Ming Lei <tom.leiming@gmail.com>,
        John Garry <john.garry@huawei.com>, linux-scsi@vger.kernel.org
References: <20190531074158.76923-1-hare@suse.de>
 <20190531082116.GA12106@ming.t460p>
 <e81ca95e-95af-1078-c523-701120dd4ca7@suse.de>
 <20190531084600.GB12106@ming.t460p>
 <f7e184d4-3d90-2c36-84b8-702105dccafb@suse.de>
 <20190531230620.GB16190@ming.t460p>
 <fc049d0a-a7e3-894a-0680-574d86603ea5@suse.de>
 <20190603073733.GA11812@ming.t460p>
 <f0901773-0faf-7a4e-bb17-3e584de00c4f@suse.de>
 <20190603081621.GC11812@ming.t460p>
From:   Hannes Reinecke <hare@suse.com>
Message-ID: <cd22b399-789d-c0fd-5748-5feeea90c0ee@suse.com>
Date:   Mon, 3 Jun 2019 10:47:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190603081621.GC11812@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 6/3/19 10:16 AM, Ming Lei wrote:
> On Mon, Jun 03, 2019 at 09:46:39AM +0200, Hannes Reinecke wrote:
>> On 6/3/19 9:37 AM, Ming Lei wrote:
>>> On Mon, Jun 03, 2019 at 08:08:18AM +0200, Hannes Reinecke wrote:
>>>> On 6/1/19 1:06 AM, Ming Lei wrote:
>>>>> On Fri, May 31, 2019 at 12:26:56PM +0200, Hannes Reinecke wrote:
>>>>>> On 5/31/19 10:46 AM, Ming Lei wrote:
>>>> [ .. ]
>>>>>> First we check for the 'slot_index_alloc()' callback to handle weird v2
>>>>>> allocation rules, _then_ we look for a tag, and only if we do _not_ have
>>>>>> a tag we're using the bitmap.
>>>>>
>>>>> OK, looks I miss the above change.
>>>>>
>>>>>> And the bitmap is already correctly sized, as otherwise we'd have a
>>>>>> clash between internal and tagged I/O commands even now.
>>>>>
>>>>> But now the big problem is in the following two line code:
>>>>>
>>>>> +       else if (blk_tag != (u32)-1)
>>>>> +               rc = blk_mq_unique_tag_to_tag(blk_tag);
>>>>>
>>>>> Request from different blk-mq hw queue has same tag returned from
>>>>> blk_mq_unique_tag_to_tag().
>>>>>
>>>> Yes, but the sbitmap allocator will ensure that each command will get a
>>>> unique tag.
>>>
>>> Each hw queue has independent sbitmap allocator, so commands with same
>>> tag can come from different hw queue.
>>>
>> It does not for SCSI.
>> See below.
>>
>>> So you meant this RFC patch depends on the host-wide tags patchset I
>>> posted?
>>>
>>>>
>>>>> Now the biggest question is that if V3 hw supports per-queue tags,
>>>>> If yes, it should be real MQ hardware, otherwise I guess commands with
>>>>> same tag at the same time may not work for host-wide tags.
>>>>>
>>>>
>>>> Of course you can't have different commands with the same tag. But the
>>>> sbitmap allocator prevents this from happening, as for host-wide tags
>>>> the tagset is _shared_ between all devices, so the sbitmap allocator
>>>> will only ever run on _one_ tagset for all commands.
>>>
>>> But blk-mq doesn't support host-wide tags yet, so how can this single
>>> patch work?
>>>
>> Wrong. It does:
>>
>> struct request_queue *scsi_mq_alloc_queue(struct scsi_device *sdev)
>> {
>> 	sdev->request_queue = blk_mq_init_queue(&sdev->host->tag_set);
>> 	if (IS_ERR(sdev->request_queue))
>> 		return NULL;
>>
>> 	sdev->request_queue->queuedata = sdev;
>> 	__scsi_init_queue(sdev->host, sdev->request_queue);
>> 	blk_queue_flag_set(QUEUE_FLAG_SCSI_PASSTHROUGH, sdev->request_queue);
>> 	return sdev->request_queue;
>> }
>>
>>
>> IE every scsi device is using the tagset from the host.
> 
> Looks we are not in the same page, and you misunderstood two concepts:
> scsi's host-wide tagset, and the new host-tags of BLK_MQ_F_HOST_TAGS.
> 
> I admit that the new flag of BLK_MQ_F_HOST_TAGS is misleading.
> 
> Now let me clarify it a bit:
> 
> 1) the current SCSI hostwide tags means all LUNs share the host tagset,
> but the tagset may include multiple hw queues, and each hw queue still
> has independent tags, that is why blk-mq provides blk_mq_unique_tag().
> In short, each LUN's hw queue has independent tags.
> 
Which is where I fundamentally disagree.
Each hw queue does _not_ have independent tags.
Each hw queue will use tags from the same (host-wide) tagset; the tags
themselves will be allocated for each queue on an ad-hoc base, ie there
is no fixed mapping between tag values and hardware queues.
Which is why there is blk_mq_unique_tag(); this precisely returns a tag
which is unique across all devices from this host by shifting the queue
number on top of the actual tag number:

u32 blk_mq_unique_tag(struct request *rq)
{
	return (rq->mq_hctx->queue_num << BLK_MQ_UNIQUE_TAG_BITS) |
		(rq->tag & BLK_MQ_UNIQUE_TAG_MASK);
}

So the tagset itself is not split across devices, and all devices can
(potentially) use all tags from the tagset.

> 
> 2) some drivers(hisi_v3 hw, hpsa, megraid_sas, mpt3sas) only support
> single hw queue, but has multiple reply queue which can avoid CPU
> lockup, so we are working towards converting the private reply queue
> into blk-mq hw queue. That is what BLK_MQ_F_HOST_TAGS covers.
> 
I am aware.

> Now you think 1) is enough for converting the private reply queue into
> blk-mq hw queue, that is definitely not correct since blk-mq MQ doesn't
> support shared tags among hw queues.
> 
Currently blk-mq assumes a symmetric submission/completion model, ie it
is assumed that a multiqueue device will have the same number of
submissions and completion queues.

For the HBAs listed above the submission works by writing an address
into a single dedicated PCI register, whereas there are completion
queues per interrupt. So we really have a 1:n mapping between submission
and completion queues.

Which is what your patchset is trying to address, and I'm perfectly fine
with this.

All I'm arguing is that hisi_sas v3 really maps onto the original model,
seeing that is has per-queue submission paths, and as such maps more
closely on the original model for blk-mq.
Hence I do think that hisi_sas v3 should benefit more from moving to
that 'full' blk-mq model, and not the simplified 1:n model you are
proposing.

We still should be going ahead with your patchset for the actual RAID
HBAs like megaraid_sas etc.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		               zSeries & Storage
hare@suse.com			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
