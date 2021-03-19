Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C310C341E8C
	for <lists+linux-scsi@lfdr.de>; Fri, 19 Mar 2021 14:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbhCSNk4 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 19 Mar 2021 09:40:56 -0400
Received: from verein.lst.de ([213.95.11.211]:46257 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230015AbhCSNku (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 19 Mar 2021 09:40:50 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6A6C368BFE; Fri, 19 Mar 2021 14:40:47 +0100 (CET)
Date:   Fri, 19 Mar 2021 14:40:47 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     John Garry <john.garry@huawei.com>
Cc:     joro@8bytes.org, will@kernel.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH 0/6] dma mapping/iommu: Allow IOMMU IOVA rcache range
 to be configured
Message-ID: <20210319134047.GA5729@lst.de>
References: <1616160348-29451-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616160348-29451-1-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, Mar 19, 2021 at 09:25:42PM +0800, John Garry wrote:
> For streaming DMA mappings involving an IOMMU and whose IOVA len regularly
> exceeds the IOVA rcache upper limit (meaning that they are not cached),
> performance can be reduced. 
> 
> This is much more pronounced from commit 4e89dce72521 ("iommu/iova: Retry
> from last rb tree node if iova search fails"), as discussed at [0].
> 
> IOVAs which cannot be cached are highly involved in the IOVA aging issue,
> as discussed at [1].

I'm confused.  If this a limit in the IOVA allocator, dma-iommu should
be able to just not grow the allocation so larger without help from
the driver.

If contrary to the above description it is device-specific, the driver
could simply use dma_get_max_seg_size().
