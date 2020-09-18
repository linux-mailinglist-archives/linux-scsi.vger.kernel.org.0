Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02518270032
	for <lists+linux-scsi@lfdr.de>; Fri, 18 Sep 2020 16:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgIROup (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 18 Sep 2020 10:50:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:48780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbgIROuo (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 18 Sep 2020 10:50:44 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3666D206A2;
        Fri, 18 Sep 2020 14:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600440644;
        bh=JExP6zY6h1SZ+wtyR7i6mlCSjsoYjKdw7KOOBUNXAiU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D3rOvNMzT9mEFbnA4MFiTcoObjFIpGjehVNLOXBwrwsKSHZYNOqw92zxlep3i2Hqt
         T3fv/Sn7jxA73Hbbq0GneNn2EeTw7dksfIYTjOuGXTXmWovvenGMijMhKfZ416gnVT
         tlIIBuTvLnGbuHc8C1sVfPTVj/CNFgOAIDbx4OZE=
Date:   Fri, 18 Sep 2020 09:56:19 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        lee.jones@linaro.org, colin.king@canonical.com, axboe@kernel.dk,
        mchehab+huawei@kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: arcmsr: Remove the superfluous break
Message-ID: <20200918145619.GA25599@embeddedor>
References: <20200918093230.49050-1-jingxiangfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918093230.49050-1-jingxiangfeng@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, Sep 18, 2020 at 05:32:30PM +0800, Jing Xiangfeng wrote:
> Remove the superfluous break, as there is a 'return' before it.
>

Apparently, the change is correct. Please, just add a proper Fixes tag by
yourself this time.

Thanks
--
Gustavo

> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
> ---
>  drivers/scsi/arcmsr/arcmsr_hba.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
> index ec895d0319f0..74add6d247d5 100644
> --- a/drivers/scsi/arcmsr/arcmsr_hba.c
> +++ b/drivers/scsi/arcmsr/arcmsr_hba.c
> @@ -2699,10 +2699,8 @@ static irqreturn_t arcmsr_interrupt(struct AdapterControlBlock *acb)
>  	switch (acb->adapter_type) {
>  	case ACB_ADAPTER_TYPE_A:
>  		return arcmsr_hbaA_handle_isr(acb);
> -		break;
>  	case ACB_ADAPTER_TYPE_B:
>  		return arcmsr_hbaB_handle_isr(acb);
> -		break;
>  	case ACB_ADAPTER_TYPE_C:
>  		return arcmsr_hbaC_handle_isr(acb);
>  	case ACB_ADAPTER_TYPE_D:
> -- 
> 2.17.1
> 
