Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0A8F4D22D
	for <lists+linux-scsi@lfdr.de>; Thu, 20 Jun 2019 17:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfFTPaH (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 20 Jun 2019 11:30:07 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:38798 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726661AbfFTPaH (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 20 Jun 2019 11:30:07 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 9C0FD8EE109;
        Thu, 20 Jun 2019 08:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1561044606;
        bh=j+ZEXqGm73MzhdiOTfPrr+7eP4WdvL0/NlUmNKWRH2g=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=h5kngsMzB7Lj6C0KiKXeEjbYUG6/j1Z9UW3KR8KBye5rh06DuWM5nad/3OncauyoS
         suGlQwfEaNzG1XTSzgVtgxCRAu3+VHYYaKey2UB5jdsRmuHhm5u2vMcRxaAJ9cS7rq
         9LJ3YX4gq9lAUlGZLfigcnILi39xebiAajIPnhlg=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id F12ohWY5pka9; Thu, 20 Jun 2019 08:30:06 -0700 (PDT)
Received: from jarvis.lan (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id E90618EE0CF;
        Thu, 20 Jun 2019 08:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1561044606;
        bh=j+ZEXqGm73MzhdiOTfPrr+7eP4WdvL0/NlUmNKWRH2g=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=h5kngsMzB7Lj6C0KiKXeEjbYUG6/j1Z9UW3KR8KBye5rh06DuWM5nad/3OncauyoS
         suGlQwfEaNzG1XTSzgVtgxCRAu3+VHYYaKey2UB5jdsRmuHhm5u2vMcRxaAJ9cS7rq
         9LJ3YX4gq9lAUlGZLfigcnILi39xebiAajIPnhlg=
Message-ID: <1561044605.7970.5.camel@HansenPartnership.com>
Subject: Re: [PATCH] scsi: mvumi: fix build warning
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Ming Lei <ming.lei@redhat.com>, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Ewan D . Milne" <emilne@redhat.com>
Date:   Thu, 20 Jun 2019 08:30:05 -0700
In-Reply-To: <20190620062622.9979-1-ming.lei@redhat.com>
References: <20190620062622.9979-1-ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, 2019-06-20 at 14:26 +0800, Ming Lei wrote:
> The local variable 'sg' should be initialized in the failure path of
> mvumi_make_sgl(), otherwise the following build warning is triggered:
> 
> 	In file included from include/linux/pci-dma-compat.h:8,
> 	                 from include/linux/pci.h:2408,
> 	                 from drivers/scsi/mvumi.c:13:
> 	drivers/scsi/mvumi.c: In function 'mvumi_queue_command':
> 	include/linux/dma-mapping.h:608:34: warning: 'sg' may be used
> uninitialized in this function
> 	+[-Wmaybe-uninitialized]
> 	 #define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n,
> r, 0)
> 	                                  ^~~~~~~~~~~~~~~~~~
> 	drivers/scsi/mvumi.c:192:22: note: 'sg' was declared here
> 	  struct scatterlist *sg;
>                       ^~
> Fixed it by removing the local variable reference in failure path.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Ewan D. Milne <emilne@redhat.com>
> Fixes: 350d66a72adc ("scsi: mvumi: use sg helper to iterate over
> scatterlist")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/scsi/mvumi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/mvumi.c b/drivers/scsi/mvumi.c
> index 0022cd31500a..53f3563aca22 100644
> --- a/drivers/scsi/mvumi.c
> +++ b/drivers/scsi/mvumi.c
> @@ -217,7 +217,7 @@ static int mvumi_make_sgl(struct mvumi_hba *mhba,
> struct scsi_cmnd *scmd,
>  		dev_err(&mhba->pdev->dev,
>  			"sg count[0x%x] is bigger than max
> sg[0x%x].\n",
>  			*sg_count, mhba->max_sge);
> -		dma_unmap_sg(&mhba->pdev->dev, sg, sgnum,
> +		dma_unmap_sg(&mhba->pdev->dev, scsi_sglist(scmd),
> sgnum,
>  			     scmd->sc_data_direction);
>  		return -1;
>  	}

I think this is a serious enough problem for mvumi that it needs
folding with comment into the original path.  I believe it will cause
an oops when this code path is hit otherwise, right?

James

