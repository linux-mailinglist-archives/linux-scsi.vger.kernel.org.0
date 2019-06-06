Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8425937A8D
	for <lists+linux-scsi@lfdr.de>; Thu,  6 Jun 2019 19:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729909AbfFFRII (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 6 Jun 2019 13:08:08 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41553 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbfFFRII (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 6 Jun 2019 13:08:08 -0400
Received: by mail-pf1-f195.google.com with SMTP id q17so1886875pfq.8
        for <linux-scsi@vger.kernel.org>; Thu, 06 Jun 2019 10:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=DfWGqMsNhu0Wn9UXa5rpUQbIrk9rtIgPo7mJo0K3Iy0=;
        b=edOUZg3GANEHsuow5KsriAJk8/6SQssHjNCT4tBBHkNEMs7cc7BSBL3Y5TX+twtruP
         6TSMfZEm92SNNInMq87/gyoNQ336XCRS8pIlKvho5y7eSZB2ZIoGpjkMaChwJVN6lykR
         N+iefC9iJuKoXcUKxrzKy8O/cExO4RJci97F4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=DfWGqMsNhu0Wn9UXa5rpUQbIrk9rtIgPo7mJo0K3Iy0=;
        b=o27WgXHBXKdbHCkizZKJtFkqYK6zhkJKIoD1EZjsfc7YIHLl2qtsVCRThBE14RevE7
         mZ8QVN/iMOF6YOtjyS42s7ogHe8/x1/wh0HPwo3UPMppINm/NzwLF3riCI1yNDpJF0Ke
         SfXT4hsuyYwN9LW7id8sYDLS13C+Fw5+Ych7LRvpIQvvFucdz37FrVCrY8NoFnvMGc8J
         Z1pIddEp6avORb7AMxWH7fvTQdU3HarY6FrD37o6XR7Kb5Y6OpIA/ptzLgVzVI9AIYqd
         aJJDaxFMSGKg0zLGrpxpFwsa3bGo81unPIZ/GPURPUWKuP0NZdQsRfUIjT1P4pAYwWUr
         Z1WA==
X-Gm-Message-State: APjAAAUiWUaGJhMGzCu8LPoqLA/Lyi2RWQ/rNKGO8XL++sJFUVIGi9y6
        SxOA2C1z1wKMkIu1HyzsMVYPvA==
X-Google-Smtp-Source: APXvYqx1MzvkxzqJ8jjRho8uRYT9sXVTCtAk6vNSNa5xM12hkcJ+i72lyJF9dDCi4kO+O6iXQnbySw==
X-Received: by 2002:aa7:942f:: with SMTP id y15mr55190799pfo.121.1559840887916;
        Thu, 06 Jun 2019 10:08:07 -0700 (PDT)
Received: from [10.69.37.149] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id x25sm2648197pfm.48.2019.06.06.10.08.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 10:08:07 -0700 (PDT)
Subject: Re: [PATCH] scsi: lpfc: Avoid unused function warnings
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        YueHaibing <yuehaibing@huawei.com>
References: <20190606052421.103469-1-natechancellor@gmail.com>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <27ccc327-3a4b-f489-2b21-b68479e45519@broadcom.com>
Date:   Thu, 6 Jun 2019 10:08:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606052421.103469-1-natechancellor@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org



On 6/5/2019 10:24 PM, Nathan Chancellor wrote:
> When building powerpc pseries_defconfig or powernv_defconfig:
>
> drivers/scsi/lpfc/lpfc_nvmet.c:224:1: error: unused function
> 'lpfc_nvmet_get_ctx_for_xri' [-Werror,-Wunused-function]
> drivers/scsi/lpfc/lpfc_nvmet.c:246:1: error: unused function
> 'lpfc_nvmet_get_ctx_for_oxid' [-Werror,-Wunused-function]
>
> These functions are only compiled when CONFIG_NVME_TARGET_FC is enabled.
> Use that same condition so there is no more warning. While the fixes
> commit did not introduce these functions, it caused these warnings.
>
> Fixes: 4064b27417a7 ("scsi: lpfc: Make some symbols static")
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>   drivers/scsi/lpfc/lpfc_nvmet.c | 2 ++
>   1 file changed, 2 insertions(+)
>
>

Looks fine.

Reviewed-by:  James Smart  <james.smart@broadcom.com>


