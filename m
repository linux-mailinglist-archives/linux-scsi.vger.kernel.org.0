Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F73E4B871A
	for <lists+linux-scsi@lfdr.de>; Wed, 16 Feb 2022 12:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbiBPLul (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 16 Feb 2022 06:50:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbiBPLuk (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 16 Feb 2022 06:50:40 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A0E2560E9
        for <linux-scsi@vger.kernel.org>; Wed, 16 Feb 2022 03:50:23 -0800 (PST)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JzGPF4F55z67L71;
        Wed, 16 Feb 2022 19:45:53 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Wed, 16 Feb 2022 12:50:20 +0100
Received: from [10.47.81.42] (10.47.81.42) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 16 Feb
 2022 11:50:20 +0000
Message-ID: <5a5481af-e975-c6fb-2d48-961769eae551@huawei.com>
Date:   Wed, 16 Feb 2022 11:50:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v3 27/31] scsi: pm8001: Cleanup pm8001_queue_command()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Xiang Chen <chenxiang66@hisilicon.com>,
        "Jason Yan" <yanaijie@huawei.com>
References: <20220214021747.4976-1-damien.lemoal@opensource.wdc.com>
 <20220214021747.4976-28-damien.lemoal@opensource.wdc.com>
 <51d7c127-f975-14e9-a036-c37416ed8679@huawei.com>
 <32efd519-3485-ee34-84e2-34a0d8c27e17@opensource.wdc.com>
 <38090771-ad24-1b20-9b79-f7f89d42ea66@huawei.com>
 <37df3c92-c28e-72d4-76d8-33356829af5a@opensource.wdc.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <37df3c92-c28e-72d4-76d8-33356829af5a@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.81.42]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 16/02/2022 11:42, Damien Le Moal wrote:
>> Hi Damien,
>>
>>> patch 30 cleans up pm8001_task_exec(). This patch is for
>>> pm8001_queue_command(). I preferred to separate to facilitate review.
>>> But if you insist, I can merge these into a much bigger "code cleanup"
>>> patch...
>>>
>> I don't mind really.
>>
>> BTW, on a separate topic, IIRC you said that rmmod hangs for this driver
>> - if so, did you investigate why?
> The problem is gone with the fixes. I suspect it was due to the buggy
> non-data command handling (likely, the flush issued when stopping the
> device on rmmod).
> 
> I have not tackled/tried again the QD change failure though.
> 
> Preparing v4 now. Will check the QD change.
> 

ok, great.

JFYI, turning on DMA debug sometimes gives this even after fdisk -l:

