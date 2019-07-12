Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD0156677A
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jul 2019 09:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbfGLHJ6 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 12 Jul 2019 03:09:58 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56524 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725889AbfGLHJ5 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 12 Jul 2019 03:09:57 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E855770AC2F4937F8316;
        Fri, 12 Jul 2019 15:09:51 +0800 (CST)
Received: from [127.0.0.1] (10.74.223.225) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Fri, 12 Jul 2019
 15:09:46 +0800
Subject: Re: [PATCH v2] scsi: kill useless scsi_use_blk_mq and force_blk_mq
To:     Jason Yan <yanaijie@huawei.com>, <martin.petersen@oracle.com>,
        <jejb@linux.vnet.ibm.com>
CC:     <linux-scsi@vger.kernel.org>
References: <20190604133515.40311-1-yanaijie@huawei.com>
 <eba1acbd-7001-82d9-0661-40a551f01b5e@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <4a67e2d1-60b0-3f38-899d-0877f2691946@huawei.com>
Date:   Fri, 12 Jul 2019 15:09:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <eba1acbd-7001-82d9-0661-40a551f01b5e@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.74.223.225]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

在 09/07/2019 10:06, Jason Yan 写道:
> ping?
> 
> On 2019/6/4 21:35, Jason Yan wrote:
>> The legacy path is gone and we do not have to choose mq or not. The
>> module parameter scsi_use_blk_mq and scsi_host_template.force_blk_mq
>> is useless now.
>>
>> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Reviewed-by: John Garry <john.garry@huawei.com>

>> ---
>>
>> v2: remove force_blk_mq too
>>
>>   drivers/scsi/scsi.c        | 4 ----
>>   drivers/scsi/scsi_priv.h   | 1 -
>>   drivers/scsi/scsi_sysfs.c  | 8 --------
>>   drivers/scsi/virtio_scsi.c | 1 -
>>   include/scsi/scsi_host.h   | 3 ---
>>   5 files changed, 17 deletions(-)
>>
>> diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
>> index 653d5ea6c5d9..7049aabb86e0 100644
>> --- a/drivers/scsi/scsi.c
>> +++ b/drivers/scsi/scsi.c
>> @@ -765,10 +765,6 @@ MODULE_LICENSE("GPL");
>>   module_param(scsi_logging_level, int, S_IRUGO|S_IWUSR);
>>   MODULE_PARM_DESC(scsi_logging_level, "a bit mask of logging levels");
>> -/* This should go away in the future, it doesn't do anything anymore */
>> -bool scsi_use_blk_mq = true;
>> -module_param_named(use_blk_mq, scsi_use_blk_mq, bool, S_IWUSR | 
>> S_IRUGO);
>> -
>>   static int __init init_scsi(void)
>>   {
>>       int error;
>> diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
>> index 5f21547b2ad2..a4f0741524d8 100644
>> --- a/drivers/scsi/scsi_priv.h
>> +++ b/drivers/scsi/scsi_priv.h
>> @@ -29,7 +29,6 @@ extern int scsi_init_hosts(void);
>>   extern void scsi_exit_hosts(void);
>>   /* scsi.c */
>> -extern bool scsi_use_blk_mq;
>>   int scsi_init_sense_cache(struct Scsi_Host *shost);
>>   void scsi_init_command(struct scsi_device *dev, struct scsi_cmnd *cmd);
>>   #ifdef CONFIG_SCSI_LOGGING
>> diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
>> index dbb206c90ecf..403832ee17e0 100644
>> --- a/drivers/scsi/scsi_sysfs.c
>> +++ b/drivers/scsi/scsi_sysfs.c
>> @@ -386,15 +386,7 @@ show_host_busy(struct device *dev, struct 
>> device_attribute *attr, char *buf)
>>   }
>>   static DEVICE_ATTR(host_busy, S_IRUGO, show_host_busy, NULL);
>> -static ssize_t
>> -show_use_blk_mq(struct device *dev, struct device_attribute *attr, 
>> char *buf)
>> -{
>> -    return sprintf(buf, "1\n");
>> -}
>> -static DEVICE_ATTR(use_blk_mq, S_IRUGO, show_use_blk_mq, NULL);
>> -
>>   static struct attribute *scsi_sysfs_shost_attrs[] = {
>> -    &dev_attr_use_blk_mq.attr,
>>       &dev_attr_unique_id.attr,
>>       &dev_attr_host_busy.attr,
>>       &dev_attr_cmd_per_lun.attr,
>> diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
>> index 13f1b3b9923a..f4e3c0310c7d 100644
>> --- a/drivers/scsi/virtio_scsi.c
>> +++ b/drivers/scsi/virtio_scsi.c
>> @@ -687,7 +687,6 @@ static struct scsi_host_template 
>> virtscsi_host_template = {
>>       .dma_boundary = UINT_MAX,
>>       .map_queues = virtscsi_map_queues,
>>       .track_queue_depth = 1,
>> -    .force_blk_mq = 1,
>>   };
>>   #define virtscsi_config_get(vdev, fld) \
>> diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
>> index a5fcdad4a03e..2bf56cdb6195 100644
>> --- a/include/scsi/scsi_host.h
>> +++ b/include/scsi/scsi_host.h
>> @@ -425,9 +425,6 @@ struct scsi_host_template {
>>       /* True if the controller does not support WRITE SAME */
>>       unsigned no_write_same:1;
>> -    /* True if the low-level driver supports blk-mq only */
>> -    unsigned force_blk_mq:1;
>> -
>>       /*
>>        * Countdown for host blocking with no commands outstanding.
>>        */
>>
> 
> 
> .
> 


