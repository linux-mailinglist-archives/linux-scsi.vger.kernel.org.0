Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE105DB46
	for <lists+linux-scsi@lfdr.de>; Wed,  3 Jul 2019 04:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfGCCBy (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 2 Jul 2019 22:01:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50448 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbfGCCBy (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 2 Jul 2019 22:01:54 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 90F7D368E3;
        Wed,  3 Jul 2019 02:01:53 +0000 (UTC)
Received: from ming.t460p (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 737371001B01;
        Wed,  3 Jul 2019 02:01:33 +0000 (UTC)
Date:   Wed, 3 Jul 2019 10:01:23 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Andrea Vai <andrea.vai@unipv.it>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-usb@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        Hannes Reinecke <hare@suse.com>,
        Omar Sandoval <osandov@fb.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Slow I/O on USB media after commit
 f664a3cc17b7d0a2bc3b3ab96181e1029b0ec0e6
Message-ID: <20190703020119.GA23872@ming.t460p>
References: <cc54d51ec7a203eceb76d62fc230b378b1da12e1.camel@unipv.it>
 <20190702120112.GA19890@ming.t460p>
 <20190702223931.GB3735@brian.unipv.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702223931.GB3735@brian.unipv.it>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 03 Jul 2019 02:01:54 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Jul 03, 2019 at 12:39:31AM +0200, Andrea Vai wrote:
> On 02/07/19 20:01:13, Ming Lei wrote:
> > On Tue, Jul 02, 2019 at 12:46:45PM +0200, Andrea Vai wrote:
> > > Hi,
> > >   I have a problem writing data to a USB pendrive, and it seems
> > > kernel-related. With the help of Greg an Alan (thanks) and some
> > > bisect, I found out the offending commit being
> > > 
> > > commit f664a3cc17b7d0a2bc3b3ab96181e1029b0ec0e6
> > > 
> > >  [...]    
> > >     
> > 
> > One possible reason may be related with too small 'nr_requests', could
> > you apply the following command and see if any difference can be made?
> > 
> > echo 32 > /sys/block/sdN/queue/nr_requests
> 
> I applied it (echo 32 > /sys/block/sdf/queue/nr_requests), ran the test again, and still failed. I assumed I didn't have to build the kernel again, did I? (sorry but I am not skilled)
> 

You don't need to build kernel.

I just run same write test on one slow usb drive in my laptop, which
runs '5.1.11-200.fc29.x86_64', and can't reproduce your issue, maybe it
depends on your drive.

Could you collect the queue limits sysfs log via the following command?

	find /sys/block/sdN/queue -type f -exec grep -aH . {} \;

Thanks,
Ming
