Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8412FF71
	for <lists+linux-scsi@lfdr.de>; Thu, 30 May 2019 17:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfE3P2d (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 30 May 2019 11:28:33 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58722 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726576AbfE3P2c (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 30 May 2019 11:28:32 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C16F24F5BA5A3619ACBD;
        Thu, 30 May 2019 23:28:28 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Thu, 30 May 2019
 23:28:25 +0800
Subject: Re: [PATCH 10/24] scsi: allocate separate queue for reserved commands
To:     Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20190529132901.27645-1-hare@suse.de>
 <20190529132901.27645-11-hare@suse.de>
CC:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        <linux-scsi@vger.kernel.org>, "Hannes Reinecke" <hare@suse.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <5537cf59-0138-3553-0896-21b1aaf2fe51@huawei.com>
Date:   Thu, 30 May 2019 16:28:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190529132901.27645-11-hare@suse.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 29/05/2019 14:28, Hannes Reinecke wrote:
> From: Hannes Reinecke <hare@suse.com>
>
> Allocate a separate 'reserved_cmd_q' for sending reserved commands.
>
> Signed-off-by: Hannes Reinecke <hare@suse.com>
> ---
>  drivers/scsi/scsi_lib.c  | 15 ++++++++++++++-
>  include/scsi/scsi_host.h |  4 ++++
>  2 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index e17153a9ce7c..076459853622 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -1831,6 +1831,7 @@ struct request_queue *scsi_mq_alloc_queue(struct scsi_device *sdev)
>  int scsi_mq_setup_tags(struct Scsi_Host *shost)
>  {
>  	unsigned int cmd_size, sgl_size;
> +	int ret;
>
>  	sgl_size = scsi_mq_inline_sgl_size(shost);
>  	cmd_size = sizeof(struct scsi_cmnd) + shost->hostt->cmd_size + sgl_size;
> @@ -1850,11 +1851,23 @@ int scsi_mq_setup_tags(struct Scsi_Host *shost)
>  		BLK_ALLOC_POLICY_TO_MQ_FLAG(shost->hostt->tag_alloc_policy);
>  	shost->tag_set.driver_data = shost;
>
> -	return blk_mq_alloc_tag_set(&shost->tag_set);
> +	ret = blk_mq_alloc_tag_set(&shost->tag_set);
> +	if (ret)
> +		return ret;
> +
> +	if (shost->nr_reserved_cmds && shost->use_reserved_cmd_q) {
> +		shost->reserved_cmd_q = blk_mq_init_queue(&shost->tag_set);
> +		if (IS_ERR(shost->reserved_cmd_q)) {
> +			blk_mq_free_tag_set(&shost->tag_set);
> +			ret = PTR_ERR(shost->reserved_cmd_q);
> +		}
> +	}
> +	return ret;
>  }
>
>  void scsi_mq_destroy_tags(struct Scsi_Host *shost)
>  {
> +	blk_cleanup_queue(shost->reserved_cmd_q);
>  	blk_mq_free_tag_set(&shost->tag_set);
>  }
>
> diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
> index 89998b6bee04..a2bab5f07eff 100644
> --- a/include/scsi/scsi_host.h
> +++ b/include/scsi/scsi_host.h
> @@ -600,6 +600,7 @@ struct Scsi_Host {
>  	 * Number of reserved commands, if any.
>  	 */
>  	unsigned nr_reserved_cmds;
> +	struct request_queue *reserved_cmd_q;
>
>  	unsigned active_mode:2;
>  	unsigned unchecked_isa_dma:1;
> @@ -637,6 +638,9 @@ struct Scsi_Host {
>  	/* The transport requires the LUN bits NOT to be stored in CDB[1] */
>  	unsigned no_scsi2_lun_in_cdb:1;
>
> +	/* Host requires a separate reserved_cmd_q */
> +	unsigned use_reserved_cmd_q:1;

Is this really required? I would think that a non-zero value for 
shost->nr_reserved_cmds means the same thing in practice.

Thanks,
John

> +
>  	/*
>  	 * Optional work queue to be utilized by the transport
>  	 */
>


