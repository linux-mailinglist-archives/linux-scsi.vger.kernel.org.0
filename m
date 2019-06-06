Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A937D36E0B
	for <lists+linux-scsi@lfdr.de>; Thu,  6 Jun 2019 10:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfFFIDQ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 6 Jun 2019 04:03:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50058 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbfFFIDQ (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 6 Jun 2019 04:03:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1821EB2DD3;
        Thu,  6 Jun 2019 08:03:03 +0000 (UTC)
Received: from ming.t460p (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DB5425DF4C;
        Thu,  6 Jun 2019 08:02:54 +0000 (UTC)
Date:   Thu, 6 Jun 2019 16:02:50 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Christoph Hellwig <hch@lst.de>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH V2 1/3] scsi: lib/sg_pool.c: clear 'first_chunk' in case
 of no pre-allocation
Message-ID: <20190606080249.GC28677@ming.t460p>
References: <20190605010623.12325-1-ming.lei@redhat.com>
 <20190605010623.12325-2-ming.lei@redhat.com>
 <f099b22a-23e8-abe6-1526-6ceed2a4ebde@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f099b22a-23e8-abe6-1526-6ceed2a4ebde@acm.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 06 Jun 2019 08:03:15 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Jun 05, 2019 at 08:45:58AM -0700, Bart Van Assche wrote:
> On 6/4/19 6:06 PM, Ming Lei wrote:
> > If user doesn't ask to pre-allocate by passing zero 'nents_first_chunk' to
> > sg_alloc_table_chained, we need to make sure that 'first_chunk' is cleared.
> > Otherwise, __sg_alloc_table() still may think that the 1st SGL should
> > be from the pre-allocation.
> > 
> > Fixes the issue by clearing 'first_chunk' in sg_alloc_table_chained() if
> > 'nents_first_chunk' is zero.
> > 
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Bart Van Assche <bvanassche@acm.org>
> > Cc: Ewan D. Milne <emilne@redhat.com>
> > Cc: Hannes Reinecke <hare@suse.com>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Fixes: c3288dd8c232 ("scsi: core: avoid pre-allocating big SGL for data")
> 
> Shouldn't the "Fixes:" tag be left out from this patch? I don't think that

Here the 'Fixes' means it is a fix on the code(sg_alloc_table_chained) itself.

> this patch by itself fixes anything. Isn't this patch something that is
> necessary to make patch 2/3 in this series work?

Yeah, it is needed for patch 2/3.

> How about indicating that by mentioning it in the commit message?

OK.

> 
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Tested-by: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >   lib/sg_pool.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/lib/sg_pool.c b/lib/sg_pool.c
> > index 47eecbe094d8..e042a1722615 100644
> > --- a/lib/sg_pool.c
> > +++ b/lib/sg_pool.c
> > @@ -122,7 +122,7 @@ int sg_alloc_table_chained(struct sg_table *table, int nents,
> >   	}
> >   	/* User supposes that the 1st SGL includes real entry */
> > -	if (nents_first_chunk == 1) {
> > +	if (nents_first_chunk <= 1) {
> >   		first_chunk = NULL;
> >   		nents_first_chunk = 0;
> >   	}
> 
> How about also updating the kernel-doc header above sg_alloc_table_chained()
> such that it is made clear that @first_chunk is ignored if nents_first_chunk
> <= 1 ? Otherwise this patch looks fine to me.

OK.

Thanks,
Ming
