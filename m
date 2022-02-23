Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA004C2054
	for <lists+linux-scsi@lfdr.de>; Thu, 24 Feb 2022 00:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242822AbiBWX6p (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 23 Feb 2022 18:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbiBWX6o (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 23 Feb 2022 18:58:44 -0500
Received: from mp-relay-01.fibernetics.ca (mp-relay-01.fibernetics.ca [208.85.217.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599E95D657
        for <linux-scsi@vger.kernel.org>; Wed, 23 Feb 2022 15:58:16 -0800 (PST)
Received: from mailpool-fe-01.fibernetics.ca (mailpool-fe-01.fibernetics.ca [208.85.217.144])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mp-relay-01.fibernetics.ca (Postfix) with ESMTPS id B2FD4E0CE5;
        Wed, 23 Feb 2022 23:58:15 +0000 (UTC)
Received: from localhost (mailpool-mx-02.fibernetics.ca [208.85.217.141])
        by mailpool-fe-01.fibernetics.ca (Postfix) with ESMTP id AB3963D5CD;
        Wed, 23 Feb 2022 23:58:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at 
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Received: from mailpool-fe-01.fibernetics.ca ([208.85.217.144])
        by localhost (mail-mx-02.fibernetics.ca [208.85.217.141]) (amavisd-new, port 10024)
        with ESMTP id GFm9zrNof7Nn; Wed, 23 Feb 2022 23:58:15 +0000 (UTC)
Received: from [192.168.48.23] (host-45-78-195-155.dyn.295.ca [45.78.195.155])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dgilbert@interlog.com)
        by mail.ca.inter.net (Postfix) with ESMTPSA id D82DA3D5CA;
        Wed, 23 Feb 2022 23:58:14 +0000 (UTC)
Message-ID: <372aba34-bc0d-f096-4748-219c0a99799e@interlog.com>
Date:   Wed, 23 Feb 2022 18:58:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: dgilbert@interlog.com
Subject: Re: sd: Unaligned partial completion
Content-Language: en-CA
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     SCSI development list <linux-scsi@vger.kernel.org>
References: <ae40bef0-702f-04c4-9219-47502c37d977@interlog.com>
 <yq11qzyh4zj.fsf@ca-mkp.ca.oracle.com>
 <22a343a6-f659-3938-b83e-a3842486bbb8@interlog.com>
 <yq1r17ub8fi.fsf@ca-mkp.ca.oracle.com>
 <55661371-3526-36e8-5743-c59a75a5374c@interlog.com>
 <1d41eaea-f2ef-6af1-e1d1-c588286fe338@opensource.wdc.com>
From:   Douglas Gilbert <dgilbert@interlog.com>
In-Reply-To: <1d41eaea-f2ef-6af1-e1d1-c588286fe338@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2022-02-23 17:47, Damien Le Moal wrote:
> On 2/24/22 06:37, Douglas Gilbert wrote:
>> On 2022-02-22 22:27, Martin K. Petersen wrote:
>>>
>>> Douglas,
>>>
>>>> No, of course not. But the kernel should inspect all UAs especially
>>>> the one that says: CAPACITY DATA HAS CHANGED !
>>>
>>> It does. And uses it to emit an event to userland.
>>>
>>> In most cases when capacity has changed it is because the user grew
>>> their LUN. And doing the right thing in that case is to let userland
>>> decide how to deal with it.
>>>
>>> You could argue that the kernel should do something if the device
>>> capacity shrinks. But it is unclear to me what "the right thing" is in
>>> all cases. What if there is not a mounted filesystem in the affected
>>> block range? Maybe the reduced block range it is not even described by
>>> an entry in the partition table? Should we do something? How does SCSI
>>> know how much of the capacity is actively in use, if any? Also, what's a
>>> partition?
>>>
>>> In addition, given our experience with NVMe devices which, for $OTHER_OS
>>> reasons, truncated their capacity when they experienced media problems,
>>> I am not sure we want to encourage anybody ever going down this
>>> path. What a mess!
>>
>> But this misses my point. sbc5r01.pdf says this:
>>
>>     "If the device server supports changing the block descriptor parameters
>>      by a MODE SELECT command and the number of logical blocks or the
>>      logical block length is changed, then the device server establishes
>>      a unit attention condition of:
>>         a) CAPACITY DATA HAS CHANGED as described in 4.10; and
>>         b) MODE PARAMETERS CHANGED as described in SPC-6.
>>
>> My point is: if "the logical block length is changed" then the sd driver
>> can NOT reliably issue any IO commands (READ or WRITE) until it does a
>> READ CAPACITY command to find out whether the LB size has changed, and
>> if so, to what.
>>
>>>> Also more and more settings in SCSI *** are giving the option to
>>>> return an error (even MEDIUM ERROR) if the initiator is reading a
>>>> block that has never been written. So if the sd driver is looking for
>>>> a partition table (LBA 0 ?)  then you have a chicken and egg problem
>>>> that retrying will not solve.
>>>
>>> For a general purpose OS it is completely unreasonable to expect that
>>> the OS has prior knowledge about which blocks were written. How is that
>>> even supposed to work if you plug in a USB drive from a different
>>> machine/OS? It also breaks the notion of array disks being
>>> self-describing which is now effectively an industry requirement.
>>>
>>> I am very happy to take patches that prevent us from retrying forever
>>> when a device is being disagreeable. But I am also very comfortable with
>>> the notion of not bothering to support devices that behave in a
>>> nonsensical way. Just because the SCSI spec allows something doesn't
>>> mean we should support it.
>>>
>>>> The sd driver should take its lead from SBC, not ZBC.
>>>
>>> The sd driver is the driver for both protocols.
>>
>> This "unaligned" usage seems to come from ZBC and first appeared in
>> SPC-4, ASC/ACSQ code [0x21,0x4]: "Unaligned WRITE command". It is
>> the only use of the word "unaligned" in SPC-4, SPC-5 and spc6r06.pdf
>> and it is not defined (in those documents) or in the SBC specs.
>> Surprisingly it is used, but not defined in zbc2r12.pdf .
>>
>> To me "unaligned" means some sort of transport issue which this is
>> not ***. It simply means the WRITE was not issued with a starting
>> LBA which corresponded to that zone's write pointer. This is
>> for "sequential write required" (swr)zones. IMO the ASC message
>> should be akin to: "Sequential write requirement violated".
>>
>> Until Linux utilities catch up with zoned disks, users of zoned
>> disks are going to see a lot of that "unaligned"  error! Currently
>> you can't partition a zoned disk because those utilities try to
>> WRITE shadow copies further out on the disk and violate the
>> write pointer settings of swr zones (then crash and burn).
>> You can create a BTR file system on a whole zoned disk (e.g. /dev/sdb)
>> but only if you have a recent enough btrfs-prog package ****. Any
>> Debian user caught in this bind, try using the binary Sid package at:
>>       https://packages.debian.org/sid/btrfs-progs
>>
>>
>> Life is a little easier fo ZBC/ZAC zoned disks which typically
>> start with conventional (normal random WRITE capable) zones (for 1%
>> of the available storage) before the swr zones commence. ZNS (for
>> NVMe) doesn't support conventional zones.
>>
>> Doug Gilbert
>>
>>
>> ***  well where sd.c generated that "unaligned" error it was because
>>        it tried to READ one block at LBA 0 and thought it was 4096
>>        bytes long. It wasn't (due to a MODE SELECT) so it got back
>>        512 bytes. Is that an alignment error ??
> 
> Personally, I consider it as such because the retry to process the
> remaining will necessarily fail, or worse, do bad things to the drive
> sectors, since the addressing is off by a factor of 8. Retrying the
> remaining of any of these "unaligned" commands is dangerous. For a read,
> this can lead to data leaks, and for a write, that can destroy the FS on
> the disk.

Here are the error messages I saw after the MODE_SELECT+FORMAT_UNIT
commands that changed the LB size from 4096 to 512 bytes. No command
was entered on the command line (after the format). The disk had no
mounted file systems on it.

[10490.819058] sd 2:0:1:0: [sdb] Unaligned partial completion (resid=3584, 
sector_sz=4096)
[10490.819189] sd 2:0:1:0: [sdb] tag#392 CDB: Read(16) 88 00 00 00 00 00 00 00 
00 00 00 00 00 01 00 00
[10490.820349] sd 2:0:1:0: [sdb] Unaligned partial completion (resid=3584, 
sector_sz=4096)
[10490.820356] sd 2:0:1:0: [sdb] tag#393 CDB: Read(16) 88 00 00 00 00 00 00 00 
00 00 00 00 00 01 00 00
[10490.820609] sd 2:0:1:0: [sdb] Unaligned partial completion (resid=3584, 
sector_sz=4096)
[10490.820612] sd 2:0:1:0: [sdb] tag#394 CDB: Read(16) 88 00 00 00 00 00 00 00 
00 00 00 00 00 01 00 00
[10490.820768] sd 2:0:1:0: [sdb] Unaligned partial completion (resid=3584, 
sector_sz=4096)
[10490.820769] sd 2:0:1:0: [sdb] tag#395 CDB: Read(16) 88 00 00 00 00 00 00 00 
00 00 00 00 00 01 00 00

That continued and the machine became unusable so I rebooted it.

The log shows that it is trying to read the partition table, that failed,
lets try it again (ad infinitum).
Surely to goodness that is BUG. And the information it needs is there:
wanted 4096 bytes, got 512, try again ... same result ... does that look
like a transport error? Not IMO.

What should it do? Well doing a READ CAPACITY would be a great start.

Doug Gilbert

