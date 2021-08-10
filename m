Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8D93E5363
	for <lists+linux-scsi@lfdr.de>; Tue, 10 Aug 2021 08:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237760AbhHJGVB (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 10 Aug 2021 02:21:01 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48112 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235202AbhHJGVB (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 10 Aug 2021 02:21:01 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1327621FC3;
        Tue, 10 Aug 2021 06:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628576439; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dzuJ4ISms2Iou6ZX2nReBmQcy8c8Jdvljz3KsHihDCc=;
        b=qaNWO4rGK0gHeFLnvu7PyzoqCLJZJbPfSsFaBlm5XVvcpHf6YYncBnu8PJBaVXYOwiSUj4
        ucIEvSKjydzW23556hQfttW/7txI26+XMjctMpK9qlJrzpFZHo2km46PkfNDJpPVAqHYGx
        DSv06r0eukNOBHCZldYE41itno6ZMCo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628576439;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dzuJ4ISms2Iou6ZX2nReBmQcy8c8Jdvljz3KsHihDCc=;
        b=1E79l/IJWuada9r8ghHaujopInF2z0j2sUP9pnJNp5Aa3LQxx1ygqwXnd4rlB5F28WL44y
        7sWT7grB2EQcPBAg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id E2209133D0;
        Tue, 10 Aug 2021 06:20:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 9Z5GNrYaEmFQOwAAGKfGzw
        (envelope-from <hare@suse.de>); Tue, 10 Aug 2021 06:20:38 +0000
Subject: Re: [PATCH v5 08/52] RDMA/iser: Use scsi_cmd_to_rq() instead of
 scsi_cmnd.request
To:     Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Max Gurtovoy <mgurtovoy@nvidia.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <20210809230355.8186-1-bvanassche@acm.org>
 <20210809230355.8186-9-bvanassche@acm.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <a0110185-2d35-0b1a-0dbc-f84ab4720738@suse.de>
Date:   Tue, 10 Aug 2021 08:20:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210809230355.8186-9-bvanassche@acm.org>
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
> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   drivers/infiniband/ulp/iser/iser_memory.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/ulp/iser/iser_memory.c b/drivers/infiniband/ulp/iser/iser_memory.c
> index afec40da9b58..9776b755d848 100644
> --- a/drivers/infiniband/ulp/iser/iser_memory.c
> +++ b/drivers/infiniband/ulp/iser/iser_memory.c
> @@ -159,7 +159,7 @@ iser_set_dif_domain(struct scsi_cmnd *sc, struct ib_sig_domain *domain)
>   {
>   	domain->sig_type = IB_SIG_TYPE_T10_DIF;
>   	domain->sig.dif.pi_interval = scsi_prot_interval(sc);
> -	domain->sig.dif.ref_tag = t10_pi_ref_tag(sc->request);
> +	domain->sig.dif.ref_tag = t10_pi_ref_tag(scsi_cmd_to_rq(sc));
>   	/*
>   	 * At the moment we hard code those, but in the future
>   	 * we will take them from sc.
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
