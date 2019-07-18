Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2473B6D3AE
	for <lists+linux-scsi@lfdr.de>; Thu, 18 Jul 2019 20:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391154AbfGRSS1 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 18 Jul 2019 14:18:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42268 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391148AbfGRSS0 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 18 Jul 2019 14:18:26 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 30D0C317916D;
        Thu, 18 Jul 2019 18:18:26 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-160.bos.redhat.com [10.18.17.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B2DA41001B35;
        Thu, 18 Jul 2019 18:18:25 +0000 (UTC)
Subject: Re: [PATCH] scsi: ses: Fix out-of-bounds memory access in
 ses_enclosure_data_process()
To:     James Bottomley <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190501180535.26718-1-longman@redhat.com>
 <1fd39969-4413-2f11-86b2-729787680efa@redhat.com>
 <1558363938.3742.1.camel@linux.ibm.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <729b0751-01a6-7c0b-ce0d-f19807b59dee@redhat.com>
Date:   Thu, 18 Jul 2019 14:18:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1558363938.3742.1.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 18 Jul 2019 18:18:26 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/20/19 10:52 AM, James Bottomley wrote:
> On Mon, 2019-05-20 at 10:41 -0400, Waiman Long wrote:
> [...]
>>> --- a/drivers/scsi/ses.c
>>> +++ b/drivers/scsi/ses.c
>>> @@ -605,9 +605,14 @@ static void ses_enclosure_data_process(struct
>>> enclosure_device *edev,
>>>  			     /* these elements are optional */
>>>  			     type_ptr[0] ==
>>> ENCLOSURE_COMPONENT_SCSI_TARGET_PORT ||
>>>  			     type_ptr[0] ==
>>> ENCLOSURE_COMPONENT_SCSI_INITIATOR_PORT ||
>>> -			     type_ptr[0] ==
>>> ENCLOSURE_COMPONENT_CONTROLLER_ELECTRONICS))
>>> +			     type_ptr[0] ==
>>> ENCLOSURE_COMPONENT_CONTROLLER_ELECTRONICS)) {
>>>  				addl_desc_ptr += addl_desc_ptr[1]
>>> + 2;
>>>  
>>> +				/* Ensure no out-of-bounds memory
>>> access */
>>> +				if (addl_desc_ptr >= ses_dev-
>>>> page10 +
>>> +						     ses_dev-
>>>> page10_len)
>>> +					addl_desc_ptr = NULL;
>>> +			}
>>>  		}
>>>  	}
>>>  	kfree(buf);
>> Ping! Any comment on this patch.
> The update looks fine to me:
>
> Reviewed-by: James E.J. Bottomley <jejb@linux.ibm.com>
>
> It might also be interesting to find out how the proliant is
> structuring this descriptor array to precipitate the out of bounds: Is
> it just an off by one or something more serious?
>
> James
>
Is someone going to merge this patch in the current cycle?

Thanks,
Longman

