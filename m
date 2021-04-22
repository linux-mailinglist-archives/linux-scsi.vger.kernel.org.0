Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B313679F7
	for <lists+linux-scsi@lfdr.de>; Thu, 22 Apr 2021 08:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234823AbhDVGcS (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 22 Apr 2021 02:32:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:43868 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229967AbhDVGcR (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 22 Apr 2021 02:32:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AA872B008;
        Thu, 22 Apr 2021 06:31:42 +0000 (UTC)
Subject: Re: [PATCH 07/42] scsi: Kill DRIVER_SENSE
To:     Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org
References: <20210421174749.11221-1-hare@suse.de>
 <20210421174749.11221-8-hare@suse.de>
 <b365b179-c82c-57fc-1b4c-32bfbe003672@acm.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <df94d8e2-67de-f613-3a89-2754aaad4038@suse.de>
Date:   Thu, 22 Apr 2021 08:31:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <b365b179-c82c-57fc-1b4c-32bfbe003672@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 4/21/21 11:06 PM, Bart Van Assche wrote:
> On 4/21/21 10:47 AM, Hannes Reinecke wrote:
>> diff --git a/drivers/scsi/megaraid/megaraid_mbox.c 
>> b/drivers/scsi/megaraid/megaraid_mbox.c
>> index 6a5b844a8499..2b6138a7c71f 100644
>> --- a/drivers/scsi/megaraid/megaraid_mbox.c
>> +++ b/drivers/scsi/megaraid/megaraid_mbox.c
>> @@ -2299,8 +2299,7 @@ megaraid_mbox_dpc(unsigned long devp)
>>                   memcpy(scp->sense_buffer, pthru->reqsensearea,
>>                           14);
>> -                scp->result = DRIVER_SENSE << 24 |
>> -                    DID_OK << 16 | CHECK_CONDITION << 1;
>> +                scp->result = DID_OK << 16 | SAM_STAT_CHECK_CONDITION;
>>               }
>>               else {
>>                   if (mbox->cmd == MBOXCMD_EXTPTHRU) {
>> @@ -2308,9 +2307,8 @@ megaraid_mbox_dpc(unsigned long devp)
>>                       memcpy(scp->sense_buffer,
>>                           epthru->reqsensearea, 14);
>> -                    scp->result = DRIVER_SENSE << 24 |
>> -                        DID_OK << 16 |
>> -                        CHECK_CONDITION << 1;
>> +                    scp->result = DID_OK << 16 |
>> +                        SAM_STAT_CHECK_CONDITION;
>>                   } else
>>                       scsi_build_sense(scp, 0,
>>                                ABORTED_COMMAND, 0, 0);
> 
> Since DID_OK == 0 I prefer to leave out the 'DID_OK << 16' expressions 
> from code that is modified.
> 
Okay, will do.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
