Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFA963BA17
	for <lists+linux-scsi@lfdr.de>; Mon, 10 Jun 2019 18:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbfFJQ4I (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 10 Jun 2019 12:56:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51964 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727648AbfFJQ4H (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 10 Jun 2019 12:56:07 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A19A830F1BBA;
        Mon, 10 Jun 2019 16:56:07 +0000 (UTC)
Received: from emilne (unknown [10.18.25.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 38CFC600CD;
        Mon, 10 Jun 2019 16:56:04 +0000 (UTC)
Message-ID: <4637da79e3687524e2b2ef535bca0c225b86c9a2.camel@redhat.com>
Subject: Re: [PATCH 3/5] scsi: ipr: use sg helper to operate sgl
From:   "Ewan D. Milne" <emilne@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Date:   Mon, 10 Jun 2019 12:56:04 -0400
In-Reply-To: <20190610150317.29546-4-ming.lei@redhat.com>
References: <20190610150317.29546-1-ming.lei@redhat.com>
         <20190610150317.29546-4-ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 10 Jun 2019 16:56:07 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, 2019-06-10 at 23:03 +0800, Ming Lei wrote:
> The current way isn't safe for chained sgl, so use sg helper to
> operate sgl.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/scsi/ipr.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
> index d06bc1a817a1..028db6bd0280 100644
> --- a/drivers/scsi/ipr.c
> +++ b/drivers/scsi/ipr.c
> @@ -3952,6 +3952,7 @@ static void ipr_build_ucode_ioadl64(struct ipr_cmnd *ipr_cmd,
>  	struct ipr_ioarcb *ioarcb = &ipr_cmd->ioarcb;
>  	struct ipr_ioadl64_desc *ioadl64 = ipr_cmd->i.ioadl64;
>  	struct scatterlist *scatterlist = sglist->scatterlist;
> +	struct scatterlist *sg;
>  	int i;
>  
>  	ipr_cmd->dma_use_sg = sglist->num_dma_sg;
> @@ -3960,10 +3961,10 @@ static void ipr_build_ucode_ioadl64(struct ipr_cmnd *ipr_cmd,
>  
>  	ioarcb->ioadl_len =
>  		cpu_to_be32(sizeof(struct ipr_ioadl64_desc) * ipr_cmd->dma_use_sg);
> -	for (i = 0; i < ipr_cmd->dma_use_sg; i++) {
> +	for_each_sg(scatterlist, sg, ipr_cmd->dma_use_sg, i) {
>  		ioadl64[i].flags = cpu_to_be32(IPR_IOADL_FLAGS_WRITE);
> -		ioadl64[i].data_len = cpu_to_be32(sg_dma_len(&scatterlist[i]));
> -		ioadl64[i].address = cpu_to_be64(sg_dma_address(&scatterlist[i]));
> +		ioadl64[i].data_len = cpu_to_be32(sg_dma_len(sg));
> +		ioadl64[i].address = cpu_to_be64(sg_dma_address(sg));
>  	}
>  
>  	ioadl64[i-1].flags |= cpu_to_be32(IPR_IOADL_FLAGS_LAST);

Reviewed-by: Ewan D. Milne <emilne@redhat.com>

