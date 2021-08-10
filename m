Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E3F3E5362
	for <lists+linux-scsi@lfdr.de>; Tue, 10 Aug 2021 08:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237736AbhHJGUk (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 10 Aug 2021 02:20:40 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48086 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235202AbhHJGUj (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 10 Aug 2021 02:20:39 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3A3E921FBF;
        Tue, 10 Aug 2021 06:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628576417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ha+PBhT235Z6PgTlsPMIVMm6DOAAjBc0pyU7UzT6/Xg=;
        b=iVkxURbB+40TMw8Aq/DKf2lcfn4aDI+JHIWDsUdpzyaqSAMsZqWrJ17Y7cHGBv5QcGivAq
        7/7+dozebDiR74iTHy6M1jzY5DjEUwtINa82A2bSzVh0WAt8pOZZl3b4S+/R0t6d2BiNyS
        bNWLKCmxd8FVnx/N4T7O5y/peZzBtIA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628576417;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ha+PBhT235Z6PgTlsPMIVMm6DOAAjBc0pyU7UzT6/Xg=;
        b=DwINYWK9Yp3SueYweQ4gOwLWXL9W7ZmqC/NVdLupwZDx4aLfGaTkDCZqv/3f61lssTNUkD
        3oMNisR0tABL3jCQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 11DB2133D0;
        Tue, 10 Aug 2021 06:20:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id GWmiA6EaEmE8OwAAGKfGzw
        (envelope-from <hare@suse.de>); Tue, 10 Aug 2021 06:20:17 +0000
Subject: Re: [PATCH v5 07/52] ata: Use scsi_cmd_to_rq() instead of
 scsi_cmnd.request
To:     Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
References: <20210809230355.8186-1-bvanassche@acm.org>
 <20210809230355.8186-8-bvanassche@acm.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <8071437c-d186-40af-ce81-66fa3e523e5d@suse.de>
Date:   Tue, 10 Aug 2021 08:20:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210809230355.8186-8-bvanassche@acm.org>
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
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   drivers/ata/libata-eh.c   |  5 ++---
>   drivers/ata/libata-scsi.c | 10 +++++-----
>   drivers/ata/pata_falcon.c |  4 ++--
>   3 files changed, 9 insertions(+), 10 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
