Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 793F641B2D
	for <lists+linux-scsi@lfdr.de>; Wed, 12 Jun 2019 06:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbfFLE3H (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 12 Jun 2019 00:29:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35236 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727286AbfFLE3H (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 12 Jun 2019 00:29:07 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 31154C057E7D;
        Wed, 12 Jun 2019 04:29:07 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 164DB60BF1;
        Wed, 12 Jun 2019 04:28:50 +0000 (UTC)
Date:   Wed, 12 Jun 2019 12:28:46 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        "Ewan D. Milne" <emilne@redhat.com>, linux-scsi@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>, Jim Gill <jgill@vmware.com>,
        Cathy Avery <cavery@redhat.com>,
        Brian King <brking@us.ibm.com>,
        James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH 2/5] scsi: advansys: use sg helper to operate sgl
Message-ID: <20190612042845.GB19198@ming.t460p>
References: <20190610150317.29546-3-ming.lei@redhat.com>
 <1560191829.3698.8.camel@HansenPartnership.com>
 <ff5eba7c1ec7f5c6418c812ff24ac376d915188d.camel@redhat.com>
 <1560207747.3698.30.camel@HansenPartnership.com>
 <20190611002856.GA32621@ming.t460p>
 <yq1k1drfzrq.fsf@oracle.com>
 <20190612013930.GC17522@ming.t460p>
 <1560306453.20425.19.camel@HansenPartnership.com>
 <yq1lfy7eby8.fsf@oracle.com>
 <20190612033441.GA19198@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612033441.GA19198@ming.t460p>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 12 Jun 2019 04:29:07 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Jun 12, 2019 at 11:34:41AM +0800, Ming Lei wrote:
> On Tue, Jun 11, 2019 at 11:09:51PM -0400, Martin K. Petersen wrote:
> > 
> > James,
> > 
> > > Studying the issue further, I think we have to do the rebase.  The
> > > problem is that any driver which hasn't been updated can be persuaded
> > > to walk of the end of the request and dereference the next struct
> > > request.  It's not impossible for userspace to set up both requests,
> > > so it looks like this could be used at least to leak information from
> > > the kernel if not exploit it outright.  I think that means we have to
> > > have every driver updated before this goes in.
> > 
> > I agree in theory. Although, regardless of ordering of the commits, this
> > would still be a single pull request for 5.3. So it's not like there
> > would be a kernel release with this flaw exposed. Assuming all drivers
> > get fixed.
> > 
> > Hence my concerns about breaking bisection. Not in terms of being able
> > to build, but in terms of being able to test intermediate commits on
> > systems with the affected drivers.
> > 
> > Ming: Please audit all drivers, including ones that live outside of
> > drivers/scsi but which use the midlayer such a s390, USB, libata,
> > etc. Just to make sure we've got all of them covered.
> 
> OK, I am studying coccinelle, and should figure out one semantic patch
> for covering all these drivers.

Looks the following semantic patch is working, if you are fine with it,
I will start to work out patches with this coccinelle semantic path:

@@ struct scatterlist *p; @@
(
- p++
+ p = sg_next(p)
|
- p--
+ p = sg_non_exist_prev(p)
|
- p += 1
+ p = sg_next(p)
|
- p -= 1
+ p = sg_non_exist_prev(p)
|
- p = p + 1
+ p = sg_next(p)
|
- p = p - 1
+ p = sg_non_exit_prev(p)
)

@@
struct scatterlist *p;
expression data != 0;
@@
- p[data]
+ '!!!!!!use sg iterator helper!!!!!!'

@@
struct scatterlist[] p;
expression data != 0;
@@
- p[data]
+ '!!!!!!use sg iterator helper!!!!!!'

Thanks,
Ming
