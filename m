Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17DFB345016
	for <lists+linux-scsi@lfdr.de>; Mon, 22 Mar 2021 20:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbhCVTkv (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 22 Mar 2021 15:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbhCVTkZ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 22 Mar 2021 15:40:25 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CFAC061574;
        Mon, 22 Mar 2021 12:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=lZV1Q08Gt9KcwF0VrymmjoQBEVGQpCTheMonie5ZjV0=; b=cVhy76GkuquX1eEbjZdNcAYQqR
        +Hv0YTy9rXkeLRg19RxmchipTPQQWxj1iuszTYWLxA7KEvJMzyI1sUQWeex7n4Cmfzg/u6knfJaBd
        D4f9Ne8pJwFLW6feOR8UoLBMKEsmTX6sOLHqO5CWtnFvUIGMz1FBHJ20tMEQD8vtfHCaaS3igEwc4
        8acdKymN8uuWY4IDSmcyZWqF90a+fEc3Nv0W+zR9BStfdcRvINmPrNppM7sW7fkgH2ZgbkOLJMy5u
        VF0IQAuN2nzr6uRFDwFWiN86w1LayuXXyG05usUTVRvY34ybTHnlOAmsaiiECBjHuZCtvyH9ElJ2Y
        3xCZPcnQ==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOQPX-00CRe7-AQ; Mon, 22 Mar 2021 19:40:23 +0000
Subject: Re: [PATCH] scsi: bnx2fc: Fix a typo
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, skashyap@marvell.com,
        jhasan@marvell.com, GR-QLogic-Storage-Upstream@marvell.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210322063530.3588282-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <342e394a-b7f6-a84c-3635-2ddd239e4c39@infradead.org>
Date:   Mon, 22 Mar 2021 12:40:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210322063530.3588282-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 3/21/21 11:35 PM, Bhaskar Chowdhury wrote:
> 
> s/struture/structure/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  drivers/scsi/bnx2fc/bnx2fc_fcoe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
> index 16bb6d2f98de..8863a74e6c57 100644
> --- a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
> +++ b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
> @@ -1796,7 +1796,7 @@ static void bnx2fc_unbind_pcidev(struct bnx2fc_hba *hba)
>  /**
>   * bnx2fc_ulp_get_stats - cnic callback to populate FCoE stats
>   *
> - * @handle:    transport handle pointing to adapter struture
> + * @handle:    transport handle pointing to adapter structure
>   */
>  static int bnx2fc_ulp_get_stats(void *handle)
>  {
> --


-- 
~Randy

