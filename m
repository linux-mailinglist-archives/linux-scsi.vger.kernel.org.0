Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 840CD5E67A
	for <lists+linux-scsi@lfdr.de>; Wed,  3 Jul 2019 16:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfGCOXP (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 3 Jul 2019 10:23:15 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:48388 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725830AbfGCOXO (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 3 Jul 2019 10:23:14 -0400
Received: (qmail 2846 invoked by uid 2102); 3 Jul 2019 10:23:13 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 3 Jul 2019 10:23:13 -0400
Date:   Wed, 3 Jul 2019 10:23:13 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Johannes Thumshirn <jthumshirn@suse.de>
cc:     Andrea Vai <andrea.vai@unipv.it>, Jens Axboe <axboe@kernel.dk>,
        <linux-usb@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        Hannes Reinecke <hare@suse.com>,
        Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@fb.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Slow I/O on USB media after commit f664a3cc17b7d0a2bc3b3ab96181e1029b0ec0e6
In-Reply-To: <20190703072934.GA4026@x250.microfocus.com>
Message-ID: <Pine.LNX.4.44L0.1907031020220.1547-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, 3 Jul 2019, Johannes Thumshirn wrote:

> On Wed, Jul 03, 2019 at 12:36:30AM +0200, Andrea Vai wrote:
> > On 02/07/19 13:51:17, Johannes Thumshirn wrote:
> > > On Tue, Jul 02, 2019 at 12:46:45PM +0200, Andrea Vai wrote:
> > > > Hi,
> > > >   I have a problem writing data to a USB pendrive, and it seems
> > > > kernel-related. With the help of Greg an Alan (thanks) and some
> > > > bisect, I found out the offending commit being
> > > > 
> > > > commit f664a3cc17b7d0a2bc3b3ab96181e1029b0ec0e6
> > > >
> > > > [...]
> > > 
> > > Hi,
> > > 
> > > Can you please check what IO scheduler you have set for your USB pendrive?
> > > 
> > > i.e. with:
> > > cat /sys/block/$DISK/queue/scheduler
> > >
> > 
> > # cat /sys/block/sdf/queue/scheduler
> > [mq-deadline] none
> 
> One thing you can try as well is building a kernel with CONFIG_IOSCHED_BFQ and
> use it. Deadline is probably not the best choice for a slow drive.

Andrea, another thing you could try is to collect a usbmon trace under 
one of the "slow" kernels.  Follow the instructions in 
Documentation/usb/usbmon.txt.  I think you could kill the file-copy 
operation after just a couple of seconds; that should provide enough 
trace information to help see what causes the slowdown.

(If you want, do the same test with a "fast" kernel and then we'll 
compare the results.)

Alan Stern

