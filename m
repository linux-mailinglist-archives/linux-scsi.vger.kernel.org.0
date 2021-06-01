Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E3C38FCB9
	for <lists+linux-scsi@lfdr.de>; Tue, 25 May 2021 10:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbhEYI1i (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 25 May 2021 04:27:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:40296 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232408AbhEYI1c (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 25 May 2021 04:27:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1621931162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bNbAlHo1EQ2ZaT1LVZUFuygvqAEUgqU7/d3OqPfby8s=;
        b=kNInzt7o92mXwj5mm/tTB3mvp67b2SyAQFwHzwsyiBAknMavEnoBNjJP18tMcVLl0Gt7RG
        D5ZyM3Da2GmNIuB1EYzTmm6vvqoxRUZJndN2RI9lH7q3tsaVou9Z2xgQNsxc/L3Qgfwxrj
        qrhtZvNkAdplphtLAO+kullzgQwP1jo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1621931162;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bNbAlHo1EQ2ZaT1LVZUFuygvqAEUgqU7/d3OqPfby8s=;
        b=IbsF7be7IP90OP075dLi1k2Qff7v3ZnjUc8Bk5cR9UH2gwM5flg6iWijH5Hr+QIZDBXb12
        hrn5ZP2I3ROHxqBw==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4AE88AE1F;
        Tue, 25 May 2021 08:26:02 +0000 (UTC)
Subject: Re: [PATCH 8/8] block: remove bdget_disk
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Song Liu <song@kernel.org>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20210525061301.2242282-1-hch@lst.de>
 <20210525061301.2242282-9-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <46da28bf-a531-7640-0b0b-d0645d850827@suse.de>
Date:   Tue, 25 May 2021 10:26:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210525061301.2242282-9-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/25/21 8:13 AM, Christoph Hellwig wrote:
> Just opencode the xa_load in the callers, as none of them actually
> needs a reference to the bdev.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/genhd.c           | 35 +++++------------------------------
>   block/partitions/core.c | 25 ++++++++++++-------------
>   include/linux/genhd.h   |  1 -
>   3 files changed, 17 insertions(+), 44 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
