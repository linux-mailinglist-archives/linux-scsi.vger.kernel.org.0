Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38AA144446A
	for <lists+linux-scsi@lfdr.de>; Wed,  3 Nov 2021 16:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbhKCPOr (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 3 Nov 2021 11:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbhKCPOr (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 3 Nov 2021 11:14:47 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85884C061205
        for <linux-scsi@vger.kernel.org>; Wed,  3 Nov 2021 08:12:10 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id d12so717167oij.5
        for <linux-scsi@vger.kernel.org>; Wed, 03 Nov 2021 08:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pDUKSouqG6RynvIJ9HV2AeD5NrQTmoBC9P2idDBq9xU=;
        b=nRENZKa7cSa6jMZOT5FuIuti6mb1eTifXOrW6R1WTHSWapCu4ePAcf7LTAGRArOu8E
         9zk35oRbj6MLIxKf/Uz/9blYZFEuUtOFLYc2gXy9b0P9nm9LEzOYJr/6RAEVGOBwkies
         /x9o25DpojyND5UOYfjQ439wCUIi/ImHXo1/FlnhR9OjIOrwjkiXQoedqWjVN0MzxLvL
         FS0IzShPLHA4Y0jUasV2wGQ/sFYF0UX8jz6Ejg+ImPVpiAWB0mRDd8F4pEd/Cn7AshVj
         7VNVFM5io0kXqNVA6YnQ5jOsDcryP6WKPkXWPxehYIhP1LzzyuMGmBERzCTgH6Bgi3dp
         mrWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pDUKSouqG6RynvIJ9HV2AeD5NrQTmoBC9P2idDBq9xU=;
        b=lZ+PUSK8d13QlRtUiRf5T19t49VvFXTg3ZJvwugL7EtryZiyKZTZ3McBFxa8gWk8jj
         hU150erqpZ05sklsQtZkKO5ZCBVZqZDAhd0OtfCqy8X8smwfjjKvS78zNtOgrxwjVNig
         duq6ppaWVC7TrRAaVV3oqCtGZcdv3czrkb1VgaHMGa7ip6mZben8JfK3LihaPQguM9lq
         t/CwGq8QIEtrSuwNhNt28Uy+2fktNfbDODzJK1BBxLGFf7J9NN0WBD6qeDd/7kjG1kyO
         YZr21l3nI3GDRd7kD4Kfxr45Xs04gI6XUvmOXGFdTYNNVTR5KWCIJTi7GIzn82hu26pR
         FSAg==
X-Gm-Message-State: AOAM532NMb8nUd1zHNHSQ9DTGyAa/lWXHzRDYivfuVWG3dM6IcxpoOpY
        YL/pfojWmsSylu7jTHGPmEqXGNyUkDeM4w==
X-Google-Smtp-Source: ABdhPJx9P9g86YlhOVmCqekE3CfNx8r+apQSDsly5akRQfZa0eFCNC+3mByZY7XSbmP82yteVnmvsQ==
X-Received: by 2002:a05:6808:231e:: with SMTP id bn30mr10645778oib.93.1635952329578;
        Wed, 03 Nov 2021 08:12:09 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id m13sm610232ooj.43.2021.11.03.08.12.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Nov 2021 08:12:09 -0700 (PDT)
Subject: Re: [bug report] WARNING: CPU: 1 PID: 1386 at
 block/blk-mq-sched.c:432 blk_mq_sched_insert_request+0x54/0x178
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Yi Zhang <yi.zhang@redhat.com>,
        Steffen Maier <maier@linux.ibm.com>,
        linux-block <linux-block@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>
References: <YYIHXGSb2O5va0vA@T590>
 <85F2E9AC-385F-4BCA-BD3C-7A093442F87F@kernel.dk>
 <733e1dcd-36a1-903e-709a-5ebe5f491564@kernel.dk>
 <CAHj4cs8U-Tboc-i-ZpK2-7euPZNsHja_6SWs6Ap0ywddStLC_A@mail.gmail.com>
 <YYKjPIoMR04HrcWp@T590> <2a3b12f7-ea1b-c843-8370-8086ae2993ec@kernel.dk>
 <YYKmIgHttlxudYCA@T590>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4542eb75-aa3a-23dc-699f-c6aec613c613@kernel.dk>
Date:   Wed, 3 Nov 2021 09:12:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YYKmIgHttlxudYCA@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 11/3/21 9:09 AM, Ming Lei wrote:
> On Wed, Nov 03, 2021 at 09:03:02AM -0600, Jens Axboe wrote:
>> On 11/3/21 8:57 AM, Ming Lei wrote:
>>> On Wed, Nov 03, 2021 at 09:59:02PM +0800, Yi Zhang wrote:
>>>> On Wed, Nov 3, 2021 at 7:59 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>>>
>>>>> On 11/2/21 9:54 PM, Jens Axboe wrote:
>>>>>> On Nov 2, 2021, at 9:52 PM, Ming Lei <ming.lei@redhat.com> wrote:
>>>>>>>
>>>>>>> ﻿On Tue, Nov 02, 2021 at 09:21:10PM -0600, Jens Axboe wrote:
>>>>>>>>> On 11/2/21 8:21 PM, Yi Zhang wrote:
>>>>>>>>>>>
>>>>>>>>>>> Can either one of you try with this patch? Won't fix anything, but it'll
>>>>>>>>>>> hopefully shine a bit of light on the issue.
>>>>>>>>>>>
>>>>>>>>> Hi Jens
>>>>>>>>>
>>>>>>>>> Here is the full log:
>>>>>>>>
>>>>>>>> Thanks! I think I see what it could be - can you try this one as well,
>>>>>>>> would like to confirm that the condition I think is triggering is what
>>>>>>>> is triggering.
>>>>>>>>
>>>>>>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>>>>>>> index 07eb1412760b..81dede885231 100644
>>>>>>>> --- a/block/blk-mq.c
>>>>>>>> +++ b/block/blk-mq.c
>>>>>>>> @@ -2515,6 +2515,8 @@ void blk_mq_submit_bio(struct bio *bio)
>>>>>>>>    if (plug && plug->cached_rq) {
>>>>>>>>        rq = rq_list_pop(&plug->cached_rq);
>>>>>>>>        INIT_LIST_HEAD(&rq->queuelist);
>>>>>>>> +        WARN_ON_ONCE(q->elevator && !(rq->rq_flags & RQF_ELV));
>>>>>>>> +        WARN_ON_ONCE(!q->elevator && (rq->rq_flags & RQF_ELV));
>>>>>>>>    } else {
>>>>>>>>        struct blk_mq_alloc_data data = {
>>>>>>>>            .q        = q,
>>>>>>>> @@ -2535,6 +2537,8 @@ void blk_mq_submit_bio(struct bio *bio)
>>>>>>>>                bio_wouldblock_error(bio);
>>>>>>>>            goto queue_exit;
>>>>>>>>        }
>>>>>>>> +        WARN_ON_ONCE(q->elevator && !(rq->rq_flags & RQF_ELV));
>>>>>>>> +        WARN_ON_ONCE(!q->elevator && (rq->rq_flags & RQF_ELV));
>>>>>>>
>>>>>>> Hello Jens,
>>>>>>>
>>>>>>> I guess the issue could be the following code run without grabbing
>>>>>>> ->q_usage_counter from blk_mq_alloc_request() and blk_mq_alloc_request_hctx().
>>>>>>>
>>>>>>> .rq_flags       = q->elevator ? RQF_ELV : 0,
>>>>>>>
>>>>>>> then elevator is switched to real one from none, and check on q->elevator
>>>>>>> becomes not consistent.
>>>>>>
>>>>>> Indeed, that’s where I was going with this. I have a patch, testing it
>>>>>> locally but it’s getting late. Will send it out tomorrow. The nice
>>>>>> benefit is that it allows dropping the weird ref get on plug flush,
>>>>>> and batches getting the refs as well.
>>>>>
>>>>> Yi/Steffen, can you try pulling this into your test kernel:
>>>>>
>>>>> git://git.kernel.dk/linux-block for-next
>>>>>
>>>>> and see if it fixes the issue for you. Thanks!
>>>>
>>>> It still can be reproduced with the latest linux-block/for-next, here is the log
>>>>
>>>> fab2914e46eb (HEAD, new/for-next) Merge branch 'for-5.16/drivers' into for-next
>>>
>>> Hi Yi,
>>>
>>> Please try the following change:
>>>
>>>
>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>> index e1e64964a31b..eb634a9c61ff 100644
>>> --- a/block/blk-mq.c
>>> +++ b/block/blk-mq.c
>>> @@ -494,7 +494,6 @@ struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
>>>  		.q		= q,
>>>  		.flags		= flags,
>>>  		.cmd_flags	= op,
>>> -		.rq_flags	= q->elevator ? RQF_ELV : 0,
>>>  		.nr_tags	= 1,
>>>  	};
>>>  	struct request *rq;
>>> @@ -504,6 +503,7 @@ struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
>>>  	if (ret)
>>>  		return ERR_PTR(ret);
>>>  
>>> +	data.rq_flags	= q->elevator ? RQF_ELV : 0,
>>>  	rq = __blk_mq_alloc_requests(&data);
>>>  	if (!rq)
>>>  		goto out_queue_exit;
>>> @@ -524,7 +524,6 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
>>>  		.q		= q,
>>>  		.flags		= flags,
>>>  		.cmd_flags	= op,
>>> -		.rq_flags	= q->elevator ? RQF_ELV : 0,
>>>  		.nr_tags	= 1,
>>>  	};
>>>  	u64 alloc_time_ns = 0;
>>> @@ -551,6 +550,7 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
>>>  	ret = blk_queue_enter(q, flags);
>>>  	if (ret)
>>>  		return ERR_PTR(ret);
>>> +	data.rq_flags	= q->elevator ? RQF_ELV : 0,
>>
>> Don't think that will compile, but I guess the point is that we can't do
> 
> It can compile.

s/,/;

for the new assignments.

>> this assignment before queue enter, in case we're in the midst of
>> switching schedulers. Which is indeed a valid concern.
> 
> Yeah, for scsi, real io sched is switched when adding disk, before
> that, the passthrough command need to see consistent q->elevator.

Yeah, I agree that the problem is most certainly there. Guess I'm just
surprised the timing works out reliably, but it sure looks like it.

-- 
Jens Axboe

