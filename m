Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E94702FEB3
	for <lists+linux-scsi@lfdr.de>; Thu, 30 May 2019 16:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfE3O76 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 30 May 2019 10:59:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:49734 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725897AbfE3O75 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 30 May 2019 10:59:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 85553AEDB;
        Thu, 30 May 2019 14:59:56 +0000 (UTC)
Subject: Re: [PATCH 03/24] scsi: add 'nr_reserved_cmds' field to the SCSI host
 template
To:     John Garry <john.garry@huawei.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>
References: <20190529132901.27645-1-hare@suse.de>
 <20190529132901.27645-4-hare@suse.de>
 <255f2a10-c79c-06a4-d94a-53cf19b17bf3@huawei.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <45b14b10-8295-b9d7-29f5-31aa64c0ea4f@suse.de>
Date:   Thu, 30 May 2019 16:59:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <255f2a10-c79c-06a4-d94a-53cf19b17bf3@huawei.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/30/19 2:51 PM, John Garry wrote:
> On 29/05/2019 14:28, Hannes Reinecke wrote:
>> From: Hannes Reinecke <hare@suse.com>
>>
>> Add a new field 'nr_reserved_cmds' to the SCSI host template to
>> instruct the block layer to set aside a tag space for reserved
>> commands.
>>
> 
> Out of curiousity, is there a reason why this would not also be added to 
> scsi_host_template?
> 
None, really. I just didn't do it :-)\

>> Signed-off-by: Hannes Reinecke <hare@suse.com>
>> ---
>>  drivers/scsi/scsi_lib.c  | 1 +
>>  include/scsi/scsi_host.h | 6 ++++++
>>  2 files changed, 7 insertions(+)
>>
>> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
>> index 34eaef631064..e17153a9ce7c 100644
>> --- a/drivers/scsi/scsi_lib.c
>> +++ b/drivers/scsi/scsi_lib.c
>> @@ -1842,6 +1842,7 @@ int scsi_mq_setup_tags(struct Scsi_Host *shost)
>>      shost->tag_set.ops = &scsi_mq_ops;
>>      shost->tag_set.nr_hw_queues = shost->nr_hw_queues ? : 1;
>>      shost->tag_set.queue_depth = shost->can_queue;
>> +    shost->tag_set.reserved_tags = shost->nr_reserved_cmds;
>>      shost->tag_set.cmd_size = cmd_size;
>>      shost->tag_set.numa_node = NUMA_NO_NODE;
>>      shost->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
>> diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
>> index a5fcdad4a03e..b094e17ef2d4 100644
>> --- a/include/scsi/scsi_host.h
>> +++ b/include/scsi/scsi_host.h
>> @@ -595,6 +595,12 @@ struct Scsi_Host {
>>       * is nr_hw_queues * can_queue.
>>       */
>>      unsigned nr_hw_queues;
>> +
>> +    /*
>> +     * Number of reserved commands, if any.
>> +     */
> 
> nit: I would write, "Number of commands to reserve, if any"
> 
Ok.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                              +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
