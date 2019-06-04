Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C62D34F11
	for <lists+linux-scsi@lfdr.de>; Tue,  4 Jun 2019 19:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfFDRg6 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 4 Jun 2019 13:36:58 -0400
Received: from mail-pf1-f179.google.com ([209.85.210.179]:44773 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfFDRg6 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 4 Jun 2019 13:36:58 -0400
Received: by mail-pf1-f179.google.com with SMTP id t16so4287879pfe.11
        for <linux-scsi@vger.kernel.org>; Tue, 04 Jun 2019 10:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=PWMUIeKcA67ntqsV3am8FfBRihyiBy43QFk2ZFto7CM=;
        b=G8k+cLgghyl2S4FplSud+2bVMT5NKiA95E/EsvA3Id8eyBSWWQO+H1Qn36aGOI74od
         iyuS0NrPRJ64HY+TAVrnfwZ9nBi4eeJf96ZEoFmdgl7xys/3aTbklO7/n2BscPxhsCvr
         p4ccpj/UwN1PK+qd/SHqYHgWtvkcRccwSSGLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=PWMUIeKcA67ntqsV3am8FfBRihyiBy43QFk2ZFto7CM=;
        b=OMozneNmZgZChJB5ojZC7ypWT3Zdamfily4FIop1eAyL0tZ032/GJ8Y0zMtJx1GGZB
         C+ao8FjR18E6FDvQRuQxl8PGKO7oAQHE5V7PJ0jkJjdk9Q0nGMz4w6j0Rx+CX8/b3qNN
         toJxz0b7fLiQjUd1tCuJCLaI3uQqNiHqCq9f14SKZ6uDmNxYI3W+wQp6O/DvTSPRpAMv
         HXgE9P0rbaB1GT1V/WXjKIwCyAbWRjlY5cNMtncEMBHqVETcb62+G7TYPi3ca9Uz2bE4
         o2V2uGoBIH5vPm51bEj9dkG/7OTLb+jhAh4mSeLcFH+A6KmkQr+kPRz44KA1/3ArCjIL
         ORxA==
X-Gm-Message-State: APjAAAV862tnmvthynaBUtzOm3omZiJhMAT8PiUVvKKbiZM8IP+a1Bp4
        qB4BnII/q1PNd2gRiQDVxcHB7u0yvuzSNtLV0BB4BKt3tiurCdvWzTKLKEz2IX2ZkeigK3sxUy5
        kmZj+jfwEuch8QQMp8JmOhpX0S/GsYWOwCixXMWGArwnyWqsQKHBJ3IitprFlbq1/eOuZcczrYL
        ie
X-Google-Smtp-Source: APXvYqylI88kRmDNZ/oxDJWq9xsvDeuPxiCKRSLjyFzOzvV23vcUCd1kB3ZvXq0BVCsVf3c10ysEFw==
X-Received: by 2002:a17:90a:17cb:: with SMTP id q69mr10670208pja.8.1559669817477;
        Tue, 04 Jun 2019 10:36:57 -0700 (PDT)
Received: from [10.230.29.90] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id k13sm11247632pgq.45.2019.06.04.10.36.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 10:36:56 -0700 (PDT)
Subject: Re: [PATCH -next] scsi: lpfc: Make some symbols static
To:     YueHaibing <yuehaibing@huawei.com>, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        jsmart2021@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20190531152841.13684-1-yuehaibing@huawei.com>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <e9a78d2a-a756-c42e-0c8d-af8ebf262615@broadcom.com>
Date:   Tue, 4 Jun 2019 10:36:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190531152841.13684-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org



On 5/31/2019 8:28 AM, YueHaibing wrote:
> Fix sparse warnings:
>
> drivers/scsi/lpfc/lpfc_sli.c:115:1: warning: symbol 'lpfc_sli4_pcimem_bcopy' was not declared. Should it be static?
> drivers/scsi/lpfc/lpfc_sli.c:7854:1: warning: symbol 'lpfc_sli4_process_missed_mbox_completions' was not declared. Should it be static?
> drivers/scsi/lpfc/lpfc_nvmet.c:223:27: warning: symbol 'lpfc_nvmet_get_ctx_for_xri' was not declared. Should it be static?
> drivers/scsi/lpfc/lpfc_nvmet.c:245:27: warning: symbol 'lpfc_nvmet_get_ctx_for_oxid' was not declared. Should it be static?
> drivers/scsi/lpfc/lpfc_init.c:75:10: warning: symbol 'lpfc_present_cpu' was not declared. Should it be static?
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   drivers/scsi/lpfc/lpfc_init.c  | 2 +-
>   drivers/scsi/lpfc/lpfc_nvmet.c | 4 ++--
>   drivers/scsi/lpfc/lpfc_sli.c   | 4 ++--
>   3 files changed, 5 insertions(+), 5 deletions(-)
>
>

Looks good - thank You

Reviewed-by: James Smart  <james.smart@broadcom.com>


