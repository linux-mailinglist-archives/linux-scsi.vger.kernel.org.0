Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC43C381982
	for <lists+linux-scsi@lfdr.de>; Sat, 15 May 2021 17:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbhEOPK4 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 15 May 2021 11:10:56 -0400
Received: from netrider.rowland.org ([192.131.102.5]:32799 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S231646AbhEOPKp (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 15 May 2021 11:10:45 -0400
Received: (qmail 1036884 invoked by uid 1000); 15 May 2021 11:09:30 -0400
Date:   Sat, 15 May 2021 11:09:30 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 49/50] usb-storage: Use blk_req() instead of
 scsi_cmnd.request
Message-ID: <20210515150930.GA1036273@rowland.harvard.edu>
References: <20210514213356.5264-1-bvanassche@acm.org>
 <20210514213356.5264-50-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514213356.5264-50-bvanassche@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, May 14, 2021 at 02:33:04PM -0700, Bart Van Assche wrote:
> Prepare for removal of the request pointer by using blk_req() instead. This
> patch does not change any functionality.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>

>  drivers/usb/storage/transport.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/storage/transport.c b/drivers/usb/storage/transport.c
> index f4304ce69350..53cc76b51ed7 100644
> --- a/drivers/usb/storage/transport.c
> +++ b/drivers/usb/storage/transport.c
> @@ -551,7 +551,7 @@ static void last_sector_hacks(struct us_data *us, struct scsi_cmnd *srb)
>  	/* Did this command access the last sector? */
>  	sector = (srb->cmnd[2] << 24) | (srb->cmnd[3] << 16) |
>  			(srb->cmnd[4] << 8) | (srb->cmnd[5]);
> -	disk = srb->request->rq_disk;
> +	disk = blk_req(srb)->rq_disk;
>  	if (!disk)
>  		goto done;
>  	sdkp = scsi_disk(disk);
