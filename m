Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E373C36082A
	for <lists+linux-scsi@lfdr.de>; Thu, 15 Apr 2021 13:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbhDOLWU (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 15 Apr 2021 07:22:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37537 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230202AbhDOLWR (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 15 Apr 2021 07:22:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618485714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Wd5wIgys/2joilfaJvtwcPNbumqMsLn/+FBS/palpE=;
        b=eEssbo8AeOjWebLB0zzgI85qqZaT2QYlUIix7fGqlMOdWqc+8FXZ+yOV8aRi6BJjfLPfGP
        g6jk+RnP0I3BcoD0amuYjmaDlu3pr9vKYyxzxbp/33pK9Xbe5P2RbDAykL04AAq3htSGaW
        UWjNYxjAo8pC8MYmAWav0XzwjY7iTHg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-J6WJD9uQNImZTNgt69jMkA-1; Thu, 15 Apr 2021 07:21:50 -0400
X-MC-Unique: J6WJD9uQNImZTNgt69jMkA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42DFB84E20A;
        Thu, 15 Apr 2021 11:21:49 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.193.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3B00747;
        Thu, 15 Apr 2021 11:21:48 +0000 (UTC)
Subject: Re: [PATCH v2 09/24] mpi3mr: add support for recovering controller
To:     Kashyap Desai <kashyap.desai@broadcom.com>,
        linux-scsi@vger.kernel.org
Cc:     sathya.prakash@broadcom.com
References: <20210407020451.924822-1-kashyap.desai@broadcom.com>
 <20210407020451.924822-10-kashyap.desai@broadcom.com>
From:   Tomas Henzl <thenzl@redhat.com>
Message-ID: <2ae12d78-6f50-cf36-94fc-2e6e92ab3051@redhat.com>
Date:   Thu, 15 Apr 2021 13:21:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210407020451.924822-10-kashyap.desai@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 4/7/21 4:04 AM, Kashyap Desai wrote:
> Added h/w defined process of doing controller reset.
> The driver on detection of firmware fault or any kind of unresponsiveness in
> the controller (Any admin command time outs) results in resetting the controller.
> The primary reset mechanisms used are either soft reset or diag fault reset.
> Reset is performed if the host sets the ResetAction field in the HostDiagnostic
> register to a 001b (Soft Reset) or 007b(diag fault reset).
> The driver after successfully resetting the controller reinitialize the
> controller by going through start of the day controller initialization procedures.
> The pending I/Os during the reset are returned back to SML for retry.
> 
> Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Cc: sathya.prakash@broadcom.com
> ---
>  drivers/scsi/mpi3mr/mpi3mr.h    |  15 +-
>  drivers/scsi/mpi3mr/mpi3mr_fw.c | 416 +++++++++++++++++++++++++++++---
>  drivers/scsi/mpi3mr/mpi3mr_os.c |  92 ++++++-
>  3 files changed, 480 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/scsi/mpi3mr/mpi3mr.h b/drivers/scsi/mpi3mr/mpi3mr.h
> index 063877f1bc37..d18bfb954bc4 100644
> --- a/drivers/scsi/mpi3mr/mpi3mr.h
> +++ b/drivers/scsi/mpi3mr/mpi3mr.h
> @@ -98,6 +98,7 @@ extern struct list_head mrioc_list;
>  #define MPI3MR_INTADMCMD_TIMEOUT		10
>  #define MPI3MR_PORTENABLE_TIMEOUT		300
>  #define MPI3MR_RESETTM_TIMEOUT			30
> +#define MPI3MR_RESET_HOST_IOWAIT_TIMEOUT	5
>  #define MPI3MR_DEFAULT_SHUTDOWN_TIME		120
>  
>  #define MPI3MR_WATCHDOG_INTERVAL		1000 /* in milli seconds */
> @@ -630,10 +631,14 @@ struct scmd_priv {
>   * @dev_handle_bitmap_sz: Device handle bitmap size
>   * @removepend_bitmap: Remove pending bitmap
>   * @delayed_rmhs_list: Delayed device removal list
> + * @fault_dbg: Fault debug flag
>   * @reset_in_progress: Reset in progress flag
>   * @unrecoverable: Controller unrecoverable flag
> + * @reset_mutex: Controller reset mutex
> + * @reset_waitq: Controller reset  wait queue
>   * @diagsave_timeout: Diagnostic information save timeout
>   * @logging_level: Controller debug logging level
> + * @flush_io_count: I/O count to flush after reset
>   * @current_event: Firmware event currently in process
>   * @driver_info: Driver, Kernel, OS information to firmware
>   * @change_count: Topology change count
> @@ -748,11 +753,15 @@ struct mpi3mr_ioc {
>  	void *removepend_bitmap;
>  	struct list_head delayed_rmhs_list;
>  
> +	u8 fault_dbg;
>  	u8 reset_in_progress;
>  	u8 unrecoverable;
> +	struct mutex reset_mutex;
> +	wait_queue_head_t reset_waitq;
>  
>  	u16 diagsave_timeout;
>  	int logging_level;
> +	u16 flush_io_count;
>  
>  	struct mpi3mr_fwevt *current_event;
>  	Mpi3DriverInfoLayout_t driver_info;
> @@ -801,8 +810,8 @@ struct delayed_dev_rmhs_node {
>  
>  int mpi3mr_setup_resources(struct mpi3mr_ioc *mrioc);
>  void mpi3mr_cleanup_resources(struct mpi3mr_ioc *mrioc);
> -int mpi3mr_init_ioc(struct mpi3mr_ioc *mrioc);
> -void mpi3mr_cleanup_ioc(struct mpi3mr_ioc *mrioc);
> +int mpi3mr_init_ioc(struct mpi3mr_ioc *mrioc, u8 re_init);
> +void mpi3mr_cleanup_ioc(struct mpi3mr_ioc *mrioc, u8 re_init);
>  int mpi3mr_issue_port_enable(struct mpi3mr_ioc *mrioc, u8 async);
>  int mpi3mr_admin_request_post(struct mpi3mr_ioc *mrioc, void *admin_req,
>  u16 admin_req_sz, u8 ignore_reset);
> @@ -828,6 +837,8 @@ void mpi3mr_stop_watchdog(struct mpi3mr_ioc *mrioc);
>  
>  int mpi3mr_soft_reset_handler(struct mpi3mr_ioc *mrioc,
>  			      u32 reset_reason, u8 snapdump);
> +int mpi3mr_diagfault_reset_handler(struct mpi3mr_ioc *mrioc,
> +				   u32 reset_reason);
>  void mpi3mr_ioc_disable_intr(struct mpi3mr_ioc *mrioc);
>  void mpi3mr_ioc_enable_intr(struct mpi3mr_ioc *mrioc);
>  
> diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
> index a5c9a0f7cb8e..b8e9c87ea677 100644
> --- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
> +++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
> @@ -1608,6 +1608,40 @@ void mpi3mr_stop_watchdog(struct mpi3mr_ioc *mrioc)
>  	}
>  }
>  
> +/**
> + * mpi3mr_kill_ioc - Kill the controller
> + * @mrioc: Adapter instance reference
> + * @reason: reason for the failure.
> + *
> + * If fault debug is enabled, display the fault info else issue
> + * diag fault and freeze the system for controller debug
> + * purpose.
> + *
> + * Return: Nothing.
> + */
> +static void mpi3mr_kill_ioc(struct mpi3mr_ioc *mrioc, u32 reason)
> +{
> +	enum mpi3mr_iocstate ioc_state;
> +
> +	if (!mrioc->fault_dbg)
> +		return;
> +
> +	dump_stack();
> +
> +	ioc_state = mpi3mr_get_iocstate(mrioc);
> +	if (ioc_state == MRIOC_STATE_FAULT)
> +		mpi3mr_print_fault_info(mrioc);
> +	else {
> +		ioc_err(mrioc, "Firmware is halted due to the reason %d\n",
> +		    reason);
> +		mpi3mr_diagfault_reset_handler(mrioc, reason);
> +	}
> +	if (mrioc->fault_dbg == 2)
> +		for (;;)
> +			;
> +	else
> +		panic("panic in %s\n", __func__);
> +}
>  
>  /**
>   * mpi3mr_setup_admin_qpair - Setup admin queue pair
> @@ -2357,6 +2391,7 @@ static int mpi3mr_alloc_chain_bufs(struct mpi3mr_ioc *mrioc)
>  	return retval;
>  }
>  
> +
>  /**
>   * mpi3mr_port_enable_complete - Mark port enable complete
>   * @mrioc: Adapter instance reference
> @@ -2567,6 +2602,7 @@ int mpi3mr_setup_resources(struct mpi3mr_ioc *mrioc)
>  /**
>   * mpi3mr_init_ioc - Initialize the controller
>   * @mrioc: Adapter instance reference
> + * @re_init: Flag to indicate is this fresh init or re-init
>   *
>   * This the controller initialization routine, executed either
>   * after soft reset or from pci probe callback.
> @@ -2579,7 +2615,7 @@ int mpi3mr_setup_resources(struct mpi3mr_ioc *mrioc)
>   *
>   * Return: 0 on success and non-zero on failure.
>   */
> -int mpi3mr_init_ioc(struct mpi3mr_ioc *mrioc)
> +int mpi3mr_init_ioc(struct mpi3mr_ioc *mrioc, u8 re_init)
>  {
>  	int retval = 0;
>  	enum mpi3mr_iocstate ioc_state;
> @@ -2589,12 +2625,14 @@ int mpi3mr_init_ioc(struct mpi3mr_ioc *mrioc)
>  	Mpi3IOCFactsData_t facts_data;
>  
>  	mrioc->change_count = 0;
> -	mrioc->cpu_count = num_online_cpus();
> -	retval = mpi3mr_setup_resources(mrioc);
> -	if (retval) {
> -		ioc_err(mrioc, "Failed to setup resources:error %d\n",
> -		    retval);
> -		goto out_nocleanup;
> +	if (!re_init) {
> +		mrioc->cpu_count = num_online_cpus();
> +		retval = mpi3mr_setup_resources(mrioc);
> +		if (retval) {
> +			ioc_err(mrioc, "Failed to setup resources:error %d\n",
> +			    retval);
> +			goto out_nocleanup;
> +		}
>  	}
>  	ioc_status = readl(&mrioc->sysif_regs->IOCStatus);
>  	ioc_config = readl(&mrioc->sysif_regs->IOCConfiguration);
> @@ -2670,12 +2708,15 @@ int mpi3mr_init_ioc(struct mpi3mr_ioc *mrioc)
>  		goto out_failed;
>  	}
>  
> -	retval = mpi3mr_setup_isr(mrioc, 1);
> -	if (retval) {
> -		ioc_err(mrioc, "Failed to setup ISR error %d\n",
> -		    retval);
> -		goto out_failed;
> -	}
> +	if (!re_init) {
> +		retval = mpi3mr_setup_isr(mrioc, 1);
> +		if (retval) {
> +			ioc_err(mrioc, "Failed to setup ISR error %d\n",
> +			    retval);
> +			goto out_failed;
> +		}
> +	} else
> +		mpi3mr_ioc_enable_intr(mrioc);
>  
>  	retval = mpi3mr_issue_iocfacts(mrioc, &facts_data);
>  	if (retval) {
> @@ -2685,11 +2726,14 @@ int mpi3mr_init_ioc(struct mpi3mr_ioc *mrioc)
>  	}
>  
>  	mpi3mr_process_factsdata(mrioc, &facts_data);
> -	retval = mpi3mr_check_reset_dma_mask(mrioc);
> -	if (retval) {
> -		ioc_err(mrioc, "Resetting dma mask failed %d\n",
> -		    retval);
> -		goto out_failed;
> +	if (!re_init) {
> +		retval = mpi3mr_check_reset_dma_mask(mrioc);
> +		if (retval) {
> +			ioc_err(mrioc, "Resetting dma mask failed %d\n",
> +			    retval);
> +			goto out_failed;
> +		}
> +
>  	}
>  
>  	retval = mpi3mr_alloc_reply_sense_bufs(mrioc);
> @@ -2700,13 +2744,15 @@ int mpi3mr_init_ioc(struct mpi3mr_ioc *mrioc)
>  		goto out_failed;
>  	}
>  
> -	retval = mpi3mr_alloc_chain_bufs(mrioc);
> -	if (retval) {
> -		ioc_err(mrioc, "Failed to allocated chain buffers %d\n",
> -		    retval);
> -		goto out_failed;
> -	}
> +	if (!re_init) {
> +		retval = mpi3mr_alloc_chain_bufs(mrioc);
> +		if (retval) {
> +			ioc_err(mrioc, "Failed to allocated chain buffers %d\n",
> +			    retval);
> +			goto out_failed;
> +		}
>  
> +	}
>  	retval = mpi3mr_issue_iocinit(mrioc);
>  	if (retval) {
>  		ioc_err(mrioc, "Failed to Issue IOC Init %d\n",
> @@ -2721,11 +2767,13 @@ int mpi3mr_init_ioc(struct mpi3mr_ioc *mrioc)
>  	writel(mrioc->sbq_host_index,
>  	    &mrioc->sysif_regs->SenseBufferFreeHostIndex);
>  
> -	retval = mpi3mr_setup_isr(mrioc, 0);
> -	if (retval) {
> -		ioc_err(mrioc, "Failed to re-setup ISR, error %d\n",
> -		    retval);
> -		goto out_failed;
> +	if (!re_init)  {
> +		retval = mpi3mr_setup_isr(mrioc, 0);
> +		if (retval) {
> +			ioc_err(mrioc, "Failed to re-setup ISR, error %d\n",
> +			    retval);
> +			goto out_failed;
> +		}
>  	}
>  
>  	retval = mpi3mr_create_op_queues(mrioc);
> @@ -2735,6 +2783,14 @@ int mpi3mr_init_ioc(struct mpi3mr_ioc *mrioc)
>  		goto out_failed;
>  	}
>  
> +	if (re_init &&
> +	    (mrioc->shost->nr_hw_queues > mrioc->num_op_reply_q)) {
> +		ioc_err(mrioc,
> +		    "Cannot create minimum number of OpQueues expected:%d created:%d\n",
> +		    mrioc->shost->nr_hw_queues, mrioc->num_op_reply_q);
> +		goto out_failed;
> +	}
> +
>  	for (i = 0; i < MPI3_EVENT_NOTIFY_EVENTMASK_WORDS; i++)
>  		mrioc->event_masks[i] = -1;
>  
> @@ -2758,14 +2814,109 @@ int mpi3mr_init_ioc(struct mpi3mr_ioc *mrioc)
>  		goto out_failed;
>  	}
>  
> +	if (re_init) {
> +		ioc_info(mrioc, "Issuing Port Enable\n");
> +		retval = mpi3mr_issue_port_enable(mrioc, 0);
> +		if (retval) {
> +			ioc_err(mrioc, "Failed to issue port enable %d\n",
> +			    retval);
> +			goto out_failed;
> +		}
> +	}
>  	return retval;
>  
>  out_failed:
> -	mpi3mr_cleanup_ioc(mrioc);
> +	mpi3mr_cleanup_ioc(mrioc, re_init);
>  out_nocleanup:
>  	return retval;
>  }
>  
> +/**
> + * mpi3mr_memset_op_reply_q_buffers - memset the operational reply queue's
> + *					segments
> + * @mrioc: Adapter instance reference
> + * @qidx: Operational reply queue index
> + *
> + * Return: Nothing.
> + */
> +static void mpi3mr_memset_op_reply_q_buffers(struct mpi3mr_ioc *mrioc, u16 qidx)
> +{
> +	struct op_reply_qinfo *op_reply_q = mrioc->op_reply_qinfo + qidx;
> +	struct segments *segments;
> +	int i, size;
> +
> +	if (!op_reply_q->q_segments)
> +		return;
> +
> +	size = op_reply_q->segment_qd * mrioc->op_reply_desc_sz;
> +	segments = op_reply_q->q_segments;
> +	for (i = 0; i < op_reply_q->num_segments; i++)
> +		memset(segments[i].segment, 0, size);
> +}
> +
> +/**
> + * mpi3mr_memset_op_req_q_buffers - memset the operational request queue's
> + *					segments
> + * @mrioc: Adapter instance reference
> + * @qidx: Operational request queue index
> + *
> + * Return: Nothing.
> + */
> +static void mpi3mr_memset_op_req_q_buffers(struct mpi3mr_ioc *mrioc, u16 qidx)
> +{
> +	struct op_req_qinfo *op_req_q = mrioc->req_qinfo + qidx;
> +	struct segments *segments;
> +	int i, size;
> +
> +	if (!op_req_q->q_segments)
> +		return;
> +
> +	size = op_req_q->segment_qd * mrioc->facts.op_req_sz;
> +	segments = op_req_q->q_segments;
> +	for (i = 0; i < op_req_q->num_segments; i++)
> +		memset(segments[i].segment, 0, size);
> +}
> +
> +/**
> + * mpi3mr_memset_buffers - memset memory for a controller
> + * @mrioc: Adapter instance reference
> + *
> + * clear all the memory allocated for a controller, typically
> + * called post reset to reuse the memory allocated during the
> + * controller init.
> + *
> + * Return: Nothing.
> + */
> +static void mpi3mr_memset_buffers(struct mpi3mr_ioc *mrioc)
> +{
> +	u16 i;
> +
> +	memset(mrioc->admin_req_base, 0, mrioc->admin_req_q_sz);
> +	memset(mrioc->admin_reply_base, 0, mrioc->admin_reply_q_sz);
> +
> +	memset(mrioc->init_cmds.reply, 0, sizeof(*mrioc->init_cmds.reply));
> +	for (i = 0; i < MPI3MR_NUM_DEVRMCMD; i++)
> +		memset(mrioc->dev_rmhs_cmds[i].reply, 0,
> +		    sizeof(*mrioc->dev_rmhs_cmds[i].reply));
> +	memset(mrioc->removepend_bitmap, 0, mrioc->dev_handle_bitmap_sz);
> +	memset(mrioc->devrem_bitmap, 0, mrioc->devrem_bitmap_sz);
> +
> +	for (i = 0; i < mrioc->num_queues; i++) {
> +		mrioc->op_reply_qinfo[i].qid = 0;
> +		mrioc->op_reply_qinfo[i].ci = 0;
> +		mrioc->op_reply_qinfo[i].num_replies = 0;
> +		mrioc->op_reply_qinfo[i].ephase = 0;
> +		mpi3mr_memset_op_reply_q_buffers(mrioc, i);
> +
> +		mrioc->req_qinfo[i].ci = 0;
> +		mrioc->req_qinfo[i].pi = 0;
> +		mrioc->req_qinfo[i].num_requests = 0;
> +		mrioc->req_qinfo[i].qid = 0;
> +		mrioc->req_qinfo[i].reply_qid = 0;
> +		spin_lock_init(&mrioc->req_qinfo[i].q_lock);
> +		mpi3mr_memset_op_req_q_buffers(mrioc, i);
> +	}
> +}
>  
>  /**
>   * mpi3mr_free_mem - Free memory allocated for a controller
> @@ -2941,6 +3092,7 @@ static void mpi3mr_issue_ioc_shutdown(struct mpi3mr_ioc *mrioc)
>  /**
>   * mpi3mr_cleanup_ioc - Cleanup controller
>   * @mrioc: Adapter instance reference
> + * @re_init: Cleanup due to a reinit or not
>   *
>   * Controller cleanup handler, Message unit reset or soft reset
>   * and shutdown notification is issued to the controller and the
> @@ -2948,11 +3100,12 @@ static void mpi3mr_issue_ioc_shutdown(struct mpi3mr_ioc *mrioc)
>   *
>   * Return: Nothing.
>   */
> -void mpi3mr_cleanup_ioc(struct mpi3mr_ioc *mrioc)
> +void mpi3mr_cleanup_ioc(struct mpi3mr_ioc *mrioc, u8 re_init)
>  {
>  	enum mpi3mr_iocstate ioc_state;
>  
> -	mpi3mr_stop_watchdog(mrioc);
> +	if (!re_init)
> +		mpi3mr_stop_watchdog(mrioc);
>  
>  	mpi3mr_ioc_disable_intr(mrioc);
>  
> @@ -2966,13 +3119,94 @@ void mpi3mr_cleanup_ioc(struct mpi3mr_ioc *mrioc)
>  			    MPI3_SYSIF_HOST_DIAG_RESET_ACTION_SOFT_RESET,
>  			    MPI3MR_RESET_FROM_MUR_FAILURE);
>  
> -		 mpi3mr_issue_ioc_shutdown(mrioc);
> +		if (!re_init)
> +			mpi3mr_issue_ioc_shutdown(mrioc);
>  	}
>  
> -	mpi3mr_free_mem(mrioc);
> -	mpi3mr_cleanup_resources(mrioc);
> +	if (!re_init) {
> +		mpi3mr_free_mem(mrioc);
> +		mpi3mr_cleanup_resources(mrioc);
> +	}
> +}
> +
> +/**
> + * mpi3mr_drv_cmd_comp_reset - Flush a internal driver command
> + * @mrioc: Adapter instance reference
> + * @cmdptr: Internal command tracker
> + *
> + * Complete an internal driver commands with state indicating it
> + * is completed due to reset.
> + *
> + * Return: Nothing.
> + */
> +static inline void mpi3mr_drv_cmd_comp_reset(struct mpi3mr_ioc *mrioc,
> +	struct mpi3mr_drv_cmd *cmdptr)
> +{
> +	if (cmdptr->state & MPI3MR_CMD_PENDING) {
> +		cmdptr->state |= MPI3MR_CMD_RESET;
> +		cmdptr->state &= ~MPI3MR_CMD_PENDING;
> +		if (cmdptr->is_waiting) {
> +			complete(&cmdptr->done);
> +			cmdptr->is_waiting = 0;
> +		} else if (cmdptr->callback)
> +			cmdptr->callback(mrioc, cmdptr);
> +	}
>  }
>  
> +/**
> + * mpi3mr_flush_drv_cmds - Flush internaldriver commands
> + * @mrioc: Adapter instance reference
> + *
> + * Flush all internal driver commands post reset
> + *
> + * Return: Nothing.
> + */
> +static void mpi3mr_flush_drv_cmds(struct mpi3mr_ioc *mrioc)
> +{
> +	struct mpi3mr_drv_cmd *cmdptr;
> +	u8 i;
> +
> +	cmdptr = &mrioc->init_cmds;
> +	mpi3mr_drv_cmd_comp_reset(mrioc, cmdptr);
> +
> +	for (i = 0; i < MPI3MR_NUM_DEVRMCMD; i++) {
> +		cmdptr = &mrioc->dev_rmhs_cmds[i];
> +		mpi3mr_drv_cmd_comp_reset(mrioc, cmdptr);
> +	}
> +}
> +
> +/**
> + * mpi3mr_diagfault_reset_handler - Diag fault reset handler
> + * @mrioc: Adapter instance reference
> + * @reset_reason: Reset reason code
> + *
> + * This is an handler for issuing diag fault reset from the
> + * applications through IOCTL path to stop the execution of the
> + * controller
> + *
> + * Return: 0 on success, non-zero on failure.
> + */
> +int mpi3mr_diagfault_reset_handler(struct mpi3mr_ioc *mrioc,
> +	u32 reset_reason)
> +{
> +	int retval = 0;
> +
> +	mrioc->reset_in_progress = 1;
> +
> +	mpi3mr_ioc_disable_intr(mrioc);
> +
> +	retval = mpi3mr_issue_reset(mrioc,
> +	    MPI3_SYSIF_HOST_DIAG_RESET_ACTION_DIAG_FAULT, reset_reason);
> +
> +	if (retval) {
> +		ioc_err(mrioc, "The diag fault reset failed: reason %d\n",
> +		    reset_reason);
> +		mpi3mr_ioc_enable_intr(mrioc);
> +	}
> +	ioc_info(mrioc, "%s\n", ((retval == 0) ? "SUCCESS" : "FAILED"));
> +	mrioc->reset_in_progress = 0;
> +	return retval;
> +}
>  
>  /**
>   * mpi3mr_soft_reset_handler - Reset the controller
> @@ -2980,12 +3214,120 @@ void mpi3mr_cleanup_ioc(struct mpi3mr_ioc *mrioc)
>   * @reset_reason: Reset reason code
>   * @snapdump: Flag to generate snapdump in firmware or not
>   *
> - * TBD
> + * This is an handler for recovering controller by issuing soft
> + * reset are diag fault reset.  This is a blocking function and
> + * when one reset is executed if any other resets they will be
> + * blocked. All IOCTLs/IO will be blocked during the reset. If
> + * controller reset is successful then the controller will be
> + * reinitalized, otherwise the controller will be marked as not
> + * recoverable
> + *
> + * In snapdump bit is set, the controller is issued with diag
> + * fault reset so that the firmware can create a snap dump and
> + * post that the firmware will result in F000 fault and the
> + * driver will issue soft reset to recover from that.
>   *
>   * Return: 0 on success, non-zero on failure.
>   */
>  int mpi3mr_soft_reset_handler(struct mpi3mr_ioc *mrioc,
>  	u32 reset_reason, u8 snapdump)
>  {
> -	return 0;
> +	int retval = 0, i;
> +	unsigned long flags;
> +	u32 host_diagnostic, timeout = MPI3_SYSIF_DIAG_SAVE_TIMEOUT * 10;
> +
> +	if (mrioc->fault_dbg) {
> +		if (snapdump)
> +			mpi3mr_set_diagsave(mrioc);
> +		mpi3mr_kill_ioc(mrioc, reset_reason);
> +	}
> +
> +	/*
> +	 * Block new resets until the currently executing one is finished and
> +	 * return the status of the existing reset for all blocked resets
> +	 */
> +	if (!mutex_trylock(&mrioc->reset_mutex)) {
> +		ioc_info(mrioc, "Another reset in progress\n");
> +		return -1;
> +	}
> +	mrioc->reset_in_progress = 1;
> +
> +	if ((!snapdump) && (reset_reason != MPI3MR_RESET_FROM_FAULT_WATCH) &&
> +	    (reset_reason != MPI3MR_RESET_FROM_CIACTIV_FAULT)) {
> +
> +		for (i = 0; i < MPI3_EVENT_NOTIFY_EVENTMASK_WORDS; i++)
> +			mrioc->event_masks[i] = -1;
> +
> +		retval = mpi3mr_issue_event_notification(mrioc);
> +
> +		if (retval) {
> +			ioc_err(mrioc,
> +			    "Failed to turn off events prior to reset %d\n",
> +			    retval);
> +		}
> +	}
> +
> +	mpi3mr_ioc_disable_intr(mrioc);
> +
> +	if (snapdump) {
> +		mpi3mr_set_diagsave(mrioc);
> +		retval = mpi3mr_issue_reset(mrioc,
> +		    MPI3_SYSIF_HOST_DIAG_RESET_ACTION_DIAG_FAULT, reset_reason);
> +		if (!retval) {
> +			do {
> +				host_diagnostic =
> +				    readl(&mrioc->sysif_regs->HostDiagnostic);
> +				if (!(host_diagnostic &
> +				    MPI3_SYSIF_HOST_DIAG_SAVE_IN_PROGRESS))
> +					break;
> +				msleep(100);
> +			} while (--timeout);
> +		}
> +	}
> +
> +	retval = mpi3mr_issue_reset(mrioc,
> +	    MPI3_SYSIF_HOST_DIAG_RESET_ACTION_SOFT_RESET, reset_reason);
> +	if (retval) {
> +		ioc_err(mrioc, "Failed to issue soft reset to the ioc\n");
> +		goto out;
> +	}
> +
> +	mpi3mr_flush_delayed_rmhs_list(mrioc);
> +	mpi3mr_flush_drv_cmds(mrioc);
> +	memset(mrioc->devrem_bitmap, 0, mrioc->devrem_bitmap_sz);
> +	memset(mrioc->removepend_bitmap, 0, mrioc->dev_handle_bitmap_sz);
> +	mpi3mr_cleanup_fwevt_list(mrioc);
> +	mpi3mr_flush_host_io(mrioc);
> +	mpi3mr_invalidate_devhandles(mrioc);
> +	mpi3mr_memset_buffers(mrioc);
> +	retval = mpi3mr_init_ioc(mrioc, 1);
> +	if (retval) {
> +		pr_err(IOCNAME "reinit after soft reset failed: reason %d\n",
> +		    mrioc->name, reset_reason);
> +		goto out;
> +	}
> +	ssleep(10);
> +
> +out:
> +	if (!retval) {
> +		mrioc->reset_in_progress = 0;
> +		scsi_unblock_requests(mrioc->shost);
> +		mpi3mr_rfresh_tgtdevs(mrioc);
> +		spin_lock_irqsave(&mrioc->watchdog_lock, flags);
> +		if (mrioc->watchdog_work_q)
> +			queue_delayed_work(mrioc->watchdog_work_q,
> +			    &mrioc->watchdog_work,
> +			    msecs_to_jiffies(MPI3MR_WATCHDOG_INTERVAL));
> +		spin_unlock_irqrestore(&mrioc->watchdog_lock, flags);
> +	} else {
> +		mpi3mr_issue_reset(mrioc,
> +		    MPI3_SYSIF_HOST_DIAG_RESET_ACTION_DIAG_FAULT, reset_reason);
> +		mrioc->unrecoverable = 1;
> +		mrioc->reset_in_progress = 0;
> +		retval = -1;
> +	}
> +
> +	mutex_unlock(&mrioc->reset_mutex);
> +	ioc_info(mrioc, "%s\n", ((retval == 0) ? "SUCCESS" : "FAILED"));
> +	return retval;
>  }
> diff --git a/drivers/scsi/mpi3mr/mpi3mr_os.c b/drivers/scsi/mpi3mr/mpi3mr_os.c
> index cd30e26a2225..dd9452de76f8 100644
> --- a/drivers/scsi/mpi3mr/mpi3mr_os.c
> +++ b/drivers/scsi/mpi3mr/mpi3mr_os.c
> @@ -311,6 +311,88 @@ void mpi3mr_cleanup_fwevt_list(struct mpi3mr_ioc *mrioc)
>  	}
>  }
>  
> +/**
> + * mpi3mr_invalidate_devhandles -Invalidate device handles
> + * @mrioc: Adapter instance reference
> + *
> + * Invalidate the device handles in the target device structures
> + * . Called post reset prior to reinitializing the controller.
> + *
> + * Return: Nothing.
> + */
> +void mpi3mr_invalidate_devhandles(struct mpi3mr_ioc *mrioc)
> +{
> +	struct mpi3mr_tgt_dev *tgtdev;
> +	struct mpi3mr_stgt_priv_data *tgt_priv;
> +
> +	list_for_each_entry(tgtdev, &mrioc->tgtdev_list, list) {
> +		tgtdev->dev_handle = MPI3MR_INVALID_DEV_HANDLE;
> +		if (tgtdev->starget && tgtdev->starget->hostdata) {
> +			tgt_priv = tgtdev->starget->hostdata;
> +			tgt_priv->dev_handle = MPI3MR_INVALID_DEV_HANDLE;
> +		}
> +	}
> +}
> +
> +
> +/**
> + * mpi3mr_flush_scmd - Flush individual SCSI command
> + * @rq: Block request
> + * @data: Adapter instance reference
> + *
> + * Return the SCSI command to the upper layers if it is in LLD
> + * scope.
> + *
> + * Return: true always.
> + */
> +
> +static bool mpi3mr_flush_scmd(struct request *rq,
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
> +		mpi3mr_clear_scmd_priv(mrioc, scmd);
> +		scsi_dma_unmap(scmd);
> +		scmd->result = DID_RESET << 16;
> +		scsi_print_command(scmd);
> +		scmd->scsi_done(scmd);
> +		mrioc->flush_io_count++;
> +	}
> +
> +out:
> +	return(true);
> +}
> +
> +
> +/**
> + * mpi3mr_flush_host_io -  Flush host I/Os
> + * @mrioc: Adapter instance reference
> + *
> + * Flush all of the pending I/Os by calling
> + * blk_mq_tagset_busy_iter() for each possible tag. This is
> + * executed post controller reset
> + *
> + * Return: Nothing.
> + */
> +void mpi3mr_flush_host_io(struct mpi3mr_ioc *mrioc)
> +{
> +	struct Scsi_Host *shost = mrioc->shost;
> +
> +	mrioc->flush_io_count = 0;
> +	ioc_info(mrioc, "%s :Flushing Host I/O cmds post reset\n", __func__);
> +	blk_mq_tagset_busy_iter(&shost->tag_set,
> +	    mpi3mr_flush_scmd, (void *)mrioc);
> +	ioc_info(mrioc, "%s :Flushed %d Host I/O cmds\n", __func__,
> +	    mrioc->flush_io_count);
> +}
> +
>  /**
>   * mpi3mr_alloc_tgtdev - target device allocator
>   *
> @@ -2510,6 +2592,7 @@ mpi3mr_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	INIT_LIST_HEAD(&mrioc->tgtdev_list);
>  	INIT_LIST_HEAD(&mrioc->delayed_rmhs_list);
>  
> +	mutex_init(&mrioc->reset_mutex);
>  	mpi3mr_init_drv_cmd(&mrioc->init_cmds, MPI3MR_HOSTTAG_INITCMDS);
>  
>  	for (i = 0; i < MPI3MR_NUM_DEVRMCMD; i++)
> @@ -2519,6 +2602,7 @@ mpi3mr_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (pdev->revision)
>  		mrioc->enable_segqueue = true;
>  
> +	init_waitqueue_head(&mrioc->reset_waitq);
>  	mrioc->logging_level = logging_level;
>  	mrioc->shost = shost;
>  	mrioc->pdev = pdev;
> @@ -2543,7 +2627,7 @@ mpi3mr_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	}
>  
>  	mrioc->is_driver_loading = 1;
> -	if (mpi3mr_init_ioc(mrioc)) {
> +	if (mpi3mr_init_ioc(mrioc, 0)) {
>  		ioc_err(mrioc, "failure at %s:%d/%s()!\n",
>  		    __FILE__, __LINE__, __func__);
>  		retval = -ENODEV;
> @@ -2566,7 +2650,7 @@ mpi3mr_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	return retval;
>  
>  addhost_failed:
> -	mpi3mr_cleanup_ioc(mrioc);
> +	mpi3mr_cleanup_ioc(mrioc, 0);
>  out_iocinit_failed:
>  	destroy_workqueue(mrioc->fwevt_worker_thread);
>  out_fwevtthread_failed:
> @@ -2616,7 +2700,7 @@ static void mpi3mr_remove(struct pci_dev *pdev)
>  		mpi3mr_tgtdev_put(tgtdev);
>  	}
>  
> -	mpi3mr_cleanup_ioc(mrioc);
> +	mpi3mr_cleanup_ioc(mrioc, 0);
>  
>  	spin_lock(&mrioc_list_lock);
>  	list_del(&mrioc->list);
> @@ -2656,7 +2740,7 @@ static void mpi3mr_shutdown(struct pci_dev *pdev)
>  	if (wq)
>  		destroy_workqueue(wq);
>  
> -	mpi3mr_cleanup_ioc(mrioc);
> +	mpi3mr_cleanup_ioc(mrioc, 0);
>  
>  }
>  
Looks good

Reviewed-by: Tomas Henzl <thenzl@redhat.com>


