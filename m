Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E98F832B3D
	for <lists+linux-scsi@lfdr.de>; Mon,  3 Jun 2019 10:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfFCI5n (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 3 Jun 2019 04:57:43 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17657 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726450AbfFCI5m (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 3 Jun 2019 04:57:42 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B260ABF93D4BCBAE53E7;
        Mon,  3 Jun 2019 16:57:39 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Mon, 3 Jun 2019
 16:57:31 +0800
Subject: Re: [PATCH RFC] hisi_sas_v3: multiqueue support
To:     Ming Lei <ming.lei@redhat.com>
References: <20190531074158.76923-1-hare@suse.de>
 <20190531082116.GA12106@ming.t460p>
 <e81ca95e-95af-1078-c523-701120dd4ca7@suse.de>
 <20190531084600.GB12106@ming.t460p>
 <57d87edb-e748-6223-bfb4-a67ead9a8bdd@huawei.com>
 <20190531225338.GA16190@ming.t460p>
CC:     Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Ming Lei <tom.leiming@gmail.com>, <linux-scsi@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        chenxiang <chenxiang66@hisilicon.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <ab62907f-0d91-607e-daac-d069efb97355@huawei.com>
Date:   Mon, 3 Jun 2019 09:57:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190531225338.GA16190@ming.t460p>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

>>> Otherwise duplicated slot can be used from different blk-mq hw queue.
>>>
>>>>
>>>>> The worsen thing is that V3's actual max queue depth is (4096 - 96), but
>>>>> this patch claims that the device can support (4096 - 96) * 32 command
>>>>> slots
>>
>> To be clear about the hw, the hw supports max 4096 command tags and has 16
>
> Is 4096 the max allowed host-wide command tags? Or per-queue's max commands
> tags?

4096 is max allowed host wide, in range [0, 4096), and tags are not per 
queue. HW delivery queues can be configured to be as large as desired.

And on another point I saw mentioned, the device supports multiple 
submission and multiple completion queues. They are symmetrical, and any 
command will always complete on the same queue index which it was submitted.

>
> If it is per-queue's max command tags, V3 should be real MQ hardware,
> otherwise it is still host wide. Otherwise, Hannes's patch can't work
> because tag from different hw queue can be same.
>
>> hw queues. The hw queue depth is configurable by software, and we configure
>> it at 4096 per queue - same as max command tags - this is to support
>> possibility of all commands using the same queue simultaneously.
>
> Suppose 4096 is the host-wide command tags:
>
> As Hannes's patch changed to allow each blk-mq hw queue to accept 4096 commands,
> there will be big contention in driver, given now the actual .can_queue becomes
> 4096 * 32, and how to avoid the same tag from different hw queue?

The documentation needs to be clarifed for this, to avoid future confusion.

>
> Thanks,
> Ming
>
> .
>


