Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A1F3072B4
	for <lists+linux-scsi@lfdr.de>; Thu, 28 Jan 2021 10:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbhA1J31 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 28 Jan 2021 04:29:27 -0500
Received: from verein.lst.de ([213.95.11.211]:56639 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232471AbhA1JYt (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 28 Jan 2021 04:24:49 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 67D2068AFE; Thu, 28 Jan 2021 10:24:06 +0100 (CET)
Date:   Thu, 28 Jan 2021 10:24:06 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH v4 8/8] sd_zbc: clear zone resources for non-zoned case
Message-ID: <20210128092406.GA2607@lst.de>
References: <20210128044733.503606-1-damien.lemoal@wdc.com> <20210128044733.503606-9-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128044733.503606-9-damien.lemoal@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, Jan 28, 2021 at 01:47:33PM +0900, Damien Le Moal wrote:
> For host-aware ZBC disk, setting the device zoned model to BLK_ZONED_HA
> using blk_queue_set_zoned() in sd_read_block_characteristics() may
> result in the block device effective zoned model to be "none"
> (BLK_ZONED_NONE) if partitions are present on the device. In this case,
> sd_zbc_read_zones() should not setup the zone related queue limits for
> the disk so that the device limits and configuration is consistent with
> a regular disk and resources not uselessly allocated (e.g. the zone
> write pointer tracking array for zone append emulation).
> 
> Furthermore, if the disk zoned model changes at run time due to the
> creation of a partition by the user, the zone related resources can be
> released.
> 
> Fix both problems by introducing the function sd_zbc_clear_zone_info()
> to reset the scsi disk zone information and free resources and by
> returning early in sd_zbc_read_zones() for a block device that has a
> zoned model equal to BLK_ZONED_NONE.

So creating the partition doesn't even call into the driver, which
means we'll leak the info for now.  But I guess the next revalidate
will simply clean it up, so it is not a major issue.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
