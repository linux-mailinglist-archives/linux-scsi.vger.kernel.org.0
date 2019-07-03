Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB9D5DE1C
	for <lists+linux-scsi@lfdr.de>; Wed,  3 Jul 2019 08:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfGCGgY (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 3 Jul 2019 02:36:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38796 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbfGCGgY (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 3 Jul 2019 02:36:24 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 39B133084243;
        Wed,  3 Jul 2019 06:36:24 +0000 (UTC)
Received: from ming.t460p (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 794CA7841E;
        Wed,  3 Jul 2019 06:36:10 +0000 (UTC)
Date:   Wed, 3 Jul 2019 14:36:05 +0800
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
Message-ID: <20190703063603.GA32123@ming.t460p>
References: <cc54d51ec7a203eceb76d62fc230b378b1da12e1.camel@unipv.it>
 <20190702120112.GA19890@ming.t460p>
 <20190702223931.GB3735@brian.unipv.it>
 <20190703020119.GA23872@ming.t460p>
 <20190703051117.GA6458@brian.unipv.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703051117.GA6458@brian.unipv.it>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 03 Jul 2019 06:36:24 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Jul 03, 2019 at 07:11:17AM +0200, Andrea Vai wrote:
> On 03/07/19 10:01:23, Ming Lei wrote:
> > On Wed, Jul 03, 2019 at 12:39:31AM +0200, Andrea Vai wrote:
> > > On 02/07/19 20:01:13, Ming Lei wrote:
> > > > On Tue, Jul 02, 2019 at 12:46:45PM +0200, Andrea Vai wrote:
> > > > > Hi,
> > > > >   I have a problem writing data to a USB pendrive, and it seems
> > > > > kernel-related. With the help of Greg an Alan (thanks) and some
> > > > > bisect, I found out the offending commit being
> > > > > 
> > > > > commit f664a3cc17b7d0a2bc3b3ab96181e1029b0ec0e6
> > > > > 
> > > > >  [...]    
> > > > >     
> > > > 
> > > > One possible reason may be related with too small 'nr_requests', could
> > > > you apply the following command and see if any difference can be made?
> > > > 
> > > > echo 32 > /sys/block/sdN/queue/nr_requests
> > > 
> > > I applied it (echo 32 > /sys/block/sdf/queue/nr_requests), ran the test again, and still failed. I assumed I didn't have to build the kernel again, did I? (sorry but I am not skilled)
> > > 
> > 
> > You don't need to build kernel.
> > 
> > I just run same write test on one slow usb drive in my laptop, which
> > runs '5.1.11-200.fc29.x86_64', and can't reproduce your issue, maybe it
> > depends on your drive.
> > 
> > Could you collect the queue limits sysfs log via the following command?
> > 
> > 	find /sys/block/sdN/queue -type f -exec grep -aH . {} \;
> >
> 
> # find /sys/block/sdf/queue -type f -exec grep -aH . {} ;
> /sys/block/sdf/queue/io_poll_delay:-1
> /sys/block/sdf/queue/max_integrity_segments:0
> /sys/block/sdf/queue/zoned:none
> /sys/block/sdf/queue/scheduler:[mq-deadline] none
> /sys/block/sdf/queue/io_poll:0
> /sys/block/sdf/queue/discard_zeroes_data:0
> /sys/block/sdf/queue/minimum_io_size:512
> /sys/block/sdf/queue/nr_zones:0
> /sys/block/sdf/queue/write_same_max_bytes:0
> /sys/block/sdf/queue/max_segments:2048
> /sys/block/sdf/queue/dax:0
> /sys/block/sdf/queue/physical_block_size:512
> /sys/block/sdf/queue/logical_block_size:512
> /sys/block/sdf/queue/io_timeout:30000
> /sys/block/sdf/queue/nr_requests:2
> /sys/block/sdf/queue/write_cache:write through/sys/block/sdf/queue/max_segment_size:4294967295
> /sys/block/sdf/queue/rotational:1
> /sys/block/sdf/queue/discard_max_bytes:0
> /sys/block/sdf/queue/add_random:1
> /sys/block/sdf/queue/discard_max_hw_bytes:0
> /sys/block/sdf/queue/optimal_io_size:0
> /sys/block/sdf/queue/chunk_sectors:0
> /sys/block/sdf/queue/iosched/front_merges:1
> /sys/block/sdf/queue/iosched/read_expire:500
> /sys/block/sdf/queue/iosched/fifo_batch:16
> /sys/block/sdf/queue/iosched/write_expire:5000/sys/block/sdf/queue/iosched/writes_starved:2
> /sys/block/sdf/queue/read_ahead_kb:128
> /sys/block/sdf/queue/max_discard_segments:1
> /sys/block/sdf/queue/write_zeroes_max_bytes:0
> /sys/block/sdf/queue/nomerges:0
> /sys/block/sdf/queue/wbt_lat_usec:75000
> /sys/block/sdf/queue/fua:0
> /sys/block/sdf/queue/discard_granularity:0
> /sys/block/sdf/queue/rq_affinity:1
> /sys/block/sdf/queue/max_sectors_kb:120
> /sys/block/sdf/queue/hw_sector_size:512
> /sys/block/sdf/queue/max_hw_sectors_kb:120
> /sys/block/sdf/queue/iostats:1 

The above is basically same with my USB drive's queue setting, and looks
all are fine.

BTW, 'rotational' shouldn't be set for USB drive, except for USB HDD,
but that shouldn't be related with your issue.

Then could you install bcc package and collect the IO trace?

	sudo /usr/share/bcc/tools/biosnoop | grep sdN

sdN is your USB disk device name.

Thanks,
Ming
