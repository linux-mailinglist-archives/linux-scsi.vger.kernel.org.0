Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F11AA55C65
	for <lists+linux-scsi@lfdr.de>; Wed, 26 Jun 2019 01:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbfFYXgc (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 25 Jun 2019 19:36:32 -0400
Received: from smtp.infotech.no ([82.134.31.41]:57156 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbfFYXgc (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 25 Jun 2019 19:36:32 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id C9A83204192;
        Wed, 26 Jun 2019 01:36:28 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PUd5Hi81u7lR; Wed, 26 Jun 2019 01:36:22 +0200 (CEST)
Received: from [192.168.48.23] (host-45-58-224-183.dyn.295.ca [45.58.224.183])
        by smtp.infotech.no (Postfix) with ESMTPA id DFA88204163;
        Wed, 26 Jun 2019 01:36:19 +0200 (CEST)
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH] scsi: convert to rst for documenation
To:     Jonathan Corbet <corbet@lwn.net>,
        Phong Tran <tranmanphong@gmail.com>
Cc:     skhan@linuxfoundation.org, martin.petersen@oracle.com,
        axboe@kernel.dk, avri.altman@wdc.com, beanhuo@micron.com,
        evgreen@chromium.org, henrik@austad.us, jpittman@redhat.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-scsi@vger.kernel.org
References: <20190622151947.29115-1-tranmanphong@gmail.com>
 <20190625153658.53ad0e18@lwn.net>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <0e3c88da-e643-a60f-4a5a-92c3c7a2fbb1@interlog.com>
Date:   Tue, 25 Jun 2019 19:36:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190625153658.53ad0e18@lwn.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Please see below.

On 2019-06-25 5:36 p.m., Jonathan Corbet wrote:
> On Sat, 22 Jun 2019 22:19:47 +0700
> Phong Tran <tranmanphong@gmail.com> wrote:
> 
>> - Update to the link in documenation
>> - Remove trailing white space
>> - Adaptation the sphinx doc syntax
>>
>> Signed-off-by: Phong Tran <tranmanphong@gmail.com>
> 
> Thanks for working to improve the documentation!  That said, I think this
> patch needs a fair amount of work before we are ready to accept it.  I'll
> only get partway in, but it should be enough to start with.
> 
> The first overall thing I would like to point out (and hopefully the SCSI
> folks won't fight me too much on this) is that Documentation/scsi is the
> wrong place for much of this stuff.  We are doing our best to organize the
> documentation with the audience in mind.  So, for example, documents that
> are of interest to system administrators should go into
> Documentation/admin-guide.  Information for driver developers should go in
> Documentation/driver-api.  And so on.
> 
> [...]
> 
>> diff --git a/Documentation/scsi/link_power_management_policy.rst b/Documentation/scsi/link_power_management_policy.rst
>> new file mode 100644
>> index 000000000000..170f58c94cac
>> --- /dev/null
>> +++ b/Documentation/scsi/link_power_management_policy.rst
>> @@ -0,0 +1,22 @@
>> +SCSI Power Management Policy
>> +============================
>> +Its
>> +This parameter allows the user to set the link (interface) power management.
>> +There are 3 possible options:
> 
> This isn't your fault, but...*which* parameter allows this?  The document
> describes the values, but not where they can be set.  That makes it less
> than fully useful.
> 
>> ++-------------------+------------------------------------------------------+
>> +| Value             | Effect                                               |
>> ++===================+======================================================+
>> +| min_power         | Tell the controller to try to make the link use the  |
>> +|                   | least possible power when possible. This may         |
>> +|                   | sacrifice some performance due to increased latency  |
>> +|                   | when coming out of lower power states.               |
>> ++-------------------+------------------------------------------------------+
>> +| max_performance   | Generally, this means no power management. Tell      |
>> +|                   | the controller to have performance be a priority     |
>> +|                   | over power management.                               |
>> ++-------------------+------------------------------------------------------+
>> +| medium_power      | Tell the controller to enter a lower power state     |
>> +|                   | when possible, but do not enter the lowest power     |
>> +|                   | state, thus improving latency over min_power setting.|
>> ++-------------------+------------------------------------------------------+
> 
> [...]
> 
>> diff --git a/Documentation/scsi/scsi-changer.txt b/Documentation/scsi/scsi-changer.rst
>> similarity index 71%
>> rename from Documentation/scsi/scsi-changer.txt
>> rename to Documentation/scsi/scsi-changer.rst
>> index ade046ea7c17..a4923873c77b 100644
>> --- a/Documentation/scsi/scsi-changer.txt
>> +++ b/Documentation/scsi/scsi-changer.rst
>> @@ -1,4 +1,3 @@
>> -
>>   README for the SCSI media changer driver
>>   ========================================
>>   
>> @@ -10,7 +9,7 @@ common small CD-ROM changers, neither one-lun-per-slot SCSI changers
>>   nor IDE drives.
>>   
>>   Userland tools available from here:
>> -	http://linux.bytesex.org/misc/changer.html
>> +    http://linux.bytesex.org/misc/changer.html
>>   
>>   
>>   General Information
>> @@ -28,15 +27,17 @@ The SCSI changer model is complex, compared to - for example - IDE-CD
>>   changers. But it allows to handle nearly all possible cases. It knows
>>   4 different types of changer elements:
>>   
>> +::
> 
> Two notes:
> 
>   - You can put the double colon on the line above ("...elements::") and
>     don't need to make a separate line for it.
> 
>   - But, more to the point, please avoid the temptation to use a literal
>     block for something that doesn't actually require that treatment. This
>     should be reworked as an RST definition list.
> 
>>     media transport - this one shuffles around the media, i.e. the
>>                       transport arm.  Also known as "picker".
>>     storage         - a slot which can hold a media.
>>     import/export   - the same as above, but is accessible from outside,
>>                       i.e. there the operator (you !) can use this to
>>                       fill in and remove media from the changer.
>> -		    Sometimes named "mailslot".
>> +            Sometimes named "mailslot".
>>     data transfer   - this is the device which reads/writes, i.e. the
>> -		    CD-ROM / Tape / whatever drive.
>> +            CD-ROM / Tape / whatever drive.
> 
> [...]
> 
>> diff --git a/Documentation/scsi/scsi-generic.txt b/Documentation/scsi/scsi-generic.rst
>> similarity index 70%
>> rename from Documentation/scsi/scsi-generic.txt
>> rename to Documentation/scsi/scsi-generic.rst
>> index 51be20a6a14d..8356810160f0 100644
>> --- a/Documentation/scsi/scsi-generic.txt
>> +++ b/Documentation/scsi/scsi-generic.rst
>> @@ -1,8 +1,10 @@
>> -            Notes on Linux SCSI Generic (sg) driver
>> -            ---------------------------------------
>> -                                                        20020126
>> +=======================================
>> +Notes on Linux SCSI Generic (sg) driver
>> +=======================================
>> +20020126
>> +
>>   Introduction
>> -============
>> +------------
>>   The SCSI Generic driver (sg) is one of the four "high level" SCSI device
>>   drivers along with sd, st and sr (disk, tape and CDROM respectively). Sg
>>   is more generalized (but lower level) than its siblings and tends to be
>> @@ -16,20 +18,20 @@ and examples.
>>   
>>   
>>   Major versions of the sg driver
>> -===============================
>> +-------------------------------
>>   There are three major versions of sg found in the linux kernel (lk):
>> -      - sg version 1 (original) from 1992 to early 1999 (lk 2.2.5) .
>> -	It is based in the sg_header interface structure.
>> +      - sg version 1 (original) from 1992 to early 1999 (lk 2.2.5) .
>> +        It is based in the sg_header interface structure.
>>         - sg version 2 from lk 2.2.6 in the 2.2 series. It is based on
>> -	an extended version of the sg_header interface structure.
>> +        an extended version of the sg_header interface structure.
>>         - sg version 3 found in the lk 2.4 series (and the lk 2.5 series).
>> -	It adds the sg_io_hdr interface structure.
>> +        It adds the sg_io_hdr interface structure.
> 
> Perhaps we don't *really* need to preserve information about what versions
> were around in the 1990's?
> 
>>   Sg driver documentation
>> -=======================
>> +-----------------------
>>   The most recent documentation of the sg driver is kept at the Linux
>> -Documentation Project's (LDP) site:
>> +Documentation Project's (LDP) site:
>>   http://www.tldp.org/HOWTO/SCSI-Generic-HOWTO
> 
> That document claims to have been last updated in 2002.  Is there really
> nothing more recent than that?

http://sg.danny.cz/sg/sg_v40.html

Last updated: yesterday.

>>   This describes the sg version 3 driver found in the lk 2.4 series.
> 
> ...and it's unclear to me that users of the 5.x kernel are much concerned
> with what was found in 2.4.
> 
> That is the problem with this document in general.  I suspect that about
> the only useful information left in it is the location of the sg3_utils
> source.  I honestly don't think that it helps the documentation that much
> to carry forward ancient information to the RST format.

That old document is pretty damn accurate. At least one feature was
quietly removed over the years. And some ioctls no longer do anything
(see the ioctl table towards the end of the above document). The sg
driver's public interface is a lot more stable than the kernel API behind
it :-) . There is driver in FreeBSD that implements that interface, it's
called scsi_sg .

> Of course, doing this right by deleting obsolete information and updating
> the documents to reflect current reality is a *lot* more work.  Probably
> far more than you were thinking of signing up for.  If you were willing to
> work on this, there may be somebody from the SCSI community who would be in
> a position to help you with it.

Hmmm.

> Unfortunately, the SCSI community probably did not see this patch because
> you didn't copy the linux-scsi list.  I'll fix that now, but they will not
> have seen your original patch.  You should be sure to include them on
> future postings.
> 
> I would like to make a suggestion, in addition to all of the above: rather
> than trying to do a mass conversion in a single 4000-line patch, start with
> a single file and post a patch doing just that one, being sure to include
> the linux-scsi list.  That will give everybody something more workable to
> start with.

Editorial comments welcome.

Martin Petersen wants to see that document reworked in order to market the
new features that I am proposing. My approach is to document the code that
I have in front of me ***, plus add a bit of historical context.

I chose that format so I could add diagrams (using Libreoffice writer).
Do those diagrams help?

Doug Gilbert


*** it helps me find bugs in my code and my documentation. I'm also testing
     the code at the same time.

