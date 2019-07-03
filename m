Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC865DEE7
	for <lists+linux-scsi@lfdr.de>; Wed,  3 Jul 2019 09:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfGCH3j (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 3 Jul 2019 03:29:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:54346 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726670AbfGCH3j (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 3 Jul 2019 03:29:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B9713AFB0;
        Wed,  3 Jul 2019 07:29:35 +0000 (UTC)
Date:   Wed, 3 Jul 2019 09:29:34 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Andrea Vai <andrea.vai@unipv.it>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-usb@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        Hannes Reinecke <hare@suse.com>,
        Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@fb.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Slow I/O on USB media after commit
 f664a3cc17b7d0a2bc3b3ab96181e1029b0ec0e6
Message-ID: <20190703072934.GA4026@x250.microfocus.com>
References: <cc54d51ec7a203eceb76d62fc230b378b1da12e1.camel@unipv.it>
 <20190702115117.GC4463@x250.microfocus.com>
 <20190702223630.GA3735@brian.unipv.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190702223630.GA3735@brian.unipv.it>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Jul 03, 2019 at 12:36:30AM +0200, Andrea Vai wrote:
> On 02/07/19 13:51:17, Johannes Thumshirn wrote:
> > On Tue, Jul 02, 2019 at 12:46:45PM +0200, Andrea Vai wrote:
> > > Hi,
> > >   I have a problem writing data to a USB pendrive, and it seems
> > > kernel-related. With the help of Greg an Alan (thanks) and some
> > > bisect, I found out the offending commit being
> > > 
> > > commit f664a3cc17b7d0a2bc3b3ab96181e1029b0ec0e6
> > >
> > > [...]
> > 
> > Hi,
> > 
> > Can you please check what IO scheduler you have set for your USB pendrive?
> > 
> > i.e. with:
> > cat /sys/block/$DISK/queue/scheduler
> >
> 
> # cat /sys/block/sdf/queue/scheduler
> [mq-deadline] none

One thing you can try as well is building a kernel with CONFIG_IOSCHED_BFQ and
use it. Deadline is probably not the best choice for a slow drive.

Byte,
	Johannes
-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
