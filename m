Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8002FE5F
	for <lists+linux-scsi@lfdr.de>; Thu, 30 May 2019 16:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbfE3Or4 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 30 May 2019 10:47:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:47838 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725897AbfE3Or4 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 30 May 2019 10:47:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 30A53AFB2;
        Thu, 30 May 2019 14:47:54 +0000 (UTC)
Subject: Re: [PATCH 11/24] scsi: add scsi_host_get_reserved_cmd()
To:     Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>
References: <20190529132901.27645-1-hare@suse.de>
 <20190529132901.27645-12-hare@suse.de>
 <25a5a8f5-324b-6b7c-71eb-6cb9f9a60ba8@acm.org>
 <0af75234-7470-acb8-c7ac-10ebaa1e3321@suse.de>
 <0dcf29df-c4c9-0d1c-cd88-972888cd644d@acm.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <381a9e4a-7cee-86d3-6225-5bbab72aae2e@suse.de>
Date:   Thu, 30 May 2019 16:47:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <0dcf29df-c4c9-0d1c-cd88-972888cd644d@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/29/19 9:36 PM, Bart Van Assche wrote:
> On 5/29/19 10:38 AM, Hannes Reinecke wrote:
>> On 5/29/19 5:19 PM, Bart Van Assche wrote:
>>> On 5/29/19 6:28 AM, Hannes Reinecke wrote:
>>>> +    rq = blk_mq_alloc_request(shost->reserved_cmd_q,
>>>> +                  REQ_OP_DRV_OUT | REQ_NOWAIT,
>>>> +                  BLK_MQ_REQ_RESERVED);
>>>
>>> Is your purpose to avoid that blk_mq_alloc_request() waits? If so, 
>>> why do you want to avoid that?
>>>
>> Typically these commands are intended for internal purposes, so there 
>> should always be enough commands free to allow direct allocation.
>> If not we're in an error condition, and we need to return so as not to 
>> lock up the driver (as it might rely on this command to make forward 
>> progress).
> 
> That sounds like a risky strategy to me. blk_mq_alloc_request() can 
> block for a number of reasons, e.g. because a request queue due to e.g. 
> CPU hotplugging. I don't think that you want 
> scsi_host_get_reserved_cmd() or scsi_get_reserved_cmd() to fail if a 
> request queue is frozen.
> 
Au contraire.
These commands are intended for driver internals (like sending TMFs 
etc). Drivers can handle a failure here pretty well, as then the driver 
will just escalate things internally. A stall, OTOH, would lock up the 
entire driver.
Think of Task Abort TMF: it's okay (and actually expected) for the TMF 
to fail; the driver will just escalate things internally.
It is, however, _not_ okay to stall for that command to become available 
(eg if all tags are used up, and we now have to start aborting 
commands), as this will stall or even live-lock the entire driver.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                              +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
