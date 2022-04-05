Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545F54F2246
	for <lists+linux-scsi@lfdr.de>; Tue,  5 Apr 2022 06:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiDEEzH (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 5 Apr 2022 00:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiDEEyu (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 5 Apr 2022 00:54:50 -0400
Received: from mp-relay-01.fibernetics.ca (mp-relay-01.fibernetics.ca [208.85.217.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D5E694AB
        for <linux-scsi@vger.kernel.org>; Mon,  4 Apr 2022 21:51:19 -0700 (PDT)
Received: from mailpool-fe-02.fibernetics.ca (mailpool-fe-02.fibernetics.ca [208.85.217.145])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mp-relay-01.fibernetics.ca (Postfix) with ESMTPS id AC552E11EC;
        Tue,  5 Apr 2022 04:51:18 +0000 (UTC)
Received: from localhost (mailpool-mx-01.fibernetics.ca [208.85.217.140])
        by mailpool-fe-02.fibernetics.ca (Postfix) with ESMTP id 9735361545;
        Tue,  5 Apr 2022 04:51:18 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at 
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Received: from mailpool-fe-02.fibernetics.ca ([208.85.217.145])
        by localhost (mail-mx-01.fibernetics.ca [208.85.217.140]) (amavisd-new, port 10024)
        with ESMTP id phN7AU8dwKxP; Tue,  5 Apr 2022 04:51:18 +0000 (UTC)
Received: from [192.168.48.23] (host-45-78-195-155.dyn.295.ca [45.78.195.155])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dgilbert@interlog.com)
        by mail.ca.inter.net (Postfix) with ESMTPSA id 0314C60476;
        Tue,  5 Apr 2022 04:51:17 +0000 (UTC)
Message-ID: <f95d6ec7-8d00-bf5b-e5e2-fcb1d788dc40@interlog.com>
Date:   Tue, 5 Apr 2022 00:51:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH] scsi: scsi_debug: Fix sdebug_blk_mq_poll() in_use_bm
 bitmap use
Content-Language: en-CA
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20220404045547.579887-1-damien.lemoal@opensource.wdc.com>
From:   Douglas Gilbert <dgilbert@interlog.com>
In-Reply-To: <20220404045547.579887-1-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2022-04-04 00:55, Damien Le Moal wrote:
> The in_use_bm bitmap of struct sdebug_queue should be accessed under
> protection of the qc_lock spinlock. Make sure that this lock is taken
> before calling find_first_bit() at the beginning of the function
> sdebug_blk_mq_poll().
> 
> Fixes: 3fd07aecb750 ("scsi: scsi_debug: Fix qc_lock use in sdebug_blk_mq_poll()")
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Acked-by: Douglas Gilbert <dgilbert@interlog.com>

> ---
>   drivers/scsi/scsi_debug.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
> index c607755cce00..ff78ef702f22 100644
> --- a/drivers/scsi/scsi_debug.c
> +++ b/drivers/scsi/scsi_debug.c
> @@ -7519,12 +7519,13 @@ static int sdebug_blk_mq_poll(struct Scsi_Host *shost, unsigned int queue_num)
>   	struct sdebug_defer *sd_dp;
>   
>   	sqp = sdebug_q_arr + queue_num;
> -	qc_idx = find_first_bit(sqp->in_use_bm, sdebug_max_queue);
> -	if (qc_idx >= sdebug_max_queue)
> -		return 0;
>   
>   	spin_lock_irqsave(&sqp->qc_lock, iflags);
>   
> +	qc_idx = find_first_bit(sqp->in_use_bm, sdebug_max_queue);
> +	if (qc_idx >= sdebug_max_queue)
> +		goto unlock;
> +
>   	for (first = true; first || qc_idx + 1 < sdebug_max_queue; )   {
>   		if (first) {
>   			first = false;
> @@ -7589,6 +7590,7 @@ static int sdebug_blk_mq_poll(struct Scsi_Host *shost, unsigned int queue_num)
>   			break;
>   	}
>   
> +unlock:
>   	spin_unlock_irqrestore(&sqp->qc_lock, iflags);
>   
>   	if (num_entries > 0)

