Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8B1464F15
	for <lists+linux-scsi@lfdr.de>; Wed,  1 Dec 2021 14:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349684AbhLANxY (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 1 Dec 2021 08:53:24 -0500
Received: from mga14.intel.com ([192.55.52.115]:44389 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349639AbhLANvc (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 1 Dec 2021 08:51:32 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="236687410"
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="236687410"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 05:48:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="459254648"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.76]) ([10.237.72.76])
  by orsmga003.jf.intel.com with ESMTP; 01 Dec 2021 05:48:08 -0800
Subject: Re: [PATCH v3 10/17] scsi: ufs: Fix a deadlock in the error handler
To:     Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-scsi@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Bean Huo <beanhuo@micron.com>,
        Avri Altman <avri.altman@wdc.com>,
        Can Guo <cang@codeaurora.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Keoseong Park <keosung.park@samsung.com>
References: <20211130233324.1402448-1-bvanassche@acm.org>
 <20211130233324.1402448-11-bvanassche@acm.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <25844cd2-872a-514f-4384-6ee877418dc7@intel.com>
Date:   Wed, 1 Dec 2021 15:48:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211130233324.1402448-11-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 01/12/2021 01:33, Bart Van Assche wrote:
> The following deadlock has been observed on a test setup:
> * All tags allocated.
> * The SCSI error handler calls ufshcd_eh_host_reset_handler()
> * ufshcd_eh_host_reset_handler() queues work that calls ufshcd_err_handler()
> * ufshcd_err_handler() locks up as follows:
> 
> Workqueue: ufs_eh_wq_0 ufshcd_err_handler.cfi_jt
> Call trace:
>  __switch_to+0x298/0x5d8
>  __schedule+0x6cc/0xa94
>  schedule+0x12c/0x298
>  blk_mq_get_tag+0x210/0x480
>  __blk_mq_alloc_request+0x1c8/0x284
>  blk_get_request+0x74/0x134
>  ufshcd_exec_dev_cmd+0x68/0x640
>  ufshcd_verify_dev_init+0x68/0x35c
>  ufshcd_probe_hba+0x12c/0x1cb8
>  ufshcd_host_reset_and_restore+0x88/0x254
>  ufshcd_reset_and_restore+0xd0/0x354
>  ufshcd_err_handler+0x408/0xc58
>  process_one_work+0x24c/0x66c
>  worker_thread+0x3e8/0xa4c
>  kthread+0x150/0x1b4
>  ret_from_fork+0x10/0x30
> 
> Fix this lockup by making ufshcd_exec_dev_cmd() allocate a reserved
> request.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

One minor comment below, nevertheless:

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/scsi/ufs/ufshcd.c | 53 +++++++++++----------------------------
>  drivers/scsi/ufs/ufshcd.h |  2 ++
>  2 files changed, 16 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index 2d0f59424b00..da4714aaa850 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -128,8 +128,9 @@ EXPORT_SYMBOL_GPL(ufshcd_dump_regs);
>  enum {
>  	UFSHCD_MAX_CHANNEL	= 0,
>  	UFSHCD_MAX_ID		= 1,
> -	UFSHCD_CMD_PER_LUN	= 32,
> -	UFSHCD_CAN_QUEUE	= 32,
> +	UFSHCD_NUM_RESERVED	= 1,
> +	UFSHCD_CMD_PER_LUN	= 32 - UFSHCD_NUM_RESERVED,
> +	UFSHCD_CAN_QUEUE	= 32 - UFSHCD_NUM_RESERVED,
>  };
>  
>  static const char *const ufshcd_state_name[] = {
> @@ -2170,6 +2171,7 @@ static inline int ufshcd_hba_capabilities(struct ufs_hba *hba)
>  	hba->nutrs = (hba->capabilities & MASK_TRANSFER_REQUESTS_SLOTS) + 1;
>  	hba->nutmrs =
>  	((hba->capabilities & MASK_TASK_MANAGEMENT_REQUEST_SLOTS) >> 16) + 1;
> +	hba->reserved_slot = hba->nutrs - 1;
>  
>  	/* Read crypto capabilities */
>  	err = ufshcd_hba_init_crypto_capabilities(hba);
> @@ -2912,30 +2914,15 @@ static int ufshcd_wait_for_dev_cmd(struct ufs_hba *hba,
>  static int ufshcd_exec_dev_cmd(struct ufs_hba *hba,
>  		enum dev_cmd_type cmd_type, int timeout)
>  {
> -	struct request_queue *q = hba->cmd_queue;

I think cmd_queue is not used anymore after this.

>  	DECLARE_COMPLETION_ONSTACK(wait);
> -	struct request *req;
> +	const u32 tag = hba->reserved_slot;
>  	struct ufshcd_lrb *lrbp;
>  	int err;
> -	int tag;
>  
> -	down_read(&hba->clk_scaling_lock);
> +	/* Protects use of hba->reserved_slot. */
> +	lockdep_assert_held(&hba->dev_cmd.lock);
>  
> -	/*
> -	 * Get free slot, sleep if slots are unavailable.
> -	 * Even though we use wait_event() which sleeps indefinitely,
> -	 * the maximum wait time is bounded by SCSI request timeout.
> -	 */
> -	req = blk_mq_alloc_request(q, REQ_OP_DRV_OUT, 0);
> -	if (IS_ERR(req)) {
> -		err = PTR_ERR(req);
> -		goto out_unlock;
> -	}
> -	tag = req->tag;
> -	WARN_ONCE(tag < 0, "Invalid tag %d\n", tag);
> -	/* Set the timeout such that the SCSI error handler is not activated. */
> -	req->timeout = msecs_to_jiffies(2 * timeout);
> -	blk_mq_start_request(req);
> +	down_read(&hba->clk_scaling_lock);
>  
>  	lrbp = &hba->lrb[tag];
>  	WARN_ON(lrbp->cmd);
> @@ -2953,8 +2940,6 @@ static int ufshcd_exec_dev_cmd(struct ufs_hba *hba,
>  				    (struct utp_upiu_req *)lrbp->ucd_rsp_ptr);
>  
>  out:
> -	blk_mq_free_request(req);
> -out_unlock:
>  	up_read(&hba->clk_scaling_lock);
>  	return err;
>  }
> @@ -6689,23 +6674,16 @@ static int ufshcd_issue_devman_upiu_cmd(struct ufs_hba *hba,
>  					enum dev_cmd_type cmd_type,
>  					enum query_opcode desc_op)
>  {
> -	struct request_queue *q = hba->cmd_queue;
>  	DECLARE_COMPLETION_ONSTACK(wait);
> -	struct request *req;
> +	const u32 tag = hba->reserved_slot;
>  	struct ufshcd_lrb *lrbp;
>  	int err = 0;
> -	int tag;
>  	u8 upiu_flags;
>  
> -	down_read(&hba->clk_scaling_lock);
> +	/* Protects use of hba->reserved_slot. */
> +	lockdep_assert_held(&hba->dev_cmd.lock);
>  
> -	req = blk_mq_alloc_request(q, REQ_OP_DRV_OUT, 0);
> -	if (IS_ERR(req)) {
> -		err = PTR_ERR(req);
> -		goto out_unlock;
> -	}
> -	tag = req->tag;
> -	WARN_ONCE(tag < 0, "Invalid tag %d\n", tag);
> +	down_read(&hba->clk_scaling_lock);
>  
>  	lrbp = &hba->lrb[tag];
>  	WARN_ON(lrbp->cmd);
> @@ -6774,9 +6752,6 @@ static int ufshcd_issue_devman_upiu_cmd(struct ufs_hba *hba,
>  	ufshcd_add_query_upiu_trace(hba, err ? UFS_QUERY_ERR : UFS_QUERY_COMP,
>  				    (struct utp_upiu_req *)lrbp->ucd_rsp_ptr);
>  
> -	blk_mq_free_request(req);
> -
> -out_unlock:
>  	up_read(&hba->clk_scaling_lock);
>  	return err;
>  }
> @@ -9507,8 +9482,8 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
>  	/* Configure LRB */
>  	ufshcd_host_memory_configure(hba);
>  
> -	host->can_queue = hba->nutrs;
> -	host->cmd_per_lun = hba->nutrs;
> +	host->can_queue = hba->nutrs - UFSHCD_NUM_RESERVED;
> +	host->cmd_per_lun = hba->nutrs - UFSHCD_NUM_RESERVED;
>  	host->max_id = UFSHCD_MAX_ID;
>  	host->max_lun = UFS_MAX_LUNS;
>  	host->max_channel = UFSHCD_MAX_CHANNEL;
> diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
> index ecc6c545a19d..c3c2792f309f 100644
> --- a/drivers/scsi/ufs/ufshcd.h
> +++ b/drivers/scsi/ufs/ufshcd.h
> @@ -745,6 +745,7 @@ struct ufs_hba_monitor {
>   * @capabilities: UFS Controller Capabilities
>   * @nutrs: Transfer Request Queue depth supported by controller
>   * @nutmrs: Task Management Queue depth supported by controller
> + * @reserved_slot: Used to submit device commands. Protected by @dev_cmd.lock.
>   * @ufs_version: UFS Version to which controller complies
>   * @vops: pointer to variant specific operations
>   * @priv: pointer to variant specific private data
> @@ -836,6 +837,7 @@ struct ufs_hba {
>  	u32 capabilities;
>  	int nutrs;
>  	int nutmrs;
> +	u32 reserved_slot;
>  	u32 ufs_version;
>  	const struct ufs_hba_variant_ops *vops;
>  	struct ufs_hba_variant_params *vps;
> 

