Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D572421A257
	for <lists+linux-scsi@lfdr.de>; Thu,  9 Jul 2020 16:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgGIOnX (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 9 Jul 2020 10:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgGIOnW (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 9 Jul 2020 10:43:22 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C84C08C5CE
        for <linux-scsi@vger.kernel.org>; Thu,  9 Jul 2020 07:43:22 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f18so2095438wml.3
        for <linux-scsi@vger.kernel.org>; Thu, 09 Jul 2020 07:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=6KoAFUsUrZ7flV3NXYhvK8N5k4F/lRegtCNv8DS45bg=;
        b=LUNGXiDbl9DtqNPaT0f+H1y3L1yDl4rS2y10Dzyjb8SoAMWd2asubpPUen66Ck2nJK
         /991ZvY0dwfsdsbdgys/rxK54Xd036ElXK4ihRhe5/89CryfYkLHBrqrsunggcvRltx4
         JByvg6VrJV32KsLeyyJ7OZvMLosm3ny0gHMPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=6KoAFUsUrZ7flV3NXYhvK8N5k4F/lRegtCNv8DS45bg=;
        b=HSC+0Bje4iVwhxZd54EyZ8t225ivJDGYkRtPXj4zAOiTcN0mA+NrRFPuoWdHPb6SiY
         UDigRyyFo75FjeZE07PK3hmXKiYtGkibaVXQ5Ur95Ihi5c18dgcOOI8w/JCGrnk6doXe
         N7N8KjJSCQYi1i/ur6Ehy55DIlRb0EhQa/dXia3T499AMGAvIdA1ERwH02dANFrQPq5t
         6Cz7p+P2sEUClRTgaCwL26jbGsReSQckdBxQokUpC56ktiOWsHCvpzhlw+9JkhCaLYfM
         89MS8GtizKeSkGXOi1fGUjGs56eTCAZEAaCJYsaqrz7Y2QVwIF1caHP2zXh0MfryN2ez
         sfqQ==
X-Gm-Message-State: AOAM5325X37fjZ+GijIyPmqVth0ZPd30wSuDpJ3IjAVptgaU+GEubVKW
        LL4/ngHZdt3bjIlrc3L8aQZd59gG3gc=
X-Google-Smtp-Source: ABdhPJxaudZr04lUjxPGVUndU4tGUVgotYNJeA9ASesDFcG2ySk1xc9QRQlgAlKkgaE0phMmj5sGcg==
X-Received: by 2002:a05:600c:414f:: with SMTP id h15mr423555wmm.82.1594305801080;
        Thu, 09 Jul 2020 07:43:21 -0700 (PDT)
Received: from [192.168.1.237] (ip68-5-85-189.oc.oc.cox.net. [68.5.85.189])
        by smtp.gmail.com with ESMTPSA id g14sm5859528wrm.93.2020.07.09.07.43.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 07:43:20 -0700 (PDT)
Subject: Re: [PATCH v2] scsi: lpfc: Fix a condition in lpfc_dmp_dbg()
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20200709105826.GH2571@kadam>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <3c46ca75-54d7-7f75-edfb-514b34b003dc@broadcom.com>
Date:   Thu, 9 Jul 2020 07:43:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200709105826.GH2571@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 7/9/2020 3:58 AM, Dan Carpenter wrote:
> These variables are unsigned so the result of the subtraction is also
> unsigned and thus can't be negative.  Change it to a comparison and
> remove the subtraction.
>
> Fixes: 372c187b8a70 ("scsi: lpfc: Add an internal trace log buffer")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> v2:  I reverse the if statement in v1
>
>   drivers/scsi/lpfc/lpfc_init.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
> index 7285b0114837..2bb2c96e7784 100644
> --- a/drivers/scsi/lpfc/lpfc_init.c
> +++ b/drivers/scsi/lpfc/lpfc_init.c
> @@ -14152,7 +14152,7 @@ void lpfc_dmp_dbg(struct lpfc_hba *phba)
>   		if ((start_idx + dbg_cnt) > (DBG_LOG_SZ - 1)) {
>   			temp_idx = (start_idx + dbg_cnt) % DBG_LOG_SZ;
>   		} else {
> -			if ((start_idx - dbg_cnt) < 0) {
> +			if (start_idx < dbg_cnt) {
>   				start_idx = DBG_LOG_SZ - (dbg_cnt - start_idx);
>   				temp_idx = 0;
>   			} else {

Already resolved/accepted.

https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git/commit/?id=77dd7d7b3442

Thank you though.

-- james

