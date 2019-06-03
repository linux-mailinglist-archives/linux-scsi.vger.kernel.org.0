Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99DBE32FE2
	for <lists+linux-scsi@lfdr.de>; Mon,  3 Jun 2019 14:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfFCMmF (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 3 Jun 2019 08:42:05 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44244 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726360AbfFCMmF (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 3 Jun 2019 08:42:05 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A7A778C3BE3C2FF0BF28;
        Mon,  3 Jun 2019 20:41:59 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Mon, 3 Jun 2019
 20:41:51 +0800
Subject: Re: [PATCH RFC] hisi_sas_v3: multiqueue support (v2 hw divergence)
To:     Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>
References: <20190531074158.76923-1-hare@suse.de>
 <20190531082116.GA12106@ming.t460p>
 <e81ca95e-95af-1078-c523-701120dd4ca7@suse.de>
 <20190531084600.GB12106@ming.t460p>
 <57d87edb-e748-6223-bfb4-a67ead9a8bdd@huawei.com>
 <15480880-496f-9603-ece8-4da2a204ed51@suse.de>
 <2994ee9f-85a0-c3dc-ab5c-cb8c6ee1ec92@huawei.com>
 <86347b6f-7b23-9f0f-4306-a7c22b50dd8c@suse.de>
CC:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        "Ming Lei" <tom.leiming@gmail.com>, <linux-scsi@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        chenxiang <chenxiang66@hisilicon.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <525e2437-0484-8b2e-57df-2d1e1b09a03b@huawei.com>
Date:   Mon, 3 Jun 2019 13:41:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <86347b6f-7b23-9f0f-4306-a7c22b50dd8c@suse.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

>>
>> The crazy (escalating from weird) rules to workaround the HW bug(s) mean
>> that we need to chop up the command tag range into blocks of 32 even tag
>> indexes per SATA device; this means that SATA device #0 can use 64, 66,
>> 68, 70...126. device #1 can use 128, 130, 132,..., device #2 can use
>> 192, 194,...
>>
>> I don't know how you can take a rq tag and generate a command tag
>> suitable for a SATA device.
>> Actually, you can.
> We can setup a _distinct_ tagset per SATA device.
> Eg we can setup a shared tagset for SAS (which is half the size of the
> original tagset), and shift the tags by one to get a valid SAS tag.
> For SATA we can setup a _distinct_ tagset per device, containing 32
> tags. The we can invoke some calculation to transform the tag (which is
> not guaranteed to be in the range of 0-31) into a valid hardware tag.
>
> Should actually work.

ok, fine. I suppose that each SATA device having its own tagset could be 
more efficient, as in reality the tags are separate.

>
> Problem is that we'd need to set aside some tags for TMF,

It not just TMF to consider, but the HW also supports "internal abort", 
which also requires a unique tag. And in some scenarios we send ATA 
softreset, as is the abort flow design for this host.

  but I really
> don't think that we can or should do command aborts on SATA; while there
> is the 'abort NCQ' command, it'll work only for NCQ commands, and won't
> help us for 'normal' commands.
> And seeing that on error all NCQ commands will be aborted anyway, plus
> the standard ATA error handler will be resulting into a device reset, I
> guess we should skip command abort on SATA and escalate to device reset
> straightaway. That would also have the nice benefit that we need only to
> set _one_ tag aside for TMF, as we will only send one TMF at a time.
>

Yeah, I think that it should be ok. All error handlng is sequential.

Thanks very much,
John

> Cheers,
>
> Hannes
>


