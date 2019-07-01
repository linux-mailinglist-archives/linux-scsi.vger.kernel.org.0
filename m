Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB37A4A56D
	for <lists+linux-scsi@lfdr.de>; Tue, 18 Jun 2019 17:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729754AbfFRPb4 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 18 Jun 2019 11:31:56 -0400
Received: from smtp.infotech.no ([82.134.31.41]:46540 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729189AbfFRPb4 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 18 Jun 2019 11:31:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 9EDDE2041C0;
        Tue, 18 Jun 2019 17:31:53 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pL-vL3TFSVtp; Tue, 18 Jun 2019 17:31:46 +0200 (CEST)
Received: from [192.168.48.23] (host-45-58-224-183.dyn.295.ca [45.58.224.183])
        by smtp.infotech.no (Postfix) with ESMTPA id B8CE4204150;
        Tue, 18 Jun 2019 17:31:44 +0200 (CEST)
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH v1] scsi: Don't select SCSI_PROC_FS by default
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Finn Thain <fthain@telegraphics.com.au>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Martin Petersen <martin.petersen@oracle.com>,
        SCSI <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <2de15293-b9be-4d41-bc67-a69417f27f7a@free.fr>
 <621306ee-7ab6-9cd2-e934-94b3d6d731fc@acm.org>
 <fb2d2e74-6725-4bf2-cf6c-63c0a2a10f4f@interlog.com>
 <alpine.LNX.2.21.1906181107240.287@nippy.intranet>
 <017cf3cf-ecd8-19c2-3bbd-7e7c28042c3c@free.fr>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <f8339103-5b45-b72d-9f87-fd4dd7b3081e@interlog.com>
