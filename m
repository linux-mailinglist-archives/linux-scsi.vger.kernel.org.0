Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3655747D97
	for <lists+linux-scsi@lfdr.de>; Mon, 17 Jun 2019 10:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbfFQIvM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 17 Jun 2019 04:51:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38822 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727323AbfFQIvM (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 17 Jun 2019 04:51:12 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 314743086235;
        Mon, 17 Jun 2019 08:51:06 +0000 (UTC)
Received: from ming.t460p (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 484AA4DA35;
        Mon, 17 Jun 2019 08:50:37 +0000 (UTC)
Date:   Mon, 17 Jun 2019 16:50:32 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>, Jim Gill <jgill@vmware.com>,
        Cathy Avery <cavery@redhat.com>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Brian King <brking@us.ibm.com>,
        James Smart <james.smart@broadcom.com>,
        "Juergen E . Fischer" <fischer@norbit.de>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-usb@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Benjamin Block <bblock@linux.ibm.com>
Subject: Re: [PATCH V4 05/16] scsi: ipr: use sg helper to operate scatterlist
Message-ID: <20190617085027.GA31002@ming.t460p>
References: <20190617030349.26415-1-ming.lei@redhat.com>
 <20190617030349.26415-6-ming.lei@redhat.com>
 <20190617082423.GE7455@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617082423.GE7455@lst.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 17 Jun 2019 08:51:11 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, Jun 17, 2019 at 10:24:23AM +0200, Christoph Hellwig wrote:
> > -	for (i = 0; i < (len / bsize_elem); i++, buffer += bsize_elem) {
> > -		struct page *page = sg_page(&scatterlist[i]);
> > +	for (i = 0; i < (len / bsize_elem); i++, sg = sg_next(sg), buffer += bsize_elem) {
> 
> Please split the overly long line.

Fine.

> 
> > +		struct page *page = sg_page(sg);
> >  
> >  		kaddr = kmap(page);
> >  		memcpy(kaddr, buffer, bsize_elem);
> >  		kunmap(page);
> 
> Not new in this patch, but this is buggy as scatterlists could have
> offsets.  This should probably use the scatterlist.c copy helper
> eventually.

This sglist is allocated by driver, see ipr_copy_ucode_buffer(), so
offset for any element is zero.

Thanks,
Ming
