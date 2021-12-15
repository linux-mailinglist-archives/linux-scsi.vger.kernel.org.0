Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C46B4753DF
	for <lists+linux-scsi@lfdr.de>; Wed, 15 Dec 2021 08:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236083AbhLOHq4 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 15 Dec 2021 02:46:56 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:15740 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbhLOHqw (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 15 Dec 2021 02:46:52 -0500
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JDS113kbfzZcfm;
        Wed, 15 Dec 2021 15:43:49 +0800 (CST)
Received: from [127.0.0.1] (10.40.193.166) by dggeme756-chm.china.huawei.com
 (10.3.19.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.20; Wed, 15
 Dec 2021 15:46:48 +0800
Subject: Re: [PATCH 14/15] scsi: libsas: Keep sas host active until finished
 some work
To:     John Garry <john.garry@huawei.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
References: <1637117108-230103-1-git-send-email-chenxiang66@hisilicon.com>
 <1637117108-230103-15-git-send-email-chenxiang66@hisilicon.com>
 <c05f5d30-bc2a-6933-4f27-589242fb84d4@huawei.com>
CC:     <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>
From:   "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <c5125015-4f0b-80dc-c6cb-9fc0c758ef7f@hisilicon.com>
Date:   Wed, 15 Dec 2021 15:46:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <c05f5d30-bc2a-6933-4f27-589242fb84d4@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.193.166]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeme756-chm.china.huawei.com (10.3.19.102)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org



在 2021/12/14 20:34, John Garry 写道:
> Please consider som rewrite:
>
> On 17/11/2021 02:45, chenxiang wrote:
>
> "scsi: libsas: Keep sas host active until finished some work" -> 
> "scsi: libsas: Keep host active while processing events"
>
>> From: Xiang Chen <chenxiang66@hisilicon.com>
>>
>> For those works from event queue, if executing them such as
>> PORTE_BROADCAST_RCVD when sas host is suspended, it will resume sas host
>> firstly as SMP IOs are sent in the process. So phyup will occur and it
>> will call work PORTE_BYTES_DMAED. But the original work (such as
>> PORTE_BROADCAST_RCVD) and the work PORTE_BYTES_DMAED are in the same
>> singlethread workqueue, so the complete of original work waits for
>> the complete of work PORTE_BYTES_DMAED while the complete of work
>> PORTE_BYTES_DMAED wait for the complete of original and it is blocked.
>>
>> So call pm_runtime_get_noresume() to keep sas host active until
>> finished those works.
> Processing events such as PORTE_BROADCAST_RCVD may cause dependency 
> issues for runtime power management support.
>
> Such a problem would be that handling a PORTE_BROADCAST_RCVD event 
> requires that the host is resumed to send SMP commands. However, in 
> resuming the host, the phyup events generated from re-enabling the 
> phys are processed in the same workqueue as the original 
> PORTE_BROADCAST_RCVD event. As such, the host will never finish 
> resuming (as it waits for the phyup event processing), and then the 
> PORTE_BROADCAST_RCVD event cannot be processed as the SMP commands are 
> blocked, and so we have a deadlock.
>
> Solve this problem by ensuring that libsas keeps the host active until 
> completely finished processing phy or port events, such as 
> PORTE_BYTES_DMAED. As such, we don't have to worry about resuming the 
> host for processing individual SMP commands in this example.
>

ok, i will consider to rewrite them.

>>
>> Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
>> Reviewed-by: John Garry <john.garry@huawei.com>
>> ---
>>   drivers/scsi/libsas/sas_event.c | 24 +++++++++++++++++++++---
>>   1 file changed, 21 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/scsi/libsas/sas_event.c 
>> b/drivers/scsi/libsas/sas_event.c
>> index 626ef96b9348..3613b9b315bc 100644
>> --- a/drivers/scsi/libsas/sas_event.c
>> +++ b/drivers/scsi/libsas/sas_event.c
>> @@ -50,8 +50,10 @@ void sas_queue_deferred_work(struct sas_ha_struct 
>> *ha)
>>       list_for_each_entry_safe(sw, _sw, &ha->defer_q, drain_node) {
>>           list_del_init(&sw->drain_node);
>>           ret = sas_queue_work(ha, sw);
>> -        if (ret != 1)
>> +        if (ret != 1) {
>> +            pm_runtime_put(ha->dev);
>> sas_free_event(to_asd_sas_event(&sw->work));
>> +        }
>>       }
>>       spin_unlock_irq(&ha->lock);
>>   }
>> @@ -126,16 +128,22 @@ void sas_enable_revalidation(struct 
>> sas_ha_struct *ha)
>>   static void sas_port_event_worker(struct work_struct *work)
>>   {
>>       struct asd_sas_event *ev = to_asd_sas_event(work);
>> +    struct asd_sas_phy *phy = ev->phy;
>> +    struct sas_ha_struct *ha = phy->ha;
>>         sas_port_event_fns[ev->event](work);
>> +    pm_runtime_put(ha->dev);
>>       sas_free_event(ev);
>>   }
>>     static void sas_phy_event_worker(struct work_struct *work)
>>   {
>>       struct asd_sas_event *ev = to_asd_sas_event(work);
>> +    struct asd_sas_phy *phy = ev->phy;
>> +    struct sas_ha_struct *ha = phy->ha;
>>         sas_phy_event_fns[ev->event](work);
>> +    pm_runtime_put(ha->dev);
>>       sas_free_event(ev);
>>   }
>>   @@ -170,14 +178,19 @@ int sas_notify_port_event(struct asd_sas_phy 
>> *phy, enum port_event event,
>>       if (!ev)
>>           return -ENOMEM;
>>   +    /* Call pm_runtime_put() with pairs in sas_port_event_worker() */
>> +    pm_runtime_get_noresume(ha->dev);
>> +
>>       INIT_SAS_EVENT(ev, sas_port_event_worker, phy, event);
>>         if (sas_defer_event(phy, ev))
>>           return 0;
>>         ret = sas_queue_event(event, &ev->work, ha);
>> -    if (ret != 1)
>> +    if (ret != 1) {
>> +        pm_runtime_put(ha->dev);
>>           sas_free_event(ev);
>> +    }
>>         return ret;
>>   }
>> @@ -196,14 +209,19 @@ int sas_notify_phy_event(struct asd_sas_phy 
>> *phy, enum phy_event event,
>>       if (!ev)
>>           return -ENOMEM;
>>   +    /* Call pm_runtime_put() with pairs in sas_phy_event_worker() */
>> +    pm_runtime_get_noresume(ha->dev);
>> +
>>       INIT_SAS_EVENT(ev, sas_phy_event_worker, phy, event);
>>         if (sas_defer_event(phy, ev))
>>           return 0;
>>         ret = sas_queue_event(event, &ev->work, ha);
>> -    if (ret != 1)
>> +    if (ret != 1) {
>> +        pm_runtime_put(ha->dev);
>>           sas_free_event(ev);
>> +    }
>>         return ret;
>>   }
>>
>
>
> .
>


