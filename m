Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A498036085
	for <lists+linux-scsi@lfdr.de>; Wed,  5 Jun 2019 17:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbfFEPsH (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 5 Jun 2019 11:48:07 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40144 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbfFEPsG (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 5 Jun 2019 11:48:06 -0400
Received: by mail-pf1-f193.google.com with SMTP id u17so15069079pfn.7
        for <linux-scsi@vger.kernel.org>; Wed, 05 Jun 2019 08:48:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jmSt0Eeltr64smzPoZBrmZBz6Rsm3A2f8x+hEDeHukQ=;
        b=qs05eUlJJzVu6Uo5lFRJ/xyXVKWe0nxPsPuMo7ZUd09P6D3pSwKTKrNf+nFLlLJT0j
         jSXEbMpevUPXgwrGlvJbgiMeTp77aJDXH3uaWGYJqFVg8eUxlGivGQ05ScCOkKbj5cjV
         TeAHQ9D+V2i7qDosKJ+jLWxw0iDcN6BHdRHsf1cjw3jJO1oHEgd47QkLNYDqeFsoQXc8
         3KA7hWdS0784QQir+Ag0ZmgGV5fGiRuOGxO9Su7rEjyDKum1Q3ubBdgRU67+gyQo/QrC
         sCuPruDKLznZQu5qXaYXOMiWlKeo9opHtd1vs48jil+UOFk+YBwnZZK5HUNJsRUyLSV5
         rUhQ==
X-Gm-Message-State: APjAAAUU1q5Lp8dItaXP1LpUz1O9VXqz4kxnQwjh0N/Z9QQu3N7aFamb
        ibCa/j/Zrt6FoORvsRDtKYg=
X-Google-Smtp-Source: APXvYqxXpdnDq4Ouc29uROudUEqeV32/c9LXJgbayrQmdgIPwDsTE4N11vpr2SvyZxo6a7S+SHz8iw==
X-Received: by 2002:a62:1990:: with SMTP id 138mr47137911pfz.133.1559749686253;
        Wed, 05 Jun 2019 08:48:06 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y4sm6259612pgc.85.2019.06.05.08.48.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 08:48:05 -0700 (PDT)
Subject: Re: [PATCH V2 2/3] scsi: core: don't pre-allocate small SGL in case
 of NO_SG_CHAIN
To:     Ming Lei <ming.lei@redhat.com>, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Christoph Hellwig <hch@lst.de>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
References: <20190605010623.12325-1-ming.lei@redhat.com>
 <20190605010623.12325-3-ming.lei@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <b8e93753-cfee-5696-2a33-5fb1a0d00dc9@acm.org>
Date:   Wed, 5 Jun 2019 08:48:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190605010623.12325-3-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 6/4/19 6:06 PM, Ming Lei wrote:
> The pre-allocated small SGL depends on SG_CHAIN, so if the ARCH doesn't
> support SG_CHAIN, pre-allocation of small SGL can't work at all.
> 
> Fixes this issue by not using small pre-allocation in case of
> NO_SG_CHAIN.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Ewan D. Milne <emilne@redhat.com>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Fixes: c3288dd8c232 ("scsi: core: avoid pre-allocating big SGL for data")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   drivers/scsi/scsi_lib.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 6e81258471fa..29aba762a4f1 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -44,9 +44,13 @@
>    * Size of integrity metadata is usually small, 1 inline sg should
>    * cover normal cases.
>    */
> +#ifdef CONFIG_ARCH_NO_SG_CHAIN
> +#define  SCSI_INLINE_PROT_SG_CNT  0
> +#define  SCSI_INLINE_SG_CNT  0
> +#else
>   #define  SCSI_INLINE_PROT_SG_CNT  1
> -
>   #define  SCSI_INLINE_SG_CNT  2
> +#endif

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
