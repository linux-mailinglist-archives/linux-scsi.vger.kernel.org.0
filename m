Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4DC17BB3C
	for <lists+linux-scsi@lfdr.de>; Fri,  6 Mar 2020 12:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgCFLMM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 6 Mar 2020 06:12:12 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2514 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726129AbgCFLMM (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 6 Mar 2020 06:12:12 -0500
Received: from lhreml703-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 207A84D45544E5D3D868;
        Fri,  6 Mar 2020 11:12:10 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml703-cah.china.huawei.com (10.201.108.44) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 6 Mar 2020 11:12:09 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 6 Mar 2020
 11:12:09 +0000
Subject: Re: [PATCH RFC v6 06/10] scsi: Add template flag 'host_tagset'
To:     <axboe@kernel.dk>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <ming.lei@redhat.com>,
        <bvanassche@acm.org>, <hare@suse.de>, <don.brace@microsemi.com>,
        <sumit.saxena@broadcom.com>, <hch@infradead.org>,
        <kashyap.desai@broadcom.com>,
        <shivasharan.srikanteshwara@broadcom.com>
CC:     <chenxiang66@hisilicon.com>, <linux-block@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <esc.storagedev@microsemi.com>,
        Hannes Reinecke <hare@suse.com>
References: <1583409280-158604-1-git-send-email-john.garry@huawei.com>
 <1583409280-158604-7-git-send-email-john.garry@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <f59950ce-9813-3811-d903-75ef493e2d4a@huawei.com>
Date:   Fri, 6 Mar 2020 11:12:08 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <1583409280-158604-7-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.45]
X-ClientProxiedBy: lhreml716-chm.china.huawei.com (10.201.108.67) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 05/03/2020 11:54, John Garry wrote:
> From: Hannes Reinecke <hare@suse.com>
> 
> Add a host template flag 'host_tagset' so hostwide tagset can be
> shared on multiple reply queues after the SCSI device's reply queue
> is converted to blk-mq hw queue.

We should also change the comment about Scsi_host.nr_hw_queues in 
include/scsi/scsi_host.h also, like this:

* Note: it is assumed that each hardware queue has a queue depth of
* can_queue. In other words, the total queue depth per host
-* is nr_hw_queues * can_queue.
+* is nr_hw_queues * can_queue. However, in the case of .host_tagset
+* being set, the total queue depth per host is can_queue.

> 
> Signed-off-by: Hannes Reinecke <hare@suse.com>
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   drivers/scsi/scsi_lib.c  | 2 ++
>   include/scsi/scsi_host.h | 3 +++
>   2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 610ee41fa54c..84788ccc2672 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -1901,6 +1901,8 @@ int scsi_mq_setup_tags(struct Scsi_Host *shost)
>   	shost->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
>   	shost->tag_set.flags |=
>   		BLK_ALLOC_POLICY_TO_MQ_FLAG(shost->hostt->tag_alloc_policy);
> +	if (shost->hostt->host_tagset)
> +		shost->tag_set.flags |= BLK_MQ_F_TAG_HCTX_SHARED;
>   	shost->tag_set.driver_data = shost;
>   
>   	return blk_mq_alloc_tag_set(&shost->tag_set);
> diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
> index f577647bf5f2..4fd0af0883dd 100644
> --- a/include/scsi/scsi_host.h
> +++ b/include/scsi/scsi_host.h
> @@ -429,6 +429,9 @@ struct scsi_host_template {
>   	/* True if the low-level driver supports blk-mq only */
>   	unsigned force_blk_mq:1;
>   
> +	/* True if the host uses host-wide tagspace */
> +	unsigned host_tagset:1;
> +
>   	/*
>   	 * Countdown for host blocking with no commands outstanding.
>   	 */
> 

