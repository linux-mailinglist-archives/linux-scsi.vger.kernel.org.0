Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5FA347A1
	for <lists+linux-scsi@lfdr.de>; Tue,  4 Jun 2019 15:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfFDNI0 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 4 Jun 2019 09:08:26 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18082 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727093AbfFDNI0 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 4 Jun 2019 09:08:26 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EB3E13A9168867317365;
        Tue,  4 Jun 2019 21:08:23 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.203) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Tue, 4 Jun 2019
 21:08:17 +0800
Subject: Re: [PATCH] scsi: kill useless scsi_use_blk_mq
To:     John Garry <john.garry@huawei.com>, <martin.petersen@oracle.com>,
        <jejb@linux.vnet.ibm.com>
CC:     <linux-scsi@vger.kernel.org>
References: <20190604114416.26924-1-yanaijie@huawei.com>
 <e2045ba0-2825-3563-c982-6a3acc93e63a@huawei.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <bd6583e4-a847-4d14-9b26-948b80d04bad@huawei.com>
Date:   Tue, 4 Jun 2019 21:08:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <e2045ba0-2825-3563-c982-6a3acc93e63a@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.96.203]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org



On 2019/6/4 20:41, John Garry wrote:
> On 04/06/2019 12:44, Jason Yan wrote:
>> The legacy path is gone and we do not have to choose mq or not. The
>> module parameter scsi_use_blk_mq is useless now.
>>
> 
> Can you look to also remove scsi_host_template.force_blk_mq? It only 
> looks to be set (in virtio_scsi.c) and not read.
> 

OK, I will check that. Thanks.

> cheers
> 
>> Signed-off-by: Jason Yan <yanaijie@huawei.com>
>> ---
>>  drivers/scsi/scsi.c       | 4 ----
>>  drivers/scsi/scsi_priv.h  | 1 -
>>  drivers/scsi/scsi_sysfs.c | 8 --------
>>  3 files changed, 13 deletions(-)
>>
>> diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
>> index 653d5ea6c5d9..7049aabb86e0 100644
>> --- a/drivers/scsi/scsi.c
>> +++ b/drivers/scsi/scsi.c
>> @@ -765,10 +765,6 @@ MODULE_LICENSE("GPL");
>>  module_param(scsi_logging_level, int, S_IRUGO|S_IWUSR);
>>  MODULE_PARM_DESC(scsi_logging_level, "a bit mask of logging levels");
>>
>> -/* This should go away in the future, it doesn't do anything anymore */
>> -bool scsi_use_blk_mq = true;
>> -module_param_named(use_blk_mq, scsi_use_blk_mq, bool, S_IWUSR | 
>> S_IRUGO);
>> -
>>  static int __init init_scsi(void)
>>  {
>>      int error;
>> diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
>> index 5f21547b2ad2..a4f0741524d8 100644
>> --- a/drivers/scsi/scsi_priv.h
>> +++ b/drivers/scsi/scsi_priv.h
>> @@ -29,7 +29,6 @@ extern int scsi_init_hosts(void);
>>  extern void scsi_exit_hosts(void);
>>
>>  /* scsi.c */
>> -extern bool scsi_use_blk_mq;
>>  int scsi_init_sense_cache(struct Scsi_Host *shost);
>>  void scsi_init_command(struct scsi_device *dev, struct scsi_cmnd *cmd);
>>  #ifdef CONFIG_SCSI_LOGGING
>> diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
>> index dbb206c90ecf..403832ee17e0 100644
>> --- a/drivers/scsi/scsi_sysfs.c
>> +++ b/drivers/scsi/scsi_sysfs.c
>> @@ -386,15 +386,7 @@ show_host_busy(struct device *dev, struct 
>> device_attribute *attr, char *buf)
>>  }
>>  static DEVICE_ATTR(host_busy, S_IRUGO, show_host_busy, NULL);
>>
>> -static ssize_t
>> -show_use_blk_mq(struct device *dev, struct device_attribute *attr, 
>> char *buf)
>> -{
>> -    return sprintf(buf, "1\n");
>> -}
>> -static DEVICE_ATTR(use_blk_mq, S_IRUGO, show_use_blk_mq, NULL);
>> -
>>  static struct attribute *scsi_sysfs_shost_attrs[] = {
>> -    &dev_attr_use_blk_mq.attr,
>>      &dev_attr_unique_id.attr,
>>      &dev_attr_host_busy.attr,
>>      &dev_attr_cmd_per_lun.attr,
>>
> 
> 
> 
> .
> 

