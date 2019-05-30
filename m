Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C76730096
	for <lists+linux-scsi@lfdr.de>; Thu, 30 May 2019 19:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfE3RLy (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 30 May 2019 13:11:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:37914 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726280AbfE3RLy (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 30 May 2019 13:11:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D4A7EB014;
        Thu, 30 May 2019 17:11:52 +0000 (UTC)
Subject: Re: [PATCH 02/24] scsi: add scsi_{get,put}_reserved_cmd()
To:     Ming Lei <tom.leiming@gmail.com>, Hannes Reinecke <hare@suse.de>
Cc:     Ming Lei <ming.lei@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Linux SCSI List <linux-scsi@vger.kernel.org>
References: <20190529132901.27645-1-hare@suse.de>
 <20190529132901.27645-3-hare@suse.de> <20190530064101.GA22773@ming.t460p>
 <0e8c345e-1fa4-5420-2dc1-26f449b027ca@suse.de>
 <CACVXFVM9igoO+NMY=JHLDWxE3aX=yiCcAjMs=YwtciANLdh-ow@mail.gmail.com>
From:   Hannes Reinecke <hare@suse.com>
Message-ID: <d0a45cba-ea79-208c-f228-6784917e64d5@suse.com>
Date:   Thu, 30 May 2019 19:11:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CACVXFVM9igoO+NMY=JHLDWxE3aX=yiCcAjMs=YwtciANLdh-ow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/30/19 5:48 PM, Ming Lei wrote:
> On Thu, May 30, 2019 at 10:57 PM Hannes Reinecke <hare@suse.de> wrote:
>>
>> On 5/30/19 8:41 AM, Ming Lei wrote:
>>> On Wed, May 29, 2019 at 03:28:39PM +0200, Hannes Reinecke wrote:
>>>> Add helper functions to retrieve SCSI commands from the reserved
>>>> tag pool.
>>>>
>>>> Signed-off-by: Hannes Reinecke <hare@suse.com>
>>>> ---
>>>>    include/scsi/scsi_tcq.h | 22 ++++++++++++++++++++++
>>>>    1 file changed, 22 insertions(+)
>>>>
>>>> diff --git a/include/scsi/scsi_tcq.h b/include/scsi/scsi_tcq.h
>>>> index 6053d46e794e..227f3bd4e974 100644
>>>> --- a/include/scsi/scsi_tcq.h
>>>> +++ b/include/scsi/scsi_tcq.h
>>>> @@ -39,5 +39,27 @@ static inline struct scsi_cmnd *scsi_host_find_tag(struct Scsi_Host *shost,
>>>>       return blk_mq_rq_to_pdu(req);
>>>>    }
>>>>
>>>> +static inline struct scsi_cmnd *scsi_get_reserved_cmd(struct scsi_device *sdev)
>>>> +{
>>>> +    struct request *rq;
>>>> +    struct scsi_cmnd *scmd;
>>>> +
>>>> +    rq = blk_mq_alloc_request(sdev->request_queue,
>>>> +                              REQ_OP_SCSI_OUT | REQ_NOWAIT,
>>>> +                              BLK_MQ_REQ_RESERVED);
>>>> +    if (IS_ERR(rq))
>>>> +            return NULL;
>>>> +    scmd = blk_mq_rq_to_pdu(rq);
>>>> +    scmd->request = rq;
>>>> +    return scmd;
>>>> +}
>>>
>>> Now all these internal commands won't share tags with IO requests,
>>> however, your patch switches to reserve slots for internal
>>> commands.
>>>
>> Yes.
>>
>>> This way may have performance effect on IO workloads given the
>>> reserved tags can't be used by IO at all.
>>>
>> Not really. Basically all drivers which have to use tags to send
>> internal commands already set some tags aside to handle internal
>> commands. So all this patchset does is to formalize this behaviour by
>> using private tags.
>> Some drivers (like fnic or snic) does _not_ do this currently; for those
>> I've set one command aside to handle command abort etc.
> 
>  From hardware view, you might be right, however, the implementation
> isn't correct:
> 
> set->queue_depth means number of the total tags, set->reserved_tags is just
> part of the total tags, see blk_mq_init_bitmap_tags().
> 
> So any driver sets .reserved_tags > 0, tags available for IO is reduced by
> same amount, isn't it?  Cause .can_queue isn't increased.
> 
Hmm. I was under the impression that the number of total tags is 
set->queue_depth + set-?reserved_tags.
But reading through blk-mq-tag.c it seems you are right.
Okay, will be updating the patchset.

Cheers,

Hannes
