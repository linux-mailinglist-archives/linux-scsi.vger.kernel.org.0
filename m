Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF3D232D8B
	for <lists+linux-scsi@lfdr.de>; Mon,  3 Jun 2019 12:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfFCKH3 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 3 Jun 2019 06:07:29 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52196 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726369AbfFCKH2 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 3 Jun 2019 06:07:28 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CF51374E60535C9215CF;
        Mon,  3 Jun 2019 18:07:26 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Mon, 3 Jun 2019
 18:07:17 +0800
Subject: Re: [PATCH RFC] hisi_sas_v3: multiqueue support
To:     Ming Lei <ming.lei@redhat.com>
References: <20190531074158.76923-1-hare@suse.de>
 <20190531082116.GA12106@ming.t460p>
 <e81ca95e-95af-1078-c523-701120dd4ca7@suse.de>
 <20190531084600.GB12106@ming.t460p>
 <57d87edb-e748-6223-bfb4-a67ead9a8bdd@huawei.com>
 <20190531225338.GA16190@ming.t460p>
 <ab62907f-0d91-607e-daac-d069efb97355@huawei.com>
 <20190603095413.GE11812@ming.t460p>
CC:     Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Ming Lei <tom.leiming@gmail.com>, <linux-scsi@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        chenxiang <chenxiang66@hisilicon.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <cf44701e-a5e1-f94e-bb1b-2d0a51d2571c@huawei.com>
Date:   Mon, 3 Jun 2019 11:07:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190603095413.GE11812@ming.t460p>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 03/06/2019 10:54, Ming Lei wrote:
> On Mon, Jun 03, 2019 at 09:57:26AM +0100, John Garry wrote:
>>>>> Otherwise duplicated slot can be used from different blk-mq hw queue.
>>>>>
>>>>>>
>>>>>>> The worsen thing is that V3's actual max queue depth is (4096 - 96), but
>>>>>>> this patch claims that the device can support (4096 - 96) * 32 command
>>>>>>> slots
>>>>
>>>> To be clear about the hw, the hw supports max 4096 command tags and has 16
>>>
>>> Is 4096 the max allowed host-wide command tags? Or per-queue's max commands
>>> tags?
>>
>> 4096 is max allowed host wide, in range [0, 4096), and tags are not per
>> queue. HW delivery queues can be configured to be as large as desired.
>
> Then all delivery(and complete) queues share the 4096 command slots, we can't
> convert hisi_sas V3 into typical blk-mq MQ model simply as done by Hannes's patch.
>
> Or you may partition the 4096 tags into 16 queues, then each queue's
> depth is ~256. Depends on if performance is good for workloads.
> You still can build a unique tag easily in [0, 4096), such as
> (req->tag * hw_queue_index).
>
> blk-mq's hw queue has independent tags, which is from NVMe's submission/completion
> queue.

ehhhh, and this is what I thought you were addressing in "[PATCH 1/9] 
blk-mq: allow hw queues to share hostwide tags", right?

>
>>
>> And on another point I saw mentioned, the device supports multiple
>> submission and multiple completion queues. They are symmetrical, and any
>> command will always complete on the same queue index which it was submitted.
>
> DQ & CQ did confuse me a bit, :-)

DQ is "delivery" queue. Interna; terminolgy.

In response to earlier "It depends on if hisi_sas V3 hardware supports 
independent tags for each queue. "

As you now know, it doesn't.

TBH, I would be slightly surprised if any SCSI host supported 
independent tags per HW queue (ignoring these tri-mode types). The 
reason is that hisi_sas uses this tag as SAS SSP frame tag, and later 
used for TMF tag. If we sent different commands to a SCSI end device 
from different queues, then possibly non-unique tags and this would 
break the model. But maybe other SCSI host work differently.

Thanks,
John

>
> Thanks,
> Ming
>
> .
>


