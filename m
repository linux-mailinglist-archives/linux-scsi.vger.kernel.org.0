Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDA1B10E985
	for <lists+linux-scsi@lfdr.de>; Mon,  2 Dec 2019 12:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfLBL0v (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 2 Dec 2019 06:26:51 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2147 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726330AbfLBL0v (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 2 Dec 2019 06:26:51 -0500
Received: from lhreml708-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id DFE2B47361643A3B0BDD;
        Mon,  2 Dec 2019 11:26:49 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml708-cah.china.huawei.com (10.201.108.49) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 2 Dec 2019 11:26:49 +0000
Received: from [127.0.0.1] (10.202.226.46) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5; Mon, 2 Dec 2019
 11:26:49 +0000
Subject: Re: [PATCH] scsi: libsas: stop discovering if oob mode is
 disconnected
To:     yanaijie <yanaijie@huawei.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "hch@lst.de" <hch@lst.de>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>
References: <20191129032413.36092-1-yanaijie@huawei.com>
 <b59a5d52-f663-2772-fc5d-201eeaed1d52@huawei.com>
 <437a8952-780a-aa5c-d060-c20a530f3808@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <eda7f801-4f01-c88a-ef36-bb74b13ce46b@huawei.com>
Date:   Mon, 2 Dec 2019 11:26:48 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <437a8952-780a-aa5c-d060-c20a530f3808@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.202.226.46]
X-ClientProxiedBy: lhreml702-chm.china.huawei.com (10.201.108.51) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


>>> 0x00000000417c4974)
>>> [183047.675208] CPU: 0 PID: 3291 Comm: kworker/u16:2 Tainted: G
>>> W  OE 4.19.36-vhulk1907.1.0.h410.eulerosv2r8.aarch64 #1
>>> [183047.687015] Hardware name: N/A N/A/Kunpeng Desktop Board D920S10,
>>> BIOS 0.15 10/22/2019
>>> [183047.695007] Workqueue: 0000:74:02.0_disco_q sas_discover_domain
>>> [183047.700999] pstate: 20c00009 (nzCv daif +PAN +UAO)
>>> [183047.705864] pc : prep_ata_v3_hw+0xf8/0x230 [hisi_sas_v3_hw]
>>
>> Can you explain how we discover an expander device yet try to send an
>> ATA command?
> 
> In sas_get_port_device() when oob mode is not SATA_OOB_MODE, we get into
> the branch that use the sas_identify_frame instead of dev_to_host_fis to
> determine the device type and protocal, which is a totally wrong
> structure. And the dev_type is expander, but the tproto is
> SAS_PROTOCOL_SATA or SAS_PROTOCOL_STP in this case:
> 
> 
> 
> 	if (dev->frame_rcvd[0] == 0x34 && port->oob_mode == SATA_OOB_MODE) {
> 		struct dev_to_host_fis *fis =
> 			(struct dev_to_host_fis *) dev->frame_rcvd;
> 		if (fis->interrupt_reason == 1 && fis->lbal == 1 &&
> 		    fis->byte_count_low==0x69 && fis->byte_count_high == 0x96
> 		    && (fis->device & ~0x10) == 0)
> 			dev->dev_type = SAS_SATA_PM;
> 		else
> 			dev->dev_type = SAS_SATA_DEV;
> 		dev->tproto = SAS_PROTOCOL_SATA;
> 	} else {
> 		struct sas_identify_frame *id =
> 			(struct sas_identify_frame *) dev->frame_rcvd;
> 		dev->dev_type = id->dev_type;
> 		dev->iproto = id->initiator_bits;
> 		dev->tproto = id->target_bits;
> 	}

Ah, yes, I get it.

