Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4396D5481B0
	for <lists+linux-scsi@lfdr.de>; Mon, 13 Jun 2022 10:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239853AbiFMIWf (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 13 Jun 2022 04:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239307AbiFMIWc (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 13 Jun 2022 04:22:32 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE1F1836D;
        Mon, 13 Jun 2022 01:22:31 -0700 (PDT)
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LM4Jq1L7Mz689JV;
        Mon, 13 Jun 2022 16:20:59 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Mon, 13 Jun 2022 10:22:28 +0200
Received: from [10.195.33.253] (10.195.33.253) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 09:22:27 +0100
Message-ID: <7f80f3b6-84f6-de48-4e69-4562c96e62c5@huawei.com>
Date:   Mon, 13 Jun 2022 09:25:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH RFC v2 03/18] scsi: core: Implement reserved command
 handling
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <axboe@kernel.dk>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <brking@us.ibm.com>, <hare@suse.de>,
        <hch@lst.de>
CC:     <linux-block@vger.kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <chenxiang66@hisilicon.com>
References: <1654770559-101375-1-git-send-email-john.garry@huawei.com>
 <1654770559-101375-4-git-send-email-john.garry@huawei.com>
 <b4a0ede5-95a3-4388-e808-7627b5484d01@opensource.wdc.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <b4a0ede5-95a3-4388-e808-7627b5484d01@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.33.253]
X-ClientProxiedBy: lhreml746-chm.china.huawei.com (10.201.108.196) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 13/06/2022 08:01, Damien Le Moal wrote:
> On 6/9/22 19:29, John Garry wrote:
>> From: Hannes Reinecke <hare@suse.de>
>>
>> Quite some drivers are using management commands internally, which
>> typically use the same hardware tag pool (ie they are being allocated
>> from the same hardware resources) as the 'normal' I/O commands.
>> These commands are set aside before allocating the block-mq tag bitmap,
>> so they'll never show up as busy in the tag map.
>> The block-layer, OTOH, already has 'reserved_tags' to handle precisely
>> this situation.
>> So this patch adds a new field 'nr_reserved_cmds' to the SCSI host
>> template to instruct the block layer to set aside a tag space for these
>> management commands by using reserved tags.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>> ---
>>   drivers/scsi/hosts.c     |  3 +++
>>   drivers/scsi/scsi_lib.c  |  6 +++++-
>>   include/scsi/scsi_host.h | 22 +++++++++++++++++++++-
>>   3 files changed, 29 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
>> index 8352f90d997d..27296addaf63 100644
>> --- a/drivers/scsi/hosts.c
>> +++ b/drivers/scsi/hosts.c
>> @@ -474,6 +474,9 @@ struct Scsi_Host *scsi_host_alloc(struct scsi_host_template *sht, int privsize)
>>   	if (sht->virt_boundary_mask)
>>   		shost->virt_boundary_mask = sht->virt_boundary_mask;
>>   
>> +	if (sht->nr_reserved_cmds)
>> +		shost->nr_reserved_cmds = sht->nr_reserved_cmds;
>> +
>>   	device_initialize(&shost->shost_gendev);
>>   	dev_set_name(&shost->shost_gendev, "host%d", shost->host_no);
>>   	shost->shost_gendev.bus = &scsi_bus_type;
>> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
>> index 6ffc9e4258a8..f6e53c6d913c 100644
>> --- a/drivers/scsi/scsi_lib.c
>> +++ b/drivers/scsi/scsi_lib.c
>> @@ -1974,8 +1974,12 @@ int scsi_mq_setup_tags(struct Scsi_Host *shost)
>>   	else
>>   		tag_set->ops = &scsi_mq_ops_no_commit;
>>   	tag_set->nr_hw_queues = shost->nr_hw_queues ? : 1;
>> +
>>   	tag_set->nr_maps = shost->nr_maps ? : 1;
>> -	tag_set->queue_depth = shost->can_queue;
>> +	tag_set->queue_depth =
>> +		shost->can_queue + shost->nr_reserved_cmds;
>> +	tag_set->reserved_tags = shost->nr_reserved_cmds;
>> +
>>   	tag_set->cmd_size = cmd_size;
>>   	tag_set->numa_node = dev_to_node(shost->dma_dev);
>>   	tag_set->flags = BLK_MQ_F_SHOULD_MERGE;
>> diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
>> index 59aef1f178f5..149dcbd4125e 100644
>> --- a/include/scsi/scsi_host.h
>> +++ b/include/scsi/scsi_host.h
>> @@ -366,10 +366,19 @@ struct scsi_host_template {
>>   	/*
>>   	 * This determines if we will use a non-interrupt driven
>>   	 * or an interrupt driven scheme.  It is set to the maximum number
>> -	 * of simultaneous commands a single hw queue in HBA will accept.
>> +	 * of simultaneous commands a single hw queue in HBA will accept
>> +	 * excluding internal commands.
>>   	 */
>>   	int can_queue;
>>   
>> +	/*
>> +	 * This determines how many commands the HBA will set aside
>> +	 * for internal commands. This number will be added to
>> +	 * @can_queue to calcumate the maximum number of simultaneous
> 

Hi Damien,

> s/calcumate/calculate
> 
> But this is weird. For SATA, can_queue is 32. Having reserved commands,
> that number needs to stay the same. 

It does.

> We cannot have more than 32 tags.

We may have 32 regular tags and 1 reserved tag for SATA.

> I think keeping can_queue as the max queue depth with at most
> nr_reserved_cmds tags reserved is better.

Maybe the wording in the comment can be improved as it originally 
focused on SAS HBAs where there are no special rules for tagset depth or 
how the tagset should be carved up to handle regular and reserved commands.

Thanks,
John

> 
>> +	 * commands sent to the host.
>> +	 */
>> +	int nr_reserved_cmds;
>> +
>>   	/*
>>   	 * In many instances, especially where disconnect / reconnect are
>>   	 * supported, our host also has an ID on the SCSI bus.  If this is
>> @@ -602,6 +611,11 @@ struct Scsi_Host {
>>   	unsigned short max_cmd_len;
>>   
>>   	int this_id;
>> +
>> +	/*
>> +	 * Number of commands this host can handle at the same time.
>> +	 * This excludes reserved commands as specified by nr_reserved_cmds.
>> +	 */
>>   	int can_queue;
>>   	short cmd_per_lun;
>>   	short unsigned int sg_tablesize;
>> @@ -620,6 +634,12 @@ struct Scsi_Host {
>>   	 */
>>   	unsigned nr_hw_queues;
>>   	unsigned nr_maps;
>> +
>> +	/*
>> +	 * Number of reserved commands to allocate, if any.
>> +	 */
>> +	unsigned nr_reserved_cmds;
>> +
>>   	unsigned active_mode:2;
>>   
>>   	/*
> 
> 

