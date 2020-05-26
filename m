Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C631C8553
	for <lists+linux-scsi@lfdr.de>; Thu,  7 May 2020 11:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgEGJFg (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 7 May 2020 05:05:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:54894 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbgEGJFg (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 7 May 2020 05:05:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 23C67AD5F;
        Thu,  7 May 2020 09:05:32 +0000 (UTC)
Subject: Re: [PATCH v5 11/11] qla2xxx: Fix endianness annotations in source
 files
To:     Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Nilesh Javali <njavali@marvell.com>,
        Quinn Tran <qutran@marvell.com>,
        Martin Wilck <mwilck@suse.com>,
        Daniel Wagner <dwagner@suse.de>,
        Roman Bolshakov <r.bolshakov@yadro.com>
References: <20200507042835.9135-1-bvanassche@acm.org>
 <20200507042835.9135-12-bvanassche@acm.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <6c52c7a8-6625-69c3-095b-146a300e94a5@suse.de>
Date:   Thu, 7 May 2020 11:05:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200507042835.9135-12-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/7/20 6:28 AM, Bart Van Assche wrote:
> Fix all endianness complaints reported by sparse (C=2) without affecting
> the behavior of the code on little endian CPUs.
> 
> Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
> Cc: Nilesh Javali <njavali@marvell.com>
> Cc: Quinn Tran <qutran@marvell.com>
> Cc: Martin Wilck <mwilck@suse.com>
> Cc: Daniel Wagner <dwagner@suse.de>
> Cc: Roman Bolshakov <r.bolshakov@yadro.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   drivers/scsi/qla2xxx/qla_attr.c   |  3 +-
>   drivers/scsi/qla2xxx/qla_bsg.c    |  4 +-
>   drivers/scsi/qla2xxx/qla_dbg.c    | 90 +++++++++++++++----------------
>   drivers/scsi/qla2xxx/qla_init.c   | 75 +++++++++++++-------------
>   drivers/scsi/qla2xxx/qla_iocb.c   | 57 ++++++++++----------
>   drivers/scsi/qla2xxx/qla_isr.c    | 85 ++++++++++++++---------------
>   drivers/scsi/qla2xxx/qla_mbx.c    | 35 ++++++------
>   drivers/scsi/qla2xxx/qla_mr.c     |  9 ++--
>   drivers/scsi/qla2xxx/qla_nvme.c   |  8 +--
>   drivers/scsi/qla2xxx/qla_nx.c     | 89 +++++++++++++++---------------
>   drivers/scsi/qla2xxx/qla_os.c     | 24 ++++-----
>   drivers/scsi/qla2xxx/qla_sup.c    | 75 ++++++++++++++------------
>   drivers/scsi/qla2xxx/qla_target.c | 74 ++++++++++++-------------
>   drivers/scsi/qla2xxx/qla_tmpl.c   |  4 +-
>   14 files changed, 318 insertions(+), 314 deletions(-)
> 

[ .. ]

> @@ -2679,8 +2680,8 @@ qla24xx_els_logo_iocb(srb_t *sp, struct els_entry_24xx *els_iocb)
>   	els_iocb->sys_define = 0;
>   	els_iocb->entry_status = 0;
>   	els_iocb->handle = sp->handle;
> -	els_iocb->nport_handle = cpu_to_le16(sp->fcport->loop_id);
> -	els_iocb->tx_dsd_count = 1;
> +	els_iocb->nport_handle = sp->fcport->loop_id;
> +	els_iocb->tx_dsd_count = cpu_to_le16(1);
>   	els_iocb->vp_index = vha->vp_idx;
>   	els_iocb->sof_type = EST_SOFI3;
>   	els_iocb->rx_dsd_count = 0;

Why did you drop the cpu_to_le16 for the loop_id?
I was under the impression we'll store it in machine-native format, 
don't we?

> @@ -2700,7 +2701,7 @@ qla24xx_els_logo_iocb(srb_t *sp, struct els_entry_24xx *els_iocb)
>   			cpu_to_le32(sizeof(struct els_plogi_payload));
>   		put_unaligned_le64(elsio->u.els_plogi.els_plogi_pyld_dma,
>   				   &els_iocb->tx_address);
> -		els_iocb->rx_dsd_count = 1;
> +		els_iocb->rx_dsd_count = cpu_to_le16(1);
>   		els_iocb->rx_byte_count = els_iocb->rx_len =
>   			cpu_to_le32(sizeof(struct els_plogi_payload));
>   		put_unaligned_le64(elsio->u.els_plogi.els_resp_pyld_dma,
> @@ -2712,7 +2713,7 @@ qla24xx_els_logo_iocb(srb_t *sp, struct els_entry_24xx *els_iocb)
>   		    (uint8_t *)els_iocb,
>   		    sizeof(*els_iocb));
>   	} else {
> -		els_iocb->control_flags = 1 << 13;
> +		els_iocb->control_flags = cpu_to_le16(1 << 13);
>   		els_iocb->tx_byte_count =
>   			cpu_to_le32(sizeof(struct els_logo_payload));
>   		put_unaligned_le64(elsio->u.els_logo.els_logo_pyld_dma,
> @@ -3022,7 +3023,7 @@ qla24xx_els_iocb(srb_t *sp, struct els_entry_24xx *els_iocb)
>           els_iocb->sys_define = 0;
>           els_iocb->entry_status = 0;
>           els_iocb->handle = sp->handle;
> -        els_iocb->nport_handle = cpu_to_le16(sp->fcport->loop_id);
> +	els_iocb->nport_handle = sp->fcport->loop_id;
>   	els_iocb->tx_dsd_count = cpu_to_le16(bsg_job->request_payload.sg_cnt);
>   	els_iocb->vp_index = sp->vha->vp_idx;
>           els_iocb->sof_type = EST_SOFI3;

Same here.

> @@ -3216,7 +3217,7 @@ qla82xx_start_scsi(srb_t *sp)
>   	uint16_t	tot_dsds;
>   	struct device_reg_82xx __iomem *reg;
>   	uint32_t dbval;
> -	uint32_t *fcp_dl;
> +	__be32 *fcp_dl;
>   	uint8_t additional_cdb_len;
>   	struct ct6_dsd *ctx;
>   	struct scsi_qla_host *vha = sp->vha;
> @@ -3398,7 +3399,7 @@ qla82xx_start_scsi(srb_t *sp)
>   
>   		memcpy(ctx->fcp_cmnd->cdb, cmd->cmnd, cmd->cmd_len);
>   
> -		fcp_dl = (uint32_t *)(ctx->fcp_cmnd->cdb + 16 +
> +		fcp_dl = (__be32 *)(ctx->fcp_cmnd->cdb + 16 +
>   		    additional_cdb_len);
>   		*fcp_dl = htonl((uint32_t)scsi_bufflen(cmd));
>   
> @@ -3536,7 +3537,7 @@ qla24xx_abort_iocb(srb_t *sp, struct abort_entry_24xx *abt_iocb)
>   	memset(abt_iocb, 0, sizeof(struct abort_entry_24xx));
>   	abt_iocb->entry_type = ABORT_IOCB_TYPE;
>   	abt_iocb->entry_count = 1;
> -	abt_iocb->handle = cpu_to_le32(make_handle(req->id, sp->handle));
> +	abt_iocb->handle = make_handle(req->id, sp->handle);
>   	if (sp->fcport) {
>   		abt_iocb->nport_handle = cpu_to_le16(sp->fcport->loop_id);
>   		abt_iocb->port_id[0] = sp->fcport->d_id.b.al_pa;
> @@ -3544,10 +3545,10 @@ qla24xx_abort_iocb(srb_t *sp, struct abort_entry_24xx *abt_iocb)
>   		abt_iocb->port_id[2] = sp->fcport->d_id.b.domain;
>   	}
>   	abt_iocb->handle_to_abort =
> -	    cpu_to_le32(make_handle(aio->u.abt.req_que_no,
> -				    aio->u.abt.cmd_hndl));
> +		make_handle(le16_to_cpu(aio->u.abt.req_que_no),
> +			    aio->u.abt.cmd_hndl);
>   	abt_iocb->vp_index = vha->vp_idx;
> -	abt_iocb->req_que_no = cpu_to_le16(aio->u.abt.req_que_no);
> +	abt_iocb->req_que_no = aio->u.abt.req_que_no;
>   	/* Send the command to the firmware */
>   	wmb();
>   }
> @@ -3562,7 +3563,7 @@ qla2x00_mb_iocb(srb_t *sp, struct mbx_24xx_entry *mbx)
>   	sz = min(ARRAY_SIZE(mbx->mb), ARRAY_SIZE(sp->u.iocb_cmd.u.mbx.out_mb));
>   
>   	for (i = 0; i < sz; i++)
> -		mbx->mb[i] = cpu_to_le16(sp->u.iocb_cmd.u.mbx.out_mb[i]);
> +		mbx->mb[i] = sp->u.iocb_cmd.u.mbx.out_mb[i];
>   }
>   
>   static void
> @@ -3586,7 +3587,7 @@ static void qla2x00_send_notify_ack_iocb(srb_t *sp,
>   	nack->u.isp24.nport_handle = ntfy->u.isp24.nport_handle;
>   	if (le16_to_cpu(ntfy->u.isp24.status) == IMM_NTFY_ELS) {
>   		nack->u.isp24.flags = ntfy->u.isp24.flags &
> -			cpu_to_le32(NOTIFY24XX_FLAGS_PUREX_IOCB);
> +			cpu_to_le16(NOTIFY24XX_FLAGS_PUREX_IOCB);
>   	}
>   	nack->u.isp24.srr_rx_id = ntfy->u.isp24.srr_rx_id;
>   	nack->u.isp24.status = ntfy->u.isp24.status;
> @@ -3613,20 +3614,20 @@ qla_nvme_ls(srb_t *sp, struct pt_ls4_request *cmd_pkt)
>   	nvme = &sp->u.iocb_cmd;
>   	cmd_pkt->entry_type = PT_LS4_REQUEST;
>   	cmd_pkt->entry_count = 1;
> -	cmd_pkt->control_flags = CF_LS4_ORIGINATOR << CF_LS4_SHIFT;
> +	cmd_pkt->control_flags = cpu_to_le16(CF_LS4_ORIGINATOR << CF_LS4_SHIFT);
>   
>   	cmd_pkt->timeout = cpu_to_le16(nvme->u.nvme.timeout_sec);
>   	cmd_pkt->nport_handle = cpu_to_le16(sp->fcport->loop_id);
>   	cmd_pkt->vp_index = sp->fcport->vha->vp_idx;
>   
> -	cmd_pkt->tx_dseg_count = 1;
> -	cmd_pkt->tx_byte_count = nvme->u.nvme.cmd_len;
> -	cmd_pkt->dsd[0].length = nvme->u.nvme.cmd_len;
> +	cmd_pkt->tx_dseg_count = cpu_to_le16(1);
> +	cmd_pkt->tx_byte_count = cpu_to_le32(nvme->u.nvme.cmd_len);
> +	cmd_pkt->dsd[0].length = cpu_to_le32(nvme->u.nvme.cmd_len);
>   	put_unaligned_le64(nvme->u.nvme.cmd_dma, &cmd_pkt->dsd[0].address);
>    > -	cmd_pkt->rx_dseg_count = 1;
> -	cmd_pkt->rx_byte_count = nvme->u.nvme.rsp_len;
> -	cmd_pkt->dsd[1].length  = nvme->u.nvme.rsp_len;
> +	cmd_pkt->rx_dseg_count = cpu_to_le16(1);
> +	cmd_pkt->rx_byte_count = cpu_to_le32(nvme->u.nvme.rsp_len);
> +	cmd_pkt->dsd[1].length = cpu_to_le32(nvme->u.nvme.rsp_len);
>   	put_unaligned_le64(nvme->u.nvme.rsp_dma, &cmd_pkt->dsd[1].address);
>   
>   	return rval;
> diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
> index 5f764cfc67ec..147fab38f144 100644
> --- a/drivers/scsi/qla2xxx/qla_isr.c
> +++ b/drivers/scsi/qla2xxx/qla_isr.c
> @@ -92,7 +92,7 @@ qla24xx_process_abts(struct scsi_qla_host *vha, void *pkt)
>   	rsp_els->entry_count = 1;
>   	rsp_els->nport_handle = ~0;
>   	rsp_els->rx_xchg_address = abts->rx_xch_addr_to_abort;
> -	rsp_els->control_flags = EPD_RX_XCHG;
> +	rsp_els->control_flags = cpu_to_le16(EPD_RX_XCHG);
>   	ql_dbg(ql_dbg_init, vha, 0x0283,
>   	    "Sending ELS Response to terminate exchange %#x...\n",
>   	    abts->rx_xch_addr_to_abort);
> @@ -142,7 +142,7 @@ qla24xx_process_abts(struct scsi_qla_host *vha, void *pkt)
>   	abts_rsp->ox_id = abts->ox_id;
>   	abts_rsp->payload.ba_acc.aborted_rx_id = abts->rx_id;
>   	abts_rsp->payload.ba_acc.aborted_ox_id = abts->ox_id;
> -	abts_rsp->payload.ba_acc.high_seq_cnt = ~0;
> +	abts_rsp->payload.ba_acc.high_seq_cnt = cpu_to_le16(~0);
>   	abts_rsp->rx_xch_addr_to_abort = abts->rx_xch_addr_to_abort;
>   	ql_dbg(ql_dbg_init, vha, 0x028b,
>   	    "Sending BA ACC response to ABTS %#x...\n",
> @@ -413,7 +413,7 @@ qla2x00_mbx_completion(scsi_qla_host_t *vha, uint16_t mb0)
>   {
>   	uint16_t	cnt;
>   	uint32_t	mboxes;
> -	uint16_t __iomem *wptr;
> +	__le16 __iomem *wptr;
>   	struct qla_hw_data *ha = vha->hw;
>   	struct device_reg_2xxx __iomem *reg = &ha->iobase->isp;
>   
> @@ -429,11 +429,11 @@ qla2x00_mbx_completion(scsi_qla_host_t *vha, uint16_t mb0)
>   	ha->flags.mbox_int = 1;
>   	ha->mailbox_out[0] = mb0;
>   	mboxes >>= 1;
> -	wptr = (uint16_t __iomem *)MAILBOX_REG(ha, reg, 1);
> +	wptr = MAILBOX_REG(ha, reg, 1);
>   
>   	for (cnt = 1; cnt < ha->mbx_count; cnt++) {
>   		if (IS_QLA2200(ha) && cnt == 8)
> -			wptr = (uint16_t __iomem *)MAILBOX_REG(ha, reg, 8);
> +			wptr = MAILBOX_REG(ha, reg, 8);
>   		if ((cnt == 4 || cnt == 5) && (mboxes & BIT_0))
>   			ha->mailbox_out[cnt] = qla2x00_debounce_register(wptr);
>   		else if (mboxes & BIT_0)
> @@ -457,9 +457,9 @@ qla81xx_idc_event(scsi_qla_host_t *vha, uint16_t aen, uint16_t descr)
>   
>   	/* Seed data -- mailbox1 -> mailbox7. */
>   	if (IS_QLA81XX(vha->hw) || IS_QLA83XX(vha->hw))
> -		wptr = (uint16_t __iomem *)&reg24->mailbox1;
> +		wptr = &reg24->mailbox1;
>   	else if (IS_QLA8044(vha->hw))
> -		wptr = (uint16_t __iomem *)&reg82->mailbox_out[1];
> +		wptr = &reg82->mailbox_out[1];
>   	else
>   		return;
>   
> @@ -819,7 +819,7 @@ qla2x00_async_event(scsi_qla_host_t *vha, struct rsp_que *rsp, uint16_t *mb)
>   		goto skip_rio;
>   	switch (mb[0]) {
>   	case MBA_SCSI_COMPLETION:
> -		handles[0] = le32_to_cpu((uint32_t)((mb[2] << 16) | mb[1]));
> +		handles[0] = make_handle(mb[2], mb[1]);
>   		handle_cnt = 1;
>   		break;
>   	case MBA_CMPLT_1_16BIT:
> @@ -858,10 +858,9 @@ qla2x00_async_event(scsi_qla_host_t *vha, struct rsp_que *rsp, uint16_t *mb)
>   		mb[0] = MBA_SCSI_COMPLETION;
>   		break;
>   	case MBA_CMPLT_2_32BIT:
> -		handles[0] = le32_to_cpu((uint32_t)((mb[2] << 16) | mb[1]));
> -		handles[1] = le32_to_cpu(
> -		    ((uint32_t)(RD_MAILBOX_REG(ha, reg, 7) << 16)) |
> -		    RD_MAILBOX_REG(ha, reg, 6));
> +		handles[0] = make_handle(mb[2], mb[1]);
> +		handles[1] = make_handle(RD_MAILBOX_REG(ha, reg, 7),
> +					 RD_MAILBOX_REG(ha, reg, 6));
>   		handle_cnt = 2;
>   		mb[0] = MBA_SCSI_COMPLETION;
>   		break;
> @@ -1667,7 +1666,7 @@ qla24xx_mbx_iocb_entry(scsi_qla_host_t *vha, struct req_que *req,
>   	sz = min(ARRAY_SIZE(pkt->mb), ARRAY_SIZE(sp->u.iocb_cmd.u.mbx.in_mb));
>   
>   	for (i = 0; i < sz; i++)
> -		si->u.mbx.in_mb[i] = le16_to_cpu(pkt->mb[i]);
> +		si->u.mbx.in_mb[i] = pkt->mb[i];
>   
>   	res = (si->u.mbx.in_mb[0] & MBS_MASK);
>   
> @@ -1768,6 +1767,7 @@ static void
>   qla24xx_els_ct_entry(scsi_qla_host_t *vha, struct req_que *req,
>       struct sts_entry_24xx *pkt, int iocb_type)
>   {
> +	struct els_sts_entry_24xx *ese = (struct els_sts_entry_24xx *)pkt;
>   	const char func[] = "ELS_CT_IOCB";
>   	const char *type;
>   	srb_t *sp;
> @@ -1817,23 +1817,22 @@ qla24xx_els_ct_entry(scsi_qla_host_t *vha, struct req_que *req,
>   	}
>   
>   	comp_status = fw_status[0] = le16_to_cpu(pkt->comp_status);
> -	fw_status[1] = le16_to_cpu(((struct els_sts_entry_24xx *)pkt)->error_subcode_1);
> -	fw_status[2] = le16_to_cpu(((struct els_sts_entry_24xx *)pkt)->error_subcode_2);
> +	fw_status[1] = le32_to_cpu(ese->error_subcode_1);
> +	fw_status[2] = le32_to_cpu(ese->error_subcode_2);
>   
>   	if (iocb_type == ELS_IOCB_TYPE) {
>   		els = &sp->u.iocb_cmd;
>   		els->u.els_plogi.fw_status[0] = fw_status[0];
>   		els->u.els_plogi.fw_status[1] = fw_status[1];
>   		els->u.els_plogi.fw_status[2] = fw_status[2];
> -		els->u.els_plogi.comp_status = fw_status[0];
> +		els->u.els_plogi.comp_status = cpu_to_le16(fw_status[0]);

???
Why only this line?
fw_status is kept in host-endianness; shouldn't all of the above 
assignments being done with cpu_to_le16?

>   		if (comp_status == CS_COMPLETE) {
>   			res =  DID_OK << 16;
>   		} else {
>   			if (comp_status == CS_DATA_UNDERRUN) {
>   				res =  DID_OK << 16;
> -				els->u.els_plogi.len =
> -				le16_to_cpu(((struct els_sts_entry_24xx *)
> -					pkt)->total_byte_count);
> +				els->u.els_plogi.len = cpu_to_le16(le32_to_cpu(
> +					ese->total_byte_count));
>   			} else {
>   				els->u.els_plogi.len = 0;
>   				res = DID_ERROR << 16;
> @@ -1842,8 +1841,7 @@ qla24xx_els_ct_entry(scsi_qla_host_t *vha, struct req_que *req,
>   		ql_dbg(ql_dbg_user, vha, 0x503f,
>   		    "ELS IOCB Done -%s error hdl=%x comp_status=0x%x error subcode 1=0x%x error subcode 2=0x%x total_byte=0x%x\n",
>   		    type, sp->handle, comp_status, fw_status[1], fw_status[2],
> -		    le16_to_cpu(((struct els_sts_entry_24xx *)
> -			pkt)->total_byte_count));
> +		    le32_to_cpu(ese->total_byte_count));
>   		goto els_ct_done;
>   	}
>   

Switch from 16 to 32 bits?

> @@ -1859,23 +1857,20 @@ qla24xx_els_ct_entry(scsi_qla_host_t *vha, struct req_que *req,
>   		if (comp_status == CS_DATA_UNDERRUN) {
>   			res = DID_OK << 16;
>   			bsg_reply->reply_payload_rcv_len =
> -			    le16_to_cpu(((struct els_sts_entry_24xx *)pkt)->total_byte_count);
> +				le32_to_cpu(ese->total_byte_count);
>   
>   			ql_dbg(ql_dbg_user, vha, 0x503f,
>   			    "ELS-CT pass-through-%s error hdl=%x comp_status-status=0x%x "
>   			    "error subcode 1=0x%x error subcode 2=0x%x total_byte = 0x%x.\n",
>   			    type, sp->handle, comp_status, fw_status[1], fw_status[2],
> -			    le16_to_cpu(((struct els_sts_entry_24xx *)
> -				pkt)->total_byte_count));
> +			    le32_to_cpu(ese->total_byte_count));
>   		} else {
>   			ql_dbg(ql_dbg_user, vha, 0x5040,
>   			    "ELS-CT pass-through-%s error hdl=%x comp_status-status=0x%x "
>   			    "error subcode 1=0x%x error subcode 2=0x%x.\n",
>   			    type, sp->handle, comp_status,
> -			    le16_to_cpu(((struct els_sts_entry_24xx *)
> -				pkt)->error_subcode_1),
> -			    le16_to_cpu(((struct els_sts_entry_24xx *)
> -				    pkt)->error_subcode_2));
> +			    le32_to_cpu(ese->error_subcode_1),
> +			    le32_to_cpu(ese->error_subcode_2));
>   			res = DID_ERROR << 16;
>   			bsg_reply->reply_payload_rcv_len = 0;
>   		}

Same here.

> @@ -2083,7 +2078,7 @@ static void qla24xx_nvme_iocb_entry(scsi_qla_host_t *vha, struct req_que *req,
>   	uint16_t        state_flags;
>   	struct nvmefc_fcp_req *fd;
>   	uint16_t        ret = QLA_SUCCESS;
> -	uint16_t	comp_status = le16_to_cpu(sts->comp_status);
> +	__le16		comp_status = sts->comp_status;
>   	int		logit = 0;
>   
>   	iocb = &sp->u.iocb_cmd;
> @@ -2114,7 +2109,7 @@ static void qla24xx_nvme_iocb_entry(scsi_qla_host_t *vha, struct req_que *req,
>   	} else if ((state_flags & (SF_FCP_RSP_DMA | SF_NVME_ERSP)) ==
>   			(SF_FCP_RSP_DMA | SF_NVME_ERSP)) {
>   		/* Response already DMA'd to fd->rspaddr. */
> -		iocb->u.nvme.rsp_pyld_len = le16_to_cpu(sts->nvme_rsp_pyld_len);
> +		iocb->u.nvme.rsp_pyld_len = sts->nvme_rsp_pyld_len;
>   	} else if ((state_flags & SF_FCP_RSP_DMA)) {
>   		/*
>   		 * Non-zero value in first 12 bytes of NVMe_RSP IU, treat this
> @@ -2131,8 +2126,8 @@ static void qla24xx_nvme_iocb_entry(scsi_qla_host_t *vha, struct req_que *req,
>   
>   		inbuf = (uint32_t *)&sts->nvme_ersp_data;
>   		outbuf = (uint32_t *)fd->rspaddr;
> -		iocb->u.nvme.rsp_pyld_len = le16_to_cpu(sts->nvme_rsp_pyld_len);
> -		if (unlikely(iocb->u.nvme.rsp_pyld_len >
> +		iocb->u.nvme.rsp_pyld_len = sts->nvme_rsp_pyld_len;
> +		if (unlikely(le16_to_cpu(iocb->u.nvme.rsp_pyld_len) >
>   		    sizeof(struct nvme_fc_ersp_iu))) {
>   			if (ql_mask_match(ql_dbg_io)) {
>   				WARN_ONCE(1, "Unexpected response payload length %u.\n",
> @@ -2142,9 +2137,9 @@ static void qla24xx_nvme_iocb_entry(scsi_qla_host_t *vha, struct req_que *req,
>   				    iocb->u.nvme.rsp_pyld_len);
>   			}
>   			iocb->u.nvme.rsp_pyld_len =
> -			    sizeof(struct nvme_fc_ersp_iu);
> +				cpu_to_le16(sizeof(struct nvme_fc_ersp_iu));
>   		}
> -		iter = iocb->u.nvme.rsp_pyld_len >> 2;
> +		iter = le16_to_cpu(iocb->u.nvme.rsp_pyld_len) >> 2;
>   		for (; iter; iter--)
>   			*outbuf++ = swab32(*inbuf++);
>   	}
> @@ -2159,7 +2154,7 @@ static void qla24xx_nvme_iocb_entry(scsi_qla_host_t *vha, struct req_que *req,
>   				"Dropped frame(s) detected (sent/rcvd=%u/%u).\n",
>   				tgt_xfer_len, fd->transferred_length);
>   			logit = 1;
> -		} else if (comp_status == CS_DATA_UNDERRUN) {
> +		} else if (le16_to_cpu(comp_status) == CS_DATA_UNDERRUN) {
>   			/*
>   			 * Do not log if this is just an underflow and there
>   			 * is no data loss.
> @@ -2179,7 +2174,7 @@ static void qla24xx_nvme_iocb_entry(scsi_qla_host_t *vha, struct req_que *req,
>   	 * If transport error then Failure (HBA rejects request)
>   	 * otherwise transport will handle.
>   	 */
> -	switch (comp_status) {
> +	switch (le16_to_cpu(comp_status)) {
>   	case CS_COMPLETE:
>   		break;
>   
> @@ -2412,9 +2407,9 @@ qla2x00_handle_dif_error(srb_t *sp, struct sts_entry_24xx *sts24)
>   	 * For type     3: ref & app tag is all 'f's
>   	 * For type 0,1,2: app tag is all 'f's
>   	 */
> -	if ((a_app_tag == T10_PI_APP_ESCAPE) &&
> -	    ((scsi_get_prot_type(cmd) != SCSI_PROT_DIF_TYPE3) ||
> -	     (a_ref_tag == T10_PI_REF_ESCAPE))) {
> +	if (a_app_tag == be16_to_cpu(T10_PI_APP_ESCAPE) &&
> +	    (scsi_get_prot_type(cmd) != SCSI_PROT_DIF_TYPE3 ||
> +	     a_ref_tag == be32_to_cpu(T10_PI_REF_ESCAPE))) {
>   		uint32_t blocks_done, resid;
>   		sector_t lba_s = scsi_get_lba(cmd);
>   
> @@ -2772,6 +2767,8 @@ qla2x00_status_entry(scsi_qla_host_t *vha, struct rsp_que *rsp, void *pkt)
>   	sense_len = par_sense_len = rsp_info_len = resid_len =
>   	    fw_resid_len = 0;
>   	if (IS_FWI2_CAPABLE(ha)) {
> +		u16 sts24_retry_delay = le16_to_cpu(sts24->retry_delay);
> +
>   		if (scsi_status & SS_SENSE_LEN_VALID)
>   			sense_len = le32_to_cpu(sts24->sense_len);
>   		if (scsi_status & SS_RESPONSE_INFO_LEN_VALID)
> @@ -2786,11 +2783,11 @@ qla2x00_status_entry(scsi_qla_host_t *vha, struct rsp_que *rsp, void *pkt)
>   		ox_id = le16_to_cpu(sts24->ox_id);
>   		par_sense_len = sizeof(sts24->data);
>   		/* Valid values of the retry delay timer are 0x1-0xffef */
> -		if (sts24->retry_delay > 0 && sts24->retry_delay < 0xfff1) {
> -			retry_delay = sts24->retry_delay & 0x3fff;
> +		if (sts24_retry_delay > 0 && sts24_retry_delay < 0xfff1) {
> +			retry_delay = sts24_retry_delay & 0x3fff;
>   			ql_dbg(ql_dbg_io, sp->vha, 0x3033,
>   			    "%s: scope=%#x retry_delay=%#x\n", __func__,
> -			    sts24->retry_delay >> 14, retry_delay);
> +			    sts24_retry_delay >> 14, retry_delay);
>   		}
>   	} else {
>   		if (scsi_status & SS_SENSE_LEN_VALID)
> @@ -3180,7 +3177,7 @@ qla24xx_mbx_completion(scsi_qla_host_t *vha, uint16_t mb0)
>   	ha->flags.mbox_int = 1;
>   	ha->mailbox_out[0] = mb0;
>   	mboxes >>= 1;
> -	wptr = (uint16_t __iomem *)&reg->mailbox1;
> +	wptr = &reg->mailbox1;
>   
>   	for (cnt = 1; cnt < ha->mbx_count; cnt++) {
>   		if (mboxes & BIT_0)
> @@ -3204,7 +3201,7 @@ qla24xx_abort_iocb_entry(scsi_qla_host_t *vha, struct req_que *req,
>   		return;
>   
>   	abt = &sp->u.iocb_cmd;
> -	abt->u.abt.comp_status = le16_to_cpu(pkt->nport_handle);
> +	abt->u.abt.comp_status = pkt->nport_handle;
>   	sp->done(sp, 0);
>   }
>   
> diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mbx.c
> index 6487b021356a..451d88733fd5 100644
> --- a/drivers/scsi/qla2xxx/qla_mbx.c
> +++ b/drivers/scsi/qla2xxx/qla_mbx.c
> @@ -208,11 +208,11 @@ qla2x00_mailbox_command(scsi_qla_host_t *vha, mbx_cmd_t *mcp)
>   
>   	/* Load mailbox registers. */
>   	if (IS_P3P_TYPE(ha))
> -		optr = (uint16_t __iomem *)&reg->isp82.mailbox_in[0];
> +		optr = &reg->isp82.mailbox_in[0];
>   	else if (IS_FWI2_CAPABLE(ha) && !(IS_P3P_TYPE(ha)))
> -		optr = (uint16_t __iomem *)&reg->isp24.mailbox0;
> +		optr = &reg->isp24.mailbox0;
>   	else
> -		optr = (uint16_t __iomem *)MAILBOX_REG(ha, &reg->isp, 0);
> +		optr = MAILBOX_REG(ha, &reg->isp, 0);
>   
>   	iptr = mcp->mb;
>   	command = mcp->mb[0];
> @@ -222,8 +222,7 @@ qla2x00_mailbox_command(scsi_qla_host_t *vha, mbx_cmd_t *mcp)
>   	    "Mailbox registers (OUT):\n");
>   	for (cnt = 0; cnt < ha->mbx_count; cnt++) {
>   		if (IS_QLA2200(ha) && cnt == 8)
> -			optr =
> -			    (uint16_t __iomem *)MAILBOX_REG(ha, &reg->isp, 8);
> +			optr = MAILBOX_REG(ha, &reg->isp, 8);
>   		if (mboxes & BIT_0) {
>   			ql_dbg(ql_dbg_mbx, vha, 0x1112,
>   			    "mbox[%d]<-0x%04x\n", cnt, *iptr);
> @@ -3110,8 +3109,8 @@ qla24xx_get_isp_stats(scsi_qla_host_t *vha, struct link_statistics *stats,
>   	mc.mb[6] = MSW(MSD(stats_dma));
>   	mc.mb[7] = LSW(MSD(stats_dma));
>   	mc.mb[8] = dwords;
> -	mc.mb[9] = cpu_to_le16(vha->vp_idx);
> -	mc.mb[10] = cpu_to_le16(options);
> +	mc.mb[9] = vha->vp_idx;
> +	mc.mb[10] = options;
>   
>   	rval = qla24xx_send_mb_cmd(vha, &mc);
>   

Why has the converstion been dropped here?
'vp_idx' surely is in machine-native endianness?

> @@ -3204,7 +3203,7 @@ qla24xx_abort_command(srb_t *sp)
>   		ql_dbg(ql_dbg_mbx, vha, 0x1090,
>   		    "Failed to complete IOCB -- completion status (%x).\n",
>   		    le16_to_cpu(abt->nport_handle));
> -		if (abt->nport_handle == CS_IOCB_ERROR)
> +		if (abt->nport_handle == cpu_to_le16(CS_IOCB_ERROR))
>   			rval = QLA_FUNCTION_PARAMETER_ERROR;
>   		else
>   			rval = QLA_FUNCTION_FAILED;
> @@ -4727,7 +4726,7 @@ qla82xx_set_driver_version(scsi_qla_host_t *vha, char *version)
>   	mbx_cmd_t *mcp = &mc;
>   	int i;
>   	int len;
> -	uint16_t *str;
> +	__le16 *str;
>   	struct qla_hw_data *ha = vha->hw;
>   
>   	if (!IS_P3P_TYPE(ha))
> @@ -4743,7 +4742,7 @@ qla82xx_set_driver_version(scsi_qla_host_t *vha, char *version)
>   	mcp->mb[1] = RNID_TYPE_SET_VERSION << 8;
>   	mcp->out_mb = MBX_1|MBX_0;
>   	for (i = 4; i < 16 && len; i++, str++, len -= 2) {
> -		mcp->mb[i] = cpu_to_le16p(str);
> +		mcp->mb[i] = le16_to_cpup(str);
>   		mcp->out_mb |= 1<<i;
>   	}
>   	for (; i < 16; i++) {

That looks _soo_ wrong.
The mailbox is most likely in firmware/HBA endianness, so why the 
conversion?

> @@ -4861,7 +4860,7 @@ qla24xx_get_port_login_templ(scsi_qla_host_t *vha, dma_addr_t buf_dma,
>   		    "Done %s.\n", __func__);
>   		bp = (uint32_t *) buf;
>   		for (i = 0; i < (bufsiz-4)/4; i++, bp++)
> -			*bp = le32_to_cpu(*bp);
> +			*bp = le32_to_cpu((__force __le32)*bp);
>   	}
>   
>   	return rval;
> @@ -6472,13 +6471,13 @@ int qla24xx_gpdb_wait(struct scsi_qla_host *vha, fc_port_t *fcport, u8 opt)
>   
>   	memset(&mc, 0, sizeof(mc));
>   	mc.mb[0] = MBC_GET_PORT_DATABASE;
> -	mc.mb[1] = cpu_to_le16(fcport->loop_id);
> +	mc.mb[1] = fcport->loop_id;
>   	mc.mb[2] = MSW(pd_dma);
>   	mc.mb[3] = LSW(pd_dma);
>   	mc.mb[6] = MSW(MSD(pd_dma));
>   	mc.mb[7] = LSW(MSD(pd_dma));
> -	mc.mb[9] = cpu_to_le16(vha->vp_idx);
> -	mc.mb[10] = cpu_to_le16((uint16_t)opt);
> +	mc.mb[9] = vha->vp_idx;
> +	mc.mb[10] = opt;
>   
>   	rval = qla24xx_send_mb_cmd(vha, &mc);
>   	if (rval != QLA_SUCCESS) {

Same thing here with vp_idx and loop_id

> @@ -6589,7 +6588,7 @@ int qla24xx_gidlist_wait(struct scsi_qla_host *vha,
>   	mc.mb[6] = MSW(MSD(id_list_dma));
>   	mc.mb[7] = LSW(MSD(id_list_dma));
>   	mc.mb[8] = 0;
> -	mc.mb[9] = cpu_to_le16(vha->vp_idx);
> +	mc.mb[9] = vha->vp_idx;
>   
>   	rval = qla24xx_send_mb_cmd(vha, &mc);
>   	if (rval != QLA_SUCCESS) {
> @@ -6615,8 +6614,8 @@ int qla27xx_set_zio_threshold(scsi_qla_host_t *vha, uint16_t value)
>   
>   	memset(mcp->mb, 0 , sizeof(mcp->mb));
>   	mcp->mb[0] = MBC_GET_SET_ZIO_THRESHOLD;
> -	mcp->mb[1] = cpu_to_le16(1);
> -	mcp->mb[2] = cpu_to_le16(value);
> +	mcp->mb[1] = 1;
> +	mcp->mb[2] = value;
>   	mcp->out_mb = MBX_2 | MBX_1 | MBX_0;
>   	mcp->in_mb = MBX_2 | MBX_0;
>   	mcp->tov = MBX_TOV_SECONDS;

I'm reasonably sure that these conversions need to stay.

> @@ -6641,7 +6640,7 @@ int qla27xx_get_zio_threshold(scsi_qla_host_t *vha, uint16_t *value)
>   
>   	memset(mcp->mb, 0, sizeof(mcp->mb));
>   	mcp->mb[0] = MBC_GET_SET_ZIO_THRESHOLD;
> -	mcp->mb[1] = cpu_to_le16(0);
> +	mcp->mb[1] = 0;
>   	mcp->out_mb = MBX_1 | MBX_0;
>   	mcp->in_mb = MBX_2 | MBX_0;
>   	mcp->tov = MBX_TOV_SECONDS;

Same here.

> diff --git a/drivers/scsi/qla2xxx/qla_mr.c b/drivers/scsi/qla2xxx/qla_mr.c
> index 238088176f41..b791226f4e1f 100644
> --- a/drivers/scsi/qla2xxx/qla_mr.c
> +++ b/drivers/scsi/qla2xxx/qla_mr.c
> @@ -3205,7 +3205,7 @@ qlafx00_tm_iocb(srb_t *sp, struct tsk_mgmt_entry_fx00 *ptm_iocb)
>   	memset(&tm_iocb, 0, sizeof(struct tsk_mgmt_entry_fx00));
>   	tm_iocb.entry_type = TSK_MGMT_IOCB_TYPE_FX00;
>   	tm_iocb.entry_count = 1;
> -	tm_iocb.handle = cpu_to_le32(make_handle(req->id, sp->handle));
> +	tm_iocb.handle = make_handle(req->id, sp->handle);
>   	tm_iocb.reserved_0 = 0;
>   	tm_iocb.tgt_id = cpu_to_le16(sp->fcport->tgt_id);
>   	tm_iocb.control_flags = cpu_to_le32(fxio->u.tmf.flags);
> @@ -3231,9 +3231,8 @@ qlafx00_abort_iocb(srb_t *sp, struct abort_iocb_entry_fx00 *pabt_iocb)
>   	memset(&abt_iocb, 0, sizeof(struct abort_iocb_entry_fx00));
>   	abt_iocb.entry_type = ABORT_IOCB_TYPE_FX00;
>   	abt_iocb.entry_count = 1;
> -	abt_iocb.handle = cpu_to_le32(make_handle(req->id, sp->handle));
> -	abt_iocb.abort_handle =
> -	    cpu_to_le32(make_handle(req->id, fxio->u.abt.cmd_hndl));
> +	abt_iocb.handle = make_handle(req->id, sp->handle);
> +	abt_iocb.abort_handle = make_handle(req->id, fxio->u.abt.cmd_hndl);
>   	abt_iocb.tgt_id_sts = cpu_to_le16(sp->fcport->tgt_id);
>   	abt_iocb.req_que_no = cpu_to_le16(req->id);
>   
> @@ -3254,7 +3253,7 @@ qlafx00_fxdisc_iocb(srb_t *sp, struct fxdisc_entry_fx00 *pfxiocb)
>   
>   	memset(&fx_iocb, 0, sizeof(struct fxdisc_entry_fx00));
>   	fx_iocb.entry_type = FX00_IOCB_TYPE;
> -	fx_iocb.handle = cpu_to_le32(sp->handle);
> +	fx_iocb.handle = sp->handle;
>   	fx_iocb.entry_count = entry_cnt;
>   
>   	if (sp->type == SRB_FXIOCB_DCMD) {
> diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
> index ad3aa1947e7d..bdb62bffbe8c 100644
> --- a/drivers/scsi/qla2xxx/qla_nvme.c
> +++ b/drivers/scsi/qla2xxx/qla_nvme.c
> @@ -138,7 +138,7 @@ static void qla_nvme_release_fcp_cmd_kref(struct kref *kref)
>   	priv->sp = NULL;
>   	sp->priv = NULL;
>   	if (priv->comp_status == QLA_SUCCESS) {
> -		fd->rcv_rsplen = nvme->u.nvme.rsp_pyld_len;
> +		fd->rcv_rsplen = le16_to_cpu(nvme->u.nvme.rsp_pyld_len);
>   	} else {
>   		fd->rcv_rsplen = 0;
>   		fd->transferred_length = 0;
> @@ -426,11 +426,11 @@ static inline int qla2x00_start_nvme_mq(srb_t *sp)
>   
>   	/* No data transfer how do we check buffer len == 0?? */
>   	if (fd->io_dir == NVMEFC_FCP_READ) {
> -		cmd_pkt->control_flags = CF_READ_DATA;
> +		cmd_pkt->control_flags = cpu_to_le16(CF_READ_DATA);
>   		vha->qla_stats.input_bytes += fd->payload_length;
>   		vha->qla_stats.input_requests++;
>   	} else if (fd->io_dir == NVMEFC_FCP_WRITE) {
> -		cmd_pkt->control_flags = CF_WRITE_DATA;
> +		cmd_pkt->control_flags = cpu_to_le16(CF_WRITE_DATA);
>   		if ((vha->flags.nvme_first_burst) &&
>   		    (sp->fcport->nvme_prli_service_param &
>   			NVME_PRLI_SP_FIRST_BURST)) {
> @@ -438,7 +438,7 @@ static inline int qla2x00_start_nvme_mq(srb_t *sp)
>   			    sp->fcport->nvme_first_burst_size) ||
>   				(sp->fcport->nvme_first_burst_size == 0))
>   				cmd_pkt->control_flags |=
> -				    CF_NVME_FIRST_BURST_ENABLE;
> +					cpu_to_le16(CF_NVME_FIRST_BURST_ENABLE);
>   		}
>   		vha->qla_stats.output_bytes += fd->payload_length;
>   		vha->qla_stats.output_requests++;
> diff --git a/drivers/scsi/qla2xxx/qla_nx.c b/drivers/scsi/qla2xxx/qla_nx.c
> index 8c17864ca5b2..df13d77fa582 100644
> --- a/drivers/scsi/qla2xxx/qla_nx.c
> +++ b/drivers/scsi/qla2xxx/qla_nx.c
> @@ -1561,14 +1561,14 @@ qla82xx_get_table_desc(const u8 *unirom, int section)
>   	uint32_t i;
>   	struct qla82xx_uri_table_desc *directory =
>   		(struct qla82xx_uri_table_desc *)&unirom[0];
> -	__le32 offset;
> -	__le32 tab_type;
> -	__le32 entries = cpu_to_le32(directory->num_entries);
> +	uint32_t offset;
> +	uint32_t tab_type;
> +	uint32_t entries = le32_to_cpu(directory->num_entries);
>   
>   	for (i = 0; i < entries; i++) {
> -		offset = cpu_to_le32(directory->findex) +
> -		    (i * cpu_to_le32(directory->entry_size));
> -		tab_type = cpu_to_le32(*((u32 *)&unirom[offset] + 8));
> +		offset = le32_to_cpu(directory->findex) +
> +		    (i * le32_to_cpu(directory->entry_size));
> +		tab_type = get_unaligned_le32((u32 *)&unirom[offset] + 8);
>   
>   		if (tab_type == section)
>   			return (struct qla82xx_uri_table_desc *)&unirom[offset];
> @@ -1582,16 +1582,17 @@ qla82xx_get_data_desc(struct qla_hw_data *ha,
>   	u32 section, u32 idx_offset)
>   {
>   	const u8 *unirom = ha->hablob->fw->data;
> -	int idx = cpu_to_le32(*((int *)&unirom[ha->file_prd_off] + idx_offset));
> +	int idx = get_unaligned_le32((u32 *)&unirom[ha->file_prd_off] +
> +				     idx_offset);
>   	struct qla82xx_uri_table_desc *tab_desc = NULL;
> -	__le32 offset;
> +	uint32_t offset;
>   
>   	tab_desc = qla82xx_get_table_desc(unirom, section);
>   	if (!tab_desc)
>   		return NULL;
>   
> -	offset = cpu_to_le32(tab_desc->findex) +
> -	    (cpu_to_le32(tab_desc->entry_size) * idx);
> +	offset = le32_to_cpu(tab_desc->findex) +
> +	    (le32_to_cpu(tab_desc->entry_size) * idx);
>   
>   	return (struct qla82xx_uri_data_desc *)&unirom[offset];
>   }
> @@ -1606,7 +1607,7 @@ qla82xx_get_bootld_offset(struct qla_hw_data *ha)
>   		uri_desc = qla82xx_get_data_desc(ha,
>   		    QLA82XX_URI_DIR_SECT_BOOTLD, QLA82XX_URI_BOOTLD_IDX_OFF);
>   		if (uri_desc)
> -			offset = cpu_to_le32(uri_desc->findex);
> +			offset = le32_to_cpu(uri_desc->findex);
>   	}
>   
>   	return (u8 *)&ha->hablob->fw->data[offset];
> @@ -1620,7 +1621,7 @@ static u32 qla82xx_get_fw_size(struct qla_hw_data *ha)
>   		uri_desc =  qla82xx_get_data_desc(ha, QLA82XX_URI_DIR_SECT_FW,
>   		    QLA82XX_URI_FIRMWARE_IDX_OFF);
>   		if (uri_desc)
> -			return cpu_to_le32(uri_desc->size);
> +			return le32_to_cpu(uri_desc->size);
>   	}
>   
>   	return get_unaligned_le32(&ha->hablob->fw->data[FW_SIZE_OFFSET]);
> @@ -1636,7 +1637,7 @@ qla82xx_get_fw_offs(struct qla_hw_data *ha)
>   		uri_desc = qla82xx_get_data_desc(ha, QLA82XX_URI_DIR_SECT_FW,
>   			QLA82XX_URI_FIRMWARE_IDX_OFF);
>   		if (uri_desc)
> -			offset = cpu_to_le32(uri_desc->findex);
> +			offset = le32_to_cpu(uri_desc->findex);
>   	}
>   
>   	return (u8 *)&ha->hablob->fw->data[offset];
> @@ -1847,8 +1848,8 @@ qla82xx_set_product_offset(struct qla_hw_data *ha)
>   	struct qla82xx_uri_table_desc *ptab_desc = NULL;
>   	const uint8_t *unirom = ha->hablob->fw->data;
>   	uint32_t i;
> -	__le32 entries;
> -	__le32 flags, file_chiprev, offset;
> +	uint32_t entries;
> +	uint32_t flags, file_chiprev, offset;
>   	uint8_t chiprev = ha->chip_revision;
>   	/* Hardcoding mn_present flag for P3P */
>   	int mn_present = 0;
> @@ -1859,14 +1860,14 @@ qla82xx_set_product_offset(struct qla_hw_data *ha)
>   	if (!ptab_desc)
>   		return -1;
>   
> -	entries = cpu_to_le32(ptab_desc->num_entries);
> +	entries = le32_to_cpu(ptab_desc->num_entries);
>   
>   	for (i = 0; i < entries; i++) {
> -		offset = cpu_to_le32(ptab_desc->findex) +
> -			(i * cpu_to_le32(ptab_desc->entry_size));
> -		flags = cpu_to_le32(*((int *)&unirom[offset] +
> +		offset = le32_to_cpu(ptab_desc->findex) +
> +			(i * le32_to_cpu(ptab_desc->entry_size));
> +		flags = le32_to_cpu(*((__le32 *)&unirom[offset] +
>   			QLA82XX_URI_FLAGS_OFF));
> -		file_chiprev = cpu_to_le32(*((int *)&unirom[offset] +
> +		file_chiprev = le32_to_cpu(*((__le32 *)&unirom[offset] +
>   			QLA82XX_URI_CHIP_REV_OFF));
>   
>   		flagbit = mn_present ? 1 : 2;
> @@ -2549,8 +2550,8 @@ qla82xx_start_firmware(scsi_qla_host_t *vha)
>   	return qla82xx_check_rcvpeg_state(ha);
>   }
>   
> -static uint32_t *
> -qla82xx_read_flash_data(scsi_qla_host_t *vha, uint32_t *dwptr, uint32_t faddr,
> +static __le32 *
> +qla82xx_read_flash_data(scsi_qla_host_t *vha, __le32 *dwptr, uint32_t faddr,
>   	uint32_t length)
>   {
>   	uint32_t i;
> @@ -2675,13 +2676,13 @@ qla82xx_read_optrom_data(struct scsi_qla_host *vha, void *buf,
>   	uint32_t offset, uint32_t length)
>   {
>   	scsi_block_requests(vha->host);
> -	qla82xx_read_flash_data(vha, (uint32_t *)buf, offset, length);
> +	qla82xx_read_flash_data(vha, buf, offset, length);
>   	scsi_unblock_requests(vha->host);
>   	return buf;
>   }
>   
>   static int
> -qla82xx_write_flash_data(struct scsi_qla_host *vha, uint32_t *dwptr,
> +qla82xx_write_flash_data(struct scsi_qla_host *vha, __le32 *dwptr,
>   	uint32_t faddr, uint32_t dwords)
>   {
>   	int ret;
> @@ -2758,7 +2759,7 @@ qla82xx_write_flash_data(struct scsi_qla_host *vha, uint32_t *dwptr,
>   		}
>   
>   		ret = qla82xx_write_flash_dword(ha, faddr,
> -		    cpu_to_le32(*dwptr));
> +						le32_to_cpu(*dwptr));
>   		if (ret) {
>   			ql_dbg(ql_dbg_p3p, vha, 0xb020,
>   			    "Unable to program flash address=%x data=%x.\n",
> @@ -3724,7 +3725,7 @@ qla82xx_chip_reset_cleanup(scsi_qla_host_t *vha)
>   /* Minidump related functions */
>   static int
>   qla82xx_minidump_process_control(scsi_qla_host_t *vha,
> -	qla82xx_md_entry_hdr_t *entry_hdr, uint32_t **d_ptr)
> +	qla82xx_md_entry_hdr_t *entry_hdr, __le32 **d_ptr)
>   {
>   	struct qla_hw_data *ha = vha->hw;
>   	struct qla82xx_md_entry_crb *crb_entry;
> @@ -3841,12 +3842,12 @@ qla82xx_minidump_process_control(scsi_qla_host_t *vha,
>   
>   static void
>   qla82xx_minidump_process_rdocm(scsi_qla_host_t *vha,
> -	qla82xx_md_entry_hdr_t *entry_hdr, uint32_t **d_ptr)
> +	qla82xx_md_entry_hdr_t *entry_hdr, __le32 **d_ptr)
>   {
>   	struct qla_hw_data *ha = vha->hw;
>   	uint32_t r_addr, r_stride, loop_cnt, i, r_value;
>   	struct qla82xx_md_entry_rdocm *ocm_hdr;
> -	uint32_t *data_ptr = *d_ptr;
> +	__le32 *data_ptr = *d_ptr;
>   
>   	ocm_hdr = (struct qla82xx_md_entry_rdocm *)entry_hdr;
>   	r_addr = ocm_hdr->read_addr;
> @@ -3863,12 +3864,12 @@ qla82xx_minidump_process_rdocm(scsi_qla_host_t *vha,
>   
>   static void
>   qla82xx_minidump_process_rdmux(scsi_qla_host_t *vha,
> -	qla82xx_md_entry_hdr_t *entry_hdr, uint32_t **d_ptr)
> +	qla82xx_md_entry_hdr_t *entry_hdr, __le32 **d_ptr)
>   {
>   	struct qla_hw_data *ha = vha->hw;
>   	uint32_t r_addr, s_stride, s_addr, s_value, loop_cnt, i, r_value;
>   	struct qla82xx_md_entry_mux *mux_hdr;
> -	uint32_t *data_ptr = *d_ptr;
> +	__le32 *data_ptr = *d_ptr;
>   
>   	mux_hdr = (struct qla82xx_md_entry_mux *)entry_hdr;
>   	r_addr = mux_hdr->read_addr;
> @@ -3889,12 +3890,12 @@ qla82xx_minidump_process_rdmux(scsi_qla_host_t *vha,
>   
>   static void
>   qla82xx_minidump_process_rdcrb(scsi_qla_host_t *vha,
> -	qla82xx_md_entry_hdr_t *entry_hdr, uint32_t **d_ptr)
> +	qla82xx_md_entry_hdr_t *entry_hdr, __le32 **d_ptr)
>   {
>   	struct qla_hw_data *ha = vha->hw;
>   	uint32_t r_addr, r_stride, loop_cnt, i, r_value;
>   	struct qla82xx_md_entry_crb *crb_hdr;
> -	uint32_t *data_ptr = *d_ptr;
> +	__le32 *data_ptr = *d_ptr;
>   
>   	crb_hdr = (struct qla82xx_md_entry_crb *)entry_hdr;
>   	r_addr = crb_hdr->addr;
> @@ -3912,7 +3913,7 @@ qla82xx_minidump_process_rdcrb(scsi_qla_host_t *vha,
>   
>   static int
>   qla82xx_minidump_process_l2tag(scsi_qla_host_t *vha,
> -	qla82xx_md_entry_hdr_t *entry_hdr, uint32_t **d_ptr)
> +	qla82xx_md_entry_hdr_t *entry_hdr, __le32 **d_ptr)
>   {
>   	struct qla_hw_data *ha = vha->hw;
>   	uint32_t addr, r_addr, c_addr, t_r_addr;
> @@ -3921,7 +3922,7 @@ qla82xx_minidump_process_l2tag(scsi_qla_host_t *vha,
>   	uint32_t c_value_w, c_value_r;
>   	struct qla82xx_md_entry_cache *cache_hdr;
>   	int rval = QLA_FUNCTION_FAILED;
> -	uint32_t *data_ptr = *d_ptr;
> +	__le32 *data_ptr = *d_ptr;
>   
>   	cache_hdr = (struct qla82xx_md_entry_cache *)entry_hdr;
>   	loop_count = cache_hdr->op_count;
> @@ -3971,14 +3972,14 @@ qla82xx_minidump_process_l2tag(scsi_qla_host_t *vha,
>   
>   static void
>   qla82xx_minidump_process_l1cache(scsi_qla_host_t *vha,
> -	qla82xx_md_entry_hdr_t *entry_hdr, uint32_t **d_ptr)
> +	qla82xx_md_entry_hdr_t *entry_hdr, __le32 **d_ptr)
>   {
>   	struct qla_hw_data *ha = vha->hw;
>   	uint32_t addr, r_addr, c_addr, t_r_addr;
>   	uint32_t i, k, loop_count, t_value, r_cnt, r_value;
>   	uint32_t c_value_w;
>   	struct qla82xx_md_entry_cache *cache_hdr;
> -	uint32_t *data_ptr = *d_ptr;
> +	__le32 *data_ptr = *d_ptr;
>   
>   	cache_hdr = (struct qla82xx_md_entry_cache *)entry_hdr;
>   	loop_count = cache_hdr->op_count;
> @@ -4006,14 +4007,14 @@ qla82xx_minidump_process_l1cache(scsi_qla_host_t *vha,
>   
>   static void
>   qla82xx_minidump_process_queue(scsi_qla_host_t *vha,
> -	qla82xx_md_entry_hdr_t *entry_hdr, uint32_t **d_ptr)
> +	qla82xx_md_entry_hdr_t *entry_hdr, __le32 **d_ptr)
>   {
>   	struct qla_hw_data *ha = vha->hw;
>   	uint32_t s_addr, r_addr;
>   	uint32_t r_stride, r_value, r_cnt, qid = 0;
>   	uint32_t i, k, loop_cnt;
>   	struct qla82xx_md_entry_queue *q_hdr;
> -	uint32_t *data_ptr = *d_ptr;
> +	__le32 *data_ptr = *d_ptr;
>   
>   	q_hdr = (struct qla82xx_md_entry_queue *)entry_hdr;
>   	s_addr = q_hdr->select_addr;
> @@ -4036,13 +4037,13 @@ qla82xx_minidump_process_queue(scsi_qla_host_t *vha,
>   
>   static void
>   qla82xx_minidump_process_rdrom(scsi_qla_host_t *vha,
> -	qla82xx_md_entry_hdr_t *entry_hdr, uint32_t **d_ptr)
> +	qla82xx_md_entry_hdr_t *entry_hdr, __le32 **d_ptr)
>   {
>   	struct qla_hw_data *ha = vha->hw;
>   	uint32_t r_addr, r_value;
>   	uint32_t i, loop_cnt;
>   	struct qla82xx_md_entry_rdrom *rom_hdr;
> -	uint32_t *data_ptr = *d_ptr;
> +	__le32 *data_ptr = *d_ptr;
>   
>   	rom_hdr = (struct qla82xx_md_entry_rdrom *)entry_hdr;
>   	r_addr = rom_hdr->read_addr;
> @@ -4062,7 +4063,7 @@ qla82xx_minidump_process_rdrom(scsi_qla_host_t *vha,
>   
>   static int
>   qla82xx_minidump_process_rdmem(scsi_qla_host_t *vha,
> -	qla82xx_md_entry_hdr_t *entry_hdr, uint32_t **d_ptr)
> +	qla82xx_md_entry_hdr_t *entry_hdr, __le32 **d_ptr)
>   {
>   	struct qla_hw_data *ha = vha->hw;
>   	uint32_t r_addr, r_value, r_data;
> @@ -4070,7 +4071,7 @@ qla82xx_minidump_process_rdmem(scsi_qla_host_t *vha,
>   	struct qla82xx_md_entry_rdmem *m_hdr;
>   	unsigned long flags;
>   	int rval = QLA_FUNCTION_FAILED;
> -	uint32_t *data_ptr = *d_ptr;
> +	__le32 *data_ptr = *d_ptr;
>   
>   	m_hdr = (struct qla82xx_md_entry_rdmem *)entry_hdr;
>   	r_addr = m_hdr->read_addr;
> @@ -4163,12 +4164,12 @@ qla82xx_md_collect(scsi_qla_host_t *vha)
>   	int no_entry_hdr = 0;
>   	qla82xx_md_entry_hdr_t *entry_hdr;
>   	struct qla82xx_md_template_hdr *tmplt_hdr;
> -	uint32_t *data_ptr;
> +	__le32 *data_ptr;
>   	uint32_t total_data_size = 0, f_capture_mask, data_collected = 0;
>   	int i = 0, rval = QLA_FUNCTION_FAILED;
>   
>   	tmplt_hdr = (struct qla82xx_md_template_hdr *)ha->md_tmplt_hdr;
> -	data_ptr = (uint32_t *)ha->md_dump;
> +	data_ptr = ha->md_dump;
>   
>   	if (ha->fw_dumped) {
>   		ql_log(ql_log_warn, vha, 0xb037,
> diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
> index 8617ea42551c..d560d5cb6865 100644
> --- a/drivers/scsi/qla2xxx/qla_os.c
> +++ b/drivers/scsi/qla2xxx/qla_os.c
> @@ -5957,7 +5957,7 @@ void qla24xx_process_purex_rdp(struct scsi_qla_host *vha, void *pkt)
>   	rsp_els->entry_status = 0;
>   	rsp_els->handle = 0;
>   	rsp_els->nport_handle = purex->nport_handle;
> -	rsp_els->tx_dsd_count = 1;
> +	rsp_els->tx_dsd_count = cpu_to_le16(1);
>   	rsp_els->vp_index = purex->vp_idx;
>   	rsp_els->sof_type = EST_SOFI3;
>   	rsp_els->rx_xchg_address = purex->rx_xchg_addr;
> @@ -5968,7 +5968,7 @@ void qla24xx_process_purex_rdp(struct scsi_qla_host *vha, void *pkt)
>   	rsp_els->d_id[1] = purex->s_id[1];
>   	rsp_els->d_id[2] = purex->s_id[2];
>   
> -	rsp_els->control_flags = EPD_ELS_ACC;
> +	rsp_els->control_flags = cpu_to_le16(EPD_ELS_ACC);
>   	rsp_els->rx_byte_count = 0;
>   	rsp_els->tx_byte_count = cpu_to_le32(rsp_payload_length);
>   
> @@ -5980,8 +5980,8 @@ void qla24xx_process_purex_rdp(struct scsi_qla_host *vha, void *pkt)
>   
>   	/* Prepare Response Payload */
>   	rsp_payload->hdr.cmd = cpu_to_be32(0x2 << 24); /* LS_ACC */
> -	rsp_payload->hdr.len = cpu_to_be32(
> -	    rsp_els->tx_byte_count - sizeof(rsp_payload->hdr));
> +	rsp_payload->hdr.len = cpu_to_be32(le32_to_cpu(rsp_els->tx_byte_count) -
> +					   sizeof(rsp_payload->hdr));
>   
>   	/* Link service Request Info Descriptor */
>   	rsp_payload->ls_req_info_desc.desc_tag = cpu_to_be32(0x1);
> @@ -6031,7 +6031,7 @@ void qla24xx_process_purex_rdp(struct scsi_qla_host *vha, void *pkt)
>   		memset(sfp, 0, SFP_RTDI_LEN);
>   		rval = qla2x00_read_sfp(vha, sfp_dma, sfp, 0xa2, 0x60, 10, 0);
>   		if (!rval) {
> -			uint16_t *trx = (void *)sfp; /* already be16 */
> +			__be16 *trx = (__force __be16 *)sfp; /* already be16 */
>   			rsp_payload->sfp_diag_desc.temperature = trx[0];
>   			rsp_payload->sfp_diag_desc.vcc = trx[1];
>   			rsp_payload->sfp_diag_desc.tx_bias = trx[2];
> @@ -6058,17 +6058,17 @@ void qla24xx_process_purex_rdp(struct scsi_qla_host *vha, void *pkt)
>   		rval = qla24xx_get_isp_stats(vha, stat, stat_dma, 0);
>   		if (!rval) {
>   			rsp_payload->ls_err_desc.link_fail_cnt =
> -			    cpu_to_be32(stat->link_fail_cnt);
> +			    cpu_to_be32(le32_to_cpu(stat->link_fail_cnt));
>   			rsp_payload->ls_err_desc.loss_sync_cnt =
> -			    cpu_to_be32(stat->loss_sync_cnt);
> +			    cpu_to_be32(le32_to_cpu(stat->loss_sync_cnt));
>   			rsp_payload->ls_err_desc.loss_sig_cnt =
> -			    cpu_to_be32(stat->loss_sig_cnt);
> +			    cpu_to_be32(le32_to_cpu(stat->loss_sig_cnt));
>   			rsp_payload->ls_err_desc.prim_seq_err_cnt =
> -			    cpu_to_be32(stat->prim_seq_err_cnt);
> +			    cpu_to_be32(le32_to_cpu(stat->prim_seq_err_cnt));
>   			rsp_payload->ls_err_desc.inval_xmit_word_cnt =
> -			    cpu_to_be32(stat->inval_xmit_word_cnt);
> +			    cpu_to_be32(le32_to_cpu(stat->inval_xmit_word_cnt));
>   			rsp_payload->ls_err_desc.inval_crc_cnt =
> -			    cpu_to_be32(stat->inval_crc_cnt);
> +			    cpu_to_be32(le32_to_cpu(stat->inval_crc_cnt));
>   			rsp_payload->ls_err_desc.pn_port_phy_type |= BIT_6;
>   		}
>   	}
> @@ -6140,7 +6140,7 @@ void qla24xx_process_purex_rdp(struct scsi_qla_host *vha, void *pkt)
>   		memset(sfp, 0, SFP_RTDI_LEN);
>   		rval = qla2x00_read_sfp(vha, sfp_dma, sfp, 0xa2, 0, 64, 0);
>   		if (!rval) {
> -			uint16_t *trx = (void *)sfp; /* already be16 */
> +			__be16 *trx = (__force __be16 *)sfp; /* already be16 */
>   
>   			/* Optical Element Descriptor, Temperature */
>   			rsp_payload->optical_elmt_desc[0].high_alarm = trx[0];
> diff --git a/drivers/scsi/qla2xxx/qla_sup.c b/drivers/scsi/qla2xxx/qla_sup.c
> index 40ce1ee7c0d7..85f5f1834925 100644
> --- a/drivers/scsi/qla2xxx/qla_sup.c
> +++ b/drivers/scsi/qla2xxx/qla_sup.c
> @@ -183,7 +183,7 @@ qla2x00_nv_deselect(struct qla_hw_data *ha)
>    * @data: word to program
>    */
>   static void
> -qla2x00_write_nvram_word(struct qla_hw_data *ha, uint32_t addr, uint16_t data)
> +qla2x00_write_nvram_word(struct qla_hw_data *ha, uint32_t addr, __le16 data)
>   {
>   	int count;
>   	uint16_t word;
> @@ -202,7 +202,7 @@ qla2x00_write_nvram_word(struct qla_hw_data *ha, uint32_t addr, uint16_t data)
>   
>   	/* Write data */
>   	nv_cmd = (addr << 16) | NV_WRITE_OP;
> -	nv_cmd |= data;
> +	nv_cmd |= (__force u16)data;
>   	nv_cmd <<= 5;
>   	for (count = 0; count < 27; count++) {
>   		if (nv_cmd & BIT_31)
> @@ -241,7 +241,7 @@ qla2x00_write_nvram_word(struct qla_hw_data *ha, uint32_t addr, uint16_t data)
>   
>   static int
>   qla2x00_write_nvram_word_tmo(struct qla_hw_data *ha, uint32_t addr,
> -	uint16_t data, uint32_t tmo)
> +			     __le16 data, uint32_t tmo)
>   {
>   	int ret, count;
>   	uint16_t word;
> @@ -261,7 +261,7 @@ qla2x00_write_nvram_word_tmo(struct qla_hw_data *ha, uint32_t addr,
>   
>   	/* Write data */
>   	nv_cmd = (addr << 16) | NV_WRITE_OP;
> -	nv_cmd |= data;
> +	nv_cmd |= (__force u16)data;
>   	nv_cmd <<= 5;
>   	for (count = 0; count < 27; count++) {
>   		if (nv_cmd & BIT_31)
> @@ -308,7 +308,7 @@ qla2x00_clear_nvram_protection(struct qla_hw_data *ha)
>   	int ret, stat;
>   	struct device_reg_2xxx __iomem *reg = &ha->iobase->isp;
>   	uint32_t word, wait_cnt;
> -	uint16_t wprot, wprot_old;
> +	__le16 wprot, wprot_old;
>   	scsi_qla_host_t *vha = pci_get_drvdata(ha->pdev);
>   
>   	/* Clear NVRAM write protection. */
> @@ -318,7 +318,7 @@ qla2x00_clear_nvram_protection(struct qla_hw_data *ha)
>   	stat = qla2x00_write_nvram_word_tmo(ha, ha->nvram_base,
>   					    cpu_to_le16(0x1234), 100000);
>   	wprot = cpu_to_le16(qla2x00_get_nvram_word(ha, ha->nvram_base));
> -	if (stat != QLA_SUCCESS || wprot != 0x1234) {
> +	if (stat != QLA_SUCCESS || wprot != cpu_to_le16(0x1234)) {
>   		/* Write enable. */
>   		qla2x00_nv_write(ha, NVR_DATA_OUT);
>   		qla2x00_nv_write(ha, 0);
> @@ -549,7 +549,8 @@ qla2xxx_find_flt_start(scsi_qla_host_t *vha, uint32_t *start)
>   {
>   	const char *loc, *locations[] = { "DEF", "PCI" };
>   	uint32_t pcihdr, pcids;
> -	uint16_t cnt, chksum, *wptr;
> +	uint16_t cnt, chksum;
> +	__le16 *wptr;
>   	struct qla_hw_data *ha = vha->hw;
>   	struct req_que *req = ha->req_q_map[0];
>   	struct qla_flt_location *fltl = (void *)req->ring;
> @@ -610,7 +611,7 @@ qla2xxx_find_flt_start(scsi_qla_host_t *vha, uint32_t *start)
>   	if (memcmp(fltl->sig, "QFLT", 4))
>   		goto end;
>   
> -	wptr = (void *)req->ring;
> +	wptr = (__force __le16 *)req->ring;
>   	cnt = sizeof(*fltl) / sizeof(*wptr);
>   	for (chksum = 0; cnt--; wptr++)
>   		chksum += le16_to_cpu(*wptr);
> @@ -671,7 +672,8 @@ qla2xxx_get_flt_info(scsi_qla_host_t *vha, uint32_t flt_addr)
>   	uint32_t def = IS_QLA81XX(ha) ? 2 : IS_QLA25XX(ha) ? 1 : 0;
>   	struct qla_flt_header *flt = ha->flt;
>   	struct qla_flt_region *region = &flt->region[0];
> -	uint16_t *wptr, cnt, chksum;
> +	__le16 *wptr;
> +	uint16_t cnt, chksum;
>   	uint32_t start;
>   
>   	/* Assign FCP prio region since older adapters may not have FLT, or
> @@ -681,8 +683,8 @@ qla2xxx_get_flt_info(scsi_qla_host_t *vha, uint32_t flt_addr)
>   	    fcp_prio_cfg0[def] : fcp_prio_cfg1[def];
>   
>   	ha->flt_region_flt = flt_addr;
> -	wptr = (uint16_t *)ha->flt;
> -	ha->isp_ops->read_optrom(vha, (void *)flt, flt_addr << 2,
> +	wptr = (__force __le16 *)ha->flt;
> +	ha->isp_ops->read_optrom(vha, flt, flt_addr << 2,
>   	    (sizeof(struct qla_flt_header) + FLT_REGIONS_SIZE));
>   
>   	if (le16_to_cpu(*wptr) == 0xffff)
> @@ -949,7 +951,7 @@ qla2xxx_get_fdt_info(scsi_qla_host_t *vha)
>   	struct qla_hw_data *ha = vha->hw;
>   	struct req_que *req = ha->req_q_map[0];
>   	uint16_t cnt, chksum;
> -	uint16_t *wptr = (void *)req->ring;
> +	__le16 *wptr = (__force __le16 *)req->ring;
>   	struct qla_fdt_layout *fdt = (struct qla_fdt_layout *)req->ring;
>   	uint8_t	man_id, flash_id;
>   	uint16_t mid = 0, fid = 0;
> @@ -1042,14 +1044,14 @@ static void
>   qla2xxx_get_idc_param(scsi_qla_host_t *vha)
>   {
>   #define QLA82XX_IDC_PARAM_ADDR       0x003e885c
> -	uint32_t *wptr;
> +	__le32 *wptr;
>   	struct qla_hw_data *ha = vha->hw;
>   	struct req_que *req = ha->req_q_map[0];
>   
>   	if (!(IS_P3P_TYPE(ha)))
>   		return;
>   
> -	wptr = (uint32_t *)req->ring;
> +	wptr = (__force __le32 *)req->ring;
>   	ha->isp_ops->read_optrom(vha, req->ring, QLA82XX_IDC_PARAM_ADDR, 8);
>   
>   	if (*wptr == cpu_to_le32(0xffffffff)) {
> @@ -1095,7 +1097,7 @@ qla2xxx_flash_npiv_conf(scsi_qla_host_t *vha)
>   {
>   #define NPIV_CONFIG_SIZE	(16*1024)
>   	void *data;
> -	uint16_t *wptr;
> +	__le16 *wptr;
>   	uint16_t cnt, chksum;
>   	int i;
>   	struct qla_npiv_header hdr;
> @@ -1265,7 +1267,7 @@ qla24xx_erase_sector(scsi_qla_host_t *vha, uint32_t fdata)
>   }
>   
>   static int
> -qla24xx_write_flash_data(scsi_qla_host_t *vha, uint32_t *dwptr, uint32_t faddr,
> +qla24xx_write_flash_data(scsi_qla_host_t *vha, __le32 *dwptr, uint32_t faddr,
>       uint32_t dwords)
>   {
>   	int ret;
> @@ -1352,7 +1354,7 @@ qla24xx_write_flash_data(scsi_qla_host_t *vha, uint32_t *dwptr, uint32_t faddr,
>   
>   		/* Slow write */
>   		ret = qla24xx_write_flash_dword(ha,
> -		    flash_data_addr(ha, faddr), cpu_to_le32(*dwptr));
> +		    flash_data_addr(ha, faddr), le32_to_cpu(*dwptr));
>   		if (ret) {
>   			ql_dbg(ql_dbg_user, vha, 0x7006,
>   			    "Failed slopw write %x (%x)\n", faddr, *dwptr);
> @@ -1379,11 +1381,11 @@ qla2x00_read_nvram_data(scsi_qla_host_t *vha, void *buf, uint32_t naddr,
>       uint32_t bytes)
>   {
>   	uint32_t i;
> -	uint16_t *wptr;
> +	__le16 *wptr;
>   	struct qla_hw_data *ha = vha->hw;
>   
>   	/* Word reads to NVRAM via registers. */
> -	wptr = (uint16_t *)buf;
> +	wptr = buf;
>   	qla2x00_lock_nvram_access(ha);
>   	for (i = 0; i < bytes >> 1; i++, naddr++)
>   		wptr[i] = cpu_to_le16(qla2x00_get_nvram_word(ha,
> @@ -1456,7 +1458,7 @@ qla24xx_write_nvram_data(scsi_qla_host_t *vha, void *buf, uint32_t naddr,
>   {
>   	struct qla_hw_data *ha = vha->hw;
>   	struct device_reg_24xx __iomem *reg = &ha->iobase->isp24;
> -	uint32_t *dwptr = buf;
> +	__le32 *dwptr = buf;
>   	uint32_t i;
>   	int ret;
>   
> @@ -1478,7 +1480,7 @@ qla24xx_write_nvram_data(scsi_qla_host_t *vha, void *buf, uint32_t naddr,
>   	naddr = nvram_data_addr(ha, naddr);
>   	bytes >>= 2;
>   	for (i = 0; i < bytes; i++, naddr++, dwptr++) {
> -		if (qla24xx_write_flash_dword(ha, naddr, cpu_to_le32(*dwptr))) {
> +		if (qla24xx_write_flash_dword(ha, naddr, le32_to_cpu(*dwptr))) {
>   			ql_dbg(ql_dbg_user, vha, 0x709a,
>   			    "Unable to program nvram address=%x data=%x.\n",
>   			    naddr, *dwptr);
> @@ -2610,7 +2612,7 @@ qla24xx_read_optrom_data(struct scsi_qla_host *vha, void *buf,
>   	set_bit(MBX_UPDATE_FLASH_ACTIVE, &ha->mbx_cmd_flags);
>   
>   	/* Go with read. */
> -	qla24xx_read_flash_data(vha, (void *)buf, offset >> 2, length >> 2);
> +	qla24xx_read_flash_data(vha, buf, offset >> 2, length >> 2);
>   
>   	/* Resume HBA. */
>   	clear_bit(MBX_UPDATE_FLASH_ACTIVE, &ha->mbx_cmd_flags);
> @@ -2662,7 +2664,7 @@ qla28xx_get_flash_region(struct scsi_qla_host *vha, uint32_t start,
>   
>   	cnt = le16_to_cpu(flt->length) / sizeof(struct qla_flt_region);
>   	for (; cnt; cnt--, flt_reg++) {
> -		if (flt_reg->start == start) {
> +		if (le32_to_cpu(flt_reg->start) == start) {
>   			memcpy((uint8_t *)region, flt_reg,
>   			    sizeof(struct qla_flt_region));
>   			rval = QLA_SUCCESS;
> @@ -2691,7 +2693,7 @@ qla28xx_write_flash_data(scsi_qla_host_t *vha, uint32_t *dwptr, uint32_t faddr,
>   	struct qla_flt_region region;
>   	bool reset_to_rom = false;
>   	uint32_t risc_size, risc_attr = 0;
> -	uint32_t *fw_array = NULL;
> +	__be32 *fw_array = NULL;
>   
>   	/* Retrieve region info - must be a start address passed in */
>   	rval = qla28xx_get_flash_region(vha, offset, &region);
> @@ -2722,12 +2724,12 @@ qla28xx_write_flash_data(scsi_qla_host_t *vha, uint32_t *dwptr, uint32_t faddr,
>   		ql_log(ql_log_warn + ql_dbg_verbose, vha, 0xffff,
>   		    "Region %x is secure\n", region.code);
>   
> -		switch (region.code) {
> +		switch (le16_to_cpu(region.code)) {
>   		case FLT_REG_FW:
>   		case FLT_REG_FW_SEC_27XX:
>   		case FLT_REG_MPI_PRI_28XX:
>   		case FLT_REG_MPI_SEC_28XX:
> -			fw_array = dwptr;
> +			fw_array = (__force __be32 *)dwptr;
>   
>   			/* 1st fw array */
>   			risc_size = be32_to_cpu(fw_array[3]);
> @@ -2761,7 +2763,7 @@ qla28xx_write_flash_data(scsi_qla_host_t *vha, uint32_t *dwptr, uint32_t faddr,
>   
>   		case FLT_REG_PEP_PRI_28XX:
>   		case FLT_REG_PEP_SEC_28XX:
> -			fw_array = dwptr;
> +			fw_array = (__force __be32 *)dwptr;
>   
>   			/* 1st fw array */
>   			risc_size = be32_to_cpu(fw_array[3]);
> @@ -2892,7 +2894,8 @@ qla28xx_write_flash_data(scsi_qla_host_t *vha, uint32_t *dwptr, uint32_t faddr,
>   		if (region.attribute && buf_size_without_sfub) {
>   			ql_log(ql_log_warn + ql_dbg_verbose, vha, 0xffff,
>   			    "Sending Secure Flash MB Cmd\n");
> -			rval = qla28xx_secure_flash_update(vha, 0, region.code,
> +			rval = qla28xx_secure_flash_update(vha, 0,
> +				le16_to_cpu(region.code),
>   				buf_size_without_sfub, sfub_dma,
>   				sizeof(struct secure_flash_update_block) >> 2);
>   			if (rval != QLA_SUCCESS) {
> @@ -2981,11 +2984,11 @@ qla24xx_write_optrom_data(struct scsi_qla_host *vha, void *buf,
>   
>   	/* Go with write. */
>   	if (IS_QLA28XX(ha))
> -		rval = qla28xx_write_flash_data(vha, (uint32_t *)buf,
> -		    offset >> 2, length >> 2);
> +		rval = qla28xx_write_flash_data(vha, buf, offset >> 2,
> +						length >> 2);
>   	else
> -		rval = qla24xx_write_flash_data(vha, (uint32_t *)buf,
> -		    offset >> 2, length >> 2);
> +		rval = qla24xx_write_flash_data(vha, buf, offset >> 2,
> +						length >> 2);
>   
>   	clear_bit(MBX_UPDATE_FLASH_ACTIVE, &ha->mbx_cmd_flags);
>   	scsi_unblock_requests(vha->host);
> @@ -3513,7 +3516,8 @@ qla24xx_get_flash_version(scsi_qla_host_t *vha, void *mbuf)
>   		ql_dump_buffer(ql_dbg_init, vha, 0x005f, dcode, 32);
>   	} else {
>   		for (i = 0; i < 4; i++)
> -			ha->fw_revision[i] = be32_to_cpu(dcode[4+i]);
> +			ha->fw_revision[i] =
> +				be32_to_cpu((__force __be32)dcode[4+i]);
>   		ql_dbg(ql_dbg_init, vha, 0x0060,
>   		    "Firmware revision (flash) %u.%u.%u (%x).\n",
>   		    ha->fw_revision[0], ha->fw_revision[1],
> @@ -3528,7 +3532,7 @@ qla24xx_get_flash_version(scsi_qla_host_t *vha, void *mbuf)
>   
>   	memset(ha->gold_fw_version, 0, sizeof(ha->gold_fw_version));
>   	faddr = ha->flt_region_gold_fw;
> -	qla24xx_read_flash_data(vha, (void *)dcode, ha->flt_region_gold_fw, 8);
> +	qla24xx_read_flash_data(vha, dcode, ha->flt_region_gold_fw, 8);
>   	if (qla24xx_risc_firmware_invalid(dcode)) {
>   		ql_log(ql_log_warn, vha, 0x0056,
>   		    "Unrecognized golden fw at %#x.\n", faddr);
> @@ -3537,7 +3541,8 @@ qla24xx_get_flash_version(scsi_qla_host_t *vha, void *mbuf)
>   	}
>   
>   	for (i = 0; i < 4; i++)
> -		ha->gold_fw_version[i] = be32_to_cpu(dcode[4+i]);
> +		ha->gold_fw_version[i] =
> +			be32_to_cpu((__force __be32)dcode[4+i]);
>   
>   	return ret;
>   }
> diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
> index 186de3fcf1fd..11064bbda543 100644
> --- a/drivers/scsi/qla2xxx/qla_target.c
> +++ b/drivers/scsi/qla2xxx/qla_target.c
> @@ -378,7 +378,7 @@ static bool qlt_24xx_atio_pkt_all_vps(struct scsi_qla_host *vha,
>   		qlt_issue_marker(vha, ha_locked);
>   
>   		if ((entry->u.isp24.vp_index != 0xFF) &&
> -		    (entry->u.isp24.nport_handle != 0xFFFF)) {
> +		    (entry->u.isp24.nport_handle != cpu_to_le16(0xFFFF))) {
>   			host = qlt_find_host_by_vp_idx(vha,
>   			    entry->u.isp24.vp_index);
>   			if (unlikely(!host)) {
> @@ -1697,7 +1697,7 @@ static void qlt_send_notify_ack(struct qla_qpair *qpair,
>   	nack->u.isp24.nport_handle = ntfy->u.isp24.nport_handle;
>   	if (le16_to_cpu(ntfy->u.isp24.status) == IMM_NTFY_ELS) {
>   		nack->u.isp24.flags = ntfy->u.isp24.flags &
> -			cpu_to_le32(NOTIFY24XX_FLAGS_PUREX_IOCB);
> +			cpu_to_le16(NOTIFY24XX_FLAGS_PUREX_IOCB);
>   	}
>   	nack->u.isp24.srr_rx_id = ntfy->u.isp24.srr_rx_id;
>   	nack->u.isp24.status = ntfy->u.isp24.status;
> @@ -1725,7 +1725,8 @@ static int qlt_build_abts_resp_iocb(struct qla_tgt_mgmt_cmd *mcmd)
>   	struct scsi_qla_host *vha = mcmd->vha;
>   	struct qla_hw_data *ha = vha->hw;
>   	struct abts_resp_to_24xx *resp;
> -	uint32_t f_ctl, h;
> +	__le32 f_ctl;
> +	uint32_t h;
>   	uint8_t *p;
>   	int rc;
>   	struct abts_recv_from_24xx *abts = &mcmd->orig_iocb.abts;
> @@ -1782,7 +1783,7 @@ static int qlt_build_abts_resp_iocb(struct qla_tgt_mgmt_cmd *mcmd)
>   		resp->fcp_hdr_le.r_ctl = R_CTL_BASIC_LINK_SERV | R_CTL_B_ACC;
>   		resp->payload.ba_acct.seq_id_valid = SEQ_ID_INVALID;
>   		resp->payload.ba_acct.low_seq_cnt = 0x0000;
> -		resp->payload.ba_acct.high_seq_cnt = 0xFFFF;
> +		resp->payload.ba_acct.high_seq_cnt = cpu_to_le16(0xFFFF);
>   		resp->payload.ba_acct.ox_id = abts->fcp_hdr_le.ox_id;
>   		resp->payload.ba_acct.rx_id = abts->fcp_hdr_le.rx_id;
>   	} else {
> @@ -1814,7 +1815,7 @@ static void qlt_24xx_send_abts_resp(struct qla_qpair *qpair,
>   	struct scsi_qla_host *vha = qpair->vha;
>   	struct qla_hw_data *ha = vha->hw;
>   	struct abts_resp_to_24xx *resp;
> -	uint32_t f_ctl;
> +	__le32 f_ctl;
>   	uint8_t *p;
>   
>   	ql_dbg(ql_dbg_tgt, vha, 0xe006,
> @@ -1857,7 +1858,7 @@ static void qlt_24xx_send_abts_resp(struct qla_qpair *qpair,
>   		resp->fcp_hdr_le.r_ctl = R_CTL_BASIC_LINK_SERV | R_CTL_B_ACC;
>   		resp->payload.ba_acct.seq_id_valid = SEQ_ID_INVALID;
>   		resp->payload.ba_acct.low_seq_cnt = 0x0000;
> -		resp->payload.ba_acct.high_seq_cnt = 0xFFFF;
> +		resp->payload.ba_acct.high_seq_cnt = cpu_to_le16(0xFFFF);
>   		resp->payload.ba_acct.ox_id = abts->fcp_hdr_le.ox_id;
>   		resp->payload.ba_acct.rx_id = abts->fcp_hdr_le.rx_id;
>   	} else {
> @@ -2223,7 +2224,7 @@ static void qlt_24xx_send_task_mgmt_ctio(struct qla_qpair *qpair,
>   	ctio->entry_type = CTIO_TYPE7;
>   	ctio->entry_count = 1;
>   	ctio->handle = QLA_TGT_SKIP_HANDLE | CTIO_COMPLETION_HANDLE_MARK;
> -	ctio->nport_handle = mcmd->sess->loop_id;
> +	ctio->nport_handle = cpu_to_le16(mcmd->sess->loop_id);
>   	ctio->timeout = cpu_to_le16(QLA_TGT_TIMEOUT);
>   	ctio->vp_index = ha->vp_idx;
>   	ctio->initiator_id = be_id_to_le(atio->u.isp24.fcp_hdr.s_id);

Ah. For the session we _do_ need to convert the loop id...

> @@ -2280,7 +2281,7 @@ void qlt_send_resp_ctio(struct qla_qpair *qpair, struct qla_tgt_cmd *cmd,
>   	ctio->entry_type = CTIO_TYPE7;
>   	ctio->entry_count = 1;
>   	ctio->handle = QLA_TGT_SKIP_HANDLE;
> -	ctio->nport_handle = cmd->sess->loop_id;
> +	ctio->nport_handle = cpu_to_le16(cmd->sess->loop_id);
>   	ctio->timeout = cpu_to_le16(QLA_TGT_TIMEOUT);
>   	ctio->vp_index = vha->vp_idx;
>   	ctio->initiator_id = be_id_to_le(atio->u.isp24.fcp_hdr.s_id);
> @@ -2840,10 +2841,12 @@ static void qlt_24xx_init_ctio_to_isp(struct ctio7_to_24xx *ctio,
>   		    cpu_to_le16(SS_SENSE_LEN_VALID);
>   		ctio->u.status1.sense_length =
>   		    cpu_to_le16(prm->sense_buffer_len);
> -		for (i = 0; i < prm->sense_buffer_len/4; i++)
> -			((uint32_t *)ctio->u.status1.sense_data)[i] =
> -				cpu_to_be32(((uint32_t *)prm->sense_buffer)[i]);
> +		for (i = 0; i < prm->sense_buffer_len/4; i++) {
> +			uint32_t v;
>   
> +			v = get_unaligned_be32(&((uint32_t *)prm->sense_buffer)[i]);
> +			put_unaligned_le32(v, &((uint32_t *)ctio->u.status1.sense_data)[i]);
> +		}
>   		qlt_print_dif_err(prm);
>   
>   	} else {
> @@ -3114,7 +3117,7 @@ qlt_build_ctio_crc2_pkt(struct qla_qpair *qpair, struct qla_tgt_prm *prm)
>   	else if (cmd->dma_data_direction == DMA_FROM_DEVICE)
>   		pkt->flags = cpu_to_le16(CTIO7_FLAGS_DATA_OUT);
>   
> -	pkt->dseg_count = prm->tot_dsds;
> +	pkt->dseg_count = cpu_to_le16(prm->tot_dsds);
>   	/* Fibre channel byte count */
>   	pkt->transfer_length = cpu_to_le32(transfer_length);
>   
> @@ -3136,7 +3139,7 @@ qlt_build_ctio_crc2_pkt(struct qla_qpair *qpair, struct qla_tgt_prm *prm)
>   	qla_tgt_set_dif_tags(cmd, crc_ctx_pkt, &fw_prot_opts);
>   
>   	put_unaligned_le64(crc_ctx_dma, &pkt->crc_context_address);
> -	pkt->crc_context_len = CRC_CONTEXT_LEN_FW;
> +	pkt->crc_context_len = cpu_to_le16(CRC_CONTEXT_LEN_FW);
>   
>   	if (!bundling) {
>   		cur_dsd = &crc_ctx_pkt->u.nobundling.data_dsd[0];
> @@ -3573,7 +3576,7 @@ static int __qlt_send_term_imm_notif(struct scsi_qla_host *vha,
>   	nack->u.isp24.nport_handle = ntfy->u.isp24.nport_handle;
>   	if (le16_to_cpu(ntfy->u.isp24.status) == IMM_NTFY_ELS) {
>   		nack->u.isp24.flags = ntfy->u.isp24.flags &
> -			__constant_cpu_to_le32(NOTIFY24XX_FLAGS_PUREX_IOCB);
> +			cpu_to_le16(NOTIFY24XX_FLAGS_PUREX_IOCB);
>   	}
>   
>   	/* terminate */
> @@ -3647,7 +3650,7 @@ static int __qlt_send_term_exchange(struct qla_qpair *qpair,
>   
>   	ctio24 = (struct ctio7_to_24xx *)pkt;
>   	ctio24->entry_type = CTIO_TYPE7;
> -	ctio24->nport_handle = CTIO7_NHANDLE_UNRECOGNIZED;
> +	ctio24->nport_handle = cpu_to_le16(CTIO7_NHANDLE_UNRECOGNIZED);
>   	ctio24->timeout = cpu_to_le16(QLA_TGT_TIMEOUT);
>   	ctio24->vp_index = vha->vp_idx;
>   	ctio24->initiator_id = be_id_to_le(atio->u.isp24.fcp_hdr.s_id);
> @@ -5302,7 +5305,7 @@ static int __qlt_send_busy(struct qla_qpair *qpair,
>   
>   	ctio24 = (struct ctio7_to_24xx *)pkt;
>   	ctio24->entry_type = CTIO_TYPE7;
> -	ctio24->nport_handle = sess->loop_id;
> +	ctio24->nport_handle = cpu_to_le16(sess->loop_id);
>   	ctio24->timeout = cpu_to_le16(QLA_TGT_TIMEOUT);
>   	ctio24->vp_index = vha->vp_idx;
>   	ctio24->initiator_id = be_id_to_le(atio->u.isp24.fcp_hdr.s_id);
> @@ -5315,13 +5318,14 @@ static int __qlt_send_busy(struct qla_qpair *qpair,
>   	 * CTIO from fw w/o se_cmd doesn't provide enough info to retry it,
>   	 * if the explicit conformation is used.
>   	 */
> -	ctio24->u.status1.ox_id = swab16(atio->u.isp24.fcp_hdr.ox_id);
> +	ctio24->u.status1.ox_id =
> +		cpu_to_le16(be16_to_cpu(atio->u.isp24.fcp_hdr.ox_id));
>   	ctio24->u.status1.scsi_status = cpu_to_le16(status);
>   
> -	ctio24->u.status1.residual = get_datalen_for_atio(atio);
> +	ctio24->u.status1.residual = cpu_to_le32(get_datalen_for_atio(atio));
>   
>   	if (ctio24->u.status1.residual != 0)
> -		ctio24->u.status1.scsi_status |= SS_RESIDUAL_UNDER;
> +		ctio24->u.status1.scsi_status |= cpu_to_le16(SS_RESIDUAL_UNDER);
>   
>   	/* Memory Barrier */
>   	wmb();
> @@ -5713,8 +5717,8 @@ static void qlt_handle_abts_completion(struct scsi_qla_host *vha,
>   	    entry->compl_status);
>   
>   	if (le16_to_cpu(entry->compl_status) != ABTS_RESP_COMPL_SUCCESS) {
> -		if ((entry->error_subcode1 == 0x1E) &&
> -		    (entry->error_subcode2 == 0)) {
> +		if (le32_to_cpu(entry->error_subcode1) == 0x1E &&
> +		    le32_to_cpu(entry->error_subcode2) == 0) {
>   			if (qlt_chk_unresolv_exchg(vha, rsp->qpair, entry)) {
>   				ha->tgt.tgt_ops->free_mcmd(mcmd);
>   				return;
> @@ -5928,8 +5932,7 @@ void qlt_async_event(uint16_t code, struct scsi_qla_host *vha,
>   		ql_dbg(ql_dbg_tgt_mgt, vha, 0xf03b,
>   		    "qla_target(%d): Async LOOP_UP occurred "
>   		    "(m[0]=%x, m[1]=%x, m[2]=%x, m[3]=%x)", vha->vp_idx,
> -		    le16_to_cpu(mailbox[0]), le16_to_cpu(mailbox[1]),
> -		    le16_to_cpu(mailbox[2]), le16_to_cpu(mailbox[3]));
> +		    mailbox[0], mailbox[1], mailbox[2], mailbox[3]);
>   		if (tgt->link_reinit_iocb_pending) {
>   			qlt_send_notify_ack(ha->base_qpair,
>   			    (void *)&tgt->link_reinit_iocb,
> @@ -5946,18 +5949,16 @@ void qlt_async_event(uint16_t code, struct scsi_qla_host *vha,
>   		ql_dbg(ql_dbg_tgt_mgt, vha, 0xf03c,
>   		    "qla_target(%d): Async event %#x occurred "
>   		    "(m[0]=%x, m[1]=%x, m[2]=%x, m[3]=%x)", vha->vp_idx, code,
> -		    le16_to_cpu(mailbox[0]), le16_to_cpu(mailbox[1]),
> -		    le16_to_cpu(mailbox[2]), le16_to_cpu(mailbox[3]));
> +		    mailbox[0], mailbox[1], mailbox[2], mailbox[3]);
>   		break;
>   
>   	case MBA_REJECTED_FCP_CMD:
>   		ql_dbg(ql_dbg_tgt_mgt, vha, 0xf017,
>   		    "qla_target(%d): Async event LS_REJECT occurred (m[0]=%x, m[1]=%x, m[2]=%x, m[3]=%x)",
>   		    vha->vp_idx,
> -		    le16_to_cpu(mailbox[0]), le16_to_cpu(mailbox[1]),
> -		    le16_to_cpu(mailbox[2]), le16_to_cpu(mailbox[3]));
> +		    mailbox[0], mailbox[1], mailbox[2], mailbox[3]);
>   
> -		if (le16_to_cpu(mailbox[3]) == 1) {
> +		if (mailbox[3] == 1) {
>   			/* exchange starvation. */
>   			vha->hw->exch_starvation++;
>   			if (vha->hw->exch_starvation > 5) {

I would argue that we should keep the conversions here; otherwise the 
mailbox contents will be really hard to read on big endian.

> @@ -5981,10 +5982,9 @@ void qlt_async_event(uint16_t code, struct scsi_qla_host *vha,
>   		    "qla_target(%d): Port update async event %#x "
>   		    "occurred: updating the ports database (m[0]=%x, m[1]=%x, "
>   		    "m[2]=%x, m[3]=%x)", vha->vp_idx, code,
> -		    le16_to_cpu(mailbox[0]), le16_to_cpu(mailbox[1]),
> -		    le16_to_cpu(mailbox[2]), le16_to_cpu(mailbox[3]));
> +		    mailbox[0], mailbox[1], mailbox[2], mailbox[3]);
>   
> -		login_code = le16_to_cpu(mailbox[2]);
> +		login_code = mailbox[2];
>   		if (login_code == 0x4) {
>   			ql_dbg(ql_dbg_tgt_mgt, vha, 0xf03e,
>   			    "Async MB 2: Got PLOGI Complete\n");

And this now is wrong; assuming the mailbox is little endian
we'll need to keep it.

> @@ -6729,7 +6729,7 @@ qlt_init_atio_q_entries(struct scsi_qla_host *vha)
>   		return;
>   
>   	for (cnt = 0; cnt < ha->tgt.atio_q_length; cnt++) {
> -		pkt->u.raw.signature = ATIO_PROCESSED;
> +		pkt->u.raw.signature = cpu_to_le32(ATIO_PROCESSED);
>   		pkt++;
>   	}
>   
> @@ -6764,7 +6764,7 @@ qlt_24xx_process_atio_queue(struct scsi_qla_host *vha, uint8_t ha_locked)
>   			    "corrupted fcp frame SID[%3phN] OXID[%04x] EXCG[%x] %64phN\n",
>   			    &pkt->u.isp24.fcp_hdr.s_id,
>   			    be16_to_cpu(pkt->u.isp24.fcp_hdr.ox_id),
> -			    le32_to_cpu(pkt->u.isp24.exchange_addr), pkt);
> +			    pkt->u.isp24.exchange_addr, pkt);
>   
>   			adjust_corrupted_atio(pkt);
>   			qlt_send_term_exchange(ha->base_qpair, NULL, pkt,

Why did you drop the conversion for the exchange address?
Is it in machine native format already?

> @@ -6782,7 +6782,7 @@ qlt_24xx_process_atio_queue(struct scsi_qla_host *vha, uint8_t ha_locked)
>   			} else
>   				ha->tgt.atio_ring_ptr++;
>   
> -			pkt->u.raw.signature = ATIO_PROCESSED;
> +			pkt->u.raw.signature = cpu_to_le32(ATIO_PROCESSED);
>   			pkt = (struct atio_from_isp *)ha->tgt.atio_ring_ptr;
>   		}
>   		wmb();
> @@ -6811,10 +6811,10 @@ qlt_24xx_config_rings(struct scsi_qla_host *vha)
>   			if (IS_QLA2071(ha)) {
>   				/* 4 ports Baker: Enable Interrupt Handshake */
>   				icb->msix_atio = 0;
> -				icb->firmware_options_2 |= BIT_26;
> +				icb->firmware_options_2 |= cpu_to_le32(BIT_26);
>   			} else {
>   				icb->msix_atio = cpu_to_le16(msix->entry);
> -				icb->firmware_options_2 &= ~BIT_26;
> +				icb->firmware_options_2 &= cpu_to_le32(~BIT_26);
>   			}
>   			ql_dbg(ql_dbg_init, vha, 0xf072,
>   			    "Registering ICB vector 0x%x for atio que.\n",
> @@ -6824,7 +6824,7 @@ qlt_24xx_config_rings(struct scsi_qla_host *vha)
>   		/* INTx|MSI */
>   		if (IS_QLA83XX(ha) || IS_QLA27XX(ha) || IS_QLA28XX(ha)) {
>   			icb->msix_atio = 0;
> -			icb->firmware_options_2 |= BIT_26;
> +			icb->firmware_options_2 |= cpu_to_le32(BIT_26);
>   			ql_dbg(ql_dbg_init, vha, 0xf072,
>   			    "%s: Use INTx for ATIOQ.\n", __func__);
>   		}
> diff --git a/drivers/scsi/qla2xxx/qla_tmpl.c b/drivers/scsi/qla2xxx/qla_tmpl.c
> index 3f52d5af3e8a..d241929d6dd5 100644
> --- a/drivers/scsi/qla2xxx/qla_tmpl.c
> +++ b/drivers/scsi/qla2xxx/qla_tmpl.c
> @@ -922,9 +922,9 @@ qla27xx_firmware_info(struct scsi_qla_host *vha,
>   	tmp->firmware_version[0] = vha->hw->fw_major_version;
>   	tmp->firmware_version[1] = vha->hw->fw_minor_version;
>   	tmp->firmware_version[2] = vha->hw->fw_subminor_version;
> -	tmp->firmware_version[3] = cpu_to_le32(
> +	tmp->firmware_version[3] = (__force u32)cpu_to_le32(
>   		vha->hw->fw_attributes_h << 16 | vha->hw->fw_attributes);
> -	tmp->firmware_version[4] = cpu_to_le32(
> +	tmp->firmware_version[4] = (__force u32)cpu_to_le32(
>   	  vha->hw->fw_attributes_ext[1] << 16 | vha->hw->fw_attributes_ext[0]);
>   }
>   
> 
In general this is really hard to review, as you move the function 
arguments around together with the missing/wrong annotations.
Can't you split it off into one patch for the missing annotations and 
another one which moves the function argument (and annotations)?
(Or, maybe, the other way around; the first one moving the function
arguments and annotations touched by this, and the second one for
the remaining fixes...)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
