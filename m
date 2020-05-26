Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD0A21CF34D
	for <lists+linux-scsi@lfdr.de>; Tue, 12 May 2020 13:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgELL3T (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 12 May 2020 07:29:19 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50976 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727783AbgELL3T (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 12 May 2020 07:29:19 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 74653CD34FBF50A68C75;
        Tue, 12 May 2020 19:29:17 +0800 (CST)
Received: from [127.0.0.1] (10.166.213.7) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Tue, 12 May 2020
 19:29:07 +0800
Subject: Re: [PATCH] scsi: hisi_sas: display correct proc_name in sysfs
To:     John Garry <john.garry@huawei.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Xiang Chen <chenxiang66@hisilicon.com>
References: <20200512063318.13825-1-yanaijie@huawei.com>
 <66c3318d-e8fa-9ff4-c7f4-ebe23925b807@huawei.com>
 <dacd7cbe-3d84-2b35-e63a-af6179aa5221@huawei.com>
 <920c5d36-5637-1fba-034b-8ea3d41c131c@huawei.com>
 <1043f72a-7f4c-eb5c-eeb2-227f5321fed5@huawei.com>
 <a0ff79dd-d00e-a938-39c2-0ab281c7f795@huawei.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <628c3185-e120-53c9-9971-1eecf9c097f9@huawei.com>
Date:   Tue, 12 May 2020 19:29:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <a0ff79dd-d00e-a938-39c2-0ab281c7f795@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.166.213.7]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


在 2020/5/12 19:07, John Garry 写道:
> On 12/05/2020 11:30, Jason Yan wrote:
>>
>>
>> 在 2020/5/12 18:00, John Garry 写道:
>>> On 12/05/2020 10:35, Jason Yan wrote:
>>>>
>>>>
>>>> 在 2020/5/12 16:23, John Garry 写道:
>>>>> On 12/05/2020 07:33, Jason Yan wrote:
>>>>>> The 'proc_name' entry in sysfs for hisi_sas is 'null' now becuase 
>>>>>> it is
>>>>>> not initialized in scsi_host_template. It looks like:
>>>>>>
>>>>>> [root@localhost ~]# cat /sys/class/scsi_host/host2/proc_name
>>>>>> (null)
>>>>>>
>>>>>
>>>>> hmmm.. it would be good to tell us what this buys us, apart from 
>>>>> the proc_name file.
>>>>>
>>>>
>>>> When there is more than one storage cards(or controllers) in the 
>>>> system, I'm tring to find out which host is belong to which card. 
>>>> And then I found this in scsi_host in sysfs but the output is 
>>>> '(null)' which is odd.
>>>
>>> "dmesg | grep host" would give this info, like:
>>>
>>> root@(none)$ dmesg | grep host0
>>> [    8.877245] scsi host0: hisi_sas_v2_hw
>>>
>>
>> NO, if long time after the system boot, dmesg cannot get this 
>> infomation. It is flushed by other logs.
> 
> 
> ok, so I don't see any other way to currently do this, even though using 
> proc_name is a bit suspect, so:
> 
> Acked-by: John Garry <john.garry@huawei.com>
> 
> And the $subject is not right. It should be simply "display proc_name in 
> sysfs".
> 

Thanks, will send v2 with right $subject.

Jason

> Thanks,
> John
> 
> .

