Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D635520A2
	for <lists+linux-scsi@lfdr.de>; Tue, 25 Jun 2019 04:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730475AbfFYCas (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 24 Jun 2019 22:30:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52962 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726774AbfFYCar (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 24 Jun 2019 22:30:47 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D6ED63086204;
        Tue, 25 Jun 2019 02:30:46 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 29B1C60BE2;
        Tue, 25 Jun 2019 02:30:32 +0000 (UTC)
Date:   Tue, 25 Jun 2019 10:30:28 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Steffen Maier <maier@linux.ibm.com>, linux-scsi@vger.kernel.org,
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
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH V5 10/16] s390: zfcp_fc: use sg helper to operate
 scatterlist
Message-ID: <20190625023027.GF23777@ming.t460p>
References: <20190618013757.22401-1-ming.lei@redhat.com>
 <20190618013757.22401-11-ming.lei@redhat.com>
 <95bfa1fb-d0eb-fc61-ecc0-001ae52a326f@linux.ibm.com>
 <20190625011902.GA23777@ming.t460p>
 <alpine.LNX.2.21.1906251157160.8@nippy.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.21.1906251157160.8@nippy.intranet>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 25 Jun 2019 02:30:47 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, Jun 25, 2019 at 12:01:24PM +1000, Finn Thain wrote:
> > diff --git a/drivers/s390/scsi/zfcp_dbf.c b/drivers/s390/scsi/zfcp_dbf.c
> > index dccdb41bed8c..c7129f5234f0 100644
> > --- a/drivers/s390/scsi/zfcp_dbf.c
> > +++ b/drivers/s390/scsi/zfcp_dbf.c
> > @@ -552,7 +552,7 @@ static u16 zfcp_dbf_san_res_cap_len_if_gpn_ft(char *tag,
> >  		if (x % (ZFCP_FC_GPN_FT_ENT_PAGE + 1))
> >  			acc++;
> >  		else
> > -			acc = sg_virt(++resp_entry);
> > +			acc = sg_virt(resp_entry = sg_next(resp_entry));
> 
> Shouldn't that be,
> 
> 			acc = sg_virt(sg_next(resp_entry));

resp_entry needs to be updated.

> 
> >  
> >  		last = acc->fp_flags & FC_NS_FID_LAST;
> >  	}
> > diff --git a/drivers/s390/scsi/zfcp_fc.c b/drivers/s390/scsi/zfcp_fc.c
> > index b018b61bd168..5048812ce660 100644
> > --- a/drivers/s390/scsi/zfcp_fc.c
> > +++ b/drivers/s390/scsi/zfcp_fc.c
> > @@ -742,7 +742,7 @@ static int zfcp_fc_eval_gpn_ft(struct zfcp_fc_req *fc_req,
> >  		if (x % (ZFCP_FC_GPN_FT_ENT_PAGE + 1))
> >  			acc++;
> >  		else
> > -			acc = sg_virt(++sg);
> > +			acc = sg_virt(sg = sg_next(sg));
> 
> and
> 
> 			acc = sg_virt(sg_next(sg));
> 
> ?

Same with above.

Thanks,
Ming
