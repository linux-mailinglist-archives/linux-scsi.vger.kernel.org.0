Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A61034909
	for <lists+linux-scsi@lfdr.de>; Tue,  4 Jun 2019 15:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfFDNjV (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 4 Jun 2019 09:39:21 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33544 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbfFDNjV (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 4 Jun 2019 09:39:21 -0400
Received: by mail-pl1-f193.google.com with SMTP id g21so8374969plq.0
        for <linux-scsi@vger.kernel.org>; Tue, 04 Jun 2019 06:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8uWPQ0ji8Qp0Mp5hs2GEEThcVafBTcwkWX5MHE61Sc0=;
        b=tWeIfjlLVVK2hQerMnbdGb93fVfWkjWU9ThwtPpNXt0vc4lMVYA4eVmTUUxfpZMop1
         ry1gzNDjzgpYLqaQ98je3IWrVc396sW3q96l7oOE4AGU8FydfFNy+F8BruizwI5p3coi
         4/NunSpfBX1CS92Nn2Dq4WXEQJP6CFjtYAJqF6WWyMv7qYhGPqZLXwVj7SZ77swnMIvW
         d2G02MFLxiCyhWseICL13VoyNf70iMRX/YUUNql1Rdq82HsdSt+/wkM0hXYrApDtEDnq
         h9eN6BiMbGm5utIcfJPvEvogvJcglEF61Bckkmt3+sl+nCBIU/qVWEssmMZBiF3TDC4I
         FQiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=8uWPQ0ji8Qp0Mp5hs2GEEThcVafBTcwkWX5MHE61Sc0=;
        b=hb7R2Nle06C3flYs5HdGglaDeb/iJ2MUFuJ0QYMmygyfCJmt5D9xeNVrBI/IW5XHBQ
         uTBl6+iOeVbcCbR0E9WHzxy1gwU4N3IsXr3Mct6v2Q8AX1Qmds65XeOF7aYHBGjqg/RI
         WM749vCY8wmajoBOOarh8cKSuLJHzh4AlAUg0P6mdRdBbfsmucGl2FdNOp6DHnQ2Pi3j
         PsWgjH9Fh+JzPldlEVOj49LYHgKG6Lh84kXrYGTLFLDgfeV87WgZUFFo7AwGF/8mItPt
         5v8GiCLcTWCOEpcQqwOjgVz3EytiWNfjecTUpW+54E3mFJ3eGpZiM/smBeu8kv5FypWw
         VmvA==
X-Gm-Message-State: APjAAAXFRBdhrf+xlAjs3em7ayAZJfg7BaOdUdh5GqgI+BKVG2X35X/r
        oZdJK4kkjT+Wma0E7Ul3/ZU=
X-Google-Smtp-Source: APXvYqzaIhamopYEPGLr3/A9MOjkeYo7joxd43ozhldD+0RAcrscMYtbYUPZDuK5adur78WpJQ4nAw==
X-Received: by 2002:a17:902:988b:: with SMTP id s11mr9653512plp.216.1559655560332;
        Tue, 04 Jun 2019 06:39:20 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z15sm3004812pge.40.2019.06.04.06.39.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 06:39:19 -0700 (PDT)
Date:   Tue, 4 Jun 2019 06:39:18 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 2/2] scsi: esp: make it working on SG_CHAIN
Message-ID: <20190604133918.GB1880@roeck-us.net>
References: <20190604082308.5575-1-ming.lei@redhat.com>
 <20190604082308.5575-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604082308.5575-3-ming.lei@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, Jun 04, 2019 at 04:23:08PM +0800, Ming Lei wrote:
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

Tested-by: Guenter Roeck <linux@roeck-us.net>

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
> -- 
> 2.20.1
> 
