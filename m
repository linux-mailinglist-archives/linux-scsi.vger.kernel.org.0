Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C8E23C6CE
	for <lists+linux-scsi@lfdr.de>; Wed,  5 Aug 2020 09:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbgHEHQP (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 5 Aug 2020 03:16:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:34370 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbgHEHQO (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 5 Aug 2020 03:16:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 55F7DB5E6;
        Wed,  5 Aug 2020 07:16:28 +0000 (UTC)
Subject: Re: [RFC 16/16] lpfc: vmid: Introducing vmid in io path.
To:     Muneendra <muneendra.kumar@broadcom.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     pbonzini@redhat.com, emilne@redhat.com, mkumar@redhat.com,
        Gaurav Srivastava <gaurav.srivastava@broadcom.com>,
        James Smart <jsmart2021@gmail.com>
References: <1596507196-27417-1-git-send-email-muneendra.kumar@broadcom.com>
 <1596507196-27417-17-git-send-email-muneendra.kumar@broadcom.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <61d2fd75-84ea-798b-aee9-b07957ac8f1b@suse.de>
Date:   Wed, 5 Aug 2020 09:16:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1596507196-27417-17-git-send-email-muneendra.kumar@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 8/4/20 4:13 AM, Muneendra wrote:
> From: Gaurav Srivastava <gaurav.srivastava@broadcom.com>
> 
> The patch introduces the vmid in the io path. It checks if the vmid is
> enabled and if io belongs to a vm or not and acts accordingly. Other
> supporing APIs are also included in the patch.
> 
> Signed-off-by: Gaurav Srivastava  <gaurav.srivastava@broadcom.com>
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> Signed-off-by: Muneendra <muneendra.kumar@broadcom.com>
> ---
>   drivers/scsi/lpfc/lpfc_scsi.c | 163 ++++++++++++++++++++++++++++++++++
>   1 file changed, 163 insertions(+)
> 
> diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
> index e5a1056cc575..3c7af8064b12 100644
> --- a/drivers/scsi/lpfc/lpfc_scsi.c
> +++ b/drivers/scsi/lpfc/lpfc_scsi.c
> @@ -4624,6 +4624,149 @@ void lpfc_vmid_assign_cs_ctl(struct lpfc_vport *vport, struct lpfc_vmid *vmid)
>   	}
>   }
>   
> +/*
> + * lpfc_vmid_get_appid- get the vmid associated with the uuid
> + * @vport: The virtual port for which this call is being executed.
> + * @uuid: uuid associated with the VE
> + * @cmd: address of scsi cmmd descriptor
> + * @tag: VMID tag
> + * Returns status of the function
> + */
> +static int lpfc_vmid_get_appid(struct lpfc_vport *vport, char *uuid, struct
> +			       scsi_cmnd * cmd, union lpfc_vmid_io_tag *tag)
> +{
> +	struct lpfc_vmid *vmp = NULL;
> +	int hash, len, rc = 1, i;
> +	u8 pending = 0;
> +
> +	/* check if QFPA is complete */
> +	if (lpfc_vmid_is_type_priority_tag(vport) && !(vport->vmid_flag &
> +	      LPFC_VMID_QFPA_CMPL))
> +		return 1;
> +
> +	/* search if the uuid has already been mapped to the vmid */
> +	len = strlen(uuid);
> +	hash = lpfc_vmid_hash_fn(uuid, len);
> +
> +	/* search for the VMID in the table */
> +	read_lock(&vport->vmid_lock);
> +	vmp = lpfc_get_vmid_from_hastable(vport, hash, uuid);
> +	read_unlock(&vport->vmid_lock);
> +
> +	/* if found, check if its already registered  */
> +	if (vmp  && vmp->flag & LPFC_VMID_REGISTERED) {
> +		lpfc_vmid_update_entry(vport, cmd, vmp, tag);
> +		rc = 0;
> +	} else if (vmp && (vmp->flag & LPFC_VMID_REQ_REGISTER ||
> +			   vmp->flag & LPFC_VMID_DE_REGISTER)) {
> +		/* else if register or dereg request has already been sent */
> +		/* Hence vmid tag will not be added for this IO */
> +		rc = 1;
> +	} else {
> +		/* else, start the process to obtain one as per the */
> +		/* switch connected */
> +		write_lock(&vport->vmid_lock);
> +		vmp = lpfc_get_vmid_from_hastable(vport, hash, uuid);
> +
> +		/* while the read lock was released, in case the entry was */
> +		/* added by other context or is in process of being added */
> +		if (vmp && vmp->flag & LPFC_VMID_REGISTERED) {
> +			lpfc_vmid_update_entry(vport, cmd, vmp, tag);
> +			write_unlock(&vport->vmid_lock);
> +			return 0;
> +		} else if (vmp && vmp->flag & LPFC_VMID_REQ_REGISTER) {
> +			write_unlock(&vport->vmid_lock);
> +			return 1;
> +		}
> +
> +		/* else search and allocate a free slot in the hash table */
> +		if (vport->cur_vmid_cnt < vport->max_vmid) {
> +			for (i = 0; i < vport->max_vmid; ++i) {
> +				vmp = vport->vmid + i;
> +				if (vmp->flag == LPFC_VMID_SLOT_FREE) {
> +					vmp = vport->vmid + i;
> +					break;
> +				}
> +			}
> +		} else {
> +			write_unlock(&vport->vmid_lock);
> +			return 1;
> +		}
> +
> +		if (vmp && (vmp->flag == LPFC_VMID_SLOT_FREE)) {
> +			vmp->vmid_len = len;
> +
> +			/* Add the vmid and register  */
> +			memcpy(vmp->host_vmid, uuid, vmp->vmid_len);
> +			vmp->io_rd_cnt = 0;
> +			vmp->io_wr_cnt = 0;
> +			vmp->flag = LPFC_VMID_SLOT_USED;
> +			lpfc_put_vmid_in_hashtable(vport, hash, vmp);
> +
> +			vmp->delete_inactive =
> +			    vport->vmid_inactivity_timeout ? 1 : 0;
> +
> +			/* if type priority tag, get next available vmid */
> +			if (lpfc_vmid_is_type_priority_tag(vport))
> +				lpfc_vmid_assign_cs_ctl(vport, vmp);
> +
> +			/* allocate the per cpu variable for holding */
> +			/* the last access time stamp only if vmid is enabled */
> +			if (!vmp->last_io_time)
> +				vmp->last_io_time =
> +				    __alloc_percpu(sizeof(u64),
> +						   __alignof__(struct
> +							       lpfc_vmid));
> +
> +			/* registration pending */
> +			pending = 1;
> +			rc = 1;
> +		}
> +		write_unlock(&vport->vmid_lock);
> +
> +		/* complete transaction with switch */
> +		if (pending) {
> +			if (lpfc_vmid_is_type_priority_tag(vport))
> +				rc = lpfc_vmid_uvem(vport, vmp, true);
> +			else
> +				rc = lpfc_vmid_cmd(vport,
> +						   SLI_CTAS_RAPP_IDENT,
> +						   vmp);
> +			if (!rc) {
> +				write_lock(&vport->vmid_lock);
> +				vport->cur_vmid_cnt++;
> +				vmp->flag |= LPFC_VMID_REQ_REGISTER;
> +				write_unlock(&vport->vmid_lock);
> +			}
> +		}
> +
> +		/* finally, enable the idle timer once */
> +		if (!(vport->phba->pport->vmid_flag & LPFC_VMID_TIMER_ENBLD)) {
> +			mod_timer(&vport->phba->inactive_vmid_poll,
> +				  jiffies +
> +				  msecs_to_jiffies(1000 * LPFC_VMID_TIMER));
> +			vport->phba->pport->vmid_flag |= LPFC_VMID_TIMER_ENBLD;
> +		}
> +	}
> +	return rc;
> +}
> +
> +/*
> + * lpfc_is_command_vm_io - get the uuid from blk cgroup
> + * @cmd:Pointer to scsi_cmnd data structure
> + * Returns uuid if present if not null
> + */
> +static char *lpfc_is_command_vm_io(struct scsi_cmnd *cmd)
> +{
> +	char *uuid = NULL;
> +
> +	if (cmd->request) {
> +		if (cmd->request->bio)
> +			uuid = blkcg_get_app_identifier(cmd->request->bio);
> +	}
> +	return uuid;
> +}
> +
>   /**
>    * lpfc_queuecommand - scsi_host_template queuecommand entry point
>    * @cmnd: Pointer to scsi_cmnd data structure.
> @@ -4649,6 +4792,7 @@ lpfc_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *cmnd)
>   	int err, idx;
>   #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
>   	uint64_t start = 0L;
> +	u8 *uuid = NULL;
>   
>   	if (phba->ktime_on)
>   		start = ktime_get_ns();
> @@ -4772,6 +4916,25 @@ lpfc_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *cmnd)
>   
>   	lpfc_scsi_prep_cmnd(vport, lpfc_cmd, ndlp);
>   
> +	/* check the necessary and sufficient condition to support VMID */
> +	if (lpfc_is_vmid_enabled(phba) &&
> +	    (ndlp->vmid_support ||
> +	     phba->pport->vmid_priority_tagging ==
> +	     LPFC_VMID_PRIO_TAG_ALL_TARGETS)) {
> +		/* is the IO generated by a VM, get the associated virtual */
> +		/* entity id */
> +		uuid = lpfc_is_command_vm_io(cmnd);
> +
> +		if (uuid) {
> +			err = lpfc_vmid_get_appid(vport, uuid, cmnd,
> +				(union lpfc_vmid_io_tag *)
> +					&lpfc_cmd->cur_iocbq.vmid_tag);
> +			if (!err)
> +				lpfc_cmd->cur_iocbq.iocb_flag |= LPFC_IO_VMID;
> +		}
> +	}
> +
> +	atomic_inc(&ndlp->cmd_pending);
>   #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
>   	if (unlikely(phba->hdwqstat_on & LPFC_CHECK_SCSI_IO))
>   		this_cpu_inc(phba->sli4_hba.c_stat->xmt_io);
> 
Well.

Creating a VMID in the hotpath with a while() loop will be bogging down 
performance to no end.
I'd rather have restricted the ->queuecommand() function to a direct lookup.
If that fails (as the VMID isn't registered) we should kicking of a 
workqueue for registering the VMID and return BUSY.
Or tweak blkcg to register the VMID directly, and reject the command if 
the VMID isn't registered :-)

Cheers,

Hannes


-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
