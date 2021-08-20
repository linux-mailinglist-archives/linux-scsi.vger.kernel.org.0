Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B733F29B3
	for <lists+linux-scsi@lfdr.de>; Fri, 20 Aug 2021 12:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237133AbhHTKBa (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 20 Aug 2021 06:01:30 -0400
Received: from verein.lst.de ([213.95.11.211]:40418 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236384AbhHTKB3 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 20 Aug 2021 06:01:29 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5B3D76736F; Fri, 20 Aug 2021 12:00:48 +0200 (CEST)
Date:   Fri, 20 Aug 2021 12:00:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 1/3] snic: reserve tag for TMF
Message-ID: <20210820100047.GA9872@lst.de>
References: <20210819091224.94213-1-hare@suse.de> <20210819091224.94213-2-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819091224.94213-2-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, Aug 19, 2021 at 11:12:22AM +0200, Hannes Reinecke wrote:
>  
> diff --git a/drivers/scsi/snic/snic_main.c b/drivers/scsi/snic/snic_main.c
> index 14f4ce665e58..65f50057c66e 100644
> --- a/drivers/scsi/snic/snic_main.c
> +++ b/drivers/scsi/snic/snic_main.c
> @@ -512,6 +512,9 @@ snic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  					 max_t(u32, SNIC_MIN_IO_REQ, max_ios));
>  
>  	snic->max_tag_id = shost->can_queue;
> +	/* Reserve one reset command */
> +	shost->can_queue--;
> +	snic->tmf_tag_id = shost->can_queue;

This is decrementing can_queue before scsi_add_host, which allocates
the requests ..

> +	sc = scsi_host_find_tag(shost, snic->tmf_tag_id);
> +	if (!sc) {

... but this is expecting a scsi_cmnd / struct request for that tag
value.

How is that supposed to work?
