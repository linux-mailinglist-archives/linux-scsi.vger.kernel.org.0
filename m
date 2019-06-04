Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE2253430B
	for <lists+linux-scsi@lfdr.de>; Tue,  4 Jun 2019 11:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfFDJVc (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 4 Jun 2019 05:21:32 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:50504 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfFDJVc (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 4 Jun 2019 05:21:32 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 00DC82280B;
        Tue,  4 Jun 2019 05:21:27 -0400 (EDT)
Date:   Tue, 4 Jun 2019 19:21:37 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Ming Lei <ming.lei@redhat.com>
cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 2/2] scsi: esp: make it working on SG_CHAIN
In-Reply-To: <20190604082308.5575-3-ming.lei@redhat.com>
Message-ID: <alpine.LNX.2.21.1906041921050.66@nippy.intranet>
References: <20190604082308.5575-1-ming.lei@redhat.com> <20190604082308.5575-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, 4 Jun 2019, Ming Lei wrote:

> The driver supporses that there isn't sg chain, and itereate the
> list one by one. This way is obviously wrong.
> 
> Fixes it by sgl helper.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Ewan D. Milne <emilne@redhat.com>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/scsi/esp_scsi.c | 32 +++++++++++++++++++++++++-------
>  1 file changed, 25 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/scsi/esp_scsi.c b/drivers/scsi/esp_scsi.c
> index 76e7ca864d6a..58b4e059dcfb 100644
> --- a/drivers/scsi/esp_scsi.c
> +++ b/drivers/scsi/esp_scsi.c
> @@ -371,6 +371,7 @@ static void esp_map_dma(struct esp *esp, struct scsi_cmnd *cmd)
>  	struct esp_cmd_priv *spriv = ESP_CMD_PRIV(cmd);
>  	struct scatterlist *sg = scsi_sglist(cmd);
>  	int total = 0, i;
> +	struct scatterlist *sgt;
>  
>  	if (cmd->sc_data_direction == DMA_NONE)
>  		return;
> @@ -381,14 +382,15 @@ static void esp_map_dma(struct esp *esp, struct scsi_cmnd *cmd)
>  		 * a dma address, so perform an identity mapping.
>  		 */
>  		spriv->num_sg = scsi_sg_count(cmd);
> -		for (i = 0; i < spriv->num_sg; i++) {
> -			sg[i].dma_address = (uintptr_t)sg_virt(&sg[i]);
> -			total += sg_dma_len(&sg[i]);
> +
> +		scsi_for_each_sg(cmd, sgt, spriv->num_sg, i) {
> +			sgt->dma_address = (uintptr_t)sg_virt(sgt);
> +			total += sg_dma_len(sgt);
>  		}
>  	} else {
>  		spriv->num_sg = scsi_dma_map(cmd);
> -		for (i = 0; i < spriv->num_sg; i++)
> -			total += sg_dma_len(&sg[i]);
> +		scsi_for_each_sg(cmd, sgt, spriv->num_sg, i)
> +			total += sg_dma_len(sgt);
>  	}
>  	spriv->cur_residue = sg_dma_len(sg);
>  	spriv->cur_sg = sg;
> @@ -444,7 +446,7 @@ static void esp_advance_dma(struct esp *esp, struct esp_cmd_entry *ent,
>  		p->tot_residue = 0;
>  	}
>  	if (!p->cur_residue && p->tot_residue) {
> -		p->cur_sg++;
> +		p->cur_sg = sg_next(p->cur_sg);
>  		p->cur_residue = sg_dma_len(p->cur_sg);
>  	}
>  }
> @@ -1610,6 +1612,22 @@ static void esp_msgin_extended(struct esp *esp)
>  	scsi_esp_cmd(esp, ESP_CMD_SATN);
>  }
>  
> +static struct scatterlist *esp_sg_prev(struct scsi_cmnd *cmd,
> +		struct scatterlist *sg)
> +{
> +	int i;
> +	struct scatterlist *tmp;
> +	struct scatterlist *prev = NULL;
> +
> +	scsi_for_each_sg(cmd, tmp, scsi_sg_count(cmd), i) {
> +		if (tmp == sg)
> +			break;
> +		prev = tmp;
> +	}
> +
> +	return prev;
> +}
> +

Did you consider recording the previous scatterlist pointer using an 
additional member in struct esp_cmd_priv, to be assigned in 
esp_advance_dma()? I think it would execute faster and require less code.

-- 

>  /* Analyze msgin bytes received from target so far.  Return non-zero
>   * if there are more bytes needed to complete the message.
>   */
> @@ -1647,7 +1665,7 @@ static int esp_msgin_process(struct esp *esp)
>  		spriv = ESP_CMD_PRIV(ent->cmd);
>  
>  		if (spriv->cur_residue == sg_dma_len(spriv->cur_sg)) {
> -			spriv->cur_sg--;
> +			spriv->cur_sg = esp_sg_prev(ent->cmd, spriv->cur_sg);
>  			spriv->cur_residue = 1;
>  		} else
>  			spriv->cur_residue++;
> 
