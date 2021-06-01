Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEF838FC8B
	for <lists+linux-scsi@lfdr.de>; Tue, 25 May 2021 10:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbhEYIVU (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 25 May 2021 04:21:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:33396 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232208AbhEYIVT (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 25 May 2021 04:21:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1621930788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M0954BxebX/w9pSqYiAMhwE8DfGhNGO/HRhlrF8O8xU=;
        b=fi8xTdFYmFXGIfPFy0dTF9B4CSNGiVWXw63MAJq74H2ywS2hub+21UAtOQWWmiuBePYIIW
        lyL91omzQOhisIb/SQr0dzAbpxZmpt+GTO06jQvS/VxZbOWQWfcsivJWcqsNSngT/HaRpz
        j8boql0Djne2XKveXPYQ39jPS9m7rlw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1621930788;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M0954BxebX/w9pSqYiAMhwE8DfGhNGO/HRhlrF8O8xU=;
        b=MBbH/1wcsmvsqI3EihMyUefqC3Gy7a7JrgSxft+s4HIquHc/Jt5C3bh9zOArK9GfZqkTMg
        oLjkLHnTNA5T8PDw==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 60464AEAC;
        Tue, 25 May 2021 08:19:48 +0000 (UTC)
Subject: Re: [PATCH 5/8] block: split __blkdev_put
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
 <20210525061301.2242282-6-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <df9f1c97-7f3d-8efc-ad50-97ef67d09f6e@suse.de>
Date:   Tue, 25 May 2021 10:19:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210525061301.2242282-6-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/25/21 8:12 AM, Christoph Hellwig wrote:
> Split __blkdev_put into one helper for the whole device, and one for
> partitions as well as another shared helper for flushing the block
> device inode mapping.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/block_dev.c | 58 ++++++++++++++++++++++++++++----------------------
>   1 file changed, 32 insertions(+), 26 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
