Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC1E229502
	for <lists+linux-scsi@lfdr.de>; Wed, 22 Jul 2020 11:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgGVJej (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 22 Jul 2020 05:34:39 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2505 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727819AbgGVJei (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 22 Jul 2020 05:34:38 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 6FE4675AE90AF695EA1C;
        Wed, 22 Jul 2020 10:34:36 +0100 (IST)
Received: from [127.0.0.1] (10.47.1.221) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 22 Jul
 2020 10:34:35 +0100
Subject: Re: [PATCH RFC v7 10/12] megaraid_sas: switch fusion adapters to MQ
To:     Ming Lei <ming.lei@redhat.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>
CC:     <axboe@kernel.dk>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <don.brace@microsemi.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>, <bvanassche@acm.org>,
        <hare@suse.com>, <hch@lst.de>,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>,
        <linux-block@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <esc.storagedev@microsemi.com>, <chenxiang66@hisilicon.com>,
        "PDL,MEGARAIDLINUX" <megaraidlinux.pdl@broadcom.com>
References: <61299951-97dc-b2be-c66c-024dfbd3a1cb@huawei.com>
 <b49c33ebda36b8f116a51bc5c430eb9d@mail.gmail.com>
 <13d6b63e-3aa8-68fa-29ab-a4c202024280@huawei.com>
 <34a832717fef4702b143ea21aa12b79e@mail.gmail.com>
 <1dcf2bb9-142c-7bb8-9207-5a1b792eb3f9@huawei.com>
 <e69dc243174664efd414a4cd0176e59d@mail.gmail.com>
 <20200721011323.GA833377@T590>
 <c71bbdf2607a8183926430b5f4aa1ae1@mail.gmail.com>
 <20200722041201.GA912316@T590>
 <f6f05483491c391ce79486b8fb78cb2e@mail.gmail.com>
 <20200722080409.GB912316@T590>
From:   John Garry <john.garry@huawei.com>
Message-ID: <fe7a7acf-d62b-d541-4203-29c1d0403c2a@huawei.com>
Date:   Wed, 22 Jul 2020 10:32:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200722080409.GB912316@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.1.221]
X-ClientProxiedBy: lhreml729-chm.china.huawei.com (10.201.108.80) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

>>>>>>
>>>>>> diff --git a/block/blk-mq.c b/block/blk-mq.c index
>>>>>> 1be7ac5a4040..b6a5b41b7fc2 100644
>>>>>> --- a/block/blk-mq.c
>>>>>> +++ b/block/blk-mq.c
>>>>>> @@ -1559,6 +1559,9 @@ void blk_mq_run_hw_queues(struct
>>>>> request_queue
>>>>>> *q, bool async)
>>>>>>          struct blk_mq_hw_ctx *hctx;
>>>>>>          int i;
>>>>>>
>>>>>> +       if (!q->elevator)
>>>>>> +               return;
>>>>>> +
>>>>> This way shouldn't be correct, blk_mq_run_hw_queues() is still
>>>>> needed

Could the logic of blk_mq_run_hw_queue() -> blk_mq_hctx_has_pending() -> 
sbitmap_any_bit_set(&hctx->ctx_map) be optimised for megaraid scenario?

As I see, since megaraid will have 1:1 mapping of CPU to hw queue, will 
there only ever possibly a single bit set in ctx_map? If so, it seems a 
waste to always check every sbitmap map. But adding logic for this may 
negate any possible gains.

>>>> for
>>>>> none because request may not be dispatched successfully by direct
>> issue.
>>>> When block layer attempt posting request to h/w queue directly (for
>>>> ioscheduler=none) and if it fails, it is calling
>>>> blk_mq_request_bypass_insert().
>>>> blk_mq_request_bypass_insert function will start the h/w queue from
>>>> submission context. Do we still have an issue if we skip running hw
>>>> queue from completion ?
>>> The thing is that we can't guarantee that direct issue or adding request
>> into
>>> hctx->dispatch is always done for MQ/none, for example, request still
>>> can be added to sw queue from blk_mq_flush_plug_list() when mq plug is
>>> applied.
>> I see even blk_mq_sched_insert_requests() from blk_mq_flush_plug_list make
>> sure it run the h/w queue. If all the submission path which deals with s/w
>> queue make sure they run h/w queue, can't we remove blk_mq_run_hw_queues()
>> from scsi_end_request ?
> No, one purpose of blk_mq_run_hw_queues() is for rerun queue in case that
> dispatch budget is running out of in submission path, and sdev->device_busy is
> shared by all hw queues on this scsi device.
> 
> I posted one patch for avoiding it in scsi_end_request() before, looks it
> never lands upstream:
> 

I saw that you actually posted the v3:
https://lore.kernel.org/linux-scsi/BL0PR2101MB11230C5F70151037B23C0C35CE2D0@BL0PR2101MB1123.namprd21.prod.outlook.com/
And it no longer applies, due to the changes in scsi_mq_get_budget(), I 
think, which look non-trivial. Any chance to repost?

Thanks,
John
