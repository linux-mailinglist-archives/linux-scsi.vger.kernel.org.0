Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B60AD4980BD
	for <lists+linux-scsi@lfdr.de>; Mon, 24 Jan 2022 14:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239620AbiAXNPW (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 24 Jan 2022 08:15:22 -0500
Received: from verein.lst.de ([213.95.11.211]:55756 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229533AbiAXNPV (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 24 Jan 2022 08:15:21 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 10B4068BEB; Mon, 24 Jan 2022 14:15:17 +0100 (CET)
Date:   Mon, 24 Jan 2022 14:15:16 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V2 09/13] scsi: force unfreezing queue into atomic mode
Message-ID: <20220124131516.GH27269@lst.de>
References: <20220122111054.1126146-1-ming.lei@redhat.com> <20220122111054.1126146-10-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220122111054.1126146-10-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sat, Jan 22, 2022 at 07:10:50PM +0800, Ming Lei wrote:
> In scsi_disk_release() request queue is frozen for clearing
> disk->private_data, and there can't be any FS IO issued to
> this queue, and only private passthrough request will be handled, so
> force unfreezing queue into atomic mode.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/scsi/sd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index 0e73c3f2f381..27f04c860f00 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -3670,7 +3670,7 @@ static void scsi_disk_release(struct device *dev)
>  	 * in case multiple processes open a /dev/sd... node concurrently.
>  	 */
>  	blk_mq_freeze_queue(q);
> -	blk_mq_unfreeze_queue(q);
> +	__blk_mq_unfreeze_queue(q, true);

I think the right thing here is to drop the freeze/unfreeze pair.
Now that del_gendisk properly freezes the queue, we don't need this
protection as the issue that Bart fixed with it can't happen any more.
