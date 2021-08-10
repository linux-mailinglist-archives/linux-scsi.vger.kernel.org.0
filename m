Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D503E5348
	for <lists+linux-scsi@lfdr.de>; Tue, 10 Aug 2021 08:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237746AbhHJGNN (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 10 Aug 2021 02:13:13 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47368 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbhHJGNN (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 10 Aug 2021 02:13:13 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E1FD221F63;
        Tue, 10 Aug 2021 06:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628575970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gnbnqEeMP7e0hG9FkAzjVGOk25+iLNRR3P6+Il41Yh8=;
        b=NBcs3v/xewpt444lrThWRD2nd4xiL513xsvBd2QOQn/Te4qLK1E8jhzKnn8R5BJ6p+lFwB
        SoBDfmWvzHI0NnRfB4Mdi92ifV2n/rOay3QCC0GfcnXNcOkqhIz9NJNRY8NQ6DiOjLDxFw
        qjgTwONiLUM8UMuA9lbwjgTzMzqB4DM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628575970;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gnbnqEeMP7e0hG9FkAzjVGOk25+iLNRR3P6+Il41Yh8=;
        b=+iOn1psb2T3Kcc06+JElGtHbl70HRmnfzh7zX829lZ06z92KNlq47LjkoJMCTKxOoP2nst
        9c4qCaavouztW+Cw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id B9583133D0;
        Tue, 10 Aug 2021 06:12:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id HWHoK+IYEmHZOQAAGKfGzw
        (envelope-from <hare@suse.de>); Tue, 10 Aug 2021 06:12:50 +0000
Subject: Re: [PATCH] scsi: aha1542: Remove unneeded semicolon
To:     Jason Wang <wangborong@cdjrlc.com>, martin.petersen@oracle.com
Cc:     jejb@linux.ibm.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210807105525.192240-1-wangborong@cdjrlc.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <9d4b934e-c04a-720c-fc3b-8161614d4df3@suse.de>
Date:   Tue, 10 Aug 2021 08:12:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210807105525.192240-1-wangborong@cdjrlc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 8/7/21 12:55 PM, Jason Wang wrote:
> The semicolon after a code block bracket is unneeded in C. Thus, we can
> remove the redundant semicolon from the code safely.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>   drivers/scsi/aha1542.c | 20 ++++++++++----------
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
