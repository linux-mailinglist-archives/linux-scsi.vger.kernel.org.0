Return-Path: <linux-scsi+bounces-24148-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDhEOCQbF2ov4gcAu9opvQ
	(envelope-from <linux-scsi+bounces-24148-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 27 May 2026 18:26:12 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F625E7BDA
	for <lists+linux-scsi@lfdr.de>; Wed, 27 May 2026 18:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D7D6C302E5EF
	for <lists+linux-scsi@lfdr.de>; Wed, 27 May 2026 16:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BBD42EEA4;
	Wed, 27 May 2026 16:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="2IwDKY4u"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47BD42EED5;
	Wed, 27 May 2026 16:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779898482; cv=none; b=Xd8o11/UHL1kuRWoivTGrDnjqm6U4Iec7duyA3uNAei0K/EqwshsJzgZmFMdYeqROvNAbEMfSqz+k6RrSRWhO5R2oofcESjt0z/pyqYdJRZRR56B7UfeZCik5uqrlLhCve/TS32TlU62tI3RKDVPQ+w0SrIgDTIfOsrsjbaEuvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779898482; c=relaxed/simple;
	bh=4/VaCb0G9ASGG14S4t8hkrmVUZfCXfSeTRx2lkZ0Xk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NXCkUjMYEdv6qsQ2KeK1KP0SYa/rYUbqRXabKgCjymNXaVy9m9DAPrEFaY/Y88Iqvajpq0iHUU0bqnIEkQyIV9W2M9v7uNQBN7harms+s41lSlM2+qtSS2EX2uIJhKXwGktWE030sjqeMOSq+4JQEsM+lCFjRdRU31Zvmg36Iz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=2IwDKY4u; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gQZSs5cMPz1XM6J7;
	Wed, 27 May 2026 16:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1779898469; x=1782490470; bh=svTP7kkm814futHVp7/3I/4t
	93E+z9bYb+2FvFyOZqQ=; b=2IwDKY4u5X82SfjWhK3zbViCg/6q1G14faDH8cEJ
	2W9OegoZAFtuGF9cxZ0QLLWgTv3hIKsVsvty/pXaZSCqBRwmAzt4Iegurr3Ns1CH
	jy0zJ6lSBNKwYFU/kNEEDVk/uoZQIO6USpUdpoxtyvZkLWC4wWjfhgZ9llooAWQq
	oYpdYFuNAtFa5rMx1AsYfklFZUiY/kIh9riG5+WFBoj7hP8hcMnBZqhmVe7DD17u
	liqqiZu6sDM1qm/LYTKO4BWS5MDXioBJg3XFGtchj2bFbX01nWuGJXwVNzRyDJ7c
	11rSn3lHn6+7uxy+TlYta8xy1m9Lghfk3jRs1X8vEdanmg==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Pb4gHz8B1rMV; Wed, 27 May 2026 16:14:29 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gQZSc6QvJz1XM5kt;
	Wed, 27 May 2026 16:14:24 +0000 (UTC)
Message-ID: <b4ae913e-2356-4b10-be3a-817e380034af@acm.org>
Date: Wed, 27 May 2026 09:14:23 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: ufs: core: Fix NULL pointer dereference in
 scsi_cmd_priv() calls
To: Chanwoo Lee <cw9316.lee@samsung.com>, ulf.hansson@linaro.org,
 alim.akhtar@samsung.com, avri.altman@wdc.com,
 James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
 peter.wang@mediatek.com, vamshigajjela@google.com,
 alok.a.tiwari@oracle.comm, beanhuo@micron.com, can.guo@oss.qualcomm.com,
 adrian.hunter@intel.com, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <CGME20260527072231epcas1p308649370c22bbf30eb2381abf6058db6@epcas1p3.samsung.com>
 <20260527072228.271542-1-cw9316.lee@samsung.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260527072228.271542-1-cw9316.lee@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-24148-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-scsi];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,acm.org:mid,acm.org:dkim]
X-Rspamd-Queue-Id: E7F625E7BDA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/27/26 12:22 AM, Chanwoo Lee wrote:
> diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
> index c1b1d67a1ddc..798b2a910128 100644
> --- a/drivers/ufs/core/ufs-mcq.c
> +++ b/drivers/ufs/core/ufs-mcq.c
> @@ -555,8 +555,8 @@ static int ufshcd_mcq_sq_start(struct ufs_hba *hba, struct ufs_hw_queue *hwq)
>   int ufshcd_mcq_sq_cleanup(struct ufs_hba *hba, int task_tag)
>   {
>   	struct scsi_cmnd *cmd = ufshcd_tag_to_cmd(hba, task_tag);
> -	struct ufshcd_lrb *lrbp = scsi_cmd_priv(cmd);
> -	struct request *rq = scsi_cmd_to_rq(cmd);
> +	struct ufshcd_lrb *lrbp;
> +	struct request *rq;
>   	struct ufs_hw_queue *hwq;
>   	void __iomem *reg, *opr_sqd_base;
>   	u32 nexus, id, val;
> @@ -568,6 +568,9 @@ int ufshcd_mcq_sq_cleanup(struct ufs_hba *hba, int task_tag)
>   	if (!cmd)
>   		return -EINVAL;
>   
> +	lrbp = scsi_cmd_priv(cmd);
> +	rq = scsi_cmd_to_rq(cmd);
> +

These changes are not necessary. Although scsi_cmd_priv() and
scsi_cmd_to_rq() both return an invalid pointer if their argument is
NULL, these pointers are not dereferenced before the cmd != NULL check.

> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 9e0336098e26..0371dea44887 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -5833,13 +5833,15 @@ void ufshcd_compl_one_cqe(struct ufs_hba *hba, int task_tag,
>   			  struct cq_entry *cqe)
>   {
>   	struct scsi_cmnd *cmd = ufshcd_tag_to_cmd(hba, task_tag);
> -	struct ufshcd_lrb *lrbp = scsi_cmd_priv(cmd);
> +	struct ufshcd_lrb *lrbp;
>   	enum utp_ocs ocs;
>   
>   	if (WARN_ONCE(!cmd, "cqe->command_desc_base_addr = %#llx\n",
>   		      le64_to_cpu(cqe->command_desc_base_addr)))
>   		return;
>   
> +	lrbp = scsi_cmd_priv(cmd);
> +
>   	if (hba->monitor.enabled) {
>   		lrbp->compl_time_stamp = ktime_get();
>   		lrbp->compl_time_stamp_local_clock = local_clock();

These changes are not necessary either because lrbp is not dereferenced
before the cmd != NULL check.

Thanks,

Bart.

