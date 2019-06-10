Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61BD93BA3F
	for <lists+linux-scsi@lfdr.de>; Mon, 10 Jun 2019 18:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbfFJQ7i (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 10 Jun 2019 12:59:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55726 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727648AbfFJQ7i (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 10 Jun 2019 12:59:38 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 24C1EC18B2EF;
        Mon, 10 Jun 2019 16:59:38 +0000 (UTC)
Received: from emilne (unknown [10.18.25.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD0F560610;
        Mon, 10 Jun 2019 16:59:32 +0000 (UTC)
Message-ID: <fda4d419a07aae244466f35edf3d17c25d3ccf1e.camel@redhat.com>
Subject: Re: [PATCH 5/5] scsi: mvumi: use sg helper to operate sgl
From:   "Ewan D. Milne" <emilne@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Date:   Mon, 10 Jun 2019 12:59:32 -0400
In-Reply-To: <20190610150317.29546-6-ming.lei@redhat.com>
References: <20190610150317.29546-1-ming.lei@redhat.com>
         <20190610150317.29546-6-ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 10 Jun 2019 16:59:38 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, 2019-06-10 at 23:03 +0800, Ming Lei wrote:
> The current way isn't safe for chained sgl, so use sgl helper to
> operate sgl.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/scsi/mvumi.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/scsi/mvumi.c b/drivers/scsi/mvumi.c
> index 1fb6f6ca627e..3881aa6bf4c4 100644
> --- a/drivers/scsi/mvumi.c
> +++ b/drivers/scsi/mvumi.c
> @@ -195,8 +195,7 @@ static int mvumi_make_sgl(struct mvumi_hba *mhba, struct scsi_cmnd *scmd,
>  	unsigned int sgnum = scsi_sg_count(scmd);
>  	dma_addr_t busaddr;
>  
> -	sg = scsi_sglist(scmd);
> -	*sg_count = dma_map_sg(&mhba->pdev->dev, sg, sgnum,
> +	*sg_count = dma_map_sg(&mhba->pdev->dev, scsi_sglist(scmd), sgnum,
>  			       scmd->sc_data_direction);
>  	if (*sg_count > mhba->max_sge) {
>  		dev_err(&mhba->pdev->dev,
> @@ -206,12 +205,12 @@ static int mvumi_make_sgl(struct mvumi_hba *mhba, struct scsi_cmnd *scmd,
>  			     scmd->sc_data_direction);
>  		return -1;
>  	}
> -	for (i = 0; i < *sg_count; i++) {
> -		busaddr = sg_dma_address(&sg[i]);
> +	scsi_for_each_sg(scmd, sg, *sg_count, i) {
> +		busaddr = sg_dma_address(sg);
>  		m_sg->baseaddr_l = cpu_to_le32(lower_32_bits(busaddr));
>  		m_sg->baseaddr_h = cpu_to_le32(upper_32_bits(busaddr));
>  		m_sg->flags = 0;
> -		sgd_setsz(mhba, m_sg, cpu_to_le32(sg_dma_len(&sg[i])));
> +		sgd_setsz(mhba, m_sg, cpu_to_le32(sg_dma_len(sg)));
>  		if ((i + 1) == *sg_count)
>  			m_sg->flags |= 1U << mhba->eot_flag;
>  

Reviewed-by: Ewan D. Milne <emilne@redhat.com>

