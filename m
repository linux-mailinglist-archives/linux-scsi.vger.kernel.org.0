Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F692CA158
	for <lists+linux-scsi@lfdr.de>; Tue,  1 Dec 2020 12:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbgLAL37 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 1 Dec 2020 06:29:59 -0500
Received: from verein.lst.de ([213.95.11.211]:49311 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727852AbgLAL37 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 1 Dec 2020 06:29:59 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id B665768B02; Tue,  1 Dec 2020 12:29:15 +0100 (CET)
Date:   Tue, 1 Dec 2020 12:29:15 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        "David S . Miller" <davem@davemloft.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Can Guo <cang@codeaurora.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v4 3/9] ide: Do not set the RQF_PREEMPT flag for sense
 requests
Message-ID: <20201201112915.GB32252@lst.de>
References: <20201130024615.29171-1-bvanassche@acm.org> <20201130024615.29171-4-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130024615.29171-4-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
