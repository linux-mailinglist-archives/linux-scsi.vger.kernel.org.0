Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2654D34BFA
	for <lists+linux-scsi@lfdr.de>; Tue,  4 Jun 2019 17:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfFDPTO (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 4 Jun 2019 11:19:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34550 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727783AbfFDPTO (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 4 Jun 2019 11:19:14 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 988C8C04BD44;
        Tue,  4 Jun 2019 15:19:07 +0000 (UTC)
Received: from ming.t460p (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A0AB1001F41;
        Tue,  4 Jun 2019 15:18:49 +0000 (UTC)
Date:   Tue, 4 Jun 2019 23:18:44 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 0/2] scsi: two SG_CHAIN related fixes
Message-ID: <20190604151843.GC17248@ming.t460p>
References: <20190604082308.5575-1-ming.lei@redhat.com>
 <20190604133849.GA1880@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604133849.GA1880@roeck-us.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 04 Jun 2019 15:19:14 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Guenter,

Thanks for your test and report!

On Tue, Jun 04, 2019 at 06:38:49AM -0700, Guenter Roeck wrote:
> On Tue, Jun 04, 2019 at 04:23:06PM +0800, Ming Lei wrote:
> > Hi,
> > 
> > Guenter reported scsi boot issue caused by commit c3288dd8c232
> > ("scsi: core: avoid pre-allocating big SGL for data").
> > 
> > Turns out there are at least two issues.
> > 
> > The 1st patch fixes issue in case that NO_SG_CHAIN on some ARCHs,
> > such as alpha, arm and parisc.
> > 
> > The 2nd patch makes esp scsi working with SG_CHAIN.
> > 
> 
> Both patches applied on top of next-20190604.
> 
> Results on alpha:
> 
> Waiting for root device /dev/sda...
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 7 at mm/slab.h:359 kmem_cache_free+0x120/0x2a0
> virt_to_cache: Object is not a Slab page!

Please apply the following patch against the posted two:

diff --git a/lib/sg_pool.c b/lib/sg_pool.c
index 47eecbe094d8..e042a1722615 100644
--- a/lib/sg_pool.c
+++ b/lib/sg_pool.c
@@ -122,7 +122,7 @@ int sg_alloc_table_chained(struct sg_table *table, int nents,
 	}
 
 	/* User supposes that the 1st SGL includes real entry */
-	if (nents_first_chunk == 1) {
+	if (nents_first_chunk <= 1) {
 		first_chunk = NULL;
 		nents_first_chunk = 0;
 	}

Thanks,
Ming
