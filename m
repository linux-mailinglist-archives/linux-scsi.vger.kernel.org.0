Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC2438112
	for <lists+linux-scsi@lfdr.de>; Fri,  7 Jun 2019 00:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfFFWmc (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 6 Jun 2019 18:42:32 -0400
Received: from smtp.infotech.no ([82.134.31.41]:38038 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbfFFWmc (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 6 Jun 2019 18:42:32 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 462EF204191;
        Fri,  7 Jun 2019 00:42:29 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Cg3nHROWWhGr; Fri,  7 Jun 2019 00:42:21 +0200 (CEST)
Received: from [192.168.48.23] (host-45-58-224-183.dyn.295.ca [45.58.224.183])
        by smtp.infotech.no (Postfix) with ESMTPA id 60AC6204163;
        Fri,  7 Jun 2019 00:42:20 +0200 (CEST)
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH 00/19] sg: v4 interface, rq sharing + multiple rqs
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-scsi@vger.kernel.org,
        jejb@linux.vnet.ibm.com, hare@suse.de
References: <20190524184809.25121-1-dgilbert@interlog.com>
 <038d4781-1762-d7f6-199d-2f4702e746f6@acm.org>
 <4bebc171-55b9-5c41-0a7e-51db22473a03@interlog.com>
 <yq1muiuok9f.fsf@oracle.com>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <9e8a020e-c014-733d-11b4-986e5aefd877@interlog.com>
Date:   Thu, 6 Jun 2019 18:42:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <yq1muiuok9f.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2019-06-06 10:34 a.m., Martin K. Petersen wrote:
> 
> Doug,
> 
>> Cutting a patchset that touches around 1500 lines of a 3000 line
>> driver, then adds new functionality amounting to an extra 3000 lines
>> of code (and comments), according to the "one change per patch" rule
>> would result in a patchset with hundreds of patches.
> 
> The problem here is that you think of it as a single patch set
> transitioning the driver from major version X to version Y.
> 
> Linux kernel development has moved away from that model. The kernel
> release cadence is more or less fixed at 10 weeks. The release process
> is not controlled by features or component versions or anything of that
> nature. It is set by passing of time.
> 
> The notion that a driver or kernel component may have a version number
> applied to it is orthogonal to that process. A version is something you
> as a driver maintainer may decide to use to describe a certain set of
> commits. But it has no meaning wrt. the Linux development process.
> 
> If you want to transition sg from what you call v3 to v4, then the
> process is that you submit a handful or two of small, easily digestible
> patches at a time.
> 
> It may take a few kernel releases to get to where you want to be. But
> that is the process that everybody else is following to get their
> changes merged.
> 
> Nobody says you can only make one submission per submission window. It's
> perfectly fine to submit patches 11-20 as soon as patches 1-10 have been
> reviewed and merged. As an example of this, the HBA vendors usually send
> several driver updates each release cycle.
> 
>> Further if they are to be bisectable then they must not only
>> compile and build, but run properly.
> 
> Absolutely. That's a requirement.
> 
>> Of course that is impossible for new functionality as there is little
>> to test the new functionality against.
> 
> The burden is on you to submit patches in an order in which they make
> logical sense and in which they can be reviewed, bisected, and tested.
> 
>> I looked at the "Device Drivers" section. Most patchsets there
>> had between 10 and 20 patches, one had 33.
> 
> The "number of patches in a driver submission" as a measure is a red
> herring. sg is not a new driver, it has users.
> 
>> One, the SIW Infiniband driver, is over 10,000 lines long, and
>> contains 'only' 12 patches.
> 
> But it was presumably developed out of tree in a separate repo. And the
> thousands of commits that resulted in this driver have been collapsed
> into 12 patches for initial submission.
> 
> The number of lines is also a red herring. If a patch changes 10,000
> lines to make one logical change that's perfectly fine. What's not fine
> is a patch changing 10,000 lines and also making an entirely different
> logical change.
> 
>> Reviewers are obviously a scarce resource, but making their live's
>> easier shouldn't be a goal in itself.
> 
> Couldn't disagree more. If you want your code merged, you will have to
> present it in a way that caters to the reviewers. Because without
> reviews, your code won't get merged.
> 
>> If new functionality is being proposed, surely it is better to check
>> that it is documented and that test code exists. Then the design and
>> high level details of the implementation should be assessed.
> 
> Testing and documentation are absolutely important. But so is
> documenting what compelled a code change.
> 
> Reviews aid in verifying that the thought process outlined in the patch
> description matches the code changes performed. This is where the whole
> "one logical change" comes from. And when things subsequently break, it
> is then easy to identify which assumptions the patch author made that
> turned out not to be valid.
> 
>> To date I have had no feedback about design document describing this
>> patchset: http://sg.danny.cz/sg/sg_v40.html
> 
> This suffers the same problem as your patch series in that it
> encapsulates 26 years of thought in a single blob.
> 
> Presumably that document developed over time and didn't go from nothing
> to 22K words in an instant. You need to document that process. Also,
> having a design document that describes a wealth of changes after the
> fact is not terribly helpful.

So tl;dr ?

And if I hid the code, would my "blob" then qualify as a design document?

Also if my sg v2/v3 documentation targetted the kernel submission
processes between 1998 and 2002, would it be much use today? I
think not.

The way C++ standards are being developed these days is interesting.
A proposer comes with an idea, code, test cases, rationale; then clang
and gcc folks implement it and then the committee looks at it seriously.
Some proposals get shunted through TS groups for a longer look.

I'm old enough to have been through the Ada debacle. So I know about
design documentation that went from the floor to the ceiling, several
times. Ada wasn't (isn't) a bad language but it was killed by its
associated documentation workflow. The Ada prophets claimed it was
a self-evident truth that almost all documentation (and test cases)
must be written before any code was cut. Ada is still used in air
traffic control, railway signalling, etc; not sure if that is
re-assuring.


BTW Not everything in that "blob" is new. Only a small part of the
large ioctl table is new; plus the v1, v2, v3 and v4 interfaces
have all been in place for over 10 years. The object tree of the
driver remains the same.

> I understand appreciate that you are focused on the end product. But to
> get there you need to slowly and iteratively submit patches against v3
> that can be independently reviewed and merged.
> 
> Please pick one feature at a time. Carve that into a few patches that
> each logically only do one thing. And then submit that as a patch set
> with an intro mail that describes the design of the feature, which
> assumptions are made, what the benefits are, who needs this capability,
> etc.

Thank you for repeating the party line. I expected none other. As a
bonus, you took the "scarce resource" bait.

And I'm reminded of the well reasoned process that the cabal in which
Christoph, you and (I suspect) James conspired, to remove bidirectional
SCSI command support from the kernel. You dismissed it masterfully as
"old cruft" while Christoph continued to misquote Boaz after he had been
told by same to stop or properly qualify the quote in question. Cache
lines also got an honourable mention as a justification. But where was
the design document (aka a "blob") justifying the change/removal,
complete with a fallback strategy if the removal "blew up"? And where
are the design documents for the sd driver and its ongoing
evolutionary changes? Ever seen anything written about the sr or
ses driver?
... in short: don't do as I do, do as I say ...

I will probably produce a first half patchset, when I have properly
adjusted my "cadence".

Doug Gilbert


P.S. For historical accuracy it is 21 years not 26. I have never spoken
to, or received any correspondence (or design documents) from, Lawrence
Foard. In 1998 he had not responded to emails for several years (I was
told) and Alan Cox was looking for someone, anyone to take over
maintenance of the sg driver. IMO Alan considered that ongoing maintenance
and evolutionary change of the existing driver was more important than a
replacement driver that was on offer. So now I'm looking at a bit more
evolution.
