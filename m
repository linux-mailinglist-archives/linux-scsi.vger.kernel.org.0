Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E03A6478AF
	for <lists+linux-scsi@lfdr.de>; Mon, 17 Jun 2019 05:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfFQDfs (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 16 Jun 2019 23:35:48 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:47442 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbfFQDfs (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 16 Jun 2019 23:35:48 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 2F7832931B;
        Sun, 16 Jun 2019 23:35:42 -0400 (EDT)
Date:   Mon, 17 Jun 2019 13:35:53 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Ming Lei <ming.lei@redhat.com>
cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>, Jim Gill <jgill@vmware.com>,
        Cathy Avery <cavery@redhat.com>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Brian King <brking@us.ibm.com>,
        James Smart <james.smart@broadcom.com>,
        "Juergen E . Fischer" <fischer@norbit.de>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-usb@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Benjamin Block <bblock@linux.ibm.com>
Subject: Re: [PATCH V4 11/16] scsi: aha152x: use sg helper to operate
 scatterlist
In-Reply-To: <20190617030349.26415-12-ming.lei@redhat.com>
Message-ID: <alpine.LNX.2.21.1906171334330.168@nippy.intranet>
References: <20190617030349.26415-1-ming.lei@redhat.com> <20190617030349.26415-12-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, 17 Jun 2019, Ming Lei wrote:

> Use the scatterlist iterators and remove direct indexing of the
> scatterlist array.
> 
> This way allows us to pre-allocate one small scatterlist, which can be
> chained with one runtime allocated scatterlist if the pre-allocated one
> isn't enough for the whole request.
> 
> Finn added the change to replace SCp.buffers_residual with sg_is_last()
> for fixing updating it, and the similar change has been applied on
> NCR5380.c
> 
> Cc: Finn Thain <fthain@telegraphics.com.au>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Reviewed-by: Finn Thain <fthain@telegraphics.com.au>

-- 

> ---
>  drivers/scsi/aha152x.c | 42 ++++++++++++++++++++----------------------
>  1 file changed, 20 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/scsi/aha152x.c b/drivers/scsi/aha152x.c
> index 97872838b983..6d0518f616cb 100644
> --- a/drivers/scsi/aha152x.c
> +++ b/drivers/scsi/aha152x.c
> @@ -948,7 +948,6 @@ static int aha152x_internal_queue(struct scsi_cmnd *SCpnt,
>  	   SCp.ptr              : buffer pointer
>  	   SCp.this_residual    : buffer length
>  	   SCp.buffer           : next buffer
> -	   SCp.buffers_residual : left buffers in list
>  	   SCp.phase            : current state of the command */
>  
>  	if ((phase & resetting) || !scsi_sglist(SCpnt)) {
> @@ -956,13 +955,11 @@ static int aha152x_internal_queue(struct scsi_cmnd *SCpnt,
>  		SCpnt->SCp.this_residual = 0;
>  		scsi_set_resid(SCpnt, 0);
>  		SCpnt->SCp.buffer           = NULL;
> -		SCpnt->SCp.buffers_residual = 0;
>  	} else {
>  		scsi_set_resid(SCpnt, scsi_bufflen(SCpnt));
>  		SCpnt->SCp.buffer           = scsi_sglist(SCpnt);
>  		SCpnt->SCp.ptr              = SG_ADDRESS(SCpnt->SCp.buffer);
>  		SCpnt->SCp.this_residual    = SCpnt->SCp.buffer->length;
> -		SCpnt->SCp.buffers_residual = scsi_sg_count(SCpnt) - 1;
>  	}
>  
>  	DO_LOCK(flags);
> @@ -2030,10 +2027,9 @@ static void datai_run(struct Scsi_Host *shpnt)
>  				}
>  
>  				if (CURRENT_SC->SCp.this_residual == 0 &&
> -				    CURRENT_SC->SCp.buffers_residual > 0) {
> +				    !sg_is_last(CURRENT_SC->SCp.buffer)) {
>  					/* advance to next buffer */
> -					CURRENT_SC->SCp.buffers_residual--;
> -					CURRENT_SC->SCp.buffer++;
> +					CURRENT_SC->SCp.buffer = sg_next(CURRENT_SC->SCp.buffer);
>  					CURRENT_SC->SCp.ptr           = SG_ADDRESS(CURRENT_SC->SCp.buffer);
>  					CURRENT_SC->SCp.this_residual = CURRENT_SC->SCp.buffer->length;
>  				}
> @@ -2136,10 +2132,10 @@ static void datao_run(struct Scsi_Host *shpnt)
>  			CMD_INC_RESID(CURRENT_SC, -2 * data_count);
>  		}
>  
> -		if(CURRENT_SC->SCp.this_residual==0 && CURRENT_SC->SCp.buffers_residual>0) {
> +		if(CURRENT_SC->SCp.this_residual==0 &&
> +		   !sg_is_last(CURRENT_SC->SCp.buffer)) {
>  			/* advance to next buffer */
> -			CURRENT_SC->SCp.buffers_residual--;
> -			CURRENT_SC->SCp.buffer++;
> +			CURRENT_SC->SCp.buffer = sg_next(CURRENT_SC->SCp.buffer);
>  			CURRENT_SC->SCp.ptr           = SG_ADDRESS(CURRENT_SC->SCp.buffer);
>  			CURRENT_SC->SCp.this_residual = CURRENT_SC->SCp.buffer->length;
>  		}
> @@ -2158,22 +2154,24 @@ static void datao_run(struct Scsi_Host *shpnt)
>  static void datao_end(struct Scsi_Host *shpnt)
>  {
>  	if(TESTLO(DMASTAT, DFIFOEMP)) {
> -		int data_count = (DATA_LEN - scsi_get_resid(CURRENT_SC)) -
> -			GETSTCNT();
> +		int done = GETSTCNT();
> +		int data_count = (DATA_LEN - scsi_get_resid(CURRENT_SC)) - done;
> +		struct scatterlist *sg = scsi_sglist(CURRENT_SC);
>  
>  		CMD_INC_RESID(CURRENT_SC, data_count);
>  
> -		data_count -= CURRENT_SC->SCp.ptr -
> -			SG_ADDRESS(CURRENT_SC->SCp.buffer);
> -		while(data_count>0) {
> -			CURRENT_SC->SCp.buffer--;
> -			CURRENT_SC->SCp.buffers_residual++;
> -			data_count -= CURRENT_SC->SCp.buffer->length;
> +		/* Locate the first SG entry not yet sent */
> +		while (done > 0 && !sg_is_last(sg)) {
> +			if (done < sg->length)
> +				break;
> +			done -= sg->length;
> +			sg = sg_next(sg);
>  		}
> -		CURRENT_SC->SCp.ptr = SG_ADDRESS(CURRENT_SC->SCp.buffer) -
> -			data_count;
> -		CURRENT_SC->SCp.this_residual = CURRENT_SC->SCp.buffer->length +
> -			data_count;
> +
> +		CURRENT_SC->SCp.buffer = sg;
> +		CURRENT_SC->SCp.ptr = SG_ADDRESS(CURRENT_SC->SCp.buffer) + done;
> +		CURRENT_SC->SCp.this_residual = CURRENT_SC->SCp.buffer->length -
> +			done;
>  	}
>  
>  	SETPORT(SXFRCTL0, CH1|CLRCH1|CLRSTCNT);
> @@ -2501,7 +2499,7 @@ static void get_command(struct seq_file *m, struct scsi_cmnd * ptr)
>  
>  	seq_printf(m, "); resid=%d; residual=%d; buffers=%d; phase |",
>  		scsi_get_resid(ptr), ptr->SCp.this_residual,
> -		ptr->SCp.buffers_residual);
> +		sg_nents(ptr->SCp.buffer) - 1);
>  
>  	if (ptr->SCp.phase & not_issued)
>  		seq_puts(m, "not issued|");
> 
