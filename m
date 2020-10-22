Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 676C3295BB1
	for <lists+linux-scsi@lfdr.de>; Thu, 22 Oct 2020 11:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895884AbgJVJZl (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 22 Oct 2020 05:25:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56474 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2508320AbgJVJZk (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 22 Oct 2020 05:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603358738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V4iDiOcDlfxoeiFCe52LA34QHP6qFIj9VPFt7sZ2z60=;
        b=FzG3xyvV5sEuMIvBqLfR0aLiX/bg5OXRbORAsMjGuGscXZ8Epr1kxoUlKiWOn9y6tcxIhJ
        PpFPcdKcj4YhExbiH8ybCGWwMCD+4Vbp9Yy08/DP3WD+6WBsSumLkJZqQFNC0Xtm12DW+e
        x19S0MGX8WEC3GHjXeyWmvrt+XxG1qo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-7idT9gG9OaKZttwlpdSKTg-1; Thu, 22 Oct 2020 05:25:34 -0400
X-MC-Unique: 7idT9gG9OaKZttwlpdSKTg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BDEB804B60;
        Thu, 22 Oct 2020 09:25:31 +0000 (UTC)
Received: from [10.36.113.152] (ovpn-113-152.ams2.redhat.com [10.36.113.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3EFBD60BFA;
        Thu, 22 Oct 2020 09:25:26 +0000 (UTC)
Subject: Re: Buggy commit tracked to: "Re: [PATCH 2/9] iov_iter: move
 rw_copy_check_uvector() into lib/iov_iter.c"
From:   David Hildenbrand <david@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     David Laight <David.Laight@aculab.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Christoph Hellwig <hch@lst.de>,
        "kernel-team@android.com" <kernel-team@android.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-aio@kvack.org" <linux-aio@kvack.org>,
        "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
References: <20200925045146.1283714-1-hch@lst.de>
 <20200925045146.1283714-3-hch@lst.de> <20201021161301.GA1196312@kroah.com>
 <20201021233914.GR3576660@ZenIV.linux.org.uk>
 <20201022082654.GA1477657@kroah.com>
 <80a2e5fa-718a-8433-1ab0-dd5b3e3b5416@redhat.com>
 <5d2ecb24db1e415b8ff88261435386ec@AcuMS.aculab.com>
 <df2e0758-b8ed-5aec-6adc-a18f499c0179@redhat.com>
 <20201022090155.GA1483166@kroah.com>
 <e04d0c5d-e834-a15b-7844-44dcc82785cc@redhat.com>
Organization: Red Hat GmbH
Message-ID: <a1533569-948a-1d5b-e231-5531aa988047@redhat.com>
Date:   Thu, 22 Oct 2020 11:25:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <e04d0c5d-e834-a15b-7844-44dcc82785cc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 22.10.20 11:19, David Hildenbrand wrote:
> On 22.10.20 11:01, Greg KH wrote:
>> On Thu, Oct 22, 2020 at 10:48:59AM +0200, David Hildenbrand wrote:
>>> On 22.10.20 10:40, David Laight wrote:
>>>> From: David Hildenbrand
>>>>> Sent: 22 October 2020 09:35
>>>>>
>>>>> On 22.10.20 10:26, Greg KH wrote:
>>>>>> On Thu, Oct 22, 2020 at 12:39:14AM +0100, Al Viro wrote:
>>>>>>> On Wed, Oct 21, 2020 at 06:13:01PM +0200, Greg KH wrote:
>>>>>>>> On Fri, Sep 25, 2020 at 06:51:39AM +0200, Christoph Hellwig wrote:
>>>>>>>>> From: David Laight <David.Laight@ACULAB.COM>
>>>>>>>>>
>>>>>>>>> This lets the compiler inline it into import_iovec() generating
>>>>>>>>> much better code.
>>>>>>>>>
>>>>>>>>> Signed-off-by: David Laight <david.laight@aculab.com>
>>>>>>>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>>>>>>>> ---
>>>>>>>>>  fs/read_write.c | 179 ------------------------------------------------
>>>>>>>>>  lib/iov_iter.c  | 176 +++++++++++++++++++++++++++++++++++++++++++++++
>>>>>>>>>  2 files changed, 176 insertions(+), 179 deletions(-)
>>>>>>>>
>>>>>>>> Strangely, this commit causes a regression in Linus's tree right now.
>>>>>>>>
>>>>>>>> I can't really figure out what the regression is, only that this commit
>>>>>>>> triggers a "large Android system binary" from working properly.  There's
>>>>>>>> no kernel log messages anywhere, and I don't have any way to strace the
>>>>>>>> thing in the testing framework, so any hints that people can provide
>>>>>>>> would be most appreciated.
>>>>>>>
>>>>>>> It's a pure move - modulo changed line breaks in the argument lists
>>>>>>> the functions involved are identical before and after that (just checked
>>>>>>> that directly, by checking out the trees before and after, extracting two
>>>>>>> functions in question from fs/read_write.c and lib/iov_iter.c (before and
>>>>>>> after, resp.) and checking the diff between those.
>>>>>>>
>>>>>>> How certain is your bisection?
>>>>>>
>>>>>> The bisection is very reproducable.
>>>>>>
>>>>>> But, this looks now to be a compiler bug.  I'm using the latest version
>>>>>> of clang and if I put "noinline" at the front of the function,
>>>>>> everything works.
>>>>>
>>>>> Well, the compiler can do more invasive optimizations when inlining. If
>>>>> you have buggy code that relies on some unspecified behavior, inlining
>>>>> can change the behavior ... but going over that code, there isn't too
>>>>> much action going on. At least nothing screamed at me.
>>>>
>>>> Apart from all the optimisations that get rid off the 'pass be reference'
>>>> parameters and strange conditional tests.
>>>> Plenty of scope for the compiler getting it wrong.
>>>> But nothing even vaguely illegal.
>>>
>>> Not the first time that people blame the compiler to then figure out
>>> that something else is wrong ... but maybe this time is different :)
>>
>> I agree, I hate to blame the compiler, that's almost never the real
>> problem, but this one sure "feels" like it.
>>
>> I'm running some more tests, trying to narrow things down as just adding
>> a "noinline" to the function that got moved here doesn't work on Linus's
>> tree at the moment because the function was split into multiple
>> functions.
>>
>> Give me a few hours...
> 
> I might be wrong but
> 
> a) import_iovec() uses:
> - unsigned nr_segs -> int
> - unsigned fast_segs -> int
> b) rw_copy_check_uvector() uses:
> - unsigned long nr_segs -> long
> - unsigned long fast_seg -> long
> 
> So when calling rw_copy_check_uvector(), we have to zero-extend the
> registers used for passing the arguments. That's definitely done when
> calling the function explicitly. Maybe when inlining something is messed up?
> 
> Just a thought ...
> 

... especially because I recall that clang and gcc behave slightly
differently:

https://github.com/hjl-tools/x86-psABI/issues/2

"Function args are different: narrow types are sign or zero extended to
32 bits, depending on their type. clang depends on this for incoming
args, but gcc doesn't make that assumption. But both compilers do it
when calling, so gcc code can call clang code.

The upper 32 bits of registers are always undefined garbage for types
smaller than 64 bits."

Again, just a thought.

-- 
Thanks,

David / dhildenb

