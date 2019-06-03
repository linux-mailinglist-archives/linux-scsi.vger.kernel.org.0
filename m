Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E376933482
	for <lists+linux-scsi@lfdr.de>; Mon,  3 Jun 2019 18:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbfFCQEo (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 3 Jun 2019 12:04:44 -0400
Received: from smtp.infotech.no ([82.134.31.41]:47814 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727664AbfFCQEn (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 3 Jun 2019 12:04:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 37EDB2041B2;
        Mon,  3 Jun 2019 18:04:42 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tnTBbhtca47q; Mon,  3 Jun 2019 18:04:40 +0200 (CEST)
Received: from [192.168.48.23] (host-45-58-224-183.dyn.295.ca [45.58.224.183])
        by smtp.infotech.no (Postfix) with ESMTPA id 968E020415B;
        Mon,  3 Jun 2019 18:04:39 +0200 (CEST)
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH 01/19] sg: move functions around
To:     Bart Van Assche <bvanassche@acm.org>, linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        bart.vanassche@wdc.com, Arnd Bergmann <arnd@arndb.de>
References: <20190524184809.25121-1-dgilbert@interlog.com>
 <20190524184809.25121-2-dgilbert@interlog.com>
 <f67f3eef-bb0e-2211-9b3a-6628227e76b0@acm.org>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <21cf4296-f59d-fcf3-bdb4-a4da440593e0@interlog.com>
Date:   Mon, 3 Jun 2019 12:04:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <f67f3eef-bb0e-2211-9b3a-6628227e76b0@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2019-05-26 11:46 a.m., Bart Van Assche wrote:
> On 5/24/19 11:47 AM, Douglas Gilbert wrote:
>> Move code around so it has the basic ordering: open(), close(),
>> write(), read(), ioctl(), other system calls (e.g. mmap()),
>> support code and finally debug code. The change was to put the
>> write() associated code before the read() code. The write()
>> system call is associated with submitting SCSI commands (i.e.
>> writing metadata to the device).  The read() system call is
>> associated with receiving the responses of earlier submitted
>> commands.
>>
>> Helper functions are often placed above their caller to reduce
>> the number of forward function declarations needed.
> 
> Moving helper functions in front of their caller is useful but random
> reordering of functions not. Such a random reordering of code pollutes
> the git history. Please don't do that.

Another reviewer accepted that open,close,submit,receive was a more
logical order than what was there previously. He suggested containing
the moves in a single patch within the patchset. It seemed best to
do that first, hence this patch (i.e. 1/19).

Over time, patches by others have blurred what started as a
coherent ordering of functions, IMO. There needs to be a way to
re-mediate that. git could have better ways of notating that
a function has moved within a source file, or to another file.
There is a drastic alternative: two patches, one to remove the
driver, another to add the rewrite.


Please rephrase artless expressions like:
   - "What makes you think that ...", (in another post) and
   - "random reordering of code pollutes"

and use more professional language. Thanks.

Douglas Gilbert
