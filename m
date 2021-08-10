Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0BD3E26AE
	for <lists+linux-scsi@lfdr.de>; Fri,  6 Aug 2021 11:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243976AbhHFJBj (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 6 Aug 2021 05:01:39 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3602 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243869AbhHFJBj (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 6 Aug 2021 05:01:39 -0400
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ggzwc4q27z6BCTG;
        Fri,  6 Aug 2021 17:01:04 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 6 Aug 2021 11:01:22 +0200
Received: from [10.47.24.8] (10.47.24.8) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Fri, 6 Aug 2021
 10:01:21 +0100
Subject: Re: [PATCH] scsi: core: Run queue first after running device.
From:   John Garry <john.garry@huawei.com>
To:     <lijinlin3@huawei.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <bvanassche@acm.org>, <qiulaibin@huawei.com>,
        <linfeilong@huawei.com>, <wubo40@huawei.com>
References: <20210805143231.1713299-1-lijinlin3@huawei.com>
 <908bb2bb-c511-06a4-e0b6-577d90bb9b57@huawei.com>
Message-ID: <0d27db3f-4236-4a30-97a0-ad1dcbf4bcfa@huawei.com>
Date:   Fri, 6 Aug 2021 10:00:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <908bb2bb-c511-06a4-e0b6-577d90bb9b57@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.24.8]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 06/08/2021 09:58, John Garry wrote:

And the patch subject is ambiguous

> On 05/08/2021 15:32, lijinlin3@huawei.com wrote:
>> From: Li Jinlin<lijinlin3@huawei.com>
>>
>> We found a hang issue, the test steps are as follows:
>>    1. echo "blocked" >/sys/block/sda/device/state
>>    2. dd if=/dev/sda of=/mnt/t.log bs=1M count=10
>>    3. echo none > /sys/block/sda/queue/scheduler
>>    4. echo "running" >/sys/block/sda/device/state
>>
>> Step3 and Step4 should finish this work after Step4, but them hangs.
>>
>>    CPU#0               CPU#1                CPU#2
>>    ---------------     ----------------     ----------------
>>                                             Step1: blocking device
>>
>>                                             Step2: dd xxxx
>>                                                    ^^^^^^ get request
>>                                                           
>> q_usage_counter++
>>
>>                        Step3: switching scheculer
>>                        elv_iosched_store
>>                          elevator_switch
>>                            blk_mq_freeze_queue
>>                              blk_freeze_queue
>>                                > blk_freeze_queue_start
>>                                  ^^^^^^ mq_freeze_depth++
>>
>>                                > blk_mq_run_hw_queues
>>                                  ^^^^^^ can't run queue when dev blocked
>>
>>                                > blk_mq_freeze_queue_wait
>>                                  ^^^^^^ Hang here!!!
>>                                         wait q_usage_counter==0
>>
>>    Step4: running device
>>    store_state_field
>>      scsi_rescan_device
>>        scsi_attach_vpd
>>          scsi_vpd_inquiry
>>            __scsi_execute
>>              blk_get_request
>>                blk_mq_alloc_request
>>                  blk_queue_enter
>>                  ^^^^^^ Hang here!!!
>>                         wait mq_freeze_depth==0
>>
>>      blk_mq_run_hw_queues
>>      ^^^^^^ dispatch IO, q_usage_counter will reduce to zero
>>
>>                              blk_mq_unfreeze_queue
>>                              ^^^^^ mq_freeze_depth--
>>
>> Step3 and Step4 wait for each other, caused hangs.
>>
>> This requires run queue frist to fix this issue when the device state
> 
> frist ?
> 
>> changes to SDEV_RUNNING.
>>
>> Fixes: f0f82e2476f6 ("scsi: core: Fix capacity set to zero after 
>> offlinining device")
>> Signed-off-by: Li Jinlin<lijinlin3@huawei.com>
>> Signed-off-by: Qiu Laibin<qiulaibin@huawei.com>
>> Signed-off-by: Wu Bo<wubo40@huawei.com>
> 
> what kind of SoB is this?
> 
>> ---
>>   drivers/scsi/scsi_sysfs.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
>> index c3a710bceba0..aa701582c950 100644
>> --- a/drivers/scsi/scsi_sysfs.c
>> +++ b/drivers/scsi/scsi_sysfs.c
>> @@ -809,12 +809,12 @@ store_state_field(struct device *dev, struct 
>> device_attribute *attr,
>>       ret = scsi_device_set_state(sdev, state);
>>       /*
>>        * If the device state changes to SDEV_RUNNING, we need to
>> -     * rescan the device to revalidate it, and run the queue to
>> -     * avoid I/O hang.
>> +     * run the queue to avoid I/O hang, and rescan the device
>> +     * to revalidate it.
> 
> A bit more description of the IO hang would be useful
> 
>>        */
>>       if (ret == 0 && state == SDEV_RUNNING) {
>> -        scsi_rescan_device(dev);
>>           blk_mq_run_hw_queues(sdev->request_queue, true);
>> +        scsi_rescan_device(dev);
> 
> This would not have happened if scsi_rescan_device() was ran outside the 
> mutex lock region, like I suggested originally.
> 
> Indeed, I doubt blk_mq_run_hw_queues() needs to be run with the sdev 
> state_mutex held either.
> 
>>       }
>>       mutex_unlock(&sdev->state_mutex);
>> -- 
> 
> .

