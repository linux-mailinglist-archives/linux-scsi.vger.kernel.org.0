Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3122C5255
	for <lists+linux-scsi@lfdr.de>; Thu, 26 Nov 2020 11:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388401AbgKZKr6 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 26 Nov 2020 05:47:58 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2159 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388389AbgKZKr6 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 26 Nov 2020 05:47:58 -0500
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ChZDf0Dz0z67GpV;
        Thu, 26 Nov 2020 18:46:10 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 26 Nov 2020 11:47:56 +0100
Received: from [10.210.172.213] (10.210.172.213) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Thu, 26 Nov 2020 10:47:55 +0000
Subject: Re: [PATCH v2 1/3] genirq/affinity: Add irq_update_affinity_desc()
To:     Marc Zyngier <maz@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <martin.petersen@oracle.com>,
        <jejb@linux.ibm.com>, <linuxarm@huawei.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <87ft57r7v3.fsf@nanos.tec.linutronix.de>
 <78356caa-57a0-b807-fe52-8f12d36c1789@huawei.com>
 <874klmqu2r.fsf@nanos.tec.linutronix.de>
 <b86af904-2288-8b53-7e99-e763b73987d0@huawei.com>
 <87lfexp6am.fsf@nanos.tec.linutronix.de>
 <3acb7fde-eae2-a223-9cfd-f409cc2abba6@huawei.com>
 <873615oy8a.fsf@nanos.tec.linutronix.de>
 <4aab9d3b-6ca6-01c5-f840-459f945c7577@huawei.com>
 <87sg91ik9e.wl-maz@kernel.org>
 <0edc9a11-0b92-537f-1790-6b4b6de4900d@huawei.com>
 <afd97dd4b1e102ac9ad49800821231a4@kernel.org>
 <5a314713-c1ee-2d34-bee1-60beae274742@huawei.com>
 <0525a4bcf17a355cd141632d4f3714be@kernel.org>
 <702e1729-9a4b-b16f-6a58-33172b1a3220@huawei.com>
 <5a588f5d86010602ff9a90e8f057743c@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <80e0a19b-3291-1304-1a5b-0445c49efe31@huawei.com>
Date:   Thu, 26 Nov 2020 10:47:33 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <5a588f5d86010602ff9a90e8f057743c@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.210.172.213]
X-ClientProxiedBy: lhreml707-chm.china.huawei.com (10.201.108.56) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Marc,

>> Right, I did consider this.
> 
> FWIW, I've pushed my hack branch[1]

Did you miss that reference?

> out with a couple of patches
> for you to try (the top 3 patches). They allow platform-MSI domains
> created by devices (mbigen, ICU) to be advertised as shared between
> devices, so that the low-level driver can handle that in an appropriate
> way.
> 
> I gave it a go on my D05 and nothing blew up, but I can't really remove
> the kernel module, as that's where my disks are... :-/

You still should be able to enable my favorite 
CONFIG_DEBUG_TEST_DRIVER_REMOVE=y, while the distro still boot. But I'll 
just test if you want.

> Please let me know if that helps.
> 
>>> It is just that passing that information down isn't a simple affair,
>>> as msi_alloc_info_t isn't a generic type... Let me have a think.
>>
>> I think that there is a way to circumvent the problem, which you might
>> call hacky, but OTOH, not sure if there's much point changing mbigen
>> or related infrastructure at this stage.
> 
> Bah, it's a simple change, and there is now more than the mbigen using
> the same API...
> 
>>
>> Anyway, so we have 128 irqs in total for the mbigen domain, but the
>> driver only is interesting in something like irq indexes 1,2,72-81,
>> and 96-112. So we can just dispose the mappings for irq index 0-112 at
>> removal stage, thereby keeping the its device around. We do still call
>> platform_irq_count(), which sets up all 128 mappings, so maybe we
>> should be unmapping all of these - this would be the contentious part.
>> But maybe not, as the device driver is only interested in that subset,
>> and has no business unmapping the rest.
> 
> I don't think the driver should mess with interrupts it doesn't own.

I would tend to agree. But all 128 lines here are for the SAS 
controller. It's quite strange, as only about ~20 are useful.

> And while the mbigen port that is connected to the SAS controller
> doesn't seem to be shared between endpoints, some other ports definitely
> are:
> 
> # cat /sys/kernel/debug/irq/domains/\\_SB.MBI1
> name:   \_SB.MBI1
>   size:   409
>   mapped: 192
>   flags:  0x00000003
> 
> [...]
> 
> I guess that the other 217 lines are connected somewhere.
> 

I think that is not the right one. See 
https://github.com/tianocore/edk2-platforms/blob/master/Silicon/Hisilicon/Hi1616/D05AcpiTables/Dsdt/D05Sas.asl#L101


Thanks,
John
