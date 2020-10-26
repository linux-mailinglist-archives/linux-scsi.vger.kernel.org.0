Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70FE9299837
	for <lists+linux-scsi@lfdr.de>; Mon, 26 Oct 2020 21:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgJZUuz (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 26 Oct 2020 16:50:55 -0400
Received: from mail-1.ca.inter.net ([208.85.220.69]:36287 "EHLO
        mail-1.ca.inter.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbgJZUuz (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 26 Oct 2020 16:50:55 -0400
Received: from localhost (offload-3.ca.inter.net [208.85.220.70])
        by mail-1.ca.inter.net (Postfix) with ESMTP id 1FC3A2EAB6F;
        Mon, 26 Oct 2020 16:50:54 -0400 (EDT)
Received: from mail-1.ca.inter.net ([208.85.220.69])
        by localhost (offload-3.ca.inter.net [208.85.220.70]) (amavisd-new, port 10024)
        with ESMTP id 3F+qMe1QX23Q; Mon, 26 Oct 2020 16:42:56 -0400 (EDT)
Received: from [192.168.48.23] (host-104-157-204-209.dyn.295.ca [104.157.204.209])
        (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dgilbert@interlog.com)
        by mail-1.ca.inter.net (Postfix) with ESMTPSA id ABEA82EA190;
        Mon, 26 Oct 2020 16:50:53 -0400 (EDT)
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH v2 1/5] lib/scatterlist: use consistent sg_copy_buffer()
 return type
To:     David Disseldorp <ddiss@suse.de>, target-devel@vger.kernel.org
Cc:     linux-scsi@vger.kernel.org
References: <20201026190646.8727-1-ddiss@suse.de>
 <20201026190646.8727-2-ddiss@suse.de>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <08c0e425-d8c5-a950-f2a1-01bb6c9a5adf@interlog.com>
Date:   Mon, 26 Oct 2020 16:50:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201026190646.8727-2-ddiss@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2020-10-26 3:06 p.m., David Disseldorp wrote:
> sg_copy_buffer() returns a size_t with the number of bytes copied.
> Return 0 instead of false if the copy is skipped.
> 
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> ---
>   lib/scatterlist.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/scatterlist.c b/lib/scatterlist.c
> index 0a482ef988e5..a59778946404 100644
> --- a/lib/scatterlist.c
> +++ b/lib/scatterlist.c
> @@ -933,7 +933,7 @@ size_t sg_copy_buffer(struct scatterlist *sgl, unsigned int nents, void *buf,
>   	sg_miter_start(&miter, sgl, nents, sg_flags);
>   
>   	if (!sg_miter_skip(&miter, skip))
> -		return false;
> +		return 0;
>   
>   	while ((offset < buflen) && sg_miter_next(&miter)) {
>   		unsigned int len;
> 

This one probably should be sent by itself as a fix to:
    linux-block@vger.kernel.org

and cc-ed to:
    axboe@kernel.dk

on the assumption that Jens Axboe is the maintainer of lib/scatterlist.c .
He put a fix of mine in sgl_alloc_order() into the kernel recently.

Otherwise:
Reviewed-by: Douglas Gilbert <dgilbert@interlog.com>
