Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5AB43BCFC
	for <lists+linux-scsi@lfdr.de>; Mon, 10 Jun 2019 21:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389044AbfFJTgw (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 10 Jun 2019 15:36:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56458 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388900AbfFJTgw (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 10 Jun 2019 15:36:52 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EFA9F88304;
        Mon, 10 Jun 2019 19:36:46 +0000 (UTC)
Received: from emilne (unknown [10.18.25.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 721DC1001B11;
        Mon, 10 Jun 2019 19:36:38 +0000 (UTC)
Message-ID: <ff5eba7c1ec7f5c6418c812ff24ac376d915188d.camel@redhat.com>
Subject: Re: [PATCH 2/5] scsi: advansys: use sg helper to operate sgl
From:   "Ewan D. Milne" <emilne@redhat.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Ming Lei <ming.lei@redhat.com>, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>, Jim Gill <jgill@vmware.com>,
        Cathy Avery <cavery@redhat.com>,
        Brian King <brking@us.ibm.com>,
        James Smart <james.smart@broadcom.com>
Date:   Mon, 10 Jun 2019 15:36:37 -0400
In-Reply-To: <1560191829.3698.8.camel@HansenPartnership.com>
References: <20190610150317.29546-1-ming.lei@redhat.com>
         <20190610150317.29546-3-ming.lei@redhat.com>
         <1560191829.3698.8.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 10 Jun 2019 19:36:52 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, 2019-06-10 at 11:37 -0700, James Bottomley wrote:
> On Mon, 2019-06-10 at 23:03 +0800, Ming Lei wrote:
> > The current way isn't safe for chained sgl, so use sgl helper to
> > operate sgl.
> 
> The advansys driver doesn't currently use a chained scatterlist.  In
> theory it could; the 
> 
> 	if (shost->sg_tablesize > SG_ALL) {
> 		shost->sg_tablesize = SG_ALL;
> 	}
> 
> At around line 11226 is what prevents it and that could be eliminated
> provided someone actually has the hardware to test.
> 
> However, provided drivers make the correct SG_ALL or less declaration,
> they're entitled to treat scatterlists as fully contiguous, so there's
> no real justification (beyond uniformity) for making it use the chain
> helpers.
> 
> James
> 

I thought the whole issue came about because Ming's earlier changes
to scsi_lib.c made the previously SG_CHUNK_SIZE scatterlist allocated
with the struct request much smaller, (SCSI_INLINE_SG_CNT is 2) so
everything needs to support it?

-Ewan
