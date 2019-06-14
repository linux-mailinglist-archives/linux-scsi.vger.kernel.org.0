Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE8A845524
	for <lists+linux-scsi@lfdr.de>; Fri, 14 Jun 2019 08:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbfFNG56 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 14 Jun 2019 02:57:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34620 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbfFNG56 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 14 Jun 2019 02:57:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F32B259463;
        Fri, 14 Jun 2019 06:57:57 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7AC7A39C3;
        Fri, 14 Jun 2019 06:57:43 +0000 (UTC)
Date:   Fri, 14 Jun 2019 14:57:38 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
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
Message-ID: <20190614065737.GB24393@ming.t460p>
References: <20190614025316.7360-1-ming.lei@redhat.com>
 <20190614025316.7360-8-ming.lei@redhat.com>
 <alpine.LNX.2.21.1906141536000.33@nippy.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.21.1906141536000.33@nippy.intranet>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 14 Jun 2019 06:57:58 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, Jun 14, 2019 at 03:39:10PM +1000, Finn Thain wrote:
> On Fri, 14 Jun 2019, Ming Lei wrote:
> 
> > Use the scatterlist iterators and remove direct indexing of the
> > scatterlist array.
> > 
> > This way allows us to pre-allocate one small scatterlist, which can be
> > chained with one runtime allocated scatterlist if the pre-allocated one
> > isn't enough for the whole request.
> > 
> > Cc: Oliver Neukum <oliver@neukum.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: linux-usb@vger.kernel.org
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/usb/image/microtek.c | 20 ++++++++------------
> >  drivers/usb/image/microtek.h |  2 +-
> >  2 files changed, 9 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/usb/image/microtek.c b/drivers/usb/image/microtek.c
> > index 607be1f4fe27..0a57c2cc8e5a 100644
> > --- a/drivers/usb/image/microtek.c
> > +++ b/drivers/usb/image/microtek.c
> > @@ -488,7 +488,6 @@ static void mts_command_done( struct urb *transfer )
> >  
> >  static void mts_do_sg (struct urb* transfer)
> >  {
> > -	struct scatterlist * sg;
> >  	int status = transfer->status;
> >  	MTS_INT_INIT();
> >  
> > @@ -500,13 +499,12 @@ static void mts_do_sg (struct urb* transfer)
> >  		mts_transfer_cleanup(transfer);
> >          }
> >  
> > -	sg = scsi_sglist(context->srb);
> > -	context->fragment++;
> > +	context->curr_sg = sg_next(context->curr_sg);
> >  	mts_int_submit_urb(transfer,
> >  			   context->data_pipe,
> > -			   sg_virt(&sg[context->fragment]),
> > -			   sg[context->fragment].length,
> > -			   context->fragment + 1 == scsi_sg_count(context->srb) ?
> > +			   sg_virt(context->curr_sg),
> > +			   context->curr_sg->length,
> > +			   sg_is_last(context->curr_sg) ?
> >  			   mts_data_done : mts_do_sg);
> >  }
> >  
> > @@ -526,22 +524,20 @@ static void
> >  mts_build_transfer_context(struct scsi_cmnd *srb, struct mts_desc* desc)
> >  {
> >  	int pipe;
> > -	struct scatterlist * sg;
> > -	
> > +
> >  	MTS_DEBUG_GOT_HERE();
> >  
> >  	desc->context.instance = desc;
> >  	desc->context.srb = srb;
> > -	desc->context.fragment = 0;
> >  
> >  	if (!scsi_bufflen(srb)) {
> >  		desc->context.data = NULL;
> >  		desc->context.data_length = 0;
> >  		return;
> >  	} else {
> > -		sg = scsi_sglist(srb);
> > -		desc->context.data = sg_virt(&sg[0]);
> > -		desc->context.data_length = sg[0].length;
> > +		desc->context.curr_sg = scsi_sglist(srb);
> > +		desc->context.data = sg_virt(desc->context.curr_sg);
> > +		desc->context.data_length = desc->context.curr_sg->length;
> >  	}
> >  
> 
> Would it not be better to initialize desc->context.curr_sg in both 
> branches of this conditional?

I think either way is fine given desc->context.curr_sg is used only
if 'context->data' isn't NULL, see mts_command_done().

So I'd keep the patch as it is.

Thanks,
Ming
