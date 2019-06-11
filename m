Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8972E3C098
	for <lists+linux-scsi@lfdr.de>; Tue, 11 Jun 2019 02:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbfFKA3T (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 10 Jun 2019 20:29:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51698 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728645AbfFKA3T (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 10 Jun 2019 20:29:19 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 13A8E30833C5;
        Tue, 11 Jun 2019 00:29:13 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D615360126;
        Tue, 11 Jun 2019 00:29:01 +0000 (UTC)
Date:   Tue, 11 Jun 2019 08:28:57 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     "Ewan D. Milne" <emilne@redhat.com>, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>, Jim Gill <jgill@vmware.com>,
        Cathy Avery <cavery@redhat.com>,
        Brian King <brking@us.ibm.com>,
        James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH 2/5] scsi: advansys: use sg helper to operate sgl
Message-ID: <20190611002856.GA32621@ming.t460p>
References: <20190610150317.29546-1-ming.lei@redhat.com>
 <20190610150317.29546-3-ming.lei@redhat.com>
 <1560191829.3698.8.camel@HansenPartnership.com>
 <ff5eba7c1ec7f5c6418c812ff24ac376d915188d.camel@redhat.com>
 <1560207747.3698.30.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560207747.3698.30.camel@HansenPartnership.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 11 Jun 2019 00:29:19 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, Jun 10, 2019 at 04:02:27PM -0700, James Bottomley wrote:
> On Mon, 2019-06-10 at 15:36 -0400, Ewan D. Milne wrote:
> > On Mon, 2019-06-10 at 11:37 -0700, James Bottomley wrote:
> > > On Mon, 2019-06-10 at 23:03 +0800, Ming Lei wrote:
> > > > The current way isn't safe for chained sgl, so use sgl helper to
> > > > operate sgl.
> > > 
> > > The advansys driver doesn't currently use a chained
> > > scatterlist.  In
> > > theory it could; the 
> > > 
> > > 	if (shost->sg_tablesize > SG_ALL) {
> > > 		shost->sg_tablesize = SG_ALL;
> > > 	}
> > > 
> > > At around line 11226 is what prevents it and that could be
> > > eliminated provided someone actually has the hardware to test.
> > > 
> > > However, provided drivers make the correct SG_ALL or less
> > > declaration, they're entitled to treat scatterlists as fully
> > > contiguous, so there's no real justification (beyond uniformity)
> > > for making it use the chain helpers.
> > > 
> > > James
> > > 
> > 
> > I thought the whole issue came about because Ming's earlier changes
> > to scsi_lib.c made the previously SG_CHUNK_SIZE scatterlist allocated
> > with the struct request much smaller, (SCSI_INLINE_SG_CNT is 2) so
> > everything needs to support it?
> 
> Um, well, I'm just going by the commit log.  If the problem is someone
> broke the SG_ALL no chaining assumption in an earlier commit, finger
> that as the buggy commit you're fixing rather than implying the drivers
> had a longstanding bug.  In fact, preferably do this work as a
> precursor to the original instead of leaving the drivers broken for a
> bisect.

Yeah, these drivers should have been converted from the beginning.

Let's discuss how to move on now:

1) we introduce the following patches to avoid big pre-allocation since
it won't be an accepted behaviour to consume GB maybe for nothing:

scsi: core: avoid pre-allocating big SGL for data
scsi: core: avoid pre-allocating big SGL for protection information
scsi: lib/sg_pool.c: improve APIs for allocating sg pool

2) it is flexible to reserve a small SGL for avoiding runtime
allocation, which needs driver to support chained SG.

3) I grep all scsi drivers, and found most of them are chained sgl
ready, except for the 6 drivers in this patchset and esi_scsi which
is fixed already.

Given the above 3 patches are just in 5.3/scsi-queue, I am fine with
either way:

1) revert the 3 first, then re-organize the whole patchset in correct
order(convert drivers first, then the 3 above drivers)

2) simply apply the 5 patches now

Any comments?

Thanks,
Ming
