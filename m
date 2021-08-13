Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB8013EBA14
	for <lists+linux-scsi@lfdr.de>; Fri, 13 Aug 2021 18:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236627AbhHMQbq (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 13 Aug 2021 12:31:46 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54584 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236528AbhHMQbl (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 13 Aug 2021 12:31:41 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EFDF12236B;
        Fri, 13 Aug 2021 16:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628872267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IpRGvPvDJmSJgZyDZN7hhPL7Stnoj/FmezzStMXKH8I=;
        b=K/NGNaTqJ/f8YUxW3+xDOYGteSWcWlCpJ2mDkk5mEGDfYZsfsBKTdnU/M3dTuJbUxkyePx
        StTRpLrdZ+y1bUWSB8YQxdAcYrjAEy9swmgDQx53UJ730GqajUPpo/be3k+YqnFgJJDmTQ
        njuY6E7WzTNwLCJb5VPpHnGEGEmN4Wc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628872267;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IpRGvPvDJmSJgZyDZN7hhPL7Stnoj/FmezzStMXKH8I=;
        b=rvTLZedrY+jQLUxo/wW8Zqc8bgs0aPpj7pu1kefe7UW2Dph4+1jICP7rksrzg08cD06uuW
        08S1nIyTOQyDqOCg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 5FBC9137C3;
        Fri, 13 Aug 2021 16:31:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id kJ1EFEueFmH6IQAAGKfGzw
        (envelope-from <hare@suse.de>); Fri, 13 Aug 2021 16:31:07 +0000
Subject: Re: [PATCH 2/3] scsi: fnic: Stop setting scsi_cmnd.tag
To:     John Garry <john.garry@huawei.com>, satishkh@cisco.com,
        sebaddel@cisco.com, kartilak@cisco.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@lst.de, bvanassche@acm.org
References: <1628862553-179450-1-git-send-email-john.garry@huawei.com>
 <1628862553-179450-3-git-send-email-john.garry@huawei.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <9c4a07dc-a8ea-6f99-0e13-be8c64ec94ed@suse.de>
Date:   Fri, 13 Aug 2021 18:31:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1628862553-179450-3-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 8/13/21 3:49 PM, John Garry wrote:
> It is never read. Setting it and the request tag seems dodgy
> anyway.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   drivers/scsi/fnic/fnic_scsi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
