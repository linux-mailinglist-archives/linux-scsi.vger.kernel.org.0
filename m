Return-Path: <linux-scsi+bounces-23791-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCnfLk7TBGr0PQIAu9opvQ
	(envelope-from <linux-scsi+bounces-23791-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 13 May 2026 21:38:54 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F58853A1B3
	for <lists+linux-scsi@lfdr.de>; Wed, 13 May 2026 21:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86D58310893F
	for <lists+linux-scsi@lfdr.de>; Wed, 13 May 2026 19:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0491E3B3BF0;
	Wed, 13 May 2026 19:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="DwYfBXLk"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702F13AFB19
	for <linux-scsi@vger.kernel.org>; Wed, 13 May 2026 19:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778700390; cv=none; b=QVS59eKC+Rc4U6CbEoDDwMqXehVK9YZtaBPAiKHo37/j+ahylOb5G5TG3FHoXmHoYsmYgCOLDJl2MLajzAqaGMBcgCCs85GKDGtUoOx5PBRVGZsuKJWJAcp/JlGAN6RBZAXecf3cGDW54LXXxFinm3EJqJmMe07itG2iEuP8ABM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778700390; c=relaxed/simple;
	bh=+Vf4tBheg5Dj9udBZOD5dz516hHdl/MIrYvPSbtraiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FENEqbg4zm/A2u9+mi+2M9f1VZSZXGeno4tp4LZI3ReXC283L+95mSC/icGAWwG5IJeEUR91iQ6bkcAZsaxtzx3TjbM+CkR1iu0UZz1/DJhtn1qdhw4GuaXIZY7P1iAQ/M81M7bnLRTcy3cgXthn6OLNjUTpJ0nD4yoQe1czWAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=DwYfBXLk; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gG3Nh6Z81z1XM0nq;
	Wed, 13 May 2026 19:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1778700383; x=1781292384; bh=+Vf4tBheg5Dj9udBZOD5dz51
	6hHdl/MIrYvPSbtraiw=; b=DwYfBXLkifT0Vd4PFB8APp+umsn8ZUnH55dOs2nD
	1Cus7VI79VRmgfXGDkSZlu1YQpiKZQMYh43KFRkSqRyCFWcUwWJCvJh5F2VSAvnK
	NNUxTAS1IwP3pMYUk2ssEqp2hqDA9ZUGJccXfjXD22PM+hjK9ggSZvLVuuiESKz8
	G3ZHUwe55ETwUK0aPBc9LaGgRchSzM7+f/xAr+hgR46VbuRmc9tJgu35+b33M+kH
	zu/ZW3wM5mZlpEKB7oXWaVJZnSUo5YXvbaDHBUW9Bp6fekNGrYjyl1c7lzmUeZsz
	heE3NRCP9Bq0+ly+f5s80EsLlV/zci/AlA0BlALSbi/xxA==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id wRoLGvXb5Jlw; Wed, 13 May 2026 19:26:23 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gG3NY4P4lz1XM6JP;
	Wed, 13 May 2026 19:26:21 +0000 (UTC)
Message-ID: <d81c6987-6f76-4391-a713-96bbde4efc8d@acm.org>
Date: Wed, 13 May 2026 12:26:20 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] ufs: core: Introduce ufshcd_mcq_poll_n_cqe_lock()
To: =?UTF-8?B?UGV0ZXIgV2FuZyAo546L5L+h5Y+LKQ==?= <peter.wang@mediatek.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Cc: "vamshigajjela@google.com" <vamshigajjela@google.com>,
 "alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "chenyuan0y@gmail.com" <chenyuan0y@gmail.com>,
 "ping.gao@samsung.com" <ping.gao@samsung.com>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "James.Bottomley@HansenPartnership.com"
 <James.Bottomley@HansenPartnership.com>
References: <20260402171404.3008494-1-bvanassche@acm.org>
 <20260402171404.3008494-2-bvanassche@acm.org>
 <459ba5ca0f24ce49fd7de7ae6e014588f40e2445.camel@mediatek.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <459ba5ca0f24ce49fd7de7ae6e014588f40e2445.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 3F58853A1B3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[google.com,oracle.com,vger.kernel.org,collabora.com,gmail.com,samsung.com,HansenPartnership.com];
	TAGGED_FROM(0.00)[bounces-23791-lists,linux-scsi=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[acm.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/12/26 11:50 PM, Peter Wang (=E7=8E=8B=E4=BF=A1=E5=8F=8B) wrote:
> May I ask if you have any plans to continue upstreaming this patch
> in the future?

Hi Peter,

After I posted this patch series I learned that even processing a single
completion can cause interrupts to be disabled for too long. I think the
root cause is in F2FS (f2fs_write_end_io()). I have reported this to the
F2FS team and I'm waiting for their feedback. After F2FS has been
improved I will repeat my measurements and reduce the number of
completions processed in interrupt context if that is still necessary.

Thanks,

Bart.

