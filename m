Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 868C840A618
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Sep 2021 07:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239706AbhINFqR (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 14 Sep 2021 01:46:17 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34672 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239398AbhINFqQ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 14 Sep 2021 01:46:16 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A8F571FDB5;
        Tue, 14 Sep 2021 05:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1631598298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J5vhZkg7A1Xw7FQT6sp7X2FVifVd8Tn3fnGHGCoFYMg=;
        b=lg84VyQ0ahRpmU6WU8hLrEL3a1PIuH04u1ZjSW9cPolmbQFPl16hpgPGC8FLCDv8omCoaD
        j9nTnXUsk+GRIUlWAwYyAxjx4SSkANEWQScko7XLE7T0JbfBpLEw8ADDE4tIK84RbzRNw2
        gC0jNzARSYyO+s7yfj2NmAPPYEbykQ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1631598298;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J5vhZkg7A1Xw7FQT6sp7X2FVifVd8Tn3fnGHGCoFYMg=;
        b=/ehVbn60xBknqGp7ZGEcfuULSHpC9CwVX6182H8T/j6idkMpm14luAhV/E0V4USjH9qG5c
        75h1z7EcZ10uBOAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6626413E4A;
        Tue, 14 Sep 2021 05:44:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TCJjFNo2QGE5UgAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 14 Sep 2021 05:44:58 +0000
Subject: Re: [PATCH RESEND v3 07/13] blk-mq: Pass driver tags to
 blk_mq_clear_rq_mapping()
To:     John Garry <john.garry@huawei.com>, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        ming.lei@redhat.com, linux-scsi@vger.kernel.org
References: <1631545950-56586-1-git-send-email-john.garry@huawei.com>
 <1631545950-56586-8-git-send-email-john.garry@huawei.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <3aa570f2-7150-e0a0-a968-40435493dfe4@suse.de>
Date:   Tue, 14 Sep 2021 07:44:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1631545950-56586-8-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 9/13/21 5:12 PM, John Garry wrote:
> Function blk_mq_clear_rq_mapping() will be used for shared sbitmap tags
> in future, so pass a driver tags pointer instead of the tagset container
> and HW queue index.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   block/blk-mq.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
