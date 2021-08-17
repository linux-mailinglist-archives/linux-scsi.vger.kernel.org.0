Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852793EE770
	for <lists+linux-scsi@lfdr.de>; Tue, 17 Aug 2021 09:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238532AbhHQHqr (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 17 Aug 2021 03:46:47 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:13436 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238439AbhHQHqn (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 17 Aug 2021 03:46:43 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Gpjfm4jPYzdbm7;
        Tue, 17 Aug 2021 15:42:24 +0800 (CST)
Received: from dggema773-chm.china.huawei.com (10.1.198.217) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 17 Aug 2021 15:46:06 +0800
Received: from [10.174.179.2] (10.174.179.2) by dggema773-chm.china.huawei.com
 (10.1.198.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 17
 Aug 2021 15:46:05 +0800
Subject: Re: [PATCH v2] scsi: core: Fix hang of freezing queue between
 blocking and running device
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <john.garry@huawei.com>, <bvanassche@acm.org>,
        <qiulaibin@huawei.com>, <linfeilong@huawei.com>,
        <wubo40@huawei.com>
References: <20210809141308.3700854-1-lijinlin3@huawei.com>
From:   Li Jinlin <lijinlin3@huawei.com>
Message-ID: <8d0583de-f818-1be7-ac08-c84cfd5988f6@huawei.com>
Date:   Tue, 17 Aug 2021 15:46:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210809141308.3700854-1-lijinlin3@huawei.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.2]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema773-chm.china.huawei.com (10.1.198.217)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2021/8/9 22:13, Li Jinlin wrote:
> From: Li Jinlin <lijinlin3@huawei.com>
> 
> We found a hang issue, the test steps are as follows:
>   1. blocking device via scsi_device_set_state()
>   2. dd if=/dev/sda of=/mnt/t.log bs=1M count=10
>   3. echo none > /sys/block/sda/queue/scheduler
>   4. echo "running" >/sys/block/sda/device/state
> 
> Step 3 and 4 should finish this work after step 4, but they hangs.
> 
>   CPU#0               CPU#1                CPU#2
>   ---------------     ----------------     ----------------
>                                            Step 1: blocking device
> 
>                                            Step 2: dd xxxx
>                                                   ^^^^^^ get request
>                                                          q_usage_counter++
> 
>                       Step 3: switching scheculer
>                       elv_iosched_store
>                         elevator_switch
>                           blk_mq_freeze_queue
>                             blk_freeze_queue
>                               > blk_freeze_queue_start
>                                 ^^^^^^ mq_freeze_depth++
> 
>                               > blk_mq_run_hw_queues
>                                 ^^^^^^ can't run queue when dev blocked
> 
>                               > blk_mq_freeze_queue_wait
>                                 ^^^^^^ Hang here!!!
>                                        wait q_usage_counter==0
> 
>   Step 4: running device
>   store_state_field
>     scsi_rescan_device
>       scsi_attach_vpd
>         scsi_vpd_inquiry
>           __scsi_execute
>             blk_get_request
>               blk_mq_alloc_request
>                 blk_queue_enter
>                 ^^^^^^ Hang here!!!
>                        wait mq_freeze_depth==0
> 
>     blk_mq_run_hw_queues
>     ^^^^^^ dispatch IO, q_usage_counter will reduce to zero
> 
>                             blk_mq_unfreeze_queue
>                             ^^^^^ mq_freeze_depth--
> 
> Step 3 and 4 wait for each other.
> 
> To fix this, we need to run queue before rescanning device when the device
> state changes to SDEV_RUNNING.
> 
> Fixes: f0f82e2476f6 ("scsi: core: Fix capacity set to zero after offlinining device")
> Signed-off-by: Li Jinlin <lijinlin3@huawei.com>
> Signed-off-by: Qiu Laibin <qiulaibin@huawei.com>
> ---
> changes since v1 send with Message-ID:
> 20210805143231.1713299-1-lijinlin3@huawei.com
> 
>  - Modify the subject to make it distinct
>  - Modify the message to fix typo and make it distinct
>  - Reduce the number of SOB
> 
>  drivers/scsi/scsi_sysfs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
> index c3a710bceba0..aa701582c950 100644
> --- a/drivers/scsi/scsi_sysfs.c
> +++ b/drivers/scsi/scsi_sysfs.c
> @@ -809,12 +809,12 @@ store_state_field(struct device *dev, struct device_attribute *attr,
>  	ret = scsi_device_set_state(sdev, state);
>  	/*
>  	 * If the device state changes to SDEV_RUNNING, we need to
> -	 * rescan the device to revalidate it, and run the queue to
> -	 * avoid I/O hang.
> +	 * run the queue to avoid I/O hang, and rescan the device
> +	 * to revalidate it.
>  	 */
>  	if (ret == 0 && state == SDEV_RUNNING) {
> -		scsi_rescan_device(dev);
>  		blk_mq_run_hw_queues(sdev->request_queue, true);
> +		scsi_rescan_device(dev);
>  	}
>  	mutex_unlock(&sdev->state_mutex);
>  
> 

Ping.

Thanks,
Li Jinlin
