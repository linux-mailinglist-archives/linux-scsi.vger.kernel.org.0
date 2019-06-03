Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5ACA32D3D
	for <lists+linux-scsi@lfdr.de>; Mon,  3 Jun 2019 11:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfFCJy5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 3 Jun 2019 05:54:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40762 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbfFCJy5 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 3 Jun 2019 05:54:57 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AFA2C30821F4;
        Mon,  3 Jun 2019 09:54:56 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DC9EE61B6A;
        Mon,  3 Jun 2019 09:54:48 +0000 (UTC)
Date:   Mon, 3 Jun 2019 17:54:43 +0800
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
Message-ID: <20190603095413.GE11812@ming.t460p>
References: <20190531074158.76923-1-hare@suse.de>
 <20190531082116.GA12106@ming.t460p>
 <e81ca95e-95af-1078-c523-701120dd4ca7@suse.de>
 <20190531084600.GB12106@ming.t460p>
 <57d87edb-e748-6223-bfb4-a67ead9a8bdd@huawei.com>
 <20190531225338.GA16190@ming.t460p>
 <ab62907f-0d91-607e-daac-d069efb97355@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab62907f-0d91-607e-daac-d069efb97355@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 03 Jun 2019 09:54:56 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, Jun 03, 2019 at 09:57:26AM +0100, John Garry wrote:
> > > > Otherwise duplicated slot can be used from different blk-mq hw queue.
> > > > 
> > > > > 
> > > > > > The worsen thing is that V3's actual max queue depth is (4096 - 96), but
> > > > > > this patch claims that the device can support (4096 - 96) * 32 command
> > > > > > slots
> > > 
> > > To be clear about the hw, the hw supports max 4096 command tags and has 16
> > 
> > Is 4096 the max allowed host-wide command tags? Or per-queue's max commands
> > tags?
> 
> 4096 is max allowed host wide, in range [0, 4096), and tags are not per
> queue. HW delivery queues can be configured to be as large as desired.

Then all delivery(and complete) queues share the 4096 command slots, we can't
convert hisi_sas V3 into typical blk-mq MQ model simply as done by Hannes's patch.

Or you may partition the 4096 tags into 16 queues, then each queue's
depth is ~256. Depends on if performance is good for workloads.
You still can build a unique tag easily in [0, 4096), such as
(req->tag * hw_queue_index).

blk-mq's hw queue has independent tags, which is from NVMe's submission/completion
queue.

> 
> And on another point I saw mentioned, the device supports multiple
> submission and multiple completion queues. They are symmetrical, and any
> command will always complete on the same queue index which it was submitted.

DQ & CQ did confuse me a bit, :-)

Thanks,
Ming
