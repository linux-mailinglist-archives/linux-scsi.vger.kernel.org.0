Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD122351E9
	for <lists+linux-scsi@lfdr.de>; Tue,  4 Jun 2019 23:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfFDVba (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 4 Jun 2019 17:31:30 -0400
Received: from smtp.infotech.no ([82.134.31.41]:57465 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbfFDVba (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 4 Jun 2019 17:31:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 18D50204191;
        Tue,  4 Jun 2019 23:31:27 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Pjhx3aK6VCp1; Tue,  4 Jun 2019 23:31:20 +0200 (CEST)
Received: from [192.168.48.23] (host-45-58-224-183.dyn.295.ca [45.58.224.183])
        by smtp.infotech.no (Postfix) with ESMTPA id 93823204158;
        Tue,  4 Jun 2019 23:31:19 +0200 (CEST)
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH 00/19] sg: v4 interface, rq sharing + multiple rqs
To:     Bart Van Assche <bvanassche@acm.org>, linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        bart.vanassche@wdc.com
References: <20190524184809.25121-1-dgilbert@interlog.com>
 <038d4781-1762-d7f6-199d-2f4702e746f6@acm.org>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <4bebc171-55b9-5c41-0a7e-51db22473a03@interlog.com>
Date:   Tue, 4 Jun 2019 17:31:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <038d4781-1762-d7f6-199d-2f4702e746f6@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2019-06-03 12:19 p.m., Bart Van Assche wrote:
> On 5/24/19 11:47 AM, Douglas Gilbert wrote:
>> This patchset is big and can be regarded as a driver rewrite. The
>> number of lines increases from around 3000 to over 6000.
> 
> Every SCSI reviewer I know is too busy to review a patch series that involves so 
> many changes. You may have to split this series into a number of smaller series 
> if you want to encourage reviewers to have a look.

Cutting a patchset that touches around 1500 lines of a 3000 line
driver, then adds new functionality amounting to an extra 3000
lines of code (and comments), according to the "one change per
patch" rule would result in a patchset with hundreds of patches.

Further if they are to be bisectable then they must not only
compile and build, but run properly. Of course that is impossible
for new functionality as there is little to test the new
functionality against. Then there is the case of a driver maintainer
who wants to clean up code that has "rusted" over time, including
being weakened by hundreds of well-meaning but silly janitor type
patches. Should a maintainer be discouraged from doing that?

Looking around at current patchsets, LWN keeps a helpful list at
the bottom of this page (from last Thursday):
     https://lwn.net/Articles/789234/
[non-subscribers need to wait until next Thursday to view that].
I looked at the "Device Drivers" section. Most patchsets there
had between 10 and 20 patches, one had 33. One, the SIW Infiniband
driver, is over 10,000 lines long, and contains 'only' 12 patches.
Reviewers are obviously a scarce resource, but making their live's
easier shouldn't be a goal in itself.


Further, the utility of bottom up reviews by humans reduces with
time as the automatic tools to do that get better. Of the responses
to my "version 1" patchset 10 days ago, I would regard only one of
your responses "useful", and all but one of the kbuild robot's
responses useful. By "useful" I mean that they lead to better code.

If new functionality is being proposed, surely it is better to
check that it is documented and that test code exists. Then the
design and high level details of the implementation should be
assessed. And if the code doesn't involve special hardware,
shouldn't the test code be run as part of the review process?
Code reviews have their place, but over the last 10 years, bugs in
the sg and scsi_debug drivers have been found by _using_ those
drivers. Also with those drivers I and others have found bugs in
the block layer and the SCSI mid-level. To date I have had no
feedback about design document describing this patchset:
     http://sg.danny.cz/sg/sg_v40.html
even though I refer to sections of it in about half of the patches
in this patchset. Plus I have written extensive test code and made
it available; again no feedback on that.

In the article: "A ring buffer for epoll":
    https://lwn.net/Articles/789603/    [May 30, 2019]
Jonathan Corbet discusses these issues in the final section
titled: "Some closing grumbles".

Doug Gilbert


