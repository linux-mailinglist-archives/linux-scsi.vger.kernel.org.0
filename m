Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDB443BA11
	for <lists+linux-scsi@lfdr.de>; Mon, 10 Jun 2019 18:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbfFJQyk (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 10 Jun 2019 12:54:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37512 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728007AbfFJQyk (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 10 Jun 2019 12:54:40 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5FEAC7F7C8;
        Mon, 10 Jun 2019 16:54:40 +0000 (UTC)
Received: from emilne (unknown [10.18.25.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EA98F5DD95;
        Mon, 10 Jun 2019 16:54:36 +0000 (UTC)
Message-ID: <9159e8a0af44f7775eb2be2ea81cdbe473cc97f1.camel@redhat.com>
Subject: Re: [PATCH 2/5] scsi: advansys: use sg helper to operate sgl
From:   "Ewan D. Milne" <emilne@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Date:   Mon, 10 Jun 2019 12:54:35 -0400
In-Reply-To: <20190610150317.29546-3-ming.lei@redhat.com>
References: <20190610150317.29546-1-ming.lei@redhat.com>
         <20190610150317.29546-3-ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 10 Jun 2019 16:54:40 +0000 (UTC)
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
>  drivers/scsi/advansys.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/advansys.c b/drivers/scsi/advansys.c
> index 926311c792d5..a242a62caaa1 100644
> --- a/drivers/scsi/advansys.c
> +++ b/drivers/scsi/advansys.c
> @@ -7710,7 +7710,7 @@ adv_get_sglist(struct asc_board *boardp, adv_req_t *reqp,
>  				sg_block->sg_ptr = 0L; /* Last ADV_SG_BLOCK in list. */
>  				return ADV_SUCCESS;
>  			}
> -			slp++;
> +			slp = sg_next(slp);
>  		}
>  		sg_block->sg_cnt = NO_OF_SG_PER_BLOCK;
>  		prev_sg_block = sg_block;

Reviewed-by: Ewan D. Milne <emilne@redhat.com>

