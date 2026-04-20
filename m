Return-Path: <linux-scsi+bounces-23115-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPMuDr5e5mm3vQEAu9opvQ
	(envelope-from <linux-scsi+bounces-23115-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 20 Apr 2026 19:13:34 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BE0430C29
	for <lists+linux-scsi@lfdr.de>; Mon, 20 Apr 2026 19:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC7223106494
	for <lists+linux-scsi@lfdr.de>; Mon, 20 Apr 2026 16:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0B237646A;
	Mon, 20 Apr 2026 16:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="TRsRi8HK"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE091374E62
	for <linux-scsi@vger.kernel.org>; Mon, 20 Apr 2026 16:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776703565; cv=none; b=BuDAdCMQmXFbopO/KGObc3tY5h0xxyz8Arp3U8iq4aM6AvkNXqv5gBsvLN+gCOIMGCPkdGmpKVSPg4fmZ8Xgdm/zXsD0u6jSYzmWKBsn3wPEQhoJ3qP7SDrjWLt7e0z7+CKYk1UWgozTx68pvu+/CaCu77olsqE+LenIb4+Sj9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776703565; c=relaxed/simple;
	bh=a1XvIzRqF9Um1gWWHn1rOVng4I/mmpgPQ4X6IBbrF4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PsdE5XdriuoOYiElgrk1335Ej1/ZRAKh6p80GP4/lyZYZcF0ZvGpTEWlFpiUVrNGBmq3/lqEUuT2/hH4GKh6qwapMmRRjLgviAlMyTWMToD16FGatUOyGmEkCPY1Jez5gjL67o9+idztchn/NSnXYYJcMOuRuoFUwVBLcly5DtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=TRsRi8HK; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fzrwB327lzlfdGT;
	Mon, 20 Apr 2026 16:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1776703557; x=1779295558; bh=pTx7u0MM1e2vMoE0exJ4KVsC
	SAcmcTRz2iIaFUsZGj0=; b=TRsRi8HKCStclphfeuEYPBDwNVVsFsUiWr3dTDQG
	jfjufXFyTxs6iOpr/8bvZ7a8r/o0+1FqaYBqceyU82aixqpEivXS/XL9OELCUoSB
	Vref3COi5dYOjhY54f0jYjwiSADmoJrSoKYolAbD4BR5TYlr27tKwlUZrjxvo+0w
	4f3Ryf+A5Mca0ImfJQxb+CcNyufYDoxfTnanpCH7R41u1nmuamcdGKkHwk/grKvA
	1LFjt8LX3AKXZw2tPQONl00xwBCh454D8xj6RF+uvj6WUnZNIbzAnRejdHGTQVqW
	ekS9dT8R2FuJfd1aRBzOqEiVOTWIfRtXLed0JOQum79RWg==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id uIbwegIsavq0; Mon, 20 Apr 2026 16:45:57 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fzrw311PZzlfddf;
	Mon, 20 Apr 2026 16:45:54 +0000 (UTC)
Message-ID: <197fd58e-2cc7-4ed8-a662-52120f39c5e2@acm.org>
Date: Mon, 20 Apr 2026 09:45:54 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] scsi: qedi: Fix command overqueueing
To: Mike Christie <michael.christie@oracle.com>, martin.petersen@oracle.com,
 linux-scsi@vger.kernel.org, james.bottomley@hansenpartnership.com,
 virtualization@lists.linux.dev, mst@redhat.com, pbonzini@redhat.com,
 stefanha@redhat.com, eperezma@redhat.com
References: <20260417230751.117836-1-michael.christie@oracle.com>
 <20260417230751.117836-3-michael.christie@oracle.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260417230751.117836-3-michael.christie@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[acm.org:+];
	TAGGED_FROM(0.00)[bounces-23115-lists,linux-scsi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,acm.org:dkim,acm.org:mid,oracle.com:email]
X-Rspamd-Queue-Id: D2BE0430C29
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/17/26 3:57 PM, Mike Christie wrote:
> qedi supports a total of can_queue commands over all queues so set
> host_tagset when multiple queues are used.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>   drivers/scsi/qedi/qedi_main.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.c
> index 227ff7bd1bdc..0be0a9f30ee2 100644
> --- a/drivers/scsi/qedi/qedi_main.c
> +++ b/drivers/scsi/qedi/qedi_main.c
> @@ -657,6 +657,8 @@ static struct qedi_ctx *qedi_host_alloc(struct pci_dev *pdev)
>   	qedi->max_sqes = QEDI_SQ_SIZE;
>   
>   	shost->nr_hw_queues = MIN_NUM_CPUS_MSIX(qedi);
> +	if (shost->nr_hw_queues > 1)
> +		shost->host_tagset = 1;
>   
>   	pci_set_drvdata(pdev, qedi);
>   

Why "if (shost->nr_hw_queues > 1)"? It is safe to set host_tagset even
if shost->nr_hw_queues == 1. See e.g. "[PATCH] ufs: core: Use a host-
wide tagset in SDB mode" 
(https://lore.kernel.org/linux-scsi/20260116180800.3085233-1-bvanassche@acm.org/).

Thanks,

Bart.

