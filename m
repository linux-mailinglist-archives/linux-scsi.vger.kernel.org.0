Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 089C436080
	for <lists+linux-scsi@lfdr.de>; Wed,  5 Jun 2019 17:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbfFEPqB (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 5 Jun 2019 11:46:01 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40026 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfFEPqB (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 5 Jun 2019 11:46:01 -0400
Received: by mail-pg1-f195.google.com with SMTP id d30so12598948pgm.7
        for <linux-scsi@vger.kernel.org>; Wed, 05 Jun 2019 08:46:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OOkyg0plL38d7//C23OXvGetIepg8EzN+3Ep0xpklcI=;
        b=oBeZXYSaZaLQouYBkoVm2jLLGLnXcEHe9DVrnpN8AcfEz3N6LLxo5Fxu0SkPEw9iXP
         q+HswKdy0AUXZahHPvR2ARGQi+NbmM6YgASCa4qMOv2Y0mQcqbC7wtBBUn88psFYtC5i
         vK/CkkKxttx745kb/tM352UWHXUwmw2cL4kIFIkkYKsHryQGkY6LxFXjU3TNqdTbehPl
         YKJ8rp4OJNi/ET4ZV7IdYnKM5UyVCJ6o15t/bkOstdk2RGT5u+YCSYxoE+D1GzhzqmF/
         cN+ZqsvIMfYI3DXZ68ZigO38lbaFqlZzbYsTiJLTvdnqSS65+whH5tHgRIKYuojQRMcB
         Bbfg==
X-Gm-Message-State: APjAAAXqC4UtH+KydGjv0Gk0beQ3mXeLfVXNBu6VO/0rsqEZqx5AzBaK
        x5rmsf7mHGQy5CEiPqd3dyM=
X-Google-Smtp-Source: APXvYqzZi4cV8Nzjm+AZO4TqucsjXwvZzrAoXBLu4Z14Nk/JLb3tjq0wAcbwoHKMYok18N2dgSRQcg==
X-Received: by 2002:a17:90a:1706:: with SMTP id z6mr24082432pjd.108.1559749560110;
        Wed, 05 Jun 2019 08:46:00 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id 63sm12206764pfv.149.2019.06.05.08.45.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 08:45:59 -0700 (PDT)
Subject: Re: [PATCH V2 1/3] scsi: lib/sg_pool.c: clear 'first_chunk' in case
 of no pre-allocation
To:     Ming Lei <ming.lei@redhat.com>, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Christoph Hellwig <hch@lst.de>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
References: <20190605010623.12325-1-ming.lei@redhat.com>
 <20190605010623.12325-2-ming.lei@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <f099b22a-23e8-abe6-1526-6ceed2a4ebde@acm.org>
Date:   Wed, 5 Jun 2019 08:45:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190605010623.12325-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 6/4/19 6:06 PM, Ming Lei wrote:
> If user doesn't ask to pre-allocate by passing zero 'nents_first_chunk' to
> sg_alloc_table_chained, we need to make sure that 'first_chunk' is cleared.
> Otherwise, __sg_alloc_table() still may think that the 1st SGL should
> be from the pre-allocation.
> 
> Fixes the issue by clearing 'first_chunk' in sg_alloc_table_chained() if
> 'nents_first_chunk' is zero.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Ewan D. Milne <emilne@redhat.com>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Fixes: c3288dd8c232 ("scsi: core: avoid pre-allocating big SGL for data")

Shouldn't the "Fixes:" tag be left out from this patch? I don't think 
that this patch by itself fixes anything. Isn't this patch something 
that is necessary to make patch 2/3 in this series work? How about 
indicating that by mentioning it in the commit message?

> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Tested-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   lib/sg_pool.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/sg_pool.c b/lib/sg_pool.c
> index 47eecbe094d8..e042a1722615 100644
> --- a/lib/sg_pool.c
> +++ b/lib/sg_pool.c
> @@ -122,7 +122,7 @@ int sg_alloc_table_chained(struct sg_table *table, int nents,
>   	}
>   
>   	/* User supposes that the 1st SGL includes real entry */
> -	if (nents_first_chunk == 1) {
> +	if (nents_first_chunk <= 1) {
>   		first_chunk = NULL;
>   		nents_first_chunk = 0;
>   	}

How about also updating the kernel-doc header above 
sg_alloc_table_chained() such that it is made clear that @first_chunk is 
ignored if nents_first_chunk <= 1 ? Otherwise this patch looks fine to me.

Bart.

