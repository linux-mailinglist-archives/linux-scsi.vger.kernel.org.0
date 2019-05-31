Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D410130BDA
	for <lists+linux-scsi@lfdr.de>; Fri, 31 May 2019 11:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfEaJmb (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 31 May 2019 05:42:31 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33832 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726233AbfEaJmb (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 31 May 2019 05:42:31 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E0B119A64511E1726FD8;
        Fri, 31 May 2019 17:42:27 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Fri, 31 May 2019
 17:42:18 +0800
Subject: Re: [PATCH RFC] hisi_sas_v3: multiqueue support
To:     Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>
References: <20190531074158.76923-1-hare@suse.de>
 <20190531082116.GA12106@ming.t460p>
 <e81ca95e-95af-1078-c523-701120dd4ca7@suse.de>
 <20190531084600.GB12106@ming.t460p>
CC:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        "Ming Lei" <tom.leiming@gmail.com>, <linux-scsi@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        chenxiang <chenxiang66@hisilicon.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <57d87edb-e748-6223-bfb4-a67ead9a8bdd@huawei.com>
Date:   Fri, 31 May 2019 10:42:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190531084600.GB12106@ming.t460p>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

>>>>
>>>> -static int hisi_sas_slot_index_alloc(struct hisi_hba *hisi_hba,
>>>> -				     struct scsi_cmnd *scsi_cmnd)
>>>> +static int hisi_sas_slot_index_alloc(struct hisi_hba *hisi_hba)
>>>>  {
>>>>  	int index;
>>>>  	void *bitmap = hisi_hba->slot_index_tags;
>>>>  	unsigned long flags;
>>>>
>>>> -	if (scsi_cmnd)
>>>> -		return scsi_cmnd->request->tag;
>>>> -
>>>>  	spin_lock_irqsave(&hisi_hba->lock, flags);
>>>>  	index = find_next_zero_bit(bitmap, hisi_hba->slot_index_count,
>>>>  				   hisi_hba->last_slot_index + 1);
>>>
>>> Then you switch to hisi_sas_slot_index_alloc() for allocating the unique
>>> tag via spin_lock & find_next_zero_bit(). Do you think this way is more
>>> efficient than blk-mq's sbitmap?

These are not fast path, as used only for TMF, internal IO, etc.

Having said that, hopefully we can move to scsi_{get,put}_reserved_cmd() 
when available, so that the LLDD has to stop managing them.

>>>
>> slot_index_alloc() is only used for commands which do _not_ have a tag
>> (eg internal commands), or for v2 hardware which has weird allocation rules.
>
> But this patch has switched to this allocation unconditionally for all commands:
>

As Hannes said, v2 had a few bugs which meant that we had to make a 
specific version of this function for that hw revision, cf. 
slot_index_alloc_quirk_v2_hw(), and it cannot use request queue tag.

But, indeed, we could consider sbitmap for v2 hw. I'm not sure if it 
would help, considering the weird rules.

>> -       if (scsi_cmnd)
>> -               return scsi_cmnd->request->tag;
>> -
>
> Otherwise duplicated slot can be used from different blk-mq hw queue.
>
>>
>>> The worsen thing is that V3's actual max queue depth is (4096 - 96), but
>>> this patch claims that the device can support (4096 - 96) * 32 command
>>> slots

To be clear about the hw, the hw supports max 4096 command tags and has 
16 hw queues. The hw queue depth is configurable by software, and we 
configure it at 4096 per queue - same as max command tags - this is to 
support possibility of all commands using the same queue simultaneously.

, finally hisi_sas_slot_index_alloc() is used to respect the actual
>>> max queue depth(4000).
>>>
>> Well, this patch is an RFC to demonstrate my idea. Of course the queue
>> depth should be identical before and after the conversion.
>
> That is why I call it is hard to partition the hostwide tags to MQ.
>
>>
>>> Big contention is caused on hisi_sas_slot_index_alloc(), meantime huge> memory is wasted for request pool.
>>>
>> See above. That allocation is only used if no blk tag is available.
>
> This patch switches the allocation for all commands.
>
>>
>> Or, at least, that was the idea :-)
>
> Agree, :-)
>
>
> thanks,
> Ming
>
> .
>


