Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20BB53571E
	for <lists+linux-scsi@lfdr.de>; Wed,  5 Jun 2019 08:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfFEGlQ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 5 Jun 2019 02:41:16 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35347 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfFEGlQ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 5 Jun 2019 02:41:16 -0400
Received: by mail-wm1-f67.google.com with SMTP id c6so1015749wml.0;
        Tue, 04 Jun 2019 23:41:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=EXBMxmzqDPj7w9jPTlfNNH3NFLsZs2zArvJ0g4zjxl0=;
        b=WjeU8Pbndph2iWAwesXyBbGBdbPyPePHx2RFS+cyPLz7ulIaIK2SdY/L/KSkj1apdd
         V3PCAe/m9bNwvsTICe1iXjOo5qVBddPJpmdUAyBT8ohvfqEjDu6FY8j2wBE03g5mZdJR
         Bx0l6BzFIFegtJpp4Y3gFxvGCHOauXsCiZTn6sNTydOdCtghkl1e8usoFHYA2cA/WoG8
         +jC+3nfDu1riqrbYY3GV7QlKYPuIUCD7plwnpeaGnTlJ4arN1oKSkiXeS/7gso/nRY0x
         ePSYf/2ohC386PJAldqGxJcQjC0X6wWDFVrSnyZdxZGp7Ta54FNu3wpgP0MbOLy52N8f
         S9XA==
X-Gm-Message-State: APjAAAU9G6XAPBnqnkbXsO5bV0u87m1PvWrpfG75MTfPBokqISMVSpSU
        9jEwVYt/IRG4iytRygwKVxg5TWi3
X-Google-Smtp-Source: APXvYqyfCMjwJUQp05GdEULwrTvClpb3/I41JYZJM0ML1ALho8OoU+c1Rfk5kIrRAMkXDSEk8FT6lA==
X-Received: by 2002:a1c:4e19:: with SMTP id g25mr21144180wmh.156.1559716873774;
        Tue, 04 Jun 2019 23:41:13 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id 197sm19459812wma.36.2019.06.04.23.41.12
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 23:41:13 -0700 (PDT)
Subject: Re: [PATCH] sg: fix a double-fetch bug in sg_write()
To:     Gen Zhang <blackgod016574@gmail.com>, dgilbert@interlog.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190531012704.GA4541@zhanggen-UX430UQ>
From:   Jiri Slaby <jslaby@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=jslaby@suse.cz; prefer-encrypt=mutual; keydata=
 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
Message-ID: <38bbd54f-d85b-e529-36ad-5c1809bb435f@suse.cz>
Date:   Wed, 5 Jun 2019 08:41:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190531012704.GA4541@zhanggen-UX430UQ>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 31. 05. 19, 3:27, Gen Zhang wrote:
> In sg_write(), the opcode of the command is fetched the first time from 
> the userspace by __get_user(). Then the whole command, the opcode 
> included, is fetched again from userspace by __copy_from_user(). 
> However, a malicious user can change the opcode between the two fetches.
> This can cause inconsistent data and potential errors as cmnd is used in
> the following codes.
> 
> Thus we should check opcode between the two fetches to prevent this.
> 
> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> ---
> diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
> index d3f1531..a2971b8 100644
> --- a/drivers/scsi/sg.c
> +++ b/drivers/scsi/sg.c
> @@ -694,6 +694,8 @@ sg_write(struct file *filp, const char __user *buf, size_t count, loff_t * ppos)
>  	hp->flags = input_size;	/* structure abuse ... */
>  	hp->pack_id = old_hdr.pack_id;
>  	hp->usr_ptr = NULL;
> +	if (opcode != cmnd[0])
> +		return -EINVAL;
>  	if (__copy_from_user(cmnd, buf, cmd_size))
>  		return -EFAULT;

You are sending the same patches like a broken machine. Please STOP this
and give people some time to actually review your patches! (Don't expect
replies in days.)

I already commented on this apparently broken one earlier...

thanks,
-- 
js
suse labs
