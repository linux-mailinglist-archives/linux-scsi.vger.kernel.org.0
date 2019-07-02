Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 056755CEFE
	for <lists+linux-scsi@lfdr.de>; Tue,  2 Jul 2019 14:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfGBMBf (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 2 Jul 2019 08:01:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40400 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbfGBMBf (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 2 Jul 2019 08:01:35 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 456A1307D974;
        Tue,  2 Jul 2019 12:01:25 +0000 (UTC)
Received: from ming.t460p (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C41F617114;
        Tue,  2 Jul 2019 12:01:18 +0000 (UTC)
Date:   Tue, 2 Jul 2019 20:01:13 +0800
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
Message-ID: <20190702120112.GA19890@ming.t460p>
References: <cc54d51ec7a203eceb76d62fc230b378b1da12e1.camel@unipv.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc54d51ec7a203eceb76d62fc230b378b1da12e1.camel@unipv.it>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 02 Jul 2019 12:01:29 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, Jul 02, 2019 at 12:46:45PM +0200, Andrea Vai wrote:
> Hi,
>   I have a problem writing data to a USB pendrive, and it seems
> kernel-related. With the help of Greg an Alan (thanks) and some
> bisect, I found out the offending commit being
> 
> commit f664a3cc17b7d0a2bc3b3ab96181e1029b0ec0e6
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Thu Nov 1 16:36:27 2018 -0600
> 
>     scsi: kill off the legacy IO path
>     
>     This removes the legacy (non-mq) IO path for SCSI.
>     
> So, here I am to notify you about the problem and ask you if I can
> help in any way to work it out and fix it.
> 
> The problem is that if I copy a file from the internal SATA HD to the
> pendrive, it takes ~10 times to complete (in respect of the time
> needed with the patch reverted).
> 
> The test script, which I use to detect if the problem triggers or not,
> is:
> 
> #!/bin/bash
> logfile=...
> uname -a | tee -a $logfile
> echo -n "Begin: " | tee -a $logfile
> date | tee -a $logfile
> touch inizio
> SECONDS=0
> mount UUID="05141239-4ea5-494d-aa91-acd67db89ce5" /mnt/pendrive
> cp /NoBackup/buttare/testfile /mnt/pendrive
> umount /mnt/pendrive
> tempo=$SECONDS
> touch fine
> echo -n "...end: " | tee -a $logfile
> date | tee -a $logfile
> echo "It took $tempo seconds!" | tee -a $logfile
> 
> If I run the test with a 512MB file it takes >10min vs. half a minute.
> 
> The problem is still present in last tested git (cloned today in the
> morning).
> 
> You can see the previous discussion that lead to these results at
> 
> https://marc.info/?t=155922230700001&r=1&w=2

One possible reason may be related with too small 'nr_requests', could
you apply the following command and see if any difference can be made?

echo 32 > /sys/block/sdN/queue/nr_requests


Thanks,
Ming
