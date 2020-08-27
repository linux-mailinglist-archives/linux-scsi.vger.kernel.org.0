Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B96C2541D1
	for <lists+linux-scsi@lfdr.de>; Thu, 27 Aug 2020 11:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbgH0JSu (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 27 Aug 2020 05:18:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:33036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727897AbgH0JSq (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 27 Aug 2020 05:18:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 045052080C;
        Thu, 27 Aug 2020 09:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598519925;
        bh=eyGOZg/y/QcXFOJgZoOtuvDPU8rg6VzNRmKctKnURZ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=esepNnSVmYNkD0epnb+1wYHjyodtG/x2Cmq2wrlli5PQv1aBJjWgCRTPt/ft3mz+I
         s/wnvmq66qRfKMb4MQ4H9Na9SVr8U5ojM6LGZImkQMCmUvbnbLe31AMAI8dIVfLXiS
         wQZFDGO9yA5Zd9spv8Tlcm2nIEUNchgvtUYp/LyU=
Date:   Thu, 27 Aug 2020 11:18:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Denis Efremov <efremov@linux.com>,
        "David S. Miller" <davem@davemloft.net>,
        Song Liu <song@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH 01/19] char_dev: replace cdev_map with an xarray
Message-ID: <20200827091859.GA393660@kroah.com>
References: <20200826062446.31860-1-hch@lst.de>
 <20200826062446.31860-2-hch@lst.de>
 <20200826081905.GB1796103@kroah.com>
 <20200827085353.GA12111@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827085353.GA12111@lst.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, Aug 27, 2020 at 10:53:53AM +0200, Christoph Hellwig wrote:
> On Wed, Aug 26, 2020 at 10:19:05AM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Aug 26, 2020 at 08:24:28AM +0200, Christoph Hellwig wrote:
> > > None of the complicated overlapping regions bits of the kobj_map are
> > > required for the character device lookup, so just a trivial xarray
> > > instead.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > 
> > Really?  This is ok to use and just as fast?  If so, wonderful, it would
> > be great to clean up kobj_map users.
> 
> Xarrays provide pretty efficient as long as we have a unsigned long
> or smaller index (check, dev_t is small) and the indices are reasonable
> clustered (check, minors for the same major).  Memory usage will go down
> vs the probes, and lookup speed up.

Ok, great!

xarrays weren't around when this code was written (back in the 2.5
days).

> > > +	mutex_lock(&chrdevs_lock);
> > > +	for (i = 0; i < count; i++) {
> > > +		error = xa_insert(&cdev_map, dev + i, p, GFP_KERNEL);
> > > +		if (error)
> > > +			goto out_unwind;
> > > +	}
> > > +	mutex_unlock(&chrdevs_lock);
> > >  
> > >  	kobject_get(p->kobj.parent);
> > 
> > Can't you drop this kobject_get() too?
> 
> I'll have to drop it or add back the put on the delete side.  And
> I think the latter is safer for now, because..
> 
> > 
> > And also the "struct kobj" in struct cdev can be gone as well, as the
> > kobj_map was the only "real" user of this structure.  I know some
> > drivers liked to touch that field as well, but it never actually did
> > anything for them, so it was pointless, but it will take some 'make
> > allmodconfig' builds to flush them out.
> 
> I looked at it, but it does get registered and shows up in sysfs.

It does?  Where does that happen?  I see a bunch of kobject_init()
calls, but nothing that registers it in sysfs that I can see.

Note, this is not the kobject that shows up in /sys/dev/char/ as a
symlink, that comes from the driver core logic and is independent of the
cdev code.

The kobject does handle the structure lifetime rules, but that should be
able to be replaced with a simple kref instead.

> I don't really dare to touch this for now, as it can have huge
> implications.  Better done in a separate series (if we can actually do
> it at all).

Fair enough, I will be willing to tackle that once this gets merged, so
this is fine as-is.

thanks,

greg k-h
