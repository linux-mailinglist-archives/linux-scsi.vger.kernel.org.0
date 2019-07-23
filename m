Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBD3C71BB1
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jul 2019 17:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733112AbfGWPdT (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 23 Jul 2019 11:33:19 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:39354 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729570AbfGWPdT (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 23 Jul 2019 11:33:19 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 1374E8EE147;
        Tue, 23 Jul 2019 08:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1563895998;
        bh=BpRjUmHUdu3Q29+u0OMpk0BVieyFeETGZPNlSkyqEbs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=aXjyL4G7qx6akPE2ezoFMcUhcLIbwAqsbIoSGPouqR8p5XWDHeufpRHkwXCC52Pqk
         3BWRy4yfFLd8x5VIUh3I1WQFds/6VTlBsElgltd+/hwpfnsXC47CMj51b7dPqIKn0D
         YO06aHJlYWUPYoGOz6jWQLi1pIm02Nk5ThR/KRoM=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XU24is8yc8ax; Tue, 23 Jul 2019 08:33:17 -0700 (PDT)
Received: from jarvis.lan (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 57EC08EE0EF;
        Tue, 23 Jul 2019 08:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1563895997;
        bh=BpRjUmHUdu3Q29+u0OMpk0BVieyFeETGZPNlSkyqEbs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=tiA5n/WXq14sDr5bvg0AJ8VNLZHVQjdl0ftb4IZtyszcxOJ1c1XqexFpZ8FMZPJut
         nRbCpmon/Of4Lo3kva2e8/gfle9471a8UMZWOJzUL6aaqk5yK9CT4p/Bjl/u7B/glL
         OMKusvw5KpThDnFRC0lVo6b+Sleep5JmL9kMKW8A=
Message-ID: <1563895995.3609.10.camel@HansenPartnership.com>
Subject: Re: Linux 5.3-rc1
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Steffen Maier <maier@linux.ibm.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-scsi <linux-scsi@vger.kernel.org>
Date:   Tue, 23 Jul 2019 08:33:15 -0700
In-Reply-To: <1e05670d-9e28-1b1d-249d-743c736e6d63@linux.ibm.com>
References: <CAHk-=wiVjkTqzP6OppBuLQZ+t1mpRQC4T+Ho4Wg2sBAapKd--Q@mail.gmail.com>
         <20190722222126.GA27291@roeck-us.net>
         <1563839144.2504.5.camel@HansenPartnership.com>
         <4dc6ef77-afce-1c6d-add3-8df76332e672@roeck-us.net>
         <1563859682.2504.17.camel@HansenPartnership.com>
         <1e05670d-9e28-1b1d-249d-743c736e6d63@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, 2019-07-23 at 16:25 +0200, Steffen Maier wrote:
> On 7/23/19 7:28 AM, James Bottomley wrote:
> > On Mon, 2019-07-22 at 19:42 -0700, Guenter Roeck wrote:
> > > On 7/22/19 4:45 PM, James Bottomley wrote:
> > > > [linux-scsi added to cc]
> > > > On Mon, 2019-07-22 at 15:21 -0700, Guenter Roeck wrote:
> > > > > On Sun, Jul 21, 2019 at 02:33:38PM -0700, Linus Torvalds
> > > > > wrote:
> > > > > 
> > > > > [ ... ]
> > > > > > 
> > > > > > Go test,
> > > > > > 
> > > > > 
> > > > > Things looked pretty good until a few days ago.
> > > > > Unfortunately,
> > > > > the last few days brought in a couple of issues.
> > > > > 
> > > > > riscv:virt:defconfig:scsi[virtio]
> > > > > riscv:virt:defconfig:scsi[virtio-pci]
> > > > > 
> > > > > Boot tests crash with no useful backtrace. Bisect points to
> > > > > merge ac60602a6d8f ("Merge tag 'dma-mapping-5.3-1'"). Log is
> > > > > at
> > > > > https://kerneltests.org/builders/qemu-riscv64-master/builds/2
> > > > > 38/s
> > > > > teps
> > > > > /qemubuildcommand_1/logs/stdio
> > > > > 
> > > > > ppc:mpc8544ds:mpc85xx_defconfig:sata-sii3112
> > > > > ppc64:pseries:pseries_defconfig:sata-sii3112
> > > > > ppc64:pseries:pseries_defconfig:little:sata-sii3112
> > > > > ppc64:ppce500:corenet64_smp_defconfig:e5500:sata-sii3112
> > > > > 
> > > > > ata1: lost interrupt (Status 0x50)
> > > > > ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
> > > > > frozen
> > > > > ata1.00: failed command: READ DMA
> > > > > 
> > > > > and many similar errors. Boot ultimately times out. Bisect
> > > > > points
> > > > > to
> > > > > merge
> > > > > f65420df914a ("Merge tag 'scsi-fixes'").
> > > > > 
> > > > > Logs:
> > > > > https://kerneltests.org/builders/qemu-ppc64-master/builds/121
> > > > > 2/st
> > > > > eps/
> > > > > qemubuildcommand/logs/stdio
> > > > > https://kerneltests.org/builders/qemu-ppc-master/builds/1255/
> > > > > step
> > > > > s/qe
> > > > > mubuildcommand/logs/stdio
> > > > > 
> > > > > Guenter
> > > > > 
> > > > > ---
> > > > > riscv bisect log
> > > > > 
> > > > > # bad: [5f9e832c137075045d15cd6899ab0505cfb2ca4b] Linus 5.3-
> > > > > rc1
> > > > > # good: [bdd17bdef7d8da4d8eee254abb4c92d8a566bdc1] scsi:
> > > > > core:
> > > > > take
> > > > > the DMA max mapping size into account
> > > > > # first bad commit:
> > > > > [ac60602a6d8f6830dee89f4b87ee005f62eb7171]
> > > > > Merge
> > > > > tag 'dma-mapping-5.3-1' of
> > > > > git://git.infradead.org/users/hch/dma-
> > > > > mapping
> > > > When a bisect lands on a merge commit it usually indicates bad
> > > > interaction between two trees.  The way to find it is to do a
> > > > bisect,
> > > > but merge up to the other side of the scsi-fixes pull before
> > > > running
> > > > tests so the interaction is exposed in the bisect.
> > > > 
> > > 
> > > Can you provide instructions for dummies ?
> > 
> > do a man git-bisect and then follow the 'Automatically bisect with
> > temporary modifications' example.  You substitute
> > 168c79971b4a7be7011e73bf488b740a8e1135c8 for hot-fix
> > 
> > > > However my money is on:
> > > > 
> > > > 
> > > > commit bdd17bdef7d8da4d8eee254abb4c92d8a566bdc1
> > > > Author: Christoph Hellwig <hch@lst.de>
> > > > Date:   Mon Jun 17 14:19:54 2019 +0200
> > > > 
> > > >       scsi: core: take the DMA max mapping size into account
> > > >    
> > > > Now that I look at the code again:
> > > > 
> > > > 
> > > > +       shost->max_sectors = min_t(unsigned int, shost-
> > > > > max_sectors,
> > > > 
> > > > +                       dma_max_mapping_size(dev) <<
> > > > SECTOR_SHIFT);
> > > > 
> > > > That shift looks to be the wrong way around (should be >>).  I
> > > > bet
> > > > something is giving a very large number which becomes zero on
> > > > left
> > > > shift, meaning max_sectors gets set to zero.
> > > > 
> > > 
> > > That does indeed look bad, but changing it doesn't make a
> > > difference.
> > 
> > Odd, all the other changes are driver specific (and not in ATA)
> > apart
> > from this one:
> > 
> > commit 7ad388d8e4c703980b7018b938cdeec58832d78d
> > Author: Christoph Hellwig <hch@lst.de>
> > Date:   Mon Jun 17 14:19:53 2019 +0200
> > 
> >      scsi: core: add a host / host template field for the virt
> > boundary
> > 
> > 
> > I suppose it could be because the virt_boundary_mask isn't set, but
> > that should just set zero, which is what block usually does.
> 
> I found max_segment_size unexpectedly to be UINT_MAX with zfcp today
> in our CI. 
> My investigations are still very early, but I thought, I share a few
> thoughts 
> as I'm way too unfamiliar with the DMA business and thus hope for
> help.
> 
> Above commit introduced an unconditional call to
> blk_queue_virt_boundary(q, 
> shost->virt_boundary_mask), _after_ blk_queue_max_segment_size(q, 
> shost->max_segment_size).
> 
> Looking at the source, dma_set_max_seg_size() seems to
> unconditionally 
> overwrite max_segment_size:
> 
> > /**
> >  * blk_queue_virt_boundary - set boundary rules for bio merging
> >  * @q:  the request queue for the device
> >  * @mask:  the memory boundary mask
> >  **/
> > void blk_queue_virt_boundary(struct request_queue *q, unsigned long
> > mask)
> > {
> > 	q->limits.virt_boundary_mask = mask;
> > 
> > 	/*
> > 	 * Devices that require a virtual boundary do not support
> > scatter/gather
> > 	 * I/O natively, but instead require a descriptor list entry
> > for each
> > 	 * page (which might not be idential to the Linux
> > PAGE_SIZE).  Because
> > 	 * of that they are not limited by our notion of "segment
> > size".
> > 	 */
> > 	q->limits.max_segment_size = UINT_MAX;
> > }
> > EXPORT_SYMBOL(blk_queue_virt_boundary);
> 
> Wild guess: Do we need to make the call to blk_queue_virt_boundary()
> conditional?
> 
> Cf. https://www.spinics.net/lists/linux-scsi/msg131077.html ("[PATCH
> v2] iser: 
> explicitly set shost max_segment_size if non virtual boundary
> devices")
> 

Yes, I think so.  Can someone try this, or something like it.

Thanks,

James

---

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 9381171c2fc0..4715671a1537 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1793,7 +1793,8 @@ void __scsi_init_queue(struct Scsi_Host *shost, struct request_queue *q)
 	dma_set_seg_boundary(dev, shost->dma_boundary);
 
 	blk_queue_max_segment_size(q, shost->max_segment_size);
-	blk_queue_virt_boundary(q, shost->virt_boundary_mask);
+	if (shost->virt_boundary_mask)
+		blk_queue_virt_boundary(q, shost->virt_boundary_mask);
 	dma_set_max_seg_size(dev, queue_max_segment_size(q));
 
 	/*
