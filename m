Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1461AFE74
	for <lists+linux-scsi@lfdr.de>; Sun, 19 Apr 2020 23:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgDSVxr (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 19 Apr 2020 17:53:47 -0400
Received: from smtp.infotech.no ([82.134.31.41]:35729 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbgDSVxr (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 19 Apr 2020 17:53:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 7DC50204164;
        Sun, 19 Apr 2020 23:53:45 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gT99j1gy38dS; Sun, 19 Apr 2020 23:53:39 +0200 (CEST)
Received: from [192.168.48.23] (host-23-251-188-50.dyn.295.ca [23.251.188.50])
        by smtp.infotech.no (Postfix) with ESMTPA id BD519204150;
        Sun, 19 Apr 2020 23:53:38 +0200 (CEST)
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH v4 06/14] scsi_debug: implement pre-fetch commands
To:     Julian Wiedmann <jwi@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, jejb@linux.vnet.ibm.com, hare@suse.de,
        Damien.LeMoal@wdc.com
References: <20200225062351.21267-1-dgilbert@interlog.com>
 <20200225062351.21267-7-dgilbert@interlog.com> <yq1eesrvvrk.fsf@oracle.com>
 <045764e7-277c-d81c-9e73-dc9fa9ab22b5@interlog.com>
 <aac5d33f-5280-3660-8059-e3a154f29979@linux.ibm.com>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <7e423d1f-5c9e-c040-583e-494ba385b803@interlog.com>
Date:   Sun, 19 Apr 2020 17:53:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <aac5d33f-5280-3660-8059-e3a154f29979@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2020-04-19 2:22 p.m., Julian Wiedmann wrote:
> On 19.04.20 20:01, Douglas Gilbert wrote:
>> On 2020-04-13 6:57 p.m., Martin K. Petersen wrote:
>>>
>>> Doug,
>>>
>>>> Many disks implement the SCSI PRE-FETCH commands. One use case might
>>>> be a disk-to-disk compare, say between disks A and B.  Then this
>>>> sequence of commands might be used: PRE-FETCH(from B, IMMED),
>>>> READ(from A), VERIFY (BYTCHK=1 on B with data returned from READ). The
>>>> PRE-FETCH (which returns quickly due to the IMMED) fetches the data
>>>> from the media into B's cache which should speed the trailing VERIFY
>>>> command.  The next chunk of the compare might be done in parallel,
>>>> with A and B reversed.
>>>
>>> Minor nit: I agree with the code and the use case. But the commit
>>> description should reflect what the code actually does (not much in the
>>> absence of cache, etc.)
>>
>> On reflection, there is no reason why the implementation of PRE-FETCH
>> for a scsi_debug ramdisk can't do what it implies. IOWs get those blocks
>> into (say) the machine's L3 cache. This is to speed a following
>> VERIFY(BYTCHK=1) [or NVMe Compare ***] that will use those blocks. The
>> question is, how?
>>
>> I have added this to resp_pre_fetch():
>>     memcpm(ramdisk_ptr, ramdisk_ptr, num_blks*blk_sz);
>>
>> Will that be optimized out? If so, is there a better/faster way to
>> encourage a machine to populate its cache?
>>
> 
> Have a look at prefetch_range() ?

Perfect.


