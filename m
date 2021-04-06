Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5950354F57
	for <lists+linux-scsi@lfdr.de>; Tue,  6 Apr 2021 11:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240836AbhDFJDs (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 6 Apr 2021 05:03:48 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15491 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240559AbhDFJDr (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 6 Apr 2021 05:03:47 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FF1jN2wxyzrd4Z;
        Tue,  6 Apr 2021 17:01:28 +0800 (CST)
Received: from [10.174.179.174] (10.174.179.174) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Tue, 6 Apr 2021 17:03:33 +0800
Subject: Re: [RFC PATCH] scsi: megaraid_sas: set msix index for
 NON_READ_WRITE_LDIO type cmd
To:     <kashyap.desai@broadcom.com>, <sumit.saxena@broadcom.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <megaraidlinux.pdl@broadcom.com>, <linux-scsi@vger.kernel.org>
References: <20210325084247.4136519-1-yuyufen@huawei.com>
From:   Yufen Yu <yuyufen@huawei.com>
Message-ID: <fe977858-91a3-51e3-f90e-d2ec878499df@huawei.com>
Date:   Tue, 6 Apr 2021 17:03:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20210325084247.4136519-1-yuyufen@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.174]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

gentle ping.
Any suggestion are welcome.

Thanks,
Yufen



On 2021/3/25 16:42, Yufen Yu wrote:
> Before commit 132147d7f620 ("scsi: megaraid_sas: Add support for
> High IOPS queues"), all interrupt of megaraid_sas is managed when
> smp_affinity_enable for misx_enable. The mapping between vectors and
> cpus for a 128 vectors likely:
>      vector0 maps to cpu0
>      vector1 maps to cpu1
>      ...
> If cpu0 is offline, vector0 cannot handle any io.
> 
> For now, we have not pointed msix index in megasas_build_ld_nonrw_fusion().
> The default value of index is '0'. So, cmd like TEST_UNIT_READY will hung
> forever after cpu0 offline. We can simplely reproduce by:
> 
>      echo 0 > /sys/devices/system/cpu/cpu0/online
>      sg_turs /dev/sda # hung
> 
> After commit 132147d7f620, low_latency_index_start is set as 1 (not sure
> for all scenario), then vector 0 is not managed. Thus, io issue to vector0
> can be handled by other cpus after cpu0 offline.
> 
> Nevertheless, we may also conside to set msix index rather than default 0
> in megasas_build_ld_nonrw_fusion().
> 
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
> ---
>   drivers/scsi/megaraid/megaraid_sas_fusion.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
> index 38fc9467c625..ddc6176f12c4 100644
> --- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
> +++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
> @@ -3021,6 +3021,8 @@ static void megasas_build_ld_nonrw_fusion(struct megasas_instance *instance,
>   		io_request->Function = MPI2_FUNCTION_SCSI_IO_REQUEST;
>   		io_request->DevHandle = devHandle;
>   	}
> +
> +	megasas_get_msix_index(instance, scmd, cmd, 1);
>   }
>   
>   /**
> 
