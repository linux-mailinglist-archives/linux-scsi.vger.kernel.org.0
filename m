Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5308F5CEE0
	for <lists+linux-scsi@lfdr.de>; Tue,  2 Jul 2019 13:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfGBLvU (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 2 Jul 2019 07:51:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:39554 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726544AbfGBLvT (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 2 Jul 2019 07:51:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6D100B116;
        Tue,  2 Jul 2019 11:51:18 +0000 (UTC)
Date:   Tue, 2 Jul 2019 13:51:17 +0200
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
Message-ID: <20190702115117.GC4463@x250.microfocus.com>
References: <cc54d51ec7a203eceb76d62fc230b378b1da12e1.camel@unipv.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc54d51ec7a203eceb76d62fc230b378b1da12e1.camel@unipv.it>
User-Agent: Mutt/1.10.1 (2018-07-13)
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

Hi,

Can you please check what IO scheduler you have set for your USB pendrive?

i.e. with:
cat /sys/block/$DISK/queue/scheduler

Thanks,
	Johannes
-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
