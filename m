Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E455649636
	for <lists+linux-scsi@lfdr.de>; Tue, 18 Jun 2019 02:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbfFRAP6 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 17 Jun 2019 20:15:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51602 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726568AbfFRAP6 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 17 Jun 2019 20:15:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C4ECDC057F3E;
        Tue, 18 Jun 2019 00:15:57 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2DA7D91F33;
        Tue, 18 Jun 2019 00:15:41 +0000 (UTC)
Date:   Tue, 18 Jun 2019 08:15:37 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     "Juergen E . Fischer" <fischer@norbit.de>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>, Jim Gill <jgill@vmware.com>,
        Cathy Avery <cavery@redhat.com>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Brian King <brking@us.ibm.com>,
        James Smart <james.smart@broadcom.com>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-usb@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Benjamin Block <bblock@linux.ibm.com>
Subject: Re: [PATCH V4 11/16] scsi: aha152x: use sg helper to operate
 scatterlist
Message-ID: <20190618001536.GA5774@ming.t460p>
References: <20190617030349.26415-1-ming.lei@redhat.com>
 <20190617030349.26415-12-ming.lei@redhat.com>
 <alpine.LNX.2.21.1906171334330.168@nippy.intranet>
 <alpine.LNX.2.21.1906180901160.284@nippy.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.21.1906180901160.284@nippy.intranet>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 18 Jun 2019 00:15:58 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, Jun 18, 2019 at 09:35:48AM +1000, Finn Thain wrote:
> On Mon, 17 Jun 2019, Finn Thain wrote:
> 
> > On Mon, 17 Jun 2019, Ming Lei wrote:
> > 
> > > Use the scatterlist iterators and remove direct indexing of the
> > > scatterlist array.
> > > 
> > > This way allows us to pre-allocate one small scatterlist, which can be
> > > chained with one runtime allocated scatterlist if the pre-allocated one
> > > isn't enough for the whole request.
> > > 
> > > Finn added the change to replace SCp.buffers_residual with sg_is_last()
> > > for fixing updating it, and the similar change has been applied on
> > > NCR5380.c
> > > 
> > > Cc: Finn Thain <fthain@telegraphics.com.au>
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > 
> > Reviewed-by: Finn Thain <fthain@telegraphics.com.au>
> > 
> 
> I have to retract that. I think this patch is still wrong.
> 
> GETSTCNT() appears to be the number of bytes sent since datao_init() and 
> not the number of bytes sent since the start of the command. (Note the 
> CLRSTCNT in datao_init() which appears to clear the transfer counter.) I 
> don't see how the existing datao_end() could work otherwise. (Juergen?)
> 
> So here's another attempt. Ming, I'd be happy to take the blame/credit (in 
> the form of a From tag etc.) in case you don't want to spend more time on 
> this.

Sure, will do that in V5.

Thanks,
Ming
