Return-Path: <linux-scsi+bounces-14795-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7DCAE499A
	for <lists+linux-scsi@lfdr.de>; Mon, 23 Jun 2025 18:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C02C188C56C
	for <lists+linux-scsi@lfdr.de>; Mon, 23 Jun 2025 16:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A5C28AAF4;
	Mon, 23 Jun 2025 15:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Prxj5wUJ"
X-Original-To: linux-scsi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FDE2451F0
	for <linux-scsi@vger.kernel.org>; Mon, 23 Jun 2025 15:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750694396; cv=none; b=aTxfMP9AAuaDLetJFsnPJ6L6q809KKoB5ZdUJLPuXLJzFk+NkjFoQKOJ+zV6q1HG1UM+LUgWO7V7ooLycLxOR98ZisEShUnrhrxDg+MWHQs+NkSjs80FnzqSdoVYmlbZo3RTaIW9wKjzQehQfwyzliHnvy+01MjKvGBNIlWSrJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750694396; c=relaxed/simple;
	bh=SPyOQGy0DXBVS3pFaf4sTny9G3h4cTQ4nBPnEmaaWLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J4h10unFOO1idYZJsxBoZJ+1iEgUiGhyD94weX3WCUxsRO9PWsanr1+v9lvHsegtyZrb0KU9h+e8dqOyA0ryYoC8K5qrXQhVfSak+DlD+fA8C2K2tnf6XOo+lFtx9SVoE+dCQ+UeJYtt9F0Ke5k67EM9XqIkSFp+kR0jUXIpVoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Prxj5wUJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750694392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+eEoq+6d0WgcESEGvvbxbxwBHlN5XLV7+QpwbDZ1Oqc=;
	b=Prxj5wUJzaHzRPKlzVQmybtRgW7aPQ8EApK26oqzmZvgMheOUuIWYYFu/s8hUONexxooaV
	LzgZMa8Z2OUH6IQt58XxOQBTyZJvEQDmeRtwzJJ9x7kZl6b+VFjEWJKn7WRO7Q5+CWP5U7
	nL1k350blqcQJ6RhwTghzQ/388v8n0c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-3XoeSZyqOciyOcj1M-2MCw-1; Mon,
 23 Jun 2025 11:59:48 -0400
X-MC-Unique: 3XoeSZyqOciyOcj1M-2MCw-1
X-Mimecast-MFC-AGG-ID: 3XoeSZyqOciyOcj1M-2MCw_1750694386
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CCF391800290;
	Mon, 23 Jun 2025 15:59:45 +0000 (UTC)
Received: from [10.22.90.20] (unknown [10.22.90.20])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6F20A19560AB;
	Mon, 23 Jun 2025 15:59:42 +0000 (UTC)
Message-ID: <46047671-c047-4922-8aa9-8e4892dde8fb@redhat.com>
Date: Mon, 23 Jun 2025 11:59:41 -0400
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/6] fc_els: use 'union fc_tlv_desc'
To: Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk
Cc: james.smart@broadcom.com, dick.kennedy@broadcom.com, njavali@marvell.com,
 linux-scsi@vger.kernel.org, hare@suse.de
References: <20250620175557.34635-1-bgurney@redhat.com>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20250620175557.34635-1-bgurney@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Reviewed-by: John Meneghini <jmeneghi@redhat.com>

