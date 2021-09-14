Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD4940A62A
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Sep 2021 07:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239812AbhINFuE (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 14 Sep 2021 01:50:04 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34916 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239813AbhINFuA (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 14 Sep 2021 01:50:00 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 351121FDB5;
        Tue, 14 Sep 2021 05:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1631598522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y9AqVdnpL3ixsvhi1BqR4J5bsG/nLXnB2X8nFUXBTaw=;
        b=wV19FbD0wfPSPq7jMJIPjLmKHAn29SdyXDg6eNq+L8aXuLgVVIa7al7rcHzcgyvnccZQti
        lsYL3IrvR6YinNBvrPrXhWd2sZmmnafYxaDSbkMUjO+XYLtu4Umath5qDYtgjkMDFp9rW3
        +q2EmRRKZQMDfgE8FAHTbdlyb0l8gUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1631598522;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y9AqVdnpL3ixsvhi1BqR4J5bsG/nLXnB2X8nFUXBTaw=;
        b=t2lJw0U84ZC8LCnLB/jTJHzzD5M5Yj8Ifie1lUIe6TdrrAxgopB7FktW36YchhM6mbPOY4
        pwFGcUq0mokUAZBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 165AA13E4A;
        Tue, 14 Sep 2021 05:48:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OfpUBLo3QGGUUwAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 14 Sep 2021 05:48:42 +0000
Subject: Re: [PATCH RESEND v3 10/13] blk-mq: Add blk_mq_alloc_map_and_rqs()
To:     John Garry <john.garry@huawei.com>, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        ming.lei@redhat.com, linux-scsi@vger.kernel.org
References: <1631545950-56586-1-git-send-email-john.garry@huawei.com>
 <1631545950-56586-11-git-send-email-john.garry@huawei.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <c4803363-4502-2b05-d1ac-846d14537435@suse.de>
Date:   Tue, 14 Sep 2021 07:48:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1631545950-56586-11-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 9/13/21 5:12 PM, John Garry wrote:
> Add a function to combine allocating tags and the associated requests,
> and factor out common patterns to use this new function.
> 
> Some functions only call blk_mq_alloc_map_and_rqs() now, but more
> functionality will be added later to those functions.
> 
> Also make blk_mq_alloc_rq_map() and blk_mq_alloc_rqs() static since they
> are only used in blk-mq.c, and finally rename some functions for
> conciseness and consistency with other function names:
> - __blk_mq_alloc_map_and_{request -> rqs}()
> - blk_mq_alloc_{map_and_requests -> set_map_and_rqs}()
> 
> Suggested-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   block/blk-mq-sched.c | 15 +++--------
>   block/blk-mq-tag.c   |  9 +------
>   block/blk-mq.c       | 62 +++++++++++++++++++++++++-------------------
>   block/blk-mq.h       |  9 ++-----
>   4 files changed, 42 insertions(+), 53 deletions(-)
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
