Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9E6318563
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Feb 2021 07:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhBKGw2 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 11 Feb 2021 01:52:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:53156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229678AbhBKGwT (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 11 Feb 2021 01:52:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A422964D9A;
        Thu, 11 Feb 2021 06:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613026291;
        bh=/bqBzgsBwYu/4OWo8yzcEBn/7GQQ8Lv9Niz3kBW/VWM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1QJjeqSTOBLk8sQWqKjJZqLaZA933MTVDA3vE1bYAgp+pbNmVJam/IcUXg46nXzRS
         0QAaaMpQZBWtebp8LATsgI2tZhJyAmpU8GsDdu24fK4SVwpUYtaH367sVMUzU83kaK
         xjGz6S7Uyc+RmTHL23aiYf1ZlyJ6NfCJdu1OZR+s=
Date:   Thu, 11 Feb 2021 07:51:28 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bodo Stroesser <bostroesser@gmail.com>
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH 1/2] uio: Add late_release callback to uio_info
Message-ID: <YCTT8HQ7PobTyUz4@kroah.com>
References: <20210210194031.7422-1-bostroesser@gmail.com>
 <20210210194031.7422-2-bostroesser@gmail.com>
 <YCQ4aEz29P26ZxaL@kroah.com>
 <7bc9eef9-0a9e-58a9-11f1-2c32010c70f0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bc9eef9-0a9e-58a9-11f1-2c32010c70f0@gmail.com>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Feb 10, 2021 at 08:57:11PM +0100, Bodo Stroesser wrote:
> On 10.02.21 20:47, Greg Kroah-Hartman wrote:
> > On Wed, Feb 10, 2021 at 08:40:30PM +0100, Bodo Stroesser wrote:
> > > If uio_unregister_device() is called while userspace daemon
> > > still holds the uio device open or mmap'ed, uio will not call
> > > uio_info->release() on later close / munmap.
> > > 
> > > At least one user of uio (tcmu) should not free resources (pages
> > > allocated by tcmu which are mmap'ed to userspace) while uio
> > > device still is open, because that could cause userspace daemon
> > > to be killed by SIGSEGV or SIGBUS. Therefore tcmu frees the
> > > pages only after it called uio_unregister_device _and_ the device
> > > was closed.
> > > So, uio not calling uio_info->release causes trouble.
> > > tcmu currently leaks memory in that case.
> > > 
> > > Just waiting for userspace daemon to exit before calling
> > > uio_unregister_device I think is not the right solution, because
> > > daemon would not become aware of kernel code wanting to destroy
> > > the uio device.
> > > After uio_unregister_device was called, reading or writing the
> > > uio device returns -EIO, which normally results in daemon exit.
> > > 
> > > This patch adds new callback pointer 'late_release' to struct
> > > uio_info. If uio user sets this callback, it will be called by
> > > uio if userspace closes / munmaps the device after
> > > uio_unregister_device was executed.
> > > 
> > > That way we can use uio_unregister_device() to notify userspace
> > > that we are going to destroy the device, but still get a call
> > > to late_release when uio device is finally closed.
> > > 
> > > Signed-off-by: Bodo Stroesser <bostroesser@gmail.com>
> > > ---
> > >   Documentation/driver-api/uio-howto.rst | 10 ++++++++++
> > >   drivers/uio/uio.c                      |  4 ++++
> > >   include/linux/uio_driver.h             |  4 ++++
> > >   3 files changed, 18 insertions(+)
> > > 
> > > diff --git a/Documentation/driver-api/uio-howto.rst b/Documentation/driver-api/uio-howto.rst
> > > index 907ffa3b38f5..a2d57a7d623a 100644
> > > --- a/Documentation/driver-api/uio-howto.rst
> > > +++ b/Documentation/driver-api/uio-howto.rst
> > > @@ -265,6 +265,16 @@ the members are required, others are optional.
> > >      function. The parameter ``irq_on`` will be 0 to disable interrupts
> > >      and 1 to enable them.
> > > +-  ``int (*late_release)(struct uio_info *info, struct inode *inode)``:
> > > +   Optional. If you define your own :c:func:`open()`, you will
> > > +   in certain cases also want a custom :c:func:`late_release()`
> > > +   function. If uio device is unregistered - by calling
> > > +   :c:func:`uio_unregister_device()` - while it is open or mmap'ed by
> > > +   userspace, the custom :c:func:`release()` function will not be
> > > +   called when userspace later closes the device. An optionally
> > > +   specified :c:func:`late_release()` function will be called in that
> > > +   situation.
> > > +
> > >   Usually, your device will have one or more memory regions that can be
> > >   mapped to user space. For each region, you have to set up a
> > >   ``struct uio_mem`` in the ``mem[]`` array. Here's a description of the
> > > diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
> > > index ea96e319c8a0..0b2636f8d373 100644
> > > --- a/drivers/uio/uio.c
> > > +++ b/drivers/uio/uio.c
> > > @@ -532,6 +532,8 @@ static int uio_release(struct inode *inode, struct file *filep)
> > >   	mutex_lock(&idev->info_lock);
> > >   	if (idev->info && idev->info->release)
> > >   		ret = idev->info->release(idev->info, inode);
> > > +	else if (idev->late_info && idev->late_info->late_release)
> > > +		ret = idev->late_info->late_release(idev->late_info, inode);
> > >   	mutex_unlock(&idev->info_lock);
> > 
> > Why can't release() be called here?  Why doesn't your driver define a
> > release() if it cares about this information?  Why do we need 2
> > different callbacks that fire at exactly the same time?
> > 
> > This feels really wrong.
> > 
> > greg k-h
> > 
> 
> tcmu has a release callback. But uio can't call it after
> uio_unregister_device was executed, because in uio_unregister_device
> uio sets the uio_device::info to NULL.

As it should because the driver could then be gone.  It should NEVER
call back into it again.

> So, uio would never call both callbacks for the same release action,
> but would call release before uio_unregister_device is executed, and
> late_release after that.

That's not ok.

> Of course it would be good for tcmu if uio would call uio_info:release even
> after uio_unregister_device, but changing this AFAICS could cause
> trouble in other drivers using uio.

You are confusing two different lifetime rules here it seems.  One is
the char device and one is the struct device.  They work independently
as different users affect them.

So if one is removed from the system, do not try to keep a callback to
it, otherwise you will crash.

And why is scsi using the uio driver in the first place?  That feels
really odd to me.  Why not just make a "real" driver if you want to
somehow tie these two lifetimes together?

thanks,

greg k-h
