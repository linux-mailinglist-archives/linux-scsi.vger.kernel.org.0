Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5571E3BA0D
	for <lists+linux-scsi@lfdr.de>; Mon, 10 Jun 2019 18:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbfFJQyJ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 10 Jun 2019 12:54:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44967 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726775AbfFJQyJ (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 10 Jun 2019 12:54:09 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ECF1230872F1;
        Mon, 10 Jun 2019 16:54:08 +0000 (UTC)
Received: from emilne (unknown [10.18.25.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8038B19C59;
        Mon, 10 Jun 2019 16:54:08 +0000 (UTC)
Message-ID: <0e35b4a1c4ea35c084b2ea10d01ff58fb0086f8c.camel@redhat.com>
Subject: Re: [PATCH 1/5] scsi: vmw_pscsi: use sgl helper to operate sgl
From:   "Ewan D. Milne" <emilne@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Date:   Mon, 10 Jun 2019 12:54:07 -0400
In-Reply-To: <20190610150317.29546-2-ming.lei@redhat.com>
References: <20190610150317.29546-1-ming.lei@redhat.com>
         <20190610150317.29546-2-ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 10 Jun 2019 16:54:08 +0000 (UTC)
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
>  drivers/scsi/vmw_pvscsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/vmw_pvscsi.c b/drivers/scsi/vmw_pvscsi.c
> index ecee4b3ff073..d71abd416eb4 100644
> --- a/drivers/scsi/vmw_pvscsi.c
> +++ b/drivers/scsi/vmw_pvscsi.c
> @@ -335,7 +335,7 @@ static void pvscsi_create_sg(struct pvscsi_ctx *ctx,
>  	BUG_ON(count > PVSCSI_MAX_NUM_SG_ENTRIES_PER_SEGMENT);
>  
>  	sge = &ctx->sgl->sge[0];
> -	for (i = 0; i < count; i++, sg++) {
> +	for (i = 0; i < count; i++, sg = sg_next(sg)) {
>  		sge[i].addr   = sg_dma_address(sg);
>  		sge[i].length = sg_dma_len(sg);
>  		sge[i].flags  = 0;

Reviewed-by: Ewan D. Milne <emilne@redhat.com>

