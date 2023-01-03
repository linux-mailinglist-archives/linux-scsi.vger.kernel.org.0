Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C044F65B8CD
	for <lists+linux-scsi@lfdr.de>; Tue,  3 Jan 2023 02:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbjACBY7 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 2 Jan 2023 20:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjACBY6 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 2 Jan 2023 20:24:58 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21ADA95B7
        for <linux-scsi@vger.kernel.org>; Mon,  2 Jan 2023 17:24:56 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NmFKz5LKPzJpW7;
        Tue,  3 Jan 2023 09:20:55 +0800 (CST)
Received: from [10.40.193.166] (10.40.193.166) by
 kwepemi500016.china.huawei.com (7.221.188.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 3 Jan 2023 09:24:53 +0800
Subject: Re: [PATCH v2] scsi: hisi_sas: fix tags freeing for the reserverd
 tags
To:     <martin.petersen@oracle.com>
References: <20221215040925.147615-1-yanaijie@huawei.com>
CC:     Jason Yan <yanaijie@huawei.com>, <jejb@linux.ibm.com>,
        <linux-scsi@vger.kernel.org>, <hare@suse.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <jinpu.wang@cloud.ionos.com>,
        <damien.lemoal@opensource.wdc.com>, <john.g.garry@oracle.com>
From:   "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <6637df86-9302-56c6-b760-3f1b46970f15@hisilicon.com>
Date:   Tue, 3 Jan 2023 09:24:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20221215040925.147615-1-yanaijie@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.193.166]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi martin,

I notice that this patch is not merged till now, which affect the boot 
of this driver.
Could you consider to merge it as soon as possible?

Thanks,
Xiang Chen

�� 2022/12/15 12:09, Jason Yan д��:
> John put the reserverd tags in lower region of tagset in commit f7d190a94e35
> ("scsi: hisi_sas: Put reserved tags in lower region of tagset"). However
> he only change the allocate function and forgot to change the tags free
> function. This made my board failed to boot.
>
> [   33.467345] hisi_sas_v3_hw 0000:b4:02.0: task exec: failed[-132]!
> [   33.473413] sas: Executing internal abort failed 5000000000000603 (-132)
> [   33.480088] hisi_sas_v3_hw 0000:b4:02.0: I_T nexus reset: internal abort (-132)
> [   33.657336] hisi_sas_v3_hw 0000:b4:02.0: task exec: failed[-132]!
> [   33.663403] ata7.00: failed to IDENTIFY (I/O error, err_mask=0x40)
> [   35.787344] hisi_sas_v3_hw 0000:b4:04.0: task exec: failed[-132]!
> [   35.793411] sas: Executing internal abort failed 5000000000000703 (-132)
> [   35.800084] hisi_sas_v3_hw 0000:b4:04.0: I_T nexus reset: internal abort (-132)
> [   35.977335] hisi_sas_v3_hw 0000:b4:04.0: task exec: failed[-132]!
> [   35.983403] ata10.00: failed to IDENTIFY (I/O error, err_mask=0x40)
> [   35.989643] ata10.00: revalidation failed (errno=-5)
>
> Fixes: f7d190a94e35 ("scsi: hisi_sas: Put reserved tags in lower region of tagset")
> Cc: John Garry <john.g.garry@oracle.com>
> Cc: Xiang Chen <chenxiang66@hisilicon.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>
>   v1->v2: replace HISI_SAS_UNRESERVED_IPTT with HISI_SAS_RESERVED_IPTT
>
>   drivers/scsi/hisi_sas/hisi_sas_main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
> index 41ba22f6c7f0..e9c2d306ed87 100644
> --- a/drivers/scsi/hisi_sas/hisi_sas_main.c
> +++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
> @@ -162,7 +162,7 @@ static void hisi_sas_slot_index_clear(struct hisi_hba *hisi_hba, int slot_idx)
>   static void hisi_sas_slot_index_free(struct hisi_hba *hisi_hba, int slot_idx)
>   {
>   	if (hisi_hba->hw->slot_index_alloc ||
> -	    slot_idx >= HISI_SAS_UNRESERVED_IPTT) {
> +	    slot_idx < HISI_SAS_RESERVED_IPTT) {
>   		spin_lock(&hisi_hba->lock);
>   		hisi_sas_slot_index_clear(hisi_hba, slot_idx);
>   		spin_unlock(&hisi_hba->lock);

