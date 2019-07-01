Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9722D3D2
	for <lists+linux-scsi@lfdr.de>; Wed, 29 May 2019 04:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfE2C3M (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 28 May 2019 22:29:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60196 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbfE2C3M (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 28 May 2019 22:29:12 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DCCB781F12;
        Wed, 29 May 2019 02:29:09 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DC46B1972A;
        Wed, 29 May 2019 02:28:59 +0000 (UTC)
Date:   Wed, 29 May 2019 10:28:53 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Keith Busch <keith.busch@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 5/5] blk-mq: Wait for for hctx inflight requests on
 CPU unplug
Message-ID: <20190529022852.GA21398@ming.t460p>
References: <20190527150207.11372-1-ming.lei@redhat.com>
 <20190527150207.11372-6-ming.lei@redhat.com>
 <45daceb4-fb88-a835-8cc6-cd4c4d7cf42d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45daceb4-fb88-a835-8cc6-cd4c4d7cf42d@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 29 May 2019 02:29:12 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, May 28, 2019 at 05:50:40PM +0100, John Garry wrote:
> On 27/05/2019 16:02, Ming Lei wrote:
> > Managed interrupts can not migrate affinity when their CPUs are offline.
> > If the CPU is allowed to shutdown before they're returned, commands
> > dispatched to managed queues won't be able to complete through their
> > irq handlers.
> > 
> > Wait in cpu hotplug handler until all inflight requests on the tags
> > are completed or timeout. Wait once for each tags, so we can save time
> > in case of shared tags.
> > 
> > Based on the following patch from Keith, and use simple delay-spin
> > instead.
> > 
> > https://lore.kernel.org/linux-block/20190405215920.27085-1-keith.busch@intel.com/
> > 
> > Some SCSI devices may have single blk_mq hw queue and multiple private
> > completion queues, and wait until all requests on the private completion
> > queue are completed.
> 
> Hi Ming,
> 
> I'm a bit concerned that this approach won't work due to ordering: it seems
> that the IRQ would be shutdown prior to the CPU dead notification for the

Managed IRQ shutdown is run in irq_migrate_all_off_this_cpu(), which is
called in the callback of takedown_cpu(). And the CPU dead notification
is always sent after that CPU becomes offline, see cpuhp_invoke_callback().

> last CPU in the mask (where we attempt to drain the queue associated with
> the IRQ, which would require the IRQ to be still enabled).
> 
> I hope that you can tell me that I'm wrong...

Or you add one line printk in both irq_migrate_all_off_this_cpu() and
blk_mq_hctx_notify_dead(), you will see if you are wrong.


Thanks, 
Ming
