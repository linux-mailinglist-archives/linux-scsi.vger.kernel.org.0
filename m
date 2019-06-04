Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 233AE34F76
	for <lists+linux-scsi@lfdr.de>; Tue,  4 Jun 2019 19:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfFDR7v (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 4 Jun 2019 13:59:51 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41980 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfFDR7v (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 4 Jun 2019 13:59:51 -0400
Received: by mail-pl1-f194.google.com with SMTP id s24so8500486plr.8
        for <linux-scsi@vger.kernel.org>; Tue, 04 Jun 2019 10:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tkd8rf60dxFiqwX+mUcju2a/Hvsj/O6tUj1He3SeoKs=;
        b=j4GP3XyTWQvxUB/wXHPPKcKV9zCPW08FOfKYqjlQda5LCmEElHdihQxqOsyEvRfTuA
         GmyyY1qx2GkT1tcNmB2tqq3Kds5lAfKqD9OKZVSofwBitGQEXWPIrhaZvEl+PltHuVE2
         vc+/RXTUwt5Rb+gw80SY71A4uPstL7s2b1RRJkN3hdHvODztoxn9stNMO0s/zJAV6ofu
         QmExjnxdt45BO0aZ6dCYLX3fdWiG3Rucs25OSAdjPYjFOrTRui5whtXhB92wM01zj+fj
         U26EknKzWo8CEi3NE1k5k3zpGtfafZ1st76X/Rpfr1lWSnS9y81xnlUkJqS8iPXi7ghD
         7CtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=tkd8rf60dxFiqwX+mUcju2a/Hvsj/O6tUj1He3SeoKs=;
        b=j+GyrHD+n3wp2gOUB0l0L5HJiuRF+JQbAzZlOb7ZmfZf1RtDZAeac/6YmEU2cZxrwn
         PuUNkzAQ9WybmTvISjz+lxAtZrK65fSw3Sql7IWUrXCkpP8zixSqW5vx/MM7deM3rve5
         pUgTHuhdw5vqA+8XWBlQmxOmmb/a/W4iT9aj5B+zEj9kxb5/nTYcxAY4LgEHJAT81WaM
         SmC9gGQt5Q+ddBhnDXToFe2krlNnWcTZYoYHt6NtZS3U+Dnw2/cLxCDsvQmo58IW3HUl
         2cZXDlxWJFspkbHH0/YDiQ1hmvwELCaI4RmIKILdOOH7cEnZ+K2tvyMX8qK+rMUXtAD7
         A+vQ==
X-Gm-Message-State: APjAAAUabSyLIi3Ap+BvnvXvaEFVdQ8BZ7h2STNdRqCAMqtTET3pLZN4
        y/xjaUjS9cPEgr4iGJjIh+o=
X-Google-Smtp-Source: APXvYqyfAM7NrDteEfvih31B2o2T2MkIbWYXsApoM0g2aPKhdhLE+YAlWowNqzJDnQ3kuhLom5g7cg==
X-Received: by 2002:a17:902:6b03:: with SMTP id o3mr38085628plk.85.1559671190491;
        Tue, 04 Jun 2019 10:59:50 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l63sm19857781pfl.181.2019.06.04.10.59.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 10:59:49 -0700 (PDT)
Date:   Tue, 4 Jun 2019 10:59:47 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 0/2] scsi: two SG_CHAIN related fixes
Message-ID: <20190604175947.GA31298@roeck-us.net>
References: <20190604082308.5575-1-ming.lei@redhat.com>
 <20190604133849.GA1880@roeck-us.net>
 <20190604151843.GC17248@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604151843.GC17248@ming.t460p>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, Jun 04, 2019 at 11:18:44PM +0800, Ming Lei wrote:
> Hi Guenter,
> 
> Thanks for your test and report!
> 
> On Tue, Jun 04, 2019 at 06:38:49AM -0700, Guenter Roeck wrote:
> > On Tue, Jun 04, 2019 at 04:23:06PM +0800, Ming Lei wrote:
> > > Hi,
> > > 
> > > Guenter reported scsi boot issue caused by commit c3288dd8c232
> > > ("scsi: core: avoid pre-allocating big SGL for data").
> > > 
> > > Turns out there are at least two issues.
> > > 
> > > The 1st patch fixes issue in case that NO_SG_CHAIN on some ARCHs,
> > > such as alpha, arm and parisc.
> > > 
> > > The 2nd patch makes esp scsi working with SG_CHAIN.
> > > 
> > 
> > Both patches applied on top of next-20190604.
> > 
> > Results on alpha:
> > 
> > Waiting for root device /dev/sda...
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 7 at mm/slab.h:359 kmem_cache_free+0x120/0x2a0
> > virt_to_cache: Object is not a Slab page!
> 
> Please apply the following patch against the posted two:
> 
> diff --git a/lib/sg_pool.c b/lib/sg_pool.c
> index 47eecbe094d8..e042a1722615 100644
> --- a/lib/sg_pool.c
> +++ b/lib/sg_pool.c
> @@ -122,7 +122,7 @@ int sg_alloc_table_chained(struct sg_table *table, int nents,
>  	}
>  
>  	/* User supposes that the 1st SGL includes real entry */
> -	if (nents_first_chunk == 1) {
> +	if (nents_first_chunk <= 1) {
>  		first_chunk = NULL;
>  		nents_first_chunk = 0;
>  	}
> 

That fixes the problem.

Thanks,
Guenter
