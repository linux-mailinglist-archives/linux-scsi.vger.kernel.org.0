Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04DFB38FC1C
	for <lists+linux-scsi@lfdr.de>; Tue, 25 May 2021 10:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbhEYIJ2 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 25 May 2021 04:09:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:33484 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231960AbhEYIIw (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 25 May 2021 04:08:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1621929906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LWlIahmLD1U2sAILrwdohse9BDRtZki0LWxBuBNZ/UM=;
        b=TCFSzXKswQ9c3MQvS9pQCfBugKeRgpp6aEDv7/lox5O3E4pGK67QigZKuvWd0pyWWOliy4
        hOfZ3W5aYSAt4+/Yu1Lyswx/eUfuS3ZxaE9uaEv/ZDQGGxeapo/UpOKvZ/SvtcYHVBwaRW
        LUyuTPbzkSdwl+tluNoDVWDhXF1FR5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1621929906;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LWlIahmLD1U2sAILrwdohse9BDRtZki0LWxBuBNZ/UM=;
        b=OJjBHKRu8wjCBmKfBDOFYfR0oVCltRLNj446iVzz40g6EGOYYVMKYBrjb05n6hWxg67hlg
        SWVCipFj21aT61CQ==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 09D93AEA8;
        Tue, 25 May 2021 08:05:06 +0000 (UTC)
Subject: Re: [PATCH 2/8] block: move sync_blockdev from __blkdev_put to
 blkdev_put
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Song Liu <song@kernel.org>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
References: <20210525061301.2242282-1-hch@lst.de>
 <20210525061301.2242282-3-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <fd7e6a91-3c94-b49a-390a-cdc59aae850e@suse.de>
Date:   Tue, 25 May 2021 10:05:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210525061301.2242282-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/25/21 8:12 AM, Christoph Hellwig wrote:
> Do the early unlocked syncing even earlier to move more code out of
> the recursive path.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> ---
>   fs/block_dev.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
