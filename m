Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8F742FBB7
	for <lists+linux-scsi@lfdr.de>; Thu, 30 May 2019 14:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfE3MwB (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 30 May 2019 08:52:01 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18055 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725919AbfE3MwA (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 30 May 2019 08:52:00 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id F1D6F9F20549FAEBFF15;
        Thu, 30 May 2019 20:51:58 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Thu, 30 May 2019
 20:51:54 +0800
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 03/24] scsi: add 'nr_reserved_cmds' field to the SCSI host
 template
To:     Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20190529132901.27645-1-hare@suse.de>
 <20190529132901.27645-4-hare@suse.de>
CC:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        <linux-scsi@vger.kernel.org>, "Hannes Reinecke" <hare@suse.com>
Message-ID: <255f2a10-c79c-06a4-d94a-53cf19b17bf3@huawei.com>
Date:   Thu, 30 May 2019 13:51:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190529132901.27645-4-hare@suse.de>
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
> Add a new field 'nr_reserved_cmds' to the SCSI host template to
> instruct the block layer to set aside a tag space for reserved
> commands.
>

Out of curiousity, is there a reason why this would not also be added to 
scsi_host_template?

> Signed-off-by: Hannes Reinecke <hare@suse.com>
> ---
>  drivers/scsi/scsi_lib.c  | 1 +
>  include/scsi/scsi_host.h | 6 ++++++
>  2 files changed, 7 insertions(+)
>
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 34eaef631064..e17153a9ce7c 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -1842,6 +1842,7 @@ int scsi_mq_setup_tags(struct Scsi_Host *shost)
>  	shost->tag_set.ops = &scsi_mq_ops;
>  	shost->tag_set.nr_hw_queues = shost->nr_hw_queues ? : 1;
>  	shost->tag_set.queue_depth = shost->can_queue;
> +	shost->tag_set.reserved_tags = shost->nr_reserved_cmds;
>  	shost->tag_set.cmd_size = cmd_size;
>  	shost->tag_set.numa_node = NUMA_NO_NODE;
>  	shost->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
> diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
> index a5fcdad4a03e..b094e17ef2d4 100644
> --- a/include/scsi/scsi_host.h
> +++ b/include/scsi/scsi_host.h
> @@ -595,6 +595,12 @@ struct Scsi_Host {
>  	 * is nr_hw_queues * can_queue.
>  	 */
>  	unsigned nr_hw_queues;
> +
> +	/*
> +	 * Number of reserved commands, if any.
> +	 */

nit: I would write, "Number of commands to reserve, if any"

> +	unsigned nr_reserved_cmds;
> +
>  	unsigned active_mode:2;
>  	unsigned unchecked_isa_dma:1;
>
>


