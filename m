Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5303C300C5
	for <lists+linux-scsi@lfdr.de>; Thu, 30 May 2019 19:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfE3ROS (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 30 May 2019 13:14:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:38182 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726280AbfE3ROS (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 30 May 2019 13:14:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6417BACD4;
        Thu, 30 May 2019 17:14:16 +0000 (UTC)
Subject: Re: [PATCH 10/24] scsi: allocate separate queue for reserved commands
To:     John Garry <john.garry@huawei.com>, Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org
References: <20190529132901.27645-1-hare@suse.de>
 <20190529132901.27645-11-hare@suse.de>
 <5537cf59-0138-3553-0896-21b1aaf2fe51@huawei.com>
From:   Hannes Reinecke <hare@suse.com>
Message-ID: <323be693-8280-78ea-8050-8c8d7befdfb9@suse.com>
Date:   Thu, 30 May 2019 19:14:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <5537cf59-0138-3553-0896-21b1aaf2fe51@huawei.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/30/19 5:28 PM, John Garry wrote:
> On 29/05/2019 14:28, Hannes Reinecke wrote:
>> From: Hannes Reinecke <hare@suse.com>
>>
>> Allocate a separate 'reserved_cmd_q' for sending reserved commands.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.com>
>> ---
>>  drivers/scsi/scsi_lib.c  | 15 ++++++++++++++-
>>  include/scsi/scsi_host.h |  4 ++++
>>  2 files changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
>> index e17153a9ce7c..076459853622 100644
>> --- a/drivers/scsi/scsi_lib.c
>> +++ b/drivers/scsi/scsi_lib.c
>> @@ -1831,6 +1831,7 @@ struct request_queue *scsi_mq_alloc_queue(struct 
>> scsi_device *sdev)
>>  int scsi_mq_setup_tags(struct Scsi_Host *shost)
>>  {
>>      unsigned int cmd_size, sgl_size;
>> +    int ret;
>>
>>      sgl_size = scsi_mq_inline_sgl_size(shost);
>>      cmd_size = sizeof(struct scsi_cmnd) + shost->hostt->cmd_size + 
>> sgl_size;
>> @@ -1850,11 +1851,23 @@ int scsi_mq_setup_tags(struct Scsi_Host *shost)
>>          BLK_ALLOC_POLICY_TO_MQ_FLAG(shost->hostt->tag_alloc_policy);
>>      shost->tag_set.driver_data = shost;
>>
>> -    return blk_mq_alloc_tag_set(&shost->tag_set);
>> +    ret = blk_mq_alloc_tag_set(&shost->tag_set);
>> +    if (ret)
>> +        return ret;
>> +
>> +    if (shost->nr_reserved_cmds && shost->use_reserved_cmd_q) {
>> +        shost->reserved_cmd_q = blk_mq_init_queue(&shost->tag_set);
>> +        if (IS_ERR(shost->reserved_cmd_q)) {
>> +            blk_mq_free_tag_set(&shost->tag_set);
>> +            ret = PTR_ERR(shost->reserved_cmd_q);
>> +        }
>> +    }
>> +    return ret;
>>  }
>>
>>  void scsi_mq_destroy_tags(struct Scsi_Host *shost)
>>  {
>> +    blk_cleanup_queue(shost->reserved_cmd_q);
>>      blk_mq_free_tag_set(&shost->tag_set);
>>  }
>>
>> diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
>> index 89998b6bee04..a2bab5f07eff 100644
>> --- a/include/scsi/scsi_host.h
>> +++ b/include/scsi/scsi_host.h
>> @@ -600,6 +600,7 @@ struct Scsi_Host {
>>       * Number of reserved commands, if any.
>>       */
>>      unsigned nr_reserved_cmds;
>> +    struct request_queue *reserved_cmd_q;
>>
>>      unsigned active_mode:2;
>>      unsigned unchecked_isa_dma:1;
>> @@ -637,6 +638,9 @@ struct Scsi_Host {
>>      /* The transport requires the LUN bits NOT to be stored in CDB[1] */
>>      unsigned no_scsi2_lun_in_cdb:1;
>>
>> +    /* Host requires a separate reserved_cmd_q */
>> +    unsigned use_reserved_cmd_q:1;
> 
> Is this really required? I would think that a non-zero value for 
> shost->nr_reserved_cmds means the same thing in practice.
> ;
My implementation actually allows for per-device reserved tags (eg for 
virtio). But some drivers require to use internal commands prior to any 
device setup, so they have to use a separate reserved command queue just 
to be able to allocate tags.

So yes, they are required.

Cheers,

Hannes
