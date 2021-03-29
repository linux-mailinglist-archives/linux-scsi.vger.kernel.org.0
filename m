Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB77A34C3EF
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Mar 2021 08:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhC2Ghe (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 29 Mar 2021 02:37:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:36356 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230226AbhC2GhC (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 29 Mar 2021 02:37:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 582F1B13D;
        Mon, 29 Mar 2021 06:37:01 +0000 (UTC)
Subject: Re: [PATCH 8/8] block: stop calling blk_queue_bounce for passthrough
 requests
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Khalid Aziz <khalid@gonehiking.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Ondrej Zary <linux@rainbow-software.org>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20210326055822.1437471-1-hch@lst.de>
 <20210326055822.1437471-9-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <0a39278a-f585-8b33-ea7b-16fe7f6c7ebd@suse.de>
Date:   Mon, 29 Mar 2021 08:37:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210326055822.1437471-9-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 3/26/21 6:58 AM, Christoph Hellwig wrote:
> Instead of overloading the passthrough fast path with the deprecated
> block layer bounce buffering let the users that combine an old
> undermaintained driver with a highmem system pay the price by always
> falling back to copies in that case.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-map.c                    | 116 ++++++++---------------------
>  block/bounce.c                     |  11 +--
>  drivers/nvme/host/lightnvm.c       |   2 +-
>  drivers/target/target_core_pscsi.c |   4 +-
>  include/linux/blkdev.h             |   2 +-
>  5 files changed, 36 insertions(+), 99 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
