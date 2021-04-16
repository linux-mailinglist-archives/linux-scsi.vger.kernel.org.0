Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9F4361B7F
	for <lists+linux-scsi@lfdr.de>; Fri, 16 Apr 2021 10:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbhDPIUN (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 16 Apr 2021 04:20:13 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2869 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbhDPIUM (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 16 Apr 2021 04:20:12 -0400
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FM8BT6V6Qz68BBZ;
        Fri, 16 Apr 2021 16:14:25 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Fri, 16 Apr 2021 10:19:45 +0200
Received: from [10.47.83.179] (10.47.83.179) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 16 Apr
 2021 09:19:44 +0100
Subject: Re: [PATCH] scsi_debug: fix cmd_per_lun, set to max_queue
To:     Ming Lei <ming.lei@redhat.com>
CC:     Douglas Gilbert <dgilbert@interlog.com>,
        <linux-scsi@vger.kernel.org>, <martin.petersen@oracle.com>,
        <jejb@linux.vnet.ibm.com>, <kashyap.desai@broadcom.com>,
        <axboe@kernel.dk>
References: <20210415015031.607153-1-dgilbert@interlog.com>
 <580349dc-0152-8f39-5f3c-be9115e3bf12@huawei.com> <YHjsXaVJJsQXwEPW@T590>
From:   John Garry <john.garry@huawei.com>
Message-ID: <bd33c000-905a-b881-06ea-eef51c77566e@huawei.com>
Date:   Fri, 16 Apr 2021 09:17:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <YHjsXaVJJsQXwEPW@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.83.179]
X-ClientProxiedBy: lhreml727-chm.china.huawei.com (10.201.108.78) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 16/04/2021 02:46, Ming Lei wrote:
>>   	int display_failure_msg = 1, ret;
>>   	struct Scsi_Host *shost = dev_to_shost(starget->dev.parent);
>> +	int depth;
>>
>>   	sdev = kzalloc(sizeof(*sdev) + shost->transportt->device_size,
>>   		       GFP_KERNEL);
>> @@ -276,8 +277,13 @@ static struct scsi_device *scsi_alloc_sdev(struct
>> scsi_target *starget,
>>   	WARN_ON_ONCE(!blk_get_queue(sdev->request_queue));
>>   	sdev->request_queue->queuedata = sdev;
>>
>> -	scsi_change_queue_depth(sdev, sdev->host->cmd_per_lun ?
>> -					sdev->host->cmd_per_lun : 1);
>> +	if (sdev->host->cmd_per_lun)
>> +		depth = min_t(int, sdev->host->cmd_per_lun,
>> +			      sdev->host->can_queue);
>> +	else
>> +		depth = 1;
>> +
>> +	scsi_change_queue_depth(sdev, depth);
> 'cmd_per_lun' should have been set as correct from the beginning instead
> of capping it for changing queue depth:
> 
> diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
> index 697c09ef259b..0d9954eabbb8 100644
> --- a/drivers/scsi/hosts.c
> +++ b/drivers/scsi/hosts.c
> @@ -414,7 +414,7 @@ struct Scsi_Host *scsi_host_alloc(struct scsi_host_template *sht, int privsize)
>   	shost->can_queue = sht->can_queue;
>   	shost->sg_tablesize = sht->sg_tablesize;
>   	shost->sg_prot_tablesize = sht->sg_prot_tablesize;
> -	shost->cmd_per_lun = sht->cmd_per_lun;
> +	shost->cmd_per_lun = min_t(int, sht->cmd_per_lun, shost->can_queue);
>   	shost->no_write_same = sht->no_write_same;
>   	shost->host_tagset = sht->host_tagset;

My concern here is that it is a common pattern in LLDDs to overwrite the 
initial shost member values between scsi_host_alloc() and scsi_add_host().

Thanks,
John
