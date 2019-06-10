Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBDD33BA24
	for <lists+linux-scsi@lfdr.de>; Mon, 10 Jun 2019 18:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbfFJQ52 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 10 Jun 2019 12:57:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55558 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727648AbfFJQ51 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 10 Jun 2019 12:57:27 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DA34C3079B60;
        Mon, 10 Jun 2019 16:57:27 +0000 (UTC)
Received: from emilne (unknown [10.18.25.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 56EE360C05;
        Mon, 10 Jun 2019 16:57:24 +0000 (UTC)
Message-ID: <6f8d991bd9b083c3d7b58610c1bbe42cf5670b04.camel@redhat.com>
Subject: Re: [PATCH 4/5] scsi: lpfc:  use sg helper to operate sgl
From:   "Ewan D. Milne" <emilne@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     James Smart <james.smart@broadcom.com>
Date:   Mon, 10 Jun 2019 12:57:23 -0400
In-Reply-To: <20190610150317.29546-5-ming.lei@redhat.com>
References: <20190610150317.29546-1-ming.lei@redhat.com>
         <20190610150317.29546-5-ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 10 Jun 2019 16:57:27 +0000 (UTC)
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
>  drivers/scsi/lpfc/lpfc_nvmet.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
> index d74bfd264495..877d1fb92754 100644
> --- a/drivers/scsi/lpfc/lpfc_nvmet.c
> +++ b/drivers/scsi/lpfc/lpfc_nvmet.c
> @@ -2662,8 +2662,7 @@ lpfc_nvmet_prep_fcp_wqe(struct lpfc_hba *phba,
>  	nvmewqe->drvrTimeout = (phba->fc_ratov * 3) + LPFC_DRVR_TIMEOUT;
>  	nvmewqe->context1 = ndlp;
>  
> -	for (i = 0; i < rsp->sg_cnt; i++) {
> -		sgel = &rsp->sg[i];
> +	for_each_sg(rsp->sg, sgel, rsp->sg_cnt, i) {
>  		physaddr = sg_dma_address(sgel);
>  		cnt = sg_dma_len(sgel);
>  		sgl->addr_hi = putPaddrHigh(physaddr);

Looks right for rsp->sg

Reviewed by: Ewan D. Milne <emilne@redhat.com>

