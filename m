Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA72432CF4
	for <lists+linux-scsi@lfdr.de>; Mon,  3 Jun 2019 11:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbfFCJff (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 3 Jun 2019 05:35:35 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46784 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726555AbfFCJfe (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 3 Jun 2019 05:35:34 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9A055BA082E025D7F658;
        Mon,  3 Jun 2019 17:35:31 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Mon, 3 Jun 2019
 17:35:27 +0800
Subject: Re: [PATCH RFC] hisi_sas_v3: multiqueue support
To:     Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>
References: <20190531074158.76923-1-hare@suse.de>
 <20190531082116.GA12106@ming.t460p>
 <e81ca95e-95af-1078-c523-701120dd4ca7@suse.de>
 <20190531084600.GB12106@ming.t460p>
 <f7e184d4-3d90-2c36-84b8-702105dccafb@suse.de>
 <20190531230620.GB16190@ming.t460p>
 <fc049d0a-a7e3-894a-0680-574d86603ea5@suse.de>
 <20190603073733.GA11812@ming.t460p>
 <f0901773-0faf-7a4e-bb17-3e584de00c4f@suse.de>
CC:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        "Ming Lei" <tom.leiming@gmail.com>, <linux-scsi@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <4bad5fa4-4b7f-60af-ef75-5d13b422aaac@huawei.com>
Date:   Mon, 3 Jun 2019 10:35:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <f0901773-0faf-7a4e-bb17-3e584de00c4f@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 03/06/2019 08:46, Hannes Reinecke wrote:
> On 6/3/19 9:37 AM, Ming Lei wrote:
>> On Mon, Jun 03, 2019 at 08:08:18AM +0200, Hannes Reinecke wrote:
>>> On 6/1/19 1:06 AM, Ming Lei wrote:
>>>> On Fri, May 31, 2019 at 12:26:56PM +0200, Hannes Reinecke wrote:
>>>>> On 5/31/19 10:46 AM, Ming Lei wrote:
>>> [ .. ]
>>>>> First we check for the 'slot_index_alloc()' callback to handle weird v2
>>>>> allocation rules, _then_ we look for a tag, and only if we do _not_ have
>>>>> a tag we're using the bitmap.
>>>>
>>>> OK, looks I miss the above change.
>>>>
>>>>> And the bitmap is already correctly sized, as otherwise we'd have a
>>>>> clash between internal and tagged I/O commands even now.
>>>>
>>>> But now the big problem is in the following two line code:
>>>>
>>>> +       else if (blk_tag != (u32)-1)
>>>> +               rc = blk_mq_unique_tag_to_tag(blk_tag);
>>>>
>>>> Request from different blk-mq hw queue has same tag returned from
>>>> blk_mq_unique_tag_to_tag().
>>>>
>>> Yes, but the sbitmap allocator will ensure that each command will get a
>>> unique tag.
>>
>> Each hw queue has independent sbitmap allocator, so commands with same
>> tag can come from different hw queue.
>>
> It does not for SCSI.
> See below.
>
>> So you meant this RFC patch depends on the host-wide tags patchset I
>> posted?
>>
>>>
>>>> Now the biggest question is that if V3 hw supports per-queue tags,
>>>> If yes, it should be real MQ hardware, otherwise I guess commands with
>>>> same tag at the same time may not work for host-wide tags.
>>>>
>>>
>>> Of course you can't have different commands with the same tag. But the
>>> sbitmap allocator prevents this from happening, as for host-wide tags
>>> the tagset is _shared_ between all devices, so the sbitmap allocator
>>> will only ever run on _one_ tagset for all commands.
>>
>> But blk-mq doesn't support host-wide tags yet, so how can this single
>> patch work?
>>
> Wrong. It does:
>
> struct request_queue *scsi_mq_alloc_queue(struct scsi_device *sdev)
> {
> 	sdev->request_queue = blk_mq_init_queue(&sdev->host->tag_set);
> 	if (IS_ERR(sdev->request_queue))
> 		return NULL;
>
> 	sdev->request_queue->queuedata = sdev;
> 	__scsi_init_queue(sdev->host, sdev->request_queue);
> 	blk_queue_flag_set(QUEUE_FLAG_SCSI_PASSTHROUGH, sdev->request_queue);
> 	return sdev->request_queue;
> }
>
>
> IE every scsi device is using the tagset from the host.
>

Hi Hannes,

Do you think that we have a problem for the bsg devices we create in 
SCSI transport SAS, in that they don't seem to use the same host tagset?

I'm looking at scsi_transport_sas.c::sas_bsg_initialise()->bsg_setup_queue()

Thanks,
John

> Cheers,
>
> Hannes
>


