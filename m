Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEC933EFBB
	for <lists+linux-scsi@lfdr.de>; Wed, 17 Mar 2021 12:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhCQLpA (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 17 Mar 2021 07:45:00 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2707 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbhCQLom (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 17 Mar 2021 07:44:42 -0400
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4F0p9c4xctz680sN;
        Wed, 17 Mar 2021 19:40:04 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Wed, 17 Mar 2021 12:44:38 +0100
Received: from [10.47.1.152] (10.47.1.152) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 17 Mar
 2021 11:44:37 +0000
Subject: Re: [PATCH] scsi: libsas: Reset num_scatter if libata mark qc as
 NODATA
To:     Jolly Shah <jollys@google.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <a.darwish@linutronix.de>,
        <yanaijie@huawei.com>, <luojiaxing@huawei.com>,
        <dan.carpenter@oracle.com>, <b.zolnierkie@samsung.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210316193905.1673600-1-jollys@google.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <5e2c35b6-a9c4-0637-738b-ff6920635425@huawei.com>
Date:   Wed, 17 Mar 2021 11:42:29 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20210316193905.1673600-1-jollys@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.1.152]
X-ClientProxiedBy: lhreml716-chm.china.huawei.com (10.201.108.67) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 16/03/2021 19:39, Jolly Shah wrote:
> When the cache_type for the scsi device is changed, the scsi layer
> issues a MODE_SELECT command. The caching mode details are communicated
> via a request buffer associated with the scsi command with data
> direction set as DMA_TO_DEVICE (scsi_mode_select). When this command
> reaches the libata layer, as a part of generic initial setup, libata
> layer sets up the scatterlist for the command using the scsi command
> (ata_scsi_qc_new). This command is then translated by the libata layer
> into ATA_CMD_SET_FEATURES (ata_scsi_mode_select_xlat). The libata layer
> treats this as a non data command (ata_mselect_caching), since it only
> needs an ata taskfile to pass the caching on/off information to the
> device. It does not need the scatterlist that has been setup, so it does
> not perform dma_map_sg on the scatterlist (ata_qc_issue). 

So if we don't perform the dma_map_sg() on the sgl at this point, then 
it seems to me that we should not perform for_each_sg() on it either, 
right? That is still what happens in sas_ata_qc_issue() in this case.

> Unfortunately,
> when this command reaches the libsas layer(sas_ata_qc_issue), libsas
> layer sees it as a non data command with a scatterlist. It cannot
> extract the correct dma length, since the scatterlist has not been
> mapped with dma_map_sg for a DMA operation. When this partially
> constructed SAS task reaches pm80xx LLDD, it results in below warning.
> 
> "pm80xx_chip_sata_req 6058: The sg list address
> start_addr=0x0000000000000000 data_len=0x0end_addr_high=0xffffffff
> end_addr_low=0xffffffff has crossed 4G boundary"
> 
> This patch assigns appropriate value to  num_sectors for ata non data
> commands.
> 
> Signed-off-by: Jolly Shah <jollys@google.com>
> ---
>   drivers/scsi/libsas/sas_ata.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
> index 024e5a550759..94ec08cebbaa 100644
> --- a/drivers/scsi/libsas/sas_ata.c
> +++ b/drivers/scsi/libsas/sas_ata.c
> @@ -209,10 +209,12 @@ static unsigned int sas_ata_qc_issue(struct ata_queued_cmd *qc)
>   		task->num_scatter = si;
>   	}
>   
> -	if (qc->tf.protocol == ATA_PROT_NODATA)
> +	if (qc->tf.protocol == ATA_PROT_NODATA) {
>   		task->data_dir = DMA_NONE;
> -	else
> +		task->num_scatter = 0;

task->num_scatter has already been set in this function. Best not set it 
twice.

Thanks,
John

> +	} else {
>   		task->data_dir = qc->dma_dir;
> +	}
>   	task->scatter = qc->sg;
>   	task->ata_task.retry_count = 1;
>   	task->task_state_flags = SAS_TASK_STATE_PENDING;
> 

