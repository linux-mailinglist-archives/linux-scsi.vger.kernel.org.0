Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA02943E5A
	for <lists+linux-scsi@lfdr.de>; Thu, 13 Jun 2019 17:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389120AbfFMPsw (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 13 Jun 2019 11:48:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40922 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731712AbfFMJQG (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 13 Jun 2019 05:16:06 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0C45F2E95B1;
        Thu, 13 Jun 2019 09:16:05 +0000 (UTC)
Received: from ming.t460p (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CB78B452D;
        Thu, 13 Jun 2019 09:15:49 +0000 (UTC)
Date:   Thu, 13 Jun 2019 17:15:44 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Benjamin Block <bblock@linux.ibm.com>
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
        Finn Thain <fthain@telegraphics.com.au>,
        Steffen Maier <maier@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH V2 09/15] s390: zfcp_fc: use sg helper to operate sgl
Message-ID: <20190613091543.GA8357@ming.t460p>
References: <20190613071335.5679-1-ming.lei@redhat.com>
 <20190613071335.5679-10-ming.lei@redhat.com>
 <20190613084135.GA18038@t480-pf1aa2c2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613084135.GA18038@t480-pf1aa2c2>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 13 Jun 2019 09:16:05 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, Jun 13, 2019 at 10:41:35AM +0200, Benjamin Block wrote:
> On Thu, Jun 13, 2019 at 03:13:29PM +0800, Ming Lei wrote:
> > The current way isn't safe for chained sgl, so use sg helper to
> > operate sgl.
> > 
> > Cc: Steffen Maier <maier@linux.ibm.com>
> > Cc: Benjamin Block <bblock@linux.ibm.com>
> > Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> > Cc: linux-s390@vger.kernel.org
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/s390/scsi/zfcp_fc.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/s390/scsi/zfcp_fc.c b/drivers/s390/scsi/zfcp_fc.c
> > index 33eddb02ee30..b018b61bd168 100644
> > --- a/drivers/s390/scsi/zfcp_fc.c
> > +++ b/drivers/s390/scsi/zfcp_fc.c
> > @@ -620,7 +620,7 @@ static void zfcp_fc_sg_free_table(struct scatterlist *sg, int count)
> >  {
> >  	int i;
> >  
> > -	for (i = 0; i < count; i++, sg++)
> > +	for (i = 0; i < count; i++, sg = sg_next(sg))
> >  		if (sg)
> >  			free_page((unsigned long) sg_virt(sg));
> >  		else
> > @@ -641,7 +641,7 @@ static int zfcp_fc_sg_setup_table(struct scatterlist *sg, int count)
> >  	int i;
> >  
> >  	sg_init_table(sg, count);
> > -	for (i = 0; i < count; i++, sg++) {
> > +	for (i = 0; i < count; i++, sg = sg_next(sg)) {
> >  		addr = (void *) get_zeroed_page(GFP_KERNEL);
> >  		if (!addr) {
> >  			zfcp_fc_sg_free_table(sg, i);
> 
> Color more confused. Where did the rest of this patch-set go? I don't
> see any other patches from this series of 15 on linux-scsi? Neither on
> my mail-account, nor on the archive https://marc.info/?l=linux-scsi
> 
> I was looking for a bit more context.

Yeah, I also can't find them on the archive, maybe there is issue
related with my email box.

I need to check it now.

Thanks,
Ming
