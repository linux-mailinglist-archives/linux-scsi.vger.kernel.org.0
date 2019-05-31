Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36C0030F39
	for <lists+linux-scsi@lfdr.de>; Fri, 31 May 2019 15:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfEaNqz (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 31 May 2019 09:46:55 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17639 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726418AbfEaNqz (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 31 May 2019 09:46:55 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8DE115153299989A2F5E;
        Fri, 31 May 2019 21:46:53 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Fri, 31 May 2019
 21:46:45 +0800
Subject: Re: [PATCH RFC] hisi_sas_v3: multiqueue support
To:     Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>
References: <20190531074158.76923-1-hare@suse.de>
 <20190531082116.GA12106@ming.t460p>
 <e81ca95e-95af-1078-c523-701120dd4ca7@suse.de>
 <20190531084600.GB12106@ming.t460p>
 <57d87edb-e748-6223-bfb4-a67ead9a8bdd@huawei.com>
 <15480880-496f-9603-ece8-4da2a204ed51@suse.de>
CC:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        "Ming Lei" <tom.leiming@gmail.com>, <linux-scsi@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        chenxiang <chenxiang66@hisilicon.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <2994ee9f-85a0-c3dc-ab5c-cb8c6ee1ec92@huawei.com>
Date:   Fri, 31 May 2019 14:46:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <15480880-496f-9603-ece8-4da2a204ed51@suse.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 31/05/2019 14:18, Hannes Reinecke wrote:
> On 5/31/19 11:42 AM, John Garry wrote:
>>>>>>
>>>>>> -static int hisi_sas_slot_index_alloc(struct hisi_hba *hisi_hba,
>>>>>> -                     struct scsi_cmnd *scsi_cmnd)
>>>>>> +static int hisi_sas_slot_index_alloc(struct hisi_hba *hisi_hba)
>>>>>>  {
>>>>>>      int index;
>>>>>>      void *bitmap = hisi_hba->slot_index_tags;
>>>>>>      unsigned long flags;
>>>>>>
>>>>>> -    if (scsi_cmnd)
>>>>>> -        return scsi_cmnd->request->tag;
>>>>>> -
>>>>>>      spin_lock_irqsave(&hisi_hba->lock, flags);
>>>>>>      index = find_next_zero_bit(bitmap, hisi_hba->slot_index_count,
>>>>>>                     hisi_hba->last_slot_index + 1);
>>>>>
>>>>> Then you switch to hisi_sas_slot_index_alloc() for allocating the
>>>>> unique
>>>>> tag via spin_lock & find_next_zero_bit(). Do you think this way is more
>>>>> efficient than blk-mq's sbitmap?
>>
>> These are not fast path, as used only for TMF, internal IO, etc.
>>
>> Having said that, hopefully we can move to scsi_{get,put}_reserved_cmd()
>> when available, so that the LLDD has to stop managing them.
>>
>>>>>
>>>> slot_index_alloc() is only used for commands which do _not_ have a tag
>>>> (eg internal commands), or for v2 hardware which has weird allocation
>>>> rules.
>>>
>>> But this patch has switched to this allocation unconditionally for all
>>> commands:
>>>
>>
>> As Hannes said, v2 had a few bugs which meant that we had to make a
>> specific version of this function for that hw revision, cf.
>> slot_index_alloc_quirk_v2_hw(), and it cannot use request queue tag.
>>
>> But, indeed, we could consider sbitmap for v2 hw. I'm not sure if it
>> would help, considering the weird rules.
>>
> We should be able to get away by shifting all tags by 1 to the left,
> and adding '1' to SMP/SAS commands, and '2' to STP commands, no?
> Then index '0' would be free, and the allocation rules are satisfied.
>

The crazy (escalating from weird) rules to workaround the HW bug(s) mean 
that we need to chop up the command tag range into blocks of 32 even tag 
indexes per SATA device; this means that SATA device #0 can use 64, 66, 
68, 70...126. device #1 can use 128, 130, 132,..., device #2 can use 
192, 194,...

I don't know how you can take a rq tag and generate a command tag 
suitable for a SATA device.

Thanks!

John

> I'll see to whip up a patch.
>
> Cheers,
>
> Hannes
>