> 
> 
>>
>>> [183047.711510] lr : prep_ata_v3_hw+0xb0/0x230 [hisi_sas_v3_hw]
>>> [183047.717153] sp : ffff00000f28ba60
>>> [183047.720541] x29: ffff00000f28ba60 x28: ffff8026852d7228
>>> [183047.725925] x27: ffff8027dba3e0a8 x26: ffff8027c05fc200
>>> [183047.731310] x25: 0000000000000000 x24: ffff8026bafa8dc0
>>> [183047.736695] x23: ffff8027c05fc218 x22: ffff8026852d7228
>>> [183047.742079] x21: ffff80007c2f2940 x20: ffff8027c05fc200
>>> [183047.747464] x19: 0000000000f80800 x18: 0000000000000010
>>> [183047.752848] x17: 0000000000000000 x16: 0000000000000000
>>> [183047.758232] x15: ffff000089a5a4ff x14: 0000000000000005
>>> [183047.763617] x13: ffff000009a5a50e x12: ffff8026bafa1e20
>>> [183047.769001] x11: ffff0000087453b8 x10: ffff00000f28b870
>>> [183047.774385] x9 : 0000000000000000 x8 : ffff80007e58f9b0
>>> [183047.779770] x7 : 0000000000000000 x6 : 000000000000003f
>>> [183047.785154] x5 : 0000000000000040 x4 : ffffffffffffffe0
>>> [183047.790538] x3 : 00000000000000f8 x2 : 0000000002000007
>>> [183047.795922] x1 : 0000000000000008 x0 : 0000000000000000
>>> [183047.801307] Call trace:

is there any guard which we should add in the LLDD for this also?

