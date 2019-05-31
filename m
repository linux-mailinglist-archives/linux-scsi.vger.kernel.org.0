Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 581B53175A
	for <lists+linux-scsi@lfdr.de>; Sat,  1 Jun 2019 00:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfEaWxy (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 31 May 2019 18:53:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45888 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726450AbfEaWxy (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 31 May 2019 18:53:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 47A023DE0E;
        Fri, 31 May 2019 22:53:53 +0000 (UTC)
Received: from ming.t460p (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 941A91724E;
        Fri, 31 May 2019 22:53:43 +0000 (UTC)
Date:   Sat, 1 Jun 2019 06:53:39 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Ming Lei <tom.leiming@gmail.com>, linux-scsi@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>,
        chenxiang <chenxiang66@hisilicon.com>
Subject: Re: [PATCH RFC] hisi_sas_v3: multiqueue support
Message-ID: <20190531225338.GA16190@ming.t460p>
References: <20190531074158.76923-1-hare@suse.de>
 <20190531082116.GA12106@ming.t460p>
 <e81ca95e-95af-1078-c523-701120dd4ca7@suse.de>
 <20190531084600.GB12106@ming.t460p>
 <57d87edb-e748-6223-bfb4-a67ead9a8bdd@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57d87edb-e748-6223-bfb4-a67ead9a8bdd@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 31 May 2019 22:53:53 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, May 31, 2019 at 10:42:12AM +0100, John Garry wrote:
> > > > > 
> > > > > -static int hisi_sas_slot_index_alloc(struct hisi_hba *hisi_hba,
> > > > > -				     struct scsi_cmnd *scsi_cmnd)
> > > > > +static int hisi_sas_slot_index_alloc(struct hisi_hba *hisi_hba)
> > > > >  {
> > > > >  	int index;
> > > > >  	void *bitmap = hisi_hba->slot_index_tags;
> > > > >  	unsigned long flags;
> > > > > 
> > > > > -	if (scsi_cmnd)
> > > > > -		return scsi_cmnd->request->tag;
> > > > > -
> > > > >  	spin_lock_irqsave(&hisi_hba->lock, flags);
> > > > >  	index = find_next_zero_bit(bitmap, hisi_hba->slot_index_count,
> > > > >  				   hisi_hba->last_slot_index + 1);
> > > > 
> > > > Then you switch to hisi_sas_slot_index_alloc() for allocating the unique
> > > > tag via spin_lock & find_next_zero_bit(). Do you think this way is more
> > > > efficient than blk-mq's sbitmap?
> 
> These are not fast path, as used only for TMF, internal IO, etc.

OK, looks I miss that.

> 
> Having said that, hopefully we can move to scsi_{get,put}_reserved_cmd()
> when available, so that the LLDD has to stop managing them.

Agree.

> 
> > > > 
> > > slot_index_alloc() is only used for commands which do _not_ have a tag
> > > (eg internal commands), or for v2 hardware which has weird allocation rules.
> > 
> > But this patch has switched to this allocation unconditionally for all commands:
> > 
> 
> As Hannes said, v2 had a few bugs which meant that we had to make a specific
> version of this function for that hw revision, cf.
> slot_index_alloc_quirk_v2_hw(), and it cannot use request queue tag.
> 
> But, indeed, we could consider sbitmap for v2 hw. I'm not sure if it would
> help, considering the weird rules.
> 
> > > -       if (scsi_cmnd)
> > > -               return scsi_cmnd->request->tag;
> > > -
> > 
> > Otherwise duplicated slot can be used from different blk-mq hw queue.
> > 
> > > 
> > > > The worsen thing is that V3's actual max queue depth is (4096 - 96), but
> > > > this patch claims that the device can support (4096 - 96) * 32 command
> > > > slots
> 
> To be clear about the hw, the hw supports max 4096 command tags and has 16

Is 4096 the max allowed host-wide command tags? Or per-queue's max commands
tags?

If it is per-queue's max command tags, V3 should be real MQ hardware,
otherwise it is still host wide. Otherwise, Hannes's patch can't work
because tag from different hw queue can be same.

> hw queues. The hw queue depth is configurable by software, and we configure
> it at 4096 per queue - same as max command tags - this is to support
> possibility of all commands using the same queue simultaneously.

Suppose 4096 is the host-wide command tags:

As Hannes's patch changed to allow each blk-mq hw queue to accept 4096 commands,
there will be big contention in driver, given now the actual .can_queue becomes
4096 * 32, and how to avoid the same tag from different hw queue? 

Thanks,
Ming
