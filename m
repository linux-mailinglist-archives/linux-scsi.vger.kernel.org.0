Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9FD2B59F0
	for <lists+linux-scsi@lfdr.de>; Tue, 17 Nov 2020 07:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbgKQG5o (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 17 Nov 2020 01:57:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:33426 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbgKQG5n (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 17 Nov 2020 01:57:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 61E62AC1F;
        Tue, 17 Nov 2020 06:57:41 +0000 (UTC)
Subject: Re: [PATCH V4 05/12] sbitmap: export sbitmap_weight
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumanesh Samanta <sumanesh.samanta@broadcom.com>,
        "Ewan D . Milne" <emilne@redhat.com>
References: <20201116090737.50989-1-ming.lei@redhat.com>
 <20201116090737.50989-6-ming.lei@redhat.com>
 <d05cb6bf-35e6-d939-30a5-6ef3a9c8a679@suse.de> <20201117021030.GC56247@T590>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <1183d3b9-bd52-2428-d696-ef02d0134299@suse.de>
Date:   Tue, 17 Nov 2020 07:57:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201117021030.GC56247@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 11/17/20 3:10 AM, Ming Lei wrote:
> On Mon, Nov 16, 2020 at 10:38:58AM +0100, Hannes Reinecke wrote:
>> On 11/16/20 10:07 AM, Ming Lei wrote:
>>> SCSI's .device_busy will be converted to sbitmap, and sbitmap_weight
>>> is needed, so export the helper.
>>>
>>> Cc: Omar Sandoval <osandov@fb.com>
>>> Cc: Kashyap Desai <kashyap.desai@broadcom.com>
>>> Cc: Sumanesh Samanta <sumanesh.samanta@broadcom.com>
>>> Cc: Ewan D. Milne <emilne@redhat.com>
>>> Reviewed-by: Hannes Reinecke <hare@suse.de>
>>> Tested-by: Sumanesh Samanta <sumanesh.samanta@broadcom.com>
>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>> ---
>>>    include/linux/sbitmap.h |  9 +++++++++
>>>    lib/sbitmap.c           | 11 ++++++-----
>>>    2 files changed, 15 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
>>> index 103b41c03311..34343ce3ef6c 100644
>>> --- a/include/linux/sbitmap.h
>>> +++ b/include/linux/sbitmap.h
>>> @@ -346,6 +346,15 @@ static inline int sbitmap_test_bit(struct sbitmap *sb, unsigned int bitnr)
>>>     */
>>>    void sbitmap_show(struct sbitmap *sb, struct seq_file *m);
>>> +
>>> +/**
>>> + * sbitmap_weight() - Return how many real bits set in a &struct sbitmap.
>>> + * @sb: Bitmap to check.
>>> + *
>>> + * Return: How many real bits set
>>> + */
>>> +unsigned int sbitmap_weight(const struct sbitmap *sb);
>>> +
>>>    /**
>>>     * sbitmap_bitmap_show() - Write a hex dump of a &struct sbitmap to a &struct
>>>     * seq_file.
>>> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
>>> index dcd6a89b4d2f..fb1d3c2f70a2 100644
>>> --- a/lib/sbitmap.c
>>> +++ b/lib/sbitmap.c
>>> @@ -342,20 +342,21 @@ static unsigned int __sbitmap_weight(const struct sbitmap *sb, bool set)
>>>    	return weight;
>>>    }
>>> -static unsigned int sbitmap_weight(const struct sbitmap *sb)
>>> +static unsigned int sbitmap_cleared(const struct sbitmap *sb)
>>>    {
>>> -	return __sbitmap_weight(sb, true);
>>> +	return __sbitmap_weight(sb, false);
>>>    }
>>> -static unsigned int sbitmap_cleared(const struct sbitmap *sb)
>>> +unsigned int sbitmap_weight(const struct sbitmap *sb)
>>>    {
>>> -	return __sbitmap_weight(sb, false);
>>> +	return __sbitmap_weight(sb, true) - sbitmap_cleared(sb);
>>>    }
>>> +EXPORT_SYMBOL_GPL(sbitmap_weight);
>> That is extremely confusing. Why do you change the meaning of
>> 'sbitmap_weight' from __sbitmap_weight(sb, true) to
>> __sbitmap_weight(sb, true) - __sbitmap_weight(sb, false)?
> 
> Because the only user of sbitmap_weight() just uses the following way:
> 
> 	sbitmap_weight(sb) - sbitmap_cleared(sb)
> 
> Frankly, I think sbitmap_weight(sb) should return real busy bits.
> 
No argument about that. Just wanted to be clear that this is by intention.

>> Does this mean that the original definition was wrong?
>> Or does this mean that this patch implies a different meaning of
>> 'sbitmap_weight'?
> 
> Yeah, this patch changes meaning of sbitmap_weight(), now it is
> exported, and we should make it more accurate/readable from user view.
> 
So can you please state this in the patch description?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
