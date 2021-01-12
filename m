Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B67AE2F2A73
	for <lists+linux-scsi@lfdr.de>; Tue, 12 Jan 2021 10:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392434AbhALI6g (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 12 Jan 2021 03:58:36 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2309 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727916AbhALI6f (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 12 Jan 2021 03:58:35 -0500
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DFPV91R3Tz67b8F;
        Tue, 12 Jan 2021 16:52:49 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 12 Jan 2021 09:57:53 +0100
Received: from [10.210.171.61] (10.210.171.61) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 12 Jan 2021 08:57:52 +0000
Subject: Re: About scsi device queue depth
To:     Ming Lei <ming.lei@redhat.com>
CC:     Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        PDL-MPT-FUSIONLINUX <MPT-FusionLinux.pdl@broadcom.com>,
        chenxiang <chenxiang66@hisilicon.com>
References: <9ff894da-cf2c-9094-2690-1973cc57835a@huawei.com>
 <20210112014203.GA60605@T590>
From:   John Garry <john.garry@huawei.com>
Message-ID: <4b50f067-a368-2197-c331-a8c981f5cd02@huawei.com>
Date:   Tue, 12 Jan 2021 08:56:45 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20210112014203.GA60605@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.171.61]
X-ClientProxiedBy: lhreml744-chm.china.huawei.com (10.201.108.194) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Ming,

>>
>> I was looking at some IOMMU issue on a LSI RAID 3008 card, and noticed that
>> performance there is not what I get on other SAS HBAs - it's lower.
>>
>> After some debugging and fiddling with sdev queue depth in mpt3sas driver, I
>> am finding that performance changes appreciably with sdev queue depth:
>>
>> sdev qdepth	fio number jobs* 	1	10	20
>> 16					1590	1654	1660
>> 32					1545	1646	1654
>> 64					1436	1085	1070
>> 254 (default)				1436	1070	1050
> 
> What does the performance number mean? IOPS or others? What is the fio
> io test? random IO or sequential IO?

So those figures are x1K IOPs read performance; so 1590, above, is 1.59M 
IOPs read. Here's the fio script:

[global]
rw=read
direct=1
ioengine=libaio
iodepth=40
numjobs=20
bs=4k
;size=10240000m
;zero_buffers=1
group_reporting=1
;ioscheduler=noop
;cpumask=0xffe
;cpus_allowed=1-47
;gtod_reduce=1
;iodepth_batch=2
;iodepth_batch_complete=2
runtime=60
;thread
loops = 10000

>>
>> fio queue depth is 40, and I'm using 12x SAS SSDs.
>>
>> I got comparable disparity in results for fio queue depth = 128 and num jobs
>> = 1:
>>
>> sdev qdepth	fio number jobs* 	1	
>> 16					1640
>> 32					1618	
>> 64					1577	
>> 254 (default)				1437	
>>
>> IO sched = none.
>>
>> That driver also sets queue depth tracking = 1, but never seems to kick in.
>>
>> So it seems to me that the block layer is merging more bios per request, as
>> averge sg count per request goes up from 1 - > upto 6 or more. As I see,
>> when queue depth lowers the only thing that is really changing is that we
>> fail more often in getting the budget in
>> scsi_mq_get_budget()->scsi_dev_queue_ready().
> 
> Right, the behavior basically doesn't change compared with block legacy
> io path. And that is why sdev->queue_depth is a bit important for HDD.

OK

> 
>>
>> So initial sdev queue depth comes from cmd_per_lun by default or manually
>> setting in the driver via scsi_change_queue_depth(). It seems to me that
>> some drivers are not setting this optimally, as above.
>>
>> Thoughts on guidance for setting sdev queue depth? Could blk-mq changed this
>> behavior?
> 
> So far, the sdev queue depth is provided by SCSI layer, and blk-mq can
> queue one request only if budget is obtained via .get_budget().
> 

Well, based on my testing, default sdev queue depth seems too large for 
that LLDD ...

Thanks,
John

