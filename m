Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B71432D382
	for <lists+linux-scsi@lfdr.de>; Thu,  4 Mar 2021 13:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231380AbhCDMrq (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 4 Mar 2021 07:47:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:40864 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231345AbhCDMrX (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 4 Mar 2021 07:47:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3B261ACBF;
        Thu,  4 Mar 2021 12:46:42 +0000 (UTC)
Subject: Re: [PATCH v8 13/16] lpfc: vmid: Timeout implementation for vmid
To:     Muneendra <muneendra.kumar@broadcom.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        tj@kernel.org, linux-nvme@lists.infradead.org
Cc:     jsmart2021@gmail.com, emilne@redhat.com, mkumar@redhat.com,
        Gaurav Srivastava <gaurav.srivastava@broadcom.com>
References: <1614835646-16217-1-git-send-email-muneendra.kumar@broadcom.com>
 <1614835646-16217-14-git-send-email-muneendra.kumar@broadcom.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <51d437e1-7f47-c2f1-d9a4-c52de026e7d1@suse.de>
Date:   Thu, 4 Mar 2021 13:46:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1614835646-16217-14-git-send-email-muneendra.kumar@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 3/4/21 6:27 AM, Muneendra wrote:
> From: Gaurav Srivastava <gaurav.srivastava@broadcom.com>
> 
> This patch implements the timeout functionality for the vmid. After the
> set time period of inactivity, the vmid is deregistered from the switch.
> 
> Signed-off-by: Gaurav Srivastava  <gaurav.srivastava@broadcom.com>
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> 
> ---
> v8:
> Fixed the uninitialized variable
> 
> v7:
> No change
> 
> v6:
> Added Forward declarations
> 
> v5:
> No change
> 
> v4:
> No change
> 
> v3:
> No change
> 
> v2:
> Ported the patch on top of 5.10/scsi-queue
> ---
>   drivers/scsi/lpfc/lpfc_hbadisc.c | 110 +++++++++++++++++++++++++++++++
>   drivers/scsi/lpfc/lpfc_init.c    |  40 +++++++++++
>   2 files changed, 150 insertions(+)
> 
> diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
> index 48ca4a612f80..c4519f6349bc 100644
> --- a/drivers/scsi/lpfc/lpfc_hbadisc.c
> +++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
> @@ -72,6 +72,7 @@ static void lpfc_disc_flush_list(struct lpfc_vport *vport);
>   static void lpfc_unregister_fcfi_cmpl(struct lpfc_hba *, LPFC_MBOXQ_t *);
>   static int lpfc_fcf_inuse(struct lpfc_hba *);
>   static void lpfc_mbx_cmpl_read_sparam(struct lpfc_hba *, LPFC_MBOXQ_t *);
> +static void lpfc_check_inactive_vmid(struct lpfc_hba *phba);
>   
>   static int
>   lpfc_valid_xpt_node(struct lpfc_nodelist *ndlp)
> @@ -239,6 +240,115 @@ lpfc_dev_loss_tmo_callbk(struct fc_rport *rport)
>   	return;
>   }
>   
> +/**
> + * lpfc_check_inactive_vmid_one - VMID inactivity checker for a vport
> + * @vport: Pointer to vport context object.
> + *
> + * This function checks for idle vmid entries related to a particular vport. If
> + * found unused/idle, it frees them accordingly.
> + **/
> +static void lpfc_check_inactive_vmid_one(struct lpfc_vport *vport)
> +{
> +	u16 i, keep;
> +	u32 difftime = 0, r;
> +	u64 *lta;
> +	int cpu;
> +
> +	write_lock(&vport->vmid_lock);
> +
> +	if (!vport->cur_vmid_cnt)
> +		goto out;
> +
> +	/* iterate through the table */
> +	for (i = 0; i < LPFC_VMID_HASH_SIZE; ++i) {
> +		keep = 0;
> +		if (vport->hash_table[i] && (vport->hash_table[i]->flag &
> +					     LPFC_VMID_REGISTERED)) {
> +			/* check if the particular vmid is in use */
> +			/* for all available per cpu variable */
> +			for_each_possible_cpu(cpu) {
> +				/* if last access time is less than timeout */
> +				lta = per_cpu_ptr(
> +					vport->hash_table[i]->last_io_time,
> +					cpu);
> +				if (!lta)
> +					continue;
> +				difftime = (jiffies) - (*lta);
> +				if ((vport->vmid_inactivity_timeout *
> +				     JIFFIES_PER_HR) > difftime) {
> +					keep = 1;
> +					break;
> +				}
> +			}
> +
> +			/* if none of the cpus have been used by the vm, */
> +			/*  remove the entry if already registered */
> +			if (!keep) {
> +				/* mark the entry for deregistration */
> +				vport->hash_table[i]->flag =
> +					LPFC_VMID_DE_REGISTER;
> +				write_unlock(&vport->vmid_lock);
> +				if (vport->vmid_priority_tagging)
> +					r = lpfc_vmid_uvem(vport,
> +							   vport->hash_table[i],
> +							   false);
> +				else
> +					r = lpfc_vmid_cmd(vport,
> +							  SLI_CTAS_DAPP_IDENT,
> +							  vport->hash_table[i]);
> +
> +				/* decrement number of active vms and mark */
> +				/* entry in slot as free */
> +				write_lock(&vport->vmid_lock);
> +				if (!r) {
> +					struct lpfc_vmid *ht =
> +							vport->hash_table[i];
> +					vport->cur_vmid_cnt--;
> +					ht->flag = LPFC_VMID_SLOT_FREE;
> +					free_percpu(ht->last_io_time);
> +					ht->last_io_time = NULL;
> +					vport->hash_table[i] = NULL;
> +				}
> +			}
> +		}
> +	}
> + out:
> +	write_unlock(&vport->vmid_lock);
> +}
> +
> +/**
> + * lpfc_check_inactive_vmid - VMID inactivity checker
> + * @phba: Pointer to hba context object.
> + *
> + * This function is called from the worker thread to determine if an entry in
> + * the vmid table can be released since there was no IO activity seen from that
> + * particular VM for the specified time. When this happens, the entry in the
> + * table is released and also the resources on the switch cleared.
> + **/
> +
> +static void lpfc_check_inactive_vmid(struct lpfc_hba *phba)
> +{
> +	struct lpfc_vport *vport;
> +	struct lpfc_vport **vports;
> +	int i;
> +
> +	vports = lpfc_create_vport_work_array(phba);
> +	if (!vports)
> +		return;
> +
> +	for (i = 0; i <= phba->max_vports; i++) {
> +		if ((!vports[i]) && (i == 0))
> +			vport = phba->pport;
> +		else
> +			vport = vports[i];
> +		if (!vport)
> +			break;
> +
> +		lpfc_check_inactive_vmid_one(vport);
> +	}
> +	lpfc_destroy_vport_work_array(phba, vports);
> +}
> +
>   /**
>    * lpfc_dev_loss_tmo_handler - Remote node devloss timeout handler
>    * @ndlp: Pointer to remote node object.
> diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
> index 78934724aaad..f5628f8743ba 100644
> --- a/drivers/scsi/lpfc/lpfc_init.c
> +++ b/drivers/scsi/lpfc/lpfc_init.c
> @@ -4858,6 +4858,42 @@ lpfc_sli4_fcf_redisc_wait_tmo(struct timer_list *t)
>   	lpfc_worker_wake_up(phba);
>   }
>   
> +/**
> + * lpfc_vmid_poll - VMID timeout detection
> + * @ptr: Map to lpfc_hba data structure pointer.
> + *
> + * This routine is invoked when there is no IO on by a VM for the specified
> + * amount of time. When this situation is detected, the VMID has to be
> + * deregistered from the switch and all the local resources freed. The VMID
> + * will be reassigned to the VM once the IO begins.
> + **/
> +static void
> +lpfc_vmid_poll(struct timer_list *t)
> +{
> +	struct lpfc_hba *phba = from_timer(phba, t, inactive_vmid_poll);
> +	u32 wake_up = 0;
> +
> +	/* check if there is a need to issue QFPA */
> +	if (phba->pport->vmid_priority_tagging) {
> +		wake_up = 1;
> +		phba->pport->work_port_events |= WORKER_CHECK_VMID_ISSUE_QFPA;
> +	}
> +
> +	/* Is the vmid inactivity timer enabled */
> +	if (phba->pport->vmid_inactivity_timeout ||
> +	    phba->pport->load_flag & FC_DEREGISTER_ALL_APP_ID) {
> +		wake_up = 1;
> +		phba->pport->work_port_events |= WORKER_CHECK_INACTIVE_VMID;
> +	}
> +
> +	if (wake_up)
> +		lpfc_worker_wake_up(phba);
> +
> +	/* restart the timer for the next iteration */
> +	mod_timer(&phba->inactive_vmid_poll, jiffies + msecs_to_jiffies(1000 *
> +							LPFC_VMID_TIMER));
> +}
> +
>   /**
>    * lpfc_sli4_parse_latt_fault - Parse sli4 link-attention link fault code
>    * @phba: pointer to lpfc hba data structure.
> @@ -6708,6 +6744,10 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
>   	phba->hbqs[LPFC_ELS_HBQ].hbq_alloc_buffer = lpfc_sli4_rb_alloc;
>   	phba->hbqs[LPFC_ELS_HBQ].hbq_free_buffer = lpfc_sli4_rb_free;
>   
> +	/* for VMID idle timeout if VMID is enabled */
> +	if (lpfc_is_vmid_enabled(phba))
> +		timer_setup(&phba->inactive_vmid_poll, lpfc_vmid_poll, 0);
> +
>   	/*
>   	 * Initialize the SLI Layer to run with lpfc SLI4 HBAs.
>   	 */
> 
'tis is a bit odd; I would have expected that the app id is getting 
deregistered when the respective cgroup is released.
But if this timeout is mandated by the spec I guess that's what we need 
to do.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
