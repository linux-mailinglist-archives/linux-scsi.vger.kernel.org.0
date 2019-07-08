Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81BE2618AB
	for <lists+linux-scsi@lfdr.de>; Mon,  8 Jul 2019 03:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbfGHBBt (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 7 Jul 2019 21:01:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34184 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727163AbfGHBBt (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 7 Jul 2019 21:01:49 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1326181DFE;
        Mon,  8 Jul 2019 01:01:48 +0000 (UTC)
Received: from ming.t460p (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A273019C77;
        Mon,  8 Jul 2019 01:01:39 +0000 (UTC)
Date:   Mon, 8 Jul 2019 09:01:35 +0800
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
Message-ID: <20190708010134.GA7248@ming.t460p>
References: <cc54d51ec7a203eceb76d62fc230b378b1da12e1.camel@unipv.it>
 <20190702120112.GA19890@ming.t460p>
 <20190702223931.GB3735@brian.unipv.it>
 <20190703020119.GA23872@ming.t460p>
 <20190703051117.GA6458@brian.unipv.it>
 <20190703063603.GA32123@ming.t460p>
 <20190706093327.GA31927@brian.unipv.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190706093327.GA31927@brian.unipv.it>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 08 Jul 2019 01:01:48 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sat, Jul 06, 2019 at 11:33:27AM +0200, Andrea Vai wrote:
> On 03/07/19 14:36:05, Ming Lei wrote:
> > On Wed, Jul 03, 2019 at 07:11:17AM +0200, Andrea Vai wrote:
> > > On 03/07/19 10:01:23, Ming Lei wrote:
> > > > On Wed, Jul 03, 2019 at 12:39:31AM +0200, Andrea Vai wrote:
> > > > > On 02/07/19 20:01:13, Ming Lei wrote:
> > > > > > On Tue, Jul 02, 2019 at 12:46:45PM +0200, Andrea Vai wrote:
> > > > > > > Hi,
> > > > > > >   I have a problem writing data to a USB pendrive, and it seems
> > > > > > > kernel-related. With the help of Greg an Alan (thanks) and some
> > > > > > > bisect, I found out the offending commit being
> > > > > > > 
> > > > > > > commit f664a3cc17b7d0a2bc3b3ab96181e1029b0ec0e6
> > > > > > > 
> > > > > > >  [...]    
> > > > > > >     
> > [...]
> > Then could you install bcc package and collect the IO trace?
> > 
> > 	sudo /usr/share/bcc/tools/biosnoop | grep sdN
> > 
> > sdN is your USB disk device name.
> 
> The command runs forever (or at least for hours) without giving any output through "|grep sdf". The device is connected, but not mounted. Maybe I should run the command with the device mounted? Or while performing the test?
> The command itself seems to work, as /usr/share/bcc/tools/biosnoop | tee -a biosnoop.txt produces an output file sized about some MB in some hours. 
> 
> What should I do?

1) run the bcc biosnoop trace in one terminal after mounting the fs on the USB dirve

2) start the write test in another teminal

3) wait for 10 seconds, and stop the bcc trace via ctrl^ + C, then post the bcc biosnoop
trace log


Thanks, 
Ming
