Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4179225E9BA
	for <lists+linux-scsi@lfdr.de>; Sat,  5 Sep 2020 20:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbgIEShl (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 5 Sep 2020 14:37:41 -0400
Received: from smtp.infotech.no ([82.134.31.41]:59044 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728393AbgIEShk (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 5 Sep 2020 14:37:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 8CB6F204197;
        Sat,  5 Sep 2020 20:37:39 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4LjnfPtbfb8u; Sat,  5 Sep 2020 20:37:37 +0200 (CEST)
Received: from [192.168.48.23] (host-45-78-251-166.dyn.295.ca [45.78.251.166])
        by smtp.infotech.no (Postfix) with ESMTPA id 6DA31204194;
        Sat,  5 Sep 2020 20:37:35 +0200 (CEST)
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH 3/4] scsi: sg: use queue_logical_sector_size() in
 max_sectors_bytes()
To:     Tom Yan <tom.ty89@gmail.com>, linux-scsi@vger.kernel.org
Cc:     stern@rowland.harvard.edu, James.Bottomley@SteelEye.com,
        akinobu.mita@gmail.com, hch@lst.de, jens.axboe@oracle.com
References: <CAGnHSE=fY2wkzNeZTSHC37Sp-uD4D8YMEb7LesDkPcQWAfiK=w@mail.gmail.com>
 <20200904200554.168979-1-tom.ty89@gmail.com>
 <20200904200554.168979-3-tom.ty89@gmail.com>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <6b00f8ac-6da3-2c85-b6e8-bf17fc741d25@interlog.com>
Date:   Sat, 5 Sep 2020 14:37:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200904200554.168979-3-tom.ty89@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2020-09-04 4:05 p.m., Tom Yan wrote:
> Signed-off-by: Tom Yan <tom.ty89@gmail.com>

Acked-by: Douglas Gilbert <dgilbert@interlog.com>

> ---
>   drivers/scsi/sg.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
> index 0e3f084141a3..deeab4855172 100644
> --- a/drivers/scsi/sg.c
> +++ b/drivers/scsi/sg.c
> @@ -848,10 +848,11 @@ static int srp_done(Sg_fd *sfp, Sg_request *srp)
>   static int max_sectors_bytes(struct request_queue *q)
>   {
>   	unsigned int max_sectors = queue_max_sectors(q);
> +	unsigned int logical_block_size = queue_logical_block_size(q);
>   
> -	max_sectors = min_t(unsigned int, max_sectors, INT_MAX >> 9);
> +	max_sectors = min_t(unsigned int, max_sectors, USHRT_MAX);
>   
> -	return max_sectors << 9;
> +	return max_sectors * logical_block_size;
>   }
>   
>   static void
> 

