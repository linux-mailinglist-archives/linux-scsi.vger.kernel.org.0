Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C07515AD2
	for <lists+linux-scsi@lfdr.de>; Sat, 30 Apr 2022 08:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238155AbiD3GdV (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 30 Apr 2022 02:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiD3GdV (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 30 Apr 2022 02:33:21 -0400
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B40167D3
        for <linux-scsi@vger.kernel.org>; Fri, 29 Apr 2022 23:29:56 -0700 (PDT)
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <lnx-linux-scsi@m.gmane-mx.org>)
        id 1nkgc6-0007HW-Hg
        for linux-scsi@vger.kernel.org; Sat, 30 Apr 2022 08:29:54 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-scsi@vger.kernel.org
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] scsi: elx: efct: remove unnecessary memset in efct_io
Date:   Sat, 30 Apr 2022 08:29:46 +0200
Message-ID: <794191df-e745-c591-bf1d-37945f96e73a@wanadoo.fr>
References: <20220318145230.1031-1-wanjiabing@vivo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
In-Reply-To: <20220318145230.1031-1-wanjiabing@vivo.com>
Cc:     target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Le 18/03/2022 à 15:52, Wan Jiabing a écrit :
> io->sgl is allocated by kzalloc(). The memory is set to zero.
> It is unnecessary to call memset again.
> 

Hi,

Nitpick: this kzalloc() should be a kcalloc() to avoid an open-coded 
multiplication when computing the size to allocate.

CJ


> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>   drivers/scsi/elx/efct/efct_io.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/scsi/elx/efct/efct_io.c b/drivers/scsi/elx/efct/efct_io.c
> index c3247b951a76..c612f0a48839 100644
> --- a/drivers/scsi/elx/efct/efct_io.c
> +++ b/drivers/scsi/elx/efct/efct_io.c
> @@ -62,7 +62,6 @@ efct_io_pool_create(struct efct *efct, u32 num_sgl)
>   			return NULL;
>   		}
>   
> -		memset(io->sgl, 0, sizeof(*io->sgl) * num_sgl);
>   		io->sgl_allocated = num_sgl;
>   		io->sgl_count = 0;
>   


