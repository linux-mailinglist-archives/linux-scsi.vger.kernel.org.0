Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA9FF3A62F
	for <lists+linux-scsi@lfdr.de>; Sun,  9 Jun 2019 15:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbfFINlt (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 9 Jun 2019 09:41:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44166 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728777AbfFINlt (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 9 Jun 2019 09:41:49 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EEFF6223899;
        Sun,  9 Jun 2019 13:41:45 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6070F1967F;
        Sun,  9 Jun 2019 13:41:26 +0000 (UTC)
Date:   Sun, 9 Jun 2019 21:41:21 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Christoph Hellwig <hch@lst.de>, linux-scsi@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Ondrej Zary <linux@zary.sk>,
        Michael Schmitz <schmitzmic@gmail.com>
Subject: Re: [PATCH V3 0/3] scsi: three SG_CHAIN related fixes
Message-ID: <20190609134120.GA20067@ming.t460p>
References: <20190606083410.32243-1-ming.lei@redhat.com>
 <yq1ftommk66.fsf@oracle.com>
 <alpine.LNX.2.21.1906070956580.26@nippy.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.21.1906070956580.26@nippy.intranet>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Sun, 09 Jun 2019 13:41:48 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Finn,

On Fri, Jun 07, 2019 at 11:02:36AM +1000, Finn Thain wrote:
> On Thu, 6 Jun 2019, Martin K. Petersen wrote:
> 
> > 
> > Ming,
> > 
> > > Guenter reported scsi boot issue caused by commit c3288dd8c232 ("scsi:
> > > core: avoid pre-allocating big SGL for data").
> > 
> > Applied to 5.3/scsi-queue, thank you!
> > 
> 
> Thanks, that seems to fix the esp_scsi regression.
> 
> Am I right in thinking that commit c3288dd8c232 ("scsi: core: avoid 
> pre-allocating big SGL for data") has the effect that any scsi host with 
> sg_tablesize > 2 must now support chained sg lists?

Yeah, every driver should support chained SGL, in theory.

> 
> In commit 4af14d113bcf ("[PATCH] scsi: remove the use_clustering flag"), I 
> read that "setting the dma_boundary to PAGE_SIZE - 1 and the 
> max_segment_size to PAGE_SIZE" is sufficient to inhibit clustering. Is 
> that sufficient to inhibit chained sg lists for LLDs?

clustering just means that every segment(sg) can't cross page boundary, and
it is nothing to do with chained sg lists.

> 
> Does it follow that #define SCSI_INLINE_SG_CNT 2 is now the upper bound 
> for sg list entries (clamping sg_tablesize) for those LLDs (regardless 
> support for chained sg lists)?

No, 2 just means that size of the pre-allocated SGL.

> 
> Does commit c3288dd8c232 have similar implications for any LLD running on 
> an architecture with CONFIG_ARCH_NO_SG_CHAIN=y?

As you saw in this patch, SCSI_INLINE_SG_CNT becomes 0 on any ARCH
with CONFIG_ARCH_NO_SG_CHAIN=y.

Thanks,
Ming