Date:   Tue, 18 Jun 2019 11:31:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <017cf3cf-ecd8-19c2-3bbd-7e7c28042c3c@free.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2019-06-18 3:29 a.m., Marc Gonzalez wrote:
> On 18/06/2019 03:08, Finn Thain wrote:
> 
>> On Mon, 17 Jun 2019, Douglas Gilbert wrote:
>>
>>> On 2019-06-17 5:11 p.m., Bart Van Assche wrote:
>>>
>>>> On 6/12/19 6:59 AM, Marc Gonzalez wrote:
>>>>
>>>>> According to the option's help message, SCSI_PROC_FS has been
>>>>> superseded for ~15 years. Don't select it by default anymore.
>>>>>
>>>>> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
>>>>> ---
>>>>>    drivers/scsi/Kconfig | 3 ---
>>>>>    1 file changed, 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
>>>>> index 73bce9b6d037..8c95e9ad6470 100644
>>>>> --- a/drivers/scsi/Kconfig
>>>>> +++ b/drivers/scsi/Kconfig
>>>>> @@ -54,14 +54,11 @@ config SCSI_NETLINK
>>>>>    config SCSI_PROC_FS
>>>>>        bool "legacy /proc/scsi/ support"
>>>>>        depends on SCSI && PROC_FS
>>>>> -    default y
>>>>>        ---help---
>>>>>          This option enables support for the various files in
>>>>>          /proc/scsi.  In Linux 2.6 this has been superseded by
>>>>>          files in sysfs but many legacy applications rely on this.
>>>>> -      If unsure say Y.
>>>>> -
>>>>>    comment "SCSI support type (disk, tape, CD-ROM)"
>>>>>        depends on SCSI
>>>>
>>>> Hi Doug,
>>>>
>>>> If I run grep "/proc/scsi" over the sg3_utils source code then grep reports
>>>> 38 matches for that string. Does sg3_utils break with SCSI_PROC_FS=n?
>>>
>>> First, the sg driver. If placing
>>> #undef CONFIG_SCSI_PROC_FS
>>>
>>> prior to the includes in sg.c is a valid way to test that then the
>>> answer is no. Ah, but you are talking about sg3_utils .
>>>
>>> Or are you? For sg3_utils:
>>>
>>> $ find . -name '*.c' -exec grep "/proc/scsi" {} \; -print
>>> static const char * proc_allow_dio = "/proc/scsi/sg/allow_dio";
>>> ./src/sg_read.c
>>> static const char * proc_allow_dio = "/proc/scsi/sg/allow_dio";
>>> ./src/sgp_dd.c
>>> static const char * proc_allow_dio = "/proc/scsi/sg/allow_dio";
>>> ./src/sgm_dd.c
>>> static const char * proc_allow_dio = "/proc/scsi/sg/allow_dio";
>>> ./src/sg_dd.c
>>>                  "'echo 1 > /proc/scsi/sg/allow_dio'\n", q_len, dirio_count);
>>> ./testing/sg_tst_bidi.c
>>> static const char * proc_allow_dio = "/proc/scsi/sg/allow_dio";
>>> ./examples/sgq_dd.c
>>>
>>>
>>> That is 6 (not 38) by my count. Those 6 are all for direct IO
>>> (see below) which is off by default. I suspect old scanning
>>> utilities like sg_scan and sg_map might also use /proc/scsi/* .
>>> That is one reason why I wrote lsscsi. However I can't force folks
>>> to use lsscsi. As a related example, I still get bug reports for
>>> sginfo which I inherited from Eric Youngdale.
>>>
>>> If I was asked to debug a problem with the sg driver in a
>>> system without CONFIG_SCSI_PROC_FS defined, I would decline.
>>>
>>> The absence of /proc/scsi/sg/debug would be my issue. Can this
>>> be set up to do the same thing:
>>>      cat /sys/class/scsi_generic/debug
>>>    Is that breaking any sysfs rules?
>>>
>>>
>>> Also folks who rely on this to work:
>>>     cat /proc/scsi/sg/devices
>>> 0	0	0	0	0	1	255	0	1
>>> 0	0	0	1	0	1	255	0	1
>>> 0	0	0	2	0	1	255	0	1
>>>
>>> would be disappointed. Further I note that setting allow_dio via
>>> /proc/scsi/sg/allow_dio can also be done via /sys/module/sg/allow_dio .
>>> So that would be an interface breakage, but with an alternative.
>>
>> You can grep for /proc/scsi/ across all Debian packages:
>> https://codesearch.debian.net/
>>
>> This reveals that /proc/scsi/sg/ appears in smartmontools and other
>> packages, for example.
> 
> Hello everyone,
> 
> Please note that I am _in no way_ suggesting that we remove any code.
> 
> I just think it might be time to stop forcing CONFIG_SCSI_PROC_FS into
> every config, and instead require one to explicitly request the aging
> feature (which makes CONFIG_SCSI_PROC_FS show up in a defconfig).
> 
> Maybe we could add CONFIG_SCSI_PROC_FS to arch/x86/configs/foo ?
> (For which foo? In a separate patch or squashed with this one?)

Marc,
Since current sg driver usage seems to depend more on SCSI_PROC_FS
being "y" than other parts of the SCSI subsystem then if
SCSI_PROC_FS is to default to "n" in the future then a new
CONFIG_SG_PROC_FS variable could be added.

If CONFIG_CHR_DEV_SG is "*" or "m" then default CONFIG_SG_PROC_FS
to "y"; if CONFIG_SCSI_PROC_FS is "y" then default CONFIG_SG_PROC_FS
to "y"; else default CONFIG_SG_PROC_FS to "n". Obviously the
sg driver would need to be changed to use CONFIG_SG_PROC_FS instead
of CONFIG_SCSI_PROC_FS .


Does that defeat the whole purpose of your proposal or could it be
seen as a partial step in that direction? What is the motivation
for this proposal?

Doug Gilbert


BTW We still have the non-sg related 'cat /proc/scsi/scsi' usage
and 'cat /proc/scsi/device_info'. And I believe the latter one is
writable even though its permissions say otherwise.

