Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18E7D2CD6B5
	for <lists+linux-scsi@lfdr.de>; Thu,  3 Dec 2020 14:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387612AbgLCN2B (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 3 Dec 2020 08:28:01 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2199 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgLCN2B (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 3 Dec 2020 08:28:01 -0500
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CmxR52XYhz67LF8;
        Thu,  3 Dec 2020 21:25:21 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Thu, 3 Dec 2020 14:27:17 +0100
Received: from [10.47.8.200] (10.47.8.200) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 3 Dec 2020
 13:27:17 +0000
Subject: Re: [PATCH v2 4/4] scsi: set shost as hctx driver_data
To:     Kashyap Desai <kashyap.desai@broadcom.com>,
        <linux-scsi@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20201203034100.29716-1-kashyap.desai@broadcom.com>
 <20201203034100.29716-5-kashyap.desai@broadcom.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <3ee6826b-e010-8874-0447-da8e9b1e8971@huawei.com>
Date:   Thu, 3 Dec 2020 13:26:49 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20201203034100.29716-5-kashyap.desai@broadcom.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.8.200]
X-ClientProxiedBy: lhreml734-chm.china.huawei.com (10.201.108.85) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 03/12/2020 03:41, Kashyap Desai wrote:
> hctx->driver_data is not set for SCSI currently.
> Separately set hctx->driver_data = shost.

nit: this looks ok to me, but I would have made as an earlier patch so 
that you don't add code and then remove it:

 >   static int scsi_mq_poll(struct blk_mq_hw_ctx *hctx)
 >   {
 > -	struct request_queue *q = hctx->queue;
 > -	struct scsi_device *sdev = q->queuedata;
 > -	struct Scsi_Host *shost = sdev->host;

Thanks,
John

> 
> Suggested-by: John Garry <john.garry@huawei.com>
> Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
> ---
>   drivers/scsi/scsi_lib.c | 19 +++++++++++++------
>   1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 8675900ccc27..892315c21b70 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -1789,9 +1789,7 @@ static void scsi_mq_exit_request(struct blk_mq_tag_set *set, struct request *rq,
>   
>   static int scsi_mq_poll(struct blk_mq_hw_ctx *hctx)
>   {
> -	struct request_queue *q = hctx->queue;
> -	struct scsi_device *sdev = q->queuedata;
> -	struct Scsi_Host *shost = sdev->host;
> +	struct Scsi_Host *shost = hctx->driver_data;
>   
>   	if (shost->hostt->mq_poll)
>   		return shost->hostt->mq_poll(shost, hctx->queue_num);
> @@ -1799,6 +1797,15 @@ static int scsi_mq_poll(struct blk_mq_hw_ctx *hctx)
>   	return 0;
>   }
>   
> +static int scsi_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
> +			  unsigned int hctx_idx)
> +{
> +	struct Scsi_Host *shost = data;
> +
> +	hctx->driver_data = shost;
> +	return 0;
> +}
> +
>   static int scsi_map_queues(struct blk_mq_tag_set *set)
>   {
>   	struct Scsi_Host *shost = container_of(set, struct Scsi_Host, tag_set);
> @@ -1866,15 +1873,14 @@ static const struct blk_mq_ops scsi_mq_ops_no_commit = {
>   	.cleanup_rq	= scsi_cleanup_rq,
>   	.busy		= scsi_mq_lld_busy,
>   	.map_queues	= scsi_map_queues,
> +	.init_hctx	= scsi_init_hctx,
>   	.poll		= scsi_mq_poll,
>   };
>   
>   
>   static void scsi_commit_rqs(struct blk_mq_hw_ctx *hctx)
>   {
> -	struct request_queue *q = hctx->queue;
> -	struct scsi_device *sdev = q->queuedata;
> -	struct Scsi_Host *shost = sdev->host;
> +	struct Scsi_Host *shost = hctx->driver_data;
>   
>   	shost->hostt->commit_rqs(shost, hctx->queue_num);
>   }
> @@ -1895,6 +1901,7 @@ static const struct blk_mq_ops scsi_mq_ops = {
>   	.cleanup_rq	= scsi_cleanup_rq,
>   	.busy		= scsi_mq_lld_busy,
>   	.map_queues	= scsi_map_queues,
> +	.init_hctx	= scsi_init_hctx,
>   	.poll		= scsi_mq_poll,
>   };
>   
> 

