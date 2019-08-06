Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E33F82E78
	for <lists+linux-scsi@lfdr.de>; Tue,  6 Aug 2019 11:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731735AbfHFJMD (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 6 Aug 2019 05:12:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:41396 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728056AbfHFJMD (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 6 Aug 2019 05:12:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BC479ADEC;
        Tue,  6 Aug 2019 09:12:01 +0000 (UTC)
Subject: Re: [PATCH v2] lpfc: Mitigate high memory pre-allocation by SCSI-MQ
To:     James Smart <jsmart2021@gmail.com>, linux-scsi@vger.kernel.org
Cc:     Dick Kennedy <dick.kennedy@broadcom.com>,
        Ming Lei <tom.leiming@gmail.com>
References: <20190801220941.19615-1-jsmart2021@gmail.com>
From:   Hannes Reinecke <hare@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=hare@suse.de; prefer-encrypt=mutual; keydata=
 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
 azzYF4VRJsdl+d0MCaSy8mUh
Message-ID: <aceb02fc-0790-6246-7fac-1e765bf9e3cf@suse.de>
Date:   Tue, 6 Aug 2019 11:12:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190801220941.19615-1-jsmart2021@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 8/2/19 12:09 AM, James Smart wrote:
> When SCSI-MQ is enabled, the SCSI-MQ layers will do pre-allocation of
> MQ resources based on shost values set by the driver. In newer cases
> of the driver, which attempts to set nr_hw_queues to the cpu count,
> the multipliers become excessive, with a single shost having SCSI-MQ
> pre-allocation reaching into the multiple GBytes range.  NPIV, which
> creates additional shosts, only multiply this overhead. On lower-memory
> systems, this can exhaust system memory very quickly, resulting in a
> system crash or failures in the driver or elsewhere due to low memory
> conditions.
> 
> After testing several scenarios, the situation can be mitigated by
> limiting the value set in shost->nr_hw_queues to 4. Although the shost
> values were changed, the driver still had per-cpu hardware queues of
> its own that allowed parallelization per-cpu.  Testing revealed that
> even with the smallish number for nr_hw_queues for SCSI-MQ, performance
> levels remained near maximum with the within-driver affiinitization.
> 
> A module parameter was created to allow the value set for the
> nr_hw_queues to be tunable.
> 
> Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> CC: Ming Lei <tom.leiming@gmail.com>
> 
> ---
> v2:
>   revised to set nr_hw_queues to minimum of 2 per numa node or
>       max value specified by module parameter.
>   raised default value for module parameter to 8.
> ---
>  drivers/scsi/lpfc/lpfc.h      |  1 +
>  drivers/scsi/lpfc/lpfc_attr.c | 15 +++++++++++++++
>  drivers/scsi/lpfc/lpfc_init.c | 10 ++++++----
>  drivers/scsi/lpfc/lpfc_sli4.h |  5 +++++
>  4 files changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
> index 2c3bb8a966e5..bade2e025ecf 100644
> --- a/drivers/scsi/lpfc/lpfc.h
> +++ b/drivers/scsi/lpfc/lpfc.h
> @@ -824,6 +824,7 @@ struct lpfc_hba {
>  	uint32_t cfg_cq_poll_threshold;
>  	uint32_t cfg_cq_max_proc_limit;
>  	uint32_t cfg_fcp_cpu_map;
> +	uint32_t cfg_fcp_mq_threshold;
>  	uint32_t cfg_hdw_queue;
>  	uint32_t cfg_irq_chann;
>  	uint32_t cfg_suppress_rsp;
> diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
> index ea62322ffe2b..8d8c495b5b60 100644
> --- a/drivers/scsi/lpfc/lpfc_attr.c
> +++ b/drivers/scsi/lpfc/lpfc_attr.c
> @@ -5709,6 +5709,19 @@ LPFC_ATTR_RW(nvme_embed_cmd, 1, 0, 2,
>  	     "Embed NVME Command in WQE");
>  
>  /*
> + * lpfc_fcp_mq_threshold: Set the maximum number of Hardware Queues
> + * the driver will advertise it supports to the SCSI layer.
> + *
> + *      0    = Set nr_hw_queues by the number of CPUs or HW queues.
> + *      1,128 = Manually specify the maximum nr_hw_queue value to be set,
> + *
> + * Value range is [0,128]. Default value is 8.
> + */
> +LPFC_ATTR_R(fcp_mq_threshold, LPFC_FCP_MQ_THRESHOLD_DEF,
> +	    LPFC_FCP_MQ_THRESHOLD_MIN, LPFC_FCP_MQ_THRESHOLD_MAX,
> +	    "Set the number of SCSI Queues advertised");
> +
> +/*
>   * lpfc_hdw_queue: Set the number of Hardware Queues the driver
>   * will advertise it supports to the NVME and  SCSI layers. This also
>   * will map to the number of CQ/WQ pairs the driver will create.
> @@ -6030,6 +6043,7 @@ struct device_attribute *lpfc_hba_attrs[] = {
>  	&dev_attr_lpfc_cq_poll_threshold,
>  	&dev_attr_lpfc_cq_max_proc_limit,
>  	&dev_attr_lpfc_fcp_cpu_map,
> +	&dev_attr_lpfc_fcp_mq_threshold,
>  	&dev_attr_lpfc_hdw_queue,
>  	&dev_attr_lpfc_irq_chann,
>  	&dev_attr_lpfc_suppress_rsp,
> @@ -7112,6 +7126,7 @@ lpfc_get_cfgparam(struct lpfc_hba *phba)
>  	/* Initialize first burst. Target vs Initiator are different. */
>  	lpfc_nvme_enable_fb_init(phba, lpfc_nvme_enable_fb);
>  	lpfc_nvmet_fb_size_init(phba, lpfc_nvmet_fb_size);
> +	lpfc_fcp_mq_threshold_init(phba, lpfc_fcp_mq_threshold);
>  	lpfc_hdw_queue_init(phba, lpfc_hdw_queue);
>  	lpfc_irq_chann_init(phba, lpfc_irq_chann);
>  	lpfc_enable_bbcr_init(phba, lpfc_enable_bbcr);
> diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
> index faf43b1d3dbe..03998579d6ee 100644
> --- a/drivers/scsi/lpfc/lpfc_init.c
> +++ b/drivers/scsi/lpfc/lpfc_init.c
> @@ -4309,10 +4309,12 @@ lpfc_create_port(struct lpfc_hba *phba, int instance, struct device *dev)
>  	shost->max_cmd_len = 16;
>  
>  	if (phba->sli_rev == LPFC_SLI_REV4) {
> -		if (phba->cfg_fcp_io_sched == LPFC_FCP_SCHED_BY_HDWQ)
> -			shost->nr_hw_queues = phba->cfg_hdw_queue;
> -		else
> -			shost->nr_hw_queues = phba->sli4_hba.num_present_cpu;
> +		if (!phba->cfg_fcp_mq_threshold ||
> +		    phba->cfg_fcp_mq_threshold > phba->cfg_hdw_queue)
> +			phba->cfg_fcp_mq_threshold = phba->cfg_hdw_queue;
> +
> +		shost->nr_hw_queues = min_t(int, 2 * num_possible_nodes(),
> +					    phba->cfg_fcp_mq_threshold);
>  
>  		shost->dma_boundary =
>  			phba->sli4_hba.pc_sli4_params.sge_supp_len-1;
> diff --git a/drivers/scsi/lpfc/lpfc_sli4.h b/drivers/scsi/lpfc/lpfc_sli4.h
> index 3aeca387b22a..329f7aa7e169 100644
> --- a/drivers/scsi/lpfc/lpfc_sli4.h
> +++ b/drivers/scsi/lpfc/lpfc_sli4.h
> @@ -44,6 +44,11 @@
>  #define LPFC_HBA_HDWQ_MAX	128
>  #define LPFC_HBA_HDWQ_DEF	0
>  
> +/* FCP MQ queue count limiting */
> +#define LPFC_FCP_MQ_THRESHOLD_MIN	0
> +#define LPFC_FCP_MQ_THRESHOLD_MAX	128
> +#define LPFC_FCP_MQ_THRESHOLD_DEF	8
> +
>  /* Common buffer size to accomidate SCSI and NVME IO buffers */
>  #define LPFC_COMMON_IO_BUF_SZ	768
>  
> 
I would actually use the HW limit here; there are some machines where
being able to leverage all HW queues might be preferable.

Otherwise:
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
