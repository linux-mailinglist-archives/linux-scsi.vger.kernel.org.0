Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC2B4C60AB
	for <lists+linux-scsi@lfdr.de>; Mon, 28 Feb 2022 02:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbiB1Bj7 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 27 Feb 2022 20:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbiB1Bj7 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 27 Feb 2022 20:39:59 -0500
Received: from mp-relay-01.fibernetics.ca (mp-relay-01.fibernetics.ca [208.85.217.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5907F220E8
        for <linux-scsi@vger.kernel.org>; Sun, 27 Feb 2022 17:39:20 -0800 (PST)
Received: from mailpool-fe-02.fibernetics.ca (mailpool-fe-02.fibernetics.ca [208.85.217.145])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mp-relay-01.fibernetics.ca (Postfix) with ESMTPS id 0CD53E0FB0;
        Mon, 28 Feb 2022 01:39:19 +0000 (UTC)
Received: from localhost (mailpool-mx-01.fibernetics.ca [208.85.217.140])
        by mailpool-fe-02.fibernetics.ca (Postfix) with ESMTP id 029E0630AC;
        Mon, 28 Feb 2022 01:39:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at 
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Received: from mailpool-fe-02.fibernetics.ca ([208.85.217.145])
        by localhost (mail-mx-01.fibernetics.ca [208.85.217.140]) (amavisd-new, port 10024)
        with ESMTP id LNi9oZzX8ANu; Mon, 28 Feb 2022 01:39:18 +0000 (UTC)
Received: from [192.168.48.23] (host-45-78-195-155.dyn.295.ca [45.78.195.155])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dgilbert@interlog.com)
        by mail.ca.inter.net (Postfix) with ESMTPSA id 4AD0D60494;
        Mon, 28 Feb 2022 01:39:18 +0000 (UTC)
Message-ID: <86e4fafa-f834-6fb5-2337-314a6078a480@interlog.com>
Date:   Sun, 27 Feb 2022 20:39:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH 1/2] scsi: scsi_debug: silence sparse unexpected unlock
 warnings
Content-Language: en-CA
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20220225084527.523038-1-damien.lemoal@opensource.wdc.com>
 <20220225084527.523038-2-damien.lemoal@opensource.wdc.com>
From:   Douglas Gilbert <dgilbert@interlog.com>
In-Reply-To: <20220225084527.523038-2-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2022-02-25 03:45, Damien Le Moal wrote:
> The return statement inside the sdeb_read_lock(), sdeb_read_unlock(),
> sdeb_write_lock() and sdeb_write_unlock() confuse sparse, leading to
> many warnings about unexpected unlocks in the resp_xxx() functions.
> 
> Modify the lock/unlock functions using the __acquire() and __release()
> inline annotations for the sdebug_no_rwlock == true case to avoid these
> warnings.

I'm confused. The idea with sdebug_no_rwlock was that the application
may know that the protection afforded by the driver's rwlock is not
needed because locking is performed at a higher level (e.g. in the
user space). Hence there is no need to use a read-write lock (or a
full lock) in this driver to protect a read (say) against a co-incident
write to the same memory region. So this was a performance enhancement.

The proposed patch seems to be replacing a read-write lock with a full
lock. That would be going in the opposite direction to what I intended.

If this is the only solution, a better idea might be to drop the
patch (in staging I think) that introduced the sdebug_no_rwlock option.

The sdebug_no_rwlock option has been pretty thoroughly tested (for over
a year) with memory to memory transfers (together with sgl to sgl
additions to lib/scatterlist.h). Haven't seen any unexplained crashes
that I could trace to this lack of locking. OTOH I haven't measured
any improvement of the copy speed either, that may be because my tests
are approaching the copy bandwidth of the ram.


Does sparse understand guard variables (e.g. like 'bool lock_taken')?
 From what I've seen with sg3_utils Coverity doesn't, leading to many false
reports.

Doug Gilbert

> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>   drivers/scsi/scsi_debug.c | 68 +++++++++++++++++++++++++--------------
>   1 file changed, 44 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
> index 0d25b30922ef..f4e97f2224b2 100644
> --- a/drivers/scsi/scsi_debug.c
> +++ b/drivers/scsi/scsi_debug.c
> @@ -3167,45 +3167,65 @@ static int prot_verify_read(struct scsi_cmnd *scp, sector_t start_sec,
>   static inline void
>   sdeb_read_lock(struct sdeb_store_info *sip)
>   {
> -	if (sdebug_no_rwlock)
> -		return;
> -	if (sip)
> -		read_lock(&sip->macc_lck);
> -	else
> -		read_lock(&sdeb_fake_rw_lck);
> +	if (sdebug_no_rwlock) {
> +		if (sip)
> +			__acquire(&sip->macc_lck);
> +		else
> +			__acquire(&sdeb_fake_rw_lck);
> +	} else {
> +		if (sip)
> +			read_lock(&sip->macc_lck);
> +		else
> +			read_lock(&sdeb_fake_rw_lck);
> +	}
>   }
>   
>   static inline void
>   sdeb_read_unlock(struct sdeb_store_info *sip)
>   {
> -	if (sdebug_no_rwlock)
> -		return;
> -	if (sip)
> -		read_unlock(&sip->macc_lck);
> -	else
> -		read_unlock(&sdeb_fake_rw_lck);
> +	if (sdebug_no_rwlock) {
> +		if (sip)
> +			__release(&sip->macc_lck);
> +		else
> +			__release(&sdeb_fake_rw_lck);
> +	} else {
> +		if (sip)
> +			read_unlock(&sip->macc_lck);
> +		else
> +			read_unlock(&sdeb_fake_rw_lck);
> +	}
>   }
>   
>   static inline void
>   sdeb_write_lock(struct sdeb_store_info *sip)
>   {
> -	if (sdebug_no_rwlock)
> -		return;
> -	if (sip)
> -		write_lock(&sip->macc_lck);
> -	else
> -		write_lock(&sdeb_fake_rw_lck);
> +	if (sdebug_no_rwlock) {
> +		if (sip)
> +			__acquire(&sip->macc_lck);
> +		else
> +			__acquire(&sdeb_fake_rw_lck);
> +	} else {
> +		if (sip)
> +			write_lock(&sip->macc_lck);
> +		else
> +			write_lock(&sdeb_fake_rw_lck);
> +	}
>   }
>   
>   static inline void
>   sdeb_write_unlock(struct sdeb_store_info *sip)
>   {
> -	if (sdebug_no_rwlock)
> -		return;
> -	if (sip)
> -		write_unlock(&sip->macc_lck);
> -	else
> -		write_unlock(&sdeb_fake_rw_lck);
> +	if (sdebug_no_rwlock) {
> +		if (sip)
> +			__release(&sip->macc_lck);
> +		else
> +			__release(&sdeb_fake_rw_lck);
> +	} else {
> +		if (sip)
> +			write_unlock(&sip->macc_lck);
> +		else
> +			write_unlock(&sdeb_fake_rw_lck);
> +	}
>   }
>   
>   static int resp_read_dt0(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)

