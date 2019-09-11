Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38CD2AFFE0
	for <lists+linux-scsi@lfdr.de>; Wed, 11 Sep 2019 17:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfIKPXX (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 11 Sep 2019 11:23:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44502 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbfIKPXX (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 11 Sep 2019 11:23:23 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C7BEF1DA2;
        Wed, 11 Sep 2019 15:23:22 +0000 (UTC)
Received: from [10.10.125.194] (ovpn-125-194.rdu2.redhat.com [10.10.125.194])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9212C60BEC;
        Wed, 11 Sep 2019 15:23:21 +0000 (UTC)
Subject: Re: [RFC PATCH] Add proc interface to set PF_MEMALLOC flags
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <20190909162804.5694-1-mchristi@redhat.com>
 <5D76995B.1010507@redhat.com>
 <ee39d997-ee07-22c7-3e59-a436cef4d587@I-love.SAKURA.ne.jp>
Cc:     axboe@kernel.dk, James.Bottomley@HansenPartnership.com,
        martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5D791169.2090807@redhat.com>
Date:   Wed, 11 Sep 2019 10:23:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <ee39d997-ee07-22c7-3e59-a436cef4d587@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.71]); Wed, 11 Sep 2019 15:23:23 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 09/10/2019 05:12 PM, Tetsuo Handa wrote:
> On 2019/09/10 3:26, Mike Christie wrote:
>> Forgot to cc linux-mm.
>>
>> On 09/09/2019 11:28 AM, Mike Christie wrote:
>>> There are several storage drivers like dm-multipath, iscsi, and nbd that
>>> have userspace components that can run in the IO path. For example,
>>> iscsi and nbd's userspace deamons may need to recreate a socket and/or
>>> send IO on it, and dm-multipath's daemon multipathd may need to send IO
>>> to figure out the state of paths and re-set them up.
>>>
>>> In the kernel these drivers have access to GFP_NOIO/GFP_NOFS and the
>>> memalloc_*_save/restore functions to control the allocation behavior,
>>> but for userspace we would end up hitting a allocation that ended up
>>> writing data back to the same device we are trying to allocate for.
>>>
>>> This patch allows the userspace deamon to set the PF_MEMALLOC* flags
>>> through procfs. It currently only supports PF_MEMALLOC_NOIO, but
>>> depending on what other drivers and userspace file systems need, for
>>> the final version I can add the other flags for that file or do a file
>>> per flag or just do a memalloc_noio file.
> 
> Interesting patch. But can't we instead globally mask __GFP_NOFS / __GFP_NOIO
> than playing games with per a thread masking (which suffers from inability to
> propagate current thread's mask to other threads indirectly involved)?

If I understood you, then that had been discussed in the past:

https://www.spinics.net/lists/linux-fsdevel/msg149035.html

We only need this for specific threads which implement part of a storage
driver in userspace.

> 
>>> +static ssize_t memalloc_write(struct file *file, const char __user *buf,
>>> +			      size_t count, loff_t *ppos)
>>> +{
>>> +	struct task_struct *task;
>>> +	char buffer[5];
>>> +	int rc = count;
>>> +
>>> +	memset(buffer, 0, sizeof(buffer));
>>> +	if (count != sizeof(buffer) - 1)
>>> +		return -EINVAL;
>>> +
>>> +	if (copy_from_user(buffer, buf, count))
> 
> copy_from_user() / copy_to_user() might involve memory allocation
> via page fault which has to be done under the mask? Moreover, since
> just open()ing this file can involve memory allocation, do we forbid
> open("/proc/thread-self/memalloc") ?

I was having the daemons set the flag when they initialize.
