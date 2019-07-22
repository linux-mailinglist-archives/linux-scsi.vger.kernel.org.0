Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41097709CF
	for <lists+linux-scsi@lfdr.de>; Mon, 22 Jul 2019 21:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfGVThs (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 22 Jul 2019 15:37:48 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40254 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbfGVThs (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 22 Jul 2019 15:37:48 -0400
Received: by mail-pf1-f194.google.com with SMTP id p184so17850810pfp.7
        for <linux-scsi@vger.kernel.org>; Mon, 22 Jul 2019 12:37:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wdtJHF+knv1TUn/MruzOrhxsEVrJPMYiiJ9guij6ViM=;
        b=OQJdj0hSjUWFizLvOB9t2vVDoI9OtiOhwnMgHivcB9EgYXBVFDNqa+09DIVpHZ3ckF
         y8wjoDwLvoNDc6pmvEsPKXG5jtXTBd8865uAic1Y0N6CAhfXmGXSf95LlPF5L8luFecQ
         DjLH7tR5wTdJO3K6mhEtvNkvt0rh4/jfltoNgNRxAsg1J9J+Lt7zlJSzHuIkXskT8bmr
         Mx4XeqTt/lkuPZSy+yNF5hBnVwDqS0BjY2Po1JcKjw2EJDnead8vCffcUuTelcSZXhdQ
         as6NdJMEre0lGa/EYJkKcbW+qmYD6Q1NwApOpGTMQCF9z/a6+j7mwiz6PPIQovmyqNMw
         6hyw==
X-Gm-Message-State: APjAAAVvWT81l/+boYIDIIwtAzbG8Nh/6BRcncji+juS1kbGa7swWYIX
        mXHbGCjaqAQx2bhzNTzDiqoeXiKWefo=
X-Google-Smtp-Source: APXvYqzMWDHEjOxi6b+PqN3xSG3RDBdd/nx39VhF8LeYLKjW6E4EGyuSKzRqkAJDEWOpo/FgpD2R5Q==
X-Received: by 2002:a63:1d4:: with SMTP id 203mr55610964pgb.441.1563824267320;
        Mon, 22 Jul 2019 12:37:47 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id t29sm48906078pfq.156.2019.07.22.12.37.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 12:37:45 -0700 (PDT)
Subject: Re: [PATCH] scsi: fix the dma_max_mapping_size call
To:     Christoph Hellwig <hch@lst.de>, martin.petersen@oracle.com
Cc:     tom.leiming@gmail.com, dexuan.linux@gmail.com,
        Damien.LeMoal@wdc.com, linux-scsi@vger.kernel.org
References: <20190722092038.17659-1-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <38dd48c2-12fe-8521-4beb-7b4c415cc710@acm.org>
Date:   Mon, 22 Jul 2019 12:37:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190722092038.17659-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 7/22/19 2:20 AM, Christoph Hellwig wrote:
> We should only call dma_max_mapping_size for devices that have a DMA
> mask set, otherwise we can run into a NULL pointer dereference that
> will crash the system.
> 
> Also we need to do right shift to get the sectors from the size in
> bytes, not a left shift.
> 
> Fixes: bdd17bdef7d8 ("scsi: core: take the DMA max mapping size into account")
> Reported-by: Bart Van Assche <bvanassche@acm.org>
> Reported-by: Ming Lei <tom.leiming@gmail.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/scsi/scsi_lib.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 9381171c2fc0..11e64b50497f 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -1784,8 +1784,10 @@ void __scsi_init_queue(struct Scsi_Host *shost, struct request_queue *q)
>   		blk_queue_max_integrity_segments(q, shost->sg_prot_tablesize);
>   	}
>   
> -	shost->max_sectors = min_t(unsigned int, shost->max_sectors,
> -			dma_max_mapping_size(dev) << SECTOR_SHIFT);
> +	if (dev->dma_mask) {
> +		shost->max_sectors = min_t(unsigned int, shost->max_sectors,
> +				dma_max_mapping_size(dev) >> SECTOR_SHIFT);
> +	}
>   	blk_queue_max_hw_sectors(q, shost->max_sectors);
>   	if (shost->unchecked_isa_dma)
>   		blk_queue_bounce_limit(q, BLK_BOUNCE_ISA);
> 

Is it possible that a device defines a maximum mapping size but no DMA 
mask? Is the NULL pointer dereference that can happen an attempt to 
dereference dev->dma_ops? Have you considered to test the get_dma_ops() 
return value instead of dev->dma_mask? I think that would make this code 
easier to read.

Thanks,

Bart.