[   45.080945] sas: sas_scsi_find_task: querying task 0x(____ptrval____)
[   45.087582] pm80xx0:: mpi_ssp_completion  1936:sas IO status 0x3b
[   45.093681] pm80xx0:: mpi_ssp_completion  1947:SAS Address of IO 
Failure Drive:5000c50085ff5559
[   45.102641] pm80xx0:: mpi_ssp_completion  1936:sas IO status 0x3b
[   45.108739] pm80xx0:: mpi_ssp_completion  1947:SAS Address of IO 
Failure Drive:5000c50085ff5559
[   45.117694] pm80xx0:: mpi_ssp_completion  1936:sas IO status 0x3b
[   45.123792] pm80xx0:: mpi_ssp_completion  1947:SAS Address of IO 
Failure Drive:5000c50085ff5559
[   45.132652] pm80xx: rc= -5
[   45.135370] sas: sas_scsi_find_task: task 0x(____ptrval____) result 
code -5 not handled
[   45.143466] sas: task 0x(____ptrval____) is not at LU: I_T recover
[   45.149741] sas: I_T nexus reset for dev 5000c50085ff5559
[   47.183916] sas: I_T 5000c50085ff5559 recovered
[   47.189034] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 1 
tries: 1
[   47.204168] ------------[ cut here ]------------
[   47.208829] DMA-API: pm80xx 0000:04:00.0: cacheline tracking EEXIST, 
overlapping mappings aren't supported
[   47.218502] WARNING: CPU: 3 PID: 641 at kernel/dma/debug.c:570 
add_dma_entry+0x308/0x3f0
[   47.226607] Modules linked in:
[   47.229678] CPU: 3 PID: 641 Comm: kworker/3:1H Not tainted 
5.17.0-rc1-11918-gd9d909a8c666 #407
[   47.238298] Hardware name: Huawei D06 /D06, BIOS Hisilicon D06 UEFI 
RC0 - V1.16.01 03/15/2019
[   47.246829] Workqueue: kblockd blk_mq_run_work_fn
[   47.251552] pstate: 604000c9 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS 
BTYPE=--)
[   47.258522] pc : add_dma_entry+0x308/0x3f0
[   47.262626] lr : add_dma_entry+0x308/0x3f0
[   47.266730] sp : ffff80002e5c75f0
[   47.270049] x29: ffff80002e5c75f0 x28: 0000002880a908c0 x27: 
ffff80000cc95440
[   47.277216] x26: ffff80000cc94000 x25: ffff80000cc94e20 x24: 
ffff00208e4660c8
[   47.284382] x23: ffff800009d16b40 x22: ffff80000a5b8700 x21: 
1ffff00005cb8eca
[   47.291548] x20: ffff80000caf4c90 x19: ffff0a2009726100 x18: 
0000000000000000
[   47.298713] x17: 70616c7265766f20 x16: 2c54534958454520 x15: 
676e696b63617274
[   47.305879] x14: 1ffff00005cb8df4 x13: 0000000041b58ab3 x12: 
ffff700005cb8e27
[   47.313044] x11: 1ffff00005cb8e26 x10: ffff700005cb8e26 x9 : 
dfff800000000000
[   47.320210] x8 : ffff80002e5c7137 x7 : 0000000000000001 x6 : 
00008ffffa3471da
[   47.327375] x5 : ffff80002e5c7130 x4 : dfff800000000000 x3 : 
ffff8000083a1f48
[   47.334540] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 
ffff00208f7ab200
[   47.341706] Call trace:
[   47.344157]  add_dma_entry+0x308/0x3f0
[   47.347914]  debug_dma_map_sg+0x3ac/0x500
[   47.351931]  __dma_map_sg_attrs+0xac/0x130
[   47.356037]  dma_map_sg_attrs+0x14/0x2c
[   47.359883]  pm8001_task_exec.constprop.0+0x5e0/0x800
[   47.364945]  pm8001_queue_command+0x1c/0x2c
[   47.369136]  sas_queuecommand+0x2c4/0x360
[   47.373153]  scsi_queue_rq+0x810/0x1334
[   47.377000]  blk_mq_dispatch_rq_list+0x340/0xda0
[   47.381625]  __blk_mq_sched_dispatch_requests+0x14c/0x22c
[   47.387034]  blk_mq_sched_dispatch_requests+0x60/0x9c
[   47.392095]  __blk_mq_run_hw_queue+0xc8/0x274
[   47.396460]  blk_mq_run_work_fn+0x30/0x40
[   47.400476]  process_one_work+0x494/0xbac
[   47.404494]  worker_thread+0xac/0x6d0
[   47.408164]  kthread+0x174/0x184
[   47.411401]  ret_from_fork+0x10/0x2[   45.080945] sas: 
sas_scsi_find_task: querying task 0x(____ptrval____)
[   45.087582] pm80xx0:: mpi_ssp_completion  1936:sas IO status 0x3b
[   45.093681] pm80xx0:: mpi_ssp_completion  1947:SAS Address of IO 
Failure Drive:5000c50085ff5559
[   45.102641] pm80xx0:: mpi_ssp_completion  1936:sas IO status 0x3b
[   45.108739] pm80xx0:: mpi_ssp_completion  1947:SAS Address of IO 
Failure Drive:5000c50085ff5559
[   45.117694] pm80xx0:: mpi_ssp_completion  1936:sas IO status 0x3b
[   45.123792] pm80xx0:: mpi_ssp_completion  1947:SAS Address of IO 
Failure Drive:5000c50085ff5559
[   45.132652] pm80xx: rc= -5
[   45.135370] sas: sas_scsi_find_task: task 0x(____ptrval____) result 
code -5 not handled
[   45.143466] sas: task 0x(____ptrval____) is not at LU: I_T recover
[   45.149741] sas: I_T nexus reset for dev 5000c50085ff5559
[   47.183916] sas: I_T 5000c50085ff5559 recovered
[   47.189034] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 1 
tries: 1
[   47.204168] ------------[ cut here ]------------
[   47.208829] DMA-API: pm80xx 0000:04:00.0: cacheline tracking EEXIST, 
overlapping mappings aren't supported
[   47.218502] WARNING: CPU: 3 PID: 641 at kernel/dma/debug.c:570 
add_dma_entry+0x308/0x3f0
[   47.226607] Modules linked in:
[   47.229678] CPU: 3 PID: 641 Comm: kworker/3:1H Not tainted 
5.17.0-rc1-11918-gd9d909a8c666 #407
[   47.238298] Hardware name: Huawei D06 /D06, BIOS Hisilicon D06 UEFI 
RC0 - V1.16.01 03/15/2019
[   47.246829] Workqueue: kblockd blk_mq_run_work_fn
[   47.251552] pstate: 604000c9 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS 
BTYPE=--)
[   47.258522] pc : add_dma_entry+0x308/0x3f0
[   47.262626] lr : add_dma_entry+0x308/0x3f0
[   47.266730] sp : ffff80002e5c75f0
[   47.270049] x29: ffff80002e5c75f0 x28: 0000002880a908c0 x27: 
ffff80000cc95440
[   47.277216] x26: ffff80000cc94000 x25: ffff80000cc94e20 x24: 
ffff00208e4660c8
[   47.284382] x23: ffff800009d16b40 x22: ffff80000a5b8700 x21: 
1ffff00005cb8eca
[   47.291548] x20: ffff80000caf4c90 x19: ffff0a2009726100 x18: 
0000000000000000
[   47.298713] x17: 70616c7265766f20 x16: 2c54534958454520 x15: 
676e696b63617274
[   47.305879] x14: 1ffff00005cb8df4 x13: 0000000041b58ab3 x12: 
ffff700005cb8e27
[   47.313044] x11: 1ffff00005cb8e26 x10: ffff700005cb8e26 x9 : 
dfff800000000000
[   47.320210] x8 : ffff80002e5c7137 x7 : 0000000000000001 x6 : 
00008ffffa3471da
[   47.327375] x5 : ffff80002e5c7130 x4 : dfff800000000000 x3 : 
ffff8000083a1f48
[   47.334540] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 
ffff00208f7ab200
[   47.341706] Call trace:
[   47.344157]  add_dma_entry+0x308/0x3f0
[   47.347914]  debug_dma_map_sg+0x3ac/0x500
[   47.351931]  __dma_map_sg_attrs+0xac/0x130
[   47.356037]  dma_map_sg_attrs+0x14/0x2c
[   47.359883]  pm8001_task_exec.constprop.0+0x5e0/0x800
[   47.364945]  pm8001_queue_command+0x1c/0x2c
[   47.369136]  sas_queuecommand+0x2c4/0x360
[   47.373153]  scsi_queue_rq+0x810/0x1334
[   47.377000]  blk_mq_dispatch_rq_list+0x340/0xda0
[   47.381625]  __blk_mq_sched_dispatch_requests+0x14c/0x22c
[   47.387034]  blk_mq_sched_dispatch_requests+0x60/0x9c
[   47.392095]  __blk_mq_run_hw_queue+0xc8/0x274
[   47.396460]  blk_mq_run_work_fn+0x30/0x40
[   47.400476]  process_one_work+0x494/0xbac
[   47.404494]  worker_thread+0xac/0x6d0
[   47.408164]  kthread+0x174/0x184
[   47.411401]  ret_from_fork+0x10/0x2

I'll have a look at it. And that is on mainline or mkp-scsi staging, and 
not your patchset.

Thanks,
John
