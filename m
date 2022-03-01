Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94924C807E
	for <lists+linux-scsi@lfdr.de>; Tue,  1 Mar 2022 02:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbiCABti (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 28 Feb 2022 20:49:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbiCABtb (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 28 Feb 2022 20:49:31 -0500
Received: from mp-relay-01.fibernetics.ca (mp-relay-01.fibernetics.ca [208.85.217.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E325DE42
        for <linux-scsi@vger.kernel.org>; Mon, 28 Feb 2022 17:48:49 -0800 (PST)
Received: from mailpool-fe-02.fibernetics.ca (mailpool-fe-02.fibernetics.ca [208.85.217.145])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mp-relay-01.fibernetics.ca (Postfix) with ESMTPS id 1A247E0F68;
        Tue,  1 Mar 2022 01:48:48 +0000 (UTC)
Received: from localhost (mailpool-mx-02.fibernetics.ca [208.85.217.141])
        by mailpool-fe-02.fibernetics.ca (Postfix) with ESMTP id 11EF263086;
        Tue,  1 Mar 2022 01:48:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at 
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Received: from mailpool-fe-02.fibernetics.ca ([208.85.217.145])
        by localhost (mail-mx-02.fibernetics.ca [208.85.217.141]) (amavisd-new, port 10024)
        with ESMTP id E9tgzuaWfdRv; Tue,  1 Mar 2022 01:48:47 +0000 (UTC)
Received: from [192.168.48.23] (host-45-78-195-155.dyn.295.ca [45.78.195.155])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dgilbert@interlog.com)
        by mail.ca.inter.net (Postfix) with ESMTPSA id 37BAD62664;
        Tue,  1 Mar 2022 01:48:47 +0000 (UTC)
Message-ID: <a0876c6a-3e5e-70ba-e8f0-366ce05a4a67@interlog.com>
Date:   Mon, 28 Feb 2022 20:48:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH 2/2] scsi: scsi_debug: fix sparse lock warnings in
 sdebug_blk_mq_poll()
Content-Language: en-CA
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20220225084527.523038-1-damien.lemoal@opensource.wdc.com>
 <20220225084527.523038-3-damien.lemoal@opensource.wdc.com>
 <fbfa587b-94fc-9431-bb74-56c50a89767e@interlog.com>
 <2dda2a2a-dc54-e335-e0eb-574868397277@opensource.wdc.com>
From:   Douglas Gilbert <dgilbert@interlog.com>
In-Reply-To: <2dda2a2a-dc54-e335-e0eb-574868397277@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

See below:

On 2022-02-28 08:46, Damien Le Moal wrote:
> On 2022/02/28 4:05, Douglas Gilbert wrote:
>> On 2022-02-25 03:45, Damien Le Moal wrote:
>>> The use of the locked boolean variable to control locking and unlocking
>>> of the qc_lock of struct sdebug_queue confuses sparse, leading to a
>>> warning about an unexpected unlock. Simplify the qc_lock lock/unlock
>>> handling code of this function to avoid this warning by removing the
>>> locked boolean variable.
>>
>> See below.
>>
>>>
>>> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>>> ---
>>>    drivers/scsi/scsi_debug.c | 19 +++++++++----------
>>>    1 file changed, 9 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
>>> index f4e97f2224b2..acb32f3e38eb 100644
>>> --- a/drivers/scsi/scsi_debug.c
>>> +++ b/drivers/scsi/scsi_debug.c
>>> @@ -7509,7 +7509,6 @@ static int sdebug_blk_mq_poll(struct Scsi_Host *shost, unsigned int queue_num)
>>>    {
>>>    	bool first;
>>>    	bool retiring = false;
>>> -	bool locked = false;
>>>    	int num_entries = 0;
>>>    	unsigned int qc_idx = 0;
>>>    	unsigned long iflags;
>>> @@ -7525,18 +7524,17 @@ static int sdebug_blk_mq_poll(struct Scsi_Host *shost, unsigned int queue_num)
>>>    	if (qc_idx >= sdebug_max_queue)
>>>    		return 0;
>>>    
>>> +	spin_lock_irqsave(&sqp->qc_lock, iflags);
>>> +
>>>    	for (first = true; first || qc_idx + 1 < sdebug_max_queue; )   {
>>> -		if (!locked) {
>>> -			spin_lock_irqsave(&sqp->qc_lock, iflags);
>>> -			locked = true;
>>> -		}
>>>    		if (first) {
>>>    			first = false;
>>>    			if (!test_bit(qc_idx, sqp->in_use_bm))
>>>    				continue;
>>> -		} else {
>>> -			qc_idx = find_next_bit(sqp->in_use_bm, sdebug_max_queue, qc_idx + 1);
>>>    		}
>>> +
>>> +		qc_idx = find_next_bit(sqp->in_use_bm, sdebug_max_queue,
>>> +				       qc_idx + 1);
>>
>> The original logic is wrong or the above line is wrong. find_next_bit() is not
>> called on the first iteration in the original, but it is with this patch.
>>
>>>    		if (qc_idx >= sdebug_max_queue)
>>>    			break;
>>>    
>>> @@ -7586,14 +7584,15 @@ static int sdebug_blk_mq_poll(struct Scsi_Host *shost, unsigned int queue_num)
>>>    		}
>>>    		WRITE_ONCE(sd_dp->defer_t, SDEB_DEFER_NONE);
>>>    		spin_unlock_irqrestore(&sqp->qc_lock, iflags);
>>> -		locked = false;
>>>    		scsi_done(scp); /* callback to mid level */
>>>    		num_entries++;
>>> +		spin_lock_irqsave(&sqp->qc_lock, iflags);
>>>    		if (find_first_bit(sqp->in_use_bm, sdebug_max_queue) >= sdebug_max_queue)
>>>    			break;	/* if no more then exit without retaking spinlock */
>>
>> See that comment on the line above? That is the reason for the guard variable.
>> Defying that comment, the modified code does a superfluous spinlock irqsave
>> and irqrestore.
> 
> Rechecking this, there is one point that is bothering me: is it OK to have the
> find_first_bit() outside of the sqp lock ? If not, then this is a bug and the
> extra lock/unlock that my patch add is a fix...

I think you are correct, please fix it.
You will notice that when the spinlock_irq is dropped to call scsi_done(),
that the iteration is restarted.

>>
>> Sparse could be taken as a comment on the amount of grey matter that tool has.
>>
>>
>>>    	}
>>> -	if (locked)
>>> -		spin_unlock_irqrestore(&sqp->qc_lock, iflags);
>>> +
>>> +	spin_unlock_irqrestore(&sqp->qc_lock, iflags);
>>> +
>>>    	if (num_entries > 0)
>>>    		atomic_add(num_entries, &sdeb_mq_poll_count);
>>>    	return num_entries;
>>
>> Locking issues are extremely difficult to analyze via a unified diff of
>> the function. A copy of the original function is required to make any
>> sense of it.

I was trying to say: it is difficult to understand what diff style output
of a change as shown in a [PATCH] post like this, especially to a function's
locking, will do, without see the __whole__ function.

It is not a criticism of this patchset, but the process in general which loses
important context of the function being patched.


