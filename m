Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87E9B45413
	for <lists+linux-scsi@lfdr.de>; Fri, 14 Jun 2019 07:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbfFNFjG (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 14 Jun 2019 01:39:06 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:55994 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfFNFjG (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 14 Jun 2019 01:39:06 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id C026922BFB;
        Fri, 14 Jun 2019 01:39:01 -0400 (EDT)
Date:   Fri, 14 Jun 2019 15:39:10 +1000 (AEST)
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
        Benjamin Block <bblock@linux.ibm.com>,
        Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH V3 07/15] usb: image: microtek: use sg helper to operate
 scatterlist
In-Reply-To: <20190614025316.7360-8-ming.lei@redhat.com>
Message-ID: <alpine.LNX.2.21.1906141536000.33@nippy.intranet>
References: <20190614025316.7360-1-ming.lei@redhat.com> <20190614025316.7360-8-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, 14 Jun 2019, Ming Lei wrote:

> Use the scatterlist iterators and remove direct indexing of the
> scatterlist array.
> 
> This way allows us to pre-allocate one small scatterlist, which can be
> chained with one runtime allocated scatterlist if the pre-allocated one
> isn't enough for the whole request.
> 
> Cc: Oliver Neukum <oliver@neukum.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/usb/image/microtek.c | 20 ++++++++------------
>  drivers/usb/image/microtek.h |  2 +-
>  2 files changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/usb/image/microtek.c b/drivers/usb/image/microtek.c
> index 607be1f4fe27..0a57c2cc8e5a 100644
> --- a/drivers/usb/image/microtek.c
> +++ b/drivers/usb/image/microtek.c
> @@ -488,7 +488,6 @@ static void mts_command_done( struct urb *transfer )
>  
>  static void mts_do_sg (struct urb* transfer)
>  {
> -	struct scatterlist * sg;
>  	int status = transfer->status;
>  	MTS_INT_INIT();
>  
> @@ -500,13 +499,12 @@ static void mts_do_sg (struct urb* transfer)
>  		mts_transfer_cleanup(transfer);
>          }
>  
> -	sg = scsi_sglist(context->srb);
> -	context->fragment++;
> +	context->curr_sg = sg_next(context->curr_sg);
>  	mts_int_submit_urb(transfer,
>  			   context->data_pipe,
> -			   sg_virt(&sg[context->fragment]),
> -			   sg[context->fragment].length,
> -			   context->fragment + 1 == scsi_sg_count(context->srb) ?
> +			   sg_virt(context->curr_sg),
> +			   context->curr_sg->length,
> +			   sg_is_last(context->curr_sg) ?
>  			   mts_data_done : mts_do_sg);
>  }
>  
> @@ -526,22 +524,20 @@ static void
>  mts_build_transfer_context(struct scsi_cmnd *srb, struct mts_desc* desc)
>  {
>  	int pipe;
> -	struct scatterlist * sg;
> -	
> +
>  	MTS_DEBUG_GOT_HERE();
>  
>  	desc->context.instance = desc;
>  	desc->context.srb = srb;
> -	desc->context.fragment = 0;
>  
>  	if (!scsi_bufflen(srb)) {
>  		desc->context.data = NULL;
>  		desc->context.data_length = 0;
>  		return;
>  	} else {
> -		sg = scsi_sglist(srb);
> -		desc->context.data = sg_virt(&sg[0]);
> -		desc->context.data_length = sg[0].length;
> +		desc->context.curr_sg = scsi_sglist(srb);
> +		desc->context.data = sg_virt(desc->context.curr_sg);
> +		desc->context.data_length = desc->context.curr_sg->length;
>  	}
>  

Would it not be better to initialize desc->context.curr_sg in both 
branches of this conditional?

-- 

>  
> diff --git a/drivers/usb/image/microtek.h b/drivers/usb/image/microtek.h
> index 66685e59241a..7bd5f4639c4a 100644
> --- a/drivers/usb/image/microtek.h
> +++ b/drivers/usb/image/microtek.h
> @@ -21,7 +21,7 @@ struct mts_transfer_context
>  	void *data;
>  	unsigned data_length;
>  	int data_pipe;
> -	int fragment;
> +	struct scatterlist *curr_sg;
>  
>  	u8 *scsi_status; /* status returned from ep_response after command completion */
>  };
> 
