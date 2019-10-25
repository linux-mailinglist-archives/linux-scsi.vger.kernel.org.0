Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1369E4670
	for <lists+linux-scsi@lfdr.de>; Fri, 25 Oct 2019 10:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438210AbfJYI6T (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 25 Oct 2019 04:58:19 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2053 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2438203AbfJYI6S (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 25 Oct 2019 04:58:18 -0400
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 6448D1CD0FE2A83F3447;
        Fri, 25 Oct 2019 09:58:17 +0100 (IST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML711-CAH.china.huawei.com (10.201.108.34) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 25 Oct 2019 09:58:16 +0100
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 25 Oct
 2019 09:58:16 +0100
Subject: Re: [PATCH V4 1/2] scsi: core: avoid host-wide host_busy counter for
 scsi_mq
To:     Ming Lei <ming.lei@redhat.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Omar Sandoval <osandov@fb.com>,
        "Christoph Hellwig" <hch@lst.de>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        "Hannes Reinecke" <hare@suse.de>,
        Laurence Oberman <loberman@redhat.com>,
        "Bart Van Assche" <bart.vanassche@wdc.com>
References: <20191009093241.21481-1-ming.lei@redhat.com>
 <20191009093241.21481-2-ming.lei@redhat.com>
 <7d95de12-6114-c0d7-8b21-d36b2ea020fc@huawei.com>
 <20191024005828.GB15426@ming.t460p>
 <19e73b4d-77c7-e776-fee4-8b9f078c2be5@huawei.com>
 <20191024212427.GA26168@ming.t460p>
From:   John Garry <john.garry@huawei.com>
Message-ID: <fb0d3475-b9b9-bac2-ec44-5c4cff67a104@huawei.com>
Date:   Fri, 25 Oct 2019 09:58:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191024212427.GA26168@ming.t460p>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.45]
X-ClientProxiedBy: lhreml730-chm.china.huawei.com (10.201.108.81) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


>> In scsi_host.h, we have for scsi_host_template.can_queue: "It is set to the
>> maximum number of simultaneous commands a given host adapter will accept.",
>> so that should be honoured.
> 

Hi Ming,

> That words should have been changed to:
> 
> "It is set to the maximum number of simultaneous commands a given host adapter's
> hw queue will accept."

I find this definition misleading. As you know, some MQ SAS HBAs can 
accept .can_queue commands on a given hw queue, but can still only 
accept .can_queue commands over all hw queues.

> 
>>
>> And Scsi_host.nr_hw_queues: "it is assumed that each hardware queue has a
>> queue depth of can_queue. In other words, the total queue depth per host is
>> nr_hw_queues * can_queue."
> 
> The above is correct.
> 
>>
>> I don't read "total queue depth per host" same as "maximum number of
>> simultaneous commands a given host adapter will accept". If anything, the
>> nr_hw_queues comment is ambiguous.
>>
>>>
>>> The point is simple, because each hw queue has its own independent tags,
>>> that is why I mentioned your Hisilicon SAS can't be converted to MQ
>>> easily cause this hardware has only single shared tags.
>>
>> Please be aware that HiSilicon SAS HW would not be unique for SCSI HBAs in
>> this regard, in that the unique hostwide tag is not just for HBA HW IO
>> management, but also is used as the tag for SCSI TMFs.
> 
> Right.
> 
>>
>> Just checking mpt3sas seems similar:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/scsi/mpt3sas/mpt3sas_scsih.c#n2918
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/scsi/mpt3sas/mpt3sas_base.c#n3546
> 
> Not only mpt3sas, there are also HPSA and more. And these drivers have to
> support single hw queue of blk-mq, instead of real MQ. And the reason is that
> these HBA has single tags.

We should be able to do better than that.

For a start, at least doesn't the check you remove in 
scsi_host_is_busy() limit commands the HBA accepts to .can_queue?

And if you make the change in this patch, then the changes to improve 
blk-mq for CPU hotplug are pointless, as we can't change the SAS HBAs to 
expose multiple queues.

Thanks,
John

> 
> Thanks,
> Ming
> 
> .
> 

