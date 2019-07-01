Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98C4A23CA0
	for <lists+linux-scsi@lfdr.de>; Mon, 20 May 2019 17:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389021AbfETP4C (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 20 May 2019 11:56:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:25309 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389005AbfETP4C (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 20 May 2019 11:56:02 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1549785365;
        Mon, 20 May 2019 15:56:02 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9437F27C4B;
        Mon, 20 May 2019 15:56:01 +0000 (UTC)
Subject: Re: [PATCH] scsi: ses: Fix out-of-bounds memory access in
 ses_enclosure_data_process()
To:     James Bottomley <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190501180535.26718-1-longman@redhat.com>
 <1fd39969-4413-2f11-86b2-729787680efa@redhat.com>
 <1558363938.3742.1.camel@linux.ibm.com>
 <3385cf54-7b6c-3f28-e037-f0d4037368eb@redhat.com>
 <1558367212.3742.10.camel@linux.ibm.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <8080a1ae-027e-ecdb-d8f1-5786a6b8853b@redhat.com>
Date:   Mon, 20 May 2019 11:56:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1558367212.3742.10.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 20 May 2019 15:56:02 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/20/19 11:46 AM, James Bottomley wrote:
> On Mon, 2019-05-20 at 11:24 -0400, Waiman Long wrote:
>> On 5/20/19 10:52 AM, James Bottomley wrote:
>>> On Mon, 2019-05-20 at 10:41 -0400, Waiman Long wrote:
>>> [...]
>>>>> --- a/drivers/scsi/ses.c
>>>>> +++ b/drivers/scsi/ses.c
>>>>> @@ -605,9 +605,14 @@ static void
>>>>> ses_enclosure_data_process(struct
>>>>> enclosure_device *edev,
>>>>>  			     /* these elements are optional */
>>>>>  			     type_ptr[0] ==
>>>>> ENCLOSURE_COMPONENT_SCSI_TARGET_PORT ||
>>>>>  			     type_ptr[0] ==
>>>>> ENCLOSURE_COMPONENT_SCSI_INITIATOR_PORT ||
>>>>> -			     type_ptr[0] ==
>>>>> ENCLOSURE_COMPONENT_CONTROLLER_ELECTRONICS))
>>>>> +			     type_ptr[0] ==
>>>>> ENCLOSURE_COMPONENT_CONTROLLER_ELECTRONICS)) {
>>>>>  				addl_desc_ptr +=
>>>>> addl_desc_ptr[1]
>>>>> + 2;
>>>>>  
>>>>> +				/* Ensure no out-of-bounds
>>>>> memory
>>>>> access */
>>>>> +				if (addl_desc_ptr >= ses_dev-
>>>>>> page10 +
>>>>> +						     ses_dev-
>>>>>> page10_len)
>>>>> +					addl_desc_ptr = NULL;
>>>>> +			}
>>>>>  		}
>>>>>  	}
>>>>>  	kfree(buf);
>>>> Ping! Any comment on this patch.
>>> The update looks fine to me:
>>>
>>> Reviewed-by: James E.J. Bottomley <jejb@linux.ibm.com>
>>>
>>> It might also be interesting to find out how the proliant is
>>> structuring this descriptor array to precipitate the out of bounds:
>>> Is it just an off by one or something more serious?
>> I didn't look into the detail the enclosure message returned by the
>> hardware, but I believe it may have more description entries (page7)
>> than extended description entries (page10).
>>
>> I can try to reserve the system and find out what exactly is wrong
>> with that system if you really want to find that out.
> Please.  What I'm interested in is whether this is simply a bug in the
> array firmware, in which case the fix is sufficient, or whether there's
> some problem with the parser, like mismatched expectations over added
> trailing nulls or something.
>
> James
>
OK, will let you know once I get hold of the system.

Cheers,
Longman

