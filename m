Return-Path: <linux-scsi+bounces-894-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E02580F79D
	for <lists+linux-scsi@lfdr.de>; Tue, 12 Dec 2023 21:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECAFE281FC4
	for <lists+linux-scsi@lfdr.de>; Tue, 12 Dec 2023 20:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B444A63BED;
	Tue, 12 Dec 2023 20:14:19 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42175A5;
	Tue, 12 Dec 2023 12:14:17 -0800 (PST)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d0c4d84bf6so36733335ad.1;
        Tue, 12 Dec 2023 12:14:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702412057; x=1703016857;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KymjChpn+W/EoA8lrLNNU5MTNVyrEAJwx7+J+qgDA8M=;
        b=KACuKOnSaYhkzlR9k/uaILju7elcvZsg9f9ijYCbyMP+2EnaX406f18tKL7eQmve0G
         rfh7tZlbxUm4bhKfAFlahEcD/TjHWoJuMk0qo3Lv9oIO6kkjs/xuANd0P8XgpBiM6Hik
         kOkF+s0DA1ILw3lhAz+eyVmEzJJXWK8on4eL7eFluKNTe1Q78MiSiQi6AyMaXBWEaqiL
         cA5ZBqXK0sTsUnhZ8fY4x5bTdrX18NIIxxExPzhionS8MBtlexhh5oL+TXY4HoRDSHx6
         QYLnuYVgu0jMyjX+JLvtCj5vd2ZDIPYEr7HeqhcqzvnkUIS/UVth+7lX0AQamEnewisW
         M6+g==
X-Gm-Message-State: AOJu0YzKyZWC2SPaAlI7CbpQ3HO6vJyhxfUcU0eNjC+EqPLd4/le1Dl3
	yTGaFmjLp4C2UFyxGtIyiNDHUwer4pE=
X-Google-Smtp-Source: AGHT+IFJ9o9j/cg0bjQ1fZO08UyLxhkh6Z/ewxt+SpRNj+9OxmnXvilL60zcbt+bqlQzE1ysrk720w==
X-Received: by 2002:a17:902:d2cf:b0:1d0:c986:8aae with SMTP id n15-20020a170902d2cf00b001d0c9868aaemr4231815plc.97.1702412056545;
        Tue, 12 Dec 2023 12:14:16 -0800 (PST)
Received: from ?IPV6:2620:0:1000:5e10:c59a:35c6:9a2a:969f? ([2620:0:1000:5e10:c59a:35c6:9a2a:969f])
        by smtp.gmail.com with ESMTPSA id k10-20020a170902694a00b001cca8a01e68sm8970483plt.278.2023.12.12.12.14.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 12:14:16 -0800 (PST)
Message-ID: <dac24fac-57eb-4ca8-b819-fbdc24464d94@acm.org>
Date: Tue, 12 Dec 2023 12:14:14 -0800
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] scsi: myrb: Fix a potential string truncation in
 rebuild_show()
Content-Language: en-US
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, hare@kernel.org,
 jejb@linux.ibm.com, martin.petersen@oracle.com
Cc: hare@suse.com, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <cover.1702411083.git.christophe.jaillet@wanadoo.fr>
 <2d3096dd4b1b6e758287e4062e3147c57c007eaa.1702411083.git.christophe.jaillet@wanadoo.fr>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <2d3096dd4b1b6e758287e4062e3147c57c007eaa.1702411083.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/12/23 10:09, Christophe JAILLET wrote:
> "physical device - not rebuilding\n" is 34 bytes long. When written in
> 'buf' with a limit of 32 bytes, it is truncated.
> 
> When building with W=1, it leads to:
>     drivers/scsi/myrb.c: In function ‘rebuild_show’:
>     drivers/scsi/myrb.c:1906:24: error: ‘physical device - not rebuil...’ directive output truncated writing 33 bytes into a region of size 32 [-Werror=format-truncation=]
>      1906 |                 return snprintf(buf, 32, "physical device - not rebuilding\n");
>           |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     drivers/scsi/myrb.c:1906:24: note: ‘snprintf’ output 34 bytes into a destination of size 32
> 
> Change the allowed size to 64 to fix the issue.
> 
> Fixes: 081ff398c56c ("scsi: myrb: Add Mylex RAID controller (block interface)")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   drivers/scsi/myrb.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/scsi/myrb.c b/drivers/scsi/myrb.c
> index ca2e932dd9b7..ca2380d2d6d3 100644
> --- a/drivers/scsi/myrb.c
> +++ b/drivers/scsi/myrb.c
> @@ -1903,15 +1903,15 @@ static ssize_t rebuild_show(struct device *dev,
>   	unsigned char status;
>   
>   	if (sdev->channel < myrb_logical_channel(sdev->host))
> -		return snprintf(buf, 32, "physical device - not rebuilding\n");
> +		return snprintf(buf, 64, "physical device - not rebuilding\n");
>   
>   	status = myrb_get_rbld_progress(cb, &rbld_buf);
>   
>   	if (rbld_buf.ldev_num != sdev->id ||
>   	    status != MYRB_STATUS_SUCCESS)
> -		return snprintf(buf, 32, "not rebuilding\n");
> +		return snprintf(buf, 64, "not rebuilding\n");
>   
> -	return snprintf(buf, 32, "rebuilding block %u of %u\n",
> +	return snprintf(buf, 64, "rebuilding block %u of %u\n",
>   			rbld_buf.ldev_size - rbld_buf.blocks_left,
>   			rbld_buf.ldev_size);
>   }

Anyone who sees the resulting code without having seen the above patch will
wonder where the magic number '64' comes from. Please use sysfs_emit() instead
of snprintf(buf, 64, ...).

Thanks,

Bart.

