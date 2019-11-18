Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3822F100746
	for <lists+linux-scsi@lfdr.de>; Mon, 18 Nov 2019 15:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfKROXB (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 18 Nov 2019 09:23:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:34250 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726627AbfKROXB (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 18 Nov 2019 09:23:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C3533B249;
        Mon, 18 Nov 2019 14:22:59 +0000 (UTC)
Date:   Mon, 18 Nov 2019 15:22:59 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Daniel Wagner <daniel.wagner@suse.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] lpfc: fixup out-of-bounds access during CPU hotplug
Message-ID: <20191118142259.nszyqku5pewuu6st@beryllium.lan>
References: <20191118123012.99664-1-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191118123012.99664-1-hare@suse.de>
User-Agent: NeoMutt/20180716
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Hannes,

On Mon, Nov 18, 2019 at 01:30:12PM +0100, Hannes Reinecke wrote:
> The lpfc driver allocates a cpu_map based on the number of possible
> cpus during startup. If a CPU hotplug occurs the number of CPUs
> might change, causing an out-of-bounds access when trying to lookup
> the hardware index for a given CPU.
> 
> Suggested-by: Daniel Wagner <daniel.wagner@suse.com>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/scsi/lpfc/lpfc_scsi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
> index ba26df90a36a..2380452a8efd 100644
> --- a/drivers/scsi/lpfc/lpfc_scsi.c
> +++ b/drivers/scsi/lpfc/lpfc_scsi.c
> @@ -642,7 +642,8 @@ lpfc_get_scsi_buf_s4(struct lpfc_hba *phba, struct lpfc_nodelist *ndlp,
>  	int tag;
>  	struct fcp_cmd_rsp_buf *tmp = NULL;
>  
> -	cpu = raw_smp_processor_id();
> +	cpu = min_t(u32, raw_smp_processor_id(),
> +		    phba->sli4_hba.num_possible_cpu);

The index is limited by phba->cfg_hdw_queue and not the number of CPUs.

Thanks,
Daniel
