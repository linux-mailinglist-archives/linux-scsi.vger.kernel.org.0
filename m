Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9B5425D619
	for <lists+linux-scsi@lfdr.de>; Fri,  4 Sep 2020 12:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbgIDK0c (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 4 Sep 2020 06:26:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:43398 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730043AbgIDK0R (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 4 Sep 2020 06:26:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CF89FAF6D;
        Fri,  4 Sep 2020 10:26:15 +0000 (UTC)
Subject: Re: [PATCH 13/19] ide: switch to __register_blkdev for command set
 probing
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Denis Efremov <efremov@linux.com>,
        "David S. Miller" <davem@davemloft.net>,
        Song Liu <song@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Finn Thain <fthain@telegraphics.com.au>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-m68k@lists.linux-m68k.org
References: <20200903080119.441674-1-hch@lst.de>
 <20200903080119.441674-14-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <4199305c-5d59-030b-2a5f-b13ede10bf17@suse.de>
Date:   Fri, 4 Sep 2020 12:26:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200903080119.441674-14-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 9/3/20 10:01 AM, Christoph Hellwig wrote:
> ide is the last user of the blk_register_region framework except for the
> tracking of allocated gendisk.  Switch to __register_blkdev, even if that
> doesn't allow us to trivially find out which command set to probe for.
> That means we now always request all modules when a user tries to access
> an unclaimed ide device node, but except for a few potentially loaded
> modules for a fringe use case of a deprecated and soon to be removed
> driver that doesn't make a difference.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/ide/ide-probe.c | 34 ++++++----------------------------
>   1 file changed, 6 insertions(+), 28 deletions(-)
> 
Ceterum censeo ...

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
