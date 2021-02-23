Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD491322FFB
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Feb 2021 18:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbhBWRwm (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 23 Feb 2021 12:52:42 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2599 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbhBWRwl (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 23 Feb 2021 12:52:41 -0500
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DlRNG5vq9z67rB4;
        Wed, 24 Feb 2021 01:47:58 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Tue, 23 Feb 2021 18:51:59 +0100
Received: from [10.47.0.222] (10.47.0.222) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 23 Feb
 2021 17:51:58 +0000
Subject: Re: [PATCHv7 00/31] scsi: enable reserved commands for LLDDs
From:   John Garry <john.garry@huawei.com>
To:     Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     James Bottomley <james.bottomley@hansenpartnership.com>,
        Christoph Hellwig <hch@lst.de>, <linux-scsi@vger.kernel.org>,
        "Viswas.G@microchip.com" <Viswas.G@microchip.com>
References: <20210222132405.91369-1-hare@suse.de>
 <a6234ede-74bd-81f0-9d39-db398b79f50a@huawei.com>
Message-ID: <6d2f5677-b033-9639-82da-655152ad6d8c@huawei.com>
Date:   Tue, 23 Feb 2021 17:50:11 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <a6234ede-74bd-81f0-9d39-db398b79f50a@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.0.222]
X-ClientProxiedBy: lhreml742-chm.china.huawei.com (10.201.108.192) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 23/02/2021 10:16, John Garry wrote:
> On 22/02/2021 13:23, Hannes Reinecke wrote:
>> Hi all,
> 
> +
> 
>>
>> quite some drivers use internal commands for various purposes, most
>> commonly sending TMFs or querying the HBA status.
>> While these commands use the same submission mechanism than normal
>> I/O commands, they will not be counted as outstanding commands,
>> requiring those drivers to implement their own mechanism to figure
>> out outstanding commands.
>> The block layer already has the concept of 'reserved' tags for
>> precisely this purpose, namely non-I/O tags which live off a separate
>> tag pool. That guarantees that these commands can always be sent,
>> and won't be influenced by tag starvation from the I/O tag pool.
>> This patchset enables the use of reserved tags for the SCSI midlayer
>> by allocating a virtual LUN for the HBA itself which just serves
>> as a resource to allocate valid tags from.
>> This removes quite some hacks which were required for some
>> drivers (eg. fnic or snic), and allows the use of tagset
>> iterators within the drivers.
>>
>> The entire patchset can be found at
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git
>> reserved-tags.v7
> 
> 
> Thanks for doing this, I'll have a look.

So I got this working eventually for hisi_sas - a few fixes needed:
https://github.com/hisilicon/kernel-dev/commits/private-topic-sas-5.11-resv7

I'll have a look at the core patches tomorrow. However, at this point, 
how about convert just a couple of drivers (the ones which you can test) 
to get it merged as a start? 31 patches is too many.

thanks,
John
