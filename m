Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06D31B023B
	for <lists+linux-scsi@lfdr.de>; Wed, 11 Sep 2019 18:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbfIKQ47 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 11 Sep 2019 12:56:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40118 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729242AbfIKQ46 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 11 Sep 2019 12:56:58 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3947030832E9;
        Wed, 11 Sep 2019 16:56:58 +0000 (UTC)
Received: from [10.10.125.194] (ovpn-125-194.rdu2.redhat.com [10.10.125.194])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 36AEA10018F8;
        Wed, 11 Sep 2019 16:56:56 +0000 (UTC)
Subject: Re: [RFC PATCH] Add proc interface to set PF_MEMALLOC flags
To:     Martin Raiber <martin@urbackup.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20190909162804.5694-1-mchristi@redhat.com>
 <5D76995B.1010507@redhat.com>
 <BYAPR04MB5816DABF3C5071D13D823990E7B60@BYAPR04MB5816.namprd04.prod.outlook.com>
 <0102016d1f7af966-334f093b-2a62-4baa-9678-8d90d5fba6d9-000000@eu-west-1.amazonses.com>
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5D792758.2060706@redhat.com>
Date:   Wed, 11 Sep 2019 11:56:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <0102016d1f7af966-334f093b-2a62-4baa-9678-8d90d5fba6d9-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 11 Sep 2019 16:56:58 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 09/11/2019 03:40 AM, Martin Raiber wrote:
> On 10.09.2019 10:35 Damien Le Moal wrote:
>> Mike,
>>
>> On 2019/09/09 19:26, Mike Christie wrote:
>>> Forgot to cc linux-mm.
>>>
>>> On 09/09/2019 11:28 AM, Mike Christie wrote:
>>>> There are several storage drivers like dm-multipath, iscsi, and nbd that
>>>> have userspace components that can run in the IO path. For example,
>>>> iscsi and nbd's userspace deamons may need to recreate a socket and/or
>>>> send IO on it, and dm-multipath's daemon multipathd may need to send IO
>>>> to figure out the state of paths and re-set them up.
>>>>
>>>> In the kernel these drivers have access to GFP_NOIO/GFP_NOFS and the
>>>> memalloc_*_save/restore functions to control the allocation behavior,
>>>> but for userspace we would end up hitting a allocation that ended up
>>>> writing data back to the same device we are trying to allocate for.
>>>>
>>>> This patch allows the userspace deamon to set the PF_MEMALLOC* flags
>>>> through procfs. It currently only supports PF_MEMALLOC_NOIO, but
>>>> depending on what other drivers and userspace file systems need, for
>>>> the final version I can add the other flags for that file or do a file
>>>> per flag or just do a memalloc_noio file.
>> Awesome. That probably will be the perfect solution for the problem we hit with
>> tcmu-runner a while back (please see this thread:
>> https://www.spinics.net/lists/linux-fsdevel/msg148912.html).
>>
>> I think we definitely need nofs as well for dealing with cases where the backend
>> storage for the user daemon is a file.
>>
>> I will give this patch a try as soon as possible (I am traveling currently).
>>
>> Best regards.
> 
> I had issues with this as well, and work on this is appreciated! In my
> case it is a loop block device on a fuse file system.
> Setting PF_LESS_THROTTLE was the one that helped the most, though, so
> add an option for that as well? I set this via prctl() for the thread
> calling it (was easiest to add to).
> 
> Sorry, I have no idea about the current rationale, but wouldn't it be
> better to have a way to mask a set of block devices/file systems not to
> write-back to in a thread. So in my case I'd specify that the fuse
> daemon threads cannot write-back to the file system and loop device
> running on top of the fuse file system, while all other block
> devices/file systems can be write-back to (causing less swapping/OOM
> issues).

I'm not sure I understood you.

The storage daemons I mentioned normally kick off N threads per M
devices. The threads handle duties like IO and error handling for those
devices. Those threads would set the flag, so those IO/error-handler
related operations do not end up writing back to them. So it works
similar to how storage drivers work in the kernel where iscsi_tcp has an
xmit thread and that does memalloc_noreclaim_save. Only the threads for
those specific devices being would set the flag.

In your case, it sounds like you have a thread/threads that would
operate on multiple devices and some need the behavior and some do not.
Is that right?


