Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 026C6162FA8
	for <lists+linux-scsi@lfdr.de>; Tue, 18 Feb 2020 20:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgBRTUa (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 18 Feb 2020 14:20:30 -0500
Received: from mail.archive.org ([207.241.224.6]:57414 "EHLO mail.archive.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbgBRTU3 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 18 Feb 2020 14:20:29 -0500
Received: from mail.archive.org (localhost [127.0.0.1])
        by mail.archive.org (Postfix) with ESMTP id 06B371FB34;
        Tue, 18 Feb 2020 19:20:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.archive.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,SHORTCIRCUIT
        autolearn=disabled version=3.4.2
Received: from [0.0.0.0] (a82-161-36-93.adsl.xs4all.nl [82.161.36.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: merlijn@archive.org)
        by mail.archive.org (Postfix) with ESMTPSA id 971A71FB1D;
        Tue, 18 Feb 2020 19:20:23 +0000 (UTC)
Subject: Re: [PATCH v2] scsi: sr: get rid of sr global mutex
To:     Christoph Hellwig <hch@infradead.org>,
        James Bottomley <jejb@linux.ibm.com>
Cc:     merlijn@wizzup.org, linux-scsi@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
References: <20200218143918.30267-1-merlijn@archive.org>
 <20200218171259.GA6724@infradead.org>
 <1582046428.16681.7.camel@linux.ibm.com>
 <20200218172347.GA3020@infradead.org>
 <1582046914.16681.11.camel@linux.ibm.com>
 <20200218173158.GA18386@infradead.org>
From:   "Merlijn B.W. Wajer" <merlijn@archive.org>
Message-ID: <33da5f81-ad37-05fd-d765-8bd997995dd2@archive.org>
Date:   Tue, 18 Feb 2020 20:21:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200218173158.GA18386@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Envelope-From: <merlijn@archive.org>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi,

On 18/02/2020 18:31, Christoph Hellwig wrote:
> On Tue, Feb 18, 2020 at 09:28:34AM -0800, James Bottomley wrote:
>> On Tue, 2020-02-18 at 09:23 -0800, Christoph Hellwig wrote:
>>> On Tue, Feb 18, 2020 at 09:20:28AM -0800, James Bottomley wrote:
>>>>>> Replace the global mutex with per-sr-device mutex.
>>>>>
>>>>> Do we actually need the lock at all?  What is protected by it?
>>>>
>>>> We do at least for cdrom_open.  It modifies the cdi structure with
>>>> no other protection and concurrent modification would at least
>>>> screw up the use counter which is not atomic.  Same reasoning for
>>>> cdrom_release.
>>>
>>> Wouldn't the right fix to add locking to cdrom_open/release instead
>>> of having an undocumented requirement for the callers?
>>
>> Yes ... but that's somewhat of a bigger patch because you now have to
>> reason about the callbacks within cdrom.  There's also the question of
>> whether you can assume ops->generic_packet() has its own concurrency
>> protections ... it's certainly true for SCSI, but is it for anything
>> else?  Although I suppose you can just not care and run the internal
>> lock over it anyway.
> 
> We have 4 instances of struct cdrom_device_ops in the kernel, one of
> which has a no-op generic_packet.  So I don't think this should be a
> huge project.

The are two reasons I decided to make minor changes to fix the
performance regression.

First, being able to send the patch to the various stable branches once
merged. For people working with many CD drives attached to one station,
this is a pretty big deal, so I tried to keep the patch simple. It fixes
the regression introduced in another commit.

Secondly, I don't have the hardware to test sophisticated or old setups,
like some of the issues linked from my patch. I have SATA CD drives with
USB->SATA bridges, no IDE, no PATA, etc. So the testing I can do is
relatively limited.

Perhaps I or someone else can work on removing the usage of the locks,
but as it stands I think this addresses the performance issue present in
the current kernel, and removing locks and the associated testing
required with that is something I am not entirely comfortable doing.

Cheers,
Merlijn
