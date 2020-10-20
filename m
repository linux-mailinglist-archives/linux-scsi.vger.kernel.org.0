Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E422832BA
	for <lists+linux-scsi@lfdr.de>; Mon,  5 Oct 2020 11:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgJEJE6 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 5 Oct 2020 05:04:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:57168 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgJEJE6 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 5 Oct 2020 05:04:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 631DCABE3;
        Mon,  5 Oct 2020 09:04:57 +0000 (UTC)
Subject: Re: [PATCH 06/10] scsi: rename scsi_prep_state_check to
 scsi_device_state_check
To:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org
References: <20201005084130.143273-1-hch@lst.de>
 <20201005084130.143273-7-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <764c8b62-f104-21c4-6010-a6e571b36755@suse.de>
Date:   Mon, 5 Oct 2020 11:04:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201005084130.143273-7-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 10/5/20 10:41 AM, Christoph Hellwig wrote:
> The old name is rather confusing now that the the legacy prep_fn is gone.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/scsi/scsi_lib.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 670ad06812b419..3940641052f90b 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -1214,7 +1214,7 @@ static blk_status_t scsi_setup_cmnd(struct scsi_device *sdev,
>   }
>   
>   static blk_status_t
> -scsi_prep_state_check(struct scsi_device *sdev, struct request *req)
> +scsi_device_state_check(struct scsi_device *sdev, struct request *req)
>   {
>   	switch (sdev->sdev_state) {
>   	case SDEV_OFFLINE:
> @@ -1653,7 +1653,7 @@ static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
>   	 * commands.
>   	 */
>   	if (unlikely(sdev->sdev_state != SDEV_RUNNING)) {
> -		ret = scsi_prep_state_check(sdev, req);
> +		ret = scsi_device_state_check(sdev, req);
>   		if (ret != BLK_STS_OK)
>   			goto out_put_budget;
>   	}
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
