Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9E7372F8F
	for <lists+linux-scsi@lfdr.de>; Tue,  4 May 2021 20:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbhEDSKt (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 4 May 2021 14:10:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:53332 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232350AbhEDSKs (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 4 May 2021 14:10:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 65462AEEF;
        Tue,  4 May 2021 18:09:52 +0000 (UTC)
Subject: Re: [PATCH 10/18] scsi: implement reserved command handling
To:     Bart Van Assche <bvanassche@acm.org>,
        John Garry <john.garry@huawei.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org
References: <20210503150333.130310-1-hare@suse.de>
 <20210503150333.130310-11-hare@suse.de>
 <3e41e5ea-6313-9718-c07d-20f8b203efd2@acm.org>
 <1db7fc49-17a9-1c8d-9d94-9a1b3694f392@suse.de>
 <7a9ceb36-32dc-4fcc-49a2-f4c2ca2286c3@huawei.com>
 <e2d2b5f7-6f8d-241e-5a38-44cbcd7fc772@suse.de>
 <4467caa8-b4f4-3de0-c5d6-09a685229e5a@acm.org>
From:   Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <98d2d0d5-84e5-3837-d5b2-8b9f89166664@suse.de>
Date:   Tue, 4 May 2021 20:09:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <4467caa8-b4f4-3de0-c5d6-09a685229e5a@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/4/21 6:59 PM, Bart Van Assche wrote:
> On 5/4/21 6:12 AM, Hannes Reinecke wrote:
>> On 5/4/21 12:55 PM, John Garry wrote:
>>> On 04/05/2021 07:17, Hannes Reinecke wrote:
>>>> On 5/4/21 5:20 AM, Bart Van Assche wrote:
>>>>> On 5/3/21 8:03 AM, Hannes Reinecke wrote:
>>>>>> These commands are set aside before allocating the block-mq tag
>>>>>> bitmap,
>>>>>> so they'll never show up as busy in the tag map.
>>>>>
>>>>> That doesn't sound correct to me. Should the above perhaps be changed
>>>>> into "blk_mq_start_request() is never called for internal commands so
>>>>> they'll never show up as busy in the tag map"?
>>>>>
>>>> Yes, will do.
>>>
>>> So why don't these - or shouldn't these - turn up in the busy tag map?
>>>
>>> One of the motivations to use these block requests for internal
>>> commands is that we can take advantage of the block layer handling for
>>> CPU hotplug for MQ hosts, i.e. if blk-mq can't see these are inflight,
>>> then they would be missed in blk_mq_hctx_notify_offline() ->
>>> blk_mq_hctx_has_requests(), right? And who knows what else...
>>>
>> Oh, but of course it's possible to call 'start' on these requests to
>> have them counted in the busy map.
>> I just didn't see the need for it until now, that's all.
> 
> This is possible but this will require careful review of at least the
> following code paths such that nothing unexpected happens for internal
> commands:
> * The SCSI timeout code.
> * All blk_mq_tagset_busy_iter() and scsi_host_busy_iter() callers. As an
> example, scsi_host_busy() must not include LLD-internal commands.
> 
Oh, _that_ is easy. These are reserved commands, which will have the
last bool argument to the iter functions set to 'true'.

 bool (*fn)(struct scsi_cmnd *, void *, bool)

So we just need to return from the iter if the last argument is true.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		        Kernel Storage Architect
hare@suse.de			               +49 911 74053 688
SUSE Software Solutions Germany GmbH, 90409 Nürnberg
GF: F. Imendörffer, HRB 36809 (AG Nürnberg)
