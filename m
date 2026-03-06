Return-Path: <linux-scsi+bounces-21584-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wF3JHTsCq2msZQEAu9opvQ
	(envelope-from <linux-scsi+bounces-21584-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 06 Mar 2026 17:35:07 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0169C2250D3
	for <lists+linux-scsi@lfdr.de>; Fri, 06 Mar 2026 17:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8ECDE3039DC8
	for <lists+linux-scsi@lfdr.de>; Fri,  6 Mar 2026 16:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B7636CDFE;
	Fri,  6 Mar 2026 16:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="eVHUZDn7"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E9E3EB7FE
	for <linux-scsi@vger.kernel.org>; Fri,  6 Mar 2026 16:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772814891; cv=none; b=dKoJImjfuxhFRHiBs/glkmfLgc2IfFCRVDCe6oURphcHAjBD1ZLfasPokHqcQL7PApNFyZGUsIINF0SzTOj8xwKifpudZB5O5RqBaYDiWkhLDMXCCyxBDiqnLQ7bdMpUT8YtcwApsHM4svHwuEf31wOHSJQcgxOZWWd4GRt8pWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772814891; c=relaxed/simple;
	bh=BTnHghhzC/4435ME5gJ6kCp/nCWvq1j07LPB7IjNf0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F0d7h7ssHEW3ygtb8z2CZ2VZyA0JfJr/jCXiny4dstjz5TVpxhwOhS3fXk1gKXf89DZm9b4QA1I0pdUbsZYYIRYbjU1B1UJjfzOH1XaGnBk6IeKANzzAsxWzGWwQRau2QQJJFQlq/lVIGWHnrrSDMaAhMJj23OKF6sAeTN7zOMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=eVHUZDn7; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fSBnv1zDbz1XMFjb;
	Fri,  6 Mar 2026 16:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1772814875; x=1775406876; bh=eUMcn21fRpVvqrGOqfVjdpLc
	64MmlG9YmMC8WmKCo+Y=; b=eVHUZDn7dDf6ss9LzktVwxMu+tMRj0UG7vAENGxq
	U3RSfYM7mcFpqdh9g1tO7EqK6CNTwzsj5H+Oa9CaBtUjV0xktg1v8QdYRzYg+OIZ
	FpIeEfoKCX867X0T3EfpgL9EuGWXiDV1w+4Ye1VIRnHQ9gAnFLTz4aBSQ62vf8CC
	vq9ki44dAtUWy+p01XlLZGN9NGhC0NDCxd8aqvCvM7jPuNCoTPB3u5EwAPw5MwPS
	XC82JA+XzvhhnMEyFSbrcUpwszflJ7e1P6SmItkFTOXupB41SPU2dMXocQ9Il0kB
	bLq1pLeRj+I9cnqhHvRWEupDlPqfSrKVVp91G2E+34DSYg==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id uFYceNCoOJXC; Fri,  6 Mar 2026 16:34:35 +0000 (UTC)
Received: from [10.96.36.50] (unknown [12.131.83.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fSBnd6ylmz1XM0p2;
	Fri,  6 Mar 2026 16:34:29 +0000 (UTC)
Message-ID: <048e761a-0fed-43f7-a194-f804b9b08918@acm.org>
Date: Fri, 6 Mar 2026 10:34:28 -0600
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ufs: core: Avoid IRQ thread wakeup during active UIC
 command
To: peter.wang@mediatek.com, linux-scsi@vger.kernel.org,
 martin.petersen@oracle.com, avri.altman@sandisk.com,
 alim.akhtar@samsung.com, jejb@linux.ibm.com
Cc: wsd_upstream@mediatek.com, linux-mediatek@lists.infradead.org,
 chun-hung.wu@mediatek.com, alice.chao@mediatek.com, cc.chou@mediatek.com,
 chaotian.jing@mediatek.com, tun-yu.yu@mediatek.com,
 eddie.huang@mediatek.com, naomi.chu@mediatek.com, ed.tsai@mediatek.com
References: <20260306054419.3816557-1-peter.wang@mediatek.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260306054419.3816557-1-peter.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0169C2250D3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[acm.org:+];
	TAGGED_FROM(0.00)[bounces-21584-lists,linux-scsi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,acm.org:dkim,acm.org:email,acm.org:mid]
X-Rspamd-Action: no action

On 3/5/26 11:43 PM, peter.wang@mediatek.com wrote:
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 9908375b2f98..6554e1db3343 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -7200,8 +7200,12 @@ static irqreturn_t ufshcd_intr(int irq, void *__hba)
>   	struct ufs_hba *hba = __hba;
>   	u32 intr_status, enabled_intr_status;
>   
> -	/* Move interrupt handling to thread when MCQ & ESI are not enabled */
> -	if (!hba->mcq_enabled || !hba->mcq_esi_enabled)
> +	/*
> +	 * Handle interrupt in thread if MCQ or ESI is disabled,
> +	 * and no active UIC command.
> +	 */
> +	if ((!hba->mcq_enabled || !hba->mcq_esi_enabled) &&
> +	    !hba->active_uic_cmd)
>   		return IRQ_WAKE_THREAD;
>   
>   	intr_status = ufshcd_readl(hba, REG_INTERRUPT_STATUS);

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

