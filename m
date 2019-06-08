Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E05DD39B99
	for <lists+linux-scsi@lfdr.de>; Sat,  8 Jun 2019 09:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfFHH7R (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 8 Jun 2019 03:59:17 -0400
Received: from verein.lst.de ([213.95.11.211]:60519 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbfFHH7R (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 8 Jun 2019 03:59:17 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 5586E68B02; Sat,  8 Jun 2019 09:58:48 +0200 (CEST)
Date:   Sat, 8 Jun 2019 09:58:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH V3 3/3] scsi: esp: make it working on SG_CHAIN
Message-ID: <20190608075847.GD19075@lst.de>
References: <20190606083410.32243-1-ming.lei@redhat.com> <20190606083410.32243-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606083410.32243-4-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

> @@ -381,16 +382,18 @@ static void esp_map_dma(struct esp *esp, struct scsi_cmnd *cmd)
>  		 * a dma address, so perform an identity mapping.
>  		 */
>  		spriv->num_sg = scsi_sg_count(cmd);
> -		for (i = 0; i < spriv->num_sg; i++) {
> -			sg[i].dma_address = (uintptr_t)sg_virt(&sg[i]);
> -			total += sg_dma_len(&sg[i]);
> +
> +		scsi_for_each_sg(cmd, s, spriv->num_sg, i) {
> +			s->dma_address = (uintptr_t)sg_virt(s);
> +			total += sg_dma_len(s);

But I wonder if we could just use blk_rq_bytes() here, maybe through
a new scsi inline wrappers, instead of iterating over all SGs.  Maybe
for next merge window and not the bug fix..
