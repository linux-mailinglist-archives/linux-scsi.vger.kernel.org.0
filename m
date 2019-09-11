Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69948B006F
	for <lists+linux-scsi@lfdr.de>; Wed, 11 Sep 2019 17:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbfIKPom (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 11 Sep 2019 11:44:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53446 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728266AbfIKPol (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 11 Sep 2019 11:44:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 61BBAA371AF;
        Wed, 11 Sep 2019 15:44:41 +0000 (UTC)
Received: from [10.10.125.194] (ovpn-125-194.rdu2.redhat.com [10.10.125.194])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 176E35D6A5;
        Wed, 11 Sep 2019 15:44:38 +0000 (UTC)
Subject: Re: [RFC PATCH] Add proc interface to set PF_MEMALLOC flags
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Hillf Danton <hdanton@sina.com>
References: <20190911031348.9648-1-hdanton@sina.com>
 <c48cd3d8-699d-a614-b12d-1ddef71691f3@I-love.SAKURA.ne.jp>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>, axboe@kernel.dk,
        James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org, Linux-MM <linux-mm@kvack.org>
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5D791666.7080302@redhat.com>
Date:   Wed, 11 Sep 2019 10:44:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <c48cd3d8-699d-a614-b12d-1ddef71691f3@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Wed, 11 Sep 2019 15:44:41 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 09/11/2019 05:07 AM, Tetsuo Handa wrote:
> On 2019/09/11 12:13, Hillf Danton wrote:
>>
>> On Tue, 10 Sep 2019 11:06:03 -0500 From: Mike Christie <mchristi@redhat.com>
>>>
>>>> Really? Without any privilege check? So any random user can tap into
>>>> __GFP_NOIO allocations?
>>>
>>> That was a mistake on my part. I will add it in.
>>>
>> You may alternatively madvise a nutcracker as long as you would have
>> added a sledgehammer under /proc instead of a gavel.
>>
>> --- a/include/uapi/asm-generic/mman-common.h
>> +++ b/include/uapi/asm-generic/mman-common.h
>> @@ -45,6 +45,7 @@
>>  #define MADV_SEQUENTIAL	2		/* expect sequential page references */
>>  #define MADV_WILLNEED	3		/* will need these pages */
>>  #define MADV_DONTNEED	4		/* don't need these pages */
>> +#define MADV_NOIO	5		/* set PF_MEMALLOC_NOIO */
>>  
>>  /* common parameters: try to keep these consistent across architectures */
>>  #define MADV_FREE	8		/* free pages only if memory pressure */
>> --- a/mm/madvise.c
>> +++ b/mm/madvise.c
>> @@ -716,6 +716,7 @@ madvise_behavior_valid(int behavior)
>>  	case MADV_WILLNEED:
>>  	case MADV_DONTNEED:
>>  	case MADV_FREE:
>> +	case MADV_NOIO:
>>  #ifdef CONFIG_KSM
>>  	case MADV_MERGEABLE:
>>  	case MADV_UNMERGEABLE:
>> @@ -813,6 +814,11 @@ SYSCALL_DEFINE3(madvise, unsigned long,
>>  	if (!madvise_behavior_valid(behavior))
>>  		return error;
>>  
>> +	if (behavior == MADV_NOIO) {
>> +		current->flags |= PF_MEMALLOC_NOIO;
> 
> Yes, for "modifying p->flags when p != current" is not permitted.
> 
> But I guess that there is a problem. Setting PF_MEMALLOC_NOIO causes
> current_gfp_context() to mask __GFP_IO | __GFP_FS, but the OOM killer cannot
> be invoked when __GFP_FS is masked. As a result, any userspace thread which
> has PF_MEMALLOC_NOIO cannot invoke the OOM killer. If the userspace thread
> which uses PF_MEMALLOC_NOIO is involved in memory reclaiming activities,
> the memory reclaiming activities won't be able to make forward progress when
> the userspace thread triggered e.g. a page fault. Can the "userspace components
> that can run in the IO path" survive without any memory allocation?
> 

Yes and no, when they can they will have preallocated the resources they
need to make forward progress similar to how kernel storage drivers do.
However for some resources, like in the network layer, both userspace
and kernel drivers are not able to preallocate and may fail.


>> +		return 0;
>> +	}
>> +
>>  	if (start & ~PAGE_MASK)
>>  		return error;
>>  	len = (len_in + ~PAGE_MASK) & PAGE_MASK;
> 