On 6/20/25 1:55 PM, Bryan Gurney wrote:
> From: Hannes Reinecke <hare@kernel.org>
> 
> Introduce 'union fc_tlv_desc' to have a common structure for all FC
> ELS TLV structures and avoid type casts.
> 
> [bgurney: The cast inside the union fc_tlv_next_desc() has "u8",
> which causes a failure to build.  Use "__u8" instead.]
> 
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> Reviewed-by: Justin Tee <justin.tee@broadcom.com>
> Tested-by: Bryan Gurney <bgurney@redhat.com>
> ---
>   drivers/scsi/lpfc/lpfc_els.c     |  75 +++++++-------
>   drivers/scsi/scsi_transport_fc.c |  27 +++--
>   include/uapi/scsi/fc/fc_els.h    | 165 +++++++++++++++++--------------
>   3 files changed, 135 insertions(+), 132 deletions(-)
> 
> diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
> index 375a879c31f1..959603ab939a 100644
> --- a/drivers/scsi/lpfc/lpfc_els.c
> +++ b/drivers/scsi/lpfc/lpfc_els.c
> @@ -3937,7 +3937,7 @@ lpfc_cmpl_els_edc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
>   {
>   	IOCB_t *irsp_iocb;
>   	struct fc_els_edc_resp *edc_rsp;
> -	struct fc_tlv_desc *tlv;
> +	union fc_tlv_desc *tlv;
>   	struct fc_diag_cg_sig_desc *pcgd;
>   	struct fc_diag_lnkflt_desc *plnkflt;
>   	struct lpfc_dmabuf *pcmd, *prsp;
> @@ -4028,7 +4028,7 @@ lpfc_cmpl_els_edc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
>   			goto out;
>   		}
>   
> -		dtag = be32_to_cpu(tlv->desc_tag);
> +		dtag = be32_to_cpu(tlv->hdr.desc_tag);
>   		switch (dtag) {
>   		case ELS_DTAG_LNK_FAULT_CAP:
>   			if (bytes_remain < FC_TLV_DESC_SZ_FROM_LENGTH(tlv) ||
> @@ -4043,7 +4043,7 @@ lpfc_cmpl_els_edc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
>   					sizeof(struct fc_diag_lnkflt_desc));
>   				goto out;
>   			}
> -			plnkflt = (struct fc_diag_lnkflt_desc *)tlv;
> +			plnkflt = &tlv->lnkflt;
>   			lpfc_printf_log(phba, KERN_INFO,
>   				LOG_ELS | LOG_LDS_EVENT,
>   				"4617 Link Fault Desc Data: 0x%08x 0x%08x "
> @@ -4070,7 +4070,7 @@ lpfc_cmpl_els_edc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
>   				goto out;
>   			}
>   
> -			pcgd = (struct fc_diag_cg_sig_desc *)tlv;
> +			pcgd = &tlv->cg_sig;
>   			lpfc_printf_log(
>   				phba, KERN_INFO, LOG_ELS | LOG_CGN_MGMT,
>   				"4616 CGN Desc Data: 0x%08x 0x%08x "
> @@ -4125,10 +4125,8 @@ lpfc_cmpl_els_edc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
>   }
>   
>   static void
> -lpfc_format_edc_lft_desc(struct lpfc_hba *phba, struct fc_tlv_desc *tlv)
> +lpfc_format_edc_lft_desc(struct lpfc_hba *phba, struct fc_diag_lnkflt_desc *lft)
>   {
> -	struct fc_diag_lnkflt_desc *lft = (struct fc_diag_lnkflt_desc *)tlv;
> -
>   	lft->desc_tag = cpu_to_be32(ELS_DTAG_LNK_FAULT_CAP);
>   	lft->desc_len = cpu_to_be32(
>   		FC_TLV_DESC_LENGTH_FROM_SZ(struct fc_diag_lnkflt_desc));
> @@ -4141,10 +4139,8 @@ lpfc_format_edc_lft_desc(struct lpfc_hba *phba, struct fc_tlv_desc *tlv)
>   }
>   
>   static void
> -lpfc_format_edc_cgn_desc(struct lpfc_hba *phba, struct fc_tlv_desc *tlv)
> +lpfc_format_edc_cgn_desc(struct lpfc_hba *phba, struct fc_diag_cg_sig_desc *cgd)
>   {
> -	struct fc_diag_cg_sig_desc *cgd = (struct fc_diag_cg_sig_desc *)tlv;
> -
>   	/* We are assuming cgd was zero'ed before calling this routine */
>   
>   	/* Configure the congestion detection capability */
> @@ -4233,7 +4229,7 @@ lpfc_issue_els_edc(struct lpfc_vport *vport, uint8_t retry)
>   	struct lpfc_hba  *phba = vport->phba;
>   	struct lpfc_iocbq *elsiocb;
>   	struct fc_els_edc *edc_req;
> -	struct fc_tlv_desc *tlv;
> +	union fc_tlv_desc *tlv;
>   	u16 cmdsize;
>   	struct lpfc_nodelist *ndlp;
>   	u8 *pcmd = NULL;
> @@ -4272,13 +4268,13 @@ lpfc_issue_els_edc(struct lpfc_vport *vport, uint8_t retry)
>   	tlv = edc_req->desc;
>   
>   	if (cgn_desc_size) {
> -		lpfc_format_edc_cgn_desc(phba, tlv);
> +		lpfc_format_edc_cgn_desc(phba, &tlv->cg_sig);
>   		phba->cgn_sig_freq = lpfc_fabric_cgn_frequency;
>   		tlv = fc_tlv_next_desc(tlv);
>   	}
>   
>   	if (lft_desc_size)
> -		lpfc_format_edc_lft_desc(phba, tlv);
> +		lpfc_format_edc_lft_desc(phba, &tlv->lnkflt);
>   
>   	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS | LOG_CGN_MGMT,
>   			 "4623 Xmit EDC to remote "
> @@ -5823,7 +5819,7 @@ lpfc_issue_els_edc_rsp(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
>   {
>   	struct lpfc_hba  *phba = vport->phba;
>   	struct fc_els_edc_resp *edc_rsp;
> -	struct fc_tlv_desc *tlv;
> +	union fc_tlv_desc *tlv;
>   	struct lpfc_iocbq *elsiocb;
>   	IOCB_t *icmd, *cmd;
>   	union lpfc_wqe128 *wqe;
> @@ -5867,10 +5863,10 @@ lpfc_issue_els_edc_rsp(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
>   		FC_TLV_DESC_LENGTH_FROM_SZ(struct fc_els_lsri_desc));
>   	edc_rsp->lsri.rqst_w0.cmd = ELS_EDC;
>   	tlv = edc_rsp->desc;
> -	lpfc_format_edc_cgn_desc(phba, tlv);
> +	lpfc_format_edc_cgn_desc(phba, &tlv->cg_sig);
>   	tlv = fc_tlv_next_desc(tlv);
>   	if (lft_desc_size)
> -		lpfc_format_edc_lft_desc(phba, tlv);
> +		lpfc_format_edc_lft_desc(phba, &tlv->lnkflt);
>   
>   	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_RSP,
>   			      "Issue EDC ACC:      did:x%x flg:x%lx refcnt %d",
> @@ -9255,7 +9251,7 @@ lpfc_els_rcv_edc(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
>   {
>   	struct lpfc_hba  *phba = vport->phba;
>   	struct fc_els_edc *edc_req;
> -	struct fc_tlv_desc *tlv;
> +	union fc_tlv_desc *tlv;
>   	uint8_t *payload;
>   	uint32_t *ptr, dtag;
>   	const char *dtag_nm;
> @@ -9298,7 +9294,7 @@ lpfc_els_rcv_edc(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
>   			goto out;
>   		}
>   
> -		dtag = be32_to_cpu(tlv->desc_tag);
> +		dtag = be32_to_cpu(tlv->hdr.desc_tag);
>   		switch (dtag) {
>   		case ELS_DTAG_LNK_FAULT_CAP:
>   			if (bytes_remain < FC_TLV_DESC_SZ_FROM_LENGTH(tlv) ||
> @@ -9313,7 +9309,7 @@ lpfc_els_rcv_edc(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
>   					sizeof(struct fc_diag_lnkflt_desc));
>   				goto out;
>   			}
> -			plnkflt = (struct fc_diag_lnkflt_desc *)tlv;
> +			plnkflt = &tlv->lnkflt;
>   			lpfc_printf_log(phba, KERN_INFO,
>   				LOG_ELS | LOG_LDS_EVENT,
>   				"4626 Link Fault Desc Data: x%08x len x%x "
> @@ -9350,7 +9346,7 @@ lpfc_els_rcv_edc(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
>   			phba->cgn_sig_freq = lpfc_fabric_cgn_frequency;
>   
>   			lpfc_least_capable_settings(
> -				phba, (struct fc_diag_cg_sig_desc *)tlv);
> +				phba, &tlv->cg_sig);
>   			break;
>   		default:
>   			dtag_nm = lpfc_get_tlv_dtag_nm(dtag);
> @@ -9941,14 +9937,13 @@ lpfc_display_fpin_wwpn(struct lpfc_hba *phba, __be64 *wwnlist, u32 cnt)
>   /**
>    * lpfc_els_rcv_fpin_li - Process an FPIN Link Integrity Event.
>    * @phba: Pointer to phba object.
> - * @tlv:  Pointer to the Link Integrity Notification Descriptor.
> + * @li:  Pointer to the Link Integrity Notification Descriptor.
>    *
>    * This function processes a Link Integrity FPIN event by logging a message.
>    **/
>   static void
> -lpfc_els_rcv_fpin_li(struct lpfc_hba *phba, struct fc_tlv_desc *tlv)
> +lpfc_els_rcv_fpin_li(struct lpfc_hba *phba, struct fc_fn_li_desc *li)
>   {
> -	struct fc_fn_li_desc *li = (struct fc_fn_li_desc *)tlv;
>   	const char *li_evt_str;
>   	u32 li_evt, cnt;
>   
> @@ -9972,14 +9967,13 @@ lpfc_els_rcv_fpin_li(struct lpfc_hba *phba, struct fc_tlv_desc *tlv)
>   /**
>    * lpfc_els_rcv_fpin_del - Process an FPIN Delivery Event.
>    * @phba: Pointer to hba object.
> - * @tlv:  Pointer to the Delivery Notification Descriptor TLV
> + * @del:  Pointer to the Delivery Notification Descriptor TLV
>    *
>    * This function processes a Delivery FPIN event by logging a message.
>    **/
>   static void
> -lpfc_els_rcv_fpin_del(struct lpfc_hba *phba, struct fc_tlv_desc *tlv)
> +lpfc_els_rcv_fpin_del(struct lpfc_hba *phba, struct fc_fn_deli_desc *del)
>   {
> -	struct fc_fn_deli_desc *del = (struct fc_fn_deli_desc *)tlv;
>   	const char *del_rsn_str;
>   	u32 del_rsn;
>   	__be32 *frame;
> @@ -10010,14 +10004,14 @@ lpfc_els_rcv_fpin_del(struct lpfc_hba *phba, struct fc_tlv_desc *tlv)
>   /**
>    * lpfc_els_rcv_fpin_peer_cgn - Process a FPIN Peer Congestion Event.
>    * @phba: Pointer to hba object.
> - * @tlv:  Pointer to the Peer Congestion Notification Descriptor TLV
> + * @pc:  Pointer to the Peer Congestion Notification Descriptor TLV
>    *
>    * This function processes a Peer Congestion FPIN event by logging a message.
>    **/
>   static void
> -lpfc_els_rcv_fpin_peer_cgn(struct lpfc_hba *phba, struct fc_tlv_desc *tlv)
> +lpfc_els_rcv_fpin_peer_cgn(struct lpfc_hba *phba,
> +			   struct fc_fn_peer_congn_desc *pc)
>   {
> -	struct fc_fn_peer_congn_desc *pc = (struct fc_fn_peer_congn_desc *)tlv;
>   	const char *pc_evt_str;
>   	u32 pc_evt, cnt;
>   
> @@ -10045,7 +10039,7 @@ lpfc_els_rcv_fpin_peer_cgn(struct lpfc_hba *phba, struct fc_tlv_desc *tlv)
>   /**
>    * lpfc_els_rcv_fpin_cgn - Process an FPIN Congestion notification
>    * @phba: Pointer to hba object.
> - * @tlv:  Pointer to the Congestion Notification Descriptor TLV
> + * @cgn:  Pointer to the Congestion Notification Descriptor TLV
>    *
>    * This function processes an FPIN Congestion Notifiction.  The notification
>    * could be an Alarm or Warning.  This routine feeds that data into driver's
> @@ -10054,10 +10048,9 @@ lpfc_els_rcv_fpin_peer_cgn(struct lpfc_hba *phba, struct fc_tlv_desc *tlv)
>    * to the upper layer or 0 to indicate don't deliver it.
>    **/
>   static int
> -lpfc_els_rcv_fpin_cgn(struct lpfc_hba *phba, struct fc_tlv_desc *tlv)
> +lpfc_els_rcv_fpin_cgn(struct lpfc_hba *phba, struct fc_fn_congn_desc *cgn)
>   {
>   	struct lpfc_cgn_info *cp;
> -	struct fc_fn_congn_desc *cgn = (struct fc_fn_congn_desc *)tlv;
>   	const char *cgn_evt_str;
>   	u32 cgn_evt;
>   	const char *cgn_sev_str;
> @@ -10160,7 +10153,7 @@ lpfc_els_rcv_fpin(struct lpfc_vport *vport, void *p, u32 fpin_length)
>   {
>   	struct lpfc_hba *phba = vport->phba;
>   	struct fc_els_fpin *fpin = (struct fc_els_fpin *)p;
> -	struct fc_tlv_desc *tlv, *first_tlv, *current_tlv;
> +	union fc_tlv_desc *tlv, *first_tlv, *current_tlv;
>   	const char *dtag_nm;
>   	int desc_cnt = 0, bytes_remain, cnt;
>   	u32 dtag, deliver = 0;
> @@ -10185,7 +10178,7 @@ lpfc_els_rcv_fpin(struct lpfc_vport *vport, void *p, u32 fpin_length)
>   		return;
>   	}
>   
> -	tlv = (struct fc_tlv_desc *)&fpin->fpin_desc[0];
> +	tlv = &fpin->fpin_desc[0];
>   	first_tlv = tlv;
>   	bytes_remain = fpin_length - offsetof(struct fc_els_fpin, fpin_desc);
>   	bytes_remain = min_t(u32, bytes_remain, be32_to_cpu(fpin->desc_len));
> @@ -10193,22 +10186,22 @@ lpfc_els_rcv_fpin(struct lpfc_vport *vport, void *p, u32 fpin_length)
>   	/* process each descriptor separately */
>   	while (bytes_remain >= FC_TLV_DESC_HDR_SZ &&
>   	       bytes_remain >= FC_TLV_DESC_SZ_FROM_LENGTH(tlv)) {
> -		dtag = be32_to_cpu(tlv->desc_tag);
> +		dtag = be32_to_cpu(tlv->hdr.desc_tag);
>   		switch (dtag) {
>   		case ELS_DTAG_LNK_INTEGRITY:
> -			lpfc_els_rcv_fpin_li(phba, tlv);
> +			lpfc_els_rcv_fpin_li(phba, &tlv->li);
>   			deliver = 1;
>   			break;
>   		case ELS_DTAG_DELIVERY:
> -			lpfc_els_rcv_fpin_del(phba, tlv);
> +			lpfc_els_rcv_fpin_del(phba, &tlv->deli);
>   			deliver = 1;
>   			break;
>   		case ELS_DTAG_PEER_CONGEST:
> -			lpfc_els_rcv_fpin_peer_cgn(phba, tlv);
> +			lpfc_els_rcv_fpin_peer_cgn(phba, &tlv->peer_congn);
>   			deliver = 1;
>   			break;
>   		case ELS_DTAG_CONGESTION:
> -			deliver = lpfc_els_rcv_fpin_cgn(phba, tlv);
> +			deliver = lpfc_els_rcv_fpin_cgn(phba, &tlv->congn);
>   			break;
>   		default:
>   			dtag_nm = lpfc_get_tlv_dtag_nm(dtag);
> @@ -10221,12 +10214,12 @@ lpfc_els_rcv_fpin(struct lpfc_vport *vport, void *p, u32 fpin_length)
>   			return;
>   		}
>   		lpfc_cgn_update_stat(phba, dtag);
> -		cnt = be32_to_cpu(tlv->desc_len);
> +		cnt = be32_to_cpu(tlv->hdr.desc_len);
>   
>   		/* Sanity check descriptor length. The desc_len value does not
>   		 * include space for the desc_tag and the desc_len fields.
>   		 */
> -		len -= (cnt + sizeof(struct fc_tlv_desc));
> +		len -= (cnt + sizeof(struct fc_tlv_desc_hdr));
>   		if (len < 0) {
>   			dtag_nm = lpfc_get_tlv_dtag_nm(dtag);
>   			lpfc_printf_log(phba, KERN_WARNING, LOG_CGN_MGMT,
> diff --git a/drivers/scsi/scsi_transport_fc.c b/drivers/scsi/scsi_transport_fc.c
> index 082f76e76721..a62636c6f708 100644
> --- a/drivers/scsi/scsi_transport_fc.c
> +++ b/drivers/scsi/scsi_transport_fc.c
> @@ -750,13 +750,12 @@ fc_cn_stats_update(u16 event_type, struct fc_fpin_stats *stats)
>    *
>    */
>   static void
> -fc_fpin_li_stats_update(struct Scsi_Host *shost, struct fc_tlv_desc *tlv)
> +fc_fpin_li_stats_update(struct Scsi_Host *shost, struct fc_fn_li_desc *li_desc)
>   {
>   	u8 i;
>   	struct fc_rport *rport = NULL;
>   	struct fc_rport *attach_rport = NULL;
>   	struct fc_host_attrs *fc_host = shost_to_fc_host(shost);
> -	struct fc_fn_li_desc *li_desc = (struct fc_fn_li_desc *)tlv;
>   	u16 event_type = be16_to_cpu(li_desc->event_type);
>   	u64 wwpn;
>   
> @@ -799,12 +798,11 @@ fc_fpin_li_stats_update(struct Scsi_Host *shost, struct fc_tlv_desc *tlv)
>    */
>   static void
>   fc_fpin_delivery_stats_update(struct Scsi_Host *shost,
> -			      struct fc_tlv_desc *tlv)
> +			      struct fc_fn_deli_desc *dn_desc)
>   {
>   	struct fc_rport *rport = NULL;
>   	struct fc_rport *attach_rport = NULL;
>   	struct fc_host_attrs *fc_host = shost_to_fc_host(shost);
> -	struct fc_fn_deli_desc *dn_desc = (struct fc_fn_deli_desc *)tlv;
>   	u32 reason_code = be32_to_cpu(dn_desc->deli_reason_code);
>   
>   	rport = fc_find_rport_by_wwpn(shost,
> @@ -830,13 +828,11 @@ fc_fpin_delivery_stats_update(struct Scsi_Host *shost,
>    */
>   static void
>   fc_fpin_peer_congn_stats_update(struct Scsi_Host *shost,
> -				struct fc_tlv_desc *tlv)
> +				struct fc_fn_peer_congn_desc *pc_desc)
>   {
>   	u8 i;
>   	struct fc_rport *rport = NULL;
>   	struct fc_rport *attach_rport = NULL;
> -	struct fc_fn_peer_congn_desc *pc_desc =
> -	    (struct fc_fn_peer_congn_desc *)tlv;
>   	u16 event_type = be16_to_cpu(pc_desc->event_type);
>   	u64 wwpn;
>   
> @@ -876,10 +872,9 @@ fc_fpin_peer_congn_stats_update(struct Scsi_Host *shost,
>    */
>   static void
>   fc_fpin_congn_stats_update(struct Scsi_Host *shost,
> -			   struct fc_tlv_desc *tlv)
> +			   struct fc_fn_congn_desc *congn)
>   {
>   	struct fc_host_attrs *fc_host = shost_to_fc_host(shost);
> -	struct fc_fn_congn_desc *congn = (struct fc_fn_congn_desc *)tlv;
>   
>   	fc_cn_stats_update(be16_to_cpu(congn->event_type),
>   			   &fc_host->fpin_stats);
> @@ -899,32 +894,32 @@ fc_host_fpin_rcv(struct Scsi_Host *shost, u32 fpin_len, char *fpin_buf,
>   		u8 event_acknowledge)
>   {
>   	struct fc_els_fpin *fpin = (struct fc_els_fpin *)fpin_buf;
> -	struct fc_tlv_desc *tlv;
> +	union fc_tlv_desc *tlv;
>   	u32 bytes_remain;
>   	u32 dtag;
>   	enum fc_host_event_code event_code =
>   		event_acknowledge ? FCH_EVT_LINK_FPIN_ACK : FCH_EVT_LINK_FPIN;
>   
>   	/* Update Statistics */
> -	tlv = (struct fc_tlv_desc *)&fpin->fpin_desc[0];
> +	tlv = &fpin->fpin_desc[0];
>   	bytes_remain = fpin_len - offsetof(struct fc_els_fpin, fpin_desc);
>   	bytes_remain = min_t(u32, bytes_remain, be32_to_cpu(fpin->desc_len));
>   
>   	while (bytes_remain >= FC_TLV_DESC_HDR_SZ &&
>   	       bytes_remain >= FC_TLV_DESC_SZ_FROM_LENGTH(tlv)) {
> -		dtag = be32_to_cpu(tlv->desc_tag);
> +		dtag = be32_to_cpu(tlv->hdr.desc_tag);
>   		switch (dtag) {
>   		case ELS_DTAG_LNK_INTEGRITY:
> -			fc_fpin_li_stats_update(shost, tlv);
> +			fc_fpin_li_stats_update(shost, &tlv->li);
>   			break;
>   		case ELS_DTAG_DELIVERY:
> -			fc_fpin_delivery_stats_update(shost, tlv);
> +			fc_fpin_delivery_stats_update(shost, &tlv->deli);
>   			break;
>   		case ELS_DTAG_PEER_CONGEST:
> -			fc_fpin_peer_congn_stats_update(shost, tlv);
> +			fc_fpin_peer_congn_stats_update(shost, &tlv->peer_congn);
>   			break;
>   		case ELS_DTAG_CONGESTION:
> -			fc_fpin_congn_stats_update(shost, tlv);
> +			fc_fpin_congn_stats_update(shost, &tlv->congn);
>   		}
>   
>   		bytes_remain -= FC_TLV_DESC_SZ_FROM_LENGTH(tlv);
> diff --git a/include/uapi/scsi/fc/fc_els.h b/include/uapi/scsi/fc/fc_els.h
> index 16782c360de3..3598dc553f4d 100644
> --- a/include/uapi/scsi/fc/fc_els.h
> +++ b/include/uapi/scsi/fc/fc_els.h
> @@ -253,12 +253,12 @@ enum fc_ls_tlv_dtag {
>   
>   
>   /*
> - * Generic Link Service TLV Descriptor format
> + * Generic Link Service TLV Descriptor header
>    *
>    * This structure, as it defines no payload, will also be referred to
>    * as the "tlv header" - which contains the tag and len fields.
>    */
> -struct fc_tlv_desc {
> +struct fc_tlv_desc_hdr {
>   	__be32		desc_tag;	/* Notification Descriptor Tag */
>   	__be32		desc_len;	/* Length of Descriptor (in bytes).
>   					 * Size of descriptor excluding
> @@ -267,36 +267,6 @@ struct fc_tlv_desc {
>   	__u8		desc_value[];  /* Descriptor Value */
>   };
>   
> -/* Descriptor tag and len fields are considered the mandatory header
> - * for a descriptor
> - */
> -#define FC_TLV_DESC_HDR_SZ	sizeof(struct fc_tlv_desc)
> -
> -/*
> - * Macro, used when initializing payloads, to return the descriptor length.
> - * Length is size of descriptor minus the tag and len fields.
> - */
> -#define FC_TLV_DESC_LENGTH_FROM_SZ(desc)	\
> -		(sizeof(desc) - FC_TLV_DESC_HDR_SZ)
> -
> -/* Macro, used on received payloads, to return the descriptor length */
> -#define FC_TLV_DESC_SZ_FROM_LENGTH(tlv)		\
> -		(__be32_to_cpu((tlv)->desc_len) + FC_TLV_DESC_HDR_SZ)
> -
> -/*
> - * This helper is used to walk descriptors in a descriptor list.
> - * Given the address of the current descriptor, which minimally contains a
> - * tag and len field, calculate the address of the next descriptor based
> - * on the len field.
> - */
> -static inline void *fc_tlv_next_desc(void *desc)
> -{
> -	struct fc_tlv_desc *tlv = desc;
> -
> -	return (desc + FC_TLV_DESC_SZ_FROM_LENGTH(tlv));
> -}
> -
> -
>   /*
>    * Link Service Request Information Descriptor
>    */
> @@ -1094,19 +1064,6 @@ struct fc_fn_congn_desc {
>   	__u8		resv[3];	/* reserved - must be zero */
>   };
>   
> -/*
> - * ELS_FPIN - Fabric Performance Impact Notification
> - */
> -struct fc_els_fpin {
> -	__u8		fpin_cmd;	/* command (0x16) */
> -	__u8		fpin_zero[3];	/* specified as zero - part of cmd */
> -	__be32		desc_len;	/* Length of Descriptor List (in bytes).
> -					 * Size of ELS excluding fpin_cmd,
> -					 * fpin_zero and desc_len fields.
> -					 */
> -	struct fc_tlv_desc	fpin_desc[];	/* Descriptor list */
> -};
> -
>   /* Diagnostic Function Descriptor - FPIN Registration */
>   struct fc_df_desc_fpin_reg {
>   	__be32		desc_tag;	/* FPIN Registration (0x00030001) */
> @@ -1125,33 +1082,6 @@ struct fc_df_desc_fpin_reg {
>   					 */
>   };
>   
> -/*
> - * ELS_RDF - Register Diagnostic Functions
> - */
> -struct fc_els_rdf {
> -	__u8		fpin_cmd;	/* command (0x19) */
> -	__u8		fpin_zero[3];	/* specified as zero - part of cmd */
> -	__be32		desc_len;	/* Length of Descriptor List (in bytes).
> -					 * Size of ELS excluding fpin_cmd,
> -					 * fpin_zero and desc_len fields.
> -					 */
> -	struct fc_tlv_desc	desc[];	/* Descriptor list */
> -};
> -
> -/*
> - * ELS RDF LS_ACC Response.
> - */
> -struct fc_els_rdf_resp {
> -	struct fc_els_ls_acc	acc_hdr;
> -	__be32			desc_list_len;	/* Length of response (in
> -						 * bytes). Excludes acc_hdr
> -						 * and desc_list_len fields.
> -						 */
> -	struct fc_els_lsri_desc	lsri;
> -	struct fc_tlv_desc	desc[];	/* Supported Descriptor list */
> -};
> -
> -
>   /*
>    * Diagnostic Capability Descriptors for EDC ELS
>    */
> @@ -1221,6 +1151,65 @@ struct fc_diag_cg_sig_desc {
>   	struct fc_diag_cg_sig_freq	rcv_signal_frequency;
>   };
>   
> +/*
> + * Generic Link Service TLV Descriptor format
> + *
> + * This structure, as it defines no payload, will also be referred to
> + * as the "tlv header" - which contains the tag and len fields.
> + */
> +union fc_tlv_desc {
> +	struct fc_tlv_desc_hdr hdr;
> +	struct fc_els_lsri_desc lsri;
> +	struct fc_fn_li_desc li;
> +	struct fc_fn_deli_desc deli;
> +	struct fc_fn_peer_congn_desc peer_congn;
> +	struct fc_fn_congn_desc congn;
> +	struct fc_df_desc_fpin_reg fpin_reg;
> +	struct fc_diag_lnkflt_desc lnkflt;
> +	struct fc_diag_cg_sig_desc cg_sig;
> +};
> +
> +/* Descriptor tag and len fields are considered the mandatory header
> + * for a descriptor
> + */
> +#define FC_TLV_DESC_HDR_SZ	sizeof(struct fc_tlv_desc_hdr)
> +
> +/*
> + * Macro, used when initializing payloads, to return the descriptor length.
> + * Length is size of descriptor minus the tag and len fields.
> + */
> +#define FC_TLV_DESC_LENGTH_FROM_SZ(desc)	\
> +		(sizeof(desc) - FC_TLV_DESC_HDR_SZ)
> +
> +/* Macro, used on received payloads, to return the descriptor length */
> +#define FC_TLV_DESC_SZ_FROM_LENGTH(tlv)		\
> +		(__be32_to_cpu((tlv)->hdr.desc_len) + FC_TLV_DESC_HDR_SZ)
> +
> +/*
> + * This helper is used to walk descriptors in a descriptor list.
> + * Given the address of the current descriptor, which minimally contains a
> + * tag and len field, calculate the address of the next descriptor based
> + * on the len field.
> + */
> +static inline union fc_tlv_desc *fc_tlv_next_desc(union fc_tlv_desc *desc)
> +{
> +	return (union fc_tlv_desc *)((__u8 *)desc + FC_TLV_DESC_SZ_FROM_LENGTH(desc));
> +}
> +
> +
> +/*
> + * ELS_FPIN - Fabric Performance Impact Notification
> + */
> +struct fc_els_fpin {
> +	__u8		fpin_cmd;	/* command (0x16) */
> +	__u8		fpin_zero[3];	/* specified as zero - part of cmd */
> +	__be32		desc_len;	/* Length of Descriptor List (in bytes).
> +					 * Size of ELS excluding fpin_cmd,
> +					 * fpin_zero and desc_len fields.
> +					 */
> +	union fc_tlv_desc	fpin_desc[];	/* Descriptor list */
> +};
> +
>   /*
>    * ELS_EDC - Exchange Diagnostic Capabilities
>    */
> @@ -1231,10 +1220,37 @@ struct fc_els_edc {
>   					 * Size of ELS excluding edc_cmd,
>   					 * edc_zero and desc_len fields.
>   					 */
> -	struct fc_tlv_desc	desc[];
> +	union fc_tlv_desc	desc[];
>   					/* Diagnostic Descriptor list */
>   };
>   
> +/*
> + * ELS_RDF - Register Diagnostic Functions
> + */
> +struct fc_els_rdf {
> +	__u8		fpin_cmd;	/* command (0x19) */
> +	__u8		fpin_zero[3];	/* specified as zero - part of cmd */
> +	__be32		desc_len;	/* Length of Descriptor List (in bytes).
> +					 * Size of ELS excluding fpin_cmd,
> +					 * fpin_zero and desc_len fields.
> +					 */
> +	union fc_tlv_desc	desc[];	/* Descriptor list */
> +};
> +
> +/*
> + * ELS RDF LS_ACC Response.
> + */
> +struct fc_els_rdf_resp {
> +	struct fc_els_ls_acc	acc_hdr;
> +	__be32			desc_list_len;	/* Length of response (in
> +						 * bytes). Excludes acc_hdr
> +						 * and desc_list_len fields.
> +						 */
> +	struct fc_els_lsri_desc	lsri;
> +	union fc_tlv_desc	desc[];	/* Supported Descriptor list */
> +};
> +
> +
>   /*
>    * ELS EDC LS_ACC Response.
>    */
> @@ -1245,9 +1261,8 @@ struct fc_els_edc_resp {
>   						 * and desc_list_len fields.
>   						 */
>   	struct fc_els_lsri_desc	lsri;
> -	struct fc_tlv_desc	desc[];
> +	union fc_tlv_desc	desc[];
>   				    /* Supported Diagnostic Descriptor list */
>   };
>   
> -
>   #endif /* _FC_ELS_H_ */


