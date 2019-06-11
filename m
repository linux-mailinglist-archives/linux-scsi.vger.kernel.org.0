Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25AAD3D5EC
	for <lists+linux-scsi@lfdr.de>; Tue, 11 Jun 2019 20:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403831AbfFKSzO (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 11 Jun 2019 14:55:14 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43306 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389470AbfFKSzO (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 11 Jun 2019 14:55:14 -0400
Received: by mail-pf1-f196.google.com with SMTP id i189so7990479pfg.10
        for <linux-scsi@vger.kernel.org>; Tue, 11 Jun 2019 11:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=f3Fru+mwaeeiACG0X3g8c6CHiLSWKaplSTQC87ROeuQ=;
        b=c6xH5/Qvawf6qJjZ/xM+E56es8JaiVT0/DwVftgp6f87+AJuA/RU/4CQiSYxjtTfmG
         PSGytVbNJaOJtBjFzeOwwwcZDYYtXTZmoKwnT7IqB4KcdYfiPUlVDqNFeWYP6/AJw9uO
         rrLzkJOifPfW/e9lmiCnGCeMRGrhln8IV1Ne8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=f3Fru+mwaeeiACG0X3g8c6CHiLSWKaplSTQC87ROeuQ=;
        b=mKYXqWmxQ3gw67hwL4TAk9em9TRn18GxP8Es8AGIliduMWQl6n7Pfms6nTalGMEfUQ
         ebgenaiqXwr+3GkXqENYWIlY9Bb2KhnSuc67NjWCZ/igm7wKLsIUsAKegRQAFpALqRnM
         ClTr/D1MwlTxckK5FkXBfeBcYLsPVoj7/5Co1UHz6sJ80WogpU+ThrwnHqMNAnirHTBK
         UFF30Yeupqw1yrHA4tzfWYPSqqubRgG5+tCNou0Ny8meUTWSJdPBD7f7bf4uIECKDjM2
         VcOUj65djBUS8lOsveXgrPuoz475x+SKALGjy8rqQntg6GkNn6l8WZl46RRUS1rX86um
         ucWg==
X-Gm-Message-State: APjAAAVAuew2QDiy/doPp5PqoE44qeF4fa2xfg/V4yh2wZDBeYkD6s5W
        u+5fEiQQnG+I1Ql5NVAtMTQivg==
X-Google-Smtp-Source: APXvYqykLtoCMjK8ld6JD/RyOsTdfyoOM9u/UwTo1BXGOV4lbmZpi4MRGTiLpIKmeU10fMKb1YddfA==
X-Received: by 2002:a62:4dc5:: with SMTP id a188mr82792699pfb.8.1560279313566;
        Tue, 11 Jun 2019 11:55:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a186sm17123614pfa.188.2019.06.11.11.55.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Jun 2019 11:55:12 -0700 (PDT)
Date:   Tue, 11 Jun 2019 11:55:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: mpt3sas: Mark expected switch fall-through
Message-ID: <201906111153.4413672DE8@keescook>
References: <20190611150219.GA19152@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190611150219.GA19152@embeddedor>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, Jun 11, 2019 at 10:02:19AM -0500, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> This patch fixes the following warning:
> 
> drivers/scsi/mpt3sas/mpt3sas_base.c: In function ‘_base_update_ioc_page1_inlinewith_perf_mode’:
> drivers/scsi/mpt3sas/mpt3sas_base.c:4510:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (ioc->high_iops_queues) {
>       ^
> drivers/scsi/mpt3sas/mpt3sas_base.c:4530:2: note: here
>   case MPT_PERF_MODE_LATENCY:
>   ^~~~
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Fixes: 30cb97023f38 ("scsi: mpt3sas: Introduce perf_mode module parameter")
Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/scsi/mpt3sas/mpt3sas_base.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
> index e6377ec07f6c..9fefcd1e9c97 100644
> --- a/drivers/scsi/mpt3sas/mpt3sas_base.c
> +++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
> @@ -4527,6 +4527,7 @@ _base_update_ioc_page1_inlinewith_perf_mode(struct MPT3SAS_ADAPTER *ioc)
>  			ioc_info(ioc, "performance mode: balanced\n");
>  			return;
>  		}
> +		/* Fall through */
>  	case MPT_PERF_MODE_LATENCY:
>  		/*
>  		 * Enable interrupt coalescing on all reply queues
> -- 
> 2.21.0
> 

-- 
Kees Cook
