Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7586832A95
	for <lists+linux-scsi@lfdr.de>; Mon,  3 Jun 2019 10:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbfFCIQs (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 3 Jun 2019 04:16:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33392 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727571AbfFCIQs (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 3 Jun 2019 04:16:48 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4BE8830C1211;
        Mon,  3 Jun 2019 08:16:41 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 739815D9CD;
        Mon,  3 Jun 2019 08:16:31 +0000 (UTC)
Date:   Mon, 3 Jun 2019 16:16:25 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Ming Lei <tom.leiming@gmail.com>,
        John Garry <john.garry@huawei.com>, linux-scsi@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH RFC] hisi_sas_v3: multiqueue support
Message-ID: <20190603081621.GC11812@ming.t460p>
References: <20190531074158.76923-1-hare@suse.de>
 <20190531082116.GA12106@ming.t460p>
 <e81ca95e-95af-1078-c523-701120dd4ca7@suse.de>
 <20190531084600.GB12106@ming.t460p>
 <f7e184d4-3d90-2c36-84b8-702105dccafb@suse.de>
 <20190531230620.GB16190@ming.t460p>
 <fc049d0a-a7e3-894a-0680-574d86603ea5@suse.de>
 <20190603073733.GA11812@ming.t460p>
 <f0901773-0faf-7a4e-bb17-3e584de00c4f@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0901773-0faf-7a4e-bb17-3e584de00c4f@suse.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 03 Jun 2019 08:16:48 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, Jun 03, 2019 at 09:46:39AM +0200, Hannes Reinecke wrote:
> On 6/3/19 9:37 AM, Ming Lei wrote:
> > On Mon, Jun 03, 2019 at 08:08:18AM +0200, Hannes Reinecke wrote:
> >> On 6/1/19 1:06 AM, Ming Lei wrote:
> >>> On Fri, May 31, 2019 at 12:26:56PM +0200, Hannes Reinecke wrote:
> >>>> On 5/31/19 10:46 AM, Ming Lei wrote:
> >> [ .. ]
> >>>> First we check for the 'slot_index_alloc()' callback to handle weird v2
> >>>> allocation rules, _then_ we look for a tag, and only if we do _not_ have
> >>>> a tag we're using the bitmap.
> >>>
> >>> OK, looks I miss the above change.
> >>>
> >>>> And the bitmap is already correctly sized, as otherwise we'd have a
> >>>> clash between internal and tagged I/O commands even now.
> >>>
> >>> But now the big problem is in the following two line code:
> >>>
> >>> +       else if (blk_tag != (u32)-1)
> >>> +               rc = blk_mq_unique_tag_to_tag(blk_tag);
> >>>
> >>> Request from different blk-mq hw queue has same tag returned from
> >>> blk_mq_unique_tag_to_tag().
> >>>
> >> Yes, but the sbitmap allocator will ensure that each command will get a
> >> unique tag.
> > 
> > Each hw queue has independent sbitmap allocator, so commands with same
> > tag can come from different hw queue.
> > 
> It does not for SCSI.
> See below.
> 
> > So you meant this RFC patch depends on the host-wide tags patchset I
> > posted?
> > 
> >>
> >>> Now the biggest question is that if V3 hw supports per-queue tags,
> >>> If yes, it should be real MQ hardware, otherwise I guess commands with
> >>> same tag at the same time may not work for host-wide tags.
> >>>
> >>
> >> Of course you can't have different commands with the same tag. But the
> >> sbitmap allocator prevents this from happening, as for host-wide tags
> >> the tagset is _shared_ between all devices, so the sbitmap allocator
> >> will only ever run on _one_ tagset for all commands.
> > 
> > But blk-mq doesn't support host-wide tags yet, so how can this single
> > patch work?
> > 
> Wrong. It does:
> 
> struct request_queue *scsi_mq_alloc_queue(struct scsi_device *sdev)
> {
> 	sdev->request_queue = blk_mq_init_queue(&sdev->host->tag_set);
> 	if (IS_ERR(sdev->request_queue))
> 		return NULL;
> 
> 	sdev->request_queue->queuedata = sdev;
> 	__scsi_init_queue(sdev->host, sdev->request_queue);
> 	blk_queue_flag_set(QUEUE_FLAG_SCSI_PASSTHROUGH, sdev->request_queue);
> 	return sdev->request_queue;
> }
> 
> 
> IE every scsi device is using the tagset from the host.

Looks we are not in the same page, and you misunderstood two concepts:
scsi's host-wide tagset, and the new host-tags of BLK_MQ_F_HOST_TAGS.

I admit that the new flag of BLK_MQ_F_HOST_TAGS is misleading.

Now let me clarify it a bit:

1) the current SCSI hostwide tags means all LUNs share the host tagset,
but the tagset may include multiple hw queues, and each hw queue still
has independent tags, that is why blk-mq provides blk_mq_unique_tag().
In short, each LUN's hw queue has independent tags.


2) some drivers(hisi_v3 hw, hpsa, megraid_sas, mpt3sas) only support
single hw queue, but has multiple reply queue which can avoid CPU
lockup, so we are working towards converting the private reply queue
into blk-mq hw queue. That is what BLK_MQ_F_HOST_TAGS covers.

Now you think 1) is enough for converting the private reply queue into
blk-mq hw queue, that is definitely not correct since blk-mq MQ doesn't
support shared tags among hw queues.

Please take a look at the patch you posted before, and you will see
the point.

https://marc.info/?l=linux-block&m=149132580511346&w=2




Thanks,
Ming
