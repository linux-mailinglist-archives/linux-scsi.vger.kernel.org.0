Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1353E535C
	for <lists+linux-scsi@lfdr.de>; Tue, 10 Aug 2021 08:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237539AbhHJGSo (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 10 Aug 2021 02:18:44 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51182 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237312AbhHJGSn (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 10 Aug 2021 02:18:43 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A0F5A1FE26;
        Tue, 10 Aug 2021 06:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628576301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=whc6WsyRMEI5sgyCeEieCQxVD8Xr1wwUNaWzHBviQcg=;
        b=jDrLBRF85j843YuwII8vdjtrTJhWw4YAMmV6TM97ae7dHW8YBjIRzjK1hufz/r06ikKyjz
        IgOtDIDoSerAe4za1LK0iKbJ/c+tqatFSZxK7uW5jV74nmZeJ8PEYNvIyhnRGmv+1UXpPk
        az6PKH8fXOjwSSpkAs0VSYEj2cIjrZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628576301;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=whc6WsyRMEI5sgyCeEieCQxVD8Xr1wwUNaWzHBviQcg=;
        b=Vg8y2FJvXs+ssI8Sb0gOoKSCw2N0TDBd5zolzxpLKqV8Pd2N/ugqRM57D/W7uScj7Ma2cP
        N7BsBJhl5DQDj2Dw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 8314C133D0;
        Tue, 10 Aug 2021 06:18:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id dtryHi0aEmHgOgAAGKfGzw
        (envelope-from <hare@suse.de>); Tue, 10 Aug 2021 06:18:21 +0000
Subject: Re: [PATCH v5 03/52] sd: Use scsi_cmd_to_rq() instead of
 scsi_cmnd.request
To:     Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
References: <20210809230355.8186-1-bvanassche@acm.org>
 <20210809230355.8186-4-bvanassche@acm.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <d1840a52-bc82-22bb-214e-de9d4636596b@suse.de>
Date:   Tue, 10 Aug 2021 08:18:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210809230355.8186-4-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 8/10/21 1:03 AM, Bart Van Assche wrote:
> Prepare for removal of the request pointer by using scsi_cmd_to_rq()
> instead. This patch does not change any functionality.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   drivers/scsi/sd.c     | 33 +++++++++++++++++----------------
>   drivers/scsi/sd_zbc.c | 10 +++++-----
>   2 files changed, 22 insertions(+), 21 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
