Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A1238D7A7
	for <lists+linux-scsi@lfdr.de>; Sun, 23 May 2021 00:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbhEVWip (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 22 May 2021 18:38:45 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:47670 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbhEVWip (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 22 May 2021 18:38:45 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 43FA62ABE7;
        Sat, 22 May 2021 18:37:16 -0400 (EDT)
Date:   Sun, 23 May 2021 08:37:15 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Hui Tang <tanghui20@huawei.com>
cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/24] scsi: sun3_scsi: remove leading spaces before
 tabs
In-Reply-To: <1621672648-39955-12-git-send-email-tanghui20@huawei.com>
Message-ID: <4bd6db59-414-221f-a8bc-49645511d56b@nippy.intranet>
References: <1621672648-39955-1-git-send-email-tanghui20@huawei.com> <1621672648-39955-12-git-send-email-tanghui20@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


On Sat, 22 May 2021, Hui Tang wrote:

> There are a few leading spaces before tabs and remove it by running
> the following commard:
> 
>     $ find . -name '*.[ch]' | xargs sed -r -i 's/^[ ]+\t/\t/'
> 

Acked-by: Finn Thain <fthain@telegraphics.com.au>

Is there a reason why your regexp is anchored? I thought spaces before any 
tab would be undesirable.

> Cc: Finn Thain <fthain@telegraphics.com.au>
> Signed-off-by: Hui Tang <tanghui20@huawei.com>
> ---
>  drivers/scsi/sun3_scsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/sun3_scsi.c b/drivers/scsi/sun3_scsi.c
> index 2e3fbc2..6125ed3 100644
> --- a/drivers/scsi/sun3_scsi.c
> +++ b/drivers/scsi/sun3_scsi.c
> @@ -304,7 +304,7 @@ static int sun3scsi_dma_setup(struct NCR5380_hostdata *hostdata,
>  	sun3_udc_write(UDC_INT_ENABLE, UDC_CSR);
>  #endif
>  	
> -       	return count;
> +	return count;
>  
>  }
>  
> 
