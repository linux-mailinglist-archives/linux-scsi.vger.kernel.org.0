Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A44D22CB5B9
	for <lists+linux-scsi@lfdr.de>; Wed,  2 Dec 2020 08:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387623AbgLBHRU (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 2 Dec 2020 02:17:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:38652 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728673AbgLBHRU (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 2 Dec 2020 02:17:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5FF5FABD2;
        Wed,  2 Dec 2020 07:16:38 +0000 (UTC)
Subject: Re: [PATCH v4 9/9] block: Do not accept any requests while suspended
To:     Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Can Guo <cang@codeaurora.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Martin Kepplinger <martin.kepplinger@puri.sm>
References: <20201130024615.29171-1-bvanassche@acm.org>
 <20201130024615.29171-10-bvanassche@acm.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <aff67678-19ff-996f-1d32-6035f6dec811@suse.de>
Date:   Wed, 2 Dec 2020 08:16:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201130024615.29171-10-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 11/30/20 3:46 AM, Bart Van Assche wrote:
> From: Alan Stern <stern@rowland.harvard.edu>
> 
> blk_queue_enter() accepts BLK_MQ_REQ_PM requests independent of the runtime
> power management state. Now that SCSI domain validation no longer depends
> on this behavior, modify the behavior of blk_queue_enter() as follows:
> - Do not accept any requests while suspended.
> - Only process power management requests while suspending or resuming.
> 
> Submitting BLK_MQ_REQ_PM requests to a device that is runtime suspended
> causes runtime-suspended devices not to resume as they should. The request
> which should cause a runtime resume instead gets issued directly, without
> resuming the device first. Of course the device can't handle it properly,
> the I/O fails, and the device remains suspended.
> 
> The problem is fixed by checking that the queue's runtime-PM status
> isn't RPM_SUSPENDED before allowing a request to be issued, and
> queuing a runtime-resume request if it is.  In particular, the inline
> blk_pm_request_resume() routine is renamed blk_pm_resume_queue() and
> the code is unified by merging the surrounding checks into the
> routine.  If the queue isn't set up for runtime PM, or there currently
> is no restriction on allowed requests, the request is allowed.
> Likewise if the BLK_MQ_REQ_PM flag is set and the status isn't
> RPM_SUSPENDED.  Otherwise a runtime resume is queued and the request
> is blocked until conditions are more suitable.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Can Guo <cang@codeaurora.org>
> Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reported-and-tested-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> [ bvanassche: modified commit message and removed Cc: stable because without
>    the previous patches from this series this patch would break parallel SCSI
>    domain validation ]
> ---
>   block/blk-core.c |  6 +++---
>   block/blk-pm.h   | 14 +++++++++-----
>   2 files changed, 12 insertions(+), 8 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
