Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5508679005
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Jul 2019 17:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbfG2P7j (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 29 Jul 2019 11:59:39 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39624 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725209AbfG2P7i (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 29 Jul 2019 11:59:38 -0400
Received: by mail-pf1-f196.google.com with SMTP id f17so24265369pfn.6
        for <linux-scsi@vger.kernel.org>; Mon, 29 Jul 2019 08:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Fy+lN0OwLd6fOqqUGg68zG7G00YlFLJqLocnUSRFmVM=;
        b=Zop7xNtPQ1s9WxoKX8f62BD7v3ypviuSQaZjaKt1TXInnW97keE9vqYkjWxXUaMdQ4
         rUn7GmaBF0XbbuVOST4bzciPg2CXIfDz2nlxWHBSoMwUeX2QsP35YvJxE6KOduiD75gU
         n/HF1X4kpBU0NeK98nN69yAK5iXshX+hgDPjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fy+lN0OwLd6fOqqUGg68zG7G00YlFLJqLocnUSRFmVM=;
        b=SxOCw11GR37HsygAQLm2tUFYutXFoSVupEj+Wqn4gLqGTzKB8AdyXZSPQs4IBkBRSS
         i1e23wEOR/KK96pZygjPisI7bkTyr6ZHMf2cx2W6QADtHH6bE0Y7vs2CwMfI0B/xsXjU
         TgQA6VjbvPmX6IV64Xrx+fSRO+eAsAri0ohwCofX2Rl+lVniyU6OSnb5GN7d7V96I8dD
         hTyuSqH265CFA8tnqLoybOMLjneXxIHnUuMT81Kl4bYqj5R11iv0Ayu0PppLdI+EHKSR
         oFoaVaw2A5qz6Cp8iJ7DWR6Sy+ro3slLO07aJ/FsouGxttkQFCty2sJXzTuHBQr6jN4X
         E6FA==
X-Gm-Message-State: APjAAAWhfff1v1L6x2Lk0Ul283cYs+SxLToBgIFeftaDUoFeCFtTeIU4
        mxrHPOyEMh01rjjcRon/okGVig==
X-Google-Smtp-Source: APXvYqxXhTl1Km+BhA4YLQk6yq84HYqbOSMG2rM4UatnZC9TQtbjXWxl323JxWbn0L12SnCRCo4UWw==
X-Received: by 2002:a63:ee04:: with SMTP id e4mr80079542pgi.53.1564415977924;
        Mon, 29 Jul 2019 08:59:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i9sm61745740pgo.46.2019.07.29.08.59.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 08:59:37 -0700 (PDT)
Date:   Mon, 29 Jul 2019 08:59:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] scsi: qlogicpti: Mark expected switch fall-throughs
Message-ID: <201907290859.FCDA1B9F@keescook>
References: <20190729110345.GA2603@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729110345.GA2603@embeddedor>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, Jul 29, 2019 at 06:03:45AM -0500, Gustavo A. R. Silva wrote:
> Mark switch cases where we are expecting to fall through.
> 
> This patch fixes the following warnings (Building: sparc defconfig):
> 
> drivers/scsi/qlogicpti.c: In function 'qlogicpti_mbox_command':
> drivers/scsi/qlogicpti.c:202:10: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   case 6: sbus_writew(param[5], qpti->qregs + MBOX5);
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/scsi/qlogicpti.c:203:2: note: here
>   case 5: sbus_writew(param[4], qpti->qregs + MBOX4);
>   ^~~~
> drivers/scsi/qlogicpti.c:203:10: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   case 5: sbus_writew(param[4], qpti->qregs + MBOX4);
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/scsi/qlogicpti.c:204:2: note: here
>   case 4: sbus_writew(param[3], qpti->qregs + MBOX3);
>   ^~~~
> drivers/scsi/qlogicpti.c:204:10: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   case 4: sbus_writew(param[3], qpti->qregs + MBOX3);
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/scsi/qlogicpti.c:205:2: note: here
>   case 3: sbus_writew(param[2], qpti->qregs + MBOX2);
>   ^~~~
> drivers/scsi/qlogicpti.c:205:10: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   case 3: sbus_writew(param[2], qpti->qregs + MBOX2);
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/scsi/qlogicpti.c:206:2: note: here
>   case 2: sbus_writew(param[1], qpti->qregs + MBOX1);
>   ^~~~
> drivers/scsi/qlogicpti.c:206:10: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   case 2: sbus_writew(param[1], qpti->qregs + MBOX1);
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/scsi/qlogicpti.c:207:2: note: here
>   case 1: sbus_writew(param[0], qpti->qregs + MBOX0);
>   ^~~~
> drivers/scsi/qlogicpti.c:256:19: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   case 6: param[5] = sbus_readw(qpti->qregs + MBOX5);
>           ~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/scsi/qlogicpti.c:257:2: note: here
>   case 5: param[4] = sbus_readw(qpti->qregs + MBOX4);
>   ^~~~
> drivers/scsi/qlogicpti.c:257:19: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   case 5: param[4] = sbus_readw(qpti->qregs + MBOX4);
>           ~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/scsi/qlogicpti.c:258:2: note: here
>   case 4: param[3] = sbus_readw(qpti->qregs + MBOX3);
>   ^~~~
> drivers/scsi/qlogicpti.c:258:19: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   case 4: param[3] = sbus_readw(qpti->qregs + MBOX3);
>           ~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/scsi/qlogicpti.c:259:2: note: here
>   case 3: param[2] = sbus_readw(qpti->qregs + MBOX2);
>   ^~~~
> drivers/scsi/qlogicpti.c:259:19: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   case 3: param[2] = sbus_readw(qpti->qregs + MBOX2);
>           ~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/scsi/qlogicpti.c:260:2: note: here
>   case 2: param[1] = sbus_readw(qpti->qregs + MBOX1);
>   ^~~~
> drivers/scsi/qlogicpti.c:260:19: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   case 2: param[1] = sbus_readw(qpti->qregs + MBOX1);
>           ~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/scsi/qlogicpti.c:261:2: note: here
>   case 1: param[0] = sbus_readw(qpti->qregs + MBOX0);
>   ^~~~
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/scsi/qlogicpti.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/scsi/qlogicpti.c b/drivers/scsi/qlogicpti.c
> index 9335849f6bea..d539beef3ce8 100644
> --- a/drivers/scsi/qlogicpti.c
> +++ b/drivers/scsi/qlogicpti.c
> @@ -200,10 +200,15 @@ static int qlogicpti_mbox_command(struct qlogicpti *qpti, u_short param[], int f
>  	/* Write mailbox command registers. */
>  	switch (mbox_param[param[0]] >> 4) {
>  	case 6: sbus_writew(param[5], qpti->qregs + MBOX5);
> +		/* Fall through */
>  	case 5: sbus_writew(param[4], qpti->qregs + MBOX4);
> +		/* Fall through */
>  	case 4: sbus_writew(param[3], qpti->qregs + MBOX3);
> +		/* Fall through */
>  	case 3: sbus_writew(param[2], qpti->qregs + MBOX2);
> +		/* Fall through */
>  	case 2: sbus_writew(param[1], qpti->qregs + MBOX1);
> +		/* Fall through */
>  	case 1: sbus_writew(param[0], qpti->qregs + MBOX0);
>  	}
>  
> @@ -254,10 +259,15 @@ static int qlogicpti_mbox_command(struct qlogicpti *qpti, u_short param[], int f
>  	/* Read back output parameters. */
>  	switch (mbox_param[param[0]] & 0xf) {
>  	case 6: param[5] = sbus_readw(qpti->qregs + MBOX5);
> +		/* Fall through */
>  	case 5: param[4] = sbus_readw(qpti->qregs + MBOX4);
> +		/* Fall through */
>  	case 4: param[3] = sbus_readw(qpti->qregs + MBOX3);
> +		/* Fall through */
>  	case 3: param[2] = sbus_readw(qpti->qregs + MBOX2);
> +		/* Fall through */
>  	case 2: param[1] = sbus_readw(qpti->qregs + MBOX1);
> +		/* Fall through */
>  	case 1: param[0] = sbus_readw(qpti->qregs + MBOX0);
>  	}
>  
> -- 
> 2.22.0
> 

-- 
Kees Cook
