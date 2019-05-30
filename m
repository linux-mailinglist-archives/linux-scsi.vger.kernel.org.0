Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 483D02FEAA
	for <lists+linux-scsi@lfdr.de>; Thu, 30 May 2019 16:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfE3O4B (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 30 May 2019 10:56:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:49136 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726512AbfE3O4A (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 30 May 2019 10:56:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7DDE5AEDB;
        Thu, 30 May 2019 14:55:59 +0000 (UTC)
Subject: Re: [PATCH 02/24] scsi: add scsi_{get,put}_reserved_cmd()
To:     Ming Lei <ming.lei@redhat.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>
References: <20190529132901.27645-1-hare@suse.de>
 <20190529132901.27645-3-hare@suse.de> <20190530064101.GA22773@ming.t460p>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <0e8c345e-1fa4-5420-2dc1-26f449b027ca@suse.de>
Date:   Thu, 30 May 2019 16:55:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190530064101.GA22773@ming.t460p>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/30/19 8:41 AM, Ming Lei wrote:
> On Wed, May 29, 2019 at 03:28:39PM +0200, Hannes Reinecke wrote:
>> Add helper functions to retrieve SCSI commands from the reserved
>> tag pool.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.com>
>> ---
>>   include/scsi/scsi_tcq.h | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
>> diff --git a/include/scsi/scsi_tcq.h b/include/scsi/scsi_tcq.h
>> index 6053d46e794e..227f3bd4e974 100644
>> --- a/include/scsi/scsi_tcq.h
>> +++ b/include/scsi/scsi_tcq.h
>> @@ -39,5 +39,27 @@ static inline struct scsi_cmnd *scsi_host_find_tag(struct Scsi_Host *shost,
>>   	return blk_mq_rq_to_pdu(req);
>>   }
>>   
>> +static inline struct scsi_cmnd *scsi_get_reserved_cmd(struct scsi_device *sdev)
>> +{
>> +	struct request *rq;
>> +	struct scsi_cmnd *scmd;
>> +
>> +	rq = blk_mq_alloc_request(sdev->request_queue,
>> +				  REQ_OP_SCSI_OUT | REQ_NOWAIT,
>> +				  BLK_MQ_REQ_RESERVED);
>> +	if (IS_ERR(rq))
>> +		return NULL;
>> +	scmd = blk_mq_rq_to_pdu(rq);
>> +	scmd->request = rq;
>> +	return scmd;
>> +}
> 
> Now all these internal commands won't share tags with IO requests,
> however, your patch switches to reserve slots for internal
> commands.
> 
Yes.

> This way may have performance effect on IO workloads given the
> reserved tags can't be used by IO at all.
> 
Not really. Basically all drivers which have to use tags to send 
internal commands already set some tags aside to handle internal 
commands. So all this patchset does is to formalize this behaviour by 
using private tags.
Some drivers (like fnic or snic) does _not_ do this currently; for those 
I've set one command aside to handle command abort etc.

> Just wondering why not use an new tagset for internal commands?
> 
Because it doesn't help.
All of these drivers have a common tag pool internally, which every 
single command is required to use. So using a new tagset doesn't help 
here; you just would need to split the (hardware) tag pool with no real 
gain.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                              +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
