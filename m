Return-Path: <linux-scsi+bounces-23805-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMcbNXv3BWpVdwIAu9opvQ
	(envelope-from <linux-scsi+bounces-23805-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 14 May 2026 18:25:31 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA44544A42
	for <lists+linux-scsi@lfdr.de>; Thu, 14 May 2026 18:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8193C3039884
	for <lists+linux-scsi@lfdr.de>; Thu, 14 May 2026 16:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F8E32142B;
	Thu, 14 May 2026 16:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="vFHloJp5"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C973375D5
	for <linux-scsi@vger.kernel.org>; Thu, 14 May 2026 16:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778775623; cv=none; b=WJXv87A+QmCHCzAEQPMQ5HQrMpaA0rb1AkrRxl6Kh8GFWPK6kjRKY5KUSSUel8tl93WHt1MiHp7ZaiswH+NfZWkCGXnfdr+rxmoOJ2TdGbt/W3Ptmuy+zsuZ1nTGQAYKS189inbi44Fl9RGrts+uJ16jUok5flQoSaEhnOVW/Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778775623; c=relaxed/simple;
	bh=yDNGfqtK2za6RKRqCFOlNNlb8hjQwdUg4Syhq7Dtips=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p0uxTdH7GhODvelUmju7NjLIp4xzEwPom31vbvdxaimRjBOoj7+lGSTupyakhzMO6wp6b06ikZw8gU0ocWkqW1R5fBBXVUzjUd44GLHrKXMUXyIWdjfguuW6l1fd+W/QUS1ZLA2EnK0O/eUieBFZo9LeNldlAEXL2wmtYWfHJyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=vFHloJp5; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gGbCS4qPxzlfddr;
	Thu, 14 May 2026 16:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1778775616; x=1781367617; bh=yDNGfqtK2za6RKRqCFOlNNlb
	8hjQwdUg4Syhq7Dtips=; b=vFHloJp5TqaOiYCV07i/N1l6vtidxs4hIQJPaKFy
	XvBbeaG8XcfeMdslBK6EcoR+3Dj7DVtoJYjuLlv5iVt6g6yUAwjsku4TLkDv1jSY
	iN3IHuK6NY2XPU+IYn0ufZnfVL96uD1pUKtxN4pUumP/c0VAmAJxXbYiBEJZBKSw
	XRqM7V9BOAHaA0nn9BmPt8jraEaDm0/cLBLL4vMf9f7AnRXKfFBd+r4VKb1JgFz8
	/yL6zY+Og3i12NZIN6W2go8wk9hc31ry9glyp2biPSJKFuyGgfsyd+JmdP2Cysuk
	aiK9Q+aziRkYU287hYkC1k9hs5WVCXww/pC830VlRw9RDw==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 8evFEKxvBj8R; Thu, 14 May 2026 16:20:16 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gGbCL0Dthzlfvq7;
	Thu, 14 May 2026 16:20:13 +0000 (UTC)
Message-ID: <d7547792-62a7-409f-9906-c5f3854a0866@acm.org>
Date: Thu, 14 May 2026 09:20:12 -0700
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
 "chenyuan0y@gmail.com" <chenyuan0y@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "ping.gao@samsung.com" <ping.gao@samsung.com>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "James.Bottomley@HansenPartnership.com"
 <James.Bottomley@HansenPartnership.com>
References: <20260402171404.3008494-1-bvanassche@acm.org>
 <20260402171404.3008494-2-bvanassche@acm.org>
 <459ba5ca0f24ce49fd7de7ae6e014588f40e2445.camel@mediatek.com>
 <d81c6987-6f76-4391-a713-96bbde4efc8d@acm.org>
 <23d57dd91882a3014c0d97a7b08b81117ade5b72.camel@mediatek.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <23d57dd91882a3014c0d97a7b08b81117ade5b72.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 3CA44544A42
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,oracle.com,vger.kernel.org,gmail.com,collabora.com,samsung.com,HansenPartnership.com];
	TAGGED_FROM(0.00)[bounces-23805-lists,linux-scsi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
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

On 5/14/26 12:34 AM, Peter Wang (=E7=8E=8B=E4=BF=A1=E5=8F=8B) wrote:
> However, the UFS ISR still cannot acquire
> the spinlock and executes an unknown task that disables IRQs,
> the duration of which is controlled by F2FS.

I see this as an F2FS bug. It is widely known that bi_end_io callbacks
may be called from interrupt context and hence should finish quickly.

Thanks,

Bart.

