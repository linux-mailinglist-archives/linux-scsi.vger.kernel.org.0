Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 888C332887
	for <lists+linux-scsi@lfdr.de>; Mon,  3 Jun 2019 08:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfFCG3J (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 3 Jun 2019 02:29:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:57446 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726383AbfFCG3J (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 3 Jun 2019 02:29:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1B680AEF8;
        Mon,  3 Jun 2019 06:29:07 +0000 (UTC)
Subject: Re: [PATCH RFC] hisi_sas_v3: multiqueue support
To:     John Garry <john.garry@huawei.com>, Ming Lei <ming.lei@redhat.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Ming Lei <tom.leiming@gmail.com>, linux-scsi@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>,
        chenxiang <chenxiang66@hisilicon.com>
References: <20190531074158.76923-1-hare@suse.de>
 <20190531082116.GA12106@ming.t460p>
 <e81ca95e-95af-1078-c523-701120dd4ca7@suse.de>
 <20190531084600.GB12106@ming.t460p>
 <57d87edb-e748-6223-bfb4-a67ead9a8bdd@huawei.com>
 <15480880-496f-9603-ece8-4da2a204ed51@suse.de>
 <2994ee9f-85a0-c3dc-ab5c-cb8c6ee1ec92@huawei.com>
From:   Hannes Reinecke <hare@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=hare@suse.de; prefer-encrypt=mutual; keydata=
 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
 azzYF4VRJsdl+d0MCaSy8mUh
Message-ID: <86347b6f-7b23-9f0f-4306-a7c22b50dd8c@suse.de>
Date:   Mon, 3 Jun 2019 08:29:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <2994ee9f-85a0-c3dc-ab5c-cb8c6ee1ec92@huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/31/19 3:46 PM, John Garry wrote:
> On 31/05/2019 14:18, Hannes Reinecke wrote:
>> On 5/31/19 11:42 AM, John Garry wrote:
>>>>>>>
>>>>>>> -static int hisi_sas_slot_index_alloc(struct hisi_hba *hisi_hba,
>>>>>>> -                     struct scsi_cmnd *scsi_cmnd)
>>>>>>> +static int hisi_sas_slot_index_alloc(struct hisi_hba *hisi_hba)
>>>>>>>  {
>>>>>>>      int index;
>>>>>>>      void *bitmap = hisi_hba->slot_index_tags;
>>>>>>>      unsigned long flags;
>>>>>>>
>>>>>>> -    if (scsi_cmnd)
>>>>>>> -        return scsi_cmnd->request->tag;
>>>>>>> -
>>>>>>>      spin_lock_irqsave(&hisi_hba->lock, flags);
>>>>>>>      index = find_next_zero_bit(bitmap, hisi_hba->slot_index_count,
>>>>>>>                     hisi_hba->last_slot_index + 1);
>>>>>>
>>>>>> Then you switch to hisi_sas_slot_index_alloc() for allocating the
>>>>>> unique
>>>>>> tag via spin_lock & find_next_zero_bit(). Do you think this way is
>>>>>> more
>>>>>> efficient than blk-mq's sbitmap?
>>>
>>> These are not fast path, as used only for TMF, internal IO, etc.
>>>
>>> Having said that, hopefully we can move to scsi_{get,put}_reserved_cmd()
>>> when available, so that the LLDD has to stop managing them.
>>>
>>>>>>
>>>>> slot_index_alloc() is only used for commands which do _not_ have a tag
>>>>> (eg internal commands), or for v2 hardware which has weird allocation
>>>>> rules.
>>>>
>>>> But this patch has switched to this allocation unconditionally for all
>>>> commands:
>>>>
>>>
>>> As Hannes said, v2 had a few bugs which meant that we had to make a
>>> specific version of this function for that hw revision, cf.
>>> slot_index_alloc_quirk_v2_hw(), and it cannot use request queue tag.
>>>
>>> But, indeed, we could consider sbitmap for v2 hw. I'm not sure if it
>>> would help, considering the weird rules.
>>>
>> We should be able to get away by shifting all tags by 1 to the left,
>> and adding '1' to SMP/SAS commands, and '2' to STP commands, no?
>> Then index '0' would be free, and the allocation rules are satisfied.
>>
> 
> The crazy (escalating from weird) rules to workaround the HW bug(s) mean
> that we need to chop up the command tag range into blocks of 32 even tag
> indexes per SATA device; this means that SATA device #0 can use 64, 66,
> 68, 70...126. device #1 can use 128, 130, 132,..., device #2 can use
> 192, 194,...
> 
> I don't know how you can take a rq tag and generate a command tag
> suitable for a SATA device.
> Actually, you can.
We can setup a _distinct_ tagset per SATA device.
Eg we can setup a shared tagset for SAS (which is half the size of the
original tagset), and shift the tags by one to get a valid SAS tag.
For SATA we can setup a _distinct_ tagset per device, containing 32
tags. The we can invoke some calculation to transform the tag (which is
not guaranteed to be in the range of 0-31) into a valid hardware tag.

Should actually work.

Problem is that we'd need to set aside some tags for TMF, but I really
don't think that we can or should do command aborts on SATA; while there
is the 'abort NCQ' command, it'll work only for NCQ commands, and won't
help us for 'normal' commands.
And seeing that on error all NCQ commands will be aborted anyway, plus
the standard ATA error handler will be resulting into a device reset, I
guess we should skip command abort on SATA and escalate to device reset
straightaway. That would also have the nice benefit that we need only to
set _one_ tag aside for TMF, as we will only send one TMF at a time.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
