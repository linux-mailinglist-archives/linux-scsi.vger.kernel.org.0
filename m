Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADA40293529
	for <lists+linux-scsi@lfdr.de>; Tue, 20 Oct 2020 08:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404528AbgJTGqv (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 20 Oct 2020 02:46:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:35508 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbgJTGqv (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 20 Oct 2020 02:46:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7D0D7ACDB;
        Tue, 20 Oct 2020 06:46:49 +0000 (UTC)
Subject: Re: [PATCH v4 20/31] elx: efct: RQ buffer, memory pool allocation and
 deallocation APIs
To:     James Smart <james.smart@broadcom.com>, linux-scsi@vger.kernel.org
Cc:     Ram Vegesna <ram.vegesna@broadcom.com>
References: <20201012225147.54404-1-james.smart@broadcom.com>
 <20201012225147.54404-21-james.smart@broadcom.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <0db2f974-f177-5a79-9b11-584522d12bfc@suse.de>
Date:   Tue, 20 Oct 2020 08:46:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201012225147.54404-21-james.smart@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 10/13/20 12:51 AM, James Smart wrote:
> This patch continues the efct driver population.
> 
> This patch adds driver definitions for:
> RQ data buffer allocation and deallocate.
> Memory pool allocation and deallocation APIs.
> Mailbox command submission and completion routines.
> 
> Co-developed-by: Ram Vegesna <ram.vegesna@broadcom.com>
> Signed-off-by: Ram Vegesna <ram.vegesna@broadcom.com>
> Signed-off-by: James Smart <james.smart@broadcom.com>
> ---
>   drivers/scsi/elx/efct/efct_hw.c | 411 ++++++++++++++++++++++++++++++++
>   drivers/scsi/elx/efct/efct_hw.h |   9 +
>   2 files changed, 420 insertions(+)
> 
> diff --git a/drivers/scsi/elx/efct/efct_hw.c b/drivers/scsi/elx/efct/efct_hw.c
> index 0af13aa12e35..fdde7f70bedf 100644
> --- a/drivers/scsi/elx/efct/efct_hw.c
> +++ b/drivers/scsi/elx/efct/efct_hw.c
> @@ -1164,3 +1164,414 @@ efct_get_wwpn(struct efct_hw *hw)
>   	memcpy(p, sli->wwpn, sizeof(p));
>   	return get_unaligned_be64(p);
>   }
> +
> +static struct efc_hw_rq_buffer *
> +efct_hw_rx_buffer_alloc(struct efct_hw *hw, u32 rqindex, u32 count,
> +			u32 size)
> +{
> +	struct efct *efct = hw->os;
> +	struct efc_hw_rq_buffer *rq_buf = NULL;
> +	struct efc_hw_rq_buffer *prq;
> +	u32 i;
> +
> +	if (count != 0) {
> +		rq_buf = kmalloc_array(count, sizeof(*rq_buf), GFP_KERNEL);
> +		if (!rq_buf)
> +			return NULL;
> +		memset(rq_buf, 0, sizeof(*rq_buf) * count);
> +
> +		for (i = 0, prq = rq_buf; i < count; i ++, prq++) {
> +			prq->rqindex = rqindex;
> +			prq->dma.size = size;
> +			prq->dma.virt = dma_alloc_coherent(&efct->pci->dev,
> +							   prq->dma.size,
> +							   &prq->dma.phys,
> +							   GFP_DMA);
> +			if (!prq->dma.virt) {
> +				efc_log_err(hw->os, "DMA allocation failed\n");
> +				kfree(rq_buf);
> +				rq_buf = NULL;
> +				break;
> +			}
> +		}
> +	}
> +	return rq_buf;
> +}
> +
> +static void
> +efct_hw_rx_buffer_free(struct efct_hw *hw,
> +		       struct efc_hw_rq_buffer *rq_buf,
> +			u32 count)
> +{
> +	struct efct *efct = hw->os;
> +	u32 i;
> +	struct efc_hw_rq_buffer *prq;
> +
> +	if (rq_buf) {
> +		for (i = 0, prq = rq_buf; i < count; i++, prq++) {
> +			dma_free_coherent(&efct->pci->dev,
> +					  prq->dma.size, prq->dma.virt,
> +					  prq->dma.phys);
> +			memset(&prq->dma, 0, sizeof(struct efc_dma));
> +		}
> +
> +		kfree(rq_buf);
> +	}
> +}
> +
> +enum efct_hw_rtn
> +efct_hw_rx_allocate(struct efct_hw *hw)
> +{
> +	struct efct *efct = hw->os;
> +	u32 i;
> +	int rc = EFCT_HW_RTN_SUCCESS;
> +	u32 rqindex = 0;
> +	u32 hdr_size = EFCT_HW_RQ_SIZE_HDR;
> +	u32 payload_size = hw->config.rq_default_buffer_size;
> +
> +	rqindex = 0;
> +
> +	for (i = 0; i < hw->hw_rq_count; i++) {
> +		struct hw_rq *rq = hw->hw_rq[i];
> +
> +		/* Allocate header buffers */
> +		rq->hdr_buf = efct_hw_rx_buffer_alloc(hw, rqindex,
> +						      rq->entry_count,
> +						      hdr_size);
> +		if (!rq->hdr_buf) {
> +			efc_log_err(efct,
> +				     "efct_hw_rx_buffer_alloc hdr_buf failed\n");
> +			rc = EFCT_HW_RTN_ERROR;
> +			break;
> +		}
> +
> +		efc_log_debug(hw->os,
> +			       "rq[%2d] rq_id %02d header  %4d by %4d bytes\n",
> +			      i, rq->hdr->id, rq->entry_count, hdr_size);
> +
> +		rqindex++;
> +
> +		/* Allocate payload buffers */
> +		rq->payload_buf = efct_hw_rx_buffer_alloc(hw, rqindex,
> +							  rq->entry_count,
> +							  payload_size);
> +		if (!rq->payload_buf) {
> +			efc_log_err(efct,
> +				     "efct_hw_rx_buffer_alloc fb_buf failed\n");
> +			rc = EFCT_HW_RTN_ERROR;
> +			break;
> +		}
> +		efc_log_debug(hw->os,
> +			       "rq[%2d] rq_id %02d default %4d by %4d bytes\n",
> +			      i, rq->data->id, rq->entry_count, payload_size);
> +		rqindex++;
> +	}
> +
> +	return rc ? EFCT_HW_RTN_ERROR : EFCT_HW_RTN_SUCCESS;
> +}
> +
> +enum efct_hw_rtn
> +efct_hw_rx_post(struct efct_hw *hw)
> +{
> +	u32 i;
> +	u32 idx;
> +	u32 rq_idx;
> +	int rc = 0;
> +
> +	if (!hw->seq_pool) {
> +		u32 count = 0;
> +
> +		for (i = 0; i < hw->hw_rq_count; i++)
> +			count += hw->hw_rq[i]->entry_count;
> +
> +		hw->seq_pool = kmalloc_array(count,
> +				sizeof(struct efc_hw_sequence),	GFP_KERNEL);
> +		if (!hw->seq_pool)
> +			return EFCT_HW_RTN_NO_MEMORY;
> +	}
> +
> +	/*
> +	 * In RQ pair mode, we MUST post the header and payload buffer at the
> +	 * same time.
> +	 */
> +	for (rq_idx = 0, idx = 0; rq_idx < hw->hw_rq_count; rq_idx++) {
> +		struct hw_rq *rq = hw->hw_rq[rq_idx];
> +
> +		for (i = 0; i < rq->entry_count - 1; i++) {
> +			struct efc_hw_sequence *seq;
> +
> +			seq = hw->seq_pool + idx;
> +			if (!seq) {
> +				rc = -1;
> +				break;
> +			}
> +			idx++;
> +			seq->header = &rq->hdr_buf[i];
> +			seq->payload = &rq->payload_buf[i];
> +			rc = efct_hw_sequence_free(hw, seq);
> +			if (rc)
> +				break;
> +		}
> +		if (rc)
> +			break;
> +	}
> +
> +	if (rc && hw->seq_pool)
> +		kfree(hw->seq_pool);
> +
> +	return rc;
> +}
> +
> +void
> +efct_hw_rx_free(struct efct_hw *hw)
> +{
> +	u32 i;
> +
> +	/* Free hw_rq buffers */
> +	for (i = 0; i < hw->hw_rq_count; i++) {
> +		struct hw_rq *rq = hw->hw_rq[i];
> +
> +		if (rq) {
> +			efct_hw_rx_buffer_free(hw, rq->hdr_buf,
> +					       rq->entry_count);
> +			rq->hdr_buf = NULL;
> +			efct_hw_rx_buffer_free(hw, rq->payload_buf,
> +					       rq->entry_count);
> +			rq->payload_buf = NULL;
> +		}
> +	}
> +}
> +
> +static int
> +efct_hw_cmd_submit_pending(struct efct_hw *hw)
> +{
> +	struct efct_command_ctx *ctx = NULL;
> +	int rc = 0;
> +
> +	/* Assumes lock held */
> +
> +	/* Only submit MQE if there's room */
> +	while (hw->cmd_head_count < (EFCT_HW_MQ_DEPTH - 1) &&
> +	       !list_empty(&hw->cmd_pending)) {
> +		ctx = list_first_entry(&hw->cmd_pending,
> +				       struct efct_command_ctx, list_entry);
> +		if (!ctx)
> +			break;
> +
> +		list_del(&ctx->list_entry);
> +
> +		INIT_LIST_HEAD(&ctx->list_entry);
> +		list_add_tail(&ctx->list_entry, &hw->cmd_head);
> +		hw->cmd_head_count++;
> +		if (sli_mq_write(&hw->sli, hw->mq, ctx->buf) < 0) {
> +			efc_log_test(hw->os,
> +				      "sli_queue_write failed: %d\n", rc);
> +			rc = -1;
> +			break;
> +		}
> +	}
> +	return rc;
> +}
> +
> +enum efct_hw_rtn
> +efct_hw_command(struct efct_hw *hw, u8 *cmd, u32 opts, void *cb, void *arg)
> +{
> +	enum efct_hw_rtn rc = EFCT_HW_RTN_ERROR;
> +	unsigned long flags = 0;
> +	void *bmbx = NULL;
> +
> +	/*
> +	 * If the chip is in an error state (UE'd) then reject this mailbox
> +	 *  command.
> +	 */
> +	if (sli_fw_error_status(&hw->sli) > 0) {
> +		efc_log_crit(hw->os,
> +			      "Chip is in an error state - reset needed\n");
> +		efc_log_crit(hw->os,
> +			      "status=%#x error1=%#x error2=%#x\n",
> +			sli_reg_read_status(&hw->sli),
> +			sli_reg_read_err1(&hw->sli),
> +			sli_reg_read_err2(&hw->sli));
> +
> +		return EFCT_HW_RTN_ERROR;
> +	}
> +
> +	/*
> +	 * Send a mailbox command to the hardware, and either wait for
> +	 * a completion (EFCT_CMD_POLL) or get an optional asynchronous
> +	 * completion (EFCT_CMD_NOWAIT).
> +	 */
> +
> +	if (opts == EFCT_CMD_POLL) {
> +		mutex_lock(&hw->bmbx_lock);
> +		bmbx = hw->sli.bmbx.virt;
> +
> +		memset(bmbx, 0, SLI4_BMBX_SIZE);
> +		memcpy(bmbx, cmd, SLI4_BMBX_SIZE);
> +
> +		if (sli_bmbx_command(&hw->sli) == 0) {
> +			rc = EFCT_HW_RTN_SUCCESS;
> +			memcpy(cmd, bmbx, SLI4_BMBX_SIZE);
> +		}
> +		mutex_unlock(&hw->bmbx_lock);
> +	} else if (opts == EFCT_CMD_NOWAIT) {
> +		struct efct_command_ctx	*ctx = NULL;
> +
> +		if (hw->state != EFCT_HW_STATE_ACTIVE) {
> +			efc_log_err(hw->os,
> +				     "Can't send command, HW state=%d\n",
> +				    hw->state);
> +			return EFCT_HW_RTN_ERROR;
> +		}
> +
> +		ctx = mempool_alloc(hw->cmd_ctx_pool, GFP_ATOMIC);
> +		if (!ctx)
> +			return EFCT_HW_RTN_NO_RESOURCES;
> +
> +		memset(ctx, 0, sizeof(struct efct_command_ctx));
> +
> +		if (cb) {
> +			ctx->cb = cb;
> +			ctx->arg = arg;
> +		}
> +
> +		memcpy(ctx->buf, cmd, SLI4_BMBX_SIZE);
> +		ctx->ctx = hw;
> +
> +		spin_lock_irqsave(&hw->cmd_lock, flags);
> +
> +		/* Add to pending list */
> +		INIT_LIST_HEAD(&ctx->list_entry);
> +		list_add_tail(&ctx->list_entry, &hw->cmd_pending);
> +
> +		/* Submit as much of the pending list as we can */
> +		rc = efct_hw_cmd_submit_pending(hw);
> +
> +		spin_unlock_irqrestore(&hw->cmd_lock, flags);
> +	}
> +
> +	return rc;
> +}
> +
> +static int
> +efct_hw_command_process(struct efct_hw *hw, int status, u8 *mqe,
> +			size_t size)
> +{
> +	struct efct_command_ctx *ctx = NULL;
> +	unsigned long flags = 0;
> +
> +	spin_lock_irqsave(&hw->cmd_lock, flags);
> +	if (!list_empty(&hw->cmd_head)) {
> +		ctx = list_first_entry(&hw->cmd_head,
> +				       struct efct_command_ctx, list_entry);
> +		list_del(&ctx->list_entry);
> +	}
> +	if (!ctx) {
> +		efc_log_err(hw->os, "no command context?!?\n");
> +		spin_unlock_irqrestore(&hw->cmd_lock, flags);
> +		return EFC_FAIL;
> +	}
> +
> +	hw->cmd_head_count--;
> +
> +	/* Post any pending requests */
> +	efct_hw_cmd_submit_pending(hw);
> +
> +	spin_unlock_irqrestore(&hw->cmd_lock, flags);
> +
> +	if (ctx->cb) {
> +		if (ctx->buf)
> +			memcpy(ctx->buf, mqe, size);
> +
> +		ctx->cb(hw, status, ctx->buf, ctx->arg);
> +	}
> +
> +	mempool_free(ctx, hw->cmd_ctx_pool);
> +
> +	return EFC_SUCCESS;
> +}
> +
> +static int
> +efct_hw_mq_process(struct efct_hw *hw,
> +		   int status, struct sli4_queue *mq)
> +{
> +	u8 mqe[SLI4_BMBX_SIZE];
> +
> +	if (!sli_mq_read(&hw->sli, mq, mqe))
> +		efct_hw_command_process(hw, status, mqe, mq->size);
> +
> +	return EFC_SUCCESS;
> +}
> +
> +static int
> +efct_hw_command_cancel(struct efct_hw *hw)
> +{
> +	unsigned long flags = 0;
> +
> +	spin_lock_irqsave(&hw->cmd_lock, flags);
> +
> +	/*
> +	 * Manually clean up remaining commands. Note: since this calls
> +	 * efct_hw_command_process(), we'll also process the cmd_pending
> +	 * list, so no need to manually clean that out.
> +	 */
> +	while (!list_empty(&hw->cmd_head)) {
> +		u8		mqe[SLI4_BMBX_SIZE] = { 0 };
> +		struct efct_command_ctx *ctx =
> +	list_first_entry(&hw->cmd_head, struct efct_command_ctx, list_entry);
> +
> +		efc_log_test(hw->os, "hung command %08x\n",
> +			      !ctx ? U32_MAX :
> +			      (!ctx->buf ? U32_MAX :
> +			       *((u32 *)ctx->buf)));
> +		spin_unlock_irqrestore(&hw->cmd_lock, flags);
> +		efct_hw_command_process(hw, -1, mqe, SLI4_BMBX_SIZE);
> +		spin_lock_irqsave(&hw->cmd_lock, flags);
> +	}

Now that is an odd loop.
What is preventing this loop from spinning forever?
IOW, how do you ensure 'hw->cmd_head' is updated on each round?

> +
> +	spin_unlock_irqrestore(&hw->cmd_lock, flags);
> +
> +	return EFC_SUCCESS;
> +}
> +
> +static void
> +efct_mbox_rsp_cb(struct efct_hw *hw, int status, u8 *mqe, void *arg)
> +{
> +	struct efct_mbox_rqst_ctx *ctx = arg;
> +
> +	if (ctx) {
> +		if (ctx->callback)
> +			(*ctx->callback)(hw->os->efcport, status, mqe,
> +					 ctx->arg);
> +
> +		mempool_free(ctx, hw->mbox_rqst_pool);
> +	}
> +}
> +
> +int
> +efct_issue_mbox_rqst(void *base, void *cmd, void *cb, void *arg)
> +{
> +	int rc = 0;
> +	struct efct_mbox_rqst_ctx *ctx;
> +	struct efct *efct = base;
> +	struct efct_hw *hw = &efct->hw;
> +
> +	/*
> +	 * Allocate a callback context (which includes the mbox cmd buffer),
> +	 * we need this to be persistent as the mbox cmd submission may be
> +	 * queued and executed later execution.
> +	 */
> +	ctx = mempool_alloc(hw->mbox_rqst_pool, GFP_ATOMIC);
> +	if (!ctx)
> +		return EFC_FAIL;
> +
> +	ctx->callback = cb;
> +	ctx->arg = arg;
> +
> +	if (efct_hw_command(hw, cmd, EFCT_CMD_NOWAIT, efct_mbox_rsp_cb, ctx)) {
> +		efc_log_err(efct, "issue mbox rqst failure\n");
> +		mempool_free(ctx, hw->mbox_rqst_pool);
> +		rc = -1;
> +	}
> +	return rc;
> +}
> diff --git a/drivers/scsi/elx/efct/efct_hw.h b/drivers/scsi/elx/efct/efct_hw.h
> index 44649d649229..03787da3f4f7 100644
> --- a/drivers/scsi/elx/efct/efct_hw.h
> +++ b/drivers/scsi/elx/efct/efct_hw.h
> @@ -619,4 +619,13 @@ efct_get_wwnn(struct efct_hw *hw);
>   uint64_t
>   efct_get_wwpn(struct efct_hw *hw);
>   
> +enum efct_hw_rtn efct_hw_rx_allocate(struct efct_hw *hw);
> +enum efct_hw_rtn efct_hw_rx_post(struct efct_hw *hw);
> +void efct_hw_rx_free(struct efct_hw *hw);
> +enum efct_hw_rtn
> +efct_hw_command(struct efct_hw *hw, u8 *cmd, u32 opts, void *cb,
> +		void *arg);
> +int
> +efct_issue_mbox_rqst(void *base, void *cmd, void *cb, void *arg);
> +
>   #endif /* __EFCT_H__ */
> 
Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
