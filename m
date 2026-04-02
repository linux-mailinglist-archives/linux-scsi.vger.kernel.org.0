Return-Path: <linux-scsi+bounces-22720-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPI0JeKRzmkbogYAu9opvQ
	(envelope-from <linux-scsi+bounces-22720-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 02 Apr 2026 17:57:22 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A264C38B8CE
	for <lists+linux-scsi@lfdr.de>; Thu, 02 Apr 2026 17:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9A05330055CF
	for <lists+linux-scsi@lfdr.de>; Thu,  2 Apr 2026 15:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B633D3D09;
	Thu,  2 Apr 2026 15:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="nzhfG5OO"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBEA336897;
	Thu,  2 Apr 2026 15:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775145294; cv=none; b=k0GU1wg8fMGcQEDSEI+Em/UUMYICgMEAYQ1U1Vxa4PIPv+2sVBxNtL30NI133YcTTeziv4soW/+PyvSfG7jsku/sNPFiu1zIe+V0X6mKFNFLwZjGoYBWCFlxPTV8Pi24u+u/mOG6EarqC5hrvr3q6BBWM1qxpHcM52iqIpqbp5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775145294; c=relaxed/simple;
	bh=kh8+U9wib/r/kSZpMPatsqZZU9dR45diAh+/NPWagKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C9Re0SRibu84+KK4kjPW+PhXqMGf8Yg7WoYJHUFXuBQmY+mx82gAfI/QjJOJL9MHUHK4njjcJzQ1wbOD8pNbLcuyNjvzv/YGdMTx3TbOVtJ15FLi6GW0KeLsiKFy4g+SppDbh4fQUHT2CKTlp5fYRDFMemIe6wOid7AUF+ofxTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=nzhfG5OO; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fmmdS30w3z1XM6JJ;
	Thu,  2 Apr 2026 15:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1775145288; x=1777737289; bh=k9M+oVcP3Fs/A3qoYFfeTASR
	7MSRMG1Txy+seJJENJk=; b=nzhfG5OOHiLxr8S6hh3tGVy4v4mDtv2KPvPo08sU
	STO8ia3TP5L9oJoBfAF6Bjo3RByxzf+/MRm6tA+sTcEWS6gRS7fc12zk/7BID1lN
	ACpq8rJI71cAj7b6U2jtkifwP+I72KpkgMWWjc1DySta76HNChLxoIj0Lt8Sw7JS
	BG3CfXpPrzj/dHFIEjfKiXi8Cwqux+oPYCFWJ/2SleIk/VILBLTO4Td4JZ/l7QHe
	uU2elkL2SE3bxI12Fb1tJvdDknlBfF1Z3gl0MoJ9LGw91q/9sCQiCyit01iTqtel
	e/MBNS4wMTo8/KVNQ2VAMVcfbBfZs8KikFLw5vbWg6YZAw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 5swGIE0tdVpI; Thu,  2 Apr 2026 15:54:48 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fmmdK734bz1XMFwb;
	Thu,  2 Apr 2026 15:54:45 +0000 (UTC)
Message-ID: <1d0d35fe-5e9d-44b7-9dcd-48289f9d9f53@acm.org>
Date: Thu, 2 Apr 2026 08:54:44 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] block: align nr_active_requests_shared_tags to avoid
 cache line contention
To: Sumit Saxena <sumit.saxena@broadcom.com>, martin.petersen@oracle.com,
 axboe@kernel.dk
Cc: linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
 mpi3mr-linuxdrv.pdl@broadcom.com, James Rizzo <james.rizzo@broadcom.com>
References: <20260402074637.92417-1-sumit.saxena@broadcom.com>
 <20260402074637.92417-3-sumit.saxena@broadcom.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260402074637.92417-3-sumit.saxena@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[acm.org:+];
	TAGGED_FROM(0.00)[bounces-22720-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.985];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,acm.org:dkim,acm.org:mid]
X-Rspamd-Queue-Id: A264C38B8CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/2/26 12:46 AM, Sumit Saxena wrote:
> From: James Rizzo <james.rizzo@broadcom.com>
> 
> Place nr_active_requests_shared_tags on its own cache line so it does not
> share a cache line with nr_requests and other hot fields, avoiding
> significant performance hits from false sharing on some CPU architectures.
> 
> Signed-off-by: James Rizzo <james.rizzo@broadcom.com>
> Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
> ---
>   include/linux/blkdev.h | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index d463b9b5a0a5..7ed566c81c1b 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -561,7 +561,9 @@ struct request_queue {
>   	struct timer_list	timeout;
>   	struct work_struct	timeout_work;
>   
> -	atomic_t		nr_active_requests_shared_tags;
> +	/* ensure nr_active_requests_shared_tags and nr_requests are on different cache lines
> +	   to avoid significant performance hits on cache line contention on some CPU architectures */
> +	atomic_t		nr_active_requests_shared_tags ____cacheline_aligned_in_smp;
>   
>   	struct blk_mq_tags	*sched_shared_tags;
>   

A possible alternative is this patch that removes
nr_active_requests_shared_tags:

https://lore.kernel.org/linux-block/20240529213921.3166462-1-bvanassche@acm.org/

Thanks,

Bart.

