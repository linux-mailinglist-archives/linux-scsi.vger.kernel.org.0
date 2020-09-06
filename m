Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6294225EEF8
	for <lists+linux-scsi@lfdr.de>; Sun,  6 Sep 2020 18:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgIFQEA (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 6 Sep 2020 12:04:00 -0400
Received: from netrider.rowland.org ([192.131.102.5]:40995 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726931AbgIFQD7 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 6 Sep 2020 12:03:59 -0400
Received: (qmail 741986 invoked by uid 1000); 6 Sep 2020 12:03:57 -0400
Date:   Sun, 6 Sep 2020 12:03:57 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-scsi@vger.kernel.org, Can Guo <cang@codeaurora.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Ming Lei <ming.lei@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 5/9] scsi: Do not wait for a request in
 scsi_eh_lock_door()
Message-ID: <20200906160357.GA741441@rowland.harvard.edu>
References: <20200906012219.17893-1-bvanassche@acm.org>
 <20200906012219.17893-6-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200906012219.17893-6-bvanassche@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sat, Sep 05, 2020 at 06:22:15PM -0700, Bart Van Assche wrote:
> It is not guaranteed that a request is available when scsi_eh_lock_door()
> is called. Hence pass the BLK_MQ_REQ_NOWAIT flag to blk_get_request().
> This patch has a second purpose, namely preventing that
> scsi_eh_lock_door() deadlocks if sdev->request_queue is frozen and if a
> SCSI command is submitted to a SCSI device through a second request queue
> that has not been frozen.

I think it would help readers understand the reason for doing this if 
you mentioned that scsi_eh_lock_door() is the only place in the SCSI 
error handler that calls blk_get_request().

Also mention that an upcoming patch in this series requires the error 
handler to work okay even when the device's request queue is frozen.  
(That's what the second sentence of your description is getting at, but 
the connection is not clear.)

Alan Stern
