Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 650EB32B0B
	for <lists+linux-scsi@lfdr.de>; Mon,  3 Jun 2019 10:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbfFCIp0 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 3 Jun 2019 04:45:26 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:56791 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726653AbfFCIp0 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 3 Jun 2019 04:45:26 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45HTCL5n0hz9v0D9;
        Mon,  3 Jun 2019 10:45:18 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=WPHhyKe+; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id EQ8AzAKtaaNi; Mon,  3 Jun 2019 10:45:18 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45HTCL4d8Zz9v0D6;
        Mon,  3 Jun 2019 10:45:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1559551518; bh=EIz0NOWAX/uobIhHG6/is2QasF1BW3QEbpzGLpjwL20=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WPHhyKe+I1HWbWe98+E4FhOSpt26176vUn6v3/2lkFHz1L1LOr2Xmj8wZWUmsR+eC
         3tVRjZfv5eBf/GrTrixBbDrhI47OrRfp2EBRUMapPoOGlfOTohOZeXLD8bvmkraJO3
         3pl2dBzGIRRSLmUhQvogdilTN1N6QHLR58kQqz/8=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 555348B7B1;
        Mon,  3 Jun 2019 10:45:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id oJf0fEAn0lyt; Mon,  3 Jun 2019 10:45:23 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id ECC778B7B8;
        Mon,  3 Jun 2019 10:45:22 +0200 (CEST)
Subject: Re: [PATCH] scsi: ibmvscsi: Don't use rc uninitialized in
 ibmvscsi_do_work
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     clang-built-linux@googlegroups.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20190531185306.41290-1-natechancellor@gmail.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <d932b755-606e-6847-a460-da463411c562@c-s.fr>
Date:   Mon, 3 Jun 2019 10:45:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190531185306.41290-1-natechancellor@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org



Le 31/05/2019 à 20:53, Nathan Chancellor a écrit :
> clang warns:
> 
> drivers/scsi/ibmvscsi/ibmvscsi.c:2126:7: warning: variable 'rc' is used
> uninitialized whenever switch case is taken [-Wsometimes-uninitialized]
>          case IBMVSCSI_HOST_ACTION_NONE:
>               ^~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/scsi/ibmvscsi/ibmvscsi.c:2151:6: note: uninitialized use occurs
> here
>          if (rc) {
>              ^~
> 
> Initialize rc to zero so that the atomic_set and dev_err statement don't
> trigger for the cases that just break.
> 
> Fixes: 035a3c4046b5 ("scsi: ibmvscsi: redo driver work thread to use enum action states")
> Link: https://github.com/ClangBuiltLinux/linux/issues/502
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>   drivers/scsi/ibmvscsi/ibmvscsi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.c b/drivers/scsi/ibmvscsi/ibmvscsi.c
> index 727c31dc11a0..6714d8043e62 100644
> --- a/drivers/scsi/ibmvscsi/ibmvscsi.c
> +++ b/drivers/scsi/ibmvscsi/ibmvscsi.c
> @@ -2118,7 +2118,7 @@ static unsigned long ibmvscsi_get_desired_dma(struct vio_dev *vdev)
>   static void ibmvscsi_do_work(struct ibmvscsi_host_data *hostdata)
>   {
>   	unsigned long flags;
> -	int rc;
> +	int rc = 0;

I don't think the above is the best solution, as it hides the warning 
instead of really fixing it.

Your problem is that some legs of the switch are missing setting the 
value of rc, it would therefore be better to fix the legs instead of 
setting a default value which may not be correct for every case, 
allthough it may be at the time being.

Christophe


>   	char *action = "reset";
>   
>   	spin_lock_irqsave(hostdata->host->host_lock, flags);
> 
