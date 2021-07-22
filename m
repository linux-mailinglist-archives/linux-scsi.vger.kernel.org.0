Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11BAD3D2B2B
	for <lists+linux-scsi@lfdr.de>; Thu, 22 Jul 2021 19:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhGVQum (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 22 Jul 2021 12:50:42 -0400
Received: from mail-pj1-f47.google.com ([209.85.216.47]:35415 "EHLO
        mail-pj1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhGVQum (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 22 Jul 2021 12:50:42 -0400
Received: by mail-pj1-f47.google.com with SMTP id pf12-20020a17090b1d8cb0290175c085e7a5so5375789pjb.0;
        Thu, 22 Jul 2021 10:31:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eVHHVSJjH/j4gmKR/ewmFGqTfbLl6ki6lavAgxsu1EQ=;
        b=pnsg0T/kiezzwlzGwRmw9bZmvzfDb8IrSwC/BJctYYB28eMDgTy+6veFxGLiUuu0Rb
         WzUzqhfWsM+VRm4FNiIwj9UaVLaFn1Tl5Tr6arucZiQ1bJ0v36zO8imB2/XQrdRTKPYQ
         hegy649HjExvKLkXMNR6ziYlRuJuRnBlEvk/jBH1u/Ocfc5qWV4ir33dNhrICT1J4eFF
         zL9U9+LtL2gU1bJThnNBGcUVuaKZtmHQouIvU1hBnEAAn8JdGKngqNZSD/0XWzFsVO8z
         0thRbgdV5Y3zCwyuOz0R5xIprcOuAZWNl8s3ilA6KqBL7fUrMHRnXkfea3zd9vSXr17M
         Vlug==
X-Gm-Message-State: AOAM533hE7N9oJ5ZmHA5oudP0/C+7fu9AAqfsP6RiypwCYw7EBObrPc4
        mUxY7Of/j/104fiherTrekyygOHueIhI6nO6mSs=
X-Google-Smtp-Source: ABdhPJzoI32Y15CTTXdn9b1qibFFEWlkdl6pVaD8oYFGAZtMFUv8axwd9e2dKBbJq5DYIpj59G2M6A==
X-Received: by 2002:a63:34a:: with SMTP id 71mr980706pgd.289.1626975076439;
        Thu, 22 Jul 2021 10:31:16 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:1:6539:4b6a:66a5:486f])
        by smtp.gmail.com with ESMTPSA id m21sm26165407pjz.36.2021.07.22.10.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jul 2021 10:31:15 -0700 (PDT)
Subject: Re: [PATCH 01/24] bsg: remove support for SCSI_IOCTL_SEND_COMMAND
To:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc:     Doug Gilbert <dgilbert@interlog.com>,
        =?UTF-8?Q?Kai_M=c3=a4kisara?= <Kai.Makisara@kolumbus.fi>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20210712054816.4147559-1-hch@lst.de>
 <20210712054816.4147559-2-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <07be7708-2084-d682-15f8-626ad0a5753f@acm.org>
Date:   Thu, 22 Jul 2021 10:31:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210712054816.4147559-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 7/11/21 10:47 PM, Christoph Hellwig wrote:
> SCSI_IOCTL_SEND_COMMAND has been deprecated longer than bsg exists
> and has been warning for just as long.  More importantly it harcodes
> SCSI CDBs and thus will do the wrong thing on non-scsi bsg nodes.
> 
> Fixes: aa387cc89567 ("block: add bsg helper library")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/bsg.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/block/bsg.c b/block/bsg.c
> index 1f196563ae6c..79b42c5cafeb 100644
> --- a/block/bsg.c
> +++ b/block/bsg.c
> @@ -373,10 +373,13 @@ static long bsg_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>   	case SG_GET_RESERVED_SIZE:
>   	case SG_SET_RESERVED_SIZE:
>   	case SG_EMULATED_HOST:
> -	case SCSI_IOCTL_SEND_COMMAND:
>   		return scsi_cmd_ioctl(bd->queue, NULL, file->f_mode, cmd, uarg);
>   	case SG_IO:
>   		return bsg_sg_io(bd->queue, file->f_mode, uarg);
> +	case SCSI_IOCTL_SEND_COMMAND:
> +		pr_warn_ratelimited("%s: calling unsupported SCSI_IOCTL_SEND_COMMAND\n",
> +				current->comm);
> +		return -EINVAL;
>   	default:
>   		return -ENOTTY;
>   	}

The Fixes: tag will cause this patch to be backported to stable trees. 
Is that intentional?

Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
