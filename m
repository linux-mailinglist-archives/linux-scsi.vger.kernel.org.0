Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F4C327822
	for <lists+linux-scsi@lfdr.de>; Mon,  1 Mar 2021 08:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbhCAHRc (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 1 Mar 2021 02:17:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:58814 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232224AbhCAHRc (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 1 Mar 2021 02:17:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B5C24AD2B;
        Mon,  1 Mar 2021 07:16:49 +0000 (UTC)
Subject: Re: [PATCH 19/24] mpi3mr: print pending host ios for debug
To:     Kashyap Desai <kashyap.desai@broadcom.com>,
        linux-scsi@vger.kernel.org
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        steve.hagan@broadcom.com, peter.rivera@broadcom.com,
        mpi3mr-linuxdrv.pdl@broadcom.com, sathya.prakash@broadcom.com
References: <20201222101156.98308-1-kashyap.desai@broadcom.com>
 <20201222101156.98308-20-kashyap.desai@broadcom.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <47e32b2b-7cf5-b066-6703-38c8947ec6fa@suse.de>
Date:   Mon, 1 Mar 2021 08:16:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20201222101156.98308-20-kashyap.desai@broadcom.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 12/22/20 11:11 AM, Kashyap Desai wrote:
> Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
> Cc: sathya.prakash@broadcom.com
> ---
>   drivers/scsi/mpi3mr/mpi3mr_os.c | 68 +++++++++++++++++++++++++++++++++
>   1 file changed, 68 insertions(+)
> 
> diff --git a/drivers/scsi/mpi3mr/mpi3mr_os.c b/drivers/scsi/mpi3mr/mpi3mr_os.c
> index 742cf45d4878..8e665c70604d 100644
> --- a/drivers/scsi/mpi3mr/mpi3mr_os.c
> +++ b/drivers/scsi/mpi3mr/mpi3mr_os.c
> @@ -334,6 +334,36 @@ void mpi3mr_invalidate_devhandles(struct mpi3mr_ioc *mrioc)
>   	}
>   }
>   
> +/**
> + * mpi3mr_print_scmd - print individual SCSI command
> + * @rq: Block request
> + * @data: Adapter instance reference
> + *
> + * Print the SCSI command details if it is in LLD scope.
> + *
> + * Return: true always.
> + */
> +static bool mpi3mr_print_scmd(struct request *rq,
> +	void *data, bool reserved)
> +{
> +	struct mpi3mr_ioc *mrioc = (struct mpi3mr_ioc *)data;
> +	struct scsi_cmnd *scmd = blk_mq_rq_to_pdu(rq);
> +	struct scmd_priv *priv = NULL;
> +
> +	if (scmd) {
> +		priv = scsi_cmd_priv(scmd);
> +		if (!priv->in_lld_scope)
> +			goto out;
> +
> +		ioc_info(mrioc, "%s :Host Tag = %d, qid = %d\n",
> +		    __func__, priv->host_tag, priv->req_q_idx + 1);
> +		scsi_print_command(scmd);
> +	}
> +
> +out:
> +	return(true);
> +}
> +
>   
>   /**
>    * mpi3mr_flush_scmd - Flush individual SCSI command
> @@ -2370,6 +2400,43 @@ static int mpi3mr_map_queues(struct Scsi_Host *shost)
>   	    mrioc->pdev, mrioc->op_reply_q_offset);
>   }
>   
> +/**
> + * mpi3mr_get_fw_pending_ios - Calculate pending I/O count
> + * @mrioc: Adapter instance reference
> + *
> + * Calculate the pending I/Os for the controller and return.
> + *
> + * Return: Number of pending I/Os
> + */
> +static inline int mpi3mr_get_fw_pending_ios(struct mpi3mr_ioc *mrioc)
> +{
> +	u16 i;
> +	uint pend_ios = 0;
> +
> +	for (i = 0; i < mrioc->num_op_reply_q; i++)
> +		pend_ios += atomic_read(&mrioc->op_reply_qinfo[i].pend_ios);
> +	return pend_ios;
> +}
> +
> +/**
> + * mpi3mr_print_pending_host_io - print pending I/Os
> + * @mrioc: Adapter instance reference
> + *
> + * Print number of pending I/Os and each I/O details prior to
> + * reset for debug purpose.
> + *
> + * Return: Nothing
> + */
> +static void mpi3mr_print_pending_host_io(struct mpi3mr_ioc *mrioc)
> +{
> +	struct Scsi_Host *shost = mrioc->shost;
> +
> +	ioc_info(mrioc, "%s :Pending commands prior to reset: %d\n",
> +	    __func__, mpi3mr_get_fw_pending_ios(mrioc));
> +	blk_mq_tagset_busy_iter(&shost->tag_set,
> +	    mpi3mr_print_scmd, (void *)mrioc);
> +}
> +
>   /**
>    * mpi3mr_eh_host_reset - Host reset error handling callback
>    * @scmd: SCSI command reference
> @@ -2395,6 +2462,7 @@ static int mpi3mr_eh_host_reset(struct scsi_cmnd *scmd)
>   		dev_type = stgt_priv_data->dev_type;
>   	}
>   
> +	mpi3mr_print_pending_host_io(mrioc);
>   	ret = mpi3mr_soft_reset_handler(mrioc,
>   	    MPI3MR_RESET_FROM_EH_HOS, 1);
>   	if (ret)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 N�rnberg
HRB 36809 (AG N�rnberg), Gesch�ftsf�hrer: Felix Imend�rffer
