Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 080F3232068
	for <lists+linux-scsi@lfdr.de>; Wed, 29 Jul 2020 16:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgG2OcO (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 Jul 2020 10:32:14 -0400
Received: from netrider.rowland.org ([192.131.102.5]:47953 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726449AbgG2OcO (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 29 Jul 2020 10:32:14 -0400
Received: (qmail 1533731 invoked by uid 1000); 29 Jul 2020 10:32:13 -0400
Date:   Wed, 29 Jul 2020 10:32:13 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     Bart Van Assche <bvanassche@acm.org>, jejb@linux.ibm.com,
        Can Guo <cang@codeaurora.org>, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm
Subject: Re: [PATCH] scsi: sd: add runtime pm to open / release
Message-ID: <20200729143213.GC1530967@rowland.harvard.edu>
References: <20200706164135.GE704149@rowland.harvard.edu>
 <d0ed766b-88b0-5ad5-9c10-a4c3b2f994e3@puri.sm>
 <20200728200243.GA1511887@rowland.harvard.edu>
 <f3958758-afce-8add-1692-2a3bbcc49f73@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3958758-afce-8add-1692-2a3bbcc49f73@puri.sm>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Jul 29, 2020 at 04:12:22PM +0200, Martin Kepplinger wrote:
> On 28.07.20 22:02, Alan Stern wrote:
> > On Tue, Jul 28, 2020 at 09:02:44AM +0200, Martin Kepplinger wrote:
> >> Hi Alan,
> >>
> >> Any API cleanup is of course welcome. I just wanted to remind you that
> >> the underlying problem: broken block device runtime pm. Your initial
> >> proposed fix "almost" did it and mounting works but during file access,
> >> it still just looks like a runtime_resume is missing somewhere.
> > 
> > Well, I have tested that proposed fix several times, and on my system 
> > it's working perfectly.  When I stop accessing a drive it autosuspends, 
> > and when I access it again it gets resumed and works -- as you would 
> > expect.
> 
> that's weird. when I mount, everything looks good, "sda1". But as soon
> as I cd to the mountpoint and do "ls" (on another SD card "ls" works but
> actual file reading leads to the exact same errors), I get:
> 
> [   77.474632] sd 0:0:0:0: [sda] tag#0 UNKNOWN(0x2003) Result:
> hostbyte=0x00 driverbyte=0x08 cmd_age=0s
> [   77.474647] sd 0:0:0:0: [sda] tag#0 Sense Key : 0x6 [current]
> [   77.474655] sd 0:0:0:0: [sda] tag#0 ASC=0x28 ASCQ=0x0
> [   77.474667] sd 0:0:0:0: [sda] tag#0 CDB: opcode=0x28 28 00 00 00 60
> 40 00 00 01 00

This error report comes from the SCSI layer, not the block layer.

> [   77.474678] blk_update_request: I/O error, dev sda, sector 24640 op
> 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
> [   77.485836] sd 0:0:0:0: [sda] tag#0 device offline or changed
> [   77.491628] blk_update_request: I/O error, dev sda, sector 24641 op
> 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
> [   77.502275] sd 0:0:0:0: [sda] tag#0 device offline or changed
> [   77.508051] blk_update_request: I/O error, dev sda, sector 24642 op
> 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
> [   77.518651] sd 0:0:0:0: [sda] tag#0 device offline or changed
> (...)
> [   77.947653] sd 0:0:0:0: [sda] tag#0 device offline or changed
> [   77.953434] FAT-fs (sda1): Directory bread(block 16448) failed
> [   77.959333] sd 0:0:0:0: [sda] tag#0 device offline or changed
> [   77.965118] FAT-fs (sda1): Directory bread(block 16449) failed
> [   77.971014] sd 0:0:0:0: [sda] tag#0 device offline or changed
> [   77.976802] FAT-fs (sda1): Directory bread(block 16450) failed
> [   77.982698] sd 0:0:0:0: [sda] tag#0 device offline or changed
> (...)
> [   78.384929] FAT-fs (sda1): Filesystem has been set read-only
> [  103.070973] sd 0:0:0:0: [sda] tag#0 device offline or changed
> [  103.076751] print_req_error: 118 callbacks suppressed
> [  103.076760] blk_update_request: I/O error, dev sda, sector 9748 op
> 0x1:(WRITE) flags 0x100000 phys_seg 1 prio class 0
> [  103.087428] Buffer I/O error on dev sda1, logical block 1556, lost
> async page write
> [  103.095309] sd 0:0:0:0: [sda] tag#0 device offline or changed
> [  103.101123] blk_update_request: I/O error, dev sda, sector 17162 op
> 0x1:(WRITE) flags 0x100000 phys_seg 1 prio class 0
> [  103.111883] Buffer I/O error on dev sda1, logical block 8970, lost
> async page write

I can't tell why you're getting that error.  In one of my tests the 
device returned the same kind of error status (Sense Key = 6, ASC = 
0x28) but the operation was then retried successfully.  Perhaps the 
problem lies in the device you are testing.

> >> As we need to have that working at some point, I might look into it, but
> >> someone who has experience in the block layer can surely do it more
> >> efficiently.
> > 
> > I suspect that any problems you still face are caused by something else.
> > 
> 
> I then formatted sda1 to ext2 (on the runtime suspend system testing
> your patch) and that seems to have worked!
> 
> Again accessing the mountpoint then yield the very same "device offline
> or changed" errors.
> 
> What kind of device are you testing? You should be easily able to
> reproduce this using an "sd" device.

I tested two devices: a SanDisk Cruzer USB flash drive and a 
g-mass-storage gadget running under dummy-hcd.  They each showed up as 
/dev/sdb on my system.

I haven't tried testing with an SD card.  If you have any specific 
sequence of commands you would like me to run, let me know.

> The problems must lie in the different other drivers we use I guess.

Or the devices.  Have you tried testing with a USB flash drive?

Alan Stern
