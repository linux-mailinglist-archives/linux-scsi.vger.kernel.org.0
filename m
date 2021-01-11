Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E4F2F1C02
	for <lists+linux-scsi@lfdr.de>; Mon, 11 Jan 2021 18:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389185AbhAKRNg (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 11 Jan 2021 12:13:36 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2307 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732337AbhAKRNf (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 11 Jan 2021 12:13:35 -0500
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DF0YD1nMfz67ZFk;
        Tue, 12 Jan 2021 01:09:04 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 11 Jan 2021 18:12:53 +0100
Received: from [10.210.171.188] (10.210.171.188) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Mon, 11 Jan 2021 17:12:52 +0000
Subject: Re: About scsi device queue depth
To:     <jejb@linux.ibm.com>, Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        PDL-MPT-FUSIONLINUX <MPT-FusionLinux.pdl@broadcom.com>
CC:     chenxiang <chenxiang66@hisilicon.com>
References: <9ff894da-cf2c-9094-2690-1973cc57835a@huawei.com>
 <d784f7ff4f61a81c4c9df96decc6b7f6d884c616.camel@linux.ibm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <b51fc658-b28a-d627-a2a3-b2835132ab13@huawei.com>
Date:   Mon, 11 Jan 2021 17:11:45 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <d784f7ff4f61a81c4c9df96decc6b7f6d884c616.camel@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.171.188]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 11/01/2021 16:40, James Bottomley wrote:
>> So initial sdev queue depth comes from cmd_per_lun by default or
>> manually setting in the driver via scsi_change_queue_depth(). It
>> seems to me that some drivers are not setting this optimally, as
>> above.
>>
>> Thoughts on guidance for setting sdev queue depth? Could blk-mq
>> changed this behavior?

Hi James,

> In general, for spinning rust, you want the minimum queue depth
> possible for keeping the device active because merging is a very
> important performance enhancement and once the drive is fully occupied
> simply sending more tags won't improve latency.  We used to recommend a
> depth of about 4 for this reason.  A co-operative device can help you
> find the optimal by returning QUEUE_FULL when it's fully occupied so we
> have a mechanism to track the queue full returns and change the depth
> interactively.
> 
> For high iops devices, these considerations went out of the window and
> it's generally assumed (without varying evidence) the more tags the
> better. 

For this case, it seems the opposite - less is more. And I seem to be 
hitting closer to the sweet spot there, with more merges.

> SSDs have a peculiar lifetime problem in that when they get
> erase block starved they start behaving more like spinning rust in that
> they reach a processing limit but only for writes, so lowering the
> write queue depth (which we don't even have a knob for) might be a good
> solution.  Trying to track the erase block problem has been a constant
> bugbear.

I am only doing read performance test here, and the disks are SAS3.0 
SSDs HUSMM1640ASS204, so not exactly slow.

> 
> I'm assuming you're using spinning rust in the above, so it sounds like
> the firmware in the card might be eating the queue full returns.  I
> could see this happening in RAID mode, but it shouldn't happen in jbod
> mode.

Not sure on that, but I didn't check too much. I did try to increase fio 
queue depth and sdev queue depth to be very large to clobber the disks, 
but still nothing.

Thanks
John