>>> [183047.803827]  prep_ata_v3_hw+0xf8/0x230 [hisi_sas_v3_hw]
>>> [183047.809127]  hisi_sas_task_prep+0x750/0x888 [hisi_sas_main]
>>> [183047.814773]  hisi_sas_task_exec.isra.7+0x88/0x1f0 [hisi_sas_main]
>>> [183047.820939]  hisi_sas_queue_command+0x28/0x38 [hisi_sas_main]
>>> [183047.826757]  smp_execute_task_sg+0xec/0x218
>>> [183047.831013]  smp_execute_task+0x74/0xa0
>>> [183047.834921]  sas_discover_expander.part.7+0x9c/0x5f8
>>> [183047.839959]  sas_discover_root_expander+0x90/0x160
>>> [183047.844822]  sas_discover_domain+0x1b8/0x1e8
>>> [183047.849164]  process_one_work+0x1b4/0x3f8
>>> [183047.853246]  worker_thread+0x54/0x470
>>> [183047.856981]  kthread+0x134/0x138
>>> [183047.860283]  ret_from_fork+0x10/0x18
>>> [183047.863931] Code: f9407a80 528000e2 39409281 72a04002 (b9405800)
>>> [183047.870097] kernel fault(0x1) notification starting on CPU 0
>>> [183047.875828] kernel fault(0x1) notification finished on CPU 0
>>> [183047.881559] Modules linked in: unibsp(OE) hns3(OE) hclge(OE)
>>> hnae3(OE) mem_drv(OE) hisi_sas_v3_hw(OE) hisi_sas_main(OE)
>>> [183047.892418] ---[ end trace 4cc26083fc11b783  ]---
>>> [183047.897107] Kernel panic - not syncing: Fatal exception
>>> [183047.902403] kernel fault(0x5) notification starting on CPU 0
>>> [183047.908134] kernel fault(0x5) notification finished on CPU 0
>>> [183047.913865] SMP: stopping secondary CPUs
>>> [183047.917861] Kernel Offset: disabled
>>> [183047.921422] CPU features: 0x2,a2a00a38
>>> [183047.925243] Memory Limit: none
>>> [183047.928372] kernel reboot(0x2) notification starting on CPU 0
>>> [183047.934190] kernel reboot(0x2) notification finished on CPU 0
>>> [183047.940008] ---[ end Kernel panic - not syncing: Fatal exception
>>> ]---
>>>
>>> Fixes: 2908d778ab3e ("[SCSI] aic94xx: new driver")
>>
>> I am not sure if it is appropriate to identify this as what we're
>> fixing, since we changed significantly the event processing in libsas
>> since 2908d778ab3e?
>>
> 
> It's ok. Even before 2908d778ab3e we have this issue too. The workqueue
> process is always late and far after the interrupt.
> 
>>> Reported-by: Gao Chuan <gaochuan4@huawei.com>
>>> Signed-off-by: Jason Yan <yanaijie@huawei.com>
>>> ---
>>>    drivers/scsi/libsas/sas_discover.c | 8 +++++++-
>>>    1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/scsi/libsas/sas_discover.c
>>> b/drivers/scsi/libsas/sas_discover.c
>>> index f47b4b281b14..23fdbc8fa05a 100644
>>> --- a/drivers/scsi/libsas/sas_discover.c
>>> +++ b/drivers/scsi/libsas/sas_discover.c
>>> @@ -81,12 +81,18 @@ static int sas_get_port_device(struct asd_sas_port
>>> *port)
>>>            else
>>>                dev->dev_type = SAS_SATA_DEV;
>>>            dev->tproto = SAS_PROTOCOL_SATA;
>>> -    } else {
>>> +    } else if (port->oob_mode == SAS_OOB_MODE) {
>>
>> This just looks racy. We're sending an event and then checking some
>> volatile shared memory in the event processing :(
> 
> It's not me doing this. I add this here because the branch above which
> already doing this.

Yes, right, I was just commenting on the current code.

> 
> And It's true that it is racy. libsas is doing this all the time, not
> only here. The LLDD and libsas share many structures such as
> asd_sas_port, asd_sas_phy and so on and they access these structures in
> deferent contexts. This is a wrong design.

But I didn't think any were as bad as this.

>  > Or we can delete the
> "port->oob_mode == SATA_OOB_MODE" above to fix this issue?
> 
> Becuase "dev->frame_rcvd[0] == 0x34" is enough to determine that if this
> is a "dev_to_host_fis" or a "sas_identify_frame":
> 
> 
> 	if (dev->frame_rcvd[0] == 0x34) {
> 		struct dev_to_host_fis *fis =
> 			(struct dev_to_host_fis *) dev->frame_rcvd;
> 		if (fis->interrupt_reason == 1 && fis->lbal == 1 &&
> 		    fis->byte_count_low==0x69 && fis->byte_count_high == 0x96
> 		    && (fis->device & ~0x10) == 0)
> 			dev->dev_type = SAS_SATA_PM;
> 		else
> 			dev->dev_type = SAS_SATA_DEV;
> 		dev->tproto = SAS_PROTOCOL_SATA;
> 	} else {
> 		struct sas_identify_frame *id =
> 			(struct sas_identify_frame *) dev->frame_rcvd;

nit: we could add a add newline. I know other code does not follow this 
rule, but I see no reason to continue doing it.


> 		dev->dev_type = id->dev_type;
> 		dev->iproto = id->initiator_bits;
> 		dev->tproto = id->target_bits;
> 	}
> 
>>
>>>            struct sas_identify_frame *id =
>>>                (struct sas_identify_frame *) dev->frame_rcvd;
>>>            dev->dev_type = id->dev_type;
>>>            dev->iproto = id->initiator_bits;
>>>            dev->tproto = id->target_bits;
>>> +    } else {
>>> +        /* If the oob mode is OOB_NOT_CONNECTED, the port is
>>> +         * disconnected due to race with PHY down. We cannot
>>> +         * continue to discover this port */
>>> +        sas_put_device(dev);
>>> +        return rc;

So your fix in the original patch looks ok. I would prefer if we could 
stop using rc or remove it, but that's just a slight preference.

Another thought is to add some print to warn/inform of this.

>>>        }
>>>        sas_init_dev(dev);
>>>
>>
>>
>> .
> 


thanks,
John
